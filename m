Message-ID: <47E52BB2.5060709@domain.hid>
Date: Sat, 22 Mar 2008 16:54:26 +0100
From: Roland Stigge <stigge@domain.hid>
MIME-Version: 1.0
References: <47E4196F.2070303@domain.hid>
In-Reply-To: <47E4196F.2070303@domain.hid>
Content-Type: multipart/mixed; boundary="------------080202050005080700080903"
Subject: Re: [Xenomai-core] [Fwd: Bug#471871: xenomai-runtime: bashism in
 /bin/sh script]
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

This is a multi-part message in MIME format.
--------------080202050005080700080903
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Maybe someone with idle cycles left could have a look at this.

Idle? Preempted, at most!

Attached is what I will apply to the Debian version. Feel free to do as
well...

bye,
  Roland

--------------080202050005080700080903
Content-Type: text/x-diff;
 name="xenomai.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai.patch"

diff -u scripts.orig/xeno-info scripts/xeno-info
--- scripts.orig/xeno-info	2007-12-09 11:46:37.000000000 +0100
+++ scripts/xeno-info	2008-03-22 16:50:19.000000000 +0100
@@ -1,4 +1,4 @@
-#! /bin/sh
+#! /bin/bash
 #
 # This file has been lifted 'as is' from linux/scripts/ver_linux.
 # Adapted to be run also under the BusyBox. If you want to test it under the BusyBox use
diff -u scripts.orig/xeno-load.in scripts/xeno-load.in
--- scripts.orig/xeno-load.in	2007-12-09 11:46:37.000000000 +0100
+++ scripts/xeno-load.in	2008-03-22 16:50:57.000000000 +0100
@@ -1,4 +1,4 @@
-#! /bin/sh
+#! /bin/bash
 # Xenomai application loader script.
 # (Processes the .runinfo files)
 # June 2004, <rpm@xenomai.org>
diff -u scripts.orig/xeno-test.in scripts/xeno-test.in
--- scripts.orig/xeno-test.in	2008-02-20 18:18:46.000000000 +0100
+++ scripts/xeno-test.in	2008-03-22 16:50:32.000000000 +0100
@@ -1,4 +1,4 @@
-#! /bin/sh
+#! /bin/bash
 
 # Adapted to be run also under the BusyBox. 
 # If you want to test it this way, do: sh xeno-test

--------------080202050005080700080903--

