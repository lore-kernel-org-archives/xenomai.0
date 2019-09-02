From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] ci: Update build environment to Ubuntu 18.04
References: <f2377f95-78fc-4c83-0eb0-204babeb51e6@siemens.com>
Message-ID: <a46dc95b-4010-7837-e8dc-e36cf6aa2ad6@siemens.com>
Date: Mon, 2 Sep 2019 10:11:24 +0200
MIME-Version: 1.0
In-Reply-To: <f2377f95-78fc-4c83-0eb0-204babeb51e6@siemens.com>
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

This allows to switch to gcc 8 which may report issues earlier.

Powerpc does not build with gcc 8 and even also 7, so go with 6.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - switch back to gcc 6
 - switch to gcc 8 for the rest

Steven, any chance we get ppc to a newer gcc? Are the issues

https://travis-ci.com/xenomai-ci/xenomai/jobs/229976797#L786
https://travis-ci.com/xenomai-ci/xenomai/jobs/229922504#L3071

fixed in newer 4.14 releases?

 .travis.yml | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 671c551f72..15efb7ccb1 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,15 +1,16 @@
 language: c
-dist: xenial
+dist: bionic
 cache: ccache
  addons:
   apt:
     packages:
-      - gcc-aarch64-linux-gnu
+      - gcc-8
+      - gcc-8-aarch64-linux-gnu
       - libc6-dev-arm64-cross
-      - gcc-arm-linux-gnueabihf
+      - gcc-8-arm-linux-gnueabihf
       - libc6-dev-armhf-cross
-      - gcc-powerpc-linux-gnu
+      - gcc-6-powerpc-linux-gnu
       - libc6-dev-powerpc-cross
       - u-boot-tools
 @@ -20,6 +21,10 @@ env:
     - CCACHE_MAXSIZE=400M
  install:
+  - sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800
+  - sudo update-alternatives --install /usr/bin/aarch64-linux-gnu-gcc aarch64-linux-gnu-gcc /usr/bin/aarch64-linux-gnu-gcc-8 800
+  - sudo update-alternatives --install /usr/bin/arm-linux-gnueabihf-gcc arm-linux-gnueabihf-gcc /usr/bin/arm-linux-gnueabihf-gcc-8 800
+  - sudo update-alternatives --install /usr/bin/powerpc-linux-gnu-gcc powerpc-linux-gnu-gcc /usr/bin/powerpc-linux-gnu-gcc-6 800
   - git clone --depth 1 --branch ${IPIPE_REV} ${IPIPE_KERNEL} ${KDIR}
  before_script:
@@ -46,6 +51,8 @@ before_script:
   - ln -s /usr/bin/ccache ~/ccache/arm-linux-gnueabihf-gcc
   - ln -s /usr/bin/ccache ~/ccache/powerpc-linux-gnu-gcc
   - export PATH=~/ccache:$PATH
+  - ${CROSS_COMPILE}gcc --version
+
   - pushd ${KDIR}
   - make -j $(nproc) ${KERNEL_DEFCONFIG}
 -- 2.16.4

