From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [PATCH] cobalt/thread: initialize sigarray in __xnthread_init
Date: Tue, 15 Jun 2021 22:19:43 -0400
Message-Id: <20210616021943.13526-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Add missing sigarray initialization to avoid missing signal in
__xnthread_signal.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index d096a20d3..49913accc 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -287,6 +287,8 @@ int __xnthread_init(struct xnthread *thread,
 	thread->cookie = NULL;
 	init_completion(&thread->exited);
 	memset(xnthread_archtcb(thread), 0, sizeof(struct xnarchtcb));
+	memset(thread->sigarray, 0, sizeof(thread->sigarray[0]) *
+				XNTHREAD_MAX_SIGNALS);
 
 	gravity = flags & XNUSER ? XNTIMER_UGRAVITY : XNTIMER_KGRAVITY;
 	xntimer_init(&thread->rtimer, &nkclock, timeout_handler,
-- 
2.17.1


