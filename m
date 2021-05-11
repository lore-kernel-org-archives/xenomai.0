From: =?UTF-8?q?Jean-Baptiste=20Tr=C3=A9dez?=
 <jean-baptiste.tredez@alstefgroup.com>
Subject: [PATCH 05/31] net/stack: add support for VLAN filtering
Date: Tue, 11 May 2021 18:05:09 +0200
Message-Id: <20210511160535.26580-6-jean-baptiste.tredez@alstefgroup.com>
In-Reply-To: <20210511160535.26580-1-jean-baptiste.tredez@alstefgroup.com>
References: <20210511160535.26580-1-jean-baptiste.tredez@alstefgroup.com>
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/addons/cap.c               |  46 +-
 kernel/drivers/net/stack/Kconfig              |   8 +
 kernel/drivers/net/stack/Makefile             |   2 +
 kernel/drivers/net/stack/include/rtdev.h      |  19 +
 kernel/drivers/net/stack/include/rtif_vlan.h  | 105 +++
 kernel/drivers/net/stack/include/rtnet_port.h |   6 +-
 kernel/drivers/net/stack/include/rtskb.h      |   1 +
 kernel/drivers/net/stack/include/rtvlan.h     |  25 +
 kernel/drivers/net/stack/rtdev.c              |  32 +-
 kernel/drivers/net/stack/rtnet_chrdev.c       |   8 +-
 kernel/drivers/net/stack/rtnet_module.c       |   5 +
 kernel/drivers/net/stack/socket.c             |  17 +-
 kernel/drivers/net/stack/vlan.c               | 725 ++++++++++++++++++
 13 files changed, 969 insertions(+), 30 deletions(-)
 create mode 100644 kernel/drivers/net/stack/include/rtif_vlan.h
 create mode 100644 kernel/drivers/net/stack/include/rtvlan.h
 create mode 100644 kernel/drivers/net/stack/vlan.c

