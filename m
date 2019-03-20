From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 4/5] net/drivers: macb: do not check for initial checksum value
Date: Wed, 20 Mar 2019 16:44:24 +0100
Message-Id: <20190320154425.30639-5-rpm@xenomai.org>
In-Reply-To: <20190320154425.30639-1-rpm@xenomai.org>
References: <20190320154425.30639-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

See https://www.xenomai.org/pipermail/xenomai/2019-February/040321.html.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/drivers/macb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/drivers/net/drivers/macb.c b/kernel/drivers/net/drivers/macb.c
index 8a6a10f9c..fc5b6679a 100644
--- a/kernel/drivers/net/drivers/macb.c
+++ b/kernel/drivers/net/drivers/macb.c
@@ -725,7 +725,6 @@ static int gem_rx(struct macb *bp, int budget, nanosecs_abs_t *time_stamp)
 				 bp->rx_buffer_size, DMA_FROM_DEVICE);
 
 		skb->protocol = rt_eth_type_trans(skb, bp->dev);
-		rtskb_checksum_none_assert(skb);
 
 		bp->stats.rx_packets++;
 		bp->stats.rx_bytes += skb->len;
@@ -792,7 +791,6 @@ static int macb_rx_frame(struct macb *bp, unsigned int first_frag,
 	offset = 0;
 	len += NET_IP_ALIGN;
 	skb->time_stamp = *time_stamp;
-	rtskb_checksum_none_assert(skb);
 	rtskb_put(skb, len);
 
 	for (frag = first_frag; ; frag++) {
-- 
2.20.1


