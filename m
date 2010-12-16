Message-ID: <20101216130423.19383g369jps4nk0@domain.hid>
Date: Thu, 16 Dec 2010 13:04:23 +0100
From: Michel He <michel.he@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Gumstix / RTNET / INT Problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello All,

     I'm currently developing a RTNet RTDM driver for the chip SMSC  
Lan9221 in Gumstix expansion board. I'm using the patch from  
blog.gmane.org/gmane.linux.real-time...overo-sakoman.diff for Linux  
2.6.33.

     I have some problems to make the driver work after following the  
porting guide for programmer on the RTNet website. However, read/write  
from/to register seems to be ok. You can find the log below.

Actually, the problem is the interrupt management is not working at  
all. It's never being called from Xenomai. That's the irq setup inside  
the drv_probe:  retval = rtdm_irq_request(&pdata->irq_handle,  
dev->irq, smsc911x_irqhandler, RTDM_IRQTYPE_EDGE |  
RTDM_IRQTYPE_SHARED, dev->name, dev); You can find the source codes  
below.


RTnet: initialising real-time networking
smsc911x: Driver version 2010-12-10.
rteth0: smsc911x_init: Driver Parameters:
rteth0: smsc911x_init: LAN base: 0xD0CB8000
rteth0: smsc911x_init: IRQ: 336
rteth0: smsc911x_init: PHY will be autodetected.
rteth0: smsc911x_init: BYTE_TEST: 0x87654321
rteth0: smsc911x_init: LAN911x identified, idrev: 0x92210000, generation: 4
RTnet: registered rteth0
rteth0: smsc911x_drv_probe: Network interface: "rteth0"
rteth0: smsc911x_mii_init: External PHY is not supported, using internal PHY
smsc911x-mdio: probed
rteth0: smsc911x_mii_probe: PHY 1: addr 1, phy_id 0x0007C0C3
rteth0: attached PHY driver [Generic PHY]  
(mii_bus:phy_addr=ffffffff:01, irq=-1)
rteth0: smsc911x_phy_check_loopbackpkt: Successfully verified loopback packet
rteth0: smsc911x_mii_probe: Passed Loop Back Test
rteth0: smsc911x_mii_probe: phy initialised successfully
rteth0: smsc911x_drv_probe: Mac Address is read from LAN911x EEPROM
MAC Address: 00:15:c9:28:df:7a
initializing loopback...
RTnet: registered rtlo
rteth0: smsc911x_open: irq polarity: active low
rteth0: smsc911x_open: irq type: open drain
rteth0: smsc911x_open: Testing irq handler using IRQ 336
ISR failed signaling test (IRQ 336)
...


