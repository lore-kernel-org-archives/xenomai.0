From: =?UTF-8?q?Jean-Baptiste=20Tr=C3=A9dez?=
 <jean-baptiste.tredez@alstefgroup.com>
Subject: [PATCH 14/31] net/drivers: e1000e: add netdevice stats
Date: Tue, 11 May 2021 18:05:18 +0200
Message-Id: <20210511160535.26580-15-jean-baptiste.tredez@alstefgroup.com>
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
 kernel/drivers/net/drivers/e1000e/e1000.h  |   5 +-
 kernel/drivers/net/drivers/e1000e/netdev.c | 234 ++++++++++++++++++++-
 2 files changed, 235 insertions(+), 4 deletions(-)

diff --git a/kernel/drivers/net/drivers/e1000e/e1000.h b/kernel/drivers/net/drivers/e1000e/e1000.h
index a682de8d2..fd28011db 100644
--- a/kernel/drivers/net/drivers/e1000e/e1000.h
+++ b/kernel/drivers/net/drivers/e1000e/e1000.h
@@ -378,6 +378,7 @@ struct e1000_adapter {
 	struct e1000_hw_stats stats;
 	struct e1000_phy_info phy_info;
 	struct e1000_phy_stats phy_stats;
+	struct net_device_stats netdev_stats;
 
 	/* Snapshot of PHY registers */
 	struct e1000_phy_regs phy_regs;
@@ -505,9 +506,7 @@ extern int e1000e_setup_rx_resources(struct e1000_adapter *adapter);
 extern int e1000e_setup_tx_resources(struct e1000_adapter *adapter);
 extern void e1000e_free_rx_resources(struct e1000_adapter *adapter);
 extern void e1000e_free_tx_resources(struct e1000_adapter *adapter);
-extern struct rtnl_link_stats64 *e1000e_get_stats64(struct net_device *netdev,
-						    struct rtnl_link_stats64
-						    *stats);
+extern struct net_device_stats *e1000e_get_stats(struct rtnet_device *netdev);
 extern void e1000e_set_interrupt_capability(struct e1000_adapter *adapter);
 extern void e1000e_reset_interrupt_capability(struct e1000_adapter *adapter);
 extern void e1000e_get_hw_control(struct e1000_adapter *adapter);
diff --git a/kernel/drivers/net/drivers/e1000e/netdev.c b/kernel/drivers/net/drivers/e1000e/netdev.c
index 4042cbd1a..46bbef371 100644
--- a/kernel/drivers/net/drivers/e1000e/netdev.c
+++ b/kernel/drivers/net/drivers/e1000e/netdev.c
@@ -2470,6 +2470,8 @@ static void e1000e_flush_descriptors(struct e1000_adapter *adapter)
 	e1e_flush();
 }
 
+static void e1000e_update_stats(struct e1000_adapter *adapter);
+
 void e1000e_down(struct e1000_adapter *adapter)
 {
 	struct rtnet_device *netdev = adapter->netdev;
@@ -2506,6 +2508,10 @@ void e1000e_down(struct e1000_adapter *adapter)
 
 	rtnetif_carrier_off(netdev);
 
+	spin_lock(&adapter->stats64_lock);
+	e1000e_update_stats(adapter);
+	spin_unlock(&adapter->stats64_lock);
+
 	e1000e_flush_descriptors(adapter);
 	e1000_clean_tx_ring(adapter);
 	e1000_clean_rx_ring(adapter);
@@ -2880,6 +2886,186 @@ static void e1000_update_phy_info(unsigned long data)
 	rtdm_schedule_nrt_work(&adapter->update_phy_task);
 }
 
