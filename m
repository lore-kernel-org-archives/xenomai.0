Message-ID: <4656C583.5040303@domain.hid>
Date: Fri, 25 May 2007 13:16:19 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4656C2D0.7000705@domain.hid>
In-Reply-To: <4656C2D0.7000705@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD2F92C4ABE2EE6504ED23FC0"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Problem with interrupt enabling
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD2F92C4ABE2EE6504ED23FC0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Johan Borkhuis wrote:
> Hello,
>=20
> I am trying to create an RTDM interrupt handler for an external=20
> interrupt. I use a rtdm_irq_request, followed by a rtdm_irq_enable. Thi=
s=20

The rtdm_irq_enable is no longer required with RTDM revision 6 and
higher. But that's trunk, it's rev. 5 which still comes with Xenomai
2.3.x. And the enable will also cause no harm with rev. 6.

> caused one interrupt to be processed, but subsequent interrupts were no=
t=20
> processed.
> After adding an extra rtdm_irq_enable to the ISR the interrupts are=20
> processed. When I look at the other drivers I don't see this. Is this=20
> needed, or is there a bug/feature in the interrupt handling on my platf=
orm?
> (I use a MVME3100 with a ppc8540 processor and openPIC interrupt=20
> controller).

What do you return with your IRQ handler? RTDM_IRQ_HANDLED?

That explicit rtdm_irq_enable is not required by design, would rather be
a bug on certain platforms (where enable !=3D end IRQ), and indicates tha=
t
something else is broken, maybe in Xenomai.

Jan


--------------enigD2F92C4ABE2EE6504ED23FC0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGVsWDniDOoMHTA+kRAuekAJ927N38ZVO7ewxcOR4Y6Qn7CCt2HQCfTWub
fwwAKng9pNyeOqGf+c3MKbo=
=usLL
-----END PGP SIGNATURE-----

--------------enigD2F92C4ABE2EE6504ED23FC0--

