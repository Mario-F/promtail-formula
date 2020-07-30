# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import promtail with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}
{%- set promtail_directory = promtail.get('directory') %}

# Create service
promtail-service-unitfile-managed:
  file.managed:
    - name: /etc/systemd/system/promtail.service
    - source: {{ files_switch(['promtail.service.jinja'], lookup='promtail-service-unitfile-managed') }}
    - template: jinja
    - watch_in:
      - service: promtail-service
    - context:
        pathBin: {{ promtail.directory }}/promtail
        pathConfig: {{ promtail.config_file }}

promtail-install-systemd-reload:
  cmd.run:
    - name: systemctl --system daemon-reload
    - onchanges:
      - file: promtail-service-unitfile-managed
    - watch_in:
      - service: promtail-service

promtail-service:
  service.running:
    - name: promtail
    - enable: True