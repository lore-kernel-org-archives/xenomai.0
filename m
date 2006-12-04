Message-ID: <45744B11.3090000@domain.hid>
Date: Mon, 04 Dec 2006 17:21:37 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai install problems
References: <20061204133717.GA20186@domain.hid> <4574268C.7000705@domain.hid>
	<20061204143948.GA20411@domain.hid> <45743D46.8000502@domain.hid>
	<20061204160711.GA8055@domain.hid>
In-Reply-To: <20061204160711.GA8055@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig29BB61CF1584A275229AEB3F"
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
To: Anthony Sharobaiko <anthony@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig29BB61CF1584A275229AEB3F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Anthony Sharobaiko wrote:
> On Mon, Dec 04, 2006 at 04:22:46PM +0100, Jan Kiszka wrote:
>> You said you merged the patch for 2.6.15 on 2.6.16 and applied some
>> hunks manually. Did you check that the merge is obviously not hiding a=
ny
>> functional changes of the kernel?
>=20
> Well, I looked through all places with fuzz > 1. Some of them were not
> very clear to me, and when that test passed, I've decided I made them o=
k =3D)

As Gilles remarked, it might be a problem in the syscall part. Your
I-pipe test is kernel-only.

> I'll check them again and post (to adeos-main@ ?).

Yep, adeos-main is appropriate. You can add xenomai-core in CC.

>=20
>> Do you have a chance to test a 2.6.15 kernel as well to see if this wo=
rks?
>=20
> Unforunately, no. Vendor-specific patch is available only for 2.6.16.

Yeah, as usual. :)

Jan


--------------enig29BB61CF1584A275229AEB3F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFdEsSniDOoMHTA+kRAt/XAJ9uA9FP2d1JEz0exU0uZCPD5CESxACdEtaS
mZFbZ4RJbwzxi2xgNWt5F+k=
=8Hbs
-----END PGP SIGNATURE-----

--------------enig29BB61CF1584A275229AEB3F--

