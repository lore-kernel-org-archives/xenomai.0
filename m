From: Romain Lenglet <rlenglet@domain.hid>
Subject: Re: [Xenomai-core] [patch] fix xeno-test for busybox
Date: Wed, 13 Sep 2006 15:55:08 +0900
References: <4506E6CD.5050302@domain.hid>
	<17671.39329.255070.115135@domain.hid>
	<200609131535.05480.rlenglet@domain.hid>
In-Reply-To: <200609131535.05480.rlenglet@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Mt6BFUVypI4ds5i"
Message-Id: <200609131555.08997.rlenglet@domain.hid>
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

--Boundary-00=_Mt6BFUVypI4ds5i
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Romain Lenglet wrote:
> Gilles Chanteperdrix wrote:
> > Jan Kiszka wrote:
> >  > Jan Kiszka wrote:
> >  > > Hi,
> >  > >
> >  > > I just tried to fire up xeno-test on a busybox system -
> >  > > without success. Reason: missing getopts. But busybox
> >  > > initial test checks for something else, namely getopt.
> >  > > The attached patch should fix this it, also taking into
> >  > > account that getopts in a shell built-in, not an
> >  > > applet.
> >  >
> >  > Another quirk: switchtest runs with hard-wired -T 120...
> >
> > Could you try the attached patch ?
>
> Dumb question about your patch...
> Shouldn't you keep the -T option in the $pass variable, to
> pass it to latency?
>
>         T) timeout=$OPTARG
>             pass="$pass -T $timeout" ;;

The problem is that, if you don't put it in $pass, you must 
re-pass the latency option explicitly when logging, since it is 
no more in $pass, and is not in $loadpass. Otherwise,

script -c "`dirname $0`/xeno-test $loadpass $pass $*" $wfile

should become:

script -c "`dirname $0`/xeno-test $loadpass $pass -T $latency $*" 
$wfile


Therefore, I propose a slightly different patch. The -T option 
may be duplicated in $opts, but hopefully this is not a problem 
with the latency command?


-- 
Romain LENGLET

--Boundary-00=_Mt6BFUVypI4ds5i
Content-Type: text/x-diff;
  charset="utf-8";
  name="xeno-test-timeout.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xeno-test-timeout.diff"

--- xeno-test.in.orig	2006-09-13 15:49:31.000000000 +0900
+++ xeno-test.in	2006-09-13 15:52:50.000000000 +0900
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
@@ -280,9 +283,12 @@
 	# latency passthrus
 	s|h|q)
 	    pass="$pass -$FOO" ;;
-	T|l|H|B|p)
+	l|H|B|p)
 	    pass="$pass -$FOO $OPTARG" ;;
 
+	T) timeout=$OPTARG 
+	    pass="$pass -T $timeout" ;;
+
 	# workload related
 	d) 
 	    device=$OPTARG    

--Boundary-00=_Mt6BFUVypI4ds5i--

