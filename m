From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ci: Switch to bullseye and gcc-10
Message-ID: <8ed67e75-50e3-3264-fb91-3bbf6184554e@siemens.com>
Date: Sun, 18 Jul 2021 10:46:53 +0200
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
Cc: Steven Seeger <steven.seeger@flightsystems.net>

From: Jan Kiszka <jan.kiszka@siemens.com>

Debian 11 is almost ready. It comes with newer gcc-10. So better test
now to avoid surprises.

We just need to hold powerpc at Debian 10 as it does not build with
gcc-10. It's also unclear if the removal of SPE support in recent gcc
would affect us.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 7644861104..8be00c3cec 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -13,7 +13,7 @@ stages:
   - test
 
 default:
-  image: debian:buster
+  image: debian:bullseye
 
 variables:
   GIT_STRATEGY: clone
@@ -22,12 +22,13 @@ variables:
   CCACHE_MAXSIZE: "1G"
   IPIPE_MIRROR_URL: "https://source.denx.de/Xenomai"
   DOVETAIL_URL: "https://source.denx.de/Xenomai/linux-dovetail.git"
-  PACKAGES: "gcc-8 u-boot-tools git make bc bison libelf-dev autotools-dev \
+  GCC_VERSION: "10"
+  PACKAGES: "u-boot-tools git make bc bison libelf-dev autotools-dev \
              autoconf autogen libtool pkg-config ccache flex libssl-dev"
-  PACKAGES_arm: "gcc-8-arm-linux-gnueabihf libc6-dev-armhf-cross"
-  PACKAGES_arm64: "gcc-8-aarch64-linux-gnu libc6-dev-arm64-cross"
-  PACKAGES_powerpc: "gcc-8-powerpc-linux-gnu libc6-dev-powerpc-cross"
-  PACKAGES_x86: ""
+  PACKAGES_arm: "gcc-${GCC_VERSION} gcc-${GCC_VERSION}-arm-linux-gnueabihf libc6-dev-armhf-cross"
+  PACKAGES_arm64: "gcc-${GCC_VERSION} gcc-${GCC_VERSION}-aarch64-linux-gnu libc6-dev-arm64-cross"
+  PACKAGES_powerpc: "gcc-8 gcc-8-powerpc-linux-gnu libc6-dev-powerpc-cross"
+  PACKAGES_x86: "gcc-${GCC_VERSION}"
   XENOMAI_IMAGES_BRANCH: "master"
 
 .build:
@@ -36,7 +37,6 @@ variables:
     - apt update
     - ARCH_PACKAGES="PACKAGES_${ARCH}"
     - apt install -y ${PACKAGES} ${!ARCH_PACKAGES}
-    - update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800
     - REV=$(git ls-remote --tags --head --refs ${PIPELINE_KERNEL} | sed -e "s/.*[[:space:]]refs\/\(tags\|heads\)\///" | grep "${PIPELINE_REV}" | sort -r -n -t - -k 5 -k 6 | head -1)
     - test -n "${REV}" || REV="${PIPELINE_REV}"
     - git clone --depth 1 --branch ${REV} ${PIPELINE_KERNEL} ${KDIR}
@@ -44,24 +44,26 @@ variables:
       "arm64")
       export CROSS_COMPILE=aarch64-linux-gnu-;
       export CONFIGURE_OPTS="--host=aarch64-linux-gnu --with-cc=aarch64-linux-gnu-gcc";
-      update-alternatives --install /usr/bin/aarch64-linux-gnu-gcc aarch64-linux-gnu-gcc /usr/bin/aarch64-linux-gnu-gcc-8 800;
+      update-alternatives --install /usr/bin/aarch64-linux-gnu-gcc aarch64-linux-gnu-gcc /usr/bin/aarch64-linux-gnu-gcc-${GCC_VERSION} 800;
       ;;
       "arm")
       export CROSS_COMPILE=arm-linux-gnueabihf-;
       export CONFIGURE_OPTS="--host=arm-linux-gnueabihf --with-cc=arm-linux-gnueabihf-gcc";
-      update-alternatives --install /usr/bin/arm-linux-gnueabihf-gcc arm-linux-gnueabihf-gcc /usr/bin/arm-linux-gnueabihf-gcc-8 800;
+      update-alternatives --install /usr/bin/arm-linux-gnueabihf-gcc arm-linux-gnueabihf-gcc /usr/bin/arm-linux-gnueabihf-gcc-${GCC_VERSION} 800;
       ;;
       "powerpc")
+      export GCC_VERSION=8
       export CROSS_COMPILE=powerpc-linux-gnu-;
       export CONFIGURE_OPTS="--host=powerpc-linux-gnu --with-cc=powerpc-linux-gnu-gcc";
-      update-alternatives --install /usr/bin/powerpc-linux-gnu-gcc powerpc-linux-gnu-gcc /usr/bin/powerpc-linux-gnu-gcc-8 800;
+      update-alternatives --install /usr/bin/powerpc-linux-gnu-gcc powerpc-linux-gnu-gcc /usr/bin/powerpc-linux-gnu-gcc-${GCC_VERSION} 800;
       ;;
       "x86")
       export CROSS_COMPILE=;
       export CONFIGURE_OPTS="--enable-dlopen-libs --enable-lazy-setsched";
       ;;
       esac
-    - ln -s /usr/lib/ccache/${CROSS_COMPILE}gcc-8 /usr/lib/ccache/${CROSS_COMPILE}gcc
+    - update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-${GCC_VERSION} 800
+    - ln -s /usr/lib/ccache/${CROSS_COMPILE}gcc-${GCC_VERSION} /usr/lib/ccache/${CROSS_COMPILE}gcc
     - export PATH=/usr/lib/ccache:$PATH
     - ${CROSS_COMPILE}gcc --version
 
@@ -254,6 +256,7 @@ x86-4.19-cip-release:
 
 powerpc-4.19-release:
   extends: .build
+  image: debian:buster
   variables:
     ARCH: powerpc
     PIPELINE_REV: ipipe-core-4.19..*-ppc32-.*
-- 
2.26.2

