Message-ID: <445E84DE.2090209@domain.hid>
Date: Sun, 07 May 2006 19:38:06 -0400
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090104010706000603050606"
Subject: [Xenomai-core] more xenotest tweaks
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
--------------090104010706000603050606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


based in part on discussions and test-results from Niklaus Giger (thanks)
heres another round of tweaks.

* -p <pre-post-cmd> is changed to -P, which allows ..

* -p <sample_period> to be passed thru to latency, exposing that capability

* set -m default destination addr to <xenomai-data@domain.hid>
    you _may_ have to subscribe in order to successfully send your results.
    I didnt touch <xenotest.sender@domain.hid>, thats pending..

* -D <date-args>   allows user to change the timestamp format used for files
    written when -L -N are given on commandline.
forex:
    $ bash -x xeno-test.in -N ./junk -D \--iso-8601=seconds
yields
    Script started, file is ./junk-2006-05-07T18:16:14-0400
and
    bash -x xeno-test.in -N ./junk -D +%y%m%d.%S-foo
yields
    junk-060507.28-foo

the date-stamp echoed by loudly() shell-fn is _not_ subject to this arg,
as the added variability might make parsing the file harder.
OTOH, existing locale differences (forex between myself and Niklaus)
may preclude close parsing anyway.  Further tweaks here tbd.


* dropped the check for
    "warning: CONFIG_CPU_FREQ=$CONFIG_CPU_FREQ may be problematic"
because
the check was very incomplete, and the config info is available for 
proper analysis


* XENOTEST_OPTS envar is now read b4 commandline, so you can set your
favorites there, then override them on cmdline.

* added -s -h to default latency options, dropped -q
if one is gonna bother to send the output, we want the data itself :-}

* added 2>&1 into file-less -mailing branch.
Niklaus' testruns exposed the lack of output.

Im considering some juggling here, to use 'script' if available, 
something like:
      script -c "./xeno-test $loadpass $pass $*" | sendit

this has advantage of capturing the invocation in a single line at top 
of the file
ie the 'starting' line:

Script started on Sam 06 Mai 2006 16:26:44 CEST
creating workload using dd if=/dev/hda9
starting ./xeno-test -d /dev/hda9




This patch hasnt been properly tested, my test-box is currently busy, 
but I did run
    bash -vx xeno-test.in
just to verify that it was ok to segregate option handling code into 
handle_options,
then call it 2x from 2 while loops (1st for envar, 2nd for cmdline),
and some of the other tweaks too.





--------------090104010706000603050606
Content-Type: text/plain;
 name="patch-more-xenotest-tweaks"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-more-xenotest-tweaks"

Index: scripts/xeno-test.in
===================================================================
--- scripts/xeno-test.in	(revision 1029)
+++ scripts/xeno-test.in	(working copy)
@@ -12,7 +12,7 @@
   -W <script>   script is an alternate workload.  If you need to pass args
 		to your program, use quotes.  The program must clean
 		up its children when it gets a SIGTERM
-  -p <cmd>	cmd is run before and after rt-tests
+  -P <cmd>	cmd is run before and after rt-tests
 		(forex: 'ntpdate -b <host>' or 'ntpq -p')
   -L	     	writes logs to /tmp/test-`uname -r`-<timestamp>
   -N <name>	like -L, but writes to name-<timestamp> (in PWD)
@@ -21,15 +21,17 @@
   -M <email>	sends output to given addr
   -m		sends output to xenotest.output@domain.hid
   -U <url>	uploads output to given URL
