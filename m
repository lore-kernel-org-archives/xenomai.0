From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 12/16] net/drivers: e1000e: enable VLAN filtering
Date: Thu, 21 Mar 2019 18:13:26 +0100
Message-Id: <20190321171330.2073-13-rpm@xenomai.org>
In-Reply-To: <20190321171330.2073-1-rpm@xenomai.org>
References: <20190321171330.2073-1-rpm@xenomai.org>
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
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/drivers/e1000e/netdev.c | 30 +++++-----------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/kernel/drivers/net/drivers/e1000e/netdev.c b/kernel/drivers/net/drivers/e1000e/netdev.c
index 7b49a795d..0754a244f 100644
--- a/kernel/drivers/net/drivers/e1000e/netdev.c
+++ b/kernel/drivers/net/drivers/e1000e/netdev.c
@@ -1753,21 +1753,6 @@ static void e1000e_vlan_strip_disable(struct e1000_adapter *adapter)
 	ew32(CTRL, ctrl);
 }
 
-/**
- * e1000e_vlan_strip_enable - helper to enable HW VLAN stripping
- * @adapter: board private structure to initialize
- **/
-static void e1000e_vlan_strip_enable(struct e1000_adapter *adapter)
-{
-	struct e1000_hw *hw = &adapter->hw;
-	u32 ctrl;
-
-	/* enable VLAN tag insert/strip */
-	ctrl = er32(CTRL);
-	ctrl |= E1000_CTRL_VME;
-	ew32(CTRL, ctrl);
-}
-
 static void e1000_update_mng_vlan(struct e1000_adapter *adapter)
 {
 	struct rtnet_device *netdev = adapter->netdev;
@@ -2177,30 +2162,25 @@ static void e1000_set_multi(struct rtnet_device *netdev)
 	/* Check for Promiscuous and All Multicast modes */
 
 	rctl = er32(RCTL);
+	rctl &= ~(E1000_RCTL_UPE | E1000_RCTL_MPE);
 
 	if (netdev->flags & IFF_PROMISC) {
 		rctl |= (E1000_RCTL_UPE | E1000_RCTL_MPE);
-		rctl &= ~E1000_RCTL_VFE;
 		/* Do not hardware filter VLANs in promisc mode */
 		e1000e_vlan_filter_disable(adapter);
 	} else {
 		if (netdev->flags & IFF_ALLMULTI) {
 			rctl |= E1000_RCTL_MPE;
-			rctl &= ~E1000_RCTL_UPE;
 		} else {
-			rctl &= ~(E1000_RCTL_UPE | E1000_RCTL_MPE);
+			e1000_update_mc_addr_list(hw, netdev->mc_list, netdev->mc_count);
 		}
 		e1000e_vlan_filter_enable(adapter);
+		rctl |= E1000_RCTL_UPE;
 	}
 
 	ew32(RCTL, rctl);
 
-	e1000_update_mc_addr_list(hw, netdev->mc_list, netdev->mc_count);
-
-	if (netdev->features & NETIF_F_HW_VLAN_CTAG_RX)
-		e1000e_vlan_strip_enable(adapter);
-	else
-		e1000e_vlan_strip_disable(adapter);
+	e1000e_vlan_strip_disable(adapter);
 }
 
 /**
@@ -3995,6 +3975,8 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	netdev->mem_start = mmio_start;
 	netdev->mem_end = mmio_start + mmio_len;
+	netdev->vlan_rx_add_vid = e1000_vlan_rx_add_vid;
+	netdev->vlan_rx_kill_vid = e1000_vlan_rx_kill_vid;
 
 	adapter->bd_number = cards_found++;
 
-- 
2.20.1


