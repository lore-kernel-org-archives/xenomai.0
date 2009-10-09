MIME-Version: 1.0
In-Reply-To: <4ACDA5A9.6070408@domain.hid>
References: <1f3e02580910080127k766f2407o317ae8a2ce088b4a@domain.hid>
	<4ACDA5A9.6070408@domain.hid>
Date: Fri, 9 Oct 2009 11:09:36 +0900
Message-ID: <1f3e02580910081909j1cb4fe90yd4f22aad11d51441@domain.hid>
From: Didenko Sergey <didenkos@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd480a664bc3b04757712b7
Subject: Re: [Xenomai-help] Support for ARCH_MV88F6290
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--000e0cd480a664bc3b04757712b7
Content-Type: text/plain; charset=UTF-8

2009/10/8 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Didenko Sergey wrote:
> > Dear Xenomai Experts,
> >
> > So far I did not progress too much.
> >
> > What I have now is that patched Linux is starting to boot as original
> > kernel and it hangs right after line
> > [42949373.240000] ata1: SATA max UDMA/133 irq 27
> > As you can see after line
> >
> > [42949373.230000] ?^<6>Xenomai: real-time nucleus v2.4.9.1 (Big Bad
> > Moon) loaded.
> >
> > System does not go to timer_interrupt() function any more.
>
> That is expected. Once Xenomai runs, it takes over the timer interrupt.
>
> >
> > What I'm worring about is that the system has 2 timers, one is
> > free-running with disabled interrupts, second one is interrupt-driven
> > clockevent timer.
>
> No problem. Use the clockevent timer for hardware timer, use the
> free-running counter for tsc emulation.
>
> >
> > =========================== Code - Start
> > (...)
> > =========================== Code - End
> >
> > According to HOWTO Xenomai needs free-running counter, in my case it is
> > Timer 0, but all functions are configured to work with Timer 1, which is
> > not free running.
> >
> > What would you suggest to do?
>
> No, the howto does not say that you need a free-running counter. It
> shows the example of a free-running counter and tell you to look at the
> integrator or s3cxxxx code if you want to know how to implement the
> I-pipe support for a decrementer. The reason being that I wrote the
> howto, and I never had to work with a decrementer.
>
>
If you never worked with decrementer, I do not want to use it if there is
any other way...
For example can I:
- Enable interrupts for free-running Timer0?
- Add one more timer with proper functionality for Xenomai (system has 2
more timers which are not initialized) ?

If you really want us to help you should show us the code that you
> added, not the code that we can already find in the linux kernel sources.
>

Of course I really want...

The code I added is under XENOMAI_SUPPORT_DSV definition

file time.c
=========================== Code - Start

#if XENOMAI_SUPPORT_DSV

#ifdef CONFIG_IPIPE
#ifdef CONFIG_NO_IDLE_HZ
#error "dynamic tick timer not yet supported with IPIPE"
#endif /* CONFIG_NO_IDLE_HZ */
#endif /* CONFIG_IPIPE */

#endif

/*
 * Timer block registers.
 */
#define TIMER_CTRL        (TIMER_VIRT_BASE + 0x0000)
#define  TIMER0_EN        0x0001
#define  TIMER0_RELOAD_EN    0x0002
#define  TIMER1_EN        0x0004
#define  TIMER1_RELOAD_EN    0x0008
#define TIMER0_RELOAD        (TIMER_VIRT_BASE + 0x0010)
#define TIMER0_VAL        (TIMER_VIRT_BASE + 0x0014)
#define TIMER1_RELOAD        (TIMER_VIRT_BASE + 0x0018)
#define TIMER1_VAL        (TIMER_VIRT_BASE + 0x001c)


#if XENOMAI_SUPPORT_DSV

#define XEN_PRINT(x) printk(x);
//#define XEN_PRINT(x)

/* Assume that 16 is Ok for MV 88F6290 platfrom - Need to be clarified */
#define MIN_OSCR_DELTA 16

/*Hardware timer IRQ number */
int __ipipe_mach_timerint = IRQ_MV88F6290_BRIDGE;
EXPORT_SYMBOL(__ipipe_mach_timerint);

/*Initialized to 0, it became non zero when the hardware timer is handled by
Xenomai. */
int __ipipe_mach_timerstolen = 0;
EXPORT_SYMBOL(__ipipe_mach_timerstolen);

/*
 * Count of hardware timer ticks between two timer interrupts, same thing as
the LATCH constant.
 */
unsigned int __ipipe_mach_ticks_per_jiffy = LATCH;

static int orion_timer_initialized = 0;

union tsc_reg {
#ifdef __BIG_ENDIAN
    struct {
        unsigned long high;
        unsigned long low;
    };
#else /* __LITTLE_ENDIAN */
    struct {
        unsigned long low;
        unsigned long high;
    };
#endif /* __LITTLE_ENDIAN */
    unsigned long long full;
};


