Message-ID: <55959E70.1020407@siemens.com>
Date: Thu, 02 Jul 2015 22:26:24 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <55956729.9010901@xenomai.org> <55956A56.3050806@siemens.com>
 <20150702164933.GR13256@hermes.click-hack.org>
 <20150702165642.GS13256@hermes.click-hack.org> <5595757A.60301@siemens.com>
 <20150702173508.GU13256@hermes.click-hack.org>
 <20150702175526.GV13256@hermes.click-hack.org> <55957B86.7020009@siemens.com>
 <20150702184232.GX13256@hermes.click-hack.org> <559587A0.7020005@siemens.com>
 <20150702185525.GY13256@hermes.click-hack.org> <559591E5.5060106@siemens.com>
In-Reply-To: <559591E5.5060106@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/kernel: Remove
 unused mode parameter from COBALT_SYSCALL
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Just FYI - still requires testing and more review - find a first
generator version below.

Jan


cobalt/posix/syscall: Generate cobalt_syscalls and cobalt_sysmodes

---
 .../arch/x86/include/asm/xenomai/syscall32.h       |  12 +-
 kernel/cobalt/posix/Makefile                       |  12 ++
 kernel/cobalt/posix/gen-syscall-entries.sh         |  24 +++
 kernel/cobalt/posix/syscall.c                      | 208 ++-------------------
 scripts/prepare-kernel.sh                          |   4 +-
 5 files changed, 57 insertions(+), 203 deletions(-)
 create mode 100755 kernel/cobalt/posix/gen-syscall-entries.sh

diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h
index 8bd40d4..58b7336 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall32.h
@@ -45,14 +45,14 @@
 #define __syshand32x__(__name)	((cobalt_syshand)(cobalt32x_ ## __name))
 
 #define __COBALT_CALL32x_INITHAND(__handler)	\
-  , [__COBALT_X32_BASE ... __COBALT_X32_BASE + __NR_COBALT_SYSCALLS-1] = __handler
+	[__COBALT_X32_BASE ... __COBALT_X32_BASE + __NR_COBALT_SYSCALLS-1] = __handler,
 
 #define __COBALT_CALL32x_INITMODE(__mode)	\
-  , [__COBALT_X32_BASE ... __COBALT_X32_BASE + __NR_COBALT_SYSCALLS-1] = __mode
+	[__COBALT_X32_BASE ... __COBALT_X32_BASE + __NR_COBALT_SYSCALLS-1] = __mode,
 
 /* x32 default entry (no thunk) */
 #define __COBALT_CALL32x_ENTRY(__name, __handler)		\
