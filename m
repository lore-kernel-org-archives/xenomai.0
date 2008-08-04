Message-ID: <001b01c8f600$0c5a5a60$09201fac@domain.hid>
From: "Atsushi Katagiri" <a-katagiri@domain.hid>
Date: Mon, 4 Aug 2008 16:02:22 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] Buffer over flow in /proc/xenomai/stat
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

Hello all.

This is a small patch that fixes a serious bug.

When we open /proc/xenomai/stat, function stat_seq_open kmalloc the area, write the data and increment iter->nentries.
The last increment of this value reaches "count",
and at the next iteration "stat_info->cpu = cpu;"  overwrites zero on illegal address!

Here is my proposal of the fix..

=====patch start=====>
diff -Nur xenomai-2.4.4-org/ksrc/nucleus/module.c xenomai-2.4.4/ksrc/nucleus/module.c
--- xenomai-2.4.4-org/ksrc/nucleus/module.c 2008-06-02 00:44:48.000000000 +0900
+++ xenomai-2.4.4/ksrc/nucleus/module.c 2008-07-29 09:46:45.000000000 +0900
@@ -443,6 +443,9 @@
   int cpu = 0;
   int err;
 
+  if (iter->nentries >= count)
+   break;
+
   /* ...over all shared IRQs on all CPUs */
   while (1) {
    stat_info = &iter->stat_info[iter->nentries];
@@ -464,7 +467,9 @@
    stat_info->pf = 0;
 
    iter->nentries++;
-  };
+   if (iter->nentries >= count)
+    break;
+  }
  }
 
  seq = file->private_data;
<=====patch end=====

I hope someone who knows this function well will solve the problem.

Regards,

Atsushi KATAGIRI
Software Engineer
A&D Company, Limited
Tokyo, Japan


