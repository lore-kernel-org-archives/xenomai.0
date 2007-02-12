Message-ID: <45D093DF.1060600@domain.hid>
Date: Mon, 12 Feb 2007 17:20:47 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE
	disabled
References: <b131c9f0702120811l64e300dbu7819f7254bdc6aa0@domain.hid>
In-Reply-To: <b131c9f0702120811l64e300dbu7819f7254bdc6aa0@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAA5AB49885A09CF08E90E8F7"
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
To: vikesh rambaran <vikesh.rambaran@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAA5AB49885A09CF08E90E8F7
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

vikesh rambaran wrote:
> Hi there
>=20
> I'm using ubuntu 6.06 LTS.
> I patched a 2.6.19.1 vanilla kernel with xenomai 2.3.0 adeos
> (Processor type is Pentuim III)
> The realtime section has been left at the default settings.
>=20
> The kernel compiles and boots ok.
>=20
> Userspace Xenomai has been compiled with the --disable-x86-tsc option
>=20
> When i try to run the latency test, i get the following error
>=20
> Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled
> (modprobe xeno_native?)
>=20
> The kernel .config file shows that the native skin is supposed to be
> compiled
> into the kernel and CONFIG_SENO_OPT_PERVASIVE=3Dy
>=20
> Any help to solve this problem would be appreciated

I bet you are still running your old kernel...

Anyway, check the boot messages and the content of /proc/xenomai,
specifically .../interfaces.

Jan


--------------enigAA5AB49885A09CF08E90E8F7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF0JPfniDOoMHTA+kRAtzxAJ49VpSPve7M0X8TfYLzF1M2JpgT+ACdHodB
C1ual130gU5b8jAx+4K6QvM=
=8ypS
-----END PGP SIGNATURE-----

--------------enigAA5AB49885A09CF08E90E8F7--

