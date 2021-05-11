From: =?UTF-8?q?Jean-Baptiste=20Tr=C3=A9dez?=
 <jean-baptiste.tredez@alstefgroup.com>
Subject: [PATCH 12/31] net/drivers: e1000e: enable multicast
Date: Tue, 11 May 2021 18:05:16 +0200
Message-Id: <20210511160535.26580-13-jean-baptiste.tredez@alstefgroup.com>
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
 kernel/drivers/net/drivers/e1000e/e1000.h    | 2 +-
 kernel/drivers/net/drivers/e1000e/hw.h       | 2 +-
 kernel/drivers/net/drivers/e1000e/lib.c      | 7 ++++---
 kernel/drivers/net/drivers/e1000e/netdev.c   | 6 ++++--
 kernel/drivers/net/stack/include/ipv4/igmp.h | 4 ++--
 kernel/drivers/net/stack/ipv4/igmp.c         | 6 +++---
 6 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/kernel/drivers/net/drivers/e1000e/e1000.h b/kernel/drivers/net/drivers/e1000e/e1000.h
index 7454c6350..a682de8d2 100644
--- a/kernel/drivers/net/drivers/e1000e/e1000.h
+++ b/kernel/drivers/net/drivers/e1000e/e1000.h
@@ -574,7 +574,7 @@ extern s32 e1000e_setup_link(struct e1000_hw *hw);
 extern void e1000_clear_vfta_generic(struct e1000_hw *hw);
 extern void e1000e_init_rx_addrs(struct e1000_hw *hw, u16 rar_count);
 extern void e1000e_update_mc_addr_list_generic(struct e1000_hw *hw,
-					       u8 *mc_addr_list,
+					       struct rtdev_mc_list *mc_addr_list,
 					       u32 mc_addr_count);
 extern void e1000e_rar_set(struct e1000_hw *hw, u8 *addr, u32 index);
 extern s32 e1000e_set_fc_watermarks(struct e1000_hw *hw);
