MIME-Version: 1.0
Date: Wed, 30 Sep 2009 19:43:57 +0900
Message-ID: <1f3e02580909300343y3bf44fedh8dbc8d7e27fead4d@domain.hid>
From: Didenko Sergey <didenkos@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd22a0c4392ac0474c935db
Subject: [Xenomai-help] [Guide] To patch Linux Kernel with Xenomai for
	Unknown core
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org
Cc: Jorge Ramirez <jorge.ramirez.ortiz@domain.hid>, mohamad.sharifi@domain.hid

--000e0cd22a0c4392ac0474c935db
Content-Type: text/plain; charset=UTF-8

Dear Xenomai experts,

So far there is:

- xenomai-2.4.9.1
- linux-2.6.29
- ARM architecture based on (unknown for Xenomai core)
- It supports CONFIG_GENERIC_TIME and CONFIG_GENERIC_CLOCKEVENTS
- there is no cascaded interrupts

1) I'm following the steps described in README.INSTALL and HOWTO -
http://www.xenomai.org/index.php/I-pipe:ArmPorting
And since I'm very new in Linux as well is in Xenomai (thank God for this
project) all my problems are from that I'm not quite sure whether I'm doing
all steps correct or not.

For now on I have done with:

- prepare kernel with adeos patch
- configure kernel with its original defconfig file (the original
configuration is verified and working fine on target board)
- building kernel (and here we are!)

2) I did add implementation for (even though the  I did not find any link to
it in HOWTO, so I referred to PXA's implementation):
__ipipe_check_tickdev (called from kernel\core.c)

And for:
mv88f6290_osmr0_set_mode
mv88f6290_osmr0_set_next_event
ckevt_mv88f6290_osmr0
Even though all of them are required by __ipipe_mach_release_timer() I did
not find in HOWTO how these functions should be implemented for MYCORE, so I
referred to PXA's implementation again.

3) Then I did define all next things:

#define IRQ_OST0    IRQ_MV88F6290_TIMER0    /* OS Timer IRQ number match */
#define OSCR        __REG(TIMER0_VAL)        /* (TIMER_VIRT_BASE + 0x0014) -
OS timer 0 Register*/
#define OSMR0        __REG(TIMER_CTRL)        /* (TIMER_VIRT_BASE + 0x0000)
- OS timers Control Register*/
#define OIER_E0        (1 << 0)                    /* Interrupt enable
channel 0 */

Since, according to documentation, there is no PENDING (Status) register for
the timer I did comment all the lines required these definitions.
*QUESTION: Please tell me am I right or not and what to do if it is still
required?*

//#define OSSR        __REG(TIMER0_RELOAD)     /* OS Timer Status Register
*/
//#define OSSR_M0        (1 << 0)                    /* Match status channel
0 */

4) Now I have a problem to define OIER value /* OS Timer Interrupt Enable
Register */
According to Documentation, timer has 3 registers: Control, Reload and Timer
Register.
*QUESTION: What to do with OIER, have no idea, need some one kick me in
right direction!*

I'm attaching the code which has been added according to HOWTO for the
reference.

5) Any additional information (schematic or step-by-step explanation) about
*How what I'm doing now is working* is very welcome to share.

========= CODE BEGIN ==========

#ifdef CONFIG_IPIPE
#ifdef CONFIG_NO_IDLE_HZ
#error "dynamic tick timer not yet supported with IPIPE"
#endif /* CONFIG_NO_IDLE_HZ */

#define __REG(x) (*(volatile unsigned long *)x) /* === I'm not sure whether
this implementation should be or another ===*/

//# define __PREG(x)    io_v2p(x)

//#define OSSR        __REG(TIMER0_RELOAD)     /* OS Timer Status Register
*/
#define IRQ_OST0    IRQ_MV88F6290_TIMER0    /* OS Timer IRQ number match */

//#define OSSR_M0        (1 << 0)                    /* Match status channel
0 */
#define OSCR        __REG(TIMER0_VAL)        /* (TIMER_VIRT_BASE + 0x0014) -
OS timer 0 Register*/
#define OSMR0        __REG(TIMER_CTRL)        /* (TIMER_VIRT_BASE + 0x0000)
- OS timers Control Register*/

