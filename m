Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075AB17A589
	for <xenomai@lists.linux.dev>; Wed,  3 Jul 2024 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013152; cv=none; b=GKP9ZaHWasx6qsdkNsK1zaAZuDNZloh/+cs/zmapMWqALTI/mHf/aHkEurrG2hFx7KBjIIF5FRNnN+KuHb+YoYu2UzuIdCQ3vLF8ywHSRybigUl2+gustjv4h5UcTc2Ii+KJoDe+66MzpxkL21wup2IvFy9I0LBLvCkto4JMMlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013152; c=relaxed/simple;
	bh=LS8a343kk9f3FrcpsoFw09V5SM6Gc8fER1NbTF217RE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NVuvmA2iPXLdALvW6lZTQ+XNZbKrh9o0/geegzxmf+DeQyrmpSdb0WL0KaZEDfjycg1NtGDBzi2/GVJ4dqi/Ynsdfjl/M5K+VBmCnRFTEnBTawdVo4Jknghi9rEp+qkc4dHTfM7TonWPHhnLBEeGQjIDQonOcjMbpPM8JIyLQGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=nEB3SBmb; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="nEB3SBmb"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2024070313254969a11d633ef44a9189
        for <xenomai@lists.linux.dev>;
        Wed, 03 Jul 2024 15:25:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=5ywyybsPDpXsoJSC5xk8uUopHbuEfUX4rIZ51Xj2yYQ=;
 b=nEB3SBmb1Mk8nMrQUmGzDVZb9fdkcWbT14ONbn2rj5m5ZaHXRMDZg78bWqsjviEhdhLzKa
 Yp6Iuk6Pr+jIj2JFh+YcA9gxrL5mQXVwJFV0Ay5E88slw8M2qK8/5OwKK53XZ0jDoyHAlZfW
 V1bXycDjSNKxvmw0ngCHpi0zSAOkY=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Wed, 03 Jul 2024 15:25:50 +0200
Subject: [PATCH 27/33] drivers/stack/ipv4: Migrate from rtdm_printk() and
 printk() to pr_*()
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-flo-removal-of-rtdm_printk-v1-27-cc91bffdd063@siemens.com>
References: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
In-Reply-To: <20240702-flo-removal-of-rtdm_printk-v1-0-cc91bffdd063@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Some (rtdm_)printk() calls were missing log level information. The
default log level (= warn) did not fit well for them.

The missing log level is addressed by migrating to the pr_*() API.

rtdm_printk() itself is just an alias for printk(). Migrating helps to
remove this function once all drivers were updated.

No functional change.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 kernel/drivers/net/stack/ipv4/icmp.c           | 25 +++++------
 kernel/drivers/net/stack/ipv4/ip_fragment.c    | 17 +++----
 kernel/drivers/net/stack/ipv4/ip_input.c       |  4 +-
 kernel/drivers/net/stack/ipv4/protocol.c       |  4 +-
 kernel/drivers/net/stack/ipv4/route.c          | 21 ++++-----
 kernel/drivers/net/stack/ipv4/tcp/tcp.c        | 62 +++++++++++++-------------
 kernel/drivers/net/stack/ipv4/tcp/timerwheel.c |  9 ++--
 kernel/drivers/net/stack/ipv4/udp/udp.c        |  4 +-
 8 files changed, 73 insertions(+), 73 deletions(-)

diff --git a/kernel/drivers/net/stack/ipv4/icmp.c b/kernel/drivers/net/stack/ipv4/icmp.c
index c3b80b18d..d96b4fc5d 100644
--- a/kernel/drivers/net/stack/ipv4/icmp.c
+++ b/kernel/drivers/net/stack/ipv4/icmp.c
@@ -24,6 +24,8 @@
  *
  */
 
+#define pr_fmt(fmt) "RTnet: " fmt
+
 #include <linux/types.h>
 #include <linux/socket.h>
 #include <linux/in.h>
@@ -184,8 +186,7 @@ static void rt_icmp_send_reply(struct icmp_bxm *icmp_param, struct rtskb *skb)
 
 	rtdev_dereference(rt.rtdev);
 
-	RTNET_ASSERT(err == 0,
-		     rtdm_printk("RTnet: %s() error in xmit\n", __FUNCTION__););
+	RTNET_ASSERT(err == 0, pr_err("%s() error in xmit\n", __FUNCTION__););
 	(void)err;
 }
 
