From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] drivers/serial: rt_imx_uart: Fix compiler warning
Message-ID: <1476a0e7-5047-08a8-6832-bbf981c0e21f@siemens.com>
Date: Mon, 2 Aug 2021 12:37:29 +0200
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Addresses "cast from pointer to integer of different size".

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/serial/rt_imx_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/serial/rt_imx_uart.c b/kernel/drivers/serial/rt_imx_uart.c
index 6894c1c29c..94efe873a6 100644
--- a/kernel/drivers/serial/rt_imx_uart.c
+++ b/kernel/drivers/serial/rt_imx_uart.c
@@ -1158,7 +1158,7 @@ wait_unlock_out:
 
 	case RTSER_RTIOC_BREAK_CTL: {
 		rtdm_lock_get_irqsave(&ctx->lock, lock_ctx);
-		rt_imx_uart_break_ctl(ctx, (int)arg);
+		rt_imx_uart_break_ctl(ctx, (unsigned long)arg);
 		rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
 		break;
 	}
-- 
2.31.1

