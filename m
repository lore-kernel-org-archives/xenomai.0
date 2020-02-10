From: Stephen Freyder <steve@freyder.net>
Subject: [PATCH 1/1] Restore proper operation of ioctl(SET_CONFIG)
Date: Mon, 10 Feb 2020 12:54:42 -0600
Message-Id: <1581360882-8724-1-git-send-email-steve@freyder.net>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Disable software reset by setting SRST_B=1 when writing to UCR2 in
rt_imx_uart_set_config.

Signed-off-by: Stephen Freyder <steve@freyder.net>
---
 kernel/drivers/serial/rt_imx_uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/serial/rt_imx_uart.c b/kernel/drivers/serial/rt_imx_uart.c
index 2b27b7d..6894c1c 100644
--- a/kernel/drivers/serial/rt_imx_uart.c
+++ b/kernel/drivers/serial/rt_imx_uart.c
@@ -703,9 +703,9 @@ static int rt_imx_uart_set_config(struct rt_imx_uart_ctx *ctx,
 		uint64_t tdiv64;
 
 		if (ctx->config.data_bits == RTSER_8_BITS)
-			ucr2 = UCR2_WS | UCR2_IRTS;
+			ucr2 = UCR2_WS | UCR2_SRST | UCR2_IRTS;
 		else
-			ucr2 = UCR2_IRTS;
+			ucr2 = UCR2_SRST | UCR2_IRTS;
 
 		if (ctx->config.handshake == RTSER_RTSCTS_HAND) {
 			if (port->have_rtscts) {
-- 
2.7.4


