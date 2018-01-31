From: Greg Gallagher <greg@embeddedgreg.com>
Date: Tue, 30 Jan 2018 21:36:20 -0500
Message-Id: <1517366181-6547-2-git-send-email-greg@embeddedgreg.com>
In-Reply-To: <1517366181-6547-1-git-send-email-greg@embeddedgreg.com>
References: <1517366181-6547-1-git-send-email-greg@embeddedgreg.com>
Subject: [Xenomai] [PATCH 2/3] Handle device paths from the device tree that
	start with a forward slash
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

If the device name from the device tree starts with a forward slash (/) the
rtdm device stores it in the registry including the forward slash.  When we
go to use that device and do the registry lookup we use a relative path from
/dev/rtdm which doesn't contain the forward slash and fails to find a match.
Open won't return an error but IO calls will fail.  To fix this when we
register an RTDM device skip the first character if it's a forward slash.

In my case the path from the device tree is
        /amba_pl/gpio@41200000/gpio905
which gets stored in the registry. When we want to use the device and look up
the device path in the registry we use
        amba_pl/gpio@41200000/gpio905
which won't find a match in the registry.

Tested on Zynq7000 gpio drivers
---
 kernel/cobalt/rtdm/device.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/cobalt/rtdm/device.c b/kernel/cobalt/rtdm/device.c
index 4533dfb..89e0815 100644
--- a/kernel/cobalt/rtdm/device.c
+++ b/kernel/cobalt/rtdm/device.c
@@ -91,9 +91,12 @@ struct rtdm_device *__rtdm_get_namedev(const char *path)
 	if (strncmp(path, "rtdm/", 5) == 0)
 		path += 5;
 
+	printk(KERN_ERR "path to bind %s\n", path);
 	ret = xnregistry_bind(path, XN_NONBLOCK, XN_RELATIVE, &handle);
-	if (ret)
+	if (ret) {
+		printk(KERN_ERR "xnreg bind fail %d\n", ret);
 		return NULL;
+	}
 
 	mutex_lock(&register_lock);
 
@@ -394,6 +397,7 @@ int rtdm_dev_register(struct rtdm_device *dev)
 	int ret, major, minor;
 	xnkey_t id;
 	dev_t rdev;
+	const char *dev_name;
 
 	secondary_mode_only();
 
@@ -446,8 +450,12 @@ int rtdm_dev_register(struct rtdm_device *dev)
 			ret = -ENOMEM;
 			goto fail;
 		}
-
-		ret = xnregistry_enter(dev->name, dev,
+		if (dev->name[0] == '/') {
+			dev_name = dev->name+1;
+		} else {
+			dev_name = dev->name;
+		}
+		ret = xnregistry_enter(dev_name, dev,
 				       &dev->named.handle, NULL);
 		if (ret)
 			goto fail;
-- 
2.7.4


