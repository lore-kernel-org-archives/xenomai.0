From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] rtnet: experimental/e1000: Convert timers to delay-work
Message-ID: <424b7663-5c2a-cd9c-eab3-35747fac57a3@siemens.com>
Date: Fri, 5 Apr 2019 14:30:22 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Like in upstream. Also avoids breakage on newer kernels that removed
init_timer.

Along this, do some small cleanups. But this code looks fishy - there is
likely a reason why it never left "experimental".

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../drivers/net/drivers/experimental/e1000/e1000.h |   9 +-
 .../net/drivers/experimental/e1000/e1000_main.c    | 118 +++++++++------------
 2 files changed, 52 insertions(+), 75 deletions(-)

diff --git a/kernel/drivers/net/drivers/experimental/e1000/e1000.h b/kernel/drivers/net/drivers/experimental/e1000/e1000.h
index 4da776cc9e..8b9830b99e 100644
--- a/kernel/drivers/net/drivers/experimental/e1000/e1000.h
+++ b/kernel/drivers/net/drivers/experimental/e1000/e1000.h
@@ -242,9 +242,6 @@ struct e1000_phy_regs {
 /* board specific private data structure */
 
 struct e1000_adapter {
-	struct timer_list tx_fifo_stall_timer;
-	struct timer_list watchdog_timer;
-	struct timer_list phy_info_timer;
 #ifdef NETIF_F_HW_VLAN_TX
 	struct vlan_group *vlgrp;
 	u16 mng_vlan_id;
@@ -271,8 +268,6 @@ struct e1000_adapter {
 	u16 tx_itr;
 	u16 rx_itr;
 
-	struct work_struct reset_task;
-	struct work_struct watchdog_task;
 	bool fc_autoneg;
 
 #ifdef ETHTOOL_PHYS_ID
@@ -374,6 +369,10 @@ struct e1000_adapter {
 	/* hardware capability, feature, and workaround flags */
 	unsigned int flags;
 
+	struct work_struct reset_task;
+	struct delayed_work watchdog_task;
+	struct delayed_work fifo_stall_task;
+	struct delayed_work phy_info_task;
 };
 
 #define E1000_FLAG_HAS_SMBUS                (1 << 0)
diff --git a/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c b/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
index acdc13cb5b..443a9f55b9 100644
--- a/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
+++ b/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
@@ -287,10 +287,9 @@ static void e1000_clean_tx_ring(struct e1000_adapter *adapter,
 static void e1000_clean_rx_ring(struct e1000_adapter *adapter,
 				struct e1000_rx_ring *rx_ring);
 static void e1000_set_multi(struct net_device *netdev);
-static void e1000_update_phy_info(unsigned long data);
-static void e1000_watchdog(unsigned long data);
+static void e1000_update_phy_info_task(struct work_struct *work);
 static void e1000_watchdog_task(struct work_struct *work);
-static void e1000_82547_tx_fifo_stall(unsigned long data);
+static void e1000_82547_tx_fifo_stall_task(struct work_struct *work);
 static int e1000_xmit_frame_ring(struct sk_buff *skb, struct net_device *netdev,
 				 struct e1000_tx_ring *tx_ring);
 static int e1000_xmit_frame(struct sk_buff *skb, struct net_device *netdev);
@@ -757,14 +756,24 @@ int e1000_up(struct e1000_adapter *adapter)
 	return 0;
 }
 
+static void e1000_down_and_stop(struct e1000_adapter *adapter)
+{
+	/* signal that we're down so the interrupt handler does not
+	 * reschedule our watchdog timer */
+	set_bit(__E1000_DOWN, &adapter->state);
+
+	cancel_work_sync(&adapter->reset_task);
+	cancel_delayed_work_sync(&adapter->watchdog_task);
+	cancel_delayed_work_sync(&adapter->phy_info_task);
+	cancel_delayed_work_sync(&adapter->fifo_stall_task);
+}
+
 void e1000_down(struct e1000_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
 	u32 tctl, rctl;
 
-	/* signal that we're down so the interrupt handler does not
-	 * reschedule our watchdog timer */
-	set_bit(__E1000_DOWN, &adapter->state);
+	e1000_down_and_stop(adapter);
 
 	/* disable receives in the hardware */
 	rctl = E1000_READ_REG(&adapter->hw, E1000_RCTL);
@@ -789,10 +798,6 @@ void e1000_down(struct e1000_adapter *adapter)
 
 	e1000_irq_disable(adapter);
 
-	del_timer_sync(&adapter->tx_fifo_stall_timer);
-	del_timer_sync(&adapter->watchdog_timer);
-	del_timer_sync(&adapter->phy_info_timer);
-
 	// netdev->tx_queue_len = adapter->tx_queue_len;
 	rtnetif_carrier_off(netdev);
 	adapter->link_speed = 0;
@@ -1272,20 +1277,11 @@ static int e1000_probe(struct pci_dev *pdev,
 		goto err_eeprom;
 	}
 
-	init_timer(&adapter->tx_fifo_stall_timer);
-	adapter->tx_fifo_stall_timer.function = &e1000_82547_tx_fifo_stall;
-	adapter->tx_fifo_stall_timer.data = (unsigned long) adapter;
-
-	init_timer(&adapter->watchdog_timer);
-	adapter->watchdog_timer.function = &e1000_watchdog;
-	adapter->watchdog_timer.data = (unsigned long) adapter;
-
-	init_timer(&adapter->phy_info_timer);
-	adapter->phy_info_timer.function = &e1000_update_phy_info;
-	adapter->phy_info_timer.data = (unsigned long) adapter;
-
+	INIT_DELAYED_WORK(&adapter->watchdog_task, e1000_watchdog_task);
+	INIT_DELAYED_WORK(&adapter->fifo_stall_task,
+			  e1000_82547_tx_fifo_stall_task);
+	INIT_DELAYED_WORK(&adapter->phy_info_task, e1000_update_phy_info_task);
 	INIT_WORK(&adapter->reset_task, e1000_reset_task);
-	INIT_WORK(&adapter->watchdog_task, e1000_watchdog_task);
 
 	e1000_check_options(adapter);
 
@@ -1450,14 +1446,7 @@ static void e1000_remove(struct pci_dev *pdev)
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 
-	/* flush_scheduled work may reschedule our watchdog task, so
-	 * explicitly disable watchdog tasks from being rescheduled  */
-	set_bit(__E1000_DOWN, &adapter->state);
-	del_timer_sync(&adapter->tx_fifo_stall_timer);
-	del_timer_sync(&adapter->watchdog_timer);
-	del_timer_sync(&adapter->phy_info_timer);
-
-	flush_scheduled_work();
+	e1000_down_and_stop(adapter);
 
 	e1000_release_manageability(adapter);
 
@@ -1844,7 +1833,7 @@ static int e1000_open(struct net_device *netdev)
 
 	e1000_napi_enable_all(adapter);
 
-    mod_timer(&adapter->watchdog_timer, jiffies);
+	schedule_delayed_work(&adapter->watchdog_task, 1);
 	e1000_irq_enable(adapter);
 
 	/* fire a link status change interrupt to start the watchdog */
@@ -2931,19 +2920,23 @@ static void e1000_set_multi(struct net_device *netdev)
 
 /* Need to wait a few seconds after link up to get diagnostic information from
  * the phy */
-static void e1000_update_phy_info(unsigned long data)
+static void e1000_update_phy_info_task(struct work_struct *work)
 {
-	struct e1000_adapter *adapter = (struct e1000_adapter *) data;
+	struct e1000_adapter *adapter = container_of(work,
+						     struct e1000_adapter,
+						     phy_info_task.work);
 	e1000_get_phy_info(&adapter->hw);
 }
 
 /**
- * e1000_82547_tx_fifo_stall - Timer Call-back
- * @data: pointer to adapter cast into an unsigned long
+ * e1000_82547_tx_fifo_stall_task - task to complete work
+ * @work: work struct contained inside adapter struct
  **/
-static void e1000_82547_tx_fifo_stall(unsigned long data)
+static void e1000_82547_tx_fifo_stall_task(struct work_struct *work)
 {
-	struct e1000_adapter *adapter = (struct e1000_adapter *) data;
+	struct e1000_adapter *adapter = container_of(work,
+						     struct e1000_adapter,
+						     fifo_stall_task.work);
 	struct net_device *netdev = adapter->netdev;
 	u32 tctl;
 
@@ -2972,7 +2965,7 @@ static void e1000_82547_tx_fifo_stall(unsigned long data)
 			atomic_set(&adapter->tx_fifo_stall, 0);
 			rtnetif_wake_queue(netdev);
 		} else if (!test_bit(__E1000_DOWN, &adapter->state))
-			mod_timer(&adapter->tx_fifo_stall_timer, jiffies + 1);
+			schedule_delayed_work(&adapter->fifo_stall_task, 1);
 	}
 }
 
@@ -3032,22 +3025,11 @@ static void e1000_enable_receives(struct e1000_adapter *adapter)
 	}
 }
 
