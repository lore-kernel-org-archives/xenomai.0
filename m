From: Marc =?ISO-8859-1?Q?Str=E4mke?= <marc.straemke@eltropuls.de>
Date: Thu, 04 Jun 2015 13:12:27 +0200
Message-ID: <4852939.sydttErcHR@eltrolinux48.eltroad.eltropuls>
In-Reply-To: <2172332.WGhck7t4nv@eltrolinux48.eltroad.eltropuls>
References: <2745691.a91SqWkUDm@eltrolinux48.eltroad.eltropuls>
 <20150604105616.GS27570@hermes.click-hack.org>
 <2172332.WGhck7t4nv@eltrolinux48.eltroad.eltropuls>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] Proof of concept: disable locking in af_packet
	skb pool
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

---
 kernel/drivers/net/stack/packet/af_packet.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/drivers/net/stack/packet/af_packet.c 
b/kernel/drivers/net/stack/packet/af_packet.c
index 4c7ff57..9f5e417 100644
--- a/kernel/drivers/net/stack/packet/af_packet.c
+++ b/kernel/drivers/net/stack/packet/af_packet.c
@@ -190,6 +190,19 @@ static int rt_packet_getsockname(struct rtsocket *sock, 
struct sockaddr *addr,
 }
 
 
+static int rtskb_nop_trylock(void *cookie)
+{
+    return 1;
+}
+
+static void rtskb_nop_unlock(void *cookie)
+{
+}
+
+static const struct rtskb_pool_lock_ops rtskb_nop_lock_ops = {
+    .trylock = rtskb_nop_trylock,
+    .unlock = rtskb_nop_unlock,
+};
 
 /***
  * rt_packet_socket - initialize a packet socket
@@ -202,6 +215,8 @@ static int rt_packet_socket(struct rtdm_fd *fd, int 
protocol)
 
     if ((ret = rt_socket_init(fd, protocol)) != 0)
        return ret;
+    sock->skb_pool.lock_ops = &rtskb_module_lock_ops;
+
 
     sock->prot.packet.packet_type.type         = protocol;
     sock->prot.packet.ifindex                  = 0;
-- 
2.2.0
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: This is a digitally signed message part.
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150604/daf9252e/attachment.sig>
