From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 3/5] drivers/serial: imx: drop useless EWOULDBLOCK->EAGAIN
 remapping
Date: Wed, 20 Mar 2019 16:44:23 +0100
Message-Id: <20190320154425.30639-4-rpm@xenomai.org>
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
 kernel/drivers/serial/rt_imx_uart.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/drivers/serial/rt_imx_uart.c b/kernel/drivers/serial/rt_imx_uart.c
index 574fd1aa7..6118e29b7 100644
--- a/kernel/drivers/serial/rt_imx_uart.c
+++ b/kernel/drivers/serial/rt_imx_uart.c
@@ -1435,10 +1435,6 @@ static ssize_t rt_imx_uart_write(struct rtdm_fd *fd, const void *buf,
 				 */
 				ret = -EBADF;
 			}
-			if (ret == -EWOULDBLOCK) {
-				/* Fix error code for non-blocking mode. */
-				ret = -EAGAIN;
-			}
 			break;
 		}
 	}
-- 
2.20.1


