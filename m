Message-ID: <49085904.8080302@domain.hid>
Date: Wed, 29 Oct 2008 13:37:24 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] RT-Socket-CAN: correct bug with filter
	registration
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Sebastian Smolorz <Sebastian.Smolorz@domain.hid>

Hi Jan and Sebastian,

attached is the patch fixing the filter problem. I'm going to apply it
to the trunk as well if there are no complaints.

Wolfgang.

Index: ChangeLog
===================================================================
--- ChangeLog	(revision 4287)
+++ ChangeLog	(working copy)
@@ -1,3 +1,9 @@
+2008-10-29  Wolfgang Grandegger  <wg@domain.hid>
+
+	* ksrc/drivers/can/rtcan_raw_filter.c(rtcan_raw_mount_filter):
+	Applying the filter mask required for fast filter checks got lost
+	somehow with commit 2202.
+
 2008-10-28  Gilles Chanteperdrix  <gilles.chanteperdrix@xenomai.org>
 
 	* ksrc/nucleus/thread.c (xnthread_init): Change initialization
Index: ksrc/drivers/can/rtcan_raw_filter.c
===================================================================
--- ksrc/drivers/can/rtcan_raw_filter.c	(revision 4287)
+++ ksrc/drivers/can/rtcan_raw_filter.c	(working copy)
@@ -62,6 +62,9 @@
 	recv_filter->can_id = filter->can_id;
 	recv_filter->can_mask = filter->can_mask & ~CAN_INV_FILTER;
     }
+
+    /* Apply mask for fast filter check */
+    recv_filter->can_id &= recv_filter->can_mask;
 }
 
 


