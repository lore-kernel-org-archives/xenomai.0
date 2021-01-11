From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] drivers: spi: Fix compiler warning
Message-ID: <da4bd61b-1602-c455-32dc-e9c2ea18e271@siemens.com>
Date: Mon, 11 Jan 2021 14:27:57 +0100
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

Addresses "warning: cast from pointer to integer of different size".

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/spi/spi-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/spi/spi-master.c b/kernel/drivers/spi/spi-master.c
index 104af8023f..0fad328ef7 100644
--- a/kernel/drivers/spi/spi-master.c
+++ b/kernel/drivers/spi/spi-master.c
@@ -181,7 +181,7 @@ static int spi_master_ioctl_rt(struct rtdm_fd *fd,
 	case SPI_RTIOC_TRANSFER_N:
 		ret = -EINVAL;
 		if (master->ops->transfer_iobufs_n) {
-			len = (int)arg;
+			len = (long)arg;
 			rtdm_mutex_lock(&master->bus_lock);
 			ret = do_chip_select(slave);
 			if (ret == 0) {
-- 
2.26.2