-	
+  -D <datefmt>	alternate options to date, for timestamp (dflt: 
+
   # following options are passed thru to latency
   -s	print statistics of sampled data (default on)
   -h	print histogram of sampled data (default on, implies -s)
   -q	quiet, dont print 1 sec sampled data (default on, off if !-T)
-  -T <sec test>	(default: 120 sec)
+  -T <sec test>		 (default: 120 sec)
   -l <data/header lines> (default 21)
-  -H <bucketcount> (default 100)
-  -B <bucketsize ns> (default 1000)
+  -H <bucketcount>	 (default 100)
+  -B <bucketsize ns>	 (default 1000 ns)
+  -p <sample_period_us>	 (default 100 us)
 EOF
     # NB: many defaults are coded in latency
     exit 1
@@ -43,9 +45,9 @@
 loudly() {
     [ "$1" = "" ] && return
     # run task after announcing it
-    echo;  date;
+    echo; date;
     echo running: $*
-    eval $* &		# eval helps w complex cmds, like zegrep -E
+    eval $* &			# eval helps w complex cmds, like zegrep -E
     wait $!
 }
 
@@ -88,6 +90,7 @@
     loudly ./xeno-info
 
     loudly cat /proc/cpuinfo	# bogomips changes under CPU_FREQ
+    loudly cksum /proc/cpuinfo	'# cpuinfo fingerprint'
 
     # how much of the config do we want ?
     local cmd="zgrep -E '$whatconf'"
@@ -120,7 +123,7 @@
 
 run_w_load() {
     local opts="$*";
-    [ "$opts"  = '' ] && opts='-q -s -T 120'
+    [ "$opts"  = '' ] && opts='-sh -T 120'
 
     boxinfo
     loudly generate_loads $workload
@@ -145,17 +148,6 @@
 #####################
 # MAIN
 
-if [ -f /proc/config.gz ] ; then
-
-    # check/warn on problem configs
-    
-    eval `zgrep CONFIG_CPU_FREQ /proc/config.gz`;
-    if [ ! -z "$CONFIG_CPU_FREQ" ] ; then
-	echo "warning: CONFIG_CPU_FREQ=$CONFIG_CPU_FREQ may be problematic"
-    fi
-
-fi
-
 workload=1	# default = 1 job
 
 # *pass get all legit options, except -N, -L
@@ -167,12 +159,14 @@
 logprefix=/tmp/	# someplace usually there
 prepost=	# command to run pre, and post test (ex ntpq -p)
 
-email='xenotest.output@domain.hid'	# until formalized
-sentby='xenotest.sender@domain.hid'
+email='xenomai-data@domain.hid'		# may reject til you subscribe
+sentby='xenotest.sender@domain.hid'	# tbd
 url=
 sendit=		# send it by m-mail, u-url
 verbose=
+dateargs='+%y%m%d.%H%M%S'
 
+
 sendit() {
     local file=$1
     
@@ -190,14 +184,16 @@
     fi
 }
 
+handle_options() {	# called for XENOTEST_OPTS, ARGV
+    case $FOO in
 
-while getopts 'd:shqT:l:H:B:uLN:w:W:p:mM:U:' FOO ; do
-
-    case $FOO in
+	# latency passthrus
 	s|h|q)
 	    pass="$pass -$FOO" ;;
-	T|l|H|B)
+	T|l|H|B|p)
 	    pass="$pass -$FOO $OPTARG" ;;
+
+	# workload related
 	d) 
 	    device=$OPTARG    
 	    echo creating workload using dd if=$device
@@ -208,21 +204,23 @@
 	    fi
 	    loadpass="$loadpass -d $device"
 	    ;;
-	L)
-	    logging=1
-	    logfile=test-`uname -r`  ;;
-	N)
-	    logging=1
-	    logprefix=$OPTARG ;;
 	w)
 	    workload=$OPTARG
 	    loadpass="$loadpass -w $OPTARG"  ;;
 	W)
 	    altwork=$OPTARG
 	    loadpass="$loadpass -W '$OPTARG'"  ;;
-	p)
+	P)
 	    prepost=$OPTARG 
-	    loadpass="$loadpass -p '$OPTARG'"  ;;
+	    loadpass="$loadpass -P '$OPTARG'"  ;;
+
+	# output disposition
+	L)
+	    logging=1
+	    logfile=test-`uname -r`  ;;
+	N)
+	    logging=1
+	    logprefix=$OPTARG ;;
 	M)
 	    email=$OPTARG 
 	    sendit='m' ;;
@@ -233,15 +231,20 @@
 	    sendit='u' ;;
 	v)
 	    verbose=1 ;;
-	n)
-	    # accept note (from the outer process)
-	    notes=$OPTARG ;;
-
-
+	D)
+	    dateargs=$OPTARG ;;
 	?)
 	    myusage ;;
     esac
+}
+
+# process options from envar, then from cmd-line
+while getopts 'd:shqT:l:H:B:uLN:w:W:p:mM:U:P:D:' FOO $XENOTEST_OPTS ; do
+    handle_options;
 done
+while getopts 'd:shqT:l:H:B:uLN:w:W:p:mM:U:P:D:' FOO ; do
+    handle_options;
+done
 
 # all args have been handled, and split into 2 passthrus
 shift $(($OPTIND - 1));
@@ -249,7 +252,7 @@
 
 if [ "$logging" != "" ]; then
     # restart inside a script invocation, passing appropriate args
-    wfile=$logprefix$logfile-`date +%y%m%d.%H%M%S`
+    wfile=$logprefix$logfile-`date $dateargs`
     script -c "./xeno-test $loadpass $pass $*" $wfile && sendit $wfile
 else
     if [ "$altwork" != "" ]; then
@@ -257,7 +260,7 @@
     fi
     echo starting $0 $pass $loadpass $*
     if [ "$sendit" != '' ]; then
-	run_w_load $pass $* | sendit
+	run_w_load $pass $* 2>&1 | sendit
     else
 	run_w_load $pass $*
     fi

--------------090104010706000603050606--

