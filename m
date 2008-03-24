MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="97xn5NcqpN"
Content-Transfer-Encoding: 7bit
Message-ID: <18407.46889.268796.980178@domain.hid>
Date: Mon, 24 Mar 2008 15:14:01 +0100
In-Reply-To: <47E4196F.2070303@domain.hid>
References: <47E4196F.2070303@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [Fwd: Bug#471871: xenomai-runtime: bashism
	in	/bin/sh script]
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
Cc: Xenomai-core@domain.hid


--97xn5NcqpN
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
 > Maybe someone with idle cycles left could have a look at this.

We do not need expr actually, $(()) also works with sh, but can not make
reference to a variable without a $, hence the new patch.

-- 


					    Gilles.

--97xn5NcqpN
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-sh-scripts.diff"
Content-Transfer-Encoding: 7bit

Index: scripts/xeno-info
===================================================================
--- scripts/xeno-info	(revision 3623)
+++ scripts/xeno-info	(working copy)
@@ -74,7 +74,7 @@ ldd -v > /dev/null 2>&1 && ldd -v || ldd
 'NR==1{print "Dynamic linker (ldd)  ", $NF}'
 fi
 
-ls -l /usr/lib/lib{g,stdc}++.so  2>/dev/null | awk -F. \
+ls -l /usr/lib/libg++.so /usr/lib/libstdc++.so  2>/dev/null | awk -F. \
        '{print "Linux C++ Library      " $4"."$5"."$6}'
 
 if test 0 -eq $withBusybox ; then 
Index: scripts/xeno-load.in
===================================================================
--- scripts/xeno-load.in	(revision 3623)
+++ scripts/xeno-load.in	(working copy)
@@ -127,7 +127,7 @@ children_pids=""
 cleanup () {
 
     if test \! "x$children_pids" = x; then
-       $sudo kill -SIGINT $children_pids >& /dev/null
+       $sudo kill -SIGINT $children_pids > /dev/null 2>&1
        children_pids=""
        sleep 1
     fi
Index: scripts/xeno-test.in
===================================================================
--- scripts/xeno-test.in	(revision 3623)
+++ scripts/xeno-test.in	(working copy)
@@ -60,9 +60,9 @@ pidFile=/var/lock/`basename $0.$$`.pids
 
 checkUtilities() {
   # Check for needed helper utilities
-  local neededApplets="awk basename cut date dd dirname egrep grep head
+  neededApplets="awk basename cut date dd dirname egrep grep head
 		       kill md5sum mount sleep test top uname zcat"
-  local foundAll=1
+  foundAll=1
   for  _j in $neededApplets
   do
     if test -z "`which $_j`"; then
@@ -74,11 +74,17 @@ checkUtilities() {
     echo "Please build busybox's ash with support for getopts"
     foundAll=0
   fi
-  if test $foundAll -eq 0 ; then exit 3 ; fi
+  if test $foundAll -eq 0 ; then 
+      needApplets=""
+      foundAll=""
+      exit 3
+  fi
+  needApplets=""
+  foundAll=""
 }
 
 checkHelpers() {
-  local foundAll=1
+  foundAll=1
   if test -z "`which script`" -a -n "$logging"; then
       echo "You will not be able to log (-L option) as script is missing"
       foundAll=0
@@ -91,7 +97,11 @@ checkHelpers() {
       echo "You will not be able to upload (-U option) as curl is missing"
       foundAll=0
   fi
-  if test $foundAll -eq 0 ; then exit 3 ; fi
+  if test $foundAll -eq 0 ; then 
+      foundAll=""
+      exit 3
+  fi
+  foundAll=""
 }
 
 loudly() {
@@ -111,7 +121,7 @@ dd_jobs=
 mkload() { dd if=$device of=/dev/null $* & }
 
 generate_loads() {
-    local jobsct=$1;
+    jobsct=$1;
     # if test -z "$1"; then echo Skipping generate_loads; return; fi
     shift 1
     if test 0 -eq $withBusybox ; then
@@ -120,13 +130,14 @@ generate_loads() {
 	trap cleanup_load EXIT	# under all exit conditions
     fi
     while test $jobsct -ge 1; do 
-        jobsct=$((jobsct-1)); 
+        jobsct=$(($jobsct-1));
         mkload
         dd_jobs="$dd_jobs $!" ;
     done
 
     echo dd workload started, pids $dd_jobs stored in $pidFile
     echo  $dd_jobs > $pidFile
+    jobsct=""
 }
 
 cleanup_load() {
@@ -159,7 +170,7 @@ boxinfo() { # static info, show once
     loudly md5sum /proc/cpuinfo	'# cpuinfo fingerprint'
 
     # how much of the config do we want ?
-    local filter=" grep -E '$whatconf'"
+    filter=" grep -E '$whatconf'"
     [ "$verbose" = 1 ] && filter=
     if test -f /proc/config.gz; then # get the config
          loudly zcat /proc/config.gz | $filter
@@ -170,6 +181,7 @@ boxinfo() { # static info, show once
 
     [ -d /proc/adeos ] && for f in /proc/adeos/*; do loudly cat $f; done
     [ -d /proc/ipipe ] && for f in /proc/ipipe/*; do loudly cat $f; done
+    filter=""
 }
 
 boxstatus() {     # get dynamic status
@@ -274,7 +286,7 @@ verbose=
 dateargs='+%y%m%d.%H%M%S'
 
 sendit() {
-    local file=$1
+    file=$1
     if test "$sendit" = 'm' ; then
 	echo "mailing $file to $email"
 	if test -n "$file" ; then
@@ -290,6 +302,7 @@ sendit() {
     else
 	echo "sendit unsupported option '$sendit'"
     fi
+    file=""
 }
 
 handle_options() {	# called for XENOTEST_OPTS, ARGV
@@ -379,7 +392,7 @@ if test "$logging" != "" ; then
     # restart inside a script invocation, passing appropriate args
     script -c "`dirname $0`/xeno-test $loadpass $latpass $*" $wfile
     res="$?"
-    if test "$res" == "0" ; then
+    if test "$res" = "0" ; then
 	sendit $wfile
     fi
 else

--97xn5NcqpN--

