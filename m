Message-ID: <43581E3B.7050005@domain.hid>
Date: Fri, 21 Oct 2005 00:46:19 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig155F5EB9D17F4860F02D5B0E"
Subject: [Xenomai-core] [patch] rtdm without CONFIG_XENO_OPT_PERVASIVE
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig155F5EB9D17F4860F02D5B0E
Content-Type: multipart/mixed; boundary="------------000702070606080507040800"

This is a multi-part message in MIME format.
--------------000702070606080507040800
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

this fixes an unresolved symbol in xeno_rtdm when
CONFIG_XENO_OPT_PERVASIVE is switched off.

Jan

--------------000702070606080507040800
Content-Type: text/plain;
 name="rtdm-no-opt_pervasive.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtdm-no-opt_pervasive.patch"

Index: skins/rtdm/device.c
===================================================================
--- skins/rtdm/device.c	(Revision 53)
+++ skins/rtdm/device.c	(Arbeitskopie)
@@ -30,7 +30,6 @@
 
 #include <rtdm/device.h>
 #include <rtdm/proc.h>
-#include <rtdm/syscall.h>
 
 
 #define SET_DEFAULT_OP(device, operation)                               \
@@ -68,6 +67,12 @@
 #endif /* CONFIG_SMP */
 
 
+int rtdm_no_support(void)
+{
+    return -ENOSYS;
+}
+
+
 static inline int get_name_hash(const char *str, int limit, int hashkey_mask)
 {
     int hash = 0;
Index: skins/rtdm/GNUmakefile.am
===================================================================
--- skins/rtdm/GNUmakefile.am	(Revision 53)
+++ skins/rtdm/GNUmakefile.am	(Arbeitskopie)
@@ -10,9 +10,12 @@
 	device.c \
 	drvlib.c \
 	module.c \
-	proc.c \
-	syscall.c
+	proc.c
 
+if CONFIG_XENO_OPT_PERVASIVE
+libmodule_SRC += syscall.c
+endif
+
 include_HEADERS = \
 	rtdm.h \
 	rtdm_driver.h \
Index: skins/rtdm/device.h
===================================================================
--- skins/rtdm/device.h	(Revision 53)
+++ skins/rtdm/device.h	(Arbeitskopie)
@@ -40,6 +40,8 @@
 extern struct list_head *rtdm_protocol_devices;
 
 
+int rtdm_no_support(void);
+
 struct rtdm_device *get_named_device(const char *name);
 struct rtdm_device *get_protocol_device(int protocol_family, int socket_type);
 
Index: skins/rtdm/syscall.c
===================================================================
--- skins/rtdm/syscall.c	(Revision 53)
+++ skins/rtdm/syscall.c	(Arbeitskopie)
@@ -26,12 +26,6 @@
 int __rtdm_muxid;
 
 
-int rtdm_no_support(void)
-{
-    return -ENOSYS;
-}
-
-
 static int sys_rtdm_fdcount(struct task_struct *curr, struct pt_regs *regs)
 {
     return fd_count;
Index: skins/rtdm/syscall.h
===================================================================
--- skins/rtdm/syscall.h	(Revision 53)
+++ skins/rtdm/syscall.h	(Arbeitskopie)
@@ -46,8 +46,6 @@
 extern int __rtdm_muxid;
 
 
-int rtdm_no_support(void);
-
 int __init rtdm_syscall_init(void);
 
 static inline void rtdm_syscall_cleanup(void)

--------------000702070606080507040800--

--------------enig155F5EB9D17F4860F02D5B0E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDWB47ncNeS9Q0k+IRAm4wAKCVeUGSy+pwSyZapxKCsliRXLA2fACfX32H
rrkF9GFYMhh0b4uwN5wUJoQ=
=Gf6u
-----END PGP SIGNATURE-----

--------------enig155F5EB9D17F4860F02D5B0E--