@@ -254,11 +255,10 @@ static int rt_icmp_glue_request_bits(const void *p, unsigned char *to,
 	unsigned long csum;
 
 	/* TODO: add support for fragmented ICMP packets */
-	RTNET_ASSERT(
-		offset == 0,
-		rtdm_printk("RTnet: %s() does not support fragmentation.\n",
+	RTNET_ASSERT(offset == 0,
+		     pr_err("%s() does not support fragmentation.\n",
 			    __FUNCTION__);
-		return -1;);
+		     return -1;);
 
 	csum = rtnet_csum_copy((void *)&icmp_param->head, to,
 			       icmp_param->head_len,
@@ -435,23 +435,22 @@ static void rt_icmp_rcv(struct rtskb *skb)
 
 	/* check header sanity and don't accept fragmented packets */
 	if ((length < sizeof(struct icmphdr)) || (skb->next != NULL)) {
-		rtdm_printk("RTnet: improper length in icmp packet\n");
+		pr_debug("improper length in icmp packet\n");
 		goto cleanup;
 	}
 
 	if (ip_compute_csum((unsigned char *)icmpHdr, length)) {
-		rtdm_printk("RTnet: invalid checksum in icmp packet %d\n",
-			    length);
+		pr_debug("invalid checksum in icmp packet %d\n", length);
 		goto cleanup;
 	}
 
 	if (!rtskb_pull(skb, sizeof(struct icmphdr))) {
-		rtdm_printk("RTnet: pull failed %p\n", (skb->sk));
+		pr_debug("pull failed %p\n", (skb->sk));
 		goto cleanup;
 	}
 
 	if (icmpHdr->type > NR_ICMP_TYPES) {
-		rtdm_printk("RTnet: invalid icmp type\n");
+		pr_debug("invalid icmp type\n");
 		goto cleanup;
 	}
 
@@ -467,7 +466,7 @@ cleanup:
  */
 static void rt_icmp_rcv_err(struct rtskb *skb)
 {
-	rtdm_printk("RTnet: rt_icmp_rcv err\n");
+	pr_err("rt_icmp_rcv err\n");
 }
 
 /***
@@ -492,7 +491,7 @@ void __init rt_icmp_init(void)
 				   ICMP_REPLY_POOL_SIZE);
 	BUG_ON(skbs < 0);
 	if (skbs < ICMP_REPLY_POOL_SIZE)
-		printk("RTnet: allocated only %d icmp rtskbs\n", skbs);
+		pr_debug("allocated only %d icmp rtskbs\n", skbs);
 
 	icmp_socket->prot.inet.tos = 0;
 	icmp_fd->refs = 1;
diff --git a/kernel/drivers/net/stack/ipv4/ip_fragment.c b/kernel/drivers/net/stack/ipv4/ip_fragment.c
index 113a71238..d20cbf52b 100644
--- a/kernel/drivers/net/stack/ipv4/ip_fragment.c
+++ b/kernel/drivers/net/stack/ipv4/ip_fragment.c
@@ -19,6 +19,8 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#define pr_fmt(fmt) "RTnet: " fmt
+
 #include <linux/module.h>
 #include <net/checksum.h>
 #include <net/ip.h>
@@ -96,7 +98,7 @@ static void alloc_collector(struct rtskb *skb, struct rtsocket *sock)
 		rtdm_lock_put_irqrestore(&p_coll->frags.lock, context);
 	}
 
-	rtdm_printk("RTnet: IP fragmentation - no collector available\n");
+	pr_err("IP fragmentation - no collector available\n");
 	kfree_rtskb(skb);
 }
 
@@ -132,10 +134,9 @@ static struct rtskb *add_to_collector(struct rtskb *skb, unsigned int offset,
 							 context);
 
 #ifdef FRAG_DBG
-				rtdm_printk(
-					"RTnet: Compensation pool empty - IP fragments "
-					"dropped (saddr:%x, daddr:%x)\n",
-					iph->saddr, iph->daddr);
+				pr_err("Compensation pool empty - IP fragments "
+				       "dropped (saddr:%x, daddr:%x)\n",
+				       iph->saddr, iph->daddr);
 #endif
 
 				kfree_rtskb(first_skb);
@@ -197,9 +198,9 @@ static struct rtskb *add_to_collector(struct rtskb *skb, unsigned int offset,
 #endif
 
 #ifdef FRAG_DBG
-	rtdm_printk("RTnet: Unordered IP fragment (saddr:%x, daddr:%x)"
-		    " - dropped\n",
-		    iph->saddr, iph->daddr);
+	pr_info("Unordered IP fragment (saddr:%x, daddr:%x)"
+		" - dropped\n",
+		iph->saddr, iph->daddr);
 #endif
 
 	kfree_rtskb(skb);
diff --git a/kernel/drivers/net/stack/ipv4/ip_input.c b/kernel/drivers/net/stack/ipv4/ip_input.c
index 26642ef6f..933e38b56 100644
--- a/kernel/drivers/net/stack/ipv4/ip_input.c
+++ b/kernel/drivers/net/stack/ipv4/ip_input.c
@@ -21,6 +21,8 @@
  *
  */
 
+#define pr_fmt(fmt) "RTnet: " fmt
+
 #include <linux/bitops.h>
 #include <net/checksum.h>
 #include <net/ip.h>
@@ -102,7 +104,7 @@ static inline void rt_ip_local_deliver(struct rtskb *skb)
 #endif /* CONFIG_XENO_DRIVERS_NET_ADDON_PROXY */
 	} else {
 		if (IS_ENABLED(CONFIG_XENO_DRIVERS_NET_RTIPV4_DEBUG))
-			rtdm_printk("RTnet: no protocol found\n");
+			pr_err("no protocol found\n");
 		kfree_rtskb(skb);
 	}
 }
diff --git a/kernel/drivers/net/stack/ipv4/protocol.c b/kernel/drivers/net/stack/ipv4/protocol.c
index f56177da8..bd74b05ba 100644
--- a/kernel/drivers/net/stack/ipv4/protocol.c
+++ b/kernel/drivers/net/stack/ipv4/protocol.c
@@ -23,6 +23,8 @@
  *
  */
 
+#define pr_fmt(fmt) "RTnet: " fmt
+
 #include <linux/socket.h>
 #include <linux/in.h>
 
@@ -80,7 +82,7 @@ int rt_inet_socket(struct rtdm_fd *fd, int protocol)
 	if ((prot != NULL) && (prot->protocol == protocol))
 		return prot->init_socket(fd);
 	else {
-		rtdm_printk("RTnet: protocol with id %d not found\n", protocol);
+		pr_err("protocol with id %d not found\n", protocol);
 
 		return -ENOPROTOOPT;
 	}
diff --git a/kernel/drivers/net/stack/ipv4/route.c b/kernel/drivers/net/stack/ipv4/route.c
index d9a9c8b9b..0863c9d03 100644
--- a/kernel/drivers/net/stack/ipv4/route.c
+++ b/kernel/drivers/net/stack/ipv4/route.c
@@ -22,6 +22,8 @@
  *
  */
 
+#define pr_fmt(fmt) "RTnet: " fmt
+
 #include <linux/moduleparam.h>
 #include <net/ip.h>
 
@@ -479,7 +481,7 @@ err2:
 	xnvfile_destroy_regular(&rtnet_ipv4_route_vfile);
 
 err1:
-	printk("RTnet: unable to initialize /proc entries (route)\n");
+	pr_err("unable to initialize /proc entries (route)\n");
 	return err;
 }
 
