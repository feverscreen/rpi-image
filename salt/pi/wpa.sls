set_wifi_country:
  file.replace:
    - name: /etc/wpa_supplicant/wpa_supplicant.conf
    - pattern: "^country=.+"
    - repl: "country=NZ"

ensure_bushnet_ssid:
  file.replace:
    - name: /etc/wpa_supplicant/wpa_supplicant.conf
    - pattern: 'network={\n*\s*ssid="bushnet"\n*\s*psk="feathers"\n*\s*}'
    - repl: |
        network={
            ssid="bushnet"
            psk="feathers"
            priority=2
        }
    - append_if_not_found: true
