# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service = tplroot ~ '.service' %}
{%- from tplroot ~ "/map.jinja" import promtail with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_service }}

# Prepare Installation
promtail-install-directory:
  file.directory:
    - name: {{ promtail.directory }}

promtail-install-directory-{{ promtail.version }}:
  file.directory:
    - name: {{ promtail.directory }}/{{ promtail.version }}


# Download and Extract
promtail-install-download-extract:
  archive.extracted:
    - name: {{ promtail.directory }}/{{ promtail.version }}/
    - source: https://github.com/grafana/loki/releases/download/{{ promtail.version }}/promtail-{{ promtail.ostype }}-{{ promtail.arch }}.zip
    - source_hash: https://github.com/grafana/loki/releases/download/{{ promtail.version }}/SHA256SUMS
    - source_hash_update: True
    - enforce_toplevel: False
    - watch_in:
      - service: promtail-service

promtail-install-download-symlink:
  file.symlink:
    - name: {{ promtail.directory }}/promtail
    - target: {{ promtail.directory }}/{{ promtail.version }}/promtail-{{ promtail.ostype }}-{{ promtail.arch }}
    - watch_in:
      - service: promtail-service