#ifdef CONFIG_SMP
static union tsc_reg orion_tsc[NR_CPUS];

void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
{
    info->type = IPIPE_TSC_TYPE_NONE;
}

#else /* !CONFIG_SMP */
static union tsc_reg *orion_tsc;

// export the tsc to user-space

void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
{
    XEN_PRINT( "\n===[Break point] __ipipe_mach_get_tscinfo - IN")

    info->type = IPIPE_TSC_TYPE_FREERUNNING;
    info->u.fr.counter = (unsigned *) TIMER1_VAL;
    info->u.fr.mask = 0xffffffff;
    info->u.fr.tsc = &orion_tsc->full;
}
#endif /* !CONFIG_SMP */

/*
 * info->type indicates that the tsc is based on a free-running counter,
 * info->u.fr.counter is set to the PHYSICAL address of the free-running
counter,
 * info->u.fr.mask is a mask indicating which bits in the free-running
counter are valid.
 * info->u.fr.tsc is a pointer to the shared tsc area
 */

/* Acknowledge the hardware timer interrupt at hardware timer level.  */
void __ipipe_mach_acktimer(void)
{
    /*
     * ACK timer interrupt.
     */
    XEN_PRINT("?")

    writel(BRIDGE_INT_TIMER1_CLR, BRIDGE_CAUSE);
}

// Emulates the tsc;
notrace unsigned long long __ipipe_mach_get_tsc(void)
{
    XEN_PRINT("_")

    if (likely(orion_timer_initialized)) {
        union tsc_reg *local_tsc, result;
        unsigned long stamp;

        local_tsc = &orion_tsc[ipipe_processor_id()];

        __asm__ ("ldmia %1, %M0\n":
             "=r"(result.full): "r"(local_tsc), "m"(*local_tsc));

        barrier();

        stamp = readl(TIMER0_VAL);

        if (unlikely(stamp < result.low))
            /* 32 bit counter wrapped, increment high word. */
            result.high++;
        result.low = stamp;

        return result.full;
    }

        return 0;
}
EXPORT_SYMBOL(__ipipe_mach_get_tsc);

/*
 * Program the hardware timer to trig an interrupt in 'delay' hardware timer
ticks.
 */
void __ipipe_mach_set_dec(unsigned long delay)
{
    u32 u;

    XEN_PRINT("-")

    if (delay > MIN_OSCR_DELTA) {
        unsigned long flags;

        local_irq_save(flags);

                              //  OSCR             //OSMR0
        writel(delay + readl(TIMER1_VAL), TIMER1_RELOAD);

        //OIER |= OIER_E0;

        /*
         * Clear and enable clockevent timer interrupt.
         */
        writel(BRIDGE_INT_TIMER1_CLR, BRIDGE_CAUSE);

        u = readl(BRIDGE_MASK);
        u |= BRIDGE_INT_TIMER1;
        writel(u, BRIDGE_MASK);


        local_irq_restore(flags);
    } else
        ipipe_trigger_irq(IRQ_MV88F6290_BRIDGE);

}
EXPORT_SYMBOL(__ipipe_mach_set_dec);

#endif /* XENOMAI_SUPPORT_DSV */


/*
 * Clocksource handling.
 */
static cycle_t orion_clksrc_read(void)
{
    return 0xffffffff - readl(TIMER0_VAL);
}

static struct clocksource orion_clksrc = {
    .name        = "orion_clocksource",
    .shift        = 20,
    .rating        = 300,
    .read        = orion_clksrc_read,
    .mask        = CLOCKSOURCE_MASK(32),
    .flags        = CLOCK_SOURCE_IS_CONTINUOUS,
};


/*
 * Clockevent handling.
 */
static int
orion_clkevt_next_event(unsigned long delta, struct clock_event_device *dev)
{
    unsigned long flags;
    u32 u;

    XEN_PRINT( "\n===[Break point] orion_clkevt_next_event - IN")

    if (delta == 0)
        return -ETIME;

    local_irq_save(flags);

    /*
     * Clear and enable clockevent timer interrupt.
     */
    writel(BRIDGE_INT_TIMER1_CLR, BRIDGE_CAUSE);

    u = readl(BRIDGE_MASK);
    u |= BRIDGE_INT_TIMER1;
    writel(u, BRIDGE_MASK);

    /*
     * Setup new clockevent timer value.
     */
    writel(delta, TIMER1_VAL);

    /*
     * Enable the timer.
     */
    u = readl(TIMER_CTRL);
    u = (u & ~TIMER1_RELOAD_EN) | TIMER1_EN;
    writel(u, TIMER_CTRL);

    local_irq_restore(flags);

    return 0;
}

