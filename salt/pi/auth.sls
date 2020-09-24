set-pi-password:
  user.present:
    - name: pi
    - password: "$6$u.LDU80e$fFiSnuvLeAXpPpTYlY5EVy4N/HSRsaHg4nf0IYKZVutXjjyEXaIPlc0Zxj/O/RE2QqztmoKsd4IHVg2KM6OQD."

prevent-root-ssh-login:
  file.append:
    - name: /etc/ssh/sshd_config
    - text: "PermitRootLogin no" 

prevent-password-logins:
  file.line:
    - name: /etc/ssh/sshd_config
    - mode: replace
    - match: ".*PasswordAuthentication .*"
    - content: "PasswordAuthentication no"

install-cacophony-pi-ssh-key:
  ssh_auth.present:
    - user: pi
    - source: salt://pi/cacophony-pi.pub
    - config: '%h/.ssh/authorized_keys'


ssh-service:
  service.running:
    - name: ssh
    - enable: True
    - watch:
      - prevent-root-ssh-login
      - prevent-password-logins
