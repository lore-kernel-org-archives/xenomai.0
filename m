From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 3/3] ci: Add the option to build the latest
 kernel
Date: Fri, 20 Sep 2019 16:57:31 +0200
Message-Id: <20190920145731.25281-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20190920145731.25281-1-Quirin.Gylstorff@siemens.com>
References: <20190920145731.25281-1-Quirin.Gylstorff@siemens.com>
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

For testing it is possible to select the latest kernel
and latest xenomai-version. This is done with the variable
BUILD_OPTIONS. Trigger and project variables can overwrite
this value if necessary [1]. Isar will be patch to allow
the package version to be "latest" and independent from
the kernel version.

The build can be triggered with:

curl -X POST \
     -F token=TOKEN \
     -F "ref=REF" \
     -F "variables[BUILD_OPTIONS]=opt-linux-latest.yml:opt-xenomai-next.yml" \
     https://URL

[1]: https://docs.gitlab.com/ee/ci/variables/#priority-of-environment-variables

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml                                |  13 +-
 kas.yml                                       |   4 +
 opt-linux-latest.yml                          |  20 ++
 opt-latest.yml => opt-xenomai-next.yml        |   0
 ...inux-build-kernel-Allow-kernel-build.patch | 173 ++++++++++++++++++
 recipes-kernel/linux/linux-xenomai_latest.bb  |  24 +++
 6 files changed, 228 insertions(+), 6 deletions(-)
 create mode 100644 opt-linux-latest.yml
 rename opt-latest.yml => opt-xenomai-next.yml (100%)
 create mode 100644 patches/0001-recipes-kernel-linux-build-kernel-Allow-kernel-build.patch
 create mode 100644 recipes-kernel/linux/linux-xenomai_latest.bb

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 9bb8b1a..bc51b00 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -18,6 +18,7 @@ variables:
   https_proxy: "$HTTPS_PROXY"
   ftp_proxy: "$FTP_PROXY"
   no_proxy: "$NO_PROXY"
+  BUILD_OPTIONS: "opt-xenomai-next.yml"
 default:
   image: kasproject/kas-isar:latest
 
@@ -34,7 +35,7 @@ build:qemu-amd64:
   <<: *lava-ssh-key
   stage: build
   script:
-    - kas build kas.yml:board-qemu-amd64.yml
+    - kas build kas.yml:board-qemu-amd64.yml:${BUILD_OPTIONS}
     - scripts/deploy_for_testing.sh qemu-amd64
 
 lava-test:qemu-amd64:
@@ -52,7 +53,7 @@ build:qemu-armhf:
   <<: *lava-ssh-key
   stage: build
   script:
-    - kas build kas.yml:board-qemu-armhf.yml
+    - kas build kas.yml:board-qemu-armhf.yml:${BUILD_OPTIONS}
     - scripts/deploy_for_testing.sh qemu-armhf
 
 lava-test:qemu-armhf:
@@ -70,7 +71,7 @@ build:qemu-arm64:
   <<: *lava-ssh-key
   stage: build
   script:
-    - kas build kas.yml:board-qemu-arm64.yml
+    - kas build kas.yml:board-qemu-arm64.yml:${BUILD_OPTIONS}
     - scripts/deploy_for_testing.sh qemu-arm64
 
 lava-test:qemu-arm64:
@@ -88,7 +89,7 @@ build:board-hikey:
   <<: *lava-ssh-key
   stage: build
   script:
-    - kas build kas.yml:board-hikey.yml:opt-latest.yml:opt-lava-test.yml
+    - kas build kas.yml:board-hikey.yml:opt-lava-test.yml:${BUILD_OPTIONS}
     - scripts/deploy_for_testing.sh hikey
 # hikey is currently not part of the testlab
 
@@ -96,7 +97,7 @@ build:board-beaglebone:
   <<: *lava-ssh-key
   stage: build
   script:
-    - kas build kas.yml:board-beagle-bone-black.yml:opt-latest.yml:opt-lava-test.yml
+    - kas build kas.yml:board-beagle-bone-black.yml:opt-lava-test.yml:${BUILD_OPTIONS}
     - scripts/deploy_for_testing.sh beagle-bone-black
 
 lava-test:board-beaglebone:
