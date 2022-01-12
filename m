Message-ID: <a3ff4fe4-d4ba-04c4-d231-955adf3d005c@siemens.com>
Date: Wed, 12 Jan 2022 17:33:00 +0100
MIME-Version: 1.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] debian: Update to compat level 10, resolve deprecation
 warnings
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This addresses

warning: Compatibility levels before 10 are deprecated (level 9 in use)
warning: -s/--same-arch is deprecated; please use -a/--arch instead
warning: This feature will be removed in compat 12.

on bullseye while remaining compatible with buster.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
  debian/compat |  2 +-
  debian/rules  | 32 ++++++++++++++++----------------
  2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/debian/compat b/debian/compat
index ec635144f6..f599e28b8a 100644
--- a/debian/compat
+++ b/debian/compat
@@ -1 +1 @@
-9
+10
diff --git a/debian/rules b/debian/rules
index 3fc65ef3a2..3fe6bece93 100755
--- a/debian/rules
+++ b/debian/rules
@@ -102,20 +102,20 @@ binary-indep: build install
  
  # Build architecture-dependent files here.
  binary-arch: build install
-	dh_testdir -s
-	dh_testroot -s
-	dh_installinit -s --name=xenomai
-	dh_installman -s
-	dh_installdocs -s -A README
-	dh_link -s
-	dh_installchangelogs -s
-	dh_strip -s --exclude=smokey
-	dh_compress -s
-	dh_fixperms -s
-	dh_makeshlibs -s
-	dh_installdeb -s
-	dh_shlibdeps -s
-	dh_gencontrol -s
+	dh_testdir -a
+	dh_testroot -a
+	dh_installinit -a --name=xenomai
+	dh_installman -a
+	dh_installdocs -a -A README
+	dh_link -a
+	dh_installchangelogs -a
+	dh_strip -a --exclude=smokey
+	dh_compress -a
+	dh_fixperms -a
+	dh_makeshlibs -a
+	dh_installdeb -a
+	dh_shlibdeps -a
+	dh_gencontrol -a
  #	 Echo config options to control.
  	echo " ." >> $(CURDIR)/debian/libxenomai1/DEBIAN/control
  	echo " Compiled with the following options." >> \
@@ -123,8 +123,8 @@ binary-arch: build install
  	echo "$(CONFIG_OPTS)" | awk '{ for ( i=1 ; i<=NF ; i++ ) print "   "$$i }' >> \
  	        $(CURDIR)/debian/libxenomai1/DEBIAN/control
  #	 End of hackery.
-	dh_md5sums -s
-	dh_builddeb -s
+	dh_md5sums -a
+	dh_builddeb -a
  
  # We have nothing to do by default.
  
-- 
2.31.1

