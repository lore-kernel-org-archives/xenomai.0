Message-ID: <48B313B5.9050308@domain.hid>
Date: Mon, 25 Aug 2008 22:19:01 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFD8D658A5E5440EDBF81BB57"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] xnregistry_fetch & friends
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
--------------enigFD8D658A5E5440EDBF81BB57
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

trying to select a sane kernel-side looking scheme for fast native
mutexes, I had a closer look at the registry usage in that skin (and
many others). The typical pattern is

object =3D xnregistry_fetch(handle);
perform_operation(object);

There is no lock around those two, both services do nklock acquisition
only internally. So this is a bit racy against concurrent object
destruction and memory releasing / object reconstruction. Well, I guess
the rational is: we test against object magics and the underlying memory
is normally not vanishing (immediately) on destruction, right? Remains
just object reconstruction. Not a real-life issue?

But then I wonder

 a) why xnregistry_fetch uses nklock at all (even for totally uncritical
    XNOBJECT_SELF!)

 b) what the ideas/plans on unused xnregistry_put/get are.

Jan


--------------enigFD8D658A5E5440EDBF81BB57
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkizE7oACgkQniDOoMHTA+nhGQCfVQDkd59z78VESWHvbWY0rHzv
S6wAn2ooHDejtQJOD5SrqcaHKsPUy601
=07ew
-----END PGP SIGNATURE-----

--------------enigFD8D658A5E5440EDBF81BB57--

