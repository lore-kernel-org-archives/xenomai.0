Message-ID: <43E1E423.7040908@domain.hid>
Date: Thu, 02 Feb 2006 11:51:15 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] 	[Combo-PATCH] Shared interrupts (base, /proc
	support,	edge-triggered stuff)
References: <b647ffbd0602011323o9ac08b3x@domain.hid>
In-Reply-To: <b647ffbd0602011323o9ac08b3x@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF2011F94B9ECDC2005773475"
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
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF2011F94B9ECDC2005773475
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> Hi there,
>=20
> as I promised, here go the following patches (ordered as they have to b=
e
> applied one by one) :
>=20
>=20
> 1) shirq-base.patch
>=20
> Adds the "name" field to the interrupt object of the nucleus layer.
> Reworks the related bits of the native skin (+ a few minor changes for
> posix and rtdm) to support the named interrupt objects.
>=20
>=20
> 2) shirq-v7.patch
>=20
> Generic support for shared interrupts.
>=20
>=20
> 3) shirq-proc.patch
>=20
> /proc support.
>=20
> Now /proc/xenomai/irq shows the names of handlers.
>=20
> The related code have been removed from the hal layer to nucleus.
>=20
>=20
> -----
>=20
> 4) shirq-isa.patch
>=20
> Trying to handle the edge-triggered stuff.
>=20
> This is a very preliminary version so the only thing I promise so far
> is that it compiles successfully.

Why not name it XN_ISR_EDGE or so (also the related functions etc.)?
Although it mostly targets ISA hardware, it's about the edge-triggered
characteristic of that devices after all.

>=20
>=20
> The functionality added by first 3 patches seem to be working.
>=20
> --
> Best regards,
> Dmitry Adamushko
>=20

I'm now trying to organise a full test scenario with shared UART
ISA-IRQs at our institute. May take till beginning of next week, some
regressions in our own software need to be fixed first.

Jan


--------------enigF2011F94B9ECDC2005773475
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD4eQjniDOoMHTA+kRApdYAJ9kz/cy0WgJVF0PvU/TFVBhW7vZoACfVMOq
qVW1Ib3UZKOxCuHtZZuX6FE=
=49J1
-----END PGP SIGNATURE-----

--------------enigF2011F94B9ECDC2005773475--

