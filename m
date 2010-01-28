Message-ID: <4B61C195.8000500@domain.hid>
Date: Thu, 28 Jan 2010 17:55:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B615E0E.7070601@domain.hid>
In-Reply-To: <4B615E0E.7070601@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [PATCH v2] x86: Fix handling of IRQ_MOVE_CLEANUP_VECTOR
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

IRQ_MOVE_CLEANUP_VECTOR is at 0x20, ie. far below FIRST_SYSTEM_VECTOR.
So we must not translate it when calling ipipe_virtualize_irq, and we
have to demux it properly in __ipipe_handle_irq.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

Changes in v2:
 - special demux code for __ipipe_handle_irq

 arch/x86/kernel/ipipe.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index b471355..76fd782 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -289,7 +289,7 @@ void __init __ipipe_enable_pipeline(void)
 			     IPIPE_STDROOT_MASK);
 
 	ipipe_virtualize_irq(ipipe_root_domain,
-			     ipipe_apic_vector_irq(IRQ_MOVE_CLEANUP_VECTOR),
+			     IRQ_MOVE_CLEANUP_VECTOR,
 			     (ipipe_irq_handler_t)&smp_irq_move_cleanup_interrupt,
 			     NULL,
 			     &__ipipe_ack_apic,
@@ -311,7 +311,10 @@ void __init __ipipe_enable_pipeline(void)
 	 * IPIPE_SYSTEM_MASK has been passed for them, that's ok. */
 
 	for (irq = 0; irq < NR_IRQS; irq++)
-		/* Fails for IPIPE_CRITICAL_IPI but that's ok. */
+		/*
+		 * Fails for IPIPE_CRITICAL_IPI and IRQ_MOVE_CLEANUP_VECTOR,
+		 * but that's ok.
+		 */
 		ipipe_virtualize_irq(ipipe_root_domain,
 				     irq,
 				     (ipipe_irq_handler_t)&do_IRQ,
@@ -900,6 +903,8 @@ int __ipipe_handle_irq(struct pt_regs *regs)
 #ifdef CONFIG_X86_LOCAL_APIC
 		if (vector >= FIRST_SYSTEM_VECTOR)
 			irq = ipipe_apic_vector_irq(vector);
+		else if (vector == IRQ_MOVE_CLEANUP_VECTOR)
+			irq = vector;
 		else
 #endif
 			irq = __get_cpu_var(vector_irq)[vector];
-- 
1.6.0.2

