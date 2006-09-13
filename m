From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="whb/uWuZy5"
Content-Transfer-Encoding: 7bit
Message-ID: <17671.42827.171379.619971@domain.hid>
Date: Wed, 13 Sep 2006 08:38:03 +0200
Subject: Re: [Xenomai-core] [patch] fix xeno-test for busybox
In-Reply-To: <17671.39329.255070.115135@domain.hid>
References: <4506E6CD.5050302@domain.hid> <4506E7AC.5090508@domain.hid>
	<17671.39329.255070.115135@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>


--whb/uWuZy5
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
 > Jan Kiszka wrote:
 >  > Jan Kiszka wrote:
 >  > > Hi,
 >  > > 
 >  > > I just tried to fire up xeno-test on a busybox system - without success.
 >  > > Reason: missing getopts. But busybox initial test checks for something
 >  > > else, namely getopt. The attached patch should fix this it, also taking
 >  > > into account that getopts in a shell built-in, not an applet.
 >  > > 
 >  > 
 >  > Another quirk: switchtest runs with hard-wired -T 120...
 > 
 > Could you try the attached patch ?

A better patch.

-- 


					    Gilles Chanteperdrix.

--whb/uWuZy5
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-test-timeout.diff"
Content-Transfer-Encoding: 7bit

Index: scripts/xeno-test.in
===================================================================
--- scripts/xeno-test.in	(revision 1600)
+++ scripts/xeno-test.in	(working copy)
@@ -24,6 +24,8 @@
   -v		verbose
   -M <email>	sends output to given addr
   -m		sends output to xenomai-data@domain.hid
+  -T <sec test> do not run each test for more than <sec test> seconds (defaults
+		to 120 seconds)
   -U <url>	uploads output to given URL
   -D <datefmt>	alternate options to date, for timestamp (dflt: 
 
@@ -31,7 +33,6 @@
   -s	print statistics of sampled data (default on)
   -h	print histogram of sampled data (default on, implies -s)
   -q	quiet, dont print 1 sec sampled data (default on, off if !-T)
-  -T <sec test>		 (default: 120 sec)
   -l <data/header lines> (default 21)
   -H <bucketcount>	 (default 100)
   -B <bucketsize ns>	 (default 1000 ns)
@@ -186,10 +187,12 @@
     fi
 }
 
+timeout=120
 
 run_w_load() {
     local opts="$*";
-    [ "$opts"  = '' ] && opts='-sh -T 120'
+    [ "$opts"  = '' ] && opts='-sh'
+    opts="$opts -T $timeout"
 
     boxinfo
     loudly generate_loads $workload
@@ -201,7 +204,7 @@
 	loudly ./run -- $XENOT_LATENCY $opts -t2 '# latency'
     )
     (	cd `dirname $0`/../testsuite/switchtest
-	loudly ./run -- -T 120 $XENOT_SWITCHTEST '# switchtest'
+	loudly ./run -- -T $timeout $XENOT_SWITCHTEST '# switchtest'
     )
     (	cd `dirname $0`/../testsuite/switchbench
 	loudly ./run -- -h $XENOT_SWITCHBENCH '# switchbench'
@@ -280,9 +283,11 @@
 	# latency passthrus
 	s|h|q)
 	    pass="$pass -$FOO" ;;
-	T|l|H|B|p)
+	l|H|B|p)
 	    pass="$pass -$FOO $OPTARG" ;;
 
+	T) timeout=$OPTARG;;
+
 	# workload related
 	d) 
 	    device=$OPTARG    

--whb/uWuZy5--

