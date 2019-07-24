From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH][3.0-backport] cobalt: syscall: don't bark at internal syscalls
Message-ID: <268ab3b0-cc0d-531c-1494-547871ea3eac@siemens.com>
Date: Wed, 24 Jul 2019 21:20:23 +0200
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
To: Xenomai <xenomai@xenomai.org>

From: Philippe Gerum <rpm@xenomai.org>

Some architectures may define a secondary system call range for
internal operations, fix the consistency check not to warn about them.

[Jan: backport to 3.0.x, taking care of ipipe_root_nr_syscalls moving]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

I noticed that we want this not only for secondary ranges, also for
running newer applications on older kernels when they probe for syscalls
that did not yet existed back then.

 .../cobalt/arch/arm/include/asm/xenomai/syscall.h  | 22 +++++++++++++---------
 .../arch/blackfin/include/asm/xenomai/syscall.h    | 18 +++++++++++-------
 .../arch/powerpc/include/asm/xenomai/syscall.h     | 18 +++++++++++-------
 .../cobalt/arch/x86/include/asm/xenomai/syscall.h  | 20 ++++++++++++--------
 kernel/cobalt/posix/syscall.c                      |  7 +++----
 5 files changed, 50 insertions(+), 35 deletions(-)

diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h
index 9e83007d36..362f0ebd8e 100644
--- a/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h
+++ b/kernel/cobalt/arch/arm/include/asm/xenomai/syscall.h
@@ -33,6 +33,11 @@
 #define __ARM_NR_ipipe	(__NR_SYSCALL_BASE + XENO_ARM_SYSCALL)
 #endif
 
+/*
+ * Cobalt syscall numbers can be fetched from ARM_ORIG_r0 with ARM_r7
+ * containing the Xenomai syscall marker, Linux syscalls directly from
+ * ARM_r7 (may require the OABI tweak).
+ */
 #define __xn_reg_sys(__regs)	((__regs)->ARM_ORIG_r0)
 /* In OABI_COMPAT mode, handle both OABI and EABI userspace syscalls */
 #ifdef CONFIG_OABI_COMPAT
@@ -46,16 +51,15 @@
 #define __xn_syscall(__regs)	(__xn_reg_sys(__regs) & ~__COBALT_SYSCALL_BIT)
 
 /*
- * Returns the syscall number depending on the handling core. Cobalt
- * syscall numbers can be fetched from ARM_ORIG_r0 with ARM_r7
- * containing the Xenomai syscall marker, Linux syscalls directly from
- * ARM_r7 (may require the OABI tweak).
+ * Root syscall number with predicate (valid only if
+ * !__xn_syscall_p(__regs)).
  */
-static inline long __xn_get_syscall_nr(struct pt_regs *regs)
-{
-	return __xn_syscall_p(regs) ? __xn_reg_sys(regs) : __xn_abi_decode(regs);
-}
-
+#define __xn_rootcall_p(__regs, __code)					\
+	({								\
+		*(__code) = __xn_abi_decode(__regs);			\
+		*(__code) < NR_syscalls || *(__code) >= __ARM_NR_BASE;	\
+	})
+	
 #define __xn_reg_rval(__regs)	((__regs)->ARM_r0)
 #define __xn_reg_arg1(__regs)	((__regs)->ARM_r1)
 #define __xn_reg_arg2(__regs)	((__regs)->ARM_r2)
diff --git a/kernel/cobalt/arch/blackfin/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/blackfin/include/asm/xenomai/syscall.h
index a62fa4972c..3e63f290b5 100644
--- a/kernel/cobalt/arch/blackfin/include/asm/xenomai/syscall.h
+++ b/kernel/cobalt/arch/blackfin/include/asm/xenomai/syscall.h
@@ -23,6 +23,10 @@
 #include <asm/ptrace.h>
 #include <asm-generic/xenomai/syscall.h>
 
+/*
+ * Cobalt and Linux syscall numbers can be fetched from P0, masking
+ * out the __COBALT_SYSCALL_BIT marker.
+ */
 #define __xn_reg_sys(__regs)	((__regs)->orig_p0)
 #define __xn_syscall_p(__regs)	(__xn_reg_sys(__regs) & __COBALT_SYSCALL_BIT)
 #define __xn_syscall(__regs)	(__xn_reg_sys(__regs) & ~__COBALT_SYSCALL_BIT)
@@ -35,14 +39,14 @@
 #define __xn_reg_arg5(__regs)	((__regs)->r4)
 
 /*
- * Returns the syscall number depending on the handling core. Cobalt
- * and Linux syscall numbers can be fetched from P0, masking out the
- * __COBALT_SYSCALL_BIT marker.
+ * Root syscall number with predicate (valid only if
+ * !__xn_syscall_p(__regs)).
  */
