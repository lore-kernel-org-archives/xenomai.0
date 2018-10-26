From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 6/9] net/stack: export services to switch interface up/down
Date: Fri, 26 Oct 2018 16:08:22 +0200
Message-Id: <20181026140825.5251-6-rpm@xenomai.org>
In-Reply-To: <20181026140825.5251-1-rpm@xenomai.org>
References: <20181026140825.5251-1-rpm@xenomai.org>
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

We may want to force a rtnet interface up, and more likely down before
unloading a driver module.

Export the ioctl() code which handles the IOC_RT_IFUP/IFDOWN core
ioctl requests as standalone routines. The locking model remains
unchanged, with ioctl() requests and direct service calls serializing
on the per-device lock.
---
 kernel/drivers/net/stack/include/rtdev.h |  4 +
 kernel/drivers/net/stack/rtdev.c         | 98 ++++++++++++++++++++++++
 kernel/drivers/net/stack/rtnet_chrdev.c  | 85 +-------------------
 3 files changed, 104 insertions(+), 83 deletions(-)

diff --git a/kernel/drivers/net/stack/include/rtdev.h b/kernel/drivers/net/stack/include/rtdev.h
index ad29cfaf2..ddc7aebcd 100644
--- a/kernel/drivers/net/stack/include/rtdev.h
+++ b/kernel/drivers/net/stack/include/rtdev.h
@@ -231,6 +231,10 @@ unsigned int rt_hard_mtu(struct rtnet_device *rtdev, unsigned int priority);
 int rtdev_open(struct rtnet_device *rtdev);
 int rtdev_close(struct rtnet_device *rtdev);
 
+int rtdev_up(struct rtnet_device *rtdev,
+	     struct rtnet_core_cmd *cmd);
+int rtdev_down(struct rtnet_device *rtdev);
+
 int rtdev_map_rtskb(struct rtskb *skb);
 void rtdev_unmap_rtskb(struct rtskb *skb);
 
diff --git a/kernel/drivers/net/stack/rtdev.c b/kernel/drivers/net/stack/rtdev.c
index ed6e55fcf..8f3460afd 100644
--- a/kernel/drivers/net/stack/rtdev.c
+++ b/kernel/drivers/net/stack/rtdev.c
@@ -650,7 +650,105 @@ void rtdev_del_event_hook(struct rtdev_event_hook *hook)
     mutex_unlock(&rtnet_devices_nrt_lock);
 }
 
