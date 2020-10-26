From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 11/11] ci: Add x86 5.4 kernel to CI
Date: Mon, 26 Oct 2020 12:04:57 +0100
Message-Id: <a3701ee1710101efeccdf2007474efde5c616cc1.1603710297.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1603710297.git.jan.kiszka@siemens.com>
References: <cover.1603710297.git.jan.kiszka@siemens.com>
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
Cc: Fino Meng <fino.meng@linux.intel.com>, Mingliang Hu <mingliang.hu@intel.com>

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index d76c9e25e6..87532a3376 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -205,6 +205,14 @@ arm64-4.14-release:
     IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-arm64.git
     KERNEL_DEFCONFIG: defconfig
 
+x86-5.4-head:
+  extends: .build
+  variables:
+    ARCH: x86
+    IPIPE_REV: ipipe-x86-5.4.y
+    IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-x86.git
+    KERNEL_DEFCONFIG: x86_64_defconfig
+
 x86-4.19-cip-head:
   extends: .build
   variables:
-- 
2.26.2


