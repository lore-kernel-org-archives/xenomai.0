From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Date: Fri,  7 Mar 2014 21:20:31 +0100
Message-Id: <1394223638-13070-2-git-send-email-gilles.chanteperdrix@xenomai.org>
In-Reply-To: <1394223638-13070-1-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <531A29CC.4040201@xenomai.org>
 <1394223638-13070-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Subject: [Xenomai] [PATCH 2/9] cobalt/rtdm: base named devices on nucleus
	registry
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
 include/cobalt/kernel/rtdm/driver.h |   12 ++--
 kernel/cobalt/rtdm/device.c         |  115 +++++++++++------------------------
 kernel/cobalt/rtdm/internal.h       |    2 +-
 kernel/cobalt/rtdm/proc.c           |   94 ++++++++--------------------
 4 files changed, 69 insertions(+), 154 deletions(-)

diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
index 75d0c0f..c76df5d 100644
--- a/include/cobalt/kernel/rtdm/driver.h
+++ b/include/cobalt/kernel/rtdm/driver.h
@@ -445,8 +445,12 @@ rtdm_private_to_context(void *dev_private)
 }
 
 struct rtdm_dev_reserved {
+	unsigned magic;
 	union {
-		struct list_head entry;
+		struct {
+			struct list_head entry;
+			xnhandle_t handle;
+		};
 		struct xnid id;
 	};
 	atomic_t refcount;
@@ -461,6 +465,9 @@ struct rtdm_dev_reserved {
  * not reside in write-protected memory.
  */
 struct rtdm_device {
+	/** Data stored by RTDM inside a registered device (internal use only) */
+	struct rtdm_dev_reserved reserved;
+
 	/** Revision number of this structure, see
 	 *  @ref drv_versioning "Driver Versioning" defines */
 	int struct_version;
@@ -529,9 +536,6 @@ struct rtdm_device {
 	int device_id;
 	/** Driver definable device data */
 	void *device_data;
-
-	/** Data stored by RTDM inside a registered device (internal use only) */
-	struct rtdm_dev_reserved reserved;
 };
 /** @} devregister */
 
diff --git a/kernel/cobalt/rtdm/device.c b/kernel/cobalt/rtdm/device.c
index 38353ee..299c788 100644
--- a/kernel/cobalt/rtdm/device.c
+++ b/kernel/cobalt/rtdm/device.c
@@ -31,6 +31,8 @@
 #include <cobalt/kernel/apc.h>
 #include "rtdm/internal.h"
 
+#define RTDM_DEVICE_MAGIC	0x82846877
+
 #define SET_DEFAULT_OP(device, operation)				\
 	(device).operation##_rt  = (void *)rtdm_no_support;		\
 	(device).operation##_nrt = (void *)rtdm_no_support
@@ -44,13 +46,7 @@
 #define ANY_HANDLER(device, operation)					\
 	((device).operation##_rt || (device).operation##_nrt)
 
-unsigned int devname_hashtab_size = DEF_DEVNAME_HASHTAB_SIZE;
-module_param(devname_hashtab_size, uint, 0400);
-MODULE_PARM_DESC(devname_hashtab_size,
-		 "Size of hash table for named devices (must be power of 2)");
-
-struct list_head *rtdm_named_devices;	/* hash table */
-static int name_hashkey_mask;
+struct list_head rtdm_named_devices;	/* hash table */
 struct rb_root rtdm_protocol_devices;
 
 int rtdm_apc;
@@ -74,18 +70,6 @@ int rtdm_select_bind_no_support(struct rtdm_dev_context *context,
 	return -EBADF;
 }
 
-static inline int get_name_hash(const char *str, int limit, int hashkey_mask)
-{
-	int hash = 0;
-
-	while (*str != 0) {
-		hash += *str++;
-		if (--limit == 0)
-			break;
-	}
-	return hash & hashkey_mask;
-}
-
 static inline unsigned long long get_proto_id(int pf, int type)
 {
 	unsigned long long llpf = (unsigned)pf;
@@ -99,30 +83,28 @@ static inline void rtdm_reference_device(struct rtdm_device *device)
 
 struct rtdm_device *get_named_device(const char *name)
 {
-	struct list_head *entry;
 	struct rtdm_device *device;
-	int hashkey;
+	xnhandle_t handle;
+	int err;
 	spl_t s;
 
-	hashkey = get_name_hash(name, RTDM_MAX_DEVNAME_LEN, name_hashkey_mask);
+	err = xnregistry_bind(name, XN_NONBLOCK, XN_RELATIVE, &handle);
+	if (err == -EWOULDBLOCK)
+		return NULL;
 
 	xnlock_get_irqsave(&rt_dev_lock, s);
 
-	list_for_each(entry, &rtdm_named_devices[hashkey]) {
-		device = list_entry(entry, struct rtdm_device, reserved.entry);
-
-		if (strcmp(name, device->device_name) == 0) {
+	device = xnregistry_lookup(handle, NULL);
+	if (device) {
+		if (device->reserved.magic != RTDM_DEVICE_MAGIC)
+			device = NULL;
+		else
 			rtdm_reference_device(device);
-
-			xnlock_put_irqrestore(&rt_dev_lock, s);
-
-			return device;
-		}
 	}
 
 	xnlock_put_irqrestore(&rt_dev_lock, s);
 
-	return NULL;
+	return device;
 }
 
 struct rtdm_device *get_protocol_device(int protocol_family, int socket_type)
@@ -184,10 +166,7 @@ struct rtdm_device *get_protocol_device(int protocol_family, int socket_type)
 int rtdm_dev_register(struct rtdm_device *device)
 {
 	unsigned long long id;
-	int hashkey;
 	spl_t s;
-	struct list_head *entry;
-	struct rtdm_device *existing_dev;
 	int ret;
 
 	/* Catch unsuccessful initialisation */
@@ -281,6 +260,8 @@ int rtdm_dev_register(struct rtdm_device *device)
 
 	down(&nrt_dev_lock);
 
+	device->reserved.magic = RTDM_DEVICE_MAGIC;
+
 	if ((device->device_flags & RTDM_DEVICE_TYPE_MASK) == RTDM_NAMED_DEVICE) {
 		trace_mark(xn_rtdm, nameddev_register, "device %p name %s "
 			   "flags %d class %d sub_class %d profile_version %d "
@@ -288,29 +269,19 @@ int rtdm_dev_register(struct rtdm_device *device)
 			   device->device_flags, device->device_class,
 			   device->device_sub_class, device->profile_version,
 			   device->driver_version);
-
-		hashkey =
-		    get_name_hash(device->device_name, RTDM_MAX_DEVNAME_LEN,
-				  name_hashkey_mask);
-
-		list_for_each(entry, &rtdm_named_devices[hashkey]) {
-			existing_dev =
-			    list_entry(entry, struct rtdm_device,
-				       reserved.entry);
-			if (strcmp(device->device_name,
-				   existing_dev->device_name) == 0) {
-				ret = -EEXIST;
-				goto err;
-			}
-		}
-
 		ret = rtdm_proc_register_device(device);
 		if (ret)
 			goto err;
 
+		ret = xnregistry_enter(device->device_name, device, 
+				&device->reserved.handle, NULL);
+		if (ret) {
+			rtdm_proc_unregister_device(device);
+			goto err;
+		}
+
 		xnlock_get_irqsave(&rt_dev_lock, s);
-		list_add_tail(&device->reserved.entry,
-			      &rtdm_named_devices[hashkey]);
+		list_add_tail(&device->reserved.entry, &rtdm_named_devices);
 		xnlock_put_irqrestore(&rt_dev_lock, s);
 
 		up(&nrt_dev_lock);
@@ -381,9 +352,10 @@ EXPORT_SYMBOL_GPL(rtdm_dev_register);
  */
 int rtdm_dev_unregister(struct rtdm_device *device, unsigned int poll_delay)
 {
-	spl_t s;
 	struct rtdm_device *reg_dev;
 	unsigned long warned = 0;
+	xnhandle_t handle = 0;
+	spl_t s;
 
 	if (!rtdm_initialised)
 		return -ENOSYS;
@@ -422,15 +394,20 @@ int rtdm_dev_unregister(struct rtdm_device *device, unsigned int poll_delay)
 		xnlock_get_irqsave(&rt_dev_lock, s);
 	}
 
-	if ((device->device_flags & RTDM_DEVICE_TYPE_MASK) == RTDM_NAMED_DEVICE)
+	if ((device->device_flags & RTDM_DEVICE_TYPE_MASK) == 
+		RTDM_NAMED_DEVICE) {
+		handle = reg_dev->reserved.handle;
 		list_del(&reg_dev->reserved.entry);
-	else
+	} else
 		xnid_remove(&rtdm_protocol_devices, &reg_dev->reserved.id);
 
 	xnlock_put_irqrestore(&rt_dev_lock, s);
 
 	rtdm_proc_unregister_device(device);
 
+	if (handle)
+		xnregistry_remove(handle);
+
 	up(&nrt_dev_lock);
 
 	if (reg_dev->reserved.exclusive_context)
@@ -444,8 +421,6 @@ EXPORT_SYMBOL_GPL(rtdm_dev_unregister);
 
 int __init rtdm_dev_init(void)
 {
-	int err, i;
-
 	sema_init(&nrt_dev_lock, 1);
 
 	rtdm_apc = xnapc_alloc("deferred RTDM close", rtdm_apc_handler,
@@ -453,31 +428,10 @@ int __init rtdm_dev_init(void)
 	if (rtdm_apc < 0)
 		return rtdm_apc;
 
-	name_hashkey_mask = devname_hashtab_size - 1;
-	if (((devname_hashtab_size & name_hashkey_mask) != 0)) {
-		err = -EINVAL;
-		goto err_out1;
-	}
-
-	rtdm_named_devices = (struct list_head *)
-	    kmalloc(devname_hashtab_size * sizeof(struct list_head),
-		    GFP_KERNEL);
-	if (!rtdm_named_devices) {
-		err = -ENOMEM;
-		goto err_out1;
-	}
-
-	for (i = 0; i < devname_hashtab_size; i++)
-		INIT_LIST_HEAD(&rtdm_named_devices[i]);
-	
+	INIT_LIST_HEAD(&rtdm_named_devices);
 	xntree_init(&rtdm_protocol_devices);
 
 	return 0;
-
-err_out1:
-	xnapc_free(rtdm_apc);
-
-	return err;
 }
 
 void rtdm_dev_cleanup(void)
@@ -487,7 +441,6 @@ void rtdm_dev_cleanup(void)
 	 * to deregister as long as there are references.
 	 */
 	xnapc_free(rtdm_apc);
-	kfree(rtdm_named_devices);
 }
 
 /*@}*/
diff --git a/kernel/cobalt/rtdm/internal.h b/kernel/cobalt/rtdm/internal.h
index 0bebe8b..3288068 100644
--- a/kernel/cobalt/rtdm/internal.h
+++ b/kernel/cobalt/rtdm/internal.h
@@ -50,7 +50,7 @@ extern struct rtdm_fildes fildes_table[];
 extern int open_fildes;
 extern struct semaphore nrt_dev_lock;
 extern unsigned int devname_hashtab_size;
-extern struct list_head *rtdm_named_devices;
+extern struct list_head rtdm_named_devices;
 extern struct rb_root rtdm_protocol_devices;
 extern struct xnpersonality rtdm_personality;
 
diff --git a/kernel/cobalt/rtdm/proc.c b/kernel/cobalt/rtdm/proc.c
index 218bf8b..28ec6ab 100644
--- a/kernel/cobalt/rtdm/proc.c
+++ b/kernel/cobalt/rtdm/proc.c
@@ -23,10 +23,7 @@
 struct xnvfile_directory rtdm_vfroot;	/* /proc/xenomai/rtdm */
 
 struct vfile_device_data {
-	int h;
-	int hmax;
-	struct list_head *devmap;
-	struct list_head *curr;
+	struct rtdm_device *curr;
 };
 
 static int get_nrt_lock(struct xnvfile *vfile)
@@ -44,95 +41,59 @@ static struct xnvfile_lock_ops lockops = {
 	.put = put_nrt_lock,
 };
 
-static struct list_head *next_devlist(struct vfile_device_data *priv)
-{
-	struct list_head *head;
-
-	while (priv->h < priv->hmax) {
-		head = priv->devmap + priv->h;
-		if (!list_empty(head))
-			return head;
-		priv->h++;
-	}
-
-	return NULL;
-}
-
-static void *next_dev(struct xnvfile_regular_iterator *it)
+static void *named_next(struct xnvfile_regular_iterator *it)
 {
 	struct vfile_device_data *priv = xnvfile_iterator_priv(it);
+	struct rtdm_device *device = priv->curr;
 	struct list_head *next;
 
-	next = priv->curr->next;
-seek:
-	if (next == priv->devmap + priv->h) {
-		/* Done with the current hash slot, let's progress. */
-		if (priv->h >= priv->hmax) {
-			next = NULL; /* all done. */
-			goto out;
-		}
-
-		priv->h++;
-		next = next_devlist(priv);
-		if (next) {
-			next = next->next; /* skip head. */
-			goto seek;
-		}
+	next = device->reserved.entry.next;
+	if (next == &rtdm_named_devices) {
+		priv->curr = NULL; /* all done. */
+		goto out;
 	}
-out:
-	priv->curr = next;
 
-	return next;
+	priv->curr = list_entry(next, struct rtdm_device, reserved.entry);
+
+  out:
+	return priv->curr;
 }
 
 static void *named_begin(struct xnvfile_regular_iterator *it)
 {
 	struct vfile_device_data *priv = xnvfile_iterator_priv(it);
-	struct list_head *devlist;
+	struct rtdm_device *device;
 	loff_t pos = 0;
 
-	priv->devmap = rtdm_named_devices;
-	priv->hmax = devname_hashtab_size;
-	priv->h = 0;
-
-	devlist = next_devlist(priv);
-	if (devlist == NULL)
-		return NULL;	/* All devlists empty. */
+	list_for_each_entry(device, &rtdm_named_devices, reserved.entry)
+		if (pos++ >= it->pos)
+			break;
 
-	priv->curr = devlist->next;	/* Skip head. */
+	if (&device->reserved.entry == &rtdm_named_devices)
+		return NULL;	/* End of list. */
 
-	/*
-	 * priv->curr now points to the first device; advance to the requested
-	 * position from there.
-	 */
-	while (priv->curr && pos++ < it->pos)
-		priv->curr = next_dev(it);
+	priv->curr = device;	/* Skip head. */
 
 	if (pos == 1)
 		/* Output the header once, only if some device follows. */
-		xnvfile_puts(it, "Hash\tName\t\t\t\tDriver\t\t/proc\n");
+		xnvfile_puts(it, "Name\t\t\t\tDriver\t\t/proc\n");
 
 	return priv->curr;
 }
 
 static int named_show(struct xnvfile_regular_iterator *it, void *data)
 {
-	struct vfile_device_data *priv = xnvfile_iterator_priv(it);
-	struct list_head *curr = data;
-	struct rtdm_device *device;
+	struct rtdm_device *device = data;
 
-	device = list_entry(curr, struct rtdm_device, reserved.entry);
-	xnvfile_printf(it, "%02X\t%-31s\t%-15s\t%s\n",
-		       priv->h, device->device_name,
-		       device->driver_name,
-		       device->proc_name);
+	xnvfile_printf(it, "%-31s\t%-15s\t%s\n", device->device_name, 
+		device->driver_name, device->proc_name);
 
 	return 0;
 }
 
 static struct xnvfile_regular_ops named_vfile_ops = {
 	.begin = named_begin,
-	.next = next_dev,
+	.next = named_next,
 	.show = named_show,
 };
 
@@ -306,7 +267,6 @@ static struct xnvfile_regular allfd_vfile = {
 static int devinfo_vfile_show(struct xnvfile_regular_iterator *it, void *data)
 {
 	struct rtdm_device *device;
-	int i;
 
 	if (down_interruptible(&nrt_dev_lock))
 		return -ERESTARTSYS;
@@ -315,11 +275,9 @@ static int devinfo_vfile_show(struct xnvfile_regular_iterator *it, void *data)
 	 * As the device may have disappeared while the handler was called,
 	 * first match the pointer against registered devices.
 	 */
-	for (i = 0; i < devname_hashtab_size; i++)
-		list_for_each_entry(device, &rtdm_named_devices[i],
-				    reserved.entry)
-			if (device == xnvfile_priv(it->vfile))
-				goto found;
+	list_for_each_entry(device, &rtdm_named_devices, reserved.entry)
+		if (device == xnvfile_priv(it->vfile))
+			goto found;
 
 	xntree_for_each_entry(device, &rtdm_protocol_devices, reserved.id)
 		if (device == xnvfile_priv(it->vfile))
-- 
1.7.10.4


