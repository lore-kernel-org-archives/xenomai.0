From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images PATCH 2/2] recipes-kernel/linux: Allow overwrite of
 KERNEL_DEFCONFIG
Date: Fri, 14 Feb 2020 09:38:19 +0100
Message-Id: <20200214083819.31451-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200214083819.31451-1-Quirin.Gylstorff@siemens.com>
References: <20200214083819.31451-1-Quirin.Gylstorff@siemens.com>
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

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas.yml                                       |  4 +++
 ...inux-Weak-KERNEL_DEFCONFIG-to-allow-.patch | 29 +++++++++++++++++++
 recipes-kernel/linux/linux-xenomai.inc        |  2 +-
 3 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 patches/0001-recipes-kernel-linux-Weak-KERNEL_DEFCONFIG-to-allow-.patch

diff --git a/kas.yml b/kas.yml
index d04b9c3..52c81e3 100644
--- a/kas.yml
+++ b/kas.yml
@@ -23,6 +23,10 @@ repos:
     refspec: 18b3e9a15d1f054f5d1e697c66a8f1f9befc0537
     layers:
       meta:
+    patches:
+      weak-kernel-config:
+        path: patches/0001-recipes-kernel-linux-Weak-KERNEL_DEFCONFIG-to-allow-.patch
+        repo: xenomai
 
 bblayers_conf_header:
   standard: |
diff --git a/patches/0001-recipes-kernel-linux-Weak-KERNEL_DEFCONFIG-to-allow-.patch b/patches/0001-recipes-kernel-linux-Weak-KERNEL_DEFCONFIG-to-allow-.patch
new file mode 100644
index 0000000..6b68473
--- /dev/null
+++ b/patches/0001-recipes-kernel-linux-Weak-KERNEL_DEFCONFIG-to-allow-.patch
@@ -0,0 +1,29 @@
+From 8fe37bbc21ae24ae628fdbe64316fd3753385f4c Mon Sep 17 00:00:00 2001
+From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+Date: Wed, 15 Jan 2020 15:24:43 +0100
+Subject: [PATCH] recipes-kernel/linux: Weak KERNEL_DEFCONFIG to allow
+ overwrites
+To: isar-users@googlegroups.com
+Cc: Jan Kiszka <jan.kiszka@siemens.com>
+
+Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+---
+ meta/recipes-kernel/linux/linux-custom.inc | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/meta/recipes-kernel/linux/linux-custom.inc b/meta/recipes-kernel/linux/linux-custom.inc
+index d31da3b..4fb7ca2 100644
+--- a/meta/recipes-kernel/linux/linux-custom.inc
++++ b/meta/recipes-kernel/linux/linux-custom.inc
+@@ -39,7 +39,7 @@ KERNEL_LIBC_DEV_DEPLOY ?= "0"
+ 
+ LINUX_VERSION_EXTENSION ?= ""
+ 
+-KERNEL_DEFCONFIG ?= ""
++KERNEL_DEFCONFIG ??= ""
+ 
+ # Add our template meta-data to the sources
+ FILESEXTRAPATHS_prepend := "${FILE_DIRNAME}/files:"
+-- 
+2.20.1
+
diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
index 3407b82..185b60b 100644
--- a/recipes-kernel/linux/linux-xenomai.inc
+++ b/recipes-kernel/linux/linux-xenomai.inc
@@ -11,7 +11,7 @@
 
 require recipes-kernel/linux/linux-custom.inc
 
-KERNEL_DEFCONFIG = "${DISTRO_ARCH}_defconfig"
+KERNEL_DEFCONFIG ?= "${DISTRO_ARCH}_defconfig"
 
 SRC_URI += "file://${KERNEL_DEFCONFIG}"
 
-- 
2.20.1


