Message-ID: <4A1A4B3F.8050704@domain.hid>
Date: Mon, 25 May 2009 09:39:43 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] rtcan: ixxat-pci: fix problems with device
	probing
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This patch fixes problems with probing and registration of the
RTCAN IXXAT PCI driver as reported by Stefan Kisdaroczi and
Sebastian Smolorz. The PCI device id table entry now specifies
the PCI sub-system id avoiding the driver's probe function to
be call unnecessarily (a PLX9050 is used for many other non-can
PCI devices). This also makes the checking of the sub-system id
obsolete.

Signed-off-by: Wolfgang Grandegger <wg@domain.hid>
---
 ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

Index: xenomai-2.4/ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c
===================================================================
--- xenomai-2.4.orig/ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c	2009-05-24 11:17:20.159718982 +0200
+++ xenomai-2.4/ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c	2009-05-25 08:02:06.607459337 +0200
@@ -73,7 +73,8 @@
 #define IXXAT_BASE_PORT_SIZE 0x0400
 
 static struct pci_device_id ixxat_pci_tbl[] = {
-	{IXXAT_PCI_VENDOR_ID, IXXAT_PCI_DEVICE_ID, IXXAT_PCI_VENDOR_ID, IXXAT_PCI_SUB_SYS_ID, 0, 0, 0},
+	{IXXAT_PCI_VENDOR_ID, IXXAT_PCI_DEVICE_ID,
+	 IXXAT_PCI_VENDOR_ID, IXXAT_PCI_SUB_SYS_ID, 0, 0, 0},
 	{ }
 };
 MODULE_DEVICE_TABLE (pci, ixxat_pci_tbl);
@@ -206,7 +207,6 @@
 					 const struct pci_device_id *ent)
 {
     int ret, channel, conf_addr;
-    u16 sub_sys_id;
     unsigned long addr;
     void __iomem *base_addr;
     struct rtcan_device *master_dev = NULL;
@@ -217,14 +217,9 @@
     if ((ret = pci_request_regions(pdev, RTCAN_DRV_NAME)))
 	goto failure;
 
-    if ((ret = pci_read_config_word(pdev, 0x2e, &sub_sys_id)))
-	goto failure_release_pci;
-
     RTCAN_DBG("%s: Initializing device %04x:%04x:%04x\n",
-	      RTCAN_DRV_NAME, pdev->vendor, pdev->device, sub_sys_id);
-
-    if (sub_sys_id != IXXAT_PCI_SUB_SYS_ID)
-	    return -ENODEV;
+	      RTCAN_DRV_NAME, pdev->vendor, pdev->device,
+	      pdev->subsystem_device);
 
     /* Enable memory and I/O space */
     if ((ret = pci_write_config_word(pdev, 0x04, 0x3)))

