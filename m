Message-ID: <444AED9A.7040009@domain.hid>
Date: Sat, 22 Apr 2006 22:59:38 -0400
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
References: <4447D9CA.9010809@domain.hid>
In-Reply-To: <4447D9CA.9010809@domain.hid>
Content-Type: multipart/mixed; boundary="------------060904060708040205030407"
Subject: [Xenomai-core] Re: xeno-test updates [patch]
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------060904060708040205030407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jim Cromie wrote:

>
>
> Ive started adding to xeno-test, as outlined previously (plus some)
>
<snipped>, except where noted

> - now run cyclictest and switch, in addition to latency -t 0,1,2
>
cycletest now has decent options passed in.
I havent given any thought to exposing options thru xeno-test's command 
line.

Instead, Im thinking of adding statistics, ala latency.
for that, Im also pondering a new -g 100 option to group the tests for 
stats-calcs,
ie given: -g 100 -l 1000 -v
it would compute statistics on 10 sets of 100 cycles, and report 10 lines.
Again, this is notional, comments/feedback needed.

> -  changed the prewired -m email-addy to xenotest.output@domain.hid
email options now work w/o actually writing a file.
Also changed default location of file writes to /tmp,
they no longer get written to $PWD by default

added a -U <url>,  completely untested, but mostly lifted from LiveCD
This looks necessary, since
    my hobby-box doesnt have a working mail setup
    my laptop (and presumably yours) doesnt have a FQDN,
        which pretty well precludes sending mail to anywhere useful.
          (Id bet we could span the unwashed winbloze masses, but wheres 
the sport in that ?  ;-)



>
> - now grep more config-items out of config (for non-verbose mode)
>   latency-killers, PREEMPT, others ?
>
added items per RPMs email.

Im considering stripping the warning issued when CPU_FREQ ia xonfig'd
warning: CONFIG_CPU_FREQ=y may be problematic.
I have it in cuz nothing actually changes (can change) it, so its 
harmless. (I think)
Its easier than making the list complete,
and the .config dump covers the reporting.
>
>
> Dont apply yet, not tested recently.
>

Its reasonbly tested; we can shake out some more with some distributed 
testing
(hint - try it !)

Heres some tests I ran, files got written..

./xeno-test -T 30 -l30 -m
./xeno-test -T 30 -l30
./xeno-test -T 30 -l30 -L
./xeno-test -T 30 -l30 -N foo
./xeno-test -T 30 -l30 -LN bar
./xeno-test -T 30 -l30 -LN buzz -m
./xeno-test -T 5 -l30 -L -m
./xeno-test -T 5 -l30 -N /tmp/box- -m
./xeno-test -T 5 -l30 -N ~/trucklab/ -w2 -W 'dd if=/dev/hda1 of=/dev/null'


