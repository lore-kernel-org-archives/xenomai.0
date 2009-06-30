Message-ID: <4A4A5B53.7070208@domain.hid>
Date: Tue, 30 Jun 2009 20:37:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig16076A4BDAE1C18D416128E3"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [Pull Request] trivial warning fix
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
--------------enig16076A4BDAE1C18D416128E3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

The following changes since commit cdc03ba796e72a93668cfe0eeb666b16017b6a=
97:
  Jan Kiszka (1):
        comedi: Fix build breakage due to typos

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-upstream

Jan Kiszka (1):
      posix: Fix build warning with dlopen support enabled

 src/skins/posix/init.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

---

commit c09ace348560c30754bbd1b480a838eb619600ac
Author: Jan Kiszka <jan.kiszka@domain.hid>
Date:   Tue Jun 30 20:33:44 2009 +0200

    posix: Fix build warning with dlopen support enabled
   =20
    Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>

diff --git a/src/skins/posix/init.c b/src/skins/posix/init.c
index 9c58c9b..415997f 100644
--- a/src/skins/posix/init.c
+++ b/src/skins/posix/init.c
@@ -49,8 +49,9 @@ void __init_posix_interface(void)
 {
 #ifndef CONFIG_XENO_LIBS_DLOPEN
 	struct sched_param parm;
+	int policy;
 #endif /* !CONFIG_XENO_LIBS_DLOPEN */
-	int muxid, err, policy;
+	int muxid, err;
=20
 	muxid =3D
 	    xeno_bind_skin(PSE51_SKIN_MAGIC, "POSIX", "xeno_posix");


--------------enig16076A4BDAE1C18D416128E3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkpKW1oACgkQniDOoMHTA+mvCwCcDIDh1e50FZyp5iUTqomGCjuM
8doAniYKOcJJhk3NAHlWdvAgauhHvUFK
=fnQK
-----END PGP SIGNATURE-----

--------------enig16076A4BDAE1C18D416128E3--

