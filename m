From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 08/10] recipes-kernel/linux: add exception
 handling
Date: Mon, 10 Feb 2020 19:17:47 +0100
Message-Id: <95577874f89c7063bad877eaec2907f06bd34e8e.1581358669.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1581358669.git.jan.kiszka@siemens.com>
References: <cover.1581358669.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1581358669.git.jan.kiszka@siemens.com>
References: <cover.1581358669.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

If SRCREV is not available for given DISTRO_ARCH and kernel version
get_srcrev raise a FetchError exception. Avoid a build error be
catching the exception.

[Jan: style fixing]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai.inc | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
index baa353b..ad3629b 100644
--- a/recipes-kernel/linux/linux-xenomai.inc
+++ b/recipes-kernel/linux/linux-xenomai.inc
@@ -18,7 +18,13 @@ SRC_URI += "file://${KERNEL_DEFCONFIG}"
 DEPENDS += "xenomai-kernel-source"
 KBUILD_DEPENDS += "xenomai-kernel-source"
 
-LINUX_COMMIT="${@bb.fetch2.get_srcrev(d).strip('AUTOINC+')}"
+def get_commit(d):
+    try:
+        return bb.fetch2.get_srcrev(d).strip('AUTOINC+')
+    except bb.fetch2.FetchError:
+        return ""
+
+LINUX_COMMIT ?= "${@get_commit(d)}"
 
 dpkg_runbuild_prepend() {
 	case ${DISTRO_ARCH} in
-- 
2.16.4


