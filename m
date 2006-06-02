Message-ID: <44806E3C.7080103@domain.hid>
Date: Fri, 02 Jun 2006 18:58:36 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <447F72A0.8000000@domain.hid>	<17536.18621.302528.67077@domain.hid>	<4480515F.7050500@domain.hid>	<17536.21805.408809.703077@domain.hid>	<44806253.9020805@domain.hid>
	<17536.26182.536525.725211@domain.hid>
In-Reply-To: <17536.26182.536525.725211@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig06C5F54EF9871EC6F5A3D9A7"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [patch] static buffer for timer-bheap
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
--------------enig06C5F54EF9871EC6F5A3D9A7
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Gilles Chanteperdrix wrote:
>  > > bheap_destroy allow
>  > > setting the bheap_t structure to an invalid value which, in turn, =
allow
>  > > helping upper layers in catching invalid uses of the bheap after i=
ts
>  > > destruction.
>  >=20
>  > Ok, we could make bheap_destroy pop up under XENO_OPT_DEBUG. We may =
then
>  > also add assertions to the bheap functions themselves to check for
>  > invalid usage.
>=20
> The checkings are already there, if you do not remove
> bheap_destroy. They are unconditionnal, because I find such checkings w=
ay
> too important to be optimized out.

Sorry, I might be blind, but how do bheap_gethead, bheap_insert, or
bheap_delete detect that heap->last or heap->sz became 0 after
bheap_destroy?

Given that this is code to be inlined and heavily used, we should really
take care for size and efficiency on production systems, even if it's
about a few bytes here. But I also agree that verbose(!) checking
(XENO_ASSERT/XENO_BUGON) is very useful during development.

Jan


--------------enig06C5F54EF9871EC6F5A3D9A7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEgG49niDOoMHTA+kRAjAYAJ9d4PMyMX0X2lka63yvfhuOOzCk3ACfdXSm
ZLsUCT7m/iMFS/QGwVWnOMg=
=HtB2
-----END PGP SIGNATURE-----

--------------enig06C5F54EF9871EC6F5A3D9A7--

