Message-ID: <43F793AF.4080805@domain.hid>
Date: Sat, 18 Feb 2006 22:37:51 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [PATCH] Shared interrupts (ready to merge)
References: <b647ffbd0602150939g59256b2bx@domain.hid>	
	<43F3C4EA.7050303@domain.hid>
	<b647ffbd0602160220we254aacx@domain.hid>	
	<43F47705.90309@domain.hid>
	<b647ffbd0602160558i4112313an@domain.hid>	
	<43F48832.7060804@domain.hid>	
	<b647ffbd0602161128t70d1f08ax@domain.hid>	
	<43F4E2D3.4010705@domain.hid>
	<b647ffbd0602181204u518296fev@domain.hid>
In-Reply-To: <b647ffbd0602181204u518296fev@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAC476F0562ED8351A1FDF319"
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
--------------enigAC476F0562ED8351A1FDF319
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

Dmitry Adamushko wrote:
> Hi Jan,
>=20
> let's make yet another revision of the bits :
>=20
> new XN_ISR_HANDLED  =3D=3D old XN_ISR_HANDLED + old XN_ISR_NO_ENABLE
>=20
> ok.
>=20
> new XN_ISR_NOENABLE =3D=3D ~ old XN_ISR_ENABLE
>=20
> ok.
>=20
> new XN_ISR_PROPAGATE =3D=3D XN_ISR_CHAINED
>=20
> ok.
>=20

Just to make sure that you understand my weird ideas: each of the three
new XN_ISR_xxx above should be encoded with an individual bit

> new XN_ISR_NOINT =3D=3D ?
>=20
> does it suppose the interrupt line to be .end-ed (enabled) and irq not =
to be
> propagated? Should be so, I guess, if it's different from 5). Then nucl=
eus
> ignores implicit IRQ enable for 5) as well as for 3).
>=20
> Do we really need that NOINT then, as it seems to be the same as ~HANDL=
ED?
>=20
> or NOINT =3D=3D 0 and then it's a scalar value, not a bit.
>=20
> So one may consider HANDLED =3D=3D 1 and NOINT =3D=3D 0 as really scala=
r values
>=20
> and
>=20
> NOENABLE and PROPAGATE as additional bits (used only if needed).
>=20

My idea is to urge the user specifying one of the base return types
(HANDLED or NOINT) + any of the two additional bits (NOENABLE and
PROPAGATE).

For correct drivers NOINT could be 0 indeed, but to check that the user
picked a new constant we may want to set NOINT !=3D 0. With the old API
"return 0" expressed HANDLED + ~ENABLE for the old API. With the new one
the user signals no interest and the nucleus may raise a warning that a
spurious IRQ occurred. So I would add a debug bit for NOINT here to
optionally (on OPT_XENO_DEBUG) detect old-style usage (return 0).
Moreover, we gain freedom to move bits in the future when every state is
encoded via constants. Or am I too paranoid here?

Jan


--------------enigAC476F0562ED8351A1FDF319
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD95OvniDOoMHTA+kRAhy+AJ0b6G3xkzC53dYI29Aa6SBa8trDKwCfVc7G
paE6IF5nOk1qROwgmeGLxz4=
=fEUz
-----END PGP SIGNATURE-----

--------------enigAC476F0562ED8351A1FDF319--

