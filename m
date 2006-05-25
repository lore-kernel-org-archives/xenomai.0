From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Thu, 25 May 2006 21:34:08 +0200
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wagdE2cgsVSTVUZ"
Message-Id: <200605252134.08614.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Porting xeno-{info|load|test} to a busybox system
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org, Jim Cromie <jim.cromie@domain.hid>

--Boundary-00=_wagdE2cgsVSTVUZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

For my embedded target system I installed BusyBox as it was the easiest way to 
get a small GNU/Linux system to boot into a working shell. (But it takes less 
than 16 seconds from power on till the the familiar "login: " prompt.)

But I ran into the problem, that the xeno-*-applications did not run under the 
busybox environment. Here are some comment on my proposed changes.

1) To make a shell work under the busybox I had to specify #! /bin/sh instead 
of #! /bin/bash.

2) To make the run I run the xeno-*-applications on my Debian GNU/Linux 
PowerBook 
either as:
$ xeno-info
or as 
$ busybox sh xeno-info

3) Once all tests passed on my PowerBook, I switched to the embedded PPC405GPr 
board using a recent busybox (version 1.1.3).
This exposed some more not supported errors, eg.
fdformat: unrecognized option `--version'
Also on an embedded system a lot of the usual utilites like gcc, make, etc are 
not present. Therefore I checked for their existence with expressions like 
`which make`

4) As the BSD utility script is not present on my embedded system, 
xeno-test -L does not work.

5) The busybox shell does not know arrays. Also for unknown reasons the 
dd_jobs variable got not updated outside of the function generate_loads. 
Therefore I added a "killall dd" in the cleanup.

6) "trap CHLD" did not work under the BusyBox. Also (to be sure) called 
cleanup_load manually before exit.

7) Id did not ident the not busybox parts in xeno-info. This makes the patch 
smaller and more readable, but should probably be corrected before applying 
it.

8) Using `dirname $0` relative paths to make xeno-test work also if not called 
in /usr/xenomai/bin

9) Changing the e-mail address to xenomai-data@domain.hid is also included.

Checking the changes between running xeno-test (as bash or as busybox) and the 
old one did not reveal any significant changes. On my PPC405 system I could 
not complete this test as there segmentation faults running the invidual 
tests.

I would appreciate if these changes (or similar) could go -- after a review -- 
into the trunk (not necessarily before 2.2). I am specially interested in Jim 
Cromie's opinion. 

If anybody has a working target with a Xenomai + BusyBox combination and would 
be willing to test drive my changes, I would appreciate a feedback 
enormously.

These changes are a precondition to make the buildbot run xeno-test on the 
only board where I can easily and automatically switch the power off and on, 
without risking a family crisis.

Best regards
-- 
Niklaus Giger

--Boundary-00=_wagdE2cgsVSTVUZ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="scripts.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="scripts.patch"

Index: scripts/xeno-config.in
===================================================================
--- scripts/xeno-config.in	(Revision 1135)
+++ scripts/xeno-config.in	(Arbeitskopie)
@@ -1,4 +1,4 @@
-#! /bin/bash
+#! /bin/sh
 
 staging=${DESTDIR}
 prefix="@prefix@"
Index: scripts/xeno-info
===================================================================
--- scripts/xeno-info	(Revision 1135)
+++ scripts/xeno-info	(Arbeitskopie)
@@ -1,31 +1,51 @@
-#!/bin/sh
+#! /bin/sh
 #
 # This file has been lifted 'as is' from linux/scripts/ver_linux.
-#
+# Adapted to be run also under the BusyBox. If you want to test it under the BusyBox use
+# busybox sh xeno-info 
 
 PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/sbin:$PATH
 echo 'If some fields are empty or look unusual you may have an old version.'
 echo 'Compare to the current minimal requirements in Documentation/Changes.'
 echo ' '
 
+withBusybox=0
+if test -L $SHELL ; then # is sh a logical link to busybox
+    exeName=`ls -l $SHELL|cut -d\>  -f2`
+    if test "`basename $exeName`" = "busybox";  then
+	withBusybox=1; else echo 2.3
+    fi
+elif test -n "$_" -a "`basename $_`" = "busybox"; then
+    withBusybox=1;
+# else running a real /bin/sh (bash) shell
+fi
+
+if test $withBusybox -eq 1; then busybox | grep -i "BusyBox v" ; fi
+
 uname -a
 echo ' '
 
+if test -n "`which gcc`" ; then
 gcc --version 2>&1| head -n 1 | grep -v gcc | awk \
 'NR==1{print "Gnu C                 ", $1}'
 
 gcc --version 2>&1| grep gcc | awk \
 'NR==1{print "Gnu C                 ", $3}'
+fi
 
+if test -n "`which gcc`" ; then
 make --version 2>&1 | awk -F, '{print $1}' | awk \
       '/GNU Make/{print "Gnu make              ",$NF}'
+fi
 
 ld -v 2>&1 | awk -F\) '{print $1}' | awk \
       '/BFD/{print "binutils              ",$NF}'
 
+if test 0 -eq $withBusybox ; then 
 fdformat --version | awk -F\- '{print "util-linux            ", $NF}'
 
 mount --version | awk -F\- '{print "mount                 ", $NF}'
+fi 
 
 depmod -V  2>&1 | awk 'NR==1 {print "module-init-tools     ",$NF}'
 
@@ -50,21 +70,26 @@
 isdnctrl 2>&1 | grep version | awk \
 'NR==1{print "isdn4k-utils          ", $NF}'
 
+if test -n "`which ldd`" ; then
 ls -l `ldd /bin/sh | awk '/libc/{print $3}'` | sed \
 -e 's/\.so$//' | awk -F'[.-]'   '{print "Linux C Library        " \
 $(NF-2)"."$(NF-1)"."$NF}'
 
 ldd -v > /dev/null 2>&1 && ldd -v || ldd --version |head -n1 | awk \
 'NR==1{print "Dynamic linker (ldd)  ", $NF}'
+fi
 
 ls -l /usr/lib/lib{g,stdc}++.so  2>/dev/null | awk -F. \
        '{print "Linux C++ Library      " $4"."$5"."$6}'
 
+if test 0 -eq $withBusybox ; then 
 ps --version 2>&1 | awk 'NR==1{print "Procps                ", $NF}'
+fi 
 
 ifconfig --version 2>&1 | grep tools | awk \
 'NR==1{print "Net-tools             ", $NF}'
 
+if test 0 -eq $withBusybox ; then 
 # Kbd needs 'loadkeys -h',
 loadkeys -h 2>&1 | awk \
 '(NR==1 && ($3 !~ /option/)) {print "Kbd                   ", $3}'
@@ -74,6 +99,7 @@
 '(NR==1 && ($2 ~ /console-tools/)) {print "Console-tools         ", $3}'
 
 expr --v 2>&1 | awk 'NR==1{print "Sh-utils              ", $NF}'
+fi 
 
 if [ -e /proc/modules ]; then
     X=`cat /proc/modules | sed -e "s/ .*$//"`
Index: scripts/xeno-load.in
===================================================================
--- scripts/xeno-load.in	(Revision 1135)
+++ scripts/xeno-load.in	(Arbeitskopie)
@@ -1,7 +1,9 @@
-#! /bin/bash
+#! /bin/sh
 # Xenomai application loader script.
 # (Processes the .runinfo files)
 # June 2004, <rpm@xenomai.org>
+# Adapted to be run also under the BusyBox. If you want to test it under the BusyBox use
+# busybox sh xeno-info 
 
 usage='usage: xeno-load [[dir:]target]'
 prefix="@prefix@"
@@ -23,7 +25,7 @@
   shift
 fi
 
-if test "x$1" = x--; then
+if test -z "$1" || test "x$1" = x--; then
   target_dir=`pwd`
   target_name=default
 else
@@ -80,7 +82,7 @@
 
 eval $user_moddir
 
-if `$sudo $modprobe -nq xeno_nucleus >& /dev/null`; then
+if `$sudo $modprobe -nq xeno_nucleus > /dev/null 2>&1`; then
    target_deps="${target_deps}nucleus+"
 else
    target_deps=
@@ -92,8 +94,8 @@
 
 test $verbose = 1 && echo "Running $target_name from $run_info_file"
 
-if test \! "x`type -t sudo`" = x; then
-  sudo=sudo
+if test -n "`which sudo`"; then
+  sudo=`which sudo`
 fi
 
 if test \! "x$target_mesg" = x; then
@@ -161,7 +163,7 @@
 	   echo "ERROR: cannot load $xeno_moddir/xeno_$mod$modext"
 	   break
         fi
-     elif `$sudo $modprobe -n xeno_$mod >& /dev/null`; then
+     elif `$sudo $modprobe -n xeno_$mod > /dev/null 2>&1`; then
         test $verbose = 1 && echo "+ $modprobe xeno_$mod"
         $sudo $modprobe xeno_$mod
         inslist="xeno_$mod $inslist"
Index: scripts/xeno-test.in
===================================================================
--- scripts/xeno-test.in	(Revision 1135)
+++ scripts/xeno-test.in	(Arbeitskopie)
@@ -1,4 +1,6 @@
-#!/bin/bash
+#! /bin/sh
+# Adapted to be run also under the BusyBox. If you want to test it under the BusyBox use
+# busybox sh xeno-test 
 
 myusage() {
     cat >&1 <<EOF
@@ -19,7 +21,7 @@
 		name can be full or relative pathname
   -v		verbose
   -M <email>	sends output to given addr
-  -m		sends output to xenotest.output@domain.hid
+  -m		sends output to xenomai-data@domain.hid
   -U <url>	uploads output to given URL
 	
   # following options are passed thru to latency
@@ -40,6 +42,18 @@
 
 set -o notify	# see dd's finish immediately.(or not!)
 
+withBusybox=0
+if test -L $SHELL ; then # is sh a logical link to busybox
+    exeName=`ls -l $SHELL|cut -d\>  -f2`
+    if test "`basename $exeName`" = "busybox";  then
+	withBusybox=1; else echo 2.3
+    fi
+elif test -n "$_" -a "`basename $_`" = "busybox"; then
+    withBusybox=1;
+# else running a real /bin/sh (bash) shell
+fi
+echo withBusybox ist $withBusybox
+
 loudly() {
     [ "$1" = "" ] && return
     # run task after announcing it
@@ -51,31 +65,39 @@
 
 # defaults for cpu workload 
 device=/dev/zero	
-typeset -a dd_jobs
-dd_jobs=()
+dd_jobs=
 
 # used in generate-loads
 mkload() { exec dd if=$device of=/dev/null $* ; }
 
 generate_loads() {
     local jobsct=$1; shift;
+    if test 0 -eq $withBusybox ; then
+	reaper() { echo something died a $! or $* ; sleep 1;  }
+	trap reaper CHLD
+    else
+	echo "dummy  reaper for $!"
+	reaper() { echo xx >/dev/null ; }
+    fi
+    trap cleanup_load EXIT	# under all exit conditions
 
-    reaper() { echo something died $*; }
-    trap reaper CHLD
-    trap cleanup_load EXIT	# under all exit conditions
-    
-    for (( ; $jobsct ; jobsct-- )) ; do
-	mkload &
-	dd_jobs[${#dd_jobs[*]}]=$!
+    for _j in $jobsct ; do
+ 	mkload &
+	dd_jobs="$dd_jobs $!"
+	break
     done;
 
-    echo dd workload started, pids ${dd_jobs[*]}
+    echo dd workload started, pids $dd_jobs
 }
 
 cleanup_load() {
     # kill the workload
-    echo killing workload pids ${dd_jobs[*]}
-    kill ${dd_jobs[*]};
+    echo killing workload pids ${dd_jobs}
+    for _j in ${dd_jobs}
+    do
+       kill $_j
+    done
+    killall dd
     unset dd_jobs;
 }
 
@@ -83,10 +105,9 @@
 
 
 boxinfo() { # static info, show once
+    loudly `dirname $0`/xeno-config --verbose
+    loudly `dirname $0`/xeno-info
 
-    loudly ./xeno-config --verbose
-    loudly ./xeno-info
-
     loudly cat /proc/cpuinfo	# bogomips changes under CPU_FREQ
 
     # how much of the config do we want ?
@@ -114,7 +135,11 @@
 	for f in /proc/xenomai/*/*; do [ -f $f ] && loudly cat $f; done
     fi
     [ -n "$prepost" ] && loudly $prepost
-    loudly top -bn1c | head -n $(( 12 + $workload ))
+    if test 0 -eq $withBusybox ; then
+	loudly top -bn1c | head -n $(( 12 + $workload ))
+    else
+	loudly top | head -n $(( 12 + $workload ))
+    fi
 }
 
 
@@ -126,15 +151,15 @@
     loudly generate_loads $workload
     boxstatus
     (
-	cd ../testsuite/latency
+        cd `dirname $0`/../testsuite/latency
 	loudly ./run --  $opts -t0
 	loudly ./run --  $opts -t1
 	loudly ./run --  $opts -t2
     )
-    (	cd ../testsuite/switch 
+    (	cd `dirname $0`/../testsuite/switch
 	loudly ./run --  '# switch'
     )
-    (	cd ../testsuite/cyclic
+    (	cd `dirname $0`/../testsuite/cyclic
 	loudly ./run -- -p 10 -n -l 1000 '# cyclictest'
     )
 
@@ -167,7 +192,7 @@
 logprefix=/tmp/	# someplace usually there
 prepost=	# command to run pre, and post test (ex ntpq -p)
 
-email='xenotest.output@domain.hid'	# until formalized
+email='xenomai-data@domain.hid'	
 sentby='xenotest.sender@domain.hid'
 url=
 sendit=		# send it by m-mail, u-url
@@ -175,15 +200,15 @@
 
 sendit() {
     local file=$1
-    
-    if [ "$sendit" == 'm' ]; then
+
+    if test "$sendit" = 'm' ; then
 	echo "mailing $file to $email"
-	if [ "$file" != '' ]; then
+	if test -n "$file" ; then
 	    mail -s 'xeno-test results' $email -- -F $sentby < $file
 	else
 	    cat - | mail -s 'xeno-test results' $email -- -F $sentby
 	fi
-    elif [ "$sendit" == 'u' ]; then
+    elif test "$sendit" = 'u' ; then
 	which curl && curl -T $file $url
 	# -x $proxy >/tmp/.submit_result
 	# which wget && curl -T $file $url \
@@ -263,6 +288,8 @@
     fi
 fi
 
+cleanup_load
+
 exit;
 
 

--Boundary-00=_wagdE2cgsVSTVUZ--

