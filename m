From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20101008070148.GB2255@domain.hid>
References: <20101007115728.GA24500@domain.hid>
	<4CADBDC2.8080600@domain.hid>  <20101008070148.GB2255@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 08 Oct 2010 11:41:24 +0200
Message-ID: <1286530884.13186.109.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] kernel oopses when killing realtime task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Pavel Machek <pma@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

On Fri, 2010-10-08 at 09:01 +0200, Pavel Machek wrote:
> Hi!

[snip]

> Now... I'm aware that lock_get/put around irq_free should be
> unneccessary, as should be irq_disable and my ->ready flag. Those were
> my attempts to work around the problem. I'll attach the full source at
> the end.
> 
> > > Unfortunately, when the userspace app is ran and killed repeatedly (so
> > > that interrupt is registered/unregistered all the time), I get
> > > oopses in __ipipe_dispatch_wired() -- it seems to call into the NULL
> > > pointer.
> > > 
> > > I decided that "wired" interrupt when the source is shared between
> > > Linux and Xenomai, is wrong thing, so I disable "wired" interrupts
> > > altogether, but that only moved oops to __virq_end. 
> > 
> > This is wrong. The only way to get a determistically shared IRQs across
> > domains is via the wired path, either using the pattern Gilles cited or,
> > in a slight variation, signaling down via a separate rtdm_nrtsig.
> 
> For now, I'm trying to get it not to oops; deterministic latencies are
> the next topic :-(.

Could you try the patches below? Absolutely untested as required by the
breaktiquette, but might help. Hopefully.

This series is on top of I-pipe 2.6.27-x86:

diff --git a/include/linux/ipipe.h b/include/linux/ipipe.h
index a12f431..b0e59e6 100644
--- a/include/linux/ipipe.h
+++ b/include/linux/ipipe.h
@@ -353,6 +353,15 @@ int ipipe_register_domain(struct ipipe_domain *ipd,
 
 int ipipe_unregister_domain(struct ipipe_domain *ipd);
 
+#ifdef CONFIG_SMP
+void ipipe_drain_interrupt(struct ipipe_domain *ipd,
+			   unsigned int irq);
+#else
+static inline void ipipe_drain_interrupt(struct ipipe_domain *ipd,
+					 unsigned int irq)
+{}
+#endif
+
 void ipipe_suspend_domain(void);
 
 int ipipe_virtualize_irq(struct ipipe_domain *ipd,
diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
index 97e6aae..ac4addc 100644
--- a/kernel/ipipe/core.c
+++ b/kernel/ipipe/core.c
@@ -1250,6 +1250,32 @@ int ipipe_unregister_domain(struct ipipe_domain
*ipd)
 	return 0;
 }
 
+void ipipe_drain_interrupt(struct ipipe_domain *ipd, unsigned int irq)
+{
+	struct ipipe_percpu_domain_data *p;
+	unsigned long flags;
+	int cpu;
+
+	flags = ipipe_critical_enter(NULL);
+	clear_bit(IPIPE_HANDLE_FLAG, &ipd->irqs[irq].control);
+	clear_bit(IPIPE_STICKY_FLAG, &ipd->irqs[irq].control);
+	set_bit(IPIPE_PASS_FLAG, &ipd->irqs[irq].control);
+	ipipe_critical_exit(flags);
+
+	for_each_online_cpu(cpu) {
+		local_irq_save_hw(flags);
+		p = ipipe_percpudom_ptr(ipd, cpu);
+		do {
+			local_irq_restore_hw(flags);
+			cpu_relax();
+			local_irq_save_hw(flags);
+		} while (test_bit(irq, p->irqpend_lomask) ||
+			 test_bit(IPIPE_STALL_FLAG, &p->status));
+		local_irq_restore_hw(flags);
+	}
+}
+EXPORT_SYMBOL_GPL(ipipe_drain_interrupt);
+

This series goes on top of Xenomai 2.5.x:

 /*
  * ipipe_propagate_irq() -- Force a given IRQ propagation on behalf of
  * a running interrupt handler to the next domain down the pipeline.
diff --git a/include/asm-generic/bits/intr.h
b/include/asm-generic/bits/intr.h
index 19b35d6..9452932 100644
--- a/include/asm-generic/bits/intr.h
+++ b/include/asm-generic/bits/intr.h
@@ -57,6 +57,11 @@ static inline void xnarch_chain_irq (unsigned irq)
     rthal_irq_host_pend(irq);
 }
 
+static inline void xnarch_drain_irq(unsigned irq)
+{
+    rthal_irq_drain(irq);
+}
+
 static inline xnarch_cpumask_t xnarch_set_irq_affinity (unsigned irq,
 							xnarch_cpumask_t affinity)
 {
diff --git a/include/asm-generic/hal.h b/include/asm-generic/hal.h
index 34f8ea1..81aef5e 100644
--- a/include/asm-generic/hal.h
+++ b/include/asm-generic/hal.h
@@ -504,6 +504,11 @@ int rthal_irq_disable(unsigned irq);
 
 int rthal_irq_end(unsigned irq);
 
+static inline void rthal_irq_drain(unsigned int irq)
+{
+	ipipe_drain_interrupt(&rthal_domain, irq);
+}
+
 int rthal_irq_host_request(unsigned irq,
                            rthal_irq_host_handler_t handler,
 			   char *name,
diff --git a/ksrc/nucleus/intr.c b/ksrc/nucleus/intr.c
index a6de4ea..1b79874 100644
--- a/ksrc/nucleus/intr.c
+++ b/ksrc/nucleus/intr.c
@@ -792,6 +792,8 @@ int xnintr_detach(xnintr_t *intr)
 		goto out;
 	}
 
+	xnarch_drain_irq(intr->irq);
+
 	__clrbits(intr->flags, XN_ISR_ATTACHED);
 
 	ret = xnintr_irq_detach(intr);

-- 
Philippe.



