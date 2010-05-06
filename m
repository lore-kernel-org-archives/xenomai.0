From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Date: Thu,  6 May 2010 16:56:31 +0200
Message-Id: <1273157791-30348-1-git-send-email-wolfgang.mauerer@domain.hid>
In-Reply-To: <1273151091.2440.143.camel@domain.hid>
References: <1273151091.2440.143.camel@domain.hid>
Subject: [Xenomai-core] [PATCH] Fix x86_64 builds with CC_STACKPROTECTOR
	enabled
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: jan.kiszka@domain.hid, Wolfgang Mauerer <wolfgang.mauerer@domain.hid>

The per_cpu__ prefix for per-cpu-variables in the Linux kernel
is gone since dd17c8f72993f. This patch adds a corresponding wrapper.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Acked-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/asm-generic/wrappers.h |    4 ++++
 include/asm-x86/switch_64.h    |    3 +++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/asm-generic/wrappers.h b/include/asm-generic/wrappers.h
index ecc1867..3827492 100644
--- a/include/asm-generic/wrappers.h
+++ b/include/asm-generic/wrappers.h
@@ -598,4 +598,8 @@ static inline void wrap_proc_dir_entry_owner(struct proc_dir_entry *entry)
 	raw_spin_unlock_irqrestore(&rthal_irq_descp(irq)->lock, flags)
 #endif /* LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,33) */
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,34)
+#define per_cpu_var(x)	x
+#endif
+
 #endif /* _XENO_ASM_GENERIC_WRAPPERS_H */
diff --git a/include/asm-x86/switch_64.h b/include/asm-x86/switch_64.h
index a716ad6..a436917 100644
--- a/include/asm-x86/switch_64.h
+++ b/include/asm-x86/switch_64.h
@@ -25,6 +25,9 @@
 #error "Pure kernel header included from user-space!"
 #endif
 
+#include <asm/percpu.h>
+#include <asm/xenomai/wrappers.h>
+
 struct xnarch_x8664_initstack {
 
 #ifdef CONFIG_CC_STACKPROTECTOR
-- 
1.7.0.4


