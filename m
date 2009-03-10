Message-ID: <49B66C48.7070208@domain.hid>
Date: Tue, 10 Mar 2009 14:34:00 +0100
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040905050403000405050303"
Subject: [Xenomai-core] [PATCH] Correct error handling in rtcan_ixxat_pci.c
 if card has wrong sub_sys_id
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------040905050403000405050303
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

the subject says it all. The patch is only compile-tested.

-- 
Sebastian

--------------040905050403000405050303
Content-Type: text/plain;
 name="rtcan_ixxat_pci.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtcan_ixxat_pci.patch"

Index: ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c
===================================================================
--- ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c	(Revision 4679)
+++ ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c	(Arbeitskopie)
@@ -223,8 +223,10 @@ static int __devinit ixxat_pci_init_one 
     RTCAN_DBG("%s: Initializing device %04x:%04x:%04x\n",
 	      RTCAN_DRV_NAME, pdev->vendor, pdev->device, sub_sys_id);
 
-    if (sub_sys_id != IXXAT_PCI_SUB_SYS_ID)
-	    return -ENODEV;
+    if (sub_sys_id != IXXAT_PCI_SUB_SYS_ID) {
+	ret = -ENODEV;
+	goto failure_release_pci;
+    }
 
     /* Enable memory and I/O space */
     if ((ret = pci_write_config_word(pdev, 0x04, 0x3)))

--------------040905050403000405050303--

