Message-ID: <44A432AD.9050305@domain.hid>
Date: Thu, 29 Jun 2006 22:06:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <0D21CBD1298D2C4790E2F2B86D96EC19013280F9@domain.hid>
In-Reply-To: <0D21CBD1298D2C4790E2F2B86D96EC19013280F9@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6DB28071FDEE4EC317AE234C"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-help] Re: [Adeos-main] User space,
	level triggered interrupt
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Reynolds, Terry AMRDEC/SimTech" <terry.reynolds2@domain.hid>
Cc: Xenomai <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6DB28071FDEE4EC317AE234C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Reynolds, Terry AMRDEC/SimTech wrote:
> Hi,
>=20
> Unfortunately I'm tied to this version of linux (2.6.10). =20

Very unfortunate, indeed.

>=20
> I have the PCI driver allocate the IRQ and register a handler for it, s=
o
> I'll be able to learn the IRQ number.  I've tried not propagating the
> IRQ from Fusion, but the code never seems to proceed past the first
> interrupt.
>=20
> As I understood the interrupt pipeline, if my realtime task didn't idle=

> itself, then Linux didn't get a chance to do anything, include
> processing IRQ's!

Yep.

>=20
> The only way I can think of for the interrupt count to increment is for=

> the Linux isr to get called, and return IRQ_HANDLED, without clearing
> the actual interrupt line.  (the user app. has to clear it)

The I_AUTOENA flag tells the system to immediately re-enable the IRQ
line. Your user-space task will then be executed *after* the IRQ line
got enabled (leaving SMP systems aside here). By combining I_AUTOENA and
I_PROPAGATE you then risk to re-enable the line twice: the second time
after Linux got hold of and handled the event. Cannot say what this
means in practice for your arch though.

>=20
> If I didn't have Linux return the irq_handled, how would I mark the IRQ=

> as being handled from a user space application?

You could call rt_intr_enable, though this is not totally clean. Some
archs (PPC32 is one of them I think) distinguish between *enabling* and
*ending* an interrupt. We had a long discussion on this on xenomai-core,
and while the nucleus is now clean in this respect (also it's
documentation), the native (former rtai) skin still does not deal with
this issue yet. If you decide to not let the skin enable the line for
you, then calling rt_intr_enable may not always fit. But, unfortunately,
there is no rt_intr_end() even in latest Xenomai...

[Could someone help my memory with the current status of open-coded IRQ
handling in native/POSIX threads? I only know that I have some early
RTDM code hanging around somewhere, but that will become a different
usage model.]

Even worse for you, I'm not sure if Fusion 0.9 handled this
differentiation correctly at all. nucleus/intr.c only talks about
xnarch_enable_irq() on return from the handler:

http://www.rts.uni-hannover.de/xenomai/lxr/source/nucleus/intr.c?v=3Dfusi=
on-0.9#L365

>=20
> PS.  I wasn't sure where the 'best' group to post this as it's an Fusio=
n
> / Adeos application and not a I-Pipe version.
>=20

Definitely Xenomai, I CC'ed the help list (subscription required for
postings).

Jan


>=20
> Terry.=20
>=20
> -----Original Message-----
> From: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid
> Sent: Thursday, June 29, 2006 1:32 PM
> To: Reynolds, Terry AMRDEC/SimTech
> Cc: adeos-main@gna.org
> Subject: Re: [Adeos-main] User space, level triggered interrupt
>=20
> Reynolds, Terry AMRDEC/SimTech wrote:
>> Hi All,
>> =20
>> I'm trying to understand what I'm seeing in my real-time code where I =

>> handle a PCI interrupt, using it to handshake with a program running=20
>> on another computer connected via a PCI reflective memory card.  This =

>> is on a G5 ppc64 kernel.
>> =20
>> When I register the driver for the PCI card, I allocate an IRQ for it,=

>=20
>> and install the kernel ISR which only returns IRQ_HANDLED.  I mmap the=

>=20
> Wait, do you share the IRQ this way between RT and non-RT? I mean is th=
e
> Linux handler still registered when you attach to it via Fusion? What
> jobs still should be done in non-RT context? Note that this can cause
> nasty prio inversions with the RT code.
>=20
>> registers on the card, as the user application has to access them to=20
>> clear the PCI interrupt after the IRQ is detected.
>> =20
>> My realtime application is based on Fusion 0.9, but I've looked at the=

>=20
>> Xenomai version of the rt_intr_wait code and don't see any
> differences.
>> The realtime code accesses the card's pci driver to read the IRQ=20
>> number, and creates a user space interrupt object (passing I_PROPAGATE=

>=20
>> & I_AUTOENA ).  What's strange is that when I call rt_intr_wait for an=

>=20
>> instance where only one interrupt has fired, but several micro-seconds=

>=20
>> have passed prior to the wait function, the wait returns values=20
>> indicating that several interrupts are pending.  Calling the wait=20
>> function without allowing any spare time returns a correct 'one'
>> interrupt having fired.  Calling the wait once seems to clear the=20
>> interrupt pending count.
>=20
> It does [1] (also in Xenomai).
>=20
>> =20
>> My questions are:  how are multiple interrupt pending counts being=20
>> generated during a real time task that doesn't yield?  How is it
>=20
> Hard to say without knowing your code (or at least the central parts of=

> it). But such problems can nicely be analysed these days with the Adeos=

> I-pipe tracer. Once you detect a failure in your app, you can trigger a=

> freeze and go back several thousands of kernel function calls in the
> trace history. This typically gives a nice picture of what happened and=

> what should better have not happened.
>=20
> It may "only" require an update of your code base. But given the
> improvements and fixes along the path from Fusion 0.9 to Xenomai 2.1
> (2.2 soon), it may be worth it. Do you depend on a specific kernel
> version that's no longer supported? Or does your project require fixed
> versions?
>=20
>> possible to service several pending interrupts if the pending count=20
>> gets cleared every time you check for an interrupt?
>> =20
>=20
> First, you get the number of occurred IRQs on return of rt_intr_wait.
> And second, a typical IRQ handler (if threaded or not) looks like this:=

>=20
> while (hardware_says_there_are_events) {
> 	handle_some_hardware_event;
> }
>=20
> So the IRQ event itself is just a trigger to handle n >=3D 1 hardware
> events.
>=20
>=20
> I'm just scratching my head if this is an adeos-related question ;). I
> would say xenomai-core is a better place for this discussion, covering
> more the RTOS than the low-level hardware abstractions.
>=20
> Jan
>=20
>=20
> [1]http://www.rts.uni-hannover.de/xenomai/lxr/source/skins/rtai/syscall=
=2E
> c?v=3Dfusion-0.9#L3100
>=20


--------------enig6DB28071FDEE4EC317AE234C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEpDKtniDOoMHTA+kRAkPlAJ0bsXEW1a4I3jlU3GyWoKngaOmaCwCfTAXw
ld4hYjpAm3KuanSfkoWzcUk=
=259w
-----END PGP SIGNATURE-----

--------------enig6DB28071FDEE4EC317AE234C--