> Qs
>
> - should I run boxstatus just after latency tests or b4 and after (as 
> currently) ?
>
> - /proc/xenomai/* contents are dynamic (ie run by boxstatus) ?
>
> - any bits of  boxinfo and boxstatus that should be shuffled around ?
>
> - check NPTL availability (kinda overkill, since its absence when 
> needed is already detected)
>
>
> - anything else come to mind ?


these are still open, but not crtical.


I hope thats everything for now,
it needs a good shakedown, and I need a beer.

--------------060904060708040205030407
Content-Type: text/plain;
 name="patch-xeno-test"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-xeno-test"

Index: scripts/prepare-kernel.sh
===================================================================
--- scripts/prepare-kernel.sh	(revision 974)
+++ scripts/prepare-kernel.sh	(working copy)
@@ -48,6 +48,7 @@
 patch_append() {
     file="$1"
     if test "x$output_patch" = "x"; then
+	chmod +w "$linux_tree/$file"
         cat >> "$linux_tree/$file"
     else
         if test `check_filter $file` = "ok"; then
Index: scripts/xeno-test.in
===================================================================
--- scripts/xeno-test.in	(revision 974)
+++ scripts/xeno-test.in	(working copy)
@@ -12,15 +12,18 @@
   -W <script>   script is an alternate workload.  If you need to pass args
 		to your program, use quotes.  The program must clean
 		up its children when it gets a SIGTERM
-  -p <cmd>	cmd is run before, between and after latency, klatency tests
+  -p <cmd>	cmd is run before and after rt-tests
 		(forex: 'ntpdate -b <host>' or 'ntpq -p')
-  -L	     	writes to logfile (default "test-`uname -r`") (via script)
-  -N <name>	same as -L, but prepend "$name-" (without -L, logname="$name-")
-		prepending allows you to give a full path.
-  -m		sends output file to xeno-test@domain.hid
-  -M <email>	sends output file to given addy
-
-  # following options are passed thru to latency, klatency
+  -L	     	writes logs to /tmp/test-`uname -r`-<timestamp>
+  -N <name>	like -L, but writes to name-<timestamp> (in PWD)
+		name can be full or relative pathname
+  -v		verbose
+  -M <email>	sends output to given addr
+  -m		sends output to xenotest.output@domain.hid
+  -U <url>	uploads output to given UEL
+  -u		uploads output to (TBD)
+	
+  # following options are passed thru to latency
   -s	print statistics of sampled data (default on)
   -h	print histogram of sampled data (default on)
   -q	quiet, dont print 1 sec sampled data (default on, off if !-T)
@@ -29,7 +32,7 @@
   -H <bucketcount>
   -B <bucketsize ns>
 EOF
-    # NB: many defaults are coded in latency, klatency
+    # NB: many defaults are coded in latency
     exit 1
 }
 
@@ -43,7 +46,7 @@
     # run task after announcing it
     echo;  date;
     echo running: $*
-    $* &
+    eval $* &		# eval helps w complex cmds, like zegrep -E
     wait $!
 }
 
@@ -77,20 +80,40 @@
     unset dd_jobs;
 }
 
-boxinfo() {
-    # static info, show once
-    loudly cat /proc/cpuinfo | egrep -v 'bug|wp'
-    loudly cat /proc/meminfo
-    [ -f /proc/config.gz ] && loudly zgrep XENO /proc/config.gz
+whatconf="XENO|IPIPE|PREEMPT|CONFIG_ACPI|CONFIG_PM|CPU_FREQ|CONFIG_DEBUG_SPINLOCK|CONFIG_FRAME_POINTER"
 
+
+boxinfo() { # static info, show once
+
+    loudly ./xeno-config --verbose
+    loudly ./xeno-info
+
+    loudly cat /proc/cpuinfo	# bogomips changes under CPU_FREQ
+
+    # how much of the config do we want ?
+    local cmd="zgrep -E '$whatconf'"
+    [ "$verbose" = 1 ] && cmd=cat
+
+    if [ -f /proc/config.gz ]; then	# get the config
+	loudly $cmd /proc/config.gz
+    elif [ -f /lib/modules/`uname -r`/build/.config ]; then
+	loudly $cmd /lib/modules/`uname -r`/build/.config
+    fi
+
     [ -d /proc/adeos ] && for f in /proc/adeos/*; do loudly cat $f; done
     [ -d /proc/ipipe ] && for f in /proc/ipipe/*; do loudly cat $f; done
 }
 
-boxstatus() {
-    # get dynamic status (bogomips, cpuMhz change with CPU_FREQ)
+boxstatus() {     # get dynamic status
+
     loudly cat /proc/interrupts
     loudly cat /proc/loadavg
+    loudly cat /proc/meminfo
+
+    if [ -d /proc/xenomai ]; then
+	for f in /proc/xenomai/*;   do [ -f $f ] && loudly cat $f; done
+	for f in /proc/xenomai/*/*; do [ -f $f ] && loudly cat $f; done
+    fi
     [ -n "$prepost" ] && loudly $prepost
     loudly top -bn1c | head -n $(( 12 + $workload ))
 }
@@ -105,16 +128,23 @@
     boxstatus
     (
 	cd ../testsuite/latency
-
 	loudly ./run --  $opts -t0
 	loudly ./run --  $opts -t1
 	loudly ./run --  $opts -t2
+    )
+    (	cd ../testsuite/switch 
+	loudly ./run --  '# switch'
+    )
+    (	cd ../testsuite/cyclic
+	loudly ./run -- -p 10 -n -l 1000 '# cyclictest'
+    )
 
