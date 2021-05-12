From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 6/7] cobalt/x86: remove support for the x32 ABI
Date: Wed, 12 May 2021 12:05:56 +0200
Message-Id: <38bbe6d6cbdc0807ea1c8776f9e07b0047d0f2ee.1620813957.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1620813957.git.jan.kiszka@siemens.com>
References: <cover.1620813957.git.jan.kiszka@siemens.com>
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

From: Philippe Gerum <rpm@xenomai.org>

After raising the topic of (dis)continuing support for the x32 ABI
multiple times on the mailing list, it turned out that Xenomai has no
known users of this dying ABI. So let's remove it.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 .../x86/include/asm/xenomai/uapi/syscall.h    |  8 +-
 .../x86/ipipe/include/asm/xenomai/syscall.h   |  4 +-
 .../include/asm/xenomai/syscall32-table.h     | 16 ----
 .../x86/ipipe/include/asm/xenomai/syscall32.h | 90 +------------------
 kernel/cobalt/posix/syscall.c                 | 44 +++++----
 kernel/cobalt/posix/syscall32.c               | 26 ------
 kernel/cobalt/posix/syscall32.h               |  6 --
 kernel/cobalt/trace/cobalt-posix.h            |  7 --
 8 files changed, 25 insertions(+), 176 deletions(-)

diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/syscall.h b/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/syscall.h
index aa9936dfd1..500d169368 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/syscall.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/uapi/syscall.h
@@ -18,12 +18,6 @@
 #ifndef _COBALT_X86_ASM_UAPI_SYSCALL_H
 #define _COBALT_X86_ASM_UAPI_SYSCALL_H
 
-#ifdef __ILP32__
-#define __xn_syscall_base  __COBALT_X32_BASE
-#else
-#define __xn_syscall_base  0
-#endif
-
-#define __xn_syscode(__nr)	(__COBALT_SYSCALL_BIT | (__nr + __xn_syscall_base))
+#define __xn_syscode(__nr)	(__COBALT_SYSCALL_BIT | __nr)
 
 #endif /* !_COBALT_X86_ASM_UAPI_SYSCALL_H */
diff --git a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall.h
index ea0e6fcb16..f3f1b476f7 100644
--- a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall.h
+++ b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall.h
@@ -25,9 +25,7 @@
 
 /*
  * Cobalt and Linux syscall numbers can be fetched from ORIG_AX,
- * masking out the __COBALT_SYSCALL_BIT marker. Make sure to offset
- * the number by __COBALT_X32_BASE for Cobalt 32-bit compat syscalls
- * only.
+ * masking out the __COBALT_SYSCALL_BIT marker.
  */
 #define __xn_reg_sys(regs)    ((regs)->orig_ax)
 #define __xn_reg_rval(regs)   ((regs)->ax)
diff --git a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall32-table.h b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall32-table.h
index 4784377b06..fb55d8863a 100644
--- a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall32-table.h
+++ b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall32-table.h
@@ -29,7 +29,6 @@ __COBALT_CALL32emu_THUNK(thread_setschedparam_ex)
 __COBALT_CALL32emu_THUNK(thread_getschedparam_ex)
 __COBALT_CALL32emu_THUNK(thread_setschedprio)
 __COBALT_CALL32emu_THUNK(sem_open)
-__COBALT_CALL32x_THUNK(sem_open)
 __COBALT_CALL32emu_THUNK(sem_timedwait)
 __COBALT_CALL32emu_THUNK(clock_getres)
 __COBALT_CALL32emu_THUNK(clock_gettime)
@@ -38,46 +37,31 @@ __COBALT_CALL32emu_THUNK(clock_nanosleep)
 __COBALT_CALL32emu_THUNK(mutex_timedlock)
 __COBALT_CALL32emu_THUNK(cond_wait_prologue)
 __COBALT_CALL32emu_THUNK(mq_open)
-__COBALT_CALL32x_THUNK(mq_open)
 __COBALT_CALL32emu_THUNK(mq_getattr)
-__COBALT_CALL32x_THUNK(mq_getattr)
 __COBALT_CALL32emu_THUNK(mq_timedsend)
 __COBALT_CALL32emu_THUNK(mq_timedreceive)
-__COBALT_CALL32x_pure_THUNK(mq_timedreceive)
 __COBALT_CALL32emu_THUNK(mq_notify)
-__COBALT_CALL32x_THUNK(mq_notify)
 __COBALT_CALL32emu_THUNK(sched_weightprio)
 __COBALT_CALL32emu_THUNK(sched_setconfig_np)
 __COBALT_CALL32emu_THUNK(sched_getconfig_np)
 __COBALT_CALL32emu_THUNK(sched_setscheduler_ex)
 __COBALT_CALL32emu_THUNK(sched_getscheduler_ex)
 __COBALT_CALL32emu_THUNK(timer_create)
