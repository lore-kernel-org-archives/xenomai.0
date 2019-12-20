MIME-Version: 1.0
From: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Date: Fri, 20 Dec 2019 13:14:20 +0200
Message-ID: <CAPm8-H7RNuMLSmiB-NdJ+Edck-GQy1dRmmPzc2un_V1f7QsQtA@mail.gmail.com>
Subject: [patch 1/4] fix: spi_master_read_rt()
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

>From 6e9138e92a4b9a3f163faeb4ad04f257157fd2f5 Mon Sep 17 00:00:00 2001
From: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Date: Fri, 20 Dec 2019 13:00:42 +0200
Subject: [PATCH] - spi_master_read_rt(): if master->ops->read() returns > 0,
 then copy data to userspace.

Signed-off-by: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
---
 kernel/drivers/spi/spi-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/spi/spi-master.c b/kernel/drivers/spi/spi-master.c
index 12a1ad1f1..1e81bd02e 100644
--- a/kernel/drivers/spi/spi-master.c
+++ b/kernel/drivers/spi/spi-master.c
@@ -240,7 +240,7 @@ static ssize_t spi_master_read_rt(struct rtdm_fd *fd,
 		do_chip_deselect(slave);
 	}
 	rtdm_mutex_unlock(&master->bus_lock);
-	if (ret == 0)
+	if (ret > 0)
 		ret = rtdm_safe_copy_to_user(fd, u_buf, rx, len);
 	
 	xnfree(rx);
-- 
2.17.1