#define OIER_E0        (1 << 0)                    /* Interrupt enable
channel 0 */

 /* OS Timer Interrupt Enable Register */

/*Hardware timer IRQ number */
int __ipipe_mach_timerint = IRQ_MV88F6290_TIMER0; /* === ??? ===*/
EXPORT_SYMBOL(__ipipe_mach_timerint);

/*Initialized to 0, it became non zero when the hardware timer is handled by
Xenomai. */
int __ipipe_mach_timerstolen = 0;
EXPORT_SYMBOL(__ipipe_mach_timerstolen);

/*Count of hardware timer ticks between two timer interrupts, same thing as
the LATCH constant. */
unsigned int __ipipe_mach_ticks_per_jiffy = LATCH;  /* === ??? ===*/
EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);

static int mv88f6290_timer_initialized;

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
static union tsc_reg tsc[NR_CPUS];

/* (...) */
#else /* !CONFIG_SMP */
static union tsc_reg *tsc;

/* (...) */
#endif
#endif

int mv88f6290_tclk;

int __init mv88f6290_find_tclk(void)
{
    u32 dev, rev;

    mv88f6290_pcie_id(&dev, &rev);

    return 166666667;
}

static void mv88f6290_timer_init(void)
{
    mv88f6290_tclk = mv88f6290_find_tclk();
    orion_time_init(IRQ_MV88F6290_BRIDGE, mv88f6290_tclk);

#ifdef CONFIG_IPIPE
#ifndef CONFIG_SMP
        tsc = (union tsc_reg *) __ipipe_tsc_area;
        barrier();
#endif /* CONFIG_SMP */

        mv88f6290_timer_initialized = 1;
#endif /* CONFIG_IPIPE */

}

struct sys_timer mv88f6290_timer = {
    .init = mv88f6290_timer_init,
};

/* Acknowledge the hardware timer interrupt at hardware timer level.  */
void __ipipe_mach_acktimer(void)
{
    //OSSR = OSSR_M0;  /* Clear match on timer 0 */
}

/* High resolution counter, or its emulation using the hardware decrementer
or free-running counter. */
notrace unsigned long long __ipipe_mach_get_tsc(void)
{
    if (likely(mv88f6290_timer_initialized)) {
        union tsc_reg *local_tsc, result;
        unsigned long stamp;

        local_tsc = &tsc[ipipe_processor_id()];

        __asm__ ("ldmia %1, %M0\n"
             : "=r"(result.full): "r"(local_tsc), "m"(*local_tsc));
        barrier();
        stamp = OSCR;
        if (unlikely(stamp < result.low))
            /* 32 bit counter wrapped, increment high word. */
            result.high++;
        result.low = stamp;

        return result.full;
    }

        return 0;
}
//EXPORT_SYMBOL(__ipipe_mach_get_tsc);

#ifdef CONFIG_IPIPE

/* Fills a structure which will be used in user-space to emulate the tsc. */
#ifdef CONFIG_SMP

/* (...) */
void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
{
    info->type = IPIPE_TSC_TYPE_NONE;
}
#else
/* (...) */
void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
{
    info->type = IPIPE_TSC_TYPE_FREERUNNING;
    info->u.fr.counter = (unsigned *) TIMER0_VAL; /* === ??? ===*/
    info->u.fr.mask = 0xffffffff;
    info->u.fr.tsc = &tsc->full;
}

/*
info->type indicates that the tsc is based on a free-running counter,
info->u.fr.counter is set to the PHYSICAL address of the free-running
counter,
info->u.fr.mask is a mask indicating which bits in the free-running counter
are valid.
info->u.fr.tsc is a pointer to the shared tsc area
*/

#endif /* !CONFIG_SMP */

/* Program the hardware timer to trig an interrupt in 'delay' hardware timer
ticks  */
void __ipipe_mach_set_dec(unsigned long delay)
{
        if (delay > 8)    {

                unsigned long flags;

                local_irq_save_hw(flags);
                OSMR0 = delay + OSCR;
                local_irq_restore_hw(flags);
        }
    else
;                 ipipe_trigger_irq(IRQ_OST0);

}
//EXPORT_SYMBOL(__ipipe_mach_set_dec);

