Message-ID: <46685C21.5020709@domain.hid>
Date: Thu, 07 Jun 2007 21:27:29 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200706071049.32906.ngustavson@domain.hid>
	<200706071311.09891.ngustavson@domain.hid>
	<46684CCB.8010806@domain.hid>
	<200706071337.07691.ngustavson@domain.hid>
In-Reply-To: <200706071337.07691.ngustavson@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9E978FAB3D0799BFAEEE7AA3"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Fwd: can't use message pipe - Cannot allocate
 memory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: NZG <ngustavson@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9E978FAB3D0799BFAEEE7AA3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

NZG wrote:
>>> Write does stop throwing errors with a pool of 16384.
>> Just repeating for confirmation: rt_pipe_create with smaller, but
>> non-zero pool sizes doesn't report some error?=20
> Incorrect, if it's created with smaller it does report an error. If it'=
s=20
> created with 0 however, it seems ok. (at least it doesn't throw an erro=
r)

You mean the write fails, but rt_pipe_create is fine. At least here, and
Philippe noticed the same. Looks like the margin for minimal-sized heaps
is broken. 2*PAGE_SIZE should be 3*PAGE_SIZE net space, Philippe?

>=20
>> Pipes are asymmetric: RT<->NRT only.
> RT<->NRT is my goal.
> essentially I=20
> 1. spawn off a real time task which creates a  pipe to receive commands=

> 2. throw commands at it from the user space thread which spawned the re=
al time=20
> process (which is still NRT correct? I'm fuzzy on this).

It is NRT.

Jan


--------------enig9E978FAB3D0799BFAEEE7AA3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGaFwhniDOoMHTA+kRApv9AJ4ydH1rOUwMeuFs0K2WVdwsfJFbmACfYcq/
xtSTuFoVehYG9A46bryu1QA=
=PPLp
-----END PGP SIGNATURE-----

--------------enig9E978FAB3D0799BFAEEE7AA3--

