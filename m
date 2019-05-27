From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] drivers/serial: 16550A: Plug race between TX interrupt
 handler and write function
Message-ID: <908bbe5e-2f20-c2cf-cea9-65960717d438@siemens.com>
Date: Mon, 27 May 2019 09:25:56 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

If the TX interrupt was enabled and fired on empty THR before the write
function updated out_npend, we could get stuck with transmitting. Plug
that race by checking in the write handler if we could write to the FIFO
directly. That ensures early filling of the FIFO as well as that a TX
interrupt is fired again if there needs to be more data written.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

While this may not fix all issues currently seen, it still seems like a
correct step forward to me. So at least try it on master.

 kernel/drivers/serial/16550A.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/kernel/drivers/serial/16550A.c b/kernel/drivers/serial/16550A.c
index 923211bd1c..81acc6344e 100644
--- a/kernel/drivers/serial/16550A.c
+++ b/kernel/drivers/serial/16550A.c
@@ -190,7 +190,7 @@ static inline int rt_16550_rx_interrupt(struct rt_16550_context *ctx,
 	return rbytes;
 }
 
-static inline void rt_16550_tx_interrupt(struct rt_16550_context *ctx)
+static void rt_16550_tx_fill(struct rt_16550_context *ctx)
 {
 	int c;
 	int count;
@@ -248,7 +248,7 @@ static int rt_16550_interrupt(rtdm_irq_t * irq_context)
 		} else if (iir == IIR_STAT)
 			rt_16550_stat_interrupt(ctx);
 		else if (iir == IIR_TX)
-			rt_16550_tx_interrupt(ctx);
+			rt_16550_tx_fill(ctx);
 		else if (iir == IIR_MODEM) {
 			modem = rt_16550_reg_in(mode, base, MSR);
 			if (modem & (modem << 4))
@@ -951,6 +951,7 @@ ssize_t rt_16550_write(struct rtdm_fd *fd, const void *buf, size_t nbyte)
 	int block;
 	int subblock;
 	int out_pos;
+	int lsr;
 	char *in_pos = (char *)buf;
 	rtdm_toseq_t timeout_seq;
 	ssize_t ret;
@@ -1027,11 +1028,18 @@ ssize_t rt_16550_write(struct rtdm_fd *fd, const void *buf, size_t nbyte)
 			    (ctx->out_tail + block) & (OUT_BUFFER_SIZE - 1);
 			ctx->out_npend += block;
 
-			/* unmask tx interrupt */
-			ctx->ier_status |= IER_TX;
-			rt_16550_reg_out(rt_16550_io_mode_from_ctx(ctx),
-					 ctx->base_addr, IER,
-					 ctx->ier_status);
+			lsr = rt_16550_reg_in(rt_16550_io_mode_from_ctx(ctx),
+					      ctx->base_addr, LSR);
+			if (lsr & RTSER_LSR_THR_EMTPY)
+				rt_16550_tx_fill(ctx);
+
+			if (ctx->out_npend > 0 && !(ctx->ier_status & IER_TX)) {
+				/* unmask tx interrupt */
+				ctx->ier_status |= IER_TX;
+				rt_16550_reg_out(rt_16550_io_mode_from_ctx(ctx),
+						 ctx->base_addr, IER,
+						 ctx->ier_status);
+			}
 
 			rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
 			continue;
-- 
2.16.4

