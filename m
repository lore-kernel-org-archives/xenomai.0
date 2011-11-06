Message-ID: <4EB705FB.1090008@domain.hid>
Date: Sun, 06 Nov 2011 23:11:07 +0100
From: Roland Stigge <stigge@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030405050601050201090306"
Subject: [Xenomai-core] Xenomai 2.6.0 in Debian
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

This is a multi-part message in MIME format.
--------------030405050601050201090306
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

thanks for Xenomai 2.6.0!

I'm attaching a patch that's helpful for the integration of Xenomai in
Debian (and FHS compliant systems in general), moving the architecture
dependent test programs from /usr/share to /usr/lib.

Thanks in advance,

Roland

--------------030405050601050201090306
Content-Type: text/x-patch;
 name="xenomai.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="xenomai.patch"

--- xenomai-2.6.0.orig/src/testsuite/regression/xeno-regression-test.in
+++ xenomai-2.6.0/src/testsuite/regression/xeno-regression-test.in
@@ -46,13 +46,13 @@ echo 0 > /proc/xenomai/latency || :
 @testdir@domain.hid
 
 # the tests in this tree
-@domain.hid
-@domain.hid
-@domain.hid
-@domain.hid
-@domain.hid
-@domain.hid
-@domain.hid
+@testdir@domain.hid
+@testdir@domain.hid
+@testdir@domain.hid
+@testdir@domain.hid
+@testdir@domain.hid
+@testdir@domain.hid
+@testdir@domain.hid
 
 start_load
 
--- xenomai-2.6.0.orig/src/testsuite/regression/native/Makefile.am
+++ xenomai-2.6.0/src/testsuite/regression/native/Makefile.am
@@ -1,4 +1,4 @@
-tstdir = $(pkgdatadir)/regression/native
+tstdir = @XENO_TEST_DIR@/regression/native
 
 noinst_HEADERS = check.h
 
--- xenomai-2.6.0.orig/src/testsuite/regression/posix/Makefile.am
+++ xenomai-2.6.0/src/testsuite/regression/posix/Makefile.am
@@ -1,4 +1,4 @@
-tstdir = $(pkgdatadir)/regression/posix
+tstdir = @XENO_TEST_DIR@/regression/posix
 
 noinst_HEADERS = check.h
 
--- xenomai-2.6.0.orig/src/testsuite/regression/native+posix/Makefile.am
+++ xenomai-2.6.0/src/testsuite/regression/native+posix/Makefile.am
@@ -1,4 +1,4 @@
-tstdir = $(pkgdatadir)/regression/native+posix
+tstdir = @XENO_TEST_DIR@/regression/native+posix
 
 tst_PROGRAMS = mq_select
 

--------------030405050601050201090306--

