From: Sebastian Smolorz <sebastian.smolorz@gmx.de>
Subject: [PATCH v2 6/8] net/tcp: Set valid flags in struct tcphdr on little
 and big endian machines
Date: Tue,  6 Nov 2018 11:00:24 +0100
Message-Id: <1541498426-2916-7-git-send-email-sebastian.smolorz@gmx.de>
In-Reply-To: <1541498426-2916-1-git-send-email-sebastian.smolorz@gmx.de>
References: <1541498426-2916-1-git-send-email-sebastian.smolorz@gmx.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Setting TCP header flags like ACK was fragile and not working when
RTnet was running on big endian processors. Use the macro provided
by the linux kernel for setting the TCP flags instead.

Signed-off-by: Sebastian Smolorz <sebastian.smolorz@gmx.de>
---
 kernel/drivers/net/stack/ipv4/tcp/tcp.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
index c066e06..134469c 100644
--- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
+++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
@@ -280,12 +280,6 @@ static inline int rt_tcp_after(__u32 seq1, __u32 seq2)
     return (__s32)(seq2-seq1) <= 0;
 }
 
-static inline void rt_tcp_set_flags(struct tcphdr* th, __be32 flags)
-{
-    __be16 *tf = ((__be16*)th) + 6;
-    *tf = flags;
-}
-
 static inline u32 rt_tcp_compute_ack_seq(struct tcphdr* th, u32 len)
 {
     u32 ack_seq = ntohl(th->seq) + len;
@@ -625,11 +619,10 @@ static void rt_tcp_build_header(struct tcp_socket *ts, struct rtskb *skb,
     if (unlikely(is_keepalive))
 	th->seq--;
 
+    tcp_flag_word(th) = flags;
     th->ack_seq = htonl(ts->sync.ack_seq);
     th->window  = htons(ts->sync.window);
 
-    rt_tcp_set_flags(th, flags);
-
     th->doff = tcphdrlen >> 2; /* No options for now */
     th->res1 = 0;
     th->check   = 0;
-- 
2.7.4


