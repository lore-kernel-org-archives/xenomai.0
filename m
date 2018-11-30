Subject: [PATCH 2/2][noarch-4.14] ipipe: Introduce ptrace resume notifier
From: Jan Kiszka <jan.kiszka@siemens.com>
References: <8575c954-19f8-feaf-98bc-4153728579c9@siemens.com>
Message-ID: <a5e47987-34f6-b361-0adb-4da58ef91de9@siemens.com>
Date: Fri, 30 Nov 2018 21:07:17 +0100
MIME-Version: 1.0
In-Reply-To: <8575c954-19f8-feaf-98bc-4153728579c9@siemens.com>
Content-Type: text/plain; charset=utf-8
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
To: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

This I-pipe hook reports the desired resumption mode to the subscriber:
resume all process tasks or just single-step a particular one? The use
case is to enable synchronous stopping / resuming of all head tasks of
a ptraced real-time process.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/linux/ipipe_base.h   | 18 ++++++++++++++++++
 include/linux/ipipe_domain.h |  1 +
 kernel/ptrace.c              |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/include/linux/ipipe_base.h b/include/linux/ipipe_base.h
index d8429171a550..a59e1d19eb40 100644
--- a/include/linux/ipipe_base.h
+++ b/include/linux/ipipe_base.h
@@ -164,6 +164,21 @@ do {									\
 #define __ipipe_report_clockfreq_update(freq)				\
 	__ipipe_notify_kevent(IPIPE_KEVT_CLOCKFREQ, &(freq))
 
+struct ipipe_ptrace_resume_data {
+	struct task_struct *task;
+	long request;
+};
+
+#define __ipipe_report_ptrace_resume(__p, __request)			\
+	do {								\
+		struct ipipe_ptrace_resume_data d = {			\
+			.task = (__p),					\
+			.request = (__request),				\
+		};							\
+		if (ipipe_notifier_enabled_p(__p))			\
+			__ipipe_notify_kevent(IPIPE_KEVT_PTRESUME, &d); \
+	} while (0)
+
 int __ipipe_notify_syscall(struct pt_regs *regs);
 
 int __ipipe_notify_trap(int exception, struct pt_regs *regs);
@@ -203,6 +218,9 @@ static inline void __ipipe_report_exit(struct task_struct *p) { }
 
 static inline void __ipipe_report_cleanup(struct mm_struct *mm) { }
 
+static inline void __ipipe_report_ptrace_resume(struct task_struct *p,
+						long request) { }
+
 #define __ipipe_report_trap(exception, regs)  0
 
 #define hard_preempt_disable()		({ preempt_disable(); 0; })
diff --git a/include/linux/ipipe_domain.h b/include/linux/ipipe_domain.h
index f2ce31528389..2255659a9891 100644
--- a/include/linux/ipipe_domain.h
+++ b/include/linux/ipipe_domain.h
@@ -93,6 +93,7 @@ struct ipipe_vm_notifier;
 #define IPIPE_KEVT_HOSTRT	6
 #define IPIPE_KEVT_CLOCKFREQ	7
 #define IPIPE_KEVT_USERINTRET	8
+#define IPIPE_KEVT_PTRESUME	9
 
 typedef void (*ipipe_irq_ackfn_t)(struct irq_desc *desc);
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 84b1367935e4..942d71363a0c 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -809,6 +809,8 @@ static int ptrace_resume(struct task_struct *child, long request,
 		user_disable_single_step(child);
 	}
 
+	__ipipe_report_ptrace_resume(child, request);
+
 	/*
 	 * Change ->exit_code and ->state under siglock to avoid the race
 	 * with wait_task_stopped() in between; a non-zero ->exit_code will
-- 
2.16.4

