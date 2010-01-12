Message-ID: <4B4CCCC5.4020808@domain.hid>
Date: Tue, 12 Jan 2010 20:25:57 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <1aa9845a1001110940o6bab200apde40348cc8e21bca@domain.hid>	<4B4B6D53.8050606@domain.hid>	<1aa9845a1001111053q58e082b1n75599eed79feec5a@domain.hid>
	<1aa9845a1001121054r245187bfq5bf4f65fd031238f@domain.hid>
In-Reply-To: <1aa9845a1001121054r245187bfq5bf4f65fd031238f@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai not booting on a dell server
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Saravanan S <sarans1987@domain.hid>
Cc: xenomai@xenomai.org

Saravanan S schrieb:
> 
> 
> On Tue, Jan 12, 2010 at 12:23 AM, Saravanan S <sarans1987@domain.hid
> <mailto:sarans1987@domain.hid>> wrote:
> 
> 
> 
>     On Mon, Jan 11, 2010 at 11:56 PM, Gilles Chanteperdrix
>     <gilles.chanteperdrix@xenomai.org
>     <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
> 
>         Saravanan S wrote:
>         > Hi,
>         >
>         > I am trying to install xenomai on a Dell Poweredge server
>         (R710).The
>         > platform details are given below:
>         >
>         > Two quad Intel(8 cores) Xeon E5506@domain.hid 6,RAM-16
>         > GB,uses SAS disks through a SAS Host Bus Adapter(HBA).
>         >
>         > Drivers for this HBA only available from fedora 10 onwards.
>         >
>         > So I patched xenomai  2.4.10 with linux 2.6.29.4 with fedora 11 as
>         > the host OS.I used fedora 11 config file.I made the following
>         changes
>         > to the config file
>         >
>         > 1.In processor types and features: architecture->Core2/Newer Xeon,
>         > subarchitecture->Generic, thermal throttling disabled,HPET support
>         > enabled
>         >
>         > 2.Power management stopped.
> 
>         Bad. You should enable ACPI, only CONFIG_ACPI_PROCESSOR should
>         be disabled.
> 
>         >
>         > 3.Support for PCI hotplug disabled.
>         >
>         > 4.MSI,MSI-X disabled.
> 
>         No reason to do this. If you enable these options and get problems,
>         please isolate the option which causes a problem and report.
> 
>         >
>         > 5.In real time subsystem all options selected.
> 
>         Please keep the default settings for a first run, verify that it
>         works,
>         then enable the options you want (all of them if you want), if
>         it does
>         not work, then isolate the option which is the cause of the problem.
> 
>         >
>         > 6.SMP support enabled
>         >
>         > 7.MTD support disabled
>         >
>         > 8.All other default options.
>         >
>         > After making and installing the modules ,when i selected the
>         xenomai
>         > kernel on rebooting it didnt boot at all.There was just a blinking
>         > cursor on the screen.
> 
>         Did you rebuild your OS (which is it anyway ?) initramfs/initrd?
>         If you
>         do the same procedure without activating CONFIG_IPIPE and
>         CONFIG_XENOMAI, do you get
> 
>         >
>         > I referred to the following documents while installing
>         >
>         > http://download.intel.com/design/intarch/papers/322386.pdf
>         >
>         >
>         http://stud3.tuwien.ac.at/~e0226686/xenomai/xenomai_implementation.pdf
>         <http://stud3.tuwien.ac.at/%7Ee0226686/xenomai/xenomai_implementation.pdf><http://stud3.tuwien.ac.at/%7Ee0226686/xenomai/xenomai_implementation.pdf>
>         >
>         >
>         >
>         http://www.lara.ene.unb.br/~phsantana/files/technotes/HowTo_Debian_Embedded.pdf
>         <http://www.lara.ene.unb.br/%7Ephsantana/files/technotes/HowTo_Debian_Embedded.pdf><http://www.lara.ene.unb.br/%7Ephsantana/files/technotes/HowTo_Debian_Embedded.pdf>
> 
>         That is fine and even flattering to see that there are paper about
>         xenomai all around the web and even on intel's site. However, the
>         website containing authoritative documentation is
>         http://www.xenomai.org
>         If something is missing there, please ask.
> 
>         I read the Intel doc for instance, it contains a lot of things
>         which are
>         a cut and paste of Xenomai documentation, with some added stuff,
>         which
>         unfortunately is quite erroneous:
>         - Adeos is not a real-time kernel
>         - there is no such thing as a list of linux kernels compatibles
>         with a
>         version of Xenomai, each version of Xenomai aims at being compatible
>         with each versions of a Linux kernel for which a patch has been
>         issued
>         at the time of the release. For each architecture, there are several
>         patches contained in the package, you are insured that linux kernel
>         patched with these patches compile, and that the one with the
>         highest
>         linux version has been tested to validate xenomai.
>         - the list of packages to install in order to be able to install
>         xenomai
>         is extravagant. The following packages are not needed:
>         rpm -ivh libgomp-4.1.2-42.el5.i386.rpm (Disk 2)
>         rpm -ivh elfutils-libs-0.125-3.el5.i386.rpm (Disk 2)
>         rpm -ivh redhat-rpm-config-8.0.45-24.el5.noarch.rpm (Disk
>         2)
>         rpm -ivh ncurses-devel-5.5-24.20060715.i386.rpm (Disk 2)
>         rpm -ivh elfutils-0.125-3.el5.i386.rpm (Disk 2)
>         rpm -ivh libstdc++-devel-4.1.2-42.el5.i386.rpm (Disk 2)
>         rpm -ivh doxygen-1.4.7-1.1.i386.rpm (optional, Disk 2)
>         rpm -ivh unifdef-1.171-5.fc6.i386.rpm (Disk 3)
>         rpm -ivh rpm-build-4.4.2-48.el5.i386.rpm (Disk 3)
>         rpm -ivh emacs-common-21.4-20.el5.i386.rpm (required for
>         emacs-nox, Disk 3)
>         rpm -ivh emacs-nox-21.4-20.el5.i386.rpm (optional,
>         Disk 4)
>         - when building a linux 2.6 kernel, you do not need to run make
>         clean
>         before building the kernel, actually, it is a waste of time
>         - the list of options to disable to run with xenomai is
>         extravagant too:
>         you should not disable power management, you should enable ACPI,
>         and the
>         MSI and MSI-X should work
>         CardBus should work
>         I suspect Toshiba and Dell laptop support should work
>         PCI hotplug should work
>         MTD should work (and actually works on embedded platforms with
>         MTD devices)
>         Fusion MPT should work
>         I2O should work
>         ISDN should work
> 
>         Anyway, if you have problem when enabling these options, writing
>         a paper
>         telling the rest of the world to disable them is the wrong
>         approach, any
>         such issue should be reported on this list.
> 
>         --
> 
> 
> 
>     Thanks for replying first of all.I guess i was mislead by the intel
>     document.I will try out what you have said and come back to you.
> 
> 
>     With regards,
> 
>     S Saravanan 
> 
>                                                    Gilles.
> 
> 
> 
> I tried out the installation following the guidelines given by xenomai
> documents as per your advice .The details are given below:
> 
> Xenomai-2.4.10 patched on linux 2.6.29.4,host OS-fedora 11
> 
> while patching  xenomai gave arch as x86(Is this correct for my server???)
> 
> I used the following options following options in the kernel config
> 
> 1.Processor -Pentium Pro(Strangely newer xeon option  doesnt work
> ..kernel doesnt boot...tried several times)
> 
> 2.ACPI-Processor disabled
> 
> 3.APM disabled
> 
> 4.CPU frequency scaling disabled
> 
> 5.Check for P4 thermal throttling interrupt disabled.(If enabled gives a
> error while making kernel)
> 
> 5.rest all default options.
> 
> After installing i could boot inside xenomai kernel but when i ran
> xeno-test program ,got worst case latency of around 88 us which is not
> good enough.
> 
> some other points:
> 
> 1.Grepping dmesg showed no message "SMI chipset found"(SMI detection was
> enabled), so my platform surely does not have SMI chipset(Is this
> assumption correct????).

please post the output of the following commands:

 lspci -nn
 cat /proc/cpuinfo

Stefan

> 
> 2.There are 4 UHCI USB and 2 EHCI USB embedded controllers in the
> server.But anyway the UHCI and EHCI drivers were loaded.
> 
> I dont know how to proceed next.Would be very helpful if you could guide
> me on where things could be going wrong.
> 
> Thanking you,
> 
> With Regards,
> 
> S Saravanan
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


