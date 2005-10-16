From: Romain Lenglet <rlenglet@domain.hid>
Date: Sun, 16 Oct 2005 16:47:23 +0900
References: <000d01c5cfcb$8b5dfaf0$0600a8c0@domain.hid>
	<17230.50005.610300.142351@domain.hid>
	<200510141242.59134.rlenglet@domain.hid>
In-Reply-To: <200510141242.59134.rlenglet@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510161647.23589.rlenglet@domain.hid>
Subject: [Xenomai-core] Packaging issues and licensing issues
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I repost here the issues that I have pointed in "wish" #4523 on 
the GNA interface 
https://gna.org/bugs/index.php?func=detailitem&item_id=4523
which, although it is listed in the bug tracker, is *not* a 
bug... ;) but there is no other place to put wishes or todo 
items.

========================================
Debian offers the module-assistant package, that relies on the 
kernel-package tools.
 module-assistant is both a command-line and a dialog-and-menus 
based tool, to make it very easy to build and package kernel 
modules.
 
 For instance, to build a module package from the ipw2100-source 
package (for wireless cards), the single following command is 
sufficient:
 $> m-a build ipw2100
 This downloads the source package, builds the modules and 
packages them.
 $> m-a install ipw2100
 This command does the same and even installs the built package.
 
 However, the current rtai-source in Debian is the only *-source 
package that cannot be built using module-assistant. This should 
be corrected in the next packages.
 
 
 I propose that the package be split into 5 packages, anyway:
 - libxenomai: the libraries,
 - libxenomai-dev: the development libraries, headers and devel 
tools (rtai-config, etc.),
 - libxenomai-tools: the runtime tools (rtai-load, etc.?)
 - libxenomai-doc: the docs,
 - xenomai-source: only the sources of modules; should be usable 
with module-assistant.
 
 And the *-source package should be well integrated: the module 
*.ko files should go into /lib/modules/... so that we can use 
modprobe directly to load the Xenomai modules. But that should 
be OK if it is compatible with module-assistant.
========================================


I have started creating a Debian package mockup (as a week-end 
hobby, do no expect that I finish it ;)), following the above 
remarks, and I have found other issues:

There are three licenses used in the source code:
1- GPL v2 or later:
  ./sim/**
  ./skins/rtai/*
  ./skins/posix/*
  ./skins/native/*
  ./skins/uvm/*
  ...
OK, no problem: the COPYING files are consistent with the license 
headers in files.

2- GPL v2 or later with exceptions:
  ./nucleus/**
  ./include/nucleus/**
  ./skins/psos+/**
  ./skins/uitron/**
  ./skins/vrtx/**
  ./skins/vxworks/**
  ...
The license headers in files do not mention the exceptions, only 
the COPYING files do. -> You should update the license headers 
in files.

3- LGPL v2 or later:
  ./skins/rtai/lib/*
  ./skins/posix/lib/*
  ./skins/native/lib/*
  ./skins/uvm/lib/*
  ...
Problem: only the text for v2.1 is in the COPYING files, not for 
v2 as mentioned in all license headers in files. -> You should 
update the COPYING files to contain LGPL v2, or update headers 
in files.


My other issue is: what are precisely the licences of every 
binaries / docs / modules / ... produced by make install? 
Because the right license files and doc must be provided in 
binary packages.

-- 
Romain Lenglet

