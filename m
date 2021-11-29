From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] linux-xenomai: Only add own defconfigs to
 SRC_URI
Message-ID: <4e058da6-6278-e573-cca3-f637e4d8bd55@siemens.com>
Date: Mon, 29 Nov 2021 21:12:53 +0100
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

This allows downstream layers to set KERNEL_DEFCONFIG to own files
without triggering warnings like

.../recipes-kernel/linux/linux-xenomai_5.4.bb: Unable to get checksum
for linux-xenomai SRC_URI entry custom_defconfig: file could not be found

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai.inc | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
index 1852bf6..c12d39a 100644
--- a/recipes-kernel/linux/linux-xenomai.inc
+++ b/recipes-kernel/linux/linux-xenomai.inc
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2018
+# Copyright (c) Siemens AG, 2018-2021
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -11,10 +11,11 @@
 
 require recipes-kernel/linux/linux-custom.inc
 
-KERNEL_DEFCONFIG ?= "${DISTRO_ARCH}_defconfig"
+XENOMAI_DEFCONFIG = "${DISTRO_ARCH}_defconfig"
+KERNEL_DEFCONFIG ?= "${XENOMAI_DEFCONFIG}"
 XENOMAI_DEBUG ?= "0"
 
-SRC_URI += "file://${KERNEL_DEFCONFIG}"
+SRC_URI += "${@'file://${KERNEL_DEFCONFIG}' if d.getVar('KERNEL_DEFCONFIG') == d.getVar('XENOMAI_DEFCONFIG') else ''}"
 SRC_URI += "${@'file://common_nodbg.cfg' if d.getVar('XENOMAI_DEBUG') == '0' else ''}"
 
 DEPENDS += "xenomai-kernel-source"
-- 
2.31.1

