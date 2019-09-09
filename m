From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ci: Update to 4.19.55-ppc32-1
Message-ID: <1083ef00-2764-98cf-70db-d93926ce7d5f@siemens.com>
Date: Mon, 9 Sep 2019 20:42:11 +0200
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

This allows to lift also ppc to gcc 8.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .travis.yml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 15efb7ccb1..c07939e9ef 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -10,7 +10,7 @@ addons:
       - libc6-dev-arm64-cross
       - gcc-8-arm-linux-gnueabihf
       - libc6-dev-armhf-cross
-      - gcc-6-powerpc-linux-gnu
+      - gcc-8-powerpc-linux-gnu
       - libc6-dev-powerpc-cross
       - u-boot-tools
 
@@ -24,7 +24,7 @@ install:
   - sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800
   - sudo update-alternatives --install /usr/bin/aarch64-linux-gnu-gcc aarch64-linux-gnu-gcc /usr/bin/aarch64-linux-gnu-gcc-8 800
   - sudo update-alternatives --install /usr/bin/arm-linux-gnueabihf-gcc arm-linux-gnueabihf-gcc /usr/bin/arm-linux-gnueabihf-gcc-8 800
-  - sudo update-alternatives --install /usr/bin/powerpc-linux-gnu-gcc powerpc-linux-gnu-gcc /usr/bin/powerpc-linux-gnu-gcc-6 800
+  - sudo update-alternatives --install /usr/bin/powerpc-linux-gnu-gcc powerpc-linux-gnu-gcc /usr/bin/powerpc-linux-gnu-gcc-8 800
   - git clone --depth 1 --branch ${IPIPE_REV} ${IPIPE_KERNEL} ${KDIR}
 
 before_script:
@@ -211,6 +211,6 @@ matrix:
         KERNEL_DEFCONFIG: x86_64_defconfig
     - env:
       - ARCH: powerpc
-        IPIPE_REV: ipipe-core-4.14.36-ppc32-1.1
+        IPIPE_REV: ipipe-core-4.19.55-ppc32-1
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-ppc32.git
         KERNEL_DEFCONFIG: mpc5200_defconfig
-- 

2.16.4

