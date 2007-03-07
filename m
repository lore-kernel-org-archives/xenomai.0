From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vCyHbiz4Nv"
Content-Transfer-Encoding: 7bit
Message-ID: <17903.17256.565923.470161@domain.hid>
Date: Wed, 7 Mar 2007 23:57:44 +0100
Subject: Re: [Xenomai-core] Debian rule set.
In-Reply-To: <200703070332.47745.paul_c@domain.hid>
References: <200703070332.47745.paul_c@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: xenomai@xenomai.org


--vCyHbiz4Nv
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Paul wrote:
 > xenomai-dev - Headers, static libs, and xeno-config. I would have liked to 
 > move the headers in to a /usr/include/xenomai directory, but there appears to 
 > be a minor issue with the --includedir option.

The attached patch should solve this issue.

-- 


					    Gilles Chanteperdrix.

--vCyHbiz4Nv
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-install-headers-under-includedir.diff"
Content-Transfer-Encoding: 7bit

Index: include/uitron/Makefile.am
===================================================================
--- include/uitron/Makefile.am	(revision 2279)
+++ include/uitron/Makefile.am	(working copy)
@@ -1,6 +1,6 @@
-includedir = $(prefix)/include/uitron
+includesubdir = $(includedir)/uitron
 
-include_HEADERS = \
+includesub_HEADERS = \
 	defs.h \
 	flag.h \
 	mbx.h \
Index: include/asm-ia64/bits/Makefile.am
===================================================================
--- include/asm-ia64/bits/Makefile.am	(revision 2279)
+++ include/asm-ia64/bits/Makefile.am	(working copy)
@@ -1,3 +1,3 @@
-includedir = $(prefix)/include/asm-ia64/bits
+includesubdir = $(includedir)/asm-ia64/bits
 
-include_HEADERS = pod.h intr.h heap.h thread.h shadow.h timer.h init.h
+includesub_HEADERS = pod.h intr.h heap.h thread.h shadow.h timer.h init.h
Index: include/asm-ia64/Makefile.am
===================================================================
--- include/asm-ia64/Makefile.am	(revision 2279)
+++ include/asm-ia64/Makefile.am	(working copy)
@@ -1,5 +1,5 @@
-includedir = $(prefix)/include/asm-ia64
+includesubdir = $(includedir)/asm-ia64
 
-include_HEADERS = atomic.h calibration.h features.h hal.h syscall.h system.h wrappers.h fptest.h
+includesub_HEADERS = atomic.h calibration.h features.h hal.h syscall.h system.h wrappers.h fptest.h
 
 SUBDIRS = bits
Index: include/vxworks/Makefile.am
===================================================================
--- include/vxworks/Makefile.am	(revision 2279)
+++ include/vxworks/Makefile.am	(working copy)
@@ -1,3 +1,3 @@
-includedir = $(prefix)/include/vxworks
+includesubdir = $(includedir)/vxworks
 
-include_HEADERS = syscall.h vxworks.h
+includesub_HEADERS = syscall.h vxworks.h
Index: include/native/Makefile.am
===================================================================
--- include/native/Makefile.am	(revision 2279)
+++ include/native/Makefile.am	(working copy)
@@ -1,6 +1,6 @@
-includedir = $(prefix)/include/native
+includesubdir = $(includedir)/native
 
-include_HEADERS = \
+includesub_HEADERS = \
 	alarm.h \
 	cond.h \
 	event.h \
Index: include/asm-blackfin/bits/Makefile.am
===================================================================
--- include/asm-blackfin/bits/Makefile.am	(revision 2279)
+++ include/asm-blackfin/bits/Makefile.am	(working copy)
@@ -1,3 +1,3 @@
-includedir = $(prefix)/include/asm-blackfin/bits
+includesubdir = $(includedir)/asm-blackfin/bits
 
