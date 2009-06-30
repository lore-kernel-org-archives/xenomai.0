Message-ID: <4A49B42E.10004@domain.hid>
Date: Tue, 30 Jun 2009 08:43:58 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig268B3109C23429F19FA0BE04"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [Pull Request] Build fix for comedi
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig268B3109C23429F19FA0BE04
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The following changes since commit 7f2e2eb4f2debd5bceb723e9860deb57912e3f=
c0:
  Philippe Gerum (1):
        x86: upgrade I-pipe support to 2.6.30-x86-2.4-04 - fix

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-upstream

Jan Kiszka (1):
      comedi: Fix build breakage due to typos

 ksrc/drivers/comedi/rtdm_interface.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


--------------enig268B3109C23429F19FA0BE04
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkpJtDIACgkQniDOoMHTA+kgqgCfSB/va2wsSt+pto7JKKQMN59q
eSwAnAgM2VT+l5bD5BsASC8Fu2Sdt3vy
=aTym
-----END PGP SIGNATURE-----

--------------enig268B3109C23429F19FA0BE04--

