Message-ID: <44870010.5050602@domain.hid>
Date: Wed, 07 Jun 2006 18:34:24 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Porting xenomai to AT91RM9200
References: <OF63DA82CD.5D290237-ONC1257186.00524ADB-C1257186.0054CC4F@wavecom.fr>
In-Reply-To: <OF63DA82CD.5D290237-ONC1257186.00524ADB-C1257186.0054CC4F@wavecom.fr>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAD3DC8A7F8E86054CF065F89"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Yann.LEPROVOST@wavecom.fr
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAD3DC8A7F8E86054CF065F89
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Yann.LEPROVOST@wavecom.fr wrote:
> Hi marco,
>=20
> There is an issue with porting adeos to AT91RM9200. As i understood, ad=
eos
> handles system timer interrupt directly to keep real time "tsc" up to d=
ate.
> To do that, porting xenomai to AT91RM9200 means coding the correct tsc
> handling functions in arch/arm/mach-at91rm9200/time.c (in the same way =
as
> integrator board).
> That's what i tried to do...
>=20
> But on AT91RM9200, the system interrupt timer line is shared among othe=
r
> system peripherals such as watchdog, serial debug unit, memory controll=
er,
> ...
> I try to demux the interrupt sharing by modifying code of adeos irq
> handling but there are specificities with the interrupt controller I ca=
n't
> deal with...
> I have lots of difficulties to understand the overall architecture of t=
he
> adeos/xenomai source code...

Then please ask questions.

>=20
> At this time, I have an adeos/xenomai patched kernel which freezes when=

> launching the idle process... and I 'm a bit lost !?!
> Probably something wrong with the interrupt timer handling...
> I'd like to continue to work on xenomai port to AT91RM9200 but I need
> support from people with good knowledge of adeos internals... or a good=

> documentation starting point on adeos internal.
>=20
> I currently stopped working on xenomai/adeos to study ingo molnar
> patches...

Ah, I just remembered your thread on LKML. Then you may know that the
problem is the same with PREEMPT_RT. Thomas pointed out the only
solution: Write stubs to manage shared non-RT IRQ sources in RT context
(in PREEMPT_RT terms: create SA_NODELAY stubs for the otherwise threaded
drivers).

This problem pops up quite regularly, here is my standard reference for
a realisation of such a stub. It actually worked once over RTAI:

http://www.mail-archive.com/xenomai@xenomai.org
(grab the idea, not the API from this code)

The way I would go today: register a real-time IRQ handler for the
non-RT driver, silence the IRQ source in that handler (switch off IRQ
generation for the particular piece of hardware), save any required
information, and issue a soft-IRQ to the Linux domain. Attach the Linux
IRQ handler to the soft-IRQ then. In that handler, you could pick up the
reasons for the suppressed IRQ, handle it as usual and re-enable the IRQ
generation by the hardware. This way, the influence on the RT part
remains bounded.

The reason why this never made it into some real-time Linux variant:
it's too-hardware specific, there is not much you can do in the OS to
help solving this issue.

Jan


--------------enigAD3DC8A7F8E86054CF065F89
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEhwAQniDOoMHTA+kRAiknAJ4rUn62t0PtRwWTwJpfO9BUlSJNZwCfcMLP
QQtuEcv2RBLXDPUO6MXfcPo=
=dsi4
-----END PGP SIGNATURE-----

--------------enigAD3DC8A7F8E86054CF065F89--

