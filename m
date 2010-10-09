Message-ID: <4CB04954.7010109@domain.hid>
Date: Sat, 09 Oct 2010 12:52:04 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB5558013A82C79C965053082"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [git pull] cleanups and LTTng fix for head
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB5558013A82C79C965053082
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The following changes since commit 36a0e05a86d0cd19311cd33ae9da8618cc4d0c=
55:

  posix: fix regression in clock_gettime (HOST_RT introduction) (2010-10-=
08 17:41:03 +0200)

are available in the git repository at:
  git://git.xenomai.org/xenomai-jki.git for-upstream

Jan Kiszka (3):
      Re-enable marker support for latest LTTng
      posix: Cleanup CLOCK_HOST_REALTIME
      Remove duplicate PCI ID

 include/asm-generic/pci_ids.h  |    3 ---
 include/asm-generic/wrappers.h |    9 ++++++---
 src/skins/posix/clock.c        |   15 +++------------
 3 files changed, 9 insertions(+), 18 deletions(-)


--------------enigB5558013A82C79C965053082
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAkywSVoACgkQitSsb3rl5xQQpwCcCNUZMyBwFJ3vFwjaqPdz5rsE
rogAoOGolug72rI+DVOXYBm+Kx5erM7K
=9X+J
-----END PGP SIGNATURE-----

--------------enigB5558013A82C79C965053082--

