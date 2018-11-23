From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 1/3] xenomai: Remove patches
Date: Fri, 23 Nov 2018 14:54:28 +0100
Message-Id: <9fdcb5c0e812d89a1959cf0ade62cb4eb0a24605.1542981269.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1542981269.git.jan.kiszka@siemens.com>
References: <cover.1542981269.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1542981269.git.jan.kiszka@siemens.com>
References: <cover.1542981269.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

By now merged even into master.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...dd-config-folder-to-xenomai-kernel-source.patch | 28 --------------
 ...2-debian-Add-arm64-as-target-architecture.patch | 44 ----------------------
 ...03-debian-Enable-SMP-in-userspace-package.patch | 30 ---------------
 recipes-xenomai/xenomai/xenomai_next.bb            |  5 +--
 4 files changed, 1 insertion(+), 106 deletions(-)
 delete mode 100644 recipes-xenomai/xenomai/files/0001-debian-Add-config-folder-to-xenomai-kernel-source.patch
 delete mode 100644 recipes-xenomai/xenomai/files/0002-debian-Add-arm64-as-target-architecture.patch
 delete mode 100644 recipes-xenomai/xenomai/files/0003-debian-Enable-SMP-in-userspace-package.patch

diff --git a/recipes-xenomai/xenomai/files/0001-debian-Add-config-folder-to-xenomai-kernel-source.patch b/recipes-xenomai/xenomai/files/0001-debian-Add-config-folder-to-xenomai-kernel-source.patch
deleted file mode 100644
index d3de9c4..0000000
--- a/recipes-xenomai/xenomai/files/0001-debian-Add-config-folder-to-xenomai-kernel-source.patch
+++ /dev/null
@@ -1,28 +0,0 @@
-From 07d87b9b2ca45f81024056720b28f6cdbcb3b9c7 Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Tue, 6 Nov 2018 13:37:21 +0100
-Subject: [PATCH] debian: Add config folder to xenomai-kernel-source
-
-Meanwhile required for prepare-kernel.sh.
-
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
----
- debian/rules | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/debian/rules b/debian/rules
-index 8b871a4882..99ed8982ce 100755
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
-2.16.4
-
diff --git a/recipes-xenomai/xenomai/files/0002-debian-Add-arm64-as-target-architecture.patch b/recipes-xenomai/xenomai/files/0002-debian-Add-arm64-as-target-architecture.patch
deleted file mode 100644
index fbcb344..0000000
--- a/recipes-xenomai/xenomai/files/0002-debian-Add-arm64-as-target-architecture.patch
+++ /dev/null
@@ -1,44 +0,0 @@
-From d8db92eb66ebd314d339a5faa5245b52ce093bef Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Tue, 6 Nov 2018 16:34:17 +0100
-Subject: [PATCH] debian: Add arm64 as target architecture
-
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
----
- debian/control | 6 +++---
- 1 file changed, 3 insertions(+), 3 deletions(-)
-
-diff --git a/debian/control b/debian/control
-index 3427987e15..477b16d9fd 100644
---- a/debian/control
-+++ b/debian/control
-@@ -8,7 +8,7 @@ Homepage: http://www.xenomai.org/
- 
- Package: xenomai-runtime
- Section: devel
--Architecture: amd64 arm armeb armel armhf i386 powerpc powerpcspe
-+Architecture: amd64 arm armeb armel armhf arm64 i386 powerpc powerpcspe
- Depends: ${shlibs:Depends}, ${misc:Depends}
- Suggests: xenomai-kernel-source
- Replaces: xenomai
-@@ -45,7 +45,7 @@ Description: Source for Xenomai kernel-space support
- 
- Package: libxenomai1
- Section: libs
--Architecture: amd64 arm armeb armel armhf i386 powerpc powerpcspe
-+Architecture: amd64 arm armeb armel armhf arm64 i386 powerpc powerpcspe
- Depends: ${shlibs:Depends}, ${misc:Depends}
- Suggests: xenomai-kernel-source
- Replaces: xenomai
-@@ -61,7 +61,7 @@ Description: Shared libraries for Xenomai
- 
- Package: libxenomai-dev
- Section: libdevel
--Architecture: amd64 arm armeb armel armhf i386 powerpc powerpcspe
-+Architecture: amd64 arm armeb armel armhf arm64 i386 powerpc powerpcspe
- Depends: libxenomai1 (= ${binary:Version}), ${misc:Depends}
- Suggests: xenomai-kernel-source
- Replaces: xenomai
--- 
-2.16.4
-
diff --git a/recipes-xenomai/xenomai/files/0003-debian-Enable-SMP-in-userspace-package.patch b/recipes-xenomai/xenomai/files/0003-debian-Enable-SMP-in-userspace-package.patch
deleted file mode 100644
index 98632b4..0000000
--- a/recipes-xenomai/xenomai/files/0003-debian-Enable-SMP-in-userspace-package.patch
+++ /dev/null
@@ -1,30 +0,0 @@
-From a4ec3f654a4be50aaf268c3a540e8b110ad2ded3 Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Tue, 6 Nov 2018 18:59:47 +0100
-Subject: [PATCH] debian: Enable SMP in userspace package
-
-Hard to find a UP target these days, and we definitely want to be
-generic with Debian packages.
-
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
----
- debian/rules | 3 ++-
- 1 file changed, 2 insertions(+), 1 deletion(-)
-
-diff --git a/debian/rules b/debian/rules
-index 99ed8982ce..883ae3ed8c 100755
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
-2.16.4
-
diff --git a/recipes-xenomai/xenomai/xenomai_next.bb b/recipes-xenomai/xenomai/xenomai_next.bb
index 3541d2d..6bc43ac 100644
--- a/recipes-xenomai/xenomai/xenomai_next.bb
+++ b/recipes-xenomai/xenomai/xenomai_next.bb
@@ -12,10 +12,7 @@
 require xenomai.inc
 
 SRC_URI = " \
-    git://gitlab.denx.de/Xenomai/xenomai.git;protocol=https;branch=next \
-    file://0001-debian-Add-config-folder-to-xenomai-kernel-source.patch \
-    file://0002-debian-Add-arm64-as-target-architecture.patch \
-    file://0003-debian-Enable-SMP-in-userspace-package.patch"
+    git://gitlab.denx.de/Xenomai/xenomai.git;protocol=https;branch=next"
 SRCREV = "next"
 PV = "9999-next"
 
-- 
2.16.4


