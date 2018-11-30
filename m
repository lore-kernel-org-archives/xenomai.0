From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [RFC][PATCH 3/7] cobalt/kernel: Reintroduce process-local thread list
Date: Fri, 30 Nov 2018 21:03:17 +0100
Message-Id: <fee35ce4d1a7a24ffaf52d266ea170b049f9c7aa.1543608201.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1543608201.git.jan.kiszka@siemens.com>
References: <cover.1543608201.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1543608201.git.jan.kiszka@siemens.com>
References: <cover.1543608201.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Track threads on a per-process basis again to make walking through them
cheaper.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/process.c | 3 ++-
 kernel/cobalt/posix/process.h | 3 ++-
 kernel/cobalt/posix/thread.c  | 4 +++-
 kernel/cobalt/posix/thread.h  | 2 +-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 1e679762aa..1b89ab7580 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -83,7 +83,7 @@ struct xnthread_personality *cobalt_personalities[NR_PERSONALITIES];
 
 static struct xnsynch yield_sync;
 
-LIST_HEAD(cobalt_thread_list);
+LIST_HEAD(cobalt_global_thread_list);
 
 struct cobalt_resources cobalt_global_resources = {
 	.condq = LIST_HEAD_INIT(cobalt_global_resources.condq),
@@ -1434,6 +1434,7 @@ static void *cobalt_process_attach(void)
 	INIT_LIST_HEAD(&process->resources.eventq);
 	INIT_LIST_HEAD(&process->resources.schedq);
 	INIT_LIST_HEAD(&process->sigwaiters);
+	INIT_LIST_HEAD(&process->thread_list);
 	xntree_init(&process->usems);
 	bitmap_fill(process->timers_map, CONFIG_XENO_OPT_NRTIMERS);
 	cobalt_set_process(process);
diff --git a/kernel/cobalt/posix/process.h b/kernel/cobalt/posix/process.h
index ad1f4c56bb..f867b8a919 100644
--- a/kernel/cobalt/posix/process.h
+++ b/kernel/cobalt/posix/process.h
@@ -51,6 +51,7 @@ struct cobalt_process {
 	struct rb_root usems;
 	struct list_head sigwaiters;
 	struct cobalt_resources resources;
+	struct list_head thread_list;
 	DECLARE_BITMAP(timers_map, CONFIG_XENO_OPT_NRTIMERS);
 	struct cobalt_timer *timers[CONFIG_XENO_OPT_NRTIMERS];
 	void *priv[NR_PERSONALITIES];
@@ -86,7 +87,7 @@ int cobalt_yield(xnticks_t min, xnticks_t max);
 
 int cobalt_process_init(void);
 
-extern struct list_head cobalt_thread_list;
+extern struct list_head cobalt_global_thread_list;
 
 extern struct cobalt_resources cobalt_global_resources;
 
diff --git a/kernel/cobalt/posix/thread.c b/kernel/cobalt/posix/thread.c
index 44f655a300..30c31bb6d9 100644
--- a/kernel/cobalt/posix/thread.c
+++ b/kernel/cobalt/posix/thread.c
@@ -359,6 +359,7 @@ static int pthread_create(struct cobalt_thread **thread_p,
 			  const struct sched_param_ex *param_ex,
 			  struct task_struct *task)
 {
+	struct cobalt_process *process = cobalt_current_process();
 	struct xnsched_class *sched_class;
 	union xnsched_policy_param param;
 	struct xnthread_init_attr iattr;
@@ -413,7 +414,8 @@ static int pthread_create(struct cobalt_thread **thread_p,
 	}
 
 	xnlock_get_irqsave(&nklock, s);
-	list_add_tail(&thread->next, &cobalt_thread_list);
+	list_add_tail(&thread->next, process ? &process->thread_list
+					     : &cobalt_global_thread_list);
 	xnlock_put_irqrestore(&nklock, s);
 
 	thread->hkey.u_pth = 0;
diff --git a/kernel/cobalt/posix/thread.h b/kernel/cobalt/posix/thread.h
index 5cc098afab..fec9d17859 100644
--- a/kernel/cobalt/posix/thread.h
+++ b/kernel/cobalt/posix/thread.h
@@ -91,7 +91,7 @@ struct cobalt_thread {
 	struct xnthread threadbase;
 	struct cobalt_extref extref;
 	struct cobalt_process *process;
-	struct list_head next;	/* in cobalt_thread_list */
+	struct list_head next;	/* in global/process thread_list */
 
 	/** Signal management. */
 	sigset_t sigpending;
-- 
2.16.4


