Message-ID: <48F505A9.7030507@domain.hid>
Date: Tue, 14 Oct 2008 22:48:41 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4A9D29258F0189B7F5D0E16D"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Warnings in ksrc/drivers/comedi/buffer.c
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4A9D29258F0189B7F5D0E16D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

are these warnings due to an unfinished highmem fix (I did not follow
all details)?

drivers/xenomai/comedi/buffer.c: In function =E2=80=98comedi_free_buffer=E2=
=80=99:
drivers/xenomai/comedi/buffer.c:49: warning: passing argument 1 of =E2=80=
=98vmalloc_to_page=E2=80=99 makes pointer from integer without a cast
drivers/xenomai/comedi/buffer.c: In function =E2=80=98comedi_alloc_buffer=
=E2=80=99:
drivers/xenomai/comedi/buffer.c:76: warning: passing argument 1 of =E2=80=
=98vmalloc_to_page=E2=80=99 makes pointer from integer without a cast
drivers/xenomai/comedi/buffer.c:88: warning: passing argument 1 of =E2=80=
=98vmalloc_to_page=E2=80=99 makes pointer from integer without a cast
drivers/xenomai/comedi/buffer.c:88: warning: assignment makes integer fro=
m pointer without a cast

If not, please fix.

Jan


--------------enig4A9D29258F0189B7F5D0E16D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkj1BbEACgkQniDOoMHTA+n0YgCeIIEB3C+pKlrcsJwFb3faImut
5nIAnjheBhftq27wKWOJa1ZBOSi0TLMw
=SEg5
-----END PGP SIGNATURE-----

--------------enig4A9D29258F0189B7F5D0E16D--

