From: Florian Boelstler <kernel@domain.hid>
Date: Tue, 08 Mar 2011 13:44:38 +0100
Message-ID: <il58bm$9lf$1@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [RFC] PPC 85xx: Support for doorbell-based IPIs
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I'm new to Xenomai and started an experimental port to the Freescale 
P4080 platform.
Below a lengthy explanation of my findings and additions to Xenomai 
regarding Inter-Processor Interrupts found on this platform.
I'll appreciate any comments on this topic.

P4080 is a multicore PPC platform (from a software point of view it is 
similar to the 85xx series of PowerQUICC PPCs. The CPU core is called 
e500mc).
Support for this platform is available in mainline Linux for some time.

When it comes to interrupt handling of Inter-Processor Interrupts (IPIs) 
it is different to the previous editions of e500-based platforms.
 From what I've found out so far IPIs are directly asserted as processor 
interrupts (handled using assembly instructions msgsnd and msgclr), 
consequently called doorbell interrupts.
As far as I can see previous multicore PPCs made use of the interrupt 
controller for this purpose and fed the result of an IPI to the CPU as 
an "external interrupt".

Xenomai seems to somehow work on that platform when built for PPC with 
SMP support.
Due to the different handling of IPIs on other SMP-enabled PPCs the 
Xenomai mechanism of grabbing all external interrupts in 
arch/powerpc/kernel/head_fsl_booke.S by the way of __ipipe_grab_irq() 
obviously doesn't work in respect to IPIs.
The mechanism for sending IPIs is fine since its abstracted in Linux 
using smp_85xx_ops.message_pass [1] but the receiving end is 
"disconnected". During boot of a Xenomai-enabled kernel the system fails 
to continue since "mutiplexed" SMP messages of type PPC_MSG_IPIPE_DEMUX 
aren't properly dispatched.

An initial working hack aims at hooking doorbell_exception() [2] in 
order to forword IPIs into the common IPIPE path as well.
I've extracted the necessary pieces from __ipipe_grab_irq() and put it 
in __ipipe_grab_ipi(), which is called from my version of 
doorbell_exception() using the expected interrupt numbers.
Patches below (on top of 2.6.35.7 kernel + 
adeos-ipipe-2.6.35.7-powerpc-2.11-02.patch + all additional patches from 
ipipe-2.6.35.7-powerpc-2.12-01).

I'm totally unsure if this is the right approach for handling IPIs in 
Xenomai and would be happy for any comments on this.
So far this properly boots a Xenomai-enabled Linux kernel.
I've tested most of the sample programs shipped as part of Xenomai 
without problems so far. I somehow feel that this not sufficient...

Thanks in advance.

Cheers,

    Florian

[1] 
http://lxr.linux.no/#linux+v2.6.35.7/arch/powerpc/platforms/85xx/smp.c#L120
[2] http://lxr.linux.no/#linux+v2.6.35.7/arch/powerpc/kernel/traps.c#L1348


commit 2a7eefa749128bdd88ce0520cbcd821cc524e24c
Author: Florian Boelstler <kernel@domain.hid>
Date:   Wed Mar 2 17:54:55 2011 +0100

     Try to handle P4080 doorbell-style IPIs in ipipe

         Xenomai's ipipe seems to handle only OpenPIC-side
         IPIs so far. On P4080 (and other) platforms IPIs are
         triggered through doorbells, which in turn are "real" PPC
         interrupts.
         This hack tries to "grab" those exceptions and feed
         them to the "conventional" IRQ handler of ipipe.

diff --git a/arch/powerpc/kernel/ipipe.c b/arch/powerpc/kernel/ipipe.c
index 825dc26..1cfc918 100644
--- a/arch/powerpc/kernel/ipipe.c
+++ b/arch/powerpc/kernel/ipipe.c
@@ -467,11 +467,35 @@ static int __ipipe_exit_irq(struct pt_regs *regs)
  	return 0;
  }

+void __ipipe_grab_ipi(struct pt_regs *regs, int irq)
+{
+	//printk(KERN_INFO "%s(): I-pipe: irq %d\n", __func__, irq);
+
+	if (likely(irq != NO_IRQ_IGNORE)) {
+		ipipe_trace_irq_entry(irq);
+#ifdef CONFIG_SMP
+		/* Check for cascaded I-pipe IPIs */
+		if (irq == __ipipe_ipi_irq)
+		{
+			//printk(KERN_INFO "I-pipe: grabbed ipi irq %d\n", irq);
+			__ipipe_ipi_demux(irq, regs);
+		}
+		else
+#endif /* CONFIG_SMP */
+			__ipipe_handle_irq(irq, regs);
+	}
+
+	ipipe_trace_irq_exit(irq);
+
+	__ipipe_exit_irq(regs);
+}
+
  asmlinkage int __ipipe_grab_irq(struct pt_regs *regs)
  {
  	int irq;

  	irq = ppc_md.get_irq();
+	//printk(KERN_INFO "I-pipe: grabbed irq %d\n", irq);
  	if (unlikely(irq == NO_IRQ)) {
  		__get_cpu_var(irq_stat).spurious_irqs++;
  		return __ipipe_exit_irq(regs);
@@ -482,7 +506,10 @@ asmlinkage int __ipipe_grab_irq(struct pt_regs *regs)
  #ifdef CONFIG_SMP
  		/* Check for cascaded I-pipe IPIs */
  		if (irq == __ipipe_ipi_irq)
+		{
+			printk(KERN_INFO "I-pipe: ipi irq %d\n", irq);
  			__ipipe_ipi_demux(irq, regs);
+		}
  		else
  #endif /* CONFIG_SMP */
  			__ipipe_handle_irq(irq, regs);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5f7d048..2dc860c 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -113,6 +113,7 @@ void smp_message_recv(int msg)
  #endif /* CONFIG_DEBUGGER */
  		/* FALLTHROUGH */
  	default:
+		dump_stack();
  		printk("SMP %d: smp_message_recv(): unknown msg %d\n",
  		       smp_processor_id(), msg);
  		break;
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 2866cf0..344bc7a 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1386,6 +1386,7 @@ void vsx_assist_exception(struct pt_regs *regs)
  void doorbell_exception(struct pt_regs *regs)
  {
  #ifdef CONFIG_SMP
+	extern void __ipipe_grab_ipi(struct pt_regs *regs, int irq);
  	int cpu = smp_processor_id();
  	int msg;

@@ -1394,7 +1395,8 @@ void doorbell_exception(struct pt_regs *regs)

  	for (msg = 0; msg < 4; msg++)
  		if (test_and_clear_bit(msg, &dbell_smp_message[cpu]))
-			smp_message_recv(msg);
+			//smp_message_recv(msg);
+			__ipipe_grab_ipi(regs,255-(4-msg));
  #else
  	printk(KERN_WARNING "Received doorbell on non-smp system\n");
  #endif


