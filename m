From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 2/3] net/rtmac: vnic: fix non-rt signal overflow
Date: Sat, 30 Nov 2019 19:39:28 +0100
Message-Id: <20191130183929.11034-2-rpm@xenomai.org>
In-Reply-To: <20191130183929.11034-1-rpm@xenomai.org>
References: <20191130183929.11034-1-rpm@xenomai.org>
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

From: Philippe Gerum <rpm@xenomai.org>

rtdm_nrtsig_pend() is based on ipipe_post_root_work(), which keeps a
copy of every request descriptor internally until it is consumed by
the secondary mode handler. Triggering rtdm_nrtsig_pend() every time a
packet is relayed from the stack to the VNIC may cause such request
buffer to overflow under pressure.

To address this issue, trigger the non-rt signal only when the RX
queue transitions from empty to non-empty state as a result of
enqueuing the next skb.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/stack/rtmac/rtmac_vnic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/net/stack/rtmac/rtmac_vnic.c b/kernel/drivers/net/stack/rtmac/rtmac_vnic.c
index 85ee35002..138e276ad 100644
--- a/kernel/drivers/net/stack/rtmac/rtmac_vnic.c
+++ b/kernel/drivers/net/stack/rtmac/rtmac_vnic.c
@@ -52,8 +52,8 @@ int rtmac_vnic_rx(struct rtskb *rtskb, u16 type)
 
 	rtskb->protocol = type;
 
-	rtskb_queue_tail(&rx_queue, rtskb);
-	rtdm_nrtsig_pend(&vnic_signal);
+	if (rtskb_queue_tail_check(&rx_queue, rtskb))
+		rtdm_nrtsig_pend(&vnic_signal);
 
 	return 0;
 }
-- 
2.21.0


