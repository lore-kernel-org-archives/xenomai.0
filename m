Message-ID: <447EB707.7090605@domain.hid>
Date: Thu, 01 Jun 2006 11:44:39 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] io apic and shared irq questions
References: <447ED64F.7090902@domain.hid>
In-Reply-To: <447ED64F.7090902@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFC5AD0F077DDAC672F9DF633"
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
To: "s.a." <sancelot@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFC5AD0F077DDAC672F9DF633
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

s.a. wrote:
> Hi,
>=20
> Regarding an embedded realtime system, I have got a communication board=

> on pci bus .
>=20
> I would like it's interrupt not being shared (with usb) , because the
> component receives an it every 100us and is realtime determinist.
> I looked at how was routed IRQ's with the io apic , although it is able=

> to use 24 irq's, linux always share my PCI boards IRQ with another
> component and do not use all the 24 irq's range capability of ioapic.
>=20
> Do you think it is possible to program the ioapic in order to have a
> better irq mapping and avoid this problem and use all the range of
> availbale vectors ?

Logical IRQ numbers are one side, but you first have to find out if the
PCI components do not share the same *physical* line. Dependent on the
system design, there should be some way to flip those line assignment,
either by moving to another extension slot or even by playing with
jumpers (PC/104plus boards may provide this e.g.).

Jan



--------------enigFC5AD0F077DDAC672F9DF633
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEfrcHniDOoMHTA+kRArX+AJ4ybNAiQB4MSOdVKqQ6NUPKv7UKxQCfSekb
a6t9bPUpfIG2d4SwvKUzdZc=
=/zQk
-----END PGP SIGNATURE-----

--------------enigFC5AD0F077DDAC672F9DF633--

