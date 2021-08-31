From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 2/5] net: dovetail: enable out-of-band networking
 (EXPERIMENTAL)
Date: Tue, 31 Aug 2021 10:27:06 +0200
Message-Id: <20210831082709.1296249-3-rpm@xenomai.org>
In-Reply-To: <20210831082709.1296249-1-rpm@xenomai.org>
References: <20210831082709.1296249-1-rpm@xenomai.org>
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

From: Philippe Gerum <rpm@xenomai.org>

Introduce an interface between the in-band network stack and any
companion core operating from the out-of-band stage, so that the
latter can provide an auxiliary network stack for handling expedited
traffic.

This interface extends the in-band stack as follows:

- a selected portion of the traffic flowing in and out NIC drivers can
  be diverted though the out-of-band stack.

- regular sockets now support an out-of-band operation mode, which is
  enabled at creation time, when SOCK_OOB is ORed into the type flags
  passed to the socket(2) call.

- the out-of-band stack can operate with regular, non oob-capable NIC
  drivers. However, a driver must be specifically adapted in order to
  cope with traffic directly from the out-of-band stage. This
  particular interface is still WIP.

- both in-band and out-of-band traffic can flow through the same NIC
  concurrently if need be, without proxying. In the first case, a new
  queuing discipline (sch_oob) ensures that outgoing out-of-band
  traffic is prioritized over the in-band flow until the data enters
  the NIC driver. Obviously, such concurrency is made possible at the
  expense of latency, notably if the in-band traffic is significant.

This code is EXPERIMENTAL. The kernel interfaces it introduces might
still change significantly in the future.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 include/dovetail/netdevice.h     |  13 ++
 include/linux/net.h              |   1 +
 include/linux/netdevice.h        |  94 ++++++++++
 include/linux/skbuff.h           |  53 ++++++
 include/linux/socket.h           |   4 +-
 include/net/netoob.h             |  17 ++
 include/net/sock.h               |   3 +
 include/uapi/asm-generic/fcntl.h |   3 +-
 net/Kconfig                      |   3 +
 net/core/dev.c                   |  98 ++++++++++-
 net/core/net-sysfs.c             |  52 ++++++
 net/core/skbuff.c                | 123 +++++++++++++
 net/packet/af_packet.c           |   1 +
 net/sched/Kconfig                |  23 +++
 net/sched/Makefile               |   1 +
 net/sched/sch_oob.c              | 294 +++++++++++++++++++++++++++++++
 net/socket.c                     | 127 ++++++++++++-
 17 files changed, 904 insertions(+), 6 deletions(-)
 create mode 100644 include/dovetail/netdevice.h
 create mode 100644 include/net/netoob.h
 create mode 100644 net/sched/sch_oob.c

