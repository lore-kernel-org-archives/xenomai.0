From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mnKF+/JpX0"
Content-Transfer-Encoding: 7bit
Message-ID: <18118.705.31563.238806@domain.hid>
Date: Fri, 17 Aug 2007 22:19:13 +0200
Subject: [Xenomai-core] [patch] pass xeno-test -p option to switchbench
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


--mnKF+/JpX0
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit


Hi,

when running xeno-test on ARM, I got a lock-up because xeno-test -p
option, passed to latency, is not passed to the switchbench test. The
attached patch solves this.

Regards.

-- 


					    Gilles Chanteperdrix.

--mnKF+/JpX0
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-test-pass-p-option-to-switchbench.diff"
Content-Transfer-Encoding: 7bit

Index: scripts/xeno-test.in
===================================================================
--- scripts/xeno-test.in	(revision 2930)
+++ scripts/xeno-test.in	(working copy)
@@ -191,23 +191,37 @@
 
 
 run_w_load() {
-    local opts="$*";
-    [ "$opts"  = '' ] && opts='-sh -T 120'
+    local latpass
+    local sbpass
 
+    while :; do 
+	case $1 in
+	*=*)
+	    eval $1
+	    shift;;
+	*)
+	    break;;
+	esac
+    done
+
+    latpass="$*";
+    [ "$latpass" = '' ] && latpass='-sh -T 120'
+    [ "$sbpass" = '' ] && sbpass='-h'
+
     boxinfo
     loudly generate_loads $workload
     boxstatus
     (
         cd $pkgdatadir/testsuite/latency
-	loudly ./run -- $XENOT_LATENCY $opts -t0 '# latency'
-	loudly ./run -- $XENOT_LATENCY $opts -t1 '# latency'
-	loudly ./run -- $XENOT_LATENCY $opts -t2 '# latency'
+	loudly ./run -- $XENOT_LATENCY $latpass -t0 '# latency'
+	loudly ./run -- $XENOT_LATENCY $latpass -t1 '# latency'
+	loudly ./run -- $XENOT_LATENCY $latpass -t2 '# latency'
     )
     (	cd $pkgdatadir/testsuite/switchtest
 	loudly ./run -- -T 120 $XENOT_SWITCHTEST '# switchtest'
     )
     (	cd $pkgdatadir/testsuite/switchbench
-	loudly ./run -- -h $XENOT_SWITCHBENCH '# switchbench'
+	loudly ./run -- $XENOT_SWITCHBENCH $sbpass '# switchbench'
     )
     (	cd $pkgdatadir/testsuite/cyclic
 	loudly ./run -- -p 10 -n -l 1000 $XENOT_CYCLIC '# cyclictest'
@@ -243,7 +257,8 @@
 workload=1	# default = 1 job
 
 # *pass get all legit options, except -N, -L
-pass=		# pass thru to latency
+latpass=	# pass thru to latency
+sbpass=         # pass thru to switchbench
 loadpass=	# pass thru to subshell, not to actual tests
 
 logging=	# no logging by default
@@ -280,11 +295,18 @@
 handle_options() {	# called for XENOTEST_OPTS, ARGV
     case $FOO in
 
-	# latency passthrus
-	s|h|q)
-	    pass="$pass -$FOO" ;;
-	T|l|H|B|p)
-	    pass="$pass -$FOO $OPTARG" ;;
+	# latency & switchbench passthrus
+	h)
+	    latpass="$pass -$FOO"
+	    sbpass="$sbpass -$FOO" ;;
+	p)
+	    latpass="$pass -$FOO $OPTARG"
+	    sbpass="$sbpass -$FOO $OPTARG" ;;
+	# latency only passthrus
+	s|q)
+	    latpass="$latpass -$FOO" ;;
+	T|l|H|B)
+	    latpass="$latpass -$FOO $OPTARG" ;;
 
 	# workload related
 	d) 
@@ -354,7 +376,7 @@
 wfile=$logprefix$logfile-`date $dateargs`
 if test "$logging" != "" ; then
     # restart inside a script invocation, passing appropriate args
-    script -c "`dirname $0`/xeno-test $loadpass $pass $*" $wfile
+    script -c "`dirname $0`/xeno-test $loadpass $latpass $*" $wfile
     res="$?"
     if test "$res" == "0" ; then
 	sendit $wfile
@@ -363,7 +385,7 @@
     if test "$altwork" != "" ; then
 	mkload() { exec $altwork; }
     fi
-    run_w_load $pass $* 2>&1 | tee $wfile
+    run_w_load sbpass="$sbpass" $latpass $* 2>&1 | tee $wfile
     res="$?"
     if test "$sendit" != '' && test $res -eq 0  ; then
        sendit $wfile

--mnKF+/JpX0--