@@ -114,7 +115,7 @@ build:board-x86-64-efi:
   <<: *lava-ssh-key
   stage: build
   script:
-    - kas build kas.yml:board-x86-64-efi.yml:opt-latest.yml:opt-lava-test.yml
+    - kas build kas.yml:board-x86-64-efi.yml:opt-lava-test.yml:${BUILD_OPTIONS}
     - scripts/deploy_for_testing.sh x86-64-efi
 
 lava-test:board-x86-64-efi:
diff --git a/kas.yml b/kas.yml
index 06b59ac..e3c6641 100644
--- a/kas.yml
+++ b/kas.yml
@@ -23,6 +23,10 @@ repos:
     refspec: a5d575a15285b7f66efbf3e2409a7f65d25ff15e
     layers:
       meta:
+    patches:
+      latest-kernel:
+        repo: xenomai
+        path: patches/0001-recipes-kernel-linux-build-kernel-Allow-kernel-build.patch
 
 bblayers_conf_header:
   standard: |
diff --git a/opt-linux-latest.yml b/opt-linux-latest.yml
new file mode 100644
index 0000000..25d9606
--- /dev/null
+++ b/opt-linux-latest.yml
@@ -0,0 +1,20 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2019
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 8
+
+# lava uses nfs to deploy the image. For this we need a tarball instead of
+# full image
+
+local_conf_header:
+  linux-xenomai-latest: |
+    PREFERRED_VERSION_linux-xenomai = "latest%"
diff --git a/opt-latest.yml b/opt-xenomai-next.yml
similarity index 100%
rename from opt-latest.yml
rename to opt-xenomai-next.yml
diff --git a/patches/0001-recipes-kernel-linux-build-kernel-Allow-kernel-build.patch b/patches/0001-recipes-kernel-linux-build-kernel-Allow-kernel-build.patch
new file mode 100644
index 0000000..c3ab777
--- /dev/null
+++ b/patches/0001-recipes-kernel-linux-build-kernel-Allow-kernel-build.patch
@@ -0,0 +1,173 @@
+From 3322d3f1a062b950510028ed50b2f807dc780d24 Mon Sep 17 00:00:00 2001
+From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+Date: Fri, 20 Sep 2019 13:44:56 +0200
+Subject: [PATCH] recipes-kernel/linux/build-kernel: Allow kernel build with
+ AUTOREV
+
+For testing it is sometimes necessary to build the HEAD of a kernel
+tree. If ${PV} is set to latest the check Packageversion equals
+KERNEL_VERSION is deactivated. To allow this build use the KV instead
+PV in the package generation.
+
+Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
+---
+ .../linux/files/build-kernel.sh               | 81 ++++++++++---------
+ 1 file changed, 41 insertions(+), 40 deletions(-)
+
+diff --git a/meta/recipes-kernel/linux/files/build-kernel.sh b/meta/recipes-kernel/linux/files/build-kernel.sh
+index 8b7b23b..24ddd6a 100644
+--- a/meta/recipes-kernel/linux/files/build-kernel.sh
++++ b/meta/recipes-kernel/linux/files/build-kernel.sh
+@@ -12,24 +12,24 @@ source /isar/common.sh
+ host_arch=$(dpkg --print-architecture)
+ 
+ if [ "$host_arch" != "$target_arch" ]; then
+-    case $target_arch in
+-    armhf)
+-        export ARCH=arm
+-        export CROSS_COMPILE="arm-linux-gnueabihf-"
+-        ;;
+-    arm64)
+-        export ARCH=arm64
+-        export CROSS_COMPILE="aarch64-linux-gnu-"
+-        ;;
+-    mipsel)
+-        export ARCH=mips
+-        export CROSS_COMPILE="mipsel-linux-gnu-"
+-        ;;
+-    *)
+-        echo "error: unsupported architecture ($target_arch)"
+-        exit 1
+-        ;;
+-    esac
++		case $target_arch in
++		armhf)
++				export ARCH=arm
++				export CROSS_COMPILE="arm-linux-gnueabihf-"
++				;;
++		arm64)
++				export ARCH=arm64
++				export CROSS_COMPILE="aarch64-linux-gnu-"
++				;;
++		mipsel)
++				export ARCH=mips
++				export CROSS_COMPILE="mipsel-linux-gnu-"
++				;;
++		*)
++				echo "error: unsupported architecture ($target_arch)"
++				exit 1
++				;;
++		esac
+ fi
+ 
+ REPACK_DIR="$1/../repack"
+@@ -43,12 +43,13 @@ else
+ fi
+ 
+ KV=$( make -s kernelrelease )
+-if [ "${KV}" != "${PV}" ]; then
+-	echo "ERROR: Recipe PV is \"${PV}\" but should be \"${KV}\"" 1>&2
+-	echo "ERROR: Probably due to CONFIG_LOCALVERSION" 1>&2
+-	exit 1
++if [ "${PV}" != "latest" ]; then
++	if [ "${KV}" != "${PV}" ]; then
++		echo "ERROR: Recipe PV is \"${PV}\" but should be \"${KV}\"" 1>&2
++		echo "ERROR: Probably due to CONFIG_LOCALVERSION" 1>&2
++		exit 1
++	fi
+ fi
+-
+ rm -f .version
+ KBUILD_DEBARCH=$target_arch make -j $(($(nproc) * 2)) deb-pkg
+ 
+@@ -65,13 +66,13 @@ sed -i "s/Architecture: .*/Architecture: any/" "${REPACK_DIR}/debian/control"
+ 
+ cd ..
+ 
+-dpkg-deb -R linux-image-${PV}_${PV}-1_*.deb "${REPACK_LINUX_IMAGE_DIR}"
+-dpkg-deb -R linux-headers-${PV}_${PV}-1_*.deb "${REPACK_LINUX_HEADERS_DIR}"
++dpkg-deb -R linux-image-${KV}_${KV}-1_*.deb "${REPACK_LINUX_IMAGE_DIR}"
++dpkg-deb -R linux-headers-${KV}_${KV}-1_*.deb "${REPACK_LINUX_HEADERS_DIR}"
+ 
+ dpkg-gencontrol -crepack/debian/control \
+ 	-lrepack/debian/changelog \
+ 	-frepack/debian/files \
+-	-plinux-image-${PV} \
++	-plinux-image-${KV} \
+ 	-P"${REPACK_LINUX_IMAGE_DIR}" \
+ 	-DPackage="linux-image-${KERNEL_NAME}" \
+ 	-DSection=kernel \
+@@ -80,32 +81,32 @@ dpkg-gencontrol -crepack/debian/control \
+ 	-DArchitecture=$target_arch
+ 
+ # Add Debian-like link installation to postinst
+-mkdir -p ${REPACK_LINUX_IMAGE_DIR}/lib/modules/${PV}
+-touch "${REPACK_LINUX_IMAGE_DIR}/lib/modules/${PV}/.fresh-install"
++mkdir -p ${REPACK_LINUX_IMAGE_DIR}/lib/modules/${KV}
++touch "${REPACK_LINUX_IMAGE_DIR}/lib/modules/${KV}/.fresh-install"
+ sed -i "${REPACK_LINUX_IMAGE_DIR}/DEBIAN/postinst" \
+     -e "/^set -e$/a\\
+ \\
+-if [ -f /lib/modules/${PV}/.fresh-install ]; then\\
++if [ -f /lib/modules/${KV}/.fresh-install ]; then\\
+ 	change=install\\
+ else\\
+ 	change=upgrade\\
+ fi\\
+-linux-update-symlinks \$change ${PV} /boot/vmlinuz-${PV}\\
+-rm -f /lib/modules/${PV}/.fresh-install"
++linux-update-symlinks \$change ${KV} /boot/vmlinuz-${KV}\\
++rm -f /lib/modules/${KV}/.fresh-install"
+ 
+ # Add Debian-like link removal to postrm
+ sed -i "${REPACK_LINUX_IMAGE_DIR}/DEBIAN/postrm" \
+     -e "/^set -e$/a\\
+ \\
+-rm -f /lib/modules/${PV}/.fresh-install\\
++rm -f /lib/modules/${KV}/.fresh-install\\
+ \\
+ if [ \"\$1\" != upgrade ] && command -v linux-update-symlinks >/dev/null; then\\
+-	linux-update-symlinks remove ${PV}  /boot/vmlinuz-${PV}\\
++	linux-update-symlinks remove ${KV}  /boot/vmlinuz-${KV}\\
+ fi"
+ 
+ # Make sure arm64 kernels are decompressed
+ if [ "$target_arch" = "arm64" ]; then
+-	vmlinuz="${REPACK_LINUX_IMAGE_DIR}/boot/vmlinuz-${PV}"
++	vmlinuz="${REPACK_LINUX_IMAGE_DIR}/boot/vmlinuz-${KV}"
+ 	mv "$vmlinuz" "$vmlinuz.gz"
+ 	gunzip "$vmlinuz.gz"
+ fi
+@@ -113,7 +114,7 @@ fi
+ dpkg-gencontrol -crepack/debian/control \
+ 	-lrepack/debian/changelog \
+ 	-frepack/debian/files \
+-	-plinux-headers-${PV} \
++	-plinux-headers-${KV} \
+ 	-P"${REPACK_LINUX_HEADERS_DIR}" \
+ 	-Vkernel:debarch="${KERNEL_NAME}" \
+ 	-DPackage="linux-headers-${KERNEL_NAME}" \
+@@ -122,15 +123,15 @@ dpkg-gencontrol -crepack/debian/control \
+ 	-DArchitecture=$target_arch
+ 
+ fakeroot dpkg-deb -b "${REPACK_LINUX_IMAGE_DIR}" \
+-	linux-image-${KERNEL_NAME}_${PV}-1_${KERNEL_NAME}.deb
+-rm -f linux-image-${PV}_${PV}-1_*.deb
++	linux-image-${KERNEL_NAME}_${KV}-1_${KERNEL_NAME}.deb
++rm -f linux-image-${KV}_${KV}-1_*.deb
+ fakeroot dpkg-deb -b "${REPACK_LINUX_HEADERS_DIR}" \
+-	linux-headers-${KERNEL_NAME}_${PV}-1_${KERNEL_NAME}.deb
+-rm -f linux-headers-${PV}_${PV}-1_*.deb
++	linux-headers-${KERNEL_NAME}_${KV}-1_${KERNEL_NAME}.deb
++rm -f linux-headers-${KV}_${KV}-1_*.deb
+ 
+ # linux-libc-dev causes dependency problems if we downgrade
+ # remove it after the build so the downgraded version does not get deployed
+ LINUX_LIBC_DEV_V=$( dpkg-query --show --showformat '${Version}' linux-libc-dev )
+ if dpkg --compare-versions $LINUX_LIBC_DEV_V gt $PV-1; then
+-	rm -f linux-libc-dev_${PV}*.deb
++	rm -f linux-libc-dev_${KV}*.deb
+ fi
+-- 
+2.20.1
+
diff --git a/recipes-kernel/linux/linux-xenomai_latest.bb b/recipes-kernel/linux/linux-xenomai_latest.bb
new file mode 100644
index 0000000..7ad4fed
--- /dev/null
+++ b/recipes-kernel/linux/linux-xenomai_latest.bb
@@ -0,0 +1,24 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2019
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require recipes-kernel/linux/linux-xenomai.inc
+
+SRC_URI_append_amd64 = " git://gitlab.denx.de/Xenomai/ipipe-x86.git;protocol=https;branch=ipipe-x86-4.19.y"
+SRCREV_amd64 = "${AUTOREV}"
+
+SRC_URI_append_arm64 = " git://gitlab.denx.de/Xenomai/ipipe-arm64.git;protocol=https;branch=ipipe/master"
+SRCREV_arm64 = "${AUTOREV}"
+
+
+SRC_URI_append_armhf = " git://gitlab.denx.de/Xenomai/ipipe-arm.git;protocol=https;branch=ipipe/master"
+SRCREV_armhf = "${AUTOREV}"
+S = "${WORKDIR}/git"
+
-- 
2.20.1


