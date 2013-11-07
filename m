From: Konrad Banachowicz <konradb3@gmail.com>
Date: Thu,  7 Nov 2013 13:21:17 +0100
Message-Id: <1383826877-8749-2-git-send-email-konradb3@gmail.com>
In-Reply-To: <1383826877-8749-1-git-send-email-konradb3@gmail.com>
References: <1383826877-8749-1-git-send-email-konradb3@gmail.com>
Subject: [Xenomai] [PATCH 2/2] rtcan/peek_pci: add support for 3 and 4 port
	cards.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

---
 ksrc/drivers/can/sja1000/rtcan_peak_pci.c |   61 ++++++++++++++---------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/ksrc/drivers/can/sja1000/rtcan_peak_pci.c b/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
index 21b2673..132d4e8 100644
--- a/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
+++ b/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
@@ -61,8 +61,11 @@ struct rtcan_peak_pci {
 #define PELICAN_DEFAULT (SJA_CDR_CAN_MODE                                 )
 
 #define CHANNEL_SINGLE 0 /* this is a single channel device */
-#define CHANNEL_MASTER 1 /* multi channel device, this device is master */
-#define CHANNEL_SLAVE  2 /* multi channel device, this is slave */
+#define CHANNEL_MASTER 0 /* multi channel device, this device is master */
+#define CHANNEL_SLAVE  1 /* multi channel device, this is slave */
+#define CHANNEL_SLAVE_1 1 /* multi channel device, this is slave 1*/
+#define CHANNEL_SLAVE_2 2 /* multi channel device, this is slave 2*/
+#define CHANNEL_SLAVE_3 3 /* multi channel device, this is slave 3*/
 
 // important PITA registers
 #define PITA_ICR         0x00        // interrupt control register
@@ -81,6 +84,8 @@ struct rtcan_peak_pci {
 #define PCI_CONFIG_PORT_SIZE 0x1000  // size of the config io-memory
 #define PCI_PORT_SIZE        0x0400  // size of a channel io-memory
 
+static const u16 peak_pci_icr_masks[] = {0x02, 0x01, 0x40, 0x80};
+
 static struct pci_device_id peak_pci_tbl[] = {
         {PEAK_PCI_VENDOR_ID, PEAK_PCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
         {PEAK_PCI_VENDOR_ID, PEAK_PCIE_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
@@ -113,12 +118,9 @@ static void rtcan_peak_pci_irq_ack(struct rtcan_device *dev)
 
         /* Select and clear in Pita stored interrupt */
         pita_icr_low = readw(board->conf_addr + PITA_ICR);
-        if (board->channel == CHANNEL_SLAVE) {
-                if (pita_icr_low & 0x0001)
-                        writew(0x0001, board->conf_addr + PITA_ICR);
-        } else {
-                if (pita_icr_low & 0x0002)
-                        writew(0x0002, board->conf_addr + PITA_ICR);
+
+        if (pita_icr_low & peak_pci_icr_masks[board->channel]) {
+                writew(peak_pci_icr_masks[board->channel], board->conf_addr + PITA_ICR);
         }
 }
 
@@ -140,11 +142,7 @@ static void rtcan_peak_pci_del_chan(struct rtcan_device *dev,
                 rtcan_sja1000_unregister(dev);
         case 5:
                 pita_icr_high = readw(board->conf_addr + PITA_ICR + 2);
-                if (board->channel == CHANNEL_SLAVE) {
-                        pita_icr_high &= ~0x0001;
-                } else {
-                        pita_icr_high &= ~0x0002;
-                }
+                pita_icr_high &= ~peak_pci_icr_masks[board->channel];
                 writew(pita_icr_high, board->conf_addr + PITA_ICR + 2);
         case 4:
                 iounmap((void *)board->base_addr);
@@ -181,7 +179,7 @@ static int rtcan_peak_pci_add_chan(struct pci_dev *pdev, int channel,
         board->pci_dev = pdev;
         board->channel = channel;
 
-        if (channel != CHANNEL_SLAVE) {
+        if (channel == CHANNEL_MASTER) {
 
                 addr = pci_resource_start(pdev, 0);
                 board->conf_addr = ioremap(addr, PCI_CONFIG_PORT_SIZE);
@@ -209,15 +207,14 @@ static int rtcan_peak_pci_add_chan(struct pci_dev *pdev, int channel,
                 board->conf_addr = master_board->conf_addr;
         }
 
-        addr = pci_resource_start(pdev, 1);
-        if (channel == CHANNEL_SLAVE)
-                addr += 0x400;
+        addr = pci_resource_start(pdev, 1) + channel * PCI_PORT_SIZE;
 
         board->base_addr = ioremap(addr, PCI_PORT_SIZE);
         if (board->base_addr == 0) {
                 ret = -ENODEV;
                 goto failure;
         }
+
         init_step = 4;
 
         dev->board_name = peak_pci_board_name;
@@ -244,11 +241,9 @@ static int rtcan_peak_pci_add_chan(struct pci_dev *pdev, int channel,
         chip->irq_flags = RTDM_IRQTYPE_SHARED;
         chip->irq_num = pdev->irq;
         pita_icr_high = readw(board->conf_addr + PITA_ICR + 2);
-        if (channel == CHANNEL_SLAVE) {
-                pita_icr_high |= 0x0001;
-        } else {
-                pita_icr_high |= 0x0002;
-        }
+
+        pita_icr_high |= peak_pci_icr_masks[channel];
+
         writew(pita_icr_high, board->conf_addr + PITA_ICR + 2);
         init_step = 5;
 
@@ -277,6 +272,8 @@ static int peak_pci_init_one(struct pci_dev *pdev,
                              const struct pci_device_id *ent)
 {
         int ret;
+        int num_channels;
+        int i;
         u16 sub_sys_id;
         struct rtcan_device *master_dev = NULL;
 
@@ -299,16 +296,18 @@ static int peak_pci_init_one(struct pci_dev *pdev,
         if ((ret = pci_write_config_word(pdev, 0x44, 0)))
                 goto failure_cleanup;
 
-        if (sub_sys_id > 3) {
-                if ((ret = rtcan_peak_pci_add_chan(pdev, CHANNEL_MASTER,
-                                                   &master_dev)))
-                        goto failure_cleanup;
-                if ((ret = rtcan_peak_pci_add_chan(pdev, CHANNEL_SLAVE,
-                                                   &master_dev)))
-                        goto failure_cleanup;
+        if (sub_sys_id >= 12) {
+                num_channels = 4;
+        } else if (sub_sys_id >= 12) {
+                num_channels = 3;
+        } else if (sub_sys_id >= 4) {
+                num_channels = 2;
         } else {
-                if ((ret = rtcan_peak_pci_add_chan(pdev, CHANNEL_SINGLE,
-                                                   &master_dev)))
+                num_channels = 1;
+        }
+
+        for(i = 0; i < num_channels; i++) {
+                if ((ret = rtcan_peak_pci_add_chan(pdev, i, &master_dev)))
                         goto failure_cleanup;
         }
 
-- 
1.7.9.5


