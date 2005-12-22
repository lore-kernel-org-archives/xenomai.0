Message-ID: <43AB1429.2090300@domain.hid>
Date: Thu, 22 Dec 2005 22:01:29 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8D03B6594857C2CABF52C9D2"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] load librtdm without xeno_rtdm
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
--------------enig8D03B6594857C2CABF52C9D2
Content-Type: multipart/mixed; boundary="------------070002010608010909080509"

This is a multi-part message in MIME format.
--------------070002010608010909080509
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

as suggested in an earlier mail, here is a patch that - as I think -
improves the behaviour of librtdm. It will let applications start even
if the kernel services of RTDM are not available. Instead, -ENODEV or
-EAFNOSUPPORT will be returned in this case when the user tries to open
some device or socket later - just like there is no appropriate driver
loaded, which is actually true!

Please apply.

Jan

--------------070002010608010909080509
Content-Type: text/x-patch;
 name="librtdm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="librtdm.patch"

Index: src/skins/rtdm/core.c
===================================================================
--- src/skins/rtdm/core.c	(Revision 292)
+++ src/skins/rtdm/core.c	(Arbeitskopie)
@@ -18,6 +18,7 @@
 
 #include <stdarg.h>
 #include <stddef.h>
+#include <errno.h>
 
 #include <xenomai/rtdm/rtdm.h>
 #include <xenomai/rtdm/syscall.h>
@@ -27,19 +28,25 @@
 
 int rt_dev_open(const char *path, int oflag, ...)
 {
-  return XENOMAI_SKINCALL2( __rtdm_muxid,
-                            __rtdm_open,
-                            path,
-                            oflag);
+    if (__rtdm_muxid < 0)
+        return -ENODEV;
+
+    return XENOMAI_SKINCALL2( __rtdm_muxid,
+                              __rtdm_open,
+                              path,
+                              oflag);
 }
 
 int rt_dev_socket(int protocol_family, int socket_type, int protocol)
 {
-  return XENOMAI_SKINCALL3( __rtdm_muxid,
-                            __rtdm_socket,
-                            protocol_family,
-                            socket_type,
-                            protocol);
+    if (__rtdm_muxid < 0)
+        return -EAFNOSUPPORT;
+
+    return XENOMAI_SKINCALL3( __rtdm_muxid,
+                              __rtdm_socket,
+                              protocol_family,
+                              socket_type,
+                              protocol);
 }
 
 int rt_dev_close(int fd)
Index: src/skins/rtdm/init.c
===================================================================
--- src/skins/rtdm/init.c	(Revision 292)
+++ src/skins/rtdm/init.c	(Arbeitskopie)
@@ -53,9 +53,9 @@
 	case -ENOSYS:
 	case -ESRCH:
 
-	    fprintf(stderr,"Xenomai: RTDM skin or CONFIG_XENO_OPT_PERVASIVE disabled.\n");
-	    fprintf(stderr,"(modprobe xeno_rtdm.ko?)\n");
-	    exit(1);
+	    /* we ignore this and fail later when the user tries to open
+	       a device or socket. */
+	    break;
 
 	default:
 

--------------070002010608010909080509--

--------------enig8D03B6594857C2CABF52C9D2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDqxQpniDOoMHTA+kRAknYAJ0fwtAooB5JCmNllUiahMmF7up8AACeIHcI
YHV3VdGQQ96po18e8VYM9fc=
=ny77
-----END PGP SIGNATURE-----

--------------enig8D03B6594857C2CABF52C9D2--

