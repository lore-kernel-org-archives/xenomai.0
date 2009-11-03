Message-ID: <4AF0B4B4.3020609@domain.hid>
Date: Tue, 03 Nov 2009 23:54:44 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAD084DE36831CC9675A28883"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [pull request] rtdm: Add padding to rtser_config
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>, Paolo Bernini <paolo.bernini@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAD084DE36831CC9675A28883
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The following changes since commit 6b1a185b460765c933b17932d77be6967d2e42=
dc:
  Philippe Gerum (1):
        nucleus: fix locking in shared heap deletion

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-upstream

Jan Kiszka (1):
      rtdm: Add padding to rtser_config

 include/rtdm/rtserial.h |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

---

rtdm: Add padding to rtser_config

The current layout of rtser_config is unfortunate as it may result in
different layout depending on the compiler alignment setting. Namely,
rx_timeout may be aligned on 8-byte boundaries in user land while it may
not be aligned in the kernel, or vice versa.

Avoid this ambiguity by adding a reserved padding field. Bump profile
revision number due to ABI breakage.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/rtdm/rtserial.h |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/rtdm/rtserial.h b/include/rtdm/rtserial.h
index 30bb564..48712b2 100644
--- a/include/rtdm/rtserial.h
+++ b/include/rtdm/rtserial.h
@@ -29,7 +29,7 @@
  * Feel free to comment on this profile via the Xenomai mailing list
  * (Xenomai-core@domain.hid) or directly to the author (jan.kiszka@domain.hid).=

  *
- * @b Profile @b Revision: 2
+ * @b Profile @b Revision: 3
  * @n
  * @n
  * @par Device Characteristics
@@ -79,7 +79,7 @@
=20
 #include <rtdm/rtdm.h>
=20
-#define RTSER_PROFILE_VER		2
+#define RTSER_PROFILE_VER		3
=20
 /*!
  * @anchor RTSER_DEF_BAUD   @name RTSER_DEF_BAUD
@@ -263,6 +263,8 @@ typedef struct rtser_config {
 	/** reception FIFO interrupt threshold, see @ref RTSER_FIFO_xxx */
 	int		fifo_depth;
=20
+	int		reserved;
+
 	/** reception timeout, see @ref RTSER_TIMEOUT_xxx for special
 	 *  values */
 	nanosecs_rel_t	rx_timeout;
--=20
1.6.0.2


--------------enigAD084DE36831CC9675A28883
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrwtLoACgkQitSsb3rl5xRPwwCfeNNbA5Ac8/gkD/99Z4shI6Wx
L4AAoJCGaecNySDaig8+9VVVzX/6Dbfr
=V1Re
-----END PGP SIGNATURE-----

--------------enigAD084DE36831CC9675A28883--

