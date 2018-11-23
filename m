Subject: [xenomai-images][PATCH v2 2/3] Update to latest Isar next
References: <cover.1542981269.git.jan.kiszka@siemens.com>
 <d826a32bc4373de7b89837c969f120a1598be6ab.1542981269.git.jan.kiszka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <727c3891-1f40-f3ff-f43f-18a0132dac87@siemens.com>
Date: Fri, 23 Nov 2018 16:44:36 +0100
MIME-Version: 1.0
In-Reply-To: <d826a32bc4373de7b89837c969f120a1598be6ab.1542981269.git.jan.kiszka@siemens.com>
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
To: xenomai@xenomai.org

This allows to drop the local patch, requires to set uid:gid on chroot
and set LAYERSERIES_COMPAT_xenomai. Also, image deployment paths
changed.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - also account for image deployment patch change

That means: It's now even tested, at least partially...

 conf/layer.conf                                    |  2 ++
 ...m-Update-isar-apt-prior-to-installing-bui.patch | 38 ----------------------
 kas.yml                                            |  6 +---
 recipes-kernel/linux/linux-xenomai.inc             |  2 +-
 recipes-xenomai/xenomai/xenomai_next.bb            |  3 +-
 start-qemu.sh                                      |  2 +-
 6 files changed, 7 insertions(+), 46 deletions(-)
 delete mode 100644 isar-patches/0001-linux-custom-Update-isar-apt-prior-to-installing-bui.patch

diff --git a/conf/layer.conf b/conf/layer.conf
index d4fb919..f665993 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -18,4 +18,6 @@ BBFILE_COLLECTIONS += "xenomai"
 BBFILE_PATTERN_xenomai = "^${LAYERDIR}/"
 BBFILE_PRIORITY_xenomai = "6"
 
+LAYERSERIES_COMPAT_xenomai = "next"
+
 LAYERDIR_xenomai = "${LAYERDIR}"
diff --git a/isar-patches/0001-linux-custom-Update-isar-apt-prior-to-installing-bui.patch b/isar-patches/0001-linux-custom-Update-isar-apt-prior-to-installing-bui.patch
deleted file mode 100644
index 5953ae8..0000000
--- a/isar-patches/0001-linux-custom-Update-isar-apt-prior-to-installing-bui.patch
+++ /dev/null
@@ -1,38 +0,0 @@
-From 1951178503036e47931e5bccbab241c11e949c52 Mon Sep 17 00:00:00 2001
-From: Jan Kiszka <jan.kiszka@siemens.com>
-Date: Tue, 6 Nov 2018 09:43:22 +0100
-Subject: [PATCH] linux-custom: Update isar-apt prior to installing build deps
-
-Some of them may have been built by a recipe.
-
-Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
----
- meta/recipes-kernel/linux/linux-custom.inc | 7 +++++++
- 1 file changed, 7 insertions(+)
-
-diff --git a/meta/recipes-kernel/linux/linux-custom.inc b/meta/recipes-kernel/linux/linux-custom.inc
-index e9a68fd..d9b2935 100644
---- a/meta/recipes-kernel/linux/linux-custom.inc
-+++ b/meta/recipes-kernel/linux/linux-custom.inc
-@@ -27,11 +27,18 @@ KERNEL_DEBIAN_DEPENDS ?= "initramfs-tools | linux-initramfs-tool, kmod, linux-ba
- KERNEL_HEADERS_DEBIAN_DEPENDS ?= "libc6, libssl1.1"
- 
- do_install_builddeps() {
-+	dpkg_do_mounts
- 	E="${@ bb.utils.export_proxies(d)}"
-+	sudo -E chroot ${BUILDCHROOT_DIR} \
-+		apt-get update \
-+			-o Dir::Etc::sourcelist="sources.list.d/isar-apt.list" \
-+			-o Dir::Etc::sourceparts="-" \
-+			-o APT::Get::List-Cleanup="0"
- 	sudo -E chroot ${BUILDCHROOT_DIR} \
- 		apt-get install \
- 			-y -o Debug::pkgProblemResolver=yes \
- 			--no-install-recommends ${KBUILD_DEPENDS}
-+	dpkg_undo_mounts
- }
- 
- addtask install_builddeps after do_prepare_build before do_build
--- 
-2.16.4
-
diff --git a/kas.yml b/kas.yml
index 4bbfcaa..2af48a6 100644
--- a/kas.yml
+++ b/kas.yml
@@ -19,14 +19,10 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar
-    refspec: be291cd991bd64051f5e34af24b04feddaaea48c
+    refspec: 1e24c4b477142925834eee29a4b5cdb317599a29
     layers:
       meta:
       meta-isar:
-    patches:
-      fixes:
-        repo: xenomai
-        path: isar-patches/0001-linux-custom-Update-isar-apt-prior-to-installing-bui.patch
 
 bblayers_conf_header:
   standard: |
diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
index 07747f7..d93e614 100644
--- a/recipes-kernel/linux/linux-xenomai.inc
+++ b/recipes-kernel/linux/linux-xenomai.inc
@@ -34,7 +34,7 @@ dpkg_runbuild_prepend() {
 		exit 1
 	esac
 
-	sudo chroot ${BUILDCHROOT_DIR} \
+	sudo chroot --userspec=$( id -u ):$( id -g ) ${BUILDCHROOT_DIR} \
 		/usr/src/xenomai-kernel-source/scripts/prepare-kernel.sh \
 			--linux=${PP}/${PPS} --arch=$ARCH
 }
diff --git a/recipes-xenomai/xenomai/xenomai_next.bb b/recipes-xenomai/xenomai/xenomai_next.bb
index 6bc43ac..72e5758 100644
--- a/recipes-xenomai/xenomai/xenomai_next.bb
+++ b/recipes-xenomai/xenomai/xenomai_next.bb
@@ -22,5 +22,6 @@ dpkg_runbuild_prepend() {
     bbplain $(printf "xenomai-next: Building revision %.12s\n" \
                      $(cat ${S}/.git/refs/heads/next))
 
-    sudo chroot ${BUILDCHROOT_DIR} sh -c "cd ${PP}/${PPS}; scripts/bootstrap"
+    sudo chroot --userspec=$( id -u ):$( id -g ) ${BUILDCHROOT_DIR} \
+        sh -c "cd ${PP}/${PPS}; scripts/bootstrap"
 }
diff --git a/start-qemu.sh b/start-qemu.sh
index 0daf69c..c56c234 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -57,7 +57,7 @@ case "$1" in
 		;;
 esac
 
-IMAGE_PREFIX="$(dirname $0)/build/tmp/deploy/images/demo-image-qemu-${DISTRO_ARCH}-xenomai-demo-qemu-${DISTRO_ARCH}"
+IMAGE_PREFIX="$(dirname $0)/build/tmp/deploy/images/qemu-${DISTRO_ARCH}/demo-image-qemu-${DISTRO_ARCH}-xenomai-demo-qemu-${DISTRO_ARCH}"
 IMAGE_FILE=$(ls ${IMAGE_PREFIX}.ext4.img)
 
 KERNEL_FILE=$(ls ${IMAGE_PREFIX}.vmlinuz* | tail -1)
-- 
2.16.4

