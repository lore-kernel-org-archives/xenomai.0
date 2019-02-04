From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 08/18] net/stack: allow initializing pre-allocated device
 structs
Date: Mon,  4 Feb 2019 11:56:37 +0100
Message-Id: <20190204105647.5034-9-rpm@xenomai.org>
In-Reply-To: <20190204105647.5034-1-rpm@xenomai.org>
References: <20190204105647.5034-1-rpm@xenomai.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

We may want to embed struct rtnet_device into a pre-allocated parent
container struct, which makes rtdev_alloc() and rt_alloc_etherdev()
useless for the purpose.

The new rtdev_init() and rt_init_etherdev() calls can be used to
initialize a pre-allocated device structure and set it up with default
ethernet settings resp. The caller should set the private area pointer
manually (defaults to NULL).

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/stack/include/rtdev.h |   9 ++
 kernel/drivers/net/stack/rtdev.c         | 130 +++++++++++++++--------
 2 files changed, 96 insertions(+), 43 deletions(-)

diff --git a/kernel/drivers/net/stack/include/rtdev.h b/kernel/drivers/net/stack/include/rtdev.h
index ddc7aebcd..8d37b6709 100644
--- a/kernel/drivers/net/stack/include/rtdev.h
+++ b/kernel/drivers/net/stack/include/rtdev.h
@@ -180,12 +180,21 @@ extern struct mutex rtnet_devices_nrt_lock;
 extern struct rtnet_device *rtnet_devices[];
 
 
+int __rt_init_etherdev(struct rtnet_device *rtdev,
+		       unsigned int dev_pool_size,
+		       struct module *module);
+
+#define rt_init_etherdev(__rtdev, __dev_pool_size)	\
+    __rt_init_etherdev(__rtdev, __dev_pool_size, THIS_MODULE)
+
 struct rtnet_device *__rt_alloc_etherdev(unsigned sizeof_priv,
 					unsigned dev_pool_size,
 					struct module *module);
 #define rt_alloc_etherdev(priv_size, rx_size) \
     __rt_alloc_etherdev(priv_size, rx_size, THIS_MODULE)
 
+void rtdev_destroy(struct rtnet_device *rtdev);
+
 void rtdev_free(struct rtnet_device *rtdev);
 
 int rt_register_rtnetdev(struct rtnet_device *rtdev);
diff --git a/kernel/drivers/net/stack/rtdev.c b/kernel/drivers/net/stack/rtdev.c
index e76d1debf..631ca1804 100644
--- a/kernel/drivers/net/stack/rtdev.c
+++ b/kernel/drivers/net/stack/rtdev.c
@@ -251,6 +251,39 @@ static const struct rtskb_pool_lock_ops rtdev_ops = {
     .unlock = rtdev_pool_unlock,
 };
 
+int rtdev_init(struct rtnet_device *rtdev, unsigned dev_pool_size)
+{
+    int ret;
+
+    ret = rtskb_pool_init(&rtdev->dev_pool, dev_pool_size, &rtdev_ops, rtdev);
+    if (ret < dev_pool_size) {
+	printk(KERN_ERR "RTnet: cannot allocate rtnet device pool\n");
+	rtskb_pool_release(&rtdev->dev_pool);
+	return -ENOMEM;
+    }
+
+    rtdm_mutex_init(&rtdev->xmit_mutex);
+    rtdm_lock_init(&rtdev->rtdev_lock);
+    mutex_init(&rtdev->nrt_lock);
+
+    atomic_set(&rtdev->refcount, 0);
+
+    /* scale global rtskb pool */
+    rtdev->add_rtskbs = rtskb_pool_extend(&global_pool, device_rtskbs);
+
+    return 0;
+}
+EXPORT_SYMBOL_GPL(rtdev_init);
+
+void rtdev_destroy(struct rtnet_device *rtdev)
+{
+    rtskb_pool_release(&rtdev->dev_pool);
+    rtskb_pool_shrink(&global_pool, rtdev->add_rtskbs);
+    rtdev->stack_event = NULL;
+    rtdm_mutex_destroy(&rtdev->xmit_mutex);
+}
+EXPORT_SYMBOL_GPL(rtdev_destroy);
+
 /***
  *  rtdev_alloc
  *  @int sizeof_priv:
@@ -267,70 +300,94 @@ struct rtnet_device *rtdev_alloc(unsigned sizeof_priv, unsigned dev_pool_size)
     /* ensure 32-byte alignment of the private area */
     alloc_size = sizeof (*rtdev) + sizeof_priv + 31;
 
-    rtdev = (struct rtnet_device *)kmalloc(alloc_size, GFP_KERNEL);
+    rtdev = kzalloc(alloc_size, GFP_KERNEL);
     if (rtdev == NULL) {
 	printk(KERN_ERR "RTnet: cannot allocate rtnet device\n");
 	return NULL;
     }
 