diff --git a/kernel/drivers/net/addons/cap.c b/kernel/drivers/net/addons/cap.c
index 1e8644069..293fcc84b 100644
--- a/kernel/drivers/net/addons/cap.c
+++ b/kernel/drivers/net/addons/cap.c
@@ -57,8 +57,26 @@ static struct tap_device_t {
 
 void rtcap_rx_hook(struct rtskb *rtskb)
 {
+	int                     ifindex;
+	int                     active;
 	bool			trigger = false;
 
+	if (rtskb->cap_flags & RTSKB_CAP_SHARED)
+		return;
+
+	ifindex = rtskb->rtdev->ifindex;
+	active  = tap_device[ifindex].present & (TAP_DEV | RTMAC_TAP_DEV);
+
+	if ((active & TAP_DEV)
+		&& !(tap_device[ifindex].tap_dev->flags & IFF_UP))
+		active &= ~TAP_DEV;
+	if ((active & RTMAC_TAP_DEV)
+		&& !(tap_device[ifindex].rtmac_tap_dev->flags & IFF_UP))
+		active &= ~RTMAC_TAP_DEV;
+
+	if (active == 0)
+		return;
+
 	if ((rtskb->cap_comp_skb = rtskb_pool_dequeue(&cap_pool)) == 0) {
 		tap_device[rtskb->rtdev->ifindex].tap_dev_stats.rx_dropped++;
 		return;
@@ -73,6 +91,7 @@ void rtcap_rx_hook(struct rtskb *rtskb)
 	rtskb->cap_next = NULL;
 
 	rtskb->cap_flags |= RTSKB_CAP_SHARED;
+	rtskb->cap_dev = rtskb->rtdev;
 
 	if (trigger)
 		rtdm_nrtsig_pend(&cap_signal);
@@ -83,16 +102,24 @@ int rtcap_xmit_hook(struct rtskb *rtskb, struct rtnet_device *rtdev)
 	struct tap_device_t *tap_dev = &tap_device[rtskb->rtdev->ifindex];
 	rtdm_lockctx_t context;
 	bool trigger = false;
+	int active;
 
-	if ((rtskb->cap_comp_skb = rtskb_pool_dequeue(&cap_pool)) == 0) {
+	active = tap_dev->present & XMIT_HOOK;
+	if (active && !(tap_dev->tap_dev->flags & IFF_UP))
+		active &= ~XMIT_HOOK;
+
+	if (!active
+		|| (rtskb->cap_flags & RTSKB_CAP_SHARED)
+		|| (rtskb->cap_comp_skb = rtskb_pool_dequeue(&cap_pool)) == 0) {
 		tap_dev->tap_dev_stats.rx_dropped++;
-		return tap_dev->orig_xmit(rtskb, rtdev);
+		goto done;
 	}
 
 	rtskb->cap_next = NULL;
 	rtskb->cap_start = rtskb->data;
 	rtskb->cap_len = rtskb->len;
 	rtskb->cap_flags |= RTSKB_CAP_SHARED;
+	rtskb->cap_dev = rtdev;
 
 	rtskb->time_stamp = rtdm_clock_read();
 
@@ -109,7 +136,7 @@ int rtcap_xmit_hook(struct rtskb *rtskb, struct rtnet_device *rtdev)
 
 	if (trigger)
 		rtdm_nrtsig_pend(&cap_signal);
-
+done:
 	return tap_dev->orig_xmit(rtskb, rtdev);
 }
 
@@ -181,7 +208,7 @@ static void rtcap_signal_handler(rtdm_nrtsig_t *nrtsig, void *arg)
 
 		rtdm_lock_put_irqrestore(&rtcap_lock, context);
 
-		ifindex = rtskb->rtdev->ifindex;
+		ifindex = rtskb->cap_dev->ifindex;
 		active = tap_device[ifindex].present;
 
 		if (active) {
@@ -340,6 +367,7 @@ void cleanup_tap_devices(void)
 
 			unregister_netdev(tap_device[i].tap_dev);
 			free_netdev(tap_device[i].tap_dev);
+			tap_device[i].present = 0;
 		}
 }
 
@@ -481,19 +509,21 @@ void rtcap_cleanup(void)
 {
 	rtdm_lockctx_t context;
 
-	rtdm_nrtsig_destroy(&cap_signal);
-
 	/* unregister capturing handlers
      * (take lock to avoid any unloading code before handler was left) */
 	rtdm_lock_get_irqsave(&rtcap_lock, context);
 	rtcap_handler = NULL;
 	rtdm_lock_put_irqrestore(&rtcap_lock, context);
 
+	cleanup_tap_devices();
+
+	msleep(10);
+
+	rtdm_nrtsig_destroy(&cap_signal);
+
 	/* empty queue (should be already empty) */
 	rtcap_signal_handler(0, NULL /* we ignore them anyway */);
 
-	cleanup_tap_devices();
-
 	rtskb_pool_release(&cap_pool);
 
 	printk("RTcap: unloaded\n");
diff --git a/kernel/drivers/net/stack/Kconfig b/kernel/drivers/net/stack/Kconfig
index 996536cc5..02a1c62c1 100644
--- a/kernel/drivers/net/stack/Kconfig
+++ b/kernel/drivers/net/stack/Kconfig
@@ -31,6 +31,14 @@ config XENO_DRIVERS_NET_RTWLAN
     on low-level access to 802.11-compliant adapters and is currently
     in an experimental stage.
 
+config XENO_DRIVERS_NET_VLAN
+    depends on XENO_DRIVERS_NET
+    select VLAN_8021Q
+    bool "Real-Time VLAN"
+    select XENO_DRIVERS_NET_RTIPV4_IGMP
+    ---help---
+    Enables core support for real-time VLAN.
+
 comment "Protocols"
 
 source "drivers/xenomai/net/stack/ipv4/Kconfig"
diff --git a/kernel/drivers/net/stack/Makefile b/kernel/drivers/net/stack/Makefile
index f75483e02..1e2b3ed36 100644
--- a/kernel/drivers/net/stack/Makefile
+++ b/kernel/drivers/net/stack/Makefile
@@ -24,3 +24,5 @@ rtnet-y :=  \
 	eth.o
 
 rtnet-$(CONFIG_XENO_DRIVERS_NET_RTWLAN) += rtwlan.o
+
+rtnet-$(CONFIG_XENO_DRIVERS_NET_VLAN) += vlan.o
diff --git a/kernel/drivers/net/stack/include/rtdev.h b/kernel/drivers/net/stack/include/rtdev.h
index e5a6bf920..27c390df5 100644
--- a/kernel/drivers/net/stack/include/rtdev.h
+++ b/kernel/drivers/net/stack/include/rtdev.h
@@ -153,6 +153,13 @@ struct rtnet_device {
 	int (*hard_start_xmit)(struct rtskb *skb, struct rtnet_device *dev);
 	int (*hw_reset)(struct rtnet_device *rtdev);
 	void (*set_multicast_list) (struct rtnet_device *rtdev);
+	void (*vlan_rx_add_vid)(struct rtnet_device *dev,
+				unsigned short vid);
+	void (*vlan_rx_kill_vid)(struct rtnet_device *dev,
+				unsigned short vid);
+#ifdef CONFIG_XENO_DRIVERS_NET_VLAN
+	struct list_head	vlan_link;
+#endif
 
 	/* Transmission hook, managed by the stack core, RTcap, and RTmac
      *
@@ -188,6 +195,18 @@ extern struct list_head event_hook_list;
 extern struct mutex rtnet_devices_nrt_lock;
 extern struct rtnet_device *rtnet_devices[];
 
+#ifdef CONFIG_XENO_DRIVERS_NET_VLAN
+extern struct rtnet_device *
+__rtdev_real_dev(struct rtnet_device *dev) __attribute__((pure));
+#else
+static inline struct rtnet_device *__rtdev_real_dev(struct rtnet_device *dev)
+{
+	return dev;
+}
+#endif
+#define rtdev_mc_list(dev) __rtdev_real_dev(dev)->mc_list
+#define rtdev_mc_count(dev) __rtdev_real_dev(dev)->mc_count
+
 int __rt_init_etherdev(struct rtnet_device *rtdev, unsigned int dev_pool_size,
 		       struct module *module);
 
diff --git a/kernel/drivers/net/stack/include/rtif_vlan.h b/kernel/drivers/net/stack/include/rtif_vlan.h
new file mode 100644
index 000000000..d1cc9fa4b
--- /dev/null
+++ b/kernel/drivers/net/stack/include/rtif_vlan.h
@@ -0,0 +1,105 @@
+/*
+ * VLAN		An implementation of 802.1Q VLAN tagging.
+ *
+ * Authors:	Ben Greear <greearb@candelatech.com>
+ *
+ *		This program is free software; you can redistribute it and/or
+ *		modify it under the terms of the GNU General Public License
+ *		as published by the Free Software Foundation; either version
+ *		2 of the License, or (at your option) any later version.
+ *
+ */
+#ifndef _RTNET_IF_VLAN_H_
+#define _RTNET_IF_VLAN_H_
+
+#include <rtdev.h>
+#include <rtskb.h>
+#include <uapi/linux/if_vlan.h>
+#include <linux/if_vlan.h>
+
+/* found in socket.c */
+extern void rtvlan_ioctl_set(int (*hook)(struct net *, void __user *));
+
+static inline bool is_rtvlan_dev(struct rtnet_device *dev)
+{
+	return !!(dev->priv_flags & IFF_802_1Q_VLAN);
+}
+
+struct rtvlan_pcpu_stats {
+	u64			rx_packets;
+	u64			rx_bytes;
+	u64			rx_multicast;
+	u64			tx_packets;
+	u64			tx_bytes;
+	seqcount_t		syncp;
+	u32			rx_errors;
+	u32			tx_dropped;
+};
+
+struct rtvlan_dev_priv {
+	unsigned int				nr_ingress_mappings;
+	u32					ingress_priority_map[8];
+	unsigned int				nr_egress_mappings;
+	struct vlan_priority_tci_mapping	*egress_priority_map[16];
+
+	__be16					vlan_proto;
+	u16					vlan_id;
+	u16					flags;
+
+	struct rtnet_device			*real_dev;
+	unsigned char				real_dev_addr[ETH_ALEN];
+
+	struct rtvlan_pcpu_stats __percpu	*vlan_pcpu_stats;
+	struct net_device_stats			stats;
+	unsigned int				nest_level;
+};
+
+static inline struct rtvlan_dev_priv *rtvlan_dev_priv(const struct rtnet_device *dev)
+{
+	return dev->priv;
+}
+
+static inline u16
+rtvlan_dev_get_egress_qos_mask(struct rtnet_device *dev, u32 skprio)
+{
+	struct vlan_priority_tci_mapping *mp;
+
+	smp_rmb(); /* coupled with smp_wmb() in rtvlan_dev_set_egress_priority() */
+
+	mp = rtvlan_dev_priv(dev)->egress_priority_map[(skprio & 0xF)];
+	while (mp) {
+		if (mp->priority == skprio) {
+			return mp->vlan_qos; /* This should already be shifted
+					      * to mask correctly with the
+					      * VLAN's TCI */
+		}
+		mp = mp->next;
+	}
+	return 0;
+}
+
+static inline void
+rtvlan_insert_tag(struct rtskb *skb, __be16 vlan_proto, u16 vlan_tci)
+{
+	struct vlan_ethhdr *veth;
+
+	veth = (struct vlan_ethhdr *)rtskb_push(skb, VLAN_HLEN);
+
+	/* Move the mac addresses to the beginning of the new header. */
+	memmove(skb->data, skb->data + VLAN_HLEN, 2 * ETH_ALEN);
+
+	/* first, the ethernet type */
+	veth->h_vlan_proto = vlan_proto;
+
+	/* now, the TCI */
+	veth->h_vlan_TCI = htons(vlan_tci);
+}
+
+static inline void
+rtvlan_put_tag(struct rtskb *skb, __be16 vlan_proto, u16 vlan_tci)
+{
+	rtvlan_insert_tag(skb, vlan_proto, vlan_tci);
+	skb->protocol = vlan_proto;
+}
+
+#endif /* !(_RTNET_IF_VLAN_H_) */
diff --git a/kernel/drivers/net/stack/include/rtnet_port.h b/kernel/drivers/net/stack/include/rtnet_port.h
index 5342cc621..570cea27c 100644
--- a/kernel/drivers/net/stack/include/rtnet_port.h
+++ b/kernel/drivers/net/stack/include/rtnet_port.h
@@ -58,12 +58,12 @@ static inline int rtnetif_queue_stopped(struct rtnet_device *rtdev)
 
 static inline int rtnetif_running(struct rtnet_device *rtdev)
 {
-	return test_bit(__RTNET_LINK_STATE_START, &rtdev->link_state);
+	return test_bit(__RTNET_LINK_STATE_START, &__rtdev_real_dev(rtdev)->link_state);
 }
 
 static inline int rtnetif_device_present(struct rtnet_device *rtdev)
 {
-	return test_bit(__RTNET_LINK_STATE_PRESENT, &rtdev->link_state);
+	return test_bit(__RTNET_LINK_STATE_PRESENT, &__rtdev_real_dev(rtdev)->link_state);
 }
 
 static inline void rtnetif_device_detach(struct rtnet_device *rtdev)
@@ -100,7 +100,7 @@ static inline void rtnetif_carrier_off(struct rtnet_device *rtdev)
 
 static inline int rtnetif_carrier_ok(struct rtnet_device *rtdev)
 {
-	return !test_bit(__RTNET_LINK_STATE_NOCARRIER, &rtdev->link_state);
+	return !test_bit(__RTNET_LINK_STATE_NOCARRIER, &__rtdev_real_dev(rtdev)->link_state);
 }
 
 #define NIPQUAD(addr)                                                          \
diff --git a/kernel/drivers/net/stack/include/rtskb.h b/kernel/drivers/net/stack/include/rtskb.h
index 4277fa6c6..4920b3916 100644
--- a/kernel/drivers/net/stack/include/rtskb.h
+++ b/kernel/drivers/net/stack/include/rtskb.h
@@ -219,6 +219,7 @@ struct rtskb {
 	unsigned char *cap_start; /* start offset for capturing           */
 	unsigned int cap_len; /* capture length of this rtskb         */
 	nanosecs_abs_t cap_rtmac_stamp; /* RTmac enqueuing time            */
+        struct rtnet_device *cap_dev;	 /* Captured interface */
 #endif
 
 	struct list_head entry; /* for global rtskb list */
diff --git a/kernel/drivers/net/stack/include/rtvlan.h b/kernel/drivers/net/stack/include/rtvlan.h
new file mode 100644
index 000000000..a6fd3df91
--- /dev/null
+++ b/kernel/drivers/net/stack/include/rtvlan.h
@@ -0,0 +1,25 @@
+#ifndef RTNET_RTVLAN_H
+#define RTNET_RTVLAN_H
+
+#ifdef CONFIG_XENO_DRIVERS_NET_VLAN
+void rtvlan_proto_init(void);
+
+void rtvlan_proto_release(void);
+
+int rtvlan_ioctl_handler(void __user *arg);
+#else
+static inline void rtvlan_proto_init(void)
+{
+}
+
+static inline void rtvlan_proto_release(void)
+{
+}
+
+static inline int rtvlan_ioctl_handler(void __user *arg)
+{
+	return -ENOSYS;
+}
+#endif
+
+#endif /* RTNET_RTVLAN_H */
diff --git a/kernel/drivers/net/stack/rtdev.c b/kernel/drivers/net/stack/rtdev.c
index a78d5241f..14675abf5 100644
--- a/kernel/drivers/net/stack/rtdev.c
+++ b/kernel/drivers/net/stack/rtdev.c
@@ -329,6 +329,9 @@ static void init_etherdev(struct rtnet_device *rtdev, struct module *module)
 	rtdev->flags = IFF_BROADCAST; /* TODO: IFF_MULTICAST; */
 	rtdev->get_mtu = rt_hard_mtu;
 	rtdev->rt_owner = module;
+#ifdef CONFIG_XENO_DRIVERS_NET_VLAN
+	INIT_LIST_HEAD(&rtdev->vlan_link);
+#endif
 
 	memset(rtdev->broadcast, 0xFF, ETH_ALEN);
 	strcpy(rtdev->name, "rteth%d");
@@ -525,6 +528,15 @@ int rt_register_rtnetdev(struct rtnet_device *rtdev)
 	if (rtdev->vers < RTDEV_VERS_2_0)
 		return -EINVAL;
 
+#ifdef CONFIG_XENO_DRIVERS_NET_VLAN
+	if ((rtdev->features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
+	    (!rtdev->vlan_rx_add_vid || !rtdev->vlan_rx_kill_vid)) {
+	    printk("RTnet: %s has VLAN hardware filtering but does not provide "
+		    "callbacks\n", rtdev->name);
+	    return -EINVAL;
+	}
+#endif
+
 	if (rtdev->features & NETIF_F_LLTX)
 		rtdev->start_xmit = rtdev->hard_start_xmit;
 	else
@@ -995,7 +1007,7 @@ int rt_dev_mc_delete(struct rtnet_device *dev, void *addr, int alen, int glbl)
 
     rtdm_lock_get_irqsave(&dev->rtdev_lock, flags);
 
-    for (dmip = &dev->mc_list; (dmi = *dmip) != NULL; dmip = &dmi->next) {
+    for (dmip = &rtdev_mc_list(dev); (dmi = *dmip) != NULL; dmip = &dmi->next) {
         /*
          *  Find the entry we want to delete. The device could
          *  have variable length entries so check these too.
@@ -1015,7 +1027,7 @@ int rt_dev_mc_delete(struct rtnet_device *dev, void *addr, int alen, int glbl)
              *  Last user. So delete the entry.
              */
             *dmip = dmi->next;
-            dev->mc_count--;
+            rtdev_mc_count(dev)--;
 
             /*
              *  We have altered the list, so the card
@@ -1050,7 +1062,7 @@ int rt_dev_mc_add(struct rtnet_device *dev, void *addr, int alen, int glbl)
     dmi1 = rtdm_malloc(sizeof(*dmi1));
 
     rtdm_lock_get_irqsave(&dev->rtdev_lock, flags);
-    for (dmi = dev->mc_list; dmi != NULL; dmi = dmi->next) {
+    for (dmi = rtdev_mc_list(dev); dmi != NULL; dmi = dmi->next) {
         if (memcmp(dmi->dmi_addr, addr, dmi->dmi_addrlen) == 0 &&
             dmi->dmi_addrlen == alen) {
             if (glbl) {
@@ -1070,11 +1082,11 @@ int rt_dev_mc_add(struct rtnet_device *dev, void *addr, int alen, int glbl)
     }
     memcpy(dmi->dmi_addr, addr, alen);
     dmi->dmi_addrlen = alen;
-    dmi->next = dev->mc_list;
+    dmi->next = rtdev_mc_list(dev);
     dmi->dmi_users = 1;
     dmi->dmi_gusers = glbl ? 1 : 0;
-    dev->mc_list = dmi;
-    dev->mc_count++;
+    rtdev_mc_list(dev) = dmi;
+    rtdev_mc_count(dev)++;
 
     __rt_dev_mc_upload(dev);
 
@@ -1099,16 +1111,16 @@ void rt_dev_mc_discard(struct rtnet_device *dev)
 
     rtdm_lock_get_irqsave(&dev->rtdev_lock, flags);
 
-    while (dev->mc_list != NULL) {
-        struct rtdev_mc_list *tmp = dev->mc_list;
-        dev->mc_list = tmp->next;
+    while (rtdev_mc_list(dev) != NULL) {
+        struct rtdev_mc_list *tmp = rtdev_mc_list(dev);
+        rtdev_mc_list(dev) = tmp->next;
         if (tmp->dmi_users > tmp->dmi_gusers)
             printk("dev_mc_discard: multicast leakage! dmi_users=%d\n", tmp->dmi_users);
         rtdm_lock_put_irqrestore(&dev->rtdev_lock, flags);
         rtdm_free(tmp);
         rtdm_lock_get_irqsave(&dev->rtdev_lock, flags);
     }
-    dev->mc_count = 0;
+    rtdev_mc_count(dev) = 0;
 
     rtdm_lock_put_irqrestore(&dev->rtdev_lock, flags);
 }
diff --git a/kernel/drivers/net/stack/rtnet_chrdev.c b/kernel/drivers/net/stack/rtnet_chrdev.c
index 9457661a1..782be5728 100644
--- a/kernel/drivers/net/stack/rtnet_chrdev.c
+++ b/kernel/drivers/net/stack/rtnet_chrdev.c
@@ -30,6 +30,7 @@
 #include <linux/netdevice.h>
 #include <linux/spinlock.h>
 
+#include <rtnet_port.h>
 #include <rtnet_chrdev.h>
 #include <rtnet_internal.h>
 #include <ipv4/route.h>
@@ -125,10 +126,9 @@ static int rtnet_core_ioctl(struct rtnet_device *rtdev, unsigned int request,
 		cmd.args.info.broadcast_ip = rtdev->broadcast_ip;
 		cmd.args.info.mtu = rtdev->mtu;
 		cmd.args.info.flags = rtdev->flags;
-		if ((cmd.args.info.flags & IFF_UP) &&
-		    (rtdev->link_state &
-		     (RTNET_LINK_STATE_PRESENT | RTNET_LINK_STATE_NOCARRIER)) ==
-			    RTNET_LINK_STATE_PRESENT)
+		if ((cmd.args.info.flags & IFF_UP)
+		    && rtnetif_carrier_ok(rtdev)
+		    && rtnetif_device_present(rtdev))
 			cmd.args.info.flags |= IFF_RUNNING;
 
 		memcpy(cmd.args.info.dev_addr, rtdev->dev_addr, MAX_ADDR_LEN);
diff --git a/kernel/drivers/net/stack/rtnet_module.c b/kernel/drivers/net/stack/rtnet_module.c
index 16dc91fda..87addd303 100644
--- a/kernel/drivers/net/stack/rtnet_module.c
+++ b/kernel/drivers/net/stack/rtnet_module.c
@@ -34,6 +34,7 @@
 #include <rtnet_rtpc.h>
 #include <stack_mgr.h>
 #include <rtwlan.h>
+#include <rtvlan.h>
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("RTnet stack core");
@@ -352,6 +353,8 @@ int __init rtnet_init(void)
 	if ((err = rtpc_init()) != 0)
 		goto err_out6;
 
+	rtvlan_proto_init();
+
 	rtnet_corectl_register();
 
 	return 0;
@@ -387,6 +390,8 @@ void __exit rtnet_release(void)
 {
 	rtnet_corectl_unregister();
 
+	rtvlan_proto_release();
+
 	rtpc_cleanup();
 
 	rtwlan_exit();
diff --git a/kernel/drivers/net/stack/socket.c b/kernel/drivers/net/stack/socket.c
index f030663be..cd118439b 100644
--- a/kernel/drivers/net/stack/socket.c
+++ b/kernel/drivers/net/stack/socket.c
@@ -36,6 +36,8 @@
 #include <rtnet_internal.h>
 #include <rtnet_iovec.h>
 #include <rtnet_socket.h>
+#include <rtvlan.h>
+#include <rtnet_port.h>
 #include <ipv4/protocol.h>
 
 #define SKB_POOL_CLOSED 0
@@ -231,7 +233,8 @@ int rt_socket_if_ioctl(struct rtdm_fd *fd, int request, void __user *arg)
 	int ret = 0, size = 0, i;
 	short flags;
 
-	if (request == SIOCGIFCONF) {
+	switch (request) {
+	case SIOCGIFCONF: {
 		u_ifc = arg;
 		ifc = rtnet_get_arg(fd, &_ifc, u_ifc, sizeof(_ifc));
 		if (IS_ERR(ifc))
@@ -273,6 +276,11 @@ int rt_socket_if_ioctl(struct rtdm_fd *fd, int request, void __user *arg)
 		return rtnet_put_arg(fd, &u_ifc->ifc_len, &size, sizeof(size));
 	}
 
+	case SIOCSIFVLAN:
+	  return rtvlan_ioctl_handler(arg);
+	}
+
+
 	u_ifr = arg;
 	ifr = rtnet_get_arg(fd, &_ifr, u_ifr, sizeof(_ifr));
 	if (IS_ERR(ifr))
@@ -298,10 +306,9 @@ int rt_socket_if_ioctl(struct rtdm_fd *fd, int request, void __user *arg)
 
 	case SIOCGIFFLAGS:
 		flags = rtdev->flags;
-		if ((ifr->ifr_flags & IFF_UP) &&
-		    (rtdev->link_state &
-		     (RTNET_LINK_STATE_PRESENT | RTNET_LINK_STATE_NOCARRIER)) ==
-			    RTNET_LINK_STATE_PRESENT)
+		if ((ifr->ifr_flags & IFF_UP)
+		    && rtnetif_carrier_ok(rtdev)
+		    && rtnetif_device_present(rtdev))
 			flags |= IFF_RUNNING;
 		ret = rtnet_put_arg(fd, &u_ifr->ifr_flags, &flags,
 				    sizeof(u_ifr->ifr_flags));
diff --git a/kernel/drivers/net/stack/vlan.c b/kernel/drivers/net/stack/vlan.c
new file mode 100644
index 000000000..7e8c389a4
--- /dev/null
+++ b/kernel/drivers/net/stack/vlan.c
@@ -0,0 +1,725 @@
+/*
+ * INET		802.1Q VLAN
+ *		Ethernet-type device handling.
+ *
+ * Authors:	Ben Greear <greearb@candelatech.com>
+ *		Please send support related email to: netdev@vger.kernel.org
+ *		VLAN Home Page: http://www.candelatech.com/~greear/vlan.html
+ *
+ * Fixes:
+ *		Fix for packet capture - Nick Eggleston <nick@dccinc.com>;
+ *		Add HW acceleration hooks - David S. Miller <davem@redhat.com>;
+ *		Correct all the locking - David S. Miller <davem@redhat.com>;
+ *		Use hash table for VLAN groups - David S. Miller <davem@redhat.com>
+ *
+ *		This program is free software; you can redistribute it and/or
+ *		modify it under the terms of the GNU General Public License
+ *		as published by the Free Software Foundation; either version
+ *		2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include <rtdev.h>
+#include <rtnet_port.h>
+#include <rtif_vlan.h>
+
+static unsigned short rtvlan_name_type = VLAN_NAME_TYPE_RAW_PLUS_VID_NO_PAD;
+
+struct rtnet_device *__rtdev_real_dev(struct rtnet_device *dev)
+{
+	if (is_rtvlan_dev(dev))
+		dev = rtvlan_dev_priv(dev)->real_dev;
+
+	return dev;
+}
+EXPORT_SYMBOL_GPL(__rtdev_real_dev);
+
+static inline u16 rtvlan_dev_vlan_id(const struct rtnet_device *dev)
+{
+	return rtvlan_dev_priv(dev)->vlan_id;
+}
+
+static void vlan_dev_set_rx_mode(struct rtnet_device *vlan_dev)
+{
+	struct rtvlan_dev_priv *vlan = rtvlan_dev_priv(vlan_dev);
+	struct rtnet_device *real_dev = vlan->real_dev;
+
+	rt_dev_mc_upload(real_dev);
+}
+
+/*
+ *	Create the VLAN header for an arbitrary protocol layer
+ *
+ *	saddr=NULL	means use device source address
+ *	daddr=NULL	means leave destination address (eg unresolved arp)
+ *
+ *  This is called when the SKB is moving down the stack towards the
+ *  physical devices.
+ */
+static int vlan_dev_hard_header(struct rtskb *skb, struct rtnet_device *dev,
+				unsigned short type,
+				void *daddr, void *saddr,
+				unsigned int len)
+{
+	struct rtvlan_dev_priv *vlan = rtvlan_dev_priv(dev);
+	struct vlan_hdr *vhdr;
+	unsigned int vhdrlen = 0;
+	u16 vlan_tci = 0;
+	int rc;
+
+	if (!(vlan->flags & VLAN_FLAG_REORDER_HDR)) {
+		vhdr = (struct vlan_hdr *) rtskb_push(skb, VLAN_HLEN);
+
+		vlan_tci = vlan->vlan_id;
+		vlan_tci |= rtvlan_dev_get_egress_qos_mask(dev, skb->priority);
+		vhdr->h_vlan_TCI = htons(vlan_tci);
+
+		/*
+		 *  Set the protocol type. For a packet of type ETH_P_802_3/2 we
+		 *  put the length in here instead.
+		 */
+		if (type != ETH_P_802_3 && type != ETH_P_802_2)
+			vhdr->h_vlan_encapsulated_proto = htons(type);
+		else
+			vhdr->h_vlan_encapsulated_proto = htons(len);
+
+		skb->protocol = vlan->vlan_proto;
+		type = ntohs(vlan->vlan_proto);
+		vhdrlen = VLAN_HLEN;
+	}
+
+	/* Before delegating work to the lower layer, enter our MAC-address */
+	if (saddr == NULL)
+		saddr = dev->dev_addr;
+
+	/* Now make the underlying real hard header */
+	dev = vlan->real_dev;
+	rc = dev->hard_header(skb, dev, type, daddr, saddr, len + vhdrlen);
+	if (rc > 0)
+		rc += vhdrlen;
+	return rc;
+}
+
+static netdev_tx_t vlan_dev_hard_start_xmit(struct rtskb *skb,
+					    struct rtnet_device *dev)
+{
+	struct rtvlan_dev_priv *vlan = rtvlan_dev_priv(dev);
+	struct vlan_ethhdr *veth = (struct vlan_ethhdr *)skb->data;
+	struct rtnet_device *real_dev = vlan->real_dev;
+	unsigned int len;
+	int ret;
+
+	/* Handle non-VLAN frames if they are sent to us, for example by DHCP.
+	 *
+	 * NOTE: THIS ASSUMES DIX ETHERNET, SPECIFICALLY NOT SUPPORTING
+	 * OTHER THINGS LIKE FDDI/TokenRing/802.3 SNAPs...
+	 */
+	if (veth->h_vlan_proto != vlan->vlan_proto ||
+		(vlan->flags & VLAN_FLAG_REORDER_HDR)) {
+		u16 vlan_tci;
+		vlan_tci = vlan->vlan_id;
+		vlan_tci |= rtvlan_dev_get_egress_qos_mask(dev, skb->priority);
+		rtvlan_put_tag(skb, vlan->vlan_proto, vlan_tci);
+	}
+
+	skb->rtdev = real_dev;
+	len = skb->len;
+
+	ret = real_dev->start_xmit(skb, real_dev);
+
+	if (likely(ret == 0)) {
+		struct rtvlan_pcpu_stats *stats;
+
+		stats = this_cpu_ptr(vlan->vlan_pcpu_stats);
+		raw_write_seqcount_begin(&stats->syncp);
+		stats->tx_packets++;
+		stats->tx_bytes += len;
+		raw_write_seqcount_end(&stats->syncp);
+	} else {
+		this_cpu_inc(vlan->vlan_pcpu_stats->tx_dropped);
+	}
+
+	return ret;
+}
+
+void vlan_dev_set_ingress_priority(const struct rtnet_device *dev,
+				   u32 skb_prio, u16 vlan_prio)
+{
+	struct rtvlan_dev_priv *vlan = rtvlan_dev_priv(dev);
+
+	if (vlan->ingress_priority_map[vlan_prio & 0x7] && !skb_prio)
+		vlan->nr_ingress_mappings--;
+	else if (!vlan->ingress_priority_map[vlan_prio & 0x7] && skb_prio)
+		vlan->nr_ingress_mappings++;
+
+	vlan->ingress_priority_map[vlan_prio & 0x7] = skb_prio;
+}
+
+int vlan_dev_set_egress_priority(const struct rtnet_device *dev,
+				 u32 skb_prio, u16 vlan_prio)
+{
+	struct rtvlan_dev_priv *vlan = rtvlan_dev_priv(dev);
+	struct vlan_priority_tci_mapping *mp = NULL;
+	struct vlan_priority_tci_mapping *np;
+	u32 vlan_qos = (vlan_prio << VLAN_PRIO_SHIFT) & VLAN_PRIO_MASK;
+
+	/* See if a priority mapping exists.. */
+	mp = vlan->egress_priority_map[skb_prio & 0xF];
+	while (mp) {
+		if (mp->priority == skb_prio) {
+			if (mp->vlan_qos && !vlan_qos)
+				vlan->nr_egress_mappings--;
+			else if (!mp->vlan_qos && vlan_qos)
+				vlan->nr_egress_mappings++;
+			mp->vlan_qos = vlan_qos;
+			return 0;
+		}
+		mp = mp->next;
+	}
+
+	/* Create a new mapping then. */
+	mp = vlan->egress_priority_map[skb_prio & 0xF];
+	np = kmalloc(sizeof(struct vlan_priority_tci_mapping), GFP_KERNEL);
+	if (!np)
+		return -ENOBUFS;
+
+	np->next = mp;
+	np->priority = skb_prio;
+	np->vlan_qos = vlan_qos;
+	/* Before inserting this element in hash table, make sure all its fields
+	 * are committed to memory.
+	 * coupled with smp_rmb() in vlan_dev_get_egress_qos_mask()
+	 */
+	smp_wmb();
+	vlan->egress_priority_map[skb_prio & 0xF] = np;
+	if (vlan_qos)
+		vlan->nr_egress_mappings++;
+	return 0;
+}
+
+static inline u32 vlan_get_ingress_priority(struct rtnet_device *dev,
+					    u16 vlan_tci)
+{
+	struct rtvlan_dev_priv *vip = rtvlan_dev_priv(dev);
+
+	return vip->ingress_priority_map[(vlan_tci >> VLAN_PRIO_SHIFT) & 0x7];
+}
+
+/* Flags are defined in the vlan_flags enum in include/linux/if_vlan.h file. */
+static int
+vlan_dev_change_flags(const struct rtnet_device *dev, u32 flags, u32 mask)
+{
+	struct rtvlan_dev_priv *vlan = rtvlan_dev_priv(dev);
+	u32 old_flags = vlan->flags;
+
+	if (mask & ~(VLAN_FLAG_REORDER_HDR | VLAN_FLAG_LOOSE_BINDING))
+		return -EINVAL;
+
+	vlan->flags = (old_flags & ~mask) | (flags & mask);
+
+	return 0;
+}
+
+static void
+vlan_dev_get_realdev_name(const struct rtnet_device *dev, char *result)
+{
+	strncpy(result, rtvlan_dev_priv(dev)->real_dev->name, 23);
+}
+
+static int vlan_dev_open(struct rtnet_device *dev)
+{
+	struct rtvlan_dev_priv *vlan = rtvlan_dev_priv(dev);
+	struct rtnet_device *real_dev = vlan->real_dev;
+
+	if (!(real_dev->flags & IFF_UP) &&
+	    !(vlan->flags & VLAN_FLAG_LOOSE_BINDING))
+		return -ENETDOWN;
+
+	ether_addr_copy(vlan->real_dev_addr, real_dev->dev_addr);
+
+	vlan_dev_set_rx_mode(dev);
+
+	if (rtnetif_carrier_ok(real_dev))
+		rtnetif_carrier_on(dev);
+	return 0;
+}
+
+static int vlan_dev_stop(struct rtnet_device *dev)
+{
+	rtnetif_carrier_off(dev);
+	return 0;
+}
+
+static struct net_device_stats *vlan_dev_get_stats(struct rtnet_device *dev)
+{
+	struct rtvlan_dev_priv *vlan = rtvlan_dev_priv(dev);
+	struct net_device_stats *stats = &vlan->stats;
+
+	memset(stats, '\0', sizeof(*stats));
+
+	if (rtvlan_dev_priv(dev)->vlan_pcpu_stats) {
+		struct rtvlan_pcpu_stats *p;
+		u32 rx_errors = 0, tx_dropped = 0;
+		int i;
+
+		for_each_possible_cpu(i) {
+			u64 rxpackets, rxbytes, rxmulticast, txpackets, txbytes;
+			unsigned int start;
+
+			p = per_cpu_ptr(rtvlan_dev_priv(dev)->vlan_pcpu_stats, i);
+			do {
+				start = raw_seqcount_begin(&p->syncp);
+				rxpackets	= p->rx_packets;
+				rxbytes		= p->rx_bytes;
+				rxmulticast	= p->rx_multicast;
+				txpackets	= p->tx_packets;
+				txbytes		= p->tx_bytes;
+			} while (read_seqcount_retry(&p->syncp, start));
+
+			stats->rx_packets	+= rxpackets;
+			stats->rx_bytes		+= rxbytes;
+			stats->multicast	+= rxmulticast;
+			stats->tx_packets	+= txpackets;
+			stats->tx_bytes		+= txbytes;
+			/* rx_errors & tx_dropped are u32 */
+			rx_errors	+= p->rx_errors;
+			tx_dropped	+= p->tx_dropped;
+		}
+		stats->rx_errors  = rx_errors;
+		stats->tx_dropped = tx_dropped;
+	}
+	return stats;
+}
+
+static int vlan_dev_init(struct rtnet_device *dev)
+{
+	struct rtvlan_dev_priv *vlan = rtvlan_dev_priv(dev);
+	struct rtnet_device *real_dev = vlan->real_dev;
+	int i;
+
+	rtnetif_carrier_off(dev);
+
+	/* IFF_BROADCAST|IFF_MULTICAST; ??? */
+	dev->flags  = real_dev->flags & ~(IFF_UP | IFF_PROMISC | IFF_ALLMULTI
+					| IFF_MASTER | IFF_SLAVE);
+	dev->link_state	 =
+		(real_dev->link_state & (1<<__RTNET_LINK_STATE_NOCARRIER)) |
+		(1<<__RTNET_LINK_STATE_PRESENT);
+
+	dev->features = NETIF_F_LLTX;
+
+	if (is_zero_ether_addr(dev->dev_addr))
+		ether_addr_copy(dev->dev_addr, real_dev->dev_addr);;
+	if (is_zero_ether_addr(dev->broadcast))
+		memcpy(dev->broadcast, real_dev->broadcast, dev->addr_len);
+
+	dev->open = vlan_dev_open;
+	dev->stop = vlan_dev_stop;
+	dev->hard_header_len = real_dev->hard_header_len + VLAN_HLEN;
+	dev->hard_header = vlan_dev_hard_header;
+	dev->hard_start_xmit = vlan_dev_hard_start_xmit;
+	dev->get_stats = vlan_dev_get_stats;
+	if (real_dev->set_multicast_list)
+		dev->set_multicast_list = vlan_dev_set_rx_mode;
+
+	vlan->vlan_pcpu_stats = alloc_percpu(typeof(*vlan->vlan_pcpu_stats));
+	if (!rtvlan_dev_priv(dev)->vlan_pcpu_stats)
+		return -ENOMEM;
+
+	for_each_possible_cpu(i) {
+		struct rtvlan_pcpu_stats *vlan_stat;
+		vlan_stat = per_cpu_ptr(vlan->vlan_pcpu_stats, i);
+		seqcount_init(&vlan_stat->syncp);
+	}
+
+	return 0;
+}
+
+static void vlan_dev_uninit(struct rtnet_device *dev)
+{
+	struct vlan_priority_tci_mapping *pm;
+	struct rtvlan_dev_priv *vlan = rtvlan_dev_priv(dev);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vlan->egress_priority_map); i++) {
+		while ((pm = vlan->egress_priority_map[i]) != NULL) {
+			vlan->egress_priority_map[i] = pm->next;
+			kfree(pm);
+		}
+	}
+}
+
+static void vlan_dev_free(struct rtnet_device *dev)
+{
+	struct rtvlan_dev_priv *vlan = rtvlan_dev_priv(dev);
+
+	vlan_dev_uninit(dev);
+	free_percpu(vlan->vlan_pcpu_stats);
+	vlan->vlan_pcpu_stats = NULL;
+	rt_unregister_rtnetdev(dev);
+	rt_rtdev_disconnect(dev);
+	rtdev_free(dev);
+}
+
+static bool vlan_hw_filter_capable(const struct rtnet_device *dev)
+{
+	return !!(dev->features & NETIF_F_HW_VLAN_CTAG_FILTER);
+}
+
+static struct rtnet_device *__rtvlan_find_dev(struct rtnet_device *dev, u16 vid)
+{
+	struct rtnet_device *vlan_dev;
+
+	if (vid == 0)
+		return dev;
+
+	list_for_each_entry(vlan_dev, &dev->vlan_link, vlan_link) {
+		struct rtvlan_dev_priv *vlan = rtvlan_dev_priv(vlan_dev);
+
+		if (vlan->vlan_id == vid)
+			return vlan_dev;
+	}
+
+	return NULL;
+}
+
+static struct rtnet_device *rtvlan_find_dev(struct rtnet_device *dev, u16 vid)
+{
+	struct rtnet_device *vlan_dev;
+	unsigned long flags;
+
+	rtdm_lock_get_irqsave(&dev->rtdev_lock, flags);
+	vlan_dev = __rtvlan_find_dev(dev, vid);
+	if (vlan_dev)
+		rtdev_reference(vlan_dev);
+	rtdm_lock_put_irqrestore(&dev->rtdev_lock, flags);
+
+	return vlan_dev;
+}
+
+static int rtvlan_vid_add(struct rtnet_device *dev)
+{
+	struct rtvlan_dev_priv *vlan = rtvlan_dev_priv(dev);
+	struct rtnet_device *real_dev = vlan->real_dev;
+	u16 vid = vlan->vlan_id;
+	unsigned long flags;
+	int err = 0;
+
+	rtdm_lock_get_irqsave(&dev->rtdev_lock, flags);
+	if (__rtvlan_find_dev(real_dev, vid)) {
+		err = -EEXIST;
+		goto out;
+	}
+
+	list_add(&dev->vlan_link, &real_dev->vlan_link);
+
+	if (vlan_hw_filter_capable(real_dev))
+		real_dev->vlan_rx_add_vid(real_dev, vid);
+  out:
+	rtdm_lock_put_irqrestore(&dev->rtdev_lock, flags);
+
+	return err;
+}
+
+static void rtvlan_vid_del(struct rtnet_device *dev)
+{
+	struct rtvlan_dev_priv *vlan = rtvlan_dev_priv(dev);
+	struct rtnet_device *real_dev = vlan->real_dev;
+	u16 vid = vlan->vlan_id;
+	unsigned long flags;
+
+	rtdm_lock_get_irqsave(&dev->rtdev_lock, flags);
+	if (__rtvlan_find_dev(real_dev, vid) != dev)
+		goto out;
+
+	list_del(&dev->vlan_link);
+
+	if (vlan_hw_filter_capable(real_dev))
+		real_dev->vlan_rx_kill_vid(real_dev, vid);
+  out:
+	rtdm_lock_put_irqrestore(&dev->rtdev_lock, flags);
+}
+
+void unregister_vlan_dev(struct rtnet_device *dev)
+{
+	struct rtvlan_dev_priv *vlan = rtvlan_dev_priv(dev);
+	struct rtnet_device *real_dev = vlan->real_dev;
+	u16 vlan_id = vlan->vlan_id;
+
+	if (vlan_id)
+		rtvlan_vid_del(dev);
+
+	/* Get rid of the vlan's reference to real_dev */
+	rtdev_dereference(real_dev);
+	vlan_dev_free(dev);
+}
+
+
+/*  Attach a VLAN device to a mac address (ie Ethernet Card).
+ *  Returns 0 if the device was created or a negative error code otherwise.
+ */
+static int register_vlan_device(struct rtnet_device *real_dev, u16 vlan_id)
+{
+	struct rtnet_device *new_dev;
+	struct rtvlan_dev_priv *vlan;
+	char name[IFNAMSIZ];
+	int err;
+
+	if (vlan_id >= VLAN_VID_MASK)
+		return -ERANGE;
+
+	/* Gotta set up the fields for the device.
+	   Only one type of device name supported
+	 */
+	switch (rtvlan_name_type) {
+	case VLAN_NAME_TYPE_RAW_PLUS_VID:
+		/* name will look like:	 eth1.0005 */
+		snprintf(name, IFNAMSIZ, "%s.%.4i", real_dev->name, vlan_id);
+		break;
+	case VLAN_NAME_TYPE_PLUS_VID_NO_PAD:
+		/* Put our vlan.VID in the name.
+		 * Name will look like:	 vlan5
+		 */
+		snprintf(name, IFNAMSIZ, "rtvlan%i", vlan_id);
+		break;
+	case VLAN_NAME_TYPE_RAW_PLUS_VID_NO_PAD:
+		/* Put our vlan.VID in the name.
+		 * Name will look like:	 eth0.5
+		 */
+		snprintf(name, IFNAMSIZ, "%s.%i", real_dev->name, vlan_id);
+		break;
+	case VLAN_NAME_TYPE_PLUS_VID:
+		/* Put our vlan.VID in the name.
+		 * Name will look like:	 vlan0005
+		 */
+	default:
+		snprintf(name, IFNAMSIZ, "rtvlan%.4i", vlan_id);
+	}
+
+	rtdev_reference(real_dev);
+
+	new_dev = rt_alloc_etherdev(sizeof(struct rtvlan_dev_priv), 0);
+	if (new_dev == NULL) {
+		err = -ENOBUFS;
+		goto err;
+	}
+	rtdev_alloc_name(new_dev, name);
+	rt_rtdev_connect(new_dev, &RTDEV_manager);
+	new_dev->vers = RTDEV_VERS_2_0;
+
+	new_dev->priv_flags |= IFF_802_1Q_VLAN;
+	new_dev->priv_flags &= ~(IFF_XMIT_DST_RELEASE | IFF_TX_SKB_SHARING);
+
+	memset(new_dev->broadcast, 0, ETH_ALEN);
+
+	/* need 4 bytes for extra VLAN header info,
+	 * hope the underlying device can handle it.
+	 */
+	new_dev->mtu = real_dev->mtu;
+	new_dev->priv_flags |= (real_dev->priv_flags & IFF_UNICAST_FLT);
+
+	vlan = rtvlan_dev_priv(new_dev);
+	vlan->vlan_proto = htons(ETH_P_8021Q);
+	vlan->vlan_id = vlan_id;
+	vlan->real_dev = real_dev;
+	vlan->flags = VLAN_FLAG_REORDER_HDR;
+
+	err = vlan_dev_init(new_dev);
+	if (err < 0)
+		goto out_free_newdev;
+
+	err = rtvlan_vid_add(new_dev);
+	if (err < 0)
+		goto out_free_newdev;
+
+	err = rt_register_rtnetdev(new_dev);
+	if (err > 0) {
+		err = -err;
+		goto out_free_newdev;
+	}
+
+	return 0;
+
+out_free_newdev:
+	rt_rtdev_disconnect(new_dev);
+	rtdev_free(new_dev);
+  err:
+	rtdev_dereference(real_dev);
+	return err;
+}
+
+/*
+ *	VLAN IOCTL handler.
+ *	o execute requested action or pass command to the device driver
+ *   arg is really a struct vlan_ioctl_args __user *.
+ */
+int rtvlan_ioctl_handler(void __user *arg)
+{
+	int err;
+	struct vlan_ioctl_args args;
+	struct rtnet_device *dev = NULL;
+
+	if (copy_from_user(&args, arg, sizeof(args)))
+		return -EFAULT;
+
+	/* Null terminate this sucker, just in case. */
+	args.device1[23] = 0;
+	args.u.device2[23] = 0;
+
+	switch (args.cmd) {
+	case SET_VLAN_INGRESS_PRIORITY_CMD:
+	case SET_VLAN_EGRESS_PRIORITY_CMD:
+	case SET_VLAN_FLAG_CMD:
+	case ADD_VLAN_CMD:
+	case DEL_VLAN_CMD:
+	case GET_VLAN_REALDEV_NAME_CMD:
+	case GET_VLAN_VID_CMD:
+		err = -ENODEV;
+		dev = rtdev_get_by_name(args.device1);
+		if (!dev)
+			goto out;
+
+		err = -EINVAL;
+		if (args.cmd != ADD_VLAN_CMD && !is_rtvlan_dev(dev))
+			goto out;
+	}
+
+	switch (args.cmd) {
+	case SET_VLAN_INGRESS_PRIORITY_CMD:
+		err = -EPERM;
+		vlan_dev_set_ingress_priority(dev,
+					      args.u.skb_priority,
+					      args.vlan_qos);
+		err = 0;
+		break;
+
+	case SET_VLAN_EGRESS_PRIORITY_CMD:
+		err = -EPERM;
+		err = vlan_dev_set_egress_priority(dev,
+						   args.u.skb_priority,
+						   args.vlan_qos);
+		break;
+
+	case SET_VLAN_FLAG_CMD:
+		err = -EPERM;
+		err = vlan_dev_change_flags(dev,
+					    args.vlan_qos ? args.u.flag : 0,
+					    args.u.flag);
+		break;
+
+	case SET_VLAN_NAME_TYPE_CMD:
+		err = -EPERM;
+		if ((args.u.name_type >= 0) &&
+		    (args.u.name_type < VLAN_NAME_TYPE_HIGHEST)) {
+			rtvlan_name_type = args.u.name_type;
+			err = 0;
+		} else {
+			err = -EINVAL;
+		}
+		break;
+
+	case ADD_VLAN_CMD:
+		err = -EPERM;
+		err = register_vlan_device(dev, args.u.VID);
+		break;
+
+	case DEL_VLAN_CMD:
+		err = -EPERM;
+		rtdev_dereference(dev); /*
+					 * Must dereference before unregistering
+					 * in order to avoid infinite loop in
+					 * rt_unregister_rtnetdev
+					 */
+		unregister_vlan_dev(dev);
+		return 0;
+
+	case GET_VLAN_REALDEV_NAME_CMD:
+		err = 0;
+		vlan_dev_get_realdev_name(dev, args.u.device2);
+		if (copy_to_user(arg, &args,
+				 sizeof(struct vlan_ioctl_args)))
+			err = -EFAULT;
+		break;
+
+	case GET_VLAN_VID_CMD:
+		err = 0;
+		args.u.VID = rtvlan_dev_vlan_id(dev);
+		if (copy_to_user(arg, &args,
+				 sizeof(struct vlan_ioctl_args)))
+		      err = -EFAULT;
+		break;
+
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+out:
+	if (dev)
+		rtdev_dereference(dev);
+
+	return err;
+}
+
+int rtvlan_proto_rx(struct rtskb *skb, struct rtpacket_type *pt)
+{
+	struct vlan_ethhdr *veth = (struct vlan_ethhdr *)skb->mac.raw;
+	struct rtvlan_pcpu_stats *rx_stats;
+	struct rtnet_device *vlan_dev;
+	struct rtvlan_dev_priv *vlan;
+	u16 vlan_tci;
+
+	vlan_tci = ntohs(veth->h_vlan_TCI);
+	vlan_dev = rtvlan_find_dev(skb->rtdev, vlan_tci & VLAN_VID_MASK);
+	if (!vlan_dev) {
+		kfree_rtskb(skb);
+		rtdev_dereference(skb->rtdev);
+		return 0;
+	}
+	vlan = rtvlan_dev_priv(vlan_dev);
+
+	skb->priority = vlan_get_ingress_priority(vlan_dev, vlan_tci);
+	skb->protocol = veth->h_vlan_encapsulated_proto;
+	skb->rtdev = vlan_dev;
+
+	if (skb->pkt_type == PACKET_OTHERHOST
+		&& ether_addr_equal(veth->h_dest, vlan_dev->dev_addr))
+		skb->pkt_type = PACKET_HOST;
+
+	if (vlan->flags & VLAN_FLAG_REORDER_HDR) {
+		memmove(skb->mac.raw + VLAN_HLEN, skb->mac.raw, 2 * ETH_ALEN);
+#ifdef CONFIG_XENO_DRIVERS_NET_ADDON_RTCAP
+		skb->cap_start += VLAN_HLEN;
+		skb->cap_len -= VLAN_HLEN;
+#endif
+	}
+	rtskb_pull(skb, VLAN_HLEN);
+
+	rx_stats = this_cpu_ptr(rtvlan_dev_priv(vlan_dev)->vlan_pcpu_stats);
+
+	raw_write_seqcount_begin(&rx_stats->syncp);
+	rx_stats->rx_packets++;
+	rx_stats->rx_bytes += skb->len;
+	if (skb->pkt_type == PACKET_MULTICAST)
+		rx_stats->rx_multicast++;
+	raw_write_seqcount_end(&rx_stats->syncp);
+
+	rt_stack_deliver(skb);
+	return 0;
+}
+
+struct rtpacket_type rtvlan_packet_type = {
+	.type = __constant_htons(ETH_P_8021Q),
+	.handler = rtvlan_proto_rx,
+};
+
+void rtvlan_proto_init(void)
+{
+	rtdev_add_pack(&rtvlan_packet_type);
+}
+
+void rtvlan_proto_release(void)
+{
+	rtdev_remove_pack(&rtvlan_packet_type);
+}
-- 
2.17.1


