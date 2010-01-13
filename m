MIME-Version: 1.0
In-Reply-To: <4B4CCCC5.4020808@domain.hid>
References: <1aa9845a1001110940o6bab200apde40348cc8e21bca@domain.hid>
	<4B4B6D53.8050606@domain.hid>
	<1aa9845a1001111053q58e082b1n75599eed79feec5a@domain.hid>
	<1aa9845a1001121054r245187bfq5bf4f65fd031238f@domain.hid>
	<4B4CCCC5.4020808@domain.hid>
Date: Wed, 13 Jan 2010 18:06:10 +0530
Message-ID: <1aa9845a1001130436t76834232j75977b2ab11422e1@domain.hid>
From: Saravanan S <sarans1987@domain.hid>
Content-Type: multipart/mixed; boundary=0016e64b04feef7a46047d0b0367
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
To: Stefan Kisdaroczi <kisda@domain.hid>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--0016e64b04feef7a46047d0b0367
Content-Type: multipart/alternative; boundary=0016e64b04feef7a3c047d0b0365

--0016e64b04feef7a3c047d0b0365
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Jan 13, 2010 at 12:55 AM, Stefan Kisdaroczi <kisda@domain.hid>wrote:

> Saravanan S schrieb:
> >
> >
> > On Tue, Jan 12, 2010 at 12:23 AM, Saravanan S <sarans1987@domain.hid
> > <mailto:sarans1987@domain.hid>> wrote:
> >
> >
> >
> >     On Mon, Jan 11, 2010 at 11:56 PM, Gilles Chanteperdrix
> >     <gilles.chanteperdrix@xenomai.org
> >     <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
> >
> >         Saravanan S wrote:
> >         > Hi,
> >         >
> >         > I am trying to install xenomai on a Dell Poweredge server
> >         (R710).The
> >         > platform details are given below:
> >         >
> >         > Two quad Intel(8 cores) Xeon E5506@domain.hid 6,RAM-16
> >         > GB,uses SAS disks through a SAS Host Bus Adapter(HBA).
> >         >
> >         > Drivers for this HBA only available from fedora 10 onwards.
> >         >
> >         > So I patched xenomai  2.4.10 with linux 2.6.29.4 with fedora 11
> as
> >         > the host OS.I used fedora 11 config file.I made the following
> >         changes
> >         > to the config file
> >         >
> >         > 1.In processor types and features: architecture->Core2/Newer
> Xeon,
> >         > subarchitecture->Generic, thermal throttling disabled,HPET
> support
> >         > enabled
> >         >
> >         > 2.Power management stopped.
> >
> >         Bad. You should enable ACPI, only CONFIG_ACPI_PROCESSOR should
> >         be disabled.
> >
> >         >
> >         > 3.Support for PCI hotplug disabled.
> >         >
> >         > 4.MSI,MSI-X disabled.
> >
> >         No reason to do this. If you enable these options and get
> problems,
> >         please isolate the option which causes a problem and report.
> >
> >         >
> >         > 5.In real time subsystem all options selected.
> >
> >         Please keep the default settings for a first run, verify that it
> >         works,
> >         then enable the options you want (all of them if you want), if
> >         it does
> >         not work, then isolate the option which is the cause of the
> problem.
> >
> >         >
> >         > 6.SMP support enabled
> >         >
> >         > 7.MTD support disabled
> >         >
> >         > 8.All other default options.
> >         >
> >         > After making and installing the modules ,when i selected the
> >         xenomai
> >         > kernel on rebooting it didnt boot at all.There was just a
> blinking
> >         > cursor on the screen.
> >
> >         Did you rebuild your OS (which is it anyway ?) initramfs/initrd?
> >         If you
> >         do the same procedure without activating CONFIG_IPIPE and
> >         CONFIG_XENOMAI, do you get
> >
> >         >
> >         > I referred to the following documents while installing
> >         >
> >         > http://download.intel.com/design/intarch/papers/322386.pdf
> >         >
> >         >
> >
> http://stud3.tuwien.ac.at/~e0226686/xenomai/xenomai_implementation.pdf<http://stud3.tuwien.ac.at/%7Ee0226686/xenomai/xenomai_implementation.pdf>
> >         <
> http://stud3.tuwien.ac.at/%7Ee0226686/xenomai/xenomai_implementation.pdf><
> http://stud3.tuwien.ac.at/%7Ee0226686/xenomai/xenomai_implementation.pdf>
> >         >
> >         >
> >         >
> >
> http://www.lara.ene.unb.br/~phsantana/files/technotes/HowTo_Debian_Embedded.pdf<http://www.lara.ene.unb.br/%7Ephsantana/files/technotes/HowTo_Debian_Embedded.pdf>
> >         <
> http://www.lara.ene.unb.br/%7Ephsantana/files/technotes/HowTo_Debian_Embedded.pdf
> ><
> http://www.lara.ene.unb.br/%7Ephsantana/files/technotes/HowTo_Debian_Embedded.pdf
> >
> >
> >         That is fine and even flattering to see that there are paper
> about
> >         xenomai all around the web and even on intel's site. However, the
> >         website containing authoritative documentation is
> >         http://www.xenomai.org
> >         If something is missing there, please ask.
> >
> >         I read the Intel doc for instance, it contains a lot of things
> >         which are
> >         a cut and paste of Xenomai documentation, with some added stuff,
> >         which
> >         unfortunately is quite erroneous:
> >         - Adeos is not a real-time kernel
> >         - there is no such thing as a list of linux kernels compatibles
> >         with a
> >         version of Xenomai, each version of Xenomai aims at being
> compatible
> >         with each versions of a Linux kernel for which a patch has been
> >         issued
> >         at the time of the release. For each architecture, there are
> several
> >         patches contained in the package, you are insured that linux
> kernel
> >         patched with these patches compile, and that the one with the
> >         highest
> >         linux version has been tested to validate xenomai.
> >         - the list of packages to install in order to be able to install
> >         xenomai
> >         is extravagant. The following packages are not needed:
> >         rpm -ivh libgomp-4.1.2-42.el5.i386.rpm (Disk 2)
> >         rpm -ivh elfutils-libs-0.125-3.el5.i386.rpm (Disk 2)
> >         rpm -ivh redhat-rpm-config-8.0.45-24.el5.noarch.rpm (Disk
> >         2)
> >         rpm -ivh ncurses-devel-5.5-24.20060715.i386.rpm (Disk 2)
> >         rpm -ivh elfutils-0.125-3.el5.i386.rpm (Disk 2)
> >         rpm -ivh libstdc++-devel-4.1.2-42.el5.i386.rpm (Disk 2)
> >         rpm -ivh doxygen-1.4.7-1.1.i386.rpm (optional, Disk 2)
> >         rpm -ivh unifdef-1.171-5.fc6.i386.rpm (Disk 3)
> >         rpm -ivh rpm-build-4.4.2-48.el5.i386.rpm (Disk 3)
> >         rpm -ivh emacs-common-21.4-20.el5.i386.rpm (required for
> >         emacs-nox, Disk 3)
> >         rpm -ivh emacs-nox-21.4-20.el5.i386.rpm (optional,
> >         Disk 4)
> >         - when building a linux 2.6 kernel, you do not need to run make
> >         clean
> >         before building the kernel, actually, it is a waste of time
> >         - the list of options to disable to run with xenomai is
> >         extravagant too:
> >         you should not disable power management, you should enable ACPI,
> >         and the
> >         MSI and MSI-X should work
> >         CardBus should work
> >         I suspect Toshiba and Dell laptop support should work
> >         PCI hotplug should work
> >         MTD should work (and actually works on embedded platforms with
> >         MTD devices)
> >         Fusion MPT should work
> >         I2O should work
> >         ISDN should work
> >
> >         Anyway, if you have problem when enabling these options, writing
> >         a paper
> >         telling the rest of the world to disable them is the wrong
> >         approach, any
> >         such issue should be reported on this list.
> >
> >         --
> >
> >
> >
> >     Thanks for replying first of all.I guess i was mislead by the intel
> >     document.I will try out what you have said and come back to you.
> >
> >
> >     With regards,
> >
> >     S Saravanan
> >
> >                                                    Gilles.
> >
> >
> >
> > I tried out the installation following the guidelines given by xenomai
> > documents as per your advice .The details are given below:
> >
> > Xenomai-2.4.10 patched on linux 2.6.29.4,host OS-fedora 11
> >
> > while patching  xenomai gave arch as x86(Is this correct for my
> server???)
> >
> > I used the following options following options in the kernel config
> >
> > 1.Processor -Pentium Pro(Strangely newer xeon option  doesnt work
> > ..kernel doesnt boot...tried several times)
> >
> > 2.ACPI-Processor disabled
> >
> > 3.APM disabled
> >
> > 4.CPU frequency scaling disabled
> >
> > 5.Check for P4 thermal throttling interrupt disabled.(If enabled gives a
> > error while making kernel)
> >
> > 5.rest all default options.
> >
> > After installing i could boot inside xenomai kernel but when i ran
> > xeno-test program ,got worst case latency of around 88 us which is not
> > good enough.
> >
> > some other points:
> >
> > 1.Grepping dmesg showed no message "SMI chipset found"(SMI detection was
> > enabled), so my platform surely does not have SMI chipset(Is this
> > assumption correct????).
>
> please post the output of the following commands:
>
>  lspci -nn
>  cat /proc/cpuinfo
>
> Stefan
>
> >
> > 2.There are 4 UHCI USB and 2 EHCI USB embedded controllers in the
> > server.But anyway the UHCI and EHCI drivers were loaded.
> >
> > I dont know how to proceed next.Would be very helpful if you could guide
> > me on where things could be going wrong.
> >
> > Thanking you,
> >
> > With Regards,
> >
> > S Saravanan
> >
> >
> > ------------------------------------------------------------------------
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
>


First of all Thank you stefan for also helping out.Today I was going through
the various options in the system set up of the server when I stumbled upon
power management option.It was set to Active Power Controller.I set it to OS
control and when i booted into xenomai and run xeno test got worst case
latency of around 8 us which is decent .So all this while i guess the ACPI
options were not being used.

This apart i think ideally latency should be around 3 us.What settings can i
change further.

Currently i am not enabling Low Latency Desktop option.Should I???

And Stefan here are the outputs you requested.I have also attached them in
text files.

lspci -nn

