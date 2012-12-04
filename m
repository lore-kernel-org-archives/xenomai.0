Message-ID: <50BE13D6.3070408@grandegger.com>
Date: Tue, 04 Dec 2012 16:16:38 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] rtcan: Adding device ID for PEAK PCIe card
	IPEH-003027
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>
Cc: Jonathan Bohren <jbo@jhu.edu>


Signed-off-by: Jonathan Bohren <jbo@jhu.edu>
Acked-by: Wolfgang Grandegger <wg@grandegger.com>

---

HI Gilles,

second try to the right ml. Could you please apply this patch. It looks
good from my point of view.

Thanks,

Wolfgang.

 ksrc/drivers/can/sja1000/rtcan_peak_pci.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ksrc/drivers/can/sja1000/rtcan_peak_pci.c b/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
index 53c8fef..b5ad226 100644
--- a/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
+++ b/ksrc/drivers/can/sja1000/rtcan_peak_pci.c
@@ -71,13 +71,15 @@ struct rtcan_peak_pci
 #define PITA_MISC        0x1C        // miscellanoes register
 
 #define PEAK_PCI_VENDOR_ID   0x001C  // the PCI device and vendor IDs
-#define PEAK_PCI_DEVICE_ID   0x0001
+#define PEAK_PCI_DEVICE_ID   0x0001  // Device ID for PCI and older PCIe cards
+#define PEAK_PCIE_DEVICE_ID  0x0003  // Device ID for newer PCIe cards (IPEH-003027)
 
 #define PCI_CONFIG_PORT_SIZE 0x1000  // size of the config io-memory
 #define PCI_PORT_SIZE        0x0400  // size of a channel io-memory
 
 static struct pci_device_id peak_pci_tbl[] = {
 	{PEAK_PCI_VENDOR_ID, PEAK_PCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PEAK_PCI_VENDOR_ID, PEAK_PCIE_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ }
 };
 MODULE_DEVICE_TABLE (pci, peak_pci_tbl);
-- 
1.7.9.5

