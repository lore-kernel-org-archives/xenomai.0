Message-ID: <43CD16C8.4000009@domain.hid>
Date: Tue, 17 Jan 2006 17:09:44 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF6CE8BBB636F2F76789E9A8B"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] --enable-linux-build
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF6CE8BBB636F2F76789E9A8B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Gilles,

I just tested your new build option. Maybe I'm using it the wrong way,
but I stumbled over two quirks:

 o "make install-nodev" fails as it tries to install the kernel without
   being root. Actually, I only wanted to install the user space part,
   how can I do this separately? Or is this rather a use-case for the
   standard build?

 o On every "make", the prepare-kernel script is executed -
   intentionally? Maybe it would be better to provide a dedicated make
   target to trigger the update.

Thanks,
Jan


--------------enigF6CE8BBB636F2F76789E9A8B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDzRbIniDOoMHTA+kRAirWAJ4hroxDwifRNtWDnwiLg+wMaxDbqQCcCoxi
UkDlhM12CJaF8aZYivjh0VU=
=HmRl
-----END PGP SIGNATURE-----

--------------enigF6CE8BBB636F2F76789E9A8B--

