{% set beta = salt['grains.fetch']('fs-beta', default=False) %}

feverscreen-pkgrepo:
  pkgrepo.managed:
    - humanname: feverscreen
    {% if beta %}
    - name: deb [trusted=yes] https://github.com/feverscreen/channel-beta/releases/download/feverscreen ./
    - key_url: https://github.com/feverscreen/channel-beta/releases/download/feverscreen/default.pub.key
    {% else %}
    - name: deb [trusted=yes] https://github.com/feverscreen/channel-stable/releases/download/feverscreen ./
    - key_url: https://github.com/feverscreen/channel-stable/releases/download/feverscreen/default.pub.key
    {% endif %}
    - file: /etc/apt/sources.list.d/feverscreen.list
    - clean_file: True
    - refresh: True

feverscreen-packages:
  pkg.installed:
    - pkgs:
      - feverscreen
    - watch:
      - feverscreen-pkgrepo

feverscreen-service:
  service.running:
    - name: feverscreen
    - enable: True
    - watch:
      - feverscreen-packages

leptond-service:
  service.running:
    - name: leptond
    - enable: True
    - watch:
      - feverscreen-packages

/etc/cron.d/update-feverscren:
  file.managed:
    {% if beta %}
    - source: salt://pi/feverscreen/update-feverscreen-beta
    {% else %}
    -  source: salt://pi/feverscreen/update-feverscreen
    {% endif %}
    - mode: 644