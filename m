Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BF62F3A
	for <xenomai@lists.linux.dev>; Wed, 18 Jan 2023 13:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674048575; x=1705584575;
  h=from:to:subject:date:message-id;
  bh=qtzl5JN8+MLyH4gEn+lhr2UgRje/0P4BGfo6E7EGv8A=;
  b=Wc+IjiEJkw6AVLz6Etoe2kQehSSgzBwWY0k4wwPQbkKBRCd/YYkIAL60
   C2reLkQcAZPKDle5jQ/LQ7h/kaXDk1gNrQePJ7WieSqYRwIYpsweILhN5
   7u7vHW+FQXXivGlpDH5SZ3nG8s9N8NzlVxsRm1ckhdVA4kg2lff0KUdir
   vxs9acoO5vXSNwJCjuppMqS6eQSLuXVzJRRo/EFI67k/8TrDssTdOq5NB
   Ayzu2Te+WehvVCqPHchMfjSYgjShtTTuvJhYVzj8rdMHsafRbZdpvpi9Z
   Jz27k1ne6JjECBZN8N5nD/mAehYAz+H+7JfMb+jDYtpJgmqf+JYXvwmtV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="322669934"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="322669934"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 05:29:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="767739022"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="767739022"
Received: from intel-z97x-ud5h.sh.intel.com ([10.67.103.201])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 05:29:33 -0800
From: Hongzhan Chen <hongzhan.chen@intel.com>
To: xenomai@lists.linux.dev
Subject: [PATCH] testsuite: dpdk: Add l2fwd example which is based on DPDK.
Date: Wed, 18 Jan 2023 08:05:06 -0500
Message-Id: <20230118130506.30418-1-hongzhan.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>

The L2 Forwarding sample application(l2fwd) is a simple
example of packet processing using the Data Plane
Development Kit (DPDK).

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>

diff --git a/configure.ac b/configure.ac
index 3ce34048e..3a90fc201 100644
--- a/configure.ac
+++ b/configure.ac
@@ -848,6 +848,17 @@ AC_ARG_ENABLE(libtraceevent_plugin,
 AC_MSG_RESULT(${libtraceevent_plugin:-no})
 AM_CONDITIONAL(XENO_LIBTRACEEVENT_PLUGIN, [test x$libtraceevent_plugin = xy])
 
+dpdktest=
+AC_MSG_CHECKING(whether dpdktest should be built)
+AC_ARG_ENABLE(dpdktest,
+	      AS_HELP_STRING([--enable-dpdktest], [build dpdktest]),
+	[case "$enableval" in
+	y | yes) dpdktest=y ;;
+	*) unset dpdktest ;;
+	esac])
+AC_MSG_RESULT(${dpdktest:-no})
+AM_CONDITIONAL(XENO_DPDKTEST, [test x$dpdktest = xy])
+
 if test x$kernelshark_plugin = xy -o x$libtraceevent_plugin = xy; then
 	PKG_CHECK_MODULES(LIBTRACEEVENT, libtraceevent)
 fi
@@ -856,6 +867,10 @@ if test x$kernelshark_plugin = xy; then
 	PKG_CHECK_MODULES(LIBKSHARK, libkshark)
 fi
 
+if test x$dpdktest = xy; then
+	PKG_CHECK_MODULES(LIBDPDK, libdpdk)
+fi
+
 AC_MSG_CHECKING([for test source generation])
 AC_RUN_IFELSE([AC_LANG_PROGRAM([[ ]], [[ ]])],
     [AC_MSG_RESULT(ok)], [AC_MSG_RESULT(failed)], [AC_MSG_RESULT(untestable)])
