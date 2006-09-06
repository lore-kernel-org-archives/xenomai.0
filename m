From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Wed, 6 Sep 2006 21:37:03 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gNy/EB6f9fCfDjl"
Message-Id: <200609062137.04256.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Best way to determine sudo in xeno-load?
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
To: xenomai-core <xenomai@xenomai.org>

--Boundary-00=_gNy/EB6f9fCfDjl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

Since the last checkin in xeno-load.in by gpm on the 17 of July my PPC HCU3 
target does not run the xeno-tests correctly.
E.g. in http://ngiger.dyndns.org/buildbot/hcu3_q/builds/26/step-xenotest/0
you find lines like
/usr/xenomai/bin/xeno-load: /usr/xenomai/bin/xeno-load: 249: sudo: not found

My earlier solution was:
if test -n "`which sudo`"; then
  sudo=`which sudo`
fi

This was corrected by Gilles to
>if test -n "`which sudo 2>/dev/null`"; then
>  sudo=`which sudo`
>elif test -n "`type -t sudo 2>/dev/null`"; then
>  sudo=sudo
>fi

Unfortunately my busybox version 1.1.3 behaves like this:
>~ $ type -t sudo 2>/dev/null
>-t: not found
>sudo: not found

Whereas my bash shell on my Debian system answers like this:
>$ type -t sudo
>file

Therefore I propose to change it like this:
>if test -n "`which sudo 2>/dev/null`"; then
>  sudo=`which sudo`
>elif "`type -t sudo 2>/dev/null`" = 'file'; then
>  sudo=sudo
>else
>  sudo=
>fi
>echo sudo cmd is now $sudo

Which gives me in Debian's bash the following output:
>sudo cmd is now /usr/bin/sudo
and running under the busybox
>/usr/xenomai/bin/xeno-load: /usr/xenomai/bin/xeno-load: 59: -t: not found
>sudo: not found: not found
>sudo cmd is now
which is ugly, but at least does the job correctly.

Or is Gilles patch based on yet another use-case. If this is the case, please 
let me know.

Also, the test has to be moved up before the first use of the sudo command.

If nobody comes up with a better solution, I would ask somebody to apply the 
attached patch, which implements both ideas.

Best regards

-- 
Niklaus Giger

--Boundary-00=_gNy/EB6f9fCfDjl
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="xeno-load.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xeno-load.patch"

Index: xeno-load.in
===================================================================
--- xeno-load.in	(Revision 1561)
+++ xeno-load.in	(Arbeitskopie)
@@ -82,6 +82,15 @@
 
 eval $user_moddir
 
+if test -n "`which sudo 2>/dev/null`"; then
+  sudo=`which sudo`
+elif "`type -t sudo 2>/dev/null`" = 'file'; then
+  sudo=sudo
+else
+  sudo=
+fi
+echo sudo cmd is now $sudo
+
 if `$sudo $modprobe -nq xeno_nucleus > /dev/null 2>&1`; then
    target_deps="${target_deps}nucleus+"
 else
@@ -94,12 +103,6 @@
 
 test $verbose = 1 && echo "Running $target_name from $run_info_file"
 
-if test -n "`which sudo 2>/dev/null`"; then
-  sudo=`which sudo`
-elif test -n "`type -t sudo 2>/dev/null`"; then
-  sudo=sudo
-fi
-
 if test \! "x$target_mesg" = x; then
   case "$target_mesg" in
   control_c)

--Boundary-00=_gNy/EB6f9fCfDjl--

