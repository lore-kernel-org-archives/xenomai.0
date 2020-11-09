From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 08/15] cobalt/thread: call dovetail_leave_inband to replace
 __ipipe_migrate_head
Date: Mon,  9 Nov 2020 02:50:20 -0500
Message-Id: <20201109075027.14760-8-hongzhan.chen@intel.com>
In-Reply-To: <20201109075027.14760-1-hongzhan.chen@intel.com>
References: <20201109075027.14760-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jan.kiszka@siemens.com, xenomai@xenomai.org

leave inband on dovetail

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
---
 kernel/cobalt/thread.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 7a6139142..e2a215703 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -1950,8 +1950,8 @@ int xnthread_harden(void)
 
 	xnthread_clear_sync_window(thread, XNRELAX);
 
-#warning TODO
-	ret = 0;//__ipipe_migrate_head();
+	/* Please refer to evl_switch_oob */
+	ret = dovetail_leave_inband();
 	if (ret) {
 		xnthread_test_cancel();
 		xnthread_set_sync_window(thread, XNRELAX);
-- 
2.17.1


