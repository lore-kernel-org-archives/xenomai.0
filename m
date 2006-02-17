From: "Russell Johnson" <rjohnson@domain.hid>
Subject: RE: [Xenomai-core] Handling PCI MSI interrupts
Date: Fri, 17 Feb 2006 07:43:12 -0700
Message-ID: <001d01c633d0$7a5a7300$1e01a8c0@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <43F5CAE8.9010905@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: 'Philippe Gerum' <rpm@xenomai.org>, 'Jeroen Van den Keybus' <jeroen.vandenkeybus@domain.hid>
Cc: 'xenomai-core' <xenomai@xenomai.org>


> > I tested (and intended) the patch for MSI (w/o maskbits), not MSI-X.
> > What e1000 chip are you using exactly? Easiest way to tell is by =
using=20
> > '/sbin/lspci'. I may be able to help you out with MSI-X as well, but =
in=20
> > that case, I have no hardware platform to test on.

> > You can check whether or not MSI is actually being used by doing=20
> > '/sbin/lspci -v' and look for the Capability: Message Signalled=20
> > Interrupt. When the driver is running in MSI mode, it should read=20
> > 'Enable+' instead of 'Enable-'.

This e1000 chip actually doesn't have MSI support.  I had assumed that =
since
the e1000 driver caused the hanging and disabling MSI in the kernel =
caused
the hang to go away that the problem was MSI in the e1000.  The e1000 =
driver
only enables MSI on newer chips than what are in the Dell 28xx machines.

> > As it's a Dell, I assume there's two Intel Penium CPU's=20
> > inside. Are you running with SMP enabled ?

SMP is enabled.

> > The local (internal) CPU APIC hasn't been informed that the =
interrupt=20
> > has been dealt with and it will therefore allow no other interrupts=20
> > anymore to arrive in the CPU (including your keyboard's).=20
> > In fact, your CPU is idle.

I have used a PCI analyzer to see infinite loops on this machine for =
past
similar kernel issues and assumed it would be the same due to the =
symptoms.

> >     When I build a kernel with Adeos but disable MSI then the=20
> >     system works fine for the most part.  There is one scenario=20
> >     where the system will still hang
> >     doing disk and network accesses under a moderate load of I/O.=20
> >=20
> > Hm. That may indicate another issue.
>=20
> Indeed. This behaviour has not been reported yet with patches=20
> from the Adeos I-pipe series. Does it also happen with SMP=20
> disabled, or Hyperthreading disabled?

It did happen with SMP disabled and I have always left hyperthreading
disabled because it is my understanding that hyperthreading is not =
supported
by the adeos patch.

> > Try upgrading the kernel. The kernel usually comes with updated =
drivers=20
> > as well. Currently I'm running 2.6.16-rc2, which I had to patch =
manually

> > for Adeos (about 3 'hunks' from the 2.6.15-i386-1.2-00 patch didn't=20
> > apply properly). By using 2.6.16-rc2, I got much better Intel=20
> > (especially i865 graphics) chipset support than 2.6.15. Note, =
however,=20
> > that I did the bug fixing in this thread on a plain 2.6.15, though =
(and=20
> > the msi.c code is nearly identical).
> >=20
> > I would recommend upgrading to 2.6.15 with the latest Adeos patch =
and=20
> > try to get a stable system before enabling MSI.

In short, MSI doesn't seem to have been my issue.  I now have a more =
stable
kernel.  Apparently this system had some other faults with the specific
configuration options I was using.  I had to patch to the 2.6.14.7 level
(was at .4) and change some of the options in my .config.  Specifically, =
I
had to leave ACPI enabled (I had disabled as a test a while back).  With
ACPI disabled, the machine would still hang if the USB was disabled in =
the
BIOS.

After learning how to check for MSI, no devices in my system seem to
actually be using MSI.  The code patches you provided were never =
actually
executed.  Time will tell if my system is stable.

Thanks for your help!
Russ



