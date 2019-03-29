From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 4/4] drivers/serial: imx: dismiss noisy IRQ events
Date: Fri, 29 Mar 2019 18:41:03 +0100
Message-Id: <20190329174103.8158-5-rpm@xenomai.org>
In-Reply-To: <20190329174103.8158-1-rpm@xenomai.org>
References: <20190329174103.8158-1-rpm@xenomai.org>
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

Converging to the upstream implementation further, disregard any event
which source is disabled, to help dealing with transitory states of
the hardware (e.g. as triggered by device closure).

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/serial/rt_imx_uart.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/drivers/serial/rt_imx_uart.c b/kernel/drivers/serial/rt_imx_uart.c
index fa9dc64e8..6d95cbcab 100644
--- a/kernel/drivers/serial/rt_imx_uart.c
+++ b/kernel/drivers/serial/rt_imx_uart.c
@@ -463,8 +463,7 @@ static int rt_imx_uart_int(rtdm_irq_t *irq_context)
 	uint64_t timestamp = rtdm_clock_read();
 	struct rt_imx_uart_ctx *ctx;
 	unsigned int usr1, usr2, ucr1;
-	int rbytes = 0;
-	int events = 0;
+	int rbytes = 0, events = 0;
 	int ret = RTDM_IRQ_NONE;
 
 	ctx = rtdm_irq_get_arg(irq_context, struct rt_imx_uart_ctx);
@@ -479,16 +478,19 @@ static int rt_imx_uart_int(rtdm_irq_t *irq_context)
 	 * Read if there is data available
 	 */
 	if (usr1 & USR1_RRDY) {
-		rbytes += rt_imx_uart_rx_chars(ctx, &timestamp);
-		events |= RTSER_EVENT_RXPEND;
+		if (likely(ucr1 & UCR1_RRDYEN)) {
+			rbytes = rt_imx_uart_rx_chars(ctx, &timestamp);
+			events |= RTSER_EVENT_RXPEND;
+		}
 		ret = RTDM_IRQ_HANDLED;
 	}
 
 	/*
 	 * Send data if there is data to be sent
 	 */
-	if ((usr1 & USR1_TRDY) && (ucr1 & UCR1_TXMPTYEN)) {
-		rt_imx_uart_tx_chars(ctx);
+	if (usr1 & USR1_TRDY) {
+		if (likely(ucr1 & UCR1_TXMPTYEN))
+			rt_imx_uart_tx_chars(ctx);
 		ret = RTDM_IRQ_HANDLED;
 	}
 
-- 
2.20.1


