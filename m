Message-ID: <45AE3ED4.7040506@domain.hid>
Date: Wed, 17 Jan 2007 09:20:52 -0600
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Compiling Linux+Xenomai 32bits kernel on
	FC6	x86_64?
References: <cbe23c50701170051r46cadf4cha5b144d17df2ec77@domain.hid>
	<45ADE724.3010800@domain.hid>
In-Reply-To: <45ADE724.3010800@domain.hid>
Content-Type: multipart/mixed; boundary="------------070303070002020409070608"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------070303070002020409070608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Matthias Fechner wrote:
> Eric Noulard schrieb:
>> Is it possible to run/boot a 32bit xenomai on a 64 bit system
>> or should I really need to install a 32bit only system on my 64 bit
>> machine?
>> If yes how to do this properly?
>> If no
>>   - is there a planned support for 64bit in xenomai/adeos?
>>   - what should I do to use Xenomai on my 64 bit machine?
> 
> I had exactly the same problem and I installed a second 32-bit Linux on
> my harddisk and easily linked some dirs from my old 64-bit installation
> to save space (e.g. /usr/src, /usr/local).

I installed the FC6 i386 version on a second partition as well.  After that, I followed the steps outlined in the attached file to build kernel and Xenomai RPMs.
 
> But the best is a Xenomai which supports 64-bit AMD processors :)

Of course!

-Jeff


--------------070303070002020409070608
Content-Type: text/plain;
 name="kernel-build-xeno.rst"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernel-build-xeno.rst"


=============================
Xenomai Kernel Building HOWTO
=============================

------------
Introduction
------------

This document describes how to build a Fedora kernel RPM from the
'vanilla' linux source tree.  It is written with building a Xenomai
patched kernel in mind, but the same procedure applies to standard
kernels.

-----------
Source Code
-----------

The required source code can be retrieved from:

  * http://www.mit-lcs.lkams.kernel.org/pub/linux/kernel/v2.6/linux-2.6.19.1.tar.bz2
  * http://download.gna.org/xenomai/stable/xenomai-2.3.0.tar.bz2

-------------
Configuration
-------------

Obtain Root Privileges
======================

Some folks say you shouldn't compile programs as root.  This is
probably true, but I usually do it anyway.  From this point on, I'm
assuming that you are running with root privileges.  If you want to
adapt the proceedure to run as another user, then more power to you.

::

  su

Uncompress the archives
=======================

::

  cd /usr/src
  tar -jxvf linux-2.6.19.1.tar.bz2
  tar -jxvf xenomai-2.3.0.tar.bz2
  mv linux-2.6.19.1/ linux-2.6.19.1-xenomai-2.3.0

Apply the Adeos Kernel Patch
============================

If your are building a Xenomai system, you will need to patch the
vanilla kernel for real-time use:

::

  xenomai-2.3.0/scripts/prepare-kernel.sh --arch=i386 \
  --adeos=xenomai-2.3.0/ksrc/arch/i386/patches/\
  adeos-ipipe-2.6.19-i386-1.6-03.patch \
  --linux=linux-2.6.19.1-xenomai-2.3.0

Update the mkspec Script
========================

Replace the existing mkspec script with a new one:
::

  cd linux-2.6.19.1-xenomai-2.3.0
  cp ~/svn/utils/mkspec-2.6 scripts/package/mkspec

Edit ``scripts/package/Makefile``.  Change:

::

  KERNELPATH := kernel-$(subst -,,$(KERNELRELEASE))

to

::

  KERNELPATH := customkernel-$(subst -,,$(KERNELRELEASE))

  
Modify the Maximum POSIX Message Queue Size
===========================================

Edit ``include/linux/mqueue.h``.  Change:

::

  #define MQ_BYTES_MAX  819200

to

::

  #define MQ_BYTES_MAX  1024*1024*256

Modify the Kernel Version String
================================

Add the following to the top section of the top-level kernel Makefile:

::

  EXTRAVERSION = .1xenomai2.3.0

Configure the Kernel
====================

::

  make xconfig

File->Load ``/boot/config-2.6.18-1.2849.fc6``

Change the following config options:

::

  Processor type and features/Processor family -> Athon/Duron/K7
                             /Support for hot-pluggable CPUs -> [n]
  Power management options (ACPI, APM)/ACPI Support/Processor -> [n]
                                      /APM BIOS Support -> [n]
                                      /CPU Frequency scaling -> [n]
  Bus options/PCI support/Message Signaled Interrupts -> [n]
  File systems/Ext3 journalling file system support -> [y]
  Real-time sub-system/Xenomai/Nucleus/Interfaces/POSIX API/Interrupts -> [y]
                                      /Drivers/Serial Drivers/
                                                    16550A UART driver -> [y]
                                              /Testing Drivers/<All> ->[m]
  Device Drivers/Serial ATA drivers/NVIDIA SATA support -> [m]
                                   /AHCI SATA support  -> [m]

