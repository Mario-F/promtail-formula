.. _readme:

promtail-formula
================

|img_travis| |img_sr|

.. |img_travis| image:: https://travis-ci.com/saltstack-formulas/promtail-formula.svg?branch=master
   :alt: Travis CI Build Status
   :scale: 100%
   :target: https://travis-ci.com/saltstack-formulas/promtail-formula
.. |img_sr| image:: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
   :alt: Semantic Release
   :scale: 100%
   :target: https://github.com/semantic-release/semantic-release

A SaltStack formula that is empty. It has dummy content to help with a quick
start on a new formula and it serves as a style guide.

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

None

Available states
----------------

.. contents::
   :local:

``promtail``
^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

This installs the promtail package,
manages the promtail configuration file and then
starts the associated promtail service.

``promtail.package``
^^^^^^^^^^^^^^^^^^^^

This state will install the promtail package only.

``promtail.config``
^^^^^^^^^^^^^^^^^^^

This state will configure the promtail service and has a dependency on ``promtail.install``
via include list.

``promtail.service``
^^^^^^^^^^^^^^^^^^^^

This state will start the promtail service and has a dependency on ``promtail.config``
via include list.

``promtail.clean``
^^^^^^^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

this state will undo everything performed in the ``promtail`` meta-state in reverse order, i.e.
stops the service,
removes the configuration file and
then uninstalls the package.

``promtail.service.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will stop the promtail service and disable it at boot time.

``promtail.config.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^

This state will remove the configuration of the promtail service and has a
dependency on ``promtail.service.clean`` via include list.

``promtail.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will remove the promtail package and has a depency on
``promtail.config.clean`` via include list.

``promtail.subcomponent``
^^^^^^^^^^^^^^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

This state installs a subcomponent configuration file before
configuring and starting the promtail service.

``promtail.subcomponent.config``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will configure the promtail subcomponent and has a
dependency on ``promtail.config`` via include list.

``promtail.subcomponent.config.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will remove the configuration of the promtail subcomponent
and reload the promtail service by a dependency on
``promtail.service.running`` via include list and ``watch_in``
requisite.

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

