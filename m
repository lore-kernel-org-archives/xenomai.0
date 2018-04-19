From: Greg Gallagher <greg@embeddedgreg.com>
Date: Thu, 19 Apr 2018 00:14:55 -0400
Message-Id: <20180419041455.13807-1-greg@embeddedgreg.com>
Subject: [Xenomai] [PATCH] Increase RTDM_MAX_MINOR to 4096 form 1024
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Increase the number of RTDM devices that are allowed to be registered to 4096 to allow gpio drivers with higher pin numbers to be able to register in rtdm space.
---
 include/cobalt/kernel/rtdm/driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/cobalt/kernel/rtdm/driver.h b/include/cobalt/kernel/rtdm/driver.h
index 63beb484c..5a205852e 100644
--- a/include/cobalt/kernel/rtdm/driver.h
+++ b/include/cobalt/kernel/rtdm/driver.h
@@ -94,7 +94,7 @@ enum rtdm_selecttype;
 /** @} Device Flags */
 
 /** Maximum number of named devices per driver. */
-#define RTDM_MAX_MINOR	1024
+#define RTDM_MAX_MINOR	4096
 
 /** @} rtdm_device_register */
 
-- 
2.14.1


