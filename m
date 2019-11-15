From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ci: Always build the latest release
Message-ID: <067b7837-6e61-cb34-95a3-fedcec9327d3@siemens.com>
Date: Fri, 15 Nov 2019 19:38:03 +0100
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

This should reduce the effort for updating the CI control file on new
releases. It allows to specific a tag pattern that grep can match on.
The highest one is taken.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .travis.yml | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 11f63c6731..7f3cba96e9 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -25,7 +25,10 @@ install:
   - sudo update-alternatives --install /usr/bin/aarch64-linux-gnu-gcc aarch64-linux-gnu-gcc /usr/bin/aarch64-linux-gnu-gcc-8 800
   - sudo update-alternatives --install /usr/bin/arm-linux-gnueabihf-gcc arm-linux-gnueabihf-gcc /usr/bin/arm-linux-gnueabihf-gcc-8 800
   - sudo update-alternatives --install /usr/bin/powerpc-linux-gnu-gcc powerpc-linux-gnu-gcc /usr/bin/powerpc-linux-gnu-gcc-8 800
-  - git clone --depth 1 --branch ${IPIPE_REV} ${IPIPE_KERNEL} ${KDIR}
+  - REV=$(git ls-remote --tags ${IPIPE_KERNEL} | sed "s|.*[[:space:]]refs/tags/||" | grep "${IPIPE_REV}" | sort -r -n -t - -k 5 -k 6 | head -1)
+  - test -n "${REV}" || REV="${IPIPE_REV}"
+  - echo "Cloning branch/tag ${REV}"
+  - git clone --depth 1 --branch ${REV} ${IPIPE_KERNEL} ${KDIR}
 
 before_script:
   - case "${ARCH}" in
@@ -162,13 +165,13 @@ matrix:
     - name: "ARM 4.19 release"
       env:
       - ARCH: arm
-        IPIPE_REV: ipipe-core-4.19.55-arm-5
+        IPIPE_REV: ipipe-core-4.19..*-arm-.*
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-arm.git
         KERNEL_DEFCONFIG: multi_v7_defconfig
     - name: "ARM 4.14 release"
       env:
       - ARCH: arm
-        IPIPE_REV: ipipe-core-4.14.110-arm-7
+        IPIPE_REV: ipipe-core-4.14..*-arm-.*
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-arm.git
         KERNEL_DEFCONFIG: multi_v7_defconfig
     - name: "ARM 4.4-CIP head"
@@ -180,13 +183,13 @@ matrix:
     - name: "ARM64 4.19 release"
       env:
       - ARCH: arm64
-        IPIPE_REV: ipipe-core-4.19.55-arm64-4
+        IPIPE_REV: ipipe-core-4.19..*-arm64-.*
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-arm64.git
         KERNEL_DEFCONFIG: defconfig
     - name: "ARM64 4.14 release"
       env:
       - ARCH: arm64
-        IPIPE_REV: ipipe-core-4.14.78-arm64-2
+        IPIPE_REV: ipipe-core-4.14..*-arm64-.*
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-arm64.git
         KERNEL_DEFCONFIG: defconfig
     - name: "x86 4.19 head"
@@ -198,13 +201,13 @@ matrix:
     - name: "x86 4.19 release"
       env:
       - ARCH: x86
-        IPIPE_REV: ipipe-core-4.19.75-x86-7
+        IPIPE_REV: ipipe-core-4.19..*-x86-.*
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-x86.git
         KERNEL_DEFCONFIG: x86_64_defconfig
     - name: "x86 4.14 release"
       env:
       - ARCH: x86
-        IPIPE_REV: ipipe-core-4.14.128-x86-5
+        IPIPE_REV: ipipe-core-4.14..*-x86-.*
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-x86.git
         KERNEL_DEFCONFIG: x86_64_defconfig
     - name: "x86 4.4-CIP head"
@@ -216,12 +219,12 @@ matrix:
     - name: "x86 4.4-CIP release"
       env:
       - ARCH: x86
-        IPIPE_REV: ipipe-core-4.4.192-cip37-x86-18
+        IPIPE_REV: ipipe-core-4.4..*-cip.*-x86-.*
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe.git
         KERNEL_DEFCONFIG: x86_64_defconfig
     - name: "PowerPC 4.19 release"
       env:
       - ARCH: powerpc
-        IPIPE_REV: ipipe-core-4.19.55-ppc32-1
+        IPIPE_REV: ipipe-core-4.19..*-ppc32-.*
         IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-ppc32.git
         KERNEL_DEFCONFIG: mpc5200_defconfig
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