static void
orion_clkevt_mode(enum clock_event_mode mode, struct clock_event_device
*dev)
{
    unsigned long flags;
    u32 u;

    XEN_PRINT( "\n===[Break point] orion_clkevt_mode - IN")

    local_irq_save(flags);
    if (mode == CLOCK_EVT_MODE_PERIODIC) {
        /*
         * Setup timer to fire at 1/HZ intervals.
         */
        writel(__ipipe_mach_ticks_per_jiffy - 1, TIMER1_RELOAD);
        writel(__ipipe_mach_ticks_per_jiffy - 1, TIMER1_VAL);

        /*
         * Enable timer interrupt.
         */
        u = readl(BRIDGE_MASK);
        writel(u | BRIDGE_INT_TIMER1, BRIDGE_MASK);

        /*
         * Enable timer.
         */
        u = readl(TIMER_CTRL);
        writel(u | TIMER1_EN | TIMER1_RELOAD_EN, TIMER_CTRL);
    } else {
        /*
         * Disable timer.
         */
        u = readl(TIMER_CTRL);
        writel(u & ~TIMER1_EN, TIMER_CTRL);

        /*
         * Disable timer interrupt.
         */
        u = readl(BRIDGE_MASK);
        writel(u & ~BRIDGE_INT_TIMER1, BRIDGE_MASK);

        /*
         * ACK pending timer interrupt.
         */
        writel(BRIDGE_INT_TIMER1_CLR, BRIDGE_CAUSE);

    }
    local_irq_restore(flags);
}

static struct clock_event_device orion_clkevt = {
    .name        = "orion_tick",
    .features        = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
    .shift        = 32,
    .rating        = 300,
    .set_next_event    = orion_clkevt_next_event,
    .set_mode    = orion_clkevt_mode,
};

static irqreturn_t orion_timer_interrupt(int irq, void *dev_id)
{
    /*
     * ACK timer interrupt
     */
    writel(BRIDGE_INT_TIMER1_CLR, BRIDGE_CAUSE);

    XEN_PRINT( "^")

    /*
     * Call event handler.
     */
    orion_clkevt.event_handler(&orion_clkevt);

    return IRQ_HANDLED;
}

static struct irqaction orion_timer_irq = {
    .name        = "orion_tick",
    .flags        = IRQF_DISABLED | IRQF_TIMER,
    .handler    = orion_timer_interrupt
};

void __init orion_time_init(unsigned int irq, unsigned int tclk)
{
    u32 u;

    __ipipe_mach_ticks_per_jiffy = (tclk + HZ/2) / HZ;

    XEN_PRINT( "\n===[Break point] orion_time_init - IN")

    /*
     * Setup free-running clocksource timer (interrupts disabled)
     */
    writel(0xffffffff, TIMER0_VAL);
    writel(0xffffffff, TIMER0_RELOAD);
    u = readl(BRIDGE_MASK);
    writel(u & ~BRIDGE_INT_TIMER0, BRIDGE_MASK);
    u = readl(TIMER_CTRL);
    writel(u | TIMER0_EN | TIMER0_RELOAD_EN, TIMER_CTRL);
    orion_clksrc.mult = clocksource_hz2mult(tclk, orion_clksrc.shift);
    clocksource_register(&orion_clksrc);

    /*
     * Setup clockevent timer (interrupt-driven)
     */
    setup_irq(irq, &orion_timer_irq);
    orion_clkevt.mult = div_sc(tclk, NSEC_PER_SEC, orion_clkevt.shift);
    orion_clkevt.max_delta_ns = clockevent_delta2ns(0xfffffffe,
&orion_clkevt);
    orion_clkevt.min_delta_ns = clockevent_delta2ns(1, &orion_clkevt);
    orion_clkevt.cpumask = cpumask_of(0);
    clockevents_register_device(&orion_clkevt);

#if XENOMAI_SUPPORT_DSV

#ifdef CONFIG_IPIPE
#ifndef CONFIG_SMP
        orion_tsc = (union tsc_reg *) __ipipe_tsc_area;
        barrier();
#endif /* CONFIG_SMP */
        orion_timer_initialized = 1;
#endif /* CONFIG_IPIPE */

#endif /* XENOMAI_SUPPORT_DSV */


}

#if XENOMAI_SUPPORT_DSV

#ifdef CONFIG_IPIPE
int __ipipe_check_tickdev(const char *devname)
{
    return !strcmp(devname, orion_clkevt.name);

}
#endif /* CONFIG_IPIPE */

void __ipipe_mach_release_timer(void)
{
    XEN_PRINT( "\n===[Break point] __ipipe_mach_release_timer - IN")

        orion_clkevt_mode(orion_clkevt.mode, &orion_clkevt);
        if (orion_clkevt.mode == CLOCK_EVT_MODE_ONESHOT)
                orion_clkevt_next_event(LATCH, &orion_clkevt);
}
EXPORT_SYMBOL(__ipipe_mach_release_timer);

#endif

=========================== Code - End

BTW, how can I know how much the MIN_OSCR_DELTA value should be for MV
88F6290 platfrom?

