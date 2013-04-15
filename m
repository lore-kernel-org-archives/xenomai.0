Message-ID: <516BA65B.5000908@grandegger.com>
Date: Mon, 15 Apr 2013 09:03:55 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] rtcan/peak_pci: add further device ids to the PCI
 device, table
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>
Cc: "Daniel M. Drucker, Ph.D." <dmd@interactive-motion.com>

Add support for further PEAK CAN PCI cards. We have confirmation that
the miniPCIe card with the device id 8 works fine. But 4 channels cards
are still not fully supported.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>

---
 ksrc/drivers/can/sja1000/rtcan_peak_pci.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/ksrc/drivers/can/sja1000/rtcan_peak_pci.c b/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
index a19b917..d13a7ff 100644
--- a/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
+++ b/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
@@ -70,16 +70,26 @@ struct rtcan_peak_pci
 #define PITA_GPIOICR     0x18        // general purpose IO interface control register
 #define PITA_MISC        0x1C        // miscellanoes register
 
-#define PEAK_PCI_VENDOR_ID   0x001C  // the PCI device and vendor IDs
-#define PEAK_PCI_DEVICE_ID   0x0001  // Device ID for PCI and older PCIe cards
-#define PEAK_PCIE_DEVICE_ID  0x0003  // Device ID for newer PCIe cards (IPEH-003027)
+#define PEAK_PCI_VENDOR_ID      0x001C  // the PCI device and vendor IDs
+#define PEAK_PCI_DEVICE_ID      0x0001  // Device ID for PCI and older PCIe cards
+#define PEAK_PCIE_DEVICE_ID     0x0003  // Device ID for newer PCIe cards (IPEH-003027)
+#define PEAK_CPCI_DEVICE_ID     0x0004  // for nextgen cPCI slot cards
+#define PEAK_MPCI_DEVICE_ID     0x0005  // for nextgen miniPCI slot cards
+#define PEAK_PC_104P_DEVICE_ID  0x0006  // PCAN-PC/104+ cards
+#define PEAK_PCI_104E_DEVICE_ID 0x0007  // PCAN-PCI/104 Express cards
+#define PEAK_MPCIE_DEVICE_ID    0x0008  // The miniPCIe slot cards
 
 #define PCI_CONFIG_PORT_SIZE 0x1000  // size of the config io-memory
 #define PCI_PORT_SIZE        0x0400  // size of a channel io-memory
 
 static struct pci_device_id peak_pci_tbl[] = {
-	{PEAK_PCI_VENDOR_ID, PEAK_PCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{PEAK_PCI_VENDOR_ID, PEAK_PCIE_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PEAK_PCI_VENDOR_ID, PEAK_PCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
+	{PEAK_PCI_VENDOR_ID, PEAK_PCIE_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
+	{PEAK_PCI_VENDOR_ID, PEAK_MPCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
+	{PEAK_PCI_VENDOR_ID, PEAK_MPCIE_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
+	{PEAK_PCI_VENDOR_ID, PEAK_PC_104P_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
+	{PEAK_PCI_VENDOR_ID, PEAK_PCI_104E_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
+	{PEAK_PCI_VENDOR_ID, PEAK_CPCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
 	{ }
 };
 MODULE_DEVICE_TABLE (pci, peak_pci_tbl);
-- 
1.7.9.5


