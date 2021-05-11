From: =?UTF-8?q?Jean-Baptiste=20Tr=C3=A9dez?=
 <jean-baptiste.tredez@alstefgroup.com>
Subject: [PATCH 03/31] net/stack: add multicast support
Date: Tue, 11 May 2021 18:05:07 +0200
Message-Id: <20210511160535.26580-4-jean-baptiste.tredez@alstefgroup.com>
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
 kernel/drivers/net/stack/include/ipv4/arp.h   |   3 +
 kernel/drivers/net/stack/include/ipv4/igmp.h  | 102 +++
 .../drivers/net/stack/include/ipv4/protocol.h |   1 +
 kernel/drivers/net/stack/include/rtdev.h      |  17 +
 .../drivers/net/stack/include/rtnet_socket.h  |   4 +
 kernel/drivers/net/stack/include/rtskb.h      |   1 +
 kernel/drivers/net/stack/ipv4/Kconfig         |   7 +
 kernel/drivers/net/stack/ipv4/Makefile        |   1 +
 kernel/drivers/net/stack/ipv4/af_inet.c       |   5 +
 kernel/drivers/net/stack/ipv4/arp.c           |  26 +
 kernel/drivers/net/stack/ipv4/igmp.c          | 616 ++++++++++++++++++
 kernel/drivers/net/stack/ipv4/ip_output.c     |  13 +-
 kernel/drivers/net/stack/ipv4/ip_sock.c       |  70 +-
 kernel/drivers/net/stack/ipv4/protocol.c      |  17 +
 kernel/drivers/net/stack/ipv4/tcp/tcp.c       |   2 +-
 kernel/drivers/net/stack/ipv4/udp/udp.c       |  41 +-
 kernel/drivers/net/stack/rtdev.c              | 202 ++++++
 17 files changed, 1117 insertions(+), 11 deletions(-)
 create mode 100644 kernel/drivers/net/stack/include/ipv4/igmp.h
 create mode 100644 kernel/drivers/net/stack/ipv4/igmp.c

diff --git a/kernel/drivers/net/stack/include/ipv4/arp.h b/kernel/drivers/net/stack/include/ipv4/arp.h
index cf037a18b..ee67478c2 100644
--- a/kernel/drivers/net/stack/include/ipv4/arp.h
+++ b/kernel/drivers/net/stack/include/ipv4/arp.h
@@ -48,4 +48,7 @@ static inline void rt_arp_solicit(struct rtnet_device *rtdev, u32 target)
 void __init rt_arp_init(void);
 void rt_arp_release(void);
 
+int rt_arp_mc_map(u32 addr, u8 *haddr,
+		  struct rtnet_device *dev, int dir);
+
 #endif /* __RTNET_ARP_H_ */
diff --git a/kernel/drivers/net/stack/include/ipv4/igmp.h b/kernel/drivers/net/stack/include/ipv4/igmp.h
new file mode 100644
index 000000000..a44e09041
--- /dev/null
+++ b/kernel/drivers/net/stack/include/ipv4/igmp.h
@@ -0,0 +1,102 @@
+/*
+ *  include/ipv4/igmp.h - Internet Group Management Protocol  [IGMP]
+ *
+ *      Adapted from linux/igmp.h to RTnet by:
+ *              Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
+ *	Original author:
+ *		Alan Cox <Alan.Cox@linux.org>
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+
+#ifndef __RTNET_IGMP_H_
+#define __RTNET_IGMP_H_
+#include <asm/byteorder.h>
+#include <linux/init.h>
+#include <linux/kconfig.h>
+#include <linux/in.h>
+#include <rtnet_socket.h>
+
+struct igmphdr {
+	__u8 type;
+	__u8 code;		/* For newer IGMP */
+	__u16 csum;
+	__u32 group;
+};
+
+#define IGMP_HOST_MEMBERSHIP_QUERY	0x11	/* From RFC1112 */
+#define IGMP_HOST_MEMBERSHIP_REPORT	0x12	/* Ditto */
+#define IGMP_DVMRP			0x13	/* DVMRP routing */
+#define IGMP_PIM			0x14	/* PIM routing */
+#define IGMP_TRACE			0x15
+#define IGMP_HOST_NEW_MEMBERSHIP_REPORT 0x16	/* New version of 0x11 */
+#define IGMP_HOST_LEAVE_MESSAGE 	0x17
+
+#define IGMP_MTRACE_RESP		0x1e
+#define IGMP_MTRACE			0x1f
+
+#define IGMP_DELAYING_MEMBER		0x01
+#define IGMP_IDLE_MEMBER		0x02
+#define IGMP_LAZY_MEMBER		0x03
+#define IGMP_SLEEPING_MEMBER		0x04
+#define IGMP_AWAKENING_MEMBER		0x05
+
+#define IGMP_MINLEN			8
+
+#define IGMP_MAX_HOST_REPORT_DELAY	10	/* max delay for response to */
+						/* query (in seconds)   */
+
+#define IGMP_TIMER_SCALE		10	/* denotes that the igmphdr->timer field */
+						/* specifies time in 10th of seconds     */
+
+#define IGMP_AGE_THRESHOLD		400	/* If this host don't hear any IGMP V1  */
+						/* message in this period of time,      */
+						/* revert to IGMP v2 router.            */
+
+#define IGMP_ALL_HOSTS		htonl(0xE0000001L)
+#define IGMP_ALL_ROUTER 	htonl(0xE0000002L)
+#define IGMP_LOCAL_GROUP	htonl(0xE0000000L)
+#define IGMP_LOCAL_GROUP_MASK	htonl(0xFFFFFF00L)
+
+enum rtip_mc_state {
+	RTIP_MC_NON_MEMBER,
+	RTIP_MC_DELAYING_MEMBER,
+	RTIP_MC_IDLE_MEMBER,
+};
+
+struct rtip_mc_socklist {
+	struct rtip_mc_socklist	*next;
+	struct ip_mreq		multi;
+};
+
+struct rtip_mc_list {
+	struct rtnet_device	*interface;
+	u32			multiaddr;
+	struct rtip_mc_list	*next;
+	int			users;
+	enum rtip_mc_state	state;
+};
+
+static inline bool rtnet_in_multicast(u32 addr)
+{
+	return IS_ENABLED(CONFIG_XENO_DRIVERS_NET_RTIPV4_IGMP) &&
+		IN_MULTICAST(addr);
+}
+
+#ifdef CONFIG_XENO_DRIVERS_NET_RTIPV4_IGMP
+int rt_ip_mc_join_group(struct rtsocket *sk, struct ip_mreq *imr);
+int rt_ip_mc_leave_group(struct rtsocket *sk, struct ip_mreq *imr);
+void rt_ip_mc_drop_socket(struct rtsocket *sk);
+void rt_ip_mc_dec_group(struct rtnet_device *rtdev, u32 addr);
+void rt_ip_mc_inc_group(struct rtnet_device *rtdev, u32 addr);
+void rt_igmp_init(void);
+void rt_igmp_release(void);
+#else
+static inline void rt_igmp_init(void) { }
+static inline void rt_igmp_release(void) { }
+#endif
+
+#endif /* __RTNET_IGMP_H_ */
diff --git a/kernel/drivers/net/stack/include/ipv4/protocol.h b/kernel/drivers/net/stack/include/ipv4/protocol.h
index 1df42db67..dc31fb2cc 100644
--- a/kernel/drivers/net/stack/include/ipv4/protocol.h
+++ b/kernel/drivers/net/stack/include/ipv4/protocol.h
@@ -50,5 +50,6 @@ extern struct rtinet_protocol *rt_inet_protocols[];
 extern void rt_inet_add_protocol(struct rtinet_protocol *prot);
 extern void rt_inet_del_protocol(struct rtinet_protocol *prot);
 extern int rt_inet_socket(struct rtdm_fd *fd, int protocol);
