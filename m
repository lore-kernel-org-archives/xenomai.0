Message-ID: <4559DA0E.7060406@domain.hid>
Date: Tue, 14 Nov 2006 16:00:30 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] RT-Socket-CAN, TX loopback and further
	improvements
References: <4559D38C.2080001@domain.hid>
In-Reply-To: <4559D38C.2080001@domain.hid>
Content-Type: multipart/mixed; boundary="------------000108050806010708030208"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------000108050806010708030208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Attached is the missing patch!

Wolfgang Grandegger wrote:
> Hi Jan,
> 
> attached is a patch implementing the TX loopback, apart from some other 
> fixes and improvements. The TX loopback to foreign local sockets allows 
> to have a net-alike behavior of the CAN bus. Local sockets listening to 
> a device can receive TX messages as well. As discussed, the TX lookback 
> is performed when TX is done (TX done interrupt). As I still think that 
> it will not be used very often, I made it a configurable kernel option. 
> When it's selected, it's _on_ by default and it can be switched off or 
> on again with setsockopt() (to make the Linux Socket-CAN people happy). 
> As long as it's not enabled, it adds little overhead to the driver. If 
> you have no objections I will check it in.
> 
> Here is the ChangeLog entry:
> 
> 2006-11-14  Wolfgang Grandegger  <wg@domain.hid>
> 
>         * ksrc/drivers/can/rtcan_dev.h,
>         ksrc/drivers/can/rtcan_socket.h,
>         ksrc/drivers/can/rtcan_socket.c,
>         ksrc/drivers/can/rtcan_raw.c,
>         ksrc/drivers/can/rtcan_modules.c,
>         ksrc/drivers/can/sja1000/rtcan_sja1000.c,
>         ksrc/drivers/can/mscan/rtcan_mscan.c,
>         ksrc/drivers/can/Kconfig,
>         ksrc/drivers/can/Config.in,
>         src/utils/can/rtcansend.c,
>         include/rtdm/rtcan.h,: Add feature TX loopback to local sockets.
> 
>         * ksrc/drivers/can/rtcan_raw.c, include/rtdm/rtcan.h:
>         Remove locks for the setting and reading of the RX and TX
>         timeout values and add a warning to the documentation.
> 
>         * src/utils/rtcansend.c: use sendto() by default to avoid
>         binding a default filter and add option "-s" for using bind()
>         and send().
> 
>         * src/utils/rtcanrecv.c: add option "-R" for relative
>         timestamps.
> 
>         * ksrc/drivers/can/rtcan_internal.h: use now RTCAN_ASSERT macros
>         when CONFIG_XENO_DRIVERS_RTCAN_DEBUG is set.
> 
>         * ksrc/drivers/can/mscan/Kconfig,
>         ksrc/drivers/can/sja1000/Kconfig,
>         ksrc/drivers/can/Kconfig: add more help for kernel parameters.
> 
> Thanks.
> 
> Wolfgang.
> 
> 
> 
> 
> 
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 
> 


--------------000108050806010708030208
Content-Type: text/x-patch;
 name="xenomai-rtcan-loopback.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-rtcan-loopback.patch"

Index: include/rtdm/rtcan.h
===================================================================
--- include/rtdm/rtcan.h	(revision 1834)
+++ include/rtdm/rtcan.h	(working copy)
@@ -120,6 +120,7 @@
  * - Level @b SOL_CAN_RAW : CAN RAW protocol (see @ref CAN_PROTO_RAW)
  *   - Option @ref CAN_RAW_FILTER : CAN filter list
  *   - Option @ref CAN_RAW_ERR_FILTER : CAN error mask
+ *   - Option @ref CAN_RAW_TX_LOOPBACK : CAN TX loopback to local sockets
  *   .
  * .
  * @n
@@ -543,11 +544,9 @@
  * - -EFAULT (It was not possible to access user space memory area at the
  *            specified address.)
  * - -ENOMEM (Not enough memory to fulfill the operation)
- * - -EINVAL (Invalid address family, or invalid length of address structure)
- * - -ENODEV (Invalid CAN interface index)
- * - -EBADF  (Socket is about to be closed)
- * - -EAGAIN (Too many receivers. Old binding (if any) is still active.
- *            Close some sockets and try again.)
+ * - -EINVAL (Invalid length "optlen")
+ * - -ENOSPC (No space to store filter list, check RT-Socket-CAN kernel
+ *            parameters)
  * .
  */
 #define CAN_RAW_FILTER      0x1
@@ -577,16 +576,39 @@
  * Specific return values:
  * - -EFAULT (It was not possible to access user space memory area at the
  *            specified address.)
- * - -ENOMEM (Not enough memory to fulfill the operation)
- * - -EINVAL (Invalid address family, or invalid length of address structure)
- * - -ENODEV (Invalid CAN interface index)
- * - -EBADF  (Socket is about to be closed)
- * - -EAGAIN (Too many receivers. Old binding (if any) is still active.
- *            Close some sockets and try again.)
+ * - -EINVAL (Invalid length "optlen")
  * .
  */
 #define CAN_RAW_ERR_FILTER  0x2
 
