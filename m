From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 7/9] net/stack: ignore extraneous interface UP/DOWN calls
Date: Fri, 26 Oct 2018 16:08:23 +0200
Message-Id: <20181026140825.5251-7-rpm@xenomai.org>
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

Changing the device flags now implies downing the interface prior to
switching it up anew with a different set of flags.

Return success upon useless calls (e.g. UP when iface is up, DOWN when
iface is down).
---
 kernel/drivers/net/stack/rtdev.c | 39 ++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/kernel/drivers/net/stack/rtdev.c b/kernel/drivers/net/stack/rtdev.c
index 8f3460afd..7f7dcfdd3 100644
--- a/kernel/drivers/net/stack/rtdev.c
+++ b/kernel/drivers/net/stack/rtdev.c
@@ -666,21 +666,24 @@ int rtdev_up(struct rtnet_device *rtdev, struct rtnet_core_cmd *cmd)
 	      IFF_PROMISC) ||
 	     (cmd->args.up.dev_addr_type != ARPHRD_VOID))) {
 		ret = -EBUSY;
-		goto up_out;
+		goto out;
 	}
 
+	if (cmd->args.up.dev_addr_type != ARPHRD_VOID &&
+	    cmd->args.up.dev_addr_type != rtdev->type) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Skip upon extraneous call only after args have been checked. */
+	if (test_and_set_bit(PRIV_FLAG_UP, &rtdev->priv_flags))
+		goto out;
+
 	rtdev->flags |= cmd->args.up.set_dev_flags;
 	rtdev->flags &= ~cmd->args.up.clear_dev_flags;
 
-	if (cmd->args.up.dev_addr_type != ARPHRD_VOID) {
-		if (cmd->args.up.dev_addr_type != rtdev->type) {
-			ret = -EINVAL;
-			goto up_out;
-		}
+	if (cmd->args.up.dev_addr_type != ARPHRD_VOID)
 		memcpy(rtdev->dev_addr, cmd->args.up.dev_addr, MAX_ADDR_LEN);
-	}
-
-	set_bit(PRIV_FLAG_UP, &rtdev->priv_flags);
 
 	ret = rtdev_open(rtdev);    /* also == 0 if rtdev is already up */
 
@@ -696,8 +699,7 @@ int rtdev_up(struct rtnet_device *rtdev, struct rtnet_core_cmd *cmd)
 		mutex_unlock(&rtnet_devices_nrt_lock);
 	} else
 		clear_bit(PRIV_FLAG_UP, &rtdev->priv_flags);
-
-up_out:
+out:
 	mutex_unlock(&rtdev->nrt_lock);
 
 	return ret;
@@ -718,12 +720,12 @@ int rtdev_down(struct rtnet_device *rtdev)
 	rtdm_lock_get_irqsave(&rtdev->rtdev_lock, context);
 
 	if (test_bit(PRIV_FLAG_ADDING_ROUTE, &rtdev->priv_flags)) {
-		rtdm_lock_put_irqrestore(&rtdev->rtdev_lock, context);
-
-		mutex_unlock(&rtdev->nrt_lock);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto fail;
 	}
-	clear_bit(PRIV_FLAG_UP, &rtdev->priv_flags);
+
+	if (!test_and_clear_bit(PRIV_FLAG_UP, &rtdev->priv_flags))
+		goto fail;
 
 	rtdm_lock_put_irqrestore(&rtdev->rtdev_lock, context);
 
@@ -743,10 +745,13 @@ int rtdev_down(struct rtnet_device *rtdev)
 
 		ret = rtdev_close(rtdev);
 	}
-
+out:
 	mutex_unlock(&rtdev->nrt_lock);
 
 	return ret;
+fail:
+	rtdm_lock_put_irqrestore(&rtdev->rtdev_lock, context);
+	goto out;
 }
 EXPORT_SYMBOL_GPL(rtdev_down);
 
-- 
2.17.2