-__COBALT_CALL32x_THUNK(timer_create)
 __COBALT_CALL32emu_THUNK(timer_settime)
 __COBALT_CALL32emu_THUNK(timer_gettime)
 __COBALT_CALL32emu_THUNK(timerfd_settime)
 __COBALT_CALL32emu_THUNK(timerfd_gettime)
 __COBALT_CALL32emu_THUNK(sigwait)
-__COBALT_CALL32x_THUNK(sigwait)
 __COBALT_CALL32emu_THUNK(sigtimedwait)
-__COBALT_CALL32x_THUNK(sigtimedwait)
 __COBALT_CALL32emu_THUNK(sigwaitinfo)
-__COBALT_CALL32x_THUNK(sigwaitinfo)
 __COBALT_CALL32emu_THUNK(sigpending)
-__COBALT_CALL32x_THUNK(sigpending)
 __COBALT_CALL32emu_THUNK(sigqueue)
-__COBALT_CALL32x_THUNK(sigqueue)
 __COBALT_CALL32emu_THUNK(monitor_wait)
 __COBALT_CALL32emu_THUNK(event_wait)
 __COBALT_CALL32emu_THUNK(select)
-__COBALT_CALL32x_THUNK(select)
 __COBALT_CALL32emu_THUNK(recvmsg)
-__COBALT_CALL32x_THUNK(recvmsg)
 __COBALT_CALL32emu_THUNK(sendmsg)
-__COBALT_CALL32x_THUNK(sendmsg)
 __COBALT_CALL32emu_THUNK(mmap)
-__COBALT_CALL32x_THUNK(mmap)
 __COBALT_CALL32emu_THUNK(backtrace)
-__COBALT_CALL32x_THUNK(backtrace)
 
 #endif /* !_COBALT_X86_ASM_SYSCALL32_TABLE_H */
diff --git a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall32.h b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall32.h
index 35a7b0d101..a0395e1872 100644
--- a/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall32.h
+++ b/kernel/cobalt/arch/x86/ipipe/include/asm/xenomai/syscall32.h
@@ -21,76 +21,6 @@
 
 #include <asm/unistd.h>
 
