From: Sebastian Smolorz <Sebastian.Smolorz@gmx.de>
Subject: Re: [PATCH 0/4] net/tcp: Fix several bugs and allow rttcp to be built
Date: Fri, 02 Nov 2018 17:12:28 +0100
Message-ID: <2257961.2rJi6RV1SI@lenni>
In-Reply-To: <4717946.93qni4ym1a@lenni>
References: <1539775907-5124-1-git-send-email-sebastian.smolorz@gmx.de>
 <62f6ce84-8672-c6d4-a1a2-d9bc996c9ef0@siemens.com> <4717946.93qni4ym1a@lenni>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "Hillman,
 Robert" <hillman@ddc-web.com>

Sebastian Smolorz wrote:
> On 31.10.18 19:18, Jan Kiszka wrote:
> > On 31.10.18 17:55, Pham, Phong wrote:
> > > Hi Sebastian,
> > > 
> > > The issue has to do with endianness.  We are running PowerPC (big
> > > endian).  So in rt_tcp_set_flags(), flags is 32-bit wide and *tf
> > > is
> > > 16-bit wide.  I modified the line from:
> > > 
> > > *tf = flags;
> > > 
> > > to
> > > 
> > > *tf = *(__be16 *)&flags;
> > 
> > Something is fishy with rt_tcp_set_flags. Shouldn't we rather ensure
> > that only a __be16 flag value is passed to it?
> 
> I think the reason why flags are passed as __be32 is that they are
> defined with the help of __constant_cpu_to_be32().
> 
> After reading some TCP related code in the kernel I think that this
> issue is properly fixed by
> 
> tcp_flag_word(th) = flags;
> 
> I will test this for little endian. Phong, can you test this on your
> machine?

The following patch works for me on little endian:

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
Sebastian




