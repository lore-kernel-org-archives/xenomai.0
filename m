From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 17/17] ci: Add arm,
 arm64 and x86 dovetail targets for kernel 5.10
Date: Fri, 11 Jun 2021 20:05:43 +0200
Message-Id: <e9217fe1e18aeedde193ea5ad1030203ca335189.1623434743.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1623434743.git.jan.kiszka@siemens.com>
References: <cover.1623434743.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index f6d2ee884..764486110 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -21,6 +21,7 @@ variables:
   USE_CCACHE: "1"
   CCACHE_MAXSIZE: "1G"
   IPIPE_MIRROR_URL: "https://source.denx.de/Xenomai"
+  DOVETAIL_URL: "https://source.denx.de/Xenomai/linux-dovetail.git"
   PACKAGES: "gcc-8 u-boot-tools git make bc bison libelf-dev autotools-dev \
              autoconf autogen libtool pkg-config ccache flex libssl-dev"
   PACKAGES_arm: "gcc-8-arm-linux-gnueabihf libc6-dev-armhf-cross"
@@ -72,6 +73,7 @@ variables:
     - ./scripts/config -d DEBUG_INFO
     # I-pipe and Xenomai settings
     - ./scripts/config -e IPIPE
+    - ./scripts/config -e DOVETAIL
     - ./scripts/config -e XENOMAI
     - ./scripts/config -e XENO_OPT_SCHED_CLASSES
     - ./scripts/config -e XENO_OPT_SCHED_WEAK
@@ -170,6 +172,14 @@ variables:
     paths:
       - .ccache
 
+arm-5.10-head:
+  extends: .build
+  variables:
+    ARCH: arm
+    PIPELINE_REV: v5.10.y-dovetail-rebase
+    PIPELINE_KERNEL: ${DOVETAIL_URL}
+    KERNEL_DEFCONFIG: multi_v7_defconfig
+
 arm-5.4-release:
   extends: .build
   variables:
@@ -186,6 +196,14 @@ arm-4.19-release:
     PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-arm.git
     KERNEL_DEFCONFIG: multi_v7_defconfig
 
+arm64-5.10-head:
+  extends: .build
+  variables:
+    ARCH: arm64
+    PIPELINE_REV: v5.10.y-dovetail-rebase
+    PIPELINE_KERNEL: ${DOVETAIL_URL}
+    KERNEL_DEFCONFIG: defconfig
+
 arm64-5.4-release:
   extends: .build
   variables:
@@ -202,6 +220,14 @@ arm64-4.19-cip-release:
     PIPELINE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-arm64.git
     KERNEL_DEFCONFIG: defconfig
 
+x86-5.10-head:
+  extends: .build
+  variables:
+    ARCH: x86
+    PIPELINE_REV: v5.10.y-dovetail-rebase
+    PIPELINE_KERNEL: ${DOVETAIL_URL}
+    KERNEL_DEFCONFIG: x86_64_defconfig
+
 x86-5.4-head:
   extends: .build
   variables:
-- 
2.26.2


