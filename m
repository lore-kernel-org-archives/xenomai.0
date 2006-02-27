Message-ID: <44031010.7010407@domain.hid>
Date: Mon, 27 Feb 2006 15:43:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] prepare-kernel is broken
References: <4402FA52.3080606@domain.hid>
	<17411.1445.159527.784570@domain.hid>
In-Reply-To: <17411.1445.159527.784570@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig78DD86B1B062AD56B3C28FEE"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig78DD86B1B062AD56B3C28FEE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Hi,
>  >=20
>  > the last check-in seems to have messed something up:
>  >=20
>  > .../xenomai/scripts/prepare-kernel.sh: line 61: syntax error near
>  > unexpected token `fi'
>  >=20
>  > I do not understand what's going on here, so I don't want to hack so=
me
>  > probably wrong fix for this.
>=20
> In order to have it work, I had to make the following changes to
> revision 610 :
>=20

We seem to use different find versions:

=2E..
find: warning: you have specified the -mindepth option after a
non-option argument (, but options are not positional (-mindepth affects
tests specified before it as well as those specified after it).  Please
specify options before other arguments.

[caused by revision 613]

Jan


--------------enig78DD86B1B062AD56B3C28FEE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEAxAQniDOoMHTA+kRAg/uAJ9zClKgaJoEwlSO42z2uVYQ7NEPAgCeM5wB
qM2OjJLUnu0CoAXg/01DLcU=
=EUub
-----END PGP SIGNATURE-----

--------------enig78DD86B1B062AD56B3C28FEE--