Probe and open functions inside the driver :
static int __devinit smsc911x_drv_probe(struct platform_device *pdev)
{
	struct rtnet_device *dev;
	struct smsc911x_data *pdata;
	struct smsc911x_platform_config *config = pdev->dev.platform_data;
	struct resource *res, *irq_res;
	unsigned int intcfg = 0;
	int res_size, irq_flags;
	int retval;
	static int cards_found = -1;

	cards_found++;

	if (cards[cards_found] == 0)
	return -ENODEV;

	pr_info("%s: Driver version %s.\n", SMSC_CHIPNAME, SMSC_DRV_VERSION);

	/* platform data specifies irq & dynamic bus configuration */
	if (!pdev->dev.platform_data) {
		pr_warning("%s: platform_data not provided\n", SMSC_CHIPNAME);
		retval = -ENODEV;
		goto out_0;
	}

	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
					   "smsc911x-memory");
	if (!res)
		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	if (!res) {
		pr_warning("%s: Could not allocate resource.\n",
			SMSC_CHIPNAME);
		retval = -ENODEV;
		goto out_0;
	}
	res_size = resource_size(res);

	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
	if (!irq_res) {
		pr_warning("%s: Could not allocate irq resource.\n",
			SMSC_CHIPNAME);
		retval = -ENODEV;
		goto out_0;
	}

	if (!request_mem_region(res->start, res_size, SMSC_CHIPNAME)) {
		retval = -EBUSY;
		goto out_0;
	}

	dev = rt_alloc_etherdev(sizeof(struct smsc911x_data));
	if (!dev) {
		pr_warning("%s: Could not allocate device.\n", SMSC_CHIPNAME);
		retval = -ENOMEM;
		goto out_release_io_1;
	}

     rtdev_alloc_name(dev, "rteth%d");
     rt_rtdev_connect(dev, &RTDEV_manager);
     RTNET_SET_MODULE_OWNER(dev);
     dev->vers = RTDEV_VERS_2_0;

	pdata = dev->priv;
	memset(pdata, 0, sizeof(*pdata));

	dev->irq = platform_get_irq(pdev, 0);
	irq_flags = irq_res->flags & IRQF_TRIGGER_MASK;
	pdata->ioaddr = ioremap_nocache(res->start, res_size);

	/* copy config parameters across to pdata */
	memcpy(&pdata->config, config, sizeof(pdata->config));

	pdata->ndev = dev;
	pdata->msg_enable = ((1 << debug) - 1);

	if (pdata->ioaddr == NULL) {
		SMSC_WARNING(PROBE,
			"Error smsc911x base address invalid");
		retval = -ENOMEM;
		goto out_free_netdev_2;
	}

	retval = smsc911x_init(dev);
	if (retval < 0)
		goto out_unmap_io_3;

	/* configure irq polarity and type before connecting isr */
	if (pdata->config.irq_polarity == SMSC911X_IRQ_POLARITY_ACTIVE_HIGH)
		intcfg |= INT_CFG_IRQ_POL_;

	if (pdata->config.irq_type == SMSC911X_IRQ_TYPE_PUSH_PULL)
		intcfg |= INT_CFG_IRQ_TYPE_;

	smsc911x_reg_write(pdata, INT_CFG, intcfg);

	/* Ensure interrupts are globally disabled before connecting ISR */
	smsc911x_reg_write(pdata, INT_EN, 0);
	smsc911x_reg_write(pdata, INT_STS, 0xFFFFFFFF);

	retval = rtdm_irq_request(&pdata->irq_handle, dev->irq,  
smsc911x_irqhandler, \
				irq_flags | RTDM_IRQTYPE_SHARED, dev->name, dev);
	if (retval) {
		SMSC_WARNING(PROBE,
			"Unable to claim requested irq: %d", dev->irq);
		goto out_unmap_io_3;
	}

	platform_set_drvdata(pdev, dev);

	retval = rt_register_rtnetdev(dev);
	if (retval) {
		SMSC_WARNING(PROBE, \
			"Error %i registering device", retval);
		goto out_unset_drvdata_4;
	} else {
		SMSC_TRACE(PROBE, "Network interface: \"%s\"", dev->name);
	}

	rtdm_lock_init(&pdata->mac_lock);

	retval = smsc911x_mii_init(pdev, dev);
	if (retval) {
		SMSC_WARNING(PROBE,
			"Error %i initialising mii", retval);
		goto out_unregister_netdev_5;
	}

	if (rtskb_pool_init(&pdata->skb_pool, RX_RING_SIZE*2) < RX_RING_SIZE*2)
	{
		rtskb_pool_release(&pdata->skb_pool);
		rtdev_free(dev->priv);
		dev->priv = NULL;
		return -ENOMEM;
	}

	rtdm_lock_get(&pdata->mac_lock);

	/* Check if mac address has been specified when bringing interface up */
	if (is_valid_ether_addr(dev->dev_addr)) {
		smsc911x_set_hw_mac_address(pdata, dev->dev_addr);
		SMSC_TRACE(PROBE, "MAC Address is specified by configuration");
	} else if (is_valid_ether_addr(pdata->config.mac)) {
		memcpy(dev->dev_addr, pdata->config.mac, 6);
		SMSC_TRACE(PROBE, "MAC Address specified by platform data");
	} else {
		/* Try reading mac address from device. if EEPROM is present
		 * it will already have been set */
		smsc911x_read_mac_address(dev);

		if (is_valid_ether_addr(dev->dev_addr)) {
			/* eeprom values are valid  so use them */
			SMSC_TRACE(PROBE,
				"Mac Address is read from LAN911x EEPROM");
		} else {
			/* eeprom values are invalid, generate random MAC */
			random_ether_addr(dev->dev_addr);
			smsc911x_set_hw_mac_address(pdata, dev->dev_addr);
			SMSC_TRACE(PROBE,
				"MAC Address is set to random_ether_addr");
		}
	}

	rtdm_lock_put(&pdata->mac_lock);

	rtdm_printk(KERN_INFO  "MAC Address: %pM\n", dev->dev_addr);

	return 0;

out_unregister_netdev_5:
	rt_unregister_rtnetdev(dev);
     rt_rtdev_disconnect(dev);
out_unset_drvdata_4:
	platform_set_drvdata(pdev, NULL);
	free_irq(dev->irq, dev);
out_unmap_io_3:
	iounmap(pdata->ioaddr);
out_free_netdev_2:
	rtdev_free(dev);
out_release_io_1:
	release_mem_region(res->start, resource_size(res));
out_0:
	return retval;
}





