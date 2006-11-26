Message-ID: <4569E959.2030904@domain.hid>
Date: Sun, 26 Nov 2006 20:22:01 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] Adeos support for 2.6.18 merged PowerPC
	architecture.
References: <20061124105346.e442448d.benjamin.zores@domain.hid>	<4566C5AF.7030107@domain.hid>	<20061124113009.08c0a490.benjamin.zores@domain.hid>
	<4569E699.6050003@domain.hid>
In-Reply-To: <4569E699.6050003@domain.hid>
Content-Type: multipart/mixed; boundary="------------020205080708030308020204"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------020205080708030308020204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Forgot to attach the patch, sorry.

Wolfgang.

Wolfgang Grandegger wrote:
> Benjamin Zores wrote:
>> On Fri, 24 Nov 2006 11:13:03 +0100
>> Wolfgang Grandegger <wg@domain.hid> wrote:
>>
>>> Yes, the PowerPC tree is not yet supported.
>>
>> Yes but as i need it now i've decided to port it ;-)
>> Or at least of a try.
> 
> Good, :-)
> 
>>> You might have realized my hack to get ride of radix-tree.h for the 
>>> ppc tree.
>>
>> Actually not, have some patch ?
> 
> For the ppc tree, I have added
> 
>   #ifdef CONFIG_PPC_MERGE
>   #include <linux/radix-tree.h>
>   #endif
> 
> to include/powerpc/irq.h to get rid of the trouble with radix-tree.h.
> 
>>> What defconfig do you use? Unfortunately I do not have a board by 
>>> hand supported by the PowerPC tree.
>>
>> mpc834x_itx_defconfig
> 
> I briefly reviewed your patch. At a first glance, it looks OK, but it is 
> not yet complete and it does not compile. Quickly, I spotted the 
> following problems:
> 
> - NR_IRQS is not defined. This is a problem with the include weirdness 
> due to radix-tree.h, IIRC. It is set to 512 for all PowerPC archs, puh, 
> that's overkill (but not our problem for the time being).
> 
> _ipipe_grab_irq(): special IRQ numbers have changed. Check for 
> NO_IRQ_IGNORE in the attached patch. Also the new IRQ handling needs a 
> more detailed review (check irq.c in the powerpc tree).
> 
> - disarm_decr[] has disappeared. It was used to disable the programming 
> of the decrementer in arch/ppc/kernel/time.c:timer_interrupt(). It needs 
> an appropriate replacement in the powerpc tree. A quick, untested hack 
> is in the attached patch.
> 
> There might be more issues.
> 
> We should also avoid code duplication of IPIPE files, but that's 
> something I will fix later-on.
> 
> Hope this helps you to get a bit further (kernel booted).
> 
> Wolfgang.
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 
> 


--------------020205080708030308020204
Content-Type: text/x-patch;
 name="adeos-powerpc-2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="adeos-powerpc-2.diff"

Index: linux-2.6.18/arch/powerpc/kernel/time.c
===================================================================
--- linux-2.6.18.orig/arch/powerpc/kernel/time.c
+++ linux-2.6.18/arch/powerpc/kernel/time.c
@@ -699,9 +699,15 @@ void timer_interrupt(struct pt_regs * re
 		}
 		write_sequnlock(&xtime_lock);
 	}
-	
+#ifdef CONFIG_IPIPE
+	if (__ipipe_decr_ticks == tb_ticks_per_jiffy) {
+		next_dec = tb_ticks_per_jiffy - ticks;
+		set_dec(next_dec);
+	}
+#else /* !CONFIG_IPIPE */
 	next_dec = tb_ticks_per_jiffy - ticks;
 	set_dec(next_dec);
+#endif /* CONFIG_IPIPE */
 
 #ifdef CONFIG_PPC_ISERIES
 	if (hvlpevent_is_pending())
Index: linux-2.6.18/arch/powerpc/kernel/ipipe-core.c
===================================================================
--- linux-2.6.18.orig/arch/powerpc/kernel/ipipe-core.c
+++ linux-2.6.18/arch/powerpc/kernel/ipipe-core.c
@@ -224,7 +224,6 @@ static void __ipipe_set_decr(void)
 
 	ipipe_load_cpuid();
 
-	disarm_decr[cpuid] = (__ipipe_decr_ticks != tb_ticks_per_jiffy);
 #ifdef CONFIG_40x
 	/* Enable and set auto-reload. */
 	mtspr(SPRN_TCR, mfspr(SPRN_TCR) | TCR_ARE);
Index: linux-2.6.18/arch/powerpc/kernel/ipipe-root.c
===================================================================
--- linux-2.6.18.orig/arch/powerpc/kernel/ipipe-root.c
+++ linux-2.6.18/arch/powerpc/kernel/ipipe-root.c
@@ -314,7 +314,9 @@ int __ipipe_grab_irq(struct pt_regs *reg
 	ipipe_declare_cpuid;
 	int irq;
 
-	if ((irq = ppc_md.get_irq(regs)) >= 0) {
+	irq = ppc_md.get_irq(regs);
+
+	if (irq != NO_IRQ && irq != NO_IRQ_IGNORE) {
 #ifdef CONFIG_IPIPE_TRACE_IRQSOFF
 		ipipe_trace_begin(irq);
 #endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
@@ -323,7 +325,7 @@ int __ipipe_grab_irq(struct pt_regs *reg
 		ipipe_trace_end(irq);
 #endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
 	}
-	else if (irq != -2)
+	else if (irq != NO_IRQ_IGNORE)
 		ppc_spurious_interrupts++;
 
 	ipipe_load_cpuid();

--------------020205080708030308020204--

