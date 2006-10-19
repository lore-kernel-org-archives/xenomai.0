Subject: Re: [Xenomai-core] kernel panic
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <39447.127.0.0.1.1161276534.squirrel@domain.hid>
References: <47746.127.0.0.1.1160160976.squirrel@domain.hid>
	<1160942865.4962.22.camel@domain.hid>
	<39447.127.0.0.1.1161276534.squirrel@domain.hid>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 18:26:30 +0200
Message-Id: <1161275190.4959.27.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wael BACHTA <wael@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2006-10-19 at 16:48 +0000, Wael BACHTA wrote:
> Hi,
> 
> Thank you for your hints.
> 
> I patched my kernel the new adeos patch
> (adeos-ipipe-2.6.17-i386-1.5-00.patch). and I did this tests :
> 
> - SMP on and PCI_MSI on : my PC boots. I installed xenomai 2.2.0. I can see
> my 2 virtual processors with "cat /proc/cpuinfo" BUT, I don't have
> interrupts.
> 
> - SMP on and PCI_MSI off : The PC boots and I see my 2 virtual processors.
> 
> - SMP off and PCI_MSI on : The PC boots, I have my interrupts.
> 
> It seems to me that the new patch disables the PCI_MSI when the SMP is on.
> The new patch doesn't seem to fix my problem.
> 

Clearly not, it doesn't disable anything (in case it's not obvious, I'm
looking for a real fix, not for a work-around). I managed to put my
hands on a previously failing SMP box with PCI_MSI enabled, and 1.5-00
does fix the issue there. So the current issue we are discussing must be
different.

Could you redo test #1 disabling Xenomai, and dump /proc/interrupts on
your box? TIA,

> Thanks for your help.
> 
> Wael.
> 
> 
> 
> > On Fri, 2006-10-06 at 18:56 +0000, Wael BACHTA wrote:
> >> Hi,
> >>
> >> I use an Intel Pentium 4 processor which can be used as 2 virtual
> >> processors when setting the SMP option during the kernel compiling (I
> >> can
> >> see 2 processors with "cat /proc/cpuinfo").
> >>
> >> I patched the kernel with adeos in order to install xenomai. I
> >> discovered
> >> that :
> >> - when completely disabling the ACPI and setting the SMP, my system
> >> boots
> >> but I have only one processor when I look into /proc/cpuinfo
> >> - Everything goes well when I don't disable completely the ACPI.
> >>
> >> I also use a PCI framegrabber. its driver is a real time one developed
> >> under xenomai. I noticed that this driver works fine only if the PCI_MSI
> >> is set. Otherwise, I don't have any interrupts.
> >>
> >> I must use my real time driver and the 2 virtual processors.
> >> But, when I enable the ACPI, the SMP and the PCI_MSI, I have a kernel
> >> panic. My PC boots when I disable the ACPI but I loose 1 processor.
> >>
> >> I don't see what's wrong.
> >>
> >
> > Try this patch:
> > http://download.gna.org/adeos/patches/v2.6/i386/adeos-ipipe-2.6.17-i386-1.5-00.patch
> >
> >
> >> Thanks for your help,
> >>
> >> Wael.
> >>
> >> -------------------------------------
> >> Wael BACHTA
> >> Strasbourg I University
> >> LSIIT Laboratory, AVR group
> >> Bd S. Brant
> >> BP 10413, 67412 ILLKIRCH cedex, FRANCE
> >> Tel : +33 (0)3 90 24 44 78
> >> Fax : +33 (0)3 90 24 44 80
> >> http://eavr.u-strasbg.fr
> >>
> >>
> >> _______________________________________________
> >> Xenomai-core mailing list
> >> Xenomai-core@domain.hid
> >> https://mail.gna.org/listinfo/xenomai-core
> > --
> > Philippe.
> >
> >
> -------------------------------------
> Wael BACHTA
> Strasbourg I University
> LSIIT Laboratory, AVR group
> Bd S. Brant
> BP 10413, 67412 ILLKIRCH cedex, FRANCE
> Tel : +33 (0)3 90 24 44 78
> Fax : +33 (0)3 90 24 44 80
> http://eavr.u-strasbg.fr
> 
-- 
Philippe.



