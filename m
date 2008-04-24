From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18448.9967.355128.570111@domain.hid>
Date: Thu, 24 Apr 2008 08:21:35 +0200
In-Reply-To: <18448.9901.799115.445182@domain.hid>
References: <18448.9649.956656.531081@domain.hid>
	<18448.9901.799115.445182@domain.hid>
Subject: [Xenomai-core] [2/9] Define XNARCH_SHARED_HEAP_FLAGS
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


This patch defines the macro XNARCH_SHARED_HEAP_FLAGS to be set to
XNHEAP_GFP_NONCACHED on ARM with VIVT cache. I assumed that ARM with VIPT cache
would not need non-cached mappings when sharing memory between kernel and
user-space. Please correct me if I am wrong.

---
 asm-arm/hal.h        |    3 ++-
 asm-generic/system.h |    6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

Index: include/asm-generic/system.h
===================================================================
--- include/asm-generic/system.h	(revision 3718)
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
--- include/asm-arm/hal.h	(revision 3718)
+++ include/asm-arm/hal.h	(working copy)
@@ -108,10 +108,11 @@ static inline __attribute_const__ unsign
 #include <asm/processor.h>
 #include <asm/ipipe.h>
 #include <asm/mach/irq.h>
+#include <asm/cacheflush.h>
 
 #define RTHAL_TIMER_IRQ   __ipipe_mach_timerint
 
-#define RTHAL_SHARED_HEAP_FLAGS XNHEAP_GFP_NONCACHED
+#define RTHAL_SHARED_HEAP_FLAGS (cache_is_vivt() ? XNHEAP_GFP_NONCACHED : 0)
 
 #define rthal_grab_control()     do { } while(0)
 #define rthal_release_control()  do { } while(0)


-- 


					    Gilles.

