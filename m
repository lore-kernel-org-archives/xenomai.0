Message-ID: <46CC1C34.9050205@domain.hid>
Date: Wed, 22 Aug 2007 13:21:24 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090804020508050404050509"
Subject: [Xenomai-core] [PATCH] RT-Socket-CAN:
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
--------------090804020508050404050509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

the following patch fixes:

2007-08-22  Wolfgang Grandegger  <wg@domain.hid>

         * ksrc/drivers/can/rtcan_socket.c: protect the list of sockets
         per device properly when adding or deleting sockets.

It should be applied to Xenomai's trunk and v2.3.x branch.

Wolfgang.

--------------090804020508050404050509
Content-Type: text/x-patch;
 name="xenomai-rtcan-socket-list.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-rtcan-socket-list.patch"

Index: ChangeLog
===================================================================
--- ChangeLog	(revision 2945)
+++ ChangeLog	(working copy)
@@ -1,3 +1,8 @@
+2007-08-22  Wolfgang Grandegger  <wg@domain.hid>
+
+	* ksrc/drivers/can/rtcan_socket.c: protect the list of sockets
+	per device properly when adding or deleting sockets.
+
 2007-08-18  Philippe Gerum  <rpm@xenomai.org>
 
 	* RELEASE: Xenomai 2.4-rc2
Index: ksrc/drivers/can/rtcan_socket.c
===================================================================
--- ksrc/drivers/can/rtcan_socket.c	(revision 2945)
+++ ksrc/drivers/can/rtcan_socket.c	(working copy)
@@ -37,6 +37,7 @@ LIST_HEAD(rtcan_socket_list);
 void rtcan_socket_init(struct rtdm_dev_context *context)
 {
     struct rtcan_socket *sock = (struct rtcan_socket *)&context->dev_private;
+    rtdm_lockctx_t lock_ctx;
 
 
     rtdm_sem_init(&sock->recv_sem, 0);
@@ -56,7 +57,10 @@ void rtcan_socket_init(struct rtdm_dev_c
     sock->rx_timeout = RTDM_TIMEOUT_INFINITE;
 
     INIT_LIST_HEAD(&sock->tx_wait_head);
+
+    rtdm_lock_get_irqsave(&rtcan_socket_lock, lock_ctx);
     list_add(&sock->socket_list, &rtcan_socket_list);
+    rtdm_lock_put_irqrestore(&rtcan_socket_lock, lock_ctx);
 }
 
 
@@ -64,6 +68,7 @@ void rtcan_socket_cleanup(struct rtdm_de
 {
     struct rtcan_socket *sock = (struct rtcan_socket *)&context->dev_private;
     struct tx_wait_queue *tx_waiting;
+    rtdm_lockctx_t lock_ctx;
     int tx_list_empty;
 
 
@@ -91,5 +96,8 @@ void rtcan_socket_cleanup(struct rtdm_de
     } while (!tx_list_empty);
 
     rtdm_sem_destroy(&sock->recv_sem);
+
+    rtdm_lock_get_irqsave(&rtcan_socket_lock, lock_ctx);
     list_del(&sock->socket_list);
+    rtdm_lock_put_irqrestore(&rtcan_socket_lock, lock_ctx);
 }

--------------090804020508050404050509--

