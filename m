Message-ID: <4719DFD8.3030402@domain.hid>
Date: Sat, 20 Oct 2007 13:00:40 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1192641492.5973.67.camel@domain.hid>
In-Reply-To: <1192641492.5973.67.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9ACC9CBBBF2E58762E74B99E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-help] Xenomai/Blackfin upgrade
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9ACC9CBBBF2E58762E74B99E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Our Blackfin port has just been upgraded to the latest 2.6.23. The othe=
r
> good news is that we have now rebased this work over mainline kernels.
> The I-pipe patch below is an all-in-one, supporting the bf533, bf537 an=
d
> bf561 dual core boards. Any Xenomai version from 2.3.2 and on can be
> used (albeit pre 2.4-rc4 will require to fix the default calibration
> value by hand for the bf561).
>=20
> If you happen to have any of these boards at hand, and really don't kno=
w
> how to spend geek time these days, please give this a try and send some=

> feedback.
>=20
> http://download.gna.org/adeos/patches/v2.6/blackfin/adeos-ipipe-2.6.23-=
bf5xx-1.7-00.patch
>=20

Unfortunately, ipipe for bfin is still borken: my setup is 2.6.23.1 +
"uclinux mtd maps: add blackfin maps" + the ipipe patch above on a BF537
stamp. I'm running the cache calibrator over the serial console and a
hello world shell loop over telnet. When ipipe is enabled (no Xenomai)
and the calibrator is in its measurement cycle, the telnet connection
stalls. Actually, it seems the whole Linux scheduling stalls, because
when I turn this into a background loop, it doesn't make progress when
the calibrator runs. All this does not happen when I disable ipipe in
the config.

Jan


--------------enig9ACC9CBBBF2E58762E74B99E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHGd/bniDOoMHTA+kRAnb9AJ0TH8byMkQ2CFSao7Suyj6przXjNACfbi5C
a8+fYfxPmSt8qf0/JQWHeE0=
=Pfbv
-----END PGP SIGNATURE-----

--------------enig9ACC9CBBBF2E58762E74B99E--

