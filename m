From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [RFC][PATCH] ci: Pull kernels from git and enhance coverage
Message-ID: <8bcb891e-e8ac-6fc3-ccdc-93b87615d8f6@siemens.com>
Date: Fri, 5 Apr 2019 14:49:34 +0200
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
To: Xenomai <xenomai@xenomai.org>, Roman Stratiienko <roman.stratiienko@globallogic.com>, Philippe Gerum <rpm@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This switches to cloning the ipipe tree, rather than downloading
patches. It allows to test also unreleased ipipe revisions.

The test matrix is enhanced by
 - 4.19-arm
 - 4.14.78-arm64
 - 4.14.y-x86
 - 4.4.y-x86
 - 4.4.y-arm

The 4.1-arm build is dropped because that kernel is no longer supported
- and the build is broken.

Furthermore, the no longer supported i386 target is replaced with x86-64
for 4.4.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

https://travis-ci.com/xenomai-ci/xenomai/builds/107213816

We currently fail with the last 4.4-x86 release due to
https://gitlab.denx.de/Xenomai/ipipe/commit/3ecaa6e7e7489d87b2d320eead785a8ed58c44f1.
Will likely issue a new release soon and update the tag here before
finalizing.

 .travis.yml | 51 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 58cc51c4af..1e41a41475 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -9,9 +9,6 @@ addons:
       - libc6-dev-arm64-cross
       - gcc-arm-linux-gnueabihf
       - libc6-dev-armhf-cross
-      - patch
-      - quilt
-      - wget
 
 env:
   global:
@@ -20,13 +17,7 @@ env:
     - CCACHE_MAXSIZE=400M
 
 install:
-  - if [[ "${KERNEL_VERSION}" == *-rc* ]]; then
-      KERNEL_URL=https://git.kernel.org/torvalds/t/linux-${KERNEL_VERSION}.tar.gz;
-    else
-      KERNEL_URL=https://www.kernel.org/pub/linux/kernel/v${KERNEL_VERSION::1}.x/linux-${KERNEL_VERSION}.tar.xz;
-    fi
-  - wget -O kernel.tar.xz ${KERNEL_URL} && mkdir ${KDIR} && tar -C ${KDIR} --strip=1 -xf kernel.tar.xz
-  - wget -O /tmp/ipipe.patch ${IPIPE_URL}
+  - git clone --depth 1 --branch ${IPIPE_REV} ${IPIPE_KERNEL} ${KDIR}
 
 before_script:
   - case "${ARCH}" in
@@ -135,7 +126,7 @@ before_script:
   - popd
 
 script:
-  - scripts/prepare-kernel.sh --ipipe=/tmp/ipipe.patch --arch=${ARCH} --linux=${KDIR}
+  - scripts/prepare-kernel.sh --arch=${ARCH} --linux=${KDIR}
   - pushd ${KDIR}
   - make -j $(nproc) olddefconfig
   - make -j $(nproc) all
@@ -150,21 +141,41 @@ matrix:
   include:
     - env:
       - ARCH: arm
-        KERNEL_VERSION: 4.14.85
+        IPIPE_REV: ipipe-core-4.19.33-arm-2
+        IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-arm.git
         KERNEL_DEFCONFIG: multi_v7_defconfig
-        IPIPE_URL: https://xenomai.org/downloads/ipipe/v4.x/arm/ipipe-core-4.14.85-arm-6.patch
     - env:
       - ARCH: arm
-        KERNEL_VERSION: 4.1.18
+        IPIPE_REV: ipipe-core-4.14.85-arm-6
+        IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-arm.git
         KERNEL_DEFCONFIG: multi_v7_defconfig
-        IPIPE_URL: https://xenomai.org/downloads/ipipe/v4.x/arm/older/ipipe-core-4.1.18-arm-9.patch
+    - env:
+      - ARCH: arm
+        IPIPE_REV: ipipe-4.4.y
+        IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe.git
+        KERNEL_DEFCONFIG: multi_v7_defconfig
+    - env:
+      - ARCH: arm64
+        IPIPE_REV: v4.14.78-split
+        IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-arm64.git
+        KERNEL_DEFCONFIG: defconfig
     - env:
       - ARCH: x86
-        KERNEL_VERSION: 4.14.89
+        IPIPE_REV: ipipe-x86-4.14.y
+        IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-x86.git
         KERNEL_DEFCONFIG: x86_64_defconfig
-        IPIPE_URL: https://xenomai.org/downloads/ipipe/v4.x/x86/ipipe-core-4.14.89-x86-2.patch
     - env:
       - ARCH: x86
-        KERNEL_VERSION: 4.4.166
-        KERNEL_DEFCONFIG: i386_defconfig
-        IPIPE_URL: https://xenomai.org/downloads/ipipe/v4.x/x86/ipipe-core-4.4.166-x86-12.patch
+        IPIPE_REV: ipipe-core-4.14.89-x86-2
+        IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-x86.git
+        KERNEL_DEFCONFIG: x86_64_defconfig
+    - env:
+      - ARCH: x86
+        IPIPE_REV: ipipe-4.4.y
+        IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe.git
+        KERNEL_DEFCONFIG: x86_64_defconfig
+    - env:
+      - ARCH: x86
+        IPIPE_REV: ipipe-core-4.4.176-x86-13
+        IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe.git
+        KERNEL_DEFCONFIG: x86_64_defconfig
-- 
2.16.4

