# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_install = tplroot ~ '.install' %}
{%- from tplroot ~ "/map.jinja" import promtail with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}
include:
  - {{ sls_install }}

promtail-config-file-managed:
  file.managed:
    - name: {{ promtail.config_file }}
    - source: {{ files_switch(['promtail.yaml.jinja'], lookup='promtail-config-file-managed') }}
    - mode: 644
    - user: root
    - group: {{ promtail.rootgroup }}
    - makedirs: True
    - template: jinja
    - watch_in:
      - service: promtail-service
    - require:
      - sls: {{ sls_install }}
    - context:
        promtail: {{ promtail | json }}