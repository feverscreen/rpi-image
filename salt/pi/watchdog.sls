########################################################
# Configure systemd to ping the hardware watchdog
########################################################

/etc/systemd/system.conf:
  file.append:
    - text: 
      - "RuntimeWatchdogSec=15"

restart-systemd:
   module.wait:
     - name: cmd.run
     - cmd: "systemctl daemon-reexec"
     - watch:
       - file: /etc/systemd/system.conf

########################################################
# Remove watchdog daemon where it had been installed
########################################################
watchdog:
  pkg.purged: []
  service.dead:
    - enable: False

/etc/watchdog.d:
  file.absent
