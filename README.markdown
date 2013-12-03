Java
========

Table of Contents
------------------

1. [Overview - What is the Java module?](#overview)
2. [Module Description - What does the module do?](#module-description)
3. [Usage - How to use the module for various tasks](#usage)
4. [Upgrading - Guide for upgrading from older revisions of this module](#upgrading)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
7. [Disclaimer](#disclaimer)
8. [Contributors - List of module contributors](#contributors)

Overview
---------

The java module allows you to set up the java jdk on a linux environment

Module Description
------------------


Usage
-----

**Paramters**

jdk_package_name - the name of the jdk package to install
jdk_package_ensure - the ensure level for the jdk package
primary_jdk - a yes or no variable of is this is the primary jdk for the system 
jdk_path - the path that the jdk will install to 

example usage with default parameters
	
	class { 'java::jdk': }

**Adding a cacert to the jdk**

the cacert define is designed to allow you to push out a cacert to the jdk install that may be needed

* Paramters:
	* cacertpath -> title - the path to the cacert file that you would like installed
	* owner - the owner of the cacert, the default is root
	* group - the group owner of the cacert, the default is root
	* mode - the mode of the cacert file, the default is root
	* ensure - this the ensure of the cacert file, the default is present
	* jdkpath - the path where the jdk is installed too that you want to add the cacert to
	
* example:
	
	java::jdk::cacert { 'puppet:///files/cacert':
		jdkpath => '/usr/lib/jvm/java-1.6.0-openjdk-1.6.0.x86_64/',
	}

Upgrading
---------

Since this is the first version there are no notes about upgrading

Limitations
-----------

currently only tested on:
* CentOS 6.x and related distros

Although patches are welcome for making it work with other OS distros, it is considered best effort.

Development
-----------

Contributions and pull requests are welcome to making this module the best that it can be.

**Tests**

There is a full suite of rspec-puppet tests, these can be run by going into the module and running rake spec

Disclaimer
----------

This module is provided without warranty of any kind, the creator(s) and contributors do their best to ensure stablity but can make no warranty about the stability of this module in different environments. The creator(s) and contributors reccomend that you test this module and all future releases of this module in your environment before use.

Contributors
------------

* [Diego Gutierrez](https://github.com/dgutierrez1287) )


