From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Sat,  1 Feb 2014 19:27:26 +0100
Message-Id: <1391279248-5565-1-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <52ED3BA0.4040105@xenomai.org>
References: <52ED3BA0.4040105@xenomai.org>
Subject: [Xenomai] [PATCH 1/3] cobalt/rtdm: base protocol devices on xnid
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

---
 include/cobalt/kernel/rtdm/driver.h |    6 +-
 kernel/cobalt/rtdm/device.c         |  103 ++++++++++++-----------------------
 kernel/cobalt/rtdm/internal.h       |    4 +-
 kernel/cobalt/rtdm/proc.c           |   60 ++++++++++----------
 4 files changed, 71 insertions(+), 102 deletions(-)

diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
index 3e1795c..881f517 100644
--- a/include/cobalt/kernel/rtdm/driver.h
+++ b/include/cobalt/kernel/rtdm/driver.h
@@ -38,6 +38,7 @@
 #include <cobalt/kernel/clock.h>
 #include <cobalt/kernel/apc.h>
 #include <cobalt/kernel/shadow.h>
+#include <cobalt/kernel/tree.h>
 #include <rtdm/rtdm.h>
 
 /* debug support */
@@ -443,7 +444,10 @@ rtdm_private_to_context(void *dev_private)
 }
 
 struct rtdm_dev_reserved {
-	struct list_head entry;
+	union {
+		struct list_head entry;
+		struct xnid id;
+	};
 	atomic_t refcount;
 	struct rtdm_dev_context *exclusive_context;
 };
diff --git a/kernel/cobalt/rtdm/device.c b/kernel/cobalt/rtdm/device.c
index 1aa2542..38353ee 100644
--- a/kernel/cobalt/rtdm/device.c
+++ b/kernel/cobalt/rtdm/device.c
@@ -45,19 +45,13 @@
 	((device).operation##_rt || (device).operation##_nrt)
 
 unsigned int devname_hashtab_size = DEF_DEVNAME_HASHTAB_SIZE;
-unsigned int protocol_hashtab_size = DEF_PROTO_HASHTAB_SIZE;
 module_param(devname_hashtab_size, uint, 0400);
-module_param(protocol_hashtab_size, uint, 0400);
 MODULE_PARM_DESC(devname_hashtab_size,
 		 "Size of hash table for named devices (must be power of 2)");
-MODULE_PARM_DESC(protocol_hashtab_size,
-		 "Size of hash table for protocol devices "
-		 "(must be power of 2)");
 
 struct list_head *rtdm_named_devices;	/* hash table */
-struct list_head *rtdm_protocol_devices;	/* hash table */
 static int name_hashkey_mask;
-static int proto_hashkey_mask;
+struct rb_root rtdm_protocol_devices;
 
 int rtdm_apc;
 EXPORT_SYMBOL_GPL(rtdm_apc);
@@ -92,9 +86,10 @@ static inline int get_name_hash(const char *str, int limit, int hashkey_mask)
 	return hash & hashkey_mask;
 }
 
-static inline int get_proto_hash(int protocol_family, int socket_type)
+static inline unsigned long long get_proto_id(int pf, int type)
 {
-	return protocol_family & proto_hashkey_mask;
+	unsigned long long llpf = (unsigned)pf;
+	return (llpf << 32) | (unsigned)type;
 }
 
 static inline void rtdm_reference_device(struct rtdm_device *device)
@@ -132,31 +127,26 @@ struct rtdm_device *get_named_device(const char *name)
 
 struct rtdm_device *get_protocol_device(int protocol_family, int socket_type)
 {
-	struct list_head *entry;
 	struct rtdm_device *device;
-	int hashkey;
+	unsigned long long id;
+	struct xnid *xnid;
 	spl_t s;
 
-	hashkey = get_proto_hash(protocol_family, socket_type);
+	id = get_proto_id(protocol_family, socket_type);
 
 	xnlock_get_irqsave(&rt_dev_lock, s);
 
-	list_for_each(entry, &rtdm_protocol_devices[hashkey]) {
-		device = list_entry(entry, struct rtdm_device, reserved.entry);
-
-		if ((device->protocol_family == protocol_family) &&
-		    (device->socket_type == socket_type)) {
-			rtdm_reference_device(device);
-
-			xnlock_put_irqrestore(&rt_dev_lock, s);
+	xnid = xnid_fetch(&rtdm_protocol_devices, id);
+	if (xnid) {
+		device = container_of(xnid, struct rtdm_device, reserved.id);
 
-			return device;
-		}
-	}
+		rtdm_reference_device(device);
+	} else
+		device = NULL;
 
 	xnlock_put_irqrestore(&rt_dev_lock, s);
 
-	return NULL;
+	return device;
 }
 
 /*!
@@ -193,6 +183,7 @@ struct rtdm_device *get_protocol_device(int protocol_family, int socket_type)
  */
 int rtdm_dev_register(struct rtdm_device *device)
 {
+	unsigned long long id;
 	int hashkey;
 	spl_t s;
 	struct list_head *entry;
@@ -333,34 +324,24 @@ int rtdm_dev_register(struct rtdm_device *device)
 			   device->device_sub_class, device->profile_version,
 			   device->driver_version);
 
