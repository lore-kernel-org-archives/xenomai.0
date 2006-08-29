Message-ID: <44F49A6C.5050603@domain.hid>
Date: Tue, 29 Aug 2006 21:50:04 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <b647ffbd0608291228i58bfa3fex5e8f3e18dc0ecc0@domain.hid>
In-Reply-To: <b647ffbd0608291228i58bfa3fex5e8f3e18dc0ecc0@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6CFEA5D10F33B3CABA284E66"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [patch, RFC] detect unhandled interrupts
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
--------------enig6CFEA5D10F33B3CABA284E66
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
> Hello,
>=20
> Jan has rised this question initially and I was struggling last week to=
 get
> his request eventually done :)
>=20
> The main idea is to prevent system lockups when the cross domain IRQ
> sharing
> isn't properly used (there were a number of reports recently).
>=20
> So here is an initial patch as well as some related critics (yep, I
> critisize my own patch).
>=20
> I tend to think now :
>=20
> 1) "unhandled" is not necessary indeed (do we need chasing "spurious"
> interrupts the way Linux does it? i.e. it disables the line only after =
a
> number of consequently unhandled interrupts > SOME_LIMIT);
>=20
> 2) XN_ISR_NONE --> should _not_ imply that the line gets re-enabled.
>=20
> XN_ISR_HANDLED -- implies it, that's ok.
>=20
> But XN_ISR_NONE (all ISRs in case of a shared RT line) should really me=
an
> "something strange happens" and it can be :
>=20
> o  either a spurious interrupt;
>=20
> o  something is "sitting" on the same line in the linux domain. ISR sho=
uld
> have returned XN_ISR_PROPAGATE in this case.
>=20
>=20
> That said, if we are not interested in chasing "spurious" interrupts th=
e
> linux way, then this patch could be highly simplified to just adding th=
e
> following check in all nucleus ISR handlers.
>=20
> +       if (unlikely(s =3D=3D XN_ISR_NONE)) {
> +               xnlogerr("xnintr_check_status: %d of unhandled conseque=
nt
> interrupts. "
> +                       "Disabling the IRQ line #%d\n",
> +                       XNINTR_MAX_UNHANDLED, irq);
> +               s |=3D XN_ISR_NOENABLE;
> +       }
>=20
> I tend to think this would be nicer?
>=20

I think the additional costs of maintaining an error counter are almost
negligible. The test is in the unlikely path, and the first condition
already keeps us away from touching the counter. The benefit of not
kicking out IRQ lines on spurious IRQs is obvious (think of EMC issues,
though one should better solve them on the board...).

BTW, is there a difference between unlikely(a && b) and unlikely(a) &&
unlikely(b) that we should care about here?

Patch looks good to me.

Jan


--------------enig6CFEA5D10F33B3CABA284E66
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFE9JpsniDOoMHTA+kRAluVAJ9LdLw4LNv3gPDPqLV2AA+Adm/R1gCffy01
ramUGodAn2N7L9K6MZnIYbQ=
=+lPx
-----END PGP SIGNATURE-----

--------------enig6CFEA5D10F33B3CABA284E66--

