Message-ID: <47665F6C.1000007@domain.hid>
Date: Mon, 17 Dec 2007 12:37:16 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <OFD2B0EC2A.B4C937F8-ONC12573AD.0036F9DB-C12573AD.00370BC4@domain.hid>
	<475DA397.6000408@domain.hid>
In-Reply-To: <475DA397.6000408@domain.hid>
Content-Type: multipart/mixed; boundary="------------090008090903030805080701"
Subject: Re: [Xenomai-core] Antwort: Xenomai v2.4.0:
 CONFIG_XENO_OPT_SHIRQ_LEVEL vs. CONFIG_XENO_OPT_SHIRQ
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Thomas Wiedemann <Thomas.Wiedemann@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------090008090903030805080701
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Wolfgang Grandegger wrote:
> Thomas Wiedemann wrote:
>> Hi,
>>
>> we had a problem compiling the CAN-Driver for the last release candidate 
>> when
>> shared interrupts had been enabled, because of the re-named option
>> "CONFIG_XENO_OPT_SHIRQ_LEVEL.". After a quick look, version 2.4.0 still
>> doesn't fix this. A patch is included (for ksrc/drivers/can).
> 
> Ah, thanks for reporting. I'm going to remove these #ifdefs a.s.a.p.
> It's sufficient to print an appropriate error messsage in case interrupt
> registration fails with -EBUSY.

The attached patch fixes this issue. Here is the ChangeLog entry:

2007-12-17  Wolfgang Grandegger  <wg@domain.hid>

  * ksrc/drivers/can/sja1000/{rtcan_sja1000.c, rtcan_*_pci.c}: Remove
  CONFIG_XENO_OPT_SHIRQ* ifdefs to fix build problems with recent
  versions of Xenomai. If rtdm_irq_request() now fails with -EBUSY, an
  error message reminds the user to check for shared interrupt support.

  * ksrc/drivers/can/rtcan_dev.c (rtcan_dev_unregister): unregister
  devices properly in case refcounts are disabled.

If there are no objections, I'm going to apply this patch to Xenomai
v2.3.x, v2.4.x and the trunk.

Wolfgang.

--------------090008090903030805080701
Content-Type: text/x-patch;
 name="xenomai-rtcan-shirq-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xenomai-rtcan-shirq-fix.patch"

Index: ChangeLog
===================================================================
--- ChangeLog	(revision 3274)
+++ ChangeLog	(working copy)
@@ -1,3 +1,13 @@
+2007-12-17  Wolfgang Grandegger  <wg@domain.hid>
+
+	* ksrc/drivers/can/sja1000/{rtcan_sja1000.c, rtcan_*_pci.c}: Remove
+	CONFIG_XENO_OPT_SHIRQ* ifdefs to fix build problems with recent
+	versions of Xenomai. If rtdm_irq_request() now fails with -EBUSY, an
+	error message reminds the user to check for shared interrupt support.
+
+	* ksrc/drivers/can/rtcan_dev.c (rtcan_dev_unregister): unregister
+	devices properly in case refcounts are disabled.
+
 2007-12-09  Philippe Gerum  <rpm@xenomai.org>
 
 	* include/native/misc.h: Do not run the auto-cleanup code for I/O
