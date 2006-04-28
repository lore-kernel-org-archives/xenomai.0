Message-ID: <44527E39.7090501@domain.hid>
Date: Fri, 28 Apr 2006 22:42:33 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Have condition variables Priority Inheritance
	Protection (PIP)?
References: <200604281736.28169.lbocseg@domain.hid>
In-Reply-To: <200604281736.28169.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCF928EFEF6E38D6F9B507857"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCF928EFEF6E38D6F9B507857
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Hi,
> Having a look at cond.c in the native skin, I didn't understand why it =
is not=20
> passed the PIP flag to xnsynch_init(). I mean, why the code is not=20
> xnsynch_init(&cond->synch_base,XNSYNCH_PIP);
>=20
> instead of
>=20
> xnsynch_init(&cond->synch_base,XNSYNCH_PRIO);
>=20
> ?
>=20
> Could someone please point me the reason?
>=20

Just as with semaphores: there is no ownership concept for condition
variables. Thus, who should be boosted to your priority in case you
decide to wait on such a resource?

Jan


--------------enigCF928EFEF6E38D6F9B507857
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEUn45niDOoMHTA+kRAgfQAJ9I5GuFsYJ1IFs9+6haa9aEfPbN/wCcDTDw
QD4A8njhfv3be74QwzXFs4A=
=4aY3
-----END PGP SIGNATURE-----

--------------enigCF928EFEF6E38D6F9B507857--