-    memset(rtdev, 0, alloc_size);
-
-    ret = rtskb_pool_init(&rtdev->dev_pool, dev_pool_size, &rtdev_ops, rtdev);
-    if (ret < dev_pool_size) {
-	printk(KERN_ERR "RTnet: cannot allocate rtnet device pool\n");
-	rtskb_pool_release(&rtdev->dev_pool);
+    ret = rtdev_init(rtdev, dev_pool_size);
+    if (ret) {
 	kfree(rtdev);
 	return NULL;
     }
 
-    rtdm_mutex_init(&rtdev->xmit_mutex);
-    rtdm_lock_init(&rtdev->rtdev_lock);
-    mutex_init(&rtdev->nrt_lock);
-
-    atomic_set(&rtdev->refcount, 0);
-
-    /* scale global rtskb pool */
-    rtdev->add_rtskbs = rtskb_pool_extend(&global_pool, device_rtskbs);
-
     if (sizeof_priv)
 	rtdev->priv = (void *)(((long)(rtdev + 1) + 31) & ~31);
 
     return rtdev;
 }
 
-
-
 /***
  *  rtdev_free
  */
 void rtdev_free (struct rtnet_device *rtdev)
 {
     if (rtdev != NULL) {
-	rtskb_pool_release(&rtdev->dev_pool);
-	rtskb_pool_shrink(&global_pool, rtdev->add_rtskbs);
-	rtdev->stack_event = NULL;
-	rtdm_mutex_destroy(&rtdev->xmit_mutex);
+	rtdev_destroy(rtdev);
 	kfree(rtdev);
     }
 }
+EXPORT_SYMBOL_GPL(rtdev_free);
+
+
+static void init_etherdev(struct rtnet_device *rtdev,
+			  struct module *module)
+{
+    rtdev->hard_header     = rt_eth_header;
+    rtdev->type            = ARPHRD_ETHER;
+    rtdev->hard_header_len = ETH_HLEN;
+    rtdev->mtu             = 1500; /* eth_mtu */
+    rtdev->addr_len        = ETH_ALEN;
+    rtdev->flags           = IFF_BROADCAST; /* TODO: IFF_MULTICAST; */
+    rtdev->get_mtu         = rt_hard_mtu;
+    rtdev->rt_owner	   = module;
+
+    memset(rtdev->broadcast, 0xFF, ETH_ALEN);
+    strcpy(rtdev->name, "rteth%d");
+}
+
+/**
+ * rt_init_etherdev - sets up an ethernet device
+ * @module: module initializing the device
+ *
+ * Fill in the fields of the device structure with ethernet-generic
+ * values. This routine can be used to set up a pre-allocated device
+ * structure. The device still needs to be registered afterwards.
+ */
+int __rt_init_etherdev(struct rtnet_device *rtdev,
+			unsigned dev_pool_size,
+			struct module *module)
+{
+    int ret;
 
+    ret = rtdev_init(rtdev, dev_pool_size);
+    if (ret)
+	    return ret;
+
+    init_etherdev(rtdev, module);
+
+    return 0;
+}
+EXPORT_SYMBOL_GPL(__rt_init_etherdev);
 
 
 /**
- * rtalloc_etherdev - Allocates and sets up an ethernet device
+ * rt_alloc_etherdev - Allocates and sets up an ethernet device
  * @sizeof_priv: size of additional driver-private structure to
  *               be allocated for this ethernet device
  * @dev_pool_size: size of the rx pool
- * @module: module creating the deivce
+ * @module: module creating the device
  *
- * Fill in the fields of the device structure with ethernet-generic
- * values. Basically does everything except registering the device.
+ * Allocates then fills in the fields of a new device structure with
+ * ethernet-generic values. Basically does everything except
+ * registering the device.
  *
  * A 32-byte alignment is enforced for the private data area.
  */
 struct rtnet_device *__rt_alloc_etherdev(unsigned sizeof_priv,
-					unsigned dev_pool_size,
-					struct module *module)
+					 unsigned dev_pool_size,
+					 struct module *module)
 {
     struct rtnet_device *rtdev;
 
@@ -338,21 +395,11 @@ struct rtnet_device *__rt_alloc_etherdev(unsigned sizeof_priv,
     if (!rtdev)
 	return NULL;
 
-    rtdev->hard_header     = rt_eth_header;
-    rtdev->type            = ARPHRD_ETHER;
-    rtdev->hard_header_len = ETH_HLEN;
-    rtdev->mtu             = 1500; /* eth_mtu */
-    rtdev->addr_len        = ETH_ALEN;
-    rtdev->flags           = IFF_BROADCAST; /* TODO: IFF_MULTICAST; */
-    rtdev->get_mtu         = rt_hard_mtu;
-    rtdev->rt_owner	   = module;
-
-    memset(rtdev->broadcast, 0xFF, ETH_ALEN);
-    strcpy(rtdev->name, "rteth%d");
+    init_etherdev(rtdev, module);
 
     return rtdev;
 }
-
+EXPORT_SYMBOL_GPL(__rt_alloc_etherdev);
 
 
 static inline int __rtdev_new_index(void)
@@ -907,9 +954,6 @@ unsigned int rt_hard_mtu(struct rtnet_device *rtdev, unsigned int priority)
 }
 
 
-EXPORT_SYMBOL_GPL(__rt_alloc_etherdev);
-EXPORT_SYMBOL_GPL(rtdev_free);
-
 EXPORT_SYMBOL_GPL(rtdev_alloc_name);
 
 EXPORT_SYMBOL_GPL(rt_register_rtnetdev);
-- 
2.17.2


