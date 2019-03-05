From: roman.stratiienko@globallogic.com
Subject: [PATCH 2/7] kernel: cobalt: fix build with kernel v4.20
Date: Tue,  5 Mar 2019 16:45:16 +0200
Message-Id: <20190305144521.2567-2-roman.stratiienko@globallogic.com>
In-Reply-To: <20190305144521.2567-1-roman.stratiienko@globallogic.com>
References: <20190305144521.2567-1-roman.stratiienko@globallogic.com>
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

READ_ONCE() introduced from v3.19 commit 230fa253df63
("kernel: Provide READ_ONCE and ASSIGN_ONCE")
and ACCESS_ONCE() removed startibg from v4.15-rc4 commit
b899a850431e ("compiler.h: Remove ACCESS_ONCE()")
Replace ACCESS_ONCE with READ_ONCE and make READ_ONCE wrapper
for case when READ_ONCE is not available (<v3.19)

print_symbol() removed since v4.16-rc1 commit d2279c9d7f7d
("kallsyms: remove print_symbol() function")
use print_symbol for version less than v4.16 and printk starting from v4.16

$SRCARCH removed since v4.18-rc1, upstream commit 104daea149c4
("kconfig: reference environment variables directly and remove 'option env='")
forward SRCARCH from the scripts/prepare-kernel.sh

siginfo_t can't be used in kernel-space starting from v4.20-rc1 commit
ae7795bc6187 ("signal: Distinguish between kernel_siginfo and siginfo")
replace all siginfo_t to kernel_siginfo_t and create wrapper for kernel < v4.20

Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---
 include/cobalt/uapi/kernel/urw.h               | 6 +++++-
 kernel/cobalt/include/linux/xenomai/wrappers.h | 4 ++++
 kernel/cobalt/posix/process.c                  | 6 +++++-
 kernel/cobalt/thread.c                         | 4 ++--
 scripts/Kconfig.frag                           | 2 +-
 scripts/prepare-kernel.sh                      | 1 +
 6 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/cobalt/uapi/kernel/urw.h b/include/cobalt/uapi/kernel/urw.h
index 40a1eb5ff..fcfde21a0 100644
--- a/include/cobalt/uapi/kernel/urw.h
+++ b/include/cobalt/uapi/kernel/urw.h
@@ -53,11 +53,15 @@ typedef struct {
 #define URW_INITIALIZER     { 0 }
 #define DEFINE_URW(__name)  urw_t __name = URW_INITIALIZER
 
+#ifndef READ_ONCE
+#define READ_ONCE ACCESS_ONCE
+#endif
+
 static inline void __try_read_start(const urw_t *urw, urwstate_t *tmp)
 {
 	__u32 token;
 repeat:
-	token = ACCESS_ONCE(urw->sequence);
+	token = READ_ONCE(urw->sequence);
 	smp_rmb();
 	if (token & 1) {
 		cpu_relax();
diff --git a/kernel/cobalt/include/linux/xenomai/wrappers.h b/kernel/cobalt/include/linux/xenomai/wrappers.h
index 7d00aa9d4..6ea86a0fd 100644
--- a/kernel/cobalt/include/linux/xenomai/wrappers.h
+++ b/kernel/cobalt/include/linux/xenomai/wrappers.h
@@ -49,4 +49,8 @@
 #define ipipe_root_nr_syscalls(ti)	NR_syscalls
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4,20,0)
+typedef siginfo_t kernel_siginfo_t;
+#endif
+
 #endif /* !_COBALT_LINUX_WRAPPERS_H */
diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index d0f2f3725..dcf6234d3 100644
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
@@ -747,7 +747,11 @@ static inline int handle_exception(struct ipipe_trap_data *d)
 		}
 		splexit(s);
 #endif /* CONFIG_XENO_ARCH_FPU */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 16, 0)
+		printk("invalid use of FPU in Xenomai context at %pS\n",
+#else
 		print_symbol("invalid use of FPU in Xenomai context at %s\n",
+#endif
 			     xnarch_fault_pc(d));
 	}
 
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
diff --git a/scripts/Kconfig.frag b/scripts/Kconfig.frag
index cd39f7670..c9655d43a 100644
--- a/scripts/Kconfig.frag
+++ b/scripts/Kconfig.frag
@@ -16,7 +16,7 @@ menuconfig XENOMAI
 	  Please visit http://xenomai.org for more information.
 
 if XENOMAI
-source "arch/$SRCARCH/xenomai/Kconfig"
+source "arch/@SRCARCH@/xenomai/Kconfig"
 endif
 
 if MIGRATION
diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 964e42e83..8707b1198 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -376,6 +376,7 @@ case $linux_VERSION.$linux_PATCHLEVEL in
 	    -e "s,@VERSION_MINOR@,$version_minor,g" \
 	    -e "s,@REVISION_LEVEL@,$revision_level,g" \
 	    -e "s,@VERSION_STRING@,$version_string,g" \
+	    -e "s,@SRCARCH@,$linux_arch,g" \
 	    $xenomai_root/scripts/Kconfig.frag |
             patch_append init/Kconfig
     fi
-- 
2.17.1


