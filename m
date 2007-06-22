Message-ID: <467B898F.7050706@domain.hid>
Date: Fri, 22 Jun 2007 10:34:23 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <3480a2190706220127y44fe3323s848dd28a223c9c59@domain.hid>
In-Reply-To: <3480a2190706220127y44fe3323s848dd28a223c9c59@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigED0F7A78B38EC47F29CC6BA7"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] xenomai crashes
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: nishit sharma <sharmafrequent@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigED0F7A78B38EC47F29CC6BA7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

nishit sharma wrote:
> Hi,
> This time i am working on RTDM driver to toggle the GPIO pins. For this=
 i

Is this report a repost of the earlier one by Sanjeev Sharma (or are you
the same person)? If so, please avoid this, it just causes confusion.

> have one user program which is having RT calls used in that and the dri=
ver
> code. Now the problem i am facing is that when i insert my module and i=
 run
> my user program as background process after this when i do ls (for list=
ing)
> or not do this i get error and the kernel crashes.
> The error is like
> kernel panic- not syncing: caught machine check exception- caused by
> multiple matching entries.
>=20
> Can u suggest why this is coming.

We need more details like Xenomai/I-pipe/kernel version, architecture,
=2Econfig, and - at best - demonstration code that is compilable and
exposes the problem clearly.

Jan


--------------enigED0F7A78B38EC47F29CC6BA7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGe4mPniDOoMHTA+kRAvE/AJ44qoPNuhexL1pIIRPzYyPhBwiBWgCfZPEz
lUtXjVWQfD19C3PmBs8rtTs=
=0o6j
-----END PGP SIGNATURE-----

--------------enigED0F7A78B38EC47F29CC6BA7--