Index: ksrc/drivers/can/rtcan_dev.c
===================================================================
--- ksrc/drivers/can/rtcan_dev.c	(revision 3274)
+++ ksrc/drivers/can/rtcan_dev.c	(working copy)
@@ -260,7 +260,6 @@ int rtcan_dev_register(struct rtcan_devi
 
 int rtcan_dev_unregister(struct rtcan_device *dev)
 {
-#ifdef RTCAN_USE_REFCOUNT
     rtdm_lockctx_t context;
 
 
@@ -278,6 +277,7 @@ int rtcan_dev_unregister(struct rtcan_de
 
     rtdm_lock_get_irqsave(&rtcan_devices_rt_lock, context);
 
+#ifdef RTCAN_USE_REFCOUNT
     while (atomic_read(&dev->refcount) > 0) {
         rtdm_lock_put_irqrestore(&rtcan_devices_rt_lock, context);
         up(&rtcan_devices_nrt_lock);
@@ -290,21 +290,20 @@ int rtcan_dev_unregister(struct rtcan_de
         down(&rtcan_devices_nrt_lock);
         rtdm_lock_get_irqsave(&rtcan_devices_rt_lock, context);
     }
+#endif
     rtcan_devices[dev->ifindex - 1] = NULL;
 
     rtdm_lock_put_irqrestore(&rtcan_devices_rt_lock, context);
     up(&rtcan_devices_nrt_lock);
 
+#ifdef RTCAN_USE_REFCOUNT
     RTCAN_ASSERT(atomic_read(&dev->refcount) == 0,
 		 printk("RTCAN: dev reference counter < 0!\n"););
+#endif
 
     printk("RTCAN: unregistered %s\n", dev->name);
 
     return 0;
-#else
-    printk("RTCAN: Oops, unexpected call of rtcan_dev_unregister()\n");
-    return -EINVAL;
-#endif
 }
 
 
Index: ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c
===================================================================
--- ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c	(revision 3274)
+++ ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c	(working copy)
@@ -186,7 +186,7 @@ static int rtcan_ixxat_pci_add_chan(stru
     /* Register SJA1000 device */
     ret = rtcan_sja1000_register(dev);
     if (ret) {
-	printk(KERN_ERR "ERROR while trying to register SJA1000 device %d!\n",
+	printk(KERN_ERR "ERROR %d while trying to register SJA1000 device!\n",
 	       ret);
 	goto failure;
     }
@@ -254,15 +254,11 @@ static int __devinit ixxat_pci_init_one 
 	goto failure_iounmap;
 
     if (channel != CHANNEL_SINGLE) {
-#ifdef CONFIG_XENO_OPT_SHIRQ_LEVEL
 	channel = CHANNEL_SLAVE;
 	if ((ret = rtcan_ixxat_pci_add_chan(pdev, channel,
 					    &master_dev, conf_addr,
 					    base_addr + CHANNEL_OFFSET)))
 	    goto failure_iounmap;
-#else
-	printk("Shared interrupts not enabled, using single channel!\n");
-#endif
     }
 
     pci_set_drvdata(pdev, master_dev);
Index: ksrc/drivers/can/sja1000/rtcan_peak_pci.c
===================================================================
--- ksrc/drivers/can/sja1000/rtcan_peak_pci.c	(revision 3274)
+++ ksrc/drivers/can/sja1000/rtcan_peak_pci.c	(working copy)
@@ -247,10 +247,10 @@ static int rtcan_peak_pci_add_chan(struc
     /* Register SJA1000 device */
     ret = rtcan_sja1000_register(dev);
     if (ret) {
-	printk(KERN_ERR "ERROR while trying to register SJA1000 device %d!\n",
-	       ret);
+	printk(KERN_ERR
+	       "ERROR %d while trying to register SJA1000 device!\n", ret);
 	goto failure;
-    }    
+    }
 
     if (channel != CHANNEL_SLAVE)
 	*master_dev = dev;
@@ -292,13 +292,9 @@ static int __devinit peak_pci_init_one (
 	if ((ret = rtcan_peak_pci_add_chan(pdev, CHANNEL_MASTER, 
 					   &master_dev)))
 	    goto failure_cleanup;
-#ifdef CONFIG_XENO_OPT_SHIRQ_LEVEL
 	if ((ret = rtcan_peak_pci_add_chan(pdev, CHANNEL_SLAVE, 
 					   &master_dev)))
 	    goto failure_cleanup;
-#else
-	printk("Shared interrupts not enabled, using single channel!\n");
-#endif
     } else {
 	if ((ret = rtcan_peak_pci_add_chan(pdev, CHANNEL_SINGLE,
 					   &master_dev)))
Index: ksrc/drivers/can/sja1000/rtcan_sja1000.c
===================================================================
--- ksrc/drivers/can/sja1000/rtcan_sja1000.c	(revision 3274)
+++ ksrc/drivers/can/sja1000/rtcan_sja1000.c	(working copy)
@@ -763,7 +763,9 @@ int rtcan_sja1000_register(struct rtcan_
 			   chip->irq_num, rtcan_sja_interrupt,
 			   chip->irq_flags, sja_ctrl_name, dev);
     if (ret) {
-	printk("ERROR! IRQ %d busy or invalid (code=%d)!\n", chip->irq_num, ret);
+	printk(KERN_ERR "ERROR %d: IRQ %d is %s!\n",
+	       ret, chip->irq_num, ret == -EBUSY ?
+	       "busy, check shared interrupt support" : "invalid");
 	return ret;
     }
 
@@ -772,7 +774,8 @@ int rtcan_sja1000_register(struct rtcan_
     /* Register RTDM device */
     ret = rtcan_dev_register(dev);
     if (ret) {
-	printk(KERN_ERR "ERROR while trying to register RTCAN device!\n");
+	    printk(KERN_ERR
+		   "ERROR %d while trying to register RTCAN device!\n", ret);
         goto out_irq_free;
     }
 
Index: ksrc/drivers/can/sja1000/rtcan_ems_pci.c
===================================================================
--- ksrc/drivers/can/sja1000/rtcan_ems_pci.c	(revision 3274)
+++ ksrc/drivers/can/sja1000/rtcan_ems_pci.c	(working copy)
@@ -236,7 +236,7 @@ static int rtcan_ems_pci_add_chan(struct
 	err = rtcan_sja1000_register(dev);
 	if (err) {
 		printk(KERN_ERR
-		       "ERROR while trying to register SJA1000 device %d!\n",
+		       "ERROR %d while trying to register SJA1000 device!\n",
 		       err);
 		goto failure;
 	}
@@ -272,13 +272,9 @@ static int __devinit ems_pci_init_one (s
 	if ((err = rtcan_ems_pci_add_chan(pdev, EMS_PCI_MASTER,
 					  &master_dev)))
 		goto failure_cleanup;
-#ifdef CONFIG_XENO_OPT_SHIRQ_LEVEL
 	if ((err = rtcan_ems_pci_add_chan(pdev, EMS_PCI_SLAVE,
 					  &master_dev)))
 		goto failure_cleanup;
-#else
-	printk("Shared interrupts not enabled, using single channel!\n");
-#endif
 
 	pci_set_drvdata(pdev, master_dev);
 	return 0;

--------------090008090903030805080701--