Save and Quit

---------------
Build Procedure
---------------

You can build the kernel RPM as follows:

::

  time make rpm

If you have build errors, use the following command when debugging to
keep from restarting each subsequent build from the beginning:

::

  rpmbuild --short-circuit --target i386 \
    -tc ../customkernel-2.6.19.1xenomai2.3.0.tar.gz

------------
Installation
------------

Install the RPMs
================

::

  rpm -i /usr/src/redhat/RPMS/i386/customkernel-2.6.19.1xenomai2.3.0-1.i386.rpm
  rpm -i /usr/src/redhat/RPMS/i386/customkernel-source-2.6.19.1xenomai2.3.0-1.i386.rpm

Update grub.conf
================

Add the following section to ``/boot/grub/grub.conf``.  Edit your root
partitions according to your own installation.

::
   
  title Fedora Core 6 - i386 (2.6.19.1xenomai2.3.0)
          root (hd0,1)
          kernel /boot/vmlinuz-2.6.19.1xenomai2.3.0 ro root=/dev/sda2 noapic \
            pci=routeirq 8250.nr_uarts=0 xeno_16550A.ioaddr=0x3f8 \
            xeno_16550A.irq=4
          initrd /boot/initrd-2.6.19.1xenomai2.3.0.img

If you need more vmalloc memory for some reason:

::

  title Fedora Core 6 - i386 (2.6.19.1xenomai2.3.0)
          root (hd0,1)
          uppermem 524288
          kernel /boot/vmlinuz-2.6.19.1xenomai2.3.0 ro root=/dev/sda2 noapic \
            pci=routeirq 8250.nr_uarts=0 xeno_16550A.ioaddr=0x3f8 \
            xeno_16550A.irq=4 vmalloc=256M
          initrd /boot/initrd-2.6.19.1xenomai2.3.0.img

Reboot your system and select the new kernel.

----------------------------------
Install Xenomai Userspace Software
----------------------------------

Move the tar file to the proper location:

::

  cd /usr/src
  cp xenomai-2.3.0.tar.bz2 redhat/SOURCES/

Build the RPM:

::

  rpmbuild --target i386 -ba xenomai.spec


Install the RPM:

::

  rpm -i /usr/src/redhat/RPMS/i386/xenomai-2.3.0-1.i386.rpm

------------
Test Xenomai
------------

::

  cd /usr/xenomai/share/xenomai/testsuite/latency/
  ./run
  <ctrl-c>
  cd ../switchtest
  ./run
  <ctrl-c>

-------------------
About this document
-------------------
  
:Original Author: Jeff Webb
:Creation Date: December 22, 2006
 
$LastChangedBy: webb-ja $
 
$LastChangedDate: 2007-01-04 16:48:11 -0600 (Thu, 04 Jan 2007) $

--------------070303070002020409070608
Content-Type: text/plain;
 name="mkspec-2.6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mkspec-2.6"

#!/bin/sh
#
#	Output a simple RPM spec file that uses no fancy features requring
#	RPM v4. This is intended to work with any RPM distro.
#
#	The only gothic bit here is redefining install_post to avoid
#	stripping the symbols from files in the kernel which we want
#
#	Patched for non-x86 by Opencon (L) 2002 <opencon@domain.hid>
#

# how we were called determines which rpms we build and how we build them
if [ "$1" = "prebuilt" ]; then
	PREBUILT=true
else
	PREBUILT=false
fi

# starting to output the spec
if [ "`grep CONFIG_DRM=y .config | cut -f2 -d\=`" = "y" ]; then
	PROVIDES=kernel-drm
fi

__KERNELVERSION=`echo $KERNELVERSION | sed -e "s/-//g"`
PROVIDES="$PROVIDES customkernel-$__KERNELVERSION"

echo "Name: customkernel"
echo "Summary: The Linux Kernel"
echo "Version: $__KERNELVERSION"
# we need to determine the NEXT version number so that uname and
# rpm -q will agree
echo "Release: `. $srctree/scripts/mkversion`"
echo "License: GPL"
echo "Group: System Environment/Kernel"
echo "Vendor: The Linux Community"
echo "URL: http://www.kernel.org"

if ! $PREBUILT; then
echo "Source: customkernel-$__KERNELVERSION.tar.gz"
fi

echo "BuildRoot: /var/tmp/%{name}-%{PACKAGE_VERSION}-root"
echo "Provides: $PROVIDES"
echo "%define __spec_install_post /usr/lib/rpm/brp-compress || :"
echo "%define debug_package %{nil}"
echo ""
echo "%description"
echo "The Linux Kernel, the operating system core itself"
echo ""

# Jeff stuff
echo "%package source"
echo "Summary: The Linux Kernel Source"
echo "Group: System Environment/Kernel"
echo "URL: http://www.kernel.org"
echo ""
echo "%description source"
echo "The linux build directory"
echo ""


