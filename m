From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH v3 4/8] isar: Update ISAR to current next
Date: Mon, 15 Nov 2021 11:13:42 +0100
Message-Id: <20211115101346.3566075-5-florian.bezdeka@siemens.com>
In-Reply-To: <20211115101346.3566075-1-florian.bezdeka@siemens.com>
References: <20211115101346.3566075-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Updating to the latest ISAR next revision to avoid carrying ISAR
patches. Some adjustments to CI scripts and machine configs were
necessary to follow ISAR upstream.

  - The ssh key generation had some problems on Debian 11.
    The key generation was started in parallel to the entropy feeding,
    so it took quite long. This is already fixed in latest ISAR.

  - For amd64 the generated kernel is now named vmlinux instead of
    vmlinuz. Some CI related scripts and LAVA job description files
    had to be updated.

  - DTB_FILE has been renamed to DTB_FILES

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 conf/machine/beagle-bone-black.conf |  2 +-
 conf/machine/hikey.conf             |  2 +-
 kas.yml                             |  2 +-
 scripts/deploy_to_aws.sh            | 11 ++++++++++-
 start-qemu.sh                       |  5 ++++-
 tests/jobs/xenomai-hikey.yml        |  2 +-
 tests/jobs/xenomai-qemu-arm64.yml   |  2 +-
 7 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/conf/machine/beagle-bone-black.conf b/conf/machine/beagle-bone-black.conf
index 90b9f13..af6e8f5 100644
--- a/conf/machine/beagle-bone-black.conf
+++ b/conf/machine/beagle-bone-black.conf
@@ -14,6 +14,6 @@ DISTRO_ARCH = "armhf"
 IMAGE_INSTALL += "u-boot-script"
 
 IMAGE_TYPE ?= "wic-img"
-DTB_FILE = "am335x-boneblack.dtb"
+DTB_FILES = "am335x-boneblack.dtb"
 IMAGER_INSTALL += "u-boot-omap"
 IMAGE_PREINSTALL += "fake-hwclock"
diff --git a/conf/machine/hikey.conf b/conf/machine/hikey.conf
index 9c90b9d..dc7bc57 100644
--- a/conf/machine/hikey.conf
+++ b/conf/machine/hikey.conf
@@ -17,4 +17,4 @@ IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
 IMAGE_PREINSTALL_append = " firmware-ti-connectivity"
 
 # DTB for testing
-DTB_FILE = "hi6220-hikey.dtb"
+DTB_FILES = "hi6220-hikey.dtb"
diff --git a/kas.yml b/kas.yml
index c8bafcd..93e9b82 100644
--- a/kas.yml
+++ b/kas.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: 1cfe166c5e53ae96bc07b895a92bf6cd7ace7bc9
+    refspec: 90e1fa6a80f7240109507f2f7e7ca59f50bbb2d4
     layers:
       meta:
 
diff --git a/scripts/deploy_to_aws.sh b/scripts/deploy_to_aws.sh
index e7c22f0..7d9aa89 100755
--- a/scripts/deploy_to_aws.sh
+++ b/scripts/deploy_to_aws.sh
@@ -29,8 +29,17 @@ aws_args="--acl=public-read"
 
 isar_base_name="${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${target}"
 deploy_dir="${destination}/${CI_PIPELINE_ID}/${DEPLOY_DIR_EXTENSION}"
+
+kernel="${images_dir}/${target}/${isar_base_name}-vmlinuz"
+kernel_suffix="vmlinuz"
+if [ ! -f "${kernel}" ]; then
+    # care about arm64 targets
+    kernel="${images_dir}/${target}/${isar_base_name}-vmlinux"
+    kernel_suffix="vmlinux"
+fi
+
 #KERNEL
-aws s3 cp "${aws_args}" "${images_dir}/${target}/${isar_base_name}-vmlinuz" "${deploy_dir}/${isar_base_name}-vmlinuz"
+aws s3 cp "${aws_args}" "${kernel}" "${deploy_dir}/${isar_base_name}-${kernel_suffix}"
 # INITRD
 aws s3 cp "${aws_args}" "${images_dir}/${target}/${isar_base_name}-initrd.img" "${deploy_dir}/${isar_base_name}-initrd.img"
 # ROOTFS
diff --git a/start-qemu.sh b/start-qemu.sh
index a1c29bf..68516cc 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -31,6 +31,7 @@ case "$1" in
 			-enable-kvm -machine q35 \
 			-device ide-hd,drive=disk \
 			-device virtio-net-pci,netdev=net"
+		KERNEL_SUFFIX="vmlinuz"
 		KERNEL_CMDLINE=" \
 			root=/dev/sda vga=0x305"
 		;;
@@ -45,6 +46,7 @@ case "$1" in
 			-device virtconsole,chardev=con -chardev vc,id=con \
 			-device virtio-blk-device,drive=disk \
 			-device virtio-net-device,netdev=net"
+		KERNEL_SUFFIX="vmlinux"
 		KERNEL_CMDLINE=" \
 			root=/dev/vda"
 		;;
@@ -59,6 +61,7 @@ case "$1" in
 			-device virtconsole,chardev=con -chardev vc,id=con \
 			-device virtio-blk-device,drive=disk \
 			-device virtio-net-device,netdev=net"
+		KERNEL_SUFFIX="vmlinuz"
 		KERNEL_CMDLINE=" \
 			root=/dev/vda"
 		;;
@@ -82,5 +85,5 @@ shift 1
 ${QEMU_PATH}${QEMU} \
 	-drive file=${IMAGE_PREFIX}.ext4.img,discard=unmap,if=none,id=disk,format=raw \
 	-m 1G -serial mon:stdio -netdev user,id=net \
-	-kernel ${IMAGE_PREFIX}-vmlinuz -append "${KERNEL_CMDLINE}" \
+	-kernel ${IMAGE_PREFIX}-${KERNEL_SUFFIX} -append "${KERNEL_CMDLINE}" \
 	-initrd ${IMAGE_PREFIX}-initrd.img ${QEMU_EXTRA_ARGS} "$@"
diff --git a/tests/jobs/xenomai-hikey.yml b/tests/jobs/xenomai-hikey.yml
index 14fd9f3..4b2c033 100644
--- a/tests/jobs/xenomai-hikey.yml
+++ b/tests/jobs/xenomai-hikey.yml
@@ -31,7 +31,7 @@ actions:
       minutes: 30
     to: tftp
     kernel:
-      url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
+      url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinux
       type: image
     dtb:
       url: ${DEPLOY_URL}/hi6220-hikey.dtb
diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
index fa0b5bb..4907ca4 100644
--- a/tests/jobs/xenomai-qemu-arm64.yml
+++ b/tests/jobs/xenomai-qemu-arm64.yml
@@ -51,7 +51,7 @@ actions:
     images:
       kernel:
         image_arg: -kernel {kernel} -append "root=/dev/vda"
-        url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
+        url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinux
       initrd:
         image_arg: -initrd {initrd}
         url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-initrd.img
-- 
2.30.2