00:00.0 Host bridge [0600]: Intel Corporation X58 I/O Hub to ESI Port
[8086:3406] (rev 13)
00:01.0 PCI bridge [0604]: Intel Corporation X58 I/O Hub PCI Express Root
Port 1 [8086:3408] (rev 13)
00:03.0 PCI bridge [0604]: Intel Corporation X58 I/O Hub PCI Express Root
Port 3 [8086:340a] (rev 13)
00:04.0 PCI bridge [0604]: Intel Corporation X58 I/O Hub PCI Express Root
Port 4 [8086:340b] (rev 13)
00:05.0 PCI bridge [0604]: Intel Corporation X58 I/O Hub PCI Express Root
Port 5 [8086:340c] (rev 13)
00:06.0 PCI bridge [0604]: Intel Corporation X58 I/O Hub PCI Express Root
Port 6 [8086:340d] (rev 13)
00:07.0 PCI bridge [0604]: Intel Corporation X58 I/O Hub PCI Express Root
Port 7 [8086:340e] (rev 13)
00:09.0 PCI bridge [0604]: Intel Corporation X58 I/O Hub PCI Express Root
Port 9 [8086:3410] (rev 13)
00:14.0 PIC [0800]: Intel Corporation X58 I/O Hub System Management
Registers [8086:342e] (rev 13)
00:14.1 PIC [0800]: Intel Corporation X58 I/O Hub GPIO and Scratch Pad
Registers [8086:3422] (rev 13)
00:14.2 PIC [0800]: Intel Corporation X58 I/O Hub Control Status and RAS
Registers [8086:3423] (rev 13)
00:1a.0 USB Controller [0c03]: Intel Corporation 82801I (ICH9 Family) USB
UHCI Controller #4 [8086:2937] (rev 02)
00:1a.1 USB Controller [0c03]: Intel Corporation 82801I (ICH9 Family) USB
UHCI Controller #5 [8086:2938] (rev 02)
00:1a.7 USB Controller [0c03]: Intel Corporation 82801I (ICH9 Family) USB2
EHCI Controller #2 [8086:293c] (rev 02)
00:1d.0 USB Controller [0c03]: Intel Corporation 82801I (ICH9 Family) USB
UHCI Controller #1 [8086:2934] (rev 02)
00:1d.1 USB Controller [0c03]: Intel Corporation 82801I (ICH9 Family) USB
UHCI Controller #2 [8086:2935] (rev 02)
00:1d.7 USB Controller [0c03]: Intel Corporation 82801I (ICH9 Family) USB2
EHCI Controller #1 [8086:293a] (rev 02)
00:1e.0 PCI bridge [0604]: Intel Corporation 82801 PCI Bridge [8086:244e]
(rev 92)
00:1f.0 ISA bridge [0601]: Intel Corporation 82801IB (ICH9) LPC Interface
Controller [8086:2918] (rev 02)
00:1f.2 IDE interface [0101]: Intel Corporation 82801IB (ICH9) 2 port SATA
IDE Controller [8086:2921] (rev 02)
01:00.0 Ethernet controller [0200]: Broadcom Corporation NetXtreme II
BCM5709 Gigabit Ethernet [14e4:1639] (rev 20)
01:00.1 Ethernet controller [0200]: Broadcom Corporation NetXtreme II
BCM5709 Gigabit Ethernet [14e4:1639] (rev 20)
02:00.0 Ethernet controller [0200]: Broadcom Corporation NetXtreme II
BCM5709 Gigabit Ethernet [14e4:1639] (rev 20)
02:00.1 Ethernet controller [0200]: Broadcom Corporation NetXtreme II
BCM5709 Gigabit Ethernet [14e4:1639] (rev 20)
03:00.0 SCSI storage controller [0100]: LSI Logic / Symbios Logic SAS1068E
PCI-Express Fusion-MPT SAS [1000:0058] (rev 08)
08:03.0 VGA compatible controller [0300]: Matrox Graphics, Inc. MGA G200eW
WPCM450 [102b:0532] (rev 0a)

cat /proc/cpuinfo

processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 26
model name    : Intel(R) Xeon(R) CPU           E5506  @ 2.13GHz
stepping    : 5
cpu MHz        : 2127.982
cache size    : 4096 KB
physical id    : 1
siblings    : 4
core id        : 0
cpu cores    : 4
apicid        : 16
initial apicid    : 16
fdiv_bug    : no
hlt_bug        : no
f00f_bug    : no
coma_bug    : no
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx rdtscp lm
constant_tsc arch_perfmon pebs bts xtopology nonstop_tsc pni dtes64 monitor
ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 lahf_lm tpr_shadow
vnmi flexpriority ept vpid
bogomips    : 4255.96
clflush size    : 64
power management:

processor    : 1
vendor_id    : GenuineIntel
cpu family    : 6
model        : 26
model name    : Intel(R) Xeon(R) CPU           E5506  @ 2.13GHz
stepping    : 5
cpu MHz        : 2127.982
cache size    : 4096 KB
physical id    : 0
siblings    : 4
core id        : 0
cpu cores    : 4
apicid        : 0
initial apicid    : 0
fdiv_bug    : no
hlt_bug        : no
f00f_bug    : no
coma_bug    : no
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx rdtscp lm
constant_tsc arch_perfmon pebs bts xtopology nonstop_tsc pni dtes64 monitor
ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 lahf_lm tpr_shadow
vnmi flexpriority ept vpid
bogomips    : 4255.34
clflush size    : 64
power management:

processor    : 2
vendor_id    : GenuineIntel
cpu family    : 6
model        : 26
model name    : Intel(R) Xeon(R) CPU           E5506  @ 2.13GHz
stepping    : 5
cpu MHz        : 2127.982
cache size    : 4096 KB
physical id    : 1
siblings    : 4
core id        : 1
cpu cores    : 4
apicid        : 18
initial apicid    : 18
fdiv_bug    : no
hlt_bug        : no
f00f_bug    : no
coma_bug    : no
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx rdtscp lm
constant_tsc arch_perfmon pebs bts xtopology nonstop_tsc pni dtes64 monitor
ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 lahf_lm tpr_shadow
vnmi flexpriority ept vpid
bogomips    : 4255.32
clflush size    : 64
power management:

processor    : 3
vendor_id    : GenuineIntel
cpu family    : 6
model        : 26
model name    : Intel(R) Xeon(R) CPU           E5506  @ 2.13GHz
stepping    : 5
cpu MHz        : 2127.982
cache size    : 4096 KB
physical id    : 0
siblings    : 4
core id        : 1
cpu cores    : 4
apicid        : 2
initial apicid    : 2
fdiv_bug    : no
hlt_bug        : no
f00f_bug    : no
coma_bug    : no
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx rdtscp lm
constant_tsc arch_perfmon pebs bts xtopology nonstop_tsc pni dtes64 monitor
ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 lahf_lm tpr_shadow
vnmi flexpriority ept vpid
bogomips    : 4255.34
clflush size    : 64
power management:

processor    : 4
vendor_id    : GenuineIntel
cpu family    : 6
model        : 26
model name    : Intel(R) Xeon(R) CPU           E5506  @ 2.13GHz
stepping    : 5
cpu MHz        : 2127.982
cache size    : 4096 KB
physical id    : 1
siblings    : 4
core id        : 2
cpu cores    : 4
apicid        : 20
initial apicid    : 20
fdiv_bug    : no
hlt_bug        : no
f00f_bug    : no
coma_bug    : no
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx rdtscp lm
constant_tsc arch_perfmon pebs bts xtopology nonstop_tsc pni dtes64 monitor
ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 lahf_lm tpr_shadow
vnmi flexpriority ept vpid
bogomips    : 4255.32
clflush size    : 64
power management:

processor    : 5
vendor_id    : GenuineIntel
cpu family    : 6
model        : 26
model name    : Intel(R) Xeon(R) CPU           E5506  @ 2.13GHz
stepping    : 5
cpu MHz        : 2127.982
cache size    : 4096 KB
physical id    : 0
siblings    : 4
core id        : 2
cpu cores    : 4
apicid        : 4
initial apicid    : 4
fdiv_bug    : no
hlt_bug        : no
f00f_bug    : no
coma_bug    : no
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx rdtscp lm
constant_tsc arch_perfmon pebs bts xtopology nonstop_tsc pni dtes64 monitor
ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 lahf_lm tpr_shadow
vnmi flexpriority ept vpid
bogomips    : 4255.34
clflush size    : 64
power management:

processor    : 6
vendor_id    : GenuineIntel
cpu family    : 6
model        : 26
model name    : Intel(R) Xeon(R) CPU           E5506  @ 2.13GHz
stepping    : 5
cpu MHz        : 2127.982
cache size    : 4096 KB
physical id    : 1
siblings    : 4
core id        : 3
cpu cores    : 4
apicid        : 22
initial apicid    : 22
fdiv_bug    : no
hlt_bug        : no
f00f_bug    : no
coma_bug    : no
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx rdtscp lm
constant_tsc arch_perfmon pebs bts xtopology nonstop_tsc pni dtes64 monitor
ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 lahf_lm tpr_shadow
vnmi flexpriority ept vpid
bogomips    : 4255.33
clflush size    : 64
power management:

processor    : 7
vendor_id    : GenuineIntel
cpu family    : 6
model        : 26
model name    : Intel(R) Xeon(R) CPU           E5506  @ 2.13GHz
stepping    : 5
cpu MHz        : 2127.982
cache size    : 4096 KB
physical id    : 0
siblings    : 4
core id        : 3
cpu cores    : 4
apicid        : 6
initial apicid    : 6
fdiv_bug    : no
hlt_bug        : no
f00f_bug    : no
coma_bug    : no
fpu        : yes
fpu_exception    : yes
cpuid level    : 11
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx rdtscp lm
constant_tsc arch_perfmon pebs bts xtopology nonstop_tsc pni dtes64 monitor
ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 lahf_lm tpr_shadow
vnmi flexpriority ept vpid
bogomips    : 4255.34
clflush size    : 64
power management:


We also need to find out why xeon option in processor is not working.Anyway
thanks Gilles and Stefan

I wont be able to test further until next week.So will post next week

With Regards,


S Saravanan

--0016e64b04feef7a3c047d0b0365
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Jan 13, 2010 at 12:55 AM, Stefan=
 Kisdaroczi <span dir=3D"ltr">&lt;<a href=3D"mailto:kisda@domain.hid">kisda=
