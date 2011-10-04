Message-ID: <4E8B0BC6.7030000@domain.hid>
Date: Tue, 04 Oct 2011 15:36:06 +0200
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060004050404030201060802"
Subject: [Xenomai-core] patch: build: restore building of xeno-config man
	page
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------060004050404030201060802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

here is a simple patch to the build system to restore the building of
xeno-config man page. It got lost some time ago. I noticed that it was
missing because debian packages failed to build.

Cheers,
-- 
Daniele

--------------060004050404030201060802
Content-Type: text/x-diff;
 name="0002-build-restore-building-of-xeno-config-man-page.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-build-restore-building-of-xeno-config-man-page.patch"

>From 958e522ea5aad32e9cd227e572be4ffbaff73ef9 Mon Sep 17 00:00:00 2001
From: Daniele Nicolodi <nicolodi@domain.hid>
Date: Tue, 4 Oct 2011 14:59:49 +0200
Subject: build: restore building of xeno-config man page

---
 doc/man/Makefile.am |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/man/Makefile.am b/doc/man/Makefile.am
index c2f753a..18f2bd1 100644
--- a/doc/man/Makefile.am
+++ b/doc/man/Makefile.am
@@ -1,4 +1,4 @@
-man1_MANS = clocktest.man cyclictest.man irqbench.man irqloop.man \
-	    klatency.man latency.man rtcanconfig.man \
-	    rtcanrecv.man rtcansend.man switchbench.man \
+man1_MANS = xeno-config.man clocktest.man cyclictest.man irqbench.man	\
+	    irqloop.man klatency.man latency.man rtcanconfig.man	\
+	    rtcanrecv.man rtcansend.man switchbench.man			\
 	    switchtest.man xeno.man
-- 
1.7.6.3


--------------060004050404030201060802--

