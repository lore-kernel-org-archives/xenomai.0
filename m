Message-ID: <4A618101.2000608@domain.hid>
Date: Sat, 18 Jul 2009 10:00:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <alpine.DEB.2.00.0907142049190.4341@domain.hid>
	<4A5D88E9.2010305@domain.hid>
	<Pine.LNX.4.62.0907151048370.24398@domain.hid>
	<Pine.LNX.4.62.0907151610090.24888@domain.hid>
	<4A5F9E8A.3010906@domain.hid>
	<Pine.LNX.4.62.0907171349580.28491@domain.hid>
In-Reply-To: <Pine.LNX.4.62.0907171349580.28491@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4F6773167120ABB33B379C16"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] rtdm_mmap_to_user without MMU
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kolja Waschk <xenoka09@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4F6773167120ABB33B379C16
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Kolja Waschk wrote:
>> they will become two in the end), see below. Please check if it works
>> for you.
>=20
> Aah, I was checking too hastily and missed a compile error. Sorry!
> Actually, there's a typo in the get_unmapped_area (filp <-> file), and
> it does _not_ work this way, unless the address to map is specified as
> the offset when calling do_mmap:
>=20
>     user_ptr =3D (void *)do_mmap(filp, (unsigned long)*pptr, len, prot,=

>                        MAP_SHARED, mmap_data->src_vaddr);
>=20
> Otherwise pptr will simply remain zero.

Hmm, thought I got all paths. Such side effects indicate that this way
is not a stable one. Ok, will try to find a better solution, but may
take some time.

Jan


--------------enig4F6773167120ABB33B379C16
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkphgQYACgkQniDOoMHTA+nF8ACeMe/ZpOfV9T58z1eciTdFj7/3
lB4AnjtM9cXW0U2wQSs7KYFm8nsMPgjj
=3P5b
-----END PGP SIGNATURE-----

--------------enig4F6773167120ABB33B379C16--

