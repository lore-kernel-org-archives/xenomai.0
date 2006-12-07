Message-ID: <457826BC.1080008@domain.hid>
Date: Thu, 07 Dec 2006 15:35:40 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] module usage counter of xenomai native
	corrupted (version 2.2.0 and 2.2.5)
References: <OF7997031E.1BD006A7-ONC125723D.0046EB70-C125723D.0048376B@retarus.de>
In-Reply-To: <OF7997031E.1BD006A7-ONC125723D.0046EB70-C125723D.0048376B@retarus.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7EA42E0CB1F3C7F2321B9206"
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
To: Thomas Wiedemann <Thomas.Wiedemann@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7EA42E0CB1F3C7F2321B9206
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Thomas Wiedemann wrote:
> Hi,
>=20
> there seems to be a bug in rt_task_create(). When no more memory is
> available, the module usage counter of xeno_native is decremented. I
> guess it is not incremented before, however, so the counter gets 0 and
> wraps then to a negative number. It is therefore not possible to remove=

> the module.
>=20
> I appended a small program to demonstrate this. It simply eats up all
> memory from xenomai by registering as much mutexes as possible,
> and then tries to execute rt_task_create(), which fails. When started
> again, the bug occurs at rt_task_shadow(), as the mutexes have never
> been deleted.
> Compile with  gcc -O2 -Wall `xeno-config --xeno-cflags` `xeno-config
>  --xeno-ldflags` -lrtdm -lnative -o rttest rttest.c
> then simply run it, and watch the output of lsmod before and after.
>=20
> Tested with xenomai 2.2.{0,5} and linux 2.6.17.8, modules loaded:
> xeno_native and xeno_nucleus.
>=20

Confirmed. Requires a closer look to find the leak path.

Thanks for reporting so thoroughly,
Jan



--------------enig7EA42E0CB1F3C7F2321B9206
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFeCa9niDOoMHTA+kRAp/tAJ4poU9hV60aw2xO+RVB/2U5o0bwfQCfdqGb
3qXY7baq5mNQRH7TV4XsEq8=
=8f09
-----END PGP SIGNATURE-----

--------------enig7EA42E0CB1F3C7F2321B9206--

