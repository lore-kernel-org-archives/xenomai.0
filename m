Message-ID: <44A41CA0.6090701@domain.hid>
Date: Thu, 29 Jun 2006 20:32:00 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] User space, level triggered interrupt
References: <0D21CBD1298D2C4790E2F2B86D96EC19013280F8@domain.hid>
In-Reply-To: <0D21CBD1298D2C4790E2F2B86D96EC19013280F8@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig54614899064DC0C50CE44693"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: "Reynolds, Terry AMRDEC/SimTech" <terry.reynolds2@domain.hid>
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig54614899064DC0C50CE44693
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Reynolds, Terry AMRDEC/SimTech wrote:
> Hi All,
> =20
> I'm trying to understand what I'm seeing in my real-time code where I
> handle a PCI interrupt, using it to handshake with a program running on=

> another computer connected via a PCI reflective memory card.  This is o=
n
> a G5 ppc64 kernel.
> =20
> When I register the driver for the PCI card, I allocate an IRQ for it,
> and install the kernel ISR which only returns IRQ_HANDLED.  I mmap the

Wait, do you share the IRQ this way between RT and non-RT? I mean is the
Linux handler still registered when you attach to it via Fusion? What
jobs still should be done in non-RT context? Note that this can cause
nasty prio inversions with the RT code.

> registers on the card, as the user application has to access them to
> clear the PCI interrupt after the IRQ is detected.
> =20
> My realtime application is based on Fusion 0.9, but I've looked at the
> Xenomai version of the rt_intr_wait code and don't see any differences.=

> The realtime code accesses the card's pci driver to read the IRQ number=
,
> and creates a user space interrupt object (passing I_PROPAGATE &
> I_AUTOENA ).  What's strange is that when I call rt_intr_wait for an
> instance where only one interrupt has fired, but several micro-seconds
> have passed prior to the wait function, the wait returns values
> indicating that several interrupts are pending.  Calling the wait
> function without allowing any spare time returns a correct 'one'
> interrupt having fired.  Calling the wait once seems to clear the
> interrupt pending count.

It does [1] (also in Xenomai).

> =20
> My questions are:  how are multiple interrupt pending counts being
> generated during a real time task that doesn't yield?  How is it

Hard to say without knowing your code (or at least the central parts of
it). But such problems can nicely be analysed these days with the Adeos
I-pipe tracer. Once you detect a failure in your app, you can trigger a
freeze and go back several thousands of kernel function calls in the
trace history. This typically gives a nice picture of what happened and
what should better have not happened.

It may "only" require an update of your code base. But given the
improvements and fixes along the path from Fusion 0.9 to Xenomai 2.1
(2.2 soon), it may be worth it. Do you depend on a specific kernel
version that's no longer supported? Or does your project require fixed
versions?

> possible to service several pending interrupts if the pending count get=
s
> cleared every time you check for an interrupt?
> =20

First, you get the number of occurred IRQs on return of rt_intr_wait.
And second, a typical IRQ handler (if threaded or not) looks like this:

while (hardware_says_there_are_events) {
	handle_some_hardware_event;
}

So the IRQ event itself is just a trigger to handle n >=3D 1 hardware eve=
nts.


I'm just scratching my head if this is an adeos-related question ;). I
would say xenomai-core is a better place for this discussion, covering
more the RTOS than the low-level hardware abstractions.

Jan


[1]http://www.rts.uni-hannover.de/xenomai/lxr/source/skins/rtai/syscall.c=
?v=3Dfusion-0.9#L3100


--------------enig54614899064DC0C50CE44693
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEpBygniDOoMHTA+kRAqkeAJwJHS2GeHVCjMeSOrdjCofThpDWvwCeN+Ar
sxx/82BbXCa0tR/H3sghFS4=
=nu9V
-----END PGP SIGNATURE-----

--------------enig54614899064DC0C50CE44693--

