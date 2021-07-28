From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [xenomai-image 1/2] recipes-kernel/linux: control appyling of no
 debug config fragment
Date: Wed, 28 Jul 2021 04:21:00 -0400
Message-Id: <20210728082101.5561-2-hongzhan.chen@intel.com>
In-Reply-To: <20210728082101.5561-1-hongzhan.chen@intel.com>
References: <20210728082101.5561-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

By default, nodbg config fragment would be applied.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
---
 recipes-kernel/linux/linux-xenomai.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
index 185b60b..1852bf6 100644
--- a/recipes-kernel/linux/linux-xenomai.inc
+++ b/recipes-kernel/linux/linux-xenomai.inc
@@ -12,8 +12,10 @@
 require recipes-kernel/linux/linux-custom.inc
 
 KERNEL_DEFCONFIG ?= "${DISTRO_ARCH}_defconfig"
+XENOMAI_DEBUG ?= "0"
 
 SRC_URI += "file://${KERNEL_DEFCONFIG}"
+SRC_URI += "${@'file://common_nodbg.cfg' if d.getVar('XENOMAI_DEBUG') == '0' else ''}"
 
 DEPENDS += "xenomai-kernel-source"
 KBUILD_DEPENDS += "xenomai-kernel-source"
-- 
2.17.1


