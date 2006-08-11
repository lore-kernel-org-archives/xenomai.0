Message-ID: <44DBDA2C.2000808@domain.hid>
Date: Thu, 10 Aug 2006 19:15:24 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [patch-trivial ]  fix a couple spelling errs
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

[jimc@domain.hid xenomai]$ diff -u ./ksrc/arch/i386/Kconfig{~,}
--- ./ksrc/arch/i386/Kconfig~   2006-03-23 19:06:35.000000000 -0700
+++ ./ksrc/arch/i386/Kconfig    2006-08-10 19:12:39.000000000 -0600
@@ -67,7 +67,7 @@
         and hence may not be altered.

         For this reason, Xenomai contains code to detect chipsets using
-        SMIs and optionnaly activate some workarounds to stop SMIs.
+        SMIs and optionally activate some workarounds to stop SMIs.

         Enabling this option will cause Xenomai not to try and detect whether
         your hardware use SMIs. This option is mostly useful if you know
@@ -98,7 +98,7 @@
         and hence may not be altered.

         For this reason, Xenomai contains code to detect chipsets using
-        SMIs and optionnaly activate some workarounds to stop SMIs.
+        SMIs and optionally activate some workarounds to stop SMIs.
         Enabling this option cause those workarounds to be activated.

 if XENO_HW_SMI_WORKAROUND



