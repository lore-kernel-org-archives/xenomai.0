Message-ID: <46474592.3080205@domain.hid>
Date: Sun, 13 May 2007 19:06:26 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <000301c7957f$d414d9f0$fe78a8c0@domain.hid>
In-Reply-To: <000301c7957f$d414d9f0$fe78a8c0@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig121CBDCA41B2CF5A864D03F1"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Serial Port Driver (rtser): No
	RTSER_RTIOC_WAIT_EVENT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jonas@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig121CBDCA41B2CF5A864D03F1

Jonas@domain.hid wrote:
> No other ideas for me to try out? So the driver seems to get interrupts=
=2E.
> where could it possibly fail?
>=20

Interrupts on what? Only transmission or also reception? Try the
_original_ crosslink example with a nullmodem cable and two PCs (as you
only have one port on one of the boxes).

>=20
> Another question concerning xenomai's booting process.. are any files o=
ther
> than from the /boot, /lib/modules and /usr/xenomai needed for the boot
> process (because on another platform I am having some issues with booti=
ng
> when the files from the build-folder are not available while booting).
>=20

Please describe the issue more precisely. In any case, Xenomai's
userland (/usr/xenomai here) is _not_ required to get the system
running, only when you want to start the first Xenomai application.

Jan


--------------enig121CBDCA41B2CF5A864D03F1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGR0WXniDOoMHTA+kRAs5pAJ9xW3MfvoreJMcE+fLs2eu5mPv38ACePMDY
DLnw6LJ8jyYZzdiTOYm4Qj0=
=xE26
-----END PGP SIGNATURE-----

--------------enig121CBDCA41B2CF5A864D03F1--

