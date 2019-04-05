From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] rtnet: e1000e: Account for timer API changes
Message-ID: <d65a2c6a-307d-ee91-eede-2b9d6d387f5e@siemens.com>
Date: Fri, 5 Apr 2019 11:26:12 +0200
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
 kernel/drivers/net/drivers/e1000e/netdev.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/drivers/net/drivers/e1000e/netdev.c b/kernel/drivers/net/drivers/e1000e/netdev.c
index 9feaf071a1..baeb6aa09d 100644
--- a/kernel/drivers/net/drivers/e1000e/netdev.c
+++ b/kernel/drivers/net/drivers/e1000e/netdev.c
@@ -2879,9 +2879,15 @@ static void e1000e_update_phy_task(struct work_struct *work)
  * Need to wait a few seconds after link up to get diagnostic information from
  * the phy
  */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)
+static void e1000_update_phy_info(struct timer_list *t)
+{
+	struct e1000_adapter *adapter = from_timer(adapter, t, phy_info_timer);
+#else /* < 4.14 */
 static void e1000_update_phy_info(unsigned long data)
 {
 	struct e1000_adapter *adapter = (struct e1000_adapter *) data;
+#endif /* < 4.14 */
 
 	if (test_bit(__E1000_DOWN, &adapter->state))
 		return;
@@ -3027,9 +3033,15 @@ static void e1000e_check_82574_phy_workaround(struct e1000_adapter *adapter)
  * e1000_watchdog - Timer Call-back
  * @data: pointer to adapter cast into an unsigned long
  **/
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)
+static void e1000_watchdog(struct timer_list *t)
+{
+	struct e1000_adapter *adapter = from_timer(adapter, t, watchdog_timer);
+#else /* < 4.14 */
 static void e1000_watchdog(unsigned long data)
 {
 	struct e1000_adapter *adapter = (struct e1000_adapter *) data;
+#endif /* < 4.14 */
 
 	/* Do the rest outside of interrupt context */
 	rtdm_schedule_nrt_work(&adapter->watchdog_task);
@@ -4079,6 +4091,10 @@ static int e1000_probe(struct pci_dev *pdev,
 
 	memcpy(netdev->dev_addr, adapter->hw.mac.addr, netdev->addr_len);
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4,14,0)
+	timer_setup(&adapter->watchdog_timer, e1000_watchdog, 0);
+	timer_setup(&adapter->phy_info_timer, e1000_update_phy_info, 0);
+#else /* < 4.14 */
 	init_timer(&adapter->watchdog_timer);
 	adapter->watchdog_timer.function = e1000_watchdog;
 	adapter->watchdog_timer.data = (unsigned long) adapter;
@@ -4086,6 +4102,7 @@ static int e1000_probe(struct pci_dev *pdev,
 	init_timer(&adapter->phy_info_timer);
 	adapter->phy_info_timer.function = e1000_update_phy_info;
 	adapter->phy_info_timer.data = (unsigned long) adapter;
+#endif /* < 4.14 */
 
 	INIT_WORK(&adapter->reset_task, e1000_reset_task);
 	INIT_WORK(&adapter->watchdog_task, e1000_watchdog_task);
-- 
2.16.4

