From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 7/9] drivers/can: Drop MODULE_SUPPORTED_DEVICE
Date: Wed, 13 Oct 2021 13:55:51 +0200
Message-Id: <ace781fd582ed21d18087bec953c0ec1dfa923e3.1634126152.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1634126152.git.jan.kiszka@siemens.com>
References: <cover.1634126152.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Was a nop and got removed in kernel 5.12.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/can/peak_canfd/rtcan_peak_pciefd.c | 1 -
 kernel/drivers/can/sja1000/rtcan_adv_pci.c        | 1 -
 kernel/drivers/can/sja1000/rtcan_ems_pci.c        | 1 -
 kernel/drivers/can/sja1000/rtcan_esd_pci.c        | 2 --
 kernel/drivers/can/sja1000/rtcan_isa.c            | 1 -
 kernel/drivers/can/sja1000/rtcan_ixxat_pci.c      | 1 -
 kernel/drivers/can/sja1000/rtcan_mem.c            | 1 -
 kernel/drivers/can/sja1000/rtcan_peak_dng.c       | 1 -
 kernel/drivers/can/sja1000/rtcan_peak_pci.c       | 1 -
 kernel/drivers/can/sja1000/rtcan_plx_pci.c        | 7 -------
 kernel/drivers/can/sja1000/rtcan_sja1000.c        | 1 -
 11 files changed, 18 deletions(-)

diff --git a/kernel/drivers/can/peak_canfd/rtcan_peak_pciefd.c b/kernel/drivers/can/peak_canfd/rtcan_peak_pciefd.c
index 445c46e1c7..921182fab1 100644
--- a/kernel/drivers/can/peak_canfd/rtcan_peak_pciefd.c
+++ b/kernel/drivers/can/peak_canfd/rtcan_peak_pciefd.c
@@ -35,7 +35,6 @@ static char *pciefd_board_name = "PEAK-PCIe FD";
 
 MODULE_AUTHOR("Stephane Grosjean <s.grosjean@peak-system.com>");
 MODULE_DESCRIPTION("RTCAN driver for PEAK PCAN PCIe/M.2 FD family cards");
-MODULE_SUPPORTED_DEVICE("PEAK PCAN PCIe/M.2 FD CAN controllers");
 MODULE_LICENSE("GPL v2");
 
 #define PEAK_PCI_VENDOR_ID	0x001c	/* The PCI device and vendor IDs */
diff --git a/kernel/drivers/can/sja1000/rtcan_adv_pci.c b/kernel/drivers/can/sja1000/rtcan_adv_pci.c
index 4637ff742a..f09be056ba 100644
--- a/kernel/drivers/can/sja1000/rtcan_adv_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_adv_pci.c
@@ -43,7 +43,6 @@ static char *adv_pci_board_name = "ADV-PCI";
 
 MODULE_AUTHOR("Thierry Bultel <thierry.bultel@basystemes.fr>");
 MODULE_DESCRIPTION("RTCAN board driver for Advantech PCI cards");
