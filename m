From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [PATCH] drivers/can: flexcan_chip_start(): enable loopback mode in
 flexcan
Message-ID: <775af6f2-6be8-36f4-b54f-973617332b22@grandegger.com>
Date: Thu, 10 Oct 2019 09:50:58 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Self reception disable bit needs to be cleared for loopback mode to work
in flexcan.

>From mainline Linux commit id 7ad0f53a394ba829e45682c2e21175791e36b649

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 kernel/drivers/can/rtcan_flexcan.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/drivers/can/rtcan_flexcan.c b/kernel/drivers/can/rtcan_flexcan.c
index ac88d07..1287dc8 100644
--- a/kernel/drivers/can/rtcan_flexcan.c
+++ b/kernel/drivers/can/rtcan_flexcan.c
@@ -725,7 +725,25 @@ static int flexcan_chip_start(struct rtcan_device *dev)
 	reg_mcr = flexcan_read(&regs->mcr);
 	reg_mcr |= FLEXCAN_MCR_FRZ | FLEXCAN_MCR_FEN | FLEXCAN_MCR_HALT |
 		FLEXCAN_MCR_SUPV | FLEXCAN_MCR_WRN_EN |
-		FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_SRX_DIS;
+		FLEXCAN_MCR_IDAM_C;
+
+	/* MCR
+	 *
+	 * NOTE: In loopback mode, the CAN_MCR[SRXDIS] cannot be
+	 *       asserted because this will impede the self reception
+	 *       of a transmitted message. This is not documented in
+	 *       earlier versions of flexcan block guide.
+	 *
+	 * Self Reception:
+	 * - enable Self Reception for loopback mode
+	 *   (by clearing "Self Reception Disable" bit)
+	 * - disable for normal operation
+	 */
+	if (dev->ctrl_mode & CAN_CTRLMODE_LOOPBACK)
+		reg_mcr &= ~FLEXCAN_MCR_SRX_DIS;
+	else
+		reg_mcr |= FLEXCAN_MCR_SRX_DIS;
+
 	rtcandev_dbg(dev, "%s: writing mcr=0x%08x", __func__, reg_mcr);
 	flexcan_write(reg_mcr, &regs->mcr);
 
-- 
1.9.1


