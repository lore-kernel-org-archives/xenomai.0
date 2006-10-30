Message-ID: <4545EA5C.7020105@domain.hid>
Date: Mon, 30 Oct 2006 13:04:44 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000109000306070306080204"
Subject: [Xenomai-core] [PATCH] RT-Socket-CAN fixes
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------000109000306070306080204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hallo,

attached you will find a patch for Xenomai RT-Socket-CAN fixing:

2006-10-30  Wolfgang Grandegger  <wg@domain.hid>

         * src/utils/can/rtcanrecv: Add timestamp support via
           rt_dev_recvmsg().

         * ksrc/drivers/can/mscan/rtcan_mscan.c (rtcan_mscan_interrupt),
         ksrc/drivers/can/mscan/rtcan_mscan_regs.h: Restrict MSCAN TX
         hardware buffer usage to one for the sake of real-time. Fix bug
         with TX IRQ handling. Copy timestamp also for error messages.

         * ksrc/drivers/can/sja1000/rtcan_sja1000.c(rtcan_sja_interrupt):
         Copy timestamp also for error messages.

Wolfgang.


--------------000109000306070306080204
Content-Type: text/x-patch;
 name="xenomai-rtcan-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-rtcan-update.patch"

Index: src/utils/can/rtcanrecv.c
===================================================================
--- src/utils/can/rtcanrecv.c	(revision 1770)
+++ src/utils/can/rtcanrecv.c	(working copy)
@@ -20,6 +20,7 @@
 	    " -f  --filter=id:mask[:id:mask]... apply filter\n"
 	    " -e  --error=mask      receive error messages\n"
 	    " -t, --timeout=MS      timeout in ms\n"
+	    " -T, --timestamp       with timestamp\n"
 	    " -v, --verbose         be verbose\n"
 	    " -p, --print=MODULO    print every MODULO message\n"
 	    " -h, --help            this help\n",
@@ -30,7 +31,7 @@
 extern int optind, opterr, optopt;
 
 static int s = -1, verbose = 0, print = 1;
-static nanosecs_rel_t timeout = 0;
+static nanosecs_rel_t timeout = 0, with_timestamp = 0;
 
 RT_TASK rt_task_desc;
 
@@ -84,10 +85,27 @@
     struct can_frame frame;
     struct sockaddr_can addr;
     socklen_t addrlen = sizeof(addr);
+    struct msghdr msg;
+    struct iovec iov;
+    nanosecs_abs_t timestamp;
 
