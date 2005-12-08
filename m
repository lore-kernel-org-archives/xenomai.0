Message-ID: <43982895.6000701@domain.hid>
Date: Thu, 08 Dec 2005 13:35:33 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: FW: [Xenomai-help] insmod: error inserting './xeno_posix.ko':
	-1         Unknown symbol in module
References: <000201c5fbec$8732bc70$0200000a@domain.hid>
	<439826C4.5010009@domain.hid>
In-Reply-To: <439826C4.5010009@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig369B6B73A714E1B04B55DAD1"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Martijn Hazenberg (GOVA)" <martijn@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig369B6B73A714E1B04B55DAD1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Heikki Lindholm wrote:
>=20
>> Is the order in which the modules are loaded defined or can they be
>> loaded
>> at random order ?
>=20
> Not random. First hal, then nucleus, then any of the skins. I have no
> experience with the 16550 serial module, though, and don't remember
> whether it was converted to use RTDM or not. If it wasn't, it'll
> probably come after hal, if you need it.

xeno_16550A is built on top of RTDM, so you need xeno_rtdm loaded first.
BTW, you can typically guess what module is missing by looking at the
unresolved symbol warnings in the kernel log. In case of 16550A, you
would get a bulk of unknown rtdm_xyz.

Jan



--------------enig369B6B73A714E1B04B55DAD1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDmCiVncNeS9Q0k+IRAgWEAJ4x1DfenTH47rM1UftieZT1HiMgjACg2cJV
5CIVnevvYp3cJjDkHve6xKc=
=xVol
-----END PGP SIGNATURE-----

--------------enig369B6B73A714E1B04B55DAD1--