+extern int rt_inet_socket_cleanup(struct rtdm_fd *fd);
 
 #endif /* __RTNET_PROTOCOL_H_ */
diff --git a/kernel/drivers/net/stack/include/rtdev.h b/kernel/drivers/net/stack/include/rtdev.h
index 3a9f6f8ee..e5a6bf920 100644
--- a/kernel/drivers/net/stack/include/rtdev.h
+++ b/kernel/drivers/net/stack/include/rtdev.h
@@ -64,6 +64,14 @@ enum rtnet_link_state {
 #define RTNET_LINK_STATE_PRESENT (1 << __RTNET_LINK_STATE_PRESENT)
 #define RTNET_LINK_STATE_NOCARRIER (1 << __RTNET_LINK_STATE_NOCARRIER)
 
+struct rtdev_mc_list {
+    struct rtdev_mc_list    *next;
+    __u8                    dmi_addr[MAX_ADDR_LEN];
+    unsigned char           dmi_addrlen;
+    int                     dmi_users;
+    int                     dmi_gusers;
+};
+
 /***
  *  rtnet_device
  */
@@ -114,6 +122,8 @@ struct rtnet_device {
 
 	int promiscuity;
 	int allmulti;
+	struct rtdev_mc_list *mc_list;
+	int mc_count;
 
 	__u32 local_ip; /* IP address in network order  */
 	__u32 broadcast_ip; /* broadcast IP in network order */
@@ -142,6 +152,7 @@ struct rtnet_device {
 	int (*rebuild_header)(struct rtskb *);
 	int (*hard_start_xmit)(struct rtskb *skb, struct rtnet_device *dev);
 	int (*hw_reset)(struct rtnet_device *rtdev);
+	void (*set_multicast_list) (struct rtnet_device *rtdev);
 
 	/* Transmission hook, managed by the stack core, RTcap, and RTmac
      *
@@ -244,6 +255,12 @@ void rtdev_unmap_rtskb(struct rtskb *skb);
 
 struct rtskb *rtnetdev_alloc_rtskb(struct rtnet_device *dev, unsigned int size);
 
+struct rtnet_device *rt_ip_dev_find(u32 addr);
+void rt_dev_mc_upload(struct rtnet_device *dev);
+int rt_dev_mc_delete(struct rtnet_device *dev, void *addr, int alen, int all);
+int rt_dev_mc_add(struct rtnet_device *dev, void *addr, int alen, int newonly);
+void rt_dev_set_allmulti(struct rtnet_device *dev, int inc);
+
 #define rtnetdev_priv(dev) ((dev)->priv)
 
 #define rtdev_emerg(__dev, format, args...)                                    \
diff --git a/kernel/drivers/net/stack/include/rtnet_socket.h b/kernel/drivers/net/stack/include/rtnet_socket.h
index d2caab649..af972c1a5 100644
--- a/kernel/drivers/net/stack/include/rtnet_socket.h
+++ b/kernel/drivers/net/stack/include/rtnet_socket.h
@@ -35,6 +35,8 @@
 #include <rtdm/driver.h>
 #include <stack_mgr.h>
 
+struct rtip_mc_socklist;
+
 struct rtsocket {
 	unsigned short protocol;
 
@@ -67,6 +69,8 @@ struct rtsocket {
 			int reg_index; /* index in port registry */
 			u8 tos;
 			u8 state;
+			struct rtip_mc_socklist *mc_list;
+			u32 mc_if_addr;
 		} inet;
 
 		/* packet socket specific */
diff --git a/kernel/drivers/net/stack/include/rtskb.h b/kernel/drivers/net/stack/include/rtskb.h
index 522b66715..4277fa6c6 100644
--- a/kernel/drivers/net/stack/include/rtskb.h
+++ b/kernel/drivers/net/stack/include/rtskb.h
@@ -177,6 +177,7 @@ struct rtskb {
 		struct icmphdr *icmph;
 		struct iphdr *ipihdr;
 		unsigned char *raw;
+		struct igmphdr *igmph;
 	} h;
 
 	/* network layer */
diff --git a/kernel/drivers/net/stack/ipv4/Kconfig b/kernel/drivers/net/stack/ipv4/Kconfig
index d5a6cd6d7..efe807915 100644
--- a/kernel/drivers/net/stack/ipv4/Kconfig
+++ b/kernel/drivers/net/stack/ipv4/Kconfig
@@ -62,6 +62,13 @@ config XENO_DRIVERS_NET_RTIPV4_ROUTER
 
     See Documentation/README.routing for further information.
 
+config XENO_DRIVERS_NET_RTIPV4_IGMP
+    bool "IGMP/multicast support"
+    depends on XENO_DRIVERS_NET_RTIPV4
+    default n
+    ---help---
+    Enables IGMP support of the RTnet Real-Time IPv4 protocol (multicast).
+
 config XENO_DRIVERS_NET_RTIPV4_DEBUG
     bool "RTipv4 Debugging"
     depends on XENO_DRIVERS_NET_RTIPV4
diff --git a/kernel/drivers/net/stack/ipv4/Makefile b/kernel/drivers/net/stack/ipv4/Makefile
index afdbeafce..d3a8b0c2d 100644
--- a/kernel/drivers/net/stack/ipv4/Makefile
+++ b/kernel/drivers/net/stack/ipv4/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_XENO_DRIVERS_NET_RTIPV4_UDP) += udp/
 obj-$(CONFIG_XENO_DRIVERS_NET_RTIPV4_TCP) += tcp/
 
 rtipv4-$(CONFIG_XENO_DRIVERS_NET_RTIPV4_ICMP) += icmp.o
+rtipv4-$(CONFIG_XENO_DRIVERS_NET_RTIPV4_IGMP) += igmp.o
diff --git a/kernel/drivers/net/stack/ipv4/af_inet.c b/kernel/drivers/net/stack/ipv4/af_inet.c
index 8bc87d90b..0081e0894 100644
--- a/kernel/drivers/net/stack/ipv4/af_inet.c
+++ b/kernel/drivers/net/stack/ipv4/af_inet.c
@@ -34,6 +34,7 @@
 #include <ipv4/ip_output.h>
 #include <ipv4/protocol.h>
 #include <ipv4/route.h>
+#include <ipv4/igmp.h>
 
 MODULE_LICENSE("GPL");
 
@@ -283,6 +284,7 @@ static int __init rt_ipv4_proto_init(void)
 		rt_inet_protocols[i] = NULL;
 
 	rt_icmp_init();
+	rt_igmp_init();
 
 #ifdef CONFIG_XENO_OPT_VFILE
 	result = xnvfile_init_dir("ipv4", &ipv4_proc_root, &rtnet_proc_root);
@@ -308,6 +310,7 @@ err2:
 err1:
 #endif /* CONFIG_XENO_OPT_VFILE */
 
+	rt_igmp_release();
 	rt_icmp_release();
 	rt_arp_release();
 	rt_ip_release();
@@ -327,6 +330,8 @@ static void __exit rt_ipv4_proto_release(void)
 	xnvfile_destroy_dir(&ipv4_proc_root);
 #endif
 
+	rt_igmp_release();
+
 	/* Transport-Layer */
 	rt_icmp_release();
 
diff --git a/kernel/drivers/net/stack/ipv4/arp.c b/kernel/drivers/net/stack/ipv4/arp.c
index 91c151e90..35c6c8f7e 100644
--- a/kernel/drivers/net/stack/ipv4/arp.c
+++ b/kernel/drivers/net/stack/ipv4/arp.c
@@ -21,6 +21,8 @@
  *
  */
 
+#include <net/ip.h>
+#include <linux/if_arp.h>
 #include <rtdev.h>
 #include <stack_mgr.h>
 #include <ipv4/arp.h>
@@ -195,6 +197,30 @@ static struct rtpacket_type arp_packet_type = {
 	handler: &rt_arp_rcv
 };
 
+/* Multicast mapping */
+
+#ifdef CONFIG_XENO_DRIVERS_NET_RTIPV4_IGMP
+
+int rt_arp_mc_map(u32 addr, u8 *haddr, struct rtnet_device *dev, int dir)
+{
+    switch (dev->type) {
+    case ARPHRD_ETHER:
+    case ARPHRD_FDDI:
+    case ARPHRD_IEEE802:
+        ip_eth_mc_map(addr, haddr);
+        return 0;
+    default:
+        if (dir) {
+            memcpy(haddr, dev->broadcast, dev->addr_len);
+            return 0;
+        }
+    }
+    return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(rt_arp_mc_map);
+
+#endif
+
 /***
  *  rt_arp_init
  */
diff --git a/kernel/drivers/net/stack/ipv4/igmp.c b/kernel/drivers/net/stack/ipv4/igmp.c
new file mode 100644
index 000000000..3da21df5b
--- /dev/null
+++ b/kernel/drivers/net/stack/ipv4/igmp.c
@@ -0,0 +1,616 @@
+/*
+ *      ipv4/igmp.c - Internet Group Management Protocol  [IGMP]
+ *
+ *      Adapted from net/ipv4/igmp.c to RTnet by:
+ *              Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
+ *	Original author:
+ *		Alan Cox <Alan.Cox@linux.org>
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ *
+ *	Fixes:
+ *
+ *		Alan Cox	:	Added lots of __inline__ to optimise
+ *					the memory usage of all the tiny little
+ *					functions.
+ *		Alan Cox	:	Dumped the header building experiment.
+ *		Alan Cox	:	Minor tweaks ready for multicast routing
+ *					and extended IGMP protocol.
+ *		Alan Cox	:	Removed a load of inline directives. Gcc 2.5.8
+ *					writes utterly bogus code otherwise (sigh)
+ *					fixed IGMP loopback to behave in the manner
+ *					desired by mrouted, fixed the fact it has been
+ *					broken since 1.3.6 and cleaned up a few minor
+ *					points.
+ *
+ *		Chih-Jen Chang	:	Tried to revise IGMP to Version 2
+ *		Tsu-Sheng Tsao		E-mail: chihjenc@scf.usc.edu and tsusheng@scf.usc.edu
+ *					The enhancements are mainly based on Steve Deering's
+ *					ipmulti-3.5 source code.
+ *		Chih-Jen Chang	:	Added the igmp_get_mrouter_info and
+ *		Tsu-Sheng Tsao		igmp_set_mrouter_info to keep track of
+ *					the mrouted version on that device.
+ *		Chih-Jen Chang	:	Added the max_resp_time parameter to
+ *		Tsu-Sheng Tsao		igmp_heard_query(). Using this parameter
+ *					to identify the multicast router version
+ *					and do what the IGMP version 2 specified.
+ *		Chih-Jen Chang	:	Added a timer to revert to IGMP V2 router
+ *		Tsu-Sheng Tsao		if the specified time expired.
+ *		Alan Cox	:	Stop IGMP from 0.0.0.0 being accepted.
+ *		Alan Cox	:	Use GFP_ATOMIC in the right places.
+ *		Christian Daudt :	igmp timer wasn't set for local group
+ *					memberships but was being deleted,
+ *					which caused a "del_timer() called
+ *					from %p with timer not initialized\n"
+ *					message (960131).
+ *		Christian Daudt :	removed del_timer from
+ *					igmp_timer_expire function (960205).
+ *             Christian Daudt :       igmp_heard_report now only calls
+ *                                     igmp_timer_expire if tm->running is
+ *                                     true (960216).
+ *		Malcolm Beattie :	ttl comparison wrong in igmp_rcv made
+ *					igmp_heard_query never trigger. Expiry
+ *					miscalculation fixed in igmp_heard_query
+ *					and random() made to return unsigned to
+ *					prevent negative expiry times.
+ *		Alexey Kuznetsov:	Wrong group leaving behaviour, backport
+ *					fix from pending 2.1.x patches.
+ *		Alan Cox:		Forget to enable FDDI support earlier.
+ *		Alexey Kuznetsov:	Fixed leaving groups on device down.
+ *		Alexey Kuznetsov:	Accordance to igmp-v2-06 draft.
+ */
+
+#include <ipv4/igmp.h>
+#include <net/checksum.h>
+#include <net/ip.h>
+#include <rtnet_socket.h>
+#include <rtdev.h>
+#include <ipv4/protocol.h>
+#include <ipv4/route.h>
+#include <ipv4/arp.h>
+
+#define IGMP_REPLY_POOL_SIZE  8
+#define IP_MAX_MEMBERSHIPS 20
+#define RT_IGMP_SKB_PRIO     RTSKB_PRIO_VALUE(QUEUE_MIN_PRIO-1,		\
+						RTSKB_DEF_NRT_CHANNEL)
+/***
+ *  It is not part of the socket pool. It may furthermore be used concurrently
+ *  by multiple tasks because all fields are static excect skb_pool, but that
+ *  is spin lock protected.
+ */
+static struct rtsocket igmp_socket;
+static struct rtip_mc_list *mc_list;
+static rtdm_lock_t  mc_list_lock;
+static rtdm_mutex_t mc_socklist_lock;
+rtdm_task_t rtnet_igmp_task;
+
+#define IGMP_SIZE (sizeof(struct igmphdr)+sizeof(struct iphdr)+4)
+
+static int rt_igmp_send_report(struct rtnet_device *rtdev, u32 group, int type)
+{
+	struct rtskb *skb;
+	struct iphdr *iph;
+	struct igmphdr *ih;
+	struct dest_route rt;
+	u32 dst;
+	int len;
+	int err;
+	char buf[MAX_ADDR_LEN];
+	/* According to IGMPv2 specs, LEAVE messages are
+	 * sent to all-routers group.
+	 */
+	dst = group;
+	if (type == IGMP_HOST_LEAVE_MESSAGE)
+		dst = IGMP_ALL_ROUTER;
+	if (rt_arp_mc_map(dst, buf, rtdev, 0) == 0) {
+		memcpy(rt.dev_addr, buf, sizeof(buf));
+		rt.rtdev = rtdev;
+		rt.ip = dst;
+	}
+
+	len = (rtdev->hard_header_len + 15) & ~15;
+	skb = alloc_rtskb(len + IGMP_SIZE + 15, &global_pool);
+	if (skb == NULL) {
+		printk("can't alloc rtskb \n");
+		return -ENOMEM;
+	}
+
+	skb->rtdev = rtdev;
+	skb->priority = RT_IGMP_SKB_PRIO;
+	rtskb_reserve(skb, len);
+	skb->nh.iph = iph = (struct iphdr *)rtskb_put(skb, sizeof(*iph) + 4);
+	iph->version = 4;
+	iph->ihl = (sizeof(struct iphdr) + 4) >> 2;
+	iph->tos = 0xc0;
+	iph->frag_off = htons(IP_DF);
+	iph->ttl = 1;
+	iph->daddr = rt.ip;
+	iph->saddr = rtdev->local_ip;
+	iph->protocol = IPPROTO_IGMP;
+	iph->tot_len = htons(IGMP_SIZE);
+	iph->id = htons(0);
+	((u8 *) & iph[1])[0] = IPOPT_RA;
+	((u8 *) & iph[1])[1] = 4;
+	((u8 *) & iph[1])[2] = 0;
+	((u8 *) & iph[1])[3] = 0;
+	ip_send_check(iph);
+	ih = (struct igmphdr *)rtskb_put(skb, sizeof(struct igmphdr));
+	ih->type = type;
+	ih->code = 0;
+	ih->csum = 0;
+	ih->group = group;
+	ih->csum = ip_compute_csum((void *)ih, sizeof(struct igmphdr));
+
+	if (rtdev->hard_header) {
+		err = rtdev->hard_header(skb, rtdev, ETH_P_IP, rt.dev_addr,
+					 rtdev->dev_addr, skb->len);
+		if (err < 0) {
+		    kfree_rtskb(skb);
+		    return err;
+		}
+	}
+
+	return rtdev_xmit(skb);
+}
+
+static void igmp_heard_query(struct rtnet_device *rtdev, u32 group)
+{
+    struct rtip_mc_list	*im;
+    unsigned long     flags;
+
+    rtdm_lock_get_irqsave(&mc_list_lock, flags);
+    for (im = mc_list; im != NULL; im = im->next)
+	if (im->multiaddr != IGMP_ALL_HOSTS
+	    && (!group || im->multiaddr == group))
+	    im->state = RTIP_MC_DELAYING_MEMBER;
+    rtdm_lock_put_irqrestore(&mc_list_lock, flags);
+}
+
+static void igmp_heard_report(struct rtnet_device *rtdev, u32 group)
+{
+    struct rtip_mc_list	*im;
+    unsigned long     flags;
+
+    rtdm_lock_get_irqsave(&mc_list_lock, flags);
+    for (im = mc_list; im != NULL; im = im->next)
+	if (im->multiaddr == group
+	    && im->state == RTIP_MC_DELAYING_MEMBER)
+	    im->state = RTIP_MC_IDLE_MEMBER;
+    rtdm_lock_put_irqrestore(&mc_list_lock, flags);
+}
+
+void rt_igmp_rcv(struct rtskb *skb)
+{
+	/* This basically follows the spec line by line -- see RFC1112 */
+	struct igmphdr *ih = skb->h.igmph;
+	struct rtnet_device *rtdev = skb->rtdev;
+	int len = skb->len;
+	if (len < sizeof(struct igmphdr) || ip_compute_csum((void *)ih, len))
+		goto cleanup;
+
+	switch (ih->type) {
+	case IGMP_HOST_MEMBERSHIP_QUERY:
+		igmp_heard_query(rtdev, ih->group);
+		break;
+	case IGMP_HOST_MEMBERSHIP_REPORT:
+	case IGMP_HOST_NEW_MEMBERSHIP_REPORT:
+		igmp_heard_report(rtdev, ih->group);
+		break;
+	case IGMP_PIM:
+	case IGMP_DVMRP:
+	case IGMP_TRACE:
+	case IGMP_HOST_LEAVE_MESSAGE:
+	case IGMP_MTRACE:
+	case IGMP_MTRACE_RESP:
+		break;
+	default:
+		rtdm_printk(KERN_DEBUG
+			    "New IGMP type=0x%x, why we do not know about it?\n",
+			    ih->type);
+	}
+
+cleanup:
+	kfree_rtskb(skb);
+}
+
+/*
+ *	Add a filter to a device
+ */
+static void rt_ip_mc_filter_add(struct rtnet_device *rtdev, u32 addr)
+{
+	char buf[MAX_ADDR_LEN];
+
+	/* Checking for IFF_MULTICAST here is WRONG-WRONG-WRONG.
+	   We will get multicast token leakage, when IFF_MULTICAST
+	   is changed. This check should be done in dev->set_multicast_list
+	   routine. Something sort of:
+	   if (dev->mc_list && dev->flags&IFF_MULTICAST) { do it; }
+	   --ANK
+	 */
+	if (rt_arp_mc_map(addr, buf, rtdev, 0) == 0)
+		rt_dev_mc_add(rtdev, buf, rtdev->addr_len, 0);
+}
+
+/*
+ *	Remove a filter from a device
+ */
+static void rt_ip_mc_filter_del(struct rtnet_device *rtdev, u32 addr)
+{
+	char buf[MAX_ADDR_LEN];
+	struct rtnet_device *dev = rtdev;
+
+	if (rt_arp_mc_map(addr, buf, dev, 0) == 0)
+		rt_dev_mc_delete(dev, buf, dev->addr_len, 0);
+}
+
+static void igmp_group_dropped(struct rtip_mc_list *im)
+{
+    unsigned long flags;
+    enum rtip_mc_state oldstate;
+
+    rtdm_lock_get_irqsave(&mc_list_lock, flags);
+    oldstate = im->state;
+    if (oldstate != RTIP_MC_NON_MEMBER)
+	im->state = RTIP_MC_NON_MEMBER;
+    rtdm_lock_put_irqrestore(&mc_list_lock, flags);
+
+    if (oldstate != RTIP_MC_NON_MEMBER)
+	rt_ip_mc_filter_del(im->interface, im->multiaddr);
+}
+
+static void igmp_group_added(struct rtip_mc_list *im)
+{
+    unsigned long flags;
+    enum rtip_mc_state oldstate;
+
+    rtdm_lock_get_irqsave(&mc_list_lock, flags);
+    oldstate = im->state;
+    if (oldstate == RTIP_MC_NON_MEMBER) {
+	if (im->multiaddr == IGMP_ALL_HOSTS)
+	    im->state = RTIP_MC_IDLE_MEMBER;
+	else
+	    im->state = RTIP_MC_DELAYING_MEMBER;
+    }
+    rtdm_lock_put_irqrestore(&mc_list_lock, flags);
+
+    if (oldstate != RTIP_MC_NON_MEMBER) {
+	return;
+    }
+
+    rt_ip_mc_filter_add(im->interface, im->multiaddr);
+
+    if (im->multiaddr != IGMP_ALL_HOSTS && rtdm_in_rt_context())
+	rt_igmp_send_report(im->interface,
+			    im->multiaddr, IGMP_HOST_MEMBERSHIP_REPORT);
+}
+
+void rt_ip_mc_inc_group(struct rtnet_device *rtdev, u32 addr)
+{
+    struct rtip_mc_list *im, *iml;
+    unsigned long flags;
+
+    iml = rtdm_malloc(sizeof(*im));
+    if (!iml)
+	return;
+    iml->users = 1;
+    iml->interface = rtdev;
+    iml->multiaddr = addr;
+    iml->state = RTIP_MC_NON_MEMBER;
+
+    rtdm_lock_get_irqsave(&mc_list_lock, flags);
+    for (im = mc_list; im; im = im->next) {
+	if (im->multiaddr == addr && im->interface == rtdev) {
+	    im->users++;
+	    rtdm_lock_put_irqrestore(&mc_list_lock, flags);
+	    rtdm_free(iml);
+	    return;
+	}
+    }
+    iml->next = mc_list;
+    mc_list = iml;
+    rtdm_lock_put_irqrestore(&mc_list_lock, flags);
+
+    igmp_group_added(iml);
+}
+
+/*
+ *	A socket has left a multicast group on device dev
+ */
+void rt_ip_mc_dec_group(struct rtnet_device *rtdev, u32 addr)
+{
+    struct rtip_mc_list *i, **ip;
+    unsigned long	flags;
+    rtdm_lock_get_irqsave(&mc_list_lock, flags);
+    for (ip = &mc_list; (i = *ip) != NULL; ip = &i->next) {
+	if (i->multiaddr == addr && i->interface == rtdev) {
+	    if (--i->users == 0) {
+		*ip = i->next;
+		rtdm_lock_put_irqrestore(&mc_list_lock, flags);
+		igmp_group_dropped(i);
+		rtdm_free(i);
+		return;
+	    }
+	    break;
+	}
+    }
+    rtdm_lock_put_irqrestore(&mc_list_lock, flags);
+}
+
+static struct rtnet_device *rt_ip_mc_find_dev(struct ip_mreq *imr)
+{
+    struct rtnet_device *rtdev = NULL;
+
+    if (imr->imr_interface.s_addr)
+	rtdev = rt_ip_dev_find(imr->imr_interface.s_addr);
+
+    return rtdev;
+}
+
+/*
+ *	Join a socket to a group
+ */
+
+int rt_ip_mc_join_group(struct rtsocket *sk, struct ip_mreq *imr)
+{
+    int err = 0;
+    u32 addr = imr->imr_multiaddr.s_addr;
+    struct rtnet_device *rtdev = rt_ip_mc_find_dev(imr);
+    struct rtip_mc_socklist *i, *iml;
+
+    if (!rtdev)
+	return -ENODEV;
+
+    if (!IN_MULTICAST(ntohl(addr))) {
+	err = -EINVAL;
+	goto done;
+    }
+
+    iml = rtdm_malloc(sizeof(*iml));
+    if (!iml) {
+	err = -ENOMEM;
+	goto done;
+    }
+    iml->multi = *imr;
+
+    rtdm_mutex_lock(&mc_socklist_lock);
+    for (i = sk->prot.inet.mc_list; i; i = i->next)
+	    if (i->multi.imr_multiaddr.s_addr == addr &&
+		i->multi.imr_interface.s_addr == imr->imr_interface.s_addr) {
+		rtdm_mutex_unlock(&mc_socklist_lock);
+		rtdm_free(iml);
+		err = 0;
+		goto done;
+	    }
+
+    iml->next = sk->prot.inet.mc_list;
+    sk->prot.inet.mc_list = iml;
+    rtdm_mutex_unlock(&mc_socklist_lock);
+
+    rt_ip_mc_inc_group(rtdev, addr);
+
+  done:
+    rtdev_dereference(rtdev);
+    return err;
+}
+
+/*
+ *	Ask a socket to leave a group.
+ */
+int rt_ip_mc_leave_group(struct rtsocket *sk, struct ip_mreq *imr)
+{
+    u32 addr = imr->imr_multiaddr.s_addr;
+    struct  rtnet_device *rtdev = rt_ip_mc_find_dev(imr);
+    struct rtip_mc_socklist *i, **ip;
+
+    if (!rtdev)
+	return -ENODEV;
+
+    rtdm_mutex_lock(&mc_socklist_lock);
+    for (ip = &sk->prot.inet.mc_list; (i = *ip); ip = &i->next)
+	    if (i->multi.imr_multiaddr.s_addr == addr &&
+		i->multi.imr_interface.s_addr == imr->imr_interface.s_addr) {
+		*ip = i->next;
+		rtdm_mutex_unlock(&mc_socklist_lock);
+		goto found;
+	    }
+    rtdm_mutex_unlock(&mc_socklist_lock);
+
+    rtdev_dereference(rtdev);
+
+    return -EADDRNOTAVAIL;
+
+  found:
+    rt_igmp_send_report(rtdev, addr, IGMP_HOST_LEAVE_MESSAGE);
+    rt_ip_mc_dec_group(rtdev, addr);
+    rtdev_dereference(rtdev);
+
+    rtdm_free(i);
+
+    return 0;
+}
+
+/*
+ *	A socket is closing.
+ */
+void rt_ip_mc_drop_socket(struct rtsocket *sk)
+{
+    struct rtip_mc_socklist *i, *in;
+
+    if (sk->prot.inet.mc_list == NULL)
+	return;
+
+    for (i = sk->prot.inet.mc_list; i; i = in) {
+	struct rtnet_device *rtdev;
+
+	in = i->next;
+	rtdev = rt_ip_mc_find_dev(&i->multi);
+	if (!rtdev)
+	    continue;
+
+	rt_ip_mc_dec_group(rtdev, i->multi.imr_multiaddr.s_addr);
+	rtdev_dereference(rtdev);
+    }
+}
+
+static void process(void *arg)
+{
+    struct rtip_mc_list *im;
+    unsigned long flags;
+
+    while(!rtdm_task_should_stop()){
+	rtdm_lock_get_irqsave(&mc_list_lock, flags);
+	for (im = mc_list; im; im = im->next) {
+	    if (im->state == RTIP_MC_DELAYING_MEMBER) {
+		im->state = RTIP_MC_IDLE_MEMBER;
+		im->users++;
+		rtdev_reference(im->interface);
+		break;
+	    }
+	}
+	rtdm_lock_put_irqrestore(&mc_list_lock, flags);
+
+	if (im) {
+	    rt_igmp_send_report(im->interface,
+				im->multiaddr, IGMP_HOST_MEMBERSHIP_REPORT);
+	    rt_ip_mc_dec_group(im->interface, im->multiaddr);
+	    rtdev_dereference(im->interface);
+	}
+
+	rtdm_task_wait_period(NULL);
+    }
+}
+
+static int rt_igmp_socket(struct rtdm_fd *fd)
+{
+	/* we don't support user-created ICMP sockets */
+	return -ENOPROTOOPT;
+}
+
+static struct rtsocket *rt_igmp_dest_socket(struct rtskb *skb)
+{
+	/* Note that the socket's refcount is not used by this protocol.
+	 * The socket returned here is static and not part of the global pool. */
+	return &igmp_socket;
+}
+
+void rt_igmp_rcv_err(struct rtskb *skb)
+{
+	rtdm_printk("RTnet: rt_igmp_rcv err\n");
+}
+
+static struct rtinet_protocol igmp_protocol = {
+	.protocol = IPPROTO_IGMP,
+	.dest_socket = rt_igmp_dest_socket,
+	.rcv_handler = rt_igmp_rcv,
+	.err_handler = rt_igmp_rcv_err,
+	.init_socket = rt_igmp_socket
+};
+
+static void rt_ip_mc_unregister(struct rtnet_device *rtdev)
+{
+    struct rtip_mc_list *i, **ip;
+    unsigned long flags;
+
+    if (rtdev->flags & IFF_LOOPBACK)
+	return;
+
+  restart:
+    rtdm_lock_get_irqsave(&mc_list_lock, flags);
+    for (ip = &mc_list; (i = *ip) != NULL; ip = &i->next) {
+	if (i->interface != rtdev)
+	    continue;
+	*ip = i->next;
+	rtdm_lock_put_irqrestore(&mc_list_lock, flags);
+
+	igmp_group_dropped(i);
+	rtdm_free(i);
+	goto restart;
+    }
+    rtdm_lock_put_irqrestore(&mc_list_lock, flags);
+}
+
+static void rt_ip_mc_down(struct rtnet_device *rtdev)
+{
+    struct rtip_mc_list *i;
+    unsigned long flags;
+
+    if (rtdev->flags & IFF_LOOPBACK)
+	return;
+
+restart:
+    rtdm_lock_get_irqsave(&mc_list_lock, flags);
+    for (i = mc_list; i; i = i->next) {
+	if (i->interface != rtdev || i->state == RTIP_MC_NON_MEMBER)
+	    continue;
+	rtdm_lock_put_irqrestore(&mc_list_lock, flags);
+
+	igmp_group_dropped(i);
+	goto restart;
+    }
+    rtdm_lock_put_irqrestore(&mc_list_lock, flags);
+
+    rt_ip_mc_dec_group(rtdev, IGMP_ALL_HOSTS);
+}
+
+static void rt_ip_mc_up(struct rtnet_device *rtdev,
+			struct rtnet_core_cmd *up_cmd)
+{
+    struct rtip_mc_list *i;
+    unsigned long flags;
+
+    if (rtdev->flags & IFF_LOOPBACK)
+	return;
+
+    rt_ip_mc_inc_group(rtdev, IGMP_ALL_HOSTS);
+
+restart:
+    rtdm_lock_get_irqsave(&mc_list_lock, flags);
+    for (i = mc_list; i; i = i->next) {
+	if (i->interface != rtdev || i->state != RTIP_MC_NON_MEMBER)
+	    continue;
+	rtdm_lock_put_irqrestore(&mc_list_lock, flags);
+
+	igmp_group_added(i);
+	goto restart;
+    }
+    rtdm_lock_put_irqrestore(&mc_list_lock, flags);
+}
+
+static struct rtdev_event_hook rtdev_hook = {
+	.unregister_device = rt_ip_mc_unregister,
+	.ifup = rt_ip_mc_up,
+	.ifdown = rt_ip_mc_down,
+};
+
+void __init rt_igmp_init(void)
+{
+	unsigned int skbs;
+
+	igmp_socket.protocol = IPPROTO_IGMP;
+	igmp_socket.prot.inet.tos = 0;
+	igmp_socket.priority = 0;
+	rtdm_lock_init(&mc_list_lock);
+	rtdm_mutex_init(&mc_socklist_lock);
+	/* create the rtskb pool */
+	skbs = rtskb_pool_init(&igmp_socket.skb_pool, IGMP_REPLY_POOL_SIZE,
+			NULL, NULL);
+	if (skbs < IGMP_REPLY_POOL_SIZE)
+		printk("RTnet: allocated only %d igmp rtskbs\n", skbs);
+
+	rt_inet_add_protocol(&igmp_protocol);
+	rtdm_task_init(&rtnet_igmp_task, "igmp", process, 0,
+		       RTDM_TASK_LOWEST_PRIORITY, 10000000);
+	rtdev_add_event_hook(&rtdev_hook);
+}
+
+void rt_igmp_release(void)
+{
+	rtdev_del_event_hook(&rtdev_hook);
+	rtdm_task_destroy(&rtnet_igmp_task);
+	rt_inet_del_protocol(&igmp_protocol);
+	rtskb_pool_release(&igmp_socket.skb_pool);
+	rtdm_mutex_destroy(&mc_socklist_lock);
+}
diff --git a/kernel/drivers/net/stack/ipv4/ip_output.c b/kernel/drivers/net/stack/ipv4/ip_output.c
index 664d0c790..e1bba9213 100644
--- a/kernel/drivers/net/stack/ipv4/ip_output.c
+++ b/kernel/drivers/net/stack/ipv4/ip_output.c
@@ -30,10 +30,19 @@
 #include <ipv4/ip_fragment.h>
 #include <ipv4/ip_input.h>
 #include <ipv4/route.h>
+#include <ipv4/igmp.h>
 
 static DEFINE_RTDM_LOCK(rt_ip_id_lock);
 static u16 rt_ip_id_count = 0;
 
+static inline u8 get_ttl(struct dest_route *rt)
+{
+	if (rtnet_in_multicast(ntohl(rt->ip)))
+		return 1;
+
+	return 255;
+}
+
 /***
  *  Slow path for fragmented packets
  */
@@ -108,7 +117,7 @@ int rt_ip_build_xmit_slow(struct rtsocket *sk,
 		iph->tot_len = htons(fraglen);
 		iph->id = htons(msg_rt_ip_id);
 		iph->frag_off = htons(frag_off);
-		iph->ttl = 255;
+		iph->ttl = get_ttl(rt);
 		iph->protocol = sk->protocol;
 		iph->saddr = rtdev->local_ip;
 		iph->daddr = rt->ip;
@@ -210,7 +219,7 @@ int rt_ip_build_xmit(struct rtsocket *sk,
 	iph->tot_len = htons(length);
 	iph->id = htons(msg_rt_ip_id);
 	iph->frag_off = htons(IP_DF);
-	iph->ttl = 255;
+	iph->ttl = get_ttl(rt);
 	iph->protocol = sk->protocol;
 	iph->saddr = rtdev->local_ip;
 	iph->daddr = rt->ip;
diff --git a/kernel/drivers/net/stack/ipv4/ip_sock.c b/kernel/drivers/net/stack/ipv4/ip_sock.c
index 8ca6aebd1..0349ed1b1 100644
--- a/kernel/drivers/net/stack/ipv4/ip_sock.c
+++ b/kernel/drivers/net/stack/ipv4/ip_sock.c
@@ -27,9 +27,10 @@
 #include <linux/in.h>
 
 #include <rtnet_socket.h>
+#include <ipv4/igmp.h>
 
 int rt_ip_setsockopt(struct rtdm_fd *fd, struct rtsocket *s, int level,
-		     int optname, const void __user *optval, socklen_t optlen)
+		     int optname, const void __user *u_optval, socklen_t optlen)
 {
 	int err = 0;
 	unsigned int _tos, *tos;
@@ -37,18 +38,77 @@ int rt_ip_setsockopt(struct rtdm_fd *fd, struct rtsocket *s, int level,
 	if (level != SOL_IP)
 		return -ENOPROTOOPT;
 
-	if (optlen < sizeof(unsigned int))
-		return -EINVAL;
-
 	switch (optname) {
 	case IP_TOS:
-		tos = rtnet_get_arg(fd, &_tos, optval, sizeof(_tos));
+		if (optlen < sizeof(unsigned int))
+			return -EINVAL;
+		tos = rtnet_get_arg(fd, &_tos, u_optval, sizeof(_tos));
 		if (IS_ERR(tos))
 			return PTR_ERR(tos);
 		else
 			s->prot.inet.tos = *tos;
 		break;
 
+#ifdef CONFIG_XENO_DRIVERS_NET_RTIPV4_IGMP
+	case IP_ADD_MEMBERSHIP: {
+		const struct ip_mreq *mreq;
+		struct ip_mreq _mreq;
+
+		if (optlen < sizeof(*mreq))
+			return -EINVAL;
+
+		if (!rtdm_in_rt_context())
+			return -ENOSYS;
+
+		mreq = rtnet_get_arg(fd, &_mreq, u_optval, sizeof(_mreq));
+		if (IS_ERR(mreq))
+			return PTR_ERR(mreq);
+
+		err = rt_ip_mc_join_group(s, mreq);
+		break;
+	}
+
+	case IP_DROP_MEMBERSHIP: {
+		const struct ip_mreq *mreq;
+		struct ip_mreq _mreq;
+
+		if (optlen < sizeof(*mreq))
+			return -EINVAL;
+
+		if (!rtdm_in_rt_context())
+			return -ENOSYS;
+
+		mreq = rtnet_get_arg(fd, &_mreq, u_optval, sizeof(_mreq));
+		if (IS_ERR(mreq))
+			return PTR_ERR(mreq);
+
+		err = rt_ip_mc_leave_group(s, mreq);
+		break;
+	}
+
+	case IP_MULTICAST_IF: {
+		if (optlen < sizeof(struct in_addr))
+			return -EINVAL;
+
+		if (optlen >= sizeof(struct ip_mreq)) {
+			const struct ip_mreq *mreq;
+			struct ip_mreq _mreq;
+			mreq = rtnet_get_arg(fd, &_mreq, u_optval, sizeof(_mreq));
+			if (IS_ERR(mreq))
+				return PTR_ERR(mreq);
+			s->prot.inet.mc_if_addr = mreq->imr_interface.s_addr;
+		} else {
+			const struct in_addr *in_addr;
+			struct in_addr _in_addr;
+			in_addr = rtnet_get_arg(fd, &_in_addr, u_optval, sizeof(_in_addr));
+			if (IS_ERR(in_addr))
+				return PTR_ERR(in_addr);
+			s->prot.inet.mc_if_addr = in_addr->s_addr;
+		}
+
+		break;
+	}
+#endif
 	default:
 		err = -ENOPROTOOPT;
 		break;
diff --git a/kernel/drivers/net/stack/ipv4/protocol.c b/kernel/drivers/net/stack/ipv4/protocol.c
index f56177da8..6036d6d74 100644
--- a/kernel/drivers/net/stack/ipv4/protocol.c
+++ b/kernel/drivers/net/stack/ipv4/protocol.c
@@ -28,6 +28,7 @@
 
 #include <rtnet_socket.h>
 #include <ipv4/protocol.h>
+#include <ipv4/igmp.h>
 
 struct rtinet_protocol *rt_inet_protocols[MAX_RT_INET_PROTOCOLS];
 
@@ -62,6 +63,7 @@ EXPORT_SYMBOL_GPL(rt_inet_del_protocol);
  */
 int rt_inet_socket(struct rtdm_fd *fd, int protocol)
 {
+        struct rtsocket *sock = rtdm_fd_to_private(fd);
 	struct rtinet_protocol *prot;
 
 	if (protocol == 0)
@@ -74,6 +76,8 @@ int rt_inet_socket(struct rtdm_fd *fd, int protocol)
 			break;
 		}
 
+	sock->prot.inet.mc_list = NULL;
+	sock->prot.inet.mc_if_addr = INADDR_ANY;
 	prot = rt_inet_protocols[rt_inet_hashkey(protocol)];
 
 	/* create the socket (call the socket creator) */
@@ -86,3 +90,16 @@ int rt_inet_socket(struct rtdm_fd *fd, int protocol)
 	}
 }
 EXPORT_SYMBOL_GPL(rt_inet_socket);
+
+int rt_inet_socket_cleanup(struct rtdm_fd *fd)
+{
+#ifdef CONFIG_XENO_DRIVERS_NET_RTIPV4_IGMP
+    struct rtsocket *sock = rtdm_fd_to_private(fd);
+    rt_ip_mc_drop_socket(sock);
+#endif
+
+    rt_socket_cleanup(fd);
+
+    return 0;
+}
+EXPORT_SYMBOL(rt_inet_socket_cleanup);
diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
index 71628ba03..79c25271c 100644
--- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
+++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
@@ -1442,7 +1442,7 @@ static void rt_tcp_close(struct rtdm_fd *fd)
 
 	rt_tcp_socket_destruct(ts);
 
-	rt_socket_cleanup(fd);
+	rt_inet_socket_cleanup(fd);
 }
 
 /***
diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
index 6fe1aeb12..dcaec5618 100644
--- a/kernel/drivers/net/stack/ipv4/udp/udp.c
+++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
@@ -43,6 +43,8 @@
 #include <ipv4/protocol.h>
 #include <ipv4/route.h>
 #include <ipv4/udp.h>
+#include <ipv4/arp.h>
+#include <ipv4/igmp.h>
 
 /***
  *  This structure is used to register a UDP socket for reception. All
@@ -349,7 +351,7 @@ void rt_udp_close(struct rtdm_fd *fd)
 	while ((del = rtskb_dequeue(&sock->incoming)) != NULL)
 		kfree_rtskb(del);
 
-	rt_socket_cleanup(fd);
+	rt_inet_socket_cleanup(fd);
 }
 
 int rt_udp_ioctl(struct rtdm_fd *fd, unsigned int request, void __user *arg)
@@ -567,6 +569,36 @@ static int rt_udp_getfrag(const void *p, unsigned char *to, unsigned int offset,
 	return 0;
 }
 
+static int route_multicast(struct dest_route *rt,
+			   struct rtsocket *sock,
+			   u32 daddr, u32 *saddr)
+{
+	char buf[MAX_ADDR_LEN];
+
+	if (!rtnet_in_multicast(ntohl(daddr)))
+		return -ENOTSUPP;
+
+	if (sock->prot.inet.mc_if_addr != INADDR_ANY)
+	    *saddr = sock->prot.inet.mc_if_addr;
+	else if (*saddr == INADDR_ANY)
+		return -EHOSTUNREACH;
+
+	rt->rtdev = rt_ip_dev_find(*saddr);
+	if (rt->rtdev == NULL)
+		return -EHOSTUNREACH;
+
+	if (rt_arp_mc_map(daddr, buf, rt->rtdev, 0)) {
+		rtdev_dereference(rt->rtdev);
+		rtdm_printk("can't map multicast adress %08x \n", daddr);
+		return -EHOSTUNREACH;
+	}
+
+	memcpy(rt->dev_addr, buf, sizeof(buf));
+	rt->ip = daddr;
+
+	return 0;
+}
+
 /***
  *  rt_udp_sendmsg
  */
@@ -652,6 +684,8 @@ ssize_t rt_udp_sendmsg(struct rtdm_fd *fd, const struct user_msghdr *msg,
 	}
 
 	/* get output route */
+	err = route_multicast(&rt, sock, daddr, &saddr);
+	if (err == -ENOTSUPP)
 	err = rt_ip_route_output(&rt, daddr, saddr);
 	if (err)
 		goto out;
@@ -670,7 +704,8 @@ ssize_t rt_udp_sendmsg(struct rtdm_fd *fd, const struct user_msghdr *msg,
 	err = rt_ip_build_xmit(sock, rt_udp_getfrag, &ufh, ulen, &rt,
 			       msg_flags);
 
-	/* Drop the reference obtained in rt_ip_route_output() */
+	/* Drop the reference obtained in either rt_ip_route_output()
+	   or route_multicast() */
 	rtdev_dereference(rt.rtdev);
 out:
 	rtdm_drop_iovec(iov, iov_fast);
@@ -715,7 +750,7 @@ struct rtsocket *rt_udp_dest_socket(struct rtskb *skb)
 			csum_tcpudp_nofold(saddr, daddr, ulen, IPPROTO_UDP, 0);
 
 	/* patch broadcast daddr */
-	if (daddr == rtdev->broadcast_ip)
+	if (daddr == rtdev->broadcast_ip || rtnet_in_multicast(ntohl(daddr)))
 		daddr = rtdev->local_ip;
 
 	/* find the destination socket */
diff --git a/kernel/drivers/net/stack/rtdev.c b/kernel/drivers/net/stack/rtdev.c
index 13e979088..a78d5241f 100644
--- a/kernel/drivers/net/stack/rtdev.c
+++ b/kernel/drivers/net/stack/rtdev.c
@@ -913,6 +913,208 @@ int rtdev_xmit_proxy(struct rtskb *rtskb)
 }
 #endif /* CONFIG_XENO_DRIVERS_NET_ADDON_PROXY */
 
+#ifdef CONFIG_XENO_DRIVERS_NET_RTIPV4_IGMP
+
+/* Find rtnet device by its local_ip adress */
+static inline struct rtnet_device * __rt_ip_dev_find(u32 addr){
+    int i;
+    struct rtnet_device *rtdev;
+
+    for (i = 0; i < MAX_RT_DEVICES; i++) {
+        rtdev = rtnet_devices[i];
+        if ((rtdev != NULL) && (rtdev->local_ip == addr)) {
+            return rtdev;
+        }
+    }
+    return NULL;
+}
+
+/***
+ *  rtdev_get_by_hwaddr - find and lock a rtnetdevice by its local ip adress
+ *  @addr:         Local  IP Adress
+  */
+struct rtnet_device *rt_ip_dev_find(u32 addr)
+{
+    struct rtnet_device * rtdev;
+    unsigned long flags;
+
+
+    rtdm_lock_get_irqsave(&rtnet_devices_rt_lock, flags);
+    rtdev = __rt_ip_dev_find(addr);
+    if (rtdev != NULL)
+        atomic_inc(&rtdev->refcount);
+    rtdm_lock_put_irqrestore(&rtnet_devices_rt_lock, flags);
+
+    return rtdev;
+}
+EXPORT_SYMBOL(rt_ip_dev_find);
+
+/*
+ *  Update the multicast list into the physical NIC controller.
+ */
+static void __rt_dev_mc_upload(struct rtnet_device *dev)
+{
+    /* Don't do anything till we up the interface
+     * [dev_open will call this function so the list will
+     * stay sane]
+     */
+
+    if (!(dev->flags&IFF_UP))
+        return;
+
+    /*
+     *  Devices with no set multicast or which have been
+     *  detached don't get set.
+     */
+
+    if (dev->set_multicast_list == NULL){
+        printk(KERN_INFO "RTnet: %s does not support multicast\n",
+	       dev->name);
+        return;
+    }
+    dev->set_multicast_list(dev);
+}
+
+void rt_dev_mc_upload(struct rtnet_device *dev)
+{
+    unsigned long flags;
+    rtdm_lock_get_irqsave(&dev->rtdev_lock, flags);
+    __rt_dev_mc_upload(dev);
+    rtdm_lock_put_irqrestore(&dev->rtdev_lock, flags);
+}
+
+/*
+ *  Delete a device level multicast
+ */
+
+int rt_dev_mc_delete(struct rtnet_device *dev, void *addr, int alen, int glbl)
+{
+    int err = 0;
+    struct rtdev_mc_list *dmi, **dmip;
+    unsigned long flags;
+
+    rtdm_lock_get_irqsave(&dev->rtdev_lock, flags);
+
+    for (dmip = &dev->mc_list; (dmi = *dmip) != NULL; dmip = &dmi->next) {
+        /*
+         *  Find the entry we want to delete. The device could
+         *  have variable length entries so check these too.
+         */
+        if (memcmp(dmi->dmi_addr, addr, dmi->dmi_addrlen) == 0 &&
+            alen == dmi->dmi_addrlen) {
+            if (glbl) {
+                int old_glbl = dmi->dmi_gusers;
+                dmi->dmi_gusers = 0;
+                if (old_glbl == 0)
+                    break;
+            }
+            if (--dmi->dmi_users)
+                goto done;
+
+            /*
+             *  Last user. So delete the entry.
+             */
+            *dmip = dmi->next;
+            dev->mc_count--;
+
+            /*
+             *  We have altered the list, so the card
+             *  loaded filter is now wrong. Fix it
+             */
+            __rt_dev_mc_upload(dev);
+
+            rtdm_lock_put_irqrestore(&dev->rtdev_lock, flags);
+
+            rtdm_free(dmi);
+            return 0;
+        }
+    }
+    err = -ENOENT;
+done:
+    rtdm_lock_put_irqrestore(&dev->rtdev_lock, flags);
+    return err;
+}
+EXPORT_SYMBOL(rt_dev_mc_delete);
+
+/*
+ *  Add a device level multicast
+ */
+
+
+int rt_dev_mc_add(struct rtnet_device *dev, void *addr, int alen, int glbl)
+{
+    int err = 0;
+    struct rtdev_mc_list *dmi, *dmi1;
+    unsigned long flags;
+
+    dmi1 = rtdm_malloc(sizeof(*dmi1));
+
+    rtdm_lock_get_irqsave(&dev->rtdev_lock, flags);
+    for (dmi = dev->mc_list; dmi != NULL; dmi = dmi->next) {
+        if (memcmp(dmi->dmi_addr, addr, dmi->dmi_addrlen) == 0 &&
+            dmi->dmi_addrlen == alen) {
+            if (glbl) {
+                int old_glbl = dmi->dmi_gusers;
+                dmi->dmi_gusers = 1;
+                if (old_glbl)
+                    goto done;
+            }
+            dmi->dmi_users++;
+            goto done;
+        }
+    }
+
+    if ((dmi = dmi1) == NULL) {
+        rtdm_lock_put_irqrestore(&dev->rtdev_lock, flags);
+        return -ENOMEM;
+    }
+    memcpy(dmi->dmi_addr, addr, alen);
+    dmi->dmi_addrlen = alen;
+    dmi->next = dev->mc_list;
+    dmi->dmi_users = 1;
+    dmi->dmi_gusers = glbl ? 1 : 0;
+    dev->mc_list = dmi;
+    dev->mc_count++;
+
+    __rt_dev_mc_upload(dev);
+
+    rtdm_lock_put_irqrestore(&dev->rtdev_lock, flags);
+    return 0;
+
+done:
+    rtdm_lock_put_irqrestore(&dev->rtdev_lock, flags);
+    if (dmi1)
+        rtdm_free(dmi1);
+    return err;
+}
+EXPORT_SYMBOL(rt_dev_mc_add);
+
+/*
+ *  Discard multicast list when a device is downed
+ */
+
+void rt_dev_mc_discard(struct rtnet_device *dev)
+{
+    unsigned long flags;
+
+    rtdm_lock_get_irqsave(&dev->rtdev_lock, flags);
+
+    while (dev->mc_list != NULL) {
+        struct rtdev_mc_list *tmp = dev->mc_list;
+        dev->mc_list = tmp->next;
+        if (tmp->dmi_users > tmp->dmi_gusers)
+            printk("dev_mc_discard: multicast leakage! dmi_users=%d\n", tmp->dmi_users);
+        rtdm_lock_put_irqrestore(&dev->rtdev_lock, flags);
+        rtdm_free(tmp);
+        rtdm_lock_get_irqsave(&dev->rtdev_lock, flags);
+    }
+    dev->mc_count = 0;
+
+    rtdm_lock_put_irqrestore(&dev->rtdev_lock, flags);
+}
+
+#endif	/* CONFIG_XENO_DRIVERS_NET_RTIPV4_IGMP */
+
 unsigned int rt_hard_mtu(struct rtnet_device *rtdev, unsigned int priority)
 {
 	return rtdev->mtu;
-- 
2.17.1


