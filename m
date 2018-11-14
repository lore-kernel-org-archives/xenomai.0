From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 1/3] net: fix error checking in sysfs registration of device
Date: Wed, 14 Nov 2018 11:41:50 +0100
Message-Id: <20181114104152.11627-1-rpm@xenomai.org>
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

Commit #20818d457 did not check properly for failure of the
device_create() call.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/stack/rtdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/net/stack/rtdev.c b/kernel/drivers/net/stack/rtdev.c
index 7f7dcfdd3..b22da1395 100644
--- a/kernel/drivers/net/stack/rtdev.c
+++ b/kernel/drivers/net/stack/rtdev.c
@@ -522,7 +522,7 @@ int rt_register_rtnetdev(struct rtnet_device *rtdev)
 
     rtdev->sysdev = device_create(rtnet_class, NULL,
 		  MKDEV(0, rtdev->ifindex), rtdev, rtdev->name);
-    if (rtdev->sysdev == NULL) {
+    if (IS_ERR(rtdev->sysdev)) {
 	    err = PTR_ERR(rtdev->sysdev);
 	    goto fail;
     }
-- 
2.17.2


