Message-ID: <46BB14C7.5030903@domain.hid>
Date: Thu, 09 Aug 2007 15:21:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <54803.194.114.62.34.1186665301.squirrel@domain.hid>
In-Reply-To: <54803.194.114.62.34.1186665301.squirrel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4AB8EBCAF29DE911A243156D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai kernel panic
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nadym Salem <Kaiman@domain.hid>
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4AB8EBCAF29DE911A243156D
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Nadym Salem wrote:
> Hi Jan,
>=20
> as I wanted to get the new patch for Xenomai (as discussed in rtnet
> mailing list for the rt_dev_close() issue) I had to install Xenomai 2.4=
=2E
> Xenomai 2.3.2 with Rtnet 0.9.9 didn't make any trouble.
> Since I installed 2.4 with Kernel 2.6.20 the Kernel doesn't start anymo=
re.
> We used the same config and the same kernel but now the kernel doesn't
> find the hard-disc anymore (waiting f=FCr /sys/block/sda/dev: no such f=
ile
> or directory).
> Any idea  ?

Rebuild issue? Try "make clean" before building the new kernel, or build
from a virgin kernel tree.

Otherwise, try to run the new kernel first without Xenomai being
activated to check if it is a plain I-pipe issue.

Jan


--------------enig4AB8EBCAF29DE911A243156D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGuxTHniDOoMHTA+kRAiHwAJ0SAzOABV9+Pex9KMFzHv81l89whgCeKzdk
QtWQUUQrEySBBxf/d7pvIcQ=
=ZGSm
-----END PGP SIGNATURE-----

--------------enig4AB8EBCAF29DE911A243156D--