--000e0cd480a664bc3b04757712b7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2009/10/8 Gilles Chanteperdrix <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org" target=3D"=
_blank">gilles.chanteperdrix@xenomai.org</a>&gt;</span><br><blockquote clas=
s=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margi=
n: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<div>Didenko Sergey wrote:<br>
&gt; Dear Xenomai Experts,<br>
&gt;<br>
&gt; So far I did not progress too much.<br>
&gt;<br>
&gt; What I have now is that patched Linux is starting to boot as original<=
br>
&gt; kernel and it hangs right after line<br>
&gt; [42949373.240000] ata1: SATA max UDMA/133 irq 27<br>
</div><div>&gt; As you can see after line<br>
&gt;<br>
&gt; [42949373.230000] ?^&lt;6&gt;Xenomai: real-time nucleus v2.4.9.1 (Big =
Bad<br>
&gt; Moon) loaded.<br>
&gt;<br>
&gt; System does not go to timer_interrupt() function any more.<br>
<br>
</div>That is expected. Once Xenomai runs, it takes over the timer interrup=
t.<br>
<div><br>
&gt;<br>
&gt; What I&#39;m worring about is that the system has 2 timers, one is<br>
&gt; free-running with disabled interrupts, second one is interrupt-driven<=
br>
&gt; clockevent timer.<br>
<br>
</div>No problem. Use the clockevent timer for hardware timer, use the<br>
free-running counter for tsc emulation.<br>
<br>
&gt;<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D Code - Start<br>
&gt; (...)<br>
<div>&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D Code - End<br>
&gt;<br>
&gt; According to HOWTO Xenomai needs free-running counter, in my case it i=
s<br>
&gt; Timer 0, but all functions are configured to work with Timer 1, which =
is<br>
&gt; not free running.<br>
&gt;<br>
&gt; What would you suggest to do?<br>
<br>
</div>No, the howto does not say that you need a free-running counter. It<b=
r>
shows the example of a free-running counter and tell you to look at the<br>
integrator or s3cxxxx code if you want to know how to implement the<br>
I-pipe support for a decrementer. The reason being that I wrote the<br>
howto, and I never had to work with a decrementer.<br>
<br></blockquote><div>=C2=A0</div><div>If you never worked with decrementer=
, I do not want to use it if there is any other way...<br>For example can I=
:<br>- Enable interrupts for free-running Timer0?<br>- Add one more timer w=
ith proper functionality for Xenomai (system has 2 more timers which are no=
t initialized) ?<br>
<br><blockquote style=3D"border-left: 1px solid rgb(204, 204, 204); margin:=
 0pt 0pt 0pt 0.8ex; padding-left: 1ex;" class=3D"gmail_quote">If you really=
 want us to help you should show us the code that you<br>
added, not the code that we can already find in the linux kernel sources.<b=
r></blockquote><br>Of course I really want... <br><br>The code I added is u=
nder XENOMAI_SUPPORT_DSV definition<br><br>file time.c<br>=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Code - S=
tart<br>
<br>#if XENOMAI_SUPPORT_DSV<br><br>#ifdef CONFIG_IPIPE<br>#ifdef CONFIG_NO_=
IDLE_HZ<br>#error &quot;dynamic tick timer not yet supported with IPIPE&quo=
t;<br>#endif /* CONFIG_NO_IDLE_HZ */<br>#endif /* CONFIG_IPIPE */<br><br>
#endif<br><br>/*<br>=C2=A0* Timer block registers.<br>=C2=A0*/<br>#define T=
IMER_CTRL=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 (TIMER_VIRT_BASE + 0x0000)<b=
r>#define=C2=A0 TIMER0_EN=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 0x0001<br>#d=
efine=C2=A0 TIMER0_RELOAD_EN=C2=A0=C2=A0=C2=A0 0x0002<br>#define=C2=A0 TIME=
R1_EN=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 0x0004<br>
#define=C2=A0 TIMER1_RELOAD_EN=C2=A0=C2=A0=C2=A0 0x0008<br>#define TIMER0_R=
ELOAD=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 (TIMER_VIRT_BASE + 0x0010)<br>#d=
efine TIMER0_VAL=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 (TIMER_VIRT_BASE + 0x=
0014)<br>#define TIMER1_RELOAD=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 (TIMER_=
VIRT_BASE + 0x0018)<br>#define TIMER1_VAL=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 (TIMER_VIRT_BASE + 0x001c)<br>
<br><br>#if XENOMAI_SUPPORT_DSV<br><br>#define XEN_PRINT(x) printk(x);<br>/=
/#define XEN_PRINT(x)<br><br>/* Assume that 16 is Ok for MV 88F6290 platfro=
m - Need to be clarified */<br>#define MIN_OSCR_DELTA 16<br><br>/*Hardware =
timer IRQ number */<br>
int __ipipe_mach_timerint =3D IRQ_MV88F6290_BRIDGE;<br>EXPORT_SYMBOL(__ipip=
e_mach_timerint);<br><br>/*Initialized to 0, it became non zero when the ha=
rdware timer is handled by Xenomai. */<br>int __ipipe_mach_timerstolen =3D =
0;<br>
EXPORT_SYMBOL(__ipipe_mach_timerstolen);<br><br>/*<br>=C2=A0* Count of hard=
ware timer ticks between two timer interrupts, same thing as the LATCH cons=
tant.<br>=C2=A0*/<br>unsigned int __ipipe_mach_ticks_per_jiffy =3D LATCH;<b=
r><br>static int orion_timer_initialized =3D 0;<br>
<br>union tsc_reg {<br>#ifdef __BIG_ENDIAN<br>=C2=A0=C2=A0=C2=A0 struct {<b=
r>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 unsigned long high;<br>=C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 unsigned long low;<br>=C2=A0=C2=A0=C2=A0 };<br>#e=
lse /* __LITTLE_ENDIAN */<br>=C2=A0=C2=A0=C2=A0 struct {<br>=C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 unsigned long low;<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 unsigned long high;<br>
=C2=A0=C2=A0=C2=A0 };<br>#endif /* __LITTLE_ENDIAN */<br>=C2=A0=C2=A0=C2=A0=
 unsigned long long full;<br>};<br><br><br>#ifdef CONFIG_SMP<br>static unio=