+/**
+ * e1000e_update_phy_stats - Update the PHY statistics counters
+ * @adapter: board private structure
+ *
+ * Read/clear the upper 16-bit PHY registers and read/accumulate lower
+ **/
+static void e1000e_update_phy_stats(struct e1000_adapter *adapter)
+{
+	struct e1000_hw *hw = &adapter->hw;
+	s32 ret_val;
+	u16 phy_data;
+
+	ret_val = hw->phy.ops.acquire(hw);
+	if (ret_val)
+		return;
+
+	/* A page set is expensive so check if already on desired page.
+	 * If not, set to the page with the PHY status registers.
+	 */
+	hw->phy.addr = 1;
+	ret_val = e1000e_read_phy_reg_mdic(hw, IGP01E1000_PHY_PAGE_SELECT,
+					   &phy_data);
+	if (ret_val)
+		goto release;
+	if (phy_data != (HV_STATS_PAGE << IGP_PAGE_SHIFT)) {
+		ret_val = hw->phy.ops.set_page(hw,
+					       HV_STATS_PAGE << IGP_PAGE_SHIFT);
+		if (ret_val)
+			goto release;
+	}
+
+	/* Single Collision Count */
+	hw->phy.ops.read_reg_page(hw, HV_SCC_UPPER, &phy_data);
+	ret_val = hw->phy.ops.read_reg_page(hw, HV_SCC_LOWER, &phy_data);
+	if (!ret_val)
+		adapter->stats.scc += phy_data;
+
+	/* Excessive Collision Count */
+	hw->phy.ops.read_reg_page(hw, HV_ECOL_UPPER, &phy_data);
+	ret_val = hw->phy.ops.read_reg_page(hw, HV_ECOL_LOWER, &phy_data);
+	if (!ret_val)
+		adapter->stats.ecol += phy_data;
+
+	/* Multiple Collision Count */
+	hw->phy.ops.read_reg_page(hw, HV_MCC_UPPER, &phy_data);
+	ret_val = hw->phy.ops.read_reg_page(hw, HV_MCC_LOWER, &phy_data);
+	if (!ret_val)
+		adapter->stats.mcc += phy_data;
+
+	/* Late Collision Count */
+	hw->phy.ops.read_reg_page(hw, HV_LATECOL_UPPER, &phy_data);
+	ret_val = hw->phy.ops.read_reg_page(hw, HV_LATECOL_LOWER, &phy_data);
+	if (!ret_val)
+		adapter->stats.latecol += phy_data;
+
+	/* Collision Count - also used for adaptive IFS */
+	hw->phy.ops.read_reg_page(hw, HV_COLC_UPPER, &phy_data);
+	ret_val = hw->phy.ops.read_reg_page(hw, HV_COLC_LOWER, &phy_data);
+	if (!ret_val)
+		hw->mac.collision_delta = phy_data;
+
+	/* Defer Count */
+	hw->phy.ops.read_reg_page(hw, HV_DC_UPPER, &phy_data);
+	ret_val = hw->phy.ops.read_reg_page(hw, HV_DC_LOWER, &phy_data);
+	if (!ret_val)
+		adapter->stats.dc += phy_data;
+
+	/* Transmit with no CRS */
+	hw->phy.ops.read_reg_page(hw, HV_TNCRS_UPPER, &phy_data);
+	ret_val = hw->phy.ops.read_reg_page(hw, HV_TNCRS_LOWER, &phy_data);
+	if (!ret_val)
+		adapter->stats.tncrs += phy_data;
+
+release:
+	hw->phy.ops.release(hw);
+}
+
+/**
+ * e1000e_update_stats - Update the board statistics counters
+ * @adapter: board private structure
+ **/
+static void e1000e_update_stats(struct e1000_adapter *adapter)
+{
+	struct e1000_hw *hw = &adapter->hw;
+	struct pci_dev *pdev = adapter->pdev;
+
+	/* Prevent stats update while adapter is being reset, or if the pci
+	 * connection is down.
+	 */
+	if (adapter->link_speed == 0)
+	return;
+	if (pci_channel_offline(pdev))
+		return;
+
+	adapter->stats.crcerrs += er32(CRCERRS);
+	adapter->stats.gprc += er32(GPRC);
+	adapter->stats.gorc += er32(GORCL);
+	er32(GORCH);		/* Clear gorc */
+	adapter->stats.bprc += er32(BPRC);
+	adapter->stats.mprc += er32(MPRC);
+	adapter->stats.roc += er32(ROC);
+
+	adapter->stats.mpc += er32(MPC);
+
+	/* Half-duplex statistics */
+	if (adapter->link_duplex == HALF_DUPLEX) {
+		if (adapter->flags2 & FLAG2_HAS_PHY_STATS) {
+			e1000e_update_phy_stats(adapter);
+		} else {
+			adapter->stats.scc += er32(SCC);
+			adapter->stats.ecol += er32(ECOL);
+			adapter->stats.mcc += er32(MCC);
+			adapter->stats.latecol += er32(LATECOL);
+			adapter->stats.dc += er32(DC);
+
+			hw->mac.collision_delta = er32(COLC);
+
+			if ((hw->mac.type != e1000_82574) &&
+			    (hw->mac.type != e1000_82583))
+				adapter->stats.tncrs += er32(TNCRS);
+		}
+		adapter->stats.colc += hw->mac.collision_delta;
+	}
+
+	adapter->stats.xonrxc += er32(XONRXC);
+	adapter->stats.xontxc += er32(XONTXC);
+	adapter->stats.xoffrxc += er32(XOFFRXC);
+	adapter->stats.xofftxc += er32(XOFFTXC);
+	adapter->stats.gptc += er32(GPTC);
+	adapter->stats.gotc += er32(GOTCL);
+	er32(GOTCH);		/* Clear gotc */
+	adapter->stats.rnbc += er32(RNBC);
+	adapter->stats.ruc += er32(RUC);
+
+	adapter->stats.mptc += er32(MPTC);
+	adapter->stats.bptc += er32(BPTC);
+
+	/* used for adaptive IFS */
+
+	hw->mac.tx_packet_delta = er32(TPT);
+	adapter->stats.tpt += hw->mac.tx_packet_delta;
+
+	adapter->stats.algnerrc += er32(ALGNERRC);
+	adapter->stats.rxerrc += er32(RXERRC);
+	adapter->stats.cexterr += er32(CEXTERR);
+	adapter->stats.tsctc += er32(TSCTC);
+	adapter->stats.tsctfc += er32(TSCTFC);
+
+	/* Fill out the OS statistics structure */
+	adapter->netdev_stats.multicast = adapter->stats.mprc;
+	adapter->netdev_stats.collisions = adapter->stats.colc;
+
+	/* Rx Errors */
+
+	/* RLEC on some newer hardware can be incorrect so build
+	 * our own version based on RUC and ROC
+	 */
+	adapter->netdev_stats.rx_errors = adapter->stats.rxerrc +
+	    adapter->stats.crcerrs + adapter->stats.algnerrc +
+	    adapter->stats.ruc + adapter->stats.roc + adapter->stats.cexterr;
+	adapter->netdev_stats.rx_length_errors = adapter->stats.ruc +
+	    adapter->stats.roc;
+	adapter->netdev_stats.rx_crc_errors = adapter->stats.crcerrs;
+	adapter->netdev_stats.rx_frame_errors = adapter->stats.algnerrc;
+	adapter->netdev_stats.rx_missed_errors = adapter->stats.mpc;
+
+	/* Tx Errors */
+	adapter->netdev_stats.tx_errors = adapter->stats.ecol + adapter->stats.latecol;
+	adapter->netdev_stats.tx_aborted_errors = adapter->stats.ecol;
+	adapter->netdev_stats.tx_window_errors = adapter->stats.latecol;
+	adapter->netdev_stats.tx_carrier_errors = adapter->stats.tncrs;
+
+	/* Tx Dropped needs to be maintained elsewhere */
+
+	/* Management Stats */
+	adapter->stats.mgptc += er32(MGTPTC);
+	adapter->stats.mgprc += er32(MGTPRC);
+	adapter->stats.mgpdc += er32(MGTPDC);
+}
+
 /**
  * e1000_phy_read_status - Update the PHY register status snapshot
  * @adapter: board private structure
@@ -3176,6 +3362,7 @@ static void e1000_watchdog_task(struct work_struct *work)
 
 link_up:
 	spin_lock(&adapter->stats64_lock);
+	e1000e_update_stats(adapter);
 
 	mac->tx_packet_delta = adapter->stats.tpt - adapter->tpt_old;
 	adapter->tpt_old = adapter->stats.tpt;
@@ -3440,6 +3627,51 @@ static void e1000_reset_task(struct work_struct *work)
 	e1000e_reinit_locked(adapter);
 }
 
+struct net_device_stats *e1000_get_stats(struct rtnet_device *netdev)
+{
+	struct e1000_adapter *adapter = rtnetdev_priv(netdev);
+	struct net_device_stats *stats = &adapter->netdev_stats;
+
+	memset(stats, 0, sizeof(*stats));
+	spin_lock(&adapter->stats64_lock);
+	e1000e_update_stats(adapter);
+	/* Fill out the OS statistics structure */
+	stats->rx_bytes = adapter->stats.gorc;
+	stats->rx_packets = adapter->stats.gprc;
+	stats->tx_bytes = adapter->stats.gotc;
+	stats->tx_packets = adapter->stats.gptc;
+	stats->multicast = adapter->stats.mprc;
+	stats->collisions = adapter->stats.colc;
+
+	/* Rx Errors */
+
+	/*
+	 * RLEC on some newer hardware can be incorrect so build
+	 * our own version based on RUC and ROC
+	 */
+	stats->rx_errors = adapter->stats.rxerrc +
+		adapter->stats.crcerrs + adapter->stats.algnerrc +
+		adapter->stats.ruc + adapter->stats.roc +
+		adapter->stats.cexterr;
+	stats->rx_length_errors = adapter->stats.ruc +
+					      adapter->stats.roc;
+	stats->rx_crc_errors = adapter->stats.crcerrs;
+	stats->rx_frame_errors = adapter->stats.algnerrc;
+	stats->rx_missed_errors = adapter->stats.mpc;
+
+	/* Tx Errors */
+	stats->tx_errors = adapter->stats.ecol +
+				       adapter->stats.latecol;
+	stats->tx_aborted_errors = adapter->stats.ecol;
+	stats->tx_window_errors = adapter->stats.latecol;
+	stats->tx_carrier_errors = adapter->stats.tncrs;
+
+	/* Tx Dropped needs to be maintained elsewhere */
+
+	spin_unlock(&adapter->stats64_lock);
+	return stats;
+}
+
 static int e1000_init_phy_wakeup(struct e1000_adapter *adapter, u32 wufc)
 {
 	struct e1000_hw *hw = &adapter->hw;
@@ -3987,7 +4219,7 @@ static int e1000_probe(struct pci_dev *pdev,
 	netdev->stop = e1000_close;
 	netdev->hard_start_xmit = e1000_xmit_frame;
 	netdev->set_multicast_list = e1000_set_multi;
-	//netdev->get_stats = e1000_get_stats;
+	netdev->get_stats = e1000_get_stats;
 	netdev->map_rtskb = e1000_map_rtskb;
 	netdev->unmap_rtskb = e1000_unmap_rtskb;
 	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
-- 
2.17.1


