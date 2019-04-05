From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] rtnet: igb: Account for timer API changes
Message-ID: <d8004017-d1e6-a7d5-2681-eaaf083faa9c@siemens.com>
Date: Fri, 5 Apr 2019 14:29:43 +0200
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

init_timer was removed in 4.15.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/drivers/igb/igb_main.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/drivers/net/drivers/igb/igb_main.c b/kernel/drivers/net/drivers/igb/igb_main.c
index 093ff34808..2c9d51e7f2 100644
--- a/kernel/drivers/net/drivers/igb/igb_main.c
+++ b/kernel/drivers/net/drivers/igb/igb_main.c
@@ -203,8 +203,13 @@ static void igb_clean_all_rx_rings(struct igb_adapter *);
 static void igb_clean_tx_ring(struct igb_ring *);
 static void igb_clean_rx_ring(struct igb_ring *);
 static void igb_set_rx_mode(struct rtnet_device *);
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)
+static void igb_update_phy_info(struct timer_list *);
+static void igb_watchdog(struct timer_list *);
+#else
 static void igb_update_phy_info(unsigned long);
 static void igb_watchdog(unsigned long);
+#endif
 static void igb_watchdog_task(struct work_struct *);
 static netdev_tx_t igb_xmit_frame(struct rtskb *skb, struct rtnet_device *);
 static struct net_device_stats *igb_get_stats(struct rtnet_device *);
@@ -2195,10 +2200,15 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		wr32(E1000_TXPBS, I210_TXPBSIZE_DEFAULT);
 	}
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)
+	timer_setup(&adapter->watchdog_timer, igb_watchdog, 0);
+	timer_setup(&adapter->phy_info_timer, igb_update_phy_info, 0);
+#else /* < 4.14 */
 	setup_timer(&adapter->watchdog_timer, igb_watchdog,
 		    (unsigned long) adapter);
 	setup_timer(&adapter->phy_info_timer, igb_update_phy_info,
 		    (unsigned long) adapter);
+#endif /* < 4.14 */
 
 	INIT_WORK(&adapter->reset_task, igb_reset_task);
 	INIT_WORK(&adapter->watchdog_task, igb_watchdog_task);
@@ -3511,9 +3521,15 @@ static void igb_check_wvbr(struct igb_adapter *adapter)
 /* Need to wait a few seconds after link up to get diagnostic information from
  * the phy
  */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)
+static void igb_update_phy_info(struct timer_list *t)
+{
+	struct igb_adapter *adapter = from_timer(adapter, t, phy_info_timer);
+#else /* < 4.14 */
 static void igb_update_phy_info(unsigned long data)
 {
 	struct igb_adapter *adapter = (struct igb_adapter *) data;
+#endif /* < 4.14 */
 	igb_get_phy_info(&adapter->hw);
 }
 
@@ -3600,9 +3616,15 @@ static void igb_check_lvmmc(struct igb_adapter *adapter)
  *  igb_watchdog - Timer Call-back
  *  @data: pointer to adapter cast into an unsigned long
  **/
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)
+static void igb_watchdog(struct timer_list *t)
+{
+	struct igb_adapter *adapter = from_timer(adapter, t, watchdog_timer);
+#else /* < 4.14 */
 static void igb_watchdog(unsigned long data)
 {
 	struct igb_adapter *adapter = (struct igb_adapter *)data;
+#endif /* < 4.14 */
 	/* Do the rest outside of interrupt context */
 	schedule_work(&adapter->watchdog_task);
 }
-- 
2.16.4

