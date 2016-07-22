From: Alexey Gerasev <alexey.gerasev@gmail.com>
Date: Fri, 22 Jul 2016 16:19:08 +0600
Message-Id: <1469182748-3614-1-git-send-email-alexey.gerasev@gmail.com>
Subject: [Xenomai]  'select' for RTCAN sockets
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles@click-hack.org>
Cc: xenomai@xenomai.org

---
 kernel/drivers/can/rtcan_raw.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/kernel/drivers/can/rtcan_raw.c b/kernel/drivers/can/rtcan_raw.c
index 693b927..3a49d7c 100644
--- a/kernel/drivers/can/rtcan_raw.c
+++ b/kernel/drivers/can/rtcan_raw.c
@@ -965,6 +965,44 @@ ssize_t rtcan_raw_sendmsg(struct rtdm_fd *fd,
 }
 
 
+static int rtcan_raw_select(struct rtdm_fd *fd,
+			    rtdm_selector_t *selector,
+			    enum rtdm_selecttype type,
+			    unsigned fd_index)
+{
+    struct rtcan_socket *sock = rtdm_fd_to_private(fd);
+
+    switch (type) {
+	case XNSELECT_READ:
+	    return rtdm_sem_select(&sock->recv_sem, selector,
+				   XNSELECT_READ, fd_index);
+	case XNSELECT_WRITE:
+	{
+	    struct rtcan_device *dev;
+	    int ifindex = 0;
+	    int ret;
+
+	    if (!(ifindex = atomic_read(&sock->ifindex)))
+		return -ENXIO;
+
+	    if ((dev = rtcan_dev_get_by_index(ifindex)) == NULL)
+		return -ENXIO;
+
+	    ret = rtdm_sem_select(&dev->tx_sem, selector,
+				  XNSELECT_WRITE, fd_index);
+
+	    rtcan_dev_dereference(dev);
+
+	    return ret;
+	}
+	default:
+	    return -EBADF;
+    }
+
+    return -EINVAL;
+}
+
+
 static struct rtdm_driver rtcan_driver = {
 	.profile_info		= RTDM_PROFILE_INFO(rtcan,
 						    RTDM_CLASS_CAN,
@@ -981,6 +1019,7 @@ static struct rtdm_driver rtcan_driver = {
 		.ioctl_nrt	= rtcan_raw_ioctl,
 		.recvmsg_rt	= rtcan_raw_recvmsg,
 		.sendmsg_rt	= rtcan_raw_sendmsg,
+		.select		= rtcan_raw_select,
 	},
 };
 
-- 
2.1.4


