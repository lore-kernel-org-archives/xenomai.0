From: gernot.hillier@siemens.com
Date: Fri,  8 Nov 2013 10:34:23 +0100
Message-Id: <1383903263-10441-8-git-send-email-gernot.hillier@siemens.com>
In-Reply-To: <1383903263-10441-1-git-send-email-gernot.hillier@siemens.com>
References: <1383903263-10441-1-git-send-email-gernot.hillier@siemens.com>
Subject: [Xenomai] [Xenomai-forge PATCH 7/7] debian: Prepare packaging for
	Xenomai-forge based on Xenomai-2.6 Debian rules
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Gernot Hillier <gernot.hillier@siemens.com>

Signed-off-by: Gernot Hillier <gernot.hillier@siemens.com>
---
 debian/changelog              | 8 +++++++-
 debian/libxenomai-dev.install | 1 -
 debian/rules                  | 6 +++---
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/debian/changelog b/debian/changelog
index e12e856..666b446 100644
--- a/debian/changelog
+++ b/debian/changelog
@@ -1,4 +1,10 @@
-xenomai (2.6.3) UNRELEASED; urgency=low
+xenomai (2.99.0) UNRELEASED; urgency=low
+
+  * Prepare Debian packaging for Xenomai-forge
+
+ -- Xenomai <xenomai@xenomai.org>  Wed, 20 Nov 2013 09:33:50 +0200
+
+xenomai (2.6.3) unstable; urgency=low
 
   * New release
 
diff --git a/debian/libxenomai-dev.install b/debian/libxenomai-dev.install
index 0fbe55b..3aa55d5 100644
--- a/debian/libxenomai-dev.install
+++ b/debian/libxenomai-dev.install
@@ -5,4 +5,3 @@ usr/lib/*.a
 usr/lib/*.so
 usr/lib/cobalt.wrappers
 usr/share/man/man1/xeno-config.1
-../../examples usr/share/libxenomai-dev
diff --git a/debian/rules b/debian/rules
index 5e3c9df..46a89b1 100755
--- a/debian/rules
+++ b/debian/rules
@@ -75,13 +75,13 @@ install: build
 	cp debian/libxenomai1.lintian $(CURDIR)/debian/libxenomai1/usr/share/lintian/overrides/libxenomai1
 	cp debian/libxenomai-dev.lintian $(CURDIR)/debian/libxenomai-dev/usr/share/lintian/overrides/libxenomai-dev
 	mkdir -p $(CURDIR)/debian/xenomai-kernel-source/usr/src/xenomai-kernel-source $(CURDIR)/debian/xenomai-kernel-source/usr/share/doc/xenomai-kernel-source
-	cp -a ksrc include scripts $(CURDIR)/debian/xenomai-kernel-source/usr/src/xenomai-kernel-source
+	cp -a kernel include scripts $(CURDIR)/debian/xenomai-kernel-source/usr/src/xenomai-kernel-source
 
 # Build architecture-independent files here.
 binary-indep: build install
 	dh_testdir -i
 	dh_testroot -i
-	dh_installdocs -i -A CREDITS README.INSTALL TROUBLESHOOTING
+	dh_installdocs -i -A README.INSTALL TROUBLESHOOTING
 	dh_link -i
 	dh_installchangelogs -i
 	dh_strip -i
@@ -100,7 +100,7 @@ binary-arch: build install
 	dh_testroot -s
 	dh_installinit -s --name=xenomai
 	dh_installman -s
-	dh_installdocs -s -A CREDITS README.INSTALL TROUBLESHOOTING
+	dh_installdocs -s -A README.INSTALL TROUBLESHOOTING
 	dh_link -s
 	dh_installchangelogs -s
 	dh_strip -s
-- 
1.8.1.2


