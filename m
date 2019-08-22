From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH] arm64: build only against next
Date: Thu, 22 Aug 2019 15:21:11 +0200
Message-Id: <20190822132111.5154-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The arm64 architecture is currently only supported by the xenomai
next branch.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/machine/hikey.conf      | 2 ++
 conf/machine/qemu-arm64.conf | 1 +
 kas.yml                      | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/conf/machine/hikey.conf b/conf/machine/hikey.conf
index fc199ab..4972e4d 100644
--- a/conf/machine/hikey.conf
+++ b/conf/machine/hikey.conf
@@ -15,3 +15,5 @@ IMAGE_TYPE = "wic-img"
 IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
 
 IMAGE_PREINSTALL_append = " firmware-ti-connectivity"
+
+PREFERRED_VERSION_xenomai = "next"
\ No newline at end of file
diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
index a633095..472f619 100644
--- a/conf/machine/qemu-arm64.conf
+++ b/conf/machine/qemu-arm64.conf
@@ -12,3 +12,4 @@
 require qemu-machine.inc
 
 DISTRO_ARCH = "arm64"
+PREFERRED_VERSION_xenomai = "next"
diff --git a/kas.yml b/kas.yml
index 2bf62d4..260eb36 100644
--- a/kas.yml
+++ b/kas.yml
@@ -36,4 +36,4 @@ local_conf_header:
   cross: |
     ISAR_CROSS_COMPILE = "1"
   xenomai-version: |
-    PREFERRED_VERSION_xenomai = "stable"
+    PREFERRED_VERSION_xenomai ?= "stable"
-- 
2.20.1


