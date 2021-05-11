From: =?UTF-8?q?Jean-Baptiste=20Tr=C3=A9dez?=
 <jean-baptiste.tredez@alstefgroup.com>
Subject: [PATCH 15/31] net/drivers: igb: enable multicast
Date: Tue, 11 May 2021 18:05:19 +0200
Message-Id: <20210511160535.26580-16-jean-baptiste.tredez@alstefgroup.com>
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
 kernel/drivers/net/drivers/igb/e1000_mac.c |  6 ++---
 kernel/drivers/net/drivers/igb/e1000_mac.h |  2 +-
 kernel/drivers/net/drivers/igb/igb_main.c  | 30 +++++-----------------
 3 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/kernel/drivers/net/drivers/igb/e1000_mac.c b/kernel/drivers/net/drivers/igb/e1000_mac.c
index 500c92877..765604d5f 100644
--- a/kernel/drivers/net/drivers/igb/e1000_mac.c
+++ b/kernel/drivers/net/drivers/igb/e1000_mac.c
@@ -440,7 +440,7 @@ static u32 igb_hash_mc_addr(struct e1000_hw *hw, u8 *mc_addr)
  *  The caller must have a packed mc_addr_list of multicast addresses.
  **/
 void igb_update_mc_addr_list(struct e1000_hw *hw,
-			     u8 *mc_addr_list, u32 mc_addr_count)
+			     struct rtdev_mc_list *mc_addr, u32 mc_addr_count)
 {
 	u32 hash_value, hash_bit, hash_reg;
 	int i;
@@ -450,13 +450,13 @@ void igb_update_mc_addr_list(struct e1000_hw *hw,
 
 	/* update mta_shadow from mc_addr_list */
 	for (i = 0; (u32) i < mc_addr_count; i++) {
-		hash_value = igb_hash_mc_addr(hw, mc_addr_list);
+		hash_value = igb_hash_mc_addr(hw, mc_addr->dmi_addr);
 
 		hash_reg = (hash_value >> 5) & (hw->mac.mta_reg_count - 1);
 		hash_bit = hash_value & 0x1F;
 
 		hw->mac.mta_shadow[hash_reg] |= (1 << hash_bit);
-		mc_addr_list += (ETH_ALEN);
+		mc_addr = mc_addr->next;
 	}
 
 	/* replace the entire MTA table */
diff --git a/kernel/drivers/net/drivers/igb/e1000_mac.h b/kernel/drivers/net/drivers/igb/e1000_mac.h
index b50d57c5d..a3ad413a0 100644
--- a/kernel/drivers/net/drivers/igb/e1000_mac.h
+++ b/kernel/drivers/net/drivers/igb/e1000_mac.h
@@ -49,7 +49,7 @@ s32  igb_get_speed_and_duplex_copper(struct e1000_hw *hw, u16 *speed,
 s32  igb_id_led_init(struct e1000_hw *hw);
 s32  igb_led_off(struct e1000_hw *hw);
 void igb_update_mc_addr_list(struct e1000_hw *hw,
-			     u8 *mc_addr_list, u32 mc_addr_count);
+			struct rtdev_mc_list *mc_addr, u32 mc_addr_count);
 s32  igb_setup_link(struct e1000_hw *hw);
 s32  igb_validate_mdi_setting(struct e1000_hw *hw);
 s32  igb_write_8bit_ctrl_reg(struct e1000_hw *hw, u32 reg,
diff --git a/kernel/drivers/net/drivers/igb/igb_main.c b/kernel/drivers/net/drivers/igb/igb_main.c
index 1dc4732ee..9a3998719 100644
--- a/kernel/drivers/net/drivers/igb/igb_main.c
+++ b/kernel/drivers/net/drivers/igb/igb_main.c
@@ -2070,8 +2070,8 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->map_rtskb = igb_map_rtskb;
 	netdev->unmap_rtskb = igb_unmap_rtskb;
 	netdev->do_ioctl = igb_ioctl;
+	netdev->set_multicast_list = igb_set_rx_mode;
 #if 0
-	netdev->set_multicast_list = igb_set_multi;
 	netdev->set_mac_address = igb_set_mac;
 	netdev->change_mtu = igb_change_mtu;
 
@@ -3370,34 +3370,18 @@ static int igb_write_mc_addr_list(struct rtnet_device *netdev)
 {
 	struct igb_adapter *adapter = rtnetdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
-#if 0
-	struct netdev_hw_addr *ha;
-	u8  *mta_list;
-	int i;
-	if (netdev_mc_empty(netdev)) {
+	struct rtdev_mc_list *mc_addr = netdev->mc_list;
+	unsigned mc_addr_count = netdev->mc_count;
+
+	if (!mc_addr_count) {
 		/* nothing to program, so clear mc list */
 		igb_update_mc_addr_list(hw, NULL, 0);
-		igb_restore_vf_multicasts(adapter);
 		return 0;
 	}
 
-	mta_list = kzalloc(netdev_mc_count(netdev) * 6, GFP_ATOMIC);
-	if (!mta_list)
-		return -ENOMEM;
-
-	/* The shared function expects a packed array of only addresses. */
-	i = 0;
-	netdev_for_each_mc_addr(ha, netdev)
-		memcpy(mta_list + (i++ * ETH_ALEN), ha->addr, ETH_ALEN);
+	igb_update_mc_addr_list(hw, mc_addr, mc_addr_count);
 
-	igb_update_mc_addr_list(hw, mta_list, i);
-	kfree(mta_list);
-
-	return netdev_mc_count(netdev);
-#else
-	igb_update_mc_addr_list(hw, NULL, 0);
-	return 0;
-#endif
+	return mc_addr_count;
 }
 
 /**
-- 
2.17.1


