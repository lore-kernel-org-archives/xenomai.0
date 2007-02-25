Message-ID: <45E1AD08.2020902@domain.hid>
Date: Sun, 25 Feb 2007 16:36:40 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Enhanced RTDM device closure
References: <45DC0623.3080706@domain.hid>
In-Reply-To: <45DC0623.3080706@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig62CB16CE499D4594450829B6"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig62CB16CE499D4594450829B6
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Hi,
>=20
> a few changes of the RTDM layer were committed to trunk recently. They
> make handling of RTDM file descriptors more handy:
>=20
>  o rt_dev_close/POSIX-close now polls as long as the underlying device
>    reports -EAGAIN. No more looping inside the application is required.=

>    This applies to the usual non-RT invocation of close, the corner
>    case "close from RT context" can still return EAGAIN.
>=20
>  o Automatic cleanup of open file descriptors has been implemented. Thi=
s
>    is not yet the perfect design (*), but a straightforward approach to=

>    ease the cleanup after application crashes or other unexpected
>    terminations.

 o Report file descriptor owner via /proc:

   # cat /proc/xenomai/rtdm/open_fildes
   Index   Locked  Device          Owner [PID]
   0       0       rttest0         latency [973]
   1       0       rtser0          cross-link [981]
   2       0       rtser1          cross-link [981]

Jan


--------------enig62CB16CE499D4594450829B6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF4a0IniDOoMHTA+kRAvnQAJwJScJs5DfOMt/OMN8CiN44t1t3IQCfSf/i
zbIhqASu+duU3Rs3/nTeub4=
=01gd
-----END PGP SIGNATURE-----

--------------enig62CB16CE499D4594450829B6--

