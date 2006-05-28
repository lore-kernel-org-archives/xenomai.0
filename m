From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Porting xeno-{info|load|test} to a busybox system
Date: Sun, 28 May 2006 16:41:55 +0200
References: <200605252134.08614.niklaus.giger@domain.hid>
	<200605281200.18974.niklaus.giger@domain.hid>
	<44797F49.7020705@domain.hid>
In-Reply-To: <44797F49.7020705@domain.hid>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0abeE51KAxxJOX1"
Message-Id: <200605281641.56813.niklaus.giger@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

--Boundary-00=_0abeE51KAxxJOX1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Sonntag, 28. Mai 2006 12:45 schrieb Jan Kiszka:
> Niklaus Giger wrote:
> > Am Samstag, 27. Mai 2006 18:42 schrieb Jan Kiszka:
<..>
> > Added a "ps | grep $_j" to show whether a dd job is still running before
> > killing it. Now, at least running under the busybox. the dd jobs get
> > killed as they should. Therefore I added a "killall dd" for the case the
> > dd_jobs variable is empty.
>
> But there is still no load during the tests, correct?
Yes. But now it should. The dd_jobs got killed too early, as under the BusyBox 
the trap exit handler got called too early. I think there are some subtle 
differences between the trap of the BusyBox- and the Bash-shell.

Now I store the pids in a file under /var/lock. Tested it under bash and 
busybox, works okay for me. 

Options like "-4-W 'dd if=/dev/hda1 of=/dev/null'" should also be handled 
correctly.

Options -L -m -M not tested under the BusyBox PPC405 target, as there I do not 
have access to curl, script and mail.

<..>
> - special characters in line 152 of xeno-test:
Sorry. Corrected. I think kate did not handle a paste from your e-mail message 
correctly
<..>
> - the output of xeno-test contains this error:
<..>
> /bin/xeno-test: /bin/xeno-test: 325:  : not found
May be the result of above error? Could not reproduce it here. Could try again 
the attached patch?

Thanks a lot again.

Best regards

-- 
Niklaus Giger

--Boundary-00=_0abeE51KAxxJOX1
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="scripts.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="scripts.patch"

Index: scripts/xeno-config.in
===================================================================
--- scripts/xeno-config.in	(Revision 1142)
+++ scripts/xeno-config.in	(Arbeitskopie)
@@ -1,4 +1,4 @@
-#! /bin/bash
+#! /bin/sh
 
 staging=${DESTDIR}
 prefix="@prefix@"
Index: scripts/xeno-info
===================================================================
--- scripts/xeno-info	(Revision 1142)
+++ scripts/xeno-info	(Arbeitskopie)
@@ -1,31 +1,46 @@
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
+if sh --help 2>&1| grep -q BusyBox; then
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
 
@@ -50,21 +65,26 @@
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
@@ -74,6 +94,7 @@
 '(NR==1 && ($2 ~ /console-tools/)) {print "Console-tools         ", $3}'
 
 expr --v 2>&1 | awk 'NR==1{print "Sh-utils              ", $NF}'
+fi 
 
 if [ -e /proc/modules ]; then
     X=`cat /proc/modules | sed -e "s/ .*$//"`
