Message-ID: <507E946A.5020105@siemens.com>
Date: Wed, 17 Oct 2012 13:20:10 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] can: Let Flexcan driver depend on platform support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>
Cc: Wolfgang Grandegger <wg@denx.de>

Just like the Linux version does, let our RT Flexcan driver depend on
CONFIG_HAVE_CAN_FLEXCAN so that it can only be selected on platforms
that actually support it.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ksrc/drivers/can/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/ksrc/drivers/can/Kconfig b/ksrc/drivers/can/Kconfig
index 216b807..ce411dd 100644
--- a/ksrc/drivers/can/Kconfig
+++ b/ksrc/drivers/can/Kconfig
@@ -80,7 +80,7 @@ config XENO_DRIVERS_CAN_VIRT
 	More ports can be enabled with the module parameter "devices".
 
 config XENO_DRIVERS_CAN_FLEXCAN
-	depends on XENO_DRIVERS_CAN && !XENO_DRIVERS_CAN_CALC_BITTIME_OLD
+	depends on XENO_DRIVERS_CAN && HAVE_CAN_FLEXCAN && !XENO_DRIVERS_CAN_CALC_BITTIME_OLD
 	tristate "Freescale FLEXCAN based chips"
 	help
 
-- 
1.7.3.4