-static inline long __xn_get_syscall_nr(struct pt_regs *regs)
-{
-	return __xn_syscall(regs);
-}
+#define __xn_rootcall_p(__regs, __code)			\
+	({						\
+		*(__code) = __xn_syscall(__regs);	\
+		*(__code) < NR_syscalls;		\
+	})
 
 static inline void __xn_error_return(struct pt_regs *regs, int v)
 {
diff --git a/kernel/cobalt/arch/powerpc/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/powerpc/include/asm/xenomai/syscall.h
index 2edd5ebf29..9b166ad1b6 100644
--- a/kernel/cobalt/arch/powerpc/include/asm/xenomai/syscall.h
+++ b/kernel/cobalt/arch/powerpc/include/asm/xenomai/syscall.h
@@ -26,6 +26,10 @@
 #include <linux/ptrace.h>
 #include <asm-generic/xenomai/syscall.h>
 
+/*
+ * Cobalt and Linux syscall numbers can be fetched from GPR0, masking
+ * out the __COBALT_SYSCALL_BIT marker.
+ */
 #define __xn_reg_sys(__regs)	((__regs)->gpr[0])
 #define __xn_syscall_p(__regs)	(__xn_reg_sys(__regs) & __COBALT_SYSCALL_BIT)
 #define __xn_syscall(__regs)	(__xn_reg_sys(__regs) & ~__COBALT_SYSCALL_BIT)
@@ -40,14 +44,14 @@
 #define __xn_reg_sp(__regs)	((__regs)->gpr[1])
 
 /*
- * Returns the syscall number depending on the handling core. Cobalt
- * and Linux syscall numbers can be fetched from GPR0, masking out the
- * __COBALT_SYSCALL_BIT marker.
+ * Root syscall number with predicate (valid only if
+ * !__xn_syscall_p(__regs)).
  */
-static inline long __xn_get_syscall_nr(struct pt_regs *regs)
-{
-	return __xn_syscall(regs);
-}
+#define __xn_rootcall_p(__regs, __code)			\
+	({						\
+		*(__code) = __xn_syscall(__regs);	\
+		*(__code) < NR_syscalls;		\
+	})
 
 static inline void __xn_error_return(struct pt_regs *regs, int v)
 {
diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall.h
index 86be9f7edb..ea0e6fcb16 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall.h
@@ -23,6 +23,12 @@
 #include <asm/ptrace.h>
 #include <asm-generic/xenomai/syscall.h>
 
+/*
+ * Cobalt and Linux syscall numbers can be fetched from ORIG_AX,
+ * masking out the __COBALT_SYSCALL_BIT marker. Make sure to offset
+ * the number by __COBALT_X32_BASE for Cobalt 32-bit compat syscalls
+ * only.
+ */
 #define __xn_reg_sys(regs)    ((regs)->orig_ax)
 #define __xn_reg_rval(regs)   ((regs)->ax)
 #ifdef __i386__
@@ -50,15 +56,13 @@
 #endif
 
 /*
- * Returns the syscall number depending on the handling core. Cobalt
- * and Linux syscall numbers can be fetched from ORIG_AX, masking out
- * the __COBALT_SYSCALL_BIT marker. Make sure to offset the number by
- * __COBALT_X32_BASE for Cobalt 32-bit compat syscalls only.
+ * Root syscall number with predicate (valid only if
+ * !__xn_syscall_p(__regs)).
  */
-#define __xn_get_syscall_nr(__regs)					\
-	({								\
-		__xn_syscall_p(__regs) ? __xn_syscall(__regs) :		\
-			(__xn_reg_sys(__regs) & ~__COBALT_SYSCALL_BIT);	\
+#define __xn_rootcall_p(__regs, __code)			\
+	({						\
+		*(__code) = __xn_reg_sys(__regs);	\
+		*(__code) < ipipe_root_nr_syscalls(current_thread_info()); \
 	})
 
 static inline void __xn_error_return(struct pt_regs *regs, int v)
diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
index 67fc418935..99ca2d8f62 100644
--- a/kernel/cobalt/posix/syscall.c
+++ b/kernel/cobalt/posix/syscall.c
@@ -645,10 +645,6 @@ ret_handled:
 	return KEVENT_STOP;
 
 linux_syscall:
-	code = __xn_get_syscall_nr(regs);
-	if (code >= ipipe_root_nr_syscalls(current_thread_info()))
-		goto bad_syscall;
-
 	if (xnsched_root_p())
 		/*
 		 * The call originates from the Linux domain, either
@@ -658,6 +654,9 @@ linux_syscall:
 		 */
 		return KEVENT_PROPAGATE;
 
+	if (!__xn_rootcall_p(regs, &code))
+		goto bad_syscall;
+
 	/*
 	 * We know this is a Cobalt thread since it runs over the head
 	 * domain, however the current syscall should be handled by
-- 
2.16.4

