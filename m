From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 11/12] drivers/can: Convert to rtdm_available() and clean up
Date: Fri, 13 Sep 2019 18:46:54 +0200
Message-Id: <94a43072168f6f29e8cf6945edd1887c0c1c98f0.1568393215.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1568393215.git.jan.kiszka@siemens.com>
References: <cover.1568393215.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1568393215.git.jan.kiszka@siemens.com>
References: <cover.1568393215.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Properly fail if the core is not available. This allows to remove checks
from the exit paths.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/can/mscan/rtcan_mscan_mpc5xxx.c |  3 +++
 kernel/drivers/can/rtcan_module.c              |  7 ++-----
 kernel/drivers/can/rtcan_virt.c                |  7 ++-----
 kernel/drivers/can/sja1000/rtcan_adv_pci.c     |  9 ++++-----
 kernel/drivers/can/sja1000/rtcan_ems_pci.c     |  9 ++++-----
 kernel/drivers/can/sja1000/rtcan_esd_pci.c     |  9 ++++-----
 kernel/drivers/can/sja1000/rtcan_isa.c         |  7 ++-----
 kernel/drivers/can/sja1000/rtcan_ixxat_pci.c   |  9 ++++-----
 kernel/drivers/can/sja1000/rtcan_mem.c         |  7 ++-----
 kernel/drivers/can/sja1000/rtcan_peak_dng.c    |  7 ++-----
 kernel/drivers/can/sja1000/rtcan_peak_pci.c    |  9 ++++-----
 kernel/drivers/can/sja1000/rtcan_plx_pci.c     |  9 ++++-----
 kernel/drivers/can/sja1000/rtcan_sja1000.c     | 10 +++++-----
 13 files changed, 42 insertions(+), 60 deletions(-)

