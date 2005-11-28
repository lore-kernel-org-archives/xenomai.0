Message-ID: <438AAEC9.7070703@domain.hid>
Date: Mon, 28 Nov 2005 08:16:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE750D54A5745EF0BC046216C"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] NMI-watchdog related fixes
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
--------------enigE750D54A5745EF0BC046216C
Content-Type: multipart/mixed; boundary="------------080400060003040302050203"

This is a multi-part message in MIME format.
--------------080400060003040302050203
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

some fixes related to warnings when you switch on Xenomai's NMI watchdog.

Jan

--------------080400060003040302050203
Content-Type: text/x-patch;
 name="nmi-wd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nmi-wd.patch"

Index: include/asm-i386/system.h
===================================================================
--- include/asm-i386/system.h	(Revision 191)
+++ include/asm-i386/system.h	(Arbeitskopie)
@@ -602,9 +602,11 @@
        handler would simply occur after 4 billions ticks. */
     rthal_timer_program_shot(rthal_imuldiv(delay,RTHAL_TIMER_FREQ,RTHAL_CPU_FREQ));
 #ifdef CONFIG_XENO_HW_NMI_DEBUG_LATENCY
-    extern unsigned long rthal_maxlat_tsc;
-    if (delay <= (ULONG_MAX - rthal_maxlat_tsc))
-        rthal_nmi_arm(delay + rthal_maxlat_tsc);
+    {
+        extern unsigned long rthal_maxlat_tsc;
+        if (delay <= (ULONG_MAX - rthal_maxlat_tsc))
+            rthal_nmi_arm(delay + rthal_maxlat_tsc);
+    }
 #endif /* CONFIG_XENO_HW_NMI_DEBUG_LATENCY */
 }
 
Index: ChangeLog
===================================================================
--- ChangeLog	(Revision 191)
+++ ChangeLog	(Arbeitskopie)
@@ -1,3 +1,11 @@
+2005-11-28  Jan Kiszka <jan.kiszka@domain.hid>
+
+	* ksrc/arch/i386/Kconfig: Fixed XENO_HW_NMI_DEBUG_LATENCY_MAX
+	kconfig type.
+
+	* include/asm-i386/system.h, ksrc/arch/i386/hal.c: Fixed
+	harmless compiler warnings.
+
 2005-11-25  Jan Kiszka <jan.kiszka@domain.hid>
 
 	* ksrc/skins/native/{pipe.c,syscall.c}, src/skins/native/pipe.c,
Index: ksrc/arch/i386/Kconfig
===================================================================
--- ksrc/arch/i386/Kconfig	(Revision 191)
+++ ksrc/arch/i386/Kconfig	(Arbeitskopie)
@@ -81,8 +81,8 @@
 
 config XENO_HW_NMI_DEBUG_LATENCY_MAX
         depends XENO_HW_NMI_DEBUG_LATENCY
-        string "NMI watchdog latency threshold (us)"
-        default "100"
+        int "NMI watchdog latency threshold (us)"
+        default 100
         help
         When the timer interrupt latency goes above this threshold, the
         NMI watchdog pulls the handbrake.
Index: ksrc/arch/i386/hal.c
===================================================================
--- ksrc/arch/i386/hal.c	(Revision 191)
+++ ksrc/arch/i386/hal.c	(Arbeitskopie)
@@ -175,6 +175,8 @@
 }
 
 #ifdef CONFIG_XENO_HW_NMI_DEBUG_LATENCY
+#include <asm/nmi.h>
+
 unsigned long rthal_maxlat_tsc;
 EXPORT_SYMBOL(rthal_maxlat_tsc);
 

--------------080400060003040302050203--

--------------enigE750D54A5745EF0BC046216C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDiq7fniDOoMHTA+kRAno/AJ9fPVZiBvWhFbxXX2/T6AHv/vgw8gCdEuFL
VnShTURBo4R2F1UjqVOUaL0=
=1A6V
-----END PGP SIGNATURE-----

--------------enigE750D54A5745EF0BC046216C--

