Message-ID: <4C2DAF63.4040708@domain.hid>
Date: Fri, 02 Jul 2010 11:20:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1278061090.2358.33.camel@domain.hid>
In-Reply-To: <1278061090.2358.33.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Adeos I-PIPE NS9215 port problem
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Iker Amescua <iamescua@domain.hid>
Cc: adeos-main@gna.org

Iker Amescua wrote:
> Hello
> 
> I am trying to port adeos i-pipe patch to run xenomai in an unsupported
> arch, NS9215 from Digi. I have followed instructions from
> http://www.xenomai.org/index.php/I-pipe:ArmPorting and looked at
> currently supported ports (mach-imx) but I am stuck witch the following
> error during boot
> 
> 
> [42949375.440000] ->handle_irq():  c002c39c, handle_prio_irq+0x0/0xec
> [42949375.440000] ->chip(): c026e104, 0xc026e104
> [42949375.440000] ->action(): c026e24c
> [42949375.440000] ->action->handler(): c002c7a0,
> ns921x_clockevent_handler+0x0/0x68
> [42949375.440000]    IRQ_NOPROBE set
> [42949375.440000] irq 19, desc: c02712a4, depth: 0, count: 248,
> unhandled: 0
> [42949375.450000] irq 19, desc: c02712a4, depth: 0, count: 249,
> unhandled: 0
> [42949375.450000] ->handle_irq():  c002c39c, handle_prio_irq+0x0/0xec
> [42949375.450000] ->chip(): c026e104, 0xc026e104
> [42949375.450000] ->action(): c026e24c
> [42949375.450000] ->action->handler(): c002c7a0,
> ns921x_clockevent_handler+0x0/0x68
> [42949375.450000]    IRQ_NOPROBE set
> [42949375.460000] ->handle_irq():  c002c39c, handle_prio_irq+0x0/0xec
> [42949375.460000] ->chip(): c026e104, 0xc026e104
> 
> [42949375.460000] ->action(): c026e24c
> [42949375.460000] ->action->handler(): c002c7a0,
> ns921x_clockevent_handler+0x0/0x68
> [42949375.460000]    IRQ_NOPROBE set
> [42949375.460000] irq 19, desc: c02712a4, depth: 0, count: 250,
> unhandled: 0
> 
> These messages repeat endlessly.
> 
> The board kernel 2.6.28.10 customized by Digi for adding support to
> their ns92xx processors. The configuration is done using
> CONFIG_GENERIC_TIME and CONFIG_GENERIC_CLOCKEVENTS. IRQ 19 is the
> clockevent_device's irq.
> 
> My clock event handler function is
> 
> static irqreturn_t ns921x_clockevent_handler(int irq, void *dev_id)
> {
> 	struct clock_event_device *evt = &ns921x_clockevent_device;
> #ifndef CONFIG_IPIPE
> 	int timerno = irq - IRQ_NS921X_TIMER0;
> 	u32 tc;
> 
> 	/* clear irq */
> 	tc = __raw_readl(SYS_TC(timerno));
> 	if (REGGET(tc, SYS_TCx, RELENBL) == SYS_TCx_RELENBL_DIS) {
> 		REGSET(tc, SYS_TCx, TE, DIS);
> 		__raw_writel(tc, SYS_TC(timerno));
> 	}
> 	REGSETIM(tc, SYS_TCx, INTCLR, 1);
> 	__raw_writel(tc, SYS_TC(timerno));
> 	REGSETIM(tc, SYS_TCx, INTCLR, 0);
> 	__raw_writel(tc, SYS_TC(timerno));
> 
> #else /* CONFIG_IPIPE */
> 	ipipe_mach_update_tsc();
> #endif /* CONFIG_IPIPE */
> 	evt->event_handler(evt);
> 	return  IRQ_HANDLED;
> }
> 
> and
> 
> void __ipipe_mach_acktimer(void)
> {
> 	int timerno = IRQ_NS921X_TIMER1 - IRQ_NS921X_TIMER0;
> 	u32 tc;
> 	tc = __raw_readl(SYS_TC(timerno));
> 	if (REGGET(tc, SYS_TCx, RELENBL) == SYS_TCx_RELENBL_DIS) {
> 		REGSET(tc, SYS_TCx, TE, DIS);
> 		__raw_writel(tc, SYS_TC(timerno));
> 	}
> 
> 	REGSETIM(tc, SYS_TCx, INTCLR, 1);
> 	__raw_writel(tc, SYS_TC(timerno));
> 	REGSETIM(tc, SYS_TCx, INTCLR, 0);+static int __netdev_printk(const char *level, const struct net_device *dev,
+			   struct va_format *vaf)
+{
+	int r;
+
+	if (dev && dev->dev.parent)
+		r = dev_printk(level, dev->dev.parent, "%s: %pV",
+			       netdev_name(dev), vaf);
+	else if (dev)
+		r = printk("%s%s: %pV", level, netdev_name(dev), vaf);
+	else
+		r = printk("%s(NULL net_device): %pV", level, vaf);
+
+	return r;
+}
+
+int netdev_printk(const char *level, const struct net_device *dev,
+		  const char *format, ...)
+{
+	struct va_format vaf;
+	va_list args;
+	int r;
+
+	va_start(args, format);
+
+	vaf.fmt = format;
+	vaf.va = &args;
+
+	r = __netdev_printk(level, dev, &vaf);
+	va_end(args);
+
+	return r;
+}

> 	__raw_writel(tc, SYS_TC(timerno));
> }
> 
> Using printk I see both functions (first ns921x_clockevent_handler and
> then __ipipe_mach_acktimer) are called
> 
> handle_prio_irq is a Digi's custom irq handler used in all interrupts
> set_irq_handler(i, handle_prio_irq);
> 
> /* this is similar to handle_fasteoi_irq.  The differences are:
>  *  - handle_prio_irq calls desc->chip->ack at the beginning;
>  *  - handle_prio_irq disables an irq directly after handle_IRQ_event to
> work
>  *    around the bug in the ns9xxx' irq priority encoder;
>  *  - currently some debug code;
>  */
> static void handle_prio_irq(unsigned int irq, struct irq_desc *desc)
> {
> 	unsigned int cpu = smp_processor_id();
> 	struct irqaction *action;
> 	irqreturn_t action_ret;
> 
> 	spin_lock(&desc->lock);
> 
> 	desc->chip->ack(irq);
> 
> 	if (unlikely(desc->status & IRQ_INPROGRESS)) {
> 		desc->status |= IRQ_PENDING;
> 		goto out_unlock;
> 	}
> 
> 	desc->status &= ~(IRQ_REPLAY | IRQ_WAITING);
> 	kstat_cpu(cpu).irqs[irq]++;
> 
> 	action = desc->action;
> 	if (unlikely(!action || (desc->status & IRQ_DISABLED))) {
> 		desc->status |= IRQ_PENDING;
> 		goto out_mask;
> 	}
> 
> 	desc->status |= IRQ_INPROGRESS;
> 	desc->status &= ~IRQ_PENDING;
> 	spin_unlock(&desc->lock);
> 
> 	action_ret = handle_IRQ_event(irq, action);
> 	if (!noirqdebug)
> 		note_interrupt(irq, desc, action_ret);
> 
> 	spin_lock(&desc->lock);
> 	desc->status &= ~IRQ_INPROGRESS;
> 
> 	if (desc->status & IRQ_DISABLED)
> out_mask:
> 		desc->chip->mask(irq);
> 
> 	desc->chip->eoi(irq);
> 
> out_unlock:
> 	spin_unlock(&desc->lock);
> } 
> 
> Adeos i-pipe patch used: adeos-ipipe-2.6.28.10-arm-1.12-07.patch
> 
> Any ideas what is wrong?

This is hard to say, the full code, and the config you use would help
more. However, the I-pipe patch does a few operations to get the kernel
irq handlers working with it. Obviously, by using handle_prio_irq, you
completely avoid these operations, this could explain why your system
does not work. Now looking at its code, I see that it calls eoi at the
end of the handler. This is wrong, because it will cause interrupts
handlers running in the linux domain to block interrupts of lower
priority running in xenomai domain. If all interrupts in your system
uses this handler, it is better to define the "irq_finish" macro to call
the eoi, use handle_edge_irq and drop this custom irq handler. The
system will work with no further.

Otherwise, you will have to patch the kernel more heavily to get the
handler working (starting by calling the eoi callback in the ack
callback, otherwise, your kernel will be wrong with regard to determinism).

Besides, the timer irq handler does not go trough the kernel handlers,
it is handled directly by the I-pipe, so moving the eoi in the ack
callback or use the irq_finish macro is mandatory to get the timer irq
properly eoied.

-- 
					    Gilles.

