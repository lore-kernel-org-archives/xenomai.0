From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 4/5] Revert "cobalt/kernel: Introduce __SCHED_CURRENT policy
 to setschedparam_ex"
Date: Mon,  2 Dec 2019 08:12:17 +0100
Message-Id: <65a045606878421fbfebe1adb693a16be0556bae.1575270738.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1575270738.git.jan.kiszka@siemens.com>
References: <cover.1575270738.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1575270738.git.jan.kiszka@siemens.com>
References: <cover.1575270738.git.jan.kiszka@siemens.com>
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

This reverts commit b3c70f1a470397c915a6c206d07c7c342c164df4.

Was broken by design and is now no longer needed.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/uapi/sched.h        |  3 ---
 kernel/cobalt/posix/thread.c       | 10 ----------
 kernel/cobalt/trace/cobalt-posix.h |  3 +--
 3 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/include/cobalt/uapi/sched.h b/include/cobalt/uapi/sched.h
index 2a1df44b49..b672095c3b 100644
--- a/include/cobalt/uapi/sched.h
+++ b/include/cobalt/uapi/sched.h
@@ -21,9 +21,6 @@
 #define SCHED_COBALT		42
 #define SCHED_WEAK		43
 
-/* for internal use */
-#define __SCHED_CURRENT		44
-
 #ifndef SCHED_SPORADIC
 #define SCHED_SPORADIC		10
 #define sched_ss_low_priority	sched_u.ss.__sched_low_priority
diff --git a/kernel/cobalt/posix/thread.c b/kernel/cobalt/posix/thread.c
index c2a9fb46c5..bf9c082123 100644
--- a/kernel/cobalt/posix/thread.c
+++ b/kernel/cobalt/posix/thread.c
@@ -242,7 +242,6 @@ struct xnthread_personality *cobalt_thread_finalize(struct xnthread *zombie)
 int __cobalt_thread_setschedparam_ex(struct cobalt_thread *thread, int policy,
 				     const struct sched_param_ex *param_ex)
 {
-	struct xnthread *base_thread = &thread->threadbase;
 	struct xnsched_class *sched_class;
 	union xnsched_policy_param param;
 	xnticks_t tslice;
@@ -257,15 +256,6 @@ int __cobalt_thread_setschedparam_ex(struct cobalt_thread *thread, int policy,
 		goto out;
 	}
 
-	if (policy == __SCHED_CURRENT) {
-		policy = base_thread->base_class->policy;
-		if (xnthread_base_priority(base_thread) == 0)
-			policy = SCHED_NORMAL;
-		else if (base_thread->base_class == &xnsched_class_rt &&
-			 xnthread_test_state(base_thread, XNRRB))
-			policy = SCHED_RR;
-	}
-
 	tslice = thread->threadbase.rrperiod;
 	sched_class = cobalt_sched_policy_param(&param, policy,
 						param_ex, &tslice);
diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index 83ec748586..aa78efbc01 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -202,8 +202,7 @@ DECLARE_EVENT_CLASS(syscall_exit,
 			 {SCHED_QUOTA, "quota"},		\
 			 {SCHED_SPORADIC, "sporadic"},		\
 			 {SCHED_COBALT, "cobalt"},		\
-			 {SCHED_WEAK, "weak"},			\
-			 {__SCHED_CURRENT, "<current>"})
+			 {SCHED_WEAK, "weak"})
 
 const char *cobalt_trace_parse_sched_params(struct trace_seq *, int,
 					    struct sched_param_ex *);
-- 
2.16.4