n tsc_reg orion_tsc[NR_CPUS];<br><br>void __ipipe_mach_get_tscinfo(struct _=
_ipipe_tscinfo *info)<br>{<br>
=C2=A0=C2=A0=C2=A0 info-&gt;type =3D IPIPE_TSC_TYPE_NONE;<br>}<br><br>#else=
 /* !CONFIG_SMP */<br>static union tsc_reg *orion_tsc;<br><br>// export the=
 tsc to user-space<br><br>void __ipipe_mach_get_tscinfo(struct __ipipe_tsci=
nfo *info)<br>
{<br>=C2=A0=C2=A0=C2=A0 XEN_PRINT( &quot;\n=3D=3D=3D[Break point] __ipipe_m=
ach_get_tscinfo - IN&quot;)<br><br>=C2=A0=C2=A0=C2=A0 info-&gt;type =3D IPI=
PE_TSC_TYPE_FREERUNNING;<br>=C2=A0=C2=A0=C2=A0 info-&gt;u.fr.counter =3D (u=
nsigned *) TIMER1_VAL;<br>=C2=A0=C2=A0=C2=A0 info-&gt;u.fr.mask =3D 0xfffff=
fff;<br>
=C2=A0=C2=A0=C2=A0 info-&gt;u.fr.tsc =3D &amp;orion_tsc-&gt;full;<br>}<br>#=
endif /* !CONFIG_SMP */<br><br>/*<br>=C2=A0* info-&gt;type indicates that t=
he tsc is based on a free-running counter,<br>=C2=A0* info-&gt;u.fr.counter=
 is set to the PHYSICAL address of the free-running counter,<br>
=C2=A0* info-&gt;u.fr.mask is a mask indicating which bits in the free-runn=
ing counter are valid.<br>=C2=A0* info-&gt;u.fr.tsc is a pointer to the sha=
red tsc area<br>=C2=A0*/<br><br>/* Acknowledge the hardware timer interrupt=
 at hardware timer level.=C2=A0 */<br>
