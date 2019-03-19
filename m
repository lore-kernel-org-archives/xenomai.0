From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ci: Add userspace build
Message-ID: <49f6d5d2-3cac-7439-ba1f-290b333abbfe@siemens.com>
Date: Tue, 19 Mar 2019 15:46:28 +0100
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
Cc: Roman Stratiienko <roman.stratiienko@globallogic.com>

This also builds the Xenomai userspace as part of CI.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .travis.yml | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 8d3eba2c3b..d7638afb7b 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -5,7 +5,9 @@ addons:
   apt:
     packages:
       - gcc-aarch64-linux-gnu
+      - libc6-dev-arm64-cross
       - gcc-arm-linux-gnueabihf
+      - libc6-dev-armhf-cross
       - patch
       - quilt
       - wget
@@ -25,11 +27,17 @@ install:
 
 before_script:
   - case "${ARCH}" in
-      "arm64") export CROSS_COMPILE=aarch64-linux-gnu-
+      "arm64")
+          export CROSS_COMPILE=aarch64-linux-gnu-
+          export CONFIGURE_OPTS="--host=aarch64-linux-gnu --with-cc=aarch64-linux-gnu-gcc"
           ;;
-      "arm"  ) export CROSS_COMPILE=arm-linux-gnueabihf-
+      "arm"  )
+          export CROSS_COMPILE=arm-linux-gnueabihf-
+          export CONFIGURE_OPTS="--host=arm-linux-gnueabihf --with-cc=arm-linux-gnueabihf-gcc"
           ;;
-      "x86"  ) export CROSS_COMPILE=
+      "x86"  )
+          export CROSS_COMPILE=
+          export CONFIGURE_OPTS="--enable-dlopen-libs --enable-lazy-setsched"
           ;;
     esac
   - pushd ${KDIR}
@@ -70,10 +78,15 @@ before_script:
   - popd
 
 script:
-  - ./scripts/prepare-kernel.sh --ipipe=/tmp/ipipe.patch --arch=${ARCH} --linux=${KDIR}
-  - cd ${KDIR}
+  - scripts/prepare-kernel.sh --ipipe=/tmp/ipipe.patch --arch=${ARCH} --linux=${KDIR}
+  - pushd ${KDIR}
   - make -j $(nproc) olddefconfig
   - make -j $(nproc) all
+  - popd
+
+  - scripts/bootstrap
+  - ./configure --enable-smp ${CONFIGURE_OPTS}
+  - make -j $(nproc)
 
 matrix:
   include:
-- 
2.16.4

