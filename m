Message-ID: <44678805.2000904@domain.hid>
Date: Sun, 14 May 2006 21:41:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4467860A.9020103@domain.hid>
In-Reply-To: <4467860A.9020103@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4FEDA74111FAB3166D36CB14"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [patch] kgdb for ipipe - updated version
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
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4FEDA74111FAB3166D36CB14
Content-Type: multipart/mixed; boundary="------------000505010904060306070405"

This is a multi-part message in MIME format.
--------------000505010904060306070405
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Hi all,
>=20
> here is an improved version of the kgdb-over-ipipe patch. This version
> specifically addresses the concerns Gilles brought up recently:
>=20
> o No more dependencies on Xenomai, thus also no need to have the nucleu=
s
>   compiled into the kernel. There is now a registrable handler,
>   ipipe_safe_current, which is invoked by the kgdb code to obtain
>   "current". When the xeno nucleus arms its services, it overloads this=

>   handler to always provide a valid current (either the real one or
>   init_task for kernel-only threads).
>=20
> o Replaced smp_processor_id with ipipe_processor_id in critical kgdb
>   code. I haven't tested this replacement, so no guarantees here. But s=
o
>   far it looks consistent - at least for me.
>=20
> To use the kernel debugger with Xenomai, you need the latest kgdb
> patches [1] and have to follow the attached patch series.
>=20

Oops, one patch was missing: the one to add the handler registration to
Xenomai. See attachment.

Jan

--------------000505010904060306070405
Content-Type: text/x-patch;
 name="xeno-kgdb.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="xeno-kgdb.patch"

Index: ksrc/nucleus/pod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/pod.c	(Revision 1095)
+++ ksrc/nucleus/pod.c	(Arbeitskopie)
@@ -43,6 +43,9 @@
 #include <nucleus/registry.h>
 #include <nucleus/module.h>
 #include <nucleus/ltt.h>
+#ifdef CONFIG_KGDB
+#include <linux/kgdb.h>
+#endif /* CONFIG_KGDB */
=20
 /* NOTE: We need to initialize the globals: remember that this code
    also runs over user-space VMs... */
@@ -234,6 +237,13 @@ static void xnpod_flush_heap(xnheap_t *=20
     xnarch_sysfree(extaddr, extsize);
 }
=20
+#ifdef CONFIG_KGDB
+static struct task_struct *xnpod_safe_current(void)
+{
+    return xnpod_userspace_p() ? current : &init_task;
+}
+#endif /* CONFIG_KGDB */
+
 /*!=20
  * \fn int xnpod_init(xnpod_t *pod,int minpri,int maxpri,xnflags_t flags=
)
  * \brief Initialize a new pod.
@@ -373,6 +383,9 @@ int xnpod_init(xnpod_t *pod, int minpri,
        the remaining operations. */
=20
     nkpod =3D pod;
+#ifdef CONFIG_KGDB
+    ipipe_safe_current =3D xnpod_safe_current;
+#endif /* CONFIG_KGDB */
=20
     /* No direct handler here since the host timer processing is
        postponed to xnintr_irq_handler(), as part of the interrupt
@@ -477,6 +490,9 @@ int xnpod_init(xnpod_t *pod, int minpri,
=20
         if (err) {
           fail:
+#ifdef CONFIG_KGDB
+            ipipe_safe_current =3D ipipe_default_current;
+#endif /* CONFIG_KGDB */
             nkpod =3D NULL;
             return err;
         }
@@ -607,6 +623,9 @@ void xnpod_shutdown(int xtype)
=20
     xnheap_destroy(&kheap, &xnpod_flush_heap, NULL);
=20
+#ifdef CONFIG_KGDB
+    ipipe_safe_current =3D ipipe_default_current;
+#endif /* CONFIG_KGDB */
     nkpod =3D NULL;
=20
   unlock_and_exit:

--------------000505010904060306070405--

--------------enig4FEDA74111FAB3166D36CB14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEZ4gFniDOoMHTA+kRAoJCAJ0Um2OWjJC1A7EGh9N76gXrpeh7cgCfV3Fr
OyY5rYk0oXyCFtYnK3piooo=
=eBHw
-----END PGP SIGNATURE-----

--------------enig4FEDA74111FAB3166D36CB14--

