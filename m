From: Greg Gallagher <greg@embeddedgreg.com>
Subject: [PATCH] Enable zynq gpio and xilinx gpio support for the Zynq MP
 platform.
Date: Sat, 30 May 2020 23:29:07 -0400
Message-Id: <20200531032907.790647-1-greg@embeddedgreg.com>
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
Cc: Joshua Karch <jkarch48@hotmail.com>

From: Joshua Karch <jkarch48@hotmail.com>

    	Signed-off-by: Joshua Karch <jkarch48@hotmail.com>
	Signed-off-by: Greg Gallagher <greg@embeddedgreg.com>
---
 kernel/drivers/gpio/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/gpio/Kconfig b/kernel/drivers/gpio/Kconfig
index dbc862754..44f41688c 100644
--- a/kernel/drivers/gpio/Kconfig
+++ b/kernel/drivers/gpio/Kconfig
@@ -34,7 +34,7 @@ config XENO_DRIVERS_GPIO_SUN8I_H3
 	SoC, as found on the NanoPI boards.
 
 config XENO_DRIVERS_GPIO_ZYNQ7000
-	depends on ARCH_ZYNQ
+	depends on ARCH_ZYNQ || ARCH_ZYNQMP
 	tristate "Support for Zynq7000 GPIOs"
 	help
 
@@ -42,7 +42,7 @@ config XENO_DRIVERS_GPIO_ZYNQ7000
 	Xilinx's Zynq7000 SoC.
 
 config XENO_DRIVERS_GPIO_XILINX
-	depends on ARCH_ZYNQ
+	depends on ARCH_ZYNQ || ARCH_ZYNQMP
 	tristate "Support for Xilinx GPIOs"
 	help
 
-- 
2.25.1