-include_HEADERS = pod.h intr.h heap.h thread.h shadow.h timer.h init.h
+includesub_HEADERS = pod.h intr.h heap.h thread.h shadow.h timer.h init.h
Index: include/asm-blackfin/Makefile.am
===================================================================
--- include/asm-blackfin/Makefile.am	(revision 2279)
+++ include/asm-blackfin/Makefile.am	(working copy)
@@ -1,6 +1,6 @@
-includedir = $(prefix)/include/asm-blackfin
+includesubdir = $(includedir)/asm-blackfin
 
-include_HEADERS = atomic.h calibration.h features.h hal.h \
+includesub_HEADERS = atomic.h calibration.h features.h hal.h \
 		syscall.h system.h wrappers.h fptest.h
 
 SUBDIRS = bits
Index: include/asm-generic/bits/Makefile.am
===================================================================
--- include/asm-generic/bits/Makefile.am	(revision 2279)
+++ include/asm-generic/bits/Makefile.am	(working copy)
@@ -1,6 +1,6 @@
-includedir = $(prefix)/include/asm-generic/bits
+includesubdir = $(includedir)/asm-generic/bits
 
-include_HEADERS = \
+includesub_HEADERS = \
 	bind.h \
 	heap.h \
 	intr.h \
Index: include/asm-generic/Makefile.am
===================================================================
--- include/asm-generic/Makefile.am	(revision 2279)
+++ include/asm-generic/Makefile.am	(working copy)
@@ -1,5 +1,5 @@
-includedir = $(prefix)/include/asm-generic
+includesubdir = $(includedir)/asm-generic
 
-include_HEADERS = features.h hal.h syscall.h system.h wrappers.h
+includesub_HEADERS = features.h hal.h syscall.h system.h wrappers.h
 
 SUBDIRS = bits
Index: include/asm-powerpc/bits/Makefile.am
===================================================================
--- include/asm-powerpc/bits/Makefile.am	(revision 2279)
+++ include/asm-powerpc/bits/Makefile.am	(working copy)
@@ -1,3 +1,3 @@
-includedir = $(prefix)/include/asm-powerpc/bits
+includesubdir = $(includedir)/asm-powerpc/bits
 
-include_HEADERS = pod.h intr.h heap.h thread.h shadow.h timer.h init.h
+includesub_HEADERS = pod.h intr.h heap.h thread.h shadow.h timer.h init.h
Index: include/asm-powerpc/Makefile.am
===================================================================
--- include/asm-powerpc/Makefile.am	(revision 2279)
+++ include/asm-powerpc/Makefile.am	(working copy)
@@ -1,6 +1,6 @@
-includedir = $(prefix)/include/asm-powerpc
+includesubdir = $(includedir)/asm-powerpc
 
-include_HEADERS = atomic.h calibration.h features.h hal.h \
+includesub_HEADERS = atomic.h calibration.h features.h hal.h \
 		syscall.h system.h wrappers.h fptest.h
 
 SUBDIRS = bits
Index: include/asm-arm/bits/Makefile.am
===================================================================
--- include/asm-arm/bits/Makefile.am	(revision 2279)
+++ include/asm-arm/bits/Makefile.am	(working copy)
@@ -1,3 +1,3 @@
-includedir = $(prefix)/include/asm-arm/bits
+includesubdir = $(includedir)/asm-arm/bits
 
-include_HEADERS = pod.h intr.h heap.h thread.h shadow.h timer.h init.h
+includesub_HEADERS = pod.h intr.h heap.h thread.h shadow.h timer.h init.h
Index: include/asm-arm/Makefile.am
===================================================================
--- include/asm-arm/Makefile.am	(revision 2279)
+++ include/asm-arm/Makefile.am	(working copy)
@@ -1,6 +1,6 @@
-includedir = $(prefix)/include/asm-arm
+includesubdir = $(includedir)/asm-arm
 