+    if (with_timestamp) {
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_name = (void *)&addr;
+	msg.msg_namelen = sizeof(struct sockaddr_can);
+	msg.msg_control = (void *)&timestamp;
+	msg.msg_controllen = sizeof(nanosecs_abs_t);
+    }
+
     while (1) {
-	ret = rt_dev_recvfrom(s, (void *)&frame, sizeof(can_frame_t), 0,
-	                      (struct sockaddr *)&addr, &addrlen);
+	if (with_timestamp) {
+	    iov.iov_base = (void *)&frame;
+	    iov.iov_len = sizeof(can_frame_t);
+	    ret = rt_dev_recvmsg(s, &msg, 0);
+	} else
+	    ret = rt_dev_recvfrom(s, (void *)&frame, sizeof(can_frame_t), 0,
+				  (struct sockaddr *)&addr, &addrlen);
 	if (ret < 0) {
 	    switch (ret) {
 	    case -ETIMEDOUT:
@@ -106,6 +124,8 @@
 
 	if (print && (count % print) == 0) {
 	    printf("#%d: (%d) ", count, addr.can_ifindex);
+	    if (with_timestamp && msg.msg_controllen)
+		printf("%lldns ", timestamp);
 	    if (frame.can_id & CAN_ERR_FLAG)
 		printf("!0x%08x!", frame.can_id & CAN_ERR_MASK);
 	    else if (frame.can_id & CAN_EFF_FLAG)
@@ -147,6 +167,7 @@
 	{ "filter", required_argument, 0, 'f'},
 	{ "error", required_argument, 0, 'e'},
 	{ "timeout", required_argument, 0, 't'},
+	{ "timestamp", no_argument, 0, 'T'},
 	{ 0, 0, 0, 0},
     };
 
@@ -155,7 +176,7 @@
     signal(SIGTERM, cleanup_and_exit);
     signal(SIGINT, cleanup_and_exit);
 
-    while ((opt = getopt_long(argc, argv, "hve:f:t:p:",
+    while ((opt = getopt_long(argc, argv, "hve:f:t:p:T",
 			      long_options, NULL)) != -1) {
 	switch (opt) {
 	case 'h':
@@ -196,6 +217,10 @@
 	    timeout = (nanosecs_rel_t)strtoul(optarg, NULL, 0) * 1000000;
 	    break;
 
+	case 'T':
+	    with_timestamp = 1;
+	    break;
+
 	default:
 	    fprintf(stderr, "Unknown option %c\n", opt);
 	    break;
@@ -269,6 +294,14 @@
 	}
     }
 
+    if (with_timestamp) {
+	ret = rt_dev_ioctl(s, RTCAN_RTIOC_TAKE_TIMESTAMP, RTCAN_TAKE_TIMESTAMPS);
+	if (ret) {
+	    fprintf(stderr, "rt_dev_ioctl TAKE_TIMESTAMP: %s\n", strerror(-ret));
+	    goto failure;
+	}
+    }
+
     snprintf(name, sizeof(name), "rtcanrecv-%d", getpid());
     ret = rt_task_shadow(&rt_task_desc, name, 1, 0);
     if (ret) {
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 1770)
+++ ChangeLog	(working copy)
@@ -1,3 +1,15 @@
+2006-10-30  Wolfgang Grandegger  <wg@domain.hid>
+
+	* src/utils/can/rtcanrecv: Add timestamp support via rt_dev_recvmsg().
+
+	* ksrc/drivers/can/mscan/rtcan_mscan.c (rtcan_mscan_interrupt),
+	ksrc/drivers/can/mscan/rtcan_mscan_regs.h: Restrict MSCAN TX hardware
+	buffer usage to one for the sake of real-time. Fix bug with TX IRQ
+	handling. Copy timestamp also for error messages.
+
+	* ksrc/drivers/can/sja1000/rtcan_sja1000.c (rtcan_sja_interrupt):
+	Copy timestamp also for error messages.
+
 2006-10-27  Jan Kiszka  <jan.kiszka@domain.hid>
 
 	* ksrc/nucleus/pod.c (xnpod_set_thread_periodic): Fix LART in
Index: ksrc/drivers/can/mscan/rtcan_mscan.c
===================================================================
--- ksrc/drivers/can/mscan/rtcan_mscan.c	(revision 1770)
+++ ksrc/drivers/can/mscan/rtcan_mscan.c	(working copy)
@@ -232,7 +232,7 @@
     struct rtcan_skb skb;
     struct rtcan_device *dev;
     struct mscan_regs *regs;
-    u8 t_status, r_status;
+    u8 canrflg;
     int recv_lock_free = 1;
     int ret = RTDM_IRQ_NONE;
 
@@ -242,29 +242,24 @@
 
     rtdm_lock_get(&dev->device_lock);
 
-    t_status = regs->cantflg;
-    r_status = regs->canrflg;
+    canrflg = regs->canrflg;
 
     ret = RTDM_IRQ_HANDLED;
 
     /* Transmit Interrupt? */
-    if ((t_status & MSCAN_TXE)) {
-	/* Disable transmit interrupt here or it will
-	 * constantly be pending.
-	 */
-	regs->cantier &= ~MSCAN_TXIE;
-
+    if ((regs->cantier & MSCAN_TXIE0) && (regs->cantflg & MSCAN_TXE0)) {
+	regs->cantier = 0;
 	/* Wake up a sender */
 	rtdm_sem_up(&dev->tx_sem);
     }
 
     /* Wakeup interrupt?  */
-    if ((r_status & MSCAN_WUPIF)) {
+    if ((canrflg & MSCAN_WUPIF)) {
 	rtdm_printk("WUPIF interrupt\n");
     }
 
     /* Receive Interrupt? */
-    if ((r_status & MSCAN_RXF)) {
+    if ((canrflg & MSCAN_RXF)) {
 	
 	/* Read out HW registers */
 	rtcan_mscan_rx_interrupt(dev, &skb);
@@ -289,10 +284,13 @@
     }
 
     /* Error Interrupt? */
-    if ((r_status & (MSCAN_CSCIF | MSCAN_OVRIF))) {
+    if ((canrflg & (MSCAN_CSCIF | MSCAN_OVRIF))) {
 	/* Check error condition and fill error frame */
-	rtcan_mscan_err_interrupt(dev, &skb, r_status);
+	rtcan_mscan_err_interrupt(dev, &skb, canrflg);
 
+	memcpy((void *)&skb.rb_frame + skb.rb_frame_size,
+	       &timestamp, TIMESTAMP_SIZE);
+
 	if (recv_lock_free) {
 	    recv_lock_free = 0;
 	    rtdm_lock_get(&rtcan_recv_list_lock);
@@ -306,8 +304,8 @@
     /* Acknowledge the handled interrupt within the controller.
      * Only do so for the receiver interrupts.
      */
-    if (r_status)
-	regs->canrflg = r_status;
+    if (canrflg)
+	regs->canrflg = canrflg;
 
     if (!recv_lock_free) {
         rtdm_lock_put(&rtcan_socket_lock);
@@ -422,8 +420,8 @@
     case CAN_STATE_STOPPED:
 	/* Set error active state */
 	state = CAN_STATE_ACTIVE;
-	/* Set up sender "mutex", we have three TX buffer in HW */
-	rtdm_sem_init(&dev->tx_sem, MSCAN_TX_BUFS);
+	/* Set up sender "mutex" */
+	rtdm_sem_init(&dev->tx_sem, 1);
 
 	if ((dev->ctrl_mode & CAN_CTRLMODE_LISTENONLY)) {
 	    regs->canctl1 |= MSCAN_LISTEN;
@@ -458,7 +456,7 @@
 	/* Trigger bus-off recovery */
 	regs->canrier = MSCAN_RIER;
 	/* Set up sender "mutex" */
-	rtdm_sem_init(&dev->tx_sem, MSCAN_TX_BUFS);
+	rtdm_sem_init(&dev->tx_sem, 1);
 	/* Set error active state */
 	state = CAN_STATE_ACTIVE;
 
@@ -595,7 +593,7 @@
 static int rtcan_mscan_start_xmit(struct rtcan_device *dev,
 				  can_frame_t *frame)
 {
-    int             i, id, buf;
+    int             i, id;
     /* "Real" size of the payload */
     unsigned char   size;
     /* Content of frame information register */
@@ -603,18 +601,13 @@
 
     struct mscan_regs *regs = (struct mscan_regs *)dev->base_addr;
 
-    /* Find an empty TX buffer. */
-    for (buf = 0; buf < MSCAN_TX_BUFS; buf++) {
-	if ((regs->cantflg & (1 << buf)))
-	    break;
-    }
-    if (buf == MSCAN_TX_BUFS) {
-	/* No buffer is available. */
-	rtdm_printk("rtcan_mscan_start_xmit: no TX buffer availabe");
+    /* Is TX buffer empty? */
+    if (!(regs->cantflg & MSCAN_TXE0)) {
+	rtdm_printk("rtcan_mscan_start_xmit: TX buffer not empty");
 	return -EIO;
     }
     /* Select the buffer we've found. */
-    regs->cantbsel = 1 << buf;
+    regs->cantbsel = MSCAN_TXE0;
 
     /* Get DLC and ID */
     dlc = frame->can_dlc;
@@ -663,10 +656,10 @@
     regs->cantxfg.tbpr = 0;	/* all messages have the same prio */
 
     /* Trigger transmission. */
-    regs->cantflg = (1 << buf);
-    
+    regs->cantflg = MSCAN_TXE0;
+
     /* Enable interrupt. */
-    regs->cantier |= (1 << buf);
+    regs->cantier |= MSCAN_TXIE0;
 
     return 0;
 }
@@ -742,7 +735,6 @@
     int ret, irq;
     unsigned long addr;
     struct rtcan_device *dev;
-    struct rtcan_priv *priv;
     struct mscan_regs *regs;
 
     switch (port[idx]) {
@@ -767,7 +759,6 @@
 
     dev->can_sys_clock = mscan_clock;
 
-    priv = dev->priv;
     dev->base_addr = addr;
     regs = (struct mscan_regs *)dev->base_addr;
     
Index: ksrc/drivers/can/mscan/rtcan_mscan_regs.h
===================================================================
--- ksrc/drivers/can/mscan/rtcan_mscan_regs.h	(revision 1770)
+++ ksrc/drivers/can/mscan/rtcan_mscan_regs.h	(working copy)
@@ -182,7 +182,6 @@
 #define MSCAN_BUF_STD_RTR       0x10
 #define MSCAN_BUF_EXT_RTR       0x01
 #define MSCAN_BUF_EXTENDED      0x08
-#define MSCAN_TX_BUFS           3
 
 #define MSCAN_IDAM1	0x20
 /* Value for the interrupt enable register */
Index: ksrc/drivers/can/sja1000/rtcan_sja1000.c
===================================================================
--- ksrc/drivers/can/sja1000/rtcan_sja1000.c	(revision 1770)
+++ ksrc/drivers/can/sja1000/rtcan_sja1000.c	(working copy)
@@ -299,6 +299,9 @@
 	    /* Check error condition and fill error frame */
 	    rtcan_sja_err_interrupt(dev, chip, &skb, irq_source);
 
+            memcpy((void *)&skb.rb_frame + skb.rb_frame_size,
+		   &timestamp, TIMESTAMP_SIZE);
+
 	    if (recv_lock_free) {
 		recv_lock_free = 0;
 		rtdm_lock_get(&rtcan_recv_list_lock);

--------------000109000306070306080204--

