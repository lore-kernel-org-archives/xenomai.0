From: Richard Cochran <richardcochran@domain.hid>
Date: Fri, 23 Sep 2011 13:02:20 +0200
Message-Id: <6ffd7b28c7e392a53aabb0df8405339c9a69cc71.1316774468.git.richard.cochran@domain.hid>
In-Reply-To: <cover.1316774468.git.richard.cochran@domain.hid>
References: <cover.1316774468.git.richard.cochran@domain.hid>
In-Reply-To: <cover.1316774468.git.richard.cochran@domain.hid>
References: <cover.1316774468.git.richard.cochran@domain.hid>
Subject: [Xenomai-core] [RFC 1/1] Add a class driver for raw Ethernet
	packets.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This patch adds a class driver for sending and receiving raw Ethernet
packets over a character device interface.

Signed-off-by: Richard Cochran <richard.cochran@domain.hid>
---
 include/rtdm/rtpacket.h       |   99 ++++++++++++
 ksrc/drivers/testing/Kconfig  |    8 +
 ksrc/drivers/testing/Makefile |    3 +
 ksrc/drivers/testing/packet.c |  352 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 462 insertions(+), 0 deletions(-)
 create mode 100644 include/rtdm/rtpacket.h
 create mode 100644 ksrc/drivers/testing/packet.c

diff --git a/include/rtdm/rtpacket.h b/include/rtdm/rtpacket.h
new file mode 100644
index 0000000..87930de
--- /dev/null
+++ b/include/rtdm/rtpacket.h
@@ -0,0 +1,99 @@
+/*
+ * Xenomai Packet Interface - class driver for raw Ethernet packets
+ *
+ * Copyright (C) 2011 OMICRON electronics GmbH
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#ifndef _RTPACKET_H
+#define _RTPACKET_H
+
+#include <rtdm/rtdm.h>
+
+#define RTPACKET_MAX_FILTER	16
+
+struct rtpacket_filter {
+	__u16 ethertype[RTPACKET_MAX_FILTER];
+};
+
+#define RTPACKET_FILTER _IOW(RTDM_CLASS_TESTING, 0x80, struct rtpacket_filter)
+
+#ifdef __KERNEL__
+
+#include <linux/list.h>
+#include <rtdm/rtdm_driver.h>
+
+#define RTPACKET_TX_POOL_SIZE	128
+#define RTPACKET_BUFFER_SIZE	1536
+
+struct rtp_addr {
+	void *va;
+	dma_addr_t pa;
+};
+
+struct rtpacket {
+	struct list_head list;
+	struct rtp_addr base;
+	struct rtp_addr data;
+	int length;
+};
+
+struct rtpacket_pool {
+	struct list_head list;
+	rtdm_lock_t lock;
+	struct rtpacket *pkt;
+	unsigned int npkt;
+	unsigned int pktsize;
+	struct device *dev;
+};
+
+struct rtpacket_driver_ops {
+	struct module *owner;
+	char name[16];
+	int (*filter)(struct rtpacket_driver_ops *p, struct rtpacket_filter *f);
+	int (*transmit)(struct rtpacket_driver_ops *ops, struct rtpacket *rtp);
+	void (*recycle)(struct rtpacket_driver_ops *ops, struct rtpacket *rtp);
+};
+
+struct rtpacket_interface;
+
+/* packet pool methods */
+
+void rtpacket_pool_drain(struct rtpacket_pool *p);
+
+int rtpacket_pool_init(struct rtpacket_pool *p, struct device *dev,
+		       unsigned int reserved,
+		       unsigned int npkt, unsigned int bufsize);
+
+struct rtpacket *rtpacket_pool_pop(struct rtpacket_pool *p);
+
+void rtpacket_pool_push(struct rtpacket_pool *p, struct rtpacket *rtp);
+
+/* registration methods */
+
+void rtpacket_deregister(struct rtpacket_interface *iface);
+
+struct rtpacket_interface *rtpacket_register(struct rtpacket_driver_ops *ops,
+					     struct device *dev,
+					     unsigned int tx_reserved);
+
+/* receive and transmit path methods */
+
+int rtpacket_receive(struct rtpacket_interface *iface, struct rtpacket *rtp);
+
+void rtpacket_recycle(struct rtpacket_interface *iface, struct rtpacket *rtp);
+
+#endif /* __KERNEL__ */
+#endif
diff --git a/ksrc/drivers/testing/Kconfig b/ksrc/drivers/testing/Kconfig
index 28504dc..6f67e7c 100644
--- a/ksrc/drivers/testing/Kconfig
+++ b/ksrc/drivers/testing/Kconfig
@@ -9,6 +9,14 @@ config XENO_DRIVERS_TESTING_LEGACY_NAMES
 	Only enable this if you plan to use old userspace tools with the
 	drivers.
 
