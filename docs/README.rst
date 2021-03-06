.. _readme:

promtail-formula
================

|img_travis| |img_sr|

.. |img_travis| image:: https://travis-ci.org/Mario-F/promtail-formula.svg?branch=master
   :alt: Travis CI Build Status
   :scale: 100%
   :target: https://travis-ci.com/Mario-F/promtail-formula
.. |img_sr| image:: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
   :alt: Semantic Release
   :scale: 100%
   :target: https://github.com/semantic-release/semantic-release

Install, configure and manage Grafana Loki Promtail.

.. contents:: **Table of Contents**
   :depth: 1

General notes
-------------

See the full `SaltStack Formulas installation and usage instructions
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

If you are interested in writing or contributing to formulas, please pay attention to the `Writing Formula Section
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#writing-formulas>`_.

If you want to use this formula, please pay attention to the ``FORMULA`` file and/or ``git tag``,
which contains the currently released version. This formula is versioned according to `Semantic Versioning <http://semver.org/>`_.

See `Formula Versioning Section <https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#versioning>`_ for more details.

If you need (non-default) configuration, please pay attention to the ``pillar.example`` file and/or `Special notes`_ section.

Contributing to this repo
-------------------------

**Commit message formatting is significant!!**

Please see `How to contribute <https://github.com/saltstack-formulas/.github/blob/master/CONTRIBUTING.rst>`_ for more details.

Special notes
-------------

To start off you need provide a valid promtail scrape config and your loki server, this is done by expanding the promtail pillar.

At a later time i would like to provide more information and at least a default journald scrape config::

    # Required for openssh.known_hosts
    promtail:
      config:
         clients:
          - url: http://127.0.0.1:3100/loki/api/v1/push
      scrape_configs:
       - job_name: journal
         journal:
            path: /var/log/journal
            labels:
               job: systemd-journal
         relabel_configs:
          - source_labels: ['__journal__systemd_unit']
            target_label: 'unit'

Available states
----------------

.. contents::
   :local:

``promtail``
^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

This installs the promtail binary, manages the promtail configuration file and then creates and starts the associated promtail service.

``promtail.install``
^^^^^^^^^^^^^^^^^^^^

This state will install the promtail binary and has a dependency on ``promtail.service`` via include list.

``promtail.config``
^^^^^^^^^^^^^^^^^^^

This state will configure the promtail service and has a dependency on ``promtail.install`` via include list.

``promtail.service``
^^^^^^^^^^^^^^^^^^^^

This state will create and start the promtail service only.

Testing
-------

Linux testing is done with ``kitchen-salt``.

Requirements
^^^^^^^^^^^^

* Ruby
* Docker

.. code-block:: bash

   $ gem install bundler
   $ bundle install
   $ bin/kitchen test [platform]

Where ``[platform]`` is the platform name defined in ``kitchen.yml``,
e.g. ``debian-9-2019-2-py3``.

``bin/kitchen converge``
^^^^^^^^^^^^^^^^^^^^^^^^

Creates the docker instance and runs the ``promtail`` main state, ready for testing.

``bin/kitchen verify``
^^^^^^^^^^^^^^^^^^^^^^

Runs the ``inspec`` tests on the actual instance.

``bin/kitchen destroy``
^^^^^^^^^^^^^^^^^^^^^^^

Removes the docker instance.

``bin/kitchen test``
^^^^^^^^^^^^^^^^^^^^

Runs all of the stages above in one go: i.e. ``destroy`` + ``converge`` + ``verify`` + ``destroy``.

``bin/kitchen login``
^^^^^^^^^^^^^^^^^^^^^

Gives you SSH access to the instance for manual testing.

