From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ci: Add 32-bit x86 compat userland build
Message-ID: <1120e064-46df-b28f-68c5-636bf5ad13b6@siemens.com>
Date: Mon, 16 Aug 2021 11:10:39 +0200
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

This should help to catch breakages of the compat case.

We only need to build userland as the kernel is already covered by the
x86 job.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 05b226b474..68785f657c 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -27,6 +27,7 @@ variables:
              autoconf autogen libtool pkg-config ccache flex libssl-dev"
   PACKAGES_arm: "gcc-${GCC_VERSION} gcc-${GCC_VERSION}-arm-linux-gnueabihf libc6-dev-armhf-cross"
   PACKAGES_arm64: "gcc-${GCC_VERSION} gcc-${GCC_VERSION}-aarch64-linux-gnu libc6-dev-arm64-cross"
+  PACKAGES_i386: "gcc-${GCC_VERSION} gcc-${GCC_VERSION}-i686-linux-gnu libc6-dev-i386-cross"
   PACKAGES_powerpc: "gcc-8 gcc-8-powerpc-linux-gnu libc6-dev-powerpc-cross"
   PACKAGES_x86: "gcc-${GCC_VERSION}"
   XENOMAI_IMAGES_BRANCH: "master"
@@ -39,7 +40,7 @@ variables:
     - apt install -y ${PACKAGES} ${!ARCH_PACKAGES}
     - REV=$(git ls-remote --tags --head --refs ${PIPELINE_KERNEL} | sed -e "s/.*[[:space:]]refs\/\(tags\|heads\)\///" | grep "${PIPELINE_REV}" | sort -r -n -t - -k 5 -k 6 | head -1)
     - test -n "${REV}" || REV="${PIPELINE_REV}"
-    - git clone --depth 1 --branch ${REV} ${PIPELINE_KERNEL} ${KDIR}
+    - test -n "${PIPELINE_KERNEL}" && git clone --depth 1 --branch ${REV} ${PIPELINE_KERNEL} ${KDIR}
     - case "${ARCH}" in
       "arm64")
       export CROSS_COMPILE=aarch64-linux-gnu-;
@@ -51,6 +52,11 @@ variables:
       export CONFIGURE_OPTS="--host=arm-linux-gnueabihf --with-cc=arm-linux-gnueabihf-gcc";
       update-alternatives --install /usr/bin/arm-linux-gnueabihf-gcc arm-linux-gnueabihf-gcc /usr/bin/arm-linux-gnueabihf-gcc-${GCC_VERSION} 800;
       ;;
+      "i386")
+      export CROSS_COMPILE=i686-linux-gnu-;
+      export CONFIGURE_OPTS="--host=i686-linux-gnu --with-cc=i686-linux-gnu-gcc";
+      update-alternatives --install /usr/bin/i686-linux-gnu-gcc i686-linux-gnu-gcc /usr/bin/i686-linux-gnu-gcc-${GCC_VERSION} 800;
+      ;;
       "powerpc")
       export GCC_VERSION=8
       export CROSS_COMPILE=powerpc-linux-gnu-;
@@ -255,6 +261,17 @@ x86-4.19-cip-release:
     PIPELINE_KERNEL: ${IPIPE_URL}/ipipe-x86.git
     KERNEL_DEFCONFIG: x86_64_defconfig
 
+i386-userland:
+  extends: .build
+  variables:
+    ARCH: i386
+  script:
+    - export CCACHE_DIR=$(pwd)/.ccache
+    - scripts/bootstrap
+    - ./configure --enable-smp ${CONFIGURE_OPTS}
+    - make -j $(nproc)
+    - ccache -s
+
 powerpc-4.19-release:
   extends: .build
   image: debian:buster
-- 
2.31.1

