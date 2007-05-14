From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <464814D9.8070700@domain.hid>
References: <464814D9.8070700@domain.hid>
Content-Type: text/plain
Date: Mon, 14 May 2007 11:32:21 +0200
Message-Id: <1179135141.5045.53.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] Adeos for Linux 2.6.19 PowerPC kernels.
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Benjamin Zores <benjamin.zores@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2007-05-14 at 09:50 +0200, Benjamin Zores wrote:
> Hello,
> 
> A few time ago, I've sent a first draft of a patch that aimed at porting 
> Adeos Ipipe from PPC to PowerPC kernel architecture.
> While being ported, the patch had problems running on due to some 
> incompabilities with the IRQ handling.
> 
> I recently reworked on it and have it fixed.
> Please see attached patch that adds PowerPC support on Linux 2.6.19(.2) 
> kernel. It is based on current ppc patch (v1.5) for 2.6.19.
> 
> For the record, the previous draft was in fact blocking as soon as  an 
> h/w IRQ comes in. Adeos was unable to acknowledge the interruption and 
> so, it was triggered thousands of times a second, hanging on the board.
> 
> Judging by arch/powerpc/sysdev/ipic.c, I've replaced all ack() calls in 
> ipipe-root.c by a mask_ack() call and added an end() implementation, 
> that basically unmask() the IRQ after being treated.
> 
> This may not be the best way to solve the issue but at least it works 
> for now, allowing more dev to be done on PowerPC platform. The best way 
> would probably to adapt the ipipe-root to a new Adeos version (like x86 
> arch does, defining multiple acknowledging functions, whether the IRQ is 
> level or edge based, but it's out of my scope right now).

FWIW, I've almost finished an I-pipe port over 2.6.21 also using the
arch/powerpc tree. It relies on the genirq layer which makes things way
more comfortable, and which does not require to redefine particular ack
routines but rather keep the original irqchip handlers.

> 
> If the patch is accepted (and I hope it will), I may extend it later on 
> (for more recent kernels like 2.6.21) or upgrading to a newest Adeos 
> version (but each version being pretty undocumented in terms of 
> ChangeLog, it's pretty hard to do) if you can provide me advices, unless 
> somebody else beats me on that.
> 

This should get better when the I-pipe/powerpc development is merged
into the main git repo here, which should happen in a reasonable future:
http://www.denx.de/cgi-bin/gitweb.cgi?p=ipipe-2.6.git;a=summary

> PS: if applied, please keep the README.adeos file unchanged as it was 
> mandatory for me to have the patch pushed upstream ;-)

Note: you are mixing my [and Karim's words] from the orginal Abstract
with your words from the new Disclaimer, making the "we" clauses rather
confusing. It should be more of a README.alcatel-lucent file than a
README.adeos one.

> 
> Thanks for reviewal,
> 

I had a look at this patch, and I see two issues, one of which can't be
solved easily unless you make your code use the genirq layer (see
x86-1.7 series and beyond), the other one is simple to fix.

Calling mask_ack in __ipipe_ack works for edge/level IRQs, but would not
be applicable to transparent controllers only requiring the software to
send eoi, or per-cpu IRQ flows involving mask+eoi for instance.
Basically, this code works because it assumes that all IRQs are somehow
managed in level mode thus preventing the interrupt flood, but this may
not be always the case. Working with the vanilla genirq layer solves
this.

The other issue is an old bug of mine for this port, specifically we
need to call irq_enter()/irq_exit() for virtual interrupts too;
otherwise, softirqs triggered by virtual ones might be delayed until the
next hw interrupt comes in. Something like this would do:

--- 2.6.19-ppc/include/asm/ipipe.h~	2007-02-18 15:55:03.000000000 +0100
+++ 2.6.19-ppc/include/asm/ipipe.h	2007-05-14 10:50:45.000000000 +0200
@@ -198,8 +198,14 @@
 do {					 	\
 	local_irq_enable_nohead(ipd);		\
 	if (ipd == ipipe_root_domain) {		\
-		((void (*)(unsigned, struct pt_regs *))			\
-		 ipd->irqs[irq].handler) (irq, __ipipe_tick_regs + cpuid); \
+		if (likely(!ipipe_virtual_irq_p(irq)))			\
+			((void (*)(unsigned, struct pt_regs *))		\
+			 ipd->irqs[irq].handler) (irq, __ipipe_tick_regs + cpuid); \
+		else {							\
+			irq_enter();					\
+			ipd->irqs[irq].handler(irq, ipd->irqs[irq].cookie);\
+			irq_exit();					\
+		}							\
 	} else {							\
 		__clear_bit(IPIPE_SYNC_FLAG, &cpudata->status);		\
 		ipd->irqs[irq].handler(irq,ipd->irqs[irq].cookie);	\

In the same move, you would also need to prevent irq_enter() to be
called twice for the decrementer trap which is bound to a virtual
interrupt in our case (otherwise, this would wreck the tasklets
triggering, and cause RCU to misbehave for instance):

--- 2.6.19-ppc/arch/powerpc/kernel/time.c~	2006-11-29 22:57:37.000000000 +0100
+++ 2.6.19-ppc/arch/powerpc/kernel/time.c	2007-05-14 11:02:45.000000000 +0200
@@ -625,7 +625,9 @@
 #endif
 
 	old_regs = set_irq_regs(regs);
+#ifndef CONFIG_IPIPE
 	irq_enter();
+#endif
 
 	profile_tick(CPU_PROFILING);
 	calculate_steal_time();
@@ -686,7 +688,9 @@
 	}
 #endif
 
+#ifndef CONFIG_IPIPE
 	irq_exit();
+#endif
 	set_irq_regs(old_regs);
 }
 
-- 
Philippe.



