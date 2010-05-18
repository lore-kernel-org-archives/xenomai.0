Message-ID: <4BF273ED.2070802@domain.hid>
Date: Tue, 18 May 2010 13:03:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4BF268DE.1080809@domain.hid>
In-Reply-To: <4BF268DE.1080809@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig77930E4EFF69047A2D6513D7"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] rtdm_dev_register oops
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig77930E4EFF69047A2D6513D7
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Stefan Kisdaroczi wrote:
> hi,
>=20
> i got a exception in rtdm_dev_register(). I didnt call rtdm_dev_unregis=
ter in my driver
> and after insmodding the module again I got a oops.

And that is surprising to you? :)

If you leave the previous device registered on rmmod, oopses are
programmed to occur: You leave references to unallocated memory behind.

Jan

> xenomai 2.5.3, linux 2.6.32.11, x86 32bit, ubuntu 10.04.
>=20
> Attached is the dmesg-trace and a small rtdm-module foo.c for reproduct=
ion:
> insmod ./xeno_foo.ko
> rmmod xeno_foo
> insmod ./xeno_foo.ko -> oops
>=20
> thanks
> stefan


--------------enig77930E4EFF69047A2D6513D7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvyc/EACgkQitSsb3rl5xSbngCghgBfTmWzGEtZCwDncieDMvmr
gWEAoMSJ/zNQh6Yye+n9Mg/oZlbqMjzB
=O6Y3
-----END PGP SIGNATURE-----

--------------enig77930E4EFF69047A2D6513D7--

