From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 09/18] net/stack: fresh rtskb should have ip_summed set to
 CHECKSUM_NONE
Date: Mon,  4 Feb 2019 11:56:38 +0100
Message-Id: <20190204105647.5034-10-rpm@xenomai.org>
In-Reply-To: <20190204105647.5034-1-rpm@xenomai.org>
References: <20190204105647.5034-1-rpm@xenomai.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/stack/rtskb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/drivers/net/stack/rtskb.c b/kernel/drivers/net/stack/rtskb.c
index f5609027b..cc7563719 100644
--- a/kernel/drivers/net/stack/rtskb.c
+++ b/kernel/drivers/net/stack/rtskb.c
@@ -223,6 +223,7 @@ struct rtskb *alloc_rtskb(unsigned int size, struct rtskb_pool *pool)
     skb->len = 0;
     skb->pkt_type = PACKET_HOST;
     skb->xmit_stamp = NULL;
+    skb->ip_summed = CHECKSUM_NONE;
 
 #if IS_ENABLED(CONFIG_XENO_DRIVERS_NET_ADDON_RTCAP)
     skb->cap_flags = 0;
-- 
2.17.2


