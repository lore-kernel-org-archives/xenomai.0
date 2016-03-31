From: Matti Suominen <matti.suominen@wapice.com>
Date: Thu, 31 Mar 2016 10:33:09 +0000
Message-ID: <47132d04b76942d8bd15c82a5a460f7b@EDB3.wapice.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] A fix to few generic issues in rttcp stack
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>, =?iso-8859-1?Q?Lassi_Niemist=F6?= <lassi.niemisto@wapice.com>, "rpm@xenomai.org" <rpm@xenomai.org>

Hi,

I have case where we use rtnet's tcp socket in server application to=20
communicate with real time and non-real time tcp clients. To get=20
communication work between client and server I had to do some changes to=20
stack/ipv4/tcp/tcp.c file.

First. Original tcp flag enumeration didn't work at all in this case. This=
=20
was verified by using Wireshark to track communication which didn't show=20
me any flags in tcp packets. This was solved by replacing flags assigning=20
TCP_FLAG_ prefixed enums with TCPHDR_ prefixed defines from <net/tcp.h> in=
=20
stack/ipv4/tcp/tcp.c file. The original code only works in case of little=20
endian machine, as rt_tcp_set_flags function places assumption that flags=20
are located in the least-significant 8bits of the 32bit flag variable.=20
This approach is similar to what regular TCP is using:=20
https://github.com/torvalds/linux/blob/master/net/ipv4/tcp.c

Second. Server was able to receive messages from client but was unable to=20
reply messages. I was able to trace function calls by adding debug prints=20
to tcp.c functions and noticed that accepted socket wasn't signaled for=20
"ready to send" at all and server was unable to reply messages. This seems=
=20
to work properly if the send signal is posted in the end of the accept=20
function, which also would seem the logical way to initialize it once=20
connection has been established.

Third. In our case we have regular Linux tcp sockets and rtnet tcp sockets=
=20
working parallel, serving different services. Referred to this I noticed=20
that *rt_tcp_dest_socket() may cause problem when real time stack=20
processes a message targeted to a regular Linux socket and does not find a=
=20
rttcp socket for it. The rttcp stack then  tries to send RST|ACK to client=
=20
to terminate the connection. This is temporarily disabled by setting=20
"if (!th->rst)" clause into #ifdef YET_UNUSED. This should be corrected=20
for example by implementing layer which is able to loop also non real time=
=20
sockets. Or is it really a desired rttcp design principle to unsupport the=
=20
usage of regular Linux tcp sockets in parallel?

---------------------------------------------------------------------------

We noticed also that Windows client causes assertion in pool balance at=20
end of transmission.

Assertion failed! /src/stack/socket.c:rt_socket_cleanup:199=20
(&sock->skb_pool)->pool_balance =3D=3D 0

Call Trace:
[cbe97db0] [c00087e0] show_stack+0x48/0x150 (unreliable)
[cbe97df0] [d3830414] rt_socket_cleanup+0x13c/0x140 [rtnet]
[cbe97e10] [d38a1f00] rt_tcp_close+0x2b0/0x3a8 [rttcp]
[cbe97e50] [c009d3c0] __rt_dev_close+0x174/0x368
[cbe97e80] [c0071588] hisyscall_event+0x18c/0x35c
[cbe97ec0] [c00615c0] __ipipe_dispatch_event+0xac/0x1ec
[cbe97f20] [c000ea5c] __ipipe_syscall_root+0x5c/0x140
[cbe97f40] [c000fe60] DoSyscall+0x20/0x5c
--- Exception: c01 at 0x4899ba08

This is still unsolved but it seems not to cause harms.

---------------------------------------------------------------------------

Difference between Xenomai 3 tcp.c and our tcp.c additions at end of=20
message. Our fixes is based to rtnet 0.9.13, but this is how we could do=20
fix if we use Xenomai 3's rtnet.

Best regards,
Matti Suominen
Wapice Oy
Vaasa, Finland

---------------------------------------------------------------------------

PowerPC, CPU: MPC8309E
RTNet version 0.9.13
Xenomai 2.6.1
Linux version 3.1.10-ipipe