/* Returns the count of hardware timer ticks remaining before the next timer
interrupt. */
unsigned long __ipipe_mach_get_dec(void)
{
    return OSMR0 - OSCR;
}
//EXPORT_SYMBOL(__ipipe_mach_get_dec);

static int
mv88f6290_osmr0_set_next_event(unsigned long delta, struct
clock_event_device *dev)
{
    unsigned long flags, next, oscr;

    raw_local_irq_save(flags);
    next = OSCR + delta;
    OIER |= OIER_E0;
    OSMR0 = next;
    oscr = OSCR;
    raw_local_irq_restore(flags);

    return (signed)(next - oscr) <= MIN_OSCR_DELTA ? -ETIME : 0;
    return 0;
}

static void
mv88f6290_osmr0_set_mode(enum clock_event_mode mode, struct
clock_event_device *dev)
{
    unsigned long irqflags;

    switch (mode) {
    case CLOCK_EVT_MODE_ONESHOT:
        raw_local_irq_save(irqflags);
        OIER &= ~OIER_E0;
        //OSSR = OSSR_M0;
        raw_local_irq_restore(irqflags);
        break;

    case CLOCK_EVT_MODE_UNUSED:
    case CLOCK_EVT_MODE_SHUTDOWN:
        /* initializing, released, or preparing for suspend */
        raw_local_irq_save(irqflags);
        OIER &= ~OIER_E0;
        //OSSR = OSSR_M0;
        raw_local_irq_restore(irqflags);
        break;

    case CLOCK_EVT_MODE_RESUME:
    case CLOCK_EVT_MODE_PERIODIC:
        break;
    }
}

static struct clock_event_device ckevt_mv88f6290_osmr0 = {
    .name        = "mv88f6290",
    .features        = CLOCK_EVT_FEAT_ONESHOT,
    .shift        = 32,
    .rating        = 200,
    .set_next_event    = mv88f6290_osmr0_set_next_event,
    .set_mode        = mv88f6290_osmr0_set_mode,
};


#ifdef CONFIG_IPIPE
int __ipipe_check_tickdev(const char *devname)
{
    return 1; //!strcmp(devname, ckevt_mv88f6290_osmr0.name);
}
#endif /* CONFIG_IPIPE */


/* Reprograms the timer when Xenomai stops intercepting the timer,
generally,
  * the implementation should simply call
__ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy);
  * but see Adapting to boards using CONFIG_GENERIC_TIME and
CONFIG_GENERIC_CLOCKEVENTS
  * in case the board supports CONFIG_GENERIC_TIME and
CONFIG_GENERIC_CLOCKEVENTS.
  */

void __ipipe_mach_release_timer(void)
{
        mv88f6290_osmr0_set_mode(ckevt_mv88f6290_osmr0.mode,
&ckevt_mv88f6290_osmr0);

        if (ckevt_mv88f6290_osmr0.mode == CLOCK_EVT_MODE_ONESHOT)
                mv88f6290_osmr0_set_next_event(LATCH,
&ckevt_mv88f6290_osmr0);
}
//EXPORT_SYMBOL(__ipipe_mach_release_timer);

#endif /* CONFIG_IPIPE */

========= CODE END    ==========

Sergey

--000e0cd22a0c4392ac0474c935db
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Dear Xenomai experts,<br><div><br>So far there is:<br><br></div><div></div>=
<div>- xenomai-2.4.9.1</div><div>- linux-2.6.29</div><div>- ARM architectur=
e based on (unknown for Xenomai core)<br>- It supports <span>CONFIG_GENERIC=
_TIME and CONFIG_GENERIC_CLOCKEVENTS<br>

- there is no cascaded interrupts<br></span></div><div><br></div>1) I&#39;m=
 following the steps described in README.INSTALL and HOWTO - <a href=3D"htt=
p://www.xenomai.org/index.php/I-pipe:ArmPorting" target=3D"_blank">http://w=
ww.xenomai.org/index.php/I-pipe:ArmPorting</a><br>

And since I&#39;m very new in Linux as well is in Xenomai (thank God for th=
is project) all my problems are from that I&#39;m not quite sure whether I&=
#39;m doing all steps correct or not.<br><div><div><br></div><div>For now o=
n I have done with:<br>

