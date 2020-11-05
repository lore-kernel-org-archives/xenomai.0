From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] linux: arm: Enable Xenomai GPIO and SPI
 driver for BBB
Message-ID: <f049bc90-fc68-3fff-1d1f-b223fc6871a4@siemens.com>
Date: Thu, 5 Nov 2020 12:21:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>
Cc: =?UTF-8?Q?Deniz_U=c4=9fur?= <deniz343@gmail.com>

From: Jan Kiszka <jan.kiszka@siemens.com>

The GPIO driver still needs xenomai-next, though.

Suggested-by: Deniz Uğur <deniz343@gmail.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
  recipes-kernel/linux/files/armhf_defconfig | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/recipes-kernel/linux/files/armhf_defconfig b/recipes-kernel/linux/files/armhf_defconfig
index 99fb0a8..567b61b 100644
--- a/recipes-kernel/linux/files/armhf_defconfig
+++ b/recipes-kernel/linux/files/armhf_defconfig
@@ -541,6 +541,7 @@ CONFIG_XENO_DRIVERS_GPIO_MXC=m
  CONFIG_XENO_DRIVERS_GPIO_SUN8I_H3=m
  CONFIG_XENO_DRIVERS_GPIO_ZYNQ7000=m
  CONFIG_XENO_DRIVERS_GPIO_XILINX=m
+CONFIG_XENO_DRIVERS_GPIO_OMAP=m
  # CONFIG_XENO_DRIVERS_GPIO_DEBUG is not set
   #
@@ -554,6 +555,7 @@ CONFIG_XENO_DRIVERS_GPIOPWM=m
  CONFIG_XENO_DRIVERS_SPI=m
  CONFIG_XENO_DRIVERS_SPI_BCM2835=m
  CONFIG_XENO_DRIVERS_SPI_SUN6I=m
+CONFIG_XENO_DRIVERS_SPI_OMAP2_MCSPI_RT=m
  # CONFIG_XENO_DRIVERS_SPI_DEBUG is not set
   #
-- 
2.26.2


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

