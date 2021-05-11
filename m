From: =?UTF-8?q?Jean-Baptiste=20Tr=C3=A9dez?=
 <jean-baptiste.tredez@alstefgroup.com>
Subject: [PATCH 16/31] net/drivers: igb: enable VLAN filtering
Date: Tue, 11 May 2021 18:05:20 +0200
Message-Id: <20210511160535.26580-17-jean-baptiste.tredez@alstefgroup.com>
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
 kernel/drivers/net/drivers/igb/igb_main.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/kernel/drivers/net/drivers/igb/igb_main.c b/kernel/drivers/net/drivers/igb/igb_main.c
index 9a3998719..2bdcdc5ac 100644
--- a/kernel/drivers/net/drivers/igb/igb_main.c
+++ b/kernel/drivers/net/drivers/igb/igb_main.c
@@ -224,7 +224,8 @@ static int igb_ioctl(struct rtnet_device *, struct ifreq *ifr, int cmd);
 static void igb_reset_task(struct work_struct *);
 static void igb_vlan_mode(struct rtnet_device *netdev,
 			  netdev_features_t features);
-static int igb_vlan_rx_add_vid(struct rtnet_device *, __be16, u16);
+static void igb_vlan_rx_add_vid(struct rtnet_device *, u16);
+static void igb_vlan_rx_kill_vid(struct rtnet_device *, u16);
 static void igb_restore_vlan(struct igb_adapter *);
 static void igb_rar_set_qsel(struct igb_adapter *, u8 *, u32 , u8);
 
@@ -2071,6 +2072,8 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->unmap_rtskb = igb_unmap_rtskb;
 	netdev->do_ioctl = igb_ioctl;
 	netdev->set_multicast_list = igb_set_rx_mode;
+	netdev->vlan_rx_add_vid = igb_vlan_rx_add_vid;
+	netdev->vlan_rx_kill_vid = igb_vlan_rx_kill_vid;
 #if 0
 	netdev->set_mac_address = igb_set_mac;
 	netdev->change_mtu = igb_change_mtu;
@@ -2135,10 +2138,8 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			    NETIF_F_HW_VLAN_CTAG_RX |
 			    NETIF_F_HW_VLAN_CTAG_TX;
 
-#if 0
 	/* set this bit last since it cannot be part of hw_features */
 	netdev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
-#endif
 
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
 
@@ -5135,8 +5136,7 @@ static void igb_vlan_mode(struct rtnet_device *netdev, netdev_features_t feature
 	igb_rlpml_set(adapter);
 }
 
-static int igb_vlan_rx_add_vid(struct rtnet_device *netdev,
-			       __be16 proto, u16 vid)
+static void igb_vlan_rx_add_vid(struct rtnet_device *netdev, u16 vid)
 {
 	struct igb_adapter *adapter = rtnetdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
@@ -5145,8 +5145,17 @@ static int igb_vlan_rx_add_vid(struct rtnet_device *netdev,
 	igb_vfta_set(hw, vid, true);
 
 	set_bit(vid, adapter->active_vlans);
+}
 
-	return 0;
+static void igb_vlan_rx_kill_vid(struct rtnet_device *netdev, u16 vid)
+{
+	struct igb_adapter *adapter = rtnetdev_priv(netdev);
+	struct e1000_hw *hw = &adapter->hw;
+
+	/* if vid was not present in VLVF just remove it from table */
+	igb_vfta_set(hw, vid, false);
+
+	clear_bit(vid, adapter->active_vlans);
 }
 
 static void igb_restore_vlan(struct igb_adapter *adapter)
@@ -5156,7 +5165,7 @@ static void igb_restore_vlan(struct igb_adapter *adapter)
 	igb_vlan_mode(adapter->netdev, adapter->netdev->features);
 
 	for_each_set_bit(vid, adapter->active_vlans, VLAN_N_VID)
-		igb_vlan_rx_add_vid(adapter->netdev, htons(ETH_P_8021Q), vid);
+	    igb_vlan_rx_add_vid(adapter->netdev, vid);
 }
 
 static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
-- 
2.17.1


