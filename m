Message-ID: <4618F046.6010702@domain.hid>
Date: Sun, 08 Apr 2007 15:38:14 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rt_heap return codes
References: <200704080000.12934.paul_c@domain.hid> <4618262C.50006@domain.hid>
	<200704081231.11244.paul_c@domain.hid>
In-Reply-To: <200704081231.11244.paul_c@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig40CA457F3DF716D233F066B8"
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
To: Paul <paul_c@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig40CA457F3DF716D233F066B8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Paul wrote:
> On Sunday 08 April 2007 00:15, Jan Kiszka wrote:
>> [/usr/include/asm-generic/errno.h]
>> #define EWOULDBLOCK     EAGAIN
>=20
> /me kicks backside for not reading the source..
>=20
>>> Also noted that rt_heap_delete() returns -EBUSY if another task holds=
 a
>>> valid heap descriptor - Undocumented, but well worth having as it can=
 be
>>> used to prevent the RT_HEAP memory from disappearing (either by a mod=
ule
>>> unloading, or user space app terminating).
>> Feel free to provide a patch to enhance the doc.
>=20
> Attached, one patch documenting the -EBUSY return code along with a few=
 minor=20
> spelling/syntax corrections.
>=20

Thanks for caring. I'm sure Philippe will pick it up.

Jan


--------------enig40CA457F3DF716D233F066B8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFGGPBGniDOoMHTA+kRApY4AJ44RYf2kgNv9Xzu1V9LilDA76dVKgCdHVzs
/nGBR/vMpibZ3JWjiDxztFU=
=PbwO
-----END PGP SIGNATURE-----

--------------enig40CA457F3DF716D233F066B8--