+/**
+ * CAN TX loopback
+ *
+ * The TX loopback to other local sockets can be selected with this
+ * @c setsockopt.
+ *
+ * @note The TX loopback feature must be enabled in the kernel and then
+ * the loopback to other local TX sockets is enabled by default.
+ *
+ * @n
+ * @param [in] level @b SOL_CAN_RAW
+ *
+ * @param [in] optname @b CAN_RAW_TX_LOOPBACK
+ *
+ * @param [in] optval Pointer to integer value.
+ *
+ * @param [in] optlen Size of int: sizeof(int).
+ *
+ * Environments: non-RT (RT optional)@n
+ * @n
+ * Specific return values:
+ * - -EFAULT (It was not possible to access user space memory area at the
+ *            specified address.)
+ * - -EINVAL (Invalid length "optlen")
+ * - -EOPNOTSUPP (not supported, check RT-Socket-CAN kernel parameters).
+ */
+#define CAN_RAW_TX_LOOPBACK  0x3
+
 /** @} */
 
 /*!
@@ -933,6 +955,9 @@
  *
  * The default value for a newly created socket is an infinite timeout.
  *
+ * @note The setting of the timeout value is not done atomically to avoid
+ * locks. Please set the value before receiving messages from the socket.
+ *
  * @param [in] arg Pointer to @ref nanosecs_rel_t variable. The value is
  *                interpreted as relative timeout in nanoseconds in case
  *                of a positive value.
@@ -963,6 +988,9 @@
  *
  * The default value for a newly created socket is an infinite timeout.
  *
+ * @note The setting of the timeout value is not done atomically to avoid
+ * locks. Please set the value before sending messages to the socket.
+ *
  * @param [in] arg Pointer to @ref nanosecs_rel_t variable. The value is
  *                interpreted as relative timeout in nanoseconds in case
  *                of a positive value.
Index: ChangeLog
===================================================================
--- ChangeLog	(revision 1834)
+++ ChangeLog	(working copy)
@@ -1,3 +1,32 @@
+2006-11-14  Wolfgang Grandegger  <wg@domain.hid>
+
+	* ksrc/drivers/can/rtcan_dev.h,
+	ksrc/drivers/can/rtcan_socket.h,
+	ksrc/drivers/can/rtcan_socket.c,
+	ksrc/drivers/can/rtcan_raw.c,
+	ksrc/drivers/can/rtcan_modules.c,
+	ksrc/drivers/can/sja1000/rtcan_sja1000.c,
+	ksrc/drivers/can/mscan/rtcan_mscan.c,
+	ksrc/drivers/can/Kconfig,
+	ksrc/drivers/can/Config.in,
+	src/utils/can/rtcansend.c,
+	include/rtdm/rtcan.h,: Add feature TX loopback to local sockets.
+
+	* ksrc/drivers/can/rtcan_raw.c, include/rtdm/rtcan.h:
+	Remove locks for the setting and reading of the RX and TX timeout
+	values and add a warning to the documentation.
+
+	* src/utils/rtcansend.c: use sendto() by default to avoid binding
+	a default filter and add option "-s" for using bind() and send().
+
+	* src/utils/rtcanrecv.c: add option "-R" for relative timestamps.
+
+	* ksrc/drivers/can/rtcan_internal.h: use now RTCAN_ASSERT macros
+	when CONFIG_XENO_DRIVERS_RTCAN_DEBUG is set.
+
+	* ksrc/drivers/can/mscan/Kconfig, ksrc/drivers/can/sja1000/Kconfig,
+	ksrc/drivers/can/Kconfig: add more help for kernel parameters.
+
 2006-11-12  Philippe Gerum  <rpm@xenomai.org>
 
 	* ksrc/nucleus/heap.c (xnheap_extend): Account for new extents
Index: src/utils/can/rtcansend.c
===================================================================
--- src/utils/can/rtcansend.c	(revision 1834)
+++ src/utils/can/rtcansend.c	(working copy)
@@ -26,7 +26,9 @@
 	    " -l  --loop=COUNT      send message COUNT times\n"
 	    " -c, --count           message count in data[0-3]\n"
 	    " -d, --delay=MS        delay in ms (default = 1ms)\n"
+	    " -s, --send            use send instead of sendto\n"
 	    " -t, --timeout=MS      timeout in ms\n"
+	    " -T, --tx-loopback=0|1 switch TX loopback off or on\n"
 	    " -v, --verbose         be verbose\n"
 	    " -p, --print=MODULO    print every MODULO message\n"
 	    " -h, --help            this help\n",
@@ -37,9 +39,10 @@
 RT_TASK rt_task_desc;
 
 static int s=-1, dlc=0, rtr=0, extended=0, verbose=0, loops=1, delay=1000000;
-static int count=0, print=1;
+static int count=0, print=1, use_send=0, tx_loopback=-1;
 static nanosecs_rel_t timeout = 0;
 static struct can_frame frame;
+static struct sockaddr_can to_addr;
 
 
 void cleanup(void)
@@ -77,16 +80,21 @@
         rt_task_sleep(delay);
 	if (count)
 	    memcpy(&frame.data[0], &i, sizeof(i));
-        ret = rt_dev_send(s, (void *)&frame, sizeof(can_frame_t), 0);
+	/* Note: sendto avoids the definiton of a receive filter list */ 
+	if (use_send)
+	    ret = rt_dev_send(s, (void *)&frame, sizeof(can_frame_t), 0);
+	else
+	    ret = rt_dev_sendto(s, (void *)&frame, sizeof(can_frame_t), 0,
+				(struct sockaddr *)&to_addr, sizeof(to_addr));
 	if (ret < 0) {
 	    switch (ret) {
 	    case -ETIMEDOUT:
 		if (verbose)
-		    printf("rt_dev_send: timed out");
+		    printf("rt_dev_send(to): timed out");
 		break;
 	    case -EBADF:
 		if (verbose)
-		    printf("rt_dev_send: aborted because socket was closed");
+		    printf("rt_dev_send(to): aborted because socket was closed");
 		break;
 	    default:
 		fprintf(stderr, "rt_dev_send: %s\n", strerror(-ret));
@@ -111,7 +119,6 @@
 
 int main(int argc, char **argv)
 {
-    struct sockaddr_can addr;
     int i, opt, ret;
     struct ifreq ifr;
     char name[32];
@@ -126,7 +133,9 @@
 	{ "print", required_argument, 0, 'p'},
 	{ "loop", required_argument, 0, 'l'},
 	{ "delay", required_argument, 0, 'd'},
+	{ "send", no_argument, 0, 's'},
 	{ "timeout", required_argument, 0, 't'},
+	{ "tx-loopbcak", required_argument, 0, 'T'},
 	{ 0, 0, 0, 0},
     };
 
@@ -137,7 +146,7 @@
 
     frame.can_id = 1;
 
-    while ((opt = getopt_long(argc, argv, "hvi:l:red:t:cp:",
+    while ((opt = getopt_long(argc, argv, "hvi:l:red:t:cp:sT:",
 			      long_options, NULL)) != -1) {
 	switch (opt) {
 	case 'h':
@@ -175,10 +184,18 @@
 	    delay = strtoul(optarg, NULL, 0) * 1000000;
 	    break;
 
+	case 's':
+	    use_send = 1;
+	    break;
+
 	case 't':
 	    timeout = strtoul(optarg, NULL, 0) * 1000000;
 	    break;
 
+	case 'T':
+	    tx_loopback = strtoul(optarg, NULL, 0);
+	    break;
+
 	default:
 	    fprintf(stderr, "Unknown option %c\n", opt);
 	    break;
@@ -205,6 +222,17 @@
     }
     s = ret;
 
+    if (tx_loopback >= 0) {
+	ret = rt_dev_setsockopt(s, SOL_CAN_RAW, CAN_RAW_TX_LOOPBACK,
+				&tx_loopback, sizeof(tx_loopback));
+	if (ret < 0) {
+	    fprintf(stderr, "rt_dev_setsockopt: %s\n", strerror(-ret));
+	    goto failure;
+	}
+	if (verbose)
+	    printf("Using tx_loopback=%d\n", tx_loopback);
+    }
+
     strncpy(ifr.ifr_name, argv[optind], IFNAMSIZ);
     if (verbose)
 	printf("s=%d, ifr_name=%s\n", s, ifr.ifr_name);
@@ -215,13 +243,15 @@
 	goto failure;
     }
 
-    memset(&addr, 0, sizeof(addr));
-    addr.can_ifindex = ifr.ifr_ifindex;
-    addr.can_family = AF_CAN;
-    ret = rt_dev_bind(s, (struct sockaddr *)&addr, sizeof(addr));
-    if (ret < 0) {
-	fprintf(stderr, "rt_dev_bind: %s\n", strerror(-ret));
-	goto failure;
+    memset(&to_addr, 0, sizeof(to_addr));
+    to_addr.can_ifindex = ifr.ifr_ifindex;
+    to_addr.can_family = AF_CAN;
+    if (use_send) {
+	ret = rt_dev_bind(s, (struct sockaddr *)&to_addr, sizeof(to_addr));
+	if (ret < 0) {
+	    fprintf(stderr, "rt_dev_bind: %s\n", strerror(-ret));
+	    goto failure;
+	}
     }
 
     if (count)
Index: src/utils/can/rtcanrecv.c
===================================================================
--- src/utils/can/rtcanrecv.c	(revision 1834)
+++ src/utils/can/rtcanrecv.c	(working copy)
@@ -20,7 +20,8 @@
 	    " -f  --filter=id:mask[:id:mask]... apply filter\n"
 	    " -e  --error=mask      receive error messages\n"
 	    " -t, --timeout=MS      timeout in ms\n"
-	    " -T, --timestamp       with timestamp\n"
+	    " -T, --timestamp       with absolute timestamp\n"
+	    " -R, --timestamp-rel   with relative timestamp\n"
 	    " -v, --verbose         be verbose\n"
 	    " -p, --print=MODULO    print every MODULO message\n"
 	    " -h, --help            this help\n",
@@ -31,7 +32,7 @@
 extern int optind, opterr, optopt;
 
 static int s = -1, verbose = 0, print = 1;
-static nanosecs_rel_t timeout = 0, with_timestamp = 0;
+static nanosecs_rel_t timeout = 0, with_timestamp = 0, timestamp_rel = 0;
 
 RT_TASK rt_task_desc;
 
@@ -87,7 +88,7 @@
     socklen_t addrlen = sizeof(addr);
     struct msghdr msg;
     struct iovec iov;
-    nanosecs_abs_t timestamp;
+    nanosecs_abs_t timestamp, timestamp_prev = 0;
 
     if (with_timestamp) {
 	msg.msg_iov = &iov;
@@ -124,8 +125,13 @@
 
 	if (print && (count % print) == 0) {
 	    printf("#%d: (%d) ", count, addr.can_ifindex);
-	    if (with_timestamp && msg.msg_controllen)
-		printf("%lldns ", timestamp);
+	    if (with_timestamp && msg.msg_controllen) {
+		if (timestamp_rel) {
+		    printf("%lldns ", timestamp - timestamp_prev);
+		    timestamp_prev = timestamp;
+		} else
+		    printf("%lldns ", timestamp);
+	    }
 	    if (frame.can_id & CAN_ERR_FLAG)
 		printf("!0x%08x!", frame.can_id & CAN_ERR_MASK);
 	    else if (frame.can_id & CAN_EFF_FLAG)
@@ -168,6 +174,7 @@
 	{ "error", required_argument, 0, 'e'},
 	{ "timeout", required_argument, 0, 't'},
 	{ "timestamp", no_argument, 0, 'T'},
+	{ "timestamp-rel", no_argument, 0, 'R'},
 	{ 0, 0, 0, 0},
     };
 
@@ -176,7 +183,7 @@
     signal(SIGTERM, cleanup_and_exit);
     signal(SIGINT, cleanup_and_exit);
 
-    while ((opt = getopt_long(argc, argv, "hve:f:t:p:T",
+    while ((opt = getopt_long(argc, argv, "hve:f:t:p:RT",
 			      long_options, NULL)) != -1) {
 	switch (opt) {
 	case 'h':
@@ -217,6 +224,8 @@
 	    timeout = (nanosecs_rel_t)strtoul(optarg, NULL, 0) * 1000000;
 	    break;
 
+	case 'R':
+	    timestamp_rel = 1;
 	case 'T':
 	    with_timestamp = 1;
 	    break;
@@ -242,11 +251,11 @@
     } else {
 	if (verbose)
 	    printf("interface %s\n", argv[optind]);
-	
+
 	strncpy(ifr.ifr_name, argv[optind], IFNAMSIZ);
 	if (verbose)
 	    printf("s=%d, ifr_name=%s\n", s, ifr.ifr_name);
-	
+
 	ret = rt_dev_ioctl(s, SIOCGIFINDEX, &ifr);
 	if (ret < 0) {
 	    fprintf(stderr, "rt_dev_ioctl GET_IFINDEX: %s\n", strerror(-ret));
Index: ksrc/drivers/can/Kconfig
===================================================================
--- ksrc/drivers/can/Kconfig	(revision 1834)
+++ ksrc/drivers/can/Kconfig	(working copy)
@@ -1,35 +1,62 @@
 menu "CAN drivers"
 
 config XENO_DRIVERS_RTCAN
-       depends on XENO_SKIN_RTDM
-       tristate "RT-Socket-CAN, CAN raw socket interface"
-       help
-       RT-Socket-CAN is a real-time socket interface for CAN controllers.
+	depends on XENO_SKIN_RTDM
+	tristate "RT-Socket-CAN, CAN raw socket interface"
+	help
+	RT-Socket-CAN is a real-time socket interface for CAN controllers.
 
 config XENO_DRIVERS_RTCAN_DEBUG
-       depends on XENO_DRIVERS_RTCAN
-       bool "Enable debug output"
-       default y
+	depends on XENO_DRIVERS_RTCAN
+	bool "Enable debug output"
+	default y
+	help
 
+	This option activates debugging checks and enhanced output for the
+	RT-Socket-CAN driver. It also allows to list the hardware registers
+	of the registered CAN controllers. It is a recommended option for
+	getting started and analysing potential problems. For production
+	purposes, it should be switched off (for the sake of latency).
+
+config XENO_DRIVERS_RTCAN_TX_LOOPBACK
+	depends on XENO_DRIVERS_RTCAN
+	bool "Enable TX loopback to local sockets"
+	default n
+	help
+
+	This options adds support for TX loopback to local sockets. Normally,
+	messages sent to the CAN bus are not visible to sockets listening to
+	the same local device. When this option is enabled, TX messages are
+	looped back locally when the transmit has been done by default. This
+	behaviour can be deactivated or reactivated with "setsockopt". Enable
+	this option, if you want to have a "net-alike" behaviour.
+
 config XENO_DRIVERS_RTCAN_RXBUF_SIZE
-       depends on XENO_DRIVERS_RTCAN
-       int "Size of receive ring buffers (must be 2^N)"
-       default 1024
+	depends on XENO_DRIVERS_RTCAN
+	int "Size of receive ring buffers (must be 2^N)"
+	default 1024
 
 config XENO_DRIVERS_RTCAN_MAX_DEVICES
-       depends on XENO_DRIVERS_RTCAN
-       int "Maximum number of devices"
-       default 4
+	depends on XENO_DRIVERS_RTCAN
+	int "Maximum number of devices"
+	default 4
 
 config XENO_DRIVERS_RTCAN_MAX_RECEIVERS
-       depends on XENO_DRIVERS_RTCAN
-       int "Maximum number of receive filters per device"
-       default 16
+	depends on XENO_DRIVERS_RTCAN
+	int "Maximum number of receive filters per device"
+	default 16
+	help
 
+	The driver maintains a receive filter list per device for fast access.
+
 config XENO_DRIVERS_RTCAN_VIRT
 	depends on XENO_DRIVERS_RTCAN
 	tristate "Virtual CAN bus driver"
+	help
 
+	This driver provides two CAN ports that are virtually interconnected.
+	More ports can be enabled with the module parameter "devices".
+
 source drivers/xenomai/can/mscan/Kconfig
 source drivers/xenomai/can/sja1000/Kconfig
 
Index: ksrc/drivers/can/rtcan_internal.h
===================================================================
--- ksrc/drivers/can/rtcan_internal.h	(revision 1834)
+++ ksrc/drivers/can/rtcan_internal.h	(working copy)
@@ -34,10 +34,9 @@
 #define LIST_POISON1  ((void *) 0x0)
 #endif
 
-#ifdef CONFIG_RTCAN_CHECKED
+#ifdef CONFIG_XENO_DRIVERS_RTCAN_DEBUG
 #define RTCAN_ASSERT(expr, func) \
-    if (!(expr)) \
-    { \
+    if (!(expr)) { \
         rtdm_printk("Assertion failed! %s:%s:%d %s\n", \
         __FILE__, __FUNCTION__, __LINE__, (#expr)); \
         func \
Index: ksrc/drivers/can/rtcan_dev.h
===================================================================
--- ksrc/drivers/can/rtcan_dev.h	(revision 1834)
+++ ksrc/drivers/can/rtcan_dev.h	(working copy)
@@ -141,7 +141,11 @@
 
 #ifdef CONFIG_PROC_FS
     struct proc_dir_entry *proc_root;
-#endif    
+#endif
+#ifdef CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK
+    struct rtcan_skb tx_skb;
+    struct rtcan_socket *tx_socket;
+#endif /* CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK */
 };
 
 
Index: ksrc/drivers/can/rtcan_module.c
===================================================================
--- ksrc/drivers/can/rtcan_module.c	(revision 1834)
+++ ksrc/drivers/can/rtcan_module.c	(working copy)
@@ -176,7 +176,11 @@
      *  0 rtcan0               1 0x00010 1234567890 1234567890 1234567890
      */
     if (!RTCAN_PROC_PRINT("fd Name___________ Filter ErrMask "
-			  "RX_Timeout_ns TX_Timeout_ns RX_BufFull\n"))
+			  "RX_Timeout_ns TX_Timeout_ns RX_BufFull") ||
+#ifdef CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK
+	!RTCAN_PROC_PRINT(" TX_Loopback") ||
+#endif
+	!RTCAN_PROC_PRINT("\n"))
         goto done;
 
     rtdm_lock_get_irqsave(&rtcan_recv_list_lock, lock_ctx);
@@ -196,10 +200,14 @@
 	}
 	rtcan_get_timeout_name(sock->tx_timeout, tx_timeout, 20);
 	rtcan_get_timeout_name(sock->rx_timeout, rx_timeout, 20);
-	if(!RTCAN_PROC_PRINT("%2d %-15s %6d 0x%05x %13s %13s %10d\n", 
-			     context->fd, name, sock->flistlen,
-			     sock->err_mask, rx_timeout, tx_timeout,
-			     sock->rx_buf_full))
+	if (!RTCAN_PROC_PRINT("%2d %-15s %6d 0x%05x %13s %13s %10d",
+			      context->fd, name, sock->flistlen,
+			      sock->err_mask, rx_timeout, tx_timeout,
+			      sock->rx_buf_full) ||
+#ifdef CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK
+	    !RTCAN_PROC_PRINT(" %11d", sock->tx_loopback) ||
+#endif
+	    !RTCAN_PROC_PRINT("\n"))
 	    break;
     }
 
Index: ksrc/drivers/can/rtcan_socket.c
===================================================================
--- ksrc/drivers/can/rtcan_socket.c	(revision 1834)
+++ ksrc/drivers/can/rtcan_socket.c	(working copy)
@@ -48,6 +48,9 @@
     sock->flist = NULL;
     sock->err_mask = 0;
     sock->rx_buf_full = 0;
+#ifdef CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK
+    sock->tx_loopback = 1;
+#endif
 
     sock->tx_timeout = RTDM_TIMEOUT_INFINITE;
     sock->rx_timeout = RTDM_TIMEOUT_INFINITE;
Index: ksrc/drivers/can/rtcan_raw.c
===================================================================
--- ksrc/drivers/can/rtcan_raw.c	(revision 1834)
+++ ksrc/drivers/can/rtcan_raw.c	(working copy)
@@ -68,7 +68,7 @@
 }
 
 
-static inline void rtcan_rcv_deliver(struct rtcan_recv *recv_listener, 
+static void rtcan_rcv_deliver(struct rtcan_recv *recv_listener, 
 				     struct rtcan_skb *skb)
 {
     int size_free;
@@ -152,7 +152,50 @@
     }
 }
 
+#ifdef CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK
 
+static void rtcan_tx_push(struct rtcan_device *dev, struct rtcan_socket *sock,
+			  can_frame_t *frame)
+{
+    struct rtcan_rb_frame *rb_frame = &dev->tx_skb.rb_frame;
+
+    RTCAN_ASSERT(dev->tx_socket == 0,
+		 rtdm_printk("(%d) TX skb still in use", dev->ifindex););
+
+    rb_frame->can_id = frame->can_id;
+    rb_frame->can_dlc = frame->can_dlc;
+    dev->tx_skb.rb_frame_size = EMPTY_RB_FRAME_SIZE;
+    if (frame->can_dlc && !(frame->can_id & CAN_RTR_FLAG)) {
+	memcpy(rb_frame->data, frame->data, frame->can_dlc);
+	dev->tx_skb.rb_frame_size += frame->can_dlc;
+    }
+    rb_frame->can_ifindex = dev->ifindex;
+    dev->tx_socket = sock;
+}
+
+void rtcan_tx_loopback(struct rtcan_device *dev)
+{
+    /* Entry in reception list, begin with head */
+    struct rtcan_recv *recv_listener = dev->recv_list;
+    struct rtcan_rb_frame *frame = &dev->tx_skb.rb_frame;
+
+    while (recv_listener != NULL) {
+	dev->rx_count++;
+	if ((dev->tx_socket != recv_listener->sock) &&
+	    rtcan_accept_msg(frame->can_id, &recv_listener->can_filter)) {
+	    recv_listener->match_count++;
+	    rtcan_rcv_deliver(recv_listener, &dev->tx_skb);
+	}
+	recv_listener = recv_listener->next;
+    }
+    dev->tx_socket = NULL;
+}
+
+EXPORT_SYMBOL(rtcan_tx_loopback);
+
+#endif /* CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK */
+
+
 int rtcan_raw_socket(struct rtdm_dev_context *context,
 		     rtdm_user_info_t *user_info, int protocol)
 {
@@ -252,7 +295,7 @@
     rtdm_lockctx_t lock_ctx;
     can_err_mask_t err_mask;
     int flistlen;
-    int ret = 0;
+    int val, ret = 0;
 
     if (so->level != SOL_CAN_RAW)
         return -ENOPROTOOPT;
@@ -304,7 +347,7 @@
 	break;
 
     case CAN_RAW_ERR_FILTER:
-	
+
 	if (so->optlen != sizeof(can_err_mask_t))
 	    return -EINVAL;
 
@@ -321,11 +364,31 @@
 	rtdm_lock_put_irqrestore(&rtcan_recv_list_lock, lock_ctx);
 
 	break;
-	
+
+    case CAN_RAW_TX_LOOPBACK:
+
+	if (so->optlen != sizeof(int))
+	    return -EINVAL;
+
+	if (user_info) {
+	    if (!rtdm_read_user_ok(user_info, so->optval, so->optlen) ||
+		rtdm_copy_from_user(user_info, &val, so->optval, so->optlen))
+		return -EFAULT;
+	} else
+	    memcpy(&val, so->optval, so->optlen);
+
+#ifdef CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK
+	sock->tx_loopback = val;
+#else
+	if (val)
+	    return -EOPNOTSUPP;
+#endif
+	break;
+
     default:
 	ret = -ENOPROTOOPT;
     }
-    
+
     return ret;
 }
 
@@ -334,7 +397,6 @@
 		    rtdm_user_info_t *user_info, int request, void *arg)
 {
     int ret = 0;
-    rtdm_lockctx_t lock_ctx;
 
     switch (request) {
     case _RTIOC_BIND: {
@@ -422,20 +484,11 @@
 	}
 
 	/* Now the differences begin between the requests. */
-	if (request == RTCAN_RTIOC_RCV_TIMEOUT) {
-	    rtdm_lock_get_irqsave(&rtcan_socket_lock, lock_ctx);
-
+	if (request == RTCAN_RTIOC_RCV_TIMEOUT)
 	    sock->rx_timeout = *timeout;
-
-	    rtdm_lock_put_irqrestore(&rtcan_socket_lock, lock_ctx);
-	} else {
-	    rtdm_lock_get_irqsave(&rtcan_socket_lock, lock_ctx);
-
+	else
 	    sock->tx_timeout = *timeout;
 
-	    rtdm_lock_put_irqrestore(&rtcan_socket_lock, lock_ctx);
-	}
-
 	break;
     }
 
@@ -554,13 +607,8 @@
 
 
     /* Set RX timeout */
-    rtdm_lock_get_irqsave(&rtcan_socket_lock, lock_ctx);
-
     timeout = (flags & MSG_DONTWAIT) ? RTDM_TIMEOUT_NONE : sock->rx_timeout;
 
-    rtdm_lock_put_irqrestore(&rtcan_socket_lock, lock_ctx);
-
-
     /* Fetch message (ok, try it ...) */
     ret = rtdm_sem_timeddown(&sock->recv_sem, timeout, NULL);
 
@@ -836,14 +884,9 @@
 
     if ((dev = rtcan_dev_get_by_index(ifindex)) == NULL)
         return -ENXIO;
-   
-    rtdm_lock_get_irqsave(&rtcan_socket_lock, lock_ctx);
 
     timeout = (flags & MSG_DONTWAIT) ? RTDM_TIMEOUT_NONE : sock->tx_timeout;
 
-    rtdm_lock_put_irqrestore(&rtcan_socket_lock, lock_ctx);
-
-
     tx_wait.rt_task = rtdm_task_current();
 
     /* If socket was not closed recently, register the task at the
@@ -894,6 +937,12 @@
     /* We got access */
 
 
+#ifdef CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK
+    /* Push message onto stack for loopback when TX done */
+    if (sock->tx_loopback)
+	rtcan_tx_push(dev, sock, frame);
+#endif /* CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK */
+
     rtdm_lock_get_irqsave(&dev->device_lock, lock_ctx);
 
     /* Controller should be operating */
@@ -909,7 +958,7 @@
     dev->tx_count++;
     if ((ret = dev->hard_start_xmit(dev, frame)) != 0)
 	goto send_out2;
-    
+
     /* Return number of bytes sent upon successful completion */
     ret = sizeof(can_frame_t);
 
Index: ksrc/drivers/can/mscan/Kconfig
===================================================================
--- ksrc/drivers/can/mscan/Kconfig	(revision 1834)
+++ ksrc/drivers/can/mscan/Kconfig	(working copy)
@@ -1,32 +1,39 @@
 config XENO_DRIVERS_RTCAN_MSCAN
-       depends on XENO_DRIVERS_RTCAN && PPC_MPC52xx
-       tristate "MSCAN driver for MPC52xx"
-       default n
-	
+	depends on XENO_DRIVERS_RTCAN && PPC_MPC52xx
+	tristate "MSCAN driver for MPC52xx"
+	default n
+
 config XENO_DRIVERS_RTCAN_MSCAN_1
-       depends on XENO_DRIVERS_RTCAN_MSCAN
-       bool "Enable CAN 1"
-       default y
-	
+	depends on XENO_DRIVERS_RTCAN_MSCAN
+	bool "Enable CAN 1"
+	default y
+
 config XENO_DRIVERS_RTCAN_MSCAN_2
-       depends on XENO_DRIVERS_RTCAN_MSCAN
-       bool "Enable CAN 2"
-       default y
-	
+	depends on XENO_DRIVERS_RTCAN_MSCAN
+	bool "Enable CAN 2"
+	default y
+
 config XENO_DRIVERS_RTCAN_MSCAN_CLOCK
-       depends on XENO_DRIVERS_RTCAN_MSCAN
-       int "Clock Frequency in Hz"
-       default 66000000        
-       
+	depends on XENO_DRIVERS_RTCAN_MSCAN
+	int "Clock Frequency in Hz"
+	default 66000000
+	help
+
+	The MSCAN driver selects the oscillator clock (SYS_XTAL_IN) as clock
+	source for MSCAN, which is typically 33 MHz. Due to a hardware bug on
+	the MPC5200 Rev. A chips, the IP bus clock (IP_CLK) is used instead,
+	which is typically 66 or 132 MHz.
+
 choice
 	depends on XENO_DRIVERS_RTCAN_MSCAN
 	prompt "Pin Configuration"
 	default I2C1/TMR01
+	help
 
-config 	XENO_DRIVERS_RTCAN_MSCAN_ALT
+config XENO_DRIVERS_RTCAN_MSCAN_ALT
 	bool "CAN 1 on I2C1 pins, CAN 2 on TMR01 pins"
 
-config 	XENO_DRIVERS_RTCAN_MSCAN_PSC2
+config XENO_DRIVERS_RTCAN_MSCAN_PSC2
 	bool "CAN 1 and 2 on PSC2 pins"
 
 endchoice
Index: ksrc/drivers/can/mscan/rtcan_mscan.c
===================================================================
--- ksrc/drivers/can/mscan/rtcan_mscan.c	(revision 1834)
+++ ksrc/drivers/can/mscan/rtcan_mscan.c	(working copy)
@@ -251,6 +251,21 @@
 	regs->cantier = 0;
 	/* Wake up a sender */
 	rtdm_sem_up(&dev->tx_sem);
+
+#ifdef CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK
+	if (dev->tx_socket) {
+	    memcpy((void *)&dev->tx_skb.rb_frame + dev->tx_skb.rb_frame_size,
+		   &timestamp, TIMESTAMP_SIZE);
+
+	    if (recv_lock_free) {
+		recv_lock_free = 0;
+		rtdm_lock_get(&rtcan_recv_list_lock);
+		rtdm_lock_get(&rtcan_socket_lock);
+	    }
+
+	    rtcan_tx_loopback(dev);
+	}
+#endif /* CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK */
     }
 
     /* Wakeup interrupt?  */
Index: ksrc/drivers/can/rtcan_socket.h
===================================================================
--- ksrc/drivers/can/rtcan_socket.h	(revision 1834)
+++ ksrc/drivers/can/rtcan_socket.h	(working copy)
@@ -167,6 +167,10 @@
     uint32_t            rx_buf_full;
 
     struct rtcan_filter_list *flist;
+
+#ifdef CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK
+    int tx_loopback;
+#endif
 };
 
 
Index: ksrc/drivers/can/rtcan_raw.h
===================================================================
--- ksrc/drivers/can/rtcan_raw.h	(revision 1834)
+++ ksrc/drivers/can/rtcan_raw.h	(working copy)
@@ -32,6 +32,10 @@
 
 void rtcan_rcv(struct rtcan_device *rtcandev, struct rtcan_skb *skb);
 
+#ifdef CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK
+void rtcan_tx_loopback(struct rtcan_device *rtcandev);
+#endif /* CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK */
+
 #ifdef CONFIG_PROC_FS
 int __init rtcan_raw_proto_register(void);
 void __exit rtcan_raw_proto_unregister(void);
Index: ksrc/drivers/can/Config.in
===================================================================
--- ksrc/drivers/can/Config.in	(revision 1834)
+++ ksrc/drivers/can/Config.in	(working copy)
@@ -9,6 +9,7 @@
 
 if [ "$CONFIG_XENO_DRIVERS_RTCAN" != "n" ]; then 
    bool 'Enable debug output' CONFIG_XENO_DRIVERS_RTCAN_DEBUG
+   bool 'Enable TX loopback to local sockets' CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK
    int 'Size of receive ring buffers (must be 2^N)' CONFIG_XENO_DRIVERS_RTCAN_RXBUF_SIZE 1024
    int 'Maximum number of devices' CONFIG_XENO_DRIVERS_RTCAN_MAX_DEVICES 4
    int 'Maximum number of receive filters per device' CONFIG_XENO_DRIVERS_RTCAN_MAX_RECEIVERS 16
Index: ksrc/drivers/can/sja1000/Kconfig
===================================================================
--- ksrc/drivers/can/sja1000/Kconfig	(revision 1834)
+++ ksrc/drivers/can/sja1000/Kconfig	(working copy)
@@ -5,7 +5,12 @@
 config XENO_DRIVERS_RTCAN_SJA1000_ISA
 	depends on XENO_DRIVERS_RTCAN_SJA1000
 	tristate "Standard ISA controllers"
+	help
 
+	This driver is for CAN devices connected to the ISA bus of a PC
+	or a PC/104 system. The I/O port, interrupt number and a few other
+	hardware specific parameters can be defined via module parameters.
+
 config XENO_DRIVERS_RTCAN_SJA1000_ISA_MAX_DEV
 	depends on XENO_DRIVERS_RTCAN_SJA1000_ISA
 	int "Maximum number of controllers"
@@ -14,7 +19,12 @@
 config XENO_DRIVERS_RTCAN_SJA1000_MEM
 	depends on XENO_DRIVERS_RTCAN_SJA1000
 	tristate "Memory mapped controllers"
+	help
 
+	This driver is for memory mapped CAN devices. The memory address,
+	interrupt number and a few other hardware specific parameters can
+	be defined via module parameters.
+
 config XENO_DRIVERS_RTCAN_SJA1000_MEM_MAX_DEV
 	depends on XENO_DRIVERS_RTCAN_SJA1000_MEM
 	int "Maximum number of controllers"
@@ -23,7 +33,20 @@
 config XENO_DRIVERS_RTCAN_SJA1000_PEAK_PCI
 	depends on XENO_DRIVERS_RTCAN_SJA1000
 	tristate "PEAK PCI Card"
+	help
 
+	This driver is for the PCAN PCI, the PC-PCI CAN plug-in card (1 or
+	2 channel) from PEAK Systems (http://www.peak-system.com). To get
+	the second channel working, Xenomai's shared interrupt support
+	must be enabled.
+
 config XENO_DRIVERS_RTCAN_SJA1000_PEAK_DNG
 	depends on XENO_DRIVERS_RTCAN_SJA1000
 	tristate "PEAK Parallel Port Dongle"
+	help
+
+	This driver is for the PCAN Dongle, the PC parallel port to CAN
+	converter from PEAK Systems (http://www.peak-system.com). You need
+	to disable parallel port support in the kernel (CONFIG_PARPORT) for
+	proper operation. The interface type (SP or EPP), I/O port and
+	interrupt number should be defined via module parameters.
\ No newline at end of file
Index: ksrc/drivers/can/sja1000/rtcan_sja1000.c
===================================================================
--- ksrc/drivers/can/sja1000/rtcan_sja1000.c	(revision 1834)
+++ ksrc/drivers/can/sja1000/rtcan_sja1000.c	(working copy)
@@ -312,11 +312,27 @@
 	}
 
         /* Transmit Interrupt? */
-        if (irq_source & SJA_IR_TI)
+        if (irq_source & SJA_IR_TI) {
             /* Wake up a sender */
             rtdm_sem_up(&dev->tx_sem);
 
+#ifdef CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK
+	    if (dev->tx_socket) {
+		/* Copy timestamp to skb */
+		memcpy((void *)&dev->tx_skb.rb_frame + dev->tx_skb.rb_frame_size,
+		       &timestamp, TIMESTAMP_SIZE);
 
+	    if (recv_lock_free) {
+		recv_lock_free = 0;
+		rtdm_lock_get(&rtcan_recv_list_lock);
+		rtdm_lock_get(&rtcan_socket_lock);
+	    }
+
+	    rtcan_tx_loopback(dev);
+	    }
+#endif /* CONFIG_XENO_DRIVERS_RTCAN_TX_LOOPBACK */
+	}
+
         /* Receive Interrupt? */
         if (irq_source & SJA_IR_RI) {
 

--------------000108050806010708030208--

