References: <tencent_701E00C233E82F4D5C850B25@qq.com>
From: Wolfgang Grandegger <wg@grandegger.com>
Message-ID: <4881f7df-7eb5-30ec-035c-3314b79642ab@grandegger.com>
Date: Sat, 3 Sep 2016 11:46:44 +0200
MIME-Version: 1.0
In-Reply-To: <tencent_701E00C233E82F4D5C850B25@qq.com>
Content-Type: text/plain; charset=gb18030
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt-socket-can "no device" problem with advantech
 PCM-26D2CA CAN board
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jack Lee <jacklee11@foxmail.com>, xenomai <xenomai@xenomai.org>

Hello,

Am 03.09.2016 um 02:54 schrieb Jack Lee:
...snip...

> ------------I am back.--------------
> I modified the source code and compiled the xeno_can_adv_pci.ko with
> "make CONFIG_XENO_...=m -C $(krnsrc)
> M=$(krnsrc)/drivers/xenomai/can/sja1000 modules".
> After copied the module to the /lib/... directory and "modprobe
> xeno_can_adv_pci", /proc/rtcan/devices remain the same. But "dmesg |
> grep -i can" outputs these:
> ...
> [  239.374873] RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development
> Team
> [  239.396977] RTCAN SJA1000 driver initialized
> [  239.405819] xeno_can_adv_pci: module verification failed: signature
> and/or required key missing - tainting kernel
> [  239.408014] ADV-PCI-CAN 0000:03:00.0: RTCAN Registering card
> [  239.408121] ADV-PCI-CAN 0000:03:00.0: PCI->APIC IRQ transform: INT A
> -> IRQ 18
> [  239.408189] ADV-PCI-CAN 0000:03:00.0: RTCAN detected Advantech PCI
> card at slot #0
> [  239.408254] ADV-PCI-CAN: Initializing device 13fe:c302:c302
> [  239.408386] ADV-PCI-CAN: base_addr=ffffc900008fe400
> conf_addr=          (null) irq=18 ocr=0xfa cdr=0xc0
> [  239.408575] rtcan: registered rtcan0
> [  239.408631] Unregistering SJA1000 device rtcan0
> [  239.408736] RTCAN: unregistered rtcan0
> [  239.408890] ADV-PCI-CAN: probe of 0000:03:00.0 failed with error -5

Oops, I forgot to adjust the mapped PCI space. In "pci_map()" "ADV_PCI_BASE_SIZE << shift"
should be used. Below is v2 of the patch. Hope it works now.

Wolfgang.


>From f346a0e7b08a02cc4ef3b06eef88992a6140b957 Mon Sep 17 00:00:00 2001
From: Wolfgang Grandegger <Wolfgang Grandegger>
Date: Fri, 2 Sep 2016 10:46:26 +0200
Subject: [PATCH v2] rtcan: add support for new Advantec CAN PCI devices

---
 ksrc/drivers/can/sja1000/rtcan_adv_pci.c | 52 ++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/ksrc/drivers/can/sja1000/rtcan_adv_pci.c b/ksrc/drivers/can/sja1000/rtcan_adv_pci.c
index 1d36e7b..9d2ea7b 100644
--- a/ksrc/drivers/can/sja1000/rtcan_adv_pci.c
+++ b/ksrc/drivers/can/sja1000/rtcan_adv_pci.c
@@ -95,6 +95,12 @@ static DEFINE_PCI_DEVICE_TABLE(adv_pci_tbl) = {
 	ADV_PCI_DEVICE(0xc101),
 	ADV_PCI_DEVICE(0xc102),
 	ADV_PCI_DEVICE(0xc104),
+	ADV_PCI_DEVICE(0xc201),
+	ADV_PCI_DEVICE(0xc202),
+	ADV_PCI_DEVICE(0xc204),
+	ADV_PCI_DEVICE(0xc301),
+	ADV_PCI_DEVICE(0xc302),
+	ADV_PCI_DEVICE(0xc304),
 	/* required last entry */
 	{ }
 };
@@ -115,6 +121,21 @@ static void rtcan_adv_pci_write_reg(struct rtcan_device *dev, int port, u8 data)
 	iowrite8(data, board->base_addr + port);
 }
 
