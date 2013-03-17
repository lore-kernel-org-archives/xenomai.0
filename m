From: Paul Janzen <pcj@xenomai.sez.to>
Date: Sun, 17 Mar 2013 12:16:54 -0700
References: <oqr4jdyggv.fsf@merlin.sez.to>
Message-ID: <oqli9lyg2i.fsf@merlin.sez.to>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Xenomai] [PATCH 2/2] rtcan_module: Improve buffer size handling
	for /proc/rtcan entries
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Signed-off-by: Paul Janzen <pcj@xenomai.sez.to>
---
 ksrc/drivers/can/rtcan_module.c |   26 +++++++++++++++++---------
 1 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/ksrc/drivers/can/rtcan_module.c b/ksrc/drivers/can/rtcan_module.c
index f270f65..6301f63 100644
--- a/ksrc/drivers/can/rtcan_module.c
+++ b/ksrc/drivers/can/rtcan_module.c
@@ -116,7 +116,7 @@ static void rtcan_get_timeout_name(nanosecs_rel_t timeout,
     if (timeout == RTDM_TIMEOUT_INFINITE)
 	strncpy(name, "infinite", max_len);
     else
-	sprintf(name, "%lld", (long long)timeout);
+	snprintf(name, max_len, "%lld", (long long)timeout);
 }
 
 static int rtcan_read_proc_devices(char *buf, char **start, off_t offset,
@@ -141,8 +141,10 @@ static int rtcan_read_proc_devices(char *buf, char **start, off_t offset,
 
     for (i = 1; i <= RTCAN_MAX_DEVICES; i++) {
 	if ((dev = rtcan_dev_get_by_index(i)) != NULL) {
-	    rtcan_dev_get_state_name(dev->state, state_name, 20);
-	    rtcan_dev_get_baudrate_name(dev->baudrate, baudrate_name, 20);
+	    rtcan_dev_get_state_name(dev->state,
+				     state_name, sizeof(state_name));
+	    rtcan_dev_get_baudrate_name(dev->baudrate,
+					baudrate_name, sizeof(baudrate_name));
 	    ret = RTCAN_PROC_PRINT("%-15s %9s %-8s %10d %10d %10d\n",
 				   dev->name, baudrate_name, state_name,
 				   dev->tx_count, dev->rx_count, dev->err_count);
@@ -195,8 +197,10 @@ static int rtcan_read_proc_sockets(char *buf, char **start, off_t offset,
 	    } else
 		sprintf(name, "%d", ifindex);
 	}
-	rtcan_get_timeout_name(sock->tx_timeout, tx_timeout, 20);
-	rtcan_get_timeout_name(sock->rx_timeout, rx_timeout, 20);
+	rtcan_get_timeout_name(sock->tx_timeout,
+			       tx_timeout, sizeof(tx_timeout));
+	rtcan_get_timeout_name(sock->rx_timeout,
+			       rx_timeout, sizeof(rx_timeout));
 	if (!RTCAN_PROC_PRINT("%2d %-15s %6d 0x%05x %13s %13s %10d %5d\n",
 			      context->fd, name, sock->flistlen,
 			      sock->err_mask, rx_timeout, tx_timeout,
@@ -224,10 +228,14 @@ static int rtcan_read_proc_info(char *buf, char **start, off_t offset,
     if (down_interruptible(&rtcan_devices_nrt_lock))
 	return -ERESTARTSYS;
 
-    rtcan_dev_get_state_name(dev->state, state_name, 20);
-    rtcan_dev_get_ctrlmode_name(dev->ctrl_mode, ctrlmode_name, 80);
-    rtcan_dev_get_baudrate_name(dev->baudrate, baudrate_name, 20);
-    rtcan_dev_get_bittime_name(&dev->bit_time, bittime_name, 80);
+    rtcan_dev_get_state_name(dev->state,
+			     state_name, sizeof(state_name));
+    rtcan_dev_get_ctrlmode_name(dev->ctrl_mode,
+				ctrlmode_name, sizeof(ctrlmode_name));
+    rtcan_dev_get_baudrate_name(dev->baudrate,
+				baudrate_name, sizeof(baudrate_name));
+    rtcan_dev_get_bittime_name(&dev->bit_time,
+			       bittime_name, sizeof(bittime_name));
 
     if (!RTCAN_PROC_PRINT("%s %s\n", "Device    ", dev->name) ||
 	!RTCAN_PROC_PRINT("%s %s\n", "Controller", dev->ctrl_name) ||
-- 
1.7.6.5