-#ifdef CONFIG_X86_X32
-
-#define __COBALT_X32_BASE		128
-
-#define __COBALT_SYSNR32x(__reg)			\
-	({						\
-		long __nr = __reg;			\
-		if (__nr & __X32_SYSCALL_BIT) {		\
-			__nr &= ~__X32_SYSCALL_BIT;	\
-			__nr += __COBALT_X32_BASE;	\
-		}					\
-		__nr;					\
-	})
-
-#define __COBALT_COMPAT32x(__reg)			\
-	(((__reg) & __X32_SYSCALL_BIT) ? __COBALT_COMPATX_BIT : 0)
-
-#if __NR_COBALT_SYSCALLS > __COBALT_X32_BASE
-#error "__NR_COBALT_SYSCALLS > __COBALT_X32_BASE"
-#endif
-
-#define __syshand32x__(__name)	((cobalt_syshand)(CoBaLt32x_ ## __name))
-
-#define __COBALT_CALL32x_INITHAND(__handler)	\
-	[__COBALT_X32_BASE ... __COBALT_X32_BASE + __NR_COBALT_SYSCALLS-1] = __handler,
-
-#define __COBALT_CALL32x_INITMODE(__mode)	\
-	[__COBALT_X32_BASE ... __COBALT_X32_BASE + __NR_COBALT_SYSCALLS-1] = __mode,
-
-/* x32 default entry (no thunk) */
-#define __COBALT_CALL32x_ENTRY(__name, __handler)		\
-	[sc_cobalt_ ## __name + __COBALT_X32_BASE] = __handler,
-
-/* x32 thunk installation */
-#define __COBALT_CALL32x_pure_THUNK(__name)	\
-	__COBALT_CALL32x_ENTRY(__name, __syshand32x__(__name))
-
-#define __COBALT_CALL32x_THUNK(__name)	\
-	__COBALT_CALL32x_ENTRY(__name, __syshand32emu__(__name))
-
-/* x32 thunk implementation. */
-#define COBALT_SYSCALL32x(__name, __mode, __args)	\
-	long CoBaLt32x_ ## __name __args
-
-/* x32 thunk declaration. */
-#define COBALT_SYSCALL32x_DECL(__name, __args)	\
-	long CoBaLt32x_ ## __name __args
-
-#else /* !CONFIG_X86_X32 */
-
-/* x32 support disabled. */
-
-#define __COBALT_SYSNR32x(__reg)	(__reg)
-
-#define __COBALT_COMPAT32x(__reg)	0
-
-#define __COBALT_CALL32x_INITHAND(__handler)
-
-#define __COBALT_CALL32x_INITMODE(__mode)
-
-#define __COBALT_CALL32x_ENTRY(__name, __handler)
-
-#define __COBALT_CALL32x_pure_THUNK(__name)
-
-#define __COBALT_CALL32x_THUNK(__name)
-
-#define COBALT_SYSCALL32x_DECL(__name, __args)
-
-#endif /* !CONFIG_X86_X32 */
-
 #ifdef CONFIG_IA32_EMULATION
 
 #define __COBALT_IA32_BASE		256 /* Power of two. */
@@ -155,33 +85,17 @@
 #endif /* !CONFIG_IA32_EMULATION */
 
 #define __COBALT_CALL32_ENTRY(__name, __handler)	\
-	__COBALT_CALL32x_ENTRY(__name, __handler)	\
 	__COBALT_CALL32emu_ENTRY(__name, __handler)
 
 #define __COBALT_CALL32_INITHAND(__handler)	\
-  	__COBALT_CALL32x_INITHAND(__handler)	\
 	__COBALT_CALL32emu_INITHAND(__handler)
 
 #define __COBALT_CALL32_INITMODE(__mode)	\
-  	__COBALT_CALL32x_INITMODE(__mode)	\
 	__COBALT_CALL32emu_INITMODE(__mode)
 
 /* Already checked for __COBALT_SYSCALL_BIT */
-#define __COBALT_CALL32_SYSNR(__reg)				\
-	({							\
-		long __nr;					\
-		__nr = __COBALT_SYSNR32x(__reg);		\
-		if (__nr == (__reg))				\
-			__nr = __COBALT_SYSNR32emu(__reg);	\
-		__nr;						\
-	})
+#define __COBALT_CALL32_SYSNR(__reg)	__COBALT_SYSNR32emu(__reg)
 
-#define __COBALT_CALL_COMPAT(__reg)				\
-	({							\
-		int __ret = __COBALT_COMPAT32x(__reg);		\
-		if (__ret == 0)					\
-			__ret = __COBALT_COMPAT32emu(__reg);	\
-		__ret;						\
-	})
+#define __COBALT_CALL_COMPAT(__reg)	__COBALT_COMPAT32emu(__reg)
 
 #endif /* !_COBALT_X86_ASM_SYSCALL32_H */
diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
index b9f33953a9..c6fe737e63 100644
--- a/kernel/cobalt/posix/syscall.c
+++ b/kernel/cobalt/posix/syscall.c
@@ -363,49 +363,47 @@ static int CoBaLt_ni(void)
 
 /*
  * We have a single syscall table for all ABI models, i.e. 64bit
- * native + 32bit) or plain 32bit. In the former case, we may want to
- * support several models with a single build (e.g. ia32 and x32 for
- * x86_64).
+ * native + 32bit emulation) or plain 32bit.
  *
  * The syscall table is set up in a single step, based on three
  * subsequent sources of initializers:
  *
  * - first, all syscall entries are defaulted to a placeholder
- * returning -ENOSYS, as the table may be sparse.
+ * returning -ENOSYS (__COBALT_CALL_NI), as the table may be sparse.
  *
  * - then __COBALT_CALL_ENTRY() produces a native call entry
- * (e.g. pure 64bit call handler for a 64bit architecture), optionally
- * followed by a set of 32bit syscall entries offset by an
- * arch-specific base index, which default to the native calls. These
- * nitty-gritty details are defined by
- * <asm/xenomai/syscall32.h>. 32bit architectures - or 64bit ones for
- * which we don't support any 32bit ABI model - will simply define
+ * (e.g. pure 64bit call handler for a 64bit architecture, 32bit
+ * handler for a 32bit architecture), optionally followed by a set of
+ * 32bit syscall entries offset by an arch-specific base index, which
+ * default to the native calls. These nitty-gritty details are defined
+ * by <asm/xenomai/syscall32.h>. 32bit architectures - or 64bit ones
+ * for which we don't support any 32bit ABI model - will simply define
  * __COBALT_CALL32_ENTRY() as an empty macro.
  *
- * - finally, 32bit thunk entries are generated per-architecture, by
- * including <asm/xenomai/syscall32-table.h>, overriding the default
- * handlers installed during the previous step.
+ * - finally, 32bit thunk entries are generated by including
+ * <asm/xenomai/syscall32-table.h>, overriding the default handlers
+ * installed during the previous step.
  *
- * For instance, with CONFIG_X86_X32 support enabled in an x86_64
- * kernel, sc_cobalt_mq_timedreceive would appear twice in the table,
- * as:
+ * For instance, with CONFIG_IA32_EMULATION support enabled in an
+ * x86_64 kernel, sc_cobalt_mq_timedreceive would appear twice in the
+ * table, as:
  *
- * [sc_cobalt_mq_timedreceive] = cobalt_mq_timedreceive,
+ * [sc_cobalt_mq_timedreceive] = CoBaLt_mq_timedreceive,
  * ...
- * [sc_cobalt_mq_timedreceive + __COBALT_X32_BASE] = cobalt32x_mq_timedreceive,
+ * [sc_cobalt_mq_timedreceive + __COBALT_IA32_BASE] = CoBaLt32emu_mq_timedreceive,
  *
- * cobalt32x_mq_timedreceive() would do the required thunking for
+ * CoBaLt32emu_mq_timedreceive() would do the required thunking for
  * dealing with the 32<->64bit conversion of arguments. On the other
  * hand, sc_cobalt_sched_yield - which do not require any thunk -
  * would also appear twice, but both entries would point at the native
  * syscall implementation:
  *
- * [sc_cobalt_sched_yield] = cobalt_sched_yield,
+ * [sc_cobalt_sched_yield] = CoBaLt_sched_yield,
  * ...
- * [sc_cobalt_sched_yield + __COBALT_X32_BASE] = cobalt_sched_yield,
+ * [sc_cobalt_sched_yield + __COBALT_IA32_BASE] = CoBaLt_sched_yield,
  *
- * Accordingly, applications targeting the x32 model (-mx32) issue
- * syscalls in the range [__COBALT_X32_BASE..__COBALT_X32_BASE +
+ * Accordingly, applications targeting the ia32 model issue syscalls
+ * in the range [__COBALT_IA32_BASE..__COBALT_IA32_BASE +
  * __NR_COBALT_SYSCALLS-1], whilst native (32/64bit) ones issue
  * syscalls in the range [0..__NR_COBALT_SYSCALLS-1].
  *
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index a5dc6e48f9..8bc74e9974 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -928,29 +928,3 @@ COBALT_SYSCALL32emu(backtrace, current,
 
 	return 0;
 }
-
-#ifdef COBALT_SYSCALL32x
-
-COBALT_SYSCALL32x(mq_timedreceive, primary,
-		  (mqd_t uqd, void __user *u_buf,
-		   compat_ssize_t __user *u_len,
-		   unsigned int __user *u_prio,
-		   const struct __user_old_timespec __user *u_ts))
-{
-	compat_ssize_t clen;
-	ssize_t len;
-	int ret;
-
-	ret = cobalt_copy_from_user(&clen, u_len, sizeof(*u_len));
-	if (ret)
-		return ret;
-
-	len = clen;
-	ret = __cobalt_mq_timedreceive(uqd, u_buf, &len, u_prio,
-				       u_ts, u_ts ? mq_fetch_timeout : NULL);
-	clen = len;
-
-	return ret ?: cobalt_copy_to_user(u_len, &clen, sizeof(*u_len));
-}
-
-#endif /* COBALT_SYSCALL32x */
diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
index bb62875ad0..d380c2d8e3 100644
--- a/kernel/cobalt/posix/syscall32.h
+++ b/kernel/cobalt/posix/syscall32.h
@@ -101,12 +101,6 @@ COBALT_SYSCALL32emu_DECL(mq_timedreceive,
 			  unsigned int __user *u_prio,
 			  const struct old_timespec32 __user *u_ts));
 