-MODULE_SUPPORTED_DEVICE("ADV-PCI card CAN controller");
 MODULE_LICENSE("GPL");
 
 struct rtcan_adv_pci {
diff --git a/kernel/drivers/can/sja1000/rtcan_ems_pci.c b/kernel/drivers/can/sja1000/rtcan_ems_pci.c
index ffd91235a2..2e3001b05c 100644
--- a/kernel/drivers/can/sja1000/rtcan_ems_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_ems_pci.c
@@ -41,7 +41,6 @@ static char *ems_pci_board_name = "EMS-CPC-PCI";
 
 MODULE_AUTHOR("Wolfgang Grandegger <wg@grandegger.com>");
 MODULE_DESCRIPTION("RTCAN board driver for EMS CPC-PCI/PCIe/104P CAN cards");
-MODULE_SUPPORTED_DEVICE("EMS CPC-PCI/PCIe/104P CAN card");
 MODULE_LICENSE("GPL v2");
 
 #define EMS_PCI_V1_MAX_CHAN 2
diff --git a/kernel/drivers/can/sja1000/rtcan_esd_pci.c b/kernel/drivers/can/sja1000/rtcan_esd_pci.c
index 538c0c8ac3..2b5a19caf5 100644
--- a/kernel/drivers/can/sja1000/rtcan_esd_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_esd_pci.c
@@ -44,8 +44,6 @@ static char *esd_pci_board_name = "ESD-PCI";
 MODULE_AUTHOR("Sebastian Smolorz <sesmo@gmx.net");
 MODULE_DESCRIPTION("RTCAN board driver for esd PCI/PMC/CPCI/PCIe/PCI104 " \
 		   "CAN cards");
-MODULE_SUPPORTED_DEVICE("esd CAN-PCI/200, CAN-PCI/266, CAN-PMC266, " \
-			"CAN-PCIe/2000, CAN-CPCI/200, CAN-PCI104");
 MODULE_LICENSE("GPL v2");
 
 struct rtcan_esd_pci {
diff --git a/kernel/drivers/can/sja1000/rtcan_isa.c b/kernel/drivers/can/sja1000/rtcan_isa.c
index f4c59cd86b..a0e49fea30 100644
--- a/kernel/drivers/can/sja1000/rtcan_isa.c
+++ b/kernel/drivers/can/sja1000/rtcan_isa.c
@@ -42,7 +42,6 @@ static char *isa_board_name = "ISA-Board";
 
 MODULE_AUTHOR("Wolfgang Grandegger <wg@grandegger.com>");
 MODULE_DESCRIPTION("RTCAN board driver for standard ISA boards");
-MODULE_SUPPORTED_DEVICE("ISA board");
 MODULE_LICENSE("GPL");
 
 static u16 io[RTCAN_ISA_MAX_DEV];
diff --git a/kernel/drivers/can/sja1000/rtcan_ixxat_pci.c b/kernel/drivers/can/sja1000/rtcan_ixxat_pci.c
index ca3556adc2..9c5197f833 100644
--- a/kernel/drivers/can/sja1000/rtcan_ixxat_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_ixxat_pci.c
@@ -39,7 +39,6 @@ static char *ixxat_pci_board_name = "IXXAT-PCI";
 
 MODULE_AUTHOR("Wolfgang Grandegger <wg@grandegger.com>");
 MODULE_DESCRIPTION("RTCAN board driver for IXXAT-PCI cards");
-MODULE_SUPPORTED_DEVICE("IXXAT-PCI card CAN controller");
 MODULE_LICENSE("GPL");
 
 struct rtcan_ixxat_pci
diff --git a/kernel/drivers/can/sja1000/rtcan_mem.c b/kernel/drivers/can/sja1000/rtcan_mem.c
index 178b321d92..965735eb35 100644
--- a/kernel/drivers/can/sja1000/rtcan_mem.c
+++ b/kernel/drivers/can/sja1000/rtcan_mem.c
@@ -50,7 +50,6 @@ static char *mem_board_name = "mem mapped";
 
 MODULE_AUTHOR("Matthias Fuchs <matthias.fuchs@esd-electronics.com>");
 MODULE_DESCRIPTION("RTCAN driver for memory mapped SJA1000 controller");
-MODULE_SUPPORTED_DEVICE("mem mapped");
 MODULE_LICENSE("GPL");
 
 static u32 mem[RTCAN_MEM_MAX_DEV];
diff --git a/kernel/drivers/can/sja1000/rtcan_peak_dng.c b/kernel/drivers/can/sja1000/rtcan_peak_dng.c
index 9207be55e8..d1e3f44648 100644
--- a/kernel/drivers/can/sja1000/rtcan_peak_dng.c
+++ b/kernel/drivers/can/sja1000/rtcan_peak_dng.c
@@ -45,7 +45,6 @@ static char *dongle_board_name = "PEAK-Dongle";
 
 MODULE_AUTHOR("Wolfgang Grandegger <wg@grandegger.com>");
 MODULE_DESCRIPTION("RTCAN board driver for PEAK-Dongle");
-MODULE_SUPPORTED_DEVICE("PEAK-Dongle CAN controller");
 MODULE_LICENSE("GPL");
 
 static char   *type[RTCAN_PEAK_DNG_MAX_DEV];
diff --git a/kernel/drivers/can/sja1000/rtcan_peak_pci.c b/kernel/drivers/can/sja1000/rtcan_peak_pci.c
index 42df49acdc..19f728b41b 100644
--- a/kernel/drivers/can/sja1000/rtcan_peak_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_peak_pci.c
@@ -43,7 +43,6 @@ static char *peak_pci_board_name = "PEAK-PCI";
 
 MODULE_AUTHOR("Wolfgang Grandegger <wg@grandegger.com>");
 MODULE_DESCRIPTION("RTCAN board driver for PEAK-PCI cards");
-MODULE_SUPPORTED_DEVICE("PEAK-PCI card CAN controller");
 MODULE_LICENSE("GPL");
 
 struct rtcan_peak_pci
diff --git a/kernel/drivers/can/sja1000/rtcan_plx_pci.c b/kernel/drivers/can/sja1000/rtcan_plx_pci.c
index 30255626ec..4da14f2cc5 100644
--- a/kernel/drivers/can/sja1000/rtcan_plx_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_plx_pci.c
@@ -41,13 +41,6 @@
 MODULE_AUTHOR("Pavel Cheblakov <P.B.Cheblakov@inp.nsk.su>");
 MODULE_DESCRIPTION("RTCAN driver for PLX90xx PCI-bridge cards with "
 		   "the SJA1000 chips");
-MODULE_SUPPORTED_DEVICE("Adlink PCI-7841/cPCI-7841, "
-			"Adlink PCI-7841/cPCI-7841 SE, "
-			"Marathon CAN-bus-PCI, "
-			"TEWS TECHNOLOGIES TPMC810, "
-			"esd CAN-PCI/CPCI/PCI104/200, "
-			"esd CAN-PCI/PMC/266, "
-			"esd CAN-PCIe/2000")
 MODULE_LICENSE("GPL v2");
 
 #define PLX_PCI_MAX_CHAN 2
diff --git a/kernel/drivers/can/sja1000/rtcan_sja1000.c b/kernel/drivers/can/sja1000/rtcan_sja1000.c
index 842456dfdb..bd6c0ba5c8 100644
--- a/kernel/drivers/can/sja1000/rtcan_sja1000.c
+++ b/kernel/drivers/can/sja1000/rtcan_sja1000.c
@@ -81,7 +81,6 @@ static char *sja_ctrl_name = "SJA1000";
 MODULE_AUTHOR("Sebastian.Smolorz@stud.uni-hannover.de");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("RT-Socket-CAN driver for SJA1000");
-MODULE_SUPPORTED_DEVICE("SJA1000 CAN controller");
 
 #ifndef CONFIG_XENO_DRIVERS_CAN_CALC_BITTIME_OLD
 static struct can_bittiming_const sja1000_bittiming_const = {
-- 
2.31.1


