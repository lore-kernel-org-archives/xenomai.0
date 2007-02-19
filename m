MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17882.8656.513391.469444@domain.hid>
Date: Mon, 19 Feb 2007 23:16:48 +0100
Subject: Re: [Xenomai-help] getting started (Part 2)
In-Reply-To: <45D98774.7070400@domain.hid>
References: <45D887EF.8010404@domain.hid>
	<17880.36271.503322.588359@domain.hid>
	<45D98774.7070400@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: Xenomai-help@domain.hid

Roland Tollenaar wrote:
 > Hi
 > 
 > I have followed the directives of Richard and Gilles (thanks) and now 
 > have a rough idea of what the steps should be to install Xenomai. I 
 > still have some questions before I start.
 > 
 > I apologize in advance for amount of text surrounding the not so many 
 > questions. I have tried to be a clear as possible.
 > 
 > A
 > The first part of the installation is preparing the kernel
 > I have 2.6.16 kernel so I have downloaded the
 > adeos-ipipe-2.6.16-i386-1.5-02.patch.
 > I have no idea what architecture I have but i386 sounds familiar. :)
 > How can I test what architecture I have?
 > Is this the correct patch?
 > Calling prepare-kernel.sh with its arguments seems straight-forward 
 > after that.

To test what architecture you have, run uname -m. You are using the
correct patch, but why 2.6.16 ? If you have no particular reason to
choose a kernel revision, then use the latest one.

 > 
 > B
 > Compiling the kernel. My biggest worry here is the configuration. 
 > Knowing nothing of such configurations I would like to avoid having to 
 > make uneducated guesses in this stage. Is it possible to get hold of the 
 > current kernel configuration and load that in the
 > make menuconfig
 > stage?
 > If yes, how?

By default, when running the configuration frontend, it will load the
kernel configuration from the running kernel. About selecting options,
there are (at least) two kinds of kernels:
- the one tailored for a particular machine, it will not use an initrd
  have the root partition driver and root filesystem built-in, and only
  a few modules;
- a generic one, that will boot on a maximum of machines, it will come
  with as much modules as possible and with an initrd which selects the
  driver for the root partition and the root filesystem before booting.

About Xenomai now: there are a few options that you should avoid, they
are documented in the TROUBLESHOOTING file, except one: the HPET timer
option, which should be also avoided though it is not documented. 

 > 
 > C
 > Subsequently calling
 > make
 > then
 > make modules_install install
 > What happens in this install step? What files/directories are installed 
 > and where? Reason I ask is because I am running from liveUSB and booting 
 > with syslinux so I will have to write the kernel image (vmlinuz on my 
 > system) to /dev/sda1 (via where ever it is mounted of course) and not to 
 > /boot/ on that same drive.

make modules_install installs the compiled modules under
/lib/modules/<kernel-revision>

make install installs the bzImage, .config and System.map in /boot under
the names vmlinuz-<kernel-revision>, config-<kernel-revision> and
System.map-<kernel-revision>. It also creates a symbolic link between
the last installed kernel and /boot/vmlinuz.

 > 
 > Another question in this regard is that my current kernel image is 
 > called vmlinuz not bzImage the documentation talks about all the time. 
 > What is the difference? Can I rename the bzImage to vmlinuz. Take note 
 > of the fact that the USB has a FAT filesystem. Thus symbolic links do 
 > not work and I instead have to make copies instead.

Yes, vmlinuz and bzImage are the same thing.

 > 
 > Then captain's universe mutters about creating the initial RAM-disk (if 
 > I need one). How do I know whether I need one? I know that running from 
 > a liveUSB I do need what is called initrd.gz in the boot process, but is 
 > this what the documentation is talking about?

initrd are mostly useful for generic kernels.

 > 
 > How do I finally set up the new kernel to be booted. Is it sufficient to 
 > write it (vmlinuz) to the position where the current kernel image is 
 > located? (safely renaming the current kernel image to "vmlinuz-old" of 
 > course :))

I have never used syslinux, but reading rapidly its documentation, it
does not seem to be necessary to re-run syslinux after each kernel
installation.

-- 


					    Gilles Chanteperdrix.

