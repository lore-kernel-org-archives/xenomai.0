From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] drivers/can: Fix lock initialization
Message-ID: <8085906e-a222-c5a9-9c96-f297bcee28ff@siemens.com>
Date: Fri, 10 Dec 2021 11:36:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>
Cc: Dario Binacchi <dariobin@libero.it>

From: Jan Kiszka <jan.kiszka@siemens.com>

These locks must be initialized statically so that they can be used
prior to the first driver being registered, e.g. via
rtcan_socket_init().

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/can/rtcan_dev.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/kernel/drivers/can/rtcan_dev.c b/kernel/drivers/can/rtcan_dev.c
index 5caea3aa51..da64be75ca 100644
--- a/kernel/drivers/can/rtcan_dev.c
+++ b/kernel/drivers/can/rtcan_dev.c
@@ -36,29 +36,15 @@
 static struct rtcan_device *rtcan_devices[RTCAN_MAX_DEVICES];
 static DEFINE_RTDM_LOCK(rtcan_devices_rt_lock);
 
-static int rtcan_global_init_done;
-
 DEFINE_SEMAPHORE(rtcan_devices_nrt_lock);
 
 /* Spinlock for all reception lists and also for some members in
  * struct rtcan_socket */
-rtdm_lock_t rtcan_socket_lock;
+DEFINE_RTDM_LOCK(rtcan_socket_lock);
 
 /* Spinlock for all reception lists and also for some members in
  * struct rtcan_socket */
-rtdm_lock_t rtcan_recv_list_lock;
-
-
-
-static inline void rtcan_global_init(void)
-{
-    if (!rtcan_global_init_done) {
-	rtdm_lock_init(&rtcan_socket_lock);
-	rtdm_lock_init(&rtcan_recv_list_lock);
-	rtcan_global_init_done = 1;
-    }
-}
-
+DEFINE_RTDM_LOCK(rtcan_recv_list_lock);
 
 static inline struct rtcan_device *__rtcan_dev_get_by_name(const char *name)
 {
@@ -226,8 +212,6 @@ int rtcan_dev_register(struct rtcan_device *dev)
 
     down(&rtcan_devices_nrt_lock);
 
-    rtcan_global_init();
-
     if ((ret = __rtcan_dev_new_index()) < 0) {
 	up(&rtcan_devices_nrt_lock);
 	return ret;
-- 
2.31.1