@hispeed.ch</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; =
padding-left: 1ex;">
Saravanan S schrieb:<br>
<div class=3D"im">&gt;<br>
&gt;<br>
&gt; On Tue, Jan 12, 2010 at 12:23 AM, Saravanan S &lt;<a href=3D"mailto:sa=
rans1987@domain.hid">sarans1987@domain.hid</a><br>
</div><div class=3D"im">&gt; &lt;mailto:<a href=3D"mailto:sarans1987@domain.hid.=
com">sarans1987@domain.hid</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 On Mon, Jan 11, 2010 at 11:56 PM, Gilles Chanteperdrix<br>
&gt; =A0 =A0 &lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.c=
hanteperdrix@domain.hid</a><br>
</div><div><div></div><div class=3D"h5">&gt; =A0 =A0 &lt;mailto:<a href=3D"=
mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&g=
t;&gt; wrote:<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Saravanan S wrote:<br>
&gt; =A0 =A0 =A0 =A0 &gt; Hi,<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; I am trying to install xenomai on a Dell Poweredg=
e server<br>
&gt; =A0 =A0 =A0 =A0 (R710).The<br>
&gt; =A0 =A0 =A0 =A0 &gt; platform details are given below:<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; Two quad Intel(8 cores) Xeon E5506@domain.hid=
mily 6,RAM-16<br>
&gt; =A0 =A0 =A0 =A0 &gt; GB,uses SAS disks through a SAS Host Bus Adapter(=
HBA).<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; Drivers for this HBA only available from fedora 1=
0 onwards.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; So I patched xenomai =A02.4.10 with linux 2.6.29.=
4 with fedora 11 as<br>
&gt; =A0 =A0 =A0 =A0 &gt; the host OS.I used fedora 11 config file.I made t=
he following<br>
&gt; =A0 =A0 =A0 =A0 changes<br>
&gt; =A0 =A0 =A0 =A0 &gt; to the config file<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; 1.In processor types and features: architecture-&=
gt;Core2/Newer Xeon,<br>
&gt; =A0 =A0 =A0 =A0 &gt; subarchitecture-&gt;Generic, thermal throttling d=
isabled,HPET support<br>
&gt; =A0 =A0 =A0 =A0 &gt; enabled<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; 2.Power management stopped.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Bad. You should enable ACPI, only CONFIG_ACPI_PROCESSO=
R should<br>
&gt; =A0 =A0 =A0 =A0 be disabled.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; 3.Support for PCI hotplug disabled.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; 4.MSI,MSI-X disabled.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 No reason to do this. If you enable these options and =
get problems,<br>
&gt; =A0 =A0 =A0 =A0 please isolate the option which causes a problem and r=
eport.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; 5.In real time subsystem all options selected.<br=
>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Please keep the default settings for a first run, veri=
fy that it<br>
&gt; =A0 =A0 =A0 =A0 works,<br>
&gt; =A0 =A0 =A0 =A0 then enable the options you want (all of them if you w=
ant), if<br>
&gt; =A0 =A0 =A0 =A0 it does<br>
&gt; =A0 =A0 =A0 =A0 not work, then isolate the option which is the cause o=
f the problem.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; 6.SMP support enabled<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; 7.MTD support disabled<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; 8.All other default options.<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; After making and installing the modules ,when i s=
elected the<br>
&gt; =A0 =A0 =A0 =A0 xenomai<br>
&gt; =A0 =A0 =A0 =A0 &gt; kernel on rebooting it didnt boot at all.There wa=
s just a blinking<br>
&gt; =A0 =A0 =A0 =A0 &gt; cursor on the screen.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Did you rebuild your OS (which is it anyway ?) initram=
fs/initrd?<br>
&gt; =A0 =A0 =A0 =A0 If you<br>
&gt; =A0 =A0 =A0 =A0 do the same procedure without activating CONFIG_IPIPE =
and<br>
&gt; =A0 =A0 =A0 =A0 CONFIG_XENOMAI, do you get<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; I referred to the following documents while insta=
lling<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; <a href=3D"http://download.intel.com/design/intar=
ch/papers/322386.pdf" target=3D"_blank">http://download.intel.com/design/in=
tarch/papers/322386.pdf</a><br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 <a href=3D"http://stud3.tuwien.ac.at/%7Ee0226686/xenom=
ai/xenomai_implementation.pdf" target=3D"_blank">http://stud3.tuwien.ac.at/=
~e0226686/xenomai/xenomai_implementation.pdf</a><br>
</div></div>&gt; =A0 =A0 =A0 =A0 &lt;<a href=3D"http://stud3.tuwien.ac.at/%=
7Ee0226686/xenomai/xenomai_implementation.pdf" target=3D"_blank">http://stu=
d3.tuwien.ac.at/%7Ee0226686/xenomai/xenomai_implementation.pdf</a>&gt;&lt;<=
a href=3D"http://stud3.tuwien.ac.at/%7Ee0226686/xenomai/xenomai_implementat=
ion.pdf" target=3D"_blank">http://stud3.tuwien.ac.at/%7Ee0226686/xenomai/xe=
nomai_implementation.pdf</a>&gt;<br>

<div class=3D"im">&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 <a href=3D"http://www.lara.ene.unb.br/%7Ephsantana/fil=
es/technotes/HowTo_Debian_Embedded.pdf" target=3D"_blank">http://www.lara.e=
ne.unb.br/~phsantana/files/technotes/HowTo_Debian_Embedded.pdf</a><br>
</div>&gt; =A0 =A0 =A0 =A0 &lt;<a href=3D"http://www.lara.ene.unb.br/%7Ephs=
antana/files/technotes/HowTo_Debian_Embedded.pdf" target=3D"_blank">http://=
www.lara.ene.unb.br/%7Ephsantana/files/technotes/HowTo_Debian_Embedded.pdf<=
/a>&gt;&lt;<a href=3D"http://www.lara.ene.unb.br/%7Ephsantana/files/technot=
es/HowTo_Debian_Embedded.pdf" target=3D"_blank">http://www.lara.ene.unb.br/=
%7Ephsantana/files/technotes/HowTo_Debian_Embedded.pdf</a>&gt;<br>

<div><div></div><div class=3D"h5">&gt;<br>
&gt; =A0 =A0 =A0 =A0 That is fine and even flattering to see that there are=
 paper about<br>
&gt; =A0 =A0 =A0 =A0 xenomai all around the web and even on intel&#39;s sit=
e. However, the<br>
&gt; =A0 =A0 =A0 =A0 website containing authoritative documentation is<br>
&gt; =A0 =A0 =A0 =A0 <a href=3D"http://www.xenomai.org" target=3D"_blank">h=
ttp://www.xenomai.org</a><br>
&gt; =A0 =A0 =A0 =A0 If something is missing there, please ask.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 I read the Intel doc for instance, it contains a lot o=
f things<br>
&gt; =A0 =A0 =A0 =A0 which are<br>
&gt; =A0 =A0 =A0 =A0 a cut and paste of Xenomai documentation, with some ad=
ded stuff,<br>
&gt; =A0 =A0 =A0 =A0 which<br>
&gt; =A0 =A0 =A0 =A0 unfortunately is quite erroneous:<br>
&gt; =A0 =A0 =A0 =A0 - Adeos is not a real-time kernel<br>
&gt; =A0 =A0 =A0 =A0 - there is no such thing as a list of linux kernels co=
mpatibles<br>
&gt; =A0 =A0 =A0 =A0 with a<br>
&gt; =A0 =A0 =A0 =A0 version of Xenomai, each version of Xenomai aims at be=
ing compatible<br>
&gt; =A0 =A0 =A0 =A0 with each versions of a Linux kernel for which a patch=
 has been<br>
&gt; =A0 =A0 =A0 =A0 issued<br>
&gt; =A0 =A0 =A0 =A0 at the time of the release. For each architecture, the=
re are several<br>
&gt; =A0 =A0 =A0 =A0 patches contained in the package, you are insured that=
 linux kernel<br>
&gt; =A0 =A0 =A0 =A0 patched with these patches compile, and that the one w=
ith the<br>
&gt; =A0 =A0 =A0 =A0 highest<br>
&gt; =A0 =A0 =A0 =A0 linux version has been tested to validate xenomai.<br>
&gt; =A0 =A0 =A0 =A0 - the list of packages to install in order to be able =
to install<br>
&gt; =A0 =A0 =A0 =A0 xenomai<br>
&gt; =A0 =A0 =A0 =A0 is extravagant. The following packages are not needed:=
<br>
&gt; =A0 =A0 =A0 =A0 rpm -ivh libgomp-4.1.2-42.el5.i386.rpm (Disk 2)<br>
&gt; =A0 =A0 =A0 =A0 rpm -ivh elfutils-libs-0.125-3.el5.i386.rpm (Disk 2)<b=
r>
&gt; =A0 =A0 =A0 =A0 rpm -ivh redhat-rpm-config-8.0.45-24.el5.noarch.rpm (D=
isk<br>
&gt; =A0 =A0 =A0 =A0 2)<br>
&gt; =A0 =A0 =A0 =A0 rpm -ivh ncurses-devel-5.5-24.20060715.i386.rpm (Disk =
2)<br>
&gt; =A0 =A0 =A0 =A0 rpm -ivh elfutils-0.125-3.el5.i386.rpm (Disk 2)<br>
&gt; =A0 =A0 =A0 =A0 rpm -ivh libstdc++-devel-4.1.2-42.el5.i386.rpm (Disk 2=
)<br>
&gt; =A0 =A0 =A0 =A0 rpm -ivh doxygen-1.4.7-1.1.i386.rpm (optional, Disk 2)=
<br>
&gt; =A0 =A0 =A0 =A0 rpm -ivh unifdef-1.171-5.fc6.i386.rpm (Disk 3)<br>
&gt; =A0 =A0 =A0 =A0 rpm -ivh rpm-build-4.4.2-48.el5.i386.rpm (Disk 3)<br>
&gt; =A0 =A0 =A0 =A0 rpm -ivh emacs-common-21.4-20.el5.i386.rpm (required f=
or<br>
&gt; =A0 =A0 =A0 =A0 emacs-nox, Disk 3)<br>
&gt; =A0 =A0 =A0 =A0 rpm -ivh emacs-nox-21.4-20.el5.i386.rpm (optional,<br>
&gt; =A0 =A0 =A0 =A0 Disk 4)<br>
&gt; =A0 =A0 =A0 =A0 - when building a linux 2.6 kernel, you do not need to=
 run make<br>
&gt; =A0 =A0 =A0 =A0 clean<br>
&gt; =A0 =A0 =A0 =A0 before building the kernel, actually, it is a waste of=
 time<br>