-COBALT_SYSCALL32x_DECL(mq_timedreceive,
-		       (mqd_t uqd, void __user *u_buf,
-			compat_ssize_t __user *u_len,
-			unsigned int __user *u_prio,
-			const struct __user_old_timespec __user *u_ts));
-
 COBALT_SYSCALL32emu_DECL(mq_notify,
 			 (mqd_t fd, const struct compat_sigevent *__user u_cev));
 
diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
index cff1bd9b71..a3713e9c9d 100644
--- a/kernel/cobalt/trace/cobalt-posix.h
+++ b/kernel/cobalt/trace/cobalt-posix.h
@@ -42,12 +42,6 @@
 #define __timespec_args(__name)					\
 	(long long)__entry->tv_sec_##__name, __entry->tv_nsec_##__name
 
-#ifdef CONFIG_X86_X32
-#define __sc_x32(__name)	, { sc_cobalt_##__name + __COBALT_X32_BASE, "x32-" #__name }
-#else
-#define __sc_x32(__name)
-#endif
-
 #ifdef CONFIG_IA32_EMULATION
 #define __sc_compat(__name)	, { sc_cobalt_##__name + __COBALT_IA32_BASE, "compat-" #__name }
 #else
@@ -56,7 +50,6 @@
 
 #define __cobalt_symbolic_syscall(__name)				\
 	{ sc_cobalt_##__name, #__name }					\
-	__sc_x32(__name)						\
 	__sc_compat(__name)						\
 
 #define __cobalt_syscall_name(__nr)					\
-- 
2.26.2