@@ -588,8 +590,7 @@ int rt_ip_route_add_host(u32 addr, unsigned char *dev_addr,
 	} else {
 		rtdm_lock_put_irqrestore(&host_table_lock, context);
 
-		/*ERRMSG*/ rtdm_printk(
-			"RTnet: no more host routes available\n");
+		/*ERRMSG*/ pr_err("no more host routes available\n");
 		ret = -ENOBUFS;
 	}
 
@@ -806,8 +807,7 @@ int rt_ip_route_add_net(u32 addr, u32 mask, u32 gw_addr)
 	} else {
 		rtdm_lock_put_irqrestore(&net_table_lock, context);
 
-		/*ERRMSG*/ rtdm_printk(
-			"RTnet: no more network routes available\n");
+		/*ERRMSG*/ pr_err("no more network routes available\n");
 		return -ENOBUFS;
 	}
 }
@@ -970,8 +970,7 @@ restart:
 	}
 #endif /* CONFIG_XENO_DRIVERS_NET_RTIPV4_NETROUTING */
 
-	/*ERRMSG*/ rtdm_printk("RTnet: host %u.%u.%u.%u unreachable\n",
-			       NIPQUAD(daddr));
+	/*ERRMSG*/ pr_err("host %u.%u.%u.%u unreachable\n", NIPQUAD(daddr));
 	return -EHOSTUNREACH;
 }
 
