MIME-Version: 1.0
From: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Date: Mon, 30 Dec 2019 17:06:01 +0200
Message-ID: <CAPm8-H5XxArzdkjuy8dS-Hkud4aaNE11DrOQEmc+-a2MgxndbQ@mail.gmail.com>
Subject: [patch 1/5] spi-master.c: spi_master_read_rt()
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

>From 15c59317fe1a9d60e20d470de3aca09bca5b99d0 Mon Sep 17 00:00:00 2001
From: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Date: Fri, 20 Dec 2019 17:35:50 +0200
Subject: [PATCH] spi-master.c: spi_master_read_rt(): when master->ops->read()
 completes successfully it returns > 0, so, in this case, copy data to
 userspace.

Signed-off-by: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
---
 kernel/drivers/spi/spi-master.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/spi/spi-master.c b/kernel/drivers/spi/spi-master.c
index 12a1ad1f1..e04f7ca10 100644
--- a/kernel/drivers/spi/spi-master.c
+++ b/kernel/drivers/spi/spi-master.c
@@ -240,8 +240,8 @@ static ssize_t spi_master_read_rt(struct rtdm_fd *fd,
 		do_chip_deselect(slave);
 	}
 	rtdm_mutex_unlock(&master->bus_lock);
-	if (ret == 0)
-		ret = rtdm_safe_copy_to_user(fd, u_buf, rx, len);
+	if (ret > 0)
+		ret = rtdm_safe_copy_to_user(fd, u_buf, rx, ret);
 	
 	xnfree(rx);
 	
-- 
2.17.1

