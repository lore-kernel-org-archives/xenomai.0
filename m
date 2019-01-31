From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt: x86: Use ipipe_root_nr_syscalls
Message-ID: <cf2852a2-8000-d545-4d32-fcdab5ba4522@siemens.com>
Date: Thu, 31 Jan 2019 18:09:53 +0100
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Required to handle compat syscalls correctly.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This is against next. The stable patch needs to touch kernel/cobalt
/posix/syscall.c instead.

Testing all these would be very appreciated!

 kernel/cobalt/arch/x86/include/asm/xenomai/syscall.h | 2 +-
 kernel/cobalt/include/linux/xenomai/wrappers.h       | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall.h b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall.h
index 992f1cd9c4..ea0e6fcb16 100644
--- a/kernel/cobalt/arch/x86/include/asm/xenomai/syscall.h
+++ b/kernel/cobalt/arch/x86/include/asm/xenomai/syscall.h
@@ -62,7 +62,7 @@
 #define __xn_rootcall_p(__regs, __code)			\
 	({						\
 		*(__code) = __xn_reg_sys(__regs);	\
-		*(__code) < NR_syscalls;		\
+		*(__code) < ipipe_root_nr_syscalls(current_thread_info()); \
 	})
 
 static inline void __xn_error_return(struct pt_regs *regs, int v)
diff --git a/kernel/cobalt/include/linux/xenomai/wrappers.h b/kernel/cobalt/include/linux/xenomai/wrappers.h
index 1d16db4218..7d00aa9d40 100644
--- a/kernel/cobalt/include/linux/xenomai/wrappers.h
+++ b/kernel/cobalt/include/linux/xenomai/wrappers.h
@@ -43,4 +43,10 @@
 		smp_store_mb((tsk)->state, (state_value))
 #endif
 
+#include <linux/ipipe.h>
+
+#ifndef ipipe_root_nr_syscalls
+#define ipipe_root_nr_syscalls(ti)	NR_syscalls
+#endif
+
 #endif /* !_COBALT_LINUX_WRAPPERS_H */
-- 
2.16.4