@@ -987,15 +986,13 @@ int rt_ip_route_forward(struct rtskb *rtskb, u32 daddr)
 		return 0;
 
 	if (rtskb_acquire(rtskb, &global_pool) != 0) {
-		/*ERRMSG*/ rtdm_printk(
-			"RTnet: router overloaded, dropping packet\n");
+		/*ERRMSG*/ pr_err("router overloaded, dropping packet\n");
 		goto error;
 	}
 
 	if (rt_ip_route_output(&dest, daddr, INADDR_ANY) < 0) {
-		/*ERRMSG*/ rtdm_printk(
-			"RTnet: unable to forward packet from %u.%u.%u.%u\n",
-			NIPQUAD(rtskb->nh.iph->saddr));
+		/*ERRMSG*/ pr_err("unable to forward packet from %u.%u.%u.%u\n",
+				  NIPQUAD(rtskb->nh.iph->saddr));
 		goto error;
 	}
 
diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
index 8e174507c..12896f646 100644
--- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
+++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
@@ -19,6 +19,8 @@
  *
  */
 
+#define pr_fmt(fmt) "rttcp: " fmt
+
 #include <linux/moduleparam.h>
 #include <linux/list.h>
 #include <linux/skbuff.h>
@@ -441,7 +443,7 @@ static void rt_tcp_retransmit_handler(void *data)
 	if (unlikely(rtskb_queue_empty(&ts->retransmit_queue))) {
 		/* handled, but retransmission queue is empty */
 		rtdm_lock_get_irqsave(&ts->socket_lock, context);
-		rtdm_printk("rttcp: bug in RT TCP retransmission routine\n");
+		pr_err("bug in RT TCP retransmission routine\n");
 		return;
 	}
 
@@ -464,8 +466,7 @@ static void rt_tcp_retransmit_handler(void *data)
 		/* BUG, window changes are not respected */
 		if (unlikely(rtdev_xmit(skb)) != 0) {
 			kfree_rtskb(skb);
-			rtdm_printk(
-				"rttcp: packet retransmission from timer failed\n");
+			pr_err("packet retransmission from timer failed\n");
 		}
 	} else {
 		ts->timer_state = max_retransmits;
@@ -478,7 +479,7 @@ static void rt_tcp_retransmit_handler(void *data)
 			rt_tcp_socket_invalidate_signal(ts);
 
 		/* retransmission queue will be cleaned up in rt_tcp_socket_destruct */
-		rtdm_printk("rttcp: connection is lost by NACK timeout\n");
+		pr_err("connection is lost by NACK timeout\n");
 	}
 }
 
@@ -604,7 +605,7 @@ static int rt_ip_build_frame(struct rtskb *skb, struct rtsocket *sk,
 	rtdev_dereference(rt->rtdev);
 
 	if (ret != rtdev->hard_header_len) {
-		rtdm_printk("rttcp: rt_ip_build_frame: error on lower level\n");
+		pr_err("rt_ip_build_frame: error on lower level\n");
 		return -EINVAL;
 	}
 
@@ -670,8 +671,7 @@ static int rt_tcp_segment(struct dest_route *rt, struct tcp_socket *ts,
 	u8 *data = NULL;
 
 	if ((skb = alloc_rtskb(mtu + hh_len + 15, &sk->skb_pool)) == NULL) {
-		rtdm_printk(
-			"rttcp: no more elements in skb_pool for allocation\n");
+		pr_err("no more elements in skb_pool for allocation\n");
 		return -ENOBUFS;
 	}
 
@@ -719,7 +719,7 @@ static int rt_tcp_segment(struct dest_route *rt, struct tcp_socket *ts,
 		cloned_skb = rtskb_clone(skb, &ts->sock.skb_pool);
 		if (!cloned_skb) {
 			rtdm_lock_put_irqrestore(&ts->socket_lock, context);
-			rtdm_printk("rttcp: cann't clone skb\n");
+			pr_err("can't clone skb\n");
 			ret = -ENOMEM;
 			goto error;
 		}
@@ -769,7 +769,7 @@ static int rt_tcp_send(struct tcp_socket *ts, __be32 flags)
 		}
 	}
 	if (ret < 0)
-		rtdm_printk("rttcp: can't send a packet: err %d\n", -ret);
+		pr_err("can't send a packet: err %d\n", -ret);
 	return ret;
 }
 
