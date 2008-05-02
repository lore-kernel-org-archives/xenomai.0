From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18459.38500.720338.652195@domain.hid>
Date: Sat, 3 May 2008 00:32:04 +0200
In-Reply-To: <18459.38430.835407.942336@domain.hid>
References: <18459.38249.462320.715909@domain.hid>
	<18459.38430.835407.942336@domain.hid>
Subject: [Xenomai-core] [Patch 2/7] Define XNARCH_SHARED_HEAP_FLAGS
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


No comment.

---
 asm-arm/hal.h        |    7 ++++++-
 asm-generic/system.h |    6 ++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

Index: include/asm-generic/system.h
===================================================================
--- include/asm-generic/system.h	(revision 3738)
+++ include/asm-generic/system.h	(working copy)
@@ -238,6 +238,12 @@ static inline int xnlock_dbg_release(xnl
 #define xnarch_logerr(fmt, args...)	printk(KERN_ERR XNARCH_PROMPT fmt, ##args)
 #define xnarch_printf(fmt, args...)	printk(KERN_INFO XNARCH_PROMPT fmt, ##args)
 
+#ifndef RTHAL_SHARED_HEAP_FLAGS
+#define XNARCH_SHARED_HEAP_FLAGS 0
+#else /* !RTHAL_SHARED_HEAP_FLAGS */
+#define XNARCH_SHARED_HEAP_FLAGS RTHAL_SHARED_HEAP_FLAGS
+#endif /* !RTHAL_SHARED_HEAP_FLAGS */
+
 typedef cpumask_t xnarch_cpumask_t;
 
 #ifdef CONFIG_SMP
Index: include/asm-arm/hal.h
===================================================================
--- include/asm-arm/hal.h	(revision 3738)
+++ include/asm-arm/hal.h	(working copy)
@@ -108,10 +108,15 @@ static inline __attribute_const__ unsign
 #include <asm/processor.h>
 #include <asm/ipipe.h>
 #include <asm/mach/irq.h>
+#include <asm/cacheflush.h>
 
 #define RTHAL_TIMER_IRQ   __ipipe_mach_timerint
 
-#define RTHAL_SHARED_HEAP_FLAGS XNHEAP_GFP_NONCACHED
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+#define RTHAL_SHARED_HEAP_FLAGS (cache_is_vivt() ? XNHEAP_GFP_NONCACHED : 0)
+#else /* !CONFIG_XENO_OPT_PERVASIVE */
+#define RTHAL_SHARED_HEAP_FLAGS 0
+#endif /* !CONFIG_XENO_OPT_PERVASIVE */
 
 #define rthal_grab_control()     do { } while(0)
 #define rthal_release_control()  do { } while(0)

-- 


					    Gilles.

