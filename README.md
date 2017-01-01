#  Lmod Test Suite.

This is a test suite for Lmod.  It checks that Lmod is installed correctly.   It relies on the Hermes testing framework (found at https://github.com:rtmclay/hermes.git).

This set of test is designed to test how well Lmod is integrated into the startup scripts.  This is typically adding the appropriate files into /etc/profile.d.  Linux systems typically use this to allow programs and aliases and shell functions to be available for a user without the user adding anything to their personal startup scripts (i.e. ~/.bashrc).

All the tests in this suite will fail if a user defines the module command in their personal startup scripts.

## Lmod Mailing list

* mailto:lmod-users@lists.sourceforge.net.

Please go to https://lists.sourceforge.net/lists/listinfo/lmod-users to join.

## Prerequisites:

To get ready to use this test suite please take the following steps:

1. Install Lmod from either lmod.sf.net or github.com:TACC/Lmod.git
2. Install Hermes from https://github.com:rtmclay/hermes.git.


## Install:

1. git clone github.com:rtmclay/Lmod_test_suite

## Usage:

    $ cd Lmod_test_suite
    $ testcleanup          # remove the old tests
    $ tm .

## Interpreting Results:

There are several tests which may run in any order.  However the results should be interpreted in the following order:

1. exist/does_module_exist:  This test checks to see if the module command has been defined. If this test fails then  it is likely that the module command is not being set correctly in /etc/profile.d.  This test creates a bash script that run the login shell so it is sourcing /etc/profile.  This file should source the scripts in /etc/profile.d/*.sh

2. avail/does_avail_work:  This test checks whether the avail command works.  Note that it is using modulefiles built-in to this test. It is NOT using the system's $MODULEPATH.

3. load/does_load_work:   This test check to see if a module load works.

4. subshell/does_a_subshell_work:  This test checks to see startup scripts are setup correctly to handle subshells.  If this fails please check to see that your file which does the initial load of modules works similarly to the ones described in http://lmod.readthedocs.io/en/latest/070_standard_modules.html 

5. int_subshell/does_an_int_subshell_work: This test checks to see if bash is built to source /etc/bashrc (or /etc/bash.bashrc) for an interactive shell.


Test number 5 is likely to fail on Redhat, Centos and MACOS systems.  Where as it will likely pass on  debian, mint and ubuntu linux system.   I have added this test to point a problem with the way bash works.  Some unix systems build bash the default way, which means that THERE IS NO SYSTEM FILES SOURCED at the start of the the shell and other unix systems do source a system file (e.g. /etc/bashrc).  Sites have two choices with dealing with this problem:


1. Patch bash.  See http://lmod.readthedocs.io/en/latest/030_installing.html#interactive-non-login-shells.  This is what we do at TACC.
2. Require all users to put:  "source /etc/bashrc" in their ~/.bashrc

Interactive non-login bash shells are very common.  One important place is the shell that MPI starts.  It is an non-login interactive shell.  This can be a problem. because your site may define "ulimit -s unlimited"  to make the stack size unlimited in /etc/bashrc.  But if bash is not patched or the user doesn't source /etc/bashrc, then no system configuration files will be sourced leading to failed fortran 90 programs.