&gt; =A0 =A0 =A0 =A0 - the list of options to disable to run with xenomai i=
s<br>
&gt; =A0 =A0 =A0 =A0 extravagant too:<br>
&gt; =A0 =A0 =A0 =A0 you should not disable power management, you should en=
able ACPI,<br>
&gt; =A0 =A0 =A0 =A0 and the<br>
&gt; =A0 =A0 =A0 =A0 MSI and MSI-X should work<br>
&gt; =A0 =A0 =A0 =A0 CardBus should work<br>
&gt; =A0 =A0 =A0 =A0 I suspect Toshiba and Dell laptop support should work<=
br>
&gt; =A0 =A0 =A0 =A0 PCI hotplug should work<br>
&gt; =A0 =A0 =A0 =A0 MTD should work (and actually works on embedded platfo=
rms with<br>
&gt; =A0 =A0 =A0 =A0 MTD devices)<br>
&gt; =A0 =A0 =A0 =A0 Fusion MPT should work<br>
&gt; =A0 =A0 =A0 =A0 I2O should work<br>
&gt; =A0 =A0 =A0 =A0 ISDN should work<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Anyway, if you have problem when enabling these option=
s, writing<br>
&gt; =A0 =A0 =A0 =A0 a paper<br>
&gt; =A0 =A0 =A0 =A0 telling the rest of the world to disable them is the w=
rong<br>
&gt; =A0 =A0 =A0 =A0 approach, any<br>
&gt; =A0 =A0 =A0 =A0 such issue should be reported on this list.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 --<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 Thanks for replying first of all.I guess i was mislead by the =
intel<br>
&gt; =A0 =A0 document.I will try out what you have said and come back to yo=
u.<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 With regards,<br>
&gt;<br>
&gt; =A0 =A0 S Saravanan<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; I tried out the installation following the guidelines given by xenomai=
<br>
&gt; documents as per your advice .The details are given below:<br>
&gt;<br>
&gt; Xenomai-2.4.10 patched on linux 2.6.29.4,host OS-fedora 11<br>
&gt;<br>
&gt; while patching =A0xenomai gave arch as x86(Is this correct for my serv=
er???)<br>
&gt;<br>
&gt; I used the following options following options in the kernel config<br=
>
&gt;<br>
&gt; 1.Processor -Pentium Pro(Strangely newer xeon option =A0doesnt work<br=
>
&gt; ..kernel doesnt boot...tried several times)<br>
&gt;<br>
&gt; 2.ACPI-Processor disabled<br>
&gt;<br>
&gt; 3.APM disabled<br>
&gt;<br>
&gt; 4.CPU frequency scaling disabled<br>
&gt;<br>
&gt; 5.Check for P4 thermal throttling interrupt disabled.(If enabled gives=
 a<br>
&gt; error while making kernel)<br>
&gt;<br>
&gt; 5.rest all default options.<br>
&gt;<br>
&gt; After installing i could boot inside xenomai kernel but when i ran<br>
&gt; xeno-test program ,got worst case latency of around 88 us which is not=
<br>
&gt; good enough.<br>
&gt;<br>
&gt; some other points:<br>
&gt;<br>
&gt; 1.Grepping dmesg showed no message &quot;SMI chipset found&quot;(SMI d=
etection was<br>
&gt; enabled), so my platform surely does not have SMI chipset(Is this<br>
&gt; assumption correct????).<br>
<br>
</div></div>please post the output of the following commands:<br>
<br>
=A0lspci -nn<br>
=A0cat /proc/cpuinfo<br>
<br>
Stefan<br>
<div class=3D"im"><br>
&gt;<br>
&gt; 2.There are 4 UHCI USB and 2 EHCI USB embedded controllers in the<br>
&gt; server.But anyway the UHCI and EHCI drivers were loaded.<br>
&gt;<br>
&gt; I dont know how to proceed next.Would be very helpful if you could gui=
de<br>
&gt; me on where things could be going wrong.<br>
&gt;<br>
&gt; Thanking you,<br>
&gt;<br>
&gt; With Regards,<br>
&gt;<br>
&gt; S Saravanan<br>
&gt;<br>
&gt;<br>
</div>&gt; ----------------------------------------------------------------=
--------<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Xenomai-help mailing list<br>
&gt; <a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
&gt; <a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blan=
k">https://mail.gna.org/listinfo/xenomai-help</a><br></blockquote><div><br>=
<br>First of all Thank you stefan for also helping out.Today I was going th=
rough the various options in the system set up of the server when I stumble=
d upon power management option.It was set to Active Power Controller.I set =
it to OS control and when i booted into xenomai and run xeno test got worst=
 case latency of around 8 us which is decent .So all this while i guess the=
 ACPI options were not being used.<br>
<br>This apart i think ideally latency should be around 3 us.What settings =
can i change further.<br><br>Currently i am not enabling Low Latency Deskto=
p option.Should I???<br><br>And Stefan here are the outputs you requested.I=
 have also attached them in text files.<br>
<br>lspci -nn<br><br>00:00.0 Host bridge [0600]: Intel Corporation X58 I/O =
Hub to ESI Port [8086:3406] (rev 13)<br>00:01.0 PCI bridge [0604]: Intel Co=
rporation X58 I/O Hub PCI Express Root Port 1 [8086:3408] (rev 13)<br>00:03=
.0 PCI bridge [0604]: Intel Corporation X58 I/O Hub PCI Express Root Port 3=
 [8086:340a] (rev 13)<br>
00:04.0 PCI bridge [0604]: Intel Corporation X58 I/O Hub PCI Express Root P=
ort 4 [8086:340b] (rev 13)<br>00:05.0 PCI bridge [0604]: Intel Corporation =
X58 I/O Hub PCI Express Root Port 5 [8086:340c] (rev 13)<br>00:06.0 PCI bri=
dge [0604]: Intel Corporation X58 I/O Hub PCI Express Root Port 6 [8086:340=
d] (rev 13)<br>
00:07.0 PCI bridge [0604]: Intel Corporation X58 I/O Hub PCI Express Root P=
ort 7 [8086:340e] (rev 13)<br>00:09.0 PCI bridge [0604]: Intel Corporation =
X58 I/O Hub PCI Express Root Port 9 [8086:3410] (rev 13)<br>00:14.0 PIC [08=
00]: Intel Corporation X58 I/O Hub System Management Registers [8086:342e] =
(rev 13)<br>
00:14.1 PIC [0800]: Intel Corporation X58 I/O Hub GPIO and Scratch Pad Regi=
sters [8086:3422] (rev 13)<br>00:14.2 PIC [0800]: Intel Corporation X58 I/O=
 Hub Control Status and RAS Registers [8086:3423] (rev 13)<br>00:1a.0 USB C=
ontroller [0c03]: Intel Corporation 82801I (ICH9 Family) USB UHCI Controlle=
r #4 [8086:2937] (rev 02)<br>
00:1a.1 USB Controller [0c03]: Intel Corporation 82801I (ICH9 Family) USB U=
HCI Controller #5 [8086:2938] (rev 02)<br>00:1a.7 USB Controller [0c03]: In=
tel Corporation 82801I (ICH9 Family) USB2 EHCI Controller #2 [8086:293c] (r=
ev 02)<br>
00:1d.0 USB Controller [0c03]: Intel Corporation 82801I (ICH9 Family) USB U=
HCI Controller #1 [8086:2934] (rev 02)<br>00:1d.1 USB Controller [0c03]: In=
tel Corporation 82801I (ICH9 Family) USB UHCI Controller #2 [8086:2935] (re=
v 02)<br>
00:1d.7 USB Controller [0c03]: Intel Corporation 82801I (ICH9 Family) USB2 =
EHCI Controller #1 [8086:293a] (rev 02)<br>00:1e.0 PCI bridge [0604]: Intel=
 Corporation 82801 PCI Bridge [8086:244e] (rev 92)<br>00:1f.0 ISA bridge [0=
601]: Intel Corporation 82801IB (ICH9) LPC Interface Controller [8086:2918]=
 (rev 02)<br>
00:1f.2 IDE interface [0101]: Intel Corporation 82801IB (ICH9) 2 port SATA =
IDE Controller [8086:2921] (rev 02)<br>01:00.0 Ethernet controller [0200]: =
Broadcom Corporation NetXtreme II BCM5709 Gigabit Ethernet [14e4:1639] (rev=
 20)<br>
01:00.1 Ethernet controller [0200]: Broadcom Corporation NetXtreme II BCM57=
09 Gigabit Ethernet [14e4:1639] (rev 20)<br>02:00.0 Ethernet controller [02=
00]: Broadcom Corporation NetXtreme II BCM5709 Gigabit Ethernet [14e4:1639]=
 (rev 20)<br>
02:00.1 Ethernet controller [0200]: Broadcom Corporation NetXtreme II BCM57=
09 Gigabit Ethernet [14e4:1639] (rev 20)<br>03:00.0 SCSI storage controller=
 [0100]: LSI Logic / Symbios Logic SAS1068E PCI-Express Fusion-MPT SAS [100=
0:0058] (rev 08)<br>
08:03.0 VGA compatible controller [0300]: Matrox Graphics, Inc. MGA G200eW =
WPCM450 [102b:0532] (rev 0a)<br><br>cat /proc/cpuinfo<br><br>processor=A0=
=A0=A0 : 0<br>vendor_id=A0=A0=A0 : GenuineIntel<br>cpu family=A0=A0=A0 : 6<=
br>model=A0=A0=A0 =A0=A0=A0 : 26<br>
model name=A0=A0=A0 : Intel(R) Xeon(R) CPU=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E5=
506=A0 @ 2.13GHz<br>stepping=A0=A0=A0 : 5<br>cpu MHz=A0=A0=A0 =A0=A0=A0 : 2=
127.982<br>cache size=A0=A0=A0 : 4096 KB<br>physical id=A0=A0=A0 : 1<br>sib=
lings=A0=A0=A0 : 4<br>core id=A0=A0=A0 =A0=A0=A0 : 0<br>cpu cores=A0=A0=A0 =
: 4<br>
apicid=A0=A0=A0 =A0=A0=A0 : 16<br>initial apicid=A0=A0=A0 : 16<br>fdiv_bug=
=A0=A0=A0 : no<br>hlt_bug=A0=A0=A0 =A0=A0=A0 : no<br>f00f_bug=A0=A0=A0 : no=
<br>coma_bug=A0=A0=A0 : no<br>fpu=A0=A0=A0 =A0=A0=A0 : yes<br>fpu_exception=
=A0=A0=A0 : yes<br>cpuid level=A0=A0=A0 : 11<br>wp=A0=A0=A0 =A0=A0=A0 : yes=
<br>flags=A0=A0=A0 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep =
mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe=
 nx rdtscp lm constant_tsc arch_perfmon pebs bts xtopology nonstop_tsc pni =
dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 la=
hf_lm tpr_shadow vnmi flexpriority ept vpid<br>
bogomips=A0=A0=A0 : 4255.96<br>clflush size=A0=A0=A0 : 64<br>power manageme=
nt:<br><br>processor=A0=A0=A0 : 1<br>vendor_id=A0=A0=A0 : GenuineIntel<br>c=
pu family=A0=A0=A0 : 6<br>model=A0=A0=A0 =A0=A0=A0 : 26<br>model name=A0=A0=
=A0 : Intel(R) Xeon(R) CPU=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E5506=A0 @ 2.13GHz=
<br>
stepping=A0=A0=A0 : 5<br>cpu MHz=A0=A0=A0 =A0=A0=A0 : 2127.982<br>cache siz=
e=A0=A0=A0 : 4096 KB<br>physical id=A0=A0=A0 : 0<br>siblings=A0=A0=A0 : 4<b=
r>core id=A0=A0=A0 =A0=A0=A0 : 0<br>cpu cores=A0=A0=A0 : 4<br>apicid=A0=A0=
=A0 =A0=A0=A0 : 0<br>initial apicid=A0=A0=A0 : 0<br>fdiv_bug=A0=A0=A0 : no<=
br>
hlt_bug=A0=A0=A0 =A0=A0=A0 : no<br>f00f_bug=A0=A0=A0 : no<br>coma_bug=A0=A0=
=A0 : no<br>fpu=A0=A0=A0 =A0=A0=A0 : yes<br>fpu_exception=A0=A0=A0 : yes<br=
>cpuid level=A0=A0=A0 : 11<br>wp=A0=A0=A0 =A0=A0=A0 : yes<br>flags=A0=A0=A0=
 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx rdtscp lm cons=
tant_tsc arch_perfmon pebs bts xtopology nonstop_tsc pni dtes64 monitor ds_=
cpl vmx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 lahf_lm tpr_shadow v=
nmi flexpriority ept vpid<br>
bogomips=A0=A0=A0 : 4255.34<br>clflush size=A0=A0=A0 : 64<br>power manageme=
nt:<br><br>processor=A0=A0=A0 : 2<br>vendor_id=A0=A0=A0 : GenuineIntel<br>c=
pu family=A0=A0=A0 : 6<br>model=A0=A0=A0 =A0=A0=A0 : 26<br>model name=A0=A0=
=A0 : Intel(R) Xeon(R) CPU=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E5506=A0 @ 2.13GHz=
<br>
stepping=A0=A0=A0 : 5<br>cpu MHz=A0=A0=A0 =A0=A0=A0 : 2127.982<br>cache siz=
e=A0=A0=A0 : 4096 KB<br>physical id=A0=A0=A0 : 1<br>siblings=A0=A0=A0 : 4<b=
r>core id=A0=A0=A0 =A0=A0=A0 : 1<br>cpu cores=A0=A0=A0 : 4<br>apicid=A0=A0=
=A0 =A0=A0=A0 : 18<br>initial apicid=A0=A0=A0 : 18<br>fdiv_bug=A0=A0=A0 : n=
o<br>
hlt_bug=A0=A0=A0 =A0=A0=A0 : no<br>f00f_bug=A0=A0=A0 : no<br>coma_bug=A0=A0=
=A0 : no<br>fpu=A0=A0=A0 =A0=A0=A0 : yes<br>fpu_exception=A0=A0=A0 : yes<br=
>cpuid level=A0=A0=A0 : 11<br>wp=A0=A0=A0 =A0=A0=A0 : yes<br>flags=A0=A0=A0=
 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx rdtscp lm cons=
tant_tsc arch_perfmon pebs bts xtopology nonstop_tsc pni dtes64 monitor ds_=
cpl vmx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 lahf_lm tpr_shadow v=
nmi flexpriority ept vpid<br>
bogomips=A0=A0=A0 : 4255.32<br>clflush size=A0=A0=A0 : 64<br>power manageme=
nt:<br><br>processor=A0=A0=A0 : 3<br>vendor_id=A0=A0=A0 : GenuineIntel<br>c=
pu family=A0=A0=A0 : 6<br>model=A0=A0=A0 =A0=A0=A0 : 26<br>model name=A0=A0=
=A0 : Intel(R) Xeon(R) CPU=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E5506=A0 @ 2.13GHz=
<br>
stepping=A0=A0=A0 : 5<br>cpu MHz=A0=A0=A0 =A0=A0=A0 : 2127.982<br>cache siz=
e=A0=A0=A0 : 4096 KB<br>physical id=A0=A0=A0 : 0<br>siblings=A0=A0=A0 : 4<b=
r>core id=A0=A0=A0 =A0=A0=A0 : 1<br>cpu cores=A0=A0=A0 : 4<br>apicid=A0=A0=
=A0 =A0=A0=A0 : 2<br>initial apicid=A0=A0=A0 : 2<br>fdiv_bug=A0=A0=A0 : no<=
br>
hlt_bug=A0=A0=A0 =A0=A0=A0 : no<br>f00f_bug=A0=A0=A0 : no<br>coma_bug=A0=A0=
=A0 : no<br>fpu=A0=A0=A0 =A0=A0=A0 : yes<br>fpu_exception=A0=A0=A0 : yes<br=
>cpuid level=A0=A0=A0 : 11<br>wp=A0=A0=A0 =A0=A0=A0 : yes<br>flags=A0=A0=A0=
 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx rdtscp lm cons=
tant_tsc arch_perfmon pebs bts xtopology nonstop_tsc pni dtes64 monitor ds_=
cpl vmx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 lahf_lm tpr_shadow v=
nmi flexpriority ept vpid<br>
bogomips=A0=A0=A0 : 4255.34<br>clflush size=A0=A0=A0 : 64<br>power manageme=
nt:<br><br>processor=A0=A0=A0 : 4<br>vendor_id=A0=A0=A0 : GenuineIntel<br>c=
pu family=A0=A0=A0 : 6<br>model=A0=A0=A0 =A0=A0=A0 : 26<br>model name=A0=A0=
=A0 : Intel(R) Xeon(R) CPU=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E5506=A0 @ 2.13GHz=
<br>
stepping=A0=A0=A0 : 5<br>cpu MHz=A0=A0=A0 =A0=A0=A0 : 2127.982<br>cache siz=
e=A0=A0=A0 : 4096 KB<br>physical id=A0=A0=A0 : 1<br>siblings=A0=A0=A0 : 4<b=
r>core id=A0=A0=A0 =A0=A0=A0 : 2<br>cpu cores=A0=A0=A0 : 4<br>apicid=A0=A0=
=A0 =A0=A0=A0 : 20<br>initial apicid=A0=A0=A0 : 20<br>fdiv_bug=A0=A0=A0 : n=
o<br>
hlt_bug=A0=A0=A0 =A0=A0=A0 : no<br>f00f_bug=A0=A0=A0 : no<br>coma_bug=A0=A0=
=A0 : no<br>fpu=A0=A0=A0 =A0=A0=A0 : yes<br>fpu_exception=A0=A0=A0 : yes<br=
>cpuid level=A0=A0=A0 : 11<br>wp=A0=A0=A0 =A0=A0=A0 : yes<br>flags=A0=A0=A0=
 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx rdtscp lm cons=
tant_tsc arch_perfmon pebs bts xtopology nonstop_tsc pni dtes64 monitor ds_=
cpl vmx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 lahf_lm tpr_shadow v=
nmi flexpriority ept vpid<br>
bogomips=A0=A0=A0 : 4255.32<br>clflush size=A0=A0=A0 : 64<br>power manageme=
nt:<br><br>processor=A0=A0=A0 : 5<br>vendor_id=A0=A0=A0 : GenuineIntel<br>c=
pu family=A0=A0=A0 : 6<br>model=A0=A0=A0 =A0=A0=A0 : 26<br>model name=A0=A0=
=A0 : Intel(R) Xeon(R) CPU=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E5506=A0 @ 2.13GHz=
<br>
stepping=A0=A0=A0 : 5<br>cpu MHz=A0=A0=A0 =A0=A0=A0 : 2127.982<br>cache siz=
e=A0=A0=A0 : 4096 KB<br>physical id=A0=A0=A0 : 0<br>siblings=A0=A0=A0 : 4<b=
r>core id=A0=A0=A0 =A0=A0=A0 : 2<br>cpu cores=A0=A0=A0 : 4<br>apicid=A0=A0=
=A0 =A0=A0=A0 : 4<br>initial apicid=A0=A0=A0 : 4<br>fdiv_bug=A0=A0=A0 : no<=
br>
hlt_bug=A0=A0=A0 =A0=A0=A0 : no<br>f00f_bug=A0=A0=A0 : no<br>coma_bug=A0=A0=
=A0 : no<br>fpu=A0=A0=A0 =A0=A0=A0 : yes<br>fpu_exception=A0=A0=A0 : yes<br=
>cpuid level=A0=A0=A0 : 11<br>wp=A0=A0=A0 =A0=A0=A0 : yes<br>flags=A0=A0=A0=
 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx rdtscp lm cons=
tant_tsc arch_perfmon pebs bts xtopology nonstop_tsc pni dtes64 monitor ds_=
cpl vmx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 lahf_lm tpr_shadow v=
nmi flexpriority ept vpid<br>
bogomips=A0=A0=A0 : 4255.34<br>clflush size=A0=A0=A0 : 64<br>power manageme=
nt:<br><br>processor=A0=A0=A0 : 6<br>vendor_id=A0=A0=A0 : GenuineIntel<br>c=
pu family=A0=A0=A0 : 6<br>model=A0=A0=A0 =A0=A0=A0 : 26<br>model name=A0=A0=
=A0 : Intel(R) Xeon(R) CPU=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E5506=A0 @ 2.13GHz=
<br>
stepping=A0=A0=A0 : 5<br>cpu MHz=A0=A0=A0 =A0=A0=A0 : 2127.982<br>cache siz=
e=A0=A0=A0 : 4096 KB<br>physical id=A0=A0=A0 : 1<br>siblings=A0=A0=A0 : 4<b=
r>core id=A0=A0=A0 =A0=A0=A0 : 3<br>cpu cores=A0=A0=A0 : 4<br>apicid=A0=A0=
=A0 =A0=A0=A0 : 22<br>initial apicid=A0=A0=A0 : 22<br>fdiv_bug=A0=A0=A0 : n=
o<br>
hlt_bug=A0=A0=A0 =A0=A0=A0 : no<br>f00f_bug=A0=A0=A0 : no<br>coma_bug=A0=A0=
=A0 : no<br>fpu=A0=A0=A0 =A0=A0=A0 : yes<br>fpu_exception=A0=A0=A0 : yes<br=
>cpuid level=A0=A0=A0 : 11<br>wp=A0=A0=A0 =A0=A0=A0 : yes<br>flags=A0=A0=A0=
 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx rdtscp lm cons=