@@ -1004,6 +1019,8 @@ AC_CONFIG_FILES([ \
 	lib/trank/Makefile \
 	testsuite/Makefile \
 	testsuite/latency/Makefile \
+	testsuite/dpdk/Makefile \
+	testsuite/dpdk/l2fwd/Makefile \
 	testsuite/switchtest/Makefile \
 	testsuite/gpiotest/Makefile \
 	testsuite/gpiobench/Makefile \
diff --git a/testsuite/Makefile.am b/testsuite/Makefile.am
index 4932f6d33..4f9c50a82 100644
--- a/testsuite/Makefile.am
+++ b/testsuite/Makefile.am
@@ -10,10 +10,17 @@ SUBDIRS += 		\
 	xeno-test
 endif
 
+if XENO_DPDKTEST
+SUBDIRS += 		\
+	dpdk
+
+endif
+
 DIST_SUBDIRS =		\
 	clocktest	\
+	dpdk		\
 	gpiotest	\
-	gpiobench   \
+	gpiobench   	\
 	latency		\
 	smokey		\
 	spitest		\
diff --git a/testsuite/dpdk/Makefile.am b/testsuite/dpdk/Makefile.am
new file mode 100644
index 000000000..7ab3f8b8b
--- /dev/null
+++ b/testsuite/dpdk/Makefile.am
@@ -0,0 +1,6 @@
+
+SUBDIRS = 		\
+	l2fwd
+
+DIST_SUBDIRS =		\
+	l2fwd
diff --git a/testsuite/dpdk/README b/testsuite/dpdk/README
new file mode 100644
index 000000000..cfb7fde55
--- /dev/null
+++ b/testsuite/dpdk/README
@@ -0,0 +1,94 @@
+
+What is it?
+=============
+
+  The modules under this folder include examples that ported from DPDK[1].
+
+Dependencies & Limitations
+================================
+
+  If you want to run these examples under xenomai, you would have to install
+DPDK at first in you system. Please refer to [2] to get dpdk started guild for
+linux. Currently, we cannot support VFIO drivers in xenomai so the examples
+depends on UIO driver.
+  In addtion, we just validated examples with IGB PMD driver on i210 NIC and
+limited X86 boards currently.
+
+How to build and install
+====================================
+
+    goto your xenomai folder
+    ./scripts/bootstrap
+    ./configure ... --enable-dpdktest
+    make
+    make install
+
+    Note: ... means other options that you may want to enable.
+
+How to use these examples?
+====================================
+
+  Common configure steps before run examples:
+
+  1. Enable hugepage:
+	mkdir -p /dev/hugepages
+	mountpoint -q /dev/hugepages || mount -t hugetlbfs nodev /dev/hugepages
+	echo 512 > /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages
+
+  2. Enable UIO driver:
+	modprobe uio_pci_generic
+
+  3. Bind NIC device with uio_pci_generic driver:
+	dpdk-devbind.py --bind=uio_pci_generic NIC_PIC_NUMBER
+
+	Note:
+	  3.1 Please find correct path for dpdk-devbind.py installed with DPDK if
+	      can not run it directly as previous dpdk-devbind.py example.
+
+	  3.2 You may type lspci | grep "Ethernet controller" to find the NIC_PIC_NUMBER
+	      for example:
+		root@ecs-xenomai-isar:/# lspci | grep Ethernet
+			03:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network Connection (rev 03)
+			04:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network Connection (rev 03)
+		root@ecs-xenomai-isar:/# dpdk-devbind.py --bind=uio_pci_generic 03:00.0
+		root@ecs-xenomai-isar:/# dpdk-devbind.py -s
+			Network devices using DPDK-compatible driver
+			============================================
+			0000:03:00.0 'I210 Gigabit Network Connection 157b' drv=uio_pci_generic unused=rt_igb
+
+			Network devices using kernel driver
+			===================================
+			0000:04:00.0 'I210 Gigabit Network Connection 157b' if=enp4s0 drv=igb unused=rt_igb,uio_pci_generic *Active*
+
+   Run examples:
+
+   4. The way to run example is like corresponding example in dpdk.
+	4.1 l2fwd
+	  4.1.1 Before run l2fwd, strongly suggest run dpdk-l2fwd [3] at first to check if all configurations is correct and basic
+		functions work. If packets received or sent are not zero with dpdk-l2fwd, please fix the issue at first. If dmesg print
+		following info, please pass iommu=pt to do work-around as discussed in [4].
+				DMAR: DRHD: handling fault status reg 3
+				DMAR: [DMA Read] Request device [03:00.0] PASID ffffffff fault addr 121a83000 [fault reason 06] PTE Read access is not set
+
+	   4.1.2 run l2fwd
+		/usr/xenomai/bin/l2fwd -l 1-2 -m 64 -n 3 -- -p 1
+
+	   4.1.3 Somethings are worth explaining further:
+		  In dpdk PMD mode, the performance of receiving or sending packets depends on polling capability of caller. But
+		When the caller is xenomai thread, it can not dominate cpu too much time in primary mode(or out-of-band). When
+		you enable CONFIG_XENO_OPT_WATCHDOG, the default XENO_OPT_WATCHDOG_TIMEOUT is 4s. That means xenomai thread
+		cannot dominate CPU more than 4s or else Linux would be frozen as discussed in [5]. In dual kernel configuration,
+		Xenomai thread do not have same polling capability as Linux thread. Xenomai threads would have to yield cpu out of
+		Xenomai domain to Linux domain before XENO_OPT_WATCHDOG_TIMEOUT trigger when you enable CONFIG_XENO_OPT_WATCHDOG to
+		avoid frozen Linux.
+		  Ported l2fwd had met same issue, in l2fwd_main_loop it would have to sleep a while to yield cpu and avoid triggering
+		the watchdog. But the drawback is that it may lower the performance of transmitting and receiving packets or even
+		cause dropped packets.
+		  Because of these limitations, this ported l2fwd does not have same capability as dpdk-l2fwd. But it still show the
+		capability of receiving and transmitting packets with DPDK on UIO driver in Xenomai.
+
+[1]: https://www.dpdk.org/
+[2]: http://doc.dpdk.org/guides/linux_gsg/
+[3]: http://doc.dpdk.org/guides/sample_app_ug/l2_forward_real_virtual.html
+[4]: https://inbox.dpdk.org/dev/b667dba1-c390-44b9-bc3b-521fa7f5becf@intel.com/
+[5]: https://lore.kernel.org/xenomai/c3a61a34-0028-57c1-1201-d18c1d9b1da0@siemens.com/T/#t
diff --git a/testsuite/dpdk/l2fwd/Makefile.am b/testsuite/dpdk/l2fwd/Makefile.am
new file mode 100644
index 000000000..b7a87f953
--- /dev/null
+++ b/testsuite/dpdk/l2fwd/Makefile.am
@@ -0,0 +1,24 @@
+testdir = @XENO_TEST_DIR@
+
+CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
+
+test_PROGRAMS = l2fwd
+
+l2fwd_SOURCES = l2fwd.c
+
+l2fwd_CPPFLAGS = 		\
+	$(XENO_USER_CFLAGS)	\
+	$(LIBDPDK_CFLAGS)	\
+	-I$(top_srcdir)/include
+
+l2fwd_LDFLAGS =	\
+	@XENO_AUTOINIT_LDFLAGS@	\
+	$(XENO_POSIX_WRAPPERS)	\
+	$(LIBDPDK_LIBS)
+
+l2fwd_LDADD =		\
+	@XENO_CORE_LDADD@	\
+	@XENO_USER_LDADD@	\
+	-lpthread -lrt -lm -ldl -lnuma -lrte_eal \
+	-lrte_mempool -lrte_meter -lrte_mbuf \
+	-lrte_ring -lrte_net -lrte_ethdev
diff --git a/testsuite/dpdk/l2fwd/l2fwd.c b/testsuite/dpdk/l2fwd/l2fwd.c
new file mode 100644
index 000000000..5a51c91d8
--- /dev/null
+++ b/testsuite/dpdk/l2fwd/l2fwd.c
@@ -0,0 +1,1066 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2010-2016 Intel Corporation,
+ * ported by Hongzhan Chen <hongzhan.chen@intel.com> from DPDK
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdint.h>
+#include <inttypes.h>
+#include <sys/types.h>
+#include <sys/queue.h>
+#include <setjmp.h>
+#include <stdarg.h>
+#include <ctype.h>
+#include <errno.h>
+#include <unistd.h>
+#include <pthread.h>
+#include <semaphore.h>
+#include <error.h>
+#include <getopt.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <fcntl.h>
+
+#include <rte_common.h>
+#include <rte_log.h>
+#include <rte_malloc.h>
+#include <rte_memory.h>
+#include <rte_memcpy.h>
+#include <rte_eal.h>
+#include <rte_launch.h>
+#include <rte_cycles.h>
+#include <rte_prefetch.h>
+#include <rte_lcore.h>
+#include <rte_per_lcore.h>
+#include <rte_branch_prediction.h>
+#include <rte_interrupts.h>
+#include <rte_random.h>
+#include <rte_debug.h>
+#include <rte_ether.h>
+#include <rte_ethdev.h>
+#include <rte_mempool.h>
+#include <rte_mbuf.h>
+#include <rte_string_fns.h>
+#include <xenomai/init.h>
+#include <sys/timerfd.h>
+
+pthread_t forward_task, display_task;
+
+sem_t *display_sem;
+
+char sem_name[16];
+
+#define HIPRIO 99
+#define LOPRIO 0
+
+int priority = HIPRIO;
+
+static bool force_quit;
+
+/* MAC updating enabled by default */
+static int mac_updating = 1;
+
+/* Ports set in promiscuous mode off by default. */
+static int promiscuous_on;
+
+#define RTE_LOGTYPE_L2FWD RTE_LOGTYPE_USER1
+
+#define MAX_PKT_BURST 32
+#define BURST_TX_DRAIN_US 100 /* TX drain every ~100us */
+#define MEMPOOL_CACHE_SIZE 256
+
+/*
+ * Configurable number of RX/TX ring descriptors
+ */
+#define RTE_TEST_RX_DESC_DEFAULT 1024
+#define RTE_TEST_TX_DESC_DEFAULT 1024
+static uint16_t nb_rxd = RTE_TEST_RX_DESC_DEFAULT;
+static uint16_t nb_txd = RTE_TEST_TX_DESC_DEFAULT;
+
+/* ethernet addresses of ports */
+static struct rte_ether_addr l2fwd_ports_eth_addr[RTE_MAX_ETHPORTS];
+
+/* mask of enabled ports */
+static uint32_t l2fwd_enabled_port_mask;
+
+/* list of enabled ports */
+static uint32_t l2fwd_dst_ports[RTE_MAX_ETHPORTS];
+
+struct port_pair_params {
+#define NUM_PORTS	2
+	uint16_t port[NUM_PORTS];
+} __rte_cache_aligned;
+
+static struct port_pair_params port_pair_params_array[RTE_MAX_ETHPORTS / 2];
+static struct port_pair_params *port_pair_params;
+static uint16_t nb_port_pair_params;
+
+static unsigned int l2fwd_rx_queue_per_lcore = 1;
+
+#define MAX_RX_QUEUE_PER_LCORE 16
+#define MAX_TX_QUEUE_PER_PORT 16
+/* List of queues to be polled for a given lcore. 8< */
+struct lcore_queue_conf {
+	unsigned int n_rx_port;
+	unsigned int rx_port_list[MAX_RX_QUEUE_PER_LCORE];
+} __rte_cache_aligned;
+struct lcore_queue_conf lcore_queue_conf[RTE_MAX_LCORE];
+/* >8 End of list of queues to be polled for a given lcore. */
+
+static struct rte_eth_dev_tx_buffer *tx_buffer[RTE_MAX_ETHPORTS];
+
+static struct rte_eth_conf port_conf = {
+	.rxmode = {
+		.split_hdr_size = 0,
+	},
+	.txmode = {
+		.mq_mode = RTE_ETH_MQ_TX_NONE,
+	},
+};
+
+struct rte_mempool *l2fwd_pktmbuf_pool;
+
+/* Per-port statistics struct */
+struct l2fwd_port_statistics {
+	uint64_t tx;
+	uint64_t rx;
+	uint64_t dropped;
+} __rte_cache_aligned;
+struct l2fwd_port_statistics port_statistics[RTE_MAX_ETHPORTS];
+
+#define MAX_TIMER_PERIOD 86400 /* 1 day max */
+/* A tsc-based timer responsible for triggering statistics printout */
+static uint64_t timer_period = 10; /* default period is 10 seconds */
+
+/* Print out statistics on packets dropped */
+static void
+print_stats(void)
+{
+	uint64_t total_packets_dropped, total_packets_tx, total_packets_rx;
+	unsigned int portid;
+
+	total_packets_dropped = 0;
+	total_packets_tx = 0;
+	total_packets_rx = 0;
+
+	const char clr[] = { 27, '[', '2', 'J', '\0' };
+	const char topLeft[] = { 27, '[', '1', ';', '1', 'H', '\0' };
+
+		/* Clear screen and move to top left */
+	printf("%s%s", clr, topLeft);
+
+	printf("\nPort statistics ====================================");
+
+	for (portid = 0; portid < RTE_MAX_ETHPORTS; portid++) {
+		/* skip disabled ports */
+		if ((l2fwd_enabled_port_mask & (1 << portid)) == 0)
+			continue;
+		printf("\nStatistics for port %u ------------------------------"
+			   "\nPackets sent: %24"PRIu64
+			   "\nPackets received: %20"PRIu64
+			   "\nPackets dropped: %21"PRIu64,
+			   portid,
+			   port_statistics[portid].tx,
+			   port_statistics[portid].rx,
+			   port_statistics[portid].dropped);
+
+		total_packets_dropped += port_statistics[portid].dropped;
+		total_packets_tx += port_statistics[portid].tx;
+		total_packets_rx += port_statistics[portid].rx;
+	}
+	printf("\nAggregate statistics ==============================="
+		   "\nTotal packets sent: %18"PRIu64
+		   "\nTotal packets received: %14"PRIu64
+		   "\nTotal packets dropped: %15"PRIu64,
+		   total_packets_tx,
+		   total_packets_rx,
+		   total_packets_dropped);
+	printf("\n====================================================\n");
+
+	fflush(stdout);
+}
+static void
+l2fwd_mac_updating(struct rte_mbuf *m, unsigned int dest_portid)
+{
+	struct rte_ether_hdr *eth;
+	void *tmp;
+
+	eth = rte_pktmbuf_mtod(m, struct rte_ether_hdr *);
+
+	/* 02:00:00:00:00:xx */
+	tmp = &eth->dst_addr.addr_bytes[0];
+	*((uint64_t *)tmp) = 0x000000000002 + ((uint64_t)dest_portid << 40);
+
+	/* src addr */
+	rte_ether_addr_copy(&l2fwd_ports_eth_addr[dest_portid], &eth->src_addr);
+}
+/* Simple forward. 8< */
+
+static void
+l2fwd_simple_forward(struct rte_mbuf *m, unsigned int portid)
+{
+	unsigned int dst_port;
+	int sent;
+	struct rte_eth_dev_tx_buffer *buffer;
+
+	dst_port = l2fwd_dst_ports[portid];
+
+	if (mac_updating)
+		l2fwd_mac_updating(m, dst_port);
+
+	buffer = tx_buffer[dst_port];
+	sent = rte_eth_tx_buffer(dst_port, 0, buffer, m);
+	if (sent)
+		port_statistics[dst_port].tx += sent;
+}
+/* >8 End of simple forward. */
+
+/* main processing loop */
+static void l2fwd_main_loop(void)
+{
+	struct rte_mbuf *pkts_burst[MAX_PKT_BURST];
+	struct rte_mbuf *m;
+	int sent;
+	unsigned int lcore_id;
+	uint64_t prev_tsc, diff_tsc, cur_tsc, timer_tsc;
+	unsigned int i, j, portid, nb_rx;
+	struct lcore_queue_conf *qconf;
+	const uint64_t drain_tsc = (rte_get_tsc_hz() + US_PER_S - 1) / US_PER_S *
+			BURST_TX_DRAIN_US;
+	struct rte_eth_dev_tx_buffer *buffer;
+
+	prev_tsc = 0;
+	timer_tsc = 0;
+
+	lcore_id = rte_get_main_lcore();
+	qconf = &lcore_queue_conf[lcore_id];
+
+	if (qconf->n_rx_port == 0) {
+		RTE_LOG(INFO, L2FWD, "lcore %u has nothing to do\n", lcore_id);
+		return;
+	}
+
+	printf("entering main loop on lcore %u\n", lcore_id);
+
+	for (i = 0; i < qconf->n_rx_port; i++) {
+
+		portid = qconf->rx_port_list[i];
+		printf(" -- lcoreid=%u portid=%u\n", lcore_id, portid);
+
+	}
+
+	while (!force_quit) {
+
+		/* Drains TX queue in its main loop. 8< */
+		cur_tsc = rte_rdtsc();
+
+		/*
+		 * TX burst queue drain
+		 */
+		diff_tsc = cur_tsc - prev_tsc;
+		if (unlikely(diff_tsc > drain_tsc)) {
+
+			for (i = 0; i < qconf->n_rx_port; i++) {
+
+				portid = l2fwd_dst_ports[qconf->rx_port_list[i]];
+				buffer = tx_buffer[portid];
+
+				sent = rte_eth_tx_buffer_flush(portid, 0, buffer);
+				if (sent)
+					port_statistics[portid].tx += sent;
+
+			}
+
+			/* if timer is enabled */
+			if (timer_period > 0) {
+
+				/* advance the timer */
+				timer_tsc += diff_tsc;
+
+				/* if timer has reached its timeout */
+				if (unlikely(timer_tsc >= timer_period)) {
+
+					/* do this only on main core */
+					if (lcore_id == rte_get_main_lcore()) {
+						sem_post(display_sem);
+						/* reset the timer */
+						timer_tsc = 0;
+					}
+				}
+			}
+
+			prev_tsc = cur_tsc;
+		}
+		/* >8 End of draining TX queue. */
+
+		/* Read packet from RX queues. 8< */
+		for (i = 0; i < qconf->n_rx_port; i++) {
+
+			portid = qconf->rx_port_list[i];
+			nb_rx = rte_eth_rx_burst(portid, 0,
+						 pkts_burst, MAX_PKT_BURST);
+
+			port_statistics[portid].rx += nb_rx;
+
+			for (j = 0; j < nb_rx; j++) {
+				m = pkts_burst[j];
+				rte_prefetch0(rte_pktmbuf_mtod(m, void *));
+				l2fwd_simple_forward(m, portid);
+			}
+		}
+		/* >8 End of read packet from RX queues. */
+		usleep(1000);
+	}
+
+}
+
+static void *forward(void *cookie)
+{
+	l2fwd_main_loop();
+
+	return NULL;
+}
+
+/* display usage */
+void application_usage(void)
+{
+	fprintf(stderr, "usage: %s [EAL options] -- -p PORTMASK [-P] [-q NQ]:\n", get_program_name());
+	fprintf(stderr,
+	       "  -p PORTMASK: hexadecimal bitmask of ports to configure\n"
+	       "  -P : Enable promiscuous mode\n"
+	       "  -q NQ: number of queue (=ports) per lcore (default is 1)\n"
+	       "  -T PERIOD: statistics will be refreshed each PERIOD seconds (0 to disable, 10 default, 86400 maximum)\n"
+	       "  --no-mac-updating: Disable MAC addresses updating (enabled by default)\n"
+	       "      When enabled:\n"
+	       "       - The source MAC address is replaced by the TX port MAC address\n"
+	       "       - The destination MAC address is replaced by 02:00:00:00:00:TX_PORT_ID\n"
+	       "  --portmap: Configure forwarding port pair mapping\n"
+	       "	      Default: alternate port pairs\n\n"
+	       );
+}
+
+static int
+l2fwd_parse_portmask(const char *portmask)
+{
+	char *end = NULL;
+	unsigned long pm;
+
+	/* parse hexadecimal string */
+	pm = strtoul(portmask, &end, 16);
+	if ((portmask[0] == '\0') || (end == NULL) || (*end != '\0'))
+		return 0;
+
+	return pm;
+}
+
+static int
+l2fwd_parse_port_pair_config(const char *q_arg)
+{
+	enum fieldnames {
+		FLD_PORT1 = 0,
+		FLD_PORT2,
+		_NUM_FLD
+	};
+	unsigned long int_fld[_NUM_FLD];
+	const char *p, *p0 = q_arg;
+	char *str_fld[_NUM_FLD];
+	unsigned int size;
+	char s[256];
+	char *end;
+	int i;
+
+	nb_port_pair_params = 0;
+
+	while ((p = strchr(p0, '(')) != NULL) {
+		++p;
+		p0 = strchr(p, ')');
+		if (p0 == NULL)
+			return -1;
+
+		size = p0 - p;
+		if (size >= sizeof(s))
+			return -1;
+
+		memcpy(s, p, size);
+		s[size] = '\0';
+		if (rte_strsplit(s, sizeof(s), str_fld,
+				 _NUM_FLD, ',') != _NUM_FLD)
+			return -1;
+		for (i = 0; i < _NUM_FLD; i++) {
+			errno = 0;
+			int_fld[i] = strtoul(str_fld[i], &end, 0);
+			if (errno != 0 || end == str_fld[i] ||
+			    int_fld[i] >= RTE_MAX_ETHPORTS)
+				return -1;
+		}
+		if (nb_port_pair_params >= RTE_MAX_ETHPORTS/2) {
+			printf("exceeded max number of port pair params: %hu\n",
+				nb_port_pair_params);
+			return -1;
+		}
+		port_pair_params_array[nb_port_pair_params].port[0] =
+				(uint16_t)int_fld[FLD_PORT1];
+		port_pair_params_array[nb_port_pair_params].port[1] =
+				(uint16_t)int_fld[FLD_PORT2];
+		++nb_port_pair_params;
+	}
+	port_pair_params = port_pair_params_array;
+	return 0;
+}
+
+static unsigned int
+l2fwd_parse_nqueue(const char *q_arg)
+{
+	char *end = NULL;
+	unsigned long n;
+
+	/* parse hexadecimal string */
+	n = strtoul(q_arg, &end, 10);
+	if ((q_arg[0] == '\0') || (end == NULL) || (*end != '\0'))
+		return 0;
+	if (n == 0)
+		return 0;
+	if (n >= MAX_RX_QUEUE_PER_LCORE)
+		return 0;
+
+	return n;
+}
+
+static int
+l2fwd_parse_timer_period(const char *q_arg)
+{
+	char *end = NULL;
+	int n;
+
+	/* parse number string */
+	n = strtol(q_arg, &end, 10);
+	if ((q_arg[0] == '\0') || (end == NULL) || (*end != '\0'))
+		return -1;
+	if (n >= MAX_TIMER_PERIOD)
+		return -1;
+
+	return n;
+}
+
+static const char short_options[] =
+	"p:"  /* portmask */
+	"P"   /* promiscuous */
+	"q:"  /* number of queues */
+	"T:"  /* timer period */
+	;
+
+#define CMD_LINE_OPT_NO_MAC_UPDATING "no-mac-updating"
+#define CMD_LINE_OPT_PORTMAP_CONFIG "portmap"
+
+enum {
+	/* long options mapped to a short option */
+
+	/* first long only option value must be >= 256, so that we won't
+	 * conflict with short options
+	 */
+	CMD_LINE_OPT_NO_MAC_UPDATING_NUM = 256,
+	CMD_LINE_OPT_PORTMAP_NUM,
+};
+
+static const struct option lgopts[] = {
+	{ CMD_LINE_OPT_NO_MAC_UPDATING, no_argument, 0,
+		CMD_LINE_OPT_NO_MAC_UPDATING_NUM},
+	{ CMD_LINE_OPT_PORTMAP_CONFIG, 1, 0, CMD_LINE_OPT_PORTMAP_NUM},
+	{NULL, 0, 0, 0}
+};
+
+/* Parse the argument given in the command line of the application */
+static int
+l2fwd_parse_args(int argc, char **argv)
+{
+	int opt, ret, timer_secs;
+	char **argvopt;
+	int option_index;
+	char *prgname = argv[0];
+
+	argvopt = argv;
+	port_pair_params = NULL;
+
+	while ((opt = getopt_long(argc, argvopt, short_options,
+				  lgopts, &option_index)) != EOF) {
+
+		switch (opt) {
+		/* portmask */
+		case 'p':
+			l2fwd_enabled_port_mask = l2fwd_parse_portmask(optarg);
+			if (l2fwd_enabled_port_mask == 0) {
+				printf("invalid portmask\n");
+				application_usage();
+				return -1;
+			}
+			break;
+		case 'P':
+			promiscuous_on = 1;
+			break;
+
+		/* nqueue */
+		case 'q':
+			l2fwd_rx_queue_per_lcore = l2fwd_parse_nqueue(optarg);
+			if (l2fwd_rx_queue_per_lcore == 0) {
+				printf("invalid queue number\n");
+				application_usage();
+				return -1;
+			}
+			break;
+
+		/* timer period */
+		case 'T':
+			timer_secs = l2fwd_parse_timer_period(optarg);
+			if (timer_secs < 0) {
+				printf("invalid timer period\n");
+				application_usage();
+				return -1;
+			}
+			timer_period = timer_secs;
+			break;
+
+		/* long options */
+		case CMD_LINE_OPT_PORTMAP_NUM:
+			ret = l2fwd_parse_port_pair_config(optarg);
+			if (ret) {
+				fprintf(stderr, "Invalid config\n");
+				application_usage();
+				return -1;
+			}
+			break;
+
+		case CMD_LINE_OPT_NO_MAC_UPDATING_NUM:
+			mac_updating = 0;
+			break;
+
+		default:
+			xenomai_usage();
+			exit(2);
+		}
+	}
+
+	if (optind >= 0)
+		argv[optind-1] = prgname;
+
+	ret = optind-1;
+	optind = 1; /* reset getopt lib */
+	return ret;
+}
+
+/*
+ * Check port pair config with enabled port mask,
+ * and for valid port pair combinations.
+ */
+static int
+check_port_pair_config(void)
+{
+	uint32_t port_pair_config_mask = 0;
+	uint32_t port_pair_mask = 0;
+	uint16_t index, i, portid;
+
+	for (index = 0; index < nb_port_pair_params; index++) {
+		port_pair_mask = 0;
+
+		for (i = 0; i < NUM_PORTS; i++)  {
+			portid = port_pair_params[index].port[i];
+			if ((l2fwd_enabled_port_mask & (1 << portid)) == 0) {
+				printf("port %u is not enabled in port mask\n",
+				       portid);
+				return -1;
+			}
+			if (!rte_eth_dev_is_valid_port(portid)) {
+				printf("port %u is not present on the board\n",
+				       portid);
+				return -1;
+			}
+
+			port_pair_mask |= 1 << portid;
+		}
+
+		if (port_pair_config_mask & port_pair_mask) {
+			printf("port %u is used in other port pairs\n", portid);
+			return -1;
+		}
+		port_pair_config_mask |= port_pair_mask;
+	}
+
+	l2fwd_enabled_port_mask &= port_pair_config_mask;
+
+	return 0;
+}
+
+/* Check the link status of all ports in up to 9s, and print them finally */
+static void
+check_all_ports_link_status(uint32_t port_mask)
+{
+#define CHECK_INTERVAL 100 /* 100ms */
+#define MAX_CHECK_TIME 90 /* 9s (90 * 100ms) in total */
+	uint16_t portid;
+	uint8_t count, all_ports_up, print_flag = 0;
+	struct rte_eth_link link;
+	int ret;
+	//char link_status_text[RTE_ETH_LINK_MAX_STR_LEN];
+
+	printf("\nChecking link status");
+	fflush(stdout);
+	for (count = 0; count <= MAX_CHECK_TIME; count++) {
+		if (force_quit)
+			return;
+		all_ports_up = 1;
+		RTE_ETH_FOREACH_DEV(portid) {
+			if (force_quit)
+				return;
+			if ((port_mask & (1 << portid)) == 0)
+				continue;
+			memset(&link, 0, sizeof(link));
+			ret = rte_eth_link_get_nowait(portid, &link);
+			if (ret < 0) {
+				all_ports_up = 0;
+				if (print_flag == 1)
+					printf("Port %u link get failed: %s\n",
+						portid, rte_strerror(-ret));
+				continue;
+			}
+			#if 0
+			/* print link status if flag set */
+			if (print_flag == 1) {
+				rte_eth_link_to_str(link_status_text,
+					sizeof(link_status_text), &link);
+				printf("Port %d %s\n", portid,
+				       link_status_text);
+				continue;
+			}
+			#endif
+			/* clear all_ports_up flag if any link down */
+			if (link.link_status == RTE_ETH_LINK_DOWN) {
+				all_ports_up = 0;
+				break;
+			}
+		}
+		/* after finally printing all link status, get out */
+		if (print_flag == 1)
+			break;
+
+		if (all_ports_up == 0) {
+			printf(".");
+			fflush(stdout);
+			rte_delay_ms(CHECK_INTERVAL);
+		}
+
+		/* set the print_flag if all ports up or timeout */
+		if (all_ports_up == 1 || count == (MAX_CHECK_TIME - 1)) {
+			print_flag = 1;
+			printf("done\n");
+		}
+	}
+}
+
+static void setup_sched_parameters(pthread_attr_t *attr, int prio)
+{
+	struct sched_param p;
+	int ret;
+
+	ret = pthread_attr_init(attr);
+	if (ret)
+		error(1, ret, "pthread_attr_init()");
+
+	ret = pthread_attr_setinheritsched(attr, PTHREAD_EXPLICIT_SCHED);
+	if (ret)
+		error(1, ret, "pthread_attr_setinheritsched()");
+
+	ret = pthread_attr_setschedpolicy(attr, prio ? SCHED_FIFO : SCHED_OTHER);
+	if (ret)
+		error(1, ret, "pthread_attr_setschedpolicy()");
+
+	p.sched_priority = prio;
+	ret = pthread_attr_setschedparam(attr, &p);
+	if (ret)
+		error(1, ret, "pthread_attr_setschedparam()");
+}
+
+static void
+signal_handler(int signum)
+{
+	if (signum == SIGINT || signum == SIGTERM) {
+		printf("\n\nSignal %d received, preparing to exit...\n",
+				signum);
+		force_quit = true;
+	}
+}
+
+static void *display(void *cookie)
+{
+	char task_name[16];
+	int err;
+
+	snprintf(task_name, sizeof(task_name), "display-%d", getpid());
+
+	err = pthread_setname_np(pthread_self(), task_name);
+	if (err)
+		error(1, err, "pthread_setname_np(display)");
+
+	snprintf(sem_name, sizeof(sem_name), "/dispsem-%d", getpid());
+
+	sem_unlink(sem_name); /* may fail */
+	display_sem = sem_open(sem_name, O_CREAT | O_EXCL, 0666, 0);
+	if (display_sem == SEM_FAILED)
+		error(1, errno, "sem_open()");
+
+
+	for (;;) {
+
+		err = sem_wait(display_sem);
+
+		if (err < 0) {
+			if (errno != EIDRM)
+				error(1, errno, "sem_wait()");
+
+			return NULL;
+		}
+
+		print_stats();
+	}
+
+	return NULL;
+}
+
+
+static void cleanup(void)
+{
+	pthread_cancel(display_task);
+
+	pthread_cancel(forward_task);
+	pthread_join(forward_task, NULL);
+	pthread_join(display_task, NULL);
+	sem_close(display_sem);
+	sem_unlink(sem_name);
+
+	exit(0);
+}
+int
+main(int argc, char **argv)
+{
+	struct lcore_queue_conf *qconf;
+	int ret;
+	uint16_t nb_ports;
+	uint16_t nb_ports_available = 0;
+	uint16_t portid, last_port;
+	unsigned int rx_lcore_id;
+	unsigned int nb_ports_in_mask = 0;
+	unsigned int nb_lcores = 0;
+	unsigned int nb_mbufs;
+	pthread_attr_t tattr;
+	cpu_set_t cpus;
+	int cpu = 0, sig;
+	sigset_t mask;
+
+	/* Init EAL. 8< */
+	ret = rte_eal_init(argc, argv);
+	if (ret < 0)
+		rte_exit(EXIT_FAILURE, "Invalid EAL arguments\n");
+	argc -= ret;
+	argv += ret;
+
+	force_quit = false;
+	signal(SIGINT, signal_handler);
+	signal(SIGTERM, signal_handler);
+
+	/* parse application arguments (after the EAL ones) */
+	ret = l2fwd_parse_args(argc, argv);
+	if (ret < 0)
+		rte_exit(EXIT_FAILURE, "Invalid L2FWD arguments\n");
+	/* >8 End of init EAL. */
+
+	printf("MAC updating %s\n", mac_updating ? "enabled" : "disabled");
+
+	/* convert to number of cycles */
+	timer_period *= rte_get_timer_hz();
+
+	nb_ports = rte_eth_dev_count_avail();
+	if (nb_ports == 0)
+		rte_exit(EXIT_FAILURE, "No Ethernet ports - bye\n");
+
+	if (port_pair_params != NULL) {
+		if (check_port_pair_config() < 0)
+			rte_exit(EXIT_FAILURE, "Invalid port pair config\n");
+	}
+
+	/* check port mask to possible port mask */
+	if (l2fwd_enabled_port_mask & ~((1 << nb_ports) - 1))
+		rte_exit(EXIT_FAILURE, "Invalid portmask; possible (0x%x)\n",
+			(1 << nb_ports) - 1);
+
+	/* Initialization of the driver. 8< */
+
+	/* reset l2fwd_dst_ports */
+	for (portid = 0; portid < RTE_MAX_ETHPORTS; portid++)
+		l2fwd_dst_ports[portid] = 0;
+	last_port = 0;
+
+	/* populate destination port details */
+	if (port_pair_params != NULL) {
+		uint16_t idx, p;
+
+		for (idx = 0; idx < (nb_port_pair_params << 1); idx++) {
+			p = idx & 1;
+			portid = port_pair_params[idx >> 1].port[p];
+			l2fwd_dst_ports[portid] =
+				port_pair_params[idx >> 1].port[p ^ 1];
+		}
+	} else {
+		RTE_ETH_FOREACH_DEV(portid) {
+			/* skip ports that are not enabled */
+			if ((l2fwd_enabled_port_mask & (1 << portid)) == 0)
+				continue;
+
+			if (nb_ports_in_mask % 2) {
+				l2fwd_dst_ports[portid] = last_port;
+				l2fwd_dst_ports[last_port] = portid;
+			} else {
+				last_port = portid;
+			}
+
+			nb_ports_in_mask++;
+		}
+		if (nb_ports_in_mask % 2) {
+			printf("Notice: odd number of ports in portmask.\n");
+			l2fwd_dst_ports[last_port] = last_port;
+		}
+	}
+	/* >8 End of initialization of the driver. */
+
+	rx_lcore_id = 0;
+	qconf = NULL;
+
+	/* Initialize the port/queue configuration of each logical core */
+	RTE_ETH_FOREACH_DEV(portid) {
+		/* skip ports that are not enabled */
+		if ((l2fwd_enabled_port_mask & (1 << portid)) == 0)
+			continue;
+
+		/* get the lcore_id for this port */
+		while (rte_lcore_is_enabled(rx_lcore_id) == 0 ||
+		       lcore_queue_conf[rx_lcore_id].n_rx_port ==
+		       l2fwd_rx_queue_per_lcore) {
+			rx_lcore_id++;
+			if (rx_lcore_id >= RTE_MAX_LCORE)
+				rte_exit(EXIT_FAILURE, "Not enough cores\n");
+		}
+
+		if (qconf != &lcore_queue_conf[rx_lcore_id]) {
+			/* Assigned a new logical core in the loop above. */
+			qconf = &lcore_queue_conf[rx_lcore_id];
+			nb_lcores++;
+		}
+
+		qconf->rx_port_list[qconf->n_rx_port] = portid;
+		qconf->n_rx_port++;
+		printf("Lcore %u: RX port %u TX port %u\n", rx_lcore_id,
+		       portid, l2fwd_dst_ports[portid]);
+	}
+
+	nb_mbufs = RTE_MAX(nb_ports * (nb_rxd + nb_txd + MAX_PKT_BURST +
+		nb_lcores * MEMPOOL_CACHE_SIZE), 8192U);
+
+	/* Create the mbuf pool. 8< */
+	l2fwd_pktmbuf_pool = rte_pktmbuf_pool_create("mbuf_pool", nb_mbufs,
+		MEMPOOL_CACHE_SIZE, 0, RTE_MBUF_DEFAULT_BUF_SIZE,
+		rte_socket_id());
+	if (l2fwd_pktmbuf_pool == NULL)
+		rte_exit(EXIT_FAILURE, "Cannot init mbuf pool\n");
+	/* >8 End of create the mbuf pool. */
+
+	/* Initialise each port */
+	RTE_ETH_FOREACH_DEV(portid) {
+		struct rte_eth_rxconf rxq_conf;
+		struct rte_eth_txconf txq_conf;
+		struct rte_eth_conf local_port_conf = port_conf;
+		struct rte_eth_dev_info dev_info;
+
+		/* skip ports that are not enabled */
+		if ((l2fwd_enabled_port_mask & (1 << portid)) == 0) {
+			printf("Skipping disabled port %u\n", portid);
+			continue;
+		}
+		nb_ports_available++;
+
+		/* init port */
+		printf("Initializing port %u... ", portid);
+		fflush(stdout);
+
+		ret = rte_eth_dev_info_get(portid, &dev_info);
+		if (ret != 0)
+			rte_exit(EXIT_FAILURE,
+				"Error during getting device (port %u) info: %s\n",
+				portid, strerror(-ret));
+
+		if (dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE)
+			local_port_conf.txmode.offloads |=
+				RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
+		/* Configure the number of queues for a port. */
+		ret = rte_eth_dev_configure(portid, 1, 1, &local_port_conf);
+		if (ret < 0)
+			rte_exit(EXIT_FAILURE, "Cannot configure device: err=%d, port=%u\n",
+				  ret, portid);
+		/* >8 End of configuration of the number of queues for a port. */
+
+		ret = rte_eth_dev_adjust_nb_rx_tx_desc(portid, &nb_rxd,
+						       &nb_txd);
+		if (ret < 0)
+			rte_exit(EXIT_FAILURE,
+				 "Cannot adjust number of descriptors: err=%d, port=%u\n",
+				 ret, portid);
+
+		ret = rte_eth_macaddr_get(portid,
+					  &l2fwd_ports_eth_addr[portid]);
+		if (ret < 0)
+			rte_exit(EXIT_FAILURE,
+				 "Cannot get MAC address: err=%d, port=%u\n",
+				 ret, portid);
+
+		/* init one RX queue */
+		fflush(stdout);
+		rxq_conf = dev_info.default_rxconf;
+		rxq_conf.offloads = local_port_conf.rxmode.offloads;
+		/* RX queue setup. 8< */
+		ret = rte_eth_rx_queue_setup(portid, 0, nb_rxd,
+					     rte_eth_dev_socket_id(portid),
+					     &rxq_conf,
+					     l2fwd_pktmbuf_pool);
+		if (ret < 0)
+			rte_exit(EXIT_FAILURE, "rte_eth_rx_queue_setup:err=%d, port=%u\n",
+				  ret, portid);
+		/* >8 End of RX queue setup. */
+
+		/* Init one TX queue on each port. 8< */
+		fflush(stdout);
+		txq_conf = dev_info.default_txconf;
+		txq_conf.offloads = local_port_conf.txmode.offloads;
+		ret = rte_eth_tx_queue_setup(portid, 0, nb_txd,
+				rte_eth_dev_socket_id(portid),
+				&txq_conf);
+		if (ret < 0)
+			rte_exit(EXIT_FAILURE, "rte_eth_tx_queue_setup:err=%d, port=%u\n",
+				ret, portid);
+		/* >8 End of init one TX queue on each port. */
+
+		/* Initialize TX buffers */
+		tx_buffer[portid] = rte_zmalloc_socket("tx_buffer",
+				RTE_ETH_TX_BUFFER_SIZE(MAX_PKT_BURST), 0,
+				rte_eth_dev_socket_id(portid));
+		if (tx_buffer[portid] == NULL)
+			rte_exit(EXIT_FAILURE, "Cannot allocate buffer for tx on port %u\n",
+					portid);
+
+		rte_eth_tx_buffer_init(tx_buffer[portid], MAX_PKT_BURST);
+
+		ret = rte_eth_tx_buffer_set_err_callback(tx_buffer[portid],
+				rte_eth_tx_buffer_count_callback,
+				&port_statistics[portid].dropped);
+		if (ret < 0)
+			rte_exit(EXIT_FAILURE,
+			"Cannot set error callback for tx buffer on port %u\n",
+				 portid);
+
+		ret = rte_eth_dev_set_ptypes(portid, RTE_PTYPE_UNKNOWN, NULL,
+					     0);
+		if (ret < 0)
+			printf("Port %u, Failed to disable Ptype parsing\n",
+					portid);
+		/* Start device */
+		ret = rte_eth_dev_start(portid);
+		if (ret < 0)
+			rte_exit(EXIT_FAILURE, "rte_eth_dev_start:err=%d, port=%u\n",
+				  ret, portid);
+
+		printf("done:\n");
+		if (promiscuous_on) {
+			ret = rte_eth_promiscuous_enable(portid);
+			if (ret != 0)
+				rte_exit(EXIT_FAILURE,
+					"rte_eth_promiscuous_enable:err=%s, port=%u\n",
+					rte_strerror(-ret), portid);
+		}
+
+		printf("Port %u, MAC address: " RTE_ETHER_ADDR_PRT_FMT "\n\n",
+			portid,
+			RTE_ETHER_ADDR_BYTES(&l2fwd_ports_eth_addr[portid]));
+
+		/* initialize port stats */
+		memset(&port_statistics, 0, sizeof(port_statistics));
+	}
+
+	if (!nb_ports_available) {
+		rte_exit(EXIT_FAILURE,
+			"All available ports are disabled. Please set portmask.\n");
+	}
+
+	check_all_ports_link_status(l2fwd_enabled_port_mask);
+
+	ret = 0;
+#if 0
+	/* launch per-lcore init on every lcore */
+	rte_eal_mp_remote_launch(l2fwd_launch_one_lcore, NULL, CALL_MAIN);
+	RTE_LCORE_FOREACH_WORKER(lcore_id) {
+		if (rte_eal_wait_lcore(lcore_id) < 0) {
+			ret = -1;
+			break;
+		}
+	}
+#endif
+	/*create display thread*/
+	setup_sched_parameters(&tattr, 0);
+
+	ret = pthread_create(&display_task, &tattr, display, NULL);
+	if (ret)
+		error(1, ret, "pthread_create(display)");
+
+	pthread_attr_destroy(&tattr);
+
+	setup_sched_parameters(&tattr, priority);
+	CPU_ZERO(&cpus);
+	cpu = rte_get_main_lcore();
+	CPU_SET(cpu, &cpus);
+
+	ret = pthread_attr_setaffinity_np(&tattr, sizeof(cpus), &cpus);
+	if (ret)
+		error(1, ret, "pthread_attr_setaffinity_np()");
+
+//	ret = __COBALT(pthread_create(&forward_task, &tattr, forward, NULL));
+	ret = pthread_create(&forward_task, &tattr, forward, NULL);
+	if (ret)
+		error(1, ret, "pthread_create(latency)");
+
+	pthread_attr_destroy(&tattr);
+
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGINT);
+	sigaddset(&mask, SIGTERM);
+	sigaddset(&mask, SIGHUP);
+	sigaddset(&mask, SIGALRM);
+	__STD(sigwait(&mask, &sig));
+
+	force_quit = true;
+
+	cleanup();
+
+	RTE_ETH_FOREACH_DEV(portid) {
+		if ((l2fwd_enabled_port_mask & (1 << portid)) == 0)
+			continue;
+		printf("Closing port %d...", portid);
+		ret = rte_eth_dev_stop(portid);
+		if (ret != 0)
+			printf("rte_eth_dev_stop: err=%d, port=%d\n",
+			       ret, portid);
+		rte_eth_dev_close(portid);
+		printf(" Done\n");
+	}
+
+	/* clean up the EAL */
+	rte_eal_cleanup();
+	printf("Bye...\n");
+
+	return ret;
+}
-- 
2.20.1

