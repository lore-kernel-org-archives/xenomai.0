Message-ID: <440006A7.7050105@domain.hid>
Date: Sat, 25 Feb 2006 00:26:31 -0700
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
References: <C0244E4B.24F4%steve@domain.hid>
	<43FF1F62.4070102@domain.hid> <4400033B.8000808@domain.hid>
In-Reply-To: <4400033B.8000808@domain.hid>
Content-Type: multipart/mixed; boundary="------------010905050802060007050907"
Subject: [Xenomai-core] Re: [Xenomai-help] Geode performance (Was: problems
	solved)
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
--------------010905050802060007050907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jim Cromie wrote:
>
> attached is an update to xeno-test which runs latency with -t0 -t1 -t2
> I think Ive got xeno-test and xeno-test.in sync'd, that doesnt seem to 
> happen
> as part of the configure make process for me.
>
this ones slightly improved, it greps XENO out of /proc/config.gz if its 
there.

> Fri Feb 24 20:39:14 MST 2006
> running: zgrep XENO /proc/config.gz
> CONFIG_XENOMAI=y
> CONFIG_XENO_OPT_NUCLEUS=y
> CONFIG_XENO_OPT_PERVASIVE=y
> CONFIG_XENO_OPT_PIPE=y
> CONFIG_XENO_OPT_PIPE_NRDEV=32
> CONFIG_XENO_OPT_SYS_HEAPSZ=128
> # CONFIG_XENO_OPT_ISHIELD is not set
> CONFIG_XENO_OPT_STATS=y
> # CONFIG_XENO_OPT_DEBUG is not set
> # CONFIG_XENO_OPT_WATCHDOG is not set
> CONFIG_XENO_OPT_TIMING_PERIODIC=y
> CONFIG_XENO_OPT_TIMING_PERIOD=0
> CONFIG_XENO_OPT_TIMING_TIMERLAT=0
> CONFIG_XENO_OPT_TIMING_SCHEDLAT=0
> # CONFIG_XENO_OPT_SCALABLE_SCHED is not set
> CONFIG_XENO_HW_FPU=y
> # CONFIG_XENO_HW_SMI_DETECT_DISABLE is not set
> CONFIG_XENO_HW_SMI_DETECT=y
> # CONFIG_XENO_HW_SMI_WORKAROUND is not set
> CONFIG_XENO_SKIN_NATIVE=y
> CONFIG_XENO_OPT_NATIVE_REGISTRY=y
> CONFIG_XENO_OPT_NATIVE_REGISTRY_NRSLOTS=512
> CONFIG_XENO_OPT_NATIVE_PIPE=y
> CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ=4096
> CONFIG_XENO_OPT_NATIVE_SEM=y
> CONFIG_XENO_OPT_NATIVE_EVENT=y
> CONFIG_XENO_OPT_NATIVE_MUTEX=y
> CONFIG_XENO_OPT_NATIVE_COND=y
> CONFIG_XENO_OPT_NATIVE_QUEUE=y
> CONFIG_XENO_OPT_NATIVE_HEAP=y
> CONFIG_XENO_OPT_NATIVE_ALARM=y
> CONFIG_XENO_OPT_NATIVE_MPS=y
> CONFIG_XENO_OPT_NATIVE_INTR=y
> CONFIG_XENO_SKIN_POSIX=m
> # CONFIG_XENO_SKIN_PSOS is not set
> # CONFIG_XENO_SKIN_UITRON is not set
> # CONFIG_XENO_SKIN_VRTX is not set
> # CONFIG_XENO_SKIN_VXWORKS is not set
> # CONFIG_XENO_SKIN_RTAI is not set
> CONFIG_XENO_SKIN_RTDM=m
> # CONFIG_XENO_SKIN_UVM is not set
> CONFIG_XENO_DRIVERS_16550A=m
> CONFIG_XENO_DRIVERS_TIMERBENCH=m
>
> Fri Feb 24 20:39:14 MST 2006
> running: cat /proc/ipipe/Linux
> Priority=100, Id=0x00000000
> irq0-15: accepted
> irq32-33: grabbed, virtual
> irq34: passed, virtual
>
> Fri Feb 24 20:39:14 MST 2006
>   


--------------010905050802060007050907
Content-Type: text/plain;
 name="patch-xenotest-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-xenotest-2"

Index: scripts/xeno-test.in
===================================================================
--- scripts/xeno-test.in	(revision 591)
+++ scripts/xeno-test.in	(working copy)
@@ -3,7 +3,7 @@
 myusage() {
     cat >&1 <<EOF
 xeno-test [options]
-  runs latency and klatency tests
+  runs latency test in all 3 test-modes
   -w <number>	spawn N workloads (dd if=/dev/zero of=/dev/null) default=1
   -d <device>	used as alternate src in workload (dd if=$device ..)
 		The device must be mounted, and (unfortunately) cannot
@@ -79,6 +79,8 @@
     # static info, show once
     loudly cat /proc/cpuinfo | egrep -v 'bug|wp'
     loudly cat /proc/meminfo
+    [ -f /proc/config.gz ] && loudly zgrep XENO /proc/config.gz
+
     [ -d /proc/adeos ] && for f in /proc/adeos/*; do loudly cat $f; done
     [ -d /proc/ipipe ] && for f in /proc/ipipe/*; do loudly cat $f; done
 }
@@ -101,14 +103,11 @@
     boxstatus
     (
 	cd ../testsuite/latency
-	#loudly ./run -- -T 10 -s -l 5
-	loudly ./run -- -h $opts
 
-	[ -n "$prepost" ] && loudly $prepost
-	
-	cd ../klatency
-	#loudly ./run -- -T 10 -s -l 5
-	loudly ./run -- -h $opts;
+	loudly ./run --  $opts -t0
+	loudly ./run --  $opts -t1
+	loudly ./run --  $opts -t2
+
     )
     boxstatus
 }
@@ -129,7 +128,7 @@
 workload=1	# default = 1 job
 
 # *pass get all legit options, except -N, -L
-pass=		# pass thru to latency, klatency
+pass=		# pass thru to latency
 loadpass=	# pass thru to subshell, not to actual tests
 
 # if both empty means no logging
@@ -209,7 +208,7 @@
    previous results.
 
 3. added -p 'command', which runs command before, between, and after
-   the latency and klatency tests.
+   the latency tests.
 
 
 TODO:

--------------010905050802060007050907--