if ! $PREBUILT; then
echo "%prep"
echo "%setup -q"
echo ""
fi

echo "%build"

if ! $PREBUILT; then
echo "make clean && make %{_smp_mflags}"
#echo "make %{_smp_mflags}"
echo ""
fi

echo "%install"
echo "%ifarch ia64"
echo 'mkdir -p $RPM_BUILD_ROOT/boot/efi $RPM_BUILD_ROOT/lib $RPM_BUILD_ROOT/lib/modules'
echo "%else"
echo 'mkdir -p $RPM_BUILD_ROOT/boot $RPM_BUILD_ROOT/lib $RPM_BUILD_ROOT/lib/modules'
echo "%endif"

echo 'INSTALL_MOD_PATH=$RPM_BUILD_ROOT make %{_smp_mflags} modules_install'
echo "%ifarch ia64"
echo 'cp $KBUILD_IMAGE $RPM_BUILD_ROOT'"/boot/efi/vmlinuz-$__KERNELVERSION"
echo 'ln -s '"efi/vmlinuz-$__KERNELVERSION" '$RPM_BUILD_ROOT'"/boot/"
echo "%else"
echo 'cp $KBUILD_IMAGE $RPM_BUILD_ROOT'"/boot/vmlinuz-$__KERNELVERSION"
echo "%endif"

echo 'cp System.map $RPM_BUILD_ROOT'"/boot/System.map-$__KERNELVERSION"

echo 'cp .config $RPM_BUILD_ROOT'"/boot/config-$__KERNELVERSION"
echo ""

# Jeff stuff
echo 'mkdir -p $RPM_BUILD_ROOT'"/usr/src/redhat/BUILD"
echo "cp -a /usr/src/redhat/BUILD/customkernel-$__KERNELVERSION"' $RPM_BUILD_ROOT'"/usr/src/redhat/BUILD/customkernel-$__KERNELVERSION"
echo ""


echo "%clean"
echo '#echo -rf $RPM_BUILD_ROOT'
echo ""
echo "%files"
echo '%defattr (-, root, root)'
echo "%dir /lib/modules"
echo "/lib/modules/$__KERNELVERSION"
echo "/boot/*"
echo ""

# Jeff stuff
echo "%files source"
echo '%defattr (-, root, root)'
echo "%dir /usr/src/redhat/BUILD"
echo "/usr/src/redhat/BUILD/customkernel-$__KERNELVERSION"
#echo "/usr/src/redhat/BUILD/kernel-$__KERNELVERSION/.*"
echo ""

# JEFF
# Fedora install scripts
echo "%pre" 
echo "/sbin/modprobe loop 2> /dev/null > /dev/null  || :"
echo "exit 0"
echo ""
echo "%post" 
echo "cd /boot"
echo "[ -x /usr/sbin/module_upgrade ] && /usr/sbin/module_upgrade"
echo "[ -x /sbin/mkkerneldoth ] && /sbin/mkkerneldoth"
echo "[ -x /sbin/new-kernel-pkg ] && /sbin/new-kernel-pkg --depmod --install $__KERNELVERSION"
echo "[ -x /sbin/mkinitrd ] && /sbin/mkinitrd -f /boot/initrd-$__KERNELVERSION.img $__KERNELVERSION"
echo "[ -x /sbin/new-kernel-pkg ] && /sbin/new-kernel-pkg --depmod --install $__KERNELVERSION --initrdfile=/boot/initrd-$__KERNELVERSION.img"
echo ""
echo "# Allow clean removal of modules directory"
echo "%preun"
echo "/sbin/modprobe loop 2> /dev/null > /dev/null  || :"
echo "[ -x /sbin/new-kernel-pkg ] && /sbin/new-kernel-pkg --rminitrd --rmmoddep --remove $__KERNELVERSION"
echo ""

##/bin/sh /usr/src/linux-2.6.19.1-xenomai-2.3-rc3/scripts/package/mkspec > /usr/src/linux-2.6.19.1-xenomai-2.3-rc3/kernel.spec

--------------070303070002020409070608
Content-Type: text/plain;
 name="xenomai.spec"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai.spec"

Summary: Xenomai real-time system
Name: xenomai
Version: 2.3.0
Release: 1
License: GNU GPL
Group: Development/Tools
Source: xenomai-2.3.0.tar.bz2
URL: http://www.xenomai.org
Buildroot: %{_tmppath}/%{name}-%{version}-root

%description
Xenomai user-space installation.  Requires a Xenomai patched kernel.

%prep
%setup -q

%build
./configure --enable-smp
make

%install
[ "$RPM_BUILD_ROOT" != "/" ] && rm -rf $RPM_BUILD_ROOT
make DESTDIR=$RPM_BUILD_ROOT install

%clean
[ "${RPM_BUILD_ROOT}" != "/" ] && rm -rf ${RPM_BUILD_ROOT}

%files
%defattr(-,root, root)
/usr/xenomai

--------------070303070002020409070608--

