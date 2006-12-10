Subject: Re: [Xenomai-core] [PATCH] consolidate testsuite installation
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <457BDF99.1020405@domain.hid>
References: <457BDF99.1020405@domain.hid>
Content-Type: text/plain
Date: Sun, 10 Dec 2006 20:22:29 +0100
Message-Id: <1165778549.8255.17.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
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
Cc: xenomai-core <xenomai@xenomai.org>

On Sun, 2006-12-10 at 11:21 +0100, Jan Kiszka wrote:
> The only part of the Xenomai user-space package not yet following
> standard installation rules is the testsuite. It gets installed to
> $prefix/testsuite, by default /usr/testsuite. The attached patch is an
> approach to overcome this unusual layout.

Ack. Implementation-wise, we have to fix the following though:

xeno-load.in needs to be fixed, so that passing a single dot as argument
correctly picks the default runinfo target in the current directory.
This currently does not work as expected.

The second patch works around a problem with sudo relying on the
contents of the user's PATH variable. This won't work for people using a
version of sudo compiled with the secure path option by their favourite
distro. In that case, /usr/xenomai/bin (or whatever the user picked to
install xenomai) won't appear in that secure path, so the binary program
given in the runinfo file won't be found. A possible option is to
provide a relative path to locate the binary program,
e.g. ../../../../bin/latency for the latency test, as the example patch
shows. Not pretty, but the other way would need to autoconfiscate the
runinfo files, or at least run them through sed before installing, so
that we could substitute some placeholder with $exec_prefix.

--- scripts/xeno-load.in	(revision 1936)
+++ scripts/xeno-load.in	(working copy)
@@ -37,7 +37,7 @@
      target_dir=`pwd`
   fi
   if test "x$target_name" = x; then
-     if `echo $target_dir | grep -q /`; then
+     if `echo $target_dir | grep -q -e / -e .`; then
         target_name=default
      else
         target_name=$target_dir
Index: src/testsuite/latency/runinfo
===================================================================
--- src/testsuite/latency/runinfo	(revision 1936)
+++ src/testsuite/latency/runinfo	(working copy)
@@ -1 +1 @@
-latency:native+rtdm+timerbench:!latency;popall:control_c
+latency:native+rtdm+timerbench:!../../../../bin/latency;popall:control_c

-- 
Philippe.



