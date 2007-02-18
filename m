Message-ID: <45D8B15C.5050707@domain.hid>
Date: Sun, 18 Feb 2007 21:04:44 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070905030802090904010401"
Subject: [Xenomai-core] More RTCAN patches
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------070905030802090904010401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jan,

I have two more patches in my quilt stack:

   2007-02-18  Wolfgang Grandegger  <wg@domain.hid>

   * ksrc/drivers/can/rtcan_raw.c, ksrc/drivers/can/rtcan_socket.h:  add
     prefix RTCAN_ to TIMESTAMP_SIZE, HAS_TIMESTAMP and HAS_NO_TIMESTAMP
     to avoid name clashes, e.g. TIMESTAMP_SIZE is used by the kernel
     starting with 2.6.20.

   * include/rtdm/rtcan.h: add "__attribute__ ((aligned(8)))" to the
     data[8] element of the struct can_frame.

   2007-02-18  Wolfgang Grandegger  <wg@domain.hid>

   * include/rtdm/rtcan.h
     ksrc/drivers/can/Config.in,
     ksrc/drivers/can/Kconfig,
     ksrc/drivers/can/rtcan_dev.h,
     ksrc/drivers/can/rtcan_module.c,
     ksrc/drivers/can/rtcan_raw.c,
     ksrc/drivers/can/rtcan_raw.h,
     ksrc/drivers/can/rtcan_socket.c,
     ksrc/drivers/can/rtcan_socket.h,
     ksrc/drivers/can/rtcan_socket.h,
     ksrc/drivers/can/rtcan_virt.c,
     ksrc/drivers/can/sja1000/rtcan_sja1000.c,
     ksrc/drivers/can/mscan/rtcan_mscan.c,
     src/utils/can/rtcansend.c: The socket option CAN_RAW_TX_LOOPBACK
     has been renamed to CAN_RAW_LOOPBACK to be compatible with the
     Socket-CAN implementation. Furthermore, all lower and upper case
     strings "tx_loopback" have been replaced with "loopback" (to
     shorten names).

The first one also fixes the alignment issue discussed on the Socket-CAN 
  mailing list.

Any comments or objections?

Wolfgang.

--------------070905030802090904010401
Content-Type: text/x-patch;
 name="xenomai-rtcan-misc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-rtcan-misc.patch"

