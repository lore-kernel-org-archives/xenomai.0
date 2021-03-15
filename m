From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ci: Do not install unneeded crosstools
Message-ID: <c4d8c972-a5e4-4f93-1569-78d6c2cef95a@siemens.com>
Date: Mon, 15 Mar 2021 08:50:49 +0100
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

Make the package set arch-specific to save some bytes and seconds.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e15f71a1df..e04df30d1d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -20,40 +20,42 @@ variables:
   USE_CCACHE: "1"
   CCACHE_MAXSIZE: "400M"
   IPIPE_MIRROR_URL: "https://source.denx.de/Xenomai"
-  PACKAGES: "gcc-8 gcc-8-aarch64-linux-gnu libc6-dev-arm64-cross \
-             gcc-8-arm-linux-gnueabihf libc6-dev-armhf-cross \
-             gcc-8-powerpc-linux-gnu libc6-dev-powerpc-cross  \
-             u-boot-tools git make bc bison libelf-dev autotools-dev \
+  PACKAGES: "gcc-8 u-boot-tools git make bc bison libelf-dev autotools-dev \
              autoconf autogen libtool pkg-config ccache flex libssl-dev"
+  PACKAGES_arm: "gcc-8-arm-linux-gnueabihf libc6-dev-armhf-cross"
+  PACKAGES_arm64: "gcc-8-aarch64-linux-gnu libc6-dev-arm64-cross"
+  PACKAGES_powerpc: "gcc-8-powerpc-linux-gnu libc6-dev-powerpc-cross"
+  PACKAGES_x86: ""
 
 .build:
   stage: build
   before_script:
     - apt update
-    - apt install -y ${PACKAGES}
+    - ARCH_PACKAGES="PACKAGES_${ARCH}"
+    - apt install -y ${PACKAGES} ${!ARCH_PACKAGES}
     - update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800
-    - update-alternatives --install /usr/bin/aarch64-linux-gnu-gcc aarch64-linux-gnu-gcc /usr/bin/aarch64-linux-gnu-gcc-8 800
-    - update-alternatives --install /usr/bin/arm-linux-gnueabihf-gcc arm-linux-gnueabihf-gcc /usr/bin/arm-linux-gnueabihf-gcc-8 800
-    - update-alternatives --install /usr/bin/powerpc-linux-gnu-gcc powerpc-linux-gnu-gcc /usr/bin/powerpc-linux-gnu-gcc-8 800
     - REV=$(git ls-remote --tags --head --refs ${PIPELINE_KERNEL} | sed -e "s/.*[[:space:]]refs\/\(tags\|heads\)\///" | grep "${PIPELINE_REV}" | sort -r -n -t - -k 5 -k 6 | head -1)
     - test -n "${REV}" || REV="${PIPELINE_REV}"
     - git clone --depth 1 --branch ${REV} ${PIPELINE_KERNEL} ${KDIR}
     - case "${ARCH}" in
       "arm64")
-      export CROSS_COMPILE=aarch64-linux-gnu-
-      export CONFIGURE_OPTS="--host=aarch64-linux-gnu --with-cc=aarch64-linux-gnu-gcc"
+      export CROSS_COMPILE=aarch64-linux-gnu-;
+      export CONFIGURE_OPTS="--host=aarch64-linux-gnu --with-cc=aarch64-linux-gnu-gcc";
+      update-alternatives --install /usr/bin/aarch64-linux-gnu-gcc aarch64-linux-gnu-gcc /usr/bin/aarch64-linux-gnu-gcc-8 800;
       ;;
       "arm")
-      export CROSS_COMPILE=arm-linux-gnueabihf-
-      export CONFIGURE_OPTS="--host=arm-linux-gnueabihf --with-cc=arm-linux-gnueabihf-gcc"
+      export CROSS_COMPILE=arm-linux-gnueabihf-;
+      export CONFIGURE_OPTS="--host=arm-linux-gnueabihf --with-cc=arm-linux-gnueabihf-gcc";
+      update-alternatives --install /usr/bin/arm-linux-gnueabihf-gcc arm-linux-gnueabihf-gcc /usr/bin/arm-linux-gnueabihf-gcc-8 800;
       ;;
       "powerpc")
-      export CROSS_COMPILE=powerpc-linux-gnu-
-      export CONFIGURE_OPTS="--host=powerpc-linux-gnu --with-cc=powerpc-linux-gnu-gcc"
+      export CROSS_COMPILE=powerpc-linux-gnu-;
+      export CONFIGURE_OPTS="--host=powerpc-linux-gnu --with-cc=powerpc-linux-gnu-gcc";
+      update-alternatives --install /usr/bin/powerpc-linux-gnu-gcc powerpc-linux-gnu-gcc /usr/bin/powerpc-linux-gnu-gcc-8 800;
       ;;
       "x86")
-      export CROSS_COMPILE=
-      export CONFIGURE_OPTS="--enable-dlopen-libs --enable-lazy-setsched"
+      export CROSS_COMPILE=;
+      export CONFIGURE_OPTS="--enable-dlopen-libs --enable-lazy-setsched";
       ;;
       esac
     - ln -s /usr/lib/ccache/${CROSS_COMPILE}gcc-8 /usr/lib/ccache/${CROSS_COMPILE}gcc
-- 
2.26.2