tant_tsc arch_perfmon pebs bts xtopology nonstop_tsc pni dtes64 monitor ds_=
cpl vmx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 lahf_lm tpr_shadow v=
nmi flexpriority ept vpid<br>
bogomips=A0=A0=A0 : 4255.33<br>clflush size=A0=A0=A0 : 64<br>power manageme=
nt:<br><br>processor=A0=A0=A0 : 7<br>vendor_id=A0=A0=A0 : GenuineIntel<br>c=
pu family=A0=A0=A0 : 6<br>model=A0=A0=A0 =A0=A0=A0 : 26<br>model name=A0=A0=
=A0 : Intel(R) Xeon(R) CPU=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 E5506=A0 @ 2.13GHz=
<br>
stepping=A0=A0=A0 : 5<br>cpu MHz=A0=A0=A0 =A0=A0=A0 : 2127.982<br>cache siz=
e=A0=A0=A0 : 4096 KB<br>physical id=A0=A0=A0 : 0<br>siblings=A0=A0=A0 : 4<b=
r>core id=A0=A0=A0 =A0=A0=A0 : 3<br>cpu cores=A0=A0=A0 : 4<br>apicid=A0=A0=
=A0 =A0=A0=A0 : 6<br>initial apicid=A0=A0=A0 : 6<br>fdiv_bug=A0=A0=A0 : no<=
br>
hlt_bug=A0=A0=A0 =A0=A0=A0 : no<br>f00f_bug=A0=A0=A0 : no<br>coma_bug=A0=A0=
=A0 : no<br>fpu=A0=A0=A0 =A0=A0=A0 : yes<br>fpu_exception=A0=A0=A0 : yes<br=
>cpuid level=A0=A0=A0 : 11<br>wp=A0=A0=A0 =A0=A0=A0 : yes<br>flags=A0=A0=A0=
 =A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx rdtscp lm cons=
tant_tsc arch_perfmon pebs bts xtopology nonstop_tsc pni dtes64 monitor ds_=
cpl vmx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 lahf_lm tpr_shadow v=
nmi flexpriority ept vpid<br>
bogomips=A0=A0=A0 : 4255.34<br>clflush size=A0=A0=A0 : 64<br>power manageme=
nt:<br><br><br>We also need to find out why xeon option in processor is not=
 working.Anyway thanks Gilles and Stefan <br><br>I wont be able to test fur=
ther until next week.So will post next week<br>
<br>With Regards,<br><br><br>S Saravanan <br></div></div><br>

--0016e64b04feef7a3c047d0b0365--

--0016e64b04feef7a46047d0b0367
Content-Type: text/plain; charset=US-ASCII; name="lspci.txt"
Content-Disposition: attachment; filename="lspci.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g4e3gsxf0

MDA6MDAuMCBIb3N0IGJyaWRnZSBbMDYwMF06IEludGVsIENvcnBvcmF0aW9uIFg1OCBJL08gSHVi
IHRvIEVTSSBQb3J0IFs4MDg2OjM0MDZdIChyZXYgMTMpCjAwOjAxLjAgUENJIGJyaWRnZSBbMDYw
NF06IEludGVsIENvcnBvcmF0aW9uIFg1OCBJL08gSHViIFBDSSBFeHByZXNzIFJvb3QgUG9ydCAx
IFs4MDg2OjM0MDhdIChyZXYgMTMpCjAwOjAzLjAgUENJIGJyaWRnZSBbMDYwNF06IEludGVsIENv
cnBvcmF0aW9uIFg1OCBJL08gSHViIFBDSSBFeHByZXNzIFJvb3QgUG9ydCAzIFs4MDg2OjM0MGFd
IChyZXYgMTMpCjAwOjA0LjAgUENJIGJyaWRnZSBbMDYwNF06IEludGVsIENvcnBvcmF0aW9uIFg1
OCBJL08gSHViIFBDSSBFeHByZXNzIFJvb3QgUG9ydCA0IFs4MDg2OjM0MGJdIChyZXYgMTMpCjAw
OjA1LjAgUENJIGJyaWRnZSBbMDYwNF06IEludGVsIENvcnBvcmF0aW9uIFg1OCBJL08gSHViIFBD
SSBFeHByZXNzIFJvb3QgUG9ydCA1IFs4MDg2OjM0MGNdIChyZXYgMTMpCjAwOjA2LjAgUENJIGJy
aWRnZSBbMDYwNF06IEludGVsIENvcnBvcmF0aW9uIFg1OCBJL08gSHViIFBDSSBFeHByZXNzIFJv
b3QgUG9ydCA2IFs4MDg2OjM0MGRdIChyZXYgMTMpCjAwOjA3LjAgUENJIGJyaWRnZSBbMDYwNF06
IEludGVsIENvcnBvcmF0aW9uIFg1OCBJL08gSHViIFBDSSBFeHByZXNzIFJvb3QgUG9ydCA3IFs4
MDg2OjM0MGVdIChyZXYgMTMpCjAwOjA5LjAgUENJIGJyaWRnZSBbMDYwNF06IEludGVsIENvcnBv
cmF0aW9uIFg1OCBJL08gSHViIFBDSSBFeHByZXNzIFJvb3QgUG9ydCA5IFs4MDg2OjM0MTBdIChy
ZXYgMTMpCjAwOjE0LjAgUElDIFswODAwXTogSW50ZWwgQ29ycG9yYXRpb24gWDU4IEkvTyBIdWIg
U3lzdGVtIE1hbmFnZW1lbnQgUmVnaXN0ZXJzIFs4MDg2OjM0MmVdIChyZXYgMTMpCjAwOjE0LjEg
UElDIFswODAwXTogSW50ZWwgQ29ycG9yYXRpb24gWDU4IEkvTyBIdWIgR1BJTyBhbmQgU2NyYXRj
aCBQYWQgUmVnaXN0ZXJzIFs4MDg2OjM0MjJdIChyZXYgMTMpCjAwOjE0LjIgUElDIFswODAwXTog
SW50ZWwgQ29ycG9yYXRpb24gWDU4IEkvTyBIdWIgQ29udHJvbCBTdGF0dXMgYW5kIFJBUyBSZWdp
c3RlcnMgWzgwODY6MzQyM10gKHJldiAxMykKMDA6MWEuMCBVU0IgQ29udHJvbGxlciBbMGMwM106
IEludGVsIENvcnBvcmF0aW9uIDgyODAxSSAoSUNIOSBGYW1pbHkpIFVTQiBVSENJIENvbnRyb2xs
ZXIgIzQgWzgwODY6MjkzN10gKHJldiAwMikKMDA6MWEuMSBVU0IgQ29udHJvbGxlciBbMGMwM106
IEludGVsIENvcnBvcmF0aW9uIDgyODAxSSAoSUNIOSBGYW1pbHkpIFVTQiBVSENJIENvbnRyb2xs
ZXIgIzUgWzgwODY6MjkzOF0gKHJldiAwMikKMDA6MWEuNyBVU0IgQ29udHJvbGxlciBbMGMwM106
IEludGVsIENvcnBvcmF0aW9uIDgyODAxSSAoSUNIOSBGYW1pbHkpIFVTQjIgRUhDSSBDb250cm9s
bGVyICMyIFs4MDg2OjI5M2NdIChyZXYgMDIpCjAwOjFkLjAgVVNCIENvbnRyb2xsZXIgWzBjMDNd
OiBJbnRlbCBDb3Jwb3JhdGlvbiA4MjgwMUkgKElDSDkgRmFtaWx5KSBVU0IgVUhDSSBDb250cm9s
bGVyICMxIFs4MDg2OjI5MzRdIChyZXYgMDIpCjAwOjFkLjEgVVNCIENvbnRyb2xsZXIgWzBjMDNd
OiBJbnRlbCBDb3Jwb3JhdGlvbiA4MjgwMUkgKElDSDkgRmFtaWx5KSBVU0IgVUhDSSBDb250cm9s
bGVyICMyIFs4MDg2OjI5MzVdIChyZXYgMDIpCjAwOjFkLjcgVVNCIENvbnRyb2xsZXIgWzBjMDNd
OiBJbnRlbCBDb3Jwb3JhdGlvbiA4MjgwMUkgKElDSDkgRmFtaWx5KSBVU0IyIEVIQ0kgQ29udHJv
bGxlciAjMSBbODA4NjoyOTNhXSAocmV2IDAyKQowMDoxZS4wIFBDSSBicmlkZ2UgWzA2MDRdOiBJ
bnRlbCBDb3Jwb3JhdGlvbiA4MjgwMSBQQ0kgQnJpZGdlIFs4MDg2OjI0NGVdIChyZXYgOTIpCjAw
OjFmLjAgSVNBIGJyaWRnZSBbMDYwMV06IEludGVsIENvcnBvcmF0aW9uIDgyODAxSUIgKElDSDkp
IExQQyBJbnRlcmZhY2UgQ29udHJvbGxlciBbODA4NjoyOTE4XSAocmV2IDAyKQowMDoxZi4yIElE
RSBpbnRlcmZhY2UgWzAxMDFdOiBJbnRlbCBDb3Jwb3JhdGlvbiA4MjgwMUlCIChJQ0g5KSAyIHBv
cnQgU0FUQSBJREUgQ29udHJvbGxlciBbODA4NjoyOTIxXSAocmV2IDAyKQowMTowMC4wIEV0aGVy
bmV0IGNvbnRyb2xsZXIgWzAyMDBdOiBCcm9hZGNvbSBDb3Jwb3JhdGlvbiBOZXRYdHJlbWUgSUkg
QkNNNTcwOSBHaWdhYml0IEV0aGVybmV0IFsxNGU0OjE2MzldIChyZXYgMjApCjAxOjAwLjEgRXRo
ZXJuZXQgY29udHJvbGxlciBbMDIwMF06IEJyb2FkY29tIENvcnBvcmF0aW9uIE5ldFh0cmVtZSBJ
SSBCQ001NzA5IEdpZ2FiaXQgRXRoZXJuZXQgWzE0ZTQ6MTYzOV0gKHJldiAyMCkKMDI6MDAuMCBF
dGhlcm5ldCBjb250cm9sbGVyIFswMjAwXTogQnJvYWRjb20gQ29ycG9yYXRpb24gTmV0WHRyZW1l
IElJIEJDTTU3MDkgR2lnYWJpdCBFdGhlcm5ldCBbMTRlNDoxNjM5XSAocmV2IDIwKQowMjowMC4x
IEV0aGVybmV0IGNvbnRyb2xsZXIgWzAyMDBdOiBCcm9hZGNvbSBDb3Jwb3JhdGlvbiBOZXRYdHJl
bWUgSUkgQkNNNTcwOSBHaWdhYml0IEV0aGVybmV0IFsxNGU0OjE2MzldIChyZXYgMjApCjAzOjAw
LjAgU0NTSSBzdG9yYWdlIGNvbnRyb2xsZXIgWzAxMDBdOiBMU0kgTG9naWMgLyBTeW1iaW9zIExv
Z2ljIFNBUzEwNjhFIFBDSS1FeHByZXNzIEZ1c2lvbi1NUFQgU0FTIFsxMDAwOjAwNThdIChyZXYg
MDgpCjA4OjAzLjAgVkdBIGNvbXBhdGlibGUgY29udHJvbGxlciBbMDMwMF06IE1hdHJveCBHcmFw
aGljcywgSW5jLiBNR0EgRzIwMGVXIFdQQ000NTAgWzEwMmI6MDUzMl0gKHJldiAwYSkK
--0016e64b04feef7a46047d0b0367
Content-Type: text/plain; charset=US-ASCII; name="cpuinfo.txt"
Content-Disposition: attachment; filename="cpuinfo.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g4e3gzpo1