<br></div><div><div></div><div>- prepare kernel with adeos patch<br>- confi=
gure kernel with its original defconfig file (the original configuration is=
 verified and working fine on target board)<br>- building kernel (and here =
we are!)<br>
<br>2) I did add implementation for (even though the=C2=A0 I did not find a=
ny link to it in HOWTO, so I referred to PXA&#39;s implementation):<br>__ip=
ipe_check_tickdev (called from kernel\core.c)<br><br>And for:<br>mv88f6290_=
osmr0_set_mode<br>
mv88f6290_osmr0_set_next_event<br>ckevt_mv88f6290_osmr0<br>Even though all =
of them are required by __ipipe_mach_release_timer() I did not find in HOWT=
O how these functions should be implemented for MYCORE, so I referred to PX=
A&#39;s implementation again.<br>
<br>3) Then I did define all next things:<br><br>#define IRQ_OST0=C2=A0=C2=
=A0=C2=A0 IRQ_MV88F6290_TIMER0=C2=A0=C2=A0=C2=A0 /* OS Timer IRQ number mat=
ch */<br>#define OSCR=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 __REG(TIMER0_VAL=
)=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /* (TIMER_VIRT_BASE + 0x0014) - OS t=
imer 0 Register*/<br>
#define OSMR0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 __REG(TIMER_CTRL)=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /* (TIMER_VIRT_BASE + 0x0000) - OS timers C=
ontrol Register*/<br>#define OIER_E0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 (=
1 &lt;&lt; 0)=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /* Interrupt enable channel 0 */<br><br>=
Since, according to documentation, there is no PENDING (Status) register fo=
r the timer I did comment all the lines required these definitions.<br>
<b>QUESTION: Please tell me am I right or not and what to do if it is still=
 required?</b><br><br>//#define OSSR=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 _=
_REG(TIMER0_RELOAD) =C2=A0=C2=A0=C2=A0 /* OS Timer Status Register */<br>//=
#define OSSR_M0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 (1 &lt;&lt; 0)=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 /* Match status channel 0 */<br>
</div><br>4) Now I have a problem to define OIER value /* OS Timer Interrup=
t Enable Register */<br>According to Documentation, timer has 3 registers: =
Control, Reload and Timer Register.<br><b>QUESTION: What to do with OIER, h=
ave no idea, need some one kick me in right direction!</b><br>
<br>I&#39;m attaching the code which has been added according to HOWTO for =
the reference.<br><br>5) Any additional information (schematic or step-by-s=
tep explanation) about <b>How what I&#39;m doing now is working</b> is very=
 welcome to share.<br>
<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D CODE BEGIN =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<b=
r><br>#ifdef CONFIG_IPIPE<br>#ifdef CONFIG_NO_IDLE_HZ<br>#error &quot;dynam=
ic tick timer not yet supported with IPIPE&quot;<br>#endif /* CONFIG_NO_IDL=
E_HZ */<br><br>#define __REG(x) (*(volatile unsigned long *)x) /* =3D=3D=3D=
 I&#39;m not sure whether this implementation should be or another =3D=3D=
