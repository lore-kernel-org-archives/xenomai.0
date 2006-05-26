From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Porting xeno-{info|load|test} to a busybox system
Date: Fri, 26 May 2006 18:52:45 +0200
References: <200605252134.08614.niklaus.giger@domain.hid>
	<44770814.5040009@domain.hid>
In-Reply-To: <44770814.5040009@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dJzdEHnV9Iq8xgU"
Message-Id: <200605261852.45980.niklaus.giger@domain.hid>
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

--Boundary-00=_dJzdEHnV9Iq8xgU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Freitag, 26. Mai 2006 15:52 schrieb Jan Kiszka:
> Niklaus Giger wrote:
> > ...
> > If anybody has a working target with a Xenomai + BusyBox combination and
> > would be willing to test drive my changes, I would appreciate a feedback
> > enormously.
>
> Did so, and here comes the result: :)
Thanks a lot for your prompt feedback.
<..>
> This may become fragile (and it already is on my hacked system). The
> reason: plans exist to allow compiling bb into multiple binaries again,
> thus sh will not be linked to busybox, but to ash e.g.
Sure. It was just my first idea. But your proposed solution is better and 
already
<..>
> When using this variant, I get the following messages:
> > /bin/xeno-test: /bin/xeno-test: 177: zgrep: not found
> What about zcat | grep instead? Moreover, I failed to find a zgrep bb
> applet. Did you copy that stuff on your box?
Sorry. As I had segmentation faults, my run did not get so far/or I missed 
this error. Running it manually I confirmed your bug and the proposed 
solution works for me, too. Integrated in the new version (attached) of the 
patch.

> > /bin/xeno-test: /bin/xeno-test: 264: getopts: not found
>
> getopts is off by default in bb. Is this essential for xeno-test? Then
> you should state this requirement somewhere.
I checked out BusyBox 1.13, run "make defconfig", changed the cross-compiler 
and install path. But I verified that a "make defconfig" on the 1.00 version 
had "# CONFIG_ASH_GETOPTS is not set".

Could you try the attached patch using busybox with "CONFIG_ASH_GETOPTS=y"? 
 
> > /bin/xeno-test: shift: 267: Illegal number: -1
>
> I guess this comes from the missing getopts...
>
>
> Regarding workload: I typically run the cache calibrator [1] in a look,
> together with some I/O load (hard disk where available, flood ping). The
> loop looks like
>
> while true; do calibrator <box-MHz> 8M /tmp/; done
> <box-MHz> should be derivable from /proc/cpuinfo with some scripting. We
> may just check if an inclusion of the calibrator source code is possible
> (license terms...).
Didn't know this tool. But I think this is another suggestion to improve 
xeno-test.
>
> Lacking time right now, otherwise I would have hacked further to make
> the test run. This test could be quite interesting for us here to
> quickly check our processing boxes' hardware and to test new Xenomai
> versions for elementary regressions when upgrading production systems
> (fortunately only their CF-cards). Looking forward!
Nice to hear that. So could you please give my patch a second try with a 
modified busybox?

-- 
Niklaus Giger

--Boundary-00=_dJzdEHnV9Iq8xgU
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="scripts.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="scripts.patch"

Index: scripts/xeno-config.in
===================================================================
--- scripts/xeno-config.in	(Revision 1137)
+++ scripts/xeno-config.in	(Arbeitskopie)
@@ -1,4 +1,4 @@
-#! /bin/bash
+#! /bin/sh
 
 staging=${DESTDIR}
 prefix="@prefix@"
Index: scripts/xeno-info
===================================================================
--- scripts/xeno-info	(Revision 1137)
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
--- scripts/xeno-load.in	(Revision 1137)
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
--- scripts/xeno-test.in	(Revision 1137)
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
@@ -40,6 +42,13 @@
 
 set -o notify	# see dd's finish immediately.(or not!)
 
+withBusybox=0
+if sh --help 2>&1| grep -q BusyBox; then
+    withBusybox=1;
+# else running a real /bin/sh (bash) shell
+fi
+echo withBusybox is $withBusybox
+
 loudly() {
     [ "$1" = "" ] && return
     # run task after announcing it
@@ -51,31 +60,39 @@
 
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
 
@@ -83,14 +100,13 @@
 
 
 boxinfo() { # static info, show once
+    loudly `dirname $0`/xeno-config --verbose
+    loudly `dirname $0`/xeno-info
 
-    loudly ./xeno-config --verbose
-    loudly ./xeno-info
-
     loudly cat /proc/cpuinfo	# bogomips changes under CPU_FREQ
 
     # how much of the config do we want ?
-    local cmd="zgrep -E '$whatconf'"
+    local cmd="zcat | grep -E '$whatconf'"
     [ "$verbose" = 1 ] && cmd=cat
 
     if [ -f /proc/config.gz ]; then	# get the config
@@ -114,7 +130,11 @@
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
 
 
@@ -126,15 +146,15 @@
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
 
@@ -149,7 +169,7 @@
 
     # check/warn on problem configs
     
-    eval `zgrep CONFIG_CPU_FREQ /proc/config.gz`;
+    eval `zcat | grep CONFIG_CPU_FREQ /proc/config.gz`;
     if [ ! -z "$CONFIG_CPU_FREQ" ] ; then
 	echo "warning: CONFIG_CPU_FREQ=$CONFIG_CPU_FREQ may be problematic"
     fi
@@ -167,7 +187,7 @@
 logprefix=/tmp/	# someplace usually there
 prepost=	# command to run pre, and post test (ex ntpq -p)
 
-email='xenotest.output@domain.hid'	# until formalized
+email='xenomai-data@domain.hid'	
 sentby='xenotest.sender@domain.hid'
 url=
 sendit=		# send it by m-mail, u-url
@@ -175,15 +195,15 @@
 
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
@@ -263,6 +283,8 @@
     fi
 fi
 
+cleanup_load
+
 exit;
 
 

--Boundary-00=_dJzdEHnV9Iq8xgU--

