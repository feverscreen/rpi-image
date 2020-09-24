def pkg_installed_from_github(name, version, pkg_name=None, systemd_reload=True, cacophony_project=False):
    """Install a deb package from a Cacophony Project Github release if it
    isn't installed on the system already. Currently only ARM packages are
    installed.

    pkg_name
        Name of the deb package if it is different to the github repository name.

    If a new version is installed, systemd will be asked to reload it's
    configuration so that any new service files in the package are known to
    systemd.
    """

    # Guard against versions being converted to floats in YAML parsing.
    assert isinstance(version, basestring), "version must be a string"

    if pkg_name == None:
        pkg_name = name

    project = 'feverscreen'
    if cacophony_project:
        project = 'TheCacophonyProject'

    installed_version = __salt__['pkg.version'](pkg_name)
    if installed_version == version:
        return {
            'name': pkg_name,
            'result': True,
            'comment': 'Version %s already installed.' % version,
            'changes': {}
        }

    source_url = 'https://github.com/{project}/{name}/releases/download/v{version}/{pkg_name}_{version}_arm.deb'.format(
        project=project,
        name=name,
        pkg_name=pkg_name,
        version=version,
    )
    ret = __states__['pkg.installed'](
        name=name,
        version=version,
        sources=[{pkg_name: source_url}],
        refresh=False,
    )

    if systemd_reload and ret['result'] and ret['changes'] and not __opts__['test']:
        __salt__['cmd.run']('systemctl daemon-reload')
        ret['comment'] += ' (systemd reloaded)'

    return ret

