Message-ID: <4CEE9309.6050808@domain.hid>
Date: Thu, 25 Nov 2010 17:47:05 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4CEE91CB.3060303@domain.hid>
In-Reply-To: <4CEE91CB.3060303@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH 3/3] ipipe: x86: Fix up root state after
 __do_root_[vx]irq under CONFIG_TRACE_IRQFLAGS
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

As TRACE_IRQS_ON, thus also TRACE_IRQS_IRET, synchronizes the root
pipeline state with the pseudo state that __do_root_[vx]irq creates on
entry. We need to fix that up, disabling root IRQs again as
__ipipe_sync_stage may inject more IRQs.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 arch/x86/include/asm/ipipe_32.h |    9 +++++++++
 arch/x86/include/asm/ipipe_64.h |    9 +++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/ipipe_32.h b/arch/x86/include/asm/ipipe_32.h
index 61d7913..38d7870 100644
--- a/arch/x86/include/asm/ipipe_32.h
+++ b/arch/x86/include/asm/ipipe_32.h
@@ -92,6 +92,11 @@ static inline void __do_root_xirq(ipipe_irq_handler_t handler,
 			     : /* no output */
 			     : "a" (~irq), "r" (handler), "rm" (regs),
 			       [x86if] "i" (X86_EFLAGS_IF));
+#ifdef CONFIG_TRACE_IRQFLAGS
+	/* TRACE_IRQS_IRET fully enables root IRQs - disable them again in
+	 * case __ipipe_sync_stage injects another one. */
+	local_irq_disable();
+#endif
 }
 
 #define __ipipe_do_root_xirq(ipd, irq)			\
@@ -132,6 +137,10 @@ static inline void __do_root_virq(ipipe_irq_handler_t handler,
 			     "__virq_end: cli\n"
 			     : /* no output */
 			     : /* no input */);
+#ifdef CONFIG_TRACE_IRQFLAGS
+	/* see __do_root_xirq */
+	local_irq_disable();
+#endif
 }
 
 #define __ipipe_do_root_virq(ipd, irq)	\
diff --git a/arch/x86/include/asm/ipipe_64.h b/arch/x86/include/asm/ipipe_64.h
index c8f2c54..91d7397 100644
--- a/arch/x86/include/asm/ipipe_64.h
+++ b/arch/x86/include/asm/ipipe_64.h
@@ -95,6 +95,11 @@ static inline void __do_root_xirq(ipipe_irq_handler_t handler,
 			       [handler] "r" (handler), "D" (regs),
 			       [x86if] "i" (X86_EFLAGS_IF)
 			     : "rax");
+#ifdef CONFIG_TRACE_IRQFLAGS
+	/* TRACE_IRQS_IRETQ fully enables root IRQs - disable them again in
+	 * case __ipipe_sync_stage injects another one. */
+	local_irq_disable();
+#endif
 }
 
 #define __ipipe_do_root_xirq(ipd, irq)			\
@@ -137,6 +142,10 @@ static inline void __do_root_virq(ipipe_irq_handler_t handler,
 			     "__virq_end: cli\n"
 			     : /* no output */
 			     : /* no input */);
+#ifdef CONFIG_TRACE_IRQFLAGS
+	/* see __do_root_xirq */
+	local_irq_disable();
+#endif
 }
 
 #define __ipipe_do_root_virq(ipd, irq)	\
-- 
1.7.1