-		hashkey = get_proto_hash(device->protocol_family,
-					 device->socket_type);
+		id = get_proto_id(device->protocol_family,
+				device->socket_type);
 
-		list_for_each(entry, &rtdm_protocol_devices[hashkey]) {
-			existing_dev =
-			    list_entry(entry, struct rtdm_device,
-				       reserved.entry);
-			if ((device->protocol_family ==
-			     existing_dev->protocol_family)
-			    && (device->socket_type ==
-				existing_dev->socket_type)) {
-				printk(XENO_ERR "protocol %u:%u already "
-				       "registered by RTDM device\n",
-				       device->protocol_family,
-				       device->socket_type);
-				ret = -EEXIST;
-				goto err;
-			}
-		}
+		xnlock_get_irqsave(&rt_dev_lock, s);
+		ret = xnid_enter(&rtdm_protocol_devices, 
+				&device->reserved.id, id);
+		xnlock_put_irqrestore(&rt_dev_lock, s);
+		if (ret < 0)
+			goto err;
 
 		ret = rtdm_proc_register_device(device);
-		if (ret)
+		if (ret) {
+			xnlock_get_irqsave(&rt_dev_lock, s);
+			xnid_remove(&rtdm_protocol_devices, 
+				&device->reserved.id);
+			xnlock_put_irqrestore(&rt_dev_lock, s);
 			goto err;
-
-		xnlock_get_irqsave(&rt_dev_lock, s);
-		list_add_tail(&device->reserved.entry,
-			      &rtdm_protocol_devices[hashkey]);
-		xnlock_put_irqrestore(&rt_dev_lock, s);
+		}
 
 		up(&nrt_dev_lock);
 	}
@@ -441,7 +422,10 @@ int rtdm_dev_unregister(struct rtdm_device *device, unsigned int poll_delay)
 		xnlock_get_irqsave(&rt_dev_lock, s);
 	}
 
-	list_del(&reg_dev->reserved.entry);
+	if ((device->device_flags & RTDM_DEVICE_TYPE_MASK) == RTDM_NAMED_DEVICE)
+		list_del(&reg_dev->reserved.entry);
+	else
+		xnid_remove(&rtdm_protocol_devices, &reg_dev->reserved.id);
 
 	xnlock_put_irqrestore(&rt_dev_lock, s);
 
@@ -470,9 +454,7 @@ int __init rtdm_dev_init(void)
 		return rtdm_apc;
 
 	name_hashkey_mask = devname_hashtab_size - 1;
-	proto_hashkey_mask = protocol_hashtab_size - 1;
-	if (((devname_hashtab_size & name_hashkey_mask) != 0) ||
-	    ((protocol_hashtab_size & proto_hashkey_mask) != 0)) {
+	if (((devname_hashtab_size & name_hashkey_mask) != 0)) {
 		err = -EINVAL;
 		goto err_out1;
 	}
@@ -487,23 +469,11 @@ int __init rtdm_dev_init(void)
 
 	for (i = 0; i < devname_hashtab_size; i++)
 		INIT_LIST_HEAD(&rtdm_named_devices[i]);
-
-	rtdm_protocol_devices = (struct list_head *)
-	    kmalloc(protocol_hashtab_size * sizeof(struct list_head),
-		    GFP_KERNEL);
-	if (!rtdm_protocol_devices) {
-		err = -ENOMEM;
-		goto err_out2;
-	}
-
-	for (i = 0; i < protocol_hashtab_size; i++)
-		INIT_LIST_HEAD(&rtdm_protocol_devices[i]);
+	
+	xntree_init(&rtdm_protocol_devices);
 
 	return 0;
 
-err_out2:
-	kfree(rtdm_named_devices);
-
 err_out1:
 	xnapc_free(rtdm_apc);
 
@@ -518,7 +488,6 @@ void rtdm_dev_cleanup(void)
 	 */
 	xnapc_free(rtdm_apc);
 	kfree(rtdm_named_devices);
-	kfree(rtdm_protocol_devices);
 }
 
 /*@}*/
diff --git a/kernel/cobalt/rtdm/internal.h b/kernel/cobalt/rtdm/internal.h
index b5184c1..0bebe8b 100644
--- a/kernel/cobalt/rtdm/internal.h
+++ b/kernel/cobalt/rtdm/internal.h
@@ -23,6 +23,7 @@
 #include <linux/list.h>
 #include <linux/sem.h>
 #include <cobalt/kernel/ppd.h>
+#include <cobalt/kernel/tree.h>
 #include <rtdm/driver.h>
 
 #define RTDM_FD_MAX			CONFIG_XENO_OPT_RTDM_FILDES
