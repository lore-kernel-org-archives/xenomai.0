From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ci: Add a powerpc target
Message-ID: <274e2975-b278-59bd-e31d-4fd45962878b@siemens.com>
Date: Mon, 27 May 2019 09:22:26 +0200
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

This adds a sufficiently representative target for the powerpc
architecture to CI.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

To finally make this official. Can still be tuned later when the need
arises.

 .travis.yml | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index c259a0b2b6..3dd38b3b6e 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -9,6 +9,9 @@ addons:
       - libc6-dev-arm64-cross
       - gcc-arm-linux-gnueabihf
       - libc6-dev-armhf-cross
+      - gcc-powerpc-linux-gnu
+      - libc6-dev-powerpc-cross
+      - u-boot-tools
 
 env:
   global:
@@ -25,11 +28,15 @@ before_script:
           export CROSS_COMPILE=aarch64-linux-gnu-
           export CONFIGURE_OPTS="--host=aarch64-linux-gnu --with-cc=aarch64-linux-gnu-gcc"
           ;;
-      "arm"  )
+      "arm")
           export CROSS_COMPILE=arm-linux-gnueabihf-
           export CONFIGURE_OPTS="--host=arm-linux-gnueabihf --with-cc=arm-linux-gnueabihf-gcc"
           ;;
-      "x86"  )
+      "powerpc")
+          export CROSS_COMPILE=powerpc-linux-gnu-
+          export CONFIGURE_OPTS="--host=powerpc-linux-gnu --with-cc=powerpc-linux-gnu-gcc"
+          ;;
+      "x86")
           export CROSS_COMPILE=
           export CONFIGURE_OPTS="--enable-dlopen-libs --enable-lazy-setsched"
           ;;
@@ -37,6 +44,7 @@ before_script:
   - mkdir ~/ccache
   - ln -s /usr/bin/ccache ~/ccache/aarch64-linux-gnu-gcc
   - ln -s /usr/bin/ccache ~/ccache/arm-linux-gnueabihf-gcc
+  - ln -s /usr/bin/ccache ~/ccache/powerpc-linux-gnu-gcc
   - export PATH=~/ccache:$PATH
   - pushd ${KDIR}
   - make -j $(nproc) ${KERNEL_DEFCONFIG}
@@ -185,3 +193,8 @@ matrix:
         IPIPE_REV: ipipe-core-4.4.176-x86-14
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe.git
         KERNEL_DEFCONFIG: x86_64_defconfig
+    - env:
+      - ARCH: powerpc
+        IPIPE_REV: ipipe-core-4.14.36-ppc32-1.1
+        IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-ppc32.git
+        KERNEL_DEFCONFIG: mpc5200_defconfig
-- 
2.16.4