-include_HEADERS = atomic.h calibration.h features.h hal.h \
+includesub_HEADERS = atomic.h calibration.h features.h hal.h \
 		syscall.h system.h wrappers.h fptest.h
 
 SUBDIRS = bits
Index: include/psos+/Makefile.am
===================================================================
--- include/psos+/Makefile.am	(revision 2279)
+++ include/psos+/Makefile.am	(working copy)
@@ -1,6 +1,6 @@
-includedir = $(prefix)/include/psos+
+includesubdir = $(includedir)/psos+
 
-include_HEADERS = \
+includesub_HEADERS = \
 	asr.h \
 	defs.h \
 	event.h \
Index: include/rtai/Makefile.am
===================================================================
--- include/rtai/Makefile.am	(revision 2279)
+++ include/rtai/Makefile.am	(working copy)
@@ -1,6 +1,6 @@
-includedir = $(prefix)/include/rtai
+includesubdir = $(includedir)/rtai
 
-include_HEADERS = \
+includesub_HEADERS = \
 	fifo.h \
 	intr.h \
 	rt_mem_mgr.h \
Index: include/posix/sys/Makefile.am
===================================================================
--- include/posix/sys/Makefile.am	(revision 2279)
+++ include/posix/sys/Makefile.am	(working copy)
@@ -1,6 +1,6 @@
-includedir = $(prefix)/include/posix/sys
+includesubdir = $(includedir)/posix/sys
 
-include_HEADERS = \
+includesub_HEADERS = \
 	ioctl.h \
 	mman.h \
 	socket.h
Index: include/posix/Makefile.am
===================================================================
--- include/posix/Makefile.am	(revision 2279)
+++ include/posix/Makefile.am	(working copy)
@@ -1,6 +1,6 @@
-includedir = $(prefix)/include/posix
+includesubdir = $(includedir)/posix
 
-include_HEADERS = \
+includesub_HEADERS = \
 	errno.h \
 	fcntl.h \
 	mqueue.h \
Index: include/vrtx/Makefile.am
===================================================================
--- include/vrtx/Makefile.am	(revision 2279)
+++ include/vrtx/Makefile.am	(working copy)
@@ -1,3 +1,3 @@
-includedir = $(prefix)/include/vrtx
+includesubdir = $(includedir)/vrtx
 
-include_HEADERS = syscall.h vrtx.h
+includesub_HEADERS = syscall.h vrtx.h
Index: include/asm-sim/bits/Makefile.am
===================================================================
--- include/asm-sim/bits/Makefile.am	(revision 2279)
+++ include/asm-sim/bits/Makefile.am	(working copy)
@@ -1,3 +1,3 @@
-includedir = $(prefix)/include/asm-sim/bits
+includesubdir = $(includedir)/asm-sim/bits
 
-include_HEADERS = pod.h intr.h heap.h thread.h timer.h init.h
+includesub_HEADERS = pod.h intr.h heap.h thread.h timer.h init.h
Index: include/asm-sim/Makefile.am
===================================================================
--- include/asm-sim/Makefile.am	(revision 2279)
+++ include/asm-sim/Makefile.am	(working copy)
@@ -1,16 +1,16 @@
-includedir = $(prefix)/include/asm-sim
+includesubdir = $(includedir)/asm-sim
 
-include_HEADERS = system.h
+includesub_HEADERS = system.h
 
 install-data-local:
-	$(mkinstalldirs) $(DESTDIR)$(includedir)
-	rm -f $(DESTDIR)$(includedir)/asm
-	$(LN_S) . $(DESTDIR)$(includedir)/asm
-	rm -f $(DESTDIR)$(includedir)/xenomai
-	$(LN_S) . $(DESTDIR)$(includedir)/xenomai
+	$(mkinstalldirs) $(DESTDIR)$(includesubdir)
+	rm -f $(DESTDIR)$(includesubdir)/asm
+	$(LN_S) . $(DESTDIR)$(includesubdir)/asm
+	rm -f $(DESTDIR)$(includesubdir)/xenomai
+	$(LN_S) . $(DESTDIR)$(includesubdir)/xenomai
 
 uninstall-local:
-	rm -f $(DESTDIR)$(includedir)/asm
-	rm -f $(DESTDIR)$(includedir)/xenomai
+	rm -f $(DESTDIR)$(includesubdir)/asm
+	rm -f $(DESTDIR)$(includesubdir)/xenomai
 
 SUBDIRS = bits
Index: include/rtdm/Makefile.am
===================================================================
--- include/rtdm/Makefile.am	(revision 2279)
+++ include/rtdm/Makefile.am	(working copy)
@@ -1,9 +1,9 @@
-includedir = $(prefix)/include/rtdm
+includesubdir = $(includedir)/rtdm
 
 noinst_HEADERS = \
 	syscall.h
 
-include_HEADERS = \
+includesub_HEADERS = \
 	rtdm.h \
 	rtdm_driver.h \
 	rtserial.h \
Index: include/asm-i386/bits/Makefile.am
===================================================================
--- include/asm-i386/bits/Makefile.am	(revision 2279)
+++ include/asm-i386/bits/Makefile.am	(working copy)
@@ -1,3 +1,3 @@
-includedir = $(prefix)/include/asm-i386/bits
+includesubdir = $(includedir)/asm-i386/bits
 
-include_HEADERS = pod.h intr.h heap.h thread.h shadow.h timer.h init.h
+includesub_HEADERS = pod.h intr.h heap.h thread.h shadow.h timer.h init.h
Index: include/asm-i386/Makefile.am
===================================================================
--- include/asm-i386/Makefile.am	(revision 2279)
+++ include/asm-i386/Makefile.am	(working copy)
@@ -1,6 +1,6 @@
-includedir = $(prefix)/include/asm-i386
+includesubdir = $(includedir)/asm-i386
 
-include_HEADERS = atomic.h calibration.h features.h \
+includesub_HEADERS = atomic.h calibration.h features.h \
 		hal.h smi.h switch.h syscall.h system.h wrappers.h fptest.h
 
 SUBDIRS = bits
Index: include/asm-x86_64/bits/Makefile.am
===================================================================
--- include/asm-x86_64/bits/Makefile.am	(revision 2279)
+++ include/asm-x86_64/bits/Makefile.am	(working copy)
@@ -1,3 +1,3 @@
-includedir = $(prefix)/include/asm-x86_64/bits
+includesubdir = $(includedir)/asm-x86_64/bits
 
-include_HEADERS = pod.h intr.h heap.h thread.h shadow.h timer.h init.h
+includesub_HEADERS = pod.h intr.h heap.h thread.h shadow.h timer.h init.h
Index: include/asm-x86_64/Makefile.am
===================================================================
--- include/asm-x86_64/Makefile.am	(revision 2279)
+++ include/asm-x86_64/Makefile.am	(working copy)
@@ -1,6 +1,6 @@
-includedir = $(prefix)/include/asm-x86_64
+includesubdir = $(includedir)/asm-x86_64
 
-include_HEADERS = atomic.h smi.h switch.h calibration.h features.h \
+includesub_HEADERS = atomic.h smi.h switch.h calibration.h features.h \
 		hal.h syscall.h system.h wrappers.h fptest.h
 
 SUBDIRS = bits
Index: include/nucleus/Makefile.am
===================================================================
--- include/nucleus/Makefile.am	(revision 2279)
+++ include/nucleus/Makefile.am	(working copy)
@@ -1,6 +1,6 @@
-includedir = $(prefix)/include/nucleus
+includesubdir = $(includedir)/nucleus
 
-include_HEADERS = \
+includesub_HEADERS = \
 	assert.h \
 	bheap.h \
 	compiler.h \

--vCyHbiz4Nv--

