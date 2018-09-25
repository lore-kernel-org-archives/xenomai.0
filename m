From: Philippe Gerum <rpm@xenomai.org>
Date: Tue, 25 Sep 2018 12:27:13 +0200
Message-Id: <20180925102716.4492-9-rpm@xenomai.org>
In-Reply-To: <20180925102716.4492-1-rpm@xenomai.org>
References: <20180925102716.4492-1-rpm@xenomai.org>
Subject: [Xenomai] [PATCH 08/11] arm64: dts: bcm2837: provide for BT-less
 variant, re-enabling uart0 as serial
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Raspberry 3 has two UARTs: uart0 is a full-fledged pl011 used for BT
by default, uart1 is a poor-man's low throughput serial device dubbed
as the "mini-uart". Unfortunately, uart1 is a massive pain, whose
clock rate is based on the CPU clock rate: this makes it quite
unstable as a serial console when a CPU frequency governor is enabled.

When BT is useless, we'd rather switch uart0 from BT to the serial
pins, disabling uart1 in the same move, so that we recover a decent
console device (*) with a stable clocking.

bcm2837-rpi-3-b-nobt.dtb is a fixed up blob doing exactly that.

(*) cmdline should mention console=ttyAMA0,<speed>
---
 arch/arm64/boot/dts/broadcom/Makefile                 |  2 +-
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b-nobt.dts | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b-nobt.dts

diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index 3df2db7f8878..b9915ee2a031 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_ARCH_BCM2835) += bcm2837-rpi-3-b.dtb
+dtb-$(CONFIG_ARCH_BCM2835) += bcm2837-rpi-3-b.dtb bcm2837-rpi-3-b-nobt.dtb
 
 dts-dirs	+= northstar2
 dts-dirs	+= stingray
diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b-nobt.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b-nobt.dts
new file mode 100644
index 000000000000..43f9d0f665cb
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b-nobt.dts
@@ -0,0 +1,12 @@
+/dts-v1/;
+#include "bcm2837-rpi-3-b.dts"
+
+&uart0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_gpio32>;
+};
+
+&uart1 {
+	status = "disabled";
+};
-- 
2.14.4