diff --git a/kernel/drivers/can/mscan/rtcan_mscan_mpc5xxx.c b/kernel/drivers/can/mscan/rtcan_mscan_mpc5xxx.c
index e43e1cf7e4..de08d94542 100644
--- a/kernel/drivers/can/mscan/rtcan_mscan_mpc5xxx.c
+++ b/kernel/drivers/can/mscan/rtcan_mscan_mpc5xxx.c
@@ -374,6 +374,9 @@ static struct of_platform_driver mpc5xxx_can_driver = {
 
 static int __init mpc5xxx_can_init(void)
 {
+	if (!rtdm_available())
+		return -ENOSYS;
+
 	return of_register_platform_driver(&mpc5xxx_can_driver);
 }
 module_init(mpc5xxx_can_init);
diff --git a/kernel/drivers/can/rtcan_module.c b/kernel/drivers/can/rtcan_module.c
index eca8acb8cf..fbc5c35e44 100644
--- a/kernel/drivers/can/rtcan_module.c
+++ b/kernel/drivers/can/rtcan_module.c
@@ -415,8 +415,8 @@ int __init rtcan_init(void)
 {
     int err = 0;
 
-    if (!realtime_core_enabled())
-	    return 0;
+    if (!rtdm_available())
+	return -ENOSYS;
 
     printk("RT-Socket-CAN %d.%d.%d - %s\n",
 	   RTCAN_MAJOR_VER, RTCAN_MINOR_VER, RTCAN_BUGFIX_VER,
@@ -437,9 +437,6 @@ int __init rtcan_init(void)
 
 void __exit rtcan_exit(void)
 {
-    if (!realtime_core_enabled())
-	    return;
-
     rtcan_raw_proto_unregister();
 #ifdef CONFIG_PROC_FS
     rtcan_proc_unregister();
diff --git a/kernel/drivers/can/rtcan_virt.c b/kernel/drivers/can/rtcan_virt.c
index 698c31a24e..c86c17fc38 100644
--- a/kernel/drivers/can/rtcan_virt.c
+++ b/kernel/drivers/can/rtcan_virt.c
@@ -157,8 +157,8 @@ static int __init rtcan_virt_init(void)
 {
 	int i, err = 0;
 
-	if (!realtime_core_enabled())
-		return 0;
+	if (!rtdm_available())
+		return -ENOSYS;
 
 	for (i = 0; i < devices; i++) {
 		err = rtcan_virt_init_one(i);
@@ -183,9 +183,6 @@ static void __exit rtcan_virt_exit(void)
 	int i;
 	struct rtcan_device *dev;
 
-	if (!realtime_core_enabled())
-	    return;
-
 	for (i = 0; i < devices; i++) {
 		dev = rtcan_virt_devs[i];
 
diff --git a/kernel/drivers/can/sja1000/rtcan_adv_pci.c b/kernel/drivers/can/sja1000/rtcan_adv_pci.c
index 32cf71ee1f..d33e79b3e7 100644
--- a/kernel/drivers/can/sja1000/rtcan_adv_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_adv_pci.c
@@ -249,6 +249,9 @@ static int adv_pci_init_one(struct pci_dev *pdev,
 
 	struct rtcan_device *master_dev = NULL;
 
+	if (!rtdm_available())
+		return -ENODEV;
+
 	dev_info(&pdev->dev, "RTCAN Registering card");
 
 	ret = pci_enable_device(pdev);
@@ -357,16 +360,12 @@ static struct pci_driver rtcan_adv_pci_driver = {
 
 static int __init rtcan_adv_pci_init(void)
 {
-	if (!realtime_core_enabled())
-		return 0;
-
 	return pci_register_driver(&rtcan_adv_pci_driver);
 }
 
 static void __exit rtcan_adv_pci_exit(void)
 {
-	if (realtime_core_enabled())
-		pci_unregister_driver(&rtcan_adv_pci_driver);
+	pci_unregister_driver(&rtcan_adv_pci_driver);
 }
 
 module_init(rtcan_adv_pci_init);
diff --git a/kernel/drivers/can/sja1000/rtcan_ems_pci.c b/kernel/drivers/can/sja1000/rtcan_ems_pci.c
index e3c178f7bb..57e0f36762 100644
--- a/kernel/drivers/can/sja1000/rtcan_ems_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_ems_pci.c
@@ -238,6 +238,9 @@ static int ems_pci_add_card(struct pci_dev *pdev,
 	int max_chan, conf_size, base_bar;
 	int err, i;
 
+	if (!rtdm_available())
+		return -ENODEV;
+
 	/* Enabling PCI device */
 	if (pci_enable_device(pdev) < 0) {
 		dev_err(&pdev->dev, "Enabling PCI device failed\n");
@@ -390,16 +393,12 @@ static struct pci_driver ems_pci_driver = {
 
 static int __init ems_pci_init(void)
 {
-	if (!realtime_core_enabled())
-		return 0;
-
 	return pci_register_driver(&ems_pci_driver);
 }
 
 static void __exit ems_pci_exit(void)
 {
-	if (realtime_core_enabled())
-		pci_unregister_driver(&ems_pci_driver);
+	pci_unregister_driver(&ems_pci_driver);
 }
 
 module_init(ems_pci_init);
diff --git a/kernel/drivers/can/sja1000/rtcan_esd_pci.c b/kernel/drivers/can/sja1000/rtcan_esd_pci.c
index 924c7d0c74..a383d1d372 100644
--- a/kernel/drivers/can/sja1000/rtcan_esd_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_esd_pci.c
@@ -224,6 +224,9 @@ static int esd_pci_init_one(struct pci_dev *pdev,
 	void __iomem *conf_addr;
 	struct rtcan_device *master_dev = NULL;
 
+	if (!rtdm_available())
+		return -ENODEV;
+
 	if ((ret = pci_enable_device (pdev)))
 		goto failure;
 
@@ -342,16 +345,12 @@ static struct pci_driver rtcan_esd_pci_driver = {
 
 static int __init rtcan_esd_pci_init(void)
 {
-	if (!realtime_core_enabled())
-		return 0;
-
 	return pci_register_driver(&rtcan_esd_pci_driver);
 }
 
 static void __exit rtcan_esd_pci_exit(void)
 {
-	if (realtime_core_enabled())
-		pci_unregister_driver(&rtcan_esd_pci_driver);
+	pci_unregister_driver(&rtcan_esd_pci_driver);
 }
 
 module_init(rtcan_esd_pci_init);
diff --git a/kernel/drivers/can/sja1000/rtcan_isa.c b/kernel/drivers/can/sja1000/rtcan_isa.c
index c506081db8..f4c59cd86b 100644
--- a/kernel/drivers/can/sja1000/rtcan_isa.c
+++ b/kernel/drivers/can/sja1000/rtcan_isa.c
@@ -161,8 +161,8 @@ static int __init rtcan_isa_init(void)
 	int i, err;
 	int devices = 0;
 
-	if (!realtime_core_enabled())
-		return 0;
+	if (!rtdm_available())
+		return -ENOSYS;
 
 	for (i = 0; i < RTCAN_ISA_MAX_DEV && io[i] != 0; i++) {
 		err = rtcan_isa_init_one(i);
@@ -187,9 +187,6 @@ static void rtcan_isa_exit(void)
 	int i;
 	struct rtcan_device *dev;
 
-	if (!realtime_core_enabled())
-		return;
-
 	for (i = 0; i < RTCAN_ISA_MAX_DEV; i++) {
 		dev = rtcan_isa_devs[i];
 		if (!dev)
diff --git a/kernel/drivers/can/sja1000/rtcan_ixxat_pci.c b/kernel/drivers/can/sja1000/rtcan_ixxat_pci.c
index eaabe1ac77..cb5169c80f 100644
--- a/kernel/drivers/can/sja1000/rtcan_ixxat_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_ixxat_pci.c
@@ -212,6 +212,9 @@ static int ixxat_pci_init_one(struct pci_dev *pdev,
     void __iomem *base_addr;
     struct rtcan_device *master_dev = NULL;
 
+    if (!rtdm_available())
+	return -ENODEV;
+
     if ((ret = pci_enable_device (pdev)))
 	goto failure;
 
@@ -296,17 +299,13 @@ static struct pci_driver rtcan_ixxat_pci_driver = {
 
 static int __init rtcan_ixxat_pci_init(void)
 {
-	if (!realtime_core_enabled())
-		return 0;
-
     return pci_register_driver(&rtcan_ixxat_pci_driver);
 }
 
 
 static void __exit rtcan_ixxat_pci_exit(void)
 {
-	if (realtime_core_enabled())
-		pci_unregister_driver(&rtcan_ixxat_pci_driver);
+	pci_unregister_driver(&rtcan_ixxat_pci_driver);
 }
 
 module_init(rtcan_ixxat_pci_init);
diff --git a/kernel/drivers/can/sja1000/rtcan_mem.c b/kernel/drivers/can/sja1000/rtcan_mem.c
index c668f8f430..178b321d92 100644
--- a/kernel/drivers/can/sja1000/rtcan_mem.c
+++ b/kernel/drivers/can/sja1000/rtcan_mem.c
@@ -173,8 +173,8 @@ static int __init rtcan_mem_init(void)
 	int i, err;
 	int devices = 0;
 
-	if (!realtime_core_enabled())
-		return 0;
+	if (!rtdm_available())
+		return -ENOSYS;
 
 	for (i = 0; i < RTCAN_MEM_MAX_DEV && mem[i] != 0; i++) {
 		err = rtcan_mem_init_one(i);
@@ -200,9 +200,6 @@ static void rtcan_mem_exit(void)
 	struct rtcan_device *dev;
 	volatile void __iomem *vmem;
 
-	if (!realtime_core_enabled())
-		return;
-
 	for (i = 0; i < RTCAN_MEM_MAX_DEV; i++) {
 		dev = rtcan_mem_devs[i];
 		if (!dev)
diff --git a/kernel/drivers/can/sja1000/rtcan_peak_dng.c b/kernel/drivers/can/sja1000/rtcan_peak_dng.c
index b174625077..9207be55e8 100644
--- a/kernel/drivers/can/sja1000/rtcan_peak_dng.c
+++ b/kernel/drivers/can/sja1000/rtcan_peak_dng.c
@@ -345,9 +345,6 @@ static void rtcan_peak_dng_exit(void)
     int i;
     struct rtcan_device *dev;
 
-    if (!realtime_core_enabled())
-        return;
-
     for (i = 0, dev = rtcan_peak_dng_devs[i];
 	 i < RTCAN_PEAK_DNG_MAX_DEV && dev != NULL;
 	 i++)
@@ -362,8 +359,8 @@ static int __init rtcan_peak_dng_init(void)
 {
     int i, ret = -EINVAL, done = 0;
 
-    if (!realtime_core_enabled())
-        return 0;
+    if (!rtdm_available())
+	return -ENOSYS;
 
     if (pnp_register_driver(&rtcan_peak_dng_pnp_driver) == 0)
 	pnp_registered = 1;
diff --git a/kernel/drivers/can/sja1000/rtcan_peak_pci.c b/kernel/drivers/can/sja1000/rtcan_peak_pci.c
index 0fdc598be8..ad7d46bbb2 100644
--- a/kernel/drivers/can/sja1000/rtcan_peak_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_peak_pci.c
@@ -284,6 +284,9 @@ static int peak_pci_init_one(struct pci_dev *pdev,
     u16 sub_sys_id;
     struct rtcan_device *master_dev = NULL;
 
+    if (!rtdm_available())
+	return -ENODEV;
+
     printk("%s: initializing device %04x:%04x\n",
 	   RTCAN_DRV_NAME,  pdev->vendor, pdev->device);
 
@@ -353,17 +356,13 @@ static struct pci_driver rtcan_peak_pci_driver = {
 
 static int __init rtcan_peak_pci_init(void)
 {
-	if (!realtime_core_enabled())
-		return 0;
-
         return pci_register_driver(&rtcan_peak_pci_driver);
 }
 
 
 static void __exit rtcan_peak_pci_exit(void)
 {
-	if (realtime_core_enabled())
-		pci_unregister_driver(&rtcan_peak_pci_driver);
+	pci_unregister_driver(&rtcan_peak_pci_driver);
 }
 
 module_init(rtcan_peak_pci_init);
diff --git a/kernel/drivers/can/sja1000/rtcan_plx_pci.c b/kernel/drivers/can/sja1000/rtcan_plx_pci.c
index b90a43d139..61ae6a2b66 100644
--- a/kernel/drivers/can/sja1000/rtcan_plx_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_plx_pci.c
@@ -460,6 +460,9 @@ static int plx_pci_add_card(struct pci_dev *pdev,
 	u32 val;
 	void __iomem *addr;
 
+	if (!rtdm_available())
+		return -ENODEV;
+
 	ci = (struct plx_pci_card_info *)ent->driver_data;
 
 	if (pci_enable_device(pdev) < 0) {
@@ -596,16 +599,12 @@ static struct pci_driver plx_pci_driver = {
 
 static int __init plx_pci_init(void)
 {
-	if (!realtime_core_enabled())
-		return 0;
-
 	return pci_register_driver(&plx_pci_driver);
 }
 
 static void __exit plx_pci_exit(void)
 {
-	if (realtime_core_enabled())
-		pci_unregister_driver(&plx_pci_driver);
+	pci_unregister_driver(&plx_pci_driver);
 }
 
 module_init(plx_pci_init);
diff --git a/kernel/drivers/can/sja1000/rtcan_sja1000.c b/kernel/drivers/can/sja1000/rtcan_sja1000.c
index c7712ab307..842456dfdb 100644
--- a/kernel/drivers/can/sja1000/rtcan_sja1000.c
+++ b/kernel/drivers/can/sja1000/rtcan_sja1000.c
@@ -822,17 +822,17 @@ void rtcan_sja1000_unregister(struct rtcan_device *dev)
 
 int __init rtcan_sja_init(void)
 {
-	if (realtime_core_enabled())
-		printk("RTCAN SJA1000 driver initialized\n");
+	if (!rtdm_available())
+		return -ENOSYS;
 
-    return 0;
+	printk("RTCAN SJA1000 driver initialized\n");
+	return 0;
 }
 
 
 void __exit rtcan_sja_exit(void)
 {
-	if (realtime_core_enabled())
-		printk("%s removed\n", sja_ctrl_name);
+	printk("%s removed\n", sja_ctrl_name);
 }
 
 module_init(rtcan_sja_init);
-- 
2.16.4


