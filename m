Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9190515AC
	for <xenomai@lists.linux.dev>; Wed, 14 Sep 2022 01:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663118587; x=1694654587;
  h=from:to:subject:date:message-id;
  bh=1nzZS9SwzCYn0eNLqvpi2QVMAldvYzlR70LIrQbKF04=;
  b=glD0tpbXKPKaAzrtGwCMAVAyCu2LH3ZzJNkka+/tq0k3pXoxlhV22+iM
   RS0Js3e1y1k44XjAl7q4o4y+CQVCCHrKT+CIgoRqMfs/nTNHV7fhigJZa
   E24If6lLunAQwJmOPv5kWbpoYX63Qqh90UGSJSKcE7Ij63/3chMGbw9aP
   3Xf0FpAncW99QHTBm6M/q0RqXc6xcaiEakfTOHHTkmVAOJEgs7zn+oa64
   rK6SfmKy0C1ij1dc9oppwoXdlT2l1rZG5E5yiIYeW7kpu1266ruP7O8ji
   hR22bMRVr7rGmo/RRntKFZ/EYYgPoCXj5UPHg/zZsYM19AWjezed6/T/8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="278032675"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="278032675"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 18:23:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="720392761"
Received: from intel-z97x-ud5h.sh.intel.com ([10.67.103.201])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 18:23:04 -0700
From: Hongzhan Chen <hongzhan.chen@intel.com>
To: xenomai@lists.linux.dev
Subject: [PATCH v2] net/drivers: igc: introduce rt_igc driver
Date: Tue, 13 Sep 2022 21:02:18 -0400
Message-Id: <20220914010218.15149-1-hongzhan.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>

ported basic network function not including TSN feature.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>
---
 kernel/drivers/net/drivers/Kconfig           |    3 +
 kernel/drivers/net/drivers/Makefile          |    2 +
 kernel/drivers/net/drivers/igc/Makefile      |   19 +
 kernel/drivers/net/drivers/igc/igc.h         |  557 +++
 kernel/drivers/net/drivers/igc/igc_base.c    |  432 ++
 kernel/drivers/net/drivers/igc/igc_base.h    |   90 +
 kernel/drivers/net/drivers/igc/igc_defines.h |  537 +++
 kernel/drivers/net/drivers/igc/igc_dump.c    |  294 ++
 kernel/drivers/net/drivers/igc/igc_hw.h      |  299 ++
 kernel/drivers/net/drivers/igc/igc_i225.c    |  645 +++
 kernel/drivers/net/drivers/igc/igc_i225.h    |   16 +
 kernel/drivers/net/drivers/igc/igc_mac.c     |  881 ++++
 kernel/drivers/net/drivers/igc/igc_mac.h     |   39 +
 kernel/drivers/net/drivers/igc/igc_main.c    | 4271 ++++++++++++++++++
 kernel/drivers/net/drivers/igc/igc_nvm.c     |  215 +
 kernel/drivers/net/drivers/igc/igc_nvm.h     |   14 +
 kernel/drivers/net/drivers/igc/igc_phy.c     |  793 ++++
 kernel/drivers/net/drivers/igc/igc_phy.h     |   21 +
 kernel/drivers/net/drivers/igc/igc_regs.h    |  267 ++
 19 files changed, 9395 insertions(+)
 create mode 100644 kernel/drivers/net/drivers/igc/Makefile
 create mode 100644 kernel/drivers/net/drivers/igc/igc.h
 create mode 100644 kernel/drivers/net/drivers/igc/igc_base.c
 create mode 100644 kernel/drivers/net/drivers/igc/igc_base.h
 create mode 100644 kernel/drivers/net/drivers/igc/igc_defines.h
 create mode 100644 kernel/drivers/net/drivers/igc/igc_dump.c
 create mode 100644 kernel/drivers/net/drivers/igc/igc_hw.h
 create mode 100644 kernel/drivers/net/drivers/igc/igc_i225.c
 create mode 100644 kernel/drivers/net/drivers/igc/igc_i225.h
 create mode 100644 kernel/drivers/net/drivers/igc/igc_mac.c
 create mode 100644 kernel/drivers/net/drivers/igc/igc_mac.h
 create mode 100644 kernel/drivers/net/drivers/igc/igc_main.c
 create mode 100644 kernel/drivers/net/drivers/igc/igc_nvm.c
 create mode 100644 kernel/drivers/net/drivers/igc/igc_nvm.h
 create mode 100644 kernel/drivers/net/drivers/igc/igc_phy.c
 create mode 100644 kernel/drivers/net/drivers/igc/igc_phy.h
 create mode 100644 kernel/drivers/net/drivers/igc/igc_regs.h

diff --git a/kernel/drivers/net/drivers/Kconfig b/kernel/drivers/net/drivers/Kconfig
index 7a9d27e38..34dd3e5f8 100644
--- a/kernel/drivers/net/drivers/Kconfig
+++ b/kernel/drivers/net/drivers/Kconfig
@@ -71,6 +71,9 @@ config XENO_DRIVERS_NET_DRV_IGB
     depends on XENO_DRIVERS_NET && PCI
     tristate "Intel(R) 82575 (Gigabit)"
 
+config XENO_DRIVERS_NET_DRV_IGC
+    depends on XENO_DRIVERS_NET && PCI
+    tristate "Intel(R) Ethernet Controller I225-LM/I225-V support"
 
 config XENO_DRIVERS_NET_DRV_R8169
     depends on XENO_DRIVERS_NET && PCI
diff --git a/kernel/drivers/net/drivers/Makefile b/kernel/drivers/net/drivers/Makefile
index 6c715abc0..3d6c89e2b 100644
--- a/kernel/drivers/net/drivers/Makefile
+++ b/kernel/drivers/net/drivers/Makefile
@@ -10,6 +10,8 @@ obj-$(CONFIG_XENO_DRIVERS_NET_DRV_TULIP) += tulip/
 
 obj-$(CONFIG_XENO_DRIVERS_NET_DRV_IGB) += igb/
 
+obj-$(CONFIG_XENO_DRIVERS_NET_DRV_IGC) += igc/
+
 obj-$(CONFIG_XENO_DRIVERS_NET_FEC) += freescale/
 
 obj-$(CONFIG_XENO_DRIVERS_NET_DRV_8139) += rt_8139too.o
diff --git a/kernel/drivers/net/drivers/igc/Makefile b/kernel/drivers/net/drivers/igc/Makefile
new file mode 100644
index 000000000..9ea81bdfd
--- /dev/null
+++ b/kernel/drivers/net/drivers/igc/Makefile
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c)  2018 Intel Corporation
+
+#
+# Intel(R) I225-LM/I225-V 2.5G Ethernet Controller
+#
+
+ccflags-y += -I$(srctree)/drivers/xenomai/net/stack/include
+
+obj-$(CONFIG_XENO_DRIVERS_NET_DRV_IGC) += rt_igc.o
+
+rt_igc-y :=  					\
+	igc_i225.o				\
+	igc_mac.o				\
+	igc_base.o				\
+	igc_dump.o				\
+	igc_nvm.o				\
+	igc_phy.o				\
+	igc_main.o
diff --git a/kernel/drivers/net/drivers/igc/igc.h b/kernel/drivers/net/drivers/igc/igc.h
new file mode 100644
index 000000000..b5383a8fc
--- /dev/null
+++ b/kernel/drivers/net/drivers/igc/igc.h
@@ -0,0 +1,557 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c)  2018 Intel Corporation */
+
+#ifndef _IGC_H_
+#define _IGC_H_
+
+#include <linux/kobject.h>
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/vmalloc.h>
+#include <linux/ethtool.h>
+#include <linux/sctp.h>
+#include <linux/ptp_clock_kernel.h>
+#include <linux/timecounter.h>
+#include <linux/net_tstamp.h>
+
+#include "igc_hw.h"
+
+void igc_ethtool_set_ops(struct rtnet_device *);
+
+/* Transmit and receive queues */
+#define IGC_MAX_RX_QUEUES		4
+#define IGC_MAX_TX_QUEUES		4
+
+#define MAX_Q_VECTORS			8
+#define MAX_STD_JUMBO_FRAME_SIZE	9216
+
+#define MAX_ETYPE_FILTER		8
+#define IGC_RETA_SIZE			128
+
+/* TODO */
+#define MAX_MSIX_ENTRIES  10
+
+enum igc_mac_filter_type {
+	IGC_MAC_FILTER_TYPE_DST = 0,
+	IGC_MAC_FILTER_TYPE_SRC
+};
+
+struct igc_tx_queue_stats {
+	u64 packets;
+	u64 bytes;
+	u64 restart_queue;
+	u64 restart_queue2;
+};
+
+struct igc_rx_queue_stats {
+	u64 packets;
+	u64 bytes;
+	u64 drops;
+	u64 csum_err;
+	u64 alloc_failed;
+};
+
+struct igc_rx_packet_stats {
+	u64 ipv4_packets;      /* IPv4 headers processed */
+	u64 ipv4e_packets;     /* IPv4E headers with extensions processed */
+	u64 ipv6_packets;      /* IPv6 headers processed */
+	u64 ipv6e_packets;     /* IPv6E headers with extensions processed */
+	u64 tcp_packets;       /* TCP headers processed */
+	u64 udp_packets;       /* UDP headers processed */
+	u64 sctp_packets;      /* SCTP headers processed */
+	u64 nfs_packets;       /* NFS headers processe */
+	u64 other_packets;
+};
+
+struct igc_ring_container {
+	struct igc_ring *ring;          /* pointer to linked list of rings */
+	unsigned int total_bytes;       /* total bytes processed this int */
+	unsigned int total_packets;     /* total packets processed this int */
+	u16 work_limit;                 /* total work allowed per interrupt */
+	u8 count;                       /* total number of rings in vector */
+	u8 itr;                         /* current ITR setting for ring */
+};
+
+struct igc_ring {
+	struct igc_q_vector *q_vector;  /* backlink to q_vector */
+	struct rtnet_device *netdev;      /* back pointer to net_device */
+	struct device *dev;             /* device for dma mapping */
+	union {                         /* array of buffer info structs */
+		struct igc_tx_buffer *tx_buffer_info;
+		struct igc_rx_buffer *rx_buffer_info;
+	};
+	void *desc;                     /* descriptor ring memory */
+	unsigned long flags;            /* ring specific flags */
+	void __iomem *tail;             /* pointer to ring tail register */
+	dma_addr_t dma;                 /* phys address of the ring */
+	unsigned int size;              /* length of desc. ring in bytes */
+
+	u16 count;                      /* number of desc. in the ring */
+	u8 queue_index;                 /* logical index of the ring*/
+	u8 reg_idx;                     /* physical index of the ring */
+	bool launchtime_enable;         /* true if LaunchTime is enabled */
+
+	u32 start_time;
+	u32 end_time;
+
+	/* everything past this point are written often */
+	u16 next_to_clean;
+	u16 next_to_use;
+	u16 next_to_alloc;
+
+	union {
+		/* TX */
+		struct {
+			struct igc_tx_queue_stats tx_stats;
+			struct u64_stats_sync tx_syncp;
+			struct u64_stats_sync tx_syncp2;
+		};
+		/* RX */
+		struct {
+			struct igc_rx_queue_stats rx_stats;
+			struct u64_stats_sync rx_syncp;
+			struct rtskb *skb;
+			u16 rx_buffer_len;
+		};
+	};
+} ____cacheline_internodealigned_in_smp;
+
+/* Board specific private data structure */
+struct igc_adapter {
+	struct rtnet_device *netdev;
+
+	struct ethtool_eee eee;
+	u16 eee_advert;
+
+	unsigned long state;
+	unsigned int flags;
+	unsigned int num_q_vectors;
+
+	struct msix_entry *msix_entries;
+	rtdm_irq_t msix_irq_handle[MAX_MSIX_ENTRIES];
+	rtdm_irq_t irq_handle;
+	rtdm_nrtsig_t watchdog_nrtsig;
+
+	/* TX */
+	u16 tx_work_limit;
+	u32 tx_timeout_count;
+	int num_tx_queues;
+	struct igc_ring *tx_ring[IGC_MAX_TX_QUEUES];
+
+	/* RX */
+	int num_rx_queues;
+	struct igc_ring *rx_ring[IGC_MAX_RX_QUEUES];
+
+	struct timer_list watchdog_timer;
+	struct timer_list dma_err_timer;
+	struct timer_list phy_info_timer;
+
+	u32 wol;
+	u32 en_mng_pt;
+	u16 link_speed;
+	u16 link_duplex;
+
+	u8 port_num;
+
+	u8 __iomem *io_addr;
+	/* Interrupt Throttle Rate */
+	u32 rx_itr_setting;
+	u32 tx_itr_setting;
+
+	struct work_struct reset_task;
+	struct work_struct watchdog_task;
+	struct work_struct dma_err_task;
+	bool fc_autoneg;
+
+	u8 tx_timeout_factor;
+
+	int msg_enable;
+	u32 max_frame_size;
+	u32 min_frame_size;
+
+	ktime_t base_time;
+	ktime_t cycle_time;
+
+	/* OS defined structs */
+	struct pci_dev *pdev;
+
+	/* lock for statistics */
+	spinlock_t stats64_lock;
+	struct net_device_stats net_stats;
+
+	/* structs defined in igc_hw.h */
+	struct igc_hw hw;
+	struct igc_hw_stats stats;
+
+	struct igc_q_vector *q_vector[MAX_Q_VECTORS];
+	u32 eims_enable_mask;
+	u32 eims_other;
+
+	u16 tx_ring_count;
+	u16 rx_ring_count;
+
+	u32 tx_hwtstamp_timeouts;
+	u32 tx_hwtstamp_skipped;
+	u32 rx_hwtstamp_cleared;
+
+	u32 rss_queues;
+	u32 rss_indir_tbl_init;
+
+	/* Any access to elements in nfc_rule_list is protected by the
+	 * nfc_rule_lock.
+	 */
+	struct mutex nfc_rule_lock;
+	struct list_head nfc_rule_list;
+	unsigned int nfc_rule_count;
+
+	u8 rss_indir_tbl[IGC_RETA_SIZE];
+
+	unsigned long link_check_timeout;
+	struct igc_info ei;
+
+	u32 test_icr;
+
+	struct ptp_clock *ptp_clock;
+	struct ptp_clock_info ptp_caps;
+	struct work_struct ptp_tx_work;
+	struct sk_buff *ptp_tx_skb;
+	struct hwtstamp_config tstamp_config;
+	unsigned long ptp_tx_start;
+	unsigned int ptp_flags;
+	/* System time value lock */
+	spinlock_t tmreg_lock;
+	struct cyclecounter cc;
+	struct timecounter tc;
+	struct timespec64 prev_ptp_time; /* Pre-reset PTP clock */
+	ktime_t ptp_reset_start; /* Reset time in clock mono */
+};
+
+void igc_up(struct igc_adapter *adapter);
+void igc_down(struct igc_adapter *adapter);
+int igc_open(struct rtnet_device *netdev);
+int igc_close(struct rtnet_device *netdev);
+int igc_setup_tx_resources(struct igc_ring *ring);
+int igc_setup_rx_resources(struct igc_ring *ring);
+void igc_free_tx_resources(struct igc_ring *ring);
+void igc_free_rx_resources(struct igc_ring *ring);
+unsigned int igc_get_max_rss_queues(struct igc_adapter *adapter);
+void igc_set_flag_queue_pairs(struct igc_adapter *adapter,
+			      const u32 max_rss_queues);
+int igc_reinit_queues(struct igc_adapter *adapter);
+void igc_write_rss_indir_tbl(struct igc_adapter *adapter);
+bool igc_has_link(struct igc_adapter *adapter);
+void igc_reset(struct igc_adapter *adapter);
+int igc_set_spd_dplx(struct igc_adapter *adapter, u32 spd, u8 dplx);
+void igc_update_stats(struct igc_adapter *adapter);
+
+/* igc_dump declarations */
+void igc_rings_dump(struct igc_adapter *adapter);
+void igc_regs_dump(struct igc_adapter *adapter);
+
+extern char igc_driver_name[];
+
+#define IGC_REGS_LEN			740
+
+/* flags controlling PTP/1588 function */
+#define IGC_PTP_ENABLED		BIT(0)
+
+/* Flags definitions */
+#define IGC_FLAG_HAS_MSI		BIT(0)
+#define IGC_FLAG_QUEUE_PAIRS		BIT(3)
+#define IGC_FLAG_DMAC			BIT(4)
+#define IGC_FLAG_PTP			BIT(8)
+#define IGC_FLAG_WOL_SUPPORTED		BIT(8)
+#define IGC_FLAG_NEED_LINK_UPDATE	BIT(9)
+#define IGC_FLAG_MEDIA_RESET		BIT(10)
+#define IGC_FLAG_MAS_ENABLE		BIT(12)
+#define IGC_FLAG_HAS_MSIX		BIT(13)
+#define IGC_FLAG_EEE			BIT(14)
+#define IGC_FLAG_VLAN_PROMISC		BIT(15)
+#define IGC_FLAG_RX_LEGACY		BIT(16)
+#define IGC_FLAG_TSN_QBV_ENABLED	BIT(17)
+
+#define IGC_FLAG_RSS_FIELD_IPV4_UDP	BIT(6)
+#define IGC_FLAG_RSS_FIELD_IPV6_UDP	BIT(7)
+
+#define IGC_MRQC_ENABLE_RSS_MQ		0x00000002
+#define IGC_MRQC_RSS_FIELD_IPV4_UDP	0x00400000
+#define IGC_MRQC_RSS_FIELD_IPV6_UDP	0x00800000
+
+/* Interrupt defines */
+#define IGC_START_ITR			648 /* ~6000 ints/sec */
+#define IGC_4K_ITR			980
+#define IGC_20K_ITR			196
+#define IGC_70K_ITR			56
+
+#define IGC_DEFAULT_ITR		3 /* dynamic */
+#define IGC_MAX_ITR_USECS	10000
+#define IGC_MIN_ITR_USECS	10
+#define NON_Q_VECTORS		1
+#define MAX_MSIX_ENTRIES	10
+
+/* TX/RX descriptor defines */
+#define IGC_DEFAULT_TXD		256
+#define IGC_DEFAULT_TX_WORK	128
+#define IGC_MIN_TXD		80
+#define IGC_MAX_TXD		4096
+
+#define IGC_DEFAULT_RXD		256
+#define IGC_MIN_RXD		80
+#define IGC_MAX_RXD		4096
+
+/* Supported Rx Buffer Sizes */
+#define IGC_RXBUFFER_256		256
+#define IGC_RXBUFFER_2048		2048
+#define IGC_RXBUFFER_3072		3072
+
+#define AUTO_ALL_MODES		0
+#define IGC_RX_HDR_LEN			IGC_RXBUFFER_256
+#define IGC_RX_BUFSZ            IGC_RXBUFFER_2048
+
+/* Transmit and receive latency (for PTP timestamps) */
+#define IGC_I225_TX_LATENCY_10		240
+#define IGC_I225_TX_LATENCY_100		58
+#define IGC_I225_TX_LATENCY_1000	80
+#define IGC_I225_TX_LATENCY_2500	1325
+#define IGC_I225_RX_LATENCY_10		6450
+#define IGC_I225_RX_LATENCY_100		185
+#define IGC_I225_RX_LATENCY_1000	300
+#define IGC_I225_RX_LATENCY_2500	1485
+
+/* RX and TX descriptor control thresholds.
+ * PTHRESH - MAC will consider prefetch if it has fewer than this number of
+ *           descriptors available in its onboard memory.
+ *           Setting this to 0 disables RX descriptor prefetch.
+ * HTHRESH - MAC will only prefetch if there are at least this many descriptors
+ *           available in host memory.
+ *           If PTHRESH is 0, this should also be 0.
+ * WTHRESH - RX descriptor writeback threshold - MAC will delay writing back
+ *           descriptors until either it has this many to write back, or the
+ *           ITR timer expires.
+ */
+#define IGC_RX_PTHRESH			8
+#define IGC_RX_HTHRESH			8
+#define IGC_TX_PTHRESH			8
+#define IGC_TX_HTHRESH			1
+#define IGC_RX_WTHRESH			4
+#define IGC_TX_WTHRESH			16
+
+#define IGC_RX_DMA_ATTR \
+	(DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
+
+#define IGC_TS_HDR_LEN			16
+
+#define IGC_SKB_PAD			(NET_SKB_PAD + NET_IP_ALIGN)
+
+#if (PAGE_SIZE < 8192)
+#define IGC_MAX_FRAME_BUILD_SKB \
+	(SKB_WITH_OVERHEAD(IGC_RXBUFFER_2048) - IGC_SKB_PAD - IGC_TS_HDR_LEN)
+#else
+#define IGC_MAX_FRAME_BUILD_SKB (IGC_RXBUFFER_2048 - IGC_TS_HDR_LEN)
+#endif
+
+/* How many Rx Buffers do we bundle into one write to the hardware ? */
+#define IGC_RX_BUFFER_WRITE	16 /* Must be power of 2 */
+
+/* VLAN info */
+#define IGC_TX_FLAGS_VLAN_MASK	0xffff0000
+
+/* igc_test_staterr - tests bits within Rx descriptor status and error fields */
+static inline __le32 igc_test_staterr(union igc_adv_rx_desc *rx_desc,
+				      const u32 stat_err_bits)
+{
+	return rx_desc->wb.upper.status_error & cpu_to_le32(stat_err_bits);
+}
+
+enum igc_state_t {
+	__IGC_TESTING,
+	__IGC_RESETTING,
+	__IGC_DOWN,
+	__IGC_PTP_TX_IN_PROGRESS,
+};
+
+enum igc_tx_flags {
+	/* cmd_type flags */
+	IGC_TX_FLAGS_VLAN	= 0x01,
+	IGC_TX_FLAGS_TSO	= 0x02,
+	IGC_TX_FLAGS_TSTAMP	= 0x04,
+
+	/* olinfo flags */
+	IGC_TX_FLAGS_IPV4	= 0x10,
+	IGC_TX_FLAGS_CSUM	= 0x20,
+};
+
+enum igc_boards {
+	board_base,
+};
+
+/* The largest size we can write to the descriptor is 65535.  In order to
+ * maintain a power of two alignment we have to limit ourselves to 32K.
+ */
+#define IGC_MAX_TXD_PWR		15
+#define IGC_MAX_DATA_PER_TXD	BIT(IGC_MAX_TXD_PWR)
+
+/* Tx Descriptors needed, worst case */
+#define TXD_USE_COUNT(S)	DIV_ROUND_UP((S), IGC_MAX_DATA_PER_TXD)
+#define DESC_NEEDED	(MAX_SKB_FRAGS + 4)
+
+/* wrapper around a pointer to a socket buffer,
+ * so a DMA handle can be stored along with the buffer
+ */
+struct igc_tx_buffer {
+	union igc_adv_tx_desc *next_to_watch;
+	unsigned long time_stamp;
+	struct rtskb *skb;
+	unsigned int bytecount;
+	u16 gso_segs;
+	__be16 protocol;
+
+	DEFINE_DMA_UNMAP_ADDR(dma);
+	DEFINE_DMA_UNMAP_LEN(len);
+	u32 tx_flags;
+};
+
+struct igc_rx_buffer {
+	dma_addr_t dma;
+	struct rtskb *skb;
+};
+
+struct igc_q_vector {
+	struct igc_adapter *adapter;    /* backlink */
+	void __iomem *itr_register;
+	u32 eims_value;                 /* EIMS mask value */
+
+	u16 itr_val;
+	u8 set_itr;
+
+	struct igc_ring_container rx, tx;
+
+	struct napi_struct napi;
+
+	struct rcu_head rcu;    /* to avoid race with update stats on free */
+	char name[IFNAMSIZ + 9];
+	struct rtnet_device poll_dev;
+
+	/* for dynamic allocation of rings associated with this q_vector */
+	struct igc_ring ring[] ____cacheline_internodealigned_in_smp;
+};
+
+enum igc_filter_match_flags {
+	IGC_FILTER_FLAG_ETHER_TYPE =	0x1,
+	IGC_FILTER_FLAG_VLAN_TCI   =	0x2,
+	IGC_FILTER_FLAG_SRC_MAC_ADDR =	0x4,
+	IGC_FILTER_FLAG_DST_MAC_ADDR =	0x8,
+};
+
+struct igc_nfc_filter {
+	u8 match_flags;
+	u16 etype;
+	u16 vlan_tci;
+	u8 src_addr[ETH_ALEN];
+	u8 dst_addr[ETH_ALEN];
+};
+
+struct igc_nfc_rule {
+	struct list_head list;
+	struct igc_nfc_filter filter;
+	u32 location;
+	u16 action;
+};
+
+/* IGC supports a total of 32 NFC rules: 16 MAC address based,, 8 VLAN priority
+ * based, and 8 ethertype based.
+ */
+#define IGC_MAX_RXNFC_RULES		32
+
+/* igc_desc_unused - calculate if we have unused descriptors */
+static inline u16 igc_desc_unused(const struct igc_ring *ring)
+{
+	u16 ntc = ring->next_to_clean;
+	u16 ntu = ring->next_to_use;
+
+	return ((ntc > ntu) ? 0 : ring->count) + ntc - ntu - 1;
+}
+
+static inline s32 igc_get_phy_info(struct igc_hw *hw)
+{
+	if (hw->phy.ops.get_phy_info)
+		return hw->phy.ops.get_phy_info(hw);
+
+	return 0;
+}
+
+static inline s32 igc_reset_phy(struct igc_hw *hw)
+{
+	if (hw->phy.ops.reset)
+		return hw->phy.ops.reset(hw);
+
+	return 0;
+}
+
+static inline struct rtnet_device *txring_txq(const struct igc_ring *tx_ring)
+{
+	return tx_ring->netdev;
+}
+
+enum igc_ring_flags_t {
+	IGC_RING_FLAG_RX_3K_BUFFER,
+	IGC_RING_FLAG_RX_BUILD_SKB_ENABLED,
+	IGC_RING_FLAG_RX_SCTP_CSUM,
+	IGC_RING_FLAG_RX_LB_VLAN_BSWAP,
+	IGC_RING_FLAG_TX_CTX_IDX,
+	IGC_RING_FLAG_TX_DETECT_HANG
+};
+
+#define ring_uses_large_buffer(ring) \
+	test_bit(IGC_RING_FLAG_RX_3K_BUFFER, &(ring)->flags)
+
+#define ring_uses_build_skb(ring) \
+	test_bit(IGC_RING_FLAG_RX_BUILD_SKB_ENABLED, &(ring)->flags)
+
+static inline unsigned int igc_rx_bufsz(struct igc_ring *ring)
+{
+#if (PAGE_SIZE < 8192)
+	if (ring_uses_large_buffer(ring))
+		return IGC_RXBUFFER_3072;
+
+	if (ring_uses_build_skb(ring))
+		return IGC_MAX_FRAME_BUILD_SKB + IGC_TS_HDR_LEN;
+#endif
+	return IGC_RXBUFFER_2048;
+}
+
+static inline unsigned int igc_rx_pg_order(struct igc_ring *ring)
+{
+#if (PAGE_SIZE < 8192)
+	if (ring_uses_large_buffer(ring))
+		return 1;
+#endif
+	return 0;
+}
+
+static inline s32 igc_read_phy_reg(struct igc_hw *hw, u32 offset, u16 *data)
+{
+	if (hw->phy.ops.read_reg)
+		return hw->phy.ops.read_reg(hw, offset, data);
+
+	return 0;
+}
+
+void igc_reinit_locked(struct igc_adapter *);
+struct igc_nfc_rule *igc_get_nfc_rule(struct igc_adapter *adapter,
+				      u32 location);
+int igc_add_nfc_rule(struct igc_adapter *adapter, struct igc_nfc_rule *rule);
+void igc_del_nfc_rule(struct igc_adapter *adapter, struct igc_nfc_rule *rule);
+
+#define igc_rx_pg_size(_ring) (PAGE_SIZE << igc_rx_pg_order(_ring))
+
+#define IGC_TXD_DCMD	(IGC_ADVTXD_DCMD_EOP | IGC_ADVTXD_DCMD_RS)
+
+#define IGC_RX_DESC(R, i)       \
+	(&(((union igc_adv_rx_desc *)((R)->desc))[i]))
+#define IGC_TX_DESC(R, i)       \
+	(&(((union igc_adv_tx_desc *)((R)->desc))[i]))
+#define IGC_TX_CTXTDESC(R, i)   \
+	(&(((struct igc_adv_tx_context_desc *)((R)->desc))[i]))
+
+#endif /* _IGC_H_ */
diff --git a/kernel/drivers/net/drivers/igc/igc_base.c b/kernel/drivers/net/drivers/igc/igc_base.c
new file mode 100644
index 000000000..fd37d2c20
--- /dev/null
+++ b/kernel/drivers/net/drivers/igc/igc_base.c
@@ -0,0 +1,432 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c)  2018 Intel Corporation */
+
+#include <linux/delay.h>
+
+#include "igc_hw.h"
+#include "igc_i225.h"
+#include "igc_mac.h"
+#include "igc_base.h"
+#include "igc.h"
+
+/**
+ * igc_reset_hw_base - Reset hardware
+ * @hw: pointer to the HW structure
+ *
+ * This resets the hardware into a known state.  This is a
+ * function pointer entry point called by the api module.
+ */
+static s32 igc_reset_hw_base(struct igc_hw *hw)
+{
+	s32 ret_val;
+	u32 ctrl;
+
+	/* Prevent the PCI-E bus from sticking if there is no TLP connection
+	 * on the last TLP read/write transaction when MAC is reset.
+	 */
+	ret_val = igc_disable_pcie_master(hw);
+	if (ret_val)
+		hw_dbg("PCI-E Master disable polling has failed\n");
+
+	hw_dbg("Masking off all interrupts\n");
+	wr32(IGC_IMC, 0xffffffff);
+
+	wr32(IGC_RCTL, 0);
+	wr32(IGC_TCTL, IGC_TCTL_PSP);
+	wrfl();
+
+	usleep_range(10000, 20000);
+
+	ctrl = rd32(IGC_CTRL);
+
+	hw_dbg("Issuing a global reset to MAC\n");
+	wr32(IGC_CTRL, ctrl | IGC_CTRL_DEV_RST);
+
+	ret_val = igc_get_auto_rd_done(hw);
+	if (ret_val) {
+		/* When auto config read does not complete, do not
+		 * return with an error. This can happen in situations
+		 * where there is no eeprom and prevents getting link.
+		 */
+		hw_dbg("Auto Read Done did not complete\n");
+	}
+
+	/* Clear any pending interrupt events. */
+	wr32(IGC_IMC, 0xffffffff);
+	rd32(IGC_ICR);
+
+	return ret_val;
+}
+
+/**
+ * igc_init_nvm_params_base - Init NVM func ptrs.
+ * @hw: pointer to the HW structure
+ */
+static s32 igc_init_nvm_params_base(struct igc_hw *hw)
+{
+	struct igc_nvm_info *nvm = &hw->nvm;
+	u32 eecd = rd32(IGC_EECD);
+	u16 size;
+
+	size = (u16)((eecd & IGC_EECD_SIZE_EX_MASK) >>
+		     IGC_EECD_SIZE_EX_SHIFT);
+
+	/* Added to a constant, "size" becomes the left-shift value
+	 * for setting word_size.
+	 */
+	size += NVM_WORD_SIZE_BASE_SHIFT;
+
+	/* Just in case size is out of range, cap it to the largest
+	 * EEPROM size supported
+	 */
+	if (size > 15)
+		size = 15;
+
+	nvm->type = igc_nvm_eeprom_spi;
+	nvm->word_size = BIT(size);
+	nvm->opcode_bits = 8;
+	nvm->delay_usec = 1;
+
+	nvm->page_size = eecd & IGC_EECD_ADDR_BITS ? 32 : 8;
+	nvm->address_bits = eecd & IGC_EECD_ADDR_BITS ?
+			    16 : 8;
+
+	if (nvm->word_size == BIT(15))
+		nvm->page_size = 128;
+
+	return 0;
+}
+
+/**
+ * igc_setup_copper_link_base - Configure copper link settings
+ * @hw: pointer to the HW structure
+ *
+ * Configures the link for auto-neg or forced speed and duplex.  Then we check
+ * for link, once link is established calls to configure collision distance
+ * and flow control are called.
+ */
+static s32 igc_setup_copper_link_base(struct igc_hw *hw)
+{
+	s32  ret_val = 0;
+	u32 ctrl;
+
+	ctrl = rd32(IGC_CTRL);
+	ctrl |= IGC_CTRL_SLU;
+	ctrl &= ~(IGC_CTRL_FRCSPD | IGC_CTRL_FRCDPX);
+	wr32(IGC_CTRL, ctrl);
+
+	ret_val = igc_setup_copper_link(hw);
+
+	return ret_val;
+}
+
+/**
+ * igc_init_mac_params_base - Init MAC func ptrs.
+ * @hw: pointer to the HW structure
+ */
+static s32 igc_init_mac_params_base(struct igc_hw *hw)
+{
+	struct igc_dev_spec_base *dev_spec = &hw->dev_spec._base;
+	struct igc_mac_info *mac = &hw->mac;
+
+	/* Set mta register count */
+	mac->mta_reg_count = 128;
+	mac->rar_entry_count = IGC_RAR_ENTRIES;
+
+	/* reset */
+	mac->ops.reset_hw = igc_reset_hw_base;
+
+	mac->ops.acquire_swfw_sync = igc_acquire_swfw_sync_i225;
+	mac->ops.release_swfw_sync = igc_release_swfw_sync_i225;
+
+	/* Allow a single clear of the SW semaphore on I225 */
+	if (mac->type == igc_i225)
+		dev_spec->clear_semaphore_once = true;
+
+	/* physical interface link setup */
+	mac->ops.setup_physical_interface = igc_setup_copper_link_base;
+
+	return 0;
+}
+
+/**
+ * igc_init_phy_params_base - Init PHY func ptrs.
+ * @hw: pointer to the HW structure
+ */
+static s32 igc_init_phy_params_base(struct igc_hw *hw)
+{
+	struct igc_phy_info *phy = &hw->phy;
+	s32 ret_val = 0;
+
+	if (hw->phy.media_type != igc_media_type_copper) {
+		phy->type = igc_phy_none;
+		goto out;
+	}
+
+	phy->autoneg_mask	= AUTONEG_ADVERTISE_SPEED_DEFAULT_2500;
+	phy->reset_delay_us	= 100;
+
+	/* set lan id */
+	hw->bus.func = (rd32(IGC_STATUS) & IGC_STATUS_FUNC_MASK) >>
+			IGC_STATUS_FUNC_SHIFT;
+
+	/* Make sure the PHY is in a good state. Several people have reported
+	 * firmware leaving the PHY's page select register set to something
+	 * other than the default of zero, which causes the PHY ID read to
+	 * access something other than the intended register.
+	 */
+	ret_val = hw->phy.ops.reset(hw);
+	if (ret_val) {
+		hw_dbg("Error resetting the PHY\n");
+		goto out;
+	}
+
+	ret_val = igc_get_phy_id(hw);
+	if (ret_val)
+		return ret_val;
+
+	igc_check_for_copper_link(hw);
+
+	/* Verify phy id and set remaining function pointers */
+	switch (phy->id) {
+	case I225_I_PHY_ID:
+		phy->type	= igc_phy_i225;
+		break;
+	default:
+		ret_val = -IGC_ERR_PHY;
+		goto out;
+	}
+
+out:
+	return ret_val;
+}
+
+static s32 igc_get_invariants_base(struct igc_hw *hw)
+{
+	struct igc_mac_info *mac = &hw->mac;
+	s32 ret_val = 0;
+
+	switch (hw->device_id) {
+	case IGC_DEV_ID_I225_LM:
+	case IGC_DEV_ID_I225_V:
+	case IGC_DEV_ID_I225_I:
+	case IGC_DEV_ID_I220_V:
+	case IGC_DEV_ID_I225_K:
+	case IGC_DEV_ID_I225_K2:
+	case IGC_DEV_ID_I225_LMVP:
+	case IGC_DEV_ID_I225_IT:
+	case IGC_DEV_ID_I226_LM:
+	case IGC_DEV_ID_I226_V:
+	case IGC_DEV_ID_I226_IT:
+	case IGC_DEV_ID_I221_V:
+	case IGC_DEV_ID_I226_BLANK_NVM:
+	case IGC_DEV_ID_I225_BLANK_NVM:
+		mac->type = igc_i225;
+		break;
+	default:
+		return -IGC_ERR_MAC_INIT;
+	}
+
+	hw->phy.media_type = igc_media_type_copper;
+
+	/* mac initialization and operations */
+	ret_val = igc_init_mac_params_base(hw);
+	if (ret_val)
+		goto out;
+
+	/* NVM initialization */
+	ret_val = igc_init_nvm_params_base(hw);
+	switch (hw->mac.type) {
+	case igc_i225:
+		ret_val = igc_init_nvm_params_i225(hw);
+		break;
+	default:
+		break;
+	}
+
+	/* setup PHY parameters */
+	ret_val = igc_init_phy_params_base(hw);
+	if (ret_val)
+		goto out;
+
+out:
+	return ret_val;
+}
+
+/**
+ * igc_acquire_phy_base - Acquire rights to access PHY
+ * @hw: pointer to the HW structure
+ *
+ * Acquire access rights to the correct PHY.  This is a
+ * function pointer entry point called by the api module.
+ */
+static s32 igc_acquire_phy_base(struct igc_hw *hw)
+{
+	u16 mask = IGC_SWFW_PHY0_SM;
+
+	return hw->mac.ops.acquire_swfw_sync(hw, mask);
+}
+
+/**
+ * igc_release_phy_base - Release rights to access PHY
+ * @hw: pointer to the HW structure
+ *
+ * A wrapper to release access rights to the correct PHY.  This is a
+ * function pointer entry point called by the api module.
+ */
+static void igc_release_phy_base(struct igc_hw *hw)
+{
+	u16 mask = IGC_SWFW_PHY0_SM;
+
+	hw->mac.ops.release_swfw_sync(hw, mask);
+}
+
+/**
+ * igc_init_hw_base - Initialize hardware
+ * @hw: pointer to the HW structure
+ *
+ * This inits the hardware readying it for operation.
+ */
+static s32 igc_init_hw_base(struct igc_hw *hw)
+{
+	struct igc_mac_info *mac = &hw->mac;
+	u16 i, rar_count = mac->rar_entry_count;
+	s32 ret_val = 0;
+
+	/* Setup the receive address */
+	igc_init_rx_addrs(hw, rar_count);
+
+	/* Zero out the Multicast HASH table */
+	hw_dbg("Zeroing the MTA\n");
+	for (i = 0; i < mac->mta_reg_count; i++)
+		array_wr32(IGC_MTA, i, 0);
+
+	/* Zero out the Unicast HASH table */
+	hw_dbg("Zeroing the UTA\n");
+	for (i = 0; i < mac->uta_reg_count; i++)
+		array_wr32(IGC_UTA, i, 0);
+
+	/* Setup link and flow control */
+	ret_val = igc_setup_link(hw);
+
+	/* Clear all of the statistics registers (clear on read).  It is
+	 * important that we do this after we have tried to establish link
+	 * because the symbol error count will increment wildly if there
+	 * is no link.
+	 */
+	igc_clear_hw_cntrs_base(hw);
+
+	return ret_val;
+}
+
+/**
+ * igc_power_down_phy_copper_base - Remove link during PHY power down
+ * @hw: pointer to the HW structure
+ *
+ * In the case of a PHY power down to save power, or to turn off link during a
+ * driver unload, or wake on lan is not enabled, remove the link.
+ */
+void igc_power_down_phy_copper_base(struct igc_hw *hw)
+{
+	/* If the management interface is not enabled, then power down */
+	if (!(igc_enable_mng_pass_thru(hw) || igc_check_reset_block(hw)))
+		igc_power_down_phy_copper(hw);
+}
+
+/**
+ * igc_rx_fifo_flush_base - Clean rx fifo after Rx enable
+ * @hw: pointer to the HW structure
+ *
+ * After Rx enable, if manageability is enabled then there is likely some
+ * bad data at the start of the fifo and possibly in the DMA fifo.  This
+ * function clears the fifos and flushes any packets that came in as rx was
+ * being enabled.
+ */
+void igc_rx_fifo_flush_base(struct igc_hw *hw)
+{
+	u32 rctl, rlpml, rxdctl[4], rfctl, temp_rctl, rx_enabled;
+	int i, ms_wait;
+
+	/* disable IPv6 options as per hardware errata */
+	rfctl = rd32(IGC_RFCTL);
+	rfctl |= IGC_RFCTL_IPV6_EX_DIS;
+	wr32(IGC_RFCTL, rfctl);
+
+	if (!(rd32(IGC_MANC) & IGC_MANC_RCV_TCO_EN))
+		return;
+
+	/* Disable all Rx queues */
+	for (i = 0; i < 4; i++) {
+		rxdctl[i] = rd32(IGC_RXDCTL(i));
+		wr32(IGC_RXDCTL(i),
+		     rxdctl[i] & ~IGC_RXDCTL_QUEUE_ENABLE);
+	}
+	/* Poll all queues to verify they have shut down */
+	for (ms_wait = 0; ms_wait < 10; ms_wait++) {
+		usleep_range(1000, 2000);
+		rx_enabled = 0;
+		for (i = 0; i < 4; i++)
+			rx_enabled |= rd32(IGC_RXDCTL(i));
+		if (!(rx_enabled & IGC_RXDCTL_QUEUE_ENABLE))
+			break;
+	}
+
+	if (ms_wait == 10)
+		hw_dbg("Queue disable timed out after 10ms\n");
+
+	/* Clear RLPML, RCTL.SBP, RFCTL.LEF, and set RCTL.LPE so that all
+	 * incoming packets are rejected.  Set enable and wait 2ms so that
+	 * any packet that was coming in as RCTL.EN was set is flushed
+	 */
+	wr32(IGC_RFCTL, rfctl & ~IGC_RFCTL_LEF);
+
+	rlpml = rd32(IGC_RLPML);
+	wr32(IGC_RLPML, 0);
+
+	rctl = rd32(IGC_RCTL);
+	temp_rctl = rctl & ~(IGC_RCTL_EN | IGC_RCTL_SBP);
+	temp_rctl |= IGC_RCTL_LPE;
+
+	wr32(IGC_RCTL, temp_rctl);
+	wr32(IGC_RCTL, temp_rctl | IGC_RCTL_EN);
+	wrfl();
+	usleep_range(2000, 3000);
+
+	/* Enable Rx queues that were previously enabled and restore our
+	 * previous state
+	 */
+	for (i = 0; i < 4; i++)
+		wr32(IGC_RXDCTL(i), rxdctl[i]);
+	wr32(IGC_RCTL, rctl);
+	wrfl();
+
+	wr32(IGC_RLPML, rlpml);
+	wr32(IGC_RFCTL, rfctl);
+
+	/* Flush receive errors generated by workaround */
+	rd32(IGC_ROC);
+	rd32(IGC_RNBC);
+	rd32(IGC_MPC);
+}
+
+static struct igc_mac_operations igc_mac_ops_base = {
+	.init_hw		= igc_init_hw_base,
+	.check_for_link		= igc_check_for_copper_link,
+	.rar_set		= igc_rar_set,
+	.read_mac_addr		= igc_read_mac_addr,
+	.get_speed_and_duplex	= igc_get_speed_and_duplex_copper,
+};
+
+static const struct igc_phy_operations igc_phy_ops_base = {
+	.acquire		= igc_acquire_phy_base,
+	.release		= igc_release_phy_base,
+	.reset			= igc_phy_hw_reset,
+	.read_reg		= igc_read_phy_reg_gpy,
+	.write_reg		= igc_write_phy_reg_gpy,
+};
+
+const struct igc_info igc_base_info = {
+	.get_invariants		= igc_get_invariants_base,
+	.mac_ops		= &igc_mac_ops_base,
+	.phy_ops		= &igc_phy_ops_base,
+};
diff --git a/kernel/drivers/net/drivers/igc/igc_base.h b/kernel/drivers/net/drivers/igc/igc_base.h
new file mode 100644
index 000000000..ea627ce52
--- /dev/null
+++ b/kernel/drivers/net/drivers/igc/igc_base.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c)  2018 Intel Corporation */
+
+#ifndef _IGC_BASE_H_
+#define _IGC_BASE_H_
+
+/* forward declaration */
+void igc_rx_fifo_flush_base(struct igc_hw *hw);
+void igc_power_down_phy_copper_base(struct igc_hw *hw);
+
+/* Transmit Descriptor - Advanced */
+union igc_adv_tx_desc {
+	struct {
+		__le64 buffer_addr;    /* Address of descriptor's data buf */
+		__le32 cmd_type_len;
+		__le32 olinfo_status;
+	} read;
+	struct {
+		__le64 rsvd;       /* Reserved */
+		__le32 nxtseq_seed;
+		__le32 status;
+	} wb;
+};
+
+/* Context descriptors */
+struct igc_adv_tx_context_desc {
+	__le32 vlan_macip_lens;
+	__le32 launch_time;
+	__le32 type_tucmd_mlhl;
+	__le32 mss_l4len_idx;
+};
+
+/* Adv Transmit Descriptor Config Masks */
+#define IGC_ADVTXD_MAC_TSTAMP	0x00080000 /* IEEE1588 Timestamp packet */
+#define IGC_ADVTXD_DTYP_CTXT	0x00200000 /* Advanced Context Descriptor */
+#define IGC_ADVTXD_DTYP_DATA	0x00300000 /* Advanced Data Descriptor */
+#define IGC_ADVTXD_DCMD_EOP	0x01000000 /* End of Packet */
+#define IGC_ADVTXD_DCMD_IFCS	0x02000000 /* Insert FCS (Ethernet CRC) */
+#define IGC_ADVTXD_DCMD_RS	0x08000000 /* Report Status */
+#define IGC_ADVTXD_DCMD_DEXT	0x20000000 /* Descriptor extension (1=Adv) */
+#define IGC_ADVTXD_DCMD_VLE	0x40000000 /* VLAN pkt enable */
+#define IGC_ADVTXD_DCMD_TSE	0x80000000 /* TCP Seg enable */
+#define IGC_ADVTXD_PAYLEN_SHIFT	14 /* Adv desc PAYLEN shift */
+
+#define IGC_RAR_ENTRIES		16
+
+/* Receive Descriptor - Advanced */
+union igc_adv_rx_desc {
+	struct {
+		__le64 pkt_addr; /* Packet buffer address */
+		__le64 hdr_addr; /* Header buffer address */
+	} read;
+	struct {
+		struct {
+			union {
+				__le32 data;
+				struct {
+					__le16 pkt_info; /*RSS type, Pkt type*/
+					/* Split Header, header buffer len */
+					__le16 hdr_info;
+				} hs_rss;
+			} lo_dword;
+			union {
+				__le32 rss; /* RSS Hash */
+				struct {
+					__le16 ip_id; /* IP id */
+					__le16 csum; /* Packet Checksum */
+				} csum_ip;
+			} hi_dword;
+		} lower;
+		struct {
+			__le32 status_error; /* ext status/error */
+			__le16 length; /* Packet length */
+			__le16 vlan; /* VLAN tag */
+		} upper;
+	} wb;  /* writeback */
+};
+
+/* Additional Transmit Descriptor Control definitions */
+#define IGC_TXDCTL_QUEUE_ENABLE	0x02000000 /* Ena specific Tx Queue */
+
+/* Additional Receive Descriptor Control definitions */
+#define IGC_RXDCTL_QUEUE_ENABLE	0x02000000 /* Ena specific Rx Queue */
+
+/* SRRCTL bit definitions */
+#define IGC_SRRCTL_BSIZEPKT_SHIFT		10 /* Shift _right_ */
+#define IGC_SRRCTL_BSIZEHDRSIZE_SHIFT		2  /* Shift _left_ */
+#define IGC_SRRCTL_DESCTYPE_ADV_ONEBUF	0x02000000
+
+#endif /* _IGC_BASE_H */
diff --git a/kernel/drivers/net/drivers/igc/igc_defines.h b/kernel/drivers/net/drivers/igc/igc_defines.h
new file mode 100644
index 000000000..32f5fd684
--- /dev/null
+++ b/kernel/drivers/net/drivers/igc/igc_defines.h
@@ -0,0 +1,537 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c)  2018 Intel Corporation */
+
+#ifndef _IGC_DEFINES_H_
+#define _IGC_DEFINES_H_
+
+/* Number of Transmit and Receive Descriptors must be a multiple of 8 */
+#define REQ_TX_DESCRIPTOR_MULTIPLE	8
+#define REQ_RX_DESCRIPTOR_MULTIPLE	8
+
+#define IGC_CTRL_EXT_DRV_LOAD	0x10000000 /* Drv loaded bit for FW */
+
+/* Definitions for power management and wakeup registers */
+/* Wake Up Control */
+#define IGC_WUC_PME_EN	0x00000002 /* PME Enable */
+
+/* Wake Up Filter Control */
+#define IGC_WUFC_LNKC	0x00000001 /* Link Status Change Wakeup Enable */
+#define IGC_WUFC_MAG	0x00000002 /* Magic Packet Wakeup Enable */
+#define IGC_WUFC_EX	0x00000004 /* Directed Exact Wakeup Enable */
+#define IGC_WUFC_MC	0x00000008 /* Directed Multicast Wakeup Enable */
+#define IGC_WUFC_BC	0x00000010 /* Broadcast Wakeup Enable */
+
+#define IGC_CTRL_ADVD3WUC	0x00100000  /* D3 WUC */
+
+/* Wake Up Status */
+#define IGC_WUS_EX	0x00000004 /* Directed Exact */
+#define IGC_WUS_ARPD	0x00000020 /* Directed ARP Request */
+#define IGC_WUS_IPV4	0x00000040 /* Directed IPv4 */
+#define IGC_WUS_IPV6	0x00000080 /* Directed IPv6 */
+#define IGC_WUS_NSD	0x00000400 /* Directed IPv6 Neighbor Solicitation */
+
+/* Packet types that are enabled for wake packet delivery */
+#define WAKE_PKT_WUS ( \
+	IGC_WUS_EX   | \
+	IGC_WUS_ARPD | \
+	IGC_WUS_IPV4 | \
+	IGC_WUS_IPV6 | \
+	IGC_WUS_NSD)
+
+/* Wake Up Packet Length */
+#define IGC_WUPL_MASK	0x00000FFF
+
+/* Wake Up Packet Memory stores the first 128 bytes of the wake up packet */
+#define IGC_WUPM_BYTES	128
+
+/* Loop limit on how long we wait for auto-negotiation to complete */
+#define COPPER_LINK_UP_LIMIT		10
+#define PHY_AUTO_NEG_LIMIT		45
+
+/* Number of 100 microseconds we wait for PCI Express master disable */
+#define MASTER_DISABLE_TIMEOUT		800
+/*Blocks new Master requests */
+#define IGC_CTRL_GIO_MASTER_DISABLE	0x00000004
+/* Status of Master requests. */
+#define IGC_STATUS_GIO_MASTER_ENABLE	0x00080000
+
+/* Receive Address
+ * Number of high/low register pairs in the RAR. The RAR (Receive Address
+ * Registers) holds the directed and multicast addresses that we monitor.
+ * Technically, we have 16 spots.  However, we reserve one of these spots
+ * (RAR[15]) for our directed address used by controllers with
+ * manageability enabled, allowing us room for 15 multicast addresses.
+ */
+#define IGC_RAH_RAH_MASK	0x0000FFFF
+#define IGC_RAH_ASEL_MASK	0x00030000
+#define IGC_RAH_ASEL_SRC_ADDR	BIT(16)
+#define IGC_RAH_QSEL_MASK	0x000C0000
+#define IGC_RAH_QSEL_SHIFT	18
+#define IGC_RAH_QSEL_ENABLE	BIT(28)
+#define IGC_RAH_AV		0x80000000 /* Receive descriptor valid */
+
+#define IGC_RAL_MAC_ADDR_LEN	4
+#define IGC_RAH_MAC_ADDR_LEN	2
+
+/* Error Codes */
+#define IGC_SUCCESS			0
+#define IGC_ERR_NVM			1
+#define IGC_ERR_PHY			2
+#define IGC_ERR_CONFIG			3
+#define IGC_ERR_PARAM			4
+#define IGC_ERR_MAC_INIT		5
+#define IGC_ERR_RESET			9
+#define IGC_ERR_MASTER_REQUESTS_PENDING	10
+#define IGC_ERR_BLK_PHY_RESET		12
+#define IGC_ERR_SWFW_SYNC		13
+
+/* Device Control */
+#define IGC_CTRL_DEV_RST	0x20000000  /* Device reset */
+
+#define IGC_CTRL_PHY_RST	0x80000000  /* PHY Reset */
+#define IGC_CTRL_SLU		0x00000040  /* Set link up (Force Link) */
+#define IGC_CTRL_FRCSPD		0x00000800  /* Force Speed */
+#define IGC_CTRL_FRCDPX		0x00001000  /* Force Duplex */
+
+#define IGC_CTRL_RFCE		0x08000000  /* Receive Flow Control enable */
+#define IGC_CTRL_TFCE		0x10000000  /* Transmit flow control enable */
+
+/* As per the EAS the maximum supported size is 9.5KB (9728 bytes) */
+#define MAX_JUMBO_FRAME_SIZE	0x2600
+
+/* PBA constants */
+#define IGC_PBA_34K		0x0022
+
+/* SW Semaphore Register */
+#define IGC_SWSM_SMBI		0x00000001 /* Driver Semaphore bit */
+#define IGC_SWSM_SWESMBI	0x00000002 /* FW Semaphore bit */
+
+/* SWFW_SYNC Definitions */
+#define IGC_SWFW_EEP_SM		0x1
+#define IGC_SWFW_PHY0_SM	0x2
+
+/* Autoneg Advertisement Register */
+#define NWAY_AR_10T_HD_CAPS	0x0020   /* 10T   Half Duplex Capable */
+#define NWAY_AR_10T_FD_CAPS	0x0040   /* 10T   Full Duplex Capable */
+#define NWAY_AR_100TX_HD_CAPS	0x0080   /* 100TX Half Duplex Capable */
+#define NWAY_AR_100TX_FD_CAPS	0x0100   /* 100TX Full Duplex Capable */
+#define NWAY_AR_PAUSE		0x0400   /* Pause operation desired */
+#define NWAY_AR_ASM_DIR		0x0800   /* Asymmetric Pause Direction bit */
+
+/* Link Partner Ability Register (Base Page) */
+#define NWAY_LPAR_PAUSE		0x0400 /* LP Pause operation desired */
+#define NWAY_LPAR_ASM_DIR	0x0800 /* LP Asymmetric Pause Direction bit */
+
+/* 1000BASE-T Control Register */
+#define CR_1000T_ASYM_PAUSE	0x0080 /* Advertise asymmetric pause bit */
+#define CR_1000T_HD_CAPS	0x0100 /* Advertise 1000T HD capability */
+#define CR_1000T_FD_CAPS	0x0200 /* Advertise 1000T FD capability  */
+
+/* 1000BASE-T Status Register */
+#define SR_1000T_REMOTE_RX_STATUS	0x1000 /* Remote receiver OK */
+#define SR_1000T_LOCAL_RX_STATUS	0x2000 /* Local receiver OK */
+
+/* PHY GPY 211 registers */
+#define STANDARD_AN_REG_MASK	0x0007 /* MMD */
+#define ANEG_MULTIGBT_AN_CTRL	0x0020 /* MULTI GBT AN Control Register */
+#define MMD_DEVADDR_SHIFT	16     /* Shift MMD to higher bits */
+#define CR_2500T_FD_CAPS	0x0080 /* Advertise 2500T FD capability */
+
+/* NVM Control */
+/* Number of milliseconds for NVM auto read done after MAC reset. */
+#define AUTO_READ_DONE_TIMEOUT		10
+#define IGC_EECD_AUTO_RD		0x00000200  /* NVM Auto Read done */
+#define IGC_EECD_REQ		0x00000040 /* NVM Access Request */
+#define IGC_EECD_GNT		0x00000080 /* NVM Access Grant */
+/* NVM Addressing bits based on type 0=small, 1=large */
+#define IGC_EECD_ADDR_BITS		0x00000400
+#define IGC_NVM_GRANT_ATTEMPTS		1000 /* NVM # attempts to gain grant */
+#define IGC_EECD_SIZE_EX_MASK		0x00007800  /* NVM Size */
+#define IGC_EECD_SIZE_EX_SHIFT		11
+#define IGC_EECD_FLUPD_I225		0x00800000 /* Update FLASH */
+#define IGC_EECD_FLUDONE_I225		0x04000000 /* Update FLASH done*/
+#define IGC_EECD_FLASH_DETECTED_I225	0x00080000 /* FLASH detected */
+#define IGC_FLUDONE_ATTEMPTS		20000
+#define IGC_EERD_EEWR_MAX_COUNT		512 /* buffered EEPROM words rw */
+
+/* Offset to data in NVM read/write registers */
+#define IGC_NVM_RW_REG_DATA	16
+#define IGC_NVM_RW_REG_DONE	2    /* Offset to READ/WRITE done bit */
+#define IGC_NVM_RW_REG_START	1    /* Start operation */
+#define IGC_NVM_RW_ADDR_SHIFT	2    /* Shift to the address bits */
+#define IGC_NVM_POLL_READ	0    /* Flag for polling for read complete */
+
+/* NVM Word Offsets */
+#define NVM_CHECKSUM_REG		0x003F
+
+/* For checksumming, the sum of all words in the NVM should equal 0xBABA. */
+#define NVM_SUM				0xBABA
+#define NVM_WORD_SIZE_BASE_SHIFT	6
+
+/* Collision related configuration parameters */
+#define IGC_COLLISION_THRESHOLD		15
+#define IGC_CT_SHIFT			4
+#define IGC_COLLISION_DISTANCE		63
+#define IGC_COLD_SHIFT			12
+
+/* Device Status */
+#define IGC_STATUS_FD		0x00000001      /* Full duplex.0=half,1=full */
+#define IGC_STATUS_LU		0x00000002      /* Link up.0=no,1=link */
+#define IGC_STATUS_FUNC_MASK	0x0000000C      /* PCI Function Mask */
+#define IGC_STATUS_FUNC_SHIFT	2
+#define IGC_STATUS_FUNC_1	0x00000004      /* Function 1 */
+#define IGC_STATUS_TXOFF	0x00000010      /* transmission paused */
+#define IGC_STATUS_SPEED_100	0x00000040      /* Speed 100Mb/s */
+#define IGC_STATUS_SPEED_1000	0x00000080      /* Speed 1000Mb/s */
+#define IGC_STATUS_SPEED_2500	0x00400000	/* Speed 2.5Gb/s */
+
+#define SPEED_10		10
+#define SPEED_100		100
+#define SPEED_1000		1000
+#define SPEED_2500		2500
+#define HALF_DUPLEX		1
+#define FULL_DUPLEX		2
+
+/* 1Gbps and 2.5Gbps half duplex is not supported, nor spec-compliant. */
+#define ADVERTISE_10_HALF		0x0001
+#define ADVERTISE_10_FULL		0x0002
+#define ADVERTISE_100_HALF		0x0004
+#define ADVERTISE_100_FULL		0x0008
+#define ADVERTISE_1000_HALF		0x0010 /* Not used, just FYI */
+#define ADVERTISE_1000_FULL		0x0020
+#define ADVERTISE_2500_HALF		0x0040 /* Not used, just FYI */
+#define ADVERTISE_2500_FULL		0x0080
+
+#define IGC_ALL_SPEED_DUPLEX_2500 ( \
+	ADVERTISE_10_HALF | ADVERTISE_10_FULL | ADVERTISE_100_HALF | \
+	ADVERTISE_100_FULL | ADVERTISE_1000_FULL | ADVERTISE_2500_FULL)
+
+#define AUTONEG_ADVERTISE_SPEED_DEFAULT_2500	IGC_ALL_SPEED_DUPLEX_2500
+
+/* Interrupt Cause Read */
+#define IGC_ICR_TXDW		BIT(0)	/* Transmit desc written back */
+#define IGC_ICR_TXQE		BIT(1)	/* Transmit Queue empty */
+#define IGC_ICR_LSC		BIT(2)	/* Link Status Change */
+#define IGC_ICR_RXSEQ		BIT(3)	/* Rx sequence error */
+#define IGC_ICR_RXDMT0		BIT(4)	/* Rx desc min. threshold (0) */
+#define IGC_ICR_RXO		BIT(6)	/* Rx overrun */
+#define IGC_ICR_RXT0		BIT(7)	/* Rx timer intr (ring 0) */
+#define IGC_ICR_TS		BIT(19)	/* Time Sync Interrupt */
+#define IGC_ICR_DRSTA		BIT(30)	/* Device Reset Asserted */
+
+/* If this bit asserted, the driver should claim the interrupt */
+#define IGC_ICR_INT_ASSERTED	BIT(31)
+
+#define IGC_ICS_RXT0		IGC_ICR_RXT0 /* Rx timer intr */
+
+#define IMS_ENABLE_MASK ( \
+	IGC_IMS_RXT0   |    \
+	IGC_IMS_TXDW   |    \
+	IGC_IMS_RXDMT0 |    \
+	IGC_IMS_RXSEQ  |    \
+	IGC_IMS_LSC)
+
+/* Interrupt Mask Set */
+#define IGC_IMS_TXDW		IGC_ICR_TXDW	/* Tx desc written back */
+#define IGC_IMS_RXSEQ		IGC_ICR_RXSEQ	/* Rx sequence error */
+#define IGC_IMS_LSC		IGC_ICR_LSC	/* Link Status Change */
+#define IGC_IMS_DOUTSYNC	IGC_ICR_DOUTSYNC /* NIC DMA out of sync */
+#define IGC_IMS_DRSTA		IGC_ICR_DRSTA	/* Device Reset Asserted */
+#define IGC_IMS_RXT0		IGC_ICR_RXT0	/* Rx timer intr */
+#define IGC_IMS_RXDMT0		IGC_ICR_RXDMT0	/* Rx desc min. threshold */
+#define IGC_IMS_TS		IGC_ICR_TS	/* Time Sync Interrupt */
+
+#define IGC_QVECTOR_MASK	0x7FFC		/* Q-vector mask */
+#define IGC_ITR_VAL_MASK	0x04		/* ITR value mask */
+
+/* Interrupt Cause Set */
+#define IGC_ICS_LSC		IGC_ICR_LSC       /* Link Status Change */
+#define IGC_ICS_RXDMT0		IGC_ICR_RXDMT0    /* rx desc min. threshold */
+
+#define IGC_ICR_DOUTSYNC	0x10000000 /* NIC DMA out of sync */
+#define IGC_EITR_CNT_IGNR	0x80000000 /* Don't reset counters on write */
+#define IGC_IVAR_VALID		0x80
+#define IGC_GPIE_NSICR		0x00000001
+#define IGC_GPIE_MSIX_MODE	0x00000010
+#define IGC_GPIE_EIAME		0x40000000
+#define IGC_GPIE_PBA		0x80000000
+
+/* Receive Descriptor bit definitions */
+#define IGC_RXD_STAT_DD		0x01    /* Descriptor Done */
+
+/* Transmit Descriptor bit definitions */
+#define IGC_TXD_DTYP_D		0x00100000 /* Data Descriptor */
+#define IGC_TXD_DTYP_C		0x00000000 /* Context Descriptor */
+#define IGC_TXD_POPTS_IXSM	0x01       /* Insert IP checksum */
+#define IGC_TXD_POPTS_TXSM	0x02       /* Insert TCP/UDP checksum */
+#define IGC_TXD_CMD_EOP		0x01000000 /* End of Packet */
+#define IGC_TXD_CMD_IC		0x04000000 /* Insert Checksum */
+#define IGC_TXD_CMD_DEXT	0x20000000 /* Desc extension (0 = legacy) */
+#define IGC_TXD_CMD_VLE		0x40000000 /* Add VLAN tag */
+#define IGC_TXD_STAT_DD		0x00000001 /* Descriptor Done */
+#define IGC_TXD_CMD_TCP		0x01000000 /* TCP packet */
+#define IGC_TXD_CMD_IP		0x02000000 /* IP packet */
+#define IGC_TXD_CMD_TSE		0x04000000 /* TCP Seg enable */
+#define IGC_TXD_EXTCMD_TSTAMP	0x00000010 /* IEEE1588 Timestamp packet */
+
+/* IPSec Encrypt Enable */
+#define IGC_ADVTXD_L4LEN_SHIFT	8  /* Adv ctxt L4LEN shift */
+#define IGC_ADVTXD_MSS_SHIFT	16 /* Adv ctxt MSS shift */
+
+/* Transmit Control */
+#define IGC_TCTL_EN		0x00000002 /* enable Tx */
+#define IGC_TCTL_PSP		0x00000008 /* pad short packets */
+#define IGC_TCTL_CT		0x00000ff0 /* collision threshold */
+#define IGC_TCTL_COLD		0x003ff000 /* collision distance */
+#define IGC_TCTL_RTLC		0x01000000 /* Re-transmit on late collision */
+#define IGC_TCTL_MULR		0x10000000 /* Multiple request support */
+
+/* Flow Control Constants */
+#define FLOW_CONTROL_ADDRESS_LOW	0x00C28001
+#define FLOW_CONTROL_ADDRESS_HIGH	0x00000100
+#define FLOW_CONTROL_TYPE		0x8808
+/* Enable XON frame transmission */
+#define IGC_FCRTL_XONE			0x80000000
+
+/* Management Control */
+#define IGC_MANC_RCV_TCO_EN	0x00020000 /* Receive TCO Packets Enabled */
+#define IGC_MANC_BLK_PHY_RST_ON_IDE	0x00040000 /* Block phy resets */
+
+/* Receive Control */
+#define IGC_RCTL_RST		0x00000001 /* Software reset */
+#define IGC_RCTL_EN		0x00000002 /* enable */
+#define IGC_RCTL_SBP		0x00000004 /* store bad packet */
+#define IGC_RCTL_UPE		0x00000008 /* unicast promisc enable */
+#define IGC_RCTL_MPE		0x00000010 /* multicast promisc enable */
+#define IGC_RCTL_LPE		0x00000020 /* long packet enable */
+#define IGC_RCTL_LBM_MAC	0x00000040 /* MAC loopback mode */
+#define IGC_RCTL_LBM_TCVR	0x000000C0 /* tcvr loopback mode */
+
+#define IGC_RCTL_RDMTS_HALF	0x00000000 /* Rx desc min thresh size */
+#define IGC_RCTL_BAM		0x00008000 /* broadcast enable */
+
+/* Split Replication Receive Control */
+#define IGC_SRRCTL_TIMESTAMP		0x40000000
+#define IGC_SRRCTL_TIMER1SEL(timer)	(((timer) & 0x3) << 14)
+#define IGC_SRRCTL_TIMER0SEL(timer)	(((timer) & 0x3) << 17)
+
+/* Receive Descriptor bit definitions */
+#define IGC_RXD_STAT_EOP	0x02	/* End of Packet */
+#define IGC_RXD_STAT_IXSM	0x04	/* Ignore checksum */
+#define IGC_RXD_STAT_UDPCS	0x10	/* UDP xsum calculated */
+#define IGC_RXD_STAT_TCPCS	0x20	/* TCP xsum calculated */
+
+/* Advanced Receive Descriptor bit definitions */
+#define IGC_RXDADV_STAT_TSIP	0x08000 /* timestamp in packet */
+
+#define IGC_RXDEXT_STATERR_L4E		0x20000000
+#define IGC_RXDEXT_STATERR_IPE		0x40000000
+#define IGC_RXDEXT_STATERR_RXE		0x80000000
+
+#define IGC_MRQC_RSS_FIELD_IPV4_TCP	0x00010000
+#define IGC_MRQC_RSS_FIELD_IPV4		0x00020000
+#define IGC_MRQC_RSS_FIELD_IPV6_TCP_EX	0x00040000
+#define IGC_MRQC_RSS_FIELD_IPV6		0x00100000
+#define IGC_MRQC_RSS_FIELD_IPV6_TCP	0x00200000
+
+/* Header split receive */
+#define IGC_RFCTL_IPV6_EX_DIS	0x00010000
+#define IGC_RFCTL_LEF		0x00040000
+
+#define IGC_RCTL_SZ_256		0x00030000 /* Rx buffer size 256 */
+
+#define IGC_RCTL_MO_SHIFT	12 /* multicast offset shift */
+#define IGC_RCTL_CFIEN		0x00080000 /* canonical form enable */
+#define IGC_RCTL_DPF		0x00400000 /* discard pause frames */
+#define IGC_RCTL_PMCF		0x00800000 /* pass MAC control frames */
+#define IGC_RCTL_SECRC		0x04000000 /* Strip Ethernet CRC */
+
+#define I225_RXPBSIZE_DEFAULT	0x000000A2 /* RXPBSIZE default */
+#define I225_TXPBSIZE_DEFAULT	0x04000014 /* TXPBSIZE default */
+#define IGC_RXPBS_CFG_TS_EN	0x80000000 /* Timestamp in Rx buffer */
+
+#define IGC_TXPBSIZE_TSN	0x04145145 /* 5k bytes buffer for each queue */
+
+#define IGC_DTXMXPKTSZ_TSN	0x19 /* 1600 bytes of max TX DMA packet size */
+#define IGC_DTXMXPKTSZ_DEFAULT	0x98 /* 9728-byte Jumbo frames */
+
+/* Time Sync Interrupt Causes */
+#define IGC_TSICR_SYS_WRAP	BIT(0) /* SYSTIM Wrap around. */
+#define IGC_TSICR_TXTS		BIT(1) /* Transmit Timestamp. */
+#define IGC_TSICR_TT0		BIT(3) /* Target Time 0 Trigger. */
+#define IGC_TSICR_TT1		BIT(4) /* Target Time 1 Trigger. */
+#define IGC_TSICR_AUTT0		BIT(5) /* Auxiliary Timestamp 0 Taken. */
+#define IGC_TSICR_AUTT1		BIT(6) /* Auxiliary Timestamp 1 Taken. */
+
+#define IGC_TSICR_INTERRUPTS	IGC_TSICR_TXTS
+
+#define IGC_FTQF_VF_BP		0x00008000
+#define IGC_FTQF_1588_TIME_STAMP	0x08000000
+#define IGC_FTQF_MASK			0xF0000000
+#define IGC_FTQF_MASK_PROTO_BP	0x10000000
+
+/* Time Sync Receive Control bit definitions */
+#define IGC_TSYNCRXCTL_TYPE_MASK	0x0000000E  /* Rx type mask */
+#define IGC_TSYNCRXCTL_TYPE_L2_V2	0x00
+#define IGC_TSYNCRXCTL_TYPE_L4_V1	0x02
+#define IGC_TSYNCRXCTL_TYPE_L2_L4_V2	0x04
+#define IGC_TSYNCRXCTL_TYPE_ALL		0x08
+#define IGC_TSYNCRXCTL_TYPE_EVENT_V2	0x0A
+#define IGC_TSYNCRXCTL_ENABLED		0x00000010  /* enable Rx timestamping */
+#define IGC_TSYNCRXCTL_SYSCFI		0x00000020  /* Sys clock frequency */
+#define IGC_TSYNCRXCTL_RXSYNSIG		0x00000400  /* Sample RX tstamp in PHY sop */
+
+/* Time Sync Receive Configuration */
+#define IGC_TSYNCRXCFG_PTP_V1_CTRLT_MASK	0x000000FF
+#define IGC_TSYNCRXCFG_PTP_V1_SYNC_MESSAGE	0x00
+#define IGC_TSYNCRXCFG_PTP_V1_DELAY_REQ_MESSAGE	0x01
+
+/* Immediate Interrupt Receive */
+#define IGC_IMIR_CLEAR_MASK	0xF001FFFF /* IMIR Reg Clear Mask */
+#define IGC_IMIR_PORT_BYPASS	0x20000 /* IMIR Port Bypass Bit */
+#define IGC_IMIR_PRIORITY_SHIFT	29 /* IMIR Priority Shift */
+#define IGC_IMIREXT_CLEAR_MASK	0x7FFFF /* IMIREXT Reg Clear Mask */
+
+/* Immediate Interrupt Receive Extended */
+#define IGC_IMIREXT_CTRL_BP	0x00080000  /* Bypass check of ctrl bits */
+#define IGC_IMIREXT_SIZE_BP	0x00001000  /* Packet size bypass */
+
+/* Time Sync Transmit Control bit definitions */
+#define IGC_TSYNCTXCTL_TXTT_0			0x00000001  /* Tx timestamp reg 0 valid */
+#define IGC_TSYNCTXCTL_ENABLED			0x00000010  /* enable Tx timestamping */
+#define IGC_TSYNCTXCTL_MAX_ALLOWED_DLY_MASK	0x0000F000  /* max delay */
+#define IGC_TSYNCTXCTL_SYNC_COMP_ERR		0x20000000  /* sync err */
+#define IGC_TSYNCTXCTL_SYNC_COMP		0x40000000  /* sync complete */
+#define IGC_TSYNCTXCTL_START_SYNC		0x80000000  /* initiate sync */
+#define IGC_TSYNCTXCTL_TXSYNSIG			0x00000020  /* Sample TX tstamp in PHY sop */
+
+/* Transmit Scheduling */
+#define IGC_TQAVCTRL_TRANSMIT_MODE_TSN	0x00000001
+#define IGC_TQAVCTRL_ENHANCED_QAV	0x00000008
+
+#define IGC_TXQCTL_QUEUE_MODE_LAUNCHT	0x00000001
+#define IGC_TXQCTL_STRICT_CYCLE		0x00000002
+#define IGC_TXQCTL_STRICT_END		0x00000004
+
+/* Receive Checksum Control */
+#define IGC_RXCSUM_CRCOFL	0x00000800   /* CRC32 offload enable */
+#define IGC_RXCSUM_PCSD		0x00002000   /* packet checksum disabled */
+
+/* GPY211 - I225 defines */
+#define GPY_MMD_MASK		0xFFFF0000
+#define GPY_MMD_SHIFT		16
+#define GPY_REG_MASK		0x0000FFFF
+
+#define IGC_MMDAC_FUNC_DATA	0x4000 /* Data, no post increment */
+
+/* MAC definitions */
+#define IGC_FACTPS_MNGCG	0x20000000
+#define IGC_FWSM_MODE_MASK	0xE
+#define IGC_FWSM_MODE_SHIFT	1
+
+/* Management Control */
+#define IGC_MANC_SMBUS_EN	0x00000001 /* SMBus Enabled - RO */
+#define IGC_MANC_ASF_EN		0x00000002 /* ASF Enabled - RO */
+
+/* PHY */
+#define PHY_REVISION_MASK	0xFFFFFFF0
+#define MAX_PHY_REG_ADDRESS	0x1F  /* 5 bit address bus (0-0x1F) */
+#define IGC_GEN_POLL_TIMEOUT	1920
+
+/* PHY Control Register */
+#define MII_CR_FULL_DUPLEX	0x0100  /* FDX =1, half duplex =0 */
+#define MII_CR_RESTART_AUTO_NEG	0x0200  /* Restart auto negotiation */
+#define MII_CR_POWER_DOWN	0x0800  /* Power down */
+#define MII_CR_AUTO_NEG_EN	0x1000  /* Auto Neg Enable */
+#define MII_CR_LOOPBACK		0x4000  /* 0 = normal, 1 = loopback */
+#define MII_CR_RESET		0x8000  /* 0 = normal, 1 = PHY reset */
+#define MII_CR_SPEED_1000	0x0040
+#define MII_CR_SPEED_100	0x2000
+#define MII_CR_SPEED_10		0x0000
+
+/* PHY Status Register */
+#define MII_SR_LINK_STATUS	0x0004 /* Link Status 1 = link */
+#define MII_SR_AUTONEG_COMPLETE	0x0020 /* Auto Neg Complete */
+#define IGC_PHY_RST_COMP	0x0100 /* Internal PHY reset completion */
+
+/* PHY 1000 MII Register/Bit Definitions */
+/* PHY Registers defined by IEEE */
+#define PHY_CONTROL		0x00 /* Control Register */
+#define PHY_STATUS		0x01 /* Status Register */
+#define PHY_ID1			0x02 /* Phy Id Reg (word 1) */
+#define PHY_ID2			0x03 /* Phy Id Reg (word 2) */
+#define PHY_AUTONEG_ADV		0x04 /* Autoneg Advertisement */
+#define PHY_LP_ABILITY		0x05 /* Link Partner Ability (Base Page) */
+#define PHY_1000T_CTRL		0x09 /* 1000Base-T Control Reg */
+#define PHY_1000T_STATUS	0x0A /* 1000Base-T Status Reg */
+
+/* Bit definitions for valid PHY IDs. I = Integrated E = External */
+#define I225_I_PHY_ID		0x67C9DC00
+
+/* MDI Control */
+#define IGC_MDIC_DATA_MASK	0x0000FFFF
+#define IGC_MDIC_REG_MASK	0x001F0000
+#define IGC_MDIC_REG_SHIFT	16
+#define IGC_MDIC_PHY_MASK	0x03E00000
+#define IGC_MDIC_PHY_SHIFT	21
+#define IGC_MDIC_OP_WRITE	0x04000000
+#define IGC_MDIC_OP_READ	0x08000000
+#define IGC_MDIC_READY		0x10000000
+#define IGC_MDIC_INT_EN		0x20000000
+#define IGC_MDIC_ERROR		0x40000000
+
+#define IGC_N0_QUEUE		-1
+
+#define IGC_MAX_MAC_HDR_LEN	127
+#define IGC_MAX_NETWORK_HDR_LEN	511
+
+#define IGC_VLANPQF_QSEL(_n, q_idx) ((q_idx) << ((_n) * 4))
+#define IGC_VLANPQF_VALID(_n)	(0x1 << (3 + (_n) * 4))
+#define IGC_VLANPQF_QUEUE_MASK	0x03
+
+#define IGC_ADVTXD_MACLEN_SHIFT		9  /* Adv ctxt desc mac len shift */
+#define IGC_ADVTXD_TUCMD_IPV4		0x00000400  /* IP Packet Type:1=IPv4 */
+#define IGC_ADVTXD_TUCMD_L4T_TCP	0x00000800  /* L4 Packet Type of TCP */
+#define IGC_ADVTXD_TUCMD_L4T_SCTP	0x00001000 /* L4 packet TYPE of SCTP */
+
+/* Maximum size of the MTA register table in all supported adapters */
+#define MAX_MTA_REG			128
+
+/* EEE defines */
+#define IGC_IPCNFG_EEE_2_5G_AN		0x00000010 /* IPCNFG EEE Ena 2.5G AN */
+#define IGC_IPCNFG_EEE_1G_AN		0x00000008 /* IPCNFG EEE Ena 1G AN */
+#define IGC_IPCNFG_EEE_100M_AN		0x00000004 /* IPCNFG EEE Ena 100M AN */
+#define IGC_EEER_EEE_NEG		0x20000000 /* EEE capability nego */
+#define IGC_EEER_TX_LPI_EN		0x00010000 /* EEER Tx LPI Enable */
+#define IGC_EEER_RX_LPI_EN		0x00020000 /* EEER Rx LPI Enable */
+#define IGC_EEER_LPI_FC			0x00040000 /* EEER Ena on Flow Cntrl */
+#define IGC_EEE_SU_LPI_CLK_STP		0x00800000 /* EEE LPI Clock Stop */
+
+/* LTR defines */
+#define IGC_LTRC_EEEMS_EN		0x00000020 /* Enable EEE LTR max send */
+#define IGC_RXPBS_SIZE_I225_MASK	0x0000003F /* Rx packet buffer size */
+#define IGC_TW_SYSTEM_1000_MASK		0x000000FF
+/* Minimum time for 100BASE-T where no data will be transmit following move out
+ * of EEE LPI Tx state
+ */
+#define IGC_TW_SYSTEM_100_MASK		0x0000FF00
+#define IGC_TW_SYSTEM_100_SHIFT		8
+#define IGC_DMACR_DMAC_EN		0x80000000 /* Enable DMA Coalescing */
+#define IGC_DMACR_DMACTHR_MASK		0x00FF0000
+#define IGC_DMACR_DMACTHR_SHIFT		16
+/* Reg val to set scale to 1024 nsec */
+#define IGC_LTRMINV_SCALE_1024		2
+/* Reg val to set scale to 32768 nsec */
+#define IGC_LTRMINV_SCALE_32768		3
+/* Reg val to set scale to 1024 nsec */
+#define IGC_LTRMAXV_SCALE_1024		2
+/* Reg val to set scale to 32768 nsec */
+#define IGC_LTRMAXV_SCALE_32768		3
+#define IGC_LTRMINV_LTRV_MASK		0x000003FF /* LTR minimum value */
+#define IGC_LTRMAXV_LTRV_MASK		0x000003FF /* LTR maximum value */
+#define IGC_LTRMINV_LSNP_REQ		0x00008000 /* LTR Snoop Requirement */
+#define IGC_LTRMINV_SCALE_SHIFT		10
+#define IGC_LTRMAXV_LSNP_REQ		0x00008000 /* LTR Snoop Requirement */
+#define IGC_LTRMAXV_SCALE_SHIFT		10
+
+#endif /* _IGC_DEFINES_H_ */
diff --git a/kernel/drivers/net/drivers/igc/igc_dump.c b/kernel/drivers/net/drivers/igc/igc_dump.c
new file mode 100644
index 000000000..77ac00598
--- /dev/null
+++ b/kernel/drivers/net/drivers/igc/igc_dump.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c)  2018 Intel Corporation */
+
+#include "igc.h"
+
+struct igc_reg_info {
+	u32 ofs;
+	char *name;
+};
+
+static const struct igc_reg_info igc_reg_info_tbl[] = {
+	/* General Registers */
+	{IGC_CTRL, "CTRL"},
+	{IGC_STATUS, "STATUS"},
+	{IGC_CTRL_EXT, "CTRL_EXT"},
+	{IGC_MDIC, "MDIC"},
+
+	/* Interrupt Registers */
+	{IGC_ICR, "ICR"},
+
+	/* RX Registers */
+	{IGC_RCTL, "RCTL"},
+	{IGC_RDLEN(0), "RDLEN"},
+	{IGC_RDH(0), "RDH"},
+	{IGC_RDT(0), "RDT"},
+	{IGC_RXDCTL(0), "RXDCTL"},
+	{IGC_RDBAL(0), "RDBAL"},
+	{IGC_RDBAH(0), "RDBAH"},
+
+	/* TX Registers */
+	{IGC_TCTL, "TCTL"},
+	{IGC_TDBAL(0), "TDBAL"},
+	{IGC_TDBAH(0), "TDBAH"},
+	{IGC_TDLEN(0), "TDLEN"},
+	{IGC_TDH(0), "TDH"},
+	{IGC_TDT(0), "TDT"},
+	{IGC_TXDCTL(0), "TXDCTL"},
+
+	/* List Terminator */
+	{}
+};
+
+/* igc_regdump - register printout routine */
+static void igc_regdump(struct igc_hw *hw, struct igc_reg_info *reginfo)
+{
+	int n = 0;
+	char rname[16];
+	u32 regs[8];
+
+	switch (reginfo->ofs) {
+	case IGC_RDLEN(0):
+		for (n = 0; n < 4; n++)
+			regs[n] = rd32(IGC_RDLEN(n));
+		break;
+	case IGC_RDH(0):
+		for (n = 0; n < 4; n++)
+			regs[n] = rd32(IGC_RDH(n));
+		break;
+	case IGC_RDT(0):
+		for (n = 0; n < 4; n++)
+			regs[n] = rd32(IGC_RDT(n));
+		break;
+	case IGC_RXDCTL(0):
+		for (n = 0; n < 4; n++)
+			regs[n] = rd32(IGC_RXDCTL(n));
+		break;
+	case IGC_RDBAL(0):
+		for (n = 0; n < 4; n++)
+			regs[n] = rd32(IGC_RDBAL(n));
+		break;
+	case IGC_RDBAH(0):
+		for (n = 0; n < 4; n++)
+			regs[n] = rd32(IGC_RDBAH(n));
+		break;
+	case IGC_TDBAL(0):
+		for (n = 0; n < 4; n++)
+			regs[n] = rd32(IGC_RDBAL(n));
+		break;
+	case IGC_TDBAH(0):
+		for (n = 0; n < 4; n++)
+			regs[n] = rd32(IGC_TDBAH(n));
+		break;
+	case IGC_TDLEN(0):
+		for (n = 0; n < 4; n++)
+			regs[n] = rd32(IGC_TDLEN(n));
+		break;
+	case IGC_TDH(0):
+		for (n = 0; n < 4; n++)
+			regs[n] = rd32(IGC_TDH(n));
+		break;
+	case IGC_TDT(0):
+		for (n = 0; n < 4; n++)
+			regs[n] = rd32(IGC_TDT(n));
+		break;
+	case IGC_TXDCTL(0):
+		for (n = 0; n < 4; n++)
+			regs[n] = rd32(IGC_TXDCTL(n));
+		break;
+	default:
+		pr_info("%-15s %08x\n", reginfo->name,
+			    rd32(reginfo->ofs));
+		return;
+	}
+
+	snprintf(rname, 16, "%s%s", reginfo->name, "[0-3]");
+	pr_info("%-15s %08x %08x %08x %08x\n", rname, regs[0], regs[1],
+		    regs[2], regs[3]);
+}
+
+/* igc_rings_dump - Tx-rings and Rx-rings */
+void igc_rings_dump(struct igc_adapter *adapter)
+{
+	struct rtnet_device *netdev = adapter->netdev;
+	struct my_u0 { u64 a; u64 b; } *u0;
+	union igc_adv_tx_desc *tx_desc;
+	union igc_adv_rx_desc *rx_desc;
+	struct igc_ring *tx_ring;
+	struct igc_ring *rx_ring;
+	u32 staterr;
+	u16 i, n;
+
+	if (!netif_msg_hw(adapter))
+		return;
+
+	/* Print TX Ring Summary */
+	if (!rtnetif_running(netdev))
+		goto exit;
+
+	dev_info(&adapter->pdev->dev, "TX Rings Summary\n");
+	dev_info(&adapter->pdev->dev, "Queue [NTU] [NTC] [bi(ntc)->dma  ] leng ntw timestamp\n");
+	for (n = 0; n < adapter->num_tx_queues; n++) {
+		struct igc_tx_buffer *buffer_info;
+
+		tx_ring = adapter->tx_ring[n];
+		buffer_info = &tx_ring->tx_buffer_info[tx_ring->next_to_clean];
+
+		dev_info(&adapter->pdev->dev, "%5d %5X %5X %016llX %04X %p %016llX\n",
+			    n, tx_ring->next_to_use, tx_ring->next_to_clean,
+			    (u64)dma_unmap_addr(buffer_info, dma),
+			    dma_unmap_len(buffer_info, len),
+			    buffer_info->next_to_watch,
+			    (u64)buffer_info->time_stamp);
+	}
+
+	dev_info(&adapter->pdev->dev, "TX Rings Dump\n");
+
+	/* Transmit Descriptor Formats
+	 *
+	 * Advanced Transmit Descriptor
+	 *   +--------------------------------------------------------------+
+	 * 0 |         Buffer Address [63:0]                                |
+	 *   +--------------------------------------------------------------+
+	 * 8 | PAYLEN  | PORTS  |CC|IDX | STA | DCMD  |DTYP|MAC|RSV| DTALEN |
+	 *   +--------------------------------------------------------------+
+	 *   63      46 45    40 39 38 36 35 32 31   24             15       0
+	 */
+
+	for (n = 0; n < adapter->num_tx_queues; n++) {
+		tx_ring = adapter->tx_ring[n];
+		dev_info(&adapter->pdev->dev, "------------------------------------\n");
+		dev_info(&adapter->pdev->dev, "TX QUEUE INDEX = %d\n",
+			    tx_ring->queue_index);
+		dev_info(&adapter->pdev->dev, "------------------------------------\n");
+		dev_info(&adapter->pdev->dev, "T [desc]     [address 63:0  ] [PlPOCIStDDM Ln] [bi->dma       ] leng  ntw timestamp        bi->skb\n");
+
+		for (i = 0; tx_ring->desc && (i < tx_ring->count); i++) {
+			const char *next_desc;
+			struct igc_tx_buffer *buffer_info;
+
+			tx_desc = IGC_TX_DESC(tx_ring, i);
+			buffer_info = &tx_ring->tx_buffer_info[i];
+			u0 = (struct my_u0 *)tx_desc;
+			if (i == tx_ring->next_to_use &&
+			    i == tx_ring->next_to_clean)
+				next_desc = " NTC/U";
+			else if (i == tx_ring->next_to_use)
+				next_desc = " NTU";
+			else if (i == tx_ring->next_to_clean)
+				next_desc = " NTC";
+			else
+				next_desc = "";
+
+			dev_info(&adapter->pdev->dev, "T [0x%03X]    %016llX %016llX %016llX %04X  %p %016llX %p%s\n",
+				    i, le64_to_cpu(u0->a),
+				    le64_to_cpu(u0->b),
+				    (u64)dma_unmap_addr(buffer_info, dma),
+				    dma_unmap_len(buffer_info, len),
+				    buffer_info->next_to_watch,
+				    (u64)buffer_info->time_stamp,
+				    buffer_info->skb, next_desc);
+
+			if (buffer_info->skb)
+				print_hex_dump(KERN_INFO, "",
+					       DUMP_PREFIX_ADDRESS,
+					       16, 1, buffer_info->skb->data,
+					       dma_unmap_len(buffer_info, len),
+					       true);
+		}
+	}
+
+	/* Print RX Rings Summary */
+	dev_info(&adapter->pdev->dev, "RX Rings Summary\n");
+	dev_info(&adapter->pdev->dev, "Queue [NTU] [NTC]\n");
+	for (n = 0; n < adapter->num_rx_queues; n++) {
+		rx_ring = adapter->rx_ring[n];
+		dev_info(&adapter->pdev->dev, "%5d %5X %5X\n", n, rx_ring->next_to_use,
+			    rx_ring->next_to_clean);
+	}
+
+	dev_info(&adapter->pdev->dev, "RX Rings Dump\n");
+
+	/* Advanced Receive Descriptor (Read) Format
+	 *    63                                           1        0
+	 *    +-----------------------------------------------------+
+	 *  0 |       Packet Buffer Address [63:1]           |A0/NSE|
+	 *    +----------------------------------------------+------+
+	 *  8 |       Header Buffer Address [63:1]           |  DD  |
+	 *    +-----------------------------------------------------+
+	 *
+	 *
+	 * Advanced Receive Descriptor (Write-Back) Format
+	 *
+	 *   63       48 47    32 31  30      21 20 17 16   4 3     0
+	 *   +------------------------------------------------------+
+	 * 0 | Packet     IP     |SPH| HDR_LEN   | RSV|Packet|  RSS |
+	 *   | Checksum   Ident  |   |           |    | Type | Type |
+	 *   +------------------------------------------------------+
+	 * 8 | VLAN Tag | Length | Extended Error | Extended Status |
+	 *   +------------------------------------------------------+
+	 *   63       48 47    32 31            20 19               0
+	 */
+
+	for (n = 0; n < adapter->num_rx_queues; n++) {
+		rx_ring = adapter->rx_ring[n];
+		dev_info(&adapter->pdev->dev, "------------------------------------\n");
+		dev_info(&adapter->pdev->dev, "RX QUEUE INDEX = %d\n",
+			    rx_ring->queue_index);
+		dev_info(&adapter->pdev->dev, "------------------------------------\n");
+		dev_info(&adapter->pdev->dev, "R  [desc]      [ PktBuf     A0] [  HeadBuf   DD] [bi->dma       ] [bi->skb] <-- Adv Rx Read format\n");
+		dev_info(&adapter->pdev->dev, "RWB[desc]      [PcsmIpSHl PtRs] [vl er S cks ln] ---------------- [bi->skb] <-- Adv Rx Write-Back format\n");
+
+		for (i = 0; i < rx_ring->count; i++) {
+			const char *next_desc;
+			struct igc_rx_buffer *buffer_info;
+
+			buffer_info = &rx_ring->rx_buffer_info[i];
+			rx_desc = IGC_RX_DESC(rx_ring, i);
+			u0 = (struct my_u0 *)rx_desc;
+			staterr = le32_to_cpu(rx_desc->wb.upper.status_error);
+
+			if (i == rx_ring->next_to_use)
+				next_desc = " NTU";
+			else if (i == rx_ring->next_to_clean)
+				next_desc = " NTC";
+			else
+				next_desc = "";
+
+			if (staterr & IGC_RXD_STAT_DD) {
+				/* Descriptor Done */
+				dev_info(&adapter->pdev->dev, "%s[0x%03X]     %016llX %016llX ---------------- %s\n",
+					    "RWB", i,
+					    le64_to_cpu(u0->a),
+					    le64_to_cpu(u0->b),
+					    next_desc);
+			} else {
+				dev_info(&adapter->pdev->dev, "%s[0x%03X]     %016llX %016llX %016llX %s\n",
+					    "R  ", i,
+					    le64_to_cpu(u0->a),
+					    le64_to_cpu(u0->b),
+					    (u64)buffer_info->dma,
+					    next_desc);
+
+			}
+		}
+	}
+
+exit:
+	return;
+}
+
+/* igc_regs_dump - registers dump */
+void igc_regs_dump(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+	struct igc_reg_info *reginfo;
+
+	/* Print Registers */
+	dev_info(&adapter->pdev->dev, "Register Dump\n");
+	dev_info(&adapter->pdev->dev, "Register Name   Value\n");
+	for (reginfo = (struct igc_reg_info *)igc_reg_info_tbl;
+	     reginfo->name; reginfo++) {
+		igc_regdump(hw, reginfo);
+	}
+}
diff --git a/kernel/drivers/net/drivers/igc/igc_hw.h b/kernel/drivers/net/drivers/igc/igc_hw.h
new file mode 100644
index 000000000..40bcdd472
--- /dev/null
+++ b/kernel/drivers/net/drivers/igc/igc_hw.h
@@ -0,0 +1,299 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c)  2018 Intel Corporation */
+
+#ifndef _IGC_HW_H_
+#define _IGC_HW_H_
+
+#include <linux/types.h>
+#include <linux/if_ether.h>
+#include <linux/netdevice.h>
+#include <rtnet_port.h>
+
+#include "igc_regs.h"
+#include "igc_defines.h"
+#include "igc_mac.h"
+#include "igc_phy.h"
+#include "igc_nvm.h"
+#include "igc_i225.h"
+#include "igc_base.h"
+
+#define IGC_DEV_ID_I225_LM			0x15F2
+#define IGC_DEV_ID_I225_V			0x15F3
+#define IGC_DEV_ID_I225_I			0x15F8
+#define IGC_DEV_ID_I220_V			0x15F7
+#define IGC_DEV_ID_I225_K			0x3100
+#define IGC_DEV_ID_I225_K2			0x3101
+#define IGC_DEV_ID_I225_LMVP			0x5502
+#define IGC_DEV_ID_I225_IT			0x0D9F
+#define IGC_DEV_ID_I226_LM			0x125B
+#define IGC_DEV_ID_I226_V			0x125C
+#define IGC_DEV_ID_I226_IT			0x125D
+#define IGC_DEV_ID_I221_V			0x125E
+#define IGC_DEV_ID_I226_BLANK_NVM		0x125F
+#define IGC_DEV_ID_I225_BLANK_NVM		0x15FD
+
+/* Function pointers for the MAC. */
+struct igc_mac_operations {
+	s32 (*check_for_link)(struct igc_hw *hw);
+	s32 (*reset_hw)(struct igc_hw *hw);
+	s32 (*init_hw)(struct igc_hw *hw);
+	s32 (*setup_physical_interface)(struct igc_hw *hw);
+	void (*rar_set)(struct igc_hw *hw, u8 *address, u32 index);
+	s32 (*read_mac_addr)(struct igc_hw *hw);
+	s32 (*get_speed_and_duplex)(struct igc_hw *hw, u16 *speed,
+				    u16 *duplex);
+	s32 (*acquire_swfw_sync)(struct igc_hw *hw, u16 mask);
+	void (*release_swfw_sync)(struct igc_hw *hw, u16 mask);
+};
+
+enum igc_mac_type {
+	igc_undefined = 0,
+	igc_i225,
+	igc_num_macs  /* List is 1-based, so subtract 1 for true count. */
+};
+
+enum igc_phy_type {
+	igc_phy_unknown = 0,
+	igc_phy_none,
+	igc_phy_i225,
+};
+
+enum igc_media_type {
+	igc_media_type_unknown = 0,
+	igc_media_type_copper = 1,
+	igc_num_media_types
+};
+
+enum igc_nvm_type {
+	igc_nvm_unknown = 0,
+	igc_nvm_eeprom_spi,
+	igc_nvm_flash_hw,
+	igc_nvm_invm,
+};
+
+struct igc_info {
+	s32 (*get_invariants)(struct igc_hw *hw);
+	struct igc_mac_operations *mac_ops;
+	const struct igc_phy_operations *phy_ops;
+	struct igc_nvm_operations *nvm_ops;
+};
+
+extern const struct igc_info igc_base_info;
+
+struct igc_mac_info {
+	struct igc_mac_operations ops;
+
+	u8 addr[ETH_ALEN];
+	u8 perm_addr[ETH_ALEN];
+
+	enum igc_mac_type type;
+
+	u32 mc_filter_type;
+
+	u16 mta_reg_count;
+	u16 uta_reg_count;
+
+	u32 mta_shadow[MAX_MTA_REG];
+	u16 rar_entry_count;
+
+	u8 forced_speed_duplex;
+
+	bool asf_firmware_present;
+	bool arc_subsystem_valid;
+
+	bool autoneg;
+	bool autoneg_failed;
+	bool get_link_status;
+};
+
+struct igc_nvm_operations {
+	s32 (*acquire)(struct igc_hw *hw);
+	s32 (*read)(struct igc_hw *hw, u16 offset, u16 i, u16 *data);
+	void (*release)(struct igc_hw *hw);
+	s32 (*write)(struct igc_hw *hw, u16 offset, u16 i, u16 *data);
+	s32 (*update)(struct igc_hw *hw);
+	s32 (*validate)(struct igc_hw *hw);
+	s32 (*valid_led_default)(struct igc_hw *hw, u16 *data);
+};
+
+struct igc_phy_operations {
+	s32 (*acquire)(struct igc_hw *hw);
+	s32 (*check_reset_block)(struct igc_hw *hw);
+	s32 (*force_speed_duplex)(struct igc_hw *hw);
+	s32 (*get_phy_info)(struct igc_hw *hw);
+	s32 (*read_reg)(struct igc_hw *hw, u32 address, u16 *data);
+	void (*release)(struct igc_hw *hw);
+	s32 (*reset)(struct igc_hw *hw);
+	s32 (*write_reg)(struct igc_hw *hw, u32 address, u16 data);
+};
+
+struct igc_nvm_info {
+	struct igc_nvm_operations ops;
+	enum igc_nvm_type type;
+
+	u16 word_size;
+	u16 delay_usec;
+	u16 address_bits;
+	u16 opcode_bits;
+	u16 page_size;
+};
+
+struct igc_phy_info {
+	struct igc_phy_operations ops;
+
+	enum igc_phy_type type;
+
+	u32 addr;
+	u32 id;
+	u32 reset_delay_us; /* in usec */
+	u32 revision;
+
+	enum igc_media_type media_type;
+
+	u16 autoneg_advertised;
+	u16 autoneg_mask;
+
+	u8 mdix;
+
+	bool is_mdix;
+	bool speed_downgraded;
+	bool autoneg_wait_to_complete;
+};
+
+struct igc_bus_info {
+	u16 func;
+	u16 pci_cmd_word;
+};
+
+enum igc_fc_mode {
+	igc_fc_none = 0,
+	igc_fc_rx_pause,
+	igc_fc_tx_pause,
+	igc_fc_full,
+	igc_fc_default = 0xFF
+};
+
+struct igc_fc_info {
+	u32 high_water;     /* Flow control high-water mark */
+	u32 low_water;      /* Flow control low-water mark */
+	u16 pause_time;     /* Flow control pause timer */
+	bool send_xon;      /* Flow control send XON */
+	bool strict_ieee;   /* Strict IEEE mode */
+	enum igc_fc_mode current_mode; /* Type of flow control */
+	enum igc_fc_mode requested_mode;
+};
+
+struct igc_dev_spec_base {
+	bool clear_semaphore_once;
+	bool eee_enable;
+};
+
+struct igc_hw {
+	void *back;
+
+	u8 __iomem *hw_addr;
+	unsigned long io_base;
+
+	struct igc_mac_info  mac;
+	struct igc_fc_info   fc;
+	struct igc_nvm_info  nvm;
+	struct igc_phy_info  phy;
+
+	struct igc_bus_info bus;
+
+	union {
+		struct igc_dev_spec_base	_base;
+	} dev_spec;
+
+	u16 device_id;
+	u16 subsystem_vendor_id;
+	u16 subsystem_device_id;
+	u16 vendor_id;
+
+	u8 revision_id;
+};
+
+/* Statistics counters collected by the MAC */
+struct igc_hw_stats {
+	u64 crcerrs;
+	u64 algnerrc;
+	u64 symerrs;
+	u64 rxerrc;
+	u64 mpc;
+	u64 scc;
+	u64 ecol;
+	u64 mcc;
+	u64 latecol;
+	u64 colc;
+	u64 dc;
+	u64 tncrs;
+	u64 sec;
+	u64 cexterr;
+	u64 rlec;
+	u64 xonrxc;
+	u64 xontxc;
+	u64 xoffrxc;
+	u64 xofftxc;
+	u64 fcruc;
+	u64 prc64;
+	u64 prc127;
+	u64 prc255;
+	u64 prc511;
+	u64 prc1023;
+	u64 prc1522;
+	u64 tlpic;
+	u64 rlpic;
+	u64 gprc;
+	u64 bprc;
+	u64 mprc;
+	u64 gptc;
+	u64 gorc;
+	u64 gotc;
+	u64 rnbc;
+	u64 ruc;
+	u64 rfc;
+	u64 roc;
+	u64 rjc;
+	u64 mgprc;
+	u64 mgpdc;
+	u64 mgptc;
+	u64 tor;
+	u64 tot;
+	u64 tpr;
+	u64 tpt;
+	u64 ptc64;
+	u64 ptc127;
+	u64 ptc255;
+	u64 ptc511;
+	u64 ptc1023;
+	u64 ptc1522;
+	u64 mptc;
+	u64 bptc;
+	u64 tsctc;
+	u64 tsctfc;
+	u64 iac;
+	u64 htdpmc;
+	u64 rpthc;
+	u64 hgptc;
+	u64 hgorc;
+	u64 hgotc;
+	u64 lenerrs;
+	u64 scvpc;
+	u64 hrmpc;
+	u64 doosync;
+	u64 o2bgptc;
+	u64 o2bspc;
+	u64 b2ospc;
+	u64 b2ogprc;
+};
+
+struct rtnet_device *igc_get_hw_dev(struct igc_hw *hw);
+#define hw_dbg(format, arg...) \
+	rtdev_dbg(igc_get_hw_dev(hw), format, ##arg)
+
+s32  igc_read_pcie_cap_reg(struct igc_hw *hw, u32 reg, u16 *value);
+s32  igc_write_pcie_cap_reg(struct igc_hw *hw, u32 reg, u16 *value);
+void igc_read_pci_cfg(struct igc_hw *hw, u32 reg, u16 *value);
+void igc_write_pci_cfg(struct igc_hw *hw, u32 reg, u16 *value);
+
+#endif /* _IGC_HW_H_ */
diff --git a/kernel/drivers/net/drivers/igc/igc_i225.c b/kernel/drivers/net/drivers/igc/igc_i225.c
new file mode 100644
index 000000000..7ec04e488
--- /dev/null
+++ b/kernel/drivers/net/drivers/igc/igc_i225.c
@@ -0,0 +1,645 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c)  2018 Intel Corporation */
+
+#include <linux/delay.h>
+
+#include "igc_hw.h"
+
+/**
+ * igc_get_hw_semaphore_i225 - Acquire hardware semaphore
+ * @hw: pointer to the HW structure
+ *
+ * Acquire the necessary semaphores for exclusive access to the EEPROM.
+ * Set the EEPROM access request bit and wait for EEPROM access grant bit.
+ * Return successful if access grant bit set, else clear the request for
+ * EEPROM access and return -IGC_ERR_NVM (-1).
+ */
+static s32 igc_acquire_nvm_i225(struct igc_hw *hw)
+{
+	return igc_acquire_swfw_sync_i225(hw, IGC_SWFW_EEP_SM);
+}
+
+/**
+ * igc_release_nvm_i225 - Release exclusive access to EEPROM
+ * @hw: pointer to the HW structure
+ *
+ * Stop any current commands to the EEPROM and clear the EEPROM request bit,
+ * then release the semaphores acquired.
+ */
+static void igc_release_nvm_i225(struct igc_hw *hw)
+{
+	igc_release_swfw_sync_i225(hw, IGC_SWFW_EEP_SM);
+}
+
+/**
+ * igc_get_hw_semaphore_i225 - Acquire hardware semaphore
+ * @hw: pointer to the HW structure
+ *
+ * Acquire the HW semaphore to access the PHY or NVM
+ */
+static s32 igc_get_hw_semaphore_i225(struct igc_hw *hw)
+{
+	s32 timeout = hw->nvm.word_size + 1;
+	s32 i = 0;
+	u32 swsm;
+
+	/* Get the SW semaphore */
+	while (i < timeout) {
+		swsm = rd32(IGC_SWSM);
+		if (!(swsm & IGC_SWSM_SMBI))
+			break;
+
+		usleep_range(500, 600);
+		i++;
+	}
+
+	if (i == timeout) {
+		/* In rare circumstances, the SW semaphore may already be held
+		 * unintentionally. Clear the semaphore once before giving up.
+		 */
+		if (hw->dev_spec._base.clear_semaphore_once) {
+			hw->dev_spec._base.clear_semaphore_once = false;
+			igc_put_hw_semaphore(hw);
+			for (i = 0; i < timeout; i++) {
+				swsm = rd32(IGC_SWSM);
+				if (!(swsm & IGC_SWSM_SMBI))
+					break;
+
+				usleep_range(500, 600);
+			}
+		}
+
+		/* If we do not have the semaphore here, we have to give up. */
+		if (i == timeout) {
+			hw_dbg("Driver can't access device - SMBI bit is set.\n");
+			return -IGC_ERR_NVM;
+		}
+	}
+
+	/* Get the FW semaphore. */
+	for (i = 0; i < timeout; i++) {
+		swsm = rd32(IGC_SWSM);
+		wr32(IGC_SWSM, swsm | IGC_SWSM_SWESMBI);
+
+		/* Semaphore acquired if bit latched */
+		if (rd32(IGC_SWSM) & IGC_SWSM_SWESMBI)
+			break;
+
+		usleep_range(500, 600);
+	}
+
+	if (i == timeout) {
+		/* Release semaphores */
+		igc_put_hw_semaphore(hw);
+		hw_dbg("Driver can't access the NVM\n");
+		return -IGC_ERR_NVM;
+	}
+
+	return 0;
+}
+
+/**
+ * igc_acquire_swfw_sync_i225 - Acquire SW/FW semaphore
+ * @hw: pointer to the HW structure
+ * @mask: specifies which semaphore to acquire
+ *
+ * Acquire the SW/FW semaphore to access the PHY or NVM.  The mask
+ * will also specify which port we're acquiring the lock for.
+ */
+s32 igc_acquire_swfw_sync_i225(struct igc_hw *hw, u16 mask)
+{
+	s32 i = 0, timeout = 200;
+	u32 fwmask = mask << 16;
+	u32 swmask = mask;
+	s32 ret_val = 0;
+	u32 swfw_sync;
+
+	while (i < timeout) {
+		if (igc_get_hw_semaphore_i225(hw)) {
+			ret_val = -IGC_ERR_SWFW_SYNC;
+			goto out;
+		}
+
+		swfw_sync = rd32(IGC_SW_FW_SYNC);
+		if (!(swfw_sync & (fwmask | swmask)))
+			break;
+
+		/* Firmware currently using resource (fwmask) */
+		igc_put_hw_semaphore(hw);
+		mdelay(5);
+		i++;
+	}
+
+	if (i == timeout) {
+		hw_dbg("Driver can't access resource, SW_FW_SYNC timeout.\n");
+		ret_val = -IGC_ERR_SWFW_SYNC;
+		goto out;
+	}
+
+	swfw_sync |= swmask;
+	wr32(IGC_SW_FW_SYNC, swfw_sync);
+
+	igc_put_hw_semaphore(hw);
+out:
+	return ret_val;
+}
+
+/**
+ * igc_release_swfw_sync_i225 - Release SW/FW semaphore
+ * @hw: pointer to the HW structure
+ * @mask: specifies which semaphore to acquire
+ *
+ * Release the SW/FW semaphore used to access the PHY or NVM.  The mask
+ * will also specify which port we're releasing the lock for.
+ */
+void igc_release_swfw_sync_i225(struct igc_hw *hw, u16 mask)
+{
+	u32 swfw_sync;
+
+	while (igc_get_hw_semaphore_i225(hw))
+		; /* Empty */
+
+	swfw_sync = rd32(IGC_SW_FW_SYNC);
+	swfw_sync &= ~mask;
+	wr32(IGC_SW_FW_SYNC, swfw_sync);
+
+	igc_put_hw_semaphore(hw);
+}
+
+/**
+ * igc_read_nvm_srrd_i225 - Reads Shadow Ram using EERD register
+ * @hw: pointer to the HW structure
+ * @offset: offset of word in the Shadow Ram to read
+ * @words: number of words to read
+ * @data: word read from the Shadow Ram
+ *
+ * Reads a 16 bit word from the Shadow Ram using the EERD register.
+ * Uses necessary synchronization semaphores.
+ */
+static s32 igc_read_nvm_srrd_i225(struct igc_hw *hw, u16 offset, u16 words,
+				  u16 *data)
+{
+	s32 status = 0;
+	u16 i, count;
+
+	/* We cannot hold synchronization semaphores for too long,
+	 * because of forceful takeover procedure. However it is more efficient
+	 * to read in bursts than synchronizing access for each word.
+	 */
+	for (i = 0; i < words; i += IGC_EERD_EEWR_MAX_COUNT) {
+		count = (words - i) / IGC_EERD_EEWR_MAX_COUNT > 0 ?
+			IGC_EERD_EEWR_MAX_COUNT : (words - i);
+
+		status = hw->nvm.ops.acquire(hw);
+		if (status)
+			break;
+
+		status = igc_read_nvm_eerd(hw, offset, count, data + i);
+		hw->nvm.ops.release(hw);
+		if (status)
+			break;
+	}
+
+	return status;
+}
+
+/**
+ * igc_write_nvm_srwr - Write to Shadow Ram using EEWR
+ * @hw: pointer to the HW structure
+ * @offset: offset within the Shadow Ram to be written to
+ * @words: number of words to write
+ * @data: 16 bit word(s) to be written to the Shadow Ram
+ *
+ * Writes data to Shadow Ram at offset using EEWR register.
+ *
+ * If igc_update_nvm_checksum is not called after this function , the
+ * Shadow Ram will most likely contain an invalid checksum.
+ */
+static s32 igc_write_nvm_srwr(struct igc_hw *hw, u16 offset, u16 words,
+			      u16 *data)
+{
+	struct igc_nvm_info *nvm = &hw->nvm;
+	s32 ret_val = -IGC_ERR_NVM;
+	u32 attempts = 100000;
+	u32 i, k, eewr = 0;
+
+	/* A check for invalid values:  offset too large, too many words,
+	 * too many words for the offset, and not enough words.
+	 */
+	if (offset >= nvm->word_size || (words > (nvm->word_size - offset)) ||
+	    words == 0) {
+		hw_dbg("nvm parameter(s) out of bounds\n");
+		goto out;
+	}
+
+	for (i = 0; i < words; i++) {
+		eewr = ((offset + i) << IGC_NVM_RW_ADDR_SHIFT) |
+			(data[i] << IGC_NVM_RW_REG_DATA) |
+			IGC_NVM_RW_REG_START;
+
+		wr32(IGC_SRWR, eewr);
+
+		for (k = 0; k < attempts; k++) {
+			if (IGC_NVM_RW_REG_DONE &
+			    rd32(IGC_SRWR)) {
+				ret_val = 0;
+				break;
+			}
+			udelay(5);
+		}
+
+		if (ret_val) {
+			hw_dbg("Shadow RAM write EEWR timed out\n");
+			break;
+		}
+	}
+
+out:
+	return ret_val;
+}
+
+/**
+ * igc_write_nvm_srwr_i225 - Write to Shadow RAM using EEWR
+ * @hw: pointer to the HW structure
+ * @offset: offset within the Shadow RAM to be written to
+ * @words: number of words to write
+ * @data: 16 bit word(s) to be written to the Shadow RAM
+ *
+ * Writes data to Shadow RAM at offset using EEWR register.
+ *
+ * If igc_update_nvm_checksum is not called after this function , the
+ * data will not be committed to FLASH and also Shadow RAM will most likely
+ * contain an invalid checksum.
+ *
+ * If error code is returned, data and Shadow RAM may be inconsistent - buffer
+ * partially written.
+ */
+static s32 igc_write_nvm_srwr_i225(struct igc_hw *hw, u16 offset, u16 words,
+				   u16 *data)
+{
+	s32 status = 0;
+	u16 i, count;
+
+	/* We cannot hold synchronization semaphores for too long,
+	 * because of forceful takeover procedure. However it is more efficient
+	 * to write in bursts than synchronizing access for each word.
+	 */
+	for (i = 0; i < words; i += IGC_EERD_EEWR_MAX_COUNT) {
+		count = (words - i) / IGC_EERD_EEWR_MAX_COUNT > 0 ?
+			IGC_EERD_EEWR_MAX_COUNT : (words - i);
+
+		status = hw->nvm.ops.acquire(hw);
+		if (status)
+			break;
+
+		status = igc_write_nvm_srwr(hw, offset, count, data + i);
+		hw->nvm.ops.release(hw);
+		if (status)
+			break;
+	}
+
+	return status;
+}
+
+/**
+ * igc_validate_nvm_checksum_i225 - Validate EEPROM checksum
+ * @hw: pointer to the HW structure
+ *
+ * Calculates the EEPROM checksum by reading/adding each word of the EEPROM
+ * and then verifies that the sum of the EEPROM is equal to 0xBABA.
+ */
+static s32 igc_validate_nvm_checksum_i225(struct igc_hw *hw)
+{
+	s32 (*read_op_ptr)(struct igc_hw *hw, u16 offset, u16 count,
+			   u16 *data);
+	s32 status = 0;
+
+	status = hw->nvm.ops.acquire(hw);
+	if (status)
+		goto out;
+
+	/* Replace the read function with semaphore grabbing with
+	 * the one that skips this for a while.
+	 * We have semaphore taken already here.
+	 */
+	read_op_ptr = hw->nvm.ops.read;
+	hw->nvm.ops.read = igc_read_nvm_eerd;
+
+	status = igc_validate_nvm_checksum(hw);
+
+	/* Revert original read operation. */
+	hw->nvm.ops.read = read_op_ptr;
+
+	hw->nvm.ops.release(hw);
+
+out:
+	return status;
+}
+
+/**
+ * igc_pool_flash_update_done_i225 - Pool FLUDONE status
+ * @hw: pointer to the HW structure
+ */
+static s32 igc_pool_flash_update_done_i225(struct igc_hw *hw)
+{
+	s32 ret_val = -IGC_ERR_NVM;
+	u32 i, reg;
+
+	for (i = 0; i < IGC_FLUDONE_ATTEMPTS; i++) {
+		reg = rd32(IGC_EECD);
+		if (reg & IGC_EECD_FLUDONE_I225) {
+			ret_val = 0;
+			break;
+		}
+		udelay(5);
+	}
+
+	return ret_val;
+}
+
+/**
+ * igc_update_flash_i225 - Commit EEPROM to the flash
+ * @hw: pointer to the HW structure
+ */
+static s32 igc_update_flash_i225(struct igc_hw *hw)
+{
+	s32 ret_val = 0;
+	u32 flup;
+
+	ret_val = igc_pool_flash_update_done_i225(hw);
+	if (ret_val == -IGC_ERR_NVM) {
+		hw_dbg("Flash update time out\n");
+		goto out;
+	}
+
+	flup = rd32(IGC_EECD) | IGC_EECD_FLUPD_I225;
+	wr32(IGC_EECD, flup);
+
+	ret_val = igc_pool_flash_update_done_i225(hw);
+	if (ret_val)
+		hw_dbg("Flash update time out\n");
+	else
+		hw_dbg("Flash update complete\n");
+
+out:
+	return ret_val;
+}
+
+/**
+ * igc_update_nvm_checksum_i225 - Update EEPROM checksum
+ * @hw: pointer to the HW structure
+ *
+ * Updates the EEPROM checksum by reading/adding each word of the EEPROM
+ * up to the checksum.  Then calculates the EEPROM checksum and writes the
+ * value to the EEPROM. Next commit EEPROM data onto the Flash.
+ */
+static s32 igc_update_nvm_checksum_i225(struct igc_hw *hw)
+{
+	u16 checksum = 0;
+	s32 ret_val = 0;
+	u16 i, nvm_data;
+
+	/* Read the first word from the EEPROM. If this times out or fails, do
+	 * not continue or we could be in for a very long wait while every
+	 * EEPROM read fails
+	 */
+	ret_val = igc_read_nvm_eerd(hw, 0, 1, &nvm_data);
+	if (ret_val) {
+		hw_dbg("EEPROM read failed\n");
+		goto out;
+	}
+
+	ret_val = hw->nvm.ops.acquire(hw);
+	if (ret_val)
+		goto out;
+
+	/* Do not use hw->nvm.ops.write, hw->nvm.ops.read
+	 * because we do not want to take the synchronization
+	 * semaphores twice here.
+	 */
+
+	for (i = 0; i < NVM_CHECKSUM_REG; i++) {
+		ret_val = igc_read_nvm_eerd(hw, i, 1, &nvm_data);
+		if (ret_val) {
+			hw->nvm.ops.release(hw);
+			hw_dbg("NVM Read Error while updating checksum.\n");
+			goto out;
+		}
+		checksum += nvm_data;
+	}
+	checksum = (u16)NVM_SUM - checksum;
+	ret_val = igc_write_nvm_srwr(hw, NVM_CHECKSUM_REG, 1,
+				     &checksum);
+	if (ret_val) {
+		hw->nvm.ops.release(hw);
+		hw_dbg("NVM Write Error while updating checksum.\n");
+		goto out;
+	}
+
+	hw->nvm.ops.release(hw);
+
+	ret_val = igc_update_flash_i225(hw);
+
+out:
+	return ret_val;
+}
+
+/**
+ * igc_get_flash_presence_i225 - Check if flash device is detected
+ * @hw: pointer to the HW structure
+ */
+bool igc_get_flash_presence_i225(struct igc_hw *hw)
+{
+	bool ret_val = false;
+	u32 eec = 0;
+
+	eec = rd32(IGC_EECD);
+	if (eec & IGC_EECD_FLASH_DETECTED_I225)
+		ret_val = true;
+
+	return ret_val;
+}
+
+/**
+ * igc_init_nvm_params_i225 - Init NVM func ptrs.
+ * @hw: pointer to the HW structure
+ */
+s32 igc_init_nvm_params_i225(struct igc_hw *hw)
+{
+	struct igc_nvm_info *nvm = &hw->nvm;
+
+	nvm->ops.acquire = igc_acquire_nvm_i225;
+	nvm->ops.release = igc_release_nvm_i225;
+
+	/* NVM Function Pointers */
+	if (igc_get_flash_presence_i225(hw)) {
+		hw->nvm.type = igc_nvm_flash_hw;
+		nvm->ops.read = igc_read_nvm_srrd_i225;
+		nvm->ops.write = igc_write_nvm_srwr_i225;
+		nvm->ops.validate = igc_validate_nvm_checksum_i225;
+		nvm->ops.update = igc_update_nvm_checksum_i225;
+	} else {
+		hw->nvm.type = igc_nvm_invm;
+		nvm->ops.read = igc_read_nvm_eerd;
+		nvm->ops.write = NULL;
+		nvm->ops.validate = NULL;
+		nvm->ops.update = NULL;
+	}
+	return 0;
+}
+
+/**
+ *  igc_set_eee_i225 - Enable/disable EEE support
+ *  @hw: pointer to the HW structure
+ *  @adv2p5G: boolean flag enabling 2.5G EEE advertisement
+ *  @adv1G: boolean flag enabling 1G EEE advertisement
+ *  @adv100M: boolean flag enabling 100M EEE advertisement
+ *
+ *  Enable/disable EEE based on setting in dev_spec structure.
+ **/
+s32 igc_set_eee_i225(struct igc_hw *hw, bool adv2p5G, bool adv1G,
+		     bool adv100M)
+{
+	u32 ipcnfg, eeer;
+
+	ipcnfg = rd32(IGC_IPCNFG);
+	eeer = rd32(IGC_EEER);
+
+	/* enable or disable per user setting */
+	if (hw->dev_spec._base.eee_enable) {
+		u32 eee_su = rd32(IGC_EEE_SU);
+
+		if (adv100M)
+			ipcnfg |= IGC_IPCNFG_EEE_100M_AN;
+		else
+			ipcnfg &= ~IGC_IPCNFG_EEE_100M_AN;
+
+		if (adv1G)
+			ipcnfg |= IGC_IPCNFG_EEE_1G_AN;
+		else
+			ipcnfg &= ~IGC_IPCNFG_EEE_1G_AN;
+
+		if (adv2p5G)
+			ipcnfg |= IGC_IPCNFG_EEE_2_5G_AN;
+		else
+			ipcnfg &= ~IGC_IPCNFG_EEE_2_5G_AN;
+
+		eeer |= (IGC_EEER_TX_LPI_EN | IGC_EEER_RX_LPI_EN |
+			 IGC_EEER_LPI_FC);
+
+		/* This bit should not be set in normal operation. */
+		if (eee_su & IGC_EEE_SU_LPI_CLK_STP)
+			hw_dbg("LPI Clock Stop Bit should not be set!\n");
+	} else {
+		ipcnfg &= ~(IGC_IPCNFG_EEE_2_5G_AN | IGC_IPCNFG_EEE_1G_AN |
+			    IGC_IPCNFG_EEE_100M_AN);
+		eeer &= ~(IGC_EEER_TX_LPI_EN | IGC_EEER_RX_LPI_EN |
+			  IGC_EEER_LPI_FC);
+	}
+	wr32(IGC_IPCNFG, ipcnfg);
+	wr32(IGC_EEER, eeer);
+	rd32(IGC_IPCNFG);
+	rd32(IGC_EEER);
+
+	return IGC_SUCCESS;
+}
+
+/* igc_set_ltr_i225 - Set Latency Tolerance Reporting thresholds
+ * @hw: pointer to the HW structure
+ * @link: bool indicating link status
+ *
+ * Set the LTR thresholds based on the link speed (Mbps), EEE, and DMAC
+ * settings, otherwise specify that there is no LTR requirement.
+ */
+s32 igc_set_ltr_i225(struct igc_hw *hw, bool link)
+{
+	u32 tw_system, ltrc, ltrv, ltr_min, ltr_max, scale_min, scale_max;
+	u16 speed, duplex;
+	s32 size;
+
+	/* If we do not have link, LTR thresholds are zero. */
+	if (link) {
+		hw->mac.ops.get_speed_and_duplex(hw, &speed, &duplex);
+
+		/* Check if using copper interface with EEE enabled or if the
+		 * link speed is 10 Mbps.
+		 */
+		if (hw->dev_spec._base.eee_enable &&
+		    speed != SPEED_10) {
+			/* EEE enabled, so send LTRMAX threshold. */
+			ltrc = rd32(IGC_LTRC) |
+			       IGC_LTRC_EEEMS_EN;
+			wr32(IGC_LTRC, ltrc);
+
+			/* Calculate tw_system (nsec). */
+			if (speed == SPEED_100) {
+				tw_system = ((rd32(IGC_EEE_SU) &
+					     IGC_TW_SYSTEM_100_MASK) >>
+					     IGC_TW_SYSTEM_100_SHIFT) * 500;
+			} else {
+				tw_system = (rd32(IGC_EEE_SU) &
+					     IGC_TW_SYSTEM_1000_MASK) * 500;
+			}
+		} else {
+			tw_system = 0;
+		}
+
+		/* Get the Rx packet buffer size. */
+		size = rd32(IGC_RXPBS) &
+		       IGC_RXPBS_SIZE_I225_MASK;
+
+		/* Calculations vary based on DMAC settings. */
+		if (rd32(IGC_DMACR) & IGC_DMACR_DMAC_EN) {
+			size -= (rd32(IGC_DMACR) &
+				 IGC_DMACR_DMACTHR_MASK) >>
+				 IGC_DMACR_DMACTHR_SHIFT;
+			/* Convert size to bits. */
+			size *= 1024 * 8;
+		} else {
+			/* Convert size to bytes, subtract the MTU, and then
+			 * convert the size to bits.
+			 */
+			size *= 1024;
+			size *= 8;
+		}
+
+		if (size < 0) {
+			hw_dbg("Invalid effective Rx buffer size %d\n",
+			       size);
+			return -IGC_ERR_CONFIG;
+		}
+
+		/* Calculate the thresholds. Since speed is in Mbps, simplify
+		 * the calculation by multiplying size/speed by 1000 for result
+		 * to be in nsec before dividing by the scale in nsec. Set the
+		 * scale such that the LTR threshold fits in the register.
+		 */
+		ltr_min = (1000 * size) / speed;
+		ltr_max = ltr_min + tw_system;
+		scale_min = (ltr_min / 1024) < 1024 ? IGC_LTRMINV_SCALE_1024 :
+			    IGC_LTRMINV_SCALE_32768;
+		scale_max = (ltr_max / 1024) < 1024 ? IGC_LTRMAXV_SCALE_1024 :
+			    IGC_LTRMAXV_SCALE_32768;
+		ltr_min /= scale_min == IGC_LTRMINV_SCALE_1024 ? 1024 : 32768;
+		ltr_min -= 1;
+		ltr_max /= scale_max == IGC_LTRMAXV_SCALE_1024 ? 1024 : 32768;
+		ltr_max -= 1;
+
+		/* Only write the LTR thresholds if they differ from before. */
+		ltrv = rd32(IGC_LTRMINV);
+		if (ltr_min != (ltrv & IGC_LTRMINV_LTRV_MASK)) {
+			ltrv = IGC_LTRMINV_LSNP_REQ | ltr_min |
+			       (scale_min << IGC_LTRMINV_SCALE_SHIFT);
+			wr32(IGC_LTRMINV, ltrv);
+		}
+
+		ltrv = rd32(IGC_LTRMAXV);
+		if (ltr_max != (ltrv & IGC_LTRMAXV_LTRV_MASK)) {
+			ltrv = IGC_LTRMAXV_LSNP_REQ | ltr_max |
+			       (scale_min << IGC_LTRMAXV_SCALE_SHIFT);
+			wr32(IGC_LTRMAXV, ltrv);
+		}
+	}
+
+	return IGC_SUCCESS;
+}
diff --git a/kernel/drivers/net/drivers/igc/igc_i225.h b/kernel/drivers/net/drivers/igc/igc_i225.h
new file mode 100644
index 000000000..dae47e4f1
--- /dev/null
+++ b/kernel/drivers/net/drivers/igc/igc_i225.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c)  2018 Intel Corporation */
+
+#ifndef _IGC_I225_H_
+#define _IGC_I225_H_
+
+s32 igc_acquire_swfw_sync_i225(struct igc_hw *hw, u16 mask);
+void igc_release_swfw_sync_i225(struct igc_hw *hw, u16 mask);
+
+s32 igc_init_nvm_params_i225(struct igc_hw *hw);
+bool igc_get_flash_presence_i225(struct igc_hw *hw);
+s32 igc_set_eee_i225(struct igc_hw *hw, bool adv2p5G, bool adv1G,
+		     bool adv100M);
+s32 igc_set_ltr_i225(struct igc_hw *hw, bool link);
+
+#endif
diff --git a/kernel/drivers/net/drivers/igc/igc_mac.c b/kernel/drivers/net/drivers/igc/igc_mac.c
new file mode 100644
index 000000000..a5c4b19d7
--- /dev/null
+++ b/kernel/drivers/net/drivers/igc/igc_mac.c
@@ -0,0 +1,881 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c)  2018 Intel Corporation */
+
+#include <linux/pci.h>
+#include <linux/delay.h>
+
+#include "igc_mac.h"
+#include "igc_hw.h"
+
+/**
+ * igc_disable_pcie_master - Disables PCI-express master access
+ * @hw: pointer to the HW structure
+ *
+ * Returns 0 (0) if successful, else returns -10
+ * (-IGC_ERR_MASTER_REQUESTS_PENDING) if master disable bit has not caused
+ * the master requests to be disabled.
+ *
+ * Disables PCI-Express master access and verifies there are no pending
+ * requests.
+ */
+s32 igc_disable_pcie_master(struct igc_hw *hw)
+{
+	s32 timeout = MASTER_DISABLE_TIMEOUT;
+	s32 ret_val = 0;
+	u32 ctrl;
+
+	ctrl = rd32(IGC_CTRL);
+	ctrl |= IGC_CTRL_GIO_MASTER_DISABLE;
+	wr32(IGC_CTRL, ctrl);
+
+	while (timeout) {
+		if (!(rd32(IGC_STATUS) &
+		    IGC_STATUS_GIO_MASTER_ENABLE))
+			break;
+		usleep_range(2000, 3000);
+		timeout--;
+	}
+
+	if (!timeout) {
+		hw_dbg("Master requests are pending.\n");
+		ret_val = -IGC_ERR_MASTER_REQUESTS_PENDING;
+		goto out;
+	}
+
+out:
+	return ret_val;
+}
+
+/**
+ * igc_init_rx_addrs - Initialize receive addresses
+ * @hw: pointer to the HW structure
+ * @rar_count: receive address registers
+ *
+ * Setup the receive address registers by setting the base receive address
+ * register to the devices MAC address and clearing all the other receive
+ * address registers to 0.
+ */
+void igc_init_rx_addrs(struct igc_hw *hw, u16 rar_count)
+{
+	u8 mac_addr[ETH_ALEN] = {0};
+	u32 i;
+
+	/* Setup the receive address */
+	hw_dbg("Programming MAC Address into RAR[0]\n");
+
+	hw->mac.ops.rar_set(hw, hw->mac.addr, 0);
+
+	/* Zero out the other (rar_entry_count - 1) receive addresses */
+	hw_dbg("Clearing RAR[1-%u]\n", rar_count - 1);
+	for (i = 1; i < rar_count; i++)
+		hw->mac.ops.rar_set(hw, mac_addr, i);
+}
+
+/**
+ * igc_set_fc_watermarks - Set flow control high/low watermarks
+ * @hw: pointer to the HW structure
+ *
+ * Sets the flow control high/low threshold (watermark) registers.  If
+ * flow control XON frame transmission is enabled, then set XON frame
+ * transmission as well.
+ */
+static s32 igc_set_fc_watermarks(struct igc_hw *hw)
+{
+	u32 fcrtl = 0, fcrth = 0;
+
+	/* Set the flow control receive threshold registers.  Normally,
+	 * these registers will be set to a default threshold that may be
+	 * adjusted later by the driver's runtime code.  However, if the
+	 * ability to transmit pause frames is not enabled, then these
+	 * registers will be set to 0.
+	 */
+	if (hw->fc.current_mode & igc_fc_tx_pause) {
+		/* We need to set up the Receive Threshold high and low water
+		 * marks as well as (optionally) enabling the transmission of
+		 * XON frames.
+		 */
+		fcrtl = hw->fc.low_water;
+		if (hw->fc.send_xon)
+			fcrtl |= IGC_FCRTL_XONE;
+
+		fcrth = hw->fc.high_water;
+	}
+	wr32(IGC_FCRTL, fcrtl);
+	wr32(IGC_FCRTH, fcrth);
+
+	return 0;
+}
+
+/**
+ * igc_setup_link - Setup flow control and link settings
+ * @hw: pointer to the HW structure
+ *
+ * Determines which flow control settings to use, then configures flow
+ * control.  Calls the appropriate media-specific link configuration
+ * function.  Assuming the adapter has a valid link partner, a valid link
+ * should be established.  Assumes the hardware has previously been reset
+ * and the transmitter and receiver are not enabled.
+ */
+s32 igc_setup_link(struct igc_hw *hw)
+{
+	s32 ret_val = 0;
+
+	/* In the case of the phy reset being blocked, we already have a link.
+	 * We do not need to set it up again.
+	 */
+	if (igc_check_reset_block(hw))
+		goto out;
+
+	/* If requested flow control is set to default, set flow control
+	 * to the both 'rx' and 'tx' pause frames.
+	 */
+	if (hw->fc.requested_mode == igc_fc_default)
+		hw->fc.requested_mode = igc_fc_full;
+
+	/* We want to save off the original Flow Control configuration just
+	 * in case we get disconnected and then reconnected into a different
+	 * hub or switch with different Flow Control capabilities.
+	 */
+	hw->fc.current_mode = hw->fc.requested_mode;
+
+	hw_dbg("After fix-ups FlowControl is now = %x\n", hw->fc.current_mode);
+
+	/* Call the necessary media_type subroutine to configure the link. */
+	ret_val = hw->mac.ops.setup_physical_interface(hw);
+	if (ret_val)
+		goto out;
+
+	/* Initialize the flow control address, type, and PAUSE timer
+	 * registers to their default values.  This is done even if flow
+	 * control is disabled, because it does not hurt anything to
+	 * initialize these registers.
+	 */
+	hw_dbg("Initializing the Flow Control address, type and timer regs\n");
+	wr32(IGC_FCT, FLOW_CONTROL_TYPE);
+	wr32(IGC_FCAH, FLOW_CONTROL_ADDRESS_HIGH);
+	wr32(IGC_FCAL, FLOW_CONTROL_ADDRESS_LOW);
+
+	wr32(IGC_FCTTV, hw->fc.pause_time);
+
+	ret_val = igc_set_fc_watermarks(hw);
+
+out:
+	return ret_val;
+}
+
+/**
+ * igc_force_mac_fc - Force the MAC's flow control settings
+ * @hw: pointer to the HW structure
+ *
+ * Force the MAC's flow control settings.  Sets the TFCE and RFCE bits in the
+ * device control register to reflect the adapter settings.  TFCE and RFCE
+ * need to be explicitly set by software when a copper PHY is used because
+ * autonegotiation is managed by the PHY rather than the MAC.  Software must
+ * also configure these bits when link is forced on a fiber connection.
+ */
+s32 igc_force_mac_fc(struct igc_hw *hw)
+{
+	s32 ret_val = 0;
+	u32 ctrl;
+
+	ctrl = rd32(IGC_CTRL);
+
+	/* Because we didn't get link via the internal auto-negotiation
+	 * mechanism (we either forced link or we got link via PHY
+	 * auto-neg), we have to manually enable/disable transmit an
+	 * receive flow control.
+	 *
+	 * The "Case" statement below enables/disable flow control
+	 * according to the "hw->fc.current_mode" parameter.
+	 *
+	 * The possible values of the "fc" parameter are:
+	 *      0:  Flow control is completely disabled
+	 *      1:  Rx flow control is enabled (we can receive pause
+	 *          frames but not send pause frames).
+	 *      2:  Tx flow control is enabled (we can send pause frames
+	 *          but we do not receive pause frames).
+	 *      3:  Both Rx and TX flow control (symmetric) is enabled.
+	 *  other:  No other values should be possible at this point.
+	 */
+	hw_dbg("hw->fc.current_mode = %u\n", hw->fc.current_mode);
+
+	switch (hw->fc.current_mode) {
+	case igc_fc_none:
+		ctrl &= (~(IGC_CTRL_TFCE | IGC_CTRL_RFCE));
+		break;
+	case igc_fc_rx_pause:
+		ctrl &= (~IGC_CTRL_TFCE);
+		ctrl |= IGC_CTRL_RFCE;
+		break;
+	case igc_fc_tx_pause:
+		ctrl &= (~IGC_CTRL_RFCE);
+		ctrl |= IGC_CTRL_TFCE;
+		break;
+	case igc_fc_full:
+		ctrl |= (IGC_CTRL_TFCE | IGC_CTRL_RFCE);
+		break;
+	default:
+		hw_dbg("Flow control param set incorrectly\n");
+		ret_val = -IGC_ERR_CONFIG;
+		goto out;
+	}
+
+	wr32(IGC_CTRL, ctrl);
+
+out:
+	return ret_val;
+}
+
+/**
+ * igc_clear_hw_cntrs_base - Clear base hardware counters
+ * @hw: pointer to the HW structure
+ *
+ * Clears the base hardware counters by reading the counter registers.
+ */
+void igc_clear_hw_cntrs_base(struct igc_hw *hw)
+{
+	rd32(IGC_CRCERRS);
+	rd32(IGC_MPC);
+	rd32(IGC_SCC);
+	rd32(IGC_ECOL);
+	rd32(IGC_MCC);
+	rd32(IGC_LATECOL);
+	rd32(IGC_COLC);
+	rd32(IGC_RERC);
+	rd32(IGC_DC);
+	rd32(IGC_RLEC);
+	rd32(IGC_XONRXC);
+	rd32(IGC_XONTXC);
+	rd32(IGC_XOFFRXC);
+	rd32(IGC_XOFFTXC);
+	rd32(IGC_FCRUC);
+	rd32(IGC_GPRC);
+	rd32(IGC_BPRC);
+	rd32(IGC_MPRC);
+	rd32(IGC_GPTC);
+	rd32(IGC_GORCL);
+	rd32(IGC_GORCH);
+	rd32(IGC_GOTCL);
+	rd32(IGC_GOTCH);
+	rd32(IGC_RNBC);
+	rd32(IGC_RUC);
+	rd32(IGC_RFC);
+	rd32(IGC_ROC);
+	rd32(IGC_RJC);
+	rd32(IGC_TORL);
+	rd32(IGC_TORH);
+	rd32(IGC_TOTL);
+	rd32(IGC_TOTH);
+	rd32(IGC_TPR);
+	rd32(IGC_TPT);
+	rd32(IGC_MPTC);
+	rd32(IGC_BPTC);
+
+	rd32(IGC_PRC64);
+	rd32(IGC_PRC127);
+	rd32(IGC_PRC255);
+	rd32(IGC_PRC511);
+	rd32(IGC_PRC1023);
+	rd32(IGC_PRC1522);
+	rd32(IGC_PTC64);
+	rd32(IGC_PTC127);
+	rd32(IGC_PTC255);
+	rd32(IGC_PTC511);
+	rd32(IGC_PTC1023);
+	rd32(IGC_PTC1522);
+
+	rd32(IGC_ALGNERRC);
+	rd32(IGC_RXERRC);
+	rd32(IGC_TNCRS);
+	rd32(IGC_HTDPMC);
+	rd32(IGC_TSCTC);
+
+	rd32(IGC_MGTPRC);
+	rd32(IGC_MGTPDC);
+	rd32(IGC_MGTPTC);
+
+	rd32(IGC_IAC);
+
+	rd32(IGC_RPTHC);
+	rd32(IGC_TLPIC);
+	rd32(IGC_RLPIC);
+	rd32(IGC_HGPTC);
+	rd32(IGC_RXDMTC);
+	rd32(IGC_HGORCL);
+	rd32(IGC_HGORCH);
+	rd32(IGC_HGOTCL);
+	rd32(IGC_HGOTCH);
+	rd32(IGC_LENERRS);
+}
+
+/**
+ * igc_rar_set - Set receive address register
+ * @hw: pointer to the HW structure
+ * @addr: pointer to the receive address
+ * @index: receive address array register
+ *
+ * Sets the receive address array register at index to the address passed
+ * in by addr.
+ */
+void igc_rar_set(struct igc_hw *hw, u8 *addr, u32 index)
+{
+	u32 rar_low, rar_high;
+
+	/* HW expects these in little endian so we reverse the byte order
+	 * from network order (big endian) to little endian
+	 */
+	rar_low = ((u32)addr[0] |
+		   ((u32)addr[1] << 8) |
+		   ((u32)addr[2] << 16) | ((u32)addr[3] << 24));
+
+	rar_high = ((u32)addr[4] | ((u32)addr[5] << 8));
+
+	/* If MAC address zero, no need to set the AV bit */
+	if (rar_low || rar_high)
+		rar_high |= IGC_RAH_AV;
+
+	/* Some bridges will combine consecutive 32-bit writes into
+	 * a single burst write, which will malfunction on some parts.
+	 * The flushes avoid this.
+	 */
+	wr32(IGC_RAL(index), rar_low);
+	wrfl();
+	wr32(IGC_RAH(index), rar_high);
+	wrfl();
+}
+
+/**
+ * igc_check_for_copper_link - Check for link (Copper)
+ * @hw: pointer to the HW structure
+ *
+ * Checks to see of the link status of the hardware has changed.  If a
+ * change in link status has been detected, then we read the PHY registers
+ * to get the current speed/duplex if link exists.
+ */
+s32 igc_check_for_copper_link(struct igc_hw *hw)
+{
+	struct igc_mac_info *mac = &hw->mac;
+	bool link = false;
+	s32 ret_val;
+
+	/* We only want to go out to the PHY registers to see if Auto-Neg
+	 * has completed and/or if our link status has changed.  The
+	 * get_link_status flag is set upon receiving a Link Status
+	 * Change or Rx Sequence Error interrupt.
+	 */
+	if (!mac->get_link_status) {
+		ret_val = 0;
+		goto out;
+	}
+
+	/* First we want to see if the MII Status Register reports
+	 * link.  If so, then we want to get the current speed/duplex
+	 * of the PHY.
+	 */
+	ret_val = igc_phy_has_link(hw, 1, 0, &link);
+	if (ret_val)
+		goto out;
+
+	if (!link)
+		goto out; /* No link detected */
+
+	mac->get_link_status = false;
+
+	/* Check if there was DownShift, must be checked
+	 * immediately after link-up
+	 */
+	igc_check_downshift(hw);
+
+	/* If we are forcing speed/duplex, then we simply return since
+	 * we have already determined whether we have link or not.
+	 */
+	if (!mac->autoneg) {
+		ret_val = -IGC_ERR_CONFIG;
+		goto out;
+	}
+
+	/* Auto-Neg is enabled.  Auto Speed Detection takes care
+	 * of MAC speed/duplex configuration.  So we only need to
+	 * configure Collision Distance in the MAC.
+	 */
+	igc_config_collision_dist(hw);
+
+	/* Configure Flow Control now that Auto-Neg has completed.
+	 * First, we need to restore the desired flow control
+	 * settings because we may have had to re-autoneg with a
+	 * different link partner.
+	 */
+	ret_val = igc_config_fc_after_link_up(hw);
+	if (ret_val)
+		hw_dbg("Error configuring flow control\n");
+
+out:
+	/* Now that we are aware of our link settings, we can set the LTR
+	 * thresholds.
+	 */
+	ret_val = igc_set_ltr_i225(hw, link);
+
+	return ret_val;
+}
+
+/**
+ * igc_config_collision_dist - Configure collision distance
+ * @hw: pointer to the HW structure
+ *
+ * Configures the collision distance to the default value and is used
+ * during link setup. Currently no func pointer exists and all
+ * implementations are handled in the generic version of this function.
+ */
+void igc_config_collision_dist(struct igc_hw *hw)
+{
+	u32 tctl;
+
+	tctl = rd32(IGC_TCTL);
+
+	tctl &= ~IGC_TCTL_COLD;
+	tctl |= IGC_COLLISION_DISTANCE << IGC_COLD_SHIFT;
+
+	wr32(IGC_TCTL, tctl);
+	wrfl();
+}
+
+/**
+ * igc_config_fc_after_link_up - Configures flow control after link
+ * @hw: pointer to the HW structure
+ *
+ * Checks the status of auto-negotiation after link up to ensure that the
+ * speed and duplex were not forced.  If the link needed to be forced, then
+ * flow control needs to be forced also.  If auto-negotiation is enabled
+ * and did not fail, then we configure flow control based on our link
+ * partner.
+ */
+s32 igc_config_fc_after_link_up(struct igc_hw *hw)
+{
+	u16 mii_status_reg, mii_nway_adv_reg, mii_nway_lp_ability_reg;
+	struct igc_mac_info *mac = &hw->mac;
+	u16 speed, duplex;
+	s32 ret_val = 0;
+
+	/* Check for the case where we have fiber media and auto-neg failed
+	 * so we had to force link.  In this case, we need to force the
+	 * configuration of the MAC to match the "fc" parameter.
+	 */
+	if (mac->autoneg_failed)
+		ret_val = igc_force_mac_fc(hw);
+
+	if (ret_val) {
+		hw_dbg("Error forcing flow control settings\n");
+		goto out;
+	}
+
+	/* Check for the case where we have copper media and auto-neg is
+	 * enabled.  In this case, we need to check and see if Auto-Neg
+	 * has completed, and if so, how the PHY and link partner has
+	 * flow control configured.
+	 */
+	if (mac->autoneg) {
+		/* Read the MII Status Register and check to see if AutoNeg
+		 * has completed.  We read this twice because this reg has
+		 * some "sticky" (latched) bits.
+		 */
+		ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS,
+					       &mii_status_reg);
+		if (ret_val)
+			goto out;
+		ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS,
+					       &mii_status_reg);
+		if (ret_val)
+			goto out;
+
+		if (!(mii_status_reg & MII_SR_AUTONEG_COMPLETE)) {
+			hw_dbg("Copper PHY and Auto Neg has not completed.\n");
+			goto out;
+		}
+
+		/* The AutoNeg process has completed, so we now need to
+		 * read both the Auto Negotiation Advertisement
+		 * Register (Address 4) and the Auto_Negotiation Base
+		 * Page Ability Register (Address 5) to determine how
+		 * flow control was negotiated.
+		 */
+		ret_val = hw->phy.ops.read_reg(hw, PHY_AUTONEG_ADV,
+					       &mii_nway_adv_reg);
+		if (ret_val)
+			goto out;
+		ret_val = hw->phy.ops.read_reg(hw, PHY_LP_ABILITY,
+					       &mii_nway_lp_ability_reg);
+		if (ret_val)
+			goto out;
+		/* Two bits in the Auto Negotiation Advertisement Register
+		 * (Address 4) and two bits in the Auto Negotiation Base
+		 * Page Ability Register (Address 5) determine flow control
+		 * for both the PHY and the link partner.  The following
+		 * table, taken out of the IEEE 802.3ab/D6.0 dated March 25,
+		 * 1999, describes these PAUSE resolution bits and how flow
+		 * control is determined based upon these settings.
+		 * NOTE:  DC = Don't Care
+		 *
+		 *   LOCAL DEVICE  |   LINK PARTNER
+		 * PAUSE | ASM_DIR | PAUSE | ASM_DIR | NIC Resolution
+		 *-------|---------|-------|---------|--------------------
+		 *   0   |    0    |  DC   |   DC    | igc_fc_none
+		 *   0   |    1    |   0   |   DC    | igc_fc_none
+		 *   0   |    1    |   1   |    0    | igc_fc_none
+		 *   0   |    1    |   1   |    1    | igc_fc_tx_pause
+		 *   1   |    0    |   0   |   DC    | igc_fc_none
+		 *   1   |   DC    |   1   |   DC    | igc_fc_full
+		 *   1   |    1    |   0   |    0    | igc_fc_none
+		 *   1   |    1    |   0   |    1    | igc_fc_rx_pause
+		 *
+		 * Are both PAUSE bits set to 1?  If so, this implies
+		 * Symmetric Flow Control is enabled at both ends.  The
+		 * ASM_DIR bits are irrelevant per the spec.
+		 *
+		 * For Symmetric Flow Control:
+		 *
+		 *   LOCAL DEVICE  |   LINK PARTNER
+		 * PAUSE | ASM_DIR | PAUSE | ASM_DIR | Result
+		 *-------|---------|-------|---------|--------------------
+		 *   1   |   DC    |   1   |   DC    | IGC_fc_full
+		 *
+		 */
+		if ((mii_nway_adv_reg & NWAY_AR_PAUSE) &&
+		    (mii_nway_lp_ability_reg & NWAY_LPAR_PAUSE)) {
+			/* Now we need to check if the user selected RX ONLY
+			 * of pause frames.  In this case, we had to advertise
+			 * FULL flow control because we could not advertise RX
+			 * ONLY. Hence, we must now check to see if we need to
+			 * turn OFF  the TRANSMISSION of PAUSE frames.
+			 */
+			if (hw->fc.requested_mode == igc_fc_full) {
+				hw->fc.current_mode = igc_fc_full;
+				hw_dbg("Flow Control = FULL.\n");
+			} else {
+				hw->fc.current_mode = igc_fc_rx_pause;
+				hw_dbg("Flow Control = RX PAUSE frames only.\n");
+			}
+		}
+
+		/* For receiving PAUSE frames ONLY.
+		 *
+		 *   LOCAL DEVICE  |   LINK PARTNER
+		 * PAUSE | ASM_DIR | PAUSE | ASM_DIR | Result
+		 *-------|---------|-------|---------|--------------------
+		 *   0   |    1    |   1   |    1    | igc_fc_tx_pause
+		 */
+		else if (!(mii_nway_adv_reg & NWAY_AR_PAUSE) &&
+			 (mii_nway_adv_reg & NWAY_AR_ASM_DIR) &&
+			 (mii_nway_lp_ability_reg & NWAY_LPAR_PAUSE) &&
+			 (mii_nway_lp_ability_reg & NWAY_LPAR_ASM_DIR)) {
+			hw->fc.current_mode = igc_fc_tx_pause;
+			hw_dbg("Flow Control = TX PAUSE frames only.\n");
+		}
+		/* For transmitting PAUSE frames ONLY.
+		 *
+		 *   LOCAL DEVICE  |   LINK PARTNER
+		 * PAUSE | ASM_DIR | PAUSE | ASM_DIR | Result
+		 *-------|---------|-------|---------|--------------------
+		 *   1   |    1    |   0   |    1    | igc_fc_rx_pause
+		 */
+		else if ((mii_nway_adv_reg & NWAY_AR_PAUSE) &&
+			 (mii_nway_adv_reg & NWAY_AR_ASM_DIR) &&
+			 !(mii_nway_lp_ability_reg & NWAY_LPAR_PAUSE) &&
+			 (mii_nway_lp_ability_reg & NWAY_LPAR_ASM_DIR)) {
+			hw->fc.current_mode = igc_fc_rx_pause;
+			hw_dbg("Flow Control = RX PAUSE frames only.\n");
+		}
+		/* Per the IEEE spec, at this point flow control should be
+		 * disabled.  However, we want to consider that we could
+		 * be connected to a legacy switch that doesn't advertise
+		 * desired flow control, but can be forced on the link
+		 * partner.  So if we advertised no flow control, that is
+		 * what we will resolve to.  If we advertised some kind of
+		 * receive capability (Rx Pause Only or Full Flow Control)
+		 * and the link partner advertised none, we will configure
+		 * ourselves to enable Rx Flow Control only.  We can do
+		 * this safely for two reasons:  If the link partner really
+		 * didn't want flow control enabled, and we enable Rx, no
+		 * harm done since we won't be receiving any PAUSE frames
+		 * anyway.  If the intent on the link partner was to have
+		 * flow control enabled, then by us enabling RX only, we
+		 * can at least receive pause frames and process them.
+		 * This is a good idea because in most cases, since we are
+		 * predominantly a server NIC, more times than not we will
+		 * be asked to delay transmission of packets than asking
+		 * our link partner to pause transmission of frames.
+		 */
+		else if ((hw->fc.requested_mode == igc_fc_none) ||
+			 (hw->fc.requested_mode == igc_fc_tx_pause) ||
+			 (hw->fc.strict_ieee)) {
+			hw->fc.current_mode = igc_fc_none;
+			hw_dbg("Flow Control = NONE.\n");
+		} else {
+			hw->fc.current_mode = igc_fc_rx_pause;
+			hw_dbg("Flow Control = RX PAUSE frames only.\n");
+		}
+
+		/* Now we need to do one last check...  If we auto-
+		 * negotiated to HALF DUPLEX, flow control should not be
+		 * enabled per IEEE 802.3 spec.
+		 */
+		ret_val = hw->mac.ops.get_speed_and_duplex(hw, &speed, &duplex);
+		if (ret_val) {
+			hw_dbg("Error getting link speed and duplex\n");
+			goto out;
+		}
+
+		if (duplex == HALF_DUPLEX)
+			hw->fc.current_mode = igc_fc_none;
+
+		/* Now we call a subroutine to actually force the MAC
+		 * controller to use the correct flow control settings.
+		 */
+		ret_val = igc_force_mac_fc(hw);
+		if (ret_val) {
+			hw_dbg("Error forcing flow control settings\n");
+			goto out;
+		}
+	}
+
+out:
+	return ret_val;
+}
+
+/**
+ * igc_get_auto_rd_done - Check for auto read completion
+ * @hw: pointer to the HW structure
+ *
+ * Check EEPROM for Auto Read done bit.
+ */
+s32 igc_get_auto_rd_done(struct igc_hw *hw)
+{
+	s32 ret_val = 0;
+	s32 i = 0;
+
+	while (i < AUTO_READ_DONE_TIMEOUT) {
+		if (rd32(IGC_EECD) & IGC_EECD_AUTO_RD)
+			break;
+		usleep_range(1000, 2000);
+		i++;
+	}
+
+	if (i == AUTO_READ_DONE_TIMEOUT) {
+		hw_dbg("Auto read by HW from NVM has not completed.\n");
+		ret_val = -IGC_ERR_RESET;
+		goto out;
+	}
+
+out:
+	return ret_val;
+}
+
+/**
+ * igc_get_speed_and_duplex_copper - Retrieve current speed/duplex
+ * @hw: pointer to the HW structure
+ * @speed: stores the current speed
+ * @duplex: stores the current duplex
+ *
+ * Read the status register for the current speed/duplex and store the current
+ * speed and duplex for copper connections.
+ */
+s32 igc_get_speed_and_duplex_copper(struct igc_hw *hw, u16 *speed,
+				    u16 *duplex)
+{
+	u32 status;
+
+	status = rd32(IGC_STATUS);
+	if (status & IGC_STATUS_SPEED_1000) {
+		/* For I225, STATUS will indicate 1G speed in both 1 Gbps
+		 * and 2.5 Gbps link modes. An additional bit is used
+		 * to differentiate between 1 Gbps and 2.5 Gbps.
+		 */
+		if (hw->mac.type == igc_i225 &&
+		    (status & IGC_STATUS_SPEED_2500)) {
+			*speed = SPEED_2500;
+			hw_dbg("2500 Mbs, ");
+		} else {
+			*speed = SPEED_1000;
+			hw_dbg("1000 Mbs, ");
+		}
+	} else if (status & IGC_STATUS_SPEED_100) {
+		*speed = SPEED_100;
+		hw_dbg("100 Mbs, ");
+	} else {
+		*speed = SPEED_10;
+		hw_dbg("10 Mbs, ");
+	}
+
+	if (status & IGC_STATUS_FD) {
+		*duplex = FULL_DUPLEX;
+		hw_dbg("Full Duplex\n");
+	} else {
+		*duplex = HALF_DUPLEX;
+		hw_dbg("Half Duplex\n");
+	}
+
+	return 0;
+}
+
+/**
+ * igc_put_hw_semaphore - Release hardware semaphore
+ * @hw: pointer to the HW structure
+ *
+ * Release hardware semaphore used to access the PHY or NVM
+ */
+void igc_put_hw_semaphore(struct igc_hw *hw)
+{
+	u32 swsm;
+
+	swsm = rd32(IGC_SWSM);
+
+	swsm &= ~(IGC_SWSM_SMBI | IGC_SWSM_SWESMBI);
+
+	wr32(IGC_SWSM, swsm);
+}
+
+/**
+ * igc_enable_mng_pass_thru - Enable processing of ARP's
+ * @hw: pointer to the HW structure
+ *
+ * Verifies the hardware needs to leave interface enabled so that frames can
+ * be directed to and from the management interface.
+ */
+bool igc_enable_mng_pass_thru(struct igc_hw *hw)
+{
+	bool ret_val = false;
+	u32 fwsm, factps;
+	u32 manc;
+
+	if (!hw->mac.asf_firmware_present)
+		goto out;
+
+	manc = rd32(IGC_MANC);
+
+	if (!(manc & IGC_MANC_RCV_TCO_EN))
+		goto out;
+
+	if (hw->mac.arc_subsystem_valid) {
+		fwsm = rd32(IGC_FWSM);
+		factps = rd32(IGC_FACTPS);
+
+		if (!(factps & IGC_FACTPS_MNGCG) &&
+		    ((fwsm & IGC_FWSM_MODE_MASK) ==
+		    (igc_mng_mode_pt << IGC_FWSM_MODE_SHIFT))) {
+			ret_val = true;
+			goto out;
+		}
+	} else {
+		if ((manc & IGC_MANC_SMBUS_EN) &&
+		    !(manc & IGC_MANC_ASF_EN)) {
+			ret_val = true;
+			goto out;
+		}
+	}
+
+out:
+	return ret_val;
+}
+
+/**
+ *  igc_hash_mc_addr - Generate a multicast hash value
+ *  @hw: pointer to the HW structure
+ *  @mc_addr: pointer to a multicast address
+ *
+ *  Generates a multicast address hash value which is used to determine
+ *  the multicast filter table array address and new table value.  See
+ *  igc_mta_set()
+ **/
+static u32 igc_hash_mc_addr(struct igc_hw *hw, u8 *mc_addr)
+{
+	u32 hash_value, hash_mask;
+	u8 bit_shift = 0;
+
+	/* Register count multiplied by bits per register */
+	hash_mask = (hw->mac.mta_reg_count * 32) - 1;
+
+	/* For a mc_filter_type of 0, bit_shift is the number of left-shifts
+	 * where 0xFF would still fall within the hash mask.
+	 */
+	while (hash_mask >> bit_shift != 0xFF)
+		bit_shift++;
+
+	/* The portion of the address that is used for the hash table
+	 * is determined by the mc_filter_type setting.
+	 * The algorithm is such that there is a total of 8 bits of shifting.
+	 * The bit_shift for a mc_filter_type of 0 represents the number of
+	 * left-shifts where the MSB of mc_addr[5] would still fall within
+	 * the hash_mask.  Case 0 does this exactly.  Since there are a total
+	 * of 8 bits of shifting, then mc_addr[4] will shift right the
+	 * remaining number of bits. Thus 8 - bit_shift.  The rest of the
+	 * cases are a variation of this algorithm...essentially raising the
+	 * number of bits to shift mc_addr[5] left, while still keeping the
+	 * 8-bit shifting total.
+	 *
+	 * For example, given the following Destination MAC Address and an
+	 * MTA register count of 128 (thus a 4096-bit vector and 0xFFF mask),
+	 * we can see that the bit_shift for case 0 is 4.  These are the hash
+	 * values resulting from each mc_filter_type...
+	 * [0] [1] [2] [3] [4] [5]
+	 * 01  AA  00  12  34  56
+	 * LSB                 MSB
+	 *
+	 * case 0: hash_value = ((0x34 >> 4) | (0x56 << 4)) & 0xFFF = 0x563
+	 * case 1: hash_value = ((0x34 >> 3) | (0x56 << 5)) & 0xFFF = 0xAC6
+	 * case 2: hash_value = ((0x34 >> 2) | (0x56 << 6)) & 0xFFF = 0x163
+	 * case 3: hash_value = ((0x34 >> 0) | (0x56 << 8)) & 0xFFF = 0x634
+	 */
+	switch (hw->mac.mc_filter_type) {
+	default:
+	case 0:
+		break;
+	case 1:
+		bit_shift += 1;
+		break;
+	case 2:
+		bit_shift += 2;
+		break;
+	case 3:
+		bit_shift += 4;
+		break;
+	}
+
+	hash_value = hash_mask & (((mc_addr[4] >> (8 - bit_shift)) |
+				  (((u16)mc_addr[5]) << bit_shift)));
+
+	return hash_value;
+}
+
+/**
+ *  igc_update_mc_addr_list - Update Multicast addresses
+ *  @hw: pointer to the HW structure
+ *  @mc_addr_list: array of multicast addresses to program
+ *  @mc_addr_count: number of multicast addresses to program
+ *
+ *  Updates entire Multicast Table Array.
+ *  The caller must have a packed mc_addr_list of multicast addresses.
+ **/
+void igc_update_mc_addr_list(struct igc_hw *hw,
+			     u8 *mc_addr_list, u32 mc_addr_count)
+{
+	u32 hash_value, hash_bit, hash_reg;
+	int i;
+
+	/* clear mta_shadow */
+	memset(&hw->mac.mta_shadow, 0, sizeof(hw->mac.mta_shadow));
+
+	/* update mta_shadow from mc_addr_list */
+	for (i = 0; (u32)i < mc_addr_count; i++) {
+		hash_value = igc_hash_mc_addr(hw, mc_addr_list);
+
+		hash_reg = (hash_value >> 5) & (hw->mac.mta_reg_count - 1);
+		hash_bit = hash_value & 0x1F;
+
+		hw->mac.mta_shadow[hash_reg] |= BIT(hash_bit);
+		mc_addr_list += ETH_ALEN;
+	}
+
+	/* replace the entire MTA table */
+	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--)
+		array_wr32(IGC_MTA, i, hw->mac.mta_shadow[i]);
+	wrfl();
+}
diff --git a/kernel/drivers/net/drivers/igc/igc_mac.h b/kernel/drivers/net/drivers/igc/igc_mac.h
new file mode 100644
index 000000000..b5963f86d
--- /dev/null
+++ b/kernel/drivers/net/drivers/igc/igc_mac.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c)  2018 Intel Corporation */
+
+#ifndef _IGC_MAC_H_
+#define _IGC_MAC_H_
+
+#include "igc_hw.h"
+#include "igc_phy.h"
+#include "igc_defines.h"
+
+/* forward declaration */
+s32 igc_disable_pcie_master(struct igc_hw *hw);
+s32 igc_check_for_copper_link(struct igc_hw *hw);
+s32 igc_config_fc_after_link_up(struct igc_hw *hw);
+s32 igc_force_mac_fc(struct igc_hw *hw);
+void igc_init_rx_addrs(struct igc_hw *hw, u16 rar_count);
+s32 igc_setup_link(struct igc_hw *hw);
+void igc_clear_hw_cntrs_base(struct igc_hw *hw);
+s32 igc_get_auto_rd_done(struct igc_hw *hw);
+void igc_put_hw_semaphore(struct igc_hw *hw);
+void igc_rar_set(struct igc_hw *hw, u8 *addr, u32 index);
+void igc_config_collision_dist(struct igc_hw *hw);
+
+s32 igc_get_speed_and_duplex_copper(struct igc_hw *hw, u16 *speed,
+				    u16 *duplex);
+
+bool igc_enable_mng_pass_thru(struct igc_hw *hw);
+void igc_update_mc_addr_list(struct igc_hw *hw,
+			     u8 *mc_addr_list, u32 mc_addr_count);
+
+enum igc_mng_mode {
+	igc_mng_mode_none = 0,
+	igc_mng_mode_asf,
+	igc_mng_mode_pt,
+	igc_mng_mode_ipmi,
+	igc_mng_mode_host_if_only
+};
+
+#endif
diff --git a/kernel/drivers/net/drivers/igc/igc_main.c b/kernel/drivers/net/drivers/igc/igc_main.c
new file mode 100644
index 000000000..5b11228b0
--- /dev/null
+++ b/kernel/drivers/net/drivers/igc/igc_main.c
@@ -0,0 +1,4271 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c)  2018 Intel Corporation
+ * RTnet port 2022 Hongzhan Chen <hongzhan.chen@intel.com>
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/if_vlan.h>
+#include <linux/aer.h>
+#include <linux/tcp.h>
+#include <linux/udp.h>
+#include <linux/ip.h>
+#include <linux/pm_runtime.h>
+#include <net/pkt_sched.h>
+
+#include <net/ipv6.h>
+#include <rtnet_port.h>
+
+#include "igc.h"
+#include "igc_hw.h"
+
+// RTNET redefines
+#ifdef NETIF_F_TSO
+#undef NETIF_F_TSO
+#define NETIF_F_TSO 0
+#endif
+
+#ifdef NETIF_F_TSO6
+#undef NETIF_F_TSO6
+#define NETIF_F_TSO6 0
+#endif
+
+#ifdef NETIF_F_HW_VLAN_TX
+#undef NETIF_F_HW_VLAN_TX
+#define NETIF_F_HW_VLAN_TX 0
+#endif
+
+#ifdef NETIF_F_HW_VLAN_RX
+#undef NETIF_F_HW_VLAN_RX
+#define NETIF_F_HW_VLAN_RX 0
+#endif
+
+#ifdef NETIF_F_HW_VLAN_FILTER
+#undef NETIF_F_HW_VLAN_FILTER
+#define NETIF_F_HW_VLAN_FILTER 0
+#endif
+
+#ifdef IGC_MAX_TX_QUEUES
+#undef IGC_MAX_TX_QUEUES
+#define IGC_MAX_TX_QUEUES 1
+#endif
+
+#ifdef IGC_MAX_RX_QUEUES
+#undef IGC_MAX_RX_QUEUES
+#define IGC_MAX_RX_QUEUES 1
+#endif
+
+#ifdef CONFIG_IGC_NAPI
+#undef CONFIG_IGC_NAPI
+#endif
+
+#ifdef IGC_HAVE_TX_TIMEOUT
+#undef IGC_HAVE_TX_TIMEOUT
+#endif
+
+#ifdef ETHTOOL_GPERMADDR
+#undef ETHTOOL_GPERMADDR
+#endif
+
+#ifdef CONFIG_PM
+#undef CONFIG_PM
+#endif
+
+#ifdef CONFIG_NET_POLL_CONTROLLER
+#undef CONFIG_NET_POLL_CONTROLLER
+#endif
+
+#ifdef MAX_SKB_FRAGS
+#undef MAX_SKB_FRAGS
+#define MAX_SKB_FRAGS 1
+#endif
+
+#ifdef IGC_FRAMES_SUPPORT
+#undef IGC_FRAMES_SUPPORT
+#endif
+
+#define DRV_SUMMARY	"Intel(R) 2.5G Ethernet Linux Driver"
+
+#define DEFAULT_MSG_ENABLE (NETIF_MSG_DRV | NETIF_MSG_PROBE | NETIF_MSG_LINK)
+
+static int debug = -1;
+
+MODULE_AUTHOR("Intel Corporation, <linux.nics@intel.com>");
+MODULE_DESCRIPTION(DRV_SUMMARY);
+MODULE_LICENSE("GPL v2");
+module_param(debug, int, 0);
+MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
+
+char igc_driver_name[] = "rt_igc";
+static const char igc_driver_string[] = DRV_SUMMARY;
+static const char igc_copyright[] =
+	"Copyright(c) 2018 Intel Corporation.";
+
+#define MAX_UNITS 8
+static int InterruptThrottle;
+module_param(InterruptThrottle, uint, 0);
+MODULE_PARM_DESC(InterruptThrottle, "Throttle interrupts (boolean, false by default)");
+
+static const struct igc_info *igc_info_tbl[] = {
+	[board_base] = &igc_base_info,
+};
+
+static const struct pci_device_id igc_pci_tbl[] = {
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_LM), board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_V), board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_I), board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I220_V), board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_K), board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_K2), board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_LMVP), board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_IT), board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_LM), board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_V), board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_IT), board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I221_V), board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_BLANK_NVM), board_base },
+	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_BLANK_NVM), board_base },
+	/* required last entry */
+	{0, }
+};
+
+MODULE_DEVICE_TABLE(pci, igc_pci_tbl);
+
+enum latency_range {
+	lowest_latency = 0,
+	low_latency = 1,
+	bulk_latency = 2,
+	latency_invalid = 255
+};
+
+void igc_reset(struct igc_adapter *adapter)
+{
+	struct rtnet_device *dev = adapter->netdev;
+	struct igc_hw *hw = &adapter->hw;
+	struct igc_fc_info *fc = &hw->fc;
+	u32 pba, hwm;
+
+	/* Repartition PBA for greater than 9k MTU if required */
+	pba = IGC_PBA_34K;
+
+	/* flow control settings
+	 * The high water mark must be low enough to fit one full frame
+	 * after transmitting the pause frame.  As such we must have enough
+	 * space to allow for us to complete our current transmit and then
+	 * receive the frame that is in progress from the link partner.
+	 * Set it to:
+	 * - the full Rx FIFO size minus one full Tx plus one full Rx frame
+	 */
+	hwm = (pba << 10) - (adapter->max_frame_size + MAX_JUMBO_FRAME_SIZE);
+
+	fc->high_water = hwm & 0xFFFFFFF0;	/* 16-byte granularity */
+	fc->low_water = fc->high_water - 16;
+	fc->pause_time = 0xFFFF;
+	fc->send_xon = 1;
+	fc->current_mode = fc->requested_mode;
+
+	hw->mac.ops.reset_hw(hw);
+
+	if (hw->mac.ops.init_hw(hw))
+		rtdev_err(dev, "Error on hardware initialization\n");
+
+	/* Re-establish EEE setting */
+	igc_set_eee_i225(hw, true, true, true);
+
+	if (!rtnetif_running(adapter->netdev))
+		igc_power_down_phy_copper_base(&adapter->hw);
+
+	igc_get_phy_info(hw);
+}
+
+/**
+ * igc_power_up_link - Power up the phy link
+ * @adapter: address of board private structure
+ */
+static void igc_power_up_link(struct igc_adapter *adapter)
+{
+	igc_reset_phy(&adapter->hw);
+
+	igc_power_up_phy_copper(&adapter->hw);
+
+	igc_setup_link(&adapter->hw);
+}
+
+/**
+ * igc_release_hw_control - release control of the h/w to f/w
+ * @adapter: address of board private structure
+ *
+ * igc_release_hw_control resets CTRL_EXT:DRV_LOAD bit.
+ * For ASF and Pass Through versions of f/w this means that the
+ * driver is no longer loaded.
+ */
+static void igc_release_hw_control(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+	u32 ctrl_ext;
+
+	/* Let firmware take over control of h/w */
+	ctrl_ext = rd32(IGC_CTRL_EXT);
+	wr32(IGC_CTRL_EXT,
+	     ctrl_ext & ~IGC_CTRL_EXT_DRV_LOAD);
+}
+
+/**
+ * igc_get_hw_control - get control of the h/w from f/w
+ * @adapter: address of board private structure
+ *
+ * igc_get_hw_control sets CTRL_EXT:DRV_LOAD bit.
+ * For ASF and Pass Through versions of f/w this means that
+ * the driver is loaded.
+ */
+static void igc_get_hw_control(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+	u32 ctrl_ext;
+
+	/* Let firmware know the driver has taken over */
+	ctrl_ext = rd32(IGC_CTRL_EXT);
+	wr32(IGC_CTRL_EXT,
+	     ctrl_ext | IGC_CTRL_EXT_DRV_LOAD);
+}
+
+void igc_unmap_and_free_tx_resource(struct igc_ring *ring,
+				    struct igc_tx_buffer *tx_buffer)
+{
+	if (tx_buffer->skb) {
+		kfree_rtskb(tx_buffer->skb);
+		tx_buffer->skb = NULL;
+	}
+	tx_buffer->next_to_watch = NULL;
+}
+/**
+ * igc_clean_tx_ring - Free Tx Buffers
+ * @tx_ring: ring to be cleaned
+ */
+static void igc_clean_tx_ring(struct igc_ring *tx_ring)
+{
+
+	struct igc_tx_buffer *buffer_info;
+	unsigned long size;
+	u16 i;
+
+	if (!tx_ring->tx_buffer_info)
+		return;
+	/* Free all the Tx ring sk_buffs */
+
+	for (i = 0; i < tx_ring->count; i++) {
+		buffer_info = &tx_ring->tx_buffer_info[i];
+		igc_unmap_and_free_tx_resource(tx_ring, buffer_info);
+	}
+
+	size = sizeof(struct igc_tx_buffer) * tx_ring->count;
+	memset(tx_ring->tx_buffer_info, 0, size);
+
+	/* Zero out the descriptor ring */
+	memset(tx_ring->desc, 0, tx_ring->size);
+
+	/* reset next_to_use and next_to_clean */
+	tx_ring->next_to_use = 0;
+	tx_ring->next_to_clean = 0;
+}
+
+/**
+ * igc_free_tx_resources - Free Tx Resources per Queue
+ * @tx_ring: Tx descriptor ring for a specific queue
+ *
+ * Free all transmit software resources
+ */
+void igc_free_tx_resources(struct igc_ring *tx_ring)
+{
+	igc_clean_tx_ring(tx_ring);
+
+	vfree(tx_ring->tx_buffer_info);
+	tx_ring->tx_buffer_info = NULL;
+
+	/* if not set, then don't free */
+	if (!tx_ring->desc)
+		return;
+
+	dma_free_coherent(tx_ring->dev, tx_ring->size,
+			  tx_ring->desc, tx_ring->dma);
+
+	tx_ring->desc = NULL;
+}
+
+/**
+ * igc_free_all_tx_resources - Free Tx Resources for All Queues
+ * @adapter: board private structure
+ *
+ * Free all transmit software resources
+ */
+static void igc_free_all_tx_resources(struct igc_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < adapter->num_tx_queues; i++)
+		igc_free_tx_resources(adapter->tx_ring[i]);
+}
+
+/**
+ * igc_clean_all_tx_rings - Free Tx Buffers for all queues
+ * @adapter: board private structure
+ */
+static void igc_clean_all_tx_rings(struct igc_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < adapter->num_tx_queues; i++)
+		if (adapter->tx_ring[i])
+			igc_clean_tx_ring(adapter->tx_ring[i]);
+}
+
+/**
+ * igc_setup_tx_resources - allocate Tx resources (Descriptors)
+ * @tx_ring: tx descriptor ring (for a specific queue) to setup
+ *
+ * Return 0 on success, negative on failure
+ */
+int igc_setup_tx_resources(struct igc_ring *tx_ring)
+{
+	struct device *dev = tx_ring->dev;
+	int size = 0;
+
+	size = sizeof(struct igc_tx_buffer) * tx_ring->count;
+	tx_ring->tx_buffer_info = vzalloc(size);
+	if (!tx_ring->tx_buffer_info)
+		goto err;
+
+	/* round up to nearest 4K */
+	tx_ring->size = tx_ring->count * sizeof(union igc_adv_tx_desc);
+	tx_ring->size = ALIGN(tx_ring->size, 4096);
+
+	tx_ring->desc = dma_alloc_coherent(dev, tx_ring->size,
+					   &tx_ring->dma, GFP_KERNEL);
+
+	if (!tx_ring->desc)
+		goto err;
+
+	tx_ring->next_to_use = 0;
+	tx_ring->next_to_clean = 0;
+
+	return 0;
+
+err:
+	vfree(tx_ring->tx_buffer_info);
+	dev_err(dev, "Unable to allocate memory for Tx descriptor ring\n");
+	return -ENOMEM;
+}
+
+/**
+ * igc_setup_all_tx_resources - wrapper to allocate Tx resources for all queues
+ * @adapter: board private structure
+ *
+ * Return 0 on success, negative on failure
+ */
+static int igc_setup_all_tx_resources(struct igc_adapter *adapter)
+{
+	struct pci_dev *pdev = adapter->pdev;
+	int i, err = 0;
+
+	for (i = 0; i < adapter->num_tx_queues; i++) {
+		err = igc_setup_tx_resources(adapter->tx_ring[i]);
+		if (err) {
+			dev_err(&pdev->dev, "Error on Tx queue %u setup\n", i);
+			for (i--; i >= 0; i--)
+				igc_free_tx_resources(adapter->tx_ring[i]);
+			break;
+		}
+	}
+
+	return err;
+}
+
+static void igc_clean_rx_ring_page_shared(struct igc_ring *rx_ring)
+{
+	unsigned long size;
+	u16 i;
+
+	if (!rx_ring->rx_buffer_info)
+		return;
+
+	/* Free all the Rx ring sk_buffs */
+	for (i = 0; i < rx_ring->count; i++) {
+		struct igc_rx_buffer *buffer_info = &rx_ring->rx_buffer_info[i];
+
+		if (buffer_info->dma)
+			buffer_info->dma = 0;
+
+		if (buffer_info->skb) {
+			kfree_rtskb(buffer_info->skb);
+			buffer_info->skb = NULL;
+		}
+	}
+
+	size = sizeof(struct igc_rx_buffer) * rx_ring->count;
+	memset(rx_ring->rx_buffer_info, 0, size);
+
+	/* Zero out the descriptor ring */
+	memset(rx_ring->desc, 0, rx_ring->size);
+}
+
+/**
+ * igc_clean_rx_ring - Free Rx Buffers per Queue
+ * @ring: ring to free buffers from
+ */
+static void igc_clean_rx_ring(struct igc_ring *ring)
+{
+	igc_clean_rx_ring_page_shared(ring);
+
+	//clear_ring_uses_large_buffer(ring);
+
+	ring->next_to_alloc = 0;
+	ring->next_to_clean = 0;
+	ring->next_to_use = 0;
+}
+
+/**
+ * igc_clean_all_rx_rings - Free Rx Buffers for all queues
+ * @adapter: board private structure
+ */
+static void igc_clean_all_rx_rings(struct igc_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < adapter->num_rx_queues; i++)
+		if (adapter->rx_ring[i])
+			igc_clean_rx_ring(adapter->rx_ring[i]);
+}
+
+/**
+ * igc_free_rx_resources - Free Rx Resources
+ * @rx_ring: ring to clean the resources from
+ *
+ * Free all receive software resources
+ */
+void igc_free_rx_resources(struct igc_ring *rx_ring)
+{
+	igc_clean_rx_ring(rx_ring);
+
+	vfree(rx_ring->rx_buffer_info);
+	rx_ring->rx_buffer_info = NULL;
+
+	/* if not set, then don't free */
+	if (!rx_ring->desc)
+		return;
+
+	dma_free_coherent(rx_ring->dev, rx_ring->size,
+			  rx_ring->desc, rx_ring->dma);
+
+	rx_ring->desc = NULL;
+}
+
+/**
+ * igc_free_all_rx_resources - Free Rx Resources for All Queues
+ * @adapter: board private structure
+ *
+ * Free all receive software resources
+ */
+static void igc_free_all_rx_resources(struct igc_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < adapter->num_rx_queues; i++)
+		igc_free_rx_resources(adapter->rx_ring[i]);
+}
+
+/**
+ * igc_setup_rx_resources - allocate Rx resources (Descriptors)
+ * @rx_ring:    rx descriptor ring (for a specific queue) to setup
+ *
+ * Returns 0 on success, negative on failure
+ */
+int igc_setup_rx_resources(struct igc_ring *rx_ring)
+{
+	struct device *dev = rx_ring->dev;
+	int size, desc_len;
+
+	size = sizeof(struct igc_rx_buffer) * rx_ring->count;
+	rx_ring->rx_buffer_info = vzalloc(size);
+	if (!rx_ring->rx_buffer_info)
+		goto err;
+
+	desc_len = sizeof(union igc_adv_rx_desc);
+
+	/* Round up to nearest 4K */
+	rx_ring->size = rx_ring->count * desc_len;
+	rx_ring->size = ALIGN(rx_ring->size, 4096);
+
+	rx_ring->desc = dma_alloc_coherent(dev, rx_ring->size,
+					   &rx_ring->dma, GFP_KERNEL);
+
+	if (!rx_ring->desc)
+		goto err;
+
+	rx_ring->next_to_alloc = 0;
+	rx_ring->next_to_clean = 0;
+	rx_ring->next_to_use = 0;
+
+	return 0;
+
+err:
+	vfree(rx_ring->rx_buffer_info);
+	rx_ring->rx_buffer_info = NULL;
+	dev_err(dev, "Unable to allocate memory for Rx descriptor ring\n");
+	return -ENOMEM;
+}
+
+/**
+ * igc_setup_all_rx_resources - wrapper to allocate Rx resources
+ *                                (Descriptors) for all queues
+ * @adapter: board private structure
+ *
+ * Return 0 on success, negative on failure
+ */
+static int igc_setup_all_rx_resources(struct igc_adapter *adapter)
+{
+	struct pci_dev *pdev = adapter->pdev;
+	int i, err = 0;
+
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		err = igc_setup_rx_resources(adapter->rx_ring[i]);
+		if (err) {
+			dev_err(&pdev->dev,
+					"Error on Rx queue %u setup\n", i);
+			for (i--; i >= 0; i--)
+				igc_free_rx_resources(adapter->rx_ring[i]);
+			break;
+		}
+	}
+
+	return err;
+}
+
+/**
+ * igc_configure_rx_ring - Configure a receive ring after Reset
+ * @adapter: board private structure
+ * @ring: receive ring to be configured
+ *
+ * Configure the Rx unit of the MAC after a reset.
+ */
+static void igc_configure_rx_ring(struct igc_adapter *adapter,
+				  struct igc_ring *ring)
+{
+	struct igc_hw *hw = &adapter->hw;
+	int reg_idx = ring->reg_idx;
+	u32 srrctl = 0, rxdctl = 0;
+	u64 rdba = ring->dma;
+
+	/* disable the queue */
+	wr32(IGC_RXDCTL(reg_idx), 0);
+
+	/* Set DMA base address registers */
+	wr32(IGC_RDBAL(reg_idx),
+	     rdba & 0x00000000ffffffffULL);
+	wr32(IGC_RDBAH(reg_idx), rdba >> 32);
+	wr32(IGC_RDLEN(reg_idx),
+	     ring->count * sizeof(union igc_adv_rx_desc));
+
+	/* initialize head and tail */
+	ring->tail =  hw->hw_addr + IGC_RDT(reg_idx);
+	wr32(IGC_RDH(reg_idx), 0);
+	writel(0, ring->tail);
+
+	/* reset next-to- use/clean to place SW in sync with hardware */
+	ring->next_to_clean = 0;
+	ring->next_to_use = 0;
+
+	/* set descriptor configuration */
+	srrctl = IGC_RX_HDR_LEN << IGC_SRRCTL_BSIZEHDRSIZE_SHIFT;
+	srrctl |= IGC_RX_BUFSZ >> IGC_SRRCTL_BSIZEPKT_SHIFT;
+	srrctl |= IGC_SRRCTL_DESCTYPE_ADV_ONEBUF;
+
+	wr32(IGC_SRRCTL(reg_idx), srrctl);
+
+	rxdctl |= IGC_RX_PTHRESH;
+	rxdctl |= IGC_RX_HTHRESH << 8;
+	rxdctl |= IGC_RX_WTHRESH << 16;
+
+	/* enable receive descriptor fetching */
+	rxdctl |= IGC_RXDCTL_QUEUE_ENABLE;
+
+	wr32(IGC_RXDCTL(reg_idx), rxdctl);
+}
+
+/**
+ * igc_configure_rx - Configure receive Unit after Reset
+ * @adapter: board private structure
+ *
+ * Configure the Rx unit of the MAC after a reset.
+ */
+static void igc_configure_rx(struct igc_adapter *adapter)
+{
+	int i;
+
+	/* Setup the HW Rx Head and Tail Descriptor Pointers and
+	 * the Base and Length of the Rx Descriptor Ring
+	 */
+	for (i = 0; i < adapter->num_rx_queues; i++)
+		igc_configure_rx_ring(adapter, adapter->rx_ring[i]);
+}
+
+/**
+ * igc_configure_tx_ring - Configure transmit ring after Reset
+ * @adapter: board private structure
+ * @ring: tx ring to configure
+ *
+ * Configure a transmit ring after a reset.
+ */
+static void igc_configure_tx_ring(struct igc_adapter *adapter,
+				  struct igc_ring *ring)
+{
+	struct igc_hw *hw = &adapter->hw;
+	int reg_idx = ring->reg_idx;
+	u64 tdba = ring->dma;
+	u32 txdctl = 0;
+
+	/* disable the queue */
+	wr32(IGC_TXDCTL(reg_idx), 0);
+	wrfl();
+	mdelay(10);
+
+	wr32(IGC_TDLEN(reg_idx),
+	     ring->count * sizeof(union igc_adv_tx_desc));
+	wr32(IGC_TDBAL(reg_idx),
+	     tdba & 0x00000000ffffffffULL);
+	wr32(IGC_TDBAH(reg_idx), tdba >> 32);
+
+	ring->tail = hw->hw_addr + IGC_TDT(reg_idx);
+	wr32(IGC_TDH(reg_idx), 0);
+	writel(0, ring->tail);
+
+	txdctl |= IGC_TX_PTHRESH;
+	txdctl |= IGC_TX_HTHRESH << 8;
+	txdctl |= IGC_TX_WTHRESH << 16;
+
+	txdctl |= IGC_TXDCTL_QUEUE_ENABLE;
+	wr32(IGC_TXDCTL(reg_idx), txdctl);
+}
+
+/**
+ * igc_configure_tx - Configure transmit Unit after Reset
+ * @adapter: board private structure
+ *
+ * Configure the Tx unit of the MAC after a reset.
+ */
+static void igc_configure_tx(struct igc_adapter *adapter)
+{
+	int i;
+
+	for (i = 0; i < adapter->num_tx_queues; i++)
+		igc_configure_tx_ring(adapter, adapter->tx_ring[i]);
+}
+
+/**
+ * igc_setup_mrqc - configure the multiple receive queue control registers
+ * @adapter: Board private structure
+ */
+static void igc_setup_mrqc(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+	u32 j, num_rx_queues;
+	u32 mrqc, rxcsum;
+	u32 rss_key[10];
+
+	get_random_bytes(rss_key, sizeof(rss_key));
+	for (j = 0; j < 10; j++)
+		wr32(IGC_RSSRK(j), rss_key[j]);
+
+	num_rx_queues = adapter->rss_queues;
+
+	if (adapter->rss_indir_tbl_init != num_rx_queues) {
+		for (j = 0; j < IGC_RETA_SIZE; j++)
+			adapter->rss_indir_tbl[j] =
+			(j * num_rx_queues) / IGC_RETA_SIZE;
+		adapter->rss_indir_tbl_init = num_rx_queues;
+	}
+
+	/* Disable raw packet checksumming so that RSS hash is placed in
+	 * descriptor on writeback.  No need to enable TCP/UDP/IP checksum
+	 * offloads as they are enabled by default
+	 */
+	rxcsum = rd32(IGC_RXCSUM);
+	rxcsum |= IGC_RXCSUM_PCSD;
+
+	/* Enable Receive Checksum Offload for SCTP */
+	rxcsum |= IGC_RXCSUM_CRCOFL;
+
+	/* Don't need to set TUOFL or IPOFL, they default to 1 */
+	wr32(IGC_RXCSUM, rxcsum);
+
+	/* Generate RSS hash based on packet types, TCP/UDP
+	 * port numbers and/or IPv4/v6 src and dst addresses
+	 */
+	mrqc = IGC_MRQC_RSS_FIELD_IPV4 |
+	       IGC_MRQC_RSS_FIELD_IPV4_TCP |
+	       IGC_MRQC_RSS_FIELD_IPV6 |
+	       IGC_MRQC_RSS_FIELD_IPV6_TCP |
+	       IGC_MRQC_RSS_FIELD_IPV6_TCP_EX;
+
+	if (adapter->flags & IGC_FLAG_RSS_FIELD_IPV4_UDP)
+		mrqc |= IGC_MRQC_RSS_FIELD_IPV4_UDP;
+	if (adapter->flags & IGC_FLAG_RSS_FIELD_IPV6_UDP)
+		mrqc |= IGC_MRQC_RSS_FIELD_IPV6_UDP;
+
+	mrqc |= IGC_MRQC_ENABLE_RSS_MQ;
+
+	wr32(IGC_MRQC, mrqc);
+}
+
+/**
+ * igc_setup_rctl - configure the receive control registers
+ * @adapter: Board private structure
+ */
+static void igc_setup_rctl(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+	u32 rctl;
+
+	rctl = rd32(IGC_RCTL);
+
+	rctl &= ~(3 << IGC_RCTL_MO_SHIFT);
+	rctl &= ~(IGC_RCTL_LBM_TCVR | IGC_RCTL_LBM_MAC);
+
+	rctl |= IGC_RCTL_EN | IGC_RCTL_BAM | IGC_RCTL_RDMTS_HALF |
+		(hw->mac.mc_filter_type << IGC_RCTL_MO_SHIFT);
+
+	/* enable stripping of CRC. Newer features require
+	 * that the HW strips the CRC.
+	 */
+	rctl |= IGC_RCTL_SECRC;
+
+	/* disable store bad packets and clear size bits. */
+	rctl &= ~(IGC_RCTL_SBP | IGC_RCTL_SZ_256);
+
+	/* enable LPE to allow for reception of jumbo frames */
+	rctl |= IGC_RCTL_LPE;
+
+	/* disable queue 0 to prevent tail write w/o re-config */
+	wr32(IGC_RXDCTL(0), 0);
+
+	/* This is useful for sniffing bad packets. */
+	if (adapter->netdev->features & NETIF_F_RXALL) {
+		/* UPE and MPE will be handled by normal PROMISC logic
+		 * in set_rx_mode
+		 */
+		rctl |= (IGC_RCTL_SBP | /* Receive bad packets */
+			 IGC_RCTL_BAM | /* RX All Bcast Pkts */
+			 IGC_RCTL_PMCF); /* RX All MAC Ctrl Pkts */
+
+		rctl &= ~(IGC_RCTL_DPF | /* Allow filtered pause */
+			  IGC_RCTL_CFIEN); /* Disable VLAN CFIEN Filter */
+	}
+
+	wr32(IGC_RCTL, rctl);
+}
+
+/**
+ * igc_setup_tctl - configure the transmit control registers
+ * @adapter: Board private structure
+ */
+static void igc_setup_tctl(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+	u32 tctl;
+
+	/* disable queue 0 which icould be enabled by default */
+	wr32(IGC_TXDCTL(0), 0);
+
+	/* Program the Transmit Control Register */
+	tctl = rd32(IGC_TCTL);
+	tctl &= ~IGC_TCTL_CT;
+	tctl |= IGC_TCTL_PSP | IGC_TCTL_RTLC |
+		(IGC_COLLISION_THRESHOLD << IGC_CT_SHIFT);
+
+	/* Enable transmits */
+	tctl |= IGC_TCTL_EN;
+
+	wr32(IGC_TCTL, tctl);
+}
+
+
+/**
+ *  igc_write_mc_addr_list - write multicast addresses to MTA
+ *  @netdev: network interface device structure
+ *
+ *  Writes multicast address list to the MTA hash table.
+ *  Returns: -ENOMEM on failure
+ *           0 on no addresses written
+ *           X on writing X addresses to MTA
+ **/
+static int igc_write_mc_addr_list(struct rtnet_device *netdev)
+{
+	struct igc_adapter *adapter = rtnetdev_priv(netdev);
+	struct igc_hw *hw = &adapter->hw;
+
+	igc_update_mc_addr_list(hw, NULL, 0);
+
+	return 0;
+}
+
+static int __igc_maybe_stop_tx(struct igc_ring *tx_ring, const u16 size)
+{
+	struct rtnet_device *netdev = tx_ring->netdev;
+
+	rtnetif_stop_queue(netdev);
+
+	/* memory barriier comment */
+	smp_mb();
+
+	/* We need to check again in a case another CPU has just
+	 * made room available.
+	 */
+	if (igc_desc_unused(tx_ring) < size)
+		return -EBUSY;
+
+	/* A reprieve! */
+	rtnetif_wake_queue(netdev);
+
+	tx_ring->tx_stats.restart_queue2++;
+
+	return 0;
+}
+
+static inline int igc_maybe_stop_tx(struct igc_ring *tx_ring, const u16 size)
+{
+	if (igc_desc_unused(tx_ring) >= size)
+		return 0;
+	return __igc_maybe_stop_tx(tx_ring, size);
+}
+
+#define IGC_SET_FLAG(_input, _flag, _result) \
+	(((_flag) <= (_result)) ?				\
+	 ((u32)((_input) & (_flag)) * ((_result) / (_flag))) :	\
+	 ((u32)((_input) & (_flag)) / ((_flag) / (_result))))
+
+static u32 igc_tx_cmd_type(struct rtskb *skb, u32 tx_flags)
+{
+	/* set type for advanced descriptor with frame checksum insertion */
+	u32 cmd_type = IGC_ADVTXD_DTYP_DATA |
+		       IGC_ADVTXD_DCMD_DEXT |
+		       IGC_ADVTXD_DCMD_IFCS;
+
+	return cmd_type;
+}
+
+static void igc_tx_olinfo_status(struct igc_ring *tx_ring,
+				 union igc_adv_tx_desc *tx_desc,
+				 u32 tx_flags, unsigned int paylen)
+{
+	u32 olinfo_status = paylen << IGC_ADVTXD_PAYLEN_SHIFT;
+
+	tx_desc->read.olinfo_status = cpu_to_le32(olinfo_status);
+}
+
+static int igc_tx_map(struct igc_ring *tx_ring,
+		      struct igc_tx_buffer *first,
+		      const u8 hdr_len)
+{
+	struct rtskb *skb = first->skb;
+	struct igc_tx_buffer *tx_buffer;
+	union igc_adv_tx_desc *tx_desc;
+	u32 tx_flags = first->tx_flags;
+	u16 i = tx_ring->next_to_use;
+	unsigned int size;
+	dma_addr_t dma;
+	u32 cmd_type = igc_tx_cmd_type(skb, tx_flags);
+
+	/* first descriptor is also last, set RS and EOP bits */
+	cmd_type |= IGC_TXD_DCMD;
+
+	tx_desc = IGC_TX_DESC(tx_ring, i);
+
+	igc_tx_olinfo_status(tx_ring, tx_desc, tx_flags, skb->len - hdr_len);
+
+	size = skb->len;
+
+	dma = rtskb_data_dma_addr(skb, 0);
+
+	tx_buffer = first;
+
+	tx_desc->read.buffer_addr = cpu_to_le64(dma);
+	/* write last descriptor with RS and EOP bits */
+	cmd_type |= size | IGC_TXD_DCMD;
+	tx_desc->read.cmd_type_len = cpu_to_le32(cmd_type);
+
+	/* set the timestamp */
+	first->time_stamp = jiffies;
+	first->next_to_watch = tx_desc;
+
+	i++;
+	tx_desc++;
+	if (i == tx_ring->count) {
+		tx_desc = IGC_TX_DESC(tx_ring, 0);
+		i = 0;
+	}
+
+	/* Force memory writes to complete before letting h/w know there
+	 * are new descriptors to fetch.  (Only applicable for weak-ordered
+	 * memory model archs, such as IA-64).
+	 *
+	 * We also need this memory barrier to make certain all of the
+	 * status bits have been updated before next_to_watch is written.
+	 */
+	wmb();
+
+	if (skb->xmit_stamp)
+		*skb->xmit_stamp =
+			cpu_to_be64(rtdm_clock_read() + *skb->xmit_stamp);
+
+	tx_ring->next_to_use = i;
+
+	/* Make sure there is space in the ring for the next send. */
+	igc_maybe_stop_tx(tx_ring, DESC_NEEDED);
+
+	writel(i, tx_ring->tail);
+
+	return 0;
+}
+
+static netdev_tx_t igc_xmit_frame_ring(struct rtskb *skb,
+				       struct igc_ring *tx_ring)
+{
+	u16 count = 2;
+	struct igc_tx_buffer *first;
+	u32 tx_flags = 0;
+	u8 hdr_len = 0;
+
+	/* need: 1 descriptor per page * PAGE_SIZE/IGC_MAX_DATA_PER_TXD,
+	 *	+ 1 desc for skb_headlen/IGC_MAX_DATA_PER_TXD,
+	 *	+ 2 desc gap to keep tail from touching head,
+	 *	+ 1 desc for context descriptor,
+	 * otherwise try next time
+	 */
+
+	if (igc_maybe_stop_tx(tx_ring, count + 3)) {
+		/* this is a hard error */
+		return NETDEV_TX_BUSY;
+	}
+
+	if (skb->protocol == htons(ETH_P_IP))
+		tx_flags |= IGC_TX_FLAGS_IPV4;
+
+	/* record the location of the first descriptor for this packet */
+	first = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
+	first->skb = skb;
+	first->bytecount = skb->len;
+	first->gso_segs = 1;
+
+	/* record initial flags and protocol */
+	first->tx_flags = tx_flags;
+	first->protocol = skb->protocol;
+
+	igc_tx_map(tx_ring, first, hdr_len);
+
+	return NETDEV_TX_OK;
+}
+
+static inline struct igc_ring *igc_tx_queue_mapping(struct igc_adapter *adapter,
+						    struct rtskb *skb)
+{
+	return adapter->tx_ring[0];
+}
+
+static netdev_tx_t igc_xmit_frame(struct rtskb *skb,
+				  struct rtnet_device *netdev)
+{
+	struct igc_adapter *adapter = rtnetdev_priv(netdev);
+
+	if (test_bit(__IGC_DOWN, &adapter->state)) {
+		kfree_rtskb(skb);
+		return NETDEV_TX_OK;
+	}
+
+	if (skb->len <= 0) {
+		kfree_rtskb(skb);
+		return NETDEV_TX_OK;
+	}
+
+	/* The minimum packet size with TCTL.PSP set is 17 so pad the skb
+	 * in order to meet this minimum size requirement.
+	 */
+	if (skb->len < 17) {
+		if (rtskb_padto(skb, 17))
+			return NETDEV_TX_OK;
+		skb->len = 17;
+	}
+
+	return igc_xmit_frame_ring(skb, igc_tx_queue_mapping(adapter, skb));
+}
+
+static void igc_rx_checksum(struct igc_ring *ring,
+			    union igc_adv_rx_desc *rx_desc,
+			    struct rtskb *skb)
+{
+	skb->ip_summed = CHECKSUM_NONE;
+
+	/* Ignore Checksum bit is set */
+	if (igc_test_staterr(rx_desc, IGC_RXD_STAT_IXSM))
+		return;
+
+	/* Rx checksum disabled via ethtool */
+	if (!(ring->netdev->features & NETIF_F_RXCSUM))
+		return;
+
+	/* TCP/UDP checksum error bit is set */
+	if (igc_test_staterr(rx_desc,
+			     IGC_RXDEXT_STATERR_L4E |
+			     IGC_RXDEXT_STATERR_IPE)) {
+		/* work around errata with sctp packets where the TCPE aka
+		 * L4E bit is set incorrectly on 64 byte (60 byte w/o crc)
+		 * packets (aka let the stack check the crc32c)
+		 */
+		if (!(skb->len == 60 &&
+		      test_bit(IGC_RING_FLAG_RX_SCTP_CSUM, &ring->flags))) {
+			u64_stats_update_begin(&ring->rx_syncp);
+			ring->rx_stats.csum_err++;
+			u64_stats_update_end(&ring->rx_syncp);
+		}
+		/* let the stack verify checksum errors */
+		return;
+	}
+	/* It must be a TCP or UDP packet with a valid checksum */
+	if (igc_test_staterr(rx_desc, IGC_RXD_STAT_TCPCS |
+				      IGC_RXD_STAT_UDPCS))
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	rtdev_dbg(ring->netdev, "cksum success: bits %08X\n",
+		   le32_to_cpu(rx_desc->wb.upper.status_error));
+}
+
+/**
+ * igc_process_skb_fields - Populate skb header fields from Rx descriptor
+ * @rx_ring: rx descriptor ring packet is being transacted on
+ * @rx_desc: pointer to the EOP Rx descriptor
+ * @skb: pointer to current skb being populated
+ *
+ * This function checks the ring, descriptor, and packet information in order
+ * to populate the hash, checksum, VLAN, protocol, and other fields within the
+ * skb.
+ */
+static void igc_process_skb_fields(struct igc_ring *rx_ring,
+				   union igc_adv_rx_desc *rx_desc,
+				   struct rtskb *skb)
+{
+	igc_rx_checksum(rx_ring, rx_desc, skb);
+
+	skb->protocol = rt_eth_type_trans(skb, rx_ring->netdev);
+}
+
+static inline bool igc_page_is_reserved(struct page *page)
+{
+	return (page_to_nid(page) != numa_mem_id()) || page_is_pfmemalloc(page);
+}
+
+/**
+ * igc_is_non_eop - process handling of non-EOP buffers
+ * @rx_ring: Rx ring being processed
+ * @rx_desc: Rx descriptor for current buffer
+ *
+ * This function updates next to clean.  If the buffer is an EOP buffer
+ * this function exits returning false, otherwise it will place the
+ * sk_buff in the next buffer to be chained and return true indicating
+ * that this is in fact a non-EOP buffer.
+ */
+static bool igc_is_non_eop(struct igc_ring *rx_ring,
+			   union igc_adv_rx_desc *rx_desc)
+{
+	u32 ntc = rx_ring->next_to_clean + 1;
+
+	/* fetch, update, and store next to clean */
+	ntc = (ntc < rx_ring->count) ? ntc : 0;
+	rx_ring->next_to_clean = ntc;
+
+	prefetch(IGC_RX_DESC(rx_ring, ntc));
+
+	if (likely(igc_test_staterr(rx_desc, IGC_RXD_STAT_EOP)))
+		return false;
+
+	return true;
+}
+
+/**
+ * igc_cleanup_headers - Correct corrupted or empty headers
+ * @rx_ring: rx descriptor ring packet is being transacted on
+ * @rx_desc: pointer to the EOP Rx descriptor
+ * @skb: pointer to current skb being fixed
+ *
+ * Address the case where we are pulling data in on pages only
+ * and as such no data is present in the skb header.
+ *
+ * In addition if skb is not at least 60 bytes we need to pad it so that
+ * it is large enough to qualify as a valid Ethernet frame.
+ *
+ * Returns true if an error was encountered and skb was freed.
+ */
+static bool igc_cleanup_headers(struct igc_ring *rx_ring,
+				union igc_adv_rx_desc *rx_desc,
+				struct rtskb *skb)
+{
+	if (unlikely(igc_test_staterr(rx_desc, IGC_RXDEXT_STATERR_RXE))) {
+		struct rtnet_device *netdev = rx_ring->netdev;
+
+		if (!(netdev->features & NETIF_F_RXALL)) {
+			kfree_rtskb(skb);
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static inline unsigned int igc_rx_offset(struct igc_ring *rx_ring)
+{
+	return ring_uses_build_skb(rx_ring) ? IGC_SKB_PAD : 0;
+}
+
+static bool igc_alloc_mapped_skb(struct igc_ring *rx_ring,
+				  struct igc_rx_buffer *bi)
+{
+	struct igc_adapter *adapter = rx_ring->q_vector->adapter;
+	struct rtskb *skb = bi->skb;
+	dma_addr_t dma = bi->dma;
+
+	/* since we are recycling buffers we should seldom need to alloc */
+	if (dma)
+		return true;
+
+	if (likely(!skb)) {
+		skb = rtnetdev_alloc_rtskb(adapter->netdev,
+					rx_ring->rx_buffer_len + NET_IP_ALIGN);
+		if (!skb) {
+			rx_ring->rx_stats.alloc_failed++;
+			return false;
+		}
+
+		rtskb_reserve(skb, NET_IP_ALIGN);
+		skb->rtdev = adapter->netdev;
+
+		bi->skb = skb;
+		bi->dma = rtskb_data_dma_addr(skb, 0);
+	}
+
+	return true;
+}
+
+/**
+ * igc_alloc_rx_buffers - Replace used receive buffers; packet split
+ * @rx_ring: rx descriptor ring
+ * @cleaned_count: number of buffers to clean
+ */
+static void igc_alloc_rx_buffers(struct igc_ring *rx_ring, u16 cleaned_count)
+{
+	union igc_adv_rx_desc *rx_desc;
+	u16 i = rx_ring->next_to_use;
+	struct igc_rx_buffer *bi;
+
+	/* nothing to do */
+	if (!cleaned_count)
+		return;
+
+	rx_desc = IGC_RX_DESC(rx_ring, i);
+	bi = &rx_ring->rx_buffer_info[i];
+	i -= rx_ring->count;
+
+	do {
+		if (!igc_alloc_mapped_skb(rx_ring, bi))
+			break;
+
+		/* Refresh the desc even if buffer_addrs didn't change
+		 * because each write-back erases this info.
+		 */
+		rx_desc->read.pkt_addr = cpu_to_le64(bi->dma);
+
+		rx_desc++;
+		bi++;
+		i++;
+		if (unlikely(!i)) {
+			rx_desc = IGC_RX_DESC(rx_ring, 0);
+			bi = rx_ring->rx_buffer_info;
+			i -= rx_ring->count;
+		}
+
+		/* clear the status bits for the next_to_use descriptor */
+		rx_desc->wb.upper.status_error = 0;
+
+		cleaned_count--;
+	} while (cleaned_count);
+
+	i += rx_ring->count;
+
+	if (rx_ring->next_to_use != i) {
+		/* record the next descriptor to use */
+		rx_ring->next_to_use = i;
+
+		/* Force memory writes to complete before letting h/w
+		 * know there are new descriptors to fetch.  (Only
+		 * applicable for weak-ordered memory model archs,
+		 * such as IA-64).
+		 */
+		wmb();
+		writel(i, rx_ring->tail);
+	}
+}
+
+static struct rtskb *igc_fetch_rx_buffer(struct igc_ring *rx_ring,
+					   union igc_adv_rx_desc *rx_desc)
+{
+	struct igc_rx_buffer *rx_buffer;
+	struct rtskb *skb;
+
+	rx_buffer = &rx_ring->rx_buffer_info[rx_ring->next_to_clean];
+	skb = rx_buffer->skb;
+	prefetchw(skb->data);
+
+	/* pull the header of the skb in */
+	rtskb_put(skb, le16_to_cpu(rx_desc->wb.upper.length));
+	rx_buffer->skb = NULL;
+	rx_buffer->dma = 0;
+
+	return skb;
+}
+
+static bool igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
+{
+	unsigned int total_bytes = 0, total_packets = 0;
+	struct igc_ring *rx_ring = q_vector->rx.ring;
+	u16 cleaned_count = igc_desc_unused(rx_ring);
+	nanosecs_abs_t time_stamp = rtdm_clock_read();
+	struct rtskb *skb =  rx_ring->skb;
+
+	while (likely(total_packets < budget)) {
+		union igc_adv_rx_desc *rx_desc;
+
+		/* return some buffers to hardware, one at a time is too slow */
+		if (cleaned_count >= IGC_RX_BUFFER_WRITE) {
+			igc_alloc_rx_buffers(rx_ring, cleaned_count);
+			cleaned_count = 0;
+		}
+
+		rx_desc = IGC_RX_DESC(rx_ring, rx_ring->next_to_clean);
+
+		if (!rx_desc->wb.upper.status_error)
+			break;
+
+		/* This memory barrier is needed to keep us from reading
+		 * any other fields out of the rx_desc until we know the
+		 * descriptor has been written back
+		 */
+		rmb();
+
+		skb = igc_fetch_rx_buffer(rx_ring, rx_desc);
+		skb->time_stamp = time_stamp;
+
+		cleaned_count++;
+
+		/* fetch next buffer in frame if non-eop */
+		if (igc_is_non_eop(rx_ring, rx_desc)) {
+			kfree_rtskb(skb);
+			continue;
+		}
+
+		/* verify the packet layout is correct */
+		if (igc_cleanup_headers(rx_ring, rx_desc, skb)) {
+			skb = NULL;
+			continue;
+		}
+
+		/* probably a little skewed due to removing CRC */
+		total_bytes += skb->len;
+
+		/* populate checksum, VLAN, and protocol */
+		igc_process_skb_fields(rx_ring, rx_desc, skb);
+
+		rtnetif_rx(skb);
+
+		/* reset skb pointer */
+		skb = NULL;
+
+		/* update budget accounting */
+		total_packets++;
+	}
+
+	rx_ring->rx_stats.packets += total_packets;
+	rx_ring->rx_stats.bytes += total_bytes;
+
+	q_vector->rx.total_packets += total_packets;
+	q_vector->rx.total_bytes += total_bytes;
+
+	if (cleaned_count)
+		igc_alloc_rx_buffers(rx_ring, cleaned_count);
+
+	if (total_packets)
+		rt_mark_stack_mgr(q_vector->adapter->netdev);
+
+	return total_packets < budget;
+}
+
+/**
+ * igc_clean_tx_irq - Reclaim resources after transmit completes
+ * @q_vector: pointer to q_vector containing needed info
+ *
+ * returns true if ring is completely cleaned
+ */
+static bool igc_clean_tx_irq(struct igc_q_vector *q_vector)
+{
+	struct igc_adapter *adapter = q_vector->adapter;
+	unsigned int total_bytes = 0, total_packets = 0;
+	unsigned int budget = q_vector->tx.work_limit;
+	struct igc_ring *tx_ring = q_vector->tx.ring;
+	unsigned int i = tx_ring->next_to_clean;
+	struct igc_tx_buffer *tx_buffer;
+	union igc_adv_tx_desc *tx_desc;
+
+	if (test_bit(__IGC_DOWN, &adapter->state))
+		return true;
+
+	tx_buffer = &tx_ring->tx_buffer_info[i];
+	tx_desc = IGC_TX_DESC(tx_ring, i);
+	i -= tx_ring->count;
+
+	do {
+		union igc_adv_tx_desc *eop_desc = tx_buffer->next_to_watch;
+
+		/* if next_to_watch is not set then there is no work pending */
+		if (!eop_desc)
+			break;
+
+		/* prevent any other reads prior to eop_desc */
+		smp_rmb();
+
+		/* if DD is not set pending work has not been completed */
+		if (!(eop_desc->wb.status & cpu_to_le32(IGC_TXD_STAT_DD)))
+			break;
+
+		/* clear next_to_watch to prevent false hangs */
+		tx_buffer->next_to_watch = NULL;
+
+		/* update the statistics for this packet */
+		total_bytes += tx_buffer->bytecount;
+		total_packets += tx_buffer->gso_segs;
+
+		/* free the skb */
+		kfree_rtskb(tx_buffer->skb);
+
+		/* clear tx_buffer data */
+		tx_buffer->skb = NULL;
+
+		/* clear last DMA location and unmap remaining buffers */
+		while (tx_desc != eop_desc) {
+			tx_buffer++;
+			tx_desc++;
+			i++;
+			if (unlikely(!i)) {
+				i -= tx_ring->count;
+				tx_buffer = tx_ring->tx_buffer_info;
+				tx_desc = IGC_TX_DESC(tx_ring, 0);
+			}
+
+		}
+
+		/* move us one more past the eop_desc for start of next pkt */
+		tx_buffer++;
+		tx_desc++;
+		i++;
+		if (unlikely(!i)) {
+			i -= tx_ring->count;
+			tx_buffer = tx_ring->tx_buffer_info;
+			tx_desc = IGC_TX_DESC(tx_ring, 0);
+		}
+
+		/* issue prefetch for next Tx descriptor */
+		prefetch(tx_desc);
+
+		/* update budget accounting */
+		budget--;
+	} while (likely(budget));
+
+	i += tx_ring->count;
+	tx_ring->next_to_clean = i;
+	tx_ring->tx_stats.bytes += total_bytes;
+	tx_ring->tx_stats.packets += total_packets;
+	q_vector->tx.total_bytes += total_bytes;
+	q_vector->tx.total_packets += total_packets;
+
+	if (test_bit(IGC_RING_FLAG_TX_DETECT_HANG, &tx_ring->flags)) {
+		struct igc_hw *hw = &adapter->hw;
+
+		/* Detect a transmit hang in hardware, this serializes the
+		 * check with the clearing of time_stamp and movement of i
+		 */
+		clear_bit(IGC_RING_FLAG_TX_DETECT_HANG, &tx_ring->flags);
+		if (tx_buffer->next_to_watch &&
+		    time_after(jiffies, tx_buffer->time_stamp +
+		    (adapter->tx_timeout_factor * HZ)) &&
+		    !(rd32(IGC_STATUS) & IGC_STATUS_TXOFF)) {
+			/* detected Tx unit hang */
+			rtdev_err(tx_ring->netdev,
+				   "Detected Tx Unit Hang\n"
+				   "  Tx Queue             <%d>\n"
+				   "  TDH                  <%x>\n"
+				   "  TDT                  <%x>\n"
+				   "  next_to_use          <%x>\n"
+				   "  next_to_clean        <%x>\n"
+				   "buffer_info[next_to_clean]\n"
+				   "  time_stamp           <%lx>\n"
+				   "  next_to_watch        <%p>\n"
+				   "  jiffies              <%lx>\n"
+				   "  desc.status          <%x>\n",
+				   tx_ring->queue_index,
+				   rd32(IGC_TDH(tx_ring->reg_idx)),
+				   readl(tx_ring->tail),
+				   tx_ring->next_to_use,
+				   tx_ring->next_to_clean,
+				   tx_buffer->time_stamp,
+				   tx_buffer->next_to_watch,
+				   jiffies,
+				   tx_buffer->next_to_watch->wb.status);
+			rtnetif_stop_queue(tx_ring->netdev);
+
+			/* we are about to reset, no point in enabling stuff */
+			return true;
+		}
+	}
+
+#define TX_WAKE_THRESHOLD (DESC_NEEDED * 2)
+	if (unlikely(total_packets &&
+		     rtnetif_carrier_ok(tx_ring->netdev) &&
+		     igc_desc_unused(tx_ring) >= TX_WAKE_THRESHOLD)) {
+		/* Make sure that anybody stopping the queue after this
+		 * sees the new next_to_clean.
+		 */
+		smp_mb();
+		if (rtnetif_queue_stopped(tx_ring->netdev) &&
+		    !(test_bit(__IGC_DOWN, &adapter->state))) {
+			rtnetif_wake_queue(tx_ring->netdev);
+
+			tx_ring->tx_stats.restart_queue++;
+		}
+	}
+
+	return !!budget;
+}
+
+/**
+ *  igc_write_uc_addr_list - write unicast addresses to RAR table
+ *  @netdev: network interface device structure
+ *
+ *  Writes unicast address list to the RAR table.
+ *  Returns: -ENOMEM on failure/insufficient address space
+ *           0 on no addresses written
+ *           X on writing X addresses to the RAR table
+ **/
+static int igc_write_uc_addr_list(struct rtnet_device *netdev)
+{
+	struct igc_adapter *adapter = rtnetdev_priv(netdev);
+	struct igc_hw *hw = &adapter->hw;
+	unsigned int vfn = 0;
+	unsigned int rar_entries = hw->mac.rar_entry_count - (vfn + 1);
+	int count = 0;
+
+
+	/* write the addresses in reverse order to avoid write combining */
+	for (; rar_entries > 0 ; rar_entries--) {
+		wr32(IGC_RAH(rar_entries), 0);
+		wr32(IGC_RAL(rar_entries), 0);
+	}
+
+	wrfl();
+
+	return count;
+}
+
+
+/**
+ * igc_set_rx_mode - Secondary Unicast, Multicast and Promiscuous mode set
+ * @netdev: network interface device structure
+ *
+ * The set_rx_mode entry point is called whenever the unicast or multicast
+ * address lists or the network interface flags are updated.  This routine is
+ * responsible for configuring the hardware for proper unicast, multicast,
+ * promiscuous mode, and all-multi behavior.
+ */
+static void igc_set_rx_mode(struct rtnet_device *netdev)
+{
+	struct igc_adapter *adapter = rtnetdev_priv(netdev);
+	struct igc_hw *hw = &adapter->hw;
+	u32 rctl = 0, rlpml = MAX_JUMBO_FRAME_SIZE;
+	int count = 0;
+
+	/* Check for Promiscuous and All Multicast modes */
+	if (netdev->flags & IFF_PROMISC) {
+		rctl |= IGC_RCTL_UPE | IGC_RCTL_MPE;
+	} else {
+		if (netdev->flags & IFF_ALLMULTI) {
+			rctl |= IGC_RCTL_MPE;
+		} else {
+			/* Write addresses to the MTA, if the attempt fails
+			 * then we should just turn on promiscuous mode so
+			 * that we can at least receive multicast traffic
+			 */
+			count = igc_write_mc_addr_list(netdev);
+			if (count < 0)
+				rctl |= IGC_RCTL_MPE;
+		}
+	}
+
+	/* Write addresses to available RAR registers, if there is not
+	 * sufficient space to store all the addresses then enable
+	 * unicast promiscuous mode
+	 */
+	count = igc_write_uc_addr_list(netdev);
+
+	if (count < 0)
+		rctl |= IGC_RCTL_UPE;
+
+	/* update state of unicast and multicast */
+	rctl |= rd32(IGC_RCTL) & ~(IGC_RCTL_UPE | IGC_RCTL_MPE);
+	wr32(IGC_RCTL, rctl);
+
+	wr32(IGC_RLPML, rlpml);
+}
+
+/**
+ * igc_configure - configure the hardware for RX and TX
+ * @adapter: private board structure
+ */
+static void igc_configure(struct igc_adapter *adapter)
+{
+	struct rtnet_device *netdev = adapter->netdev;
+	int i = 0;
+
+	igc_get_hw_control(adapter);
+	igc_set_rx_mode(netdev);
+
+	igc_setup_tctl(adapter);
+	igc_setup_mrqc(adapter);
+	igc_setup_rctl(adapter);
+
+	igc_configure_tx(adapter);
+	igc_configure_rx(adapter);
+
+	igc_rx_fifo_flush_base(&adapter->hw);
+
+	/* call igc_desc_unused which always leaves
+	 * at least 1 descriptor unused to make sure
+	 * next_to_use != next_to_clean
+	 */
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		struct igc_ring *ring = adapter->rx_ring[i];
+
+		igc_alloc_rx_buffers(ring, igc_desc_unused(ring));
+	}
+}
+
+/**
+ * igc_write_ivar - configure ivar for given MSI-X vector
+ * @hw: pointer to the HW structure
+ * @msix_vector: vector number we are allocating to a given ring
+ * @index: row index of IVAR register to write within IVAR table
+ * @offset: column offset of in IVAR, should be multiple of 8
+ *
+ * The IVAR table consists of 2 columns,
+ * each containing an cause allocation for an Rx and Tx ring, and a
+ * variable number of rows depending on the number of queues supported.
+ */
+static void igc_write_ivar(struct igc_hw *hw, int msix_vector,
+			   int index, int offset)
+{
+	u32 ivar = array_rd32(IGC_IVAR0, index);
+
+	/* clear any bits that are currently set */
+	ivar &= ~((u32)0xFF << offset);
+
+	/* write vector and valid bit */
+	ivar |= (msix_vector | IGC_IVAR_VALID) << offset;
+
+	array_wr32(IGC_IVAR0, index, ivar);
+}
+
+static void igc_assign_vector(struct igc_q_vector *q_vector, int msix_vector)
+{
+	struct igc_adapter *adapter = q_vector->adapter;
+	struct igc_hw *hw = &adapter->hw;
+	int rx_queue = IGC_N0_QUEUE;
+	int tx_queue = IGC_N0_QUEUE;
+
+	if (q_vector->rx.ring)
+		rx_queue = q_vector->rx.ring->reg_idx;
+	if (q_vector->tx.ring)
+		tx_queue = q_vector->tx.ring->reg_idx;
+
+	switch (hw->mac.type) {
+	case igc_i225:
+		if (rx_queue > IGC_N0_QUEUE)
+			igc_write_ivar(hw, msix_vector,
+				       rx_queue >> 1,
+				       (rx_queue & 0x1) << 4);
+		if (tx_queue > IGC_N0_QUEUE)
+			igc_write_ivar(hw, msix_vector,
+				       tx_queue >> 1,
+				       ((tx_queue & 0x1) << 4) + 8);
+		q_vector->eims_value = BIT(msix_vector);
+		break;
+	default:
+		WARN_ONCE(hw->mac.type != igc_i225, "Wrong MAC type\n");
+		break;
+	}
+
+	/* add q_vector eims value to global eims_enable_mask */
+	adapter->eims_enable_mask |= q_vector->eims_value;
+
+	/* configure q_vector to set itr on first interrupt */
+	q_vector->set_itr = 1;
+}
+
+/**
+ * igc_configure_msix - Configure MSI-X hardware
+ * @adapter: Pointer to adapter structure
+ *
+ * igc_configure_msix sets up the hardware to properly
+ * generate MSI-X interrupts.
+ */
+static void igc_configure_msix(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+	int i, vector = 0;
+	u32 tmp;
+
+	adapter->eims_enable_mask = 0;
+
+	/* set vector for other causes, i.e. link changes */
+	switch (hw->mac.type) {
+	case igc_i225:
+		/* Turn on MSI-X capability first, or our settings
+		 * won't stick.  And it will take days to debug.
+		 */
+		wr32(IGC_GPIE, IGC_GPIE_MSIX_MODE |
+		     IGC_GPIE_PBA | IGC_GPIE_EIAME |
+		     IGC_GPIE_NSICR);
+
+		/* enable msix_other interrupt */
+		adapter->eims_other = BIT(vector);
+		tmp = (vector++ | IGC_IVAR_VALID) << 8;
+
+		wr32(IGC_IVAR_MISC, tmp);
+		break;
+	default:
+		/* do nothing, since nothing else supports MSI-X */
+		break;
+	} /* switch (hw->mac.type) */
+
+	adapter->eims_enable_mask |= adapter->eims_other;
+
+	for (i = 0; i < adapter->num_q_vectors; i++)
+		igc_assign_vector(adapter->q_vector[i], vector++);
+
+	wrfl();
+}
+
+/**
+ * igc_irq_enable - Enable default interrupt generation settings
+ * @adapter: board private structure
+ */
+static void igc_irq_enable(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+
+	if (adapter->msix_entries) {
+		u32 ims = IGC_IMS_LSC | IGC_IMS_DOUTSYNC | IGC_IMS_DRSTA;
+		u32 regval = rd32(IGC_EIAC);
+
+		wr32(IGC_EIAC, regval | adapter->eims_enable_mask);
+		regval = rd32(IGC_EIAM);
+		wr32(IGC_EIAM, regval | adapter->eims_enable_mask);
+		wr32(IGC_EIMS, adapter->eims_enable_mask);
+		wr32(IGC_IMS, ims);
+	} else {
+		wr32(IGC_IMS, IMS_ENABLE_MASK | IGC_IMS_DRSTA);
+		wr32(IGC_IAM, IMS_ENABLE_MASK | IGC_IMS_DRSTA);
+	}
+}
+
+/**
+ * igc_irq_disable - Mask off interrupt generation on the NIC
+ * @adapter: board private structure
+ */
+static void igc_irq_disable(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+
+	if (adapter->msix_entries) {
+		u32 regval = rd32(IGC_EIAM);
+
+		wr32(IGC_EIAM, regval & ~adapter->eims_enable_mask);
+		wr32(IGC_EIMC, adapter->eims_enable_mask);
+		regval = rd32(IGC_EIAC);
+		wr32(IGC_EIAC, regval & ~adapter->eims_enable_mask);
+	}
+
+	wr32(IGC_IAM, 0);
+	wr32(IGC_IMC, ~0);
+	wrfl();
+
+	msleep(10);
+
+}
+
+void igc_set_flag_queue_pairs(struct igc_adapter *adapter,
+			      const u32 max_rss_queues)
+{
+	/* Determine if we need to pair queues. */
+	/* If rss_queues > half of max_rss_queues, pair the queues in
+	 * order to conserve interrupts due to limited supply.
+	 */
+	if (adapter->rss_queues > (max_rss_queues / 2))
+		adapter->flags |= IGC_FLAG_QUEUE_PAIRS;
+	else
+		adapter->flags &= ~IGC_FLAG_QUEUE_PAIRS;
+}
+
+unsigned int igc_get_max_rss_queues(struct igc_adapter *adapter)
+{
+	return IGC_MAX_RX_QUEUES;
+}
+
+static void igc_init_queue_configuration(struct igc_adapter *adapter)
+{
+	u32 max_rss_queues;
+
+	max_rss_queues = igc_get_max_rss_queues(adapter);
+	adapter->rss_queues = min_t(u32, max_rss_queues, num_online_cpus());
+
+	igc_set_flag_queue_pairs(adapter, max_rss_queues);
+}
+
+/**
+ * igc_reset_q_vector - Reset config for interrupt vector
+ * @adapter: board private structure to initialize
+ * @v_idx: Index of vector to be reset
+ *
+ * If NAPI is enabled it will delete any references to the
+ * NAPI struct. This is preparation for igc_free_q_vector.
+ */
+static void igc_reset_q_vector(struct igc_adapter *adapter, int v_idx)
+{
+	struct igc_q_vector *q_vector = adapter->q_vector[v_idx];
+
+	/* if we're coming from igc_set_interrupt_capability, the vectors are
+	 * not yet allocated
+	 */
+	if (!q_vector)
+		return;
+
+	if (q_vector->tx.ring)
+		adapter->tx_ring[q_vector->tx.ring->queue_index] = NULL;
+
+	if (q_vector->rx.ring)
+		adapter->rx_ring[q_vector->rx.ring->queue_index] = NULL;
+}
+
+/**
+ * igc_free_q_vector - Free memory allocated for specific interrupt vector
+ * @adapter: board private structure to initialize
+ * @v_idx: Index of vector to be freed
+ *
+ * This function frees the memory allocated to the q_vector.
+ */
+static void igc_free_q_vector(struct igc_adapter *adapter, int v_idx)
+{
+	struct igc_q_vector *q_vector = adapter->q_vector[v_idx];
+
+	adapter->q_vector[v_idx] = NULL;
+
+	/* igc_get_stats64() might access the rings on this vector,
+	 * we must wait a grace period before freeing it.
+	 */
+	if (q_vector)
+		kfree_rcu(q_vector, rcu);
+}
+
+/**
+ * igc_free_q_vectors - Free memory allocated for interrupt vectors
+ * @adapter: board private structure to initialize
+ *
+ * This function frees the memory allocated to the q_vectors.  In addition if
+ * NAPI is enabled it will delete any references to the NAPI struct prior
+ * to freeing the q_vector.
+ */
+static void igc_free_q_vectors(struct igc_adapter *adapter)
+{
+	int v_idx = adapter->num_q_vectors;
+
+	adapter->num_tx_queues = 0;
+	adapter->num_rx_queues = 0;
+	adapter->num_q_vectors = 0;
+
+	while (v_idx--) {
+		igc_reset_q_vector(adapter, v_idx);
+		igc_free_q_vector(adapter, v_idx);
+	}
+}
+
+/**
+ * igc_update_itr - update the dynamic ITR value based on statistics
+ * @q_vector: pointer to q_vector
+ * @ring_container: ring info to update the itr for
+ *
+ * Stores a new ITR value based on packets and byte
+ * counts during the last interrupt.  The advantage of per interrupt
+ * computation is faster updates and more accurate ITR for the current
+ * traffic pattern.  Constants in this function were computed
+ * based on theoretical maximum wire speed and thresholds were set based
+ * on testing data as well as attempting to minimize response time
+ * while increasing bulk throughput.
+ * NOTE: These calculations are only valid when operating in a single-
+ * queue environment.
+ */
+static void igc_update_itr(struct igc_q_vector *q_vector,
+			   struct igc_ring_container *ring_container)
+{
+	unsigned int packets = ring_container->total_packets;
+	unsigned int bytes = ring_container->total_bytes;
+	u8 itrval = ring_container->itr;
+
+	/* no packets, exit with status unchanged */
+	if (packets == 0)
+		return;
+
+	switch (itrval) {
+	case lowest_latency:
+		/* handle TSO and jumbo frames */
+		if (bytes / packets > 8000)
+			itrval = bulk_latency;
+		else if ((packets < 5) && (bytes > 512))
+			itrval = low_latency;
+		break;
+	case low_latency:  /* 50 usec aka 20000 ints/s */
+		if (bytes > 10000) {
+			/* this if handles the TSO accounting */
+			if (bytes / packets > 8000)
+				itrval = bulk_latency;
+			else if ((packets < 10) || ((bytes / packets) > 1200))
+				itrval = bulk_latency;
+			else if ((packets > 35))
+				itrval = lowest_latency;
+		} else if (bytes / packets > 2000) {
+			itrval = bulk_latency;
+		} else if (packets <= 2 && bytes < 512) {
+			itrval = lowest_latency;
+		}
+		break;
+	case bulk_latency: /* 250 usec aka 4000 ints/s */
+		if (bytes > 25000) {
+			if (packets > 35)
+				itrval = low_latency;
+		} else if (bytes < 1500) {
+			itrval = low_latency;
+		}
+		break;
+	}
+
+	/* clear work counters since we have the values we need */
+	ring_container->total_bytes = 0;
+	ring_container->total_packets = 0;
+
+	/* write updated itr to ring container */
+	ring_container->itr = itrval;
+}
+
+static void igc_set_itr(struct igc_q_vector *q_vector)
+{
+	struct igc_adapter *adapter = q_vector->adapter;
+	u32 new_itr = q_vector->itr_val;
+	u8 current_itr = 0;
+
+	if (!InterruptThrottle)
+		return;
+
+	/* for non-gigabit speeds, just fix the interrupt rate at 4000 */
+	switch (adapter->link_speed) {
+	case SPEED_10:
+	case SPEED_100:
+		current_itr = 0;
+		new_itr = IGC_4K_ITR;
+		goto set_itr_now;
+	default:
+		break;
+	}
+
+	igc_update_itr(q_vector, &q_vector->tx);
+	igc_update_itr(q_vector, &q_vector->rx);
+
+	current_itr = max(q_vector->rx.itr, q_vector->tx.itr);
+
+	/* conservative mode (itr 3) eliminates the lowest_latency setting */
+	if (current_itr == lowest_latency &&
+	    ((q_vector->rx.ring && adapter->rx_itr_setting == 3) ||
+	    (!q_vector->rx.ring && adapter->tx_itr_setting == 3)))
+		current_itr = low_latency;
+
+	switch (current_itr) {
+	/* counts and packets in update_itr are dependent on these numbers */
+	case lowest_latency:
+		new_itr = IGC_70K_ITR; /* 70,000 ints/sec */
+		break;
+	case low_latency:
+		new_itr = IGC_20K_ITR; /* 20,000 ints/sec */
+		break;
+	case bulk_latency:
+		new_itr = IGC_4K_ITR;  /* 4,000 ints/sec */
+		break;
+	default:
+		break;
+	}
+
+set_itr_now:
+	if (new_itr != q_vector->itr_val) {
+		/* this attempts to bias the interrupt rate towards Bulk
+		 * by adding intermediate steps when interrupt rate is
+		 * increasing
+		 */
+		new_itr = new_itr > q_vector->itr_val ?
+			  max((new_itr * q_vector->itr_val) /
+			  (new_itr + (q_vector->itr_val >> 2)),
+			  new_itr) : new_itr;
+		/* Don't write the value here; it resets the adapter's
+		 * internal timer, and causes us to delay far longer than
+		 * we should between interrupts.  Instead, we write the ITR
+		 * value at the beginning of the next interrupt so the timing
+		 * ends up being correct.
+		 */
+		q_vector->itr_val = new_itr;
+		q_vector->set_itr = 1;
+	}
+}
+
+static void igc_reset_interrupt_capability(struct igc_adapter *adapter)
+{
+	int v_idx = adapter->num_q_vectors;
+
+	if (adapter->msix_entries) {
+		pci_disable_msix(adapter->pdev);
+		kfree(adapter->msix_entries);
+		adapter->msix_entries = NULL;
+	} else if (adapter->flags & IGC_FLAG_HAS_MSI) {
+		pci_disable_msi(adapter->pdev);
+	}
+
+	while (v_idx--)
+		igc_reset_q_vector(adapter, v_idx);
+}
+
+/**
+ * igc_set_interrupt_capability - set MSI or MSI-X if supported
+ * @adapter: Pointer to adapter structure
+ * @msix: boolean value for MSI-X capability
+ *
+ * Attempt to configure interrupts using the best available
+ * capabilities of the hardware and kernel.
+ */
+static void igc_set_interrupt_capability(struct igc_adapter *adapter,
+					 bool msix)
+{
+	int numvecs, i;
+	int err;
+
+	if (!msix)
+		goto msi_only;
+	adapter->flags |= IGC_FLAG_HAS_MSIX;
+
+	/* Number of supported queues. */
+	adapter->num_rx_queues = adapter->rss_queues;
+
+	adapter->num_tx_queues = adapter->rss_queues;
+
+	/* start with one vector for every Rx queue */
+	numvecs = adapter->num_rx_queues;
+
+	/* if Tx handler is separate add 1 for every Tx queue */
+	if (!(adapter->flags & IGC_FLAG_QUEUE_PAIRS))
+		numvecs += adapter->num_tx_queues;
+
+	/* store the number of vectors reserved for queues */
+	adapter->num_q_vectors = numvecs;
+
+	/* add 1 vector for link status interrupts */
+	numvecs++;
+
+	adapter->msix_entries = kcalloc(numvecs, sizeof(struct msix_entry),
+					GFP_KERNEL);
+
+	if (!adapter->msix_entries)
+		return;
+
+	/* populate entry values */
+	for (i = 0; i < numvecs; i++)
+		adapter->msix_entries[i].entry = i;
+
+	err = pci_enable_msix_range(adapter->pdev,
+				    adapter->msix_entries,
+				    numvecs,
+				    numvecs);
+	if (err > 0)
+		return;
+
+	kfree(adapter->msix_entries);
+	adapter->msix_entries = NULL;
+
+	igc_reset_interrupt_capability(adapter);
+
+msi_only:
+	adapter->flags &= ~IGC_FLAG_HAS_MSIX;
+
+	adapter->rss_queues = 1;
+	adapter->flags |= IGC_FLAG_QUEUE_PAIRS;
+	adapter->num_rx_queues = 1;
+	adapter->num_tx_queues = 1;
+	adapter->num_q_vectors = 1;
+	if (!pci_enable_msi(adapter->pdev))
+		adapter->flags |= IGC_FLAG_HAS_MSI;
+}
+
+/**
+ * igc_update_ring_itr - update the dynamic ITR value based on packet size
+ * @q_vector: pointer to q_vector
+ *
+ * Stores a new ITR value based on strictly on packet size.  This
+ * algorithm is less sophisticated than that used in igc_update_itr,
+ * due to the difficulty of synchronizing statistics across multiple
+ * receive rings.  The divisors and thresholds used by this function
+ * were determined based on theoretical maximum wire speed and testing
+ * data, in order to minimize response time while increasing bulk
+ * throughput.
+ * NOTE: This function is called only when operating in a multiqueue
+ * receive environment.
+ */
+static void igc_update_ring_itr(struct igc_q_vector *q_vector)
+{
+	struct igc_adapter *adapter = q_vector->adapter;
+	int new_val = q_vector->itr_val;
+	int avg_wire_size = 0;
+	unsigned int packets;
+
+	/* For non-gigabit speeds, just fix the interrupt rate at 4000
+	 * ints/sec - ITR timer value of 120 ticks.
+	 */
+	switch (adapter->link_speed) {
+	case SPEED_10:
+	case SPEED_100:
+		new_val = IGC_4K_ITR;
+		goto set_itr_val;
+	default:
+		break;
+	}
+
+	packets = q_vector->rx.total_packets;
+	if (packets)
+		avg_wire_size = q_vector->rx.total_bytes / packets;
+
+	packets = q_vector->tx.total_packets;
+	if (packets)
+		avg_wire_size = max_t(u32, avg_wire_size,
+				      q_vector->tx.total_bytes / packets);
+
+	/* if avg_wire_size isn't set no work was done */
+	if (!avg_wire_size)
+		goto clear_counts;
+
+	/* Add 24 bytes to size to account for CRC, preamble, and gap */
+	avg_wire_size += 24;
+
+	/* Don't starve jumbo frames */
+	avg_wire_size = min(avg_wire_size, 3000);
+
+	/* Give a little boost to mid-size frames */
+	if (avg_wire_size > 300 && avg_wire_size < 1200)
+		new_val = avg_wire_size / 3;
+	else
+		new_val = avg_wire_size / 2;
+
+	/* conservative mode (itr 3) eliminates the lowest_latency setting */
+	if (new_val < IGC_20K_ITR &&
+	    ((q_vector->rx.ring && adapter->rx_itr_setting == 3) ||
+	    (!q_vector->rx.ring && adapter->tx_itr_setting == 3)))
+		new_val = IGC_20K_ITR;
+
+set_itr_val:
+	if (new_val != q_vector->itr_val) {
+		q_vector->itr_val = new_val;
+		q_vector->set_itr = 1;
+	}
+clear_counts:
+	q_vector->rx.total_bytes = 0;
+	q_vector->rx.total_packets = 0;
+	q_vector->tx.total_bytes = 0;
+	q_vector->tx.total_packets = 0;
+}
+
+static void igc_ring_irq_enable(struct igc_q_vector *q_vector)
+{
+	struct igc_adapter *adapter = q_vector->adapter;
+	struct igc_hw *hw = &adapter->hw;
+
+	if ((q_vector->rx.ring && (adapter->rx_itr_setting & 3)) ||
+	    (!q_vector->rx.ring && (adapter->tx_itr_setting & 3))) {
+		if (adapter->num_q_vectors == 1)
+			igc_set_itr(q_vector);
+		else
+			igc_update_ring_itr(q_vector);
+	}
+
+	if (!test_bit(__IGC_DOWN, &adapter->state)) {
+		if (adapter->msix_entries)
+			wr32(IGC_EIMS, q_vector->eims_value);
+		else
+			igc_irq_enable(adapter);
+	}
+}
+
+static void igc_add_ring(struct igc_ring *ring,
+			 struct igc_ring_container *head)
+{
+	head->ring = ring;
+	head->count++;
+}
+
+/**
+ * igc_cache_ring_register - Descriptor ring to register mapping
+ * @adapter: board private structure to initialize
+ *
+ * Once we know the feature-set enabled for the device, we'll cache
+ * the register offset the descriptor ring is assigned to.
+ */
+static void igc_cache_ring_register(struct igc_adapter *adapter)
+{
+	int i = 0, j = 0;
+
+	switch (adapter->hw.mac.type) {
+	case igc_i225:
+	default:
+		for (; i < adapter->num_rx_queues; i++)
+			adapter->rx_ring[i]->reg_idx = i;
+		for (; j < adapter->num_tx_queues; j++)
+			adapter->tx_ring[j]->reg_idx = j;
+		break;
+	}
+}
+
+/**
+ * igc_alloc_q_vector - Allocate memory for a single interrupt vector
+ * @adapter: board private structure to initialize
+ * @v_count: q_vectors allocated on adapter, used for ring interleaving
+ * @v_idx: index of vector in adapter struct
+ * @txr_count: total number of Tx rings to allocate
+ * @txr_idx: index of first Tx ring to allocate
+ * @rxr_count: total number of Rx rings to allocate
+ * @rxr_idx: index of first Rx ring to allocate
+ *
+ * We allocate one q_vector.  If allocation fails we return -ENOMEM.
+ */
+static int igc_alloc_q_vector(struct igc_adapter *adapter,
+			      unsigned int v_count, unsigned int v_idx,
+			      unsigned int txr_count, unsigned int txr_idx,
+			      unsigned int rxr_count, unsigned int rxr_idx)
+{
+	struct igc_q_vector *q_vector;
+	struct igc_ring *ring;
+	int ring_count, size;
+
+	/* igc only supports 1 Tx and/or 1 Rx queue per vector */
+	if (txr_count > 1 || rxr_count > 1)
+		return -ENOMEM;
+
+	ring_count = txr_count + rxr_count;
+
+	/* allocate q_vector and rings */
+	q_vector = adapter->q_vector[v_idx];
+	size = sizeof(struct igc_q_vector) +
+		(sizeof(struct igc_ring) * ring_count);
+
+	if (!q_vector)
+		q_vector = kzalloc(size,
+				   GFP_KERNEL);
+	else
+		memset(q_vector, 0, size);
+
+	if (!q_vector)
+		return -ENOMEM;
+
+	/* tie q_vector and adapter together */
+	adapter->q_vector[v_idx] = q_vector;
+	q_vector->adapter = adapter;
+
+	/* initialize work limits */
+	q_vector->tx.work_limit = adapter->tx_work_limit;
+
+	/* initialize ITR configuration */
+	q_vector->itr_register = adapter->io_addr + IGC_EITR(0);
+	q_vector->itr_val = IGC_START_ITR;
+
+	/* initialize pointer to rings */
+	ring = q_vector->ring;
+
+	/* initialize ITR */
+	if (rxr_count) {
+		/* rx or rx/tx vector */
+		if (!adapter->rx_itr_setting || adapter->rx_itr_setting > 3)
+			q_vector->itr_val = adapter->rx_itr_setting;
+	} else {
+		/* tx only vector */
+		if (!adapter->tx_itr_setting || adapter->tx_itr_setting > 3)
+			q_vector->itr_val = adapter->tx_itr_setting;
+	}
+
+	if (txr_count) {
+		/* assign generic ring traits */
+		ring->dev = &adapter->pdev->dev;
+		ring->netdev = adapter->netdev;
+
+		/* configure backlink on ring */
+		ring->q_vector = q_vector;
+
+		/* update q_vector Tx values */
+		igc_add_ring(ring, &q_vector->tx);
+
+		/* apply Tx specific ring traits */
+		ring->count = adapter->tx_ring_count;
+		ring->queue_index = txr_idx;
+
+		/* assign ring to adapter */
+		adapter->tx_ring[txr_idx] = ring;
+
+		/* push pointer to next ring */
+		ring++;
+	}
+
+	if (rxr_count) {
+		/* assign generic ring traits */
+		ring->dev = &adapter->pdev->dev;
+		ring->netdev = adapter->netdev;
+
+		/* configure backlink on ring */
+		ring->q_vector = q_vector;
+
+		/* update q_vector Rx values */
+		igc_add_ring(ring, &q_vector->rx);
+
+		/* apply Rx specific ring traits */
+		ring->count = adapter->rx_ring_count;
+		ring->queue_index = rxr_idx;
+
+		/* assign ring to adapter */
+		adapter->rx_ring[rxr_idx] = ring;
+	}
+
+	return 0;
+}
+
+/**
+ * igc_alloc_q_vectors - Allocate memory for interrupt vectors
+ * @adapter: board private structure to initialize
+ *
+ * We allocate one q_vector per queue interrupt.  If allocation fails we
+ * return -ENOMEM.
+ */
+static int igc_alloc_q_vectors(struct igc_adapter *adapter)
+{
+	int rxr_remaining = adapter->num_rx_queues;
+	int txr_remaining = adapter->num_tx_queues;
+	int rxr_idx = 0, txr_idx = 0, v_idx = 0;
+	int q_vectors = adapter->num_q_vectors;
+	int err;
+
+	if (q_vectors >= (rxr_remaining + txr_remaining)) {
+		for (; rxr_remaining; v_idx++) {
+			err = igc_alloc_q_vector(adapter, q_vectors, v_idx,
+						 0, 0, 1, rxr_idx);
+
+			if (err)
+				goto err_out;
+
+			/* update counts and index */
+			rxr_remaining--;
+			rxr_idx++;
+		}
+	}
+
+	for (; v_idx < q_vectors; v_idx++) {
+		int rqpv = DIV_ROUND_UP(rxr_remaining, q_vectors - v_idx);
+		int tqpv = DIV_ROUND_UP(txr_remaining, q_vectors - v_idx);
+
+		err = igc_alloc_q_vector(adapter, q_vectors, v_idx,
+					 tqpv, txr_idx, rqpv, rxr_idx);
+
+		if (err)
+			goto err_out;
+
+		/* update counts and index */
+		rxr_remaining -= rqpv;
+		txr_remaining -= tqpv;
+		rxr_idx++;
+		txr_idx++;
+	}
+
+	return 0;
+
+err_out:
+	adapter->num_tx_queues = 0;
+	adapter->num_rx_queues = 0;
+	adapter->num_q_vectors = 0;
+
+	while (v_idx--)
+		igc_free_q_vector(adapter, v_idx);
+
+	return -ENOMEM;
+}
+
+/**
+ * igc_init_interrupt_scheme - initialize interrupts, allocate queues/vectors
+ * @adapter: Pointer to adapter structure
+ * @msix: boolean for MSI-X capability
+ *
+ * This function initializes the interrupts and allocates all of the queues.
+ */
+static int igc_init_interrupt_scheme(struct igc_adapter *adapter, bool msix)
+{
+	struct rtnet_device *dev = adapter->netdev;
+	int err = 0;
+
+	igc_set_interrupt_capability(adapter, msix);
+
+	err = igc_alloc_q_vectors(adapter);
+	if (err) {
+		rtdev_err(dev, "Unable to allocate memory for vectors\n");
+		goto err_alloc_q_vectors;
+	}
+
+	igc_cache_ring_register(adapter);
+
+	return 0;
+
+err_alloc_q_vectors:
+	igc_reset_interrupt_capability(adapter);
+	return err;
+}
+
+/**
+ * igc_sw_init - Initialize general software structures (struct igc_adapter)
+ * @adapter: board private structure to initialize
+ *
+ * igc_sw_init initializes the Adapter private data structure.
+ * Fields are initialized based on PCI device information and
+ * OS network device settings (MTU size).
+ */
+static int igc_sw_init(struct igc_adapter *adapter)
+{
+	struct rtnet_device *netdev = adapter->netdev;
+	struct pci_dev *pdev = adapter->pdev;
+	struct igc_hw *hw = &adapter->hw;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &hw->bus.pci_cmd_word);
+
+	/* set default ring sizes */
+	adapter->tx_ring_count = IGC_DEFAULT_TXD;
+	adapter->rx_ring_count = IGC_DEFAULT_RXD;
+
+	/* set default ITR values */
+	if (InterruptThrottle) {
+		adapter->rx_itr_setting = IGC_DEFAULT_ITR;
+		adapter->tx_itr_setting = IGC_DEFAULT_ITR;
+	} else {
+		adapter->rx_itr_setting = IGC_MIN_ITR_USECS;
+		adapter->tx_itr_setting = IGC_MIN_ITR_USECS;
+	}
+
+
+	/* set default work limits */
+	adapter->tx_work_limit = IGC_DEFAULT_TX_WORK;
+
+	/* adjust max frame to be at least the size of a standard frame */
+	adapter->max_frame_size = netdev->mtu + ETH_HLEN + ETH_FCS_LEN +
+				VLAN_HLEN;
+	adapter->min_frame_size = ETH_ZLEN + ETH_FCS_LEN;
+
+	mutex_init(&adapter->nfc_rule_lock);
+	INIT_LIST_HEAD(&adapter->nfc_rule_list);
+	adapter->nfc_rule_count = 0;
+
+	spin_lock_init(&adapter->stats64_lock);
+	/* Assume MSI-X interrupts, will be checked during IRQ allocation */
+	adapter->flags |= IGC_FLAG_HAS_MSIX;
+
+	igc_init_queue_configuration(adapter);
+
+	/* This call may decrease the number of queues */
+	if (igc_init_interrupt_scheme(adapter, true)) {
+		rtdev_err(netdev, "Unable to allocate memory for queues\n");
+		return -ENOMEM;
+	}
+
+	/* Explicitly disable IRQ since the NIC can be in any state. */
+	igc_irq_disable(adapter);
+
+	set_bit(__IGC_DOWN, &adapter->state);
+
+	return 0;
+}
+
+/**
+ * igc_up - Open the interface and prepare it to handle traffic
+ * @adapter: board private structure
+ */
+void igc_up(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+
+	/* hardware has been reset, we need to reload some things */
+	igc_configure(adapter);
+
+	clear_bit(__IGC_DOWN, &adapter->state);
+
+	if (adapter->msix_entries)
+		igc_configure_msix(adapter);
+	else
+		igc_assign_vector(adapter->q_vector[0], 0);
+
+	/* Clear any pending interrupts. */
+	rd32(IGC_ICR);
+	igc_irq_enable(adapter);
+
+	rtnetif_start_queue(adapter->netdev);
+
+	/* start the watchdog. */
+	hw->mac.get_link_status = 1;
+	schedule_work(&adapter->watchdog_task);
+}
+
+/**
+ * igc_update_stats - Update the board statistics counters
+ * @adapter: board private structure
+ */
+void igc_update_stats(struct igc_adapter *adapter)
+{
+	struct pci_dev *pdev = adapter->pdev;
+	struct igc_hw *hw = &adapter->hw;
+	struct net_device_stats *net_stats;
+	u64 bytes, packets;
+	u32 mpc;
+	int i;
+
+	/* Prevent stats update while adapter is being reset, or if the pci
+	 * connection is down.
+	 */
+	if (adapter->link_speed == 0)
+		return;
+	if (pci_channel_offline(pdev))
+		return;
+
+	net_stats = &adapter->net_stats;
+	packets = 0;
+	bytes = 0;
+
+	rcu_read_lock();
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		struct igc_ring *ring = adapter->rx_ring[i];
+		u32 rqdpc = rd32(IGC_RQDPC(i));
+
+		if (hw->mac.type >= igc_i225)
+			wr32(IGC_RQDPC(i), 0);
+
+		if (rqdpc)
+			ring->rx_stats.drops += rqdpc;
+
+		bytes += ring->rx_stats.bytes;
+		packets += ring->rx_stats.packets;
+	}
+
+	net_stats->rx_bytes = bytes;
+	net_stats->rx_packets = packets;
+
+	packets = 0;
+	bytes = 0;
+	for (i = 0; i < adapter->num_tx_queues; i++) {
+		struct igc_ring *ring = adapter->tx_ring[i];
+
+		bytes += ring->tx_stats.bytes;
+		packets += ring->tx_stats.packets;
+	}
+
+	net_stats->tx_bytes = bytes;
+	net_stats->tx_packets = packets;
+
+	rcu_read_unlock();
+
+	/* read stats registers */
+	adapter->stats.crcerrs += rd32(IGC_CRCERRS);
+	adapter->stats.gprc += rd32(IGC_GPRC);
+	adapter->stats.gorc += rd32(IGC_GORCL);
+	rd32(IGC_GORCH); /* clear GORCL */
+	adapter->stats.bprc += rd32(IGC_BPRC);
+	adapter->stats.mprc += rd32(IGC_MPRC);
+	adapter->stats.roc += rd32(IGC_ROC);
+
+	adapter->stats.prc64 += rd32(IGC_PRC64);
+	adapter->stats.prc127 += rd32(IGC_PRC127);
+	adapter->stats.prc255 += rd32(IGC_PRC255);
+	adapter->stats.prc511 += rd32(IGC_PRC511);
+	adapter->stats.prc1023 += rd32(IGC_PRC1023);
+	adapter->stats.prc1522 += rd32(IGC_PRC1522);
+	adapter->stats.tlpic += rd32(IGC_TLPIC);
+	adapter->stats.rlpic += rd32(IGC_RLPIC);
+
+	mpc = rd32(IGC_MPC);
+	adapter->stats.mpc += mpc;
+	net_stats->rx_fifo_errors += mpc;
+	adapter->stats.scc += rd32(IGC_SCC);
+	adapter->stats.ecol += rd32(IGC_ECOL);
+	adapter->stats.mcc += rd32(IGC_MCC);
+	adapter->stats.latecol += rd32(IGC_LATECOL);
+	adapter->stats.dc += rd32(IGC_DC);
+	adapter->stats.rlec += rd32(IGC_RLEC);
+	adapter->stats.xonrxc += rd32(IGC_XONRXC);
+	adapter->stats.xontxc += rd32(IGC_XONTXC);
+	adapter->stats.xoffrxc += rd32(IGC_XOFFRXC);
+	adapter->stats.xofftxc += rd32(IGC_XOFFTXC);
+	adapter->stats.fcruc += rd32(IGC_FCRUC);
+	adapter->stats.gptc += rd32(IGC_GPTC);
+	adapter->stats.gotc += rd32(IGC_GOTCL);
+	rd32(IGC_GOTCH); /* clear GOTCL */
+	adapter->stats.rnbc += rd32(IGC_RNBC);
+	adapter->stats.ruc += rd32(IGC_RUC);
+	adapter->stats.rfc += rd32(IGC_RFC);
+	adapter->stats.rjc += rd32(IGC_RJC);
+	adapter->stats.tor += rd32(IGC_TORH);
+	adapter->stats.tot += rd32(IGC_TOTH);
+	adapter->stats.tpr += rd32(IGC_TPR);
+
+	adapter->stats.ptc64 += rd32(IGC_PTC64);
+	adapter->stats.ptc127 += rd32(IGC_PTC127);
+	adapter->stats.ptc255 += rd32(IGC_PTC255);
+	adapter->stats.ptc511 += rd32(IGC_PTC511);
+	adapter->stats.ptc1023 += rd32(IGC_PTC1023);
+	adapter->stats.ptc1522 += rd32(IGC_PTC1522);
+
+	adapter->stats.mptc += rd32(IGC_MPTC);
+	adapter->stats.bptc += rd32(IGC_BPTC);
+
+	adapter->stats.tpt += rd32(IGC_TPT);
+	adapter->stats.colc += rd32(IGC_COLC);
+	adapter->stats.colc += rd32(IGC_RERC);
+
+	adapter->stats.algnerrc += rd32(IGC_ALGNERRC);
+
+	adapter->stats.tsctc += rd32(IGC_TSCTC);
+
+	adapter->stats.iac += rd32(IGC_IAC);
+
+	/* Fill out the OS statistics structure */
+	net_stats->multicast = adapter->stats.mprc;
+	net_stats->collisions = adapter->stats.colc;
+
+	/* Rx Errors */
+
+	/* RLEC on some newer hardware can be incorrect so build
+	 * our own version based on RUC and ROC
+	 */
+	net_stats->rx_errors = adapter->stats.rxerrc +
+		adapter->stats.crcerrs + adapter->stats.algnerrc +
+		adapter->stats.ruc + adapter->stats.roc +
+		adapter->stats.cexterr;
+	net_stats->rx_length_errors = adapter->stats.ruc +
+					adapter->stats.roc;
+	net_stats->rx_crc_errors = adapter->stats.crcerrs;
+	net_stats->rx_frame_errors = adapter->stats.algnerrc;
+	net_stats->rx_missed_errors = adapter->stats.mpc;
+
+	/* Tx Errors */
+	net_stats->tx_errors = adapter->stats.ecol +
+				adapter->stats.latecol;
+	net_stats->tx_aborted_errors = adapter->stats.ecol;
+	net_stats->tx_window_errors = adapter->stats.latecol;
+	net_stats->tx_carrier_errors = adapter->stats.tncrs;
+
+
+	/* Tx Dropped needs to be maintained elsewhere */
+
+	/* Management Stats */
+	adapter->stats.mgptc += rd32(IGC_MGTPTC);
+	adapter->stats.mgprc += rd32(IGC_MGTPRC);
+	adapter->stats.mgpdc += rd32(IGC_MGTPDC);
+}
+
+/**
+ * igc_down - Close the interface
+ * @adapter: board private structure
+ */
+void igc_down(struct igc_adapter *adapter)
+{
+	struct rtnet_device *netdev = adapter->netdev;
+	struct igc_hw *hw = &adapter->hw;
+	u32 tctl, rctl;
+
+	set_bit(__IGC_DOWN, &adapter->state);
+
+	/* disable receives in the hardware */
+	rctl = rd32(IGC_RCTL);
+	wr32(IGC_RCTL, rctl & ~IGC_RCTL_EN);
+
+	rtnetif_stop_queue(netdev);
+
+	/* disable transmits in the hardware */
+	tctl = rd32(IGC_TCTL);
+	tctl &= ~IGC_TCTL_EN;
+	wr32(IGC_TCTL, tctl);
+	/* flush both disables and wait for them to finish */
+	wrfl();
+	usleep_range(10000, 20000);
+
+	igc_irq_disable(adapter);
+
+	adapter->flags &= ~IGC_FLAG_NEED_LINK_UPDATE;
+
+	del_timer_sync(&adapter->watchdog_timer);
+	del_timer_sync(&adapter->phy_info_timer);
+
+	/* record the stats before reset*/
+	spin_lock(&adapter->stats64_lock);
+	igc_update_stats(adapter);
+	spin_unlock(&adapter->stats64_lock);
+
+	rtnetif_carrier_off(netdev);
+
+	adapter->link_speed = 0;
+	adapter->link_duplex = 0;
+
+	if (!pci_channel_offline(adapter->pdev))
+		igc_reset(adapter);
+
+	/* clear VLAN promisc flag so VFTA will be updated if necessary */
+	adapter->flags &= ~IGC_FLAG_VLAN_PROMISC;
+
+	igc_clean_all_tx_rings(adapter);
+	igc_clean_all_rx_rings(adapter);
+}
+
+void igc_reinit_locked(struct igc_adapter *adapter)
+{
+	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
+		usleep_range(1000, 2000);
+	igc_down(adapter);
+	igc_up(adapter);
+	clear_bit(__IGC_RESETTING, &adapter->state);
+}
+
+static void igc_reset_task(struct work_struct *work)
+{
+	struct igc_adapter *adapter;
+
+	adapter = container_of(work, struct igc_adapter, reset_task);
+
+	rtnl_lock();
+	/* If we're already down or resetting, just bail */
+	if (test_bit(__IGC_DOWN, &adapter->state) ||
+	    test_bit(__IGC_RESETTING, &adapter->state)) {
+		rtnl_unlock();
+		return;
+	}
+
+	igc_rings_dump(adapter);
+	igc_regs_dump(adapter);
+	rtdev_err(adapter->netdev, "Reset adapter\n");
+	igc_reinit_locked(adapter);
+	rtnl_unlock();
+}
+
+static void igc_other_handler(struct igc_adapter *adapter, u32 icr, bool root)
+{
+	struct igc_hw *hw = &adapter->hw;
+
+	/* reading ICR causes bit 31 of EICR to be cleared */
+	if (icr & IGC_ICR_DRSTA)
+		rtdm_schedule_nrt_work(&adapter->reset_task);
+
+	if (icr & IGC_ICR_DOUTSYNC) {
+		/* HW is reporting DMA is out of sync */
+		adapter->stats.doosync++;
+	}
+
+	if (icr & IGC_ICR_LSC) {
+		hw->mac.get_link_status = 1;
+		/* guard against interrupt when we're going down */
+		if (!test_bit(__IGC_DOWN, &adapter->state)) {
+			if (root)
+				mod_timer(&adapter->watchdog_timer, jiffies + 1);
+			else
+				rtdm_nrtsig_pend(&adapter->watchdog_nrtsig);
+		}
+	}
+
+}
+
+/**
+ * igc_msix_other - msix other interrupt handler
+ * @irq: interrupt number
+ * @data: pointer to a q_vector
+ */
+static irqreturn_t igc_msix_other(int irq, void *data)
+{
+	struct igc_adapter *adapter = data;
+	struct igc_hw *hw = &adapter->hw;
+	u32 icr = rd32(IGC_ICR);
+
+	igc_other_handler(adapter, icr, true);
+
+	wr32(IGC_EIMS, adapter->eims_other);
+
+	return IRQ_HANDLED;
+}
+
+static void igc_write_itr(struct igc_q_vector *q_vector)
+{
+	u32 itr_val = q_vector->itr_val & IGC_QVECTOR_MASK;
+
+	if (!q_vector->set_itr)
+		return;
+
+	if (!itr_val)
+		itr_val = IGC_ITR_VAL_MASK;
+
+	itr_val |= IGC_EITR_CNT_IGNR;
+
+	writel(itr_val, q_vector->itr_register);
+	q_vector->set_itr = 0;
+}
+
+
+/**
+ *  igc_poll - NAPI Rx polling callback
+ *  @napi: napi polling structure
+ *  @budget: count of how many packets we should handle
+ **/
+static void igc_poll(struct igc_q_vector *q_vector)
+{
+	if (q_vector->tx.ring)
+		igc_clean_tx_irq(q_vector);
+
+	if (q_vector->rx.ring)
+		igc_clean_rx_irq(q_vector, 64);
+
+	igc_ring_irq_enable(q_vector);
+}
+
+static int igc_msix_ring(rtdm_irq_t *ih)
+{
+	struct igc_q_vector *q_vector =
+		rtdm_irq_get_arg(ih, struct igc_q_vector);
+
+	/* Write the ITR value calculated from the previous interrupt. */
+	igc_write_itr(q_vector);
+
+	igc_poll(q_vector);
+
+	return RTDM_IRQ_HANDLED;
+}
+
+/**
+ * igc_request_msix - Initialize MSI-X interrupts
+ * @adapter: Pointer to adapter structure
+ *
+ * igc_request_msix allocates MSI-X vectors and requests interrupts from the
+ * kernel.
+ */
+static int igc_request_msix(struct igc_adapter *adapter)
+{
+	int i = 0, err = 0, vector = 0, free_vector = 0;
+	struct rtnet_device *netdev = adapter->netdev;
+	struct igc_hw *hw = &adapter->hw;
+
+	err = request_irq(adapter->msix_entries[vector].vector,
+			  &igc_msix_other, 0, netdev->name, adapter);
+	if (err)
+		goto err_out;
+
+	for (i = 0; i < adapter->num_q_vectors; i++) {
+		struct igc_q_vector *q_vector = adapter->q_vector[i];
+
+		vector++;
+
+		q_vector->itr_register = hw->hw_addr  + IGC_EITR(vector);
+
+		if (q_vector->rx.ring && q_vector->tx.ring)
+			sprintf(q_vector->name, "%s-TxRx-%u", netdev->name,
+				q_vector->rx.ring->queue_index);
+		else if (q_vector->tx.ring)
+			sprintf(q_vector->name, "%s-tx-%u", netdev->name,
+				q_vector->tx.ring->queue_index);
+		else if (q_vector->rx.ring)
+			sprintf(q_vector->name, "%s-rx-%u", netdev->name,
+				q_vector->rx.ring->queue_index);
+		else
+			sprintf(q_vector->name, "%s-unused", netdev->name);
+
+		err = rtdm_irq_request(&adapter->msix_irq_handle[vector],
+				adapter->msix_entries[vector].vector,
+				igc_msix_ring, 0, q_vector->name,
+				q_vector);
+		if (err)
+			goto err_free;
+	}
+
+	igc_configure_msix(adapter);
+	return 0;
+
+err_free:
+	/* free already assigned IRQs */
+	free_irq(adapter->msix_entries[free_vector++].vector, adapter);
+
+	vector--;
+	for (i = 0; i < vector; i++)
+		rtdm_irq_free(&adapter->msix_irq_handle[free_vector++]);
+err_out:
+	return err;
+}
+
+/**
+ * igc_clear_interrupt_scheme - reset the device to a state of no interrupts
+ * @adapter: Pointer to adapter structure
+ *
+ * This function resets the device so that it has 0 rx queues, tx queues, and
+ * MSI-X interrupts allocated.
+ */
+static void igc_clear_interrupt_scheme(struct igc_adapter *adapter)
+{
+	igc_free_q_vectors(adapter);
+	igc_reset_interrupt_capability(adapter);
+}
+
+/* Need to wait a few seconds after link up to get diagnostic information from
+ * the phy
+ */
+static void igc_update_phy_info(struct timer_list *t)
+{
+	struct igc_adapter *adapter = from_timer(adapter, t, phy_info_timer);
+
+	igc_get_phy_info(&adapter->hw);
+}
+
+/**
+ * igc_has_link - check shared code for link and determine up/down
+ * @adapter: pointer to driver private info
+ */
+bool igc_has_link(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+	bool link_active = false;
+
+	/* get_link_status is set on LSC (link status) interrupt or
+	 * rx sequence error interrupt.  get_link_status will stay
+	 * false until the igc_check_for_link establishes link
+	 * for copper adapters ONLY
+	 */
+	switch (hw->phy.media_type) {
+	case igc_media_type_copper:
+		if (!hw->mac.get_link_status)
+			return true;
+		hw->mac.ops.check_for_link(hw);
+		link_active = !hw->mac.get_link_status;
+		break;
+	default:
+	case igc_media_type_unknown:
+		break;
+	}
+
+	if (hw->mac.type == igc_i225 &&
+	    hw->phy.id == I225_I_PHY_ID) {
+		if (!rtnetif_carrier_ok(adapter->netdev)) {
+			adapter->flags &= ~IGC_FLAG_NEED_LINK_UPDATE;
+		} else if (!(adapter->flags & IGC_FLAG_NEED_LINK_UPDATE)) {
+			adapter->flags |= IGC_FLAG_NEED_LINK_UPDATE;
+			adapter->link_check_timeout = jiffies;
+		}
+	}
+
+	return link_active;
+}
+
+/**
+ * igc_watchdog - Timer Call-back
+ * @t: timer for the watchdog
+ */
+static void igc_watchdog(struct timer_list *t)
+{
+	struct igc_adapter *adapter = from_timer(adapter, t, watchdog_timer);
+	/* Do the rest outside of interrupt context */
+	schedule_work(&adapter->watchdog_task);
+}
+
+static void igc_watchdog_task(struct work_struct *work)
+{
+	struct igc_adapter *adapter = container_of(work,
+						   struct igc_adapter,
+						   watchdog_task);
+	struct rtnet_device *netdev = adapter->netdev;
+	struct igc_hw *hw = &adapter->hw;
+	struct igc_phy_info *phy = &hw->phy;
+	u32 link;
+	int i;
+
+	link = igc_has_link(adapter);
+
+	if (adapter->flags & IGC_FLAG_NEED_LINK_UPDATE) {
+		if (time_after(jiffies, (adapter->link_check_timeout + HZ)))
+			adapter->flags &= ~IGC_FLAG_NEED_LINK_UPDATE;
+		else
+			link = false;
+	}
+
+	if (link) {
+		/* Cancel scheduled suspend requests. */
+		pm_runtime_resume(adapter->pdev->dev.parent);
+
+		if (!rtnetif_carrier_ok(netdev)) {
+			u32 ctrl;
+
+			hw->mac.ops.get_speed_and_duplex(hw,
+							 &adapter->link_speed,
+							 &adapter->link_duplex);
+
+			ctrl = rd32(IGC_CTRL);
+			/* Link status message must follow this format */
+			rtdev_info(netdev,
+				    "NIC Link is Up %d Mbps %s Duplex, Flow Control: %s\n",
+				    adapter->link_speed,
+				    adapter->link_duplex == FULL_DUPLEX ?
+				    "Full" : "Half",
+				    (ctrl & IGC_CTRL_TFCE) &&
+				    (ctrl & IGC_CTRL_RFCE) ? "RX/TX" :
+				    (ctrl & IGC_CTRL_RFCE) ?  "RX" :
+				    (ctrl & IGC_CTRL_TFCE) ?  "TX" : "None");
+
+			/* disable EEE if enabled */
+			if ((adapter->flags & IGC_FLAG_EEE) &&
+			    adapter->link_duplex == HALF_DUPLEX) {
+				rtdev_info(netdev,
+					    "EEE Disabled: unsupported at half duplex. Re-enable using ethtool when at full duplex\n");
+				adapter->hw.dev_spec._base.eee_enable = false;
+				adapter->flags &= ~IGC_FLAG_EEE;
+			}
+
+			/* check if SmartSpeed worked */
+			igc_check_downshift(hw);
+			if (phy->speed_downgraded)
+				rtdev_warn(netdev, "Link Speed was downgraded by SmartSpeed\n");
+
+			/* adjust timeout factor according to speed/duplex */
+			adapter->tx_timeout_factor = 1;
+			switch (adapter->link_speed) {
+			case SPEED_10:
+				adapter->tx_timeout_factor = 14;
+				break;
+			case SPEED_100:
+				/* maybe add some timeout factor ? */
+				break;
+			}
+
+			rtnetif_carrier_on(netdev);
+
+			/* link state has changed, schedule phy info update */
+			if (!test_bit(__IGC_DOWN, &adapter->state))
+				mod_timer(&adapter->phy_info_timer,
+					  round_jiffies(jiffies + 2 * HZ));
+		}
+	} else {
+		if (rtnetif_carrier_ok(netdev)) {
+			adapter->link_speed = 0;
+			adapter->link_duplex = 0;
+
+			/* Links status message must follow this format */
+			rtdev_info(netdev, "NIC Link is Down\n");
+			rtnetif_carrier_off(netdev);
+
+			/* link state has changed, schedule phy info update */
+			if (!test_bit(__IGC_DOWN, &adapter->state))
+				mod_timer(&adapter->phy_info_timer,
+					  round_jiffies(jiffies + 2 * HZ));
+
+			/* link is down, time to check for alternate media */
+			if (adapter->flags & IGC_FLAG_MAS_ENABLE) {
+				if (adapter->flags & IGC_FLAG_MEDIA_RESET) {
+					schedule_work(&adapter->reset_task);
+					/* return immediately */
+					return;
+				}
+			}
+			pm_schedule_suspend(adapter->pdev->dev.parent,
+					    MSEC_PER_SEC * 5);
+
+		/* also check for alternate media here */
+		} else if (!rtnetif_carrier_ok(netdev) &&
+			   (adapter->flags & IGC_FLAG_MAS_ENABLE)) {
+			if (adapter->flags & IGC_FLAG_MEDIA_RESET) {
+				schedule_work(&adapter->reset_task);
+				/* return immediately */
+				return;
+			}
+		}
+	}
+
+	spin_lock(&adapter->stats64_lock);
+	igc_update_stats(adapter);
+	spin_unlock(&adapter->stats64_lock);
+
+	for (i = 0; i < adapter->num_tx_queues; i++) {
+		struct igc_ring *tx_ring = adapter->tx_ring[i];
+
+		if (!rtnetif_carrier_ok(netdev)) {
+			/* We've lost link, so the controller stops DMA,
+			 * but we've got queued Tx work that's never going
+			 * to get done, so reset controller to flush Tx.
+			 * (Do the reset outside of interrupt context).
+			 */
+			if (igc_desc_unused(tx_ring) + 1 < tx_ring->count) {
+				adapter->tx_timeout_count++;
+				schedule_work(&adapter->reset_task);
+				/* return immediately since reset is imminent */
+				return;
+			}
+		}
+
+		/* Force detection of hung controller every watchdog period */
+		set_bit(IGC_RING_FLAG_TX_DETECT_HANG, &tx_ring->flags);
+	}
+
+	/* Cause software interrupt to ensure Rx ring is cleaned */
+	if (adapter->flags & IGC_FLAG_HAS_MSIX) {
+		u32 eics = 0;
+
+		for (i = 0; i < adapter->num_q_vectors; i++)
+			eics |= adapter->q_vector[i]->eims_value;
+		wr32(IGC_EICS, eics);
+	} else {
+		wr32(IGC_ICS, IGC_ICS_RXDMT0);
+	}
+
+	/* Reset the timer */
+	if (!test_bit(__IGC_DOWN, &adapter->state)) {
+		if (adapter->flags & IGC_FLAG_NEED_LINK_UPDATE)
+			mod_timer(&adapter->watchdog_timer,
+				  round_jiffies(jiffies +  HZ));
+		else
+			mod_timer(&adapter->watchdog_timer,
+				  round_jiffies(jiffies + 2 * HZ));
+	}
+}
+
+/**
+ * igc_intr_msi - Interrupt Handler
+ * @irq: interrupt number
+ * @data: pointer to a network interface device structure
+ */
+static int igc_intr_msi(rtdm_irq_t *ih)
+{
+	struct igc_adapter *adapter = rtdm_irq_get_arg(ih, struct igc_adapter);
+	struct igc_q_vector *q_vector = adapter->q_vector[0];
+	struct igc_hw *hw = &adapter->hw;
+	/* read ICR disables interrupts using IAM */
+	u32 icr = rd32(IGC_ICR);
+
+	igc_write_itr(q_vector);
+
+	igc_other_handler(adapter, icr, false);
+
+	igc_poll(q_vector);
+
+	return RTDM_IRQ_HANDLED;
+}
+
+/**
+ * igc_intr - Legacy Interrupt Handler
+ * @irq: interrupt number
+ * @data: pointer to a network interface device structure
+ */
+static int igc_intr(rtdm_irq_t *ih)
+{
+	struct igc_adapter *adapter = rtdm_irq_get_arg(ih, struct igc_adapter);
+	struct igc_q_vector *q_vector = adapter->q_vector[0];
+	struct igc_hw *hw = &adapter->hw;
+	/* Interrupt Auto-Mask...upon reading ICR, interrupts are masked.  No
+	 * need for the IMC write
+	 */
+	u32 icr = rd32(IGC_ICR);
+
+	/* IMS will not auto-mask if INT_ASSERTED is not set, and if it is
+	 * not set, then the adapter didn't send an interrupt
+	 */
+	if (!(icr & IGC_ICR_INT_ASSERTED))
+		return IRQ_NONE;
+
+	igc_write_itr(q_vector);
+
+
+	igc_other_handler(adapter, icr, false);
+
+	igc_poll(q_vector);
+
+	return RTDM_IRQ_HANDLED;
+}
+
+static void igc_free_irq(struct igc_adapter *adapter)
+{
+	if (adapter->msix_entries) {
+		int vector = 0, i;
+
+		free_irq(adapter->msix_entries[vector++].vector, adapter);
+
+		for (i = 0; i < adapter->num_q_vectors; i++)
+			rtdm_irq_free(&adapter->msix_irq_handle[vector++]);
+	} else
+		rtdm_irq_free(&adapter->irq_handle);
+
+}
+
+/**
+ * igc_request_irq - initialize interrupts
+ * @adapter: Pointer to adapter structure
+ *
+ * Attempts to configure interrupts using the best available
+ * capabilities of the hardware and kernel.
+ */
+static int igc_request_irq(struct igc_adapter *adapter)
+{
+	struct rtnet_device *netdev = adapter->netdev;
+	struct pci_dev *pdev = adapter->pdev;
+	int err = 0;
+
+	rt_stack_connect(netdev, &STACK_manager);
+
+	if (adapter->flags & IGC_FLAG_HAS_MSIX) {
+		err = igc_request_msix(adapter);
+		if (!err)
+			goto request_done;
+		/* fall back to MSI */
+		igc_free_all_tx_resources(adapter);
+		igc_free_all_rx_resources(adapter);
+
+		igc_clear_interrupt_scheme(adapter);
+		err = igc_init_interrupt_scheme(adapter, false);
+		if (err)
+			goto request_done;
+		igc_setup_all_tx_resources(adapter);
+		igc_setup_all_rx_resources(adapter);
+		igc_configure(adapter);
+	}
+
+	igc_assign_vector(adapter->q_vector[0], 0);
+
+	if (adapter->flags & IGC_FLAG_HAS_MSI) {
+		err = rtdm_irq_request(&adapter->irq_handle,
+				pdev->irq, &igc_intr_msi, 0,
+				netdev->name, adapter);
+		if (!err)
+			goto request_done;
+
+		/* fall back to legacy interrupts */
+		igc_reset_interrupt_capability(adapter);
+		adapter->flags &= ~IGC_FLAG_HAS_MSI;
+	}
+
+	err = rtdm_irq_request(&adapter->irq_handle,
+			pdev->irq, &igc_intr, IRQF_SHARED,
+			netdev->name, adapter);
+
+	if (err)
+		rtdev_err(netdev, "Error %d getting interrupt\n", err);
+
+request_done:
+	return err;
+}
+
+/**
+ * __igc_open - Called when a network interface is made active
+ * @netdev: network interface device structure
+ * @resuming: boolean indicating if the device is resuming
+ *
+ * Returns 0 on success, negative value on failure
+ *
+ * The open entry point is called when a network interface is made
+ * active by the system (IFF_UP).  At this point all resources needed
+ * for transmit and receive operations are allocated, the interrupt
+ * handler is registered with the OS, the watchdog timer is started,
+ * and the stack is notified that the interface is ready.
+ */
+static int __igc_open(struct rtnet_device *netdev, bool resuming)
+{
+	struct igc_adapter *adapter = rtnetdev_priv(netdev);
+	struct pci_dev *pdev = adapter->pdev;
+	struct igc_hw *hw = &adapter->hw;
+	int err = 0;
+
+	/* disallow open during test */
+
+	if (test_bit(__IGC_TESTING, &adapter->state)) {
+		WARN_ON(resuming);
+		return -EBUSY;
+	}
+
+	if (!resuming)
+		pm_runtime_get_sync(&pdev->dev);
+
+	rtnetif_carrier_off(netdev);
+
+	/* allocate transmit descriptors */
+	err = igc_setup_all_tx_resources(adapter);
+	if (err)
+		goto err_setup_tx;
+
+	/* allocate receive descriptors */
+	err = igc_setup_all_rx_resources(adapter);
+	if (err)
+		goto err_setup_rx;
+
+	igc_power_up_link(adapter);
+
+	igc_configure(adapter);
+
+	err = igc_request_irq(adapter);
+	if (err)
+		goto err_req_irq;
+
+	clear_bit(__IGC_DOWN, &adapter->state);
+
+	/* Clear any pending interrupts. */
+	rd32(IGC_ICR);
+	igc_irq_enable(adapter);
+
+	if (!resuming)
+		pm_runtime_put(&pdev->dev);
+
+	//netif_tx_start_all_queues(netdev);
+	rtnetif_start_queue(netdev);
+
+	/* start the watchdog. */
+	hw->mac.get_link_status = 1;
+	schedule_work(&adapter->watchdog_task);
+
+	return IGC_SUCCESS;
+
+err_req_irq:
+	igc_release_hw_control(adapter);
+	igc_power_down_phy_copper_base(&adapter->hw);
+	igc_free_all_rx_resources(adapter);
+err_setup_rx:
+	igc_free_all_tx_resources(adapter);
+err_setup_tx:
+	igc_reset(adapter);
+	if (!resuming)
+		pm_runtime_put(&pdev->dev);
+
+	return err;
+}
+
+int igc_open(struct rtnet_device *netdev)
+{
+	return __igc_open(netdev, false);
+}
+
+/**
+ * __igc_close - Disables a network interface
+ * @netdev: network interface device structure
+ * @suspending: boolean indicating the device is suspending
+ *
+ * Returns 0, this is not allowed to fail
+ *
+ * The close entry point is called when an interface is de-activated
+ * by the OS.  The hardware is still under the driver's control, but
+ * needs to be disabled.  A global MAC reset is issued to stop the
+ * hardware, and all transmit and receive resources are freed.
+ */
+static int __igc_close(struct rtnet_device *netdev, bool suspending)
+{
+	struct igc_adapter *adapter = rtnetdev_priv(netdev);
+	struct pci_dev *pdev = adapter->pdev;
+
+	WARN_ON(test_bit(__IGC_RESETTING, &adapter->state));
+
+	if (!suspending)
+		pm_runtime_get_sync(&pdev->dev);
+
+	igc_down(adapter);
+
+	igc_release_hw_control(adapter);
+
+	igc_free_irq(adapter);
+
+	rt_stack_disconnect(netdev);
+
+	igc_free_all_tx_resources(adapter);
+	igc_free_all_rx_resources(adapter);
+
+	if (!suspending)
+		pm_runtime_put_sync(&pdev->dev);
+
+	return 0;
+}
+
+int igc_close(struct rtnet_device *netdev)
+{
+	return __igc_close(netdev, false);
+}
+
+static void igc_ptp_disable_tx_timestamp(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+
+	wr32(IGC_TSYNCTXCTL, 0);
+}
+
+static void igc_ptp_enable_tx_timestamp(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+
+	wr32(IGC_TSYNCTXCTL, IGC_TSYNCTXCTL_ENABLED | IGC_TSYNCTXCTL_TXSYNSIG);
+
+	/* Read TXSTMP registers to discard any timestamp previously stored. */
+	rd32(IGC_TXSTMPL);
+	rd32(IGC_TXSTMPH);
+}
+
+static void igc_ptp_disable_rx_timestamp(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+	u32 val;
+	int i;
+
+	wr32(IGC_TSYNCRXCTL, 0);
+
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		val = rd32(IGC_SRRCTL(i));
+		val &= ~IGC_SRRCTL_TIMESTAMP;
+		wr32(IGC_SRRCTL(i), val);
+	}
+
+	val = rd32(IGC_RXPBS);
+	val &= ~IGC_RXPBS_CFG_TS_EN;
+	wr32(IGC_RXPBS, val);
+}
+
+static void igc_ptp_enable_rx_timestamp(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+	u32 val;
+	int i;
+
+	val = rd32(IGC_RXPBS);
+	val |= IGC_RXPBS_CFG_TS_EN;
+	wr32(IGC_RXPBS, val);
+
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		val = rd32(IGC_SRRCTL(i));
+		/* FIXME: For now, only support retrieving RX timestamps from
+		 * timer 0.
+		 */
+		val |= IGC_SRRCTL_TIMER1SEL(0) | IGC_SRRCTL_TIMER0SEL(0) |
+		       IGC_SRRCTL_TIMESTAMP;
+		wr32(IGC_SRRCTL(i), val);
+	}
+
+	val = IGC_TSYNCRXCTL_ENABLED | IGC_TSYNCRXCTL_TYPE_ALL |
+	      IGC_TSYNCRXCTL_RXSYNSIG;
+	wr32(IGC_TSYNCRXCTL, val);
+}
+
+/**
+ * igc_ptp_set_timestamp_mode - setup hardware for timestamping
+ * @adapter: networking device structure
+ * @config: hwtstamp configuration
+ *
+ * Return: 0 in case of success, negative errno code otherwise.
+ */
+static int igc_ptp_set_timestamp_mode(struct igc_adapter *adapter,
+				      struct hwtstamp_config *config)
+{
+	switch (config->tx_type) {
+	case HWTSTAMP_TX_OFF:
+		igc_ptp_disable_tx_timestamp(adapter);
+		break;
+	case HWTSTAMP_TX_ON:
+		igc_ptp_enable_tx_timestamp(adapter);
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	switch (config->rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		igc_ptp_disable_rx_timestamp(adapter);
+		break;
+	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
+	case HWTSTAMP_FILTER_NTP_ALL:
+	case HWTSTAMP_FILTER_ALL:
+		igc_ptp_enable_rx_timestamp(adapter);
+		config->rx_filter = HWTSTAMP_FILTER_ALL;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
+/**
+ * igc_ptp_set_ts_config - set hardware time stamping config
+ * @netdev: network interface device structure
+ * @ifr: interface request data
+ *
+ **/
+int igc_ptp_set_ts_config(struct rtnet_device *netdev, struct ifreq *ifr)
+{
+	struct igc_adapter *adapter = rtnetdev_priv(netdev);
+	struct hwtstamp_config config;
+	int err;
+
+	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
+		return -EFAULT;
+
+	err = igc_ptp_set_timestamp_mode(adapter, &config);
+	if (err)
+		return err;
+
+	/* save these settings for future reference */
+	memcpy(&adapter->tstamp_config, &config,
+	       sizeof(adapter->tstamp_config));
+
+	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
+		-EFAULT : 0;
+}
+
+/**
+ * igc_ptp_get_ts_config - get hardware time stamping config
+ * @netdev: network interface device structure
+ * @ifr: interface request data
+ *
+ * Get the hwtstamp_config settings to return to the user. Rather than attempt
+ * to deconstruct the settings from the registers, just return a shadow copy
+ * of the last known settings.
+ **/
+int igc_ptp_get_ts_config(struct rtnet_device *netdev, struct ifreq *ifr)
+{
+	struct igc_adapter *adapter = rtnetdev_priv(netdev);
+	struct hwtstamp_config *config = &adapter->tstamp_config;
+
+	return copy_to_user(ifr->ifr_data, config, sizeof(*config)) ?
+		-EFAULT : 0;
+}
+
+/**
+ * igc_ioctl - Access the hwtstamp interface
+ * @netdev: network interface device structure
+ * @ifr: interface request data
+ * @cmd: ioctl command
+ **/
+static int igc_ioctl(struct rtnet_device *netdev, struct ifreq *ifr, int cmd)
+{
+	if (rtdm_in_rt_context())
+		return -ENOSYS;
+
+	switch (cmd) {
+	case SIOCGHWTSTAMP:
+		return igc_ptp_get_ts_config(netdev, ifr);
+	case SIOCSHWTSTAMP:
+		return igc_ptp_set_ts_config(netdev, ifr);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+/* PCIe configuration access */
+void igc_read_pci_cfg(struct igc_hw *hw, u32 reg, u16 *value)
+{
+	struct igc_adapter *adapter = hw->back;
+
+	pci_read_config_word(adapter->pdev, reg, value);
+}
+
+void igc_write_pci_cfg(struct igc_hw *hw, u32 reg, u16 *value)
+{
+	struct igc_adapter *adapter = hw->back;
+
+	pci_write_config_word(adapter->pdev, reg, *value);
+}
+
+s32 igc_read_pcie_cap_reg(struct igc_hw *hw, u32 reg, u16 *value)
+{
+	struct igc_adapter *adapter = hw->back;
+
+	if (!pci_is_pcie(adapter->pdev))
+		return -IGC_ERR_CONFIG;
+
+	pcie_capability_read_word(adapter->pdev, reg, value);
+
+	return IGC_SUCCESS;
+}
+
+s32 igc_write_pcie_cap_reg(struct igc_hw *hw, u32 reg, u16 *value)
+{
+	struct igc_adapter *adapter = hw->back;
+
+	if (!pci_is_pcie(adapter->pdev))
+		return -IGC_ERR_CONFIG;
+
+	pcie_capability_write_word(adapter->pdev, reg, *value);
+
+	return IGC_SUCCESS;
+}
+
+u32 igc_rd32(struct igc_hw *hw, u32 reg)
+{
+	struct igc_adapter *igc = container_of(hw, struct igc_adapter, hw);
+	u8 __iomem *hw_addr = READ_ONCE(hw->hw_addr);
+	u32 value = 0;
+
+	value = readl(&hw_addr[reg]);
+
+	/* reads should not return all F's */
+	if (!(~value) && (!reg || !(~readl(hw_addr)))) {
+		struct rtnet_device *netdev = igc->netdev;
+
+		hw->hw_addr = NULL;
+		rtnetif_device_detach(netdev);
+		rtdev_err(netdev, "PCIe link lost, device now detached\n");
+	}
+
+	return value;
+}
+
+int igc_set_spd_dplx(struct igc_adapter *adapter, u32 spd, u8 dplx)
+{
+	struct igc_mac_info *mac = &adapter->hw.mac;
+
+	mac->autoneg = 0;
+
+	/* Make sure dplx is at most 1 bit and lsb of speed is not set
+	 * for the switch() below to work
+	 */
+	if ((spd & 1) || (dplx & ~1))
+		goto err_inval;
+
+	switch (spd + dplx) {
+	case SPEED_10 + DUPLEX_HALF:
+		mac->forced_speed_duplex = ADVERTISE_10_HALF;
+		break;
+	case SPEED_10 + DUPLEX_FULL:
+		mac->forced_speed_duplex = ADVERTISE_10_FULL;
+		break;
+	case SPEED_100 + DUPLEX_HALF:
+		mac->forced_speed_duplex = ADVERTISE_100_HALF;
+		break;
+	case SPEED_100 + DUPLEX_FULL:
+		mac->forced_speed_duplex = ADVERTISE_100_FULL;
+		break;
+	case SPEED_1000 + DUPLEX_FULL:
+		mac->autoneg = 1;
+		adapter->hw.phy.autoneg_advertised = ADVERTISE_1000_FULL;
+		break;
+	case SPEED_1000 + DUPLEX_HALF: /* not supported */
+		goto err_inval;
+	case SPEED_2500 + DUPLEX_FULL:
+		mac->autoneg = 1;
+		adapter->hw.phy.autoneg_advertised = ADVERTISE_2500_FULL;
+		break;
+	case SPEED_2500 + DUPLEX_HALF: /* not supported */
+	default:
+		goto err_inval;
+	}
+
+	/* clear MDI, MDI(-X) override is only allowed when autoneg enabled */
+	adapter->hw.phy.mdix = AUTO_ALL_MODES;
+
+	return 0;
+
+err_inval:
+	rtdev_err(adapter->netdev, "Unsupported Speed/Duplex configuration\n");
+	return -EINVAL;
+}
+
+static void igc_nrtsig_watchdog(rtdm_nrtsig_t *sig, void *data)
+{
+	struct igc_adapter *adapter = data;
+
+	mod_timer(&adapter->watchdog_timer, jiffies + 1);
+}
+
+/**
+ * igc_get_stats - Get System Network Statistics
+ * @netdev: network interface device structure
+ *
+ * Returns the address of the device statistics structure.
+ * The statistics are actually updated from the timer callback.
+ **/
+static struct net_device_stats *igc_get_stats(struct rtnet_device *netdev)
+{
+	struct igc_adapter *adapter = netdev->priv;
+
+	/* only return the current stats */
+	return &adapter->net_stats;
+}
+
+static dma_addr_t igc_map_rtskb(struct rtnet_device *netdev,
+				struct rtskb *skb)
+{
+	struct igc_adapter *adapter = netdev->priv;
+	struct device *dev = &adapter->pdev->dev;
+	dma_addr_t addr;
+
+	addr = dma_map_single(dev, skb->buf_start, RTSKB_SIZE,
+			      DMA_BIDIRECTIONAL);
+	if (dma_mapping_error(dev, addr)) {
+		dev_err(dev, "DMA map failed\n");
+		return RTSKB_UNMAPPED;
+	}
+	return addr;
+}
+
+static void igc_unmap_rtskb(struct rtnet_device *netdev,
+			      struct rtskb *skb)
+{
+	struct igc_adapter *adapter = netdev->priv;
+	struct device *dev = &adapter->pdev->dev;
+
+	dma_unmap_single(dev, skb->buf_dma_addr, RTSKB_SIZE,
+			 DMA_BIDIRECTIONAL);
+}
+
+/**
+ * igc_probe - Device Initialization Routine
+ * @pdev: PCI device information struct
+ * @ent: entry in igc_pci_tbl
+ *
+ * Returns 0 on success, negative on failure
+ *
+ * igc_probe initializes an adapter identified by a pci_dev structure.
+ * The OS initialization, configuring the adapter private structure,
+ * and a hardware reset occur.
+ */
+static int igc_probe(struct pci_dev *pdev,
+		     const struct pci_device_id *ent)
+{
+	struct igc_adapter *adapter;
+	struct rtnet_device *netdev;
+	struct igc_hw *hw;
+	const struct igc_info *ei = igc_info_tbl[ent->driver_data];
+	int err, pci_using_dac;
+
+	err = pci_enable_device_mem(pdev);
+	if (err)
+		return err;
+
+	pci_using_dac = 0;
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (!err) {
+		pci_using_dac = 1;
+	} else {
+		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+		if (err) {
+			dev_err(&pdev->dev,
+				"No usable DMA configuration, aborting\n");
+			goto err_dma;
+		}
+	}
+
+	err = pci_request_mem_regions(pdev, igc_driver_name);
+	if (err)
+		goto err_pci_reg;
+
+	pci_enable_pcie_error_reporting(pdev);
+
+	pci_set_master(pdev);
+
+	err = -ENOMEM;
+	netdev = rt_alloc_etherdev(sizeof(*adapter),
+				2 * IGC_DEFAULT_RXD + IGC_DEFAULT_TXD);
+
+	if (!netdev)
+		goto err_alloc_etherdev;
+
+	rtdev_alloc_name(netdev, "rteth%d");
+	rt_rtdev_connect(netdev, &RTDEV_manager);
+
+	netdev->vers = RTDEV_VERS_2_0;
+	netdev->sysbind = &pdev->dev;
+
+	pci_set_drvdata(pdev, netdev);
+	adapter = rtnetdev_priv(netdev);
+	adapter->netdev = netdev;
+	adapter->pdev = pdev;
+	hw = &adapter->hw;
+	hw->back = adapter;
+	adapter->port_num = hw->bus.func;
+	adapter->msg_enable = netif_msg_init(debug, DEFAULT_MSG_ENABLE);
+
+	err = pci_save_state(pdev);
+	if (err)
+		goto err_ioremap;
+
+	err = -EIO;
+	hw->hw_addr = ioremap(pci_resource_start(pdev, 0),
+				   pci_resource_len(pdev, 0));
+	if (!hw->hw_addr)
+		goto err_ioremap;
+
+	netdev->open = igc_open;
+	netdev->stop = igc_close;
+	netdev->hard_start_xmit = igc_xmit_frame;
+	netdev->get_stats = igc_get_stats;
+	netdev->map_rtskb = igc_map_rtskb;
+	netdev->unmap_rtskb = igc_unmap_rtskb;
+	netdev->do_ioctl = igc_ioctl;
+
+	netdev->mem_start = pci_resource_start(pdev, 0);
+	netdev->mem_end = pci_resource_end(pdev, 0);
+
+	/* PCI config space info */
+	hw->vendor_id = pdev->vendor;
+	hw->device_id = pdev->device;
+	hw->revision_id = pdev->revision;
+	hw->subsystem_vendor_id = pdev->subsystem_vendor;
+	hw->subsystem_device_id = pdev->subsystem_device;
+
+	/* Copy the default MAC and PHY function pointers */
+	memcpy(&hw->mac.ops, ei->mac_ops, sizeof(hw->mac.ops));
+	memcpy(&hw->phy.ops, ei->phy_ops, sizeof(hw->phy.ops));
+
+	/* Initialize skew-specific constants */
+	err = ei->get_invariants(hw);
+	if (err)
+		goto err_sw_init;
+
+	/* Add supported features to the features list*/
+	netdev->features |= NETIF_F_SG;
+	netdev->features |= NETIF_F_TSO;
+	netdev->features |= NETIF_F_TSO6;
+	netdev->features |= NETIF_F_TSO_ECN;
+	netdev->features |= NETIF_F_RXCSUM;
+	netdev->features |= NETIF_F_SCTP_CRC;
+	netdev->features |= NETIF_F_HW_TC;
+	netdev->features |= NETIF_F_IP_CSUM;
+	netdev->features |= NETIF_F_IPV6_CSUM;
+
+	netdev->priv_flags |= IFF_SUPP_NOFCS;
+	/* setup the private structure */
+	err = igc_sw_init(adapter);
+	if (err)
+		goto err_sw_init;
+
+	if (pci_using_dac)
+		netdev->features |= NETIF_F_HIGHDMA;
+
+	/* before reading the NVM, reset the controller to put the device in a
+	 * known good starting state
+	 */
+	hw->mac.ops.reset_hw(hw);
+
+	if (igc_get_flash_presence_i225(hw)) {
+		if (hw->nvm.ops.validate(hw) < 0) {
+			dev_err(&pdev->dev, "The NVM Checksum Is Not Valid\n");
+			err = -EIO;
+			goto err_eeprom;
+		}
+	}
+
+	/* copy the MAC address out of the NVM */
+	if (hw->mac.ops.read_mac_addr(hw))
+		dev_err(&pdev->dev, "NVM Read Error\n");
+
+	memcpy(netdev->dev_addr, hw->mac.addr, netdev->addr_len);
+
+	if (!is_valid_ether_addr(netdev->dev_addr)) {
+		dev_err(&pdev->dev, "Invalid MAC Address\n");
+		err = -EIO;
+		goto err_eeprom;
+	}
+
+	/* configure RXPBSIZE and TXPBSIZE */
+	wr32(IGC_RXPBS, I225_RXPBSIZE_DEFAULT);
+	wr32(IGC_TXPBS, I225_TXPBSIZE_DEFAULT);
+
+	timer_setup(&adapter->watchdog_timer, igc_watchdog, 0);
+	timer_setup(&adapter->phy_info_timer, igc_update_phy_info, 0);
+
+	INIT_WORK(&adapter->reset_task, igc_reset_task);
+	INIT_WORK(&adapter->watchdog_task, igc_watchdog_task);
+	rtdm_nrtsig_init(&adapter->watchdog_nrtsig,
+			igc_nrtsig_watchdog, adapter);
+
+	/* Initialize link properties that are user-changeable */
+	adapter->fc_autoneg = true;
+	hw->mac.autoneg = true;
+	hw->phy.autoneg_advertised = 0xaf;
+
+	hw->fc.requested_mode = igc_fc_default;
+	hw->fc.current_mode = igc_fc_default;
+
+	/* By default, support wake on port A */
+	adapter->flags |= IGC_FLAG_WOL_SUPPORTED;
+
+	/* initialize the wol settings based on the eeprom settings */
+	if (adapter->flags & IGC_FLAG_WOL_SUPPORTED)
+		adapter->wol |= IGC_WUFC_MAG;
+
+	device_set_wakeup_enable(&adapter->pdev->dev,
+				 adapter->flags & IGC_FLAG_WOL_SUPPORTED);
+
+	/* reset the hardware with the new settings */
+	igc_reset(adapter);
+
+	/* let the f/w know that the h/w is now under the control of the
+	 * driver.
+	 */
+	igc_get_hw_control(adapter);
+
+	strncpy(netdev->name, "rteth%d", IFNAMSIZ);
+	err = rt_register_rtnetdev(netdev);
+	if (err)
+		goto err_register;
+
+	 /* carrier off reporting is important to ethtool even BEFORE open */
+	rtnetif_carrier_off(netdev);
+
+	/* Check if Media Autosense is enabled */
+	adapter->ei = *ei;
+
+	/* print pcie link status and MAC address */
+	pcie_print_link_status(pdev);
+	rtdev_info(netdev, "MAC: %pM\n", netdev->dev_addr);
+
+	//dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
+	/* Disable EEE for internal PHY devices */
+	hw->dev_spec._base.eee_enable = false;
+	adapter->flags &= ~IGC_FLAG_EEE;
+	igc_set_eee_i225(hw, false, false, false);
+
+	pm_runtime_put_noidle(&pdev->dev);
+
+	//igc_led_setup(adapter);
+
+	return 0;
+
+err_register:
+	igc_release_hw_control(adapter);
+err_eeprom:
+	if (!igc_check_reset_block(hw))
+		igc_reset_phy(hw);
+err_sw_init:
+	igc_clear_interrupt_scheme(adapter);
+	iounmap(hw->hw_addr);
+err_ioremap:
+	rtdev_free(netdev);
+err_alloc_etherdev:
+	pci_release_mem_regions(pdev);
+err_pci_reg:
+err_dma:
+	pci_disable_device(pdev);
+	return err;
+}
+
+/**
+ * igc_remove - Device Removal Routine
+ * @pdev: PCI device information struct
+ *
+ * igc_remove is called by the PCI subsystem to alert the driver
+ * that it should release a PCI device.  This could be caused by a
+ * Hot-Plug event, or because the driver is going to be removed from
+ * memory.
+ */
+static void igc_remove(struct pci_dev *pdev)
+{
+	struct rtnet_device *netdev = pci_get_drvdata(pdev);
+	struct igc_adapter *adapter = rtnetdev_priv(netdev);
+	struct igc_hw *hw = &adapter->hw;
+
+	rtdev_down(netdev);
+	igc_down(adapter);
+
+	pm_runtime_get_noresume(&pdev->dev);
+
+	del_timer_sync(&adapter->watchdog_timer);
+	del_timer_sync(&adapter->phy_info_timer);
+
+	cancel_work_sync(&adapter->reset_task);
+	cancel_work_sync(&adapter->watchdog_task);
+
+	/* Release control of h/w to f/w.  If f/w is AMT enabled, this
+	 * would have already happened in close and is redundant.
+	 */
+	igc_release_hw_control(adapter);
+	rt_rtdev_disconnect(netdev);
+	rt_unregister_rtnetdev(netdev);
+
+	igc_clear_interrupt_scheme(adapter);
+	pci_iounmap(pdev, hw->hw_addr);
+	pci_release_mem_regions(pdev);
+
+	rtdev_free(netdev);
+
+	pci_disable_pcie_error_reporting(pdev);
+
+	pci_disable_device(pdev);
+}
+
+static int __igc_shutdown(struct pci_dev *pdev, bool *enable_wake,
+			  bool runtime)
+{
+	struct rtnet_device *netdev = pci_get_drvdata(pdev);
+	struct igc_adapter *adapter = rtnetdev_priv(netdev);
+	u32 wufc = runtime ? IGC_WUFC_LNKC : adapter->wol;
+	struct igc_hw *hw = &adapter->hw;
+	u32 ctrl, rctl, status;
+	bool wake;
+
+	rtnetif_device_detach(netdev);
+
+	if (rtnetif_running(netdev))
+		__igc_close(netdev, true);
+
+	igc_clear_interrupt_scheme(adapter);
+
+	status = rd32(IGC_STATUS);
+	if (status & IGC_STATUS_LU)
+		wufc &= ~IGC_WUFC_LNKC;
+
+	if (wufc) {
+		igc_setup_rctl(adapter);
+		igc_set_rx_mode(netdev);
+
+		/* turn on all-multi mode if wake on multicast is enabled */
+		if (wufc & IGC_WUFC_MC) {
+			rctl = rd32(IGC_RCTL);
+			rctl |= IGC_RCTL_MPE;
+			wr32(IGC_RCTL, rctl);
+		}
+
+		ctrl = rd32(IGC_CTRL);
+		ctrl |= IGC_CTRL_ADVD3WUC;
+		wr32(IGC_CTRL, ctrl);
+
+		/* Allow time for pending master requests to run */
+		igc_disable_pcie_master(hw);
+
+		wr32(IGC_WUC, IGC_WUC_PME_EN);
+		wr32(IGC_WUFC, wufc);
+	} else {
+		wr32(IGC_WUC, 0);
+		wr32(IGC_WUFC, 0);
+	}
+
+	wake = wufc || adapter->en_mng_pt;
+	if (!wake)
+		igc_power_down_phy_copper_base(&adapter->hw);
+	else
+		igc_power_up_link(adapter);
+
+	if (enable_wake)
+		*enable_wake = wake;
+
+	/* Release control of h/w to f/w.  If f/w is AMT enabled, this
+	 * would have already happened in close and is redundant.
+	 */
+	igc_release_hw_control(adapter);
+
+	pci_disable_device(pdev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int __maybe_unused igc_runtime_suspend(struct device *dev)
+{
+	return __igc_shutdown(to_pci_dev(dev), NULL, 1);
+}
+
+static int __maybe_unused igc_resume(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct rtnet_device *netdev = pci_get_drvdata(pdev);
+	struct igc_adapter *adapter = rtnetdev_priv(netdev);
+	struct igc_hw *hw = &adapter->hw;
+	u32 err;
+
+	pci_set_power_state(pdev, PCI_D0);
+	pci_restore_state(pdev);
+	pci_save_state(pdev);
+
+	if (!pci_device_is_present(pdev))
+		return -ENODEV;
+	err = pci_enable_device_mem(pdev);
+	if (err) {
+		rtdev_err(netdev, "Cannot enable PCI device from suspend\n");
+		return err;
+	}
+	pci_set_master(pdev);
+
+	pci_enable_wake(pdev, PCI_D3hot, 0);
+	pci_enable_wake(pdev, PCI_D3cold, 0);
+
+	if (igc_init_interrupt_scheme(adapter, true)) {
+		rtdev_err(netdev, "Unable to allocate memory for queues\n");
+		return -ENOMEM;
+	}
+
+	igc_reset(adapter);
+
+	/* let the f/w know that the h/w is now under the control of the
+	 * driver.
+	 */
+	igc_get_hw_control(adapter);
+
+	wr32(IGC_WUS, ~0);
+
+	if (netdev->flags & IFF_UP) {
+		rtnl_lock();
+		err = __igc_open(netdev, true);
+
+		if (err)
+			return err;
+	}
+
+	rtnetif_device_attach(netdev);
+	return 0;
+}
+
+static int __maybe_unused igc_runtime_resume(struct device *dev)
+{
+	return igc_resume(dev);
+}
+
+static int __maybe_unused igc_suspend(struct device *dev)
+{
+	return __igc_shutdown(to_pci_dev(dev), NULL, 0);
+}
+
+static int __maybe_unused igc_runtime_idle(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct rtnet_device *netdev = pci_get_drvdata(pdev);
+	struct igc_adapter *adapter = rtnetdev_priv(netdev);
+
+	if (!igc_has_link(adapter))
+		pm_schedule_suspend(dev, MSEC_PER_SEC * 5);
+
+	return -EBUSY;
+}
+#endif /* CONFIG_PM */
+
+static void igc_shutdown(struct pci_dev *pdev)
+{
+	bool wake;
+
+	__igc_shutdown(pdev, &wake, 0);
+
+	if (system_state == SYSTEM_POWER_OFF) {
+		pci_wake_from_d3(pdev, wake);
+		pci_set_power_state(pdev, PCI_D3hot);
+	}
+}
+
+/**
+ *  igc_io_error_detected - called when PCI error is detected
+ *  @pdev: Pointer to PCI device
+ *  @state: The current PCI connection state
+ *
+ *  This function is called after a PCI bus error affecting
+ *  this device has been detected.
+ **/
+static pci_ers_result_t igc_io_error_detected(struct pci_dev *pdev,
+					      pci_channel_state_t state)
+{
+	struct rtnet_device *netdev = pci_get_drvdata(pdev);
+	struct igc_adapter *adapter = rtnetdev_priv(netdev);
+
+	rtnetif_device_detach(netdev);
+
+	if (state == pci_channel_io_perm_failure)
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	if (rtnetif_running(netdev))
+		igc_down(adapter);
+	pci_disable_device(pdev);
+
+	/* Request a slot reset. */
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+/**
+ *  igc_io_slot_reset - called after the PCI bus has been reset.
+ *  @pdev: Pointer to PCI device
+ *
+ *  Restart the card from scratch, as if from a cold-boot. Implementation
+ *  resembles the first-half of the igc_resume routine.
+ **/
+static pci_ers_result_t igc_io_slot_reset(struct pci_dev *pdev)
+{
+	struct rtnet_device *netdev = pci_get_drvdata(pdev);
+	struct igc_adapter *adapter = rtnetdev_priv(netdev);
+	struct igc_hw *hw = &adapter->hw;
+	pci_ers_result_t result;
+
+	if (pci_enable_device_mem(pdev)) {
+		rtdev_err(netdev, "Could not re-enable PCI device after reset\n");
+		result = PCI_ERS_RESULT_DISCONNECT;
+	} else {
+		pci_set_master(pdev);
+		pci_restore_state(pdev);
+		pci_save_state(pdev);
+
+		pci_enable_wake(pdev, PCI_D3hot, 0);
+		pci_enable_wake(pdev, PCI_D3cold, 0);
+
+		igc_reset(adapter);
+		wr32(IGC_WUS, ~0);
+		result = PCI_ERS_RESULT_RECOVERED;
+	}
+
+	return result;
+}
+
+/**
+ *  igc_io_resume - called when traffic can start to flow again.
+ *  @pdev: Pointer to PCI device
+ *
+ *  This callback is called when the error recovery driver tells us that
+ *  its OK to resume normal operation. Implementation resembles the
+ *  second-half of the igc_resume routine.
+ */
+static void igc_io_resume(struct pci_dev *pdev)
+{
+	struct rtnet_device *netdev = pci_get_drvdata(pdev);
+	struct igc_adapter *adapter = rtnetdev_priv(netdev);
+
+	rtnl_lock();
+	if (rtnetif_running(netdev)) {
+		if (igc_open(netdev)) {
+			rtdev_err(netdev, "igc_open failed after reset\n");
+			return;
+		}
+	}
+
+	rtnetif_device_attach(netdev);
+
+	/* let the f/w know that the h/w is now under the control of the
+	 * driver.
+	 */
+	igc_get_hw_control(adapter);
+	rtnl_unlock();
+}
+
+static const struct pci_error_handlers igc_err_handler = {
+	.error_detected = igc_io_error_detected,
+	.slot_reset = igc_io_slot_reset,
+	.resume = igc_io_resume,
+};
+
+#ifdef CONFIG_PM
+static const struct dev_pm_ops igc_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(igc_suspend, igc_resume)
+	SET_RUNTIME_PM_OPS(igc_runtime_suspend, igc_runtime_resume,
+			   igc_runtime_idle)
+};
+#endif
+
+static struct pci_driver igc_driver = {
+	.name     = igc_driver_name,
+	.id_table = igc_pci_tbl,
+	.probe    = igc_probe,
+	.remove   = igc_remove,
+#ifdef CONFIG_PM
+	.driver.pm = &igc_pm_ops,
+#endif
+	.shutdown = igc_shutdown,
+	.err_handler = &igc_err_handler,
+};
+
+/**
+ * igc_reinit_queues - return error
+ * @adapter: pointer to adapter structure
+ */
+int igc_reinit_queues(struct igc_adapter *adapter)
+{
+	struct rtnet_device *netdev = adapter->netdev;
+	int err = 0;
+
+	if (rtnetif_running(netdev))
+		igc_close(netdev);
+
+	igc_reset_interrupt_capability(adapter);
+
+	if (igc_init_interrupt_scheme(adapter, true)) {
+		rtdev_err(netdev, "Unable to allocate memory for queues\n");
+		return -ENOMEM;
+	}
+
+	if (rtnetif_running(netdev))
+		err = igc_open(netdev);
+
+	return err;
+}
+
+/**
+ * igc_get_hw_dev - return device
+ * @hw: pointer to hardware structure
+ *
+ * used by hardware layer to print debugging information
+ */
+struct rtnet_device *igc_get_hw_dev(struct igc_hw *hw)
+{
+	struct igc_adapter *adapter = hw->back;
+
+	return adapter->netdev;
+}
+
+/**
+ * igc_init_module - Driver Registration Routine
+ *
+ * igc_init_module is the first routine called when the driver is
+ * loaded. All it does is register with the PCI subsystem.
+ */
+static int __init igc_init_module(void)
+{
+	int ret;
+
+	pr_info("%s\n", igc_driver_string);
+	pr_info("%s\n", igc_copyright);
+
+	ret = pci_register_driver(&igc_driver);
+	return ret;
+}
+
+module_init(igc_init_module);
+
+/**
+ * igc_exit_module - Driver Exit Cleanup Routine
+ *
+ * igc_exit_module is called just before the driver is removed
+ * from memory.
+ */
+static void __exit igc_exit_module(void)
+{
+	pci_unregister_driver(&igc_driver);
+}
+
+module_exit(igc_exit_module);
+/* igc_main.c */
diff --git a/kernel/drivers/net/drivers/igc/igc_nvm.c b/kernel/drivers/net/drivers/igc/igc_nvm.c
new file mode 100644
index 000000000..58f81aba0
--- /dev/null
+++ b/kernel/drivers/net/drivers/igc/igc_nvm.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c)  2018 Intel Corporation */
+
+#include "igc_mac.h"
+#include "igc_nvm.h"
+
+/**
+ * igc_poll_eerd_eewr_done - Poll for EEPROM read/write completion
+ * @hw: pointer to the HW structure
+ * @ee_reg: EEPROM flag for polling
+ *
+ * Polls the EEPROM status bit for either read or write completion based
+ * upon the value of 'ee_reg'.
+ */
+static s32 igc_poll_eerd_eewr_done(struct igc_hw *hw, int ee_reg)
+{
+	s32 ret_val = -IGC_ERR_NVM;
+	u32 attempts = 100000;
+	u32 i, reg = 0;
+
+	for (i = 0; i < attempts; i++) {
+		if (ee_reg == IGC_NVM_POLL_READ)
+			reg = rd32(IGC_EERD);
+		else
+			reg = rd32(IGC_EEWR);
+
+		if (reg & IGC_NVM_RW_REG_DONE) {
+			ret_val = 0;
+			break;
+		}
+
+		udelay(5);
+	}
+
+	return ret_val;
+}
+
+/**
+ * igc_acquire_nvm - Generic request for access to EEPROM
+ * @hw: pointer to the HW structure
+ *
+ * Set the EEPROM access request bit and wait for EEPROM access grant bit.
+ * Return successful if access grant bit set, else clear the request for
+ * EEPROM access and return -IGC_ERR_NVM (-1).
+ */
+s32 igc_acquire_nvm(struct igc_hw *hw)
+{
+	s32 timeout = IGC_NVM_GRANT_ATTEMPTS;
+	u32 eecd = rd32(IGC_EECD);
+	s32 ret_val = 0;
+
+	wr32(IGC_EECD, eecd | IGC_EECD_REQ);
+	eecd = rd32(IGC_EECD);
+
+	while (timeout) {
+		if (eecd & IGC_EECD_GNT)
+			break;
+		udelay(5);
+		eecd = rd32(IGC_EECD);
+		timeout--;
+	}
+
+	if (!timeout) {
+		eecd &= ~IGC_EECD_REQ;
+		wr32(IGC_EECD, eecd);
+		hw_dbg("Could not acquire NVM grant\n");
+		ret_val = -IGC_ERR_NVM;
+	}
+
+	return ret_val;
+}
+
+/**
+ * igc_release_nvm - Release exclusive access to EEPROM
+ * @hw: pointer to the HW structure
+ *
+ * Stop any current commands to the EEPROM and clear the EEPROM request bit.
+ */
+void igc_release_nvm(struct igc_hw *hw)
+{
+	u32 eecd;
+
+	eecd = rd32(IGC_EECD);
+	eecd &= ~IGC_EECD_REQ;
+	wr32(IGC_EECD, eecd);
+}
+
+/**
+ * igc_read_nvm_eerd - Reads EEPROM using EERD register
+ * @hw: pointer to the HW structure
+ * @offset: offset of word in the EEPROM to read
+ * @words: number of words to read
+ * @data: word read from the EEPROM
+ *
+ * Reads a 16 bit word from the EEPROM using the EERD register.
+ */
+s32 igc_read_nvm_eerd(struct igc_hw *hw, u16 offset, u16 words, u16 *data)
+{
+	struct igc_nvm_info *nvm = &hw->nvm;
+	u32 i, eerd = 0;
+	s32 ret_val = 0;
+
+	/* A check for invalid values:  offset too large, too many words,
+	 * and not enough words.
+	 */
+	if (offset >= nvm->word_size || (words > (nvm->word_size - offset)) ||
+	    words == 0) {
+		hw_dbg("nvm parameter(s) out of bounds\n");
+		ret_val = -IGC_ERR_NVM;
+		goto out;
+	}
+
+	for (i = 0; i < words; i++) {
+		eerd = ((offset + i) << IGC_NVM_RW_ADDR_SHIFT) +
+			IGC_NVM_RW_REG_START;
+
+		wr32(IGC_EERD, eerd);
+		ret_val = igc_poll_eerd_eewr_done(hw, IGC_NVM_POLL_READ);
+		if (ret_val)
+			break;
+
+		data[i] = (rd32(IGC_EERD) >> IGC_NVM_RW_REG_DATA);
+	}
+
+out:
+	return ret_val;
+}
+
+/**
+ * igc_read_mac_addr - Read device MAC address
+ * @hw: pointer to the HW structure
+ */
+s32 igc_read_mac_addr(struct igc_hw *hw)
+{
+	u32 rar_high;
+	u32 rar_low;
+	u16 i;
+
+	rar_high = rd32(IGC_RAH(0));
+	rar_low = rd32(IGC_RAL(0));
+
+	for (i = 0; i < IGC_RAL_MAC_ADDR_LEN; i++)
+		hw->mac.perm_addr[i] = (u8)(rar_low >> (i * 8));
+
+	for (i = 0; i < IGC_RAH_MAC_ADDR_LEN; i++)
+		hw->mac.perm_addr[i + 4] = (u8)(rar_high >> (i * 8));
+
+	for (i = 0; i < ETH_ALEN; i++)
+		hw->mac.addr[i] = hw->mac.perm_addr[i];
+
+	return 0;
+}
+
+/**
+ * igc_validate_nvm_checksum - Validate EEPROM checksum
+ * @hw: pointer to the HW structure
+ *
+ * Calculates the EEPROM checksum by reading/adding each word of the EEPROM
+ * and then verifies that the sum of the EEPROM is equal to 0xBABA.
+ */
+s32 igc_validate_nvm_checksum(struct igc_hw *hw)
+{
+	u16 checksum = 0;
+	u16 i, nvm_data;
+	s32 ret_val = 0;
+
+	for (i = 0; i < (NVM_CHECKSUM_REG + 1); i++) {
+		ret_val = hw->nvm.ops.read(hw, i, 1, &nvm_data);
+		if (ret_val) {
+			hw_dbg("NVM Read Error\n");
+			goto out;
+		}
+		checksum += nvm_data;
+	}
+
+	if (checksum != (u16)NVM_SUM) {
+		hw_dbg("NVM Checksum Invalid\n");
+		ret_val = -IGC_ERR_NVM;
+		goto out;
+	}
+
+out:
+	return ret_val;
+}
+
+/**
+ * igc_update_nvm_checksum - Update EEPROM checksum
+ * @hw: pointer to the HW structure
+ *
+ * Updates the EEPROM checksum by reading/adding each word of the EEPROM
+ * up to the checksum.  Then calculates the EEPROM checksum and writes the
+ * value to the EEPROM.
+ */
+s32 igc_update_nvm_checksum(struct igc_hw *hw)
+{
+	u16 checksum = 0;
+	u16 i, nvm_data;
+	s32  ret_val;
+
+	for (i = 0; i < NVM_CHECKSUM_REG; i++) {
+		ret_val = hw->nvm.ops.read(hw, i, 1, &nvm_data);
+		if (ret_val) {
+			hw_dbg("NVM Read Error while updating checksum.\n");
+			goto out;
+		}
+		checksum += nvm_data;
+	}
+	checksum = (u16)NVM_SUM - checksum;
+	ret_val = hw->nvm.ops.write(hw, NVM_CHECKSUM_REG, 1, &checksum);
+	if (ret_val)
+		hw_dbg("NVM Write Error while updating checksum.\n");
+
+out:
+	return ret_val;
+}
diff --git a/kernel/drivers/net/drivers/igc/igc_nvm.h b/kernel/drivers/net/drivers/igc/igc_nvm.h
new file mode 100644
index 000000000..f9fc2e9cf
--- /dev/null
+++ b/kernel/drivers/net/drivers/igc/igc_nvm.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c)  2018 Intel Corporation */
+
+#ifndef _IGC_NVM_H_
+#define _IGC_NVM_H_
+
+s32 igc_acquire_nvm(struct igc_hw *hw);
+void igc_release_nvm(struct igc_hw *hw);
+s32 igc_read_mac_addr(struct igc_hw *hw);
+s32 igc_read_nvm_eerd(struct igc_hw *hw, u16 offset, u16 words, u16 *data);
+s32 igc_validate_nvm_checksum(struct igc_hw *hw);
+s32 igc_update_nvm_checksum(struct igc_hw *hw);
+
+#endif
diff --git a/kernel/drivers/net/drivers/igc/igc_phy.c b/kernel/drivers/net/drivers/igc/igc_phy.c
new file mode 100644
index 000000000..8e1799508
--- /dev/null
+++ b/kernel/drivers/net/drivers/igc/igc_phy.c
@@ -0,0 +1,793 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c)  2018 Intel Corporation */
+
+#include "igc_phy.h"
+
+/**
+ * igc_check_reset_block - Check if PHY reset is blocked
+ * @hw: pointer to the HW structure
+ *
+ * Read the PHY management control register and check whether a PHY reset
+ * is blocked.  If a reset is not blocked return 0, otherwise
+ * return IGC_ERR_BLK_PHY_RESET (12).
+ */
+s32 igc_check_reset_block(struct igc_hw *hw)
+{
+	u32 manc;
+
+	manc = rd32(IGC_MANC);
+
+	return (manc & IGC_MANC_BLK_PHY_RST_ON_IDE) ?
+		IGC_ERR_BLK_PHY_RESET : 0;
+}
+
+/**
+ * igc_get_phy_id - Retrieve the PHY ID and revision
+ * @hw: pointer to the HW structure
+ *
+ * Reads the PHY registers and stores the PHY ID and possibly the PHY
+ * revision in the hardware structure.
+ */
+s32 igc_get_phy_id(struct igc_hw *hw)
+{
+	struct igc_phy_info *phy = &hw->phy;
+	s32 ret_val = 0;
+	u16 phy_id;
+
+	ret_val = phy->ops.read_reg(hw, PHY_ID1, &phy_id);
+	if (ret_val)
+		goto out;
+
+	phy->id = (u32)(phy_id << 16);
+	usleep_range(200, 500);
+	ret_val = phy->ops.read_reg(hw, PHY_ID2, &phy_id);
+	if (ret_val)
+		goto out;
+
+	phy->id |= (u32)(phy_id & PHY_REVISION_MASK);
+	phy->revision = (u32)(phy_id & ~PHY_REVISION_MASK);
+
+out:
+	return ret_val;
+}
+
+/**
+ * igc_phy_has_link - Polls PHY for link
+ * @hw: pointer to the HW structure
+ * @iterations: number of times to poll for link
+ * @usec_interval: delay between polling attempts
+ * @success: pointer to whether polling was successful or not
+ *
+ * Polls the PHY status register for link, 'iterations' number of times.
+ */
+s32 igc_phy_has_link(struct igc_hw *hw, u32 iterations,
+		     u32 usec_interval, bool *success)
+{
+	u16 i, phy_status;
+	s32 ret_val = 0;
+
+	for (i = 0; i < iterations; i++) {
+		/* Some PHYs require the PHY_STATUS register to be read
+		 * twice due to the link bit being sticky.  No harm doing
+		 * it across the board.
+		 */
+		ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS, &phy_status);
+		if (ret_val && usec_interval > 0) {
+			/* If the first read fails, another entity may have
+			 * ownership of the resources, wait and try again to
+			 * see if they have relinquished the resources yet.
+			 */
+			if (usec_interval >= 1000)
+				mdelay(usec_interval / 1000);
+			else
+				udelay(usec_interval);
+		}
+		ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS, &phy_status);
+		if (ret_val)
+			break;
+		if (phy_status & MII_SR_LINK_STATUS)
+			break;
+		if (usec_interval >= 1000)
+			mdelay(usec_interval / 1000);
+		else
+			udelay(usec_interval);
+	}
+
+	*success = (i < iterations) ? true : false;
+
+	return ret_val;
+}
+
+/**
+ * igc_power_up_phy_copper - Restore copper link in case of PHY power down
+ * @hw: pointer to the HW structure
+ *
+ * In the case of a PHY power down to save power, or to turn off link during a
+ * driver unload, restore the link to previous settings.
+ */
+void igc_power_up_phy_copper(struct igc_hw *hw)
+{
+	u16 mii_reg = 0;
+
+	/* The PHY will retain its settings across a power down/up cycle */
+	hw->phy.ops.read_reg(hw, PHY_CONTROL, &mii_reg);
+	mii_reg &= ~MII_CR_POWER_DOWN;
+	hw->phy.ops.write_reg(hw, PHY_CONTROL, mii_reg);
+}
+
+/**
+ * igc_power_down_phy_copper - Power down copper PHY
+ * @hw: pointer to the HW structure
+ *
+ * Power down PHY to save power when interface is down and wake on lan
+ * is not enabled.
+ */
+void igc_power_down_phy_copper(struct igc_hw *hw)
+{
+	u16 mii_reg = 0;
+
+	/* The PHY will retain its settings across a power down/up cycle */
+	hw->phy.ops.read_reg(hw, PHY_CONTROL, &mii_reg);
+	mii_reg |= MII_CR_POWER_DOWN;
+
+	/* Temporary workaround - should be removed when PHY will implement
+	 * IEEE registers as properly
+	 */
+	/* hw->phy.ops.write_reg(hw, PHY_CONTROL, mii_reg);*/
+	usleep_range(1000, 2000);
+}
+
+/**
+ * igc_check_downshift - Checks whether a downshift in speed occurred
+ * @hw: pointer to the HW structure
+ *
+ * Success returns 0, Failure returns 1
+ *
+ * A downshift is detected by querying the PHY link health.
+ */
+s32 igc_check_downshift(struct igc_hw *hw)
+{
+	struct igc_phy_info *phy = &hw->phy;
+	s32 ret_val;
+
+	switch (phy->type) {
+	case igc_phy_i225:
+	default:
+		/* speed downshift not supported */
+		phy->speed_downgraded = false;
+		ret_val = 0;
+	}
+
+	return ret_val;
+}
+
+/**
+ * igc_phy_hw_reset - PHY hardware reset
+ * @hw: pointer to the HW structure
+ *
+ * Verify the reset block is not blocking us from resetting.  Acquire
+ * semaphore (if necessary) and read/set/write the device control reset
+ * bit in the PHY.  Wait the appropriate delay time for the device to
+ * reset and release the semaphore (if necessary).
+ */
+s32 igc_phy_hw_reset(struct igc_hw *hw)
+{
+	struct igc_phy_info *phy = &hw->phy;
+	u32 phpm = 0, timeout = 10000;
+	s32  ret_val;
+	u32 ctrl;
+
+	ret_val = igc_check_reset_block(hw);
+	if (ret_val) {
+		ret_val = 0;
+		goto out;
+	}
+
+	ret_val = phy->ops.acquire(hw);
+	if (ret_val)
+		goto out;
+
+	phpm = rd32(IGC_I225_PHPM);
+
+	ctrl = rd32(IGC_CTRL);
+	wr32(IGC_CTRL, ctrl | IGC_CTRL_PHY_RST);
+	wrfl();
+
+	udelay(phy->reset_delay_us);
+
+	wr32(IGC_CTRL, ctrl);
+	wrfl();
+
+	/* SW should guarantee 100us for the completion of the PHY reset */
+	usleep_range(100, 150);
+	do {
+		phpm = rd32(IGC_I225_PHPM);
+		timeout--;
+		udelay(1);
+	} while (!(phpm & IGC_PHY_RST_COMP) && timeout);
+
+	if (!timeout)
+		hw_dbg("Timeout is expired after a phy reset\n");
+
+	usleep_range(100, 150);
+
+	phy->ops.release(hw);
+
+out:
+	return ret_val;
+}
+
+/**
+ * igc_phy_setup_autoneg - Configure PHY for auto-negotiation
+ * @hw: pointer to the HW structure
+ *
+ * Reads the MII auto-neg advertisement register and/or the 1000T control
+ * register and if the PHY is already setup for auto-negotiation, then
+ * return successful.  Otherwise, setup advertisement and flow control to
+ * the appropriate values for the wanted auto-negotiation.
+ */
+static s32 igc_phy_setup_autoneg(struct igc_hw *hw)
+{
+	struct igc_phy_info *phy = &hw->phy;
+	u16 aneg_multigbt_an_ctrl = 0;
+	u16 mii_1000t_ctrl_reg = 0;
+	u16 mii_autoneg_adv_reg;
+	s32 ret_val;
+
+	phy->autoneg_advertised &= phy->autoneg_mask;
+
+	/* Read the MII Auto-Neg Advertisement Register (Address 4). */
+	ret_val = phy->ops.read_reg(hw, PHY_AUTONEG_ADV, &mii_autoneg_adv_reg);
+	if (ret_val)
+		return ret_val;
+
+	if (phy->autoneg_mask & ADVERTISE_1000_FULL) {
+		/* Read the MII 1000Base-T Control Register (Address 9). */
+		ret_val = phy->ops.read_reg(hw, PHY_1000T_CTRL,
+					    &mii_1000t_ctrl_reg);
+		if (ret_val)
+			return ret_val;
+	}
+
+	if ((phy->autoneg_mask & ADVERTISE_2500_FULL) &&
+	    hw->phy.id == I225_I_PHY_ID) {
+		/* Read the MULTI GBT AN Control Register - reg 7.32 */
+		ret_val = phy->ops.read_reg(hw, (STANDARD_AN_REG_MASK <<
+					    MMD_DEVADDR_SHIFT) |
+					    ANEG_MULTIGBT_AN_CTRL,
+					    &aneg_multigbt_an_ctrl);
+
+		if (ret_val)
+			return ret_val;
+	}
+
+	/* Need to parse both autoneg_advertised and fc and set up
+	 * the appropriate PHY registers.  First we will parse for
+	 * autoneg_advertised software override.  Since we can advertise
+	 * a plethora of combinations, we need to check each bit
+	 * individually.
+	 */
+
+	/* First we clear all the 10/100 mb speed bits in the Auto-Neg
+	 * Advertisement Register (Address 4) and the 1000 mb speed bits in
+	 * the  1000Base-T Control Register (Address 9).
+	 */
+	mii_autoneg_adv_reg &= ~(NWAY_AR_100TX_FD_CAPS |
+				 NWAY_AR_100TX_HD_CAPS |
+				 NWAY_AR_10T_FD_CAPS   |
+				 NWAY_AR_10T_HD_CAPS);
+	mii_1000t_ctrl_reg &= ~(CR_1000T_HD_CAPS | CR_1000T_FD_CAPS);
+
+	hw_dbg("autoneg_advertised %x\n", phy->autoneg_advertised);
+
+	/* Do we want to advertise 10 Mb Half Duplex? */
+	if (phy->autoneg_advertised & ADVERTISE_10_HALF) {
+		hw_dbg("Advertise 10mb Half duplex\n");
+		mii_autoneg_adv_reg |= NWAY_AR_10T_HD_CAPS;
+	}
+
+	/* Do we want to advertise 10 Mb Full Duplex? */
+	if (phy->autoneg_advertised & ADVERTISE_10_FULL) {
+		hw_dbg("Advertise 10mb Full duplex\n");
+		mii_autoneg_adv_reg |= NWAY_AR_10T_FD_CAPS;
+	}
+
+	/* Do we want to advertise 100 Mb Half Duplex? */
+	if (phy->autoneg_advertised & ADVERTISE_100_HALF) {
+		hw_dbg("Advertise 100mb Half duplex\n");
+		mii_autoneg_adv_reg |= NWAY_AR_100TX_HD_CAPS;
+	}
+
+	/* Do we want to advertise 100 Mb Full Duplex? */
+	if (phy->autoneg_advertised & ADVERTISE_100_FULL) {
+		hw_dbg("Advertise 100mb Full duplex\n");
+		mii_autoneg_adv_reg |= NWAY_AR_100TX_FD_CAPS;
+	}
+
+	/* We do not allow the Phy to advertise 1000 Mb Half Duplex */
+	if (phy->autoneg_advertised & ADVERTISE_1000_HALF)
+		hw_dbg("Advertise 1000mb Half duplex request denied!\n");
+
+	/* Do we want to advertise 1000 Mb Full Duplex? */
+	if (phy->autoneg_advertised & ADVERTISE_1000_FULL) {
+		hw_dbg("Advertise 1000mb Full duplex\n");
+		mii_1000t_ctrl_reg |= CR_1000T_FD_CAPS;
+	}
+
+	/* We do not allow the Phy to advertise 2500 Mb Half Duplex */
+	if (phy->autoneg_advertised & ADVERTISE_2500_HALF)
+		hw_dbg("Advertise 2500mb Half duplex request denied!\n");
+
+	/* Do we want to advertise 2500 Mb Full Duplex? */
+	if (phy->autoneg_advertised & ADVERTISE_2500_FULL) {
+		hw_dbg("Advertise 2500mb Full duplex\n");
+		aneg_multigbt_an_ctrl |= CR_2500T_FD_CAPS;
+	} else {
+		aneg_multigbt_an_ctrl &= ~CR_2500T_FD_CAPS;
+	}
+
+	/* Check for a software override of the flow control settings, and
+	 * setup the PHY advertisement registers accordingly.  If
+	 * auto-negotiation is enabled, then software will have to set the
+	 * "PAUSE" bits to the correct value in the Auto-Negotiation
+	 * Advertisement Register (PHY_AUTONEG_ADV) and re-start auto-
+	 * negotiation.
+	 *
+	 * The possible values of the "fc" parameter are:
+	 *      0:  Flow control is completely disabled
+	 *      1:  Rx flow control is enabled (we can receive pause frames
+	 *          but not send pause frames).
+	 *      2:  Tx flow control is enabled (we can send pause frames
+	 *          but we do not support receiving pause frames).
+	 *      3:  Both Rx and Tx flow control (symmetric) are enabled.
+	 *  other:  No software override.  The flow control configuration
+	 *          in the EEPROM is used.
+	 */
+	switch (hw->fc.current_mode) {
+	case igc_fc_none:
+		/* Flow control (Rx & Tx) is completely disabled by a
+		 * software over-ride.
+		 */
+		mii_autoneg_adv_reg &= ~(NWAY_AR_ASM_DIR | NWAY_AR_PAUSE);
+		break;
+	case igc_fc_rx_pause:
+		/* Rx Flow control is enabled, and Tx Flow control is
+		 * disabled, by a software over-ride.
+		 *
+		 * Since there really isn't a way to advertise that we are
+		 * capable of Rx Pause ONLY, we will advertise that we
+		 * support both symmetric and asymmetric Rx PAUSE.  Later
+		 * (in igc_config_fc_after_link_up) we will disable the
+		 * hw's ability to send PAUSE frames.
+		 */
+		mii_autoneg_adv_reg |= (NWAY_AR_ASM_DIR | NWAY_AR_PAUSE);
+		break;
+	case igc_fc_tx_pause:
+		/* Tx Flow control is enabled, and Rx Flow control is
+		 * disabled, by a software over-ride.
+		 */
+		mii_autoneg_adv_reg |= NWAY_AR_ASM_DIR;
+		mii_autoneg_adv_reg &= ~NWAY_AR_PAUSE;
+		break;
+	case igc_fc_full:
+		/* Flow control (both Rx and Tx) is enabled by a software
+		 * over-ride.
+		 */
+		mii_autoneg_adv_reg |= (NWAY_AR_ASM_DIR | NWAY_AR_PAUSE);
+		break;
+	default:
+		hw_dbg("Flow control param set incorrectly\n");
+		return -IGC_ERR_CONFIG;
+	}
+
+	ret_val = phy->ops.write_reg(hw, PHY_AUTONEG_ADV, mii_autoneg_adv_reg);
+	if (ret_val)
+		return ret_val;
+
+	hw_dbg("Auto-Neg Advertising %x\n", mii_autoneg_adv_reg);
+
+	if (phy->autoneg_mask & ADVERTISE_1000_FULL)
+		ret_val = phy->ops.write_reg(hw, PHY_1000T_CTRL,
+					     mii_1000t_ctrl_reg);
+
+	if ((phy->autoneg_mask & ADVERTISE_2500_FULL) &&
+	    hw->phy.id == I225_I_PHY_ID)
+		ret_val = phy->ops.write_reg(hw,
+					     (STANDARD_AN_REG_MASK <<
+					     MMD_DEVADDR_SHIFT) |
+					     ANEG_MULTIGBT_AN_CTRL,
+					     aneg_multigbt_an_ctrl);
+
+	return ret_val;
+}
+
+/**
+ * igc_wait_autoneg - Wait for auto-neg completion
+ * @hw: pointer to the HW structure
+ *
+ * Waits for auto-negotiation to complete or for the auto-negotiation time
+ * limit to expire, which ever happens first.
+ */
+static s32 igc_wait_autoneg(struct igc_hw *hw)
+{
+	u16 i, phy_status;
+	s32 ret_val = 0;
+
+	/* Break after autoneg completes or PHY_AUTO_NEG_LIMIT expires. */
+	for (i = PHY_AUTO_NEG_LIMIT; i > 0; i--) {
+		ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS, &phy_status);
+		if (ret_val)
+			break;
+		ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS, &phy_status);
+		if (ret_val)
+			break;
+		if (phy_status & MII_SR_AUTONEG_COMPLETE)
+			break;
+		msleep(100);
+	}
+
+	/* PHY_AUTO_NEG_TIME expiration doesn't guarantee auto-negotiation
+	 * has completed.
+	 */
+	return ret_val;
+}
+
+/**
+ * igc_copper_link_autoneg - Setup/Enable autoneg for copper link
+ * @hw: pointer to the HW structure
+ *
+ * Performs initial bounds checking on autoneg advertisement parameter, then
+ * configure to advertise the full capability.  Setup the PHY to autoneg
+ * and restart the negotiation process between the link partner.  If
+ * autoneg_wait_to_complete, then wait for autoneg to complete before exiting.
+ */
+static s32 igc_copper_link_autoneg(struct igc_hw *hw)
+{
+	struct igc_phy_info *phy = &hw->phy;
+	u16 phy_ctrl;
+	s32 ret_val;
+
+	/* Perform some bounds checking on the autoneg advertisement
+	 * parameter.
+	 */
+	phy->autoneg_advertised &= phy->autoneg_mask;
+
+	/* If autoneg_advertised is zero, we assume it was not defaulted
+	 * by the calling code so we set to advertise full capability.
+	 */
+	if (phy->autoneg_advertised == 0)
+		phy->autoneg_advertised = phy->autoneg_mask;
+
+	hw_dbg("Reconfiguring auto-neg advertisement params\n");
+	ret_val = igc_phy_setup_autoneg(hw);
+	if (ret_val) {
+		hw_dbg("Error Setting up Auto-Negotiation\n");
+		goto out;
+	}
+	hw_dbg("Restarting Auto-Neg\n");
+
+	/* Restart auto-negotiation by setting the Auto Neg Enable bit and
+	 * the Auto Neg Restart bit in the PHY control register.
+	 */
+	ret_val = phy->ops.read_reg(hw, PHY_CONTROL, &phy_ctrl);
+	if (ret_val)
+		goto out;
+
+	phy_ctrl |= (MII_CR_AUTO_NEG_EN | MII_CR_RESTART_AUTO_NEG);
+	ret_val = phy->ops.write_reg(hw, PHY_CONTROL, phy_ctrl);
+	if (ret_val)
+		goto out;
+
+	/* Does the user want to wait for Auto-Neg to complete here, or
+	 * check at a later time (for example, callback routine).
+	 */
+	if (phy->autoneg_wait_to_complete) {
+		ret_val = igc_wait_autoneg(hw);
+		if (ret_val) {
+			hw_dbg("Error while waiting for autoneg to complete\n");
+			goto out;
+		}
+	}
+
+	hw->mac.get_link_status = true;
+
+out:
+	return ret_val;
+}
+
+/**
+ * igc_setup_copper_link - Configure copper link settings
+ * @hw: pointer to the HW structure
+ *
+ * Calls the appropriate function to configure the link for auto-neg or forced
+ * speed and duplex.  Then we check for link, once link is established calls
+ * to configure collision distance and flow control are called.  If link is
+ * not established, we return -IGC_ERR_PHY (-2).
+ */
+s32 igc_setup_copper_link(struct igc_hw *hw)
+{
+	s32 ret_val = 0;
+	bool link;
+
+	if (hw->mac.autoneg) {
+		/* Setup autoneg and flow control advertisement and perform
+		 * autonegotiation.
+		 */
+		ret_val = igc_copper_link_autoneg(hw);
+		if (ret_val)
+			goto out;
+	} else {
+		/* PHY will be set to 10H, 10F, 100H or 100F
+		 * depending on user settings.
+		 */
+		hw_dbg("Forcing Speed and Duplex\n");
+		ret_val = hw->phy.ops.force_speed_duplex(hw);
+		if (ret_val) {
+			hw_dbg("Error Forcing Speed and Duplex\n");
+			goto out;
+		}
+	}
+
+	/* Check link status. Wait up to 100 microseconds for link to become
+	 * valid.
+	 */
+	ret_val = igc_phy_has_link(hw, COPPER_LINK_UP_LIMIT, 10, &link);
+	if (ret_val)
+		goto out;
+
+	if (link) {
+		hw_dbg("Valid link established!!!\n");
+		igc_config_collision_dist(hw);
+		ret_val = igc_config_fc_after_link_up(hw);
+	} else {
+		hw_dbg("Unable to establish link!!!\n");
+	}
+
+out:
+	return ret_val;
+}
+
+/**
+ * igc_read_phy_reg_mdic - Read MDI control register
+ * @hw: pointer to the HW structure
+ * @offset: register offset to be read
+ * @data: pointer to the read data
+ *
+ * Reads the MDI control register in the PHY at offset and stores the
+ * information read to data.
+ */
+static s32 igc_read_phy_reg_mdic(struct igc_hw *hw, u32 offset, u16 *data)
+{
+	struct igc_phy_info *phy = &hw->phy;
+	u32 i, mdic = 0;
+	s32 ret_val = 0;
+
+	if (offset > MAX_PHY_REG_ADDRESS) {
+		hw_dbg("PHY Address %d is out of range\n", offset);
+		ret_val = -IGC_ERR_PARAM;
+		goto out;
+	}
+
+	/* Set up Op-code, Phy Address, and register offset in the MDI
+	 * Control register.  The MAC will take care of interfacing with the
+	 * PHY to retrieve the desired data.
+	 */
+	mdic = ((offset << IGC_MDIC_REG_SHIFT) |
+		(phy->addr << IGC_MDIC_PHY_SHIFT) |
+		(IGC_MDIC_OP_READ));
+
+	wr32(IGC_MDIC, mdic);
+
+	/* Poll the ready bit to see if the MDI read completed
+	 * Increasing the time out as testing showed failures with
+	 * the lower time out
+	 */
+	for (i = 0; i < IGC_GEN_POLL_TIMEOUT; i++) {
+		usleep_range(500, 1000);
+		mdic = rd32(IGC_MDIC);
+		if (mdic & IGC_MDIC_READY)
+			break;
+	}
+	if (!(mdic & IGC_MDIC_READY)) {
+		hw_dbg("MDI Read did not complete\n");
+		ret_val = -IGC_ERR_PHY;
+		goto out;
+	}
+	if (mdic & IGC_MDIC_ERROR) {
+		hw_dbg("MDI Error\n");
+		ret_val = -IGC_ERR_PHY;
+		goto out;
+	}
+	*data = (u16)mdic;
+
+out:
+	return ret_val;
+}
+
+/**
+ * igc_write_phy_reg_mdic - Write MDI control register
+ * @hw: pointer to the HW structure
+ * @offset: register offset to write to
+ * @data: data to write to register at offset
+ *
+ * Writes data to MDI control register in the PHY at offset.
+ */
+static s32 igc_write_phy_reg_mdic(struct igc_hw *hw, u32 offset, u16 data)
+{
+	struct igc_phy_info *phy = &hw->phy;
+	u32 i, mdic = 0;
+	s32 ret_val = 0;
+
+	if (offset > MAX_PHY_REG_ADDRESS) {
+		hw_dbg("PHY Address %d is out of range\n", offset);
+		ret_val = -IGC_ERR_PARAM;
+		goto out;
+	}
+
+	/* Set up Op-code, Phy Address, and register offset in the MDI
+	 * Control register.  The MAC will take care of interfacing with the
+	 * PHY to write the desired data.
+	 */
+	mdic = (((u32)data) |
+		(offset << IGC_MDIC_REG_SHIFT) |
+		(phy->addr << IGC_MDIC_PHY_SHIFT) |
+		(IGC_MDIC_OP_WRITE));
+
+	wr32(IGC_MDIC, mdic);
+
+	/* Poll the ready bit to see if the MDI read completed
+	 * Increasing the time out as testing showed failures with
+	 * the lower time out
+	 */
+	for (i = 0; i < IGC_GEN_POLL_TIMEOUT; i++) {
+		usleep_range(500, 1000);
+		mdic = rd32(IGC_MDIC);
+		if (mdic & IGC_MDIC_READY)
+			break;
+	}
+	if (!(mdic & IGC_MDIC_READY)) {
+		hw_dbg("MDI Write did not complete\n");
+		ret_val = -IGC_ERR_PHY;
+		goto out;
+	}
+	if (mdic & IGC_MDIC_ERROR) {
+		hw_dbg("MDI Error\n");
+		ret_val = -IGC_ERR_PHY;
+		goto out;
+	}
+
+out:
+	return ret_val;
+}
+
+/**
+ * __igc_access_xmdio_reg - Read/write XMDIO register
+ * @hw: pointer to the HW structure
+ * @address: XMDIO address to program
+ * @dev_addr: device address to program
+ * @data: pointer to value to read/write from/to the XMDIO address
+ * @read: boolean flag to indicate read or write
+ */
+static s32 __igc_access_xmdio_reg(struct igc_hw *hw, u16 address,
+				  u8 dev_addr, u16 *data, bool read)
+{
+	s32 ret_val;
+
+	ret_val = hw->phy.ops.write_reg(hw, IGC_MMDAC, dev_addr);
+	if (ret_val)
+		return ret_val;
+
+	ret_val = hw->phy.ops.write_reg(hw, IGC_MMDAAD, address);
+	if (ret_val)
+		return ret_val;
+
+	ret_val = hw->phy.ops.write_reg(hw, IGC_MMDAC, IGC_MMDAC_FUNC_DATA |
+					dev_addr);
+	if (ret_val)
+		return ret_val;
+
+	if (read)
+		ret_val = hw->phy.ops.read_reg(hw, IGC_MMDAAD, data);
+	else
+		ret_val = hw->phy.ops.write_reg(hw, IGC_MMDAAD, *data);
+	if (ret_val)
+		return ret_val;
+
+	/* Recalibrate the device back to 0 */
+	ret_val = hw->phy.ops.write_reg(hw, IGC_MMDAC, 0);
+	if (ret_val)
+		return ret_val;
+
+	return ret_val;
+}
+
+/**
+ * igc_read_xmdio_reg - Read XMDIO register
+ * @hw: pointer to the HW structure
+ * @addr: XMDIO address to program
+ * @dev_addr: device address to program
+ * @data: value to be read from the EMI address
+ */
+static s32 igc_read_xmdio_reg(struct igc_hw *hw, u16 addr,
+			      u8 dev_addr, u16 *data)
+{
+	return __igc_access_xmdio_reg(hw, addr, dev_addr, data, true);
+}
+
+/**
+ * igc_write_xmdio_reg - Write XMDIO register
+ * @hw: pointer to the HW structure
+ * @addr: XMDIO address to program
+ * @dev_addr: device address to program
+ * @data: value to be written to the XMDIO address
+ */
+static s32 igc_write_xmdio_reg(struct igc_hw *hw, u16 addr,
+			       u8 dev_addr, u16 data)
+{
+	return __igc_access_xmdio_reg(hw, addr, dev_addr, &data, false);
+}
+
+/**
+ * igc_write_phy_reg_gpy - Write GPY PHY register
+ * @hw: pointer to the HW structure
+ * @offset: register offset to write to
+ * @data: data to write at register offset
+ *
+ * Acquires semaphore, if necessary, then writes the data to PHY register
+ * at the offset. Release any acquired semaphores before exiting.
+ */
+s32 igc_write_phy_reg_gpy(struct igc_hw *hw, u32 offset, u16 data)
+{
+	u8 dev_addr = (offset & GPY_MMD_MASK) >> GPY_MMD_SHIFT;
+	s32 ret_val;
+
+	offset = offset & GPY_REG_MASK;
+
+	if (!dev_addr) {
+		ret_val = hw->phy.ops.acquire(hw);
+		if (ret_val)
+			return ret_val;
+		ret_val = igc_write_phy_reg_mdic(hw, offset, data);
+		if (ret_val)
+			return ret_val;
+		hw->phy.ops.release(hw);
+	} else {
+		ret_val = igc_write_xmdio_reg(hw, (u16)offset, dev_addr,
+					      data);
+	}
+
+	return ret_val;
+}
+
+/**
+ * igc_read_phy_reg_gpy - Read GPY PHY register
+ * @hw: pointer to the HW structure
+ * @offset: lower half is register offset to read to
+ * upper half is MMD to use.
+ * @data: data to read at register offset
+ *
+ * Acquires semaphore, if necessary, then reads the data in the PHY register
+ * at the offset. Release any acquired semaphores before exiting.
+ */
+s32 igc_read_phy_reg_gpy(struct igc_hw *hw, u32 offset, u16 *data)
+{
+	u8 dev_addr = (offset & GPY_MMD_MASK) >> GPY_MMD_SHIFT;
+	s32 ret_val;
+
+	offset = offset & GPY_REG_MASK;
+
+	if (!dev_addr) {
+		ret_val = hw->phy.ops.acquire(hw);
+		if (ret_val)
+			return ret_val;
+		ret_val = igc_read_phy_reg_mdic(hw, offset, data);
+		if (ret_val)
+			return ret_val;
+		hw->phy.ops.release(hw);
+	} else {
+		ret_val = igc_read_xmdio_reg(hw, (u16)offset, dev_addr,
+					     data);
+	}
+
+	return ret_val;
+}
diff --git a/kernel/drivers/net/drivers/igc/igc_phy.h b/kernel/drivers/net/drivers/igc/igc_phy.h
new file mode 100644
index 000000000..25cba33de
--- /dev/null
+++ b/kernel/drivers/net/drivers/igc/igc_phy.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c)  2018 Intel Corporation */
+
+#ifndef _IGC_PHY_H_
+#define _IGC_PHY_H_
+
+#include "igc_mac.h"
+
+s32 igc_check_reset_block(struct igc_hw *hw);
+s32 igc_phy_hw_reset(struct igc_hw *hw);
+s32 igc_get_phy_id(struct igc_hw *hw);
+s32 igc_phy_has_link(struct igc_hw *hw, u32 iterations,
+		     u32 usec_interval, bool *success);
+s32 igc_check_downshift(struct igc_hw *hw);
+s32 igc_setup_copper_link(struct igc_hw *hw);
+void igc_power_up_phy_copper(struct igc_hw *hw);
+void igc_power_down_phy_copper(struct igc_hw *hw);
+s32 igc_write_phy_reg_gpy(struct igc_hw *hw, u32 offset, u16 data);
+s32 igc_read_phy_reg_gpy(struct igc_hw *hw, u32 offset, u16 *data);
+
+#endif
diff --git a/kernel/drivers/net/drivers/igc/igc_regs.h b/kernel/drivers/net/drivers/igc/igc_regs.h
new file mode 100644
index 000000000..b52dd9d73
--- /dev/null
+++ b/kernel/drivers/net/drivers/igc/igc_regs.h
@@ -0,0 +1,267 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c)  2018 Intel Corporation */
+
+#ifndef _IGC_REGS_H_
+#define _IGC_REGS_H_
+
+/* General Register Descriptions */
+#define IGC_CTRL		0x00000  /* Device Control - RW */
+#define IGC_STATUS		0x00008  /* Device Status - RO */
+#define IGC_EECD		0x00010  /* EEPROM/Flash Control - RW */
+#define IGC_CTRL_EXT		0x00018  /* Extended Device Control - RW */
+#define IGC_MDIC		0x00020  /* MDI Control - RW */
+#define IGC_MDICNFG		0x00E04  /* MDC/MDIO Configuration - RW */
+#define IGC_CONNSW		0x00034  /* Copper/Fiber switch control - RW */
+#define IGC_I225_PHPM		0x00E14  /* I225 PHY Power Management */
+
+/* Internal Packet Buffer Size Registers */
+#define IGC_RXPBS		0x02404  /* Rx Packet Buffer Size - RW */
+#define IGC_TXPBS		0x03404  /* Tx Packet Buffer Size - RW */
+
+/* NVM  Register Descriptions */
+#define IGC_EERD		0x12014  /* EEprom mode read - RW */
+#define IGC_EEWR		0x12018  /* EEprom mode write - RW */
+
+/* Flow Control Register Descriptions */
+#define IGC_FCAL		0x00028  /* FC Address Low - RW */
+#define IGC_FCAH		0x0002C  /* FC Address High - RW */
+#define IGC_FCT			0x00030  /* FC Type - RW */
+#define IGC_FCTTV		0x00170  /* FC Transmit Timer - RW */
+#define IGC_FCRTL		0x02160  /* FC Receive Threshold Low - RW */
+#define IGC_FCRTH		0x02168  /* FC Receive Threshold High - RW */
+#define IGC_FCRTV		0x02460  /* FC Refresh Timer Value - RW */
+
+/* Semaphore registers */
+#define IGC_SW_FW_SYNC		0x05B5C  /* SW-FW Synchronization - RW */
+#define IGC_SWSM		0x05B50  /* SW Semaphore */
+#define IGC_FWSM		0x05B54  /* FW Semaphore */
+
+/* Function Active and Power State to MNG */
+#define IGC_FACTPS		0x05B30
+
+/* Interrupt Register Description */
+#define IGC_EICR		0x01580  /* Ext. Interrupt Cause read - W0 */
+#define IGC_EICS		0x01520  /* Ext. Interrupt Cause Set - W0 */
+#define IGC_EIMS		0x01524  /* Ext. Interrupt Mask Set/Read - RW */
+#define IGC_EIMC		0x01528  /* Ext. Interrupt Mask Clear - WO */
+#define IGC_EIAC		0x0152C  /* Ext. Interrupt Auto Clear - RW */
+#define IGC_EIAM		0x01530  /* Ext. Interrupt Auto Mask - RW */
+#define IGC_ICR			0x01500  /* Intr Cause Read - RC/W1C */
+#define IGC_ICS			0x01504  /* Intr Cause Set - WO */
+#define IGC_IMS			0x01508  /* Intr Mask Set/Read - RW */
+#define IGC_IMC			0x0150C  /* Intr Mask Clear - WO */
+#define IGC_IAM			0x01510  /* Intr Ack Auto Mask- RW */
+/* Intr Throttle - RW */
+#define IGC_EITR(_n)		(0x01680 + (0x4 * (_n)))
+/* Interrupt Vector Allocation - RW */
+#define IGC_IVAR0		0x01700
+#define IGC_IVAR_MISC		0x01740  /* IVAR for "other" causes - RW */
+#define IGC_GPIE		0x01514  /* General Purpose Intr Enable - RW */
+
+/* MSI-X Table Register Descriptions */
+#define IGC_PBACL		0x05B68  /* MSIx PBA Clear - R/W 1 to clear */
+
+/* RSS registers */
+#define IGC_MRQC		0x05818 /* Multiple Receive Control - RW */
+
+/* Filtering Registers */
+#define IGC_ETQF(_n)		(0x05CB0 + (4 * (_n))) /* EType Queue Fltr */
+
+/* ETQF register bit definitions */
+#define IGC_ETQF_FILTER_ENABLE	BIT(26)
+#define IGC_ETQF_QUEUE_ENABLE	BIT(31)
+#define IGC_ETQF_QUEUE_SHIFT	16
+#define IGC_ETQF_QUEUE_MASK	0x00070000
+#define IGC_ETQF_ETYPE_MASK	0x0000FFFF
+
+/* Redirection Table - RW Array */
+#define IGC_RETA(_i)		(0x05C00 + ((_i) * 4))
+/* RSS Random Key - RW Array */
+#define IGC_RSSRK(_i)		(0x05C80 + ((_i) * 4))
+
+/* Receive Register Descriptions */
+#define IGC_RCTL		0x00100  /* Rx Control - RW */
+#define IGC_SRRCTL(_n)		(0x0C00C + ((_n) * 0x40))
+#define IGC_PSRTYPE(_i)		(0x05480 + ((_i) * 4))
+#define IGC_RDBAL(_n)		(0x0C000 + ((_n) * 0x40))
+#define IGC_RDBAH(_n)		(0x0C004 + ((_n) * 0x40))
+#define IGC_RDLEN(_n)		(0x0C008 + ((_n) * 0x40))
+#define IGC_RDH(_n)		(0x0C010 + ((_n) * 0x40))
+#define IGC_RDT(_n)		(0x0C018 + ((_n) * 0x40))
+#define IGC_RXDCTL(_n)		(0x0C028 + ((_n) * 0x40))
+#define IGC_RQDPC(_n)		(0x0C030 + ((_n) * 0x40))
+#define IGC_RXCSUM		0x05000  /* Rx Checksum Control - RW */
+#define IGC_RLPML		0x05004  /* Rx Long Packet Max Length */
+#define IGC_RFCTL		0x05008  /* Receive Filter Control*/
+#define IGC_MTA			0x05200  /* Multicast Table Array - RW Array */
+#define IGC_RA			0x05400  /* Receive Address - RW Array */
+#define IGC_UTA			0x0A000  /* Unicast Table Array - RW */
+#define IGC_RAL(_n)		(0x05400 + ((_n) * 0x08))
+#define IGC_RAH(_n)		(0x05404 + ((_n) * 0x08))
+#define IGC_VLANPQF		0x055B0  /* VLAN Priority Queue Filter - RW */
+
+/* Transmit Register Descriptions */
+#define IGC_TCTL		0x00400  /* Tx Control - RW */
+#define IGC_TIPG		0x00410  /* Tx Inter-packet gap - RW */
+#define IGC_TDBAL(_n)		(0x0E000 + ((_n) * 0x40))
+#define IGC_TDBAH(_n)		(0x0E004 + ((_n) * 0x40))
+#define IGC_TDLEN(_n)		(0x0E008 + ((_n) * 0x40))
+#define IGC_TDH(_n)		(0x0E010 + ((_n) * 0x40))
+#define IGC_TDT(_n)		(0x0E018 + ((_n) * 0x40))
+#define IGC_TXDCTL(_n)		(0x0E028 + ((_n) * 0x40))
+
+/* MMD Register Descriptions */
+#define IGC_MMDAC		13 /* MMD Access Control */
+#define IGC_MMDAAD		14 /* MMD Access Address/Data */
+
+/* Statistics Register Descriptions */
+#define IGC_CRCERRS	0x04000  /* CRC Error Count - R/clr */
+#define IGC_ALGNERRC	0x04004  /* Alignment Error Count - R/clr */
+#define IGC_RXERRC	0x0400C  /* Receive Error Count - R/clr */
+#define IGC_MPC		0x04010  /* Missed Packet Count - R/clr */
+#define IGC_SCC		0x04014  /* Single Collision Count - R/clr */
+#define IGC_ECOL	0x04018  /* Excessive Collision Count - R/clr */
+#define IGC_MCC		0x0401C  /* Multiple Collision Count - R/clr */
+#define IGC_LATECOL	0x04020  /* Late Collision Count - R/clr */
+#define IGC_COLC	0x04028  /* Collision Count - R/clr */
+#define IGC_RERC	0x0402C  /* Receive Error Count - R/clr */
+#define IGC_DC		0x04030  /* Defer Count - R/clr */
+#define IGC_TNCRS	0x04034  /* Tx-No CRS - R/clr */
+#define IGC_HTDPMC	0x0403C  /* Host Transmit Discarded by MAC - R/clr */
+#define IGC_RLEC	0x04040  /* Receive Length Error Count - R/clr */
+#define IGC_XONRXC	0x04048  /* XON Rx Count - R/clr */
+#define IGC_XONTXC	0x0404C  /* XON Tx Count - R/clr */
+#define IGC_XOFFRXC	0x04050  /* XOFF Rx Count - R/clr */
+#define IGC_XOFFTXC	0x04054  /* XOFF Tx Count - R/clr */
+#define IGC_FCRUC	0x04058  /* Flow Control Rx Unsupported Count- R/clr */
+#define IGC_PRC64	0x0405C  /* Packets Rx (64 bytes) - R/clr */
+#define IGC_PRC127	0x04060  /* Packets Rx (65-127 bytes) - R/clr */
+#define IGC_PRC255	0x04064  /* Packets Rx (128-255 bytes) - R/clr */
+#define IGC_PRC511	0x04068  /* Packets Rx (255-511 bytes) - R/clr */
+#define IGC_PRC1023	0x0406C  /* Packets Rx (512-1023 bytes) - R/clr */
+#define IGC_PRC1522	0x04070  /* Packets Rx (1024-1522 bytes) - R/clr */
+#define IGC_GPRC	0x04074  /* Good Packets Rx Count - R/clr */
+#define IGC_BPRC	0x04078  /* Broadcast Packets Rx Count - R/clr */
+#define IGC_MPRC	0x0407C  /* Multicast Packets Rx Count - R/clr */
+#define IGC_GPTC	0x04080  /* Good Packets Tx Count - R/clr */
+#define IGC_GORCL	0x04088  /* Good Octets Rx Count Low - R/clr */
+#define IGC_GORCH	0x0408C  /* Good Octets Rx Count High - R/clr */
+#define IGC_GOTCL	0x04090  /* Good Octets Tx Count Low - R/clr */
+#define IGC_GOTCH	0x04094  /* Good Octets Tx Count High - R/clr */
+#define IGC_RNBC	0x040A0  /* Rx No Buffers Count - R/clr */
+#define IGC_RUC		0x040A4  /* Rx Undersize Count - R/clr */
+#define IGC_RFC		0x040A8  /* Rx Fragment Count - R/clr */
+#define IGC_ROC		0x040AC  /* Rx Oversize Count - R/clr */
+#define IGC_RJC		0x040B0  /* Rx Jabber Count - R/clr */
+#define IGC_MGTPRC	0x040B4  /* Management Packets Rx Count - R/clr */
+#define IGC_MGTPDC	0x040B8  /* Management Packets Dropped Count - R/clr */
+#define IGC_MGTPTC	0x040BC  /* Management Packets Tx Count - R/clr */
+#define IGC_TORL	0x040C0  /* Total Octets Rx Low - R/clr */
+#define IGC_TORH	0x040C4  /* Total Octets Rx High - R/clr */
+#define IGC_TOTL	0x040C8  /* Total Octets Tx Low - R/clr */
+#define IGC_TOTH	0x040CC  /* Total Octets Tx High - R/clr */
+#define IGC_TPR		0x040D0  /* Total Packets Rx - R/clr */
+#define IGC_TPT		0x040D4  /* Total Packets Tx - R/clr */
+#define IGC_PTC64	0x040D8  /* Packets Tx (64 bytes) - R/clr */
+#define IGC_PTC127	0x040DC  /* Packets Tx (65-127 bytes) - R/clr */
+#define IGC_PTC255	0x040E0  /* Packets Tx (128-255 bytes) - R/clr */
+#define IGC_PTC511	0x040E4  /* Packets Tx (256-511 bytes) - R/clr */
+#define IGC_PTC1023	0x040E8  /* Packets Tx (512-1023 bytes) - R/clr */
+#define IGC_PTC1522	0x040EC  /* Packets Tx (1024-1522 Bytes) - R/clr */
+#define IGC_MPTC	0x040F0  /* Multicast Packets Tx Count - R/clr */
+#define IGC_BPTC	0x040F4  /* Broadcast Packets Tx Count - R/clr */
+#define IGC_TSCTC	0x040F8  /* TCP Segmentation Context Tx - R/clr */
+#define IGC_IAC		0x04100  /* Interrupt Assertion Count */
+#define IGC_RPTHC	0x04104  /* Rx Packets To Host */
+#define IGC_TLPIC	0x04148  /* EEE Tx LPI Count */
+#define IGC_RLPIC	0x0414C  /* EEE Rx LPI Count */
+#define IGC_HGPTC	0x04118  /* Host Good Packets Tx Count */
+#define IGC_RXDMTC	0x04120  /* Rx Descriptor Minimum Threshold Count */
+#define IGC_HGORCL	0x04128  /* Host Good Octets Received Count Low */
+#define IGC_HGORCH	0x0412C  /* Host Good Octets Received Count High */
+#define IGC_HGOTCL	0x04130  /* Host Good Octets Transmit Count Low */
+#define IGC_HGOTCH	0x04134  /* Host Good Octets Transmit Count High */
+#define IGC_LENERRS	0x04138  /* Length Errors Count */
+
+/* Time sync registers */
+#define IGC_TSICR	0x0B66C  /* Time Sync Interrupt Cause */
+#define IGC_TSIM	0x0B674  /* Time Sync Interrupt Mask Register */
+#define IGC_TSAUXC	0x0B640  /* Timesync Auxiliary Control register */
+#define IGC_TSYNCRXCTL	0x0B620  /* Rx Time Sync Control register - RW */
+#define IGC_TSYNCTXCTL	0x0B614  /* Tx Time Sync Control register - RW */
+#define IGC_TSYNCRXCFG	0x05F50  /* Time Sync Rx Configuration - RW */
+#define IGC_TSSDP	0x0003C  /* Time Sync SDP Configuration Register - RW */
+
+#define IGC_IMIR(_i)	(0x05A80 + ((_i) * 4))  /* Immediate Interrupt */
+#define IGC_IMIREXT(_i)	(0x05AA0 + ((_i) * 4))  /* Immediate INTR Ext*/
+
+#define IGC_FTQF(_n)	(0x059E0 + (4 * (_n)))  /* 5-tuple Queue Fltr */
+
+/* Transmit Scheduling Registers */
+#define IGC_TQAVCTRL		0x3570
+#define IGC_TXQCTL(_n)		(0x3344 + 0x4 * (_n))
+#define IGC_BASET_L		0x3314
+#define IGC_BASET_H		0x3318
+#define IGC_QBVCYCLET		0x331C
+#define IGC_QBVCYCLET_S		0x3320
+
+#define IGC_STQT(_n)		(0x3324 + 0x4 * (_n))
+#define IGC_ENDQT(_n)		(0x3334 + 0x4 * (_n))
+#define IGC_DTXMXPKTSZ		0x355C
+
+/* System Time Registers */
+#define IGC_SYSTIML	0x0B600  /* System time register Low - RO */
+#define IGC_SYSTIMH	0x0B604  /* System time register High - RO */
+#define IGC_SYSTIMR	0x0B6F8  /* System time register Residue */
+#define IGC_TIMINCA	0x0B608  /* Increment attributes register - RW */
+
+#define IGC_TXSTMPL	0x0B618  /* Tx timestamp value Low - RO */
+#define IGC_TXSTMPH	0x0B61C  /* Tx timestamp value High - RO */
+
+/* Management registers */
+#define IGC_MANC	0x05820  /* Management Control - RW */
+
+/* Shadow Ram Write Register - RW */
+#define IGC_SRWR	0x12018
+
+/* Wake Up registers */
+#define IGC_WUC		0x05800  /* Wakeup Control - RW */
+#define IGC_WUFC	0x05808  /* Wakeup Filter Control - RW */
+#define IGC_WUS		0x05810  /* Wakeup Status - R/W1C */
+#define IGC_WUPL	0x05900  /* Wakeup Packet Length - RW */
+
+/* Wake Up packet memory */
+#define IGC_WUPM_REG(_i)	(0x05A00 + ((_i) * 4))
+
+/* Energy Efficient Ethernet "EEE" registers */
+#define IGC_EEER	0x0E30 /* Energy Efficient Ethernet "EEE"*/
+#define IGC_IPCNFG	0x0E38 /* Internal PHY Configuration */
+#define IGC_EEE_SU	0x0E34 /* EEE Setup */
+
+/* LTR registers */
+#define IGC_LTRC	0x01A0 /* Latency Tolerance Reporting Control */
+#define IGC_DMACR	0x02508 /* DMA Coalescing Control Register */
+#define IGC_LTRMINV	0x5BB0 /* LTR Minimum Value */
+#define IGC_LTRMAXV	0x5BB4 /* LTR Maximum Value */
+
+/* forward declaration */
+struct igc_hw;
+u32 igc_rd32(struct igc_hw *hw, u32 reg);
+
+/* write operations, indexed using DWORDS */
+#define wr32(reg, val) \
+do { \
+	u8 __iomem *hw_addr = READ_ONCE((hw)->hw_addr); \
+	writel((val), &hw_addr[(reg)]); \
+} while (0)
+
+#define rd32(reg) (igc_rd32(hw, reg))
+
+#define wrfl() ((void)rd32(IGC_STATUS))
+
+#define array_wr32(reg, offset, value) \
+	wr32((reg) + ((offset) << 2), (value))
+
+#define array_rd32(reg, offset) (igc_rd32(hw, (reg) + ((offset) << 2)))
+
+#endif
-- 
2.17.1