---------------------------------------------------------------------------
--- xeno3-tcp.c	2016-03-30 09:49:36.020400900 +0300
+++ xeno3-tcp-diff.c	2016-03-31 10:04:44.744351290 +0300
@@ -704,7 +704,7 @@
=20
     /* add rtskb entry to the socket retransmission queue */
     if (ts->tcp_state !=3D TCP_CLOSE &&
-	((flags & (TCP_FLAG_SYN|TCP_FLAG_FIN)) || data_len)) {
+	((flags & (TCPHDR_SYN|TCPHDR_FIN)) || data_len)) {
 	/* rtskb_clone below is called under lock, this is an admission,
 	   because for now there is no rtskb copy by reference */
 	cloned_skb =3D rtskb_clone(skb, &ts->sock.skb_pool);
@@ -720,7 +720,7 @@
=20
     /* need to update sync here, because it is safe way in
        comparison with races on fast ACK response */
-    if (flags & (TCP_FLAG_FIN|TCP_FLAG_SYN))
+    if (flags & (TCPHDR_FIN|TCPHDR_SYN))
 	ts->sync.seq++;
=20
     ts->sync.seq +=3D data_len;
@@ -832,6 +832,11 @@
 	/*
 	  rtdm_printk("Not found addr:0x%08x, port: 0x%04x\n", daddr, dport);
 	*/
+#ifdef YET_UNUSED
+/* This ifdef is added because parallel use of linux and rt_dev sockets ma=
y
+ * produce unwanted connection close when application uses linux socket in=
stead
+ * of rt_dev sockets and cannot find destination socket for package.
+ */
 	if (!th->rst) {
 	    /* No listening socket found, send RST|ACK */
 	    rst_socket.saddr =3D daddr;
@@ -846,10 +851,11 @@
=20
 	    if (rt_ip_route_output(&rst_socket.rt, daddr, saddr) =3D=3D 0) {
 		rt_socket_reference(&rst_socket.sock);
-		rt_tcp_send(&rst_socket, TCP_FLAG_ACK|TCP_FLAG_RST);
+		rt_tcp_send(&rst_socket, TCPHDR_ACK|TCPHDR_RST);
 		rtdev_dereference(rst_socket.rt.rtdev);
 	    }
 	}
+#endif
     }
=20
     return skb->sk;
@@ -918,7 +924,7 @@
     if (ts->sync.ack_seq =3D=3D (seq + 1) &&
 	ts->tcp_state =3D=3D TCP_ESTABLISHED) {
 	rtdm_lock_put_irqrestore(&ts->socket_lock, context);
-	rt_tcp_send(ts, TCP_FLAG_ACK);
+	rt_tcp_send(ts, TCPHDR_ACK);
 	goto feed;
     }
=20
@@ -930,7 +936,7 @@
 	    rtdm_lock_put_irqrestore(&ts->socket_lock, context);
 	    rtdm_event_signal(&ts->conn_evt);
 	    /* Send ACK */
-	    rt_tcp_send(ts, TCP_FLAG_ACK);
+	    rt_tcp_send(ts, TCPHDR_ACK);
 	    goto feed;
 	}
=20
@@ -940,7 +946,7 @@
=20
 	/* Send RST|ACK */
 	rtdm_event_signal(&ts->conn_evt);
-	rt_tcp_send(ts, TCP_FLAG_RST|TCP_FLAG_ACK);
+	rt_tcp_send(ts, TCPHDR_RST|TCPHDR_ACK);
 	goto drop;
     }
=20
@@ -965,7 +971,7 @@
     } else if (rt_tcp_after(seq, ts->sync.ack_seq - data_len)) {
 	/* retransmission of data we already acked */
 	rtdm_lock_put_irqrestore(&ts->socket_lock, context);
-	rt_tcp_send(ts, TCP_FLAG_ACK);
+	rt_tcp_send(ts, TCPHDR_ACK);
 	goto drop;
     } else {
 	/* drop forward ack */
@@ -995,7 +1001,7 @@
 	if (rt_ip_route_output(&rst_socket.rt, rst_socket.daddr,
 			       rst_socket.saddr) =3D=3D 0) {
 	    rt_socket_reference(&rst_socket.sock);
-	    rt_tcp_send(&rst_socket, TCP_FLAG_RST|TCP_FLAG_ACK);
+	    rt_tcp_send(&rst_socket, TCPHDR_RST|TCPHDR_ACK);
 	    rtdev_dereference(rst_socket.rt.rtdev);
 	}
 	goto drop;
@@ -1029,14 +1035,14 @@
 	    if (signal)
 		rt_tcp_socket_invalidate_signal(ts);
=20
-	    rt_tcp_send(ts, TCP_FLAG_ACK);
+	    rt_tcp_send(ts, TCPHDR_ACK);
 	    goto feed;
 	} else if ((ts->tcp_state =3D=3D TCP_FIN_WAIT1 && th->ack) ||
 		   ts->tcp_state =3D=3D TCP_FIN_WAIT2) {
 	    /* Send ACK */
 	    ts->tcp_state =3D TCP_TIME_WAIT;
 	    rtdm_lock_put_irqrestore(&ts->socket_lock, context);
-	    rt_tcp_send(ts, TCP_FLAG_ACK);
+	    rt_tcp_send(ts, TCPHDR_ACK);
 	    /* data receiving is not possible anymore */
 	    rtdm_sem_destroy(&ts->sock.pending_sem);
 	    goto feed;
@@ -1044,7 +1050,7 @@
 	    /* Send ACK */
 	    ts->tcp_state =3D TCP_CLOSING;
 	    rtdm_lock_put_irqrestore(&ts->socket_lock, context);
-	    rt_tcp_send(ts, TCP_FLAG_ACK);
+	    rt_tcp_send(ts, TCPHDR_ACK);
 	    /* data receiving is not possible anymore */
 	    rtdm_sem_destroy(&ts->sock.pending_sem);
 	    goto feed;
@@ -1076,13 +1082,13 @@
 	    rtdm_lock_put_irqrestore(&ts->socket_lock, context);
=20
 	    /* Send SYN|ACK */
-	    rt_tcp_send(ts, TCP_FLAG_SYN|TCP_FLAG_ACK);
+	    rt_tcp_send(ts, TCPHDR_SYN|TCPHDR_ACK);
 	    goto drop;
 	}