-/**
- * e1000_watchdog - Timer Call-back
- * @data: pointer to adapter cast into an unsigned long
- **/
-static void e1000_watchdog(unsigned long data)
-{
-	struct e1000_adapter *adapter = (struct e1000_adapter *) data;
-
-	/* Do the rest outside of interrupt context */
-	schedule_work(&adapter->watchdog_task);
-}
-
 static void e1000_watchdog_task(struct work_struct *work)
 {
 	struct e1000_adapter *adapter = container_of(work,
-					struct e1000_adapter, watchdog_task);
+						     struct e1000_adapter,
+						     watchdog_task.work);
 
 	struct net_device *netdev = adapter->netdev;
 	struct e1000_mac_info *mac = &adapter->hw.mac;
@@ -3161,8 +3143,8 @@ static void e1000_watchdog_task(struct work_struct *work)
 #endif
 
 			if (!test_bit(__E1000_DOWN, &adapter->state))
-				mod_timer(&adapter->phy_info_timer,
-					  round_jiffies(jiffies + 2 * HZ));
+				schedule_delayed_work(&adapter->phy_info_task,
+						      2 * HZ);
 			adapter->smartspeed = 0;
 		}
 	} else {
@@ -3173,8 +3155,8 @@ static void e1000_watchdog_task(struct work_struct *work)
 			rtnetif_carrier_off(netdev);
 			rtnetif_stop_queue(netdev);
 			if (!test_bit(__E1000_DOWN, &adapter->state))
-				mod_timer(&adapter->phy_info_timer,
-					  round_jiffies(jiffies + 2 * HZ));
+				schedule_delayed_work(&adapter->phy_info_task,
+						      2 * HZ);
 
 			/* 80003ES2LAN workaround--
 			 * For packet buffer work-around on link down event;
@@ -3231,8 +3213,9 @@ link_up:
 	if (e1000_get_laa_state_82571(&adapter->hw) == TRUE)
 		e1000_rar_set(&adapter->hw, adapter->hw.mac.addr, 0);
 
-	/* Reset the timer */
-    mod_timer(&adapter->watchdog_timer, jiffies + HZ);
+	/* Reschedule the task */
+	if (!test_bit(__E1000_DOWN, &adapter->state))
+		schedule_delayed_work(&adapter->watchdog_task, 2 * HZ);
 }
 
 enum latency_range {
@@ -3858,11 +3841,7 @@ static int e1000_xmit_frame_ring(struct sk_buff *skb,
 	    (adapter->hw.mac.type == e1000_82573))
 		e1000_transfer_dhcp_info(adapter, skb);
 
-#ifdef NETIF_F_LLTX
-	rtdm_lock_get_irqsave(&tx_ring->tx_lock, irq_flags);
-#else
 	rtdm_lock_get_irqsave(&tx_ring->tx_lock, irq_flags);
-#endif
 
 	/* need: count + 2 desc gap to keep tail from touching
 	 * head, otherwise try next time */
@@ -3875,11 +3854,10 @@ static int e1000_xmit_frame_ring(struct sk_buff *skb,
 	if (unlikely(adapter->hw.mac.type == e1000_82547)) {
 		if (unlikely(e1000_82547_fifo_workaround(adapter, skb))) {
 			rtnetif_stop_queue(netdev);
-	    rtdm_lock_put_irqrestore(&tx_ring->tx_lock, irq_flags);
-			if (!test_bit(__E1000_DOWN, &adapter->state))
-				mod_timer(&adapter->tx_fifo_stall_timer,
-					  jiffies + 1);
 			rtdm_lock_put_irqrestore(&tx_ring->tx_lock, irq_flags);
+			if (!test_bit(__E1000_DOWN, &adapter->state))
+				schedule_delayed_work(&adapter->fifo_stall_task,
+						      1);
 		    rtdm_printk("FATAL: rt_e1000 ran into tail 82547 controller bug!\n");
 			return NETDEV_TX_BUSY;
 		}
@@ -4265,8 +4243,8 @@ static int e1000_intr_msi(rtdm_irq_t *irq_handle)
 		e1000_set_itr(adapter);
 #endif
 
-    if (adapter->data_received)
-	rt_mark_stack_mgr(netdev);
+	if (adapter->data_received)
+		rt_mark_stack_mgr(netdev);
 
 	return RTDM_IRQ_HANDLED;
 }
@@ -4393,8 +4371,8 @@ static int e1000_intr(rtdm_irq_t *irq_handle)
 
 #endif
 
-    if (adapter->data_received)
-	rt_mark_stack_mgr(netdev);
+	if (adapter->data_received)
+		rt_mark_stack_mgr(netdev);
 	return RTDM_IRQ_HANDLED;
 }
 
-- 
2.16.4

