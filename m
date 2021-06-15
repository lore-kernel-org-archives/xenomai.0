From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 3/3] cobalt: Move common user-return code out of pipeline
 diversion again
Date: Tue, 15 Jun 2021 08:56:33 +0200
Message-Id: <3d51a29c4e289302aa124a695c1f8022f967a2f3.1623740192.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1623740192.git.jan.kiszka@siemens.com>
References: <cover.1623740192.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Same pattern as for previous changes: All that code it common, no need
to duplicate it. The only difference was that I-pipe needs to call
ipipe_disable_user_intret_notifier first while dovetail does this
disabling automatically.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/dovetail/kevents.c | 31 ++-----------------------------
 kernel/cobalt/ipipe/kevents.c    | 32 ++------------------------------
 kernel/cobalt/posix/process.c    | 32 ++++++++++++++++++++++++++++++++
 kernel/cobalt/posix/process.h    |  2 ++
 4 files changed, 38 insertions(+), 59 deletions(-)

diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
index 96180731e6..3fbb5e6d64 100644
--- a/kernel/cobalt/dovetail/kevents.c
+++ b/kernel/cobalt/dovetail/kevents.c
@@ -102,36 +102,9 @@ static inline int handle_taskexit_event(struct task_struct *p)
 	return cobalt_handle_taskexit_event(p);
 }
 
-static int handle_user_return(struct task_struct *task)
+static inline int handle_user_return(struct task_struct *task)
 {
-	struct xnthread *thread;
-	spl_t s;
-	int err;
-
-	thread = xnthread_from_task(task);
-	if (thread == NULL)
-		return KEVENT_PROPAGATE;
-
-	if (xnthread_test_info(thread, XNCONTHI)) {
-		xnlock_get_irqsave(&nklock, s);
-		xnthread_clear_info(thread, XNCONTHI);
-		xnlock_put_irqrestore(&nklock, s);
-
-		err = xnthread_harden();
-
-		/*
-		 * XNCONTHI may or may not have been re-applied if
-		 * harden bailed out due to pending signals. Make sure
-		 * it is set in that case.
-		 */
-		if (err == -ERESTARTSYS) {
-			xnlock_get_irqsave(&nklock, s);
-			xnthread_set_info(thread, XNCONTHI);
-			xnlock_put_irqrestore(&nklock, s);
-		}
-	}
-
-	return KEVENT_PROPAGATE;
+	return cobalt_handle_user_return(task);
 }
 
 void handle_oob_mayday(struct pt_regs *regs)
diff --git a/kernel/cobalt/ipipe/kevents.c b/kernel/cobalt/ipipe/kevents.c
index 94a951d0a6..40ad93f398 100644
--- a/kernel/cobalt/ipipe/kevents.c
+++ b/kernel/cobalt/ipipe/kevents.c
@@ -401,38 +401,10 @@ static inline int handle_clockfreq_event(unsigned int *p)
 	return KEVENT_PROPAGATE;
 }
 
-static int handle_user_return(struct task_struct *task)
+static inline int handle_user_return(struct task_struct *task)
 {
-	struct xnthread *thread;
-	spl_t s;
-	int err;
-
 	ipipe_disable_user_intret_notifier();
-
-	thread = xnthread_from_task(task);
-	if (thread == NULL)
-		return KEVENT_PROPAGATE;
-
-	if (xnthread_test_info(thread, XNCONTHI)) {
-		xnlock_get_irqsave(&nklock, s);
-		xnthread_clear_info(thread, XNCONTHI);
-		xnlock_put_irqrestore(&nklock, s);
-
-		err = xnthread_harden();
-
-		/*
-		 * XNCONTHI may or may not have been re-applied if
-		 * harden bailed out due to pending signals. Make sure
-		 * it is set in that case.
-		 */
-		if (err == -ERESTARTSYS) {
-			xnlock_get_irqsave(&nklock, s);
-			xnthread_set_info(thread, XNCONTHI);
-			xnlock_put_irqrestore(&nklock, s);
-		}
-	}
-
-	return KEVENT_PROPAGATE;
+	return cobalt_handle_user_return(task);
 }
 
 int handle_ptrace_resume(struct ipipe_ptrace_resume_data *resume)
diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 3cbad9bbb0..aa384155a1 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -870,6 +870,38 @@ static void __handle_taskexit_event(struct task_struct *p)
 	}
 }
 
+int cobalt_handle_user_return(struct task_struct *task)
+{
+	struct xnthread *thread;
+	spl_t s;
+	int err;
+
+	thread = xnthread_from_task(task);
+	if (thread == NULL)
+		return KEVENT_PROPAGATE;
+
+	if (xnthread_test_info(thread, XNCONTHI)) {
+		xnlock_get_irqsave(&nklock, s);
+		xnthread_clear_info(thread, XNCONTHI);
+		xnlock_put_irqrestore(&nklock, s);
+
+		err = xnthread_harden();
+
+		/*
+		 * XNCONTHI may or may not have been re-applied if
+		 * harden bailed out due to pending signals. Make sure
+		 * it is set in that case.
+		 */
+		if (err == -ERESTARTSYS) {
+			xnlock_get_irqsave(&nklock, s);
+			xnthread_set_info(thread, XNCONTHI);
+			xnlock_put_irqrestore(&nklock, s);
+		}
+	}
+
+	return KEVENT_PROPAGATE;
+}
+
 static void detach_current(void)
 {
 	struct cobalt_threadinfo *p = pipeline_current();
diff --git a/kernel/cobalt/posix/process.h b/kernel/cobalt/posix/process.h
index de3d9144d7..45964ae57a 100644
--- a/kernel/cobalt/posix/process.h
+++ b/kernel/cobalt/posix/process.h
@@ -173,4 +173,6 @@ int cobalt_handle_taskexit_event(struct task_struct *task);
 
 int cobalt_handle_cleanup_event(struct mm_struct *mm);
 
+int cobalt_handle_user_return(struct task_struct *task);
+
 #endif /* !_COBALT_POSIX_PROCESS_H */
-- 
2.26.2


