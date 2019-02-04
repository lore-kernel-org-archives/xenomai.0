From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 10/18] net/rtdev: ensure per-device skbs get mapped at
 registration
Date: Mon,  4 Feb 2019 11:56:39 +0100
Message-Id: <20190204105647.5034-11-rpm@xenomai.org>
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

This patch works around a regression introduced by #74464ee37d0,
causing a new device's skbs not to be passed to its ->map_rtskb()
handler when registered, breaking further DMA inits in the driver.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/stack/rtdev.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/kernel/drivers/net/stack/rtdev.c b/kernel/drivers/net/stack/rtdev.c
index 631ca1804..7ece792e7 100644
--- a/kernel/drivers/net/stack/rtdev.c
+++ b/kernel/drivers/net/stack/rtdev.c
@@ -45,6 +45,7 @@ struct rtnet_device         *rtnet_devices[MAX_RT_DEVICES];
 static struct rtnet_device  *loopback_device;
 static DEFINE_RTDM_LOCK(rtnet_devices_rt_lock);
 static LIST_HEAD(rtskb_mapped_list);
+static LIST_HEAD(rtskb_mapwait_list);
 
 LIST_HEAD(event_hook_list);
 DEFINE_MUTEX(rtnet_devices_nrt_lock);
@@ -459,8 +460,12 @@ int rtdev_map_rtskb(struct rtskb *skb)
 	}
     }
 
-    if (!err && skb->buf_dma_addr != RTSKB_UNMAPPED)
-	list_add(&skb->entry, &rtskb_mapped_list);
+    if (!err) {
+        if (skb->buf_dma_addr != RTSKB_UNMAPPED)
+	    list_add(&skb->entry, &rtskb_mapped_list);
+        else
+	    list_add(&skb->entry, &rtskb_mapwait_list);
+    }
 
     mutex_unlock(&rtnet_devices_nrt_lock);
 
@@ -471,7 +476,7 @@ int rtdev_map_rtskb(struct rtskb *skb)
 
 static int rtdev_map_all_rtskbs(struct rtnet_device *rtdev)
 {
-    struct rtskb *skb;
+    struct rtskb *skb, *n;
     int err = 0;
 
     if (!rtdev->map_rtskb)
@@ -483,6 +488,14 @@ static int rtdev_map_all_rtskbs(struct rtnet_device *rtdev)
 	   break;
     }
 
+    list_for_each_entry_safe(skb, n, &rtskb_mapwait_list, entry) {
+	err = rtskb_map(rtdev, skb);
+	if (err)
+	   break;
+	list_del(&skb->entry);
+	list_add(&skb->entry, &rtskb_mapped_list);
+    }
+
     return err;
 }
 
@@ -580,7 +593,7 @@ int rt_register_rtnetdev(struct rtnet_device *rtdev)
 	    if (err)
 		    goto fail_link;
     }
-   
+
     err = rtdev_map_all_rtskbs(rtdev);
     if (err)
 	    goto fail_map;
-- 
2.17.2