cHJvY2Vzc29yCTogMAp2ZW5kb3JfaWQJOiBHZW51aW5lSW50ZWwKY3B1IGZhbWlseQk6IDYKbW9k
ZWwJCTogMjYKbW9kZWwgbmFtZQk6IEludGVsKFIpIFhlb24oUikgQ1BVICAgICAgICAgICBFNTUw
NiAgQCAyLjEzR0h6CnN0ZXBwaW5nCTogNQpjcHUgTUh6CQk6IDIxMjcuOTgyCmNhY2hlIHNpemUJ
OiA0MDk2IEtCCnBoeXNpY2FsIGlkCTogMQpzaWJsaW5ncwk6IDQKY29yZSBpZAkJOiAwCmNwdSBj
b3Jlcwk6IDQKYXBpY2lkCQk6IDE2CmluaXRpYWwgYXBpY2lkCTogMTYKZmRpdl9idWcJOiBubwpo
bHRfYnVnCQk6IG5vCmYwMGZfYnVnCTogbm8KY29tYV9idWcJOiBubwpmcHUJCTogeWVzCmZwdV9l
eGNlcHRpb24JOiB5ZXMKY3B1aWQgbGV2ZWwJOiAxMQp3cAkJOiB5ZXMKZmxhZ3MJCTogZnB1IHZt
ZSBkZSBwc2UgdHNjIG1zciBwYWUgbWNlIGN4OCBhcGljIHNlcCBtdHJyIHBnZSBtY2EgY21vdiBw
YXQgcHNlMzYgY2xmbHVzaCBkdHMgYWNwaSBtbXggZnhzciBzc2Ugc3NlMiBzcyBodCB0bSBwYmUg
bnggcmR0c2NwIGxtIGNvbnN0YW50X3RzYyBhcmNoX3BlcmZtb24gcGVicyBidHMgeHRvcG9sb2d5
IG5vbnN0b3BfdHNjIHBuaSBkdGVzNjQgbW9uaXRvciBkc19jcGwgdm14IGVzdCB0bTIgc3NzZTMg
Y3gxNiB4dHByIHBkY20gZGNhIHNzZTRfMSBzc2U0XzIgbGFoZl9sbSB0cHJfc2hhZG93IHZubWkg
ZmxleHByaW9yaXR5IGVwdCB2cGlkCmJvZ29taXBzCTogNDI1NS45NgpjbGZsdXNoIHNpemUJOiA2
NApwb3dlciBtYW5hZ2VtZW50OgoKcHJvY2Vzc29yCTogMQp2ZW5kb3JfaWQJOiBHZW51aW5lSW50
ZWwKY3B1IGZhbWlseQk6IDYKbW9kZWwJCTogMjYKbW9kZWwgbmFtZQk6IEludGVsKFIpIFhlb24o
UikgQ1BVICAgICAgICAgICBFNTUwNiAgQCAyLjEzR0h6CnN0ZXBwaW5nCTogNQpjcHUgTUh6CQk6
IDIxMjcuOTgyCmNhY2hlIHNpemUJOiA0MDk2IEtCCnBoeXNpY2FsIGlkCTogMApzaWJsaW5ncwk6
IDQKY29yZSBpZAkJOiAwCmNwdSBjb3Jlcwk6IDQKYXBpY2lkCQk6IDAKaW5pdGlhbCBhcGljaWQJ
OiAwCmZkaXZfYnVnCTogbm8KaGx0X2J1ZwkJOiBubwpmMDBmX2J1Zwk6IG5vCmNvbWFfYnVnCTog
bm8KZnB1CQk6IHllcwpmcHVfZXhjZXB0aW9uCTogeWVzCmNwdWlkIGxldmVsCTogMTEKd3AJCTog
eWVzCmZsYWdzCQk6IGZwdSB2bWUgZGUgcHNlIHRzYyBtc3IgcGFlIG1jZSBjeDggYXBpYyBzZXAg
bXRyciBwZ2UgbWNhIGNtb3YgcGF0IHBzZTM2IGNsZmx1c2ggZHRzIGFjcGkgbW14IGZ4c3Igc3Nl
IHNzZTIgc3MgaHQgdG0gcGJlIG54IHJkdHNjcCBsbSBjb25zdGFudF90c2MgYXJjaF9wZXJmbW9u
IHBlYnMgYnRzIHh0b3BvbG9neSBub25zdG9wX3RzYyBwbmkgZHRlczY0IG1vbml0b3IgZHNfY3Bs
IHZteCBlc3QgdG0yIHNzc2UzIGN4MTYgeHRwciBwZGNtIGRjYSBzc2U0XzEgc3NlNF8yIGxhaGZf
bG0gdHByX3NoYWRvdyB2bm1pIGZsZXhwcmlvcml0eSBlcHQgdnBpZApib2dvbWlwcwk6IDQyNTUu
MzQKY2xmbHVzaCBzaXplCTogNjQKcG93ZXIgbWFuYWdlbWVudDoKCnByb2Nlc3Nvcgk6IDIKdmVu
ZG9yX2lkCTogR2VudWluZUludGVsCmNwdSBmYW1pbHkJOiA2Cm1vZGVsCQk6IDI2Cm1vZGVsIG5h
bWUJOiBJbnRlbChSKSBYZW9uKFIpIENQVSAgICAgICAgICAgRTU1MDYgIEAgMi4xM0dIegpzdGVw
cGluZwk6IDUKY3B1IE1IegkJOiAyMTI3Ljk4MgpjYWNoZSBzaXplCTogNDA5NiBLQgpwaHlzaWNh
bCBpZAk6IDEKc2libGluZ3MJOiA0CmNvcmUgaWQJCTogMQpjcHUgY29yZXMJOiA0CmFwaWNpZAkJ
OiAxOAppbml0aWFsIGFwaWNpZAk6IDE4CmZkaXZfYnVnCTogbm8KaGx0X2J1ZwkJOiBubwpmMDBm
X2J1Zwk6IG5vCmNvbWFfYnVnCTogbm8KZnB1CQk6IHllcwpmcHVfZXhjZXB0aW9uCTogeWVzCmNw
dWlkIGxldmVsCTogMTEKd3AJCTogeWVzCmZsYWdzCQk6IGZwdSB2bWUgZGUgcHNlIHRzYyBtc3Ig
cGFlIG1jZSBjeDggYXBpYyBzZXAgbXRyciBwZ2UgbWNhIGNtb3YgcGF0IHBzZTM2IGNsZmx1c2gg
ZHRzIGFjcGkgbW14IGZ4c3Igc3NlIHNzZTIgc3MgaHQgdG0gcGJlIG54IHJkdHNjcCBsbSBjb25z
dGFudF90c2MgYXJjaF9wZXJmbW9uIHBlYnMgYnRzIHh0b3BvbG9neSBub25zdG9wX3RzYyBwbmkg
ZHRlczY0IG1vbml0b3IgZHNfY3BsIHZteCBlc3QgdG0yIHNzc2UzIGN4MTYgeHRwciBwZGNtIGRj
YSBzc2U0XzEgc3NlNF8yIGxhaGZfbG0gdHByX3NoYWRvdyB2bm1pIGZsZXhwcmlvcml0eSBlcHQg
dnBpZApib2dvbWlwcwk6IDQyNTUuMzIKY2xmbHVzaCBzaXplCTogNjQKcG93ZXIgbWFuYWdlbWVu
dDoKCnByb2Nlc3Nvcgk6IDMKdmVuZG9yX2lkCTogR2VudWluZUludGVsCmNwdSBmYW1pbHkJOiA2
Cm1vZGVsCQk6IDI2Cm1vZGVsIG5hbWUJOiBJbnRlbChSKSBYZW9uKFIpIENQVSAgICAgICAgICAg
RTU1MDYgIEAgMi4xM0dIegpzdGVwcGluZwk6IDUKY3B1IE1IegkJOiAyMTI3Ljk4MgpjYWNoZSBz
aXplCTogNDA5NiBLQgpwaHlzaWNhbCBpZAk6IDAKc2libGluZ3MJOiA0CmNvcmUgaWQJCTogMQpj
cHUgY29yZXMJOiA0CmFwaWNpZAkJOiAyCmluaXRpYWwgYXBpY2lkCTogMgpmZGl2X2J1Zwk6IG5v
CmhsdF9idWcJCTogbm8KZjAwZl9idWcJOiBubwpjb21hX2J1Zwk6IG5vCmZwdQkJOiB5ZXMKZnB1
X2V4Y2VwdGlvbgk6IHllcwpjcHVpZCBsZXZlbAk6IDExCndwCQk6IHllcwpmbGFncwkJOiBmcHUg
dm1lIGRlIHBzZSB0c2MgbXNyIHBhZSBtY2UgY3g4IGFwaWMgc2VwIG10cnIgcGdlIG1jYSBjbW92
IHBhdCBwc2UzNiBjbGZsdXNoIGR0cyBhY3BpIG1teCBmeHNyIHNzZSBzc2UyIHNzIGh0IHRtIHBi
ZSBueCByZHRzY3AgbG0gY29uc3RhbnRfdHNjIGFyY2hfcGVyZm1vbiBwZWJzIGJ0cyB4dG9wb2xv
Z3kgbm9uc3RvcF90c2MgcG5pIGR0ZXM2NCBtb25pdG9yIGRzX2NwbCB2bXggZXN0IHRtMiBzc3Nl
MyBjeDE2IHh0cHIgcGRjbSBkY2Egc3NlNF8xIHNzZTRfMiBsYWhmX2xtIHRwcl9zaGFkb3cgdm5t
aSBmbGV4cHJpb3JpdHkgZXB0IHZwaWQKYm9nb21pcHMJOiA0MjU1LjM0CmNsZmx1c2ggc2l6ZQk6
IDY0CnBvd2VyIG1hbmFnZW1lbnQ6Cgpwcm9jZXNzb3IJOiA0CnZlbmRvcl9pZAk6IEdlbnVpbmVJ
bnRlbApjcHUgZmFtaWx5CTogNgptb2RlbAkJOiAyNgptb2RlbCBuYW1lCTogSW50ZWwoUikgWGVv
bihSKSBDUFUgICAgICAgICAgIEU1NTA2ICBAIDIuMTNHSHoKc3RlcHBpbmcJOiA1CmNwdSBNSHoJ
CTogMjEyNy45ODIKY2FjaGUgc2l6ZQk6IDQwOTYgS0IKcGh5c2ljYWwgaWQJOiAxCnNpYmxpbmdz
CTogNApjb3JlIGlkCQk6IDIKY3B1IGNvcmVzCTogNAphcGljaWQJCTogMjAKaW5pdGlhbCBhcGlj
aWQJOiAyMApmZGl2X2J1Zwk6IG5vCmhsdF9idWcJCTogbm8KZjAwZl9idWcJOiBubwpjb21hX2J1
Zwk6IG5vCmZwdQkJOiB5ZXMKZnB1X2V4Y2VwdGlvbgk6IHllcwpjcHVpZCBsZXZlbAk6IDExCndw
CQk6IHllcwpmbGFncwkJOiBmcHUgdm1lIGRlIHBzZSB0c2MgbXNyIHBhZSBtY2UgY3g4IGFwaWMg
c2VwIG10cnIgcGdlIG1jYSBjbW92IHBhdCBwc2UzNiBjbGZsdXNoIGR0cyBhY3BpIG1teCBmeHNy
IHNzZSBzc2UyIHNzIGh0IHRtIHBiZSBueCByZHRzY3AgbG0gY29uc3RhbnRfdHNjIGFyY2hfcGVy
Zm1vbiBwZWJzIGJ0cyB4dG9wb2xvZ3kgbm9uc3RvcF90c2MgcG5pIGR0ZXM2NCBtb25pdG9yIGRz
X2NwbCB2bXggZXN0IHRtMiBzc3NlMyBjeDE2IHh0cHIgcGRjbSBkY2Egc3NlNF8xIHNzZTRfMiBs
YWhmX2xtIHRwcl9zaGFkb3cgdm5taSBmbGV4cHJpb3JpdHkgZXB0IHZwaWQKYm9nb21pcHMJOiA0
MjU1LjMyCmNsZmx1c2ggc2l6ZQk6IDY0CnBvd2VyIG1hbmFnZW1lbnQ6Cgpwcm9jZXNzb3IJOiA1
CnZlbmRvcl9pZAk6IEdlbnVpbmVJbnRlbApjcHUgZmFtaWx5CTogNgptb2RlbAkJOiAyNgptb2Rl
bCBuYW1lCTogSW50ZWwoUikgWGVvbihSKSBDUFUgICAgICAgICAgIEU1NTA2ICBAIDIuMTNHSHoK
c3RlcHBpbmcJOiA1CmNwdSBNSHoJCTogMjEyNy45ODIKY2FjaGUgc2l6ZQk6IDQwOTYgS0IKcGh5
c2ljYWwgaWQJOiAwCnNpYmxpbmdzCTogNApjb3JlIGlkCQk6IDIKY3B1IGNvcmVzCTogNAphcGlj
aWQJCTogNAppbml0aWFsIGFwaWNpZAk6IDQKZmRpdl9idWcJOiBubwpobHRfYnVnCQk6IG5vCmYw
MGZfYnVnCTogbm8KY29tYV9idWcJOiBubwpmcHUJCTogeWVzCmZwdV9leGNlcHRpb24JOiB5ZXMK
Y3B1aWQgbGV2ZWwJOiAxMQp3cAkJOiB5ZXMKZmxhZ3MJCTogZnB1IHZtZSBkZSBwc2UgdHNjIG1z
ciBwYWUgbWNlIGN4OCBhcGljIHNlcCBtdHJyIHBnZSBtY2EgY21vdiBwYXQgcHNlMzYgY2xmbHVz
aCBkdHMgYWNwaSBtbXggZnhzciBzc2Ugc3NlMiBzcyBodCB0bSBwYmUgbnggcmR0c2NwIGxtIGNv
bnN0YW50X3RzYyBhcmNoX3BlcmZtb24gcGVicyBidHMgeHRvcG9sb2d5IG5vbnN0b3BfdHNjIHBu
aSBkdGVzNjQgbW9uaXRvciBkc19jcGwgdm14IGVzdCB0bTIgc3NzZTMgY3gxNiB4dHByIHBkY20g
ZGNhIHNzZTRfMSBzc2U0XzIgbGFoZl9sbSB0cHJfc2hhZG93IHZubWkgZmxleHByaW9yaXR5IGVw
dCB2cGlkCmJvZ29taXBzCTogNDI1NS4zNApjbGZsdXNoIHNpemUJOiA2NApwb3dlciBtYW5hZ2Vt
ZW50OgoKcHJvY2Vzc29yCTogNgp2ZW5kb3JfaWQJOiBHZW51aW5lSW50ZWwKY3B1IGZhbWlseQk6
IDYKbW9kZWwJCTogMjYKbW9kZWwgbmFtZQk6IEludGVsKFIpIFhlb24oUikgQ1BVICAgICAgICAg
ICBFNTUwNiAgQCAyLjEzR0h6CnN0ZXBwaW5nCTogNQpjcHUgTUh6CQk6IDIxMjcuOTgyCmNhY2hl
IHNpemUJOiA0MDk2IEtCCnBoeXNpY2FsIGlkCTogMQpzaWJsaW5ncwk6IDQKY29yZSBpZAkJOiAz
CmNwdSBjb3Jlcwk6IDQKYXBpY2lkCQk6IDIyCmluaXRpYWwgYXBpY2lkCTogMjIKZmRpdl9idWcJ
OiBubwpobHRfYnVnCQk6IG5vCmYwMGZfYnVnCTogbm8KY29tYV9idWcJOiBubwpmcHUJCTogeWVz
CmZwdV9leGNlcHRpb24JOiB5ZXMKY3B1aWQgbGV2ZWwJOiAxMQp3cAkJOiB5ZXMKZmxhZ3MJCTog
ZnB1IHZtZSBkZSBwc2UgdHNjIG1zciBwYWUgbWNlIGN4OCBhcGljIHNlcCBtdHJyIHBnZSBtY2Eg
Y21vdiBwYXQgcHNlMzYgY2xmbHVzaCBkdHMgYWNwaSBtbXggZnhzciBzc2Ugc3NlMiBzcyBodCB0
bSBwYmUgbnggcmR0c2NwIGxtIGNvbnN0YW50X3RzYyBhcmNoX3BlcmZtb24gcGVicyBidHMgeHRv
cG9sb2d5IG5vbnN0b3BfdHNjIHBuaSBkdGVzNjQgbW9uaXRvciBkc19jcGwgdm14IGVzdCB0bTIg
c3NzZTMgY3gxNiB4dHByIHBkY20gZGNhIHNzZTRfMSBzc2U0XzIgbGFoZl9sbSB0cHJfc2hhZG93
IHZubWkgZmxleHByaW9yaXR5IGVwdCB2cGlkCmJvZ29taXBzCTogNDI1NS4zMwpjbGZsdXNoIHNp
emUJOiA2NApwb3dlciBtYW5hZ2VtZW50OgoKcHJvY2Vzc29yCTogNwp2ZW5kb3JfaWQJOiBHZW51
aW5lSW50ZWwKY3B1IGZhbWlseQk6IDYKbW9kZWwJCTogMjYKbW9kZWwgbmFtZQk6IEludGVsKFIp
IFhlb24oUikgQ1BVICAgICAgICAgICBFNTUwNiAgQCAyLjEzR0h6CnN0ZXBwaW5nCTogNQpjcHUg
TUh6CQk6IDIxMjcuOTgyCmNhY2hlIHNpemUJOiA0MDk2IEtCCnBoeXNpY2FsIGlkCTogMApzaWJs
aW5ncwk6IDQKY29yZSBpZAkJOiAzCmNwdSBjb3Jlcwk6IDQKYXBpY2lkCQk6IDYKaW5pdGlhbCBh
cGljaWQJOiA2CmZkaXZfYnVnCTogbm8KaGx0X2J1ZwkJOiBubwpmMDBmX2J1Zwk6IG5vCmNvbWFf
YnVnCTogbm8KZnB1CQk6IHllcwpmcHVfZXhjZXB0aW9uCTogeWVzCmNwdWlkIGxldmVsCTogMTEK
d3AJCTogeWVzCmZsYWdzCQk6IGZwdSB2bWUgZGUgcHNlIHRzYyBtc3IgcGFlIG1jZSBjeDggYXBp
YyBzZXAgbXRyciBwZ2UgbWNhIGNtb3YgcGF0IHBzZTM2IGNsZmx1c2ggZHRzIGFjcGkgbW14IGZ4
c3Igc3NlIHNzZTIgc3MgaHQgdG0gcGJlIG54IHJkdHNjcCBsbSBjb25zdGFudF90c2MgYXJjaF9w
ZXJmbW9uIHBlYnMgYnRzIHh0b3BvbG9neSBub25zdG9wX3RzYyBwbmkgZHRlczY0IG1vbml0b3Ig
ZHNfY3BsIHZteCBlc3QgdG0yIHNzc2UzIGN4MTYgeHRwciBwZGNtIGRjYSBzc2U0XzEgc3NlNF8y
IGxhaGZfbG0gdHByX3NoYWRvdyB2bm1pIGZsZXhwcmlvcml0eSBlcHQgdnBpZApib2dvbWlwcwk6
IDQyNTUuMzQKY2xmbHVzaCBzaXplCTogNjQKcG93ZXIgbWFuYWdlbWVudDoKCg==
--0016e64b04feef7a46047d0b0367--

