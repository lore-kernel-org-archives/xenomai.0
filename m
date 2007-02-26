Message-ID: <45E2C2C3.1020202@domain.hid>
Date: Mon, 26 Feb 2007 12:21:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency hangs on AT91RM9200
References: <45DECFAF.60304@domain.hid> <45DF04F2.4020002@domain.hid>
	<45DF192C.6020505@domain.hid> <45E2B3A1.8070102@domain.hid>
In-Reply-To: <45E2B3A1.8070102@domain.hid>
Content-Type: multipart/mixed; boundary="------------060505050102000909000308"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-core@domain.hid

This is a multi-part message in MIME format.
--------------060505050102000909000308
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
> Ok, found the bug (actually, Philippe did), as almost expected, the way
> it is related to the latency program period is not really obvious. The
> bug is that in the macro "irq_handler" in entry-armv.S, the return value
> (in r0) of __ipipe_grab_irq is overriden by the subsequent call to
> get_irqnr_and_base.
> 

Here comes a patch. Note that it will only work correctly with
CONFIG_PREEMPT disabled for now.

-- 
                                                 Gilles Chanteperdrix

--------------060505050102000909000308
Content-Type: text/x-patch;
 name="ipipe-arm-irq_handler_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipipe-arm-irq_handler_fix.diff"

--- arch/arm/kernel/entry-armv.S~	2007-02-26 11:55:18.000000000 +0100
+++ arch/arm/kernel/entry-armv.S	2007-02-26 12:07:45.000000000 +0100
@@ -29,12 +29,16 @@
  * Interrupt handling.  Preserves r7, r8, r9
  */
 	.macro	irq_handler
-1:	get_irqnr_and_base r0, r6, r5, lr
+#ifdef CONFIG_IPIPE
+	mov r0, #2
+#endif
+1:	get_irqnr_and_base r4, r6, r5, lr
 	movne	r1, sp
 	@
 	@ routine called with r0 = irq number, r1 = struct pt_regs *
 	@
 	adrne	lr, 1b
+	movne   r0, r4
 #ifdef CONFIG_IPIPE
 	bne	__ipipe_grab_irq
 #else
@@ -48,19 +52,23 @@
 	 * this macro assumes that irqstat (r6) and base (r5) are
 	 * preserved from get_irqnr_and_base above
 	 */
-	test_for_ipi r0, r6, r5, lr
+	test_for_ipi r4, r6, r5, lr
 	movne	r0, sp
 	adrne	lr, 1b
 	bne	do_IPI
 
 #ifdef CONFIG_LOCAL_TIMERS
-	test_for_ltirq r0, r6, r5, lr
+	test_for_ltirq r4, r6, r5, lr
 	movne	r0, sp
 	adrne	lr, 1b
 	bne	do_local_timer
 #endif
 #endif
-
+#ifdef CONFIG_IPIPE
+	cmp	r0, #2
+	moveq	r0, sp
+	bleq	__ipipe_check_root
+#endif	
 	.endm
 
 /*

--------------060505050102000909000308--

