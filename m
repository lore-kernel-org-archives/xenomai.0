From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [xenomai-images 6/7] recipes-kernel/linux: control appyling of no
 debug config fragment
Date: Thu, 22 Jul 2021 23:18:10 -0400
Message-Id: <20210723031811.19290-7-hongzhan.chen@intel.com>
In-Reply-To: <20210723031811.19290-1-hongzhan.chen@intel.com>
References: <20210723031811.19290-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

For performance or latency testing and demonstration, debug switches
should be off but it is on by default.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
---
 recipes-kernel/linux/linux-xenomai.inc | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
index 185b60b..98eebf2 100644
--- a/recipes-kernel/linux/linux-xenomai.inc
+++ b/recipes-kernel/linux/linux-xenomai.inc
@@ -11,9 +11,17 @@
 
 require recipes-kernel/linux/linux-custom.inc
 
+def is_nodbg_support(d):
+    dbg_ver = d.getVar('DISTRO_NODBG') or ''
+    return dbg_ver.startswith('YES') or dbg_ver == 'YES'
+
 KERNEL_DEFCONFIG ?= "${DISTRO_ARCH}_defconfig"
+KERNEL_NODBG_FRAGMENTS ?= "${DISTRO_ARCH}_nodbg.cfg"
+KERNEL_NODBG_FRAGMENTS_append = "${@'' if is_nodbg_support(d) else ';apply=no'}"
 
-SRC_URI += "file://${KERNEL_DEFCONFIG}"
+SRC_URI += "file://${KERNEL_DEFCONFIG} \
+    file://${KERNEL_NODBG_FRAGMENTS} \
+"
 
 DEPENDS += "xenomai-kernel-source"
 KBUILD_DEPENDS += "xenomai-kernel-source"
-- 
2.17.1


