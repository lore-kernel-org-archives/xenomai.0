Message-ID: <47DD3BF9.2@domain.hid>
Date: Sun, 16 Mar 2008 16:25:45 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8DE9FD24E2195885DE65341B"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] pgprot_noncached for io-remapping?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8DE9FD24E2195885DE65341B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

doesn't this patch [1] have some relevance for us as well? As we use
xnarch_remap_io_page_range also for non-IO memory, I'm hesitating to
suggest that we apply this unconditionally at xnarch level. Ideas welcome=
=2E

Jan

[1] http://permalink.gmane.org/gmane.linux.kernel/653921



--------------enig8DE9FD24E2195885DE65341B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFH3Tv8niDOoMHTA+kRAoqhAJ0QKxsgRKn8c2V+kVeJD3itTei9YwCdEVAb
L5P3Y2EIRjQIPkW98W43lAA=
=4tcc
-----END PGP SIGNATURE-----

--------------enig8DE9FD24E2195885DE65341B--

