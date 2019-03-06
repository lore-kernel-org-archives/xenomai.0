From: roman.stratiienko@globallogic.com
Subject: [PATCH v2 06/10] kernel: cobalt: replace siginfo_t with
 kernel_siginfo_t
Date: Wed,  6 Mar 2019 19:53:27 +0200
Message-Id: <20190306175331.25444-6-roman.stratiienko@globallogic.com>
In-Reply-To: <20190306175331.25444-1-roman.stratiienko@globallogic.com>
References: <20190306175331.25444-1-roman.stratiienko@globallogic.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Roman Stratiienko <roman.stratiienko@globallogic.com>

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

siginfo_t can't be used in kernel-space starting from v4.20-rc1 commit
ae7795bc6187 ("signal: Distinguish between kernel_siginfo and siginfo")
replace all siginfo_t to kernel_siginfo_t and create wrapper for kernel < v4.20

Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---
 kernel/cobalt/include/linux/xenomai/wrappers.h | 4 ++++
 kernel/cobalt/posix/process.c                  | 2 +-
 kernel/cobalt/thread.c                         | 4 ++--
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/cobalt/include/linux/xenomai/wrappers.h b/kernel/cobalt/include/linux/xenomai/wrappers.h
index 7d00aa9d4..847d68088 100644
--- a/kernel/cobalt/include/linux/xenomai/wrappers.h
+++ b/kernel/cobalt/include/linux/xenomai/wrappers.h
@@ -49,4 +49,8 @@
 #define ipipe_root_nr_syscalls(ti)	NR_syscalls
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 20, 0)
+typedef siginfo_t kernel_siginfo_t;
+#endif
+
 #endif /* !_COBALT_LINUX_WRAPPERS_H */
diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 85dd3cfb7..ee4b70984 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -583,7 +583,7 @@ static inline void clear_threadinfo(void)
 static inline int disable_ondemand_memory(void)
 {
 	struct task_struct *p = current;
-	siginfo_t si;
+	kernel_siginfo_t si;
 
 	if ((p->mm->def_flags & VM_LOCKED) == 0) {
 		memset(&si, 0, sizeof(si));
diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
index a43d2f1ad..fa7a65569 100644
--- a/kernel/cobalt/thread.c
+++ b/kernel/cobalt/thread.c
@@ -2070,7 +2070,7 @@ void xnthread_relax(int notify, int reason)
 	struct xnthread *thread = xnthread_current();
 	struct task_struct *p = current;
 	int cpu __maybe_unused;
-	siginfo_t si;
+	kernel_siginfo_t si;
 
 	primary_mode_only();
 
@@ -2183,7 +2183,7 @@ static void lostage_task_signal(struct ipipe_work_header *work)
 	struct lostage_signal *rq;
 	struct xnthread *thread;
 	struct task_struct *p;
-	siginfo_t si;
+	kernel_siginfo_t si;
 	int signo;
 
 	rq = container_of(work, struct lostage_signal, work);
-- 
2.17.1


