From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 2/4] drivers/serial: always propagate -EINTR downstream
Date: Fri, 29 Mar 2019 18:41:01 +0100
Message-Id: <20190329174103.8158-3-rpm@xenomai.org>
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

No ifs, not buts: drivers must pass -EINTR to the core whenever
received from a blocking call.

NOTE: this change also prevents userland from receiving a partial byte
count from an interrupted read/write operation, although such amount
of bytes may have been transferred from/to the corresponding software
FIFO.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/serial/rt_imx_uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/serial/rt_imx_uart.c b/kernel/drivers/serial/rt_imx_uart.c
index 32b472c78..9e2ade4cb 100644
--- a/kernel/drivers/serial/rt_imx_uart.c
+++ b/kernel/drivers/serial/rt_imx_uart.c
@@ -1352,7 +1352,7 @@ break_unlocked:
 	clear_bit(0, &ctx->in_lock);
 
 	if ((read > 0) && ((ret == 0) || (ret == -EAGAIN) ||
-			   (ret == -ETIMEDOUT) || (ret == -EINTR)))
+			   (ret == -ETIMEDOUT)))
 		ret = read;
 
 	return ret;
@@ -1471,7 +1471,7 @@ static ssize_t rt_imx_uart_write(struct rtdm_fd *fd, const void *buf,
 	rtdm_mutex_unlock(&ctx->out_lock);
 
 	if ((written > 0) && ((ret == 0) || (ret == -EAGAIN) ||
-			      (ret == -ETIMEDOUT) || (ret == -EINTR)))
+			      (ret == -ETIMEDOUT)))
 		ret = written;
 
 	return ret;
-- 
2.20.1


