Message-ID: <4DC2457A.8020506@domain.hid>
Date: Thu, 05 May 2011 08:36:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4DC0406C.7060402@domain.hid>
	<216508.85461.qm@domain.hid>
In-Reply-To: <216508.85461.qm@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA49D4F78BD9892C10E94E991"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Problem with the configuration of new system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Franz Engel <franz_lambert_engel@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA49D4F78BD9892C10E94E991
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-05-05 07:30, Franz Engel wrote:
> Hi,
>=20
> After some days to learn how I receive logs on another PC, here is my l=
og. The problem is that the PC hangs after a few seconds.=20
>=20
>=20
>=20
> =09
> =09
> =09
> 	pre { font-family: "Liberation Serif"; }p { margin-bottom: 0.21cm; }
>=20
> #[?25l#[H#[J#[2;25HGNU GRUB  version 1.98-1ubuntu10
>=20
>=20
> [    0.000000] Linux version 2.6.32.20-adeos (root@domain.hid) (gcc=
 version 4.4.3 (Ubuntu 4.4.3-4ubuntu5) ) #1 SMP Wed May 4 22:06:49 CEST 2=
011

Can you retry with a recent 2.6.37? .32 is unmaintained (ipipe-wise) for
quite a while now, and many patches were developed since then.

Jan


--------------enigA49D4F78BD9892C10E94E991
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk3CRYMACgkQitSsb3rl5xR/4wCeP8HnZ+s+JWtgKduAPXQTN1IS
sK4AoOEBP+03+xSUW36z/Ww6G+gmZtHg
=/h4G
-----END PGP SIGNATURE-----

--------------enigA49D4F78BD9892C10E94E991--

