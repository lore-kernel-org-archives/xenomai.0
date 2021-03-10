From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH wip/dovetail] cobalt/syscall: Account for different syscall
 argument marshaling
Message-ID: <3c717e14-0494-75fa-90bd-738d5ac24972@siemens.com>
Date: Wed, 10 Mar 2021 16:52:13 +0100
MIME-Version: 1.0
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
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

I-pipe makes sure that arguments of compat calls are ordered just like
native calls. Dovetail does not. But it is better to use the kernel's
syscall_get_arguments for retrieving the arguments anyway. Introduce
pipeline_get_syscall_args to abstract that difference.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Applies on top of the dovetail branch, not yet next.

 include/cobalt/kernel/dovetail/pipeline/pipeline.h |  8 ++++++++
 include/cobalt/kernel/ipipe/pipeline/pipeline.h    | 12 ++++++++++++
 .../arm/dovetail/include/asm/xenomai/syscall.h     |  5 -----
 .../x86/dovetail/include/asm/xenomai/syscall.h     |  5 -----
 .../cobalt/include/asm-generic/xenomai/syscall.h   |  7 -------
 kernel/cobalt/posix/syscall.c                      | 14 ++++++++++----
 6 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/pipeline.h b/include/cobalt/kernel/dovetail/pipeline/pipeline.h
index 3cc7268d00..685af12af4 100644
--- a/include/cobalt/kernel/dovetail/pipeline/pipeline.h
+++ b/include/cobalt/kernel/dovetail/pipeline/pipeline.h
@@ -6,6 +6,7 @@
 #define _COBALT_KERNEL_DOVETAIL_PIPELINE_H
 
 #include <linux/irq_pipeline.h>
+#include <asm/syscall.h>
 #include <cobalt/kernel/assert.h>
 #include <asm/xenomai/features.h>
 #include <pipeline/machine.h>
@@ -90,4 +91,11 @@ static inline void pipeline_collect_features(struct cobalt_featinfo *f)
 	f->clock_freq = 0;	/* N/A */
 }
 
+static inline void pipeline_get_syscall_args(struct task_struct *task,
+					     struct pt_regs *regs,
+					     unsigned long *args)
+{
+	syscall_get_arguments(task, regs, args);
+}
+
 #endif /* !_COBALT_KERNEL_DOVETAIL_PIPELINE_H */
diff --git a/include/cobalt/kernel/ipipe/pipeline/pipeline.h b/include/cobalt/kernel/ipipe/pipeline/pipeline.h
index fda962568a..ac9c92b1b0 100644
--- a/include/cobalt/kernel/ipipe/pipeline/pipeline.h
+++ b/include/cobalt/kernel/ipipe/pipeline/pipeline.h
@@ -11,6 +11,7 @@
 
 #include <pipeline/machine.h>
 #include <asm/xenomai/features.h>
+#include <asm/xenomai/syscall.h>
 
 #define xnsched_primary_domain  cobalt_pipeline.domain
 
@@ -81,4 +82,15 @@ static inline void pipeline_collect_features(struct cobalt_featinfo *f)
 	f->clock_freq = cobalt_pipeline.clock_freq;
 }
 
+static inline void pipeline_get_syscall_args(struct task_struct *task,
+					     struct pt_regs *regs,
+					     unsigned long *args)
+{
+	*args++ = __xn_reg_arg1(regs);
+	*args++ = __xn_reg_arg2(regs);
+	*args++ = __xn_reg_arg3(regs);
+	*args++ = __xn_reg_arg4(regs);
+	*args   = __xn_reg_arg5(regs);
+}
+
 #endif /* !_COBALT_KERNEL_IPIPE_PIPELINE_H */
diff --git a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/syscall.h
index eb4ec1bbe1..fe8c1853aa 100644
--- a/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/syscall.h
+++ b/kernel/cobalt/arch/arm/dovetail/include/asm/xenomai/syscall.h
@@ -59,11 +59,6 @@
 	})
 
 #define __xn_reg_rval(__regs)	((__regs)->ARM_r0)
-#define __xn_reg_arg1(__regs)	((__regs)->ARM_r1)
-#define __xn_reg_arg2(__regs)	((__regs)->ARM_r2)
-#define __xn_reg_arg3(__regs)	((__regs)->ARM_r3)
-#define __xn_reg_arg4(__regs)	((__regs)->ARM_r4)
-#define __xn_reg_arg5(__regs)	((__regs)->ARM_r5)
 #define __xn_reg_pc(__regs)	((__regs)->ARM_ip)
 #define __xn_reg_sp(__regs)	((__regs)->ARM_sp)
 