Index: scripts/xeno-load.in
===================================================================
--- scripts/xeno-load.in	(Revision 1142)
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
--- scripts/xeno-test.in	(Revision 1142)
+++ scripts/xeno-test.in	(Arbeitskopie)
@@ -1,5 +1,7 @@
-#!/bin/bash
-
+#! /bin/sh
+# Adapted to be run also under the BusyBox. If you want to test it under the BusyBox use
+# busybox sh xeno-test 
+# A BusyBox >= 1.1.3 with a make defconfig should provide all needed applets.
 myusage() {
     cat >&1 <<EOF
 xeno-test [options]
@@ -19,7 +21,7 @@
 		name can be full or relative pathname
   -v		verbose
   -M <email>	sends output to given addr
-  -m		sends output to xenotest.output@domain.hid
+  -m		sends output to xenomai-data@domain.hid
   -U <url>	uploads output to given URL
 	
   # following options are passed thru to latency
@@ -40,6 +42,46 @@
 
 set -o notify	# see dd's finish immediately.(or not!)
 
+withBusybox=0
+if sh --help 2>&1| grep -q BusyBox; then
+    withBusybox=1;
+# else running a real /bin/sh (bash) shell
+fi
+echo withBusybox is $withBusybox
+pidFile=/var/lock/`basename $0`.pids
+
+checkUtilities() {
+  # Check for needed helper utilities
+  local neededApplets="awk basename cut date dd dirname egrep grep
+		       getopt head kill mount sleep test top uname zcat"
+  local foundAll=1
+  for  _j in $neededApplets
+  do
+    if test -z "`which $_j`"; then
+      echo "Please build busybox with support for applet $_j"
+      foundAll=0
+    fi
+  done
+  if test $foundAll -eq 0 ; then exit 3 ; fi
+}
+
+checkHelpers() {
+  local foundAll=1
+  if test -z "`which script`" -a -n "$logging"; then
+      echo "You will not be able to log (-L option) as script is missing"
+      foundAll=0
+  fi
+  if test -z "`which mail`" -a "$sendit" = 'm' ; then
+      echo "You will not be able send mail (-m/-M options) as mail is missing"
+      foundAll=0
+  fi
+  if test -z "`which curl`" -a "$sendit" = 'm' ; then
+      echo "You will not be able to upload (-U option) as curl is missing"
+      foundAll=0
+  fi
+  if test $foundAll -eq 0 ; then exit 3 ; fi
+}
+
 loudly() {
     [ "$1" = "" ] && return
     # run task after announcing it
@@ -51,31 +93,49 @@
 
 # defaults for cpu workload 
 device=/dev/zero	
-typeset -a dd_jobs
-dd_jobs=()
+dd_jobs=
 
 # used in generate-loads
-mkload() { exec dd if=$device of=/dev/null $* ; }
+mkload() { dd if=$device of=/dev/null $* & }
 
 generate_loads() {
-    local jobsct=$1; shift;
+    local jobsct=$1; 
+    # if test -z "$1"; then echo Skipping generate_loads; return; fi
+    shift 1
+    if test 0 -eq $withBusybox ; then
+	reaper() { echo something died a $! or $* ; sleep 1;  }
+	trap reaper CHLD
+	trap cleanup_load EXIT	# under all exit conditions
+    fi
+    while test $jobsct -ge 1; do 
+        jobsct=$((jobsct-1)); 
+        mkload
+        dd_jobs="$dd_jobs $!" ;
+    done
 
-    reaper() { echo something died $*; }
-    trap reaper CHLD
-    trap cleanup_load EXIT	# under all exit conditions
-    
-    for (( ; $jobsct ; jobsct-- )) ; do
-	mkload &
-	dd_jobs[${#dd_jobs[*]}]=$!
-    done;
-
-    echo dd workload started, pids ${dd_jobs[*]}
+    echo dd workload started, pids $dd_jobs stored in $pidFile
+    echo  $dd_jobs > $pidFile
 }
 
 cleanup_load() {
     # kill the workload
-    echo killing workload pids ${dd_jobs[*]}
-    kill ${dd_jobs[*]};
+    echo killing workload pids $dd_jobs pidFile $pidFile
+    if test -z "$dd_jobs" -a -r $pidFile; then
+      dd_jobs=`cat $pidFile`
+      # echo Read pids from file $pidFile, now $dd_jobs
+      rm -f $pidFile
+    fi
+
+    if test -z "$dd_jobs" ; then
+        echo "no dd_jobs found"
+    else
+	for _j in $dd_jobs
+	do
+	  ps | grep $_j
+	  echo kill workload pid $_j
+	  kill $_j
+	done
+    fi
     unset dd_jobs;
 }
 
@@ -83,20 +143,19 @@
 
 
 boxinfo() { # static info, show once
+    loudly `dirname $0`/xeno-config --verbose
+    loudly `dirname $0`/xeno-info
 
-    loudly ./xeno-config --verbose
-    loudly ./xeno-info
-
     loudly cat /proc/cpuinfo	# bogomips changes under CPU_FREQ
 
     # how much of the config do we want ?
-    local cmd="zgrep -E '$whatconf'"
-    [ "$verbose" = 1 ] && cmd=cat
-
-    if [ -f /proc/config.gz ]; then	# get the config
-	loudly $cmd /proc/config.gz
-    elif [ -f /lib/modules/`uname -r`/build/.config ]; then
-	loudly $cmd /lib/modules/`uname -r`/build/.config
+    local filter=" grep -E '$whatconf'"
+    [ "$verbose" = 1 ] && filter=
+    if test -f /proc/config.gz; then # get the config
+         loudly zcat /proc/config.gz | $filter
+    elif test -f /lib/modules/`uname -r`/build/.config
+    then
+	loudly cat /lib/modules/`uname -r`/build/.config | $filter
     fi
 
     [ -d /proc/adeos ] && for f in /proc/adeos/*; do loudly cat $f; done
@@ -104,7 +163,6 @@
 }
 
 boxstatus() {     # get dynamic status
-
     loudly cat /proc/interrupts
     loudly cat /proc/loadavg
     loudly cat /proc/meminfo
@@ -114,7 +172,11 @@
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
 
 
@@ -126,36 +188,35 @@
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
 
     boxstatus
 }
 
-
 #####################
 # MAIN
+checkUtilities
 
 if [ -f /proc/config.gz ] ; then
 
     # check/warn on problem configs
-    
-    eval `zgrep CONFIG_CPU_FREQ /proc/config.gz`;
+    eval `zcat /proc/config.gz | grep CONFIG_CPU_FREQ` ;
     if [ ! -z "$CONFIG_CPU_FREQ" ] ; then
 	echo "warning: CONFIG_CPU_FREQ=$CONFIG_CPU_FREQ may be problematic"
     fi
-
 fi
 
+
 workload=1	# default = 1 job
 
 # *pass get all legit options, except -N, -L
@@ -167,7 +228,7 @@
 logprefix=/tmp/	# someplace usually there
 prepost=	# command to run pre, and post test (ex ntpq -p)
 
-email='xenotest.output@domain.hid'	# until formalized
+email='xenomai-data@domain.hid'	
 sentby='xenotest.sender@domain.hid'
 url=
 sendit=		# send it by m-mail, u-url
@@ -175,15 +236,15 @@
 
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
@@ -243,10 +304,11 @@
     esac
 done
 
+checkHelpers
+
 # all args have been handled, and split into 2 passthrus
 shift $(($OPTIND - 1));
 
-
 if [ "$logging" != "" ]; then
     # restart inside a script invocation, passing appropriate args
     wfile=$logprefix$logfile-`date +%y%m%d.%H%M%S`
@@ -263,6 +325,8 @@
     fi
 fi
 
+cleanup_load
+
 exit;
 
 
@@ -302,8 +366,12 @@
 xeno-test -L
 xeno-test -N foo -T 18 -l 6 -s
 xeno-test -L -N foo1-
+xeno-test -m
+xeno-test -T 1 -M $USER@localhost
 xeno-test -N foo0 -w0 -l 5 -T 30 -h
 xeno-test -L -N foo4- -w4
 xeno-test -L -N foo4W- -w4 -W 'dd if=/dev/hda1 of=/dev/null'
 
-3.
+3. Repeat the same tests under the BusyBox.
+
+4. Check for border cases like missing awk, curl, mail, script, /proc/config.gz

--Boundary-00=_0abeE51KAxxJOX1--

