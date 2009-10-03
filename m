Message-ID: <4AC77B9F.1050506@domain.hid>
Date: Sat, 03 Oct 2009 18:28:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA1922958D04CD47766D3EEEF"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PULL REQUEST] 2.6.31-x86 fixes
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA1922958D04CD47766D3EEEF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The following changes since commit 1618abf5ec6d7005ced0d4c733e7a81215bc8e=
78:
  Philippe Gerum (1):
        Arch-dependent I-pipe/x86 support for 2.6.31

are available in the git repository at:

  git://git.kiszka.org/ipipe-2.6.git queues/2.6.31-x86

Jan Kiszka (3):
      x86: Fix reboot for SMP
      x86: Fix irq_move_cleanup virtualization
      x86: Silence warning when CONFIG_INTR_REMAP is not enabled

 arch/x86/include/asm/hw_irq.h  |    1 +
 arch/x86/kernel/apic/io_apic.c |    4 ++++
 arch/x86/kernel/ipipe.c        |    4 ++--
 3 files changed, 7 insertions(+), 2 deletions(-)


PS: Patch 1 ("Fix reboot for SMP") may also be applied to 2.6.30 if
that kernel is still supported.


--------------enigA1922958D04CD47766D3EEEF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrHe7EACgkQitSsb3rl5xQQJACg1NCbZt0shzUzLVlE2vJf7CBE
PQAAoJVqc7+Q6tBZSjygkOwif5vnBjVB
=4fSt
-----END PGP SIGNATURE-----

--------------enigA1922958D04CD47766D3EEEF--

