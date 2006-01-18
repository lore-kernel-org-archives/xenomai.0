Message-ID: <43CE90FD.6000508@domain.hid>
Date: Wed, 18 Jan 2006 20:03:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig57BFF093B61BB10E46A6A3C1"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] broken docs
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
--------------enig57BFF093B61BB10E46A6A3C1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I noticed that the doxygen API output is partly broken. Under the
nucleus and native skin modules most functions became variables. I
haven't looked at the source yet, but I guess it should be resolvable,
especially as the RTDM docs are fine. This mail is to file the issue,
maybe I will have a look later - /maybe/.

Moreover, I was lacking a reference to RT_MUTEX_INFO. Does this
structure just needs to be added to the correct doxygen group? I guess
there are other undocumented structures out there as well (RT_TASK_INFO,
=2E..?).

Jan


--------------enig57BFF093B61BB10E46A6A3C1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDzpD9niDOoMHTA+kRArILAJ9d5lEZqsC8WcT6snNbvIBJS4HTZgCdFD2j
dAhfUqLnXWi2mIeARNXFDCw=
=Vnmi
-----END PGP SIGNATURE-----

--------------enig57BFF093B61BB10E46A6A3C1--