void __ipipe_mach_acktimer(void)<br>{<br>=C2=A0=C2=A0=C2=A0 /*<br>=C2=A0=C2=
=A0=C2=A0 =C2=A0* ACK timer interrupt.<br>=C2=A0=C2=A0=C2=A0 =C2=A0*/<br>=
=C2=A0=C2=A0=C2=A0 XEN_PRINT(&quot;?&quot;)<br><br>=C2=A0=C2=A0=C2=A0 write=
l(BRIDGE_INT_TIMER1_CLR, BRIDGE_CAUSE);<br>}<br><br>// Emulates the tsc;<br=
>notrace unsigned long long __ipipe_mach_get_tsc(void)<br>
{<br>=C2=A0=C2=A0=C2=A0 XEN_PRINT(&quot;_&quot;)<br><br>=C2=A0=C2=A0=C2=A0 =
if (likely(orion_timer_initialized)) {<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 union tsc_reg *local_tsc, result;<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 unsigned long stamp;<br><br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 lo=
cal_tsc =3D &amp;orion_tsc[ipipe_processor_id()];<br>
<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 __asm__ (&quot;ldmia %1, %M0\n&qu=
ot;:<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0&quo=
t;=3Dr&quot;(result.full): &quot;r&quot;(local_tsc), &quot;m&quot;(*local_t=
sc));<br><br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 barrier();<br><br>=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 stamp =3D readl(TIMER0_VAL);<br><br>
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (unlikely(stamp &lt; result.low))<=
br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /* 32 bit count=
er wrapped, increment high word. */<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 result.high++;<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 result.low =3D stamp;<br><br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 retu=
rn result.full;<br>=C2=A0=C2=A0=C2=A0 }<br><br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;<br>}<br>EXPORT_SYMBOL(=
__ipipe_mach_get_tsc);<br><br>/*<br>=C2=A0* Program the hardware timer to t=
rig an interrupt in &#39;delay&#39; hardware timer ticks.<br>=C2=A0*/<br>vo=
id __ipipe_mach_set_dec(unsigned long delay)<br>
{<br>=C2=A0=C2=A0=C2=A0 u32 u;<br><br>=C2=A0=C2=A0=C2=A0 XEN_PRINT(&quot;-&=
quot;)<br><br>=C2=A0=C2=A0=C2=A0 if (delay &gt; MIN_OSCR_DELTA) {<br>=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 unsigned long flags;<br><br>=C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 local_irq_save(flags);<br><br>=C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //=C2=A0 OSCR=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //OSMR0<br>
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 writel(delay + readl(TIMER1_VAL), TIM=
ER1_RELOAD);<br><br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 //OIER |=3D OIER_=
E0;<br><br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /*<br>=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0* Clear and enable clockevent timer interrupt.<br>=
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0*/<br>=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 writel(BRIDGE_INT_TIMER1_CLR, BRIDGE_CAUSE);<br>
<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 u =3D readl(BRIDGE_MASK);<br>=C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 u |=3D BRIDGE_INT_TIMER1;<br>=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 writel(u, BRIDGE_MASK);<br><br><br>=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 local_irq_restore(flags);<br>=C2=A0=C2=A0=C2=
=A0 } else<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ipipe_trigger_irq(IRQ_M=
V88F6290_BRIDGE);<br><br>
}<br>EXPORT_SYMBOL(__ipipe_mach_set_dec);<br><br>#endif /* XENOMAI_SUPPORT_=
DSV */<br><br><br>/*<br>=C2=A0* Clocksource handling.<br>=C2=A0*/<br>static=
 cycle_t orion_clksrc_read(void)<br>{<br>=C2=A0=C2=A0=C2=A0 return 0xffffff=
ff - readl(TIMER0_VAL);<br>
}<br><br>static struct clocksource orion_clksrc =3D {<br>=C2=A0=C2=A0=C2=A0=
 .name=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =3D &quot;orion_clocksource&quo=
t;,<br>=C2=A0=C2=A0=C2=A0 .shift=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =3D 2=
0,<br>=C2=A0=C2=A0=C2=A0 .rating=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =3D 3=
00,<br>=C2=A0=C2=A0=C2=A0 .read=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =3D or=
ion_clksrc_read,<br>=C2=A0=C2=A0=C2=A0 .mask=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =3D CLOCKSOURCE_MASK(32),<br>
=C2=A0=C2=A0=C2=A0 .flags=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =3D CLOCK_SO=
URCE_IS_CONTINUOUS,<br>};<br><br><br>/*<br>=C2=A0* Clockevent handling.<br>=
=C2=A0*/<br>static int<br>orion_clkevt_next_event(unsigned long delta, stru=
ct clock_event_device *dev)<br>{<br>=C2=A0=C2=A0=C2=A0 unsigned long flags;=
<br>
=C2=A0=C2=A0=C2=A0 u32 u;<br><br>=C2=A0=C2=A0=C2=A0 XEN_PRINT( &quot;\n=3D=
=3D=3D[Break point] orion_clkevt_next_event - IN&quot;)<br><br>=C2=A0=C2=A0=
=C2=A0 if (delta =3D=3D 0)<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return =
-ETIME;<br><br>=C2=A0=C2=A0=C2=A0 local_irq_save(flags);<br><br>=C2=A0=C2=
=A0=C2=A0 /*<br>=C2=A0=C2=A0=C2=A0 =C2=A0* Clear and enable clockevent time=
r interrupt.<br>
=C2=A0=C2=A0=C2=A0 =C2=A0*/<br>=C2=A0=C2=A0=C2=A0 writel(BRIDGE_INT_TIMER1_=
CLR, BRIDGE_CAUSE);<br><br>=C2=A0=C2=A0=C2=A0 u =3D readl(BRIDGE_MASK);<br>=
=C2=A0=C2=A0=C2=A0 u |=3D BRIDGE_INT_TIMER1;<br>=C2=A0=C2=A0=C2=A0 writel(u=
, BRIDGE_MASK);<br><br>=C2=A0=C2=A0=C2=A0 /*<br>=C2=A0=C2=A0=C2=A0 =C2=A0* =
Setup new clockevent timer value.<br>=C2=A0=C2=A0=C2=A0 =C2=A0*/<br>
=C2=A0=C2=A0=C2=A0 writel(delta, TIMER1_VAL);<br><br>=C2=A0=C2=A0=C2=A0 /*<=
br>=C2=A0=C2=A0=C2=A0 =C2=A0* Enable the timer.<br>=C2=A0=C2=A0=C2=A0 =C2=
=A0*/<br>=C2=A0=C2=A0=C2=A0 u =3D readl(TIMER_CTRL);<br>=C2=A0=C2=A0=C2=A0 =
u =3D (u &amp; ~TIMER1_RELOAD_EN) | TIMER1_EN;<br>=C2=A0=C2=A0=C2=A0 writel=
(u, TIMER_CTRL);<br><br>=C2=A0=C2=A0=C2=A0 local_irq_restore(flags);<br>
<br>=C2=A0=C2=A0=C2=A0 return 0;<br>}<br><br>static void<br>orion_clkevt_mo=
de(enum clock_event_mode mode, struct clock_event_device *dev)<br>{<br>=C2=
=A0=C2=A0=C2=A0 unsigned long flags;<br>=C2=A0=C2=A0=C2=A0 u32 u;<br><br>=
=C2=A0=C2=A0=C2=A0 XEN_PRINT( &quot;\n=3D=3D=3D[Break point] orion_clkevt_m=
ode - IN&quot;)<br>
<br>=C2=A0=C2=A0=C2=A0 local_irq_save(flags);<br>=C2=A0=C2=A0=C2=A0 if (mod=
e =3D=3D CLOCK_EVT_MODE_PERIODIC) {<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 /*<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0* Setup timer to fire=
 at 1/HZ intervals.<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0*/<br>=
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 writel(__ipipe_mach_ticks_per_jiffy -=
 1, TIMER1_RELOAD);<br>
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 writel(__ipipe_mach_ticks_per_jiffy -=
 1, TIMER1_VAL);<br><br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /*<br>=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0* Enable timer interrupt.<br>=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0*/<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 u =3D readl(BRIDGE_MASK);<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 w=
ritel(u | BRIDGE_INT_TIMER1, BRIDGE_MASK);<br>
<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /*<br>=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 =C2=A0* Enable timer.<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
 =C2=A0*/<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 u =3D readl(TIMER_CTRL);=
<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 writel(u | TIMER1_EN | TIMER1_REL=
OAD_EN, TIMER_CTRL);<br>=C2=A0=C2=A0=C2=A0 } else {<br>=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 /*<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0* Disa=
ble timer.<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0*/<br>
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 u =3D readl(TIMER_CTRL);<br>=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 writel(u &amp; ~TIMER1_EN, TIMER_CTRL);<br><br=
>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /*<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0* Disable timer interrupt.<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0*/<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 u =3D readl(BRI=
DGE_MASK);<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 writel(u &amp; ~BRIDGE_=
INT_TIMER1, BRIDGE_MASK);<br>
<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /*<br>=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 =C2=A0* ACK pending timer interrupt.<br>=C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0*/<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 writel(BR=
IDGE_INT_TIMER1_CLR, BRIDGE_CAUSE);<br><br>=C2=A0=C2=A0=C2=A0 }<br>=C2=A0=
=C2=A0=C2=A0 local_irq_restore(flags);<br>}<br><br>static struct clock_even=
t_device orion_clkevt =3D {<br>
=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =3D &quot;ori=
on_tick&quot;,<br>=C2=A0=C2=A0=C2=A0 .features=C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =3D CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,<br>=C2=A0=
=C2=A0=C2=A0 .shift=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =3D 32,<br>=C2=A0=
=C2=A0=C2=A0 .rating=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =3D 300,<br>=C2=
=A0=C2=A0=C2=A0 .set_next_event=C2=A0=C2=A0=C2=A0 =3D orion_clkevt_next_eve=
nt,<br>
=C2=A0=C2=A0=C2=A0 .set_mode=C2=A0=C2=A0=C2=A0 =3D orion_clkevt_mode,<br>};=
<br><br>static irqreturn_t orion_timer_interrupt(int irq, void *dev_id)<br>=
{<br>=C2=A0=C2=A0=C2=A0 /*<br>=C2=A0=C2=A0=C2=A0 =C2=A0* ACK timer interrup=
t<br>=C2=A0=C2=A0=C2=A0 =C2=A0*/<br>=C2=A0=C2=A0=C2=A0 writel(BRIDGE_INT_TI=
MER1_CLR, BRIDGE_CAUSE);<br>
<br>=C2=A0=C2=A0=C2=A0 XEN_PRINT( &quot;^&quot;)<br><br>=C2=A0=C2=A0=C2=A0 =
/*<br>=C2=A0=C2=A0=C2=A0 =C2=A0* Call event handler.<br>=C2=A0=C2=A0=C2=A0 =
=C2=A0*/<br>=C2=A0=C2=A0=C2=A0 orion_clkevt.event_handler(&amp;orion_clkevt=
);<br><br>=C2=A0=C2=A0=C2=A0 return IRQ_HANDLED;<br>}<br><br>static struct =
irqaction orion_timer_irq =3D {<br>
=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =3D &quot;ori=
on_tick&quot;,<br>=C2=A0=C2=A0=C2=A0 .flags=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =3D IRQF_DISABLED | IRQF_TIMER,<br>=C2=A0=C2=A0=C2=A0 .handler=C2=A0=
=C2=A0=C2=A0 =3D orion_timer_interrupt<br>};<br><br>void __init orion_time_=
init(unsigned int irq, unsigned int tclk)<br>{<br>
=C2=A0=C2=A0=C2=A0 u32 u;<br><br>=C2=A0=C2=A0=C2=A0 __ipipe_mach_ticks_per_=
jiffy =3D (tclk + HZ/2) / HZ;<br><br>=C2=A0=C2=A0=C2=A0 XEN_PRINT( &quot;\n=
=3D=3D=3D[Break point] orion_time_init - IN&quot;)<br><br>=C2=A0=C2=A0=C2=
=A0 /*<br>=C2=A0=C2=A0=C2=A0 =C2=A0* Setup free-running clocksource timer (=
interrupts disabled)<br>
=C2=A0=C2=A0=C2=A0 =C2=A0*/<br>=C2=A0=C2=A0=C2=A0 writel(0xffffffff, TIMER0=
_VAL);<br>=C2=A0=C2=A0=C2=A0 writel(0xffffffff, TIMER0_RELOAD);<br>=C2=A0=
=C2=A0=C2=A0 u =3D readl(BRIDGE_MASK);<br>=C2=A0=C2=A0=C2=A0 writel(u &amp;=
 ~BRIDGE_INT_TIMER0, BRIDGE_MASK);<br>=C2=A0=C2=A0=C2=A0 u =3D readl(TIMER_=
CTRL);<br>=C2=A0=C2=A0=C2=A0 writel(u | TIMER0_EN | TIMER0_RELOAD_EN, TIMER=
_CTRL);<br>
=C2=A0=C2=A0=C2=A0 orion_clksrc.mult =3D clocksource_hz2mult(tclk, orion_cl=
ksrc.shift);<br>=C2=A0=C2=A0=C2=A0 clocksource_register(&amp;orion_clksrc);=
<br><br>=C2=A0=C2=A0=C2=A0 /*<br>=C2=A0=C2=A0=C2=A0 =C2=A0* Setup clockeven=
t timer (interrupt-driven)<br>=C2=A0=C2=A0=C2=A0 =C2=A0*/<br>=C2=A0=C2=A0=
=C2=A0 setup_irq(irq, &amp;orion_timer_irq);<br>
=C2=A0=C2=A0=C2=A0 orion_clkevt.mult =3D div_sc(tclk, NSEC_PER_SEC, orion_c=
lkevt.shift);<br>=C2=A0=C2=A0=C2=A0 orion_clkevt.max_delta_ns =3D clockeven=
t_delta2ns(0xfffffffe, &amp;orion_clkevt);<br>=C2=A0=C2=A0=C2=A0 orion_clke=
vt.min_delta_ns =3D clockevent_delta2ns(1, &amp;orion_clkevt);<br>
=C2=A0=C2=A0=C2=A0 orion_clkevt.cpumask =3D cpumask_of(0);<br>=C2=A0=C2=A0=
=C2=A0 clockevents_register_device(&amp;orion_clkevt);<br><br>#if XENOMAI_S=
UPPORT_DSV<br><br>#ifdef CONFIG_IPIPE<br>#ifndef CONFIG_SMP<br>=C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 orion_tsc =3D (union tsc_reg *) __ipipe_tsc_area;=
<br>
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 barrier();<br>#endif /* CONFIG_SMP */=
<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 orion_timer_initialized =3D 1;<br=
>#endif /* CONFIG_IPIPE */<br><br>#endif /* XENOMAI_SUPPORT_DSV */<br><br><=
br>}<br><br>#if XENOMAI_SUPPORT_DSV<br><br>#ifdef CONFIG_IPIPE<br>
int __ipipe_check_tickdev(const char *devname)<br>{<br>=C2=A0=C2=A0=C2=A0 r=
eturn !strcmp(devname, <a href=3D"http://orion_clkevt.name">orion_clkevt.na=
me</a>);<br><br>}<br>#endif /* CONFIG_IPIPE */<br><br>void __ipipe_mach_rel=
ease_timer(void)<br>
{<br>=C2=A0=C2=A0=C2=A0 XEN_PRINT( &quot;\n=3D=3D=3D[Break point] __ipipe_m=
ach_release_timer - IN&quot;)<br><br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 orion_clkevt_mode(orion_clkevt.mode, &amp;orion_clkevt);<br>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (orion_clkevt.mode =3D=3D CLOCK_EVT=
_MODE_ONESHOT)<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 orion_clkevt_next_event(LATCH, &amp;orion=
_clkevt);<br>
}<br>EXPORT_SYMBOL(__ipipe_mach_release_timer);<br><br>#endif<br><br>=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 Code - End<br><br>BTW, how can I know how much the MIN_OSCR_DELTA value sh=
ould be for MV 88F6290 platfrom?<br><br></div></div>

--000e0cd480a664bc3b04757712b7--