-	, [sc_cobalt_ ## __name + __COBALT_X32_BASE] = __handler
+	[sc_cobalt_ ## __name + __COBALT_X32_BASE] = __handler,
 
 /* x32 thunk installation */
 #define __COBALT_CALL32x_pure_THUNK(__name)	\
@@ -113,14 +113,14 @@
 #define __syshand32emu__(__name)	((cobalt_syshand)(cobalt32emu_ ## __name))
 
 #define __COBALT_CALL32emu_INITHAND(__handler)	\
-  , [__COBALT_IA32_BASE ... __COBALT_IA32_BASE + __NR_COBALT_SYSCALLS-1] = __handler
+	[__COBALT_IA32_BASE ... __COBALT_IA32_BASE + __NR_COBALT_SYSCALLS-1] = __handler,
 
 #define __COBALT_CALL32emu_INITMODE(__mode)	\
-  , [__COBALT_IA32_BASE ... __COBALT_IA32_BASE + __NR_COBALT_SYSCALLS-1] = __mode
+	[__COBALT_IA32_BASE ... __COBALT_IA32_BASE + __NR_COBALT_SYSCALLS-1] = __mode,
 
 /* ia32 default entry (no thunk) */
 #define __COBALT_CALL32emu_ENTRY(__name, __handler)		\
-	, [sc_cobalt_ ## __name + __COBALT_IA32_BASE] = __handler
+	[sc_cobalt_ ## __name + __COBALT_IA32_BASE] = __handler,
 
 /* ia32 thunk installation */
 #define __COBALT_CALL32emu_THUNK(__name)	\
diff --git a/kernel/cobalt/posix/Makefile b/kernel/cobalt/posix/Makefile
index 3049be4..2da764a 100644
--- a/kernel/cobalt/posix/Makefile
+++ b/kernel/cobalt/posix/Makefile
@@ -22,4 +22,16 @@ xenomai-y :=		\
 	timer.o		\
 	timerfd.o
 
+syscall_entries := $(srctree)/$(src)/gen-syscall-entries.sh
+
+quiet_cmd_syscall_entries = GEN     $@
+      cmd_syscall_entries = $(CONFIG_SHELL) '$(syscall_entries)' $^ > $@
+
+$(obj)/syscall_entries.h: $(syscall_entries) $(wildcard $(srctree)/$(src)/*.c)
+	$(call if_changed,syscall_entries)
+
+target += syscall_entries.h
+
+$(obj)/syscall.o: $(obj)/syscall_entries.h
+
 xenomai-$(CONFIG_XENO_ARCH_SYS3264) += compat.o syscall32.o
diff --git a/kernel/cobalt/posix/gen-syscall-entries.sh b/kernel/cobalt/posix/gen-syscall-entries.sh
new file mode 100755
index 0000000..36b1e69
--- /dev/null
+++ b/kernel/cobalt/posix/gen-syscall-entries.sh
@@ -0,0 +1,24 @@
+#! /bin/sh
+
+set -e
+
+shift
+
+echo "#ifdef COBALT_LIST_CALL_ENTRIES"
+awk '
+match($0, /COBALT_SYSCALL\([^,]*, [^,]*/)  {
+	str=substr($0, RSTART + 15, RLENGTH - 15)
+	match(str, /[^,]*/)
+	print "__COBALT_CALL_ENTRY(" substr(str, RSTART, RLENGTH) ")"
+}
+' $*
+echo "#endif"
+
+echo "#ifdef COBALT_LIST_MODES"
+awk '
+match($0, /COBALT_SYSCALL\([^,]*, [^,]*/)  {
+	str=substr($0, RSTART + 15, RLENGTH - 15)
+	print "__COBALT_MODE(" str ")"
+}
+' $*
+echo "#endif"
diff --git a/kernel/cobalt/posix/syscall.c b/kernel/cobalt/posix/syscall.c
index 36cfc3b..abe9fea 100644
--- a/kernel/cobalt/posix/syscall.c
+++ b/kernel/cobalt/posix/syscall.c
@@ -548,222 +548,40 @@ static int cobalt_ni(void)
 #define __COBALT_NI	__syshand__(ni)
 
 #define __COBALT_CALL_NI				\
-	[0 ... __NR_COBALT_SYSCALLS-1] = __COBALT_NI	\
+	[0 ... __NR_COBALT_SYSCALLS-1] = __COBALT_NI,	\
 	__COBALT_CALL32_INITHAND(__COBALT_NI)
 
 #define __COBALT_CALL_NFLAGS				\
-	[0 ... __NR_COBALT_SYSCALLS-1] = 0		\
+	[0 ... __NR_COBALT_SYSCALLS-1] = 0,		\
 	__COBALT_CALL32_INITMODE(0)
 
 #define __COBALT_CALL_ENTRY(__name)				\
-	[sc_cobalt_ ## __name] = __syshand__(__name)		\
+	[sc_cobalt_ ## __name] = __syshand__(__name),		\
 	__COBALT_CALL32_ENTRY(__name, __syshand__(__name))
 
 #define __COBALT_MODE(__name, __mode)	\
-	[sc_cobalt_ ## __name] = __xn_exec_##__mode
+	[sc_cobalt_ ## __name] = __xn_exec_##__mode,
 
 #ifdef CONFIG_XENO_ARCH_SYS3264
 #include "syscall32.h"
 #endif
 
 static const cobalt_syshand cobalt_syscalls[] = {
-	__COBALT_CALL_NI,
-	__COBALT_CALL_ENTRY(thread_create),
-	__COBALT_CALL_ENTRY(thread_getpid),
-	__COBALT_CALL_ENTRY(thread_setschedparam_ex),
-	__COBALT_CALL_ENTRY(thread_getschedparam_ex),
-	__COBALT_CALL_ENTRY(sched_weightprio),
-	__COBALT_CALL_ENTRY(sched_yield),
-	__COBALT_CALL_ENTRY(thread_setmode),
-	__COBALT_CALL_ENTRY(thread_setname),
-	__COBALT_CALL_ENTRY(thread_kill),
-	__COBALT_CALL_ENTRY(thread_getstat),
-	__COBALT_CALL_ENTRY(thread_join),
-	__COBALT_CALL_ENTRY(sem_init),
-	__COBALT_CALL_ENTRY(sem_destroy),
-	__COBALT_CALL_ENTRY(sem_post),
-	__COBALT_CALL_ENTRY(sem_wait),
-	__COBALT_CALL_ENTRY(sem_timedwait),
-	__COBALT_CALL_ENTRY(sem_trywait),
-	__COBALT_CALL_ENTRY(sem_getvalue),
-	__COBALT_CALL_ENTRY(sem_open),
-	__COBALT_CALL_ENTRY(sem_close),
-	__COBALT_CALL_ENTRY(sem_unlink),
-	__COBALT_CALL_ENTRY(sem_broadcast_np),
-	__COBALT_CALL_ENTRY(sem_inquire),
-	__COBALT_CALL_ENTRY(clock_getres),
-	__COBALT_CALL_ENTRY(clock_gettime),
-	__COBALT_CALL_ENTRY(clock_settime),
-	__COBALT_CALL_ENTRY(clock_nanosleep),
-	__COBALT_CALL_ENTRY(mutex_init),
-	__COBALT_CALL_ENTRY(mutex_check_init),
-	__COBALT_CALL_ENTRY(mutex_destroy),
-	__COBALT_CALL_ENTRY(mutex_lock),
-	__COBALT_CALL_ENTRY(mutex_timedlock),
-	__COBALT_CALL_ENTRY(mutex_trylock),
-	__COBALT_CALL_ENTRY(mutex_unlock),
-	__COBALT_CALL_ENTRY(cond_init),
-	__COBALT_CALL_ENTRY(cond_destroy),
-	__COBALT_CALL_ENTRY(cond_wait_prologue),
-	__COBALT_CALL_ENTRY(cond_wait_epilogue),
-	__COBALT_CALL_ENTRY(mq_open),
-	__COBALT_CALL_ENTRY(mq_close),
-	__COBALT_CALL_ENTRY(mq_unlink),
-	__COBALT_CALL_ENTRY(mq_getattr),
-	__COBALT_CALL_ENTRY(mq_timedsend),
-	__COBALT_CALL_ENTRY(mq_timedreceive),
-	__COBALT_CALL_ENTRY(mq_notify),
-	__COBALT_CALL_ENTRY(sigwait),
-	__COBALT_CALL_ENTRY(sigwaitinfo),
-	__COBALT_CALL_ENTRY(sigtimedwait),
-	__COBALT_CALL_ENTRY(sigpending),
-	__COBALT_CALL_ENTRY(kill),
-	__COBALT_CALL_ENTRY(sigqueue),
-	__COBALT_CALL_ENTRY(timer_create),
-	__COBALT_CALL_ENTRY(timer_delete),
-	__COBALT_CALL_ENTRY(timer_settime),
-	__COBALT_CALL_ENTRY(timer_gettime),
-	__COBALT_CALL_ENTRY(timer_getoverrun),
-	__COBALT_CALL_ENTRY(timerfd_create),
-	__COBALT_CALL_ENTRY(timerfd_gettime),
-	__COBALT_CALL_ENTRY(timerfd_settime),
-	__COBALT_CALL_ENTRY(select),
-	__COBALT_CALL_ENTRY(sched_minprio),
-	__COBALT_CALL_ENTRY(sched_maxprio),
-	__COBALT_CALL_ENTRY(monitor_init),
-	__COBALT_CALL_ENTRY(monitor_destroy),
-	__COBALT_CALL_ENTRY(monitor_enter),
-	__COBALT_CALL_ENTRY(monitor_wait),
-	__COBALT_CALL_ENTRY(monitor_sync),
-	__COBALT_CALL_ENTRY(monitor_exit),
-	__COBALT_CALL_ENTRY(event_init),
-	__COBALT_CALL_ENTRY(event_destroy),
-	__COBALT_CALL_ENTRY(event_wait),
-	__COBALT_CALL_ENTRY(event_sync),
-	__COBALT_CALL_ENTRY(event_inquire),
-	__COBALT_CALL_ENTRY(sched_setconfig_np),
-	__COBALT_CALL_ENTRY(sched_getconfig_np),
-	__COBALT_CALL_ENTRY(open),
-	__COBALT_CALL_ENTRY(socket),
-	__COBALT_CALL_ENTRY(close),
-	__COBALT_CALL_ENTRY(mmap),
-	__COBALT_CALL_ENTRY(ioctl),
-	__COBALT_CALL_ENTRY(read),
-	__COBALT_CALL_ENTRY(write),
-	__COBALT_CALL_ENTRY(recvmsg),
-	__COBALT_CALL_ENTRY(sendmsg),
-	__COBALT_CALL_ENTRY(migrate),
-	__COBALT_CALL_ENTRY(archcall),
-	__COBALT_CALL_ENTRY(bind),
-	__COBALT_CALL_ENTRY(extend),
-	__COBALT_CALL_ENTRY(trace),
-	__COBALT_CALL_ENTRY(get_current),
-	__COBALT_CALL_ENTRY(backtrace),
-	__COBALT_CALL_ENTRY(serialdbg),
-	__COBALT_CALL_ENTRY(corectl),
-	__COBALT_CALL_ENTRY(fcntl)
-	/* NO COMMA AT END */
+	__COBALT_CALL_NI
+#define COBALT_LIST_CALL_ENTRIES 1
+#include "syscall_entries.h"
+#undef COBALT_LIST_CALL_ENTRIES
+
 #ifdef CONFIG_XENO_ARCH_SYS3264
 #include <asm/xenomai/syscall32-table.h>
 #endif
 };
 
 static const int cobalt_sysmodes[] = {
-	__COBALT_CALL_NFLAGS,
-	__COBALT_MODE(thread_create, init),
-	__COBALT_MODE(thread_getpid, current),
-	__COBALT_MODE(thread_setschedparam_ex, conforming),
-	__COBALT_MODE(thread_getschedparam_ex, current),
-	__COBALT_MODE(sched_weightprio, current),
-	__COBALT_MODE(sched_yield, primary),
-	__COBALT_MODE(thread_setmode, primary),
-	__COBALT_MODE(thread_setname, current),
-	__COBALT_MODE(thread_kill, conforming),
-	__COBALT_MODE(thread_getstat, current),
-	__COBALT_MODE(thread_join, primary),
-	__COBALT_MODE(sem_init, current),
-	__COBALT_MODE(sem_destroy, current),
-	__COBALT_MODE(sem_post, current),
-	__COBALT_MODE(sem_wait, primary),
-	__COBALT_MODE(sem_timedwait, primary),
-	__COBALT_MODE(sem_trywait, primary),
-	__COBALT_MODE(sem_getvalue, current),
-	__COBALT_MODE(sem_open, lostage),
-	__COBALT_MODE(sem_close, lostage),
-	__COBALT_MODE(sem_unlink, lostage),
-	__COBALT_MODE(sem_broadcast_np, current),
-	__COBALT_MODE(sem_inquire, current),
-	__COBALT_MODE(clock_getres, current),
-	__COBALT_MODE(clock_gettime, current),
-	__COBALT_MODE(clock_settime, current),
-	__COBALT_MODE(clock_nanosleep, nonrestartable),
-	__COBALT_MODE(mutex_init, current),
-	__COBALT_MODE(mutex_check_init, current),
-	__COBALT_MODE(mutex_destroy, current),
-	__COBALT_MODE(mutex_lock, primary),
-	__COBALT_MODE(mutex_timedlock, primary),
-	__COBALT_MODE(mutex_trylock, primary),
-	__COBALT_MODE(mutex_unlock, nonrestartable),
-	__COBALT_MODE(cond_init, current),
-	__COBALT_MODE(cond_destroy, current),
-	__COBALT_MODE(cond_wait_prologue, nonrestartable),
-	__COBALT_MODE(cond_wait_epilogue, primary),
-	__COBALT_MODE(mq_open, lostage),
-	__COBALT_MODE(mq_close, lostage),
-	__COBALT_MODE(mq_unlink, lostage),
-	__COBALT_MODE(mq_getattr, current),
-	__COBALT_MODE(mq_timedsend, primary),
-	__COBALT_MODE(mq_timedreceive, primary),
-	__COBALT_MODE(mq_notify, primary),
-	__COBALT_MODE(sigwait, primary),
-	__COBALT_MODE(sigwaitinfo, nonrestartable),
-	__COBALT_MODE(sigtimedwait, nonrestartable),
-	__COBALT_MODE(sigpending, primary),
-	__COBALT_MODE(kill, conforming),
-	__COBALT_MODE(sigqueue, conforming),
-	__COBALT_MODE(timer_create, current),
-	__COBALT_MODE(timer_delete, current),
-	__COBALT_MODE(timer_settime, primary),
-	__COBALT_MODE(timer_gettime, current),
-	__COBALT_MODE(timer_getoverrun, current),
-	__COBALT_MODE(timerfd_create, lostage),
-	__COBALT_MODE(timerfd_gettime, current),
-	__COBALT_MODE(timerfd_settime, primary),
-	__COBALT_MODE(select, nonrestartable),
-	__COBALT_MODE(sched_minprio, current),
-	__COBALT_MODE(sched_maxprio, current),
-	__COBALT_MODE(monitor_init, current),
-	__COBALT_MODE(monitor_destroy, primary),
-	__COBALT_MODE(monitor_enter, primary),
-	__COBALT_MODE(monitor_wait, nonrestartable),
-	__COBALT_MODE(monitor_sync, nonrestartable),
-	__COBALT_MODE(monitor_exit, primary),
-	__COBALT_MODE(event_init, current),
-	__COBALT_MODE(event_destroy, current),
-	__COBALT_MODE(event_wait, primary),
-	__COBALT_MODE(event_sync, current),
-	__COBALT_MODE(event_inquire, current),
-	__COBALT_MODE(sched_setconfig_np, conforming),
-	__COBALT_MODE(sched_getconfig_np, conforming),
-	__COBALT_MODE(open, lostage),
-	__COBALT_MODE(socket, lostage),
-	__COBALT_MODE(close, lostage),
-	__COBALT_MODE(mmap, lostage),
-	__COBALT_MODE(ioctl, probing),
-	__COBALT_MODE(read, probing),
-	__COBALT_MODE(write, probing),
-	__COBALT_MODE(recvmsg, probing),
-	__COBALT_MODE(sendmsg, probing),
-	__COBALT_MODE(migrate, current),
-	__COBALT_MODE(archcall, current),
-	__COBALT_MODE(bind, lostage),
-	__COBALT_MODE(extend, lostage),
-	__COBALT_MODE(trace, current),
-	__COBALT_MODE(get_current, current),
-	__COBALT_MODE(backtrace, lostage),
-	__COBALT_MODE(serialdbg, current),
-	__COBALT_MODE(corectl, probing),
-	__COBALT_MODE(fcntl, current),
+	__COBALT_CALL_NFLAGS
+#define COBALT_LIST_MODES 1
+#include "syscall_entries.h"
+#undef COBALT_LIST_MODES
 };
 
 static inline int allowed_syscall(struct cobalt_process *process,
diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index dbc5d24..8e960e8 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -100,8 +100,8 @@ patch_link() {
 	       recursive_opt="-maxdepth 1"
 	       dir_opt=""
            fi
-	   find_clean_opt="$recursive_opt \( $dir_opt $link_makefiles_opt -name Kconfig -o -name '*.[chS]' \)"
-	   find_link_opt="$recursive_opt \( $link_makefiles_opt -name Kconfig -o -name '*.[chS]' \)"
+	   find_clean_opt="$recursive_opt \( $dir_opt $link_makefiles_opt -name Kconfig -o -name '*.[chS]' -o -name '*.sh' \)"
+	   find_link_opt="$recursive_opt \( $link_makefiles_opt -name Kconfig -o -name '*.[chS]' -o -name '*.sh' \)"
 	fi
 
         if test "x$output_patch" = "x" -a -e $linux_tree/$link_dir; then
-- 
2.1.4