Index: quilt/xenomai/ksrc/drivers/can/rtcan_raw.c
===================================================================
--- quilt.orig/xenomai/ksrc/drivers/can/rtcan_raw.c
+++ quilt/xenomai/ksrc/drivers/can/rtcan_raw.c
@@ -86,10 +86,10 @@ static void rtcan_rcv_deliver(struct rtc
     cpy_size = skb->rb_frame_size;
     /* Check if socket wants to receive a timestamp */
     if (test_bit(RTCAN_GET_TIMESTAMP, &context->context_flags)) {
-	cpy_size += TIMESTAMP_SIZE;
-	frame->can_dlc |= HAS_TIMESTAMP;
+	cpy_size += RTCAN_TIMESTAMP_SIZE;
+	frame->can_dlc |= RTCAN_HAS_TIMESTAMP;
     } else
-	frame->can_dlc &= HAS_NO_TIMESTAMP;
+	frame->can_dlc &= RTCAN_HAS_NO_TIMESTAMP;
     
     /* Calculate free size in the ring buffer */
     size_free = sock->recv_head - sock->recv_tail;
@@ -140,7 +140,7 @@ void rtcan_rcv(struct rtcan_device *dev,
 
     /* Copy timestamp to skb */
     memcpy((void *)&skb->rb_frame + skb->rb_frame_size,
-	   &timestamp, TIMESTAMP_SIZE);
+	   &timestamp, RTCAN_TIMESTAMP_SIZE);
 
     if ((frame->can_id & CAN_ERR_FLAG)) {
 	dev->err_count++;
@@ -192,7 +192,7 @@ void rtcan_loopback(struct rtcan_device 
     struct rtcan_rb_frame *frame = &dev->tx_skb.rb_frame;
 
     memcpy((void *)&dev->tx_skb.rb_frame + dev->tx_skb.rb_frame_size,
-	   &timestamp, TIMESTAMP_SIZE);
+	   &timestamp, RTCAN_TIMESTAMP_SIZE);
 
     while (recv_listener != NULL) {
 	dev->rx_count++;
@@ -675,7 +675,7 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_de
     can_dlc = recv_buf[recv_buf_index];
     recv_buf_index = (recv_buf_index + 1) & (RTCAN_RXBUF_SIZE - 1);
 
-    frame.can_dlc = can_dlc & HAS_NO_TIMESTAMP;
+    frame.can_dlc = can_dlc & RTCAN_HAS_NO_TIMESTAMP;
     payload_size = (frame.can_dlc > 8) ? 8 : frame.can_dlc;
 
 
@@ -688,9 +688,9 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_de
 
 
     /* Is a timestamp available and is the caller actually interested? */
-    if (msg->msg_controllen && (can_dlc & HAS_TIMESTAMP)) {
+    if (msg->msg_controllen && (can_dlc & RTCAN_HAS_TIMESTAMP)) {
         /* Copy timestamp */
-        MEMCPY_FROM_RING_BUF(&timestamp, TIMESTAMP_SIZE);
+        MEMCPY_FROM_RING_BUF(&timestamp, RTCAN_TIMESTAMP_SIZE);
     }
 
 
@@ -744,12 +744,12 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_de
 
         /* Copy timestamp if existent and wanted */
         if (msg->msg_controllen) {
-            if (can_dlc & HAS_TIMESTAMP) {
+            if (can_dlc & RTCAN_HAS_TIMESTAMP) {
                 if (rtdm_copy_to_user(user_info, msg->msg_control,
-                                      &timestamp, TIMESTAMP_SIZE))
+                                      &timestamp, RTCAN_TIMESTAMP_SIZE))
                     return -EFAULT;
 
-                msg->msg_controllen = TIMESTAMP_SIZE;
+                msg->msg_controllen = RTCAN_TIMESTAMP_SIZE;
             } else
                 msg->msg_controllen = 0;
         }
@@ -771,9 +771,9 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_de
 
         /* Copy timestamp if existent and wanted */
         if (msg->msg_controllen) {
-            if (can_dlc & HAS_TIMESTAMP) {
-                memcpy(msg->msg_control, &timestamp, TIMESTAMP_SIZE);
-                msg->msg_controllen = TIMESTAMP_SIZE;
+            if (can_dlc & RTCAN_HAS_TIMESTAMP) {
+                memcpy(msg->msg_control, &timestamp, RTCAN_TIMESTAMP_SIZE);
+                msg->msg_controllen = RTCAN_TIMESTAMP_SIZE;
             } else
                 msg->msg_controllen = 0;
         }
Index: quilt/xenomai/ksrc/drivers/can/rtcan_socket.h
===================================================================
--- quilt.orig/xenomai/ksrc/drivers/can/rtcan_socket.h
+++ quilt/xenomai/ksrc/drivers/can/rtcan_socket.h
@@ -38,18 +38,17 @@
 
 
 /* This MUST BE 2^N */
-#define RTCAN_RXBUF_SIZE    CONFIG_XENO_DRIVERS_CAN_RXBUF_SIZE
+#define RTCAN_RXBUF_SIZE          CONFIG_XENO_DRIVERS_CAN_RXBUF_SIZE
 
 /* Size of timestamp */
-#define TIMESTAMP_SIZE      sizeof(nanosecs_abs_t)
-
+#define RTCAN_TIMESTAMP_SIZE      sizeof(nanosecs_abs_t)
 
 /* Bit in the can_dlc member of struct ring_buffer_frame used to indicate
  * whether a frame has got a timestamp or not */
-#define HAS_TIMESTAMP       0x80
+#define RTCAN_HAS_TIMESTAMP       0x80
 
-/* Mask for clearing bit HAS_TIMESTAMP */
-#define HAS_NO_TIMESTAMP    0x7F
+/* Mask for clearing bit RTCAN_HAS_TIMESTAMP */
+#define RTCAN_HAS_NO_TIMESTAMP    0x7F
 
 #define RTCAN_SOCK_UNBOUND        -1
 #define RTCAN_FLIST_NO_FILTER     (void *)-1
@@ -75,7 +74,7 @@ struct rtcan_rb_frame {
     unsigned char       can_ifindex;
 
     /* DLC (between 0 and 15) and mark if frame has got a timestamp. The
-     * existence of a timestamp is indicated by the HAS_TIMESTAMP 
+     * existence of a timestamp is indicated by the RTCAN_HAS_TIMESTAMP
      * bit. */
     unsigned char       can_dlc;
 
@@ -83,7 +82,7 @@ struct rtcan_rb_frame {
     uint8_t             data[8];
 
     /* High precision timestamp indicating when the frame was received.
-     * Exists when HAS_TIMESTAMP bit in can_dlc is set. */
+     * Exists when RTCAN_HAS_TIMESTAMP bit in can_dlc is set. */
     nanosecs_abs_t      timestamp;
 
 } __attribute__ ((packed));
@@ -91,7 +90,7 @@ struct rtcan_rb_frame {
 
 /* Size of struct rtcan_rb_frame without any data bytes and timestamp */
 #define EMPTY_RB_FRAME_SIZE \
-    sizeof(struct rtcan_rb_frame) - 8 - TIMESTAMP_SIZE
+    sizeof(struct rtcan_rb_frame) - 8 - RTCAN_TIMESTAMP_SIZE
 
 
 /*
Index: quilt/xenomai/ChangeLog
===================================================================
--- quilt.orig/xenomai/ChangeLog
+++ quilt/xenomai/ChangeLog
@@ -1,5 +1,15 @@
 2007-02-18  Wolfgang Grandegger  <wg@domain.hid>
 
+	* ksrc/drivers/can/rtcan_raw.c, ksrc/drivers/can/rtcan_socket.h: add
+	prefix RTCAN_ to TIMESTAMP_SIZE, HAS_TIMESTAMP and HAS_NO_TIMESTAMP
+	to avoid name clashes, e.g. TIMESTAMP_SIZE is used by the kernel
+	starting with 2.6.20.
+
+	* include/rtdm/rtcan.h: add "__attribute__ ((aligned(8)))" to the
+	data[8] element of the struct can_frame.
+
+2007-02-18  Wolfgang Grandegger  <wg@domain.hid>
+
 	* include/rtdm/rtcan.h
 	ksrc/drivers/can/Config.in,
 	ksrc/drivers/can/Kconfig,
Index: quilt/xenomai/include/rtdm/rtcan.h
===================================================================
--- quilt.orig/xenomai/include/rtdm/rtcan.h
+++ quilt/xenomai/include/rtdm/rtcan.h
@@ -503,7 +503,7 @@ typedef struct can_frame {
 
     /** CAN ID of the frame
      *
-     *  See @ref CAN_xxx_FLAG "CAN ID flags" for special bits. 
+     *  See @ref CAN_xxx_FLAG "CAN ID flags" for special bits.
      */
     can_id_t     can_id;
 
@@ -511,7 +511,7 @@ typedef struct can_frame {
     uint8_t      can_dlc;
 
     /** Payload data bytes */
-    uint8_t      data[8];
+    uint8_t      data[8] __attribute__ ((aligned(8)));
 } can_frame_t;
 
 

--------------070905030802090904010401
Content-Type: text/x-patch;
 name="xenomai-rtcan-loopback.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-rtcan-loopback.patch"

Index: quilt/xenomai/include/rtdm/rtcan.h
===================================================================
--- quilt.orig/xenomai/include/rtdm/rtcan.h
+++ quilt/xenomai/include/rtdm/rtcan.h
@@ -123,7 +123,7 @@
  * - Level @b SOL_CAN_RAW : CAN RAW protocol (see @ref CAN_PROTO_RAW)
  *   - Option @ref CAN_RAW_FILTER : CAN filter list
  *   - Option @ref CAN_RAW_ERR_FILTER : CAN error mask
- *   - Option @ref CAN_RAW_TX_LOOPBACK : CAN TX loopback to local sockets
+ *   - Option @ref CAN_RAW_LOOPBACK : CAN TX loopback to local sockets
  *   .
  * .
  * @n
@@ -612,7 +612,7 @@ typedef struct can_frame {
  * @n
  * @param [in] level @b SOL_CAN_RAW
  *
- * @param [in] optname @b CAN_RAW_TX_LOOPBACK
+ * @param [in] optname @b CAN_RAW_LOOPBACK
  *
  * @param [in] optval Pointer to integer value.
  *
@@ -626,7 +626,7 @@ typedef struct can_frame {
  * - -EINVAL (Invalid length "optlen")
  * - -EOPNOTSUPP (not supported, check RT-Socket-CAN kernel parameters).
  */
-#define CAN_RAW_TX_LOOPBACK  0x3
+#define CAN_RAW_LOOPBACK  0x3
 
 /** @} */
 
Index: quilt/xenomai/ksrc/drivers/can/Config.in
===================================================================
--- quilt.orig/xenomai/ksrc/drivers/can/Config.in
+++ quilt/xenomai/ksrc/drivers/can/Config.in
@@ -9,7 +9,7 @@ dep_tristate 'RT-Socket-CAN, CAN raw soc
 
 if [ "$CONFIG_XENO_DRIVERS_CAN" != "n" ]; then 
    bool 'Enable debug output' CONFIG_XENO_DRIVERS_CAN_DEBUG
-   bool 'Enable TX loopback to local sockets' CONFIG_XENO_DRIVERS_CAN_TX_LOOPBACK
+   bool 'Enable TX loopback to local sockets' CONFIG_XENO_DRIVERS_CAN_LOOPBACK
    int 'Size of receive ring buffers (must be 2^N)' CONFIG_XENO_DRIVERS_CAN_RXBUF_SIZE 1024
    int 'Maximum number of devices' CONFIG_XENO_DRIVERS_CAN_MAX_DEVICES 4
    int 'Maximum number of receive filters per device' CONFIG_XENO_DRIVERS_CAN_MAX_RECEIVERS 16
Index: quilt/xenomai/ksrc/drivers/can/Kconfig
===================================================================
--- quilt.orig/xenomai/ksrc/drivers/can/Kconfig
+++ quilt/xenomai/ksrc/drivers/can/Kconfig
@@ -18,7 +18,7 @@ config XENO_DRIVERS_CAN_DEBUG
 	getting started and analysing potential problems. For production
 	purposes, it should be switched off (for the sake of latency).
 
-config XENO_DRIVERS_CAN_TX_LOOPBACK
+config XENO_DRIVERS_CAN_LOOPBACK
 	depends on XENO_DRIVERS_CAN
 	bool "Enable TX loopback to local sockets"
 	default n
Index: quilt/xenomai/ksrc/drivers/can/mscan/rtcan_mscan.c
===================================================================
--- quilt.orig/xenomai/ksrc/drivers/can/mscan/rtcan_mscan.c
+++ quilt/xenomai/ksrc/drivers/can/mscan/rtcan_mscan.c
@@ -251,7 +251,7 @@ static int rtcan_mscan_interrupt(rtdm_ir
 	/* Wake up a sender */
 	rtdm_sem_up(&dev->tx_sem);
 
-	if (rtcan_tx_loopback_pending(dev)) {
+	if (rtcan_loopback_pending(dev)) {
 
 	    if (recv_lock_free) {
 		recv_lock_free = 0;
@@ -259,7 +259,7 @@ static int rtcan_mscan_interrupt(rtdm_ir
 		rtdm_lock_get(&rtcan_socket_lock);
 	    }
 
-	    rtcan_tx_loopback(dev);
+	    rtcan_loopback(dev);
 	}
     }
 
Index: quilt/xenomai/ksrc/drivers/can/rtcan_dev.h
===================================================================
--- quilt.orig/xenomai/ksrc/drivers/can/rtcan_dev.h
+++ quilt/xenomai/ksrc/drivers/can/rtcan_dev.h
@@ -142,10 +142,10 @@ struct rtcan_device {
 #ifdef CONFIG_PROC_FS
     struct proc_dir_entry *proc_root;
 #endif
-#ifdef CONFIG_XENO_DRIVERS_CAN_TX_LOOPBACK
+#ifdef CONFIG_XENO_DRIVERS_CAN_LOOPBACK
     struct rtcan_skb tx_skb;
     struct rtcan_socket *tx_socket;
-#endif /* CONFIG_XENO_DRIVERS_CAN_TX_LOOPBACK */
+#endif /* CONFIG_XENO_DRIVERS_CAN_LOOPBACK */
 };
 
 
Index: quilt/xenomai/ksrc/drivers/can/rtcan_module.c
===================================================================
--- quilt.orig/xenomai/ksrc/drivers/can/rtcan_module.c
+++ quilt/xenomai/ksrc/drivers/can/rtcan_module.c
@@ -200,7 +200,7 @@ static int rtcan_read_proc_sockets(char 
 			      context->fd, name, sock->flistlen,
 			      sock->err_mask, rx_timeout, tx_timeout,
 			      sock->rx_buf_full,
-			      rtcan_tx_loopback_enabled(sock)))
+			      rtcan_loopback_enabled(sock)))
 	    break;
     }
 
Index: quilt/xenomai/ksrc/drivers/can/rtcan_raw.c
===================================================================
--- quilt.orig/xenomai/ksrc/drivers/can/rtcan_raw.c
+++ quilt/xenomai/ksrc/drivers/can/rtcan_raw.c
@@ -163,7 +163,7 @@ void rtcan_rcv(struct rtcan_device *dev,
     }
 }
 
-#ifdef CONFIG_XENO_DRIVERS_CAN_TX_LOOPBACK
+#ifdef CONFIG_XENO_DRIVERS_CAN_LOOPBACK
 
 void rtcan_tx_push(struct rtcan_device *dev, struct rtcan_socket *sock,
 		   can_frame_t *frame)
@@ -184,7 +184,7 @@ void rtcan_tx_push(struct rtcan_device *
     dev->tx_socket = sock;
 }
 
-void rtcan_tx_loopback(struct rtcan_device *dev)
+void rtcan_loopback(struct rtcan_device *dev)
 {
     nanosecs_abs_t timestamp = rtdm_clock_read();
     /* Entry in reception list, begin with head */
@@ -206,9 +206,9 @@ void rtcan_tx_loopback(struct rtcan_devi
     dev->tx_socket = NULL;
 }
 
-EXPORT_SYMBOL_GPL(rtcan_tx_loopback);
+EXPORT_SYMBOL_GPL(rtcan_loopback);
 
-#endif /* CONFIG_XENO_DRIVERS_CAN_TX_LOOPBACK */
+#endif /* CONFIG_XENO_DRIVERS_CAN_LOOPBACK */
 
 
 int rtcan_raw_socket(struct rtdm_dev_context *context,
@@ -386,7 +386,7 @@ static int rtcan_raw_setsockopt(struct r
 
 	break;
 
-    case CAN_RAW_TX_LOOPBACK:
+    case CAN_RAW_LOOPBACK:
 
 	if (so->optlen != sizeof(int))
 	    return -EINVAL;
@@ -398,8 +398,8 @@ static int rtcan_raw_setsockopt(struct r
 	} else
 	    memcpy(&val, so->optval, so->optlen);
 
-#ifdef CONFIG_XENO_DRIVERS_CAN_TX_LOOPBACK
-	sock->tx_loopback = val;
+#ifdef CONFIG_XENO_DRIVERS_CAN_LOOPBACK
+	sock->loopback = val;
 #else
 	if (val)
 	    return -EOPNOTSUPP;
@@ -960,7 +960,7 @@ ssize_t rtcan_raw_sendmsg(struct rtdm_de
 
 
     /* Push message onto stack for loopback when TX done */
-    if (rtcan_tx_loopback_enabled(sock))
+    if (rtcan_loopback_enabled(sock))
 	rtcan_tx_push(dev, sock, frame);
 
     rtdm_lock_get_irqsave(&dev->device_lock, lock_ctx);
Index: quilt/xenomai/ksrc/drivers/can/rtcan_raw.h
===================================================================
--- quilt.orig/xenomai/ksrc/drivers/can/rtcan_raw.h
+++ quilt/xenomai/ksrc/drivers/can/rtcan_raw.h
@@ -32,14 +32,14 @@ void rtcan_raw_remove_filter(struct rtca
 
 void rtcan_rcv(struct rtcan_device *rtcandev, struct rtcan_skb *skb);
 
-void rtcan_tx_loopback(struct rtcan_device *rtcandev);
-#ifdef CONFIG_XENO_DRIVERS_CAN_TX_LOOPBACK
-#define rtcan_tx_loopback_enabled(sock) (sock->tx_loopback)
-#define rtcan_tx_loopback_pending(dev) (dev->tx_socket)
-#else /* !CONFIG_XENO_DRIVERS_CAN_TX_LOOPBACK */
-#define rtcan_tx_loopback_enabled(sock) (0)
-#define rtcan_tx_loopback_pending(dev) (0)
-#endif /* CONFIG_XENO_DRIVERS_CAN_TX_LOOPBACK */
+void rtcan_loopback(struct rtcan_device *rtcandev);
+#ifdef CONFIG_XENO_DRIVERS_CAN_LOOPBACK
+#define rtcan_loopback_enabled(sock) (sock->loopback)
+#define rtcan_loopback_pending(dev) (dev->tx_socket)
+#else /* !CONFIG_XENO_DRIVERS_CAN_LOOPBACK */
+#define rtcan_loopback_enabled(sock) (0)
+#define rtcan_loopback_pending(dev) (0)
+#endif /* CONFIG_XENO_DRIVERS_CAN_LOOPBACK */
 
 int __init rtcan_raw_proto_register(void);
 void __exit rtcan_raw_proto_unregister(void);
Index: quilt/xenomai/ksrc/drivers/can/rtcan_socket.c
===================================================================
--- quilt.orig/xenomai/ksrc/drivers/can/rtcan_socket.c
+++ quilt/xenomai/ksrc/drivers/can/rtcan_socket.c
@@ -48,8 +48,8 @@ void rtcan_socket_init(struct rtdm_dev_c
     sock->flist = NULL;
     sock->err_mask = 0;
     sock->rx_buf_full = 0;
-#ifdef CONFIG_XENO_DRIVERS_CAN_TX_LOOPBACK
-    sock->tx_loopback = 1;
+#ifdef CONFIG_XENO_DRIVERS_CAN_LOOPBACK
+    sock->loopback = 1;
 #endif
 
     sock->tx_timeout = RTDM_TIMEOUT_INFINITE;
Index: quilt/xenomai/ksrc/drivers/can/rtcan_socket.h
===================================================================
--- quilt.orig/xenomai/ksrc/drivers/can/rtcan_socket.h
+++ quilt/xenomai/ksrc/drivers/can/rtcan_socket.h
@@ -173,8 +173,8 @@ struct rtcan_socket {
 
     struct rtcan_filter_list *flist;
 
-#ifdef CONFIG_XENO_DRIVERS_CAN_TX_LOOPBACK
-    int tx_loopback;
+#ifdef CONFIG_XENO_DRIVERS_CAN_LOOPBACK
+    int loopback;
 #endif
 };
 
Index: quilt/xenomai/ksrc/drivers/can/rtcan_virt.c
===================================================================
--- quilt.orig/xenomai/ksrc/drivers/can/rtcan_virt.c
+++ quilt/xenomai/ksrc/drivers/can/rtcan_virt.c
@@ -78,8 +78,8 @@ static int rtcan_virt_start_xmit(struct 
 			if (tx_dev != rx_dev) {
 				rx_frame->can_ifindex = rx_dev->ifindex;
 				rtcan_rcv(rx_dev, &skb);
-			} else if (rtcan_tx_loopback_pending(tx_dev))
-				rtcan_tx_loopback(tx_dev);
+			} else if (rtcan_loopback_pending(tx_dev))
+				rtcan_loopback(tx_dev);
 		}
 	}
 	rtdm_lock_put(&rtcan_socket_lock);
Index: quilt/xenomai/ksrc/drivers/can/sja1000/rtcan_sja1000.c
===================================================================
--- quilt.orig/xenomai/ksrc/drivers/can/sja1000/rtcan_sja1000.c
+++ quilt/xenomai/ksrc/drivers/can/sja1000/rtcan_sja1000.c
@@ -312,7 +312,7 @@ static int rtcan_sja_interrupt(rtdm_irq_
             /* Wake up a sender */
             rtdm_sem_up(&dev->tx_sem);
 
-	    if (rtcan_tx_loopback_pending(dev)) {
+	    if (rtcan_loopback_pending(dev)) {
 
 		if (recv_lock_free) {
 		    recv_lock_free = 0;
@@ -320,7 +320,7 @@ static int rtcan_sja_interrupt(rtdm_irq_
 		    rtdm_lock_get(&rtcan_socket_lock);
 		}
 
-		rtcan_tx_loopback(dev);
+		rtcan_loopback(dev);
 	    }
 	}
 
Index: quilt/xenomai/src/utils/can/rtcansend.c
===================================================================
--- quilt.orig/xenomai/src/utils/can/rtcansend.c
+++ quilt/xenomai/src/utils/can/rtcansend.c
@@ -28,7 +28,7 @@ static void print_usage(char *prg)
 	    " -d, --delay=MS        delay in ms (default = 1ms)\n"
 	    " -s, --send            use send instead of sendto\n"
 	    " -t, --timeout=MS      timeout in ms\n"
-	    " -T, --tx-loopback=0|1 switch TX loopback off or on\n"
+	    " -L, --loopback=0|1    switch local loopback off or on\n"
 	    " -v, --verbose         be verbose\n"
 	    " -p, --print=MODULO    print every MODULO message\n"
 	    " -h, --help            this help\n",
@@ -40,7 +40,7 @@ RT_TASK rt_task_desc;
 
 static int s=-1, dlc=0, rtr=0, extended=0, verbose=0, loops=1;
 static SRTIME delay=1000000;
-static int count=0, print=1, use_send=0, tx_loopback=-1;
+static int count=0, print=1, use_send=0, loopback=-1;
 static nanosecs_rel_t timeout = 0;
 static struct can_frame frame;
 static struct sockaddr_can to_addr;
@@ -81,7 +81,7 @@ void rt_task(void)
         rt_task_sleep(rt_timer_ns2ticks(delay));
 	if (count)
 	    memcpy(&frame.data[0], &i, sizeof(i));
-	/* Note: sendto avoids the definiton of a receive filter list */ 
+	/* Note: sendto avoids the definiton of a receive filter list */
 	if (use_send)
 	    ret = rt_dev_send(s, (void *)&frame, sizeof(can_frame_t), 0);
 	else
@@ -136,7 +136,7 @@ int main(int argc, char **argv)
 	{ "delay", required_argument, 0, 'd'},
 	{ "send", no_argument, 0, 's'},
 	{ "timeout", required_argument, 0, 't'},
-	{ "tx-loopbcak", required_argument, 0, 'T'},
+	{ "loopback", required_argument, 0, 'L'},
 	{ 0, 0, 0, 0},
     };
 
@@ -147,7 +147,7 @@ int main(int argc, char **argv)
 
     frame.can_id = 1;
 
-    while ((opt = getopt_long(argc, argv, "hvi:l:red:t:cp:sT:",
+    while ((opt = getopt_long(argc, argv, "hvi:l:red:t:cp:sL:",
 			      long_options, NULL)) != -1) {
 	switch (opt) {
 	case 'h':
@@ -193,8 +193,8 @@ int main(int argc, char **argv)
 	    timeout = strtoul(optarg, NULL, 0) * 1000000LL;
 	    break;
 
-	case 'T':
-	    tx_loopback = strtoul(optarg, NULL, 0);
+	case 'L':
+	    loopback = strtoul(optarg, NULL, 0);
 	    break;
 
 	default:
@@ -223,15 +223,15 @@ int main(int argc, char **argv)
     }
     s = ret;
 
-    if (tx_loopback >= 0) {
-	ret = rt_dev_setsockopt(s, SOL_CAN_RAW, CAN_RAW_TX_LOOPBACK,
-				&tx_loopback, sizeof(tx_loopback));
+    if (loopback >= 0) {
+	ret = rt_dev_setsockopt(s, SOL_CAN_RAW, CAN_RAW_LOOPBACK,
+				&loopback, sizeof(loopback));
 	if (ret < 0) {
 	    fprintf(stderr, "rt_dev_setsockopt: %s\n", strerror(-ret));
 	    goto failure;
 	}
 	if (verbose)
-	    printf("Using tx_loopback=%d\n", tx_loopback);
+	    printf("Using loopback=%d\n", loopback);
     }
 
     strncpy(ifr.ifr_name, argv[optind], IFNAMSIZ);
Index: quilt/xenomai/ChangeLog
===================================================================
--- quilt.orig/xenomai/ChangeLog
+++ quilt/xenomai/ChangeLog
@@ -1,3 +1,22 @@
+2007-02-18  Wolfgang Grandegger  <wg@domain.hid>
+
+	* include/rtdm/rtcan.h
+	ksrc/drivers/can/Config.in,
+	ksrc/drivers/can/Kconfig,
+	ksrc/drivers/can/rtcan_dev.h,
+	ksrc/drivers/can/rtcan_module.c,
+	ksrc/drivers/can/rtcan_raw.c,
+	ksrc/drivers/can/rtcan_raw.h,
+	ksrc/drivers/can/rtcan_socket.c,
+	ksrc/drivers/can/rtcan_socket.h,
+	ksrc/drivers/can/rtcan_virt.c,
+	ksrc/drivers/can/sja1000/rtcan_sja1000.c,
+	ksrc/drivers/can/mscan/rtcan_mscan.c,
+	src/utils/can/rtcansend.c: The socket option CAN_RAW_TX_LOOPBACK has
+	been renamed to CAN_RAW_LOOPBACK to be compatible with the Socket-CAN
+	implementation. Furthermore, all lower and upper case strings
+	"tx_loopback" have been replaced with "loopback" (to shorten names).
+
 2007-02-17  Wolfgang Grandegger  <wg@domain.hid>
 
 	* ksrc/drivers/can/rtcan_raw.c, ksrc/drivers/can/rtcan_raw_filter.c,

--------------070905030802090904010401--

