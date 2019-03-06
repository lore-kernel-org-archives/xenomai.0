From: roman.stratiienko@globallogic.com
Subject: [PATCH v2 01/10] travis: add basic CI support
Date: Wed,  6 Mar 2019 19:53:22 +0200
Message-Id: <20190306175331.25444-1-roman.stratiienko@globallogic.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Roman Stratiienko <roman.stratiienko@globallogic.com>

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---
Since v1: v4.20 removed and added to last commit
 .travis.yml | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 .travis.yml

diff --git a/.travis.yml b/.travis.yml
new file mode 100644
index 000000000..24889ca5f
--- /dev/null
+++ b/.travis.yml
@@ -0,0 +1,68 @@
+language: c
+dist: xenial
+
+addons:
+  apt:
+    packages:
+      - gcc-aarch64-linux-gnu
+      - gcc-arm-linux-gnueabihf
+      - patch
+      - quilt
+      - wget
+
+env:
+  global:
+    - KDIR=/tmp/kernel
+
+install:
+  - if [[ "${KERNEL_VERSION}" == *-rc* ]]; then
+      KERNEL_URL=https://git.kernel.org/torvalds/t/linux-${KERNEL_VERSION}.tar.gz;
+    else
+      KERNEL_URL=https://www.kernel.org/pub/linux/kernel/v${KERNEL_VERSION::1}.x/linux-${KERNEL_VERSION}.tar.xz;
+    fi
+  - wget -O kernel.tar.xz ${KERNEL_URL} && mkdir ${KDIR} && tar -C ${KDIR} --strip=1 -xf kernel.tar.xz
+  - wget -O /tmp/ipipe.patch ${IPIPE_URL}
+
+before_script:
+  - case "${ARCH}" in
+      "arm64") export CROSS_COMPILE=aarch64-linux-gnu-
+          ;;
+      "arm"  ) export CROSS_COMPILE=arm-linux-gnueabihf-
+          ;;
+      "x86"  ) export CROSS_COMPILE=
+          ;;
+    esac
+  - pushd ${KDIR}
+  - make -j $(nproc) ${KERNEL_DEFCONFIG}
+  - ./scripts/config -e CONFIG_IPIPE
+  - ./scripts/config -e CONFIG_XENOMAI
+  - popd
+
+script:
+  - ./scripts/prepare-kernel.sh --ipipe=/tmp/ipipe.patch --arch=${ARCH} --linux=${KDIR}
+  - cd ${KDIR}
+  - make -j $(nproc) olddefconfig
+  - make -j $(nproc) all
+
+matrix:
+  include:
+    - env:
+      - ARCH: arm
+        KERNEL_VERSION: 4.14.85
+        KERNEL_DEFCONFIG: multi_v7_defconfig
+        IPIPE_URL: https://xenomai.org/downloads/ipipe/v4.x/arm/ipipe-core-4.14.85-arm-6.patch
+    - env:
+      - ARCH: arm
+        KERNEL_VERSION: 4.1.18
+        KERNEL_DEFCONFIG: multi_v7_defconfig
+        IPIPE_URL: https://xenomai.org/downloads/ipipe/v4.x/arm/older/ipipe-core-4.1.18-arm-9.patch
+    - env:
+      - ARCH: x86
+        KERNEL_VERSION: 4.14.89
+        KERNEL_DEFCONFIG: x86_64_defconfig
+        IPIPE_URL: https://xenomai.org/downloads/ipipe/v4.x/x86/ipipe-core-4.14.89-x86-2.patch
+    - env:
+      - ARCH: x86
+        KERNEL_VERSION: 4.4.166
+        KERNEL_DEFCONFIG: i386_defconfig
+        IPIPE_URL: https://xenomai.org/downloads/ipipe/v4.x/x86/ipipe-core-4.4.166-x86-12.patch
-- 
2.17.1


