From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5ec34b95-3d0a-c57c-fbbf-dd8ce11f31cd@siemens.com>
Date: Thu, 8 Mar 2018 16:55:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] cobalt/thread: Move tcb clearing into
	__xnthread_init
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This both de-duplicates the code and ensures that all fields are zeroed
prior to calling one of the actual tcb initialization functions.
Specifically if host_task is not properly cleaned, we may cause a bug
when using the field earlier, e.g.

general protection fault: 0000 [#1] PREEMPT SMP
[...]
RIP: 0010:[<ffffffff81185a3c>]  [<ffffffff81185a3c>] xnthread_host_pid+0x1c/0x30
[..]
Call Trace:
 [<ffffffff8117c987>] trace_event_raw_event_cobalt_thread_set_current_prio+0x57/0xa0
 [<ffffffff8117f33d>] xnsched_set_effective_priority+0x8d/0xc0
 [<ffffffff8117a1e4>] xnsched_rt_setparam+0x14/0x30
 [<ffffffff8117e700>] xnsched_set_policy+0xc0/0x170
 [<ffffffff81185687>] __xnthread_init+0x317/0x3d0
 [<ffffffff8114a3e8>] ? trace_buffer_unlock_commit+0x58/0x70
 [<ffffffff811857bb>] xnthread_init+0x7b/0x110

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/thread.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index 3d84ddd7b..ebdecfa91 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -212,6 +212,7 @@ int __xnthread_init(struct xnthread *thread,
 	thread->entry = NULL;
 	thread->cookie = NULL;
 	init_completion(&thread->exited);
+	memset(xnthread_archtcb(thread), 0, sizeof(struct xnarchtcb));
 
 	gravity = flags & XNUSER ? XNTIMER_UGRAVITY : XNTIMER_KGRAVITY;
 	xntimer_init(&thread->rtimer, &nkclock, timeout_handler,
@@ -260,7 +261,6 @@ void xnthread_init_shadow_tcb(struct xnthread *thread)
 	 */
 	__ipipe_share_current(0);
 
-	memset(tcb, 0, sizeof(*tcb));
 	tcb->core.host_task = p;
 	tcb->core.tsp = &p->thread;
 	tcb->core.mm = p->mm;
@@ -279,7 +279,6 @@ void xnthread_init_root_tcb(struct xnthread *thread)
 	struct xnarchtcb *tcb = xnthread_archtcb(thread);
 	struct task_struct *p = current;
 
-	memset(tcb, 0, sizeof(*tcb));
 	tcb->core.host_task = p;
 	tcb->core.tsp = &tcb->core.ts;
 	tcb->core.mm = p->mm;
-- 
2.13.6

