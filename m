From: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>
Subject: [PATCH 5/9] clocksource/drivers/timer-atmel-pit: Rework Kconfig
Date: Fri, 12 Jun 2020 11:49:18 +0000
Message-ID: <HE1PR03MB3115760E523A8F25686BDD41E5810@HE1PR03MB3115.eurprd03.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Allow building the PIT driver when COMPILE_TEST is enabled. Also remove its
default value so it can be disabled.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>
---
 drivers/clocksource/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 9bc2c0a..444b845 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -405,8 +405,11 @@ config ARMV7M_SYSTICK
 	  This options enables support for the ARMv7M system timer unit
=20
 config ATMEL_PIT
+	bool "Atmel PIT support" if COMPILE_TEST
+	depends on HAS_IOMEM
 	select TIMER_OF if OF
-	def_bool SOC_AT91SAM9 || SOC_SAMA5
+	help
+	  Support for the Periodic Interval Timer found on Atmel SoCs.
=20
 config ATMEL_ST
 	bool "Atmel ST timer support" if COMPILE_TEST
--=20
2.2.2


