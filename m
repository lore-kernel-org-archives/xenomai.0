From: =?UTF-8?q?Jean-Baptiste=20Tr=C3=A9dez?=
 <jean-baptiste.tredez@ba-healthcare.com>
Subject: [PATCH 6/7] net/drivers: fec: fix dev_kfree_rtskb on wrong buffer
Date: Wed, 28 Jul 2021 09:28:01 +0200
Message-Id: <20210728072802.5816-7-jean-baptiste.tredez@ba-healthcare.com>
In-Reply-To: <20210728072802.5816-1-jean-baptiste.tredez@ba-healthcare.com>
References: <20210728072802.5816-1-jean-baptiste.tredez@ba-healthcare.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Signed-off-by: Jean-Baptiste Trédez <jean-baptiste.tredez@ba-healthcare.com>
---
 kernel/drivers/net/drivers/freescale/fec_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/net/drivers/freescale/fec_main.c b/kernel/drivers/net/drivers/freescale/fec_main.c
index 0fc754e63..bb56d0e43 100644
--- a/kernel/drivers/net/drivers/freescale/fec_main.c
+++ b/kernel/drivers/net/drivers/freescale/fec_main.c
@@ -1145,7 +1145,7 @@ static void fec_enet_reset_skb(struct net_device *ndev)
 		for (j = 0; j < txq->bd.ring_size; j++) {
 			if (txq->tx_skbuff[j]) {
 				if (fep->rtnet.enabled)
-					dev_kfree_rtskb(txq->tx_rtbuff[i]);
+					dev_kfree_rtskb(txq->tx_rtbuff[j]);
 				else
 					dev_kfree_skb_any(txq->tx_skbuff[j]);
 				txq->tx_skbuff[j] = NULL;
-- 
2.17.1


