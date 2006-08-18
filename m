Message-ID: <44E5F0B4.8070405@domain.hid>
Date: Fri, 18 Aug 2006 10:54:12 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
References: <44DA896F.9060102@domain.hid> <44DB1865.90004@domain.hid>
	<44DB9958.10109@domain.hid> <44DCAF88.2060801@domain.hid>
In-Reply-To: <44DCAF88.2060801@domain.hid>
Content-Type: multipart/mixed; boundary="------------090800090707010206040103"
Subject: [Xenomai-core] Re: Test, benchmark
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------090800090707010206040103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Hi all,
>
> Jim raised these issues nicely to a generic level. I would like to pick
> it up and add some thoughts.
>
> Jim Cromie wrote:
>   
>> ...
>> FWIW, I noted that xeno-test is not running these:
>> - switchbench
>> - switchtest
>> - irqbench
>>
>> Im not sure they belong in xeno-test though, since they dont
>> appear to produce output that shows good vs bad performance,
>> only an informal 'sanity' check.
>>     
>
> Including switchtest depends on if xeno-test should also do some
> elementary stability tests. This can be derived from performance tests
> as well, but Gilles' switchtest does it for the various switching
> constellations more systematically.
>
> Including irqbench is more tricky as "real" hardware and a second box
> are always involved here (so far it only works over null-modem, need to
> be extended to some GPIOs or parallel port).
>
>   

just responding to small part now..

this patch adds switchtest, switchbench (and drops switch) and irqbench.

each test-prog has a corresponding $XENOT_<progname>
with which you can inject new test arguments individually.
Most of these can be undef'd, except for XENOT_IRQBENCH,
which needs to be set in order for test to run (since the test requires
additional resources, as you noted above)

WRT switchtest, the -T option is useful, and makes its inclusion 
possible :-)
xeno-test adds -T 120, which you can override as follows

XENOT_SWITCHTEST='-T 300'
# other useful ones
XENOT_CYCLIC='-v'   # make it verbose

Fri Aug 18 07:06:20 MDT 2006
running: ./run -- -n -T 120 # switchtest
*
*
* Type ^C to stop this application.
*
*
[ 1574.162754] Xenomai: starting RTDM services.
cpu 0: 2079 context switches.
cpu 0: 4212 context switches.
cpu 0: 6336 context switches.
cpu 0: 8442 context switches.
...
cpu 0: 246981 context switches.
cpu 0: 249096 context switches.
cpu 0: 250263 context switches.
[ 1698.479703] Xenomai: stopping RTDM services.

wrt the data emitted, what can we learn from the numbers ?
They look to be increasing linearly, with some noise/perturbations.
We could do some statistics, but whats useful ?
Histogramming, averaging the delta-context-switches ?

Also, I see from the help-text that it does many kinds of context switches.
Does it make sense to run each kind for a bunch of samples,
so that we can see # and variation for each kind of switch ?


Other things (for other emails)

1 - one more stats/histogram suggests that it should be in a library
or at least a separate object-file.    Any thoughts / prefs / advice ?
Perhaps a 'do it the way I did in <X>'

2 - I believe Ive tracked down xeno-test's problem cleaning up workloads.
mkload is missing an 'exec', so the collected pid is that of an intermediate
shell, which is either killed, or goes away by itself, leaving the actual
workload reparented to init.  Ive got the spawn-cleanup mechanics working
in a separate script that works -
a -  it respawns tasks that have finished
    forex  dd if=/dev/hda1 of=/dev/null
    will complete, since hda1 is a finite device ( unlike /dev/zero )
b - it kills the tasks it started before it exits.
c - but needs more testing..


--------------090800090707010206040103
Content-Type: text/plain;
 name="diff-xt-newtests"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-xt-newtests"

Index: scripts/xeno-test.in
===================================================================
--- scripts/xeno-test.in	(revision 1453)
+++ scripts/xeno-test.in	(working copy)
@@ -1,7 +1,9 @@
 #! /bin/sh
-# Adapted to be run also under the BusyBox. If you want to test it under the BusyBox use
-# busybox sh xeno-test 
-# A BusyBox >= 1.1.3 with a make defconfig should provide all needed applets.
+
+# Adapted to be run also under the BusyBox. 
+# If you want to test it this way, do: sh xeno-test
+# BusyBox >= 1.1.3 with a make defconfig should provide all needed applets.
+
 myusage() {
     cat >&1 <<EOF
 xeno-test [options]
@@ -190,16 +192,30 @@
     boxstatus
     (
         cd `dirname $0`/../testsuite/latency
-	loudly ./run --  $opts -t0
-	loudly ./run --  $opts -t1
-	loudly ./run --  $opts -t2
+	loudly ./run -- $XENOT_LATENCY $opts -t0 '# latency'
+	loudly ./run -- $XENOT_LATENCY $opts -t1 '# latency'
+	loudly ./run -- $XENOT_LATENCY $opts -t2 '# latency'
     )
-    (	cd `dirname $0`/../testsuite/switch
-	loudly ./run --  '# switch'
+    (	cd `dirname $0`/../testsuite/switchtest
+	loudly ./run -- -n -T 120 $XENOT_SWITCHTEST '# switchtest'
     )
+    (	cd `dirname $0`/../testsuite/switchbench
+	loudly ./run -- -p 10 -n -l 1000 $XENOT_SWITCHBENCH '# switchbench'
+    )
     (	cd `dirname $0`/../testsuite/cyclic
-	loudly ./run -- -p 10 -n -l 1000 '# cyclictest'
+	loudly ./run -- -p 10 -n -l 1000 $XENOT_CYCLIC '# cyclictest'
     )
+
+    if [ "$XENOT_IRQBENCH" != "" ] ; then
+	(
+	    cd `dirname $0`/../testsuite/irqbench
+	    loudly ./run -- -P 10 $XENOT_IRQBENCH -t0 '# irqbench user'
+	    loudly ./run -- -P 10 $XENOT_IRQBENCH -t1 '# irqbench kernel'
+	    loudly ./run -- -P 10 $XENOT_IRQBENCH -t2 '# irqbench irq-handler'
+	    loudly ./run -- -P 10 $XENOT_IRQBENCH -t3 '# irqbench hard-irq-handler'
+	)
+    fi
+
     boxstatus
     cleanup_load
 }

--------------090800090707010206040103--

