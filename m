Message-ID: <4367C26C.8070600@domain.hid>
Date: Tue, 01 Nov 2005 12:30:52 -0700
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040800090900050907020206"
Subject: [Xenomai-core] xeno-test  etc
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
--------------040800090900050907020206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

folks,

Ive been tinkering with xeno-test, adding a bunch of
platform-info to support comparison of results from various
platforms submitted by different xenomai users.

- cat /proc/config.gz if -f /proc/config.gz
- cat /proc/cpuinfo
- cat /proc/meminfo
- cat /proc/adeos/* foreach /proc/adeos/*
- cat /proc/ipipe/* foreach /proc/ipipe/*
- xeno-config --v
- xeno-info
- (uname -a is available in xeno-config or xeno-info, dont need separately)

However, Ive gotten a bit bogged down in the workload mgmt parts;
they dont work quite the way Id like, and bash is tedious to do job 
control in scripts.

What I want:  support for 2 separate test-scenarios,
described by the latency cmdln options:

if ( -T X>0)
    workload job termination is detected and restarted.
    keeps workload conditions uniform for duration of test
    not needed for default workload - dd if=/dev/zero never finishes.
    needed for if=/dev/hda1, since partitions are finite.
       (real devices produce interrupts, so they make a better/harder test)

if ( -w1 and -T 0 )
    workload termination should end the currently running latency-test.
    runtime of latency test can be realistically compared to the same 
workload running normally.
    this sort-of turns the test inside-out; the workload becomes the 
'goal' and the latency tests are the load.


There are 2 conflicting forces (in GOF sense) driving my thinking wrt 
this script.

- We want to support busybox , /bin/ash
- we want the above features (which I havent gotten working in bash/ash yet)
- Ash doesnt support several bash features, including at least 1 used in 
xeno-test  (array vars)
- we want more features ??

Given the tedium of fixing the bash-script bugs, I ended up prepping 2 
new experiments:

- ripped most bash code out, leaving only job-control stuff.
    tinkered with it, but it still has problems.
- wrote an 'equivalent' (to above) perl version which does job-control 
(seems ok)
    perl version can run arbitrary bash loops also:
    not just     'dd if=/dev/zero of=/dev/null'
    but also   ' while true; do echo hey $$; sleep 5; done'
       or           ' cd ../../lmbench; make rerun; done'


The ash version:

AFAICT, the sticking point is waiting for work-load tasks;
shell's wait is a blocking call, so I cant use it to catch individual 
workload exits,
but I cant wait for all 3 workloads to end b4 restarting any of them. 
(load uniformity)

trapping sig CHLD almost works;
I cant recover the child pid in the handler, but perhaps I dont need it..
When I test using a dd workload, Im getting spurious signals,
and the sig-handler dumbly restarts it, but wo the pid, its hard to know
whether the signalling process is really dying, or something else ( 
which is partly what happens )

The bad behavior Im seeing now is that:
the sig-handler fires evry 5 sec, in the while 1 { sleep 5 } loop.
This suggests that Im missing something important wrt the signals.


SO:

0. is the inside-out test scenario compelling ?
1.  can anyone see whats wrong with the ash version ?
2.  do I need an intermediate  'restart & wait'  process to restart
each (possibly finite) workload,  so main process can wait on all its
children together (block til they all return)
3.  can somone see a simpler way ?
4. if the bash script cant be fixed (seems unlikely), do we want a perl 
version too ?
5. umm

tia
jimc


PS.  with all the hard work going on, I feel a bit lazy sending 2 
semi-broken
script-snippets, but..  well, I *am* lazy.

Im also sending a semi-working version of xeno-test, as promised weeks ago.
Pls dont apply, but give a look-see.

One 'controversial' addition is POD, (plain old documentation).
I think its readable as it is, and it has the virtue of not being in a 
separate file,
so its easier to maintain.   For a little flame-bait, I added -Z option,
which gives extended help (-H is taken by latency).

PPS.   long options would be nice, but is unsupported by getopts.
To use them, we'd need to do so in both xeno-test, and *latency progs,
since xeno-test passes latency options thru when it invokes *latency.
Anyone seen a version that does long options, and would work on ash & bash ?


ok, enough prattling.

--------------040800090900050907020206
Content-Type: text/plain;
 name="p-xt-c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="p-xt-c"

Index: scripts/xeno-test.in
===================================================================
--- scripts/xeno-test.in	(revision 91)
+++ scripts/xeno-test.in	(working copy)
@@ -7,8 +7,8 @@
   -w <number>	spawn N workloads (dd if=/dev/zero of=/dev/null) default=1
   -d <device>	used as alternate src in workload (dd if=$device ..)
 		The device must be mounted, and (unfortunately) cannot
-		be an NFS mount a real device (ex /dev/hda) will
-		generate interrupts
+		be an NFS mount.  A real device (ex /dev/hda) will
+		generate interrupts, /dev/zero,null will not.
   -W <script>   script is an alternate workload.  If you need to pass args
 		to your program, use quotes.  The program must clean
 		up its children when it gets a SIGTERM
@@ -18,7 +18,8 @@
   -N <name>	same as -L, but prepend "$name-" (without -L, logname="$name-")
 		prepending allows you to give a full path.
 
-  # following options are passed thru to latency, klatency
+  # following options are passed thru to latency, klatency,
+  # see testsuite/README for more info on the options	
   -s	print statistics of sampled data (default on)
   -h	print histogram of sampled data (default on)
   -q	quiet, dont print 1 sec sampled data (default on, off if !-T)
@@ -26,57 +27,85 @@
   -l <data/header lines>
   -H <bucketcount>
   -B <bucketsize ns>
+
+  -?	this help
+  -Z	more elaborate help
 EOF
     # NB: many defaults are coded in latency, klatency
     exit 1
 }
 
-#set -e	# ctrl-C's should end everything, not just subshells. 
+set -e	# ctrl-C's should end everything, not just subshells. 
 	# commenting it out may help to debug stuff.
 
-set -o notify	# see dd's finish immediately.(or not!)
+set -b -m
+# set -o monitor notify	# see dd's finish immediately.(or not!)
 
 loudly() {
+    # run command, after announcing it in an easy-to-parse format
+    [ "$1" = "-c" ] && cmt="# $2" && shift 2
     [ "$1" = "" ] && return
-    # run task after announcing it
-    echo;  date;
-    echo running: $*
-    $* &
+    # announce task
+    echo;  # date;
+    echo loudly running: $* $cmt	# cmt is empty or starts with '#'
+    $* &				# run cmd, with any extra args 
     wait $!
+    echo  by $! invoked from $$
 }
 
-# defaults for cpu workload 
-device=/dev/zero	
-typeset -a dd_jobs
+
+typeset -a dd_jobs	# array of workload jobs
 dd_jobs=()
 
-# used in generate-loads
-mkload() { exec dd if=$device of=/dev/null $* ; }
+device=/dev/zero			# -d <device>
+workload="dd if=$device of=/dev/null";	# -W 'command args'
+workct=1				# -w <count of -W jobs>
 
+mkload() {
+    eval $workload $* &
+    echo mkload by $!
+}
+
+reaper() {
+    echo something ended bang $! what $? splat $*;
+}
+
+cleanup_load() {
+    # kill the workload
+    echo killing workload pids ${dd_jobs[*]}
+    kill ${dd_jobs[*]};
+    unset dd_jobs;
+}
+
+trap cleanup_load $dd_jobs EXIT	# under all exit conditions
+
 generate_loads() {
     local jobsct=$1; shift;
+    local ct=$jobsct;
 
-    reaper() { echo something died $*; }
     trap reaper CHLD
-    trap cleanup_load EXIT	# under all exit conditions
-    
+    trap cleanup_load $dd_jobs EXIT	# under all exit conditions
+
     for (( ; $jobsct ; jobsct-- )) ; do
 	mkload &
 	dd_jobs[${#dd_jobs[*]}]=$!
     done;
 
-    echo dd workload started, pids ${dd_jobs[*]}
-}
+    echo $$ started $ct workloads: \"$workload\", pids ${dd_jobs[*]}
 
-cleanup_load() {
-    # kill the workload
-    echo killing workload pids ${dd_jobs[*]}
-    kill ${dd_jobs[*]};
-    unset dd_jobs;
+    # if we wait here for workload sub-shells, we cant run the actual
+    # tests.  But returning w/o waiting for them means that this
+    # sub-shell exits prematurely, and the exit-handler (I think)
+    # kills the shells
+
+    wait $dd_jobs;
 }
 
 boxinfo() {
     # static info, show once
+    loudly xeno-info	# includes `uname -a`
+    loudly xeno-config --v
+    [ -f /proc/config.gz ] && loudly zcat /proc/config.gz
     loudly cat /proc/cpuinfo | egrep -v 'bug|wp'
     loudly cat /proc/meminfo
     [ -d /proc/adeos ] && for f in /proc/adeos/*; do loudly cat $f; done
@@ -85,38 +114,39 @@
 
 boxstatus() {
     # get dynamic status (bogomips, cpuMhz change with CPU_FREQ)
-    loudly cat /proc/interrupts
-    loudly cat /proc/loadavg
-    [ -n "$prepost" ] && loudly $prepost
-    loudly top -bn1c | head -$(( 12 + $workload ))
+    loudly -c "$*" cat /proc/interrupts
+    loudly -c "$*" cat /proc/loadavg
+    [ -n "$prepost" ] && loudly -c "$*" $prepost
+    loudly -c "$*" top -bn1c | head -$(( 12 + $workct ))
+    loudly -c "$*" ps -efHw | cut -c8-24,51-
 }
 
 
 run_w_load() {
     local opts="$*";
-    [ "$opts"  = '' ] && opts='-q -s -T 10'
+    #[ "$opts"  = '' ] && opts='-q -s -T 10'
 
-    boxinfo
-    loudly generate_loads $workload
-    boxstatus
+    # boxinfo
+    loudly generate_loads $workct $workload &
+    loads=$?
+    boxstatus starting
     (
 	cd ../testsuite/latency
-	#loudly ./run -- -T 10 -s -l 5
-	loudly ./run -- -h $opts
+	loudly -c ulatency ./run -- -h $opts
 
-	[ -n "$prepost" ] && loudly $prepost
+	[ -n "$prepost" ] && loudly -c middle $prepost
 	
 	cd ../klatency
-	#loudly ./run -- -T 10 -s -l 5
-	loudly ./run -- -h $opts;
+	loudly -c klatency ./run -- -h $opts;
     )
-    boxstatus
+    boxstatus ending
+    kill $loads
 }
 
+### MAIN
 
+if [ -f /proc/config.gz -a -n `which zgrep` ] ; then
 
-if [ -f /proc/config.gz ] ; then
-
     # check/warn on problem configs
     
     eval `zgrep CONFIG_CPU_FREQ /proc/config.gz`;
@@ -124,10 +154,11 @@
 	echo "warning: CONFIG_CPU_FREQ=$CONFIG_CPU_FREQ may be problematic"
     fi
 
+    if zgrep 'X86_GENERIC=' /proc/config.gz; then
+	echo "warning: X86_GENERIC considered unhelpful for xenomai"
+    fi
 fi
 
-workload=1	# default = 1 job
-
 # *pass get all legit options, except -N, -L
 pass=		# pass thru to latency, klatency
 loadpass=	# pass thru to subshell, not to actual tests
@@ -137,7 +168,7 @@
 logprefix=
 prepost=	# command to run pre, and post test (ex ntpq -p)
 
-while getopts 'd:shqT:l:H:B:uLN:w:W:p:' FOO ; do
+while getopts 'd:shqT:l:H:B:uLN:w:W:p:Z' FOO ; do
 
     case $FOO in
 	s|h|q)
@@ -159,14 +190,21 @@
 	N)
 	    logprefix=$OPTARG ;;
 	w)
-	    workload=$OPTARG
+	    workct=$OPTARG
 	    loadpass="$loadpass -w $OPTARG"  ;;
 	W)
-	    altwork=$OPTARG
+	    workload=$OPTARG
 	    loadpass="$loadpass -W '$OPTARG'"  ;;
 	p)
 	    prepost=$OPTARG 
 	    loadpass="$loadpass -p '$OPTARG'"  ;;
+	Z)
+	    # extended help, given via available tools
+	    [ -n `which perldoc` ]	&& perldoc $0 && exit;
+	    # search 
+	    [ -n `which less` ]		&& less +/^=head1 $0 && exit;
+	    [ -n `which more` ]		&& more +/^=head1 $0 && exit;
+	    ;;
 	?)
 	    myusage ;;
     esac
@@ -177,57 +215,289 @@
 
 
 if [ "$logprefix$logfile" != "" ]; then
-    # restart inside a script invocation, passing all
+    # restart inside a script invocation, passing all non-logging args
     date=`date +%y%m%d.%H%M%S`
-    script -c "./xeno-test $loadpass $pass $*" "$logprefix$logfile-$date"
+
+    # create/update -latest symlink
+    [ -L $logprefix$logfile-latest ] && rm $logprefix$logfile-latest
+    dir=$logprefix$logfile
+    dir=${dir%`basename $logprefix$logfile`}    # dir gets path of symlink
+    sym=`basename $logprefix$logfile-latest`	# 
+    (cd $dir && ln -s `basename $logprefix$logfile-$date` $sym)
+
+    if [ -n `which script` ]; then
+	exec script -c "./xeno-test $loadpass $pass $*" "$logprefix$logfile-$date"
+    else
+	exec ./xeno-test $loadpass $pass $* > $logprefix$logfile-$date
+    fi
+
 else
-    if [ "$altwork" != "" ]; then
-	mkload() { exec $altwork; }
-    fi
-    echo running $0 $pass $*
+    echo running $0 $loadpass $pass $*
     run_w_load $pass $*
+    cleanup_load
+    killall dd
 fi
 
 exit;
 
 #################################################
 
-DONE:
+=head1 NAME
 
-1. added -W <program invocation>
+xeno-test - run xenomai testsuite, generate useful output
 
-The program should generate a load that is appropriately demanding
-upon cpu, interrupts, devices, etc.
+=head1 SYNOPSIS
 
-It should also work when invoked more than once, and scale the loads
-reasonably linearly (since the -w will count by N).
+  xeno-test -? 		# to see options (in brief)
+  xeno-test  		# to run with defaults
+  xeno-test -N foo	# write output to foo-<timestamp>
 
+=head1 DESCRIPTION
+
+xeno-test has these purposes:
+
+  a. provide user with 1st experience running xenomai (show it works)
+  b. output enough platform info for useful bug reports (if it doesnt)
+  c. collect info for performance analysis (how well it works)
+
+When xeno-test runs, it 1st prints available platform info, then runs
+latency and klatency tests in a manner that provides you with visual
+feedback that things work.  See testsuite/README for more info on
+those tests and their output.
+
+=head1 Capturing Output
+
+If things break, you should run xeno-test and capture output, and
+attach it to your bug-report; the platform data will answer many
+questions often asked of bug reporters.  See L<here> for bug-tracker.
+
+Or if you want to help us improve xenomai on your box, run this sctipt
+and capture the results, and email the file to us here:
+xenomai-test-results-at-gna.org.
+
+Over time, we will use the gathered data to identify performance
+regressions, and to improve performance on tested
+platforms. (including yours..;-)
+
+
+
+=head2 -N <relative-path-output-file>
+
+This calls `script -c <rpath>-$timestamp` to capture all output to a
+timestamped file.  Setting -N ~/foo will create a foo-* file in your
+HOME.
+
+If your box doesnt have 'script' installed, xeno-test just redirects
+output to a timestamped file.  'script' was thought to be better for
+catching some arcane on-screen stuff, like console output.
+
+=head2 -L
+
+Similar to -N <name> sets the name to test-`uname -r`.  This can be
+combined with -N ~/foo, which then writes ~/footest-`uname -r`-*
+files.
+
+=head1 Workload Job Control options
+
+xeno-test provides a default workload that runs in parallel with
+latency tests.
+
+=head2 -W <workload-command-or-script>
+
+This allows you to execute your own script or command to replace the
+default workload command:
+
+	device=/dev/zero
+	dd if=$device of=/dev/null
+
+For example:
+
+	xeno-test -W 'cd ~/lmbench; make run' # iirc
+
+=head2 -w <workload-job-count>
+
+This option lets you vary the number of load processes started by the
+script.  Default is 1, good for -W $benchmark runs.
+
+=head2 -d <device>
+
+This option lets you change the if=<$device> used in the default
+workload, ie:
+
+	dd if=$device of=/dev/null
+
+Your choice of device will dictate the interrupt load generated by dd;
+when if=/dev/zero, no device interrupts are generated, when
+if=/dev/hda1, my Compact-Flash drive and IDE interface create lots of
+them.  This may reveal board-specific weaknesses, ex: PIO vs MDMA,
+y/our-mmv.
+
+-d <dev> has no effect with -W <work>, as the default workload command
+(dd ..) is entirely replaced.
+
+
+=head1 k?latency pass-thru options
+
+the k?latency programs accept a number of options to control test
+parameters, theyre briefly summarized here: (xenotest -?)
+
+  # see testsuite/README for more info on the options	
+  -s	print statistics of sampled data (default on)
+  -h	print histogram of sampled data (default on)
+  -q	quiet, dont print 1 sec sampled data (default on, off if !-T)
+  -T <sec test>	(default: 10 sec, for demo purposes)
+  -l <data/header lines>
+  -H <bucketcount>
+  -B <bucketsize ns>
+
+Other than -T, I use the defaults.
+
+=head2 -p <pre-post-command>
+
+This option allows you to run a script before/after latency and
+klatency are run.  It allows you a means to observe the box-status for
+changes resulting from running the tests.
+
+For example:
+
+	xeno-test -p 'sar; iostat; vmstat'
+	xeno-test -p 'ntpq -p'
+	xeno-test -p 'ntpdate -q $anotherbox'
+
+The latter 2 attempted to characterize a clock-slip observed during
+test-runs of an early fusion (pre-xenomai) release.
+
+
 Also, if it spawns subtasks, it should end them all when it gets SIGTERM.
 
+=head1 TODO/BUGS
 
-2. added timestamp to the output filename to avoid overwriting
-   previous results.
+=head2 fix path-relative limits
 
-3. added -p 'command', which runs command before, between, and after
-   the latency and klatency tests.
+currently, xeno-test must be run from install-bin directory; some of
+the scripts it calls in turn make assumptions (xeno-load iirc).  These
+should be fixed.
 
+=head2 fix Job Control
 
-TODO:
+=head3 workloads dont get terminated properly
 
-1. get workload child reaper to work when child is killed from
-separate window, or when it finishes.  Forex, 'dd if=/dev/hda ...'
-will eventually finish, and should be restarted to keep the load up.
-Figure out why killall didnt work properly.
+I often find jobs like this lying around, meaning that workload
+cleanup doesnt always work.  I now beleive its due to running
+generate_loads in a bash subshell that then loses its mind
 
-2. Much more testing.  Heres a weak start..
+Heres a look at the job-hierarchy that this script captures (to help
+debug stuff), note that the dd jobs
 
-#!/bin/bash
-PATH=.:$PATH
-xeno-test -L
-xeno-test -N foo -T 18 -l 6 -s
-xeno-test -L -N foo1-
-xeno-test -N foo0 -w0 -l 5 -T 30 -h
-xeno-test -L -N foo4- -w4
-xeno-test -L -N foo4W- -w4 -W 'dd if=/dev/hda1 of=/dev/null'
+  14987     1  0 -bash
+  15875 14987  0   script -c ./xeno-test  -w 3 -d /dev/hda1  -T 10  /root/trucklab/FTDB/ski9-051027.234503
+  15902 15875  0     script -c ./xeno-test  -w 3 -d /dev/hda1  -T 10  /root/trucklab/FTDB/ski9-051027.234503
+  15903 15902  0       /bin/bash ./xeno-test -w 3 -d /dev/hda1 -T 10
+  16102 15903  0         /bin/bash ./xeno-test -w 3 -d /dev/hda1 -T 10
+  16104 16102  0           ps -efHw
+  16103 15903  0         cut -c8-24,51-
+  15925     1  0 /bin/bash ./xeno-test -w 3 -d /dev/hda1 -T 10
+  15934 15925 31   dd if /dev/zero of /dev/null
+  15929     1  0 /bin/bash ./xeno-test -w 3 -d /dev/hda1 -T 10
+  15935 15929 31   dd if /dev/zero of /dev/null
+  15930     1  0 /bin/bash ./xeno-test -w 3 -d /dev/hda1 -T 10
+  15946 15930 33   dd if /dev/zero of /dev/null
 
-3.
+
+
+
+root      3833     1 dd if /dev/zer
+
+=head3 restart workloads (-T > 0)
+
+Teach workload child reaper to detect termination of child, and
+restart it.  Appropriate for typical 'dd' workloads, which we want to
+keep running for duration of the test (say 8 hrs, my CF isnt that
+big).
+
+=head3  wait-for-child-then-conclude-test (-T 0)
+
+When -T 0, the k?latency tests should end when the -W <workload>
+terminates.  With this feature working, a typical benchmark script
+(lmbench, dohell, etc) would finish the test in an orderly fashion
+once the workload completed.  `time xeno-test -T 0 -W <work>` would
+then become an excellent 1st measure of kernel performance, given the
+right <work>
+
+=head2 choose good default test behaviors
+
+To improve feedback, xeno-test now runs latencies w/o -s option, so
+now user a new results-line each second.
+
+=head3 -T X
+
+1st, we want test to finish by itself, so user knows its done.  The
+script announces its expected runtimes, so we can reasonably tell the
+user 'please wait 5 minutes while test runs'.
+
+=head3 -N $USERNAME
+
+I think this option is pretty much transparent (modulo 'script'
+availability), and its use write the file automatically, lowering the
+effort-barrier.
+
+=head3 -M latency/klatency
+
+This option doesnt exist, but maybe it should.  It choses one test,
+and could be useful when running `xeno-test -T 0 -W lmbench`, esp as
+-T 0 should conclude the -M <chosen> test when lmench finishes.
+
+=head3  Info overload
+
+xeno-test currently collects a fair bit of platform-info, which is
+more than the typical user may care to see.  I hope that its speed of
+flyby will marginalize its 'cost'.
+
+xeno-test must balance the platform-info overhead against the
+"test-is-running" info that a new user cares about.  The overhead has
+recently increased (esp with /proc/config.gz), but Im reluctant to
+muzzle the script; part of the value-proposition is the possibly wide
+availability of known-quality test-results.
+
+
+=head2 New Tests
+
+We should also probably add a few options to run various batteries of
+tests, some would be gentle, others could be 12-hr torture tests
+
+I for one would welcome patches adding arbitrary invocations of
+xeno-test with its options, as long as they appear to be useful or
+interesting.  Id expect variations of -W <work> -T 0 to be ideal, esp
+when the 'wait-til-child-exits' behavior works.
+
+
+=head1 New Implementations
+
+Given the urge for script features, we must consider our platforms
+before committing to providing them;
+
+=head2 ash / busybox
+
+IIUC, busybox has a slimmer native shell that may not do job-control.
+For these, this bash version is possibly non-functional.  
+
+This might mean that a platform-fix is needed, please test if you can.
+
+=head2 bash
+
+Im finding bash fairly tedious to do job-control with;
+
+ - sub-shells preserve their command-line context, rather than
+   relabelling themselves in the process-listing when running
+   functions
+
+ - fork-exec equivalent has extra processes..
+ - trapping somehow escapes me
+ - group-leaders, lions-tigers-bears, ohmy
+
+=head2 perl
+
+Ive started hacking at perl versions which show some promise of
+solving some of the bash version\'s parent-child issues, but they have
+new problems.  Forex, one version restarts killed dd jobs nicely,
+another doesnt ($*&&^##$%).

--------------040800090900050907020206
Content-Type: text/plain;
 name="ash-sub1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ash-sub1"

#!/bin/bash

set -m
device=/dev/zero			# -d <device>
workct=1				# -w <count of -W jobs>

workload='echo hello $$; sleep 30; echo bbye';
workload='dd if=/dev/zero of=/dev/null'
#workload=$1

workpids=''

generate_loads() {
    jobsct=$1; shift;
    local ct=$jobsct;

    echo starting $jobsct jobs 

    while true ; do

	($workload )&
	workpids="$workpids $!";
	echo started $!

	ct=$(($ct - 1))
	[ $ct = 0 ] && break;
    done;
    echo $$ started  workloads: \"$workload\" pids: $workpids
}

reaper() {
    if [ -n $ending ]; then
	($workload )&
	workpids="$workpids $!";
	echo workload task ended, started a new one $!
	# ps -ef |grep dd
    fi
}

cleanup_load() {
    kill $workpids;
    echo $$ killed workload pids $workpids
    exit;
}


trap reaper CHLD
trap cleanup_load 0		# normal exit ?
trap cleanup_load TERM
trap cleanup_load INT
trap cleanup_load EXIT		# normal exit

#trap cleanup_load INT TERM KILL



echo running $$ main

generate_loads 3;

while true; do
    (sleep 5);
done



--------------040800090900050907020206
Content-Type: text/plain;
 name="pl-sub2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pl-sub2"

#!/usr/local/bin/perl -w

use IO::Select;
use Data::Dumper;
use sigtrap;
use IO::Select;
use POSIX ":sys_wait_h";

my (%pidHandles, %fhPids);	# keep both, avoid key-stringification

my $s = IO::Select->new();	# gets workload handles added to it.
my ($rd, $wr, $exc);
my $pid;

local %SIG =
    (
     CHLD => sub {
	 # catches cmd = 'sleep 30; echo yay $$'
	 my ($kid,$fh);
	 do {
	     $kid = waitpid(-1, WNOHANG);
	     print "$$ gbye chld @_ pid $kid $!\n";
	 } until $kid > 0;
	 
	 if ($pidHandles{$kid}) {
	     print "restarting workload task, retiring $kid\n";
	     $fh = delete $pidHandles{$kid};
	     delete $fhPids{"$fh"};
	     $s->remove($fh);
	     mkload();
	 }
     },
     PIPE => sub {
	 print "$$ gbye pipe @_$!\n";
	 die "$$ gbye pipe @_ $!\n";
     },
     INT => sub {
	 print "$$ gbye int @_\n";
	 die "$$ gbye int @_\n";
     },
     TERM => sub {
	 print "$$ gbye term @_\n";
	 die "$$ gbye term @_\n";
     });

my $cmd = (shift) || "dd if=/dev/zero of=/dev/null";

sub mkload {
    $! = 0;
    my $pid = open(my $fh, "$cmd |")
	or die "$! cant pipe-open '$cmd'\n";

    print "opened pid $pid, status $? $!\n";
    $pidHandles{$pid} = $fh;	# help sig-handler
    $fhPids{$fh} = $pid;	# select() lookup 
    $s->add($fh);
}

for (1..3) { mkload() }

while (1) {

    ($rd, $wr, $exc) = $s->select();
    # print "readys: ", Dumper [$rd, $wr, $exc];

    print "exc on $_ $fhPids{$_}\n" foreach @$exc;
    print "wr on $_ $fhPids{$_}\n" foreach @$wr;

    # check readables
    foreach my $h (@$rd) {
	print "$$ fh ", fileno($h);
	my $buf = <$h>;
	if ($buf) {
	    print "$fhPids{$h} says: $buf";	# has own \n
	    next;
	}
	# else rd is null, should be end ??
	$pid = delete $fhPids{$h};
	delete $pidHandles{$pid};
	print "$pid is closed\n";
	$s->remove($h);
    }
}

END { # final check: gave input

    foreach my $pid (keys %pidHandles) {
	my $fh = $pidHandles{$pid};
	warn "$$ prob w $pid $fh\n" and next  unless $fh;
	my $out = <$fh> || '';
	print "command $pid produced output <$out>\n";
    }
}


__END__

=head1 pl-sub2

Develop sub-process management needed for workload generation to
support xenomai testing.  Its maeant to help (me) understand the
shortcomings of xeno-test.pl.

=head1 Workload Process Management

Workload tasks should present a uniform demand for the kernel's
attention, and be repeatable over many tests.  There are 2 basic
scenarios for workloads

=head2 timed-test

In this test scenario, latency tests are run with "-T <N>" option, and
terminate after N seconds.  While it runs, terminating workloads
should be restarted to maintain test-conditions uniformly.

The default workload doesnt actally trigger restarts, cuz it uses
/dev/zero, which is a never-ending data source.  Unfortunately, that
source doesnt generate interrupts, thus isnt a hard test to pass.

But if you use "-d /dev/hda1", the workload task will end once
/dev/hda1 has been copied, and must be restarted to keep the
uniformity.

=head2 single workload, untimed test

This mode supports running a 'meaningful' workload (a real benchmark
test), and terminating the current latency test when it finishes.

The duration of the benchmark is the simplest measure of performance,
and 3 test-scenarios can be meaningfully compared to each other:

  1. benchmark running under latency 'load'
  2. benchmark running on ipipe kernel w/o latency 'load'
  3. benchmark on vanilla kernel

2-vs-3 shows the 'cost' of determinism vs thruput
1-vs-2 indirectly shows the latency test demands upon the CPU.


=head2 Implementation

We start the workload tasks with pipe open("$cmd|")s, and use a
select-loop to handle workload STDOUT, STDERR, and exceptions.  We
catch CHLD signals when workloads terminate, so we can restart them as
needed.  I hope the belt & suspenders approach proves adequate



Its unclear whether this is entirely workable for all unforseen
workloads, but these following invocations have tested good in tests
so far:

    perl pl-sub1 'sleep 10 ; echo yay $$'
    perl pl-sub1 'while true; do echo hay; done'
    perl pl-sub1 'while true; do sleep 5; echo hay; done'
    perl pl-sub1 'while true; do sleep 5; echo hey > out$$; done'


=head1 Limitations (not Bugs)

Only non-interactive workload/benchmarks will work properly ( the
pipes are one-way).

--------------040800090900050907020206--

