From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH] drivers/serial: imx: fix transmit interrupt handling
Date: Tue, 26 Mar 2019 14:16:19 +0100
Message-Id: <20190326131619.24709-1-rpm@xenomai.org>
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

We may receive TRDY when the TX-FIFO is not entirely empty, which
breaks the logic in rt_imx_uart_tx_chars(), as we may break early from
the transmit loop when the TXFULL condition is detected, skipping
decrement of ctx->out_npend although a byte was sent.

Because of this, we may end up with ghost bytes in the output buffer
which were actually sent to the UART, but still erroneously counted in
ctx->out_npend. As a result, incorrect output can be observed later on
as bytes from the software FIFO are unduly sent, or such FIFO may
overflow indefinitely due to accumulated errors.

Fix this by testing TXFULL before sending the next byte to the UART.
At this chance, drop the count limit on the FIFO depth: testing TXFULL
is sufficient and robust.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/serial/rt_imx_uart.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/drivers/serial/rt_imx_uart.c b/kernel/drivers/serial/rt_imx_uart.c
index 6118e29b7..f91d8fb8b 100644
--- a/kernel/drivers/serial/rt_imx_uart.c
+++ b/kernel/drivers/serial/rt_imx_uart.c
@@ -422,18 +422,15 @@ static int rt_imx_uart_rx_chars(struct rt_imx_uart_ctx *ctx,
 
 static void rt_imx_uart_tx_chars(struct rt_imx_uart_ctx *ctx)
 {
-	int ch, count;
+	int ch;
 	unsigned int uts_reg = ctx->port->devdata->uts_reg;
 
-	for (count = ctx->port->tx_fifo;
-	     (count > 0) && (ctx->out_npend > 0);
-	     count--, ctx->out_npend--) {
+	while (ctx->out_npend > 0 &&
+	       !(readl(ctx->port->membase + uts_reg) & UTS_TXFULL)) {
 		ch = ctx->out_buf[ctx->out_head++];
 		writel(ch, ctx->port->membase + URTX0);
 		ctx->out_head &= (OUT_BUFFER_SIZE - 1);
-
-		if (readl(ctx->port->membase + uts_reg) & UTS_TXFULL)
-			break;
+		ctx->out_npend--;
 	}
 }
 
-- 
2.20.1


