Message-ID: <4349868A.6020907@domain.hid>
Date: Sun, 09 Oct 2005 23:07:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA169BF34138BCE0DD54FFEEB"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] RTnet over Xenomai
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rtnet-users <rtnet-users@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA169BF34138BCE0DD54FFEEB
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

after some interruptions it's done now: RTnet compiles at least against
Xenomai SVN, I have not checked yet if it runs as well. Who would like
to give it a try may check-out RTnet's SVN repository.

Note that due to the required renaming, support of "old" fusion 0.9 and
0.9.1 was dropped. Earlier fusion versions were not supported anyway, as
they lack up-to-date RTDM support. And we are still looking forward to
the RTAI community completing RTDM support as well - the infrastructure
of RTnet is ready...

Have fun,
Jan

--------------enigA169BF34138BCE0DD54FFEEB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDSYaKniDOoMHTA+kRAi1nAJ9S4UR85rwJ1itssGgrbauykP9XqgCfWcZe
tm9AmiBa+0Z29YA90faDhuM=
=821a
-----END PGP SIGNATURE-----

--------------enigA169BF34138BCE0DD54FFEEB--