@@ -833,15 +833,15 @@ static struct rtsocket *rt_tcp_dest_socket(struct rtskb *skb)
 
 	if (tcp_v4_check(skb->len, saddr, daddr,
 			 rtnet_csum(skb->data, skb->len, 0))) {
-		rtdm_printk("rttcp: invalid TCP packet checksum, dropped\n");
+		pr_err("invalid TCP packet checksum, dropped\n");
 		return NULL; /* Invalid checksum, drop the packet */
 	}
 
 	/* find the destination socket */
 	if ((skb->sk = rt_tcp_v4_lookup(daddr, dport)) == NULL) {
 		/*
-	  rtdm_printk("Not found addr:0x%08x, port: 0x%04x\n", daddr, dport);
-	*/
+		pr_debug("Not found addr:0x%08x, port: 0x%04x\n", daddr, dport);
+		*/
 		if (!th->rst) {
 			/* No listening socket found, send RST|ACK */
 			rst_socket.saddr = daddr;
@@ -984,17 +984,16 @@ static void rt_tcp_rcv(struct rtskb *skb)
 		    /* but reset ack from old connection */
 		    ts->tcp_state == TCP_ESTABLISHED) {
 			rtdm_lock_put_irqrestore(&ts->socket_lock, context);
-			rtdm_printk(
-				"rttcp: dropped unappropriate ACK packet %u\n",
-				ts->sync.ack_seq);
+			pr_debug("dropped unappropriate ACK packet %u\n",
+				 ts->sync.ack_seq);
 			goto drop;
 		}
 
 		rtdm_lock_put_irqrestore(&ts->socket_lock, context);
-		rtdm_printk("rttcp: sequence number is not in window, "
-			    "dropped (failed: %u <= %u <= %u)\n",
-			    ts->sync.ack_seq, seq,
-			    ts->sync.ack_seq + ts->sync.window);
+		pr_debug("sequence number is not in window, "
+			 "dropped (failed: %u <= %u <= %u)\n",
+			 ts->sync.ack_seq, seq,
+			 ts->sync.ack_seq + ts->sync.window);
 
 		/* That's a forced RST for a lost connection */
 		rst_socket.saddr = skb->nh.iph->daddr;
@@ -1104,7 +1103,7 @@ static void rt_tcp_rcv(struct rtskb *skb)
 	if (th->ack) {
 		/* Check ack sequence */
 		if (rt_tcp_before(ts->sync.seq + 1, ntohl(th->ack_seq))) {
-			rtdm_printk("rttcp: unexpected ACK %u %u %u\n",
+			pr_debug("unexpected ACK %u %u %u\n",
 				    ts->sync.seq, ts->nacked_first,
 				    ntohl(th->ack_seq));
 			rtdm_lock_put_irqrestore(&ts->socket_lock, context);
@@ -1183,7 +1182,7 @@ drop:
  */
 static void rt_tcp_rcv_err(struct rtskb *skb)
 {
-	rtdm_printk("rttcp: rt_tcp_rcv err\n");
+	pr_err("rt_tcp_rcv err\n");
 }
 
 static int rt_tcp_window_send(struct tcp_socket *ts, u32 data_len, u8 *data_ptr)
@@ -1196,7 +1195,7 @@ static int rt_tcp_window_send(struct tcp_socket *ts, u32 data_len, u8 *data_ptr)
 
 	if ((ret = rt_tcp_segment(&ts->rt, ts, TCP_FLAG_ACK, data_len, data_ptr,
 				  0)) < 0) {
-		rtdm_printk("rttcp: cann't send a packet: err %d\n", -ret);
+		pr_err("can't send a packet: err %d\n", -ret);
 		return ret;
 	}
 
@@ -1219,8 +1218,8 @@ static int rt_tcp_socket_create(struct tcp_socket *ts)
 	sock->prot.inet.state = TCP_CLOSE;
 	sock->prot.inet.tos = 0;
 	/*
-      rtdm_printk("rttcp: rt_tcp_socket_create 0x%p\n", ts);
-    */
+	pr_debug("rt_tcp_socket_create 0x%p\n", ts);
+	*/
 	rtdm_lock_init(&ts->socket_lock);
 
 	ts->rt.rtdev = NULL;
@@ -1325,8 +1324,8 @@ static void rt_tcp_socket_destruct(struct tcp_socket *ts)
 	struct rtsocket *sock = &ts->sock;
 
 	/*
-      rtdm_printk("rttcp: rt_tcp_socket_destruct 0x%p\n", ts);
-    */
+	pr_debug("rt_tcp_socket_destruct 0x%p\n", ts);
+	*/
 
 	rtdm_lock_get_irqsave(&tcp_socket_base_lock, context);
 	if (sock->prot.inet.reg_index >= 0) {
@@ -1570,7 +1569,7 @@ static int rt_tcp_connect(struct rtdm_fd *fd, struct tcp_socket *ts,
 	/* Complete three-way handshake */
 	ret = rt_tcp_send(ts, TCP_FLAG_SYN);
 	if (ret < 0) {
-		rtdm_printk("rttcp: cann't send SYN\n");
+		pr_err("can't send SYN\n");
 		return ret;
 	}
 
@@ -2415,7 +2414,7 @@ static int __init rt_tcp_init(void)
 	skbs = rt_bare_socket_init(rst_fd, IPPROTO_TCP, RT_TCP_RST_PRIO,
 				   RT_TCP_RST_POOL_SIZE);
 	if (skbs < RT_TCP_RST_POOL_SIZE)
-		printk("rttcp: allocated only %d RST|ACK rtskbs\n", skbs);
+		pr_debug("allocated only %d RST|ACK rtskbs\n", skbs);
 	rst_socket.sock.prot.inet.tos = 0;
 	rst_fd->refs = 1;
 	rtdm_lock_init(&rst_socket.socket_lock);
@@ -2425,14 +2424,13 @@ static int __init rt_tcp_init(void)
      */
 	ret = timerwheel_init(100000000ull, 23);
 	if (ret < 0) {
-		rtdm_printk("rttcp: cann't initialize timerwheel task: %d\n",
-			    -ret);
+		pr_err("can't initialize timerwheel task: %d\n", -ret);
 		goto out_1;
 	}
 
 #ifdef CONFIG_XENO_OPT_VFILE
 	if ((ret = rt_tcp_proc_register()) < 0) {
-		rtdm_printk("rttcp: cann't initialize proc entry: %d\n", -ret);
+		pr_err("can't initialize proc entry: %d\n", -ret);
 		goto out_2;
 	}
 #endif /* CONFIG_XENO_OPT_VFILE */
@@ -2441,7 +2439,7 @@ static int __init rt_tcp_init(void)
 
 	ret = rtdm_dev_register(&tcp_device);
 	if (ret < 0) {
-		rtdm_printk("rttcp: cann't register RT TCP: %d\n", -ret);
+		pr_err("can't register RT TCP: %d\n", -ret);
 		goto out_3;
 	}
 
diff --git a/kernel/drivers/net/stack/ipv4/tcp/timerwheel.c b/kernel/drivers/net/stack/ipv4/tcp/timerwheel.c
index 240837dff..6c8bf7e66 100644
--- a/kernel/drivers/net/stack/ipv4/tcp/timerwheel.c
+++ b/kernel/drivers/net/stack/ipv4/tcp/timerwheel.c
@@ -19,6 +19,8 @@
  *
  */
 
+#define pr_fmt(fmt) "timerwheel: " fmt
+
 #include <linux/delay.h>
 #include <linux/slab.h>
 
@@ -125,9 +127,7 @@ static void timerwheel_pivot(void *arg)
 	while (1) {
 		ret = timerwheel_sleep();
 		if (ret < 0) {
-			rtdm_printk(
-				"timerwheel: timerwheel_pivot interrupted %d\n",
-				-ret);
+			pr_err("timerwheel_pivot interrupted %d\n", -ret);
 			break;
 		}
 
@@ -205,8 +205,7 @@ int __init timerwheel_init(nanosecs_rel_t timeout, unsigned int granularity)
 	err = rtdm_task_init(&wheel.pivot_task, "rttcp timerwheel",
 			     timerwheel_pivot, NULL, 1, 0);
 	if (err) {
-		printk("timerwheel: error on pivot task initialization: %d\n",
-		       err);
+		pr_err("error on pivot task initialization: %d\n", err);
 		kfree(wheel.ring);
 	}
 
diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
index 8ace7af06..5018ba807 100644
--- a/kernel/drivers/net/stack/ipv4/udp/udp.c
+++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
@@ -22,6 +22,8 @@
  *
  */
 
+#define pr_fmt(fmt) "RTnet: " fmt
+
 #include <linux/moduleparam.h>
 #include <linux/socket.h>
 #include <linux/in.h>
@@ -754,7 +756,7 @@ static void rt_udp_rcv(struct rtskb *skb)
  */
 static void rt_udp_rcv_err(struct rtskb *skb)
 {
-	rtdm_printk("RTnet: rt_udp_rcv err\n");
+	pr_err("rt_udp_rcv err\n");
 }
 
 /***

-- 
2.39.2

