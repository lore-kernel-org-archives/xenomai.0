From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] linux-xenomai: Add search path to pick up
 common_nodebug.cfg
Message-ID: <850bde1e-fd75-a31d-d28f-65cfab8eb5a7@siemens.com>
Date: Tue, 30 Nov 2021 07:52:48 +0100
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

Allows to use linux-xenomai.inc in downstream layers.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
index c12d39a..ccc5353 100644
--- a/recipes-kernel/linux/linux-xenomai.inc
+++ b/recipes-kernel/linux/linux-xenomai.inc
@@ -11,6 +11,8 @@
 
 require recipes-kernel/linux/linux-custom.inc
 
+FILESPATH =. "${LAYERDIR_xenomai}/recipes-kernel/linux/files:"
+
 XENOMAI_DEFCONFIG = "${DISTRO_ARCH}_defconfig"
 KERNEL_DEFCONFIG ?= "${XENOMAI_DEFCONFIG}"
 XENOMAI_DEBUG ?= "0"
-- 
2.31.1