=20
 	/* Send RST|ACK */
 	rtdm_lock_put_irqrestore(&ts->socket_lock, context);
-	rt_tcp_send(ts, TCP_FLAG_RST|TCP_FLAG_ACK);
+	rt_tcp_send(ts, TCPHDR_RST|TCPHDR_ACK);
 	goto drop;
     }
=20
@@ -1134,7 +1140,7 @@
     /* Send ACK */
     ts->sync.window -=3D data_len;
     rtdm_lock_put_irqrestore(&ts->socket_lock, context);
-    rt_tcp_send(ts, TCP_FLAG_ACK);
+    rt_tcp_send(ts, TCPHDR_ACK);
=20
     rtskb_queue_tail(&skb->sk->incoming, skb);
     rtdm_sem_up(&ts->sock.pending_sem);
@@ -1181,7 +1187,7 @@
     if (data_len > dst_window)
 	data_len =3D dst_window;
=20
-    if ((ret =3D rt_tcp_segment(&ts->rt, ts, TCP_FLAG_ACK,
+    if ((ret =3D rt_tcp_segment(&ts->rt, ts, TCPHDR_ACK,
 			      data_len, data_ptr, 0)) < 0) {
 	rtdm_printk("rttcp: cann't send a packet: err %d\n", -ret);
 	return ret;
@@ -1372,7 +1378,7 @@
 	ts->tcp_state =3D=3D TCP_SYN_RECV) {
 	/* close() from ESTABLISHED */
 	send_cmd.ts =3D ts;
-	send_cmd.flags =3D TCP_FLAG_FIN|TCP_FLAG_ACK;
+	send_cmd.flags =3D TCPHDR_FIN|TCPHDR_ACK;
 	signal =3D rt_tcp_socket_invalidate(ts, TCP_FIN_WAIT1);
=20
 	rtdm_lock_put_irqrestore(&ts->socket_lock, context);
@@ -1386,7 +1392,7 @@
     } else if (ts->tcp_state =3D=3D TCP_CLOSE_WAIT) {
 	/* Send FIN in CLOSE_WAIT */
 	send_cmd.ts =3D ts;
-	send_cmd.flags =3D TCP_FLAG_FIN|TCP_FLAG_ACK;
+	send_cmd.flags =3D TCPHDR_FIN|TCPHDR_ACK;
 	signal =3D rt_tcp_socket_invalidate(ts, TCP_LAST_ACK);
=20
 	rtdm_lock_put_irqrestore(&ts->socket_lock, context);
@@ -1532,7 +1538,7 @@
     rtdm_lock_put_irqrestore(&ts->socket_lock, context);
=20
     /* Complete three-way handshake */
-    ret =3D rt_tcp_send(ts, TCP_FLAG_SYN);
+    ret =3D rt_tcp_send(ts, TCPHDR_SYN);
     if (ret < 0) {
 	rtdm_printk("rttcp: cann't send SYN\n");
 	return ret;
@@ -1668,6 +1674,10 @@
     rtdm_lock_put_irqrestore(&ts->socket_lock, context);
=20
     ret =3D rt_socket_fd(&ts->sock)->fd;
+/*
+ * Socket should be signaled ready to send
+ */
+    rtdm_event_signal(&ts->send_evt);
=20
  err:
     /* it is not critical to leave this unlocked
@@ -1931,7 +1941,7 @@
 	    } else {
 		ts->sync.window =3D block_size;
 		rtdm_lock_put_irqrestore(&ts->socket_lock, context);
-		rt_tcp_send(ts, TCP_FLAG_ACK); /* window update */
+		rt_tcp_send(ts, TCPHDR_ACK); /* window update */
 	    }
=20
 	    __rtskb_pull(skb, block_size);
@@ -1954,7 +1964,7 @@
 	} else {
 	    ts->sync.window =3D block_size;
 	    rtdm_lock_put_irqrestore(&ts->socket_lock, context);
-	    rt_tcp_send(ts, TCP_FLAG_ACK); /* window update */
+	    rt_tcp_send(ts, TCPHDR_ACK); /* window update */
 	}
=20
 	if ((skb =3D skb->next) !=3D NULL) {

