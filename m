Message-ID: <43E4BEF6.7040502@domain.hid>
Date: Sat, 04 Feb 2006 15:49:26 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEB9A86D190EDF3CE16E5EBD9"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] xeno_panic_trace-v2
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
--------------enigEB9A86D190EDF3CE16E5EBD9
Content-Type: multipart/mixed; boundary="------------040205030505010305030103"

This is a multi-part message in MIME format.
--------------040205030505010305030103
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

now I finally found the bug in my first version of this patch: some UVM
skin builds complained about an unknown symbol. Fixed now in this
version, please apply.

Jan

--------------040205030505010305030103
Content-Type: text/x-patch;
 name="xeno_panic_trace-v2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="xeno_panic_trace-v2.patch"

Index: include/asm-uvm/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-uvm/system.h	(Revision 528)
+++ include/asm-uvm/system.h	(Arbeitskopie)
@@ -767,4 +767,7 @@
 #define xnarch_post_graph(obj,state)
 #define xnarch_post_graph_if(obj,state,cond)
=20
+/* Ipipe-tracer */
+#define ipipe_trace_panic_freeze()
+
 #endif /* !_XENO_ASM_UVM_SYSTEM_H */
Index: include/asm-generic/system.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/asm-generic/system.h	(Revision 528)
+++ include/asm-generic/system.h	(Arbeitskopie)
@@ -39,6 +39,13 @@
 #include <asm/xenomai/atomic.h>
 #include <nucleus/shadow.h>
=20
+#ifdef CONFIG_IPIPE_TRACE
+#include <linux/ipipe_trace.h>
+#else /* !CONFIG_IPIPE_TRACE */
+#define ipipe_trace_panic_freeze()
+#define ipipe_trace_panic_dump()
+#endif /* CONFIG_IPIPE_TRACE */
+
 #define module_param_value(parm) (parm)
=20
 typedef unsigned long spl_t;
@@ -185,6 +192,7 @@
     rthal_emergency_console(); \
     xnarch_logerr("fatal: %s\n",emsg); \
     show_stack(NULL,NULL);			\
+    ipipe_trace_panic_dump();			\
     for (;;) cpu_relax();			\
 } while(0)
=20
Index: include/nucleus/types.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- include/nucleus/types.h	(Revision 528)
+++ include/nucleus/types.h	(Arbeitskopie)
@@ -107,8 +107,10 @@
=20
 #define xnpod_fatal(format,args...) \
 do { \
-   const char *panic =3D xnpod_fatal_helper(format,##args); \
-   xnarch_halt(panic); \
+    const char *panic; \
+    ipipe_trace_panic_freeze(); \
+    panic =3D xnpod_fatal_helper(format,##args); \
+    xnarch_halt(panic); \
 } while (0)
=20
 #if defined(__XENO_SIM__) || defined(__XENO_UVM__)
Index: ksrc/nucleus/shadow.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/nucleus/shadow.c	(Revision 528)
+++ ksrc/nucleus/shadow.c	(Arbeitskopie)
@@ -1563,6 +1563,7 @@
 	    testbits(status,XNSTARTED) &&
 	    testbits(status,XNPEND))
 	    {
+	    ipipe_trace_panic_freeze();
 	    show_stack(xnthread_user_task(threadin),NULL);
             xnpod_fatal("blocked thread %s[%d] rescheduled?! (status=3D0=
x%lx, sig=3D%d, prev=3D%s[%d])",
 			threadin->name,

--------------040205030505010305030103--

--------------enigEB9A86D190EDF3CE16E5EBD9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD5L73niDOoMHTA+kRAjXFAJ4iddz6MGm+fqlVm5dlgqX30dS5uQCfdsu6
VrSJXUKw6Tdw3qLbenfH4qQ=
=NnHa
-----END PGP SIGNATURE-----

--------------enigEB9A86D190EDF3CE16E5EBD9--

