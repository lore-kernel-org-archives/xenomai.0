MIME-Version: 1.0
From: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Date: Tue, 14 Jan 2020 18:22:49 +0200
Message-ID: <CAPm8-H5EbHi3HPsUMTzdzQswVsGnuOvD0PqZr2QkjO+LqOiBCw@mail.gmail.com>
Subject: [PATCH 2/5] spi: new SPI_RTIOC_TRANSFER_N ioctl option
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

From: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>

SPI_RTIOC_TRANSFER_N allows the user
to make SPI transfers of arbitrary lengths
by using the same mmapped memory area.

Signed-off-by: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
---
 include/rtdm/uapi/spi.h         |  1 +
 kernel/drivers/spi/spi-master.c | 15 ++++++++++++++-
 kernel/drivers/spi/spi-master.h |  1 +
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/rtdm/uapi/spi.h b/include/rtdm/uapi/spi.h
index 8f042377f..184a2b027 100644
--- a/include/rtdm/uapi/spi.h
+++ b/include/rtdm/uapi/spi.h
@@ -37,5 +37,6 @@ struct rtdm_spi_iobufs {
 #define SPI_RTIOC_GET_CONFIG		_IOR(RTDM_CLASS_SPI, 1, struct rtdm_spi_config)
 #define SPI_RTIOC_SET_IOBUFS		_IOR(RTDM_CLASS_SPI, 2, struct rtdm_spi_iobufs)
 #define SPI_RTIOC_TRANSFER		_IO(RTDM_CLASS_SPI, 3)
+#define SPI_RTIOC_TRANSFER_N		_IOR(RTDM_CLASS_SPI, 4, int)

 #endif /* !_RTDM_UAPI_SPI_H */
diff --git a/kernel/drivers/spi/spi-master.c b/kernel/drivers/spi/spi-master.c
index e04f7ca10..104af8023 100644
--- a/kernel/drivers/spi/spi-master.c
+++ b/kernel/drivers/spi/spi-master.c
@@ -150,7 +150,7 @@ static int spi_master_ioctl_rt(struct rtdm_fd *fd,
 	struct rtdm_spi_remote_slave *slave = fd_to_slave(fd);
 	struct rtdm_spi_master *master = slave->master;
 	struct rtdm_spi_config config;
-	int ret;
+	int ret, len;

 	switch (request) {
 	case SPI_RTIOC_SET_CONFIG:
@@ -178,6 +178,19 @@ static int spi_master_ioctl_rt(struct rtdm_fd *fd,
 			rtdm_mutex_unlock(&master->bus_lock);
 		}
 		break;
+	case SPI_RTIOC_TRANSFER_N:
+		ret = -EINVAL;
+		if (master->ops->transfer_iobufs_n) {
+			len = (int)arg;
+			rtdm_mutex_lock(&master->bus_lock);
+			ret = do_chip_select(slave);
+			if (ret == 0) {
+				ret = master->ops->transfer_iobufs_n(slave, len);
+				do_chip_deselect(slave);
+			}
+			rtdm_mutex_unlock(&master->bus_lock);
+		}
+		break;
 	default:
 		ret = -ENOSYS;
 	}
diff --git a/kernel/drivers/spi/spi-master.h b/kernel/drivers/spi/spi-master.h
index b5a9ce762..ecfea2f90 100644
--- a/kernel/drivers/spi/spi-master.h
+++ b/kernel/drivers/spi/spi-master.h
@@ -39,6 +39,7 @@ struct rtdm_spi_master_ops {
 			   struct vm_area_struct *vma);
 	void (*mmap_release)(struct rtdm_spi_remote_slave *slave);
 	int (*transfer_iobufs)(struct rtdm_spi_remote_slave *slave);
+	int (*transfer_iobufs_n)(struct rtdm_spi_remote_slave *slave, int len);
 	ssize_t (*write)(struct rtdm_spi_remote_slave *slave,
 			 const void *tx, size_t len);
 	ssize_t (*read)(struct rtdm_spi_remote_slave *slave,
-- 
2.17.1

