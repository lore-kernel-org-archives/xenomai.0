Message-ID: <44AB6855.4030905@domain.hid>
Date: Wed, 05 Jul 2006 09:20:53 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig43043898B4610609AA84DE2B"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] fix swsusp for gatekeeper thread
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
--------------enig43043898B4610609AA84DE2B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

this is a convenience patch for people like me running Xenomai on their w=
orkstation or notebook. It fixes a crash that occurs on suspend to disk/r=
am via swsusp because the gatekeeper is woken up by the suspension code b=
ut has nothing to migrate then.

With this patch applied, you can now suspend your machine as long as no s=
kin is loaded, i.e. the nucleus is passive. When skins are loaded, the sy=
stem hangs on resume, maybe due to wrong hardware re-initialisation.

Jan


 include/asm-generic/wrappers.h |    3 +++
 ksrc/nucleus/shadow.c          |    2 ++
 2 files changed, 5 insertions(+)

Index: include/asm-generic/wrappers.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-generic/wrappers.h      (Revision 1281)
+++ include/asm-generic/wrappers.h      (Arbeitskopie)
@@ -161,6 +161,9 @@ struct task_struct;
 void show_stack(struct task_struct *task,
                unsigned long *sp);

+/* Process suspension */
+#define PF_NOFREEZE 0
+
 #else /* LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,5,0) */

 /* VM */
Index: ksrc/nucleus/shadow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/shadow.c       (Revision 1281)
+++ ksrc/nucleus/shadow.c       (Arbeitskopie)
@@ -53,6 +53,7 @@
 #include <nucleus/ppd.h>
 #include <nucleus/trace.h>
 #include <asm/xenomai/features.h>
+#include <asm/xenomai/wrappers.h>

 int nkthrptd;

@@ -2023,6 +2024,7 @@ int xnshadow_mount(void)
                gk->server =3D
                    kthread_create(&gatekeeper_thread, gk, "gatekeeper/%d=
",
                                   cpu);
+               gk->server->flags |=3D PF_NOFREEZE;
                wake_up_process(gk->server);
                down(&gk->sync);
        }




--------------enig43043898B4610609AA84DE2B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEq2hZniDOoMHTA+kRAuO/AJ40aBfrlQMzRkb8UMHMCQw34bgcdwCeMIrK
LVNzWRye4ocq4ZMEAINdaRg=
=KZ1b
-----END PGP SIGNATURE-----

--------------enig43043898B4610609AA84DE2B--