-    )
     boxstatus
 }
 
 
+#####################
+# MAIN
 
 if [ -f /proc/config.gz ] ; then
 
@@ -133,16 +163,37 @@
 pass=		# pass thru to latency
 loadpass=	# pass thru to subshell, not to actual tests
 
-# if both empty means no logging
-logfile=	#
-logprefix=
+logging=	# no logging by default
+logfile=	# defaults to test-`uname -r`-<datestampe>
+logprefix=/tmp/	# someplace usually there
 prepost=	# command to run pre, and post test (ex ntpq -p)
 
-email='xeno-test@domain.hid'
-sendit=
+email='xenotest.output@domain.hid'	# until formalized
+sentby='xenotest.sender@domain.hid'
+url=
+sendit=		# send it by m-mail, u-url
+verbose=
 
-while getopts 'd:shqT:l:H:B:uLN:w:W:p:mM:' FOO ; do
+sendit() {
+    local file=$1
+    
+    if [ "$sendit" == 'm' ]; then
+	echo "mailing $file to $email"
+	if [ "$file" != '' ]; then
+	    mail -s 'xeno-test results' $email -- -F $sentby < $file
+	else
+	    cat - | mail -s 'xeno-test results' $email -- -F $sentby
+	fi
+    elif [ "$sendit" == 'u' ]; then
+	which curl && curl -T $file $url
+	# -x $proxy >/tmp/.submit_result
+	# which wget && curl -T $file $url \
+    fi
+}
 
+
+while getopts 'd:shqT:l:H:B:uLN:w:W:p:mM:U:' FOO ; do
+
     case $FOO in
 	s|h|q)
 	    pass="$pass -$FOO" ;;
@@ -159,8 +210,10 @@
 	    loadpass="$loadpass -d $device"
 	    ;;
 	L)
+	    logging=1
 	    logfile=test-`uname -r`  ;;
 	N)
+	    logging=1
 	    logprefix=$OPTARG ;;
 	w)
 	    workload=$OPTARG
@@ -173,9 +226,19 @@
 	    loadpass="$loadpass -p '$OPTARG'"  ;;
 	M)
 	    email=$OPTARG 
-	    sendit=1 ;;
+	    sendit='m' ;;
 	m)
-	    sendit=1 ;;
+	    sendit='m' ;;
+	U)
+	    url=$OPTARG 
+	    sendit='u' ;;
+	v)
+	    verbose=1 ;;
+	n)
+	    # accept note (from the outer process)
+	    notes=$OPTARG ;;
+
+
 	?)
 	    myusage ;;
     esac
@@ -185,24 +248,25 @@
 shift $(($OPTIND - 1));
 
 
-if [ "$logprefix$logfile" != "" ]; then
-    # restart inside a script invocation, passing all
-    date=`date +%y%m%d.%H%M%S`
-    script -c "./xeno-test $loadpass $pass $*" "$logprefix$logfile-$date"
-    if [ $sendit == 1 ]; then
-	echo "mailing $logprefix$logfile-$date to $email"
-	mail -s 'xeno-test results' $email < "$logprefix$logfile-$date"
-    fi
+if [ "$logging" != "" ]; then
+    # restart inside a script invocation, passing appropriate args
+    wfile=$logprefix$logfile-`date +%y%m%d.%H%M%S`
+    script -c "./xeno-test $loadpass $pass $*" $wfile && sendit $wfile
 else
     if [ "$altwork" != "" ]; then
 	mkload() { exec $altwork; }
     fi
-    echo running $0 $pass $*
-    run_w_load $pass $*
+    echo starting $0 $pass $loadpass $*
+    if [ "$sendit" != '' ]; then
+	run_w_load $pass $* | sendit
+    else
+	run_w_load $pass $*
+    fi
 fi
 
 exit;
 
+
 #################################################
 
 DONE:

--------------060904060708040205030407--

