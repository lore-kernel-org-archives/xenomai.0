Message-ID: <443E68D1.5060004@domain.hid>
Date: Thu, 13 Apr 2006 11:05:53 -0400
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050208070204080908050904"
Subject: [Xenomai-core] [patch] xeno-test: replace 'head -3' with 'head -n 3'
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

This is a multi-part message in MIME format.
--------------050208070204080908050904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


heres an untested (still, low risk) patch for xeno-test
which corrects an obsolete usage of head.


noted by Tobias Marschall on xeno-help.

--------------050208070204080908050904
Content-Type: text/plain;
 name="patch-head-n"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-head-n"

Index: scripts/xeno-test.in
===================================================================
--- scripts/xeno-test.in	(revision 924)
+++ scripts/xeno-test.in	(working copy)
@@ -90,7 +90,7 @@
     loudly cat /proc/interrupts
     loudly cat /proc/loadavg
     [ -n "$prepost" ] && loudly $prepost
-    loudly top -bn1c | head -$(( 12 + $workload ))
+    loudly top -bn1c | head -n $(( 12 + $workload ))
 }
 
 

--------------050208070204080908050904--

