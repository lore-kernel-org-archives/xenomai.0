From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Porting xeno-{info|load|test} to a busybox system
Date: Sun, 28 May 2006 12:00:18 +0200
References: <200605252134.08614.niklaus.giger@domain.hid>
	<200605261852.45980.niklaus.giger@domain.hid>
	<44788191.2000405@domain.hid>
In-Reply-To: <44788191.2000405@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ySXeEQDttpvtJE8"
Message-Id: <200605281200.18974.niklaus.giger@domain.hid>
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

--Boundary-00=_ySXeEQDttpvtJE8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Samstag, 27. Mai 2006 18:42 schrieb Jan Kiszka:
> Niklaus Giger wrote:
<..>
> Still broken:
<..>
Sorry for not catching this part, but my kernel config did not set 
CONFIG_IKCONFIG. Fixed now.
> Resolves to "zcat | grep -E '...' /proc/config.gz" or to "cat
> /proc/config.gz". Both doesn't work. I would suggest this:
>
>     local filter="| grep -E '$whatconf'"
>     [ "$verbose" = 1 ] && filter=
>
>     if [ -f /proc/config.gz ]; then     # get the config
>         loudly zcat /proc/config.gz $filter
>
> >     elif [ -f /lib/modules/`uname -r`/build/.config ]; then
> >         loudly $cmd /lib/modules/`uname -r`/build/.config
>
> And here we need
>
>     loudly cat /lib/modules/`uname -r`/build/.config $filter
>
> >     fi
Should be fixed with the attached patch
> There is another occurrence of "zcat | grep" which needs fixing.
This one too.
>
> >>> /bin/xeno-test: /bin/xeno-test: 264: getopts: not found
<..>
> Did so, and also awk need to be switched on. What about testing for
> those features when bb was detected? Anyway, the latency tests work now
> (in my qemu box). But I do not find the workload (dd?) in the process list:
Added to procedure checkUtilities and checkHelpers (after having parsed the 
options). Added them unconditionally as there might be even *nix systems 
around which are lacking coreutilities like awk, cut, curl, mail, script.

Added a "ps | grep $_j" to show whether a dd job is still running before 
killing it. Now, at least running under the busybox. the dd jobs get killed 
as they should. Therefore I added a "killall dd" for the case the dd_jobs 
variable is empty.

You should be able to xeno-test under the BusyBox without any parameter, I 
added however often a "-T 1" to make them run faster. 

Could you give this patch another try? Thanks for your patience, but the 
variability is very high as both the kernel and the busybox have a lot of 
config options.

Best regards

-- 
Niklaus Giger

--Boundary-00=_ySXeEQDttpvtJE8
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="scripts.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="scripts.patch"

Index: scripts/xeno-config.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- scripts/xeno-config.in	(Revision 1142)
+++ scripts/xeno-config.in	(Arbeitskopie)
@@ -1,4 +1,4 @@
=2D#! /bin/bash
+#! /bin/sh
=20
 staging=3D${DESTDIR}
 prefix=3D"@prefix@"
Index: scripts/xeno-info
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- scripts/xeno-info	(Revision 1142)
+++ scripts/xeno-info	(Arbeitskopie)
@@ -1,31 +1,46 @@
=2D#!/bin/sh
+#! /bin/sh
 #
 # This file has been lifted 'as is' from linux/scripts/ver_linux.
=2D#
+# Adapted to be run also under the BusyBox. If you want to test it under t=
he BusyBox use
+# busybox sh xeno-info=20
=20
 PATH=3D/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/sbin:$PATH
 echo 'If some fields are empty or look unusual you may have an old version=
=2E'
 echo 'Compare to the current minimal requirements in Documentation/Changes=
=2E'
 echo ' '
=20
+withBusybox=3D0
+if sh --help 2>&1| grep -q BusyBox; then
+    withBusybox=3D1;
+# else running a real /bin/sh (bash) shell
+fi
+
+if test $withBusybox -eq 1; then busybox | grep -i "BusyBox v" ; fi
+
 uname -a
 echo ' '
