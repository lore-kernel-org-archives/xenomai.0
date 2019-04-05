From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] rtnet: e1000: Convert timers to delay-work
Message-ID: <44754612-e756-2eb5-6b3a-8a5a04ee424b@siemens.com>
Date: Fri, 5 Apr 2019 11:26:09 +0200
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/drivers/e1000/e1000.h      |  7 ++-
 kernel/drivers/net/drivers/e1000/e1000_main.c | 91 ++++++++++++++-------------
 2 files changed, 50 insertions(+), 48 deletions(-)

diff --git a/kernel/drivers/net/drivers/e1000/e1000.h b/kernel/drivers/net/drivers/e1000/e1000.h
index 3417e1e047..44f1efa9a3 100644
--- a/kernel/drivers/net/drivers/e1000/e1000.h
+++ b/kernel/drivers/net/drivers/e1000/e1000.h
@@ -256,9 +256,6 @@ struct e1000_rx_ring {
 /* board specific private data structure */
 
 struct e1000_adapter {
-	struct timer_list tx_fifo_stall_timer;
-	struct timer_list watchdog_timer;
-	struct timer_list phy_info_timer;
 #ifdef NETIF_F_HW_VLAN_TX
 	struct vlan_group *vlgrp;
 	uint16_t mng_vlan_id;
@@ -381,6 +378,10 @@ struct e1000_adapter {
 #endif
 	boolean_t smart_power_down;	/* phy smart power down */
 	unsigned long flags;
+
+	struct delayed_work watchdog_task;
+	struct delayed_work fifo_stall_task;
+	struct delayed_work phy_info_task;
 };
 
 enum e1000_state_t {
diff --git a/kernel/drivers/net/drivers/e1000/e1000_main.c b/kernel/drivers/net/drivers/e1000/e1000_main.c
index 1f0216752e..491b828e46 100644
--- a/kernel/drivers/net/drivers/e1000/e1000_main.c
+++ b/kernel/drivers/net/drivers/e1000/e1000_main.c
@@ -198,9 +198,9 @@ static void e1000_clean_tx_ring(struct e1000_adapter *adapter,
 static void e1000_clean_rx_ring(struct e1000_adapter *adapter,
 				struct e1000_rx_ring *rx_ring);
 static void e1000_set_multi(struct rtnet_device *netdev);
-static void e1000_update_phy_info(unsigned long data);
-static void e1000_watchdog(unsigned long data);
-static void e1000_82547_tx_fifo_stall(unsigned long data);
+static void e1000_update_phy_info_task(struct work_struct *work);
+static void e1000_watchdog(struct work_struct *work);
+static void e1000_82547_tx_fifo_stall_task(struct work_struct *work);
 static int e1000_xmit_frame(struct rtskb *skb, struct rtnet_device *netdev);
 static int e1000_intr(rtdm_irq_t *irq_handle);
 static boolean_t e1000_clean_tx_irq(struct e1000_adapter *adapter,
@@ -472,7 +472,7 @@ e1000_up(struct e1000_adapter *adapter)
 
 	// TODO makoehre adapter->tx_queue_len = netdev->tx_queue_len;
 
-	mod_timer(&adapter->watchdog_timer, jiffies);
+	schedule_delayed_work(&adapter->watchdog_task, 1);
 
 	e1000_irq_enable(adapter);
 
@@ -526,6 +526,14 @@ static void e1000_power_down_phy(struct e1000_adapter *adapter)
 	}
 }
 
+static void e1000_down_and_stop(struct e1000_adapter *adapter)
+{
+	cancel_work_sync(&adapter->reset_task);
+	cancel_delayed_work_sync(&adapter->watchdog_task);
+	cancel_delayed_work_sync(&adapter->phy_info_task);
+	cancel_delayed_work_sync(&adapter->fifo_stall_task);
+}
+
 void
 e1000_down(struct e1000_adapter *adapter)
 {
@@ -533,9 +541,7 @@ e1000_down(struct e1000_adapter *adapter)
 
 	e1000_irq_disable(adapter);
 
-	del_timer_sync(&adapter->tx_fifo_stall_timer);
-	del_timer_sync(&adapter->watchdog_timer);
-	del_timer_sync(&adapter->phy_info_timer);
+	e1000_down_and_stop(adapter);
 
 	// TODO makoehre     netdev->tx_queue_len = adapter->tx_queue_len;
 	adapter->link_speed = 0;
@@ -695,10 +701,6 @@ static int e1000_probe(struct pci_dev *pdev,
 	    return -ENODEV;
 	}
 
-
-
-
-
 	if ((err = pci_enable_device(pdev)))
 		return err;
 
@@ -847,18 +849,10 @@ static int e1000_probe(struct pci_dev *pdev,
 
 	e1000_get_bus_info(&adapter->hw);
 
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
+	INIT_DELAYED_WORK(&adapter->watchdog_task, e1000_watchdog);
+	INIT_DELAYED_WORK(&adapter->fifo_stall_task,
+			  e1000_82547_tx_fifo_stall_task);
+	INIT_DELAYED_WORK(&adapter->phy_info_task, e1000_update_phy_info_task);
 	INIT_WORK(&adapter->reset_task,
 		(void (*)(struct work_struct *))e1000_reset_task);
 
@@ -976,7 +970,7 @@ static void e1000_remove(struct pci_dev *pdev)
 	struct e1000_adapter *adapter = netdev->priv;
 	uint32_t manc;
 
-	flush_scheduled_work();
+	e1000_down_and_stop(adapter);
 
 	if (adapter->hw.mac_type >= e1000_82540 &&
 	   adapter->hw.mac_type != e1000_ich8lan &&
@@ -2083,25 +2077,31 @@ e1000_set_multi(struct rtnet_device *netdev)
 		e1000_leave_82542_rst(adapter);
 }
 
-/* Need to wait a few seconds after link up to get diagnostic information from
- * the phy */
-
-static void
-e1000_update_phy_info(unsigned long data)
+/**
+ * e1000_update_phy_info_task - get phy info
+ * @work: work struct contained inside adapter struct
+ *
+ * Need to wait a few seconds after link up to get diagnostic information from
+ * the phy
+ */
+static void e1000_update_phy_info_task(struct work_struct *work)
 {
-	struct e1000_adapter *adapter = (struct e1000_adapter *) data;
+	struct e1000_adapter *adapter = container_of(work,
+						     struct e1000_adapter,
+						     phy_info_task.work);
 	e1000_phy_get_info(&adapter->hw, &adapter->phy_info);
 }
 
 /**
- * e1000_82547_tx_fifo_stall - Timer Call-back
- * @data: pointer to adapter cast into an unsigned long
+ * e1000_82547_tx_fifo_stall_task - task to complete work
+ * @work: work struct contained inside adapter struct
  **/
 
-static void
-e1000_82547_tx_fifo_stall(unsigned long data)
+static void e1000_82547_tx_fifo_stall_task(struct work_struct *work)
 {
-	struct e1000_adapter *adapter = (struct e1000_adapter *) data;
+	struct e1000_adapter *adapter = container_of(work,
+						     struct e1000_adapter,
+						     fifo_stall_task.work);
 	struct rtnet_device *netdev = adapter->netdev;
 	uint32_t tctl;
 
@@ -2130,19 +2130,20 @@ e1000_82547_tx_fifo_stall(unsigned long data)
 			atomic_set(&adapter->tx_fifo_stall, 0);
 			rtnetif_wake_queue(netdev);
 		} else {
-			mod_timer(&adapter->tx_fifo_stall_timer, jiffies + 1);
+			schedule_delayed_work(&adapter->fifo_stall_task, 1);
 		}
 	}
 }
 
 /**
- * e1000_watchdog - Timer Call-back
- * @data: pointer to adapter cast into an unsigned long
+ * e1000_watchdog - work function
+ * @work: work struct contained inside adapter struct
  **/
-static void
-e1000_watchdog(unsigned long data)
+static void e1000_watchdog(struct work_struct *work)
 {
-	struct e1000_adapter *adapter = (struct e1000_adapter *) data;
+	struct e1000_adapter *adapter = container_of(work,
+						     struct e1000_adapter,
+						     watchdog_task.work);
 	struct rtnet_device *netdev = adapter->netdev;
 	struct e1000_tx_ring *txdr = adapter->tx_ring;
 	uint32_t link, tctl;
@@ -2214,7 +2215,7 @@ e1000_watchdog(unsigned long data)
 
 			rtnetif_carrier_on(netdev);
 			rtnetif_wake_queue(netdev);
-			mod_timer(&adapter->phy_info_timer, jiffies + 2 * HZ);
+			schedule_delayed_work(&adapter->phy_info_task, 2 * HZ);
 			adapter->smartspeed = 0;
 		}
 	} else {
@@ -2224,7 +2225,7 @@ e1000_watchdog(unsigned long data)
 			DPRINTK(LINK, INFO, "NIC Link is Down\n");
 			rtnetif_carrier_off(netdev);
 			rtnetif_stop_queue(netdev);
-			mod_timer(&adapter->phy_info_timer, jiffies + 2 * HZ);
+			schedule_delayed_work(&adapter->phy_info_task, 2 * HZ);
 
 			/* 80003ES2LAN workaround--
 			 * For packet buffer work-around on link down event;
@@ -2287,8 +2288,8 @@ e1000_watchdog(unsigned long data)
 	if (adapter->hw.mac_type == e1000_82571 && adapter->hw.laa_is_present)
 		e1000_rar_set(&adapter->hw, adapter->hw.mac_addr, 0);
 
-	/* Reset the timer */
-	mod_timer(&adapter->watchdog_timer, jiffies + 2 * HZ);
+	/* Reschedule the task */
+	schedule_delayed_work(&adapter->watchdog_task, 2 * HZ);
 }
 
 #define E1000_TX_FLAGS_CSUM		0x00000001
-- 
2.16.4