+config XENO_DRIVERS_PACKET
+	depends on XENO_SKIN_RTDM
+	tristate "Raw Ethernet packet driver"
+	default y
+	help
+	Provides a class driver for sending and receiving raw Ethernet
+	packets over a simple character device interface.
+
 config XENO_DRIVERS_TIMERBENCH
 	depends on XENO_SKIN_RTDM
 	tristate "Timer benchmark driver"
diff --git a/ksrc/drivers/testing/Makefile b/ksrc/drivers/testing/Makefile
index 17a6cf1..78679c8 100644
--- a/ksrc/drivers/testing/Makefile
+++ b/ksrc/drivers/testing/Makefile
@@ -4,6 +4,7 @@ ifeq ($(PATCHLEVEL),6)
 
 EXTRA_CFLAGS += -D__IN_XENOMAI__ -Iinclude/xenomai
 
+obj-$(CONFIG_XENO_DRIVERS_PACKET)     += xeno_packet.o
 obj-$(CONFIG_XENO_DRIVERS_TIMERBENCH) += xeno_timerbench.o
 obj-$(CONFIG_XENO_DRIVERS_IRQBENCH)   += xeno_irqbench.o
 obj-$(CONFIG_XENO_DRIVERS_SWITCHTEST) += xeno_switchtest.o
@@ -11,6 +12,8 @@ obj-$(CONFIG_XENO_DRIVERS_KLATENCY)   += xeno_klat.o
 obj-$(CONFIG_XENO_DRIVERS_SIGTEST)    += xeno_sigtest.o
 obj-$(CONFIG_XENO_DRIVERS_RTDMTEST)   += xeno_rtdmtest.o
 
+xeno_packet-y := packet.o
+
 xeno_timerbench-y := timerbench.o
 
 xeno_irqbench-y := irqbench.o
