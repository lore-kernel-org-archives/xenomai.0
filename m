From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] xenomai: Update to 3.0.11
Message-ID: <f22bd554-dce0-9c98-8f9d-6d0ccb767ff0@siemens.com>
Date: Fri, 11 Dec 2020 08:36:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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

The 2 patches could have been dropped with 3.0.10 already, in fact.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...nfig-folder-to-xenomai-kernel-source.patch | 29 -----------------
 ...bian-Enable-SMP-in-userspace-package.patch | 31 -------------------
 .../{xenomai_3.0.10.bb => xenomai_3.0.11.bb}  |  2 --
 3 files changed, 62 deletions(-)
 delete mode 100644 recipes-xenomai/xenomai/files/0001-debian-Add-config-folder-to-xenomai-kernel-source.patch
 delete mode 100644 recipes-xenomai/xenomai/files/0001-debian-Enable-SMP-in-userspace-package.patch
 rename recipes-xenomai/xenomai/{xenomai_3.0.10.bb => xenomai_3.0.11.bb} (71%)

diff --git a/recipes-xenomai/xenomai/files/0001-debian-Add-config-folder-to-xenomai-kernel-source.patch b/recipes-xenomai/xenomai/files/0001-debian-Add-config-folder-to-xenomai-kernel-source.patch
deleted file mode 100644
index 3be4fb3..0000000
--- a/recipes-xenomai/xenomai/files/0001-debian-Add-config-folder-to-xenomai-kernel-source.patch
+++ /dev/null
@@ -1,29 +0,0 @@
-From 07d87b9b2ca45f81024056720b28f6cdbcb3b9c7 Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Tue, 6 Nov 2018 13:37:21 +0100
-Subject: [PATCH] debian: Add config folder to xenomai-kernel-source
-
-Meanwhile required for prepare-kernel.sh.
-
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
-Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
----
- debian/rules | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/debian/rules b/debian/rules
-index 8b871a488..99ed8982c 100755
---- a/debian/rules
-+++ b/debian/rules
-@@ -73,7 +73,7 @@ install: build
- 	cp debian/libxenomai1.lintian $(CURDIR)/debian/libxenomai1/usr/share/lintian/overrides/libxenomai1
- 	cp debian/libxenomai-dev.lintian $(CURDIR)/debian/libxenomai-dev/usr/share/lintian/overrides/libxenomai-dev
- 	mkdir -p $(CURDIR)/debian/xenomai-kernel-source/usr/src/xenomai-kernel-source $(CURDIR)/debian/xenomai-kernel-source/usr/share/doc/xenomai-kernel-source
--	cp -a kernel include scripts $(CURDIR)/debian/xenomai-kernel-source/usr/src/xenomai-kernel-source
-+	cp -a config kernel include scripts $(CURDIR)/debian/xenomai-kernel-source/usr/src/xenomai-kernel-source
- 
- # Build architecture-independent files here.
- binary-indep: build install
--- 
-2.20.1
-
diff --git a/recipes-xenomai/xenomai/files/0001-debian-Enable-SMP-in-userspace-package.patch b/recipes-xenomai/xenomai/files/0001-debian-Enable-SMP-in-userspace-package.patch
deleted file mode 100644
index 6a63a92..0000000
--- a/recipes-xenomai/xenomai/files/0001-debian-Enable-SMP-in-userspace-package.patch
+++ /dev/null
@@ -1,31 +0,0 @@
-From a4ec3f654a4be50aaf268c3a540e8b110ad2ded3 Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Tue, 6 Nov 2018 18:59:47 +0100
-Subject: [PATCH] debian: Enable SMP in userspace package
-
-Hard to find a UP target these days, and we definitely want to be
-generic with Debian packages.
-
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
-Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
----
- debian/rules | 3 ++-
- 1 file changed, 2 insertions(+), 1 deletion(-)
-
-diff --git a/debian/rules b/debian/rules
-index 99ed8982c..883ae3ed8 100755
---- a/debian/rules
-+++ b/debian/rules
-@@ -16,7 +16,8 @@ DEB_BUILD_GNU_TYPE=$(shell dpkg-architecture -qDEB_BUILD_GNU_TYPE)
- CONFIG_OPTS = --prefix=/usr \
-             --includedir=/usr/include/xenomai \
-             --mandir=/usr/share/man \
--	    --with-testdir=/usr/lib/xenomai/testsuite
-+            --with-testdir=/usr/lib/xenomai/testsuite \
-+            --enable-smp
- 
- ifneq ($(DEB_HOST_GNU_TYPE),$(DEB_BUILD_GNU_TYPE))
- 	CONFIG_OPTS += --build $(DEB_BUILD_GNU_TYPE) --host $(DEB_HOST_GNU_TYPE)
--- 
-2.20.1
-
diff --git a/recipes-xenomai/xenomai/xenomai_3.0.10.bb b/recipes-xenomai/xenomai/xenomai_3.0.11.bb
similarity index 71%
rename from recipes-xenomai/xenomai/xenomai_3.0.10.bb
rename to recipes-xenomai/xenomai/xenomai_3.0.11.bb
index 4b733fb..b21b763 100644
--- a/recipes-xenomai/xenomai/xenomai_3.0.10.bb
+++ b/recipes-xenomai/xenomai/xenomai_3.0.11.bb
@@ -13,7 +13,5 @@ require xenomai.inc
 
 SRC_URI = " \
     git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=stable/v3.0.x;tag=v${PV} \
-file://0001-debian-Add-config-folder-to-xenomai-kernel-source.patch \
-file://0001-debian-Enable-SMP-in-userspace-package.patch \
     "
 S = "${WORKDIR}/git"
-- 
2.26.2

