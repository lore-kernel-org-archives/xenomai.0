From: =?UTF-8?q?Jean-Baptiste=20Tr=C3=A9dez?=
 <jean-baptiste.tredez@alstefgroup.com>
Subject: [PATCH 13/31] net/drivers: e1000e: enable VLAN filtering
Date: Tue, 11 May 2021 18:05:17 +0200
Message-Id: <20210511160535.26580-14-jean-baptiste.tredez@alstefgroup.com>
In-Reply-To: <20210511160535.26580-1-jean-baptiste.tredez@alstefgroup.com>
References: <20210511160535.26580-1-jean-baptiste.tredez@alstefgroup.com>
Content-Type: text/plain
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

From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/drivers/e1000e/netdev.c | 28 ++++------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/kernel/drivers/net/drivers/e1000e/netdev.c b/kernel/drivers/net/drivers/e1000e/netdev.c
index a75afa808..4042cbd1a 100644
--- a/kernel/drivers/net/drivers/e1000e/netdev.c
+++ b/kernel/drivers/net/drivers/e1000e/netdev.c
@@ -1756,21 +1756,6 @@ static void e1000e_vlan_strip_disable(struct e1000_adapter *adapter)
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
@@ -2181,29 +2166,24 @@ static void e1000_set_multi(struct rtnet_device *netdev)
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
 		e1000e_vlan_strip_disable(adapter);
 }
 
@@ -4014,6 +3994,8 @@ static int e1000_probe(struct pci_dev *pdev,
 
 	netdev->mem_start = mmio_start;
 	netdev->mem_end = mmio_start + mmio_len;
+	netdev->vlan_rx_add_vid = e1000_vlan_rx_add_vid;
+	netdev->vlan_rx_kill_vid = e1000_vlan_rx_kill_vid;
 
 	adapter->bd_number = cards_found++;
 
-- 
2.17.1


