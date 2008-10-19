Message-ID: <48FB79A3.5040807@domain.hid>
Date: Sun, 19 Oct 2008 20:17:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6168E239915DB1FFE4BBD12C"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] NMI watchdog on x86-64
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
--------------enig6168E239915DB1FFE4BBD12C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

can someone help my memory: What prevented us from supporting the NMI
watchdog via perfcounter also on x86-64? I'm facing a hard lock-up with
2.6.26.6 on that arch, no last words via serial console. So the watchdog
would be a nifty thing right now...

Jan


--------------enig6168E239915DB1FFE4BBD12C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkj7eaMACgkQniDOoMHTA+kB8ACfWoL5pBhxsY4+dE6ibuRGM91E
crcAnj6Fk0zadf1FfTjxuk6i0u0t87sl
=6ueL
-----END PGP SIGNATURE-----

--------------enig6168E239915DB1FFE4BBD12C--

