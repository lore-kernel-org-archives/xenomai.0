Message-ID: <43873902.5050703@domain.hid>
Date: Fri, 25 Nov 2005 17:17:06 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010800090803090901080908"
Subject: [Xenomai-core] ENOMEM detection fix in 16550A driver
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

This is a multi-part message in MIME format.
--------------010800090803090901080908
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,

that's what reusing drivers also gives us: Paolo found a small but ugly
bug in the 16550A driver, see attached fix and Changelog (for both 2.0.x
and 2.1.x).

Jan


--------------010800090803090901080908
Content-Type: text/plain;
 name="16550A-ENOMEM.patch-2.0"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="16550A-ENOMEM.patch-2.0"

Index: ChangeLog
===================================================================
--- ChangeLog	(revision 182)
+++ ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+2005-11-25  Jan Kiszka <jan.kiszka@domain.hid>
+
+	* drivers/16550A/16550A.c (RTSER_RTIOC_SET_CONFIG): Fix ENOMEM detection
+        (once again). Found by Paolo Mantegazza through cross-usage.
+
 2005-11-21  Philippe Gerum  <rpm@xenomai.org>
 
 	* skins/native, nucleus/pipe.c: Globally replace ENOSPC by
Index: drivers/16550A/16550A.c
===================================================================
--- drivers/16550A/16550A.c	(revision 182)
+++ drivers/16550A/16550A.c	(working copy)
@@ -587,10 +587,9 @@
                     else
                         hist_buf =
                             rtdm_malloc(IN_BUFFER_SIZE * sizeof(uint64_t));
+                    if (!hist_buf)
+                        return -ENOMEM;
                 }
-
-                if (!hist_buf)
-                    return -ENOMEM;
             }
 
             rt_16550_set_config(ctx, config, &hist_buf);
@@ -1025,7 +1024,7 @@
     device_class:       RTDM_CLASS_SERIAL,
     device_sub_class:   RTDM_SUBCLASS_16550A,
     driver_name:        "rt_16550A",
-    driver_version:     RTDM_DRIVER_VER(1, 2, 0),
+    driver_version:     RTDM_DRIVER_VER(1, 2, 1),
     peripheral_name:    "UART 16550A",
     provider_name:      "Jan Kiszka",
 };

--------------010800090803090901080908
Content-Type: text/plain;
 name="16550A-ENOMEM.patch-2.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="16550A-ENOMEM.patch-2.1"

Index: ksrc/drivers/16550A/16550A.c
===================================================================
--- ksrc/drivers/16550A/16550A.c	(revision 182)
+++ ksrc/drivers/16550A/16550A.c	(working copy)
@@ -589,10 +589,9 @@
                     else
                         hist_buf =
                             rtdm_malloc(IN_BUFFER_SIZE * sizeof(uint64_t));
+                    if (!hist_buf)
+                        return -ENOMEM;
                 }
-
-                if (!hist_buf)
-                    return -ENOMEM;
             }
 
             rt_16550_set_config(ctx, config, &hist_buf);
@@ -1027,7 +1026,7 @@
     device_class:       RTDM_CLASS_SERIAL,
     device_sub_class:   RTDM_SUBCLASS_16550A,
     driver_name:        "rt_16550A",
-    driver_version:     RTDM_DRIVER_VER(1, 2, 0),
+    driver_version:     RTDM_DRIVER_VER(1, 2, 1),
     peripheral_name:    "UART 16550A",
     provider_name:      "Jan Kiszka",
 };

--------------010800090803090901080908--

