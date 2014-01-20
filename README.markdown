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

The java module allows to install and configure either the jdk or jre.

Module Description
------------------

This module allows you to install the jre and/or jdk from the openjdk packages that are in the OS supplied repos or 
a custom jdk/jre package. 

Usage
-----

Installing the jre or jdk are done with two defines, this for the usecase of having more then one jdk or jre on a system.

<br/>

**Installing a jdk**

* Parameters:
    * **name (title)** - This parameter serves no purpose other then being required by puppet
	* **jdkpackage** - A custom jdk package to be installed 
	* **jdkensure** - The ensure for the custom or openjdk package, this must be present or absent for openjdk but can be a version for a custom jdk
	* **jdkpath** - the path where the jdk is installed too, this should only be supplied if you used a custom jdk package otherwise this is already prefilled 
	* **openjdk_version** - the version of the openjdk to install, currently only version 6 and 7 are supported
	* **primary_jdk** - this must be either yes or no, this will set the JDK\_HOME and JAVA\_HOME in the profile script if it is set to yes

* examples:
    * Openjdk 7:
    ```
    java::jdk { 'jdk7':
        openjdk_version => 7,
    }
    ```
    * Default openjdk 6:
    ```
    java::jdk { 'jdk6': }
    ```
    * Custom jdk package:
    ```
    java::jdk { 'custom':
        jdkpackage => 'jdk_package_name',
        jdkpath => '/usr/java'
    }
    ```
<br/>

**Adding a cacert to the jdk**

the cacert define is designed to allow you to push out a cacert to the jdk install that may be needed

* Paramters:
	* **cacertpath (title)** - the path to the cacert file that you would like installed
	* **owner** - the owner of the cacert, the default is root
	* **group** - the group owner of the cacert, the default is root
	* **mode** - the mode of the cacert file, the default is root
	* **ensure** - this the ensure of the cacert file, the default is present
	* **jdkpath** - the path where the jdk is installed, this should only be supplied if you used a custom jdk package 
    * **openjdk_version** - the version of the openjdk that was installed, if installed instead of a custom package
	
* examples:
    * cacert for default jdk 6
	```
	java::jdk::cacert { 'puppet:///files/cacert': }
    ```
    * cacert for default jdk 7
    ```
    java::jdk::cacert { 'puppet:///files/cacert':
        openjdk_version => 7,
    }
    ```
    * cacert for custom jdk package
    ```
    java::jdk::cacert { 'puppet:///files/cacert': 
        jdkpath => '/usr/java'
    }
    ```

<br />

**Installing a jre**

* Parameters 
    * **name (title)** - This parameter serves no purpose other then being required by puppet
    * **jrepackage** - A custom jre package to be installed 
    * **jreensure** - The ensure for the custom or openjdk-jre package, this must be present or absent for openjdk-jre but can be a version for a custom jre
    * **jrepath** - the path where the jre is installed too, this should only be supplied if you use a custom jre package otherwise this is already prefilled 
    * **openjre_version** - the version of the openjdk-jre to install, currently only version 6 and 7 are supported
    * **primary_jre** - this must be either yes or no, this will set the JDK_HOME and JAVA_HOME in the profile script if it is set to yes

* examples:
    * Openjdk-jre 7:
    ```
    java::jre { 'jre7':
        openjre_version => 7,
    }
    ```
    * Default openjdk-jre 6:
    ```
    java::jre { 'jre6': }
    ```
    * Custom jre package:
    ```
    java::jre { 'custom':
        jrepackage => 'jre_package_name',
        jrepath => '/usr/java'
    }
    ```
<br/>

**Adding a cacert to the jre**

the cacert define is designed to allow you to push out a cacert to the jre install that may be needed

* Paramters:
    * **cacertpath (title)** - the path to the cacert file that you would like installed
	* **owner** - the owner of the cacert, the default is root
	* **group** - the group owner of the cacert, the default is root
	* **mode** - the mode of the cacert file, the default is root
	* **ensure** - this the ensure of the cacert file, the default is present
	* **jrepath** - the path where the jre is installed, this should only be supplied if you used a custom jre package 
    * **openjre_version** - the version of the openjre that was installed, if installed instead of a custom package
	
* examples:
    * cacert for default jre 6
	```
	java::jre::cacert { 'puppet:///files/cacert': }
    ```
    * cacert for default jre 7
    ```
    java::jre::cacert { 'puppet:///files/cacert':
        openjre_version => 7,
    }
    ```
    * cacert for custom jre package
    ```
    java::jre::cacert { 'puppet:///files/cacert': 
        jrepath => '/usr/java'
    }
    ```


Upgrading
---------

Since this is the first version there are no notes about upgrading

Limitations
-----------

currently only tested on:
* RedHat based systems 5.x, 6.x, Debian 5, 6, and Ubuntu 12.04, 13.04, 13.10

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

* [Diego Gutierrez](https://github.com/dgutierrez1287) ([@diego_g](https://twitter.com/diego_g))