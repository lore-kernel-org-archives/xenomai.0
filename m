From: roman.stratiienko@globallogic.com
Subject: [PATCH] travis: add more build options
Date: Tue,  2 Apr 2019 12:30:26 +0300
Message-Id: <20190402093026.15074-1-roman.stratiienko@globallogic.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Roman Stratiienko <roman.stratiienko@globallogic.com>

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

Changes are made by enabling all xenomai-related configs using
menuconfig for arm kernel, then exported with savedefconfig command.

Other missing and removed options are turned on implicitly.

Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---
After this commit 3/4 tasks fails.

 .travis.yml | 92 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 71 insertions(+), 21 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 889721763..bddf2ace1 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -51,36 +51,86 @@ before_script:
   - make -j $(nproc) ${KERNEL_DEFCONFIG}
   - ./scripts/config -e IPIPE
   - ./scripts/config -e XENOMAI
+  - ./scripts/config -e XENO_OPT_SCHED_CLASSES
+  - ./scripts/config -e XENO_OPT_SCHED_WEAK
+  - ./scripts/config -e XENO_OPT_SCHED_TP
+  - ./scripts/config -e XENO_OPT_SCHED_SPORADIC
+  - ./scripts/config -e XENO_OPT_SCHED_QUOTA
+  - ./scripts/config -e XENO_OPT_SHIRQ
+  - ./scripts/config -e XENO_OPT_SCALABLE_SCHED
+  - ./scripts/config -e XENO_OPT_DEBUG
+  - ./scripts/config -e XENO_OPT_DEBUG_COBALT
+  - ./scripts/config -e XENO_OPT_DEBUG_MEMORY
+  - ./scripts/config -e XENO_OPT_DEBUG_CONTEXT
+  - ./scripts/config -e XENO_OPT_DEBUG_USER
+  - ./scripts/config -e XENO_OPT_DEBUG_POSIX_SYNCHRO
+  - ./scripts/config -e XENO_OPT_DEBUG_LEGACY
+  - ./scripts/config -e XENO_OPT_DEBUG_TRACE_RELAX
+  - ./scripts/config -e XENO_DRIVERS_16550A
+  - ./scripts/config -e XENO_DRIVERS_16550A_ANY
+  - ./scripts/config -e XENO_DRIVERS_16550A_PCI
+  - ./scripts/config -e XENO_DRIVERS_16550A_PCI_MOXA
+  - ./scripts/config -e XENO_DRIVERS_IMX_UART
+  - ./scripts/config -e XENO_DRIVERS_RTDMTEST
+  - ./scripts/config -e XENO_DRIVERS_CAN
+  - ./scripts/config -e XENO_DRIVERS_CAN_LOOPBACK
+  - ./scripts/config -e XENO_DRIVERS_CAN_VIRT
+  - ./scripts/config -e XENO_DRIVERS_CAN_FLEXCAN
+  - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000
+  - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000_ISA
+  - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000_MEM
+  - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000_PEAK_PCI
+  - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000_IXXAT_PCI
+  - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000_ADV_PCI
+  - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000_PLX_PCI
+  - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000_EMS_PCI
+  - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000_ESD_PCI
+  - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000_PEAK_DNG
+  - ./scripts/config -m XENO_DRIVERS_NET
+  - ./scripts/config -e XENO_DRIVERS_RTNET_CHECKED
+  - ./scripts/config -e XENO_DRIVERS_NET_ETH_P_ALL
+  - ./scripts/config -e XENO_DRIVERS_NET_RTIPV4_NETROUTING
+  - ./scripts/config -e XENO_DRIVERS_NET_RTIPV4_ROUTER
+  - ./scripts/config -e XENO_DRIVERS_NET_RTIPV4_DEBUG
+  - ./scripts/config -m XENO_DRIVERS_NET_RTIPV4_TCP
+  - ./scripts/config -e XENO_DRIVERS_NET_RTIPV4_TCP_ERROR_INJECTION
+  - ./scripts/config -m XENO_DRIVERS_NET_NOMAC
+  - ./scripts/config -e XENO_DRIVERS_NET_RTCFG_DEBUG
+  - ./scripts/config -m XENO_DRIVERS_NET_DRV_PCNET32
+  - ./scripts/config -m XENO_DRIVERS_NET_DRV_TULIP
+  - ./scripts/config -e XENO_DRIVERS_NET_DRV_EEPRO100_DBG
+  - ./scripts/config -m XENO_DRIVERS_NET_DRV_E1000E
+  - ./scripts/config -m XENO_DRIVERS_NET_DRV_NATSEMI
+  - ./scripts/config -m XENO_DRIVERS_NET_DRV_VIA_RHINE
+  - ./scripts/config -m XENO_DRIVERS_NET_DRV_IGB
+  - ./scripts/config -m XENO_DRIVERS_NET_DRV_R8169
+  - ./scripts/config -m XENO_DRIVERS_NET_DRV_SMC91111
+  - ./scripts/config -e XENO_DRIVERS_NET_EXP_DRIVERS
+  - ./scripts/config -m XENO_DRIVERS_NET_DRV_3C59X
+  - ./scripts/config -m XENO_DRIVERS_NET_DRV_E1000_NEW
+  - ./scripts/config -m XENO_DRIVERS_NET_DRV_RT2500
+  - ./scripts/config -m XENO_DRIVERS_NET_ADDON_RTCAP
+  - ./scripts/config -m XENO_DRIVERS_NET_ADDON_PROXY
+  - ./scripts/config -e XENO_DRIVERS_NET_ADDON_PROXY_ARP
   - ./scripts/config -e XENO_DRIVERS_ANALOGY
   - ./scripts/config -e XENO_DRIVERS_ANALOGY_DEBUG
   - ./scripts/config -e XENO_DRIVERS_ANALOGY_DEBUG_FTRACE