static int smsc911x_open(struct rtnet_device *dev)
{
	struct smsc911x_data *pdata = dev->priv;
	unsigned int timeout;
	unsigned int temp;
	unsigned int intcfg;

	/* if the phy is not yet registered, retry later*/
	if (!pdata->phy_dev) {
		SMSC_WARNING(HW, "phy_dev is NULL");
		return -EAGAIN;
	}

	if (!is_valid_ether_addr(dev->dev_addr)) {
		SMSC_WARNING(HW, "dev_addr is not a valid MAC address");
		return -EADDRNOTAVAIL;
	}

	/* Reset the LAN911x */
	if (smsc911x_soft_reset(pdata)) {
		SMSC_WARNING(HW, "soft reset failed");
		return -EIO;
	}

	smsc911x_reg_write(pdata, HW_CFG, 0x00050000);
	smsc911x_reg_write(pdata, AFC_CFG, 0x006E3740);

	/* Make sure EEPROM has finished loading before setting GPIO_CFG */
	timeout = 50;
	while ((smsc911x_reg_read(pdata, E2P_CMD) & E2P_CMD_EPC_BUSY_) &&
	       --timeout) {
		udelay(10);
	}

	if (unlikely(timeout == 0))
		SMSC_WARNING(IFUP,
			"Timed out waiting for EEPROM busy bit to clear");

	smsc911x_reg_write(pdata, GPIO_CFG, 0x70070000);

	/* The soft reset above cleared the device's MAC address,
	 * restore it from local copy (set in probe) */
	rtdm_lock_get(&pdata->mac_lock);
	smsc911x_set_hw_mac_address(pdata, dev->dev_addr);
	rtdm_lock_put(&pdata->mac_lock);

	/* Initialise irqs, but leave all sources disabled */
	smsc911x_reg_write(pdata, INT_EN, 0);
	smsc911x_reg_write(pdata, INT_STS, 0xFFFFFFFF);

	/* Set interrupt deassertion to 100uS */
	intcfg = ((10 << 24) | INT_CFG_IRQ_EN_);

	if (pdata->config.irq_polarity) {
		SMSC_TRACE(IFUP, "irq polarity: active high");
		intcfg |= INT_CFG_IRQ_POL_;
	} else {
		SMSC_TRACE(IFUP, "irq polarity: active low");
	}

	if (pdata->config.irq_type) {
		SMSC_TRACE(IFUP, "irq type: push-pull");
		intcfg |= INT_CFG_IRQ_TYPE_;
	} else {
		SMSC_TRACE(IFUP, "irq type: open drain");
	}

	smsc911x_reg_write(pdata, INT_CFG, intcfg);

	SMSC_TRACE(IFUP, "Testing irq handler using IRQ %d", dev->irq);
	pdata->software_irq_signal = 0;
	smp_wmb();

	temp = smsc911x_reg_read(pdata, INT_EN);
	temp |= INT_EN_SW_INT_EN_;
	smsc911x_reg_write(pdata, INT_EN, temp);

	timeout = 50;
	while (timeout--) {
		if (pdata->software_irq_signal)
			break;
		msleep(1);
	}

	if (!pdata->software_irq_signal) {
		rtdm_printk(KERN_NOTICE  "ISR failed signaling test (IRQ %d)\n",
			 dev->irq);
		//return -ENODEV;
	}
	else SMSC_TRACE(IFUP, "IRQ handler passed test using IRQ %d", dev->irq);

	rtdm_printk(KERN_INFO  "SMSC911x/921x identified at %#08lx, IRQ: %d\n",
		 (unsigned long)pdata->ioaddr, dev->irq);

	/* Reset the last known duplex and carrier */
	pdata->last_duplex = -1;
	pdata->last_carrier = -1;

	/* Bring the PHY up */
	phy_start(pdata->phy_dev);

	temp = smsc911x_reg_read(pdata, HW_CFG);
	/* Preserve TX FIFO size and external PHY configuration */
	temp &= (HW_CFG_TX_FIF_SZ_|0x00000FFF);
	temp |= HW_CFG_SF_;
	smsc911x_reg_write(pdata, HW_CFG, temp);

	temp = smsc911x_reg_read(pdata, FIFO_INT);
	temp |= FIFO_INT_TX_AVAIL_LEVEL_;
	temp &= ~(FIFO_INT_RX_STS_LEVEL_);
	smsc911x_reg_write(pdata, FIFO_INT, temp);

	/* set RX Data offset to 2 bytes for alignment */
	smsc911x_reg_write(pdata, RX_CFG, (2 << 8));

	temp = smsc911x_reg_read(pdata, INT_EN);
	temp |= (INT_EN_TDFA_EN_ | INT_EN_RSFL_EN_ | INT_EN_RXSTOP_INT_EN_);
	smsc911x_reg_write(pdata, INT_EN, temp);

	rtdm_lock_get(&pdata->mac_lock);
	temp = smsc911x_mac_read(pdata, MAC_CR);
	temp |= (MAC_CR_TXEN_ | MAC_CR_RXEN_ | MAC_CR_HBDIS_);
	smsc911x_mac_write(pdata, MAC_CR, temp);
	rtdm_lock_put(&pdata->mac_lock);

	smsc911x_reg_write(pdata, TX_CFG, TX_CFG_TX_ON_);
	rt_stack_connect(dev, &STACK_manager);
	rtnetif_start_queue(dev);

	RTNET_MOD_INC_USE_COUNT;

	return 0;
}


I hope you could give me some indications.


Thank you for all


