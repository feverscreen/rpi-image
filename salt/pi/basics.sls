/boot/config.txt:
   file.managed:
     - source: salt://pi/config.txt.jinja
     - template: jinja

/etc/modules:
   file.managed:
     - source: salt://pi/modules

/etc/rsyslog.conf:
   file.managed:
     - source: salt://pi/rsyslog.conf

/etc/logrotate.d/rsyslog:
  file.managed:
    - source: salt://pi/rsyslog

/boot/cmdline.txt:
   file.replace:
      - pattern: "^(.(?!.*spidev.bufsiz).*)"
      - repl: "\\1 spidev.bufsiz=65536"

i2c-tools:
  pkg.installed: []

create_cptv_dir:
  file.directory:
    - name: '/var/spool/cptv'

/etc/cacophony/config.toml:
  file.managed:
    - makedirs: True
    - contents: ""