diff --git a/include/dovetail/netdevice.h b/include/dovetail/netdevice.h
new file mode 100644
index 000000000000000..06e8205e25d5d98
--- /dev/null
+++ b/include/dovetail/netdevice.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _DOVETAIL_NETDEVICE_H
+#define _DOVETAIL_NETDEVICE_H
+
+/*
+ * Placeholder for per-device state information defined by the
+ * out-of-band network stack.
+ */
+
+struct oob_netdev_state {
+};
+
+#endif /* !_DOVETAIL_NETDEVICE_H */
diff --git a/include/linux/net.h b/include/linux/net.h
index 0dcd51feef02d25..692d0aa1ed0cb60 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -80,6 +80,7 @@ enum sock_type {
 #ifndef SOCK_NONBLOCK
 #define SOCK_NONBLOCK	O_NONBLOCK
 #endif
+#define SOCK_OOB	O_OOB
 
 #endif /* ARCH_HAS_SOCKET_TYPES */
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index e37480b5f4c0ef2..305cb74784f210b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -41,6 +41,7 @@
 #endif
 #include <net/netprio_cgroup.h>
 #include <net/xdp.h>
+#include <net/netoob.h>
 
 #include <linux/netdev_features.h>
 #include <linux/neighbour.h>
@@ -292,6 +293,7 @@ enum netdev_state_t {
 	__LINK_STATE_LINKWATCH_PENDING,
 	__LINK_STATE_DORMANT,
 	__LINK_STATE_TESTING,
+	__LINK_STATE_OOB,
 };
 
 
@@ -1487,6 +1489,13 @@ struct net_device_ops {
 	int			(*ndo_tunnel_ctl)(struct net_device *dev,
 						  struct ip_tunnel_parm *p, int cmd);
 	struct net_device *	(*ndo_get_peer_dev)(struct net_device *dev);
+#ifdef CONFIG_NET_OOB
+	struct sk_buff *	(*ndo_alloc_oob_skb)(struct net_device *dev,
+						     dma_addr_t *dma_addr);
+	void			(*ndo_free_oob_skb)(struct net_device *dev,
+						    struct sk_buff *skb,
+						    dma_addr_t dma_addr);
+#endif
 };
 
 /**
@@ -1678,6 +1687,7 @@ enum netdev_ml_priv_type {
  *	@tlsdev_ops:	Transport Layer Security offload operations
  *	@header_ops:	Includes callbacks for creating,parsing,caching,etc
  *			of Layer 2 headers.
+ *	@net_oob_context:	Out-of-band networking context (oob stage diversion)
  *
  *	@flags:		Interface flags (a la BSD)
  *	@priv_flags:	Like 'flags' but invisible to userspace,
@@ -1937,6 +1947,10 @@ struct net_device {
 	const struct tlsdev_ops *tlsdev_ops;
 #endif
 
+#ifdef CONFIG_NET_OOB
+	struct oob_netdev_context  oob_context;
+#endif
+
 	const struct header_ops *header_ops;
 
 	unsigned int		flags;
@@ -4130,6 +4144,86 @@ void netif_device_detach(struct net_device *dev);
 
 void netif_device_attach(struct net_device *dev);
 
+#ifdef CONFIG_NET_OOB
+
+static inline bool netif_oob_diversion(const struct net_device *dev)
+{
+	return test_bit(__LINK_STATE_OOB, &dev->state);
+}
+
+static inline void netif_enable_oob_diversion(struct net_device *dev)
+{
+	return set_bit(__LINK_STATE_OOB, &dev->state);
+}
+
+static inline void netif_disable_oob_diversion(struct net_device *dev)
+{
+	clear_bit(__LINK_STATE_OOB, &dev->state);
+	smp_mb__after_atomic();
+}
+
+int netif_xmit_oob(struct sk_buff *skb);
+
+static inline bool netdev_is_oob_capable(struct net_device *dev)
+{
+	return !!(dev->oob_context.flags & IFF_OOB_CAPABLE);
+}
+
+static inline void netdev_enable_oob_port(struct net_device *dev)
+{
+	dev->oob_context.flags |= IFF_OOB_PORT;
+}
+
+static inline void netdev_disable_oob_port(struct net_device *dev)
+{
+	dev->oob_context.flags &= ~IFF_OOB_PORT;
+}
+
+static inline bool netdev_is_oob_port(struct net_device *dev)
+{
+	return !!(dev->oob_context.flags & IFF_OOB_PORT);
+}
+
+static inline struct sk_buff *netdev_alloc_oob_skb(struct net_device *dev,
+						   dma_addr_t *dma_addr)
+{
+	return dev->netdev_ops->ndo_alloc_oob_skb(dev, dma_addr);
+}
+
+static inline void netdev_free_oob_skb(struct net_device *dev,
+				       struct sk_buff *skb,
+				       dma_addr_t dma_addr)
+{
+	dev->netdev_ops->ndo_free_oob_skb(dev, skb, dma_addr);
+}
+
+#else
+
+static inline bool netif_oob_diversion(const struct net_device *dev)
+{
+	return false;
+}
+
+static inline bool netdev_is_oob_capable(struct net_device *dev)
+{
+	return false;
+}
+
+static inline void netdev_enable_oob_port(struct net_device *dev)
+{
+}
+
+static inline void netdev_disable_oob_port(struct net_device *dev)
+{
+}
+
+static inline bool netdev_is_oob_port(struct net_device *dev)
+{
+	return false;
+}
+
+#endif
+
 /*
  * Network interface message level settings
  */
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2d01b2bbb74651b..72f2a0a2bac6110 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -858,6 +858,11 @@ struct sk_buff {
 #ifdef CONFIG_TLS_DEVICE
 	__u8			decrypted:1;
 #endif
+#ifdef CONFIG_NET_OOB
+	__u8			oob:1;
+	__u8			oob_clone:1;
+	__u8			oob_cloned:1;
+#endif
 
 #ifdef CONFIG_NET_SCHED
 	__u16			tc_index;	/* traffic control index */
@@ -1080,6 +1085,54 @@ struct sk_buff *__build_skb(void *data, unsigned int frag_size);
 struct sk_buff *build_skb(void *data, unsigned int frag_size);
 struct sk_buff *build_skb_around(struct sk_buff *skb,
 				 void *data, unsigned int frag_size);
+#ifdef CONFIG_NET_OOB
+
+static inline bool skb_is_oob(const struct sk_buff *skb)
+{
+	return skb->oob;
+}
+
+static inline bool skb_is_oob_clone(const struct sk_buff *skb)
+{
+	return skb->oob_clone;
+}
+
+static inline bool skb_has_oob_clone(const struct sk_buff *skb)
+{
+	return skb->oob_cloned;
+}
+
+struct sk_buff *__netdev_alloc_oob_skb(struct net_device *dev,
+				       size_t len, gfp_t gfp_mask);
+void __netdev_free_oob_skb(struct net_device *dev, struct sk_buff *skb);
+void netdev_reset_oob_skb(struct net_device *dev, struct sk_buff *skb);
+struct sk_buff *skb_alloc_oob_head(gfp_t gfp_mask);
+void skb_morph_oob_skb(struct sk_buff *n, struct sk_buff *skb);
+bool skb_release_oob_skb(struct sk_buff *skb, int *dref);
+
+static inline bool recycle_oob_skb(struct sk_buff *skb)
+{
+	bool skb_oob_recycle(struct sk_buff *skb);
+
+	if (!skb->oob)
+		return false;
+
+	return skb_oob_recycle(skb);
+}
+
+#else
+
+static inline bool skb_is_oob(const struct sk_buff *skb)
+{
+	return false;
+}
+
+static inline bool recycle_oob_skb(struct sk_buff *skb)
+{
+	return false;
+}
+
+#endif
 
 /**
  * alloc_skb - allocate a network buffer
diff --git a/include/linux/socket.h b/include/linux/socket.h
index 9aa530d497da8f7..4c314b3fe6a4e50 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -223,8 +223,9 @@ struct ucred {
 				 * reuses AF_INET address family
 				 */
 #define AF_XDP		44	/* XDP sockets			*/
+#define AF_OOB		45	/* Out-of-band domain sockets */
 
-#define AF_MAX		45	/* For now.. */
+#define AF_MAX		46	/* For now.. */
 
 /* Protocol families, same as address families. */
 #define PF_UNSPEC	AF_UNSPEC
@@ -274,6 +275,7 @@ struct ucred {
 #define PF_QIPCRTR	AF_QIPCRTR
 #define PF_SMC		AF_SMC
 #define PF_XDP		AF_XDP
+#define PF_OOB		AF_OOB
 #define PF_MAX		AF_MAX
 
 /* Maximum queue length specifiable by listen.  */
diff --git a/include/net/netoob.h b/include/net/netoob.h
new file mode 100644
index 000000000000000..907376ad40eddf9
--- /dev/null
+++ b/include/net/netoob.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _NET_OOBNET_H
+#define _NET_OOBNET_H
+
+#include <dovetail/netdevice.h>
+
+/* Device supports direct out-of-band operations (RX & TX) */
+#define IFF_OOB_CAPABLE		BIT(0)
+/* Device is an out-of-band port */
+#define IFF_OOB_PORT		BIT(1)
+
+struct oob_netdev_context {
+	int flags;
+	struct oob_netdev_state dev_state;
+};
+
+#endif /* !_NET_OOBNET_H */
diff --git a/include/net/sock.h b/include/net/sock.h
index 3c7addf95150907..3ccf0da0f26cc59 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -520,6 +520,9 @@ struct sock {
 	struct bpf_local_storage __rcu	*sk_bpf_storage;
 #endif
 	struct rcu_head		sk_rcu;
+#ifdef CONFIG_NET_OOB
+	void			*oob_data;
+#endif
 };
 
 enum sk_pacing {
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 346529426f91720..11415c6bf98594e 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -91,7 +91,8 @@
 
 /*
  * Tells the open call that out-of-band operations should be enabled
- * for the file (if supported).
+ * for the file (if supported). Can also be passed along to socket(2)
+ * via the type argument as SOCK_OOB.
  */
 #ifndef O_OOB
 #define O_OOB		010000000000
diff --git a/net/Kconfig b/net/Kconfig
index d6567162c1cfcf3..0d39d1f56cd8e9d 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -58,6 +58,9 @@ config NET_REDIRECT
 config SKB_EXTENSIONS
 	bool
 
+config NET_OOB
+	bool
+
 menu "Networking options"
 
 source "net/packet/Kconfig"
diff --git a/net/core/dev.c b/net/core/dev.c
index b9d19fbb15890d0..26839d7f288429d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3104,6 +3104,10 @@ void __dev_kfree_skb_irq(struct sk_buff *skb, enum skb_free_reason reason)
 	} else if (likely(!refcount_dec_and_test(&skb->users))) {
 		return;
 	}
+
+	if (recycle_oob_skb(skb))
+		return;
+
 	get_kfree_skb_cb(skb)->reason = reason;
 	local_irq_save(flags);
 	skb->next = __this_cpu_read(softnet_data.completion_queue);
@@ -3567,7 +3571,12 @@ static int xmit_one(struct sk_buff *skb, struct net_device *dev,
 	unsigned int len;
 	int rc;
 
-	if (dev_nit_active(dev))
+	/*
+	 * Clone-relay outgoing packet to listening taps. Network taps
+	 * interested in out-of-band traffic should be handled by the
+	 * companion core.
+	 */
+	if (dev_nit_active(dev) && !skb_is_oob(skb))
 		dev_queue_xmit_nit(skb, dev);
 
 	len = skb->len;
@@ -4775,6 +4784,81 @@ int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(do_xdp_generic);
 
+#ifdef CONFIG_NET_OOB
+
+__weak bool netif_oob_deliver(struct sk_buff *skb)
+{
+	return false;
+}
+
+__weak int netif_xmit_oob(struct sk_buff *skb)
+{
+	return NET_XMIT_DROP;
+}
+
+static bool netif_receive_oob(struct sk_buff *skb)
+{
+	struct net_device *dev = skb->dev;
+
+	if (dev && netif_oob_diversion(dev))
+		return netif_oob_deliver(skb);
+
+	return false;
+}
+
+static bool netif_receive_oob_list(struct list_head *head)
+{
+	struct sk_buff *skb, *next;
+	struct net_device *dev;
+
+	if (list_empty(head))
+		return false;
+
+	dev = list_first_entry(head, struct sk_buff, list)->dev;
+	if (!dev || !netif_oob_diversion(dev))
+		return false;
+
+	/* Callee dequeues every skb it consumes. */
+	list_for_each_entry_safe(skb, next, head, list)
+		netif_oob_deliver(skb);
+
+	return list_empty(head);
+}
+
+__weak void netif_oob_run(struct net_device *dev)
+{ }
+
+static void napi_complete_oob(struct napi_struct *n)
+{
+	struct net_device *dev = n->dev;
+
+	if (netif_oob_diversion(dev))
+		netif_oob_run(dev);
+}
+
+__weak void skb_inband_xmit_backlog(void)
+{ }
+
+#else
+
+static inline bool netif_receive_oob(struct sk_buff *skb)
+{
+	return false;
+}
+
+static inline bool netif_receive_oob_list(struct list_head *head)
+{
+	return false;
+}
+
+static inline void napi_complete_oob(struct napi_struct *n)
+{ }
+
+static inline void skb_inband_xmit_backlog(void)
+{ }
+
+#endif
+
 static int netif_rx_internal(struct sk_buff *skb)
 {
 	int ret;
@@ -4874,6 +4958,8 @@ static __latent_entropy void net_tx_action(struct softirq_action *h)
 {
 	struct softnet_data *sd = this_cpu_ptr(&softnet_data);
 
+	skb_inband_xmit_backlog();
+
 	if (sd->completion_queue) {
 		struct sk_buff *clist;
 
@@ -5617,6 +5703,9 @@ int netif_receive_skb(struct sk_buff *skb)
 {
 	int ret;
 
+	if (netif_receive_oob(skb))
+		return NET_RX_SUCCESS;
+
 	trace_netif_receive_skb_entry(skb);
 
 	ret = netif_receive_skb_internal(skb);
@@ -5640,6 +5729,8 @@ void netif_receive_skb_list(struct list_head *head)
 {
 	struct sk_buff *skb;
 
+	if (netif_receive_oob_list(head))
+		return;
 	if (list_empty(head))
 		return;
 	if (trace_netif_receive_skb_list_entry_enabled()) {
@@ -6130,6 +6221,9 @@ gro_result_t napi_gro_receive(struct napi_struct *napi, struct sk_buff *skb)
 {
 	gro_result_t ret;
 
+	if (netif_receive_oob(skb))
+		return GRO_NORMAL;
+
 	skb_mark_napi_id(skb, napi);
 	trace_napi_gro_receive_entry(skb);
 
@@ -6467,6 +6561,8 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 	unsigned long flags, val, new, timeout = 0;
 	bool ret = true;
 
+	napi_complete_oob(n);
+
 	/*
 	 * 1) Don't let napi dequeue from the cpu poll list
 	 *    just in case its running on a different cpu.
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index b4562f9d074cf24..1859c152fd6c145 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -366,6 +366,54 @@ static ssize_t tx_queue_len_store(struct device *dev,
 }
 NETDEVICE_SHOW_RW(tx_queue_len, fmt_dec);
 
+#ifdef CONFIG_NET_OOB
+
+__weak int netif_oob_switch_port(struct net_device *dev, bool enabled)
+{
+	return 0;
+}
+
+__weak bool netif_oob_get_port(struct net_device *dev)
+{
+	return false;
+}
+
+__weak ssize_t netif_oob_query_pool(struct net_device *dev, char *buf)
+{
+	return -EIO;
+}
+
+static int switch_oob_port(struct net_device *dev, unsigned long enable)
+{
+	return netif_oob_switch_port(dev, (bool)enable);
+}
+
+static ssize_t oob_port_store(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t len)
+{
+	return netdev_store(dev, attr, buf, len, switch_oob_port);
+}
+
+static ssize_t oob_port_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct net_device *netdev = to_net_dev(dev);
+
+	return sprintf(buf, fmt_dec, netif_oob_get_port(netdev));
+}
+static DEVICE_ATTR_RW(oob_port);
+
+static ssize_t oob_pool_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct net_device *netdev = to_net_dev(dev);
+
+	return netif_oob_query_pool(netdev, buf);
+}
+static DEVICE_ATTR_RO(oob_pool);
+
+#endif
+
 static int change_gro_flush_timeout(struct net_device *dev, unsigned long val)
 {
 	WRITE_ONCE(dev->gro_flush_timeout, val);
@@ -570,6 +618,10 @@ static struct attribute *net_class_attrs[] __ro_after_init = {
 	&dev_attr_proto_down.attr,
 	&dev_attr_carrier_up_count.attr,
 	&dev_attr_carrier_down_count.attr,
+#ifdef CONFIG_NET_OOB
+	&dev_attr_oob_port.attr,
+	&dev_attr_oob_pool.attr,
+#endif
 	NULL,
 };
 ATTRIBUTE_GROUPS(net_class);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 825e6b9880030c0..3c8aa3cbfac531f 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -290,6 +290,117 @@ static struct sk_buff *__build_skb_around(struct sk_buff *skb,
 	return skb;
 }
 
+#ifdef CONFIG_NET_OOB
+
+struct sk_buff *__netdev_alloc_oob_skb(struct net_device *dev, size_t len,
+				       gfp_t gfp_mask)
+{
+	struct sk_buff *skb = __alloc_skb(len, gfp_mask, 0, NUMA_NO_NODE);
+
+	if (!skb)
+		return NULL;
+
+	skb_reserve(skb, NET_SKB_PAD);
+	skb->dev = dev;
+	skb->oob = true;
+
+	return skb;
+}
+EXPORT_SYMBOL_GPL(__netdev_alloc_oob_skb);
+
+void __netdev_free_oob_skb(struct net_device *dev, struct sk_buff *skb)
+{
+	skb->oob = false;
+	skb->oob_clone = false;
+	dev_kfree_skb(skb);
+}
+EXPORT_SYMBOL_GPL(__netdev_free_oob_skb);
+
+void netdev_reset_oob_skb(struct net_device *dev, struct sk_buff *skb)
+{
+	struct skb_shared_info *shinfo;
+	bool head_frag = skb->head_frag;
+	bool pfmemalloc = skb->pfmemalloc;
+
+	if (WARN_ON_ONCE(!skb->oob || skb->oob_clone))
+		return;
+
+	memset(skb, 0, offsetof(struct sk_buff, tail));
+	/* Out-of-band skbs are guaranteed to have linear storage. */
+	skb->data = skb->head;
+	skb_reset_tail_pointer(skb);
+	skb->mac_header = (typeof(skb->mac_header))~0U;
+	skb->transport_header = (typeof(skb->transport_header))~0U;
+	skb->head_frag = head_frag;
+	skb->pfmemalloc = pfmemalloc;
+	shinfo = skb_shinfo(skb);
+	memset(shinfo, 0, offsetof(struct skb_shared_info, dataref));
+	atomic_set(&shinfo->dataref, 1);
+	skb_reserve(skb, NET_SKB_PAD);
+
+	refcount_set(&skb->users, 1);
+	skb->dev = dev;
+	skb->oob = true;
+	skb_set_kcov_handle(skb, kcov_common_handle());
+}
+EXPORT_SYMBOL_GPL(netdev_reset_oob_skb);
+
+struct sk_buff *skb_alloc_oob_head(gfp_t gfp_mask)
+{
+	struct sk_buff *skb = kmem_cache_alloc(skbuff_head_cache, gfp_mask);
+
+	if (!skb)
+		return NULL;
+
+	/*
+	 * skb heads allocated for out-of-band traffic should be
+	 * reserved for clones, so memset is extraneous in the sense
+	 * that skb_morph_oob() should follow the allocation.
+	 */
+	memset(skb, 0, offsetof(struct sk_buff, tail));
+	refcount_set(&skb->users, 1);
+	skb->oob_clone = true;
+	skb_set_kcov_handle(skb, kcov_common_handle());
+
+	return skb;
+}
+EXPORT_SYMBOL_GPL(skb_alloc_oob_head);
+
+static struct sk_buff *__skb_clone(struct sk_buff *n, struct sk_buff *skb);
+
+void skb_morph_oob_skb(struct sk_buff *n, struct sk_buff *skb)
+{
+	__skb_clone(n, skb);
+	n->oob = true;
+	n->oob_clone = true;
+	skb->oob_cloned = true;
+}
+EXPORT_SYMBOL_GPL(skb_morph_oob_skb);
+
+bool skb_release_oob_skb(struct sk_buff *skb, int *dref)
+{
+	struct skb_shared_info *shinfo = skb_shinfo(skb);
+
+	if (!skb_unref(skb))
+		return false;
+
+	/*
+	 * ->nohdr is never set for oob shells, so we always refcount
+         * the full data (header + payload) when cloned.
+	 */
+	*dref = skb->cloned ? atomic_sub_return(1, &shinfo->dataref) : 0;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(skb_release_oob_skb);
+
+__weak bool skb_oob_recycle(struct sk_buff *skb)
+{
+	return false;
+}
+
+#endif	/* CONFIG_NET_OOB */
+
 /**
  * __build_skb - build a network buffer
  * @data: data buffer provided by caller
@@ -690,6 +801,9 @@ static void skb_release_all(struct sk_buff *skb)
 
 void __kfree_skb(struct sk_buff *skb)
 {
+	if (recycle_oob_skb(skb))
+		return;
+
 	skb_release_all(skb);
 	kfree_skbmem(skb);
 }
@@ -882,6 +996,9 @@ static inline void _kfree_skb_defer(struct sk_buff *skb)
 	struct napi_alloc_cache *nc = this_cpu_ptr(&napi_alloc_cache);
 
 	/* drop skb->head and call any destructors for packet */
+	if (recycle_oob_skb(skb))
+		return;
+
 	skb_release_all(skb);
 
 	/* record skb to CPU local list */
@@ -901,6 +1018,9 @@ static inline void _kfree_skb_defer(struct sk_buff *skb)
 }
 void __kfree_skb_defer(struct sk_buff *skb)
 {
+	if (recycle_oob_skb(skb))
+		return;
+
 	_kfree_skb_defer(skb);
 }
 
@@ -924,6 +1044,9 @@ void napi_consume_skb(struct sk_buff *skb, int budget)
 		return;
 	}
 
+	if (recycle_oob_skb(skb))
+		return;
+
 	_kfree_skb_defer(skb);
 }
 EXPORT_SYMBOL(napi_consume_skb);
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 08144559eed56ea..5175695d58205dc 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3298,6 +3298,7 @@ static int packet_create(struct net *net, struct socket *sock, int protocol,
 	po = pkt_sk(sk);
 	init_completion(&po->skb_completion);
 	sk->sk_family = PF_PACKET;
+	sk->sk_protocol	= protocol;
 	po->num = proto;
 	po->xmit = dev_queue_xmit;
 
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index d762e89ab74f7ec..da29993d2a378d5 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -117,6 +117,29 @@ config NET_SCH_MULTIQ
 	  To compile this code as a module, choose M here: the
 	  module will be called sch_multiq.
 
+config NET_SCH_OOB
+	tristate "Out-of-band packet queuing (OOB)"
+	depends on NET_OOB
+	help
+	  Say Y here if you want to use a Dovetail-aware packet
+	  scheduler for prioritizing egress traffic between the
+	  regular (in-band) network stack and a companion core. This
+	  scheduler helps in two cases:
+
+	  - for sending high priority packets originating from the
+	    out-of-band stage to NICs which cannot handle outgoing
+	    packets from that stage directly. In this case, these
+	    packets take precedence over regular traffic for
+	    transmission.
+
+	  - for sharing an out-of-band capable interface between the
+            in-band and out-of-band network stacks, proxying regular
+            traffic originating from the in-band stage to NICs which
+            will be processing all packets from the out-of-band stage.
+
+	  To compile this code as a module, choose M here: the
+	  module will be called sch_oob.
+
 config NET_SCH_RED
 	tristate "Random Early Detection (RED)"
 	help
diff --git a/net/sched/Makefile b/net/sched/Makefile
index 66bbf9a98f9ea12..20fc082d7178357 100644
--- a/net/sched/Makefile
+++ b/net/sched/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_NET_SCH_TBF)	+= sch_tbf.o
 obj-$(CONFIG_NET_SCH_TEQL)	+= sch_teql.o
 obj-$(CONFIG_NET_SCH_PRIO)	+= sch_prio.o
 obj-$(CONFIG_NET_SCH_MULTIQ)	+= sch_multiq.o
+obj-$(CONFIG_NET_SCH_OOB)	+= sch_oob.o
 obj-$(CONFIG_NET_SCH_ATM)	+= sch_atm.o
 obj-$(CONFIG_NET_SCH_NETEM)	+= sch_netem.o
 obj-$(CONFIG_NET_SCH_DRR)	+= sch_drr.o
diff --git a/net/sched/sch_oob.c b/net/sched/sch_oob.c
new file mode 100644
index 000000000000000..22373e81bb2751e
--- /dev/null
+++ b/net/sched/sch_oob.c
@@ -0,0 +1,294 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2020 Philippe Gerum  <rpm@xenomai.org>
+ */
+
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <net/pkt_sched.h>
+#include <net/pkt_cls.h>
+
+/*
+ * With Qdisc[2], 0=oob_fallback and 1=inband. User can graft whatever
+ * qdisc on these slots; both preset to pfifo_ops. skb->oob is checked
+ * to determine which qdisc should handle the packet eventually.
+ */
+
+struct oob_qdisc_priv {
+	struct Qdisc *qdisc[2];	/* 0=oob_fallback, 1=in-band */
+	struct tcf_proto __rcu *filter_list;
+	struct tcf_block *block;
+};
+
+static int oob_enqueue(struct sk_buff *skb, struct Qdisc *sch,
+		struct sk_buff **to_free)
+{
+	struct oob_qdisc_priv *p = qdisc_priv(sch);
+	struct net_device *dev = skb->dev;
+	struct Qdisc *qdisc;
+	int ret;
+
+	/*
+	 * If the device accepts oob traffic and can handle it
+	 * directly from the oob stage, pass the outgoing packet to
+	 * the transmit handler of the oob stack. This makes sure that
+	 * all traffic, including the in-band one, flows through the
+	 * oob stack which may implement its own queuing discipline.
+	 *
+	 * netif_xmit_oob() might fail handling the packet, in which
+	 * case we leave it to the in-band packet scheduler, applying
+	 * a best-effort strategy by giving higher priority to oob
+	 * packets over mere in-band traffic.
+	 */
+	if (dev && netif_oob_diversion(dev) && netdev_is_oob_capable(dev)) {
+		ret = netif_xmit_oob(skb);
+		if (ret == NET_XMIT_SUCCESS)
+			return NET_XMIT_SUCCESS;
+	}
+
+	/*
+	 * Out-of-band fast lane is closed. Best effort: use a special
+	 * 'high priority' queue for oob packets we handle from
+	 * in-band context the usual way through the common stack.
+	 */
+	qdisc = skb->oob ? p->qdisc[0] : p->qdisc[1];
+	ret = qdisc_enqueue(skb, qdisc, to_free);
+	if (ret == NET_XMIT_SUCCESS) {
+		sch->q.qlen++;
+		return NET_XMIT_SUCCESS;
+	}
+
+	if (net_xmit_drop_count(ret))
+		qdisc_qstats_drop(sch);
+
+	return ret;
+}
+
+static struct sk_buff *oob_dequeue(struct Qdisc *sch)
+{
+	struct oob_qdisc_priv *p = qdisc_priv(sch);
+	struct sk_buff *skb;
+	struct Qdisc *qdisc;
+	int band;
+
+	/*
+	 * First try to dequeue pending out-of-band packets. If none,
+	 * then check for in-band traffic.
+	 */
+	for (band = 0; band < 2; band++) {
+		qdisc = p->qdisc[band];
+		skb = qdisc->dequeue(qdisc);
+		if (skb) {
+			qdisc_bstats_update(sch, skb);
+			sch->q.qlen--;
+			return skb;
+		}
+	}
+
+	return NULL;
+}
+
+static struct sk_buff *oob_peek(struct Qdisc *sch)
+{
+	struct oob_qdisc_priv *p = qdisc_priv(sch);
+	struct sk_buff *skb;
+	struct Qdisc *qdisc;
+	int band;
+
+	for (band = 0; band < 2; band++) {
+		qdisc = p->qdisc[band];
+		skb = qdisc->ops->peek(qdisc);
+		if (skb)
+			return skb;
+	}
+
+	return NULL;
+}
+
+static int oob_init(struct Qdisc *sch, struct nlattr *opt,
+		struct netlink_ext_ack *extack)
+{
+	struct oob_qdisc_priv *p = qdisc_priv(sch);
+	int ret;
+
+	ret = tcf_block_get(&p->block, &p->filter_list, sch, extack);
+	if (ret)
+		return ret;
+
+	p->qdisc[0] = qdisc_create_dflt(sch->dev_queue,
+					&pfifo_qdisc_ops, sch->handle,
+					extack);
+	p->qdisc[1] = qdisc_create_dflt(sch->dev_queue,
+					&pfifo_fast_ops, sch->handle,
+					extack);
+
+	return 0;
+}
+
+static void oob_reset(struct Qdisc *sch)
+{
+	struct oob_qdisc_priv *p = qdisc_priv(sch);
+
+	qdisc_reset(p->qdisc[0]);
+	qdisc_reset(p->qdisc[1]);
+	sch->q.qlen = 0;
+}
+
+static void oob_destroy(struct Qdisc *sch)
+{
+	struct oob_qdisc_priv *p = qdisc_priv(sch);
+
+	tcf_block_put(p->block);
+	qdisc_put(p->qdisc[0]);
+	qdisc_put(p->qdisc[1]);
+}
+
+static int oob_tune(struct Qdisc *sch, struct nlattr *opt,
+		struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+static int oob_dump(struct Qdisc *sch, struct sk_buff *skb)
+{
+	return skb->len;
+}
+
+static int oob_graft(struct Qdisc *sch, unsigned long arg, struct Qdisc *new,
+		struct Qdisc **old, struct netlink_ext_ack *extack)
+{
+	struct oob_qdisc_priv *p = qdisc_priv(sch);
+	unsigned long band = arg - 1;
+
+	if (new == NULL)
+		new = &noop_qdisc;
+
+	*old = qdisc_replace(sch, new, &p->qdisc[band]);
+
+	return 0;
+}
+
+static struct Qdisc *
+oob_leaf(struct Qdisc *sch, unsigned long arg)
+{
+	struct oob_qdisc_priv *p = qdisc_priv(sch);
+	unsigned long band = arg - 1;
+
+	return p->qdisc[band];
+}
+
+static unsigned long oob_find(struct Qdisc *sch, u32 classid)
+{
+	unsigned long band = TC_H_MIN(classid);
+
+	return band - 1 >= 2 ? 0 : band;
+}
+
+static int oob_dump_class(struct Qdisc *sch, unsigned long cl,
+			struct sk_buff *skb, struct tcmsg *tcm)
+{
+	struct oob_qdisc_priv *p = qdisc_priv(sch);
+
+	tcm->tcm_handle |= TC_H_MIN(cl);
+	tcm->tcm_info = p->qdisc[cl - 1]->handle;
+
+	return 0;
+}
+
+static int oob_dump_class_stats(struct Qdisc *sch, unsigned long cl,
+				struct gnet_dump *d)
+{
+	struct oob_qdisc_priv *p = qdisc_priv(sch);
+	struct Qdisc *cl_q = p->qdisc[cl - 1];
+
+	if (gnet_stats_copy_basic(qdisc_root_sleeping_running(sch),
+				  d, cl_q->cpu_bstats, &cl_q->bstats) < 0 ||
+	    qdisc_qstats_copy(d, cl_q) < 0)
+		return -1;
+
+	return 0;
+}
+
+static void oob_walk(struct Qdisc *sch, struct qdisc_walker *arg)
+{
+	int band;
+
+	if (arg->stop)
+		return;
+
+	for (band = 0; band < 2; band++) {
+		if (arg->count < arg->skip) {
+			arg->count++;
+			continue;
+		}
+		if (arg->fn(sch, band + 1, arg) < 0) {
+			arg->stop = 1;
+			break;
+		}
+		arg->count++;
+	}
+}
+
+static unsigned long oob_tcf_bind(struct Qdisc *sch, unsigned long parent,
+				 u32 classid)
+{
+	return oob_find(sch, classid);
+}
+
+static void oob_tcf_unbind(struct Qdisc *q, unsigned long cl)
+{
+}
+
+static struct tcf_block *oob_tcf_block(struct Qdisc *sch, unsigned long cl,
+				       struct netlink_ext_ack *extack)
+{
+	struct oob_qdisc_priv *p = qdisc_priv(sch);
+
+	if (cl)
+		return NULL;
+
+	return p->block;
+}
+
+static const struct Qdisc_class_ops oob_class_ops = {
+	.graft		=	oob_graft,
+	.leaf		=	oob_leaf,
+	.find		=	oob_find,
+	.walk		=	oob_walk,
+	.dump		=	oob_dump_class,
+	.dump_stats	=	oob_dump_class_stats,
+	.tcf_block	=	oob_tcf_block,
+	.bind_tcf	=	oob_tcf_bind,
+	.unbind_tcf	=	oob_tcf_unbind,
+};
+
+static struct Qdisc_ops oob_qdisc_ops __read_mostly = {
+	.cl_ops		=	&oob_class_ops,
+	.id		=	"oob",
+	.priv_size	=	sizeof(struct oob_qdisc_priv),
+	.enqueue	=	oob_enqueue,
+	.dequeue	=	oob_dequeue,
+	.peek		=	oob_peek,
+	.init		=	oob_init,
+	.reset		=	oob_reset,
+	.destroy	=	oob_destroy,
+	.change		=	oob_tune,
+	.dump		=	oob_dump,
+	.owner		=	THIS_MODULE,
+};
+
+static int __init oob_module_init(void)
+{
+	return register_qdisc(&oob_qdisc_ops);
+}
+
+static void __exit oob_module_exit(void)
+{
+	unregister_qdisc(&oob_qdisc_ops);
+}
+
+module_init(oob_module_init)
+module_exit(oob_module_exit)
+
+MODULE_LICENSE("GPL");
diff --git a/net/socket.c b/net/socket.c
index 002d5952ae5d890..c673cea523eb78f 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -141,6 +141,95 @@ static void sock_show_fdinfo(struct seq_file *m, struct file *f)
 #define sock_show_fdinfo NULL
 #endif
 
+#ifdef CONFIG_NET_OOB
+
+static inline bool sock_oob_capable(struct socket *sock)
+{
+	return !!sock->sk->oob_data;
+}
+
+int __weak sock_oob_attach(struct socket *sock)
+{
+	return 0;
+}
+
+void __weak sock_oob_detach(struct socket *sock)
+{
+}
+
+int __weak sock_oob_bind(struct socket *sock, struct sockaddr *addr, int len)
+{
+	return 0;
+}
+
+long __weak sock_inband_ioctl_redirect(struct socket *sock,
+				unsigned int cmd, unsigned long arg)
+{
+	return -ENOTTY;
+}
+
+long __weak sock_oob_ioctl(struct file *file,
+			unsigned int cmd, unsigned long arg)
+{
+	return -ENOTTY;
+}
+
+ssize_t __weak sock_oob_write(struct file *filp,
+				const char __user *u_buf, size_t count)
+{
+	return -EOPNOTSUPP;
+}
+
+ssize_t __weak sock_oob_read(struct file *filp,
+			char __user *u_buf, size_t count)
+{
+	return -EOPNOTSUPP;
+}
+
+__poll_t __weak sock_oob_poll(struct file *filp,
+				struct oob_poll_wait *wait)
+{
+	return -EOPNOTSUPP;
+}
+
+#define compat_sock_oob_ioctl compat_ptr_oob_ioctl
+
+#else	/* !CONFIG_NET_OOB */
+
+static inline bool sock_oob_capable(struct socket *sock)
+{
+	return false;
+}
+
+static inline int sock_oob_attach(struct socket *sock)
+{
+	return 0;
+}
+
+static inline void sock_oob_detach(struct socket *sock)
+{
+}
+
+static int sock_oob_bind(struct socket *sock,
+			struct sockaddr *addr, int len)
+{
+	return 0;
+}
+
+static inline long sock_inband_ioctl_redirect(struct socket *sock,
+					unsigned int cmd, unsigned long arg)
+{
+	return -ENOTTY;
+}
+
+#define sock_oob_ioctl		NULL
+#define sock_oob_write		NULL
+#define sock_oob_read		NULL
+#define sock_oob_poll		NULL
+#define compat_sock_oob_ioctl	NULL
+
+#endif	/* !CONFIG_NET_OOB */
+
 /*
  *	Socket files have a set of 'special' operations as well as the generic file ones. These don't appear
  *	in the operation structures but are done directly via the socketcall() multiplexor.
@@ -153,8 +242,13 @@ static const struct file_operations socket_file_ops = {
 	.write_iter =	sock_write_iter,
 	.poll =		sock_poll,
 	.unlocked_ioctl = sock_ioctl,
+	.oob_ioctl =	sock_oob_ioctl,
+	.oob_write =	sock_oob_write,
+	.oob_read =	sock_oob_read,
+	.oob_poll =	sock_oob_poll,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = compat_sock_ioctl,
+	.compat_oob_ioctl = compat_sock_oob_ioctl,
 #endif
 	.mmap =		sock_mmap,
 	.release =	sock_close,
@@ -426,7 +520,7 @@ EXPORT_SYMBOL(sock_alloc_file);
 static int sock_map_fd(struct socket *sock, int flags)
 {
 	struct file *newfile;
-	int fd = get_unused_fd_flags(flags);
+	int fd = get_unused_fd_flags(flags), ret;
 	if (unlikely(fd < 0)) {
 		sock_release(sock);
 		return fd;
@@ -434,6 +528,14 @@ static int sock_map_fd(struct socket *sock, int flags)
 
 	newfile = sock_alloc_file(sock, flags, NULL);
 	if (!IS_ERR(newfile)) {
+		if (IS_ENABLED(CONFIG_NET_OOB) && (flags & SOCK_OOB)) {
+			ret = sock_oob_attach(sock);
+			if (ret < 0) {
+				put_unused_fd(fd);
+				sock_release(sock);
+				return ret;
+			}
+		}
 		fd_install(fd, newfile);
 		return fd;
 	}
@@ -588,6 +690,9 @@ EXPORT_SYMBOL(sock_alloc);
 
 static void __sock_release(struct socket *sock, struct inode *inode)
 {
+	if (sock_oob_capable(sock))
+		sock_oob_detach(sock);
+
 	if (sock->ops) {
 		struct module *owner = sock->ops->owner;
 
@@ -1182,6 +1287,11 @@ static long sock_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 						   false);
 			break;
 		default:
+			if (sock_oob_capable(sock)) {
+				err = sock_inband_ioctl_redirect(sock, cmd, arg);
+				if (!err || err != -ENOIOCTLCMD)
+					break;
+			}
 			err = sock_do_ioctl(net, sock, cmd, arg);
 			break;
 		}
@@ -1495,10 +1605,18 @@ int __sys_socket(int family, int type, int protocol)
 	BUILD_BUG_ON((SOCK_MAX | SOCK_TYPE_MASK) != SOCK_TYPE_MASK);
 	BUILD_BUG_ON(SOCK_CLOEXEC & SOCK_TYPE_MASK);
 	BUILD_BUG_ON(SOCK_NONBLOCK & SOCK_TYPE_MASK);
+	BUILD_BUG_ON(SOCK_OOB & SOCK_TYPE_MASK);
 
 	flags = type & ~SOCK_TYPE_MASK;
-	if (flags & ~(SOCK_CLOEXEC | SOCK_NONBLOCK))
+	if (flags & ~(SOCK_CLOEXEC | SOCK_NONBLOCK | SOCK_OOB))
 		return -EINVAL;
+	/*
+	 * Not every protocol family supports out-of-band operations,
+	 * however PF_OOB certainly does: force SOCK_OOB in, so that
+	 * sock_oob_attach() runs for this socket.
+	 */
+	if (IS_ENABLED(CONFIG_NET_OOB) && family == AF_OOB)
+		flags |= SOCK_OOB;
 	type &= SOCK_TYPE_MASK;
 
 	if (SOCK_NONBLOCK != O_NONBLOCK && (flags & SOCK_NONBLOCK))
@@ -1508,7 +1626,7 @@ int __sys_socket(int family, int type, int protocol)
 	if (retval < 0)
 		return retval;
 
-	return sock_map_fd(sock, flags & (O_CLOEXEC | O_NONBLOCK));
+	return sock_map_fd(sock, flags & (O_CLOEXEC | O_NONBLOCK | O_OOB));
 }
 
 SYSCALL_DEFINE3(socket, int, family, int, type, int, protocol)
@@ -1639,6 +1757,9 @@ int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrlen)
 			err = security_socket_bind(sock,
 						   (struct sockaddr *)&address,
 						   addrlen);
+			if (sock_oob_capable(sock) && !err)
+				err = sock_oob_bind(sock, (struct sockaddr *)
+						&address, addrlen);
 			if (!err)
 				err = sock->ops->bind(sock,
 						      (struct sockaddr *)
-- 
2.31.1


