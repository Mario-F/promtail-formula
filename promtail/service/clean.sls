# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import promtail with context %}

promtail-service-clean-service-dead:
  service.dead:
    - name: {{ promtail.service.name }}
    - enable: False
