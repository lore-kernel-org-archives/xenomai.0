MIME-Version: 1.0
From: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Date: Mon, 30 Dec 2019 17:09:36 +0200
Message-ID: <CAPm8-H6Ybn0MpZ-UV=hyuadz=RtAVti=KmTjC+Rg1YUU1QD6_Q@mail.gmail.com>
Subject: [patch 3/5] spi-bcm2835.c,
 spi-sun6i.c: bcm2835/sun6i_transfer_iobufs_n()
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

>From 07f1e45874acef2b302eada672eaca0648f6c8fb Mon Sep 17 00:00:00 2001
From: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Date: Sat, 28 Dec 2019 12:05:35 +0200
Subject: [PATCH] spi-bcm2835.c, spi-sun6i.c: add functions
 bcm2835/sun6i_transfer_iobufs_n()

In order to support SPI_RTIOC_TRANSFER_N ioctl option
add functions bcm2835_transfer_iobufs_n() and sun6i_transfer_iobufs_n()
which are similar to bcm2835/sun6i_transfer_iobufs()

Signed-off-by: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
---
 kernel/drivers/spi/spi-bcm2835.c | 19 +++++++++++++++++++
 kernel/drivers/spi/spi-sun6i.c   | 19 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/kernel/drivers/spi/spi-bcm2835.c b/kernel/drivers/spi/spi-bcm2835.c
index e4a95d081..696a1fd89 100644
--- a/kernel/drivers/spi/spi-bcm2835.c
+++ b/kernel/drivers/spi/spi-bcm2835.c
@@ -318,6 +318,24 @@ static int bcm2835_transfer_iobufs(struct
rtdm_spi_remote_slave *slave)
 	return do_transfer_irq(slave);
 }

+static int bcm2835_transfer_iobufs_n(struct rtdm_spi_remote_slave *slave,
+										 int len)
+{
+	struct spi_master_bcm2835 *spim = to_master_bcm2835(slave);
+	struct spi_slave_bcm2835 *bcm = to_slave_bcm2835(slave);
+	
+	if ((bcm->io_len == 0) ||
+		(len <= 0) || (len > (bcm->io_len / 2)))
+		return -EINVAL;
+	
+	spim->tx_len = len;
+	spim->rx_len = len;
+	spim->tx_buf = bcm->io_virt + bcm->io_len / 2;
+	spim->rx_buf = bcm->io_virt;
+	
+	return do_transfer_irq(slave);
+}
+
 static ssize_t bcm2835_read(struct rtdm_spi_remote_slave *slave,
 			    void *rx, size_t len)
 {
@@ -549,6 +567,7 @@ static struct rtdm_spi_master_ops bcm2835_master_ops = {
 	.mmap_iobufs = bcm2835_mmap_iobufs,
 	.mmap_release = bcm2835_mmap_release,
 	.transfer_iobufs = bcm2835_transfer_iobufs,
+	.transfer_iobufs_n = bcm2835_transfer_iobufs_n,
 	.write = bcm2835_write,
 	.read = bcm2835_read,
 	.attach_slave = bcm2835_attach_slave,
diff --git a/kernel/drivers/spi/spi-sun6i.c b/kernel/drivers/spi/spi-sun6i.c
index ec08c98d8..dfc144e7e 100644
--- a/kernel/drivers/spi/spi-sun6i.c
+++ b/kernel/drivers/spi/spi-sun6i.c
@@ -355,6 +355,24 @@ static int sun6i_transfer_iobufs(struct
rtdm_spi_remote_slave *slave)
 	return do_transfer_irq(slave);
 }

+static int sun6i_transfer_iobufs_n(struct rtdm_spi_remote_slave *slave,
+								 int len)
+{
+	struct spi_master_sun6i *spim = to_master_sun6i(slave);
+	struct spi_slave_sun6i *sun6i = to_slave_sun6i(slave);
+
+	if ((sun6i->io_len == 0) ||
+		(len <= 0) || (len > (sun6i->io_len / 2)))
+		return -EINVAL;
+
+	spim->tx_len = len;
+	spim->rx_len = len;
+	spim->tx_buf = sun6i->io_virt + sun6i->io_len / 2;
+	spim->rx_buf = sun6i->io_virt;
+
+	return do_transfer_irq(slave);
+}
+
 static ssize_t sun6i_read(struct rtdm_spi_remote_slave *slave,
 			  void *rx, size_t len)
 {
@@ -480,6 +498,7 @@ static struct rtdm_spi_master_ops sun6i_master_ops = {
 	.mmap_iobufs = sun6i_mmap_iobufs,
 	.mmap_release = sun6i_mmap_release,
 	.transfer_iobufs = sun6i_transfer_iobufs,
+	.transfer_iobufs_n = sun6i_transfer_iobufs_n,	
 	.write = sun6i_write,
 	.read = sun6i_read,
 	.attach_slave = sun6i_attach_slave,
-- 
2.17.1