diff --git a/ksrc/drivers/testing/packet.c b/ksrc/drivers/testing/packet.c
new file mode 100644
index 0000000..b933888
--- /dev/null
+++ b/ksrc/drivers/testing/packet.c
@@ -0,0 +1,352 @@
+/*
+ * Xenomai Packet Interface - class driver for raw Ethernet packets
+ *
+ * Copyright (C) 2011 OMICRON electronics GmbH
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <rtdm/rtpacket.h>
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("richard.cochran@domain.hid");
+
+struct rtpacket_interface {
+	struct device *dev;
+	struct rtdm_device rtdev;
+	struct rtpacket_driver_ops *ops;
+	struct rtpacket_pool tx_pool;
+	struct rtpacket_pool rx_fifo;
+	rtdm_event_t rx_event;
+	nanosecs_rel_t rx_tmo;
+};
+
+/* Receive fifo */
+
+static struct rtpacket *fifo_dequeue(struct rtpacket_pool *p)
+{
+	return rtpacket_pool_pop(p);
+}
+
+static int fifo_empty(struct rtpacket_pool *p)
+{
+	int empty;
+	rtdm_lockctx_t ctx;
+	rtdm_lock_get_irqsave(&p->lock, ctx);
+	empty = list_empty(&p->list);
+	rtdm_lock_put_irqrestore(&p->lock, ctx);
+	return empty;
+}
+
+static void fifo_enqueue(struct rtpacket_pool *p, struct rtpacket *rtp)
+{
+	rtdm_lockctx_t ctx;
+	rtdm_lock_get_irqsave(&p->lock, ctx);
+	list_add_tail(&rtp->list, &p->list);
+	rtdm_lock_put_irqrestore(&p->lock, ctx);
+}
+
+/* Device operations */
+
+static int rtpacket_open(struct rtdm_dev_context *ctx,
+			 rtdm_user_info_t *info, int oflags)
+{
+	return 0;
+}
+
+static int rtpacket_close(struct rtdm_dev_context *ctx, rtdm_user_info_t *info)
+{
+	return 0;
+}
+
+static int rtpacket_ioctl_rt(struct rtdm_dev_context *ctx,
+			     rtdm_user_info_t *info,
+			     unsigned int request, void __user *arg)
+{
+	struct rtpacket_interface *pif = ctx->device->device_data;
+	struct rtpacket_filter __user *user = arg;
+	struct rtpacket_filter kf;
+	int err = 0;
+
+	switch (request) {
+	case RTPACKET_FILTER:
+		err = rtdm_safe_copy_from_user(info, &kf, user, sizeof(kf));
+		if (err)
+			return err;
+
+		err = pif->ops->filter(pif->ops, &kf);
+		break;
+	default:
+		err = -ENOTTY;
+	}
+
+	return err;
+}
+
+static ssize_t rtpacket_read_rt(struct rtdm_dev_context *ctx,
+				rtdm_user_info_t *info, void *buf, size_t nbyte)
+{
+	struct rtpacket_interface *pif = ctx->device->device_data;
+	struct rtpacket *rtp;
+	size_t len;
+	int err;
+
+	if (nbyte > RTPACKET_BUFFER_SIZE)
+		return -EINVAL;
+
+	if (fifo_empty(&pif->rx_fifo)) {
+		err = rtdm_event_timedwait(&pif->rx_event, pif->rx_tmo, NULL);
+		if (err == -ETIMEDOUT)
+			return 0;
+		else if (err)
+			return err;
+	}
+	rtp = fifo_dequeue(&pif->rx_fifo);
+	if (!rtp)
+		return 0;
+
+	len = rtp->length;
+	if (len > nbyte)
+		len = nbyte;
+
+	err = rtdm_safe_copy_to_user(info, buf, rtp->data.va, len);
+
+	pif->ops->recycle(pif->ops, rtp);
+
+	return err ? err : len;
+}
+
+static ssize_t rtpacket_write_rt(struct rtdm_dev_context *ctx,
+				 rtdm_user_info_t *info,
+				 const void *buf, size_t nbyte)
+{
+	struct rtpacket_interface *pif = ctx->device->device_data;
+	struct rtpacket *rtp;
+	int err;
+
+	if (nbyte > RTPACKET_BUFFER_SIZE)
+		return -EINVAL;
+
+	rtp = rtpacket_pool_pop(&pif->tx_pool);
+	if (!rtp)
+		return -EBUSY;
+
+	err = rtdm_safe_copy_from_user(info, rtp->data.va, buf, nbyte);
+	if (err)
+		goto bail;
+
+	rtp->length = nbyte;
+
+	err = pif->ops->transmit(pif->ops, rtp);
+	if (err)
+		goto bail;
+
+	return nbyte;
+bail:
+	rtpacket_pool_push(&pif->tx_pool, rtp);
+	return err;
+}
+
+/* Public methods */
+
+void rtpacket_pool_drain(struct rtpacket_pool *p)
+{
+	struct rtpacket *rtp;
+	int count;
+
+	if (!p->npkt)
+		return;
+
+	for (count = 0; ; count++) {
+		rtp = rtpacket_pool_pop(p);
+		if (!rtp)
+			break;
+	}
+
+	if (count != p->npkt)
+		pr_err("packet pool mismatch, %d of %d", count, p->npkt);
+
+	dma_free_coherent(p->dev, p->npkt * p->pktsize,
+			  p->pkt[0].base.va, p->pkt[0].base.pa);
+
+	kfree(p->pkt);
+}
+EXPORT_SYMBOL_GPL(rtpacket_pool_drain);
+
+int rtpacket_pool_init(struct rtpacket_pool *p, struct device *dev,
+		       unsigned int reserved,
+		       unsigned int npkt, unsigned int bufsize)
+{
+	void *va;
+	dma_addr_t pa;
+	int i;
+
+	INIT_LIST_HEAD(&p->list);
+	rtdm_lock_init(&p->lock);
+	p->pkt = NULL;
+	p->npkt = npkt;
+	p->pktsize = bufsize;
+	p->dev = dev;
+
+	if (!npkt)
+		return 0;
+
+	p->pkt = kmalloc(npkt * sizeof(*p->pkt), GFP_KERNEL);
+	if (!p->pkt)
+		goto no_pkt;
+
+	va = dma_alloc_coherent(dev, npkt * bufsize, &pa, GFP_KERNEL);
+	if (!va)
+		goto no_dma;
+
+	for (i = 0; i < npkt; i++) {
+		p->pkt[i].base.va = va;
+		p->pkt[i].base.pa = pa;
+		p->pkt[i].data.va = va + reserved;
+		p->pkt[i].data.pa = pa + reserved;
+		rtpacket_pool_push(p, &p->pkt[i]);
+		va += bufsize;
+		pa += bufsize;
+	}
+	return 0;
+no_dma:
+	kfree(p->pkt);
+no_pkt:
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(rtpacket_pool_init);
+
+struct rtpacket *rtpacket_pool_pop(struct rtpacket_pool *p)
+{
+	struct rtpacket *rtp = NULL;
+	rtdm_lockctx_t ctx;
+	rtdm_lock_get_irqsave(&p->lock, ctx);
+	if (!list_empty(&p->list)) {
+		rtp = list_first_entry(&p->list, struct rtpacket, list);
+		list_del_init(&rtp->list);
+	}
+	rtdm_lock_put_irqrestore(&p->lock, ctx);
+	return rtp;
+}
+EXPORT_SYMBOL_GPL(rtpacket_pool_pop);
+
+void rtpacket_pool_push(struct rtpacket_pool *p, struct rtpacket *rtp)
+{
+	rtdm_lockctx_t ctx;
+	rtdm_lock_get_irqsave(&p->lock, ctx);
+	list_add(&rtp->list, &p->list);
+	rtdm_lock_put_irqrestore(&p->lock, ctx);
+}
+EXPORT_SYMBOL_GPL(rtpacket_pool_push);
+
+void rtpacket_deregister(struct rtpacket_interface *pif)
+{
+	rtdm_dev_unregister(&pif->rtdev, 10);
+	rtpacket_pool_drain(&pif->rx_fifo);
+	rtpacket_pool_drain(&pif->tx_pool);
+	rtdm_event_destroy(&pif->rx_event);
+	kfree(pif);
+}
+EXPORT_SYMBOL_GPL(rtpacket_deregister);
+
+struct rtpacket_interface *rtpacket_register(struct rtpacket_driver_ops *ops,
+					     struct device *dev,
+					     unsigned int tx_reserved)
+{
+	struct rtpacket_interface *pif;
+
+	pif = kzalloc(sizeof(struct rtpacket_interface), GFP_KERNEL);
+	if (pif == NULL)
+		goto no_memory;
+
+	pif->ops = ops;
+	snprintf(pif->rtdev.device_name, RTDM_MAX_DEVNAME_LEN,
+		 "rt-%s", ops->name);
+	pif->rtdev.struct_version	= RTDM_DEVICE_STRUCT_VER;
+	pif->rtdev.device_flags		= RTDM_NAMED_DEVICE;
+	pif->rtdev.context_size		= 0;
+	pif->rtdev.open_nrt		= rtpacket_open;
+	pif->rtdev.ops.close_nrt	= rtpacket_close;
+	pif->rtdev.ops.ioctl_rt		= rtpacket_ioctl_rt,
+	pif->rtdev.ops.read_rt		= rtpacket_read_rt;
+	pif->rtdev.ops.write_rt		= rtpacket_write_rt;
+	pif->rtdev.device_class		= RTDM_CLASS_EXPERIMENTAL;
+	pif->rtdev.device_sub_class	= 0;
+	pif->rtdev.profile_version	= 1;
+	pif->rtdev.driver_name		= pif->rtdev.device_name;
+	pif->rtdev.driver_version	= RTDM_DRIVER_VER(1,0,0);
+	pif->rtdev.peripheral_name	= pif->rtdev.device_name;
+	pif->rtdev.provider_name	= pif->rtdev.device_name;
+	pif->rtdev.proc_name		= pif->rtdev.device_name;
+	pif->rtdev.device_id		= 0;
+	pif->rtdev.device_data		= pif;
+
+	if (rtpacket_pool_init(&pif->tx_pool, dev, tx_reserved,
+			       RTPACKET_TX_POOL_SIZE,
+			       RTPACKET_BUFFER_SIZE))
+		goto no_txpool;
+
+	if (rtpacket_pool_init(&pif->rx_fifo, dev, 0, 0, 0))
+		goto no_rxfifo;
+
+	rtdm_event_init(&pif->rx_event, 0);
+	pif->rx_tmo = 1000000000;
+
+	if (rtdm_dev_register(&pif->rtdev)) {
+		pr_err("register rtdm %s failed\n", pif->rtdev.device_name);
+		goto no_register;
+	}
+
+	return pif;
+
+no_register:
+	rtpacket_pool_drain(&pif->rx_fifo);
+no_rxfifo:
+	rtpacket_pool_drain(&pif->tx_pool);
+no_txpool:
+	kfree(pif);
+no_memory:
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(rtpacket_register);
+
+int rtpacket_receive(struct rtpacket_interface *pif, struct rtpacket *rtp)
+{
+	fifo_enqueue(&pif->rx_fifo, rtp);
+	rtdm_event_signal(&pif->rx_event);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rtpacket_receive);
+
+void rtpacket_recycle(struct rtpacket_interface *pif, struct rtpacket *rtp)
+{
+	rtpacket_pool_push(&pif->tx_pool, rtp);
+}
+EXPORT_SYMBOL_GPL(rtpacket_recycle);
+
+/* Module code */
+
+static int __init rtpacket_init(void)
+{
+	return 0;
+}
+
+static void rtpacket_exit(void)
+{
+}
+
+subsys_initcall(rtpacket_init);
+module_exit(rtpacket_exit);
-- 
1.7.2.5


