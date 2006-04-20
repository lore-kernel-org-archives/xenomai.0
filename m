Message-ID: <4447D9CA.9010809@domain.hid>
Date: Thu, 20 Apr 2006 14:58:18 -0400
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070702060909000104040803"
Subject: [Xenomai-core] xeno-test updates [rfc patch]
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
--------------070702060909000104040803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Ive started adding to xeno-test, as outlined previously (plus some)

- now run cyclictest and switch, in addition to latency -t 0,1,2

-  changed the prewired -m email-addy to xenotest.output@domain.hid
will change again when something is formalized.
In meantime, feel free to send results, Ill periodically bundle them,
and/or just forward them automatically.

- added `cat /proc/xenomai/* /proc/xenomai/*/*` to boxstatus(),
which is run before and after latency tests.
Note that /proc/ipipe/* is catted in boxinfo(), which is only run before,
since the info doesnt change

- moved cat /proc/meminfo to boxstatus, since it changes (a little bit)

- now grep more config-items out of config (for non-verbose mode)
   latency-killers, PREEMPT, others ?

- now fetch .config from /lib/modules/`uname -`/build, unless 
/proc/config.gz is there.

- -v flag gets whole config (from either source)

- boxinfo now runs xeno-info, xeno-config

- added  From: <xenotest.sender@domain.hid> to outgoing email.
This probably isnt good enough, as mailservers generally check real 
sender IP
against the given domain-name, and reject fakes.   Forex, LKML rejected 
my attempts
to do this there.  gmail.com accepted my test msgs, but perhaps cuz they 
know me from
my pop access.


- patch also includes a tweak to prepare-kernel (chmod +w in patch_append)
I added it cuz I like to use lndir to clone source trees
(much smaller, and patch does the right thing - copies file, then 
modifies local copy.
only issue is that it preserves the readonly of the original (preventing 
inadvertent touches),
which breaks the append.)  Not sure its universally safe, but it works here.


Dont apply yet, not tested recently.

Qs

- should I run boxstatus just after latency tests or b4 and after (as 
currently) ?

- /proc/xenomai/* contents are dynamic (ie run by boxstatus) ?

- any bits of  boxinfo and boxstatus that should be shuffled around ?

- mail only works if -N andor -L are used.
probably unnecessary limitation. (im lazy)

- check NPTL availability (kinda overkill, since its absence when needed 
is already detected)


- anything else come to mind ?

--------------070702060909000104040803
Content-Type: text/plain;
 name="patch-xeno-test"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-xeno-test"

Index: scripts/prepare-kernel.sh
===================================================================
--- scripts/prepare-kernel.sh	(revision 957)
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
--- scripts/xeno-test.in	(revision 957)
+++ scripts/xeno-test.in	(working copy)
@@ -19,6 +19,7 @@
 		prepending allows you to give a full path.
   -m		sends output file to xeno-test@domain.hid
   -M <email>	sends output file to given addy
+  -v		verbose
 
   # following options are passed thru to latency, klatency
   -s	print statistics of sampled data (default on)
@@ -43,7 +44,7 @@
     # run task after announcing it
     echo;  date;
     echo running: $*
-    $* &
+    eval $* &		# eval helps w complex cmds, like zegrep -E
     wait $!
 }
 
@@ -77,20 +78,37 @@
     unset dd_jobs;
 }
 
-boxinfo() {
-    # static info, show once
-    loudly cat /proc/cpuinfo | egrep -v 'bug|wp'
-    loudly cat /proc/meminfo
-    [ -f /proc/config.gz ] && loudly zgrep XENO /proc/config.gz
+boxinfo() { # static info, show once
 
+    loudly ./xeno-config -v
+    loudly ./xeno-info
+
+    loudly cat /proc/cpuinfo	# bogomips changes under CPU_FREQ
+
+    # how much of the config do we want ?
+    local cmd="zgrep -E 'XENO|PREEMPT|CONFIG_ACPI|CONFIG_PM|CPU_FREQ'"
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
@@ -105,12 +123,17 @@
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
+	loudly ./run --  '# cyclictest'
+    )
 
-    )
     boxstatus
 }
 
@@ -138,9 +161,12 @@
 logprefix=
 prepost=	# command to run pre, and post test (ex ntpq -p)
 
-email='xeno-test@domain.hid'
+email='xenotest.output@domain.hid'	# until formalized
+sentby='xenotest.sender@domain.hid'
 sendit=
+verbose=
 
+
 while getopts 'd:shqT:l:H:B:uLN:w:W:p:mM:' FOO ; do
 
     case $FOO in
@@ -176,6 +202,8 @@
 	    sendit=1 ;;
 	m)
 	    sendit=1 ;;
+	v)
+	    verbose=1 ;;
 	?)
 	    myusage ;;
     esac
@@ -189,9 +217,10 @@
     # restart inside a script invocation, passing all
     date=`date +%y%m%d.%H%M%S`
     script -c "./xeno-test $loadpass $pass $*" "$logprefix$logfile-$date"
-    if [ $sendit == 1 ]; then
+    if [ "$sendit" == 1 ]; then
 	echo "mailing $logprefix$logfile-$date to $email"
-	mail -s 'xeno-test results' $email < "$logprefix$logfile-$date"
+	mail -s 'xeno-test results' $email -- \
+	    -F $sentby < "$logprefix$logfile-$date"
     fi
 else
     if [ "$altwork" != "" ]; then

--------------070702060909000104040803--

