Message-ID: <447E9E9E.6070301@domain.hid>
Date: Thu, 01 Jun 2006 10:00:30 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] kgdb-ipipe for 2.6.16
References: <44720BD1.805@domain.hid>
In-Reply-To: <44720BD1.805@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig17C14561EBF3E10D3908C7FA"
Sender: jan.kiszka@domain.hid
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
--------------enig17C14561EBF3E10D3908C7FA
Content-Type: multipart/mixed; boundary="------------000802000300020007060302"

This is a multi-part message in MIME format.
--------------000802000300020007060302
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> ...
> I also submit a new version of the required Xenomai extension.
> Hopefully, I managed to integrate it more cleanly this time.
>=20

I did not meet this goal as I found out on my own. So here is revision 3
of the Xenomai kgdb patch, now no longer breaking uvm or the simulator.

Jan

--------------000802000300020007060302
Content-Type: text/x-patch;
 name="xeno-kgdb-v3.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="xeno-kgdb-v3.patch"

Index: include/asm-uvm/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-uvm/system.h	(Revision 1142)
+++ include/asm-uvm/system.h	(Arbeitskopie)
@@ -787,4 +787,9 @@ static inline void xnarch_sysfree (void=20
 /* Ipipe-tracer */
 #define ipipe_trace_panic_freeze()
=20
+/* kgdb hooks */
+#define xnarch_hook_safe_current(handler)       do { } while (0)
+#define xnarch_release_safe_current()           do { } while (0)
+#define XNARCH_DECLARE_SAFE_CURRENT(handler)
+
 #endif /* !_XENO_ASM_UVM_SYSTEM_H */
Index: include/asm-generic/hal.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-generic/hal.h	(Revision 1142)
+++ include/asm-generic/hal.h	(Arbeitskopie)
@@ -573,6 +573,25 @@ struct proc_dir_entry *__rthal_add_proc_
 					      struct proc_dir_entry *parent);
 #endif /* CONFIG_PROC_FS */
=20
+#ifdef CONFIG_KGDB
+#include <linux/kgdb.h>
+
+#define rthal_hook_safe_current(handler) \
+    ipipe_safe_current =3D handler
+#define rthal_release_safe_current() \
+    ipipe_safe_current =3D ipipe_default_current
+
+#define RTHAL_DECLARE_SAFE_CURRENT(handler) \
+static struct task_struct *handler(void) \
+{ \
+    return do_##handler(); \
+}
+#else /* !CONFIG_KGDB */
+#define rthal_hook_safe_current(handler)	do { } while (0)
+#define rthal_release_safe_current()		do { } while (0)
+#define RTHAL_DECLARE_SAFE_CURRENT(handler)
+#endif /* CONFIG_KGDB */
+
 #ifdef __cplusplus
 }
 #endif /* __cplusplus */
Index: include/asm-generic/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-generic/system.h	(Revision 1142)
+++ include/asm-generic/system.h	(Arbeitskopie)
@@ -669,4 +669,10 @@ static inline void xnarch_init_heapcb (x
 #define xnarch_post_graph(obj,state)
 #define xnarch_post_graph_if(obj,state,cond)
=20
+/* kgdb hooks */
+#define xnarch_hook_safe_current(handler)   rthal_hook_safe_current(hand=
ler)
+#define xnarch_release_safe_current         rthal_release_safe_current
+#define XNARCH_DECLARE_SAFE_CURRENT(handler) \
+    RTHAL_DECLARE_SAFE_CURRENT(handler)
+
 #endif /* !_XENO_ASM_GENERIC_SYSTEM_H */
Index: include/asm-sim/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-sim/system.h	(Revision 1142)
+++ include/asm-sim/system.h	(Arbeitskopie)
@@ -765,6 +765,11 @@ while(0)
 /* Ipipe-tracer */
 #define ipipe_trace_panic_freeze()
=20
+/* kgdb hooks */
+#define xnarch_hook_safe_current(handler)       do { } while (0)
+#define xnarch_release_safe_current()           do { } while (0)
+#define XNARCH_DECLARE_SAFE_CURRENT(handler)
+
 #ifndef PAGE_SIZE
 #define PAGE_SIZE sysconf(_SC_PAGESIZE)
 #endif /* !PAGE_SIZE */
Index: ksrc/nucleus/pod.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/pod.c	(Revision 1142)
+++ ksrc/nucleus/pod.c	(Arbeitskopie)
@@ -234,6 +234,13 @@ static void xnpod_flush_heap(xnheap_t *=20
     xnarch_sysfree(extaddr, extsize);
 }
=20
+#define do_safe_current() \
+({ \
+    xnpod_userspace_p() ? current : &init_task; \
+}}
+
+XNARCH_DECLARE_SAFE_CURRENT(safe_current);
+
 /*!=20
  * \fn int xnpod_init(xnpod_t *pod,int minpri,int maxpri,xnflags_t flags=
)
  * \brief Initialize a new pod.
@@ -373,6 +380,7 @@ int xnpod_init(xnpod_t *pod, int minpri,
        the remaining operations. */
=20
     nkpod =3D pod;
+    xnarch_hook_safe_current(safe_current);
=20
     /* No direct handler here since the host timer processing is
        postponed to xnintr_irq_handler(), as part of the interrupt
@@ -477,6 +485,7 @@ int xnpod_init(xnpod_t *pod, int minpri,
=20
         if (err) {
           fail:
+            xnarch_release_safe_current();
             nkpod =3D NULL;
             return err;
         }
@@ -607,6 +616,7 @@ void xnpod_shutdown(int xtype)
=20
     xnheap_destroy(&kheap, &xnpod_flush_heap, NULL);
=20
+    xnarch_release_safe_current();
     nkpod =3D NULL;
=20
   unlock_and_exit:

--------------000802000300020007060302--

--------------enig17C14561EBF3E10D3908C7FA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEfp6eniDOoMHTA+kRAlhSAJ9ZQSfBpejpAg1jaRBXSeV0nfp2+QCcDZNW
i0iC773UtkuQdZx+3sPGh9s=
=Q+ni
-----END PGP SIGNATURE-----

--------------enig17C14561EBF3E10D3908C7FA--