+static u8 rtcan_adv_pci_read_reg_shift2(struct rtcan_device *dev, int port)
+{
+	struct rtcan_adv_pci *board = (struct rtcan_adv_pci *)dev->board_priv;
+
+	return ioread8(board->base_addr + (port << 2));
+}
+
+static void rtcan_adv_pci_write_reg_shift2(struct rtcan_device *dev, int port,
+					   u8 data)
+{
+	struct rtcan_adv_pci *board = (struct rtcan_adv_pci *)dev->board_priv;
+
+	iowrite8(data, board->base_addr + (port << 2));
+}
+
 static void rtcan_adv_pci_del_chan(struct pci_dev *pdev,
 				   struct rtcan_device *dev)
 {
@@ -137,6 +158,7 @@ static int rtcan_adv_pci_add_chan(struct pci_dev *pdev,
 				  int channel,
 				  unsigned int bar,
 				  unsigned int offset,
+				  unsigned int shift,
 				  struct rtcan_device **master_dev)
 {
 	struct rtcan_device *dev;
@@ -161,13 +183,15 @@ static int rtcan_adv_pci_add_chan(struct pci_dev *pdev,
 		if (offset)
 			base_addr = master_board->base_addr+offset;
 		else
-			base_addr = pci_iomap(pdev, bar, ADV_PCI_BASE_SIZE);
+			base_addr = pci_iomap(pdev, bar,
+					      ADV_PCI_BASE_SIZE << shift);
 			if (!base_addr) {
 				ret = -EIO;
 				goto failure;
 			}
 	} else {
-		base_addr = pci_iomap(pdev, bar, ADV_PCI_BASE_SIZE) + offset;
+		base_addr = pci_iomap(pdev, bar,
+				      ADV_PCI_BASE_SIZE << shift) + offset;
 		if (!base_addr) {
 			ret = -EIO;
 			goto failure;
@@ -180,8 +204,13 @@ static int rtcan_adv_pci_add_chan(struct pci_dev *pdev,
 
 	dev->board_name = adv_pci_board_name;
 
-	chip->read_reg = rtcan_adv_pci_read_reg;
-	chip->write_reg = rtcan_adv_pci_write_reg;
+	if (shift == 2) {
+		chip->read_reg = rtcan_adv_pci_read_reg_shift2;
+		chip->write_reg = rtcan_adv_pci_write_reg_shift2;
+	} else {
+		chip->read_reg = rtcan_adv_pci_read_reg;
+		chip->write_reg = rtcan_adv_pci_write_reg;
+	}
 
 	/* Clock frequency in Hz */
 	dev->can_sys_clock = ADV_PCI_CAN_CLOCK;
@@ -244,6 +273,7 @@ static int adv_pci_init_one(struct pci_dev *pdev,
 	unsigned int bar = 0;
 	unsigned int bar_flag = 0;
 	unsigned int offset = 0;
+	unsigned int shift = 0;
 	unsigned int ix;
 
 	struct rtcan_device *master_dev = NULL;
@@ -270,7 +300,16 @@ static int adv_pci_init_one(struct pci_dev *pdev,
 	case 0xc104:
 		nb_ports = pdev->device & 0x7;
 		offset = 0x100;
-		bar = 0;
+		break;
+	case 0xc201:
+	case 0xc202:
+	case 0xc204:
+	case 0xc301:
+	case 0xc302:
+	case 0xc304:
+		nb_ports = pdev->device & 0x7;
+		offset = 0x400;
+		shift = 2;
 		break;
 	case 0x1680:
 	case 0x2052:
@@ -298,7 +337,8 @@ static int adv_pci_init_one(struct pci_dev *pdev,
 		   pdev->device,
 		   pdev->subsystem_device);
 
-	ret = rtcan_adv_pci_add_chan(pdev, channel, bar, offset, &master_dev);
+	ret = rtcan_adv_pci_add_chan(pdev, channel, bar, offset, shift,
+				     &master_dev);
 	if (ret)
 		goto failure_iounmap;
 
-- 
1.9.1


