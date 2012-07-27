Message-ID: <5012BB11.9000407@xenomai.org>
Date: Fri, 27 Jul 2012 18:00:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CE2E43470FE5444A811B580382FE5EDF2113D8D95A@KEMPMAIL2.woodward.com>	<5009A292.4060508@grandegger.com>	<CE2E43470FE5444A811B580382FE5EDF2113EA8DE7@KEMPMAIL2.woodward.com>
	<501028DC.8000803@xenomai.org> <50102E8D.1040004@xenomai.org>
	<CE2E43470FE5444A811B580382FE5EDF2113EA8E07@KEMPMAIL2.woodward.com>
	<50105A22.3090704@xenomai.org>
	<CE2E43470FE5444A811B580382FE5EDF2113EA8FD2@KEMPMAIL2.woodward.com>
	<50113143.50101@xenomai.org>
	<CE2E43470FE5444A811B580382FE5EDF2113EA9383@KEMPMAIL2.woodward.com>
In-Reply-To: <CE2E43470FE5444A811B580382FE5EDF2113EA9383@KEMPMAIL2.woodward.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai installation on P1020RDB
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lukasz Zemla <Lukasz.Zemla@woodward.com>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 07/27/2012 05:53 PM, Lukasz Zemla wrote:

> What I discovered, the source of the '76s problem' could be preemption model. Now, when I set:
>  - CONFIG_PREEMPT - the lag exists exactly after eth0 initialization. 
>  - CONFIG_PREEMPT_VOLUNTARY - the boot process stops for a while (about 50-70s) in different places.
>  - CONFIG_PREEMPT_NONE then all is fine, I cannot observe any described problems.


CONFIG_PREEMPT or PREEMPT_VOLUNTARY. Try this patch:

diff --git a/arch/powerpc/kernel/ipipe.c b/arch/powerpc/kernel/ipipe.c
index 45302c1..5b706da 100644
--- a/arch/powerpc/kernel/ipipe.c
+++ b/arch/powerpc/kernel/ipipe.c
@@ -344,8 +344,10 @@ static void __ipipe_do_IRQ(unsigned int irq, void
*cookie)

 static void __ipipe_do_timer(unsigned int irq, void *cookie)
 {
+	irq_enter();
 	check_stack_overflow();
 	timer_interrupt(__this_cpu_ptr(&ipipe_percpu.tick_regs));
+	irq_exit();
 }

 asmlinkage int __ipipe_grab_timer(struct pt_regs *regs)

Or to remove the #ifdef CONFIG_IPIPE / #endif around the calls to
irq_enter/irq_exit in arch/powerpc/kernel/time.c
-- 
                                                                Gilles.