-  - ./scripts/config -e XENO_DRIVERS_ANALOGY_8255
-  - ./scripts/config -e XENO_DRIVERS_ANALOGY_PARPORT
-  - ./scripts/config -e XENO_DRIVERS_ANALOGY_NI_MITE
-  - ./scripts/config -e XENO_DRIVERS_ANALOGY_NI_TIO
-  - ./scripts/config -e XENO_DRIVERS_ANALOGY_NI_MIO
+  - ./scripts/config -e XENO_DRIVERS_ANALOGY_FAKE
   - ./scripts/config -e XENO_DRIVERS_ANALOGY_NI_PCIMIO
-  - ./scripts/config -e XENO_DRIVERS_ANALOGY_NI_670x
-  - ./scripts/config -e XENO_DRIVERS_ANALOGY_NI_660x
   - ./scripts/config -e XENO_DRIVERS_ANALOGY_S526
-  - ./scripts/config -e XENO_DRIVERS_ANALOGY_FAKE
-  - ./scripts/config -e XENO_DRIVERS_AUTOTUNE
-  - ./scripts/config -e XENO_DRIVERS_CAN
-  - ./scripts/config -e XENO_DRIVERS_CAN_DEBUG
-  - ./scripts/config -e XENO_DRIVERS_CAN_LOOPBACK
-  - ./scripts/config -e XENO_DRIVERS_CAN_BUS_ERR
-  - ./scripts/config -e XENO_DRIVERS_CAN_VIRT
-  - ./scripts/config -e XENO_DRIVERS_CAN_FLEXCAN
+  - ./scripts/config -e XENO_DRIVERS_RTIPC
+  - ./scripts/config -e XENO_DRIVERS_UDD
   - ./scripts/config -e XENO_DRIVERS_GPIO
+  - ./scripts/config -e XENO_DRIVERS_GPIO_BCM2835
+  - ./scripts/config -e XENO_DRIVERS_GPIO_MXC
   - ./scripts/config -e XENO_DRIVERS_GPIO_SUN8I_H3
+  - ./scripts/config -e XENO_DRIVERS_GPIO_ZYNQ7000
+  - ./scripts/config -e XENO_DRIVERS_GPIO_XILINX
   - ./scripts/config -e XENO_DRIVERS_GPIO_DEBUG
   - ./scripts/config -e XENO_DRIVERS_GPIOPWM
-  - ./scripts/config -e XENO_DRIVERS_RTIPC
-  - ./scripts/config -e XENO_DRIVERS_NET
-  - ./scripts/config -e XENO_DRIVERS_16550A
-  - ./scripts/config -e XENO_DRIVERS_SPI
-  - ./scripts/config -e XENO_DRIVERS_TIMERBENCH
-  - ./scripts/config -e XENO_DRIVERS_UDD
+  - ./scripts/config -e XENO_DRIVERS_SPI_BCM2835
+  - ./scripts/config -e XENO_DRIVERS_SPI_SUN6I
+  - ./scripts/config -e XENO_DRIVERS_SPI_DEBUG
 
   - popd
 
-- 
2.17.1


