# vagrant-dhdp

#### Table of Contents

1. [Overview](#overview)
2. [Requirements](#requirements)
3. [Usage](#usage)
4. [Reference](#reference)
5. [Limitations](#limitations)

## Overview

Setup a web development environment using vagrant :

* OS : [Debian 8](https://atlas.hashicorp.com/loispuig/boxes/debian-jessie-amd64)
* Software : Apache2, MariaDB, PHP7, phpMyAdmin, Redis, git, composer

## Required dependencies

* [Virtualbox](https://www.virtualbox.org/)
* [Vagrant](https://www.vagrantup.com/)
* [Vagrant Manager](http://vagrantmanager.com/) (optional)

## Usage

Clone or download this repository
```
git clone https://github.com/loispuig/vagrant-dhdp.git
```
Edit Vagrantfile to fit your needs, then launch the box:
```
vagrant up
```

Once up: 
* Your files are stored in the 'www' directory.
* Open a web browser and navigate to http://10.10.10.10 or https://10.10.10.10
* phpMyAdmin can be found at the /phpmyadmin adress

## Reference

* Vagrantfile : As it says, this is the Vagrant file.
* puppet/init.pp : Puppet provisioning starting script.

## Limitations

Tested on Mac OS X 10.11 using Virtualbox 5.0.18 and vagrant 1.8.1.