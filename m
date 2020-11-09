From: hongzha1 <hongzhan.chen@intel.com>
Subject: [PATCH 11/15] cobalt/thread: dovetail_init_altsched and then
 dovetail_start_altsched
Date: Mon,  9 Nov 2020 02:50:23 -0500
Message-Id: <20201109075027.14760-11-hongzhan.chen@intel.com>
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

call dovetail_init_altsched and then dovetail_start_altsched to
enable Dovetail notifier

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
---
 kernel/cobalt/thread.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 944840d4d..6ac949e99 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -2542,6 +2542,7 @@ int xnthread_map(struct xnthread *thread)
 
 	thread->u_window = NULL;
 	xnthread_pin_initial(thread);
+	dovetail_init_altsched(&thread->altsched);
 
 	xnthread_init_shadow_tcb(thread);
 	xnthread_suspend(thread, XNRELAX, XN_INFINITE, XN_RELATIVE, NULL);
@@ -2549,8 +2550,8 @@ int xnthread_map(struct xnthread *thread)
 	xnthread_set_state(thread, XNMAPPED);
 	xndebug_shadow_init(thread);
 	xnthread_run_handler(thread, map_thread);
-#warning TODO
-	//ipipe_enable_notifier(p);
+
+	dovetail_start_altsched();
 
 	/*
 	 * CAUTION: Soon after xnthread_init() has returned,
-- 
2.17.1


