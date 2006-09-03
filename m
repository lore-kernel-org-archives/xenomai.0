Message-ID: <44FACF17.2020806@domain.hid>
Date: Sun, 03 Sep 2006 14:48:23 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040907090001000402050204"
Subject: [Xenomai-core] [PATCH] RTCAN bug fix
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
--------------040907090001000402050204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

attached is a patch changing:

    * ksrc/drivers/can/rtcan_dev.c (rtcan_dev_register): Bug fixed
    when maximum number of devices is exeeded.

BTW, a similar bug is present in RTnet as well.

Wolfgang.

--------------040907090001000402050204
Content-Type: text/x-patch;
 name="xenomai-rtcan-dev-enomem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-rtcan-dev-enomem.patch"

+ diff -u xenomai/ChangeLog-ENOMEM xenomai/ChangeLog
--- xenomai/ChangeLog-ENOMEM	2006-09-03 10:14:22.000000000 +0200
+++ xenomai/ChangeLog	2006-09-03 14:43:39.000000000 +0200
@@ -1,3 +1,8 @@
+2006-09-03  Wolfgang Grandegger <wg@domain.hid>
+
+	* ksrc/drivers/can/rtcan_dev.c (rtcan_dev_register): Bug fixed
+	when maximum number of devices is exeeded.
+
 2006-08-31  Gilles Chanteperdrix  <gilles.chanteperdrix@xenomai.org>
 
 	* include/asm-generic/system.h (__xnlock_get): Simplify spinlocks
+ diff -u xenomai/ksrc/drivers/can/rtcan_dev.c-ENOMEM xenomai/ksrc/drivers/can/rtcan_dev.c
--- xenomai/ksrc/drivers/can/rtcan_dev.c-ENOMEM	2006-08-23 22:12:20.000000000 +0200
+++ xenomai/ksrc/drivers/can/rtcan_dev.c	2006-09-03 12:05:23.000000000 +0200
@@ -223,13 +223,17 @@
 int rtcan_dev_register(struct rtcan_device *dev)
 {
     rtdm_lockctx_t context;
-
+    int ret;
 
     down(&rtcan_devices_nrt_lock);
 
     rtcan_global_init();
 
-    dev->ifindex = __rtcan_dev_new_index();
+    if ((ret = __rtcan_dev_new_index()) < 0) {
+        up(&rtcan_devices_nrt_lock);
+        return ret;	
+    }
+    dev->ifindex = ret;
 
     if (strchr(dev->name,'%') != NULL)
         rtcan_dev_alloc_name(dev, dev->name);

--------------040907090001000402050204--

