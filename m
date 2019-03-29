From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 3/4] drivers/serial: imx: simplify RX loop
Date: Fri, 29 Mar 2019 18:41:02 +0100
Message-Id: <20190329174103.8158-4-rpm@xenomai.org>
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

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/serial/rt_imx_uart.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/drivers/serial/rt_imx_uart.c b/kernel/drivers/serial/rt_imx_uart.c
index 9e2ade4cb..fa9dc64e8 100644
--- a/kernel/drivers/serial/rt_imx_uart.c
+++ b/kernel/drivers/serial/rt_imx_uart.c
@@ -380,12 +380,11 @@ static void rt_imx_uart_enable_ms(struct rt_imx_uart_ctx *ctx)
 static int rt_imx_uart_rx_chars(struct rt_imx_uart_ctx *ctx,
 				uint64_t *timestamp)
 {
-	unsigned int rx, temp, max_count = 256;
+	unsigned int rx, temp;
 	int rbytes = 0;
 	int lsr = 0;
 
-	while ((readl(ctx->port->membase + USR2) & USR2_RDR) &&
-	       (max_count-- > 0)) {
+	while (readl(ctx->port->membase + USR2) & USR2_RDR) {
 		rx = readl(ctx->port->membase + URXD0);
 		temp = readl(ctx->port->membase + USR2);
 		if (temp & USR2_BRCD) {
@@ -408,10 +407,10 @@ static int rt_imx_uart_rx_chars(struct rt_imx_uart_ctx *ctx,
 			ctx->in_history[ctx->in_tail] = *timestamp;
 		ctx->in_tail = (ctx->in_tail + 1) & (IN_BUFFER_SIZE - 1);
 
-		if (++ctx->in_npend > IN_BUFFER_SIZE) {
+		if (unlikely(ctx->in_npend >= IN_BUFFER_SIZE))
 			lsr |= RTSER_SOFT_OVERRUN_ERR;
-			ctx->in_npend--;
-		}
+		else
+			ctx->in_npend++;
 
 		rbytes++;
 	}
-- 
2.20.1