=3D*/<br>
<br>//# define __PREG(x)=C2=A0=C2=A0=C2=A0 io_v2p(x)<br><br>//#define OSSR=
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 __REG(TIMER0_RELOAD) =C2=A0=C2=A0=C2=
=A0 /* OS Timer Status Register */<br>#define IRQ_OST0=C2=A0=C2=A0=C2=A0 IR=
Q_MV88F6290_TIMER0=C2=A0=C2=A0=C2=A0 /* OS Timer IRQ number match */<br><br=
>//#define OSSR_M0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 (1 &lt;&lt; 0)=C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 /* Match status channel 0 */<br>
#define OSCR=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 __REG(TIMER0_VAL)=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /* (TIMER_VIRT_BASE + 0x0014) - OS timer 0 =
Register*/<br>#define OSMR0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 __REG(TIME=
R_CTRL)=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /* (TIMER_VIRT_BASE + 0x0000) =
- OS timers Control Register*/<br><br>#define OIER_E0=C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 (1 &lt;&lt; 0)=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /* Interrupt enable chan=
nel 0 */<br>
<br>=C2=A0/* OS Timer Interrupt Enable Register */<br><br>/*Hardware timer =
IRQ number */<br>int __ipipe_mach_timerint =3D IRQ_MV88F6290_TIMER0; /* =3D=
=3D=3D ??? =3D=3D=3D*/<br>EXPORT_SYMBOL(__ipipe_mach_timerint);<br><br>/*In=
itialized to 0, it became non zero when the hardware timer is handled by Xe=
nomai. */<br>
int __ipipe_mach_timerstolen =3D 0;<br>EXPORT_SYMBOL(__ipipe_mach_timerstol=
en);<br><br>/*Count of hardware timer ticks between two timer interrupts, s=
ame thing as the LATCH constant. */<br>unsigned int __ipipe_mach_ticks_per_=
jiffy =3D LATCH;=C2=A0 /* =3D=3D=3D ??? =3D=3D=3D*/<br>
EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);<br><br>static int mv88f6290_ti=
mer_initialized;<br><br>union tsc_reg {<br>#ifdef __BIG_ENDIAN<br>=C2=A0=C2=
=A0=C2=A0 struct {<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 unsigned long h=
igh;<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 unsigned long low;<br>=C2=A0=
=C2=A0=C2=A0 };<br>
#else /* __LITTLE_ENDIAN */<br>=C2=A0=C2=A0=C2=A0 struct {<br>=C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 unsigned long low;<br>=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 unsigned long high;<br>=C2=A0=C2=A0=C2=A0 };<br>#endif /* __LI=
TTLE_ENDIAN */<br>=C2=A0=C2=A0=C2=A0 unsigned long long full;<br>};<br><br>=
#ifdef CONFIG_SMP<br>static union tsc_reg tsc[NR_CPUS];<br>
<br>/* (...) */<br>#else /* !CONFIG_SMP */<br>static union tsc_reg *tsc;<br=
><br>/* (...) */<br>#endif<br>#endif<br><br>int mv88f6290_tclk;<br><br>int =
__init mv88f6290_find_tclk(void)<br>{<br>=C2=A0=C2=A0=C2=A0 u32 dev, rev;<b=
r><br>=C2=A0=C2=A0=C2=A0 mv88f6290_pcie_id(&amp;dev, &amp;rev);<br>
<br>=C2=A0=C2=A0=C2=A0 return 166666667;<br>}<br><br>static void mv88f6290_=
timer_init(void)<br>{<br>=C2=A0=C2=A0=C2=A0 mv88f6290_tclk =3D mv88f6290_fi=
nd_tclk();<br>=C2=A0=C2=A0=C2=A0 orion_time_init(IRQ_MV88F6290_BRIDGE, mv88=
f6290_tclk);<br><br>#ifdef CONFIG_IPIPE<br>
#ifndef CONFIG_SMP<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tsc =3D (union =
tsc_reg *) __ipipe_tsc_area;<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 barri=
er();<br>#endif /* CONFIG_SMP */<br><br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 mv88f6290_timer_initialized =3D 1;<br>#endif /* CONFIG_IPIPE */<br><br>=
}<br><br>struct sys_timer mv88f6290_timer =3D {<br>
=C2=A0=C2=A0=C2=A0 .init =3D mv88f6290_timer_init,<br>};<br><br>/* Acknowle=
dge the hardware timer interrupt at hardware timer level.=C2=A0 */<br>void =
__ipipe_mach_acktimer(void)<br>{<br>=C2=A0=C2=A0=C2=A0 //OSSR =3D OSSR_M0;=
=C2=A0 /* Clear match on timer 0 */<br>}<br>
<br>/* High resolution counter, or its emulation using the hardware decreme=
nter or free-running counter. */<br>notrace unsigned long long __ipipe_mach=
_get_tsc(void)<br>{<br>=C2=A0=C2=A0=C2=A0 if (likely(mv88f6290_timer_initia=
lized)) {<br>
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 union tsc_reg *local_tsc, result;<br>=
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 unsigned long stamp;<br><br>=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 local_tsc =3D &amp;tsc[ipipe_processor_id()];<=
br><br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 __asm__ (&quot;ldmia %1, %M0\n=
&quot;<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0: =
&quot;=3Dr&quot;(result.full): &quot;r&quot;(local_tsc), &quot;m&quot;(*loc=
al_tsc));<br>
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 barrier();<br>=C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 stamp =3D OSCR;<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if=
 (unlikely(stamp &lt; result.low))<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
 =C2=A0=C2=A0=C2=A0 /* 32 bit counter wrapped, increment high word. */<br>=
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 result.high++;<br>=
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 result.low =3D stamp;<br>
<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return result.full;<br>=C2=A0=C2=
=A0=C2=A0 }<br><br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;<br>=
}<br>//EXPORT_SYMBOL(__ipipe_mach_get_tsc);<br><br>#ifdef CONFIG_IPIPE<br><=
br>/* Fills a structure which will be used in user-space to emulate the tsc=
. */<br>
#ifdef CONFIG_SMP<br><br>/* (...) */<br>void __ipipe_mach_get_tscinfo(struc=
t __ipipe_tscinfo *info)<br>{<br>=C2=A0=C2=A0=C2=A0 info-&gt;type =3D IPIPE=
_TSC_TYPE_NONE;<br>}<br>#else<br>/* (...) */<br>void __ipipe_mach_get_tscin=
fo(struct __ipipe_tscinfo *info)<br>
{<br>=C2=A0=C2=A0=C2=A0 info-&gt;type =3D IPIPE_TSC_TYPE_FREERUNNING;<br>=
=C2=A0=C2=A0=C2=A0 info-&gt;u.fr.counter =3D (unsigned *) TIMER0_VAL; /* =
=3D=3D=3D ??? =3D=3D=3D*/<br>=C2=A0=C2=A0=C2=A0 info-&gt;u.fr.mask =3D 0xff=
ffffff;<br>=C2=A0=C2=A0=C2=A0 info-&gt;u.fr.tsc =3D &amp;tsc-&gt;full;<br>}=
<br><br>
/*<br>info-&gt;type indicates that the tsc is based on a free-running count=
er,<br>info-&gt;u.fr.counter is set to the PHYSICAL address of the free-run=
ning counter,<br>info-&gt;u.fr.mask is a mask indicating which bits in the =
free-running counter are valid.<br>
info-&gt;u.fr.tsc is a pointer to the shared tsc area<br>*/<br><br>#endif /=
* !CONFIG_SMP */<br><br>/* Program the hardware timer to trig an interrupt =
in &#39;delay&#39; hardware timer ticks=C2=A0 */<br>void __ipipe_mach_set_d=
ec(unsigned long delay)<br>
{<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (delay &gt; 8)=C2=A0=C2=
=A0=C2=A0 {<br><br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long flags;<br><br>=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 local_irq_save_hw(flags);<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OSMR0 =3D delay + OSCR;=
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 local_irq_restore_hw(flags);<br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>=C2=A0=C2=A0=C2=A0 else<br>=
;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ipipe_trigger_irq(IRQ_OST0);<br><br>}<br>//EXPORT_=
SYMBOL(__ipipe_mach_set_dec);<br><br>/* Returns the count of hardware timer=
 ticks remaining before the next timer interrupt. */<br>
unsigned long __ipipe_mach_get_dec(void)<br>{<br>=C2=A0=C2=A0=C2=A0 return =
OSMR0 - OSCR;<br>}<br>//EXPORT_SYMBOL(__ipipe_mach_get_dec);<br><br>static =
int<br>mv88f6290_osmr0_set_next_event(unsigned long delta, struct clock_eve=
nt_device *dev)<br>
{<br>=C2=A0=C2=A0=C2=A0 unsigned long flags, next, oscr;<br><br>=C2=A0=C2=
=A0=C2=A0 raw_local_irq_save(flags);<br>=C2=A0=C2=A0=C2=A0 next =3D OSCR + =
delta;<br>=C2=A0=C2=A0=C2=A0 OIER |=3D OIER_E0;<br>=C2=A0=C2=A0=C2=A0 OSMR0=
 =3D next;<br>=C2=A0=C2=A0=C2=A0 oscr =3D OSCR;<br>=C2=A0=C2=A0=C2=A0 raw_l=
ocal_irq_restore(flags);<br><br>=C2=A0=C2=A0=C2=A0 return (signed)(next - o=
scr) &lt;=3D MIN_OSCR_DELTA ? -ETIME : 0;<br>
=C2=A0=C2=A0=C2=A0 return 0;<br>}<br><br>static void<br>mv88f6290_osmr0_set=
_mode(enum clock_event_mode mode, struct clock_event_device *dev)<br>{<br>=
=C2=A0=C2=A0=C2=A0 unsigned long irqflags;<br><br>=C2=A0=C2=A0=C2=A0 switch=
 (mode) {<br>=C2=A0=C2=A0=C2=A0 case CLOCK_EVT_MODE_ONESHOT:<br>
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 raw_local_irq_save(irqflags);<br>=C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 OIER &amp;=3D ~OIER_E0;<br>=C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 //OSSR =3D OSSR_M0;<br>=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 raw_local_irq_restore(irqflags);<br>=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 break;<br><br>=C2=A0=C2=A0=C2=A0 case CLOCK_EVT_MODE_UNUSED:<b=
r>=C2=A0=C2=A0=C2=A0 case CLOCK_EVT_MODE_SHUTDOWN:<br>
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /* initializing, released, or prepari=
ng for suspend */<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 raw_local_irq_sa=
ve(irqflags);<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 OIER &amp;=3D ~OIER_=
E0;<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 //OSSR =3D OSSR_M0;<br>=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 raw_local_irq_restore(irqflags);<br>=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 break;<br>
<br>=C2=A0=C2=A0=C2=A0 case CLOCK_EVT_MODE_RESUME:<br>=C2=A0=C2=A0=C2=A0 ca=
se CLOCK_EVT_MODE_PERIODIC:<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 break;=
<br>=C2=A0=C2=A0=C2=A0 }<br>}<br><br>static struct clock_event_device ckevt=
_mv88f6290_osmr0 =3D {<br>=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 =3D &quot;mv88f6290&quot;,<br>=C2=A0=C2=A0=C2=A0 .features=C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =3D CLOCK_EVT_FEAT_ONESHOT,<br>
=C2=A0=C2=A0=C2=A0 .shift=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =3D 32,<br>=
=C2=A0=C2=A0=C2=A0 .rating=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =3D 200,<br=
>=C2=A0=C2=A0=C2=A0 .set_next_event=C2=A0=C2=A0=C2=A0 =3D mv88f6290_osmr0_s=
et_next_event,<br>=C2=A0=C2=A0=C2=A0 .set_mode=C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =3D mv88f6290_osmr0_set_mode,<br>};<br><br><br>#ifdef CONFIG_IPIP=
E<br>int __ipipe_check_tickdev(const char *devname)<br>
{<br>=C2=A0=C2=A0=C2=A0 return 1; //!strcmp(devname, <a href=3D"http://ckev=
t_mv88f6290_osmr0.name">ckevt_mv88f6290_osmr0.name</a>);<br>}<br>#endif /* =
CONFIG_IPIPE */<br><br><br>/* Reprograms the timer when Xenomai stops inter=
cepting the timer, generally,<br>
=C2=A0 * the implementation should simply call __ipipe_mach_set_dec(__ipipe=
_mach_ticks_per_jiffy);<br>=C2=A0 * but see Adapting to boards using CONFIG=
_GENERIC_TIME and CONFIG_GENERIC_CLOCKEVENTS<br>=C2=A0 * in case the board =
supports CONFIG_GENERIC_TIME and CONFIG_GENERIC_CLOCKEVENTS.<br>
=C2=A0 */<br><br>void __ipipe_mach_release_timer(void)<br>{<br>=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mv88f6290_osmr0_set_mode(ckevt_mv88f6290_osm=
r0.mode, &amp;ckevt_mv88f6290_osmr0);<br><br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (ckevt_mv88f6290_osmr0.mode =3D=3D CLOCK_EVT_MODE_ONESHOT)<=
br>
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 mv88f6290_osmr0_set_next_event(LATCH, &amp;ckevt_mv88f6290_=
osmr0);<br>}<br>//EXPORT_SYMBOL(__ipipe_mach_release_timer);<br><br>#endif =
/* CONFIG_IPIPE */<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D CODE END=C2=A0=C2=A0=
=C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><br>Sergey<br>
</div></div>

--000e0cd22a0c4392ac0474c935db--