diff --git a/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/syscall.h
index bf7a44ea0c..212840b5ef 100644
--- a/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/syscall.h
+++ b/kernel/cobalt/arch/x86/dovetail/include/asm/xenomai/syscall.h
@@ -29,11 +29,6 @@
  */
 #define __xn_reg_sys(regs)    ((regs)->orig_ax)
 #define __xn_reg_rval(regs)   ((regs)->ax)
-#define __xn_reg_arg1(regs)   ((regs)->di)
-#define __xn_reg_arg2(regs)   ((regs)->si)
-#define __xn_reg_arg3(regs)   ((regs)->dx)
-#define __xn_reg_arg4(regs)   ((regs)->r10)
-#define __xn_reg_arg5(regs)   ((regs)->r8)
 #define __xn_reg_pc(regs)     ((regs)->ip)
 #define __xn_reg_sp(regs)     ((regs)->sp)
 
diff --git a/kernel/cobalt/include/asm-generic/xenomai/syscall.h b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
index 91bbf3bfd1..194583c184 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/syscall.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
@@ -36,13 +36,6 @@
 #define access_wok(addr, size)	access_ok(VERIFY_WRITE, (addr), (size))
 #endif
 
-#define __xn_reg_arglist(regs)	\
-	__xn_reg_arg1(regs),	\
-	__xn_reg_arg2(regs),	\
-	__xn_reg_arg3(regs),	\
-	__xn_reg_arg4(regs),	\
-	__xn_reg_arg5(regs)
-
 #define __xn_copy_from_user(dstP, srcP, n)	raw_copy_from_user(dstP, srcP, n)
 #define __xn_copy_to_user(dstP, srcP, n)	raw_copy_to_user(dstP, srcP, n)
 #define __xn_put_user(src, dstP)		__put_user(src, dstP)
diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
index 30c33dda61..6a471758de 100644
--- a/kernel/cobalt/posix/syscall.c
+++ b/kernel/cobalt/posix/syscall.c
@@ -486,6 +486,7 @@ int handle_head_syscall(bool caller_is_relaxed, struct pt_regs *regs)
 	struct xnthread *thread;
 	cobalt_syshand handler;
 	struct task_struct *p;
+	unsigned long args[6];
 	unsigned int nr, code;
 	long ret;
 
@@ -592,7 +593,10 @@ restart:
 	 * handler (lostage ones), or rejected by allowed_syscall().
 	 */
 
-	ret = handler(__xn_reg_arglist(regs));
+	p = current;
+	pipeline_get_syscall_args(current, regs, args);
+
+	ret = handler(args[0], args[1], args[2], args[3], args[4]);
 	if (ret == -ENOSYS && (sysflags & __xn_exec_adaptive)) {
 		if (switched) {
 			ret = xnthread_harden();
@@ -611,7 +615,6 @@ done:
 	__xn_status_return(regs, ret);
 	sigs = 0;
 	if (!xnsched_root_p()) {
-		p = current;
 		if (signal_pending(p) ||
 		    xnthread_test_info(thread, XNKICKED)) {
 			sigs = 1;
@@ -677,6 +680,7 @@ int handle_root_syscall(struct pt_regs *regs)
 	struct xnthread *thread;
 	cobalt_syshand handler;
 	struct task_struct *p;
+	unsigned long args[6];
 	unsigned int nr, code;
 	long ret;
 
@@ -735,7 +739,10 @@ restart:
 			xnthread_propagate_schedparam(thread);
 	}
 
-	ret = handler(__xn_reg_arglist(regs));
+	p = current;
+	pipeline_get_syscall_args(p, regs, args);
+
+	ret = handler(args[0], args[1], args[2], args[3], args[4]);
 	if (ret == -ENOSYS && (sysflags & __xn_exec_adaptive)) {
 		sysflags ^= __xn_exec_histage;
 		if (switched) {
@@ -756,7 +763,6 @@ restart:
 		 * just invoked, so make sure to fetch it.
 		 */
 		thread = xnthread_current();
-		p = current;
 		if (signal_pending(p)) {
 			sigs = 1;
 			prepare_for_signal(p, thread, regs, sysflags);
-- 
2.26.2

