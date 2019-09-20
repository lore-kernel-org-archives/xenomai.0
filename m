From: Sebastian Smolorz <sebastian.smolorz@gmx.de>
Subject: [PATCH v2] net/tcp: Account for connection teardown handshake
Date: Fri, 20 Sep 2019 11:49:48 +0200
Message-Id: <20190920094948.21814-1-sebastian.smolorz@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jan.kiszka@siemens.com
Cc: xenomai@xenomai.org

When closing a TCP connection a handshake procedure is executed between th=
e
peers. The close routine of the rttcp driver did not participate in
detecting the end of this handshake but rather waited one second inside
a close call unconditionally. Especially when peers are directly connected
this is a waste of time which can hurt a lot in some situations.

This patch replaces the msleep(1000) call with waiting for a completion.
The maximum waiting time now can be configured via a module parameter.
The completion is done when the termination handshake has finished.

Signed-off-by: Sebastian Smolorz <sebastian.smolorz@gmx.de>
=2D--
 kernel/drivers/net/stack/ipv4/tcp/tcp.c | 38 ++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c b/kernel/drivers/net/=
stack/ipv4/tcp/tcp.c
index 54bafa80f..b8263e5d2 100644
=2D-- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
+++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
@@ -25,6 +25,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/completion.h>
 #include <net/tcp_states.h>
 #include <net/tcp.h>

@@ -41,6 +42,11 @@
 #include <ipv4/af_inet.h>
 #include "timerwheel.h"

+static unsigned int close_timeout =3D 1000;
+module_param(close_timeout, uint, 0664);
+MODULE_PARM_DESC(close_timeout,
+		 "max time (ms) to wait during close for FIN-ACK handshake to complete,=
 default 1000");
+
 #ifdef CONFIG_XENO_DRIVERS_NET_RTIPV4_TCP_ERROR_INJECTION

 static unsigned int error_rate;
@@ -147,6 +153,9 @@ struct tcp_socket {
 	struct rtskb_queue retransmit_queue;
 	struct timerwheel_timer timer;

+	struct completion fin_handshake;
+	rtdm_nrtsig_t close_sig;
+
 #ifdef CONFIG_XENO_DRIVERS_NET_RTIPV4_TCP_ERROR_INJECTION
 	unsigned int packet_counter;
 	unsigned int error_rate;
@@ -1042,6 +1051,7 @@ static void rt_tcp_rcv(struct rtskb *skb)
 			rt_tcp_send(ts, TCP_FLAG_ACK);
 			/* data receiving is not possible anymore */
 			rtdm_sem_destroy(&ts->sock.pending_sem);
+			rtdm_nrtsig_pend(&ts->close_sig);
 			goto feed;
 		} else if (ts->tcp_state =3D=3D TCP_FIN_WAIT1) {
 			/* Send ACK */
@@ -1105,6 +1115,7 @@ static void rt_tcp_rcv(struct rtskb *skb)
 			ts->tcp_state =3D TCP_CLOSE;
 			rtdm_lock_put_irqrestore(&ts->socket_lock, context);
 			/* socket destruction will be done on close() */
+			rtdm_nrtsig_pend(&ts->close_sig);
 			goto drop;
 		} else if (ts->tcp_state =3D=3D TCP_FIN_WAIT1) {
 			ts->tcp_state =3D TCP_FIN_WAIT2;
@@ -1119,6 +1130,7 @@ static void rt_tcp_rcv(struct rtskb *skb)
 			ts->tcp_state =3D TCP_TIME_WAIT;
 			rtdm_lock_put_irqrestore(&ts->socket_lock, context);
 			/* socket destruction will be done on close() */
+			rtdm_nrtsig_pend(&ts->close_sig);
 			goto feed;
 		}
 	}
@@ -1190,6 +1202,11 @@ static int rt_tcp_window_send(struct tcp_socket *ts=
, u32 data_len, u8 *data_ptr)
 	return ret;
 }

+static void rt_tcp_close_signal_handler(rtdm_nrtsig_t *nrtsig, void *arg)
+{
+	complete_all((struct completion *)arg);
+}
+
 static int rt_tcp_socket_create(struct tcp_socket *ts)
 {
 	rtdm_lockctx_t context;
@@ -1226,6 +1243,10 @@ static int rt_tcp_socket_create(struct tcp_socket *=
ts)
 	timerwheel_init_timer(&ts->timer, rt_tcp_retransmit_handler, ts);
 	rtskb_queue_init(&ts->retransmit_queue);

+	init_completion(&ts->fin_handshake);
+	rtdm_nrtsig_init(&ts->close_sig, rt_tcp_close_signal_handler,
+			 &ts->fin_handshake);
+
 #ifdef CONFIG_XENO_DRIVERS_NET_RTIPV4_TCP_ERROR_INJECTION
 	ts->packet_counter =3D counter_start;
 	ts->error_rate =3D error_rate;
@@ -1237,6 +1258,7 @@ static int rt_tcp_socket_create(struct tcp_socket *t=
s)
 	/* enforce maximum number of TCP sockets */
 	if (free_ports =3D=3D 0) {
 		rtdm_lock_put_irqrestore(&tcp_socket_base_lock, context);
+		rtdm_nrtsig_destroy(&ts->close_sig);
 		return -EAGAIN;
 	}
 	free_ports--;
@@ -1338,6 +1360,8 @@ static void rt_tcp_socket_destruct(struct tcp_socket=
 *ts)

 	rtdm_event_destroy(&ts->conn_evt);

+	rtdm_nrtsig_destroy(&ts->close_sig);
+
 	/* cleanup already collected fragments */
 	rt_ip_frag_invalidate_socket(sock);

@@ -1379,8 +1403,11 @@ static void rt_tcp_close(struct rtdm_fd *fd)
 				   sizeof(send_cmd), NULL, NULL);
 		/* result is ignored */

-		/* Give the peer some time to reply to our FIN. */
-		msleep(1000);
+		/* Give the peer some time to reply to our FIN.
+		   Since it is not relevant what exactly causes the wait
+		   function to return its result is ignored. */
+		wait_for_completion_interruptible_timeout(&ts->fin_handshake,
+					      msecs_to_jiffies(close_timeout));
 	} else if (ts->tcp_state =3D=3D TCP_CLOSE_WAIT) {
 		/* Send FIN in CLOSE_WAIT */
 		send_cmd.ts =3D ts;
@@ -1393,8 +1420,11 @@ static void rt_tcp_close(struct rtdm_fd *fd)
 				   sizeof(send_cmd), NULL, NULL);
 		/* result is ignored */

-		/* Give the peer some time to reply to our FIN. */
-		msleep(1000);
+		/* Give the peer some time to reply to our FIN.
+		   Since it is not relevant what exactly causes the wait
+		   function to return its result is ignored. */
+		wait_for_completion_interruptible_timeout(&ts->fin_handshake,
+					      msecs_to_jiffies(close_timeout));
 	} else {
 		/*
 	  rt_tcp_socket_validate() has not been called at all,
=2D-
2.20.1