=20
+if test -n "`which gcc`" ; then
 gcc --version 2>&1| head -n 1 | grep -v gcc | awk \
 'NR=3D=3D1{print "Gnu C                 ", $1}'
=20
 gcc --version 2>&1| grep gcc | awk \
 'NR=3D=3D1{print "Gnu C                 ", $3}'
+fi
=20
+if test -n "`which gcc`" ; then
 make --version 2>&1 | awk -F, '{print $1}' | awk \
       '/GNU Make/{print "Gnu make              ",$NF}'
+fi
=20
 ld -v 2>&1 | awk -F\) '{print $1}' | awk \
       '/BFD/{print "binutils              ",$NF}'
=20
+if test 0 -eq $withBusybox ; then=20
 fdformat --version | awk -F\- '{print "util-linux            ", $NF}'
=20
 mount --version | awk -F\- '{print "mount                 ", $NF}'
+fi=20
=20
 depmod -V  2>&1 | awk 'NR=3D=3D1 {print "module-init-tools     ",$NF}'
=20
@@ -50,21 +65,26 @@
 isdnctrl 2>&1 | grep version | awk \
 'NR=3D=3D1{print "isdn4k-utils          ", $NF}'
=20
+if test -n "`which ldd`" ; then
 ls -l `ldd /bin/sh | awk '/libc/{print $3}'` | sed \
 -e 's/\.so$//' | awk -F'[.-]'   '{print "Linux C Library        " \
 $(NF-2)"."$(NF-1)"."$NF}'
=20
 ldd -v > /dev/null 2>&1 && ldd -v || ldd --version |head -n1 | awk \
 'NR=3D=3D1{print "Dynamic linker (ldd)  ", $NF}'
+fi
=20
 ls -l /usr/lib/lib{g,stdc}++.so  2>/dev/null | awk -F. \
        '{print "Linux C++ Library      " $4"."$5"."$6}'
=20
+if test 0 -eq $withBusybox ; then=20
 ps --version 2>&1 | awk 'NR=3D=3D1{print "Procps                ", $NF}'
+fi=20
=20
 ifconfig --version 2>&1 | grep tools | awk \
 'NR=3D=3D1{print "Net-tools             ", $NF}'
=20
+if test 0 -eq $withBusybox ; then=20
 # Kbd needs 'loadkeys -h',
 loadkeys -h 2>&1 | awk \
 '(NR=3D=3D1 && ($3 !~ /option/)) {print "Kbd                   ", $3}'
@@ -74,6 +94,7 @@
 '(NR=3D=3D1 && ($2 ~ /console-tools/)) {print "Console-tools         ", $3=
}'
=20
 expr --v 2>&1 | awk 'NR=3D=3D1{print "Sh-utils              ", $NF}'
+fi=20
=20
 if [ -e /proc/modules ]; then
     X=3D`cat /proc/modules | sed -e "s/ .*$//"`
Index: scripts/xeno-load.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- scripts/xeno-load.in	(Revision 1142)
+++ scripts/xeno-load.in	(Arbeitskopie)
@@ -1,7 +1,9 @@
=2D#! /bin/bash
+#! /bin/sh
 # Xenomai application loader script.
 # (Processes the .runinfo files)
 # June 2004, <rpm@xenomai.org>
+# Adapted to be run also under the BusyBox. If you want to test it under t=
he BusyBox use
+# busybox sh xeno-info=20
=20
 usage=3D'usage: xeno-load [[dir:]target]'
 prefix=3D"@prefix@"
@@ -23,7 +25,7 @@
   shift
 fi
=20
=2Dif test "x$1" =3D x--; then
+if test -z "$1" || test "x$1" =3D x--; then
   target_dir=3D`pwd`
   target_name=3Ddefault
 else