diff --git a/kernel/drivers/net/drivers/e1000e/hw.h b/kernel/drivers/net/drivers/e1000e/hw.h
index 247f79eea..94e91ed10 100644
--- a/kernel/drivers/net/drivers/e1000e/hw.h
+++ b/kernel/drivers/net/drivers/e1000e/hw.h
@@ -779,7 +779,7 @@ struct e1000_mac_operations {
 	s32  (*get_link_up_info)(struct e1000_hw *, u16 *, u16 *);
 	s32  (*led_on)(struct e1000_hw *);
 	s32  (*led_off)(struct e1000_hw *);
-	void (*update_mc_addr_list)(struct e1000_hw *, u8 *, u32);
+	void (*update_mc_addr_list)(struct e1000_hw *, struct rtdev_mc_list *, u32);
 	s32  (*reset_hw)(struct e1000_hw *);
 	s32  (*init_hw)(struct e1000_hw *);
 	s32  (*setup_link)(struct e1000_hw *);
diff --git a/kernel/drivers/net/drivers/e1000e/lib.c b/kernel/drivers/net/drivers/e1000e/lib.c
index fbdccdc3b..e91037b33 100644
--- a/kernel/drivers/net/drivers/e1000e/lib.c
+++ b/kernel/drivers/net/drivers/e1000e/lib.c
@@ -356,7 +356,8 @@ static u32 e1000_hash_mc_addr(struct e1000_hw *hw, u8 *mc_addr)
  *  The caller must have a packed mc_addr_list of multicast addresses.
  **/
 void e1000e_update_mc_addr_list_generic(struct e1000_hw *hw,
-					u8 *mc_addr_list, u32 mc_addr_count)
+					struct rtdev_mc_list *mc_addr_list,
+					u32 mc_addr_count)
 {
 	u32 hash_value, hash_bit, hash_reg;
 	int i;
@@ -366,13 +367,13 @@ void e1000e_update_mc_addr_list_generic(struct e1000_hw *hw,
 
 	/* update mta_shadow from mc_addr_list */
 	for (i = 0; (u32) i < mc_addr_count; i++) {
-		hash_value = e1000_hash_mc_addr(hw, mc_addr_list);
+		hash_value = e1000_hash_mc_addr(hw, mc_addr_list->dmi_addr);
 
 		hash_reg = (hash_value >> 5) & (hw->mac.mta_reg_count - 1);
 		hash_bit = hash_value & 0x1F;
 
 		hw->mac.mta_shadow[hash_reg] |= (1 << hash_bit);
-		mc_addr_list += (ETH_ALEN);
+		mc_addr_list = mc_addr_list->next;
 	}
 
 	/* replace the entire MTA table */
diff --git a/kernel/drivers/net/drivers/e1000e/netdev.c b/kernel/drivers/net/drivers/e1000e/netdev.c
index 5ce467911..a75afa808 100644
--- a/kernel/drivers/net/drivers/e1000e/netdev.c
+++ b/kernel/drivers/net/drivers/e1000e/netdev.c
@@ -2156,7 +2156,8 @@ static void e1000_configure_rx(struct e1000_adapter *adapter)
  *  Updates the Multicast Table Array.
  *  The caller must have a packed mc_addr_list of multicast addresses.
  **/
-static void e1000_update_mc_addr_list(struct e1000_hw *hw, u8 *mc_addr_list,
+static void e1000_update_mc_addr_list(struct e1000_hw *hw,
+				struct rtdev_mc_list *mc_addr_list,
 				      u32 mc_addr_count)
 {
 	hw->mac.ops.update_mc_addr_list(hw, mc_addr_list, mc_addr_count);
@@ -2198,7 +2199,7 @@ static void e1000_set_multi(struct rtnet_device *netdev)
 
 	ew32(RCTL, rctl);
 
-	e1000_update_mc_addr_list(hw, NULL, 0);
+	e1000_update_mc_addr_list(hw, netdev->mc_list, netdev->mc_count);
 
 	if (netdev->features & NETIF_F_HW_VLAN_CTAG_RX)
 		e1000e_vlan_strip_enable(adapter);
@@ -4005,6 +4006,7 @@ static int e1000_probe(struct pci_dev *pdev,
 	netdev->open = e1000_open;
 	netdev->stop = e1000_close;
 	netdev->hard_start_xmit = e1000_xmit_frame;
+	netdev->set_multicast_list = e1000_set_multi;
 	//netdev->get_stats = e1000_get_stats;
 	netdev->map_rtskb = e1000_map_rtskb;
 	netdev->unmap_rtskb = e1000_unmap_rtskb;
diff --git a/kernel/drivers/net/stack/include/ipv4/igmp.h b/kernel/drivers/net/stack/include/ipv4/igmp.h
index a44e09041..3daa343e4 100644
--- a/kernel/drivers/net/stack/include/ipv4/igmp.h
+++ b/kernel/drivers/net/stack/include/ipv4/igmp.h
@@ -87,8 +87,8 @@ static inline bool rtnet_in_multicast(u32 addr)
 }
 
 #ifdef CONFIG_XENO_DRIVERS_NET_RTIPV4_IGMP
-int rt_ip_mc_join_group(struct rtsocket *sk, struct ip_mreq *imr);
-int rt_ip_mc_leave_group(struct rtsocket *sk, struct ip_mreq *imr);
+int rt_ip_mc_join_group(struct rtsocket *sk, const struct ip_mreq *imr);
+int rt_ip_mc_leave_group(struct rtsocket *sk, const struct ip_mreq *imr);
 void rt_ip_mc_drop_socket(struct rtsocket *sk);
 void rt_ip_mc_dec_group(struct rtnet_device *rtdev, u32 addr);
 void rt_ip_mc_inc_group(struct rtnet_device *rtdev, u32 addr);
diff --git a/kernel/drivers/net/stack/ipv4/igmp.c b/kernel/drivers/net/stack/ipv4/igmp.c
index 3da21df5b..9568cedc7 100644
--- a/kernel/drivers/net/stack/ipv4/igmp.c
+++ b/kernel/drivers/net/stack/ipv4/igmp.c
@@ -339,7 +339,7 @@ void rt_ip_mc_dec_group(struct rtnet_device *rtdev, u32 addr)
     rtdm_lock_put_irqrestore(&mc_list_lock, flags);
 }
 
-static struct rtnet_device *rt_ip_mc_find_dev(struct ip_mreq *imr)
+static struct rtnet_device *rt_ip_mc_find_dev(const struct ip_mreq *imr)
 {
     struct rtnet_device *rtdev = NULL;
 
@@ -353,7 +353,7 @@ static struct rtnet_device *rt_ip_mc_find_dev(struct ip_mreq *imr)
  *	Join a socket to a group
  */
 
-int rt_ip_mc_join_group(struct rtsocket *sk, struct ip_mreq *imr)
+int rt_ip_mc_join_group(struct rtsocket *sk, const struct ip_mreq *imr)
 {
     int err = 0;
     u32 addr = imr->imr_multiaddr.s_addr;
@@ -399,7 +399,7 @@ int rt_ip_mc_join_group(struct rtsocket *sk, struct ip_mreq *imr)
 /*
  *	Ask a socket to leave a group.
  */
-int rt_ip_mc_leave_group(struct rtsocket *sk, struct ip_mreq *imr)
+int rt_ip_mc_leave_group(struct rtsocket *sk, const struct ip_mreq *imr)
 {
     u32 addr = imr->imr_multiaddr.s_addr;
     struct  rtnet_device *rtdev = rt_ip_mc_find_dev(imr);
-- 
2.17.1


