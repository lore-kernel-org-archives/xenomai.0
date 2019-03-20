From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 2/5] drivers/serial: imx: fix locking imbalance upon -EBADF
Date: Wed, 20 Mar 2019 16:44:22 +0100
Message-Id: <20190320154425.30639-3-rpm@xenomai.org>
In-Reply-To: <20190320154425.30639-1-rpm@xenomai.org>
References: <20190320154425.30639-1-rpm@xenomai.org>
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
 kernel/drivers/serial/rt_imx_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/serial/rt_imx_uart.c b/kernel/drivers/serial/rt_imx_uart.c
index 443a34261..574fd1aa7 100644
--- a/kernel/drivers/serial/rt_imx_uart.c
+++ b/kernel/drivers/serial/rt_imx_uart.c
@@ -1433,7 +1433,7 @@ static ssize_t rt_imx_uart_write(struct rtdm_fd *fd, const void *buf,
 				/* Device has been closed -
 				 * return immediately.
 				 */
-				return -EBADF;
+				ret = -EBADF;
 			}
 			if (ret == -EWOULDBLOCK) {
 				/* Fix error code for non-blocking mode. */
-- 
2.20.1