@@ -80,7 +82,7 @@
=20
 eval $user_moddir
=20
=2Dif `$sudo $modprobe -nq xeno_nucleus >& /dev/null`; then
+if `$sudo $modprobe -nq xeno_nucleus > /dev/null 2>&1`; then
    target_deps=3D"${target_deps}nucleus+"
 else
    target_deps=3D
@@ -92,8 +94,8 @@
=20
 test $verbose =3D 1 && echo "Running $target_name from $run_info_file"
=20
=2Dif test \! "x`type -t sudo`" =3D x; then
=2D  sudo=3Dsudo
+if test -n "`which sudo`"; then
+  sudo=3D`which sudo`
 fi
=20
 if test \! "x$target_mesg" =3D x; then
@@ -161,7 +163,7 @@
 	   echo "ERROR: cannot load $xeno_moddir/xeno_$mod$modext"
 	   break
         fi
=2D     elif `$sudo $modprobe -n xeno_$mod >& /dev/null`; then
+     elif `$sudo $modprobe -n xeno_$mod > /dev/null 2>&1`; then
         test $verbose =3D 1 && echo "+ $modprobe xeno_$mod"
         $sudo $modprobe xeno_$mod
         inslist=3D"xeno_$mod $inslist"
Index: scripts/xeno-test.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- scripts/xeno-test.in	(Revision 1142)
+++ scripts/xeno-test.in	(Arbeitskopie)
@@ -1,4 +1,7 @@
=2D#!/bin/bash
+#! /bin/sh
+# Adapted to be run also under the BusyBox. If you want to test it under t=
he BusyBox use
+# busybox sh xeno-test=20
+# A BusyBox >=3D 1.1.3 with a make defconfig should provide all needed app=
lets.
=20
 myusage() {
     cat >&1 <<EOF
@@ -19,7 +22,7 @@
 		name can be full or relative pathname
   -v		verbose
   -M <email>	sends output to given addr
=2D  -m		sends output to xenotest.output@domain.hid
+  -m		sends output to xenomai-data@domain.hid
   -U <url>	uploads output to given URL
 =09
   # following options are passed thru to latency
@@ -40,6 +43,46 @@
=20
 set -o notify	# see dd's finish immediately.(or not!)
=20
+withBusybox=3D0
+if sh --help 2>&1| grep -q BusyBox; then
+    withBusybox=3D1;
+# else running a real /bin/sh (bash) shell
+fi
+echo withBusybox is $withBusybox
+
+checkUtilities() {
+  # Check for needed helper utilities
+  local neededApplets=3D"awk basename cut date dd dirname egrep grep
+		       getopt head kill mount sleep test top uname zcat"
+  local foundAll=3D1
+  for  _j in $neededApplets
+  do
+    if test -z `which $_j`; then
+      echo "Please build busybox with support for applet $_j"
+      foundAll=3D0
+    fi
+  done
+  if test $foundAll -eq 0 ; then exit 3 ; fi
+}
+
+checkHelpers() {
+  local foundAll=3D1
+  if test -z "`which script`" -a -n "$logging"; then
+      echo "You will not be able to log (-L option) as script is missing"
+      foundAll=3D0
+  fi
+  if test -z "`which mail`" -a "$sendit" =3D 'm' ; then
+      echo "You will not be able send mail (-m/-M options) as mail is miss=
ing"
+      foundAll=3D0
+  fi
+  if test -z "`which curl`" -a "$sendit" =3D 'm' ; then
+  # if test -z `which curl` -a "$sendit" =3D 'u' ; then
+      echo "You will not be able to upload (-U option) as curl is missing"
+      foundAll=3D0
+  fi
+  if test $foundAll -eq 0 ; then exit 3 ; fi
+}
+
 loudly() {
     [ "$1" =3D "" ] && return
     # run task after announcing it
@@ -51,31 +94,46 @@
=20
 # defaults for cpu workload=20
 device=3D/dev/zero=09
=2Dtypeset -a dd_jobs
=2Ddd_jobs=3D()
+dd_jobs=3D
=20
 # used in generate-loads
=2Dmkload() { exec dd if=3D$device of=3D/dev/null $* ; }
+mkload() {=20
+    dd if=3D$device of=3D/dev/null $* &
+}
=20
 generate_loads() {
=2D    local jobsct=3D$1; shift;
+    local jobsct=3D$1;=20
+    # if test -z "$1"; then echo Skipping generate_loads; return; fi
+    shift 1
+    if test 0 -eq $withBusybox ; then
+	reaper() { echo something died a $! or $* ; sleep 1;  }
+	trap reaper CHLD
+    fi
+    trap cleanup_load EXIT	# under all exit conditions
=20
=2D    reaper() { echo something died $*; }
=2D    trap reaper CHLD
=2D    trap cleanup_load EXIT	# under all exit conditions
=2D   =20
=2D    for (( ; $jobsct ; jobsct-- )) ; do
=2D	mkload &
=2D	dd_jobs[${#dd_jobs[*]}]=3D$!
+    for _j in $jobsct ; do
+	mkload
+	dd_jobs=3D"$dd_jobs $!"
+	break
     done;
=20
=2D    echo dd workload started, pids ${dd_jobs[*]}
+    echo dd workload started, pids $dd_jobs
 }
=20
 cleanup_load() {
     # kill the workload
=2D    echo killing workload pids ${dd_jobs[*]}
=2D    kill ${dd_jobs[*]};
+    echo killing workload pids $dd_jobs
+    if test -z $dd_jobs ; then
+        echo "no dd_jobs found, calling killall dd"
+        killall dd
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
=20
@@ -83,20 +141,19 @@
=20
=20
 boxinfo() { # static info, show once
+    loudly `dirname $0`/xeno-config --verbose
+    loudly `dirname $0`/xeno-info
=20
=2D    loudly ./xeno-config --verbose
=2D    loudly ./xeno-info
=2D
     loudly cat /proc/cpuinfo	# bogomips changes under CPU_FREQ
=20
     # how much of the config do we want ?
=2D    local cmd=3D"zgrep -E '$whatconf'"
=2D    [ "$verbose" =3D 1 ] && cmd=3Dcat
=2D
=2D    if [ -f /proc/config.gz ]; then	# get the config
=2D	loudly $cmd /proc/config.gz
=2D    elif [ -f /lib/modules/`uname -r`/build/.config ]; then
=2D	loudly $cmd /lib/modules/`uname -r`/build/.config
+    local filter=3D" grep -E '$whatconf'"
+    [ "$verbose" =3D 1 ] && filter=3D
+    if test -f /proc/config.gz; then =C2=A0 =C2=A0 # get the config
+         loudly zcat /proc/config.gz | $filter
+    elif test -f /lib/modules/`uname -r`/build/.config
+    then
+	loudly cat /lib/modules/`uname -r`/build/.config | $filter
     fi
=20
     [ -d /proc/adeos ] && for f in /proc/adeos/*; do loudly cat $f; done
@@ -104,7 +161,6 @@
 }
=20
 boxstatus() {     # get dynamic status
=2D
     loudly cat /proc/interrupts
     loudly cat /proc/loadavg
     loudly cat /proc/meminfo
@@ -114,7 +170,11 @@
 	for f in /proc/xenomai/*/*; do [ -f $f ] && loudly cat $f; done
     fi
     [ -n "$prepost" ] && loudly $prepost
=2D    loudly top -bn1c | head -n $(( 12 + $workload ))
+    if test 0 -eq $withBusybox ; then
+	loudly top -bn1c | head -n $(( 12 + $workload ))
+    else
+	loudly top | head -n $(( 12 + $workload ))
+    fi
 }
=20
=20
@@ -126,36 +186,36 @@
     loudly generate_loads $workload
     boxstatus
     (
=2D	cd ../testsuite/latency
+        cd `dirname $0`/../testsuite/latency
 	loudly ./run --  $opts -t0
 	loudly ./run --  $opts -t1
 	loudly ./run --  $opts -t2
     )
=2D    (	cd ../testsuite/switch=20
+    (	cd `dirname $0`/../testsuite/switch
 	loudly ./run --  '# switch'
     )
=2D    (	cd ../testsuite/cyclic
+    (	cd `dirname $0`/../testsuite/cyclic
 	loudly ./run -- -p 10 -n -l 1000 '# cyclictest'
     )
=20
     boxstatus
 }
=20
=2D
 #####################
 # MAIN
+# echo will call checkHelpers
+# checkUtilities
=20
 if [ -f /proc/config.gz ] ; then
=20
     # check/warn on problem configs
=2D   =20
=2D    eval `zgrep CONFIG_CPU_FREQ /proc/config.gz`;
+    eval `zcat /proc/config.gz | grep CONFIG_CPU_FREQ` ;
     if [ ! -z "$CONFIG_CPU_FREQ" ] ; then
 	echo "warning: CONFIG_CPU_FREQ=3D$CONFIG_CPU_FREQ may be problematic"
     fi
=2D
 fi
=20
+
 workload=3D1	# default =3D 1 job
=20
 # *pass get all legit options, except -N, -L
@@ -167,7 +227,7 @@
 logprefix=3D/tmp/	# someplace usually there
 prepost=3D	# command to run pre, and post test (ex ntpq -p)
=20
=2Demail=3D'xenotest.output@domain.hid'	# until formalized
+email=3D'xenomai-data@domain.hid
 sentby=3D'xenotest.sender@domain.hid'
 url=3D
 sendit=3D		# send it by m-mail, u-url
@@ -175,15 +235,15 @@
=20
 sendit() {
     local file=3D$1
=2D   =20
=2D    if [ "$sendit" =3D=3D 'm' ]; then
+
+    if test "$sendit" =3D 'm' ; then
 	echo "mailing $file to $email"
=2D	if [ "$file" !=3D '' ]; then
+	if test -n "$file" ; then
 	    mail -s 'xeno-test results' $email -- -F $sentby < $file
 	else
 	    cat - | mail -s 'xeno-test results' $email -- -F $sentby
 	fi
=2D    elif [ "$sendit" =3D=3D 'u' ]; then
+    elif test "$sendit" =3D 'u' ; then
 	which curl && curl -T $file $url
 	# -x $proxy >/tmp/.submit_result
 	# which wget && curl -T $file $url \
@@ -243,10 +303,11 @@
     esac
 done
=20
+checkHelpers
+
 # all args have been handled, and split into 2 passthrus
 shift $(($OPTIND - 1));
=20
=2D
 if [ "$logging" !=3D "" ]; then
     # restart inside a script invocation, passing appropriate args
     wfile=3D$logprefix$logfile-`date +%y%m%d.%H%M%S`
@@ -263,6 +324,8 @@
     fi
 fi
=20
+cleanup_load
+
 exit;
=20
=20
@@ -302,8 +365,12 @@
 xeno-test -L
 xeno-test -N foo -T 18 -l 6 -s
 xeno-test -L -N foo1-
+xeno-test -m
+xeno-test -T 1 -M $USER@localhost
 xeno-test -N foo0 -w0 -l 5 -T 30 -h
 xeno-test -L -N foo4- -w4
 xeno-test -L -N foo4W- -w4 -W 'dd if=3D/dev/hda1 of=3D/dev/null'
=20
=2D3.
+3. Repeat the same tests under the BusyBox.
+
+4. Check for border cases like missing awk, curl, mail, script, /proc/conf=
ig.gz

--Boundary-00=_ySXeEQDttpvtJE8--