+int rtdev_up(struct rtnet_device *rtdev, struct rtnet_core_cmd *cmd)
+{
+	struct list_head        *entry;
+	struct rtdev_event_hook *hook;
+	int ret = 0;
+
+	if (mutex_lock_interruptible(&rtdev->nrt_lock))
+		return -ERESTARTSYS;
+
+	/* We cannot change the promisc flag or the hardware address if
+	   the device is already up. */
+	if ((rtdev->flags & IFF_UP) &&
+	    (((cmd->args.up.set_dev_flags | cmd->args.up.clear_dev_flags) &
+	      IFF_PROMISC) ||
+	     (cmd->args.up.dev_addr_type != ARPHRD_VOID))) {
+		ret = -EBUSY;
+		goto up_out;
+	}
+
+	rtdev->flags |= cmd->args.up.set_dev_flags;
+	rtdev->flags &= ~cmd->args.up.clear_dev_flags;
+
+	if (cmd->args.up.dev_addr_type != ARPHRD_VOID) {
+		if (cmd->args.up.dev_addr_type != rtdev->type) {
+			ret = -EINVAL;
+			goto up_out;
+		}
+		memcpy(rtdev->dev_addr, cmd->args.up.dev_addr, MAX_ADDR_LEN);
+	}
+
+	set_bit(PRIV_FLAG_UP, &rtdev->priv_flags);
+
+	ret = rtdev_open(rtdev);    /* also == 0 if rtdev is already up */
+
+	if (ret == 0) {
+		mutex_lock(&rtnet_devices_nrt_lock);
+
+		list_for_each(entry, &event_hook_list) {
+			hook = list_entry(entry, struct rtdev_event_hook, entry);
+			if (hook->ifup)
+				hook->ifup(rtdev, cmd);
+		}
+
+		mutex_unlock(&rtnet_devices_nrt_lock);
+	} else
+		clear_bit(PRIV_FLAG_UP, &rtdev->priv_flags);
+
+up_out:
+	mutex_unlock(&rtdev->nrt_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rtdev_up);
+
+int rtdev_down(struct rtnet_device *rtdev)
+{
+	struct list_head        *entry;
+	struct rtdev_event_hook *hook;
+	rtdm_lockctx_t          context;
+	int ret = 0;
 
+	if (mutex_lock_interruptible(&rtdev->nrt_lock))
+		return -ERESTARTSYS;
+
+	/* spin lock required for sync with routing code */
+	rtdm_lock_get_irqsave(&rtdev->rtdev_lock, context);
+
+	if (test_bit(PRIV_FLAG_ADDING_ROUTE, &rtdev->priv_flags)) {
+		rtdm_lock_put_irqrestore(&rtdev->rtdev_lock, context);
+
+		mutex_unlock(&rtdev->nrt_lock);
+		return -EBUSY;
+	}
+	clear_bit(PRIV_FLAG_UP, &rtdev->priv_flags);
+
+	rtdm_lock_put_irqrestore(&rtdev->rtdev_lock, context);
+
+	if (rtdev->mac_detach != NULL)
+		ret = rtdev->mac_detach(rtdev);
+
+	if (ret == 0) {
+		mutex_lock(&rtnet_devices_nrt_lock);
+
+		list_for_each(entry, &event_hook_list) {
+			hook = list_entry(entry, struct rtdev_event_hook, entry);
+			if (hook->ifdown)
+				hook->ifdown(rtdev);
+		}
+
+		mutex_unlock(&rtnet_devices_nrt_lock);
+
+		ret = rtdev_close(rtdev);
+	}
+
+	mutex_unlock(&rtdev->nrt_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rtdev_down);
 
 /***
  *  rtdev_open
diff --git a/kernel/drivers/net/stack/rtnet_chrdev.c b/kernel/drivers/net/stack/rtnet_chrdev.c
index f5f32c978..14ccbabaf 100644
--- a/kernel/drivers/net/stack/rtnet_chrdev.c
+++ b/kernel/drivers/net/stack/rtnet_chrdev.c
@@ -88,16 +88,11 @@ static long rtnet_ioctl(struct file *file,
     return -ENOTTY;
 }
 
-
-
 static int rtnet_core_ioctl(struct rtnet_device *rtdev, unsigned int request,
 			    unsigned long arg)
 {
     struct rtnet_core_cmd   cmd;
-    struct list_head        *entry;
-    struct rtdev_event_hook *hook;
     int                     ret;
-    rtdm_lockctx_t          context;
 
 
     ret = copy_from_user(&cmd, (void *)arg, sizeof(cmd));
@@ -106,87 +101,11 @@ static int rtnet_core_ioctl(struct rtnet_device *rtdev, unsigned int request,
 
     switch (request) {
 	case IOC_RT_IFUP:
-	    if (mutex_lock_interruptible(&rtdev->nrt_lock))
-		return -ERESTARTSYS;
-
-	    /* We cannot change the promisc flag or the hardware address if
-	       the device is already up. */
-	    if ((rtdev->flags & IFF_UP) &&
-		(((cmd.args.up.set_dev_flags | cmd.args.up.clear_dev_flags) &
-		  IFF_PROMISC) ||
-		 (cmd.args.up.dev_addr_type != ARPHRD_VOID))) {
-		ret = -EBUSY;
-		goto up_out;
-	    }
-
-	    rtdev->flags |= cmd.args.up.set_dev_flags;
-	    rtdev->flags &= ~cmd.args.up.clear_dev_flags;
-
-	    if (cmd.args.up.dev_addr_type != ARPHRD_VOID) {
-		if (cmd.args.up.dev_addr_type != rtdev->type) {
-		    ret = -EINVAL;
-		    goto up_out;
-		}
-		memcpy(rtdev->dev_addr, cmd.args.up.dev_addr, MAX_ADDR_LEN);
-	    }
-
-	    set_bit(PRIV_FLAG_UP, &rtdev->priv_flags);
-
-	    ret = rtdev_open(rtdev);    /* also == 0 if rtdev is already up */
-
-	    if (ret == 0) {
-		mutex_lock(&rtnet_devices_nrt_lock);
-
-		list_for_each(entry, &event_hook_list) {
-		    hook = list_entry(entry, struct rtdev_event_hook, entry);
-		    if (hook->ifup)
-			hook->ifup(rtdev, &cmd);
-		}
-
-		mutex_unlock(&rtnet_devices_nrt_lock);
-	    } else
-		clear_bit(PRIV_FLAG_UP, &rtdev->priv_flags);
-
-	  up_out:
-	    mutex_unlock(&rtdev->nrt_lock);
+	    ret = rtdev_up(rtdev, &cmd);
 	    break;
 
 	case IOC_RT_IFDOWN:
-	    if (mutex_lock_interruptible(&rtdev->nrt_lock))
-		return -ERESTARTSYS;
-
-	    /* spin lock required for sync with routing code */
-	    rtdm_lock_get_irqsave(&rtdev->rtdev_lock, context);
-
-	    if (test_bit(PRIV_FLAG_ADDING_ROUTE, &rtdev->priv_flags)) {
-		rtdm_lock_put_irqrestore(&rtdev->rtdev_lock, context);
-
-		mutex_unlock(&rtdev->nrt_lock);
-		return -EBUSY;
-	    }
-	    clear_bit(PRIV_FLAG_UP, &rtdev->priv_flags);
-
-	    rtdm_lock_put_irqrestore(&rtdev->rtdev_lock, context);
-
-	    ret = 0;
-	    if (rtdev->mac_detach != NULL)
-		ret = rtdev->mac_detach(rtdev);
-
-	    if (ret == 0) {
-		mutex_lock(&rtnet_devices_nrt_lock);
-
-		list_for_each(entry, &event_hook_list) {
-		    hook = list_entry(entry, struct rtdev_event_hook, entry);
-		    if (hook->ifdown)
-			hook->ifdown(rtdev);
-		}
-
-		mutex_unlock(&rtnet_devices_nrt_lock);
-
-		ret = rtdev_close(rtdev);
-	    }
-
-	    mutex_unlock(&rtdev->nrt_lock);
+	    ret = rtdev_down(rtdev);
 	    break;
 
 	case IOC_RT_IFINFO:
-- 
2.17.2