@@ -49,9 +50,8 @@ extern struct rtdm_fildes fildes_table[];
 extern int open_fildes;
 extern struct semaphore nrt_dev_lock;
 extern unsigned int devname_hashtab_size;
-extern unsigned int protocol_hashtab_size;
 extern struct list_head *rtdm_named_devices;
-extern struct list_head *rtdm_protocol_devices;
+extern struct rb_root rtdm_protocol_devices;
 extern struct xnpersonality rtdm_personality;
 
 extern int rtdm_initialised;
diff --git a/kernel/cobalt/rtdm/proc.c b/kernel/cobalt/rtdm/proc.c
index ccbbf90..218bf8b 100644
--- a/kernel/cobalt/rtdm/proc.c
+++ b/kernel/cobalt/rtdm/proc.c
@@ -142,51 +142,49 @@ static struct xnvfile_regular named_vfile = {
 	.entry = { .lockops = &lockops }
 };
 
+struct vfile_proto_data {
+	struct rtdm_device *curr;
+};
+
+static void *proto_next(struct xnvfile_regular_iterator *it)
+{
+	struct vfile_proto_data *priv = xnvfile_iterator_priv(it);
+
+	return priv->curr = xnid_next_entry(priv->curr, reserved.id);
+}
+
 static void *proto_begin(struct xnvfile_regular_iterator *it)
 {
 
-	struct vfile_device_data *priv = xnvfile_iterator_priv(it);
-	struct list_head *devlist;
+	struct vfile_proto_data *priv = xnvfile_iterator_priv(it);
+	struct rtdm_device *dev = NULL;
 	loff_t pos = 0;
 
-	priv->devmap = rtdm_protocol_devices;
-	priv->hmax = protocol_hashtab_size;
-	priv->h = 0;
+	xntree_for_each_entry(dev, &rtdm_protocol_devices, reserved.id)
+		if (pos++ >= it->pos)
+			break;
+	
+	if (dev == NULL)
+		return NULL;	/* Empty */
 
-	devlist = next_devlist(priv);
-	if (devlist == NULL)
-		return NULL;	/* All devlists empty. */
-
-	priv->curr = devlist->next;	/* Skip head. */
-
-	/*
-	 * priv->curr now points to the first device; advance to the requested
-	 * position from there.
-	 */
-	while (priv->curr && pos++ < it->pos)
-		priv->curr = next_dev(it);
+	priv->curr = dev;
 
 	if (pos == 1)
 		/* Output the header once, only if some device follows. */
-		xnvfile_puts(it, "Hash\tName\t\t\t\tDriver\t\t/proc\n");
+		xnvfile_puts(it, "Name\t\t\t\tDriver\t\t/proc\n");
 
 	return priv->curr;
 }
 
 static int proto_show(struct xnvfile_regular_iterator *it, void *data)
 {
-	struct vfile_device_data *priv = xnvfile_iterator_priv(it);
-	struct list_head *curr = data;
-	struct rtdm_device *device;
+	struct rtdm_device *device = data;
 	char pnum[32];
 
-	device = list_entry(curr, struct rtdm_device, reserved.entry);
-
 	snprintf(pnum, sizeof(pnum), "%u:%u",
 		 device->protocol_family, device->socket_type);
 
-	xnvfile_printf(it, "%02X\t%-31s\t%-15s\t%s\n",
-		       priv->h,
+	xnvfile_printf(it, "%-31s\t%-15s\t%s\n",
 		       pnum, device->driver_name,
 		       device->proc_name);
 	return 0;
@@ -194,12 +192,12 @@ static int proto_show(struct xnvfile_regular_iterator *it, void *data)
 
 static struct xnvfile_regular_ops proto_vfile_ops = {
 	.begin = proto_begin,
-	.next = next_dev,
+	.next = proto_next,
 	.show = proto_show,
 };
 
 static struct xnvfile_regular proto_vfile = {
-	.privsz = sizeof(struct vfile_device_data),
+	.privsz = sizeof(struct vfile_proto_data),
 	.ops = &proto_vfile_ops,
 	.entry = { .lockops = &lockops }
 };
@@ -323,11 +321,9 @@ static int devinfo_vfile_show(struct xnvfile_regular_iterator *it, void *data)
 			if (device == xnvfile_priv(it->vfile))
 				goto found;
 
-	for (i = 0; i < protocol_hashtab_size; i++)
-		list_for_each_entry(device, &rtdm_protocol_devices[i],
-				    reserved.entry)
-			if (device == xnvfile_priv(it->vfile))
-				goto found;
+	xntree_for_each_entry(device, &rtdm_protocol_devices, reserved.id)
+		if (device == xnvfile_priv(it->vfile))
+			goto found;
 
 	up(&nrt_dev_lock);
 	return -ENODEV;
-- 
1.7.10.4


