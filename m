Message-ID: <4450B27C.6030200@domain.hid>
Date: Thu, 27 Apr 2006 08:01:00 -0400
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060304050005080705010306"
Subject: [Xenomai-core] patch - xeno-test: set useful default for latency
	runtimes
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
--------------060304050005080705010306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

hi

bump up the latency runtime default: -T 10, to something useful, but not 
too long: -T 120.
also inform help-user of existing defaults, some of which are wired in 
latency itself.

--------------060304050005080705010306
Content-Type: text/plain;
 name="patch-test-tweaks"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-test-tweaks"

Index: scripts/xeno-test.in
===================================================================
--- scripts/xeno-test.in	(revision 1005)
+++ scripts/xeno-test.in	(working copy)
@@ -24,12 +24,12 @@
 	
   # following options are passed thru to latency
   -s	print statistics of sampled data (default on)
-  -h	print histogram of sampled data (default on)
+  -h	print histogram of sampled data (default on, implies -s)
   -q	quiet, dont print 1 sec sampled data (default on, off if !-T)
-  -T <sec test>	(default: 10 sec, for demo purposes)
-  -l <data/header lines>
-  -H <bucketcount>
-  -B <bucketsize ns>
+  -T <sec test>	(default: 120 sec)
+  -l <data/header lines> (default 21)
+  -H <bucketcount> (default 100)
+  -B <bucketsize ns> (default 1000)
 EOF
     # NB: many defaults are coded in latency
     exit 1
@@ -120,7 +120,7 @@
 
 run_w_load() {
     local opts="$*";
-    [ "$opts"  = '' ] && opts='-q -s -T 10'
+    [ "$opts"  = '' ] && opts='-q -s -T 120'
 
     boxinfo
     loudly generate_loads $workload

--------------060304050005080705010306--

