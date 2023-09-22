Received: from mail-01-1.mymagenta.at (mail-01-1.mymagenta.at [80.109.253.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C174419
	for <xenomai@lists.linux.dev>; Fri, 22 Sep 2023 09:01:44 +0000 (UTC)
Received: from [192.168.232.135] (helo=ren-mail-psmtp-mg01.)
	by mail-01.mymagenta.at with esmtp (Exim 4.93)
	(envelope-from <martin.elshuber@chello.at>)
	id 1qjc2f-008PIi-GG
	for xenomai@lists.linux.dev; Fri, 22 Sep 2023 11:01:41 +0200
Received: from theobroma-systems.com
 ([IPv6:2001:871:22c:e819:e254:4206:be7a:b595])
	by ren-mail-psmtp-mg01. with ESMTPA
	id jc2FquadbeboCjc2cqq5jg; Fri, 22 Sep 2023 11:01:38 +0200
X-Env-Mailfrom: martin.elshuber@chello.at
X-Env-Rcptto: xenomai@lists.linux.dev
X-SourceIP: 2001:871:22c:e819:e254:4206:be7a:b595
X-CNFS-Analysis: v=2.4 cv=c5PI/Txl c=1 sm=1 tr=0 ts=650d57f2
 a=hJFyE5+EYuf3O8AJ+kz6Ug==:617 a=xqWC_Br6kY4A:10 a=NXpJzYs8AAAA:8
 a=jilmSIHVzxy82u5s5T4A:9 a=cwV61pgf2j4Cq8VD9hE_:22
X-Authenticated-Sender: martin.elshuber@chello.at
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=chello.at;
	s=201801custpemceu; t=1695373298;
	bh=Q0+uIYxhr17TehR9fziqv4gu6eWCrX+iB0d2dNkLKhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=1Au70uaxYbQNWj0KiYcCOtRnSbJj43ENGjzJFPjzK/Gk8UByKs1wy5TVfEDwmF5Ny
	 kKKLW0Z82pYU8H2pc4rApXVRxuh43reAZL6+eCRmvI3pEEGhCAMZ293sCbZehfipiO
	 QJOJsUdoIR1UmqrqjaK1jAHdewbx1g1lGR3VH1x9H54LYl57is6vE2HmszkN4p7RKb
	 JzSC4EzC67z5nLAmd7P0pedhZL/bun/FXYNaYaOSq3M1+/UPlCDNrstaxRFCKsgdwc
	 HoyGvo3ATF9ipC6y5IKz8wKaEweJ0LSWrm4dr40Tftd2e7QR0trySyyKg7UndWf88J
	 5oJqhQWyXd9HA==
From: Martin Elshuber <martin.elshuber@chello.at>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>,
	Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai @ lists . linux . dev" <xenomai@lists.linux.dev>,
	Martin Elshuber <martin.elshuber@theobroma-systems.com>
Subject: [PATCH 1/1] rtnet: icmp.c: fix rt_icmp_dest_socket triggering a NULL pointer violation
Date: Fri, 22 Sep 2023 11:01:12 +0200
Message-Id: <20230922090112.344174-2-martin.elshuber@chello.at>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922090112.344174-1-martin.elshuber@chello.at>
References: <20230922090112.344174-1-martin.elshuber@chello.at>
Reply-To: Martin Elshuber <martin.elshuber@theobroma-systems.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFGNbS3zF40awYGqRvcbhzO5yCcbM+48JVe8XMmmbqGNHX/YIOBnYjABESDOtf6p12Dd57GL3obEjGpgFtlYt79rN7LBIuBxJ1bTrmLkhmsbdE9o5LPS
 jNQaqoqLoHMnD/zD0EmEFebQt7Nu105IF/pSYv3io/cS0eM8BscZYK0eEIG8+j8NqWFoB4fTuIr8FyAqNA39XkbT0jEb4msTshumypDUcK8pPsAJyR0FBmWl
 FAsfyvWznrdTLTexnzQ/khYFdEI3cSBYgGgpAUoQGh919YpfGomf7kZ2U4+CL5gRDYd9DqcEwJmTSxjaH27eUYsPRdWONfFvQ5E7ieWuTriUAr7+ztgxcBnu
 xTTr+X/mzM8GeC+btnlTDIYgMVFudmP7nA+RbMtiPJYU4BhQcC59KK7TRSR/HWQHKNQdGlMt

From: Martin Elshuber <martin.elshuber@theobroma-systems.com>

When the ICMP stack gets a fragmented message delivered, there is NULL
pointer violation that gets triggered when the IP stack decreases the
reference to the socket.

This is because for fragmented messages the IP expects that skb->sk is
set to the socket in question, while the socket as an increased
reference count.

Following the UDP implementation rt_udp_dest_socket this commit
assigns the the socket to the respective SKB.

Kernel Panic fixed by this patch:

[   54.217711] RTnet: improper length in icmp packet
[   54.217721] Unable to handle kernel paging request at virtual address ffffffffffffffc0
[   54.217728] Mem abort info:
[   54.217730]   ESR = 0x0000000096000004
[   54.217734]   EC = 0x25: DABT (current EL), IL = 32 bits
[   54.217741]   SET = 0, FnV = 0
[   54.217745]   EA = 0, S1PTW = 0
[   54.217748]   FSC = 0x04: level 0 translation fault
[   54.217753] Data abort info:
[   54.217755]   ISV = 0, ISS = 0x00000004
[   54.217759]   CM = 0, WnR = 0
[   54.217763] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000003319000
[   54.217771] [ffffffffffffffc0] pgd=0000000000000000, p4d=0000000000000000
[   54.217784] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[   54.217792] Modules linked in: rtnetproxy rt_loopback rtipv4 rtnet
[   54.217811] CPU: 4 PID: 225 Comm: rtnetproxy Not tainted 6.0.2 #22
[   54.217822] Hardware name: Theobroma Systems RK3399-Q7 SoM (DT)
[   54.217826] IRQ stage: Xenomai
[   54.217830] pstate: a00000c5 (NzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   54.217842] pc : __put_fd+0x1c/0x160
[   54.217858] lr : rtdm_fd_unlock+0x50/0x70
[   54.217867] sp : ffff800009ffbcc0
[   54.217871] x29: ffff800009ffbcc0 x28: 0000000000000000 x27: ffff0000042b4400
[   54.217886] x26: 0000000000000000 x25: ffff000001df8e40 x24: ffff800000c89580
[   54.217899] x23: ffff800000c89000 x22: 0000000000000000 x21: 0000000000000000
[   54.217912] x20: ffffffffffffffa8 x19: ffffffffffffffa8 x18: fffffffffffe7e40
[   54.217924] x17: 0000000000000006 x16: 0000000000000006 x15: 0000000000000030
[   54.217936] x14: 0000000000000001 x13: 0a74656b63617020 x12: 706d6369206e6920
[   54.217949] x11: 6874676e656c2072 x10: 65706f72706d6920 x9 : 7020706d6369206e
[   54.217962] x8 : ffff800009365868 x7 : ffff800009ffbba0 x6 : 000000000000000c
[   54.217973] x5 : ffff8000093e0c34 x4 : 0000000000000000 x3 : ffff8000093e0c34
[   54.217985] x2 : 0000000000000001 x1 : 0000000000000000 x0 : ffffffffffffffa8
[   54.217998] Call trace:
[   54.218001]  __put_fd+0x1c/0x160
[   54.218010]  rtdm_fd_unlock+0x50/0x70
[   54.218018]  rt_ip_rcv+0x194/0x230 [rtipv4]
[   54.218052]  rt_stack_deliver+0xc0/0x1d0 [rtnet]
[   54.218093]  rt_loopback_xmit+0x54/0x70 [rt_loopback]
[   54.218105]  rtdev_xmit_proxy+0x48/0x70 [rtnet]
[   54.218143]  rtnetproxy_tx_loop+0xa0/0x174 [rtnetproxy]
[   54.218157]  kthread_trampoline+0x1a8/0x330
[   54.218170]  kthread+0x10c/0x110
[   54.218181]  ret_from_fork+0x10/0x20
[   54.218196] Code: a90153f3 aa0003f3 a9025bf5 aa0103f5 (b9401814)
[   54.476465] ---[ end trace 0000000000000000 ]---
[   54.476470] note: rtnetproxy[225] exited with preempt_count 33554434

Signed-off-by: Martin Elshuber <martin.elshuber@theobroma-systems.com>
---
 kernel/drivers/net/stack/ipv4/icmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/drivers/net/stack/ipv4/icmp.c b/kernel/drivers/net/stack/ipv4/icmp.c
index 8485614ec..cdd22beb3 100644
--- a/kernel/drivers/net/stack/ipv4/icmp.c
+++ b/kernel/drivers/net/stack/ipv4/icmp.c
@@ -421,6 +421,7 @@ static struct rt_icmp_control rt_icmp_pointers[NR_ICMP_TYPES + 1] = {
 struct rtsocket *rt_icmp_dest_socket(struct rtskb *skb)
 {
 	rt_socket_reference(icmp_socket);
+	skb->sk = icmp_socket;
 	return icmp_socket;
 }
 
-- 
2.34.1

