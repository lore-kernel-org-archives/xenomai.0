Message-ID: <4B732685.6060207@domain.hid>
Date: Wed, 10 Feb 2010 22:35:01 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1NfBdX-0001ga-4b@domain.hid>
	<4B72A7E2.5020001@domain.hid>	<4B72A9DA.1090104@domain.hid>
	<4B730A04.9040908@domain.hid> <4B731608.6010803@domain.hid>
	<4B73180C.6070301@domain.hid> <4B73207C.6020400@domain.hid>
	<4B73218A.9080306@domain.hid> <4B7323D5.1040804@domain.hid>
	<4B7324FB.8030600@domain.hid>
In-Reply-To: <4B7324FB.8030600@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA3C3C733F8468230A2940490"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : Make
 xnarch_init_timeconv an uninlined weak function
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA3C3C733F8468230A2940490
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> If xnarch_init_timeconv shall be executed unconditionally, I will
>> happily make it static inline again and call it from xeno_bind_skin_op=
t
>> (which would imply retrieving sysinfo as well).
>=20
> It is executed unconditionally, but needs to be available to kernel
> space as well.

Not yet (it was POSIX- and Native-only), but we can change this.

Jan


--------------enigA3C3C733F8468230A2940490
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAktzJoUACgkQitSsb3rl5xR4VACeLHf692Vx5WiZXe3NqT+FXNJe
g80An0ZTfNr9PrlebM9l1I0TvE4aCbt5
=PfJP
-----END PGP SIGNATURE-----

--------------enigA3C3C733F8468230A2940490--

