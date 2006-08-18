From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Zi3/lmrL7l"
Content-Transfer-Encoding: 7bit
Message-ID: <17638.5405.154869.872706@domain.hid>
Date: Fri, 18 Aug 2006 21:29:33 +0200
Subject: [Xenomai-core] Handling of null delay in asm/hal.h
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


--Zi3/lmrL7l
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit


Hi,

at some point in time, we decided to trigger directly the timer irq when
called on x86 to program a null delay. Attached a patch which does the
same for all other architectures.

-- 


					    Gilles Chanteperdrix.

--Zi3/lmrL7l
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-trigger-irq-on-null-delay.patch"
Content-Transfer-Encoding: 7bit

Index: include/asm-arm/hal.h
===================================================================
--- include/asm-arm/hal.h	(revision 1456)
+++ include/asm-arm/hal.h	(working copy)
@@ -104,8 +104,9 @@
 static inline void rthal_timer_program_shot (unsigned long delay)
 {
     if(!delay)
-        delay = 10;
-    __ipipe_mach_set_dec(delay);
+	rthal_trigger_irq(RTHAL_TIMER_IRQ);
+    else
+	__ipipe_mach_set_dec(delay);
 }
 
     /* Private interface -- Internal use only */
Index: include/asm-blackfin/hal.h
===================================================================
--- include/asm-blackfin/hal.h	(revision 1456)
+++ include/asm-blackfin/hal.h	(working copy)
@@ -61,11 +61,14 @@
 
 static inline void rthal_timer_program_shot (unsigned long delay)
 {
-    if (delay < 2) delay = 10;
-    *pTCOUNT = delay - 1;
-    __builtin_bfin_csync();
-    *pTCNTL = 3; /* Oneshot mode, no auto-reload. */
-    __builtin_bfin_csync();
+    if (delay < 2)
+	rthal_trigger_irq(RTHAL_TIMER_IRQ);
+    else {
+	*pTCOUNT = delay - 1;
+	__builtin_bfin_csync();
+	*pTCNTL = 3; /* Oneshot mode, no auto-reload. */
+	__builtin_bfin_csync();
+    }
 }
 
     /* Private interface -- Internal use only */
Index: include/asm-ia64/hal.h
===================================================================
--- include/asm-ia64/hal.h	(revision 1456)
+++ include/asm-ia64/hal.h	(working copy)
@@ -72,8 +72,10 @@
 
     rthal_local_irq_save_hw(flags);
 #endif /* CONFIG_XENO_OPT_PIPELINE_HEAD */
-    if (!delay) { delay = 10; }
-    ia64_set_itm(ia64_get_itc() + delay);
+    if (!delay)
+	rthal_trigger_irq(RTHAL_TIMER_IRQ);
+    else
+	ia64_set_itm(ia64_get_itc() + delay);
 #ifndef CONFIG_XENO_OPT_PIPELINE_HEAD
     rthal_local_irq_restore_hw(flags);
 #endif /* CONFIG_XENO_OPT_PIPELINE_HEAD */
Index: include/asm-powerpc/hal.h
===================================================================
--- include/asm-powerpc/hal.h	(revision 1456)
+++ include/asm-powerpc/hal.h	(working copy)
@@ -73,11 +73,12 @@
 static inline void rthal_timer_program_shot(unsigned long delay)
 {
 	if (!delay)
-		delay = 1;
+		rthal_trigger_irq(RTHAL_TIMER_IRQ);
+	else
 #ifdef CONFIG_40x
-	mtspr(SPRN_PIT, delay);
+		mtspr(SPRN_PIT, delay);
 #else /* !CONFIG_40x */
-	set_dec((int)delay);	/* decrementer is only 32-bits */
+	        set_dec((int)delay);	/* decrementer is only 32-bits */
 #endif /* CONFIG_40x */
 }
 

--Zi3/lmrL7l--

