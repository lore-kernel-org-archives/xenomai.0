From: Matthias Fuchs <mfuchs@domain.hid>
Date: Tue, 12 Sep 2006 17:55:04 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609121755.04559.mfuchs@domain.hid>
Subject: [Xenomai-core] RTCAN_USE_REFCOUNT issue in rtcan_dev.h
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>

Hi Jan,

I think there's is little typo in rtcan_dev.h:

Index: rtcan_dev.h
===================================================================
--- rtcan_dev.h (revision 1564)
+++ rtcan_dev.h (working copy)
@@ -45,7 +45,7 @@
 
 /* Suppress handling of refcount if module support is not enabled
  * or modules cannot be unloaded */
-#if defined(CONFIG_MODULES) && !defined(CONFIG_MODULE_UNLOAD)
+#if defined(CONFIG_MODULES) && defined(CONFIG_MODULE_UNLOAD)
 #define RTCAN_USE_REFCOUNT
 #endif


This simple patch will allow unloading of modules.

Matthias

