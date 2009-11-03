Message-ID: <725957.56219.qm@domain.hid>
Date: Tue, 3 Nov 2009 07:00:26 -0800 (PST)
From: Wael Showair <showair2003@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-7397329-1257260426=:56219"
Subject: [Xenomai-help] Porting I-Pipe for new ARM board
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid
Cc: didenkos@domain.hid

--0-7397329-1257260426=:56219
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi All,=0Ai have TS-7800 board based on Marvell 88F5182 processor core. Unf=
ortunately it is not supported by I-Pipe patch so according to the followin=
g link:=0A=0Ahttp://www.xenomai.org/index.php/I-pipe:ArmPorting=0A=0AAnd wi=
th aid of this forum thread:=0A=0Ahttp://www.mail-archive.com/xenomai-help@=
gna.org/msg09486.html=0A=0AI have now reached to the same error:=0Apatched =
Linux is starting to boot as original kernel=0Aand it hangs right after lin=
e=0A=0A"ata2: SATA max UDMA/133 irq 29"=0A=0Ahere is the time.c file that i=
 have edited:=0A=0A********************************************************=
****************************=0A=0A/*=0A * arch/arm/plat-orion/time.c=0A *=
=0A * Marvell Orion SoC timer handling.=0A *=0A * This file is licensed und=
er the terms of the GNU General Public=0A * License version 2.  This progra=
m is licensed "as is" without any=0A * warranty of any kind, whether expres=
s or implied.=0A *=0A * Timer 0 is used as free-running clocksource, while =
timer 1 is=0A * used as clock_event_device.=0A */=0A=0A#include <linux/kern=
el.h>=0A#include <linux/clockchips.h>=0A#include <linux/interrupt.h>=0A#inc=
lude <linux/irq.h>=0A#include <asm/mach/time.h>=0A#include <mach/hardware.h=
>=0A=0A/*=0A * Number of timer ticks per jiffy.=0A */=0Astatic u32 ticks_pe=
r_jiffy;=0A=0A/*=0A * Timer block registers.=0A */=0A#define TIMER_CTRL=09=
=09(TIMER_VIRT_BASE + 0x0000)=0A#define  TIMER0_EN=09=090x0001=0A#define  T=
IMER0_RELOAD_EN=090x0002=0A#define  TIMER1_EN=09=090x0004=0A#define  TIMER1=
_RELOAD_EN=090x0008=0A#define TIMER0_RELOAD=09=09(TIMER_VIRT_BASE + 0x0010)=
=0A#define TIMER0_VAL=09=09(TIMER_VIRT_BASE + 0x0014)=0A#define TIMER1_RELO=
AD=09=09(TIMER_VIRT_BASE + 0x0018)=0A#define TIMER1_VAL=09=09(TIMER_VIRT_BA=
SE + 0x001c)=0A=0A#ifdef CONFIG_IPIPE=0A=0A#define MIN_TIMER1_DELTA=09=091=
=0A=0A#ifdef CONFIG_NO_IDLE_HZ=0A#error "dynamic tick timer not yet support=
ed with IPIPE"=0A#endif /* CONFIG_NO_IDLE_HZ */=0A=0A/* The implementation =
is instead of io_v2p since the addresses are virtual addresses*/=0A//# defi=
ne __PREG(x)    io_v2p(x)=0A=0A/* #define __REG(x) (*(volatile unsigned lon=
g *)x) =0A#define OSCR_0        __REG(TIMER0_VAL)     =0A*/=0A=0A=0A/*=0A *=
IRQ number of hardware timer  =0A *According to the board manual, tables 59=
 & 61=0A *the timer0,1 interrupts are set in Local to System Bridge Interru=
pt Cause Register =0A *which in turn set bit number zero in the Main Interr=
upt Cause Register=0A *so the __ipipe_mach_timerint variable will be set to=
 zero or one=0A */=0A#define IRQ_MV88FXX_ORION_BRIDGE=090=0Aint __ipipe_mac=
h_timerint =3D IRQ_MV88FXX_ORION_BRIDGE;=0AEXPORT_SYMBOL(__ipipe_mach_timer=
int);=0A=0A=0A/*TODO: what is this value really represents? is it always in=
tialized by zero?=0A * Initialized to 0, it became non zero when the hardwa=
re timer is handled by=0A * Xenomai. =0A */=0Aint __ipipe_mach_timerstolen =
=3D 0;=0AEXPORT_SYMBOL(__ipipe_mach_timerstolen);=0A=0A=0A/*=0A * Count of =
hardware timer ticks between two timer interrupts, same thing as=0A * the L=
ATCH constant.=0A */=0Aunsigned int __ipipe_mach_ticks_per_jiffy =3D LATCH;=
=0AEXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);=0A=0Astatic int orion_timer=
_initialized =3D 0;=0A=0A/* this union represents the shared tsc area */=0A=
union tsc_reg {=0A#ifdef __BIG_ENDIAN=0A    struct {=0A        unsigned lon=
g high;=0A        unsigned long low;=0A    };=0A#else /* __LITTLE_ENDIAN */=
=0A    struct {=0A        unsigned long low;=0A        unsigned long high;=
=0A    };=0A#endif /* __LITTLE_ENDIAN */=0A=0A    unsigned long long full;=
=0A};=0A=0A=0A#ifdef CONFIG_SMP=0Astatic union tsc_reg orion_tsc[NR_CPUS];=
=0A=0Avoid __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)=0A{=0A   =
 info->type =3D IPIPE_TSC_TYPE_NONE;=0A}=0A=0A#else /* !CONFIG_SMP */=0Asta=
tic union tsc_reg *orion_tsc;=0A#endif /* !CONFIG_SMP */=0A=0Astatic void i=
pipe_mach_update_tsc(void);=0A=0A#endif /* CONFIG_IPIPE */=0A=0A/*=0A * Clo=
cksource handling.=0A */=0Astatic cycle_t orion_clksrc_read(void)=0A{=0A=09=
return 0xffffffff - readl(TIMER0_VAL);=0A}=0A=0Astatic struct clocksource o=
rion_clksrc =3D {=0A=09.name=09=09=3D "orion_clocksource",=0A=09.shift=09=
=09=3D 20,=0A=09.rating=09=09=3D 300,=0A=09.read=09=09=3D orion_clksrc_read=
,=0A=09.mask=09=09=3D CLOCKSOURCE_MASK(32),=0A=09.flags=09=09=3D CLOCK_SOUR=
CE_IS_CONTINUOUS,=0A};=0A=0A=0A=0A/*=0A * Clockevent handling.=0A */=0Astat=
ic int=0Aorion_clkevt_next_event(unsigned long delta, struct clock_event_de=
vice *dev)=0A{=0A=09unsigned long flags;=0A=09u32 u;=0A=0A=09if (delta =3D=
=3D 0)=0A=09=09return -ETIME;=0A=0A=09local_irq_save(flags);=0A=0A=09/*=0A=
=09 * Clear and enable clockevent timer interrupt.=0A=09 */=0A=09writel(BRI=
DGE_INT_TIMER1_CLR, BRIDGE_CAUSE);=0A=0A=09u =3D readl(BRIDGE_MASK);=0A=09u=
 |=3D BRIDGE_INT_TIMER1;=0A=09writel(u, BRIDGE_MASK);=0A=0A=09/*=0A=09 * Se=
tup new clockevent timer value.=0A=09 */=0A=09writel(delta, TIMER1_VAL);=0A=
=0A=09/*=0A=09 * Enable the timer.=0A=09 */=0A=09u =3D readl(TIMER_CTRL);=
=0A=09u =3D (u & ~TIMER1_RELOAD_EN) | TIMER1_EN;=0A=09writel(u, TIMER_CTRL)=
;=0A=0A=09local_irq_restore(flags);=0A=0A=09return 0;=0A}=0A=0Astatic void=
=0Aorion_clkevt_mode(enum clock_event_mode mode, struct clock_event_device =
*dev)=0A{=0A=09unsigned long flags;=0A=09u32 u;=0A=0A=09local_irq_save(flag=
s);=0A=09if (mode =3D=3D CLOCK_EVT_MODE_PERIODIC) {=0A=09=09/*=0A=09=09 * S=
etup timer to fire at 1/HZ intervals.=0A=09=09 */=0A=09=09writel(ticks_per_=
jiffy - 1, TIMER1_RELOAD);=0A=09=09writel(ticks_per_jiffy - 1, TIMER1_VAL);=
=0A=0A=09=09/*=0A=09=09 * Enable timer interrupt.=0A=09=09 */=0A=09=09u =3D=
 readl(BRIDGE_MASK);=0A=09=09writel(u | BRIDGE_INT_TIMER1, BRIDGE_MASK);=0A=
=0A=09=09/*=0A=09=09 * Enable timer.=0A=09=09 */=0A=09=09u =3D readl(TIMER_=
CTRL);=0A=09=09writel(u | TIMER1_EN | TIMER1_RELOAD_EN, TIMER_CTRL);=0A=09}=
 else {=0A=09=09/*=0A=09=09 * Disable timer.=0A=09=09 */=0A=09=09u =3D read=
l(TIMER_CTRL);=0A=09=09writel(u & ~TIMER1_EN, TIMER_CTRL);=0A=0A=09=09/*=0A=
=09=09 * Disable timer interrupt.=0A=09=09 */=0A=09=09u =3D readl(BRIDGE_MA=
SK);=0A=09=09writel(u & ~BRIDGE_INT_TIMER1, BRIDGE_MASK);=0A=0A=09=09/*=0A=
=09=09 * ACK pending timer interrupt.=0A=09=09 */=0A=09=09writel(BRIDGE_INT=
_TIMER1_CLR, BRIDGE_CAUSE);=0A=0A=09}=0A=09local_irq_restore(flags);=0A}=0A=
=0Astatic struct clock_event_device orion_clkevt =3D {=0A=09.name=09=09=3D =
"orion_tick",=0A=09.features=09=3D CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_=
PERIODIC,=0A=09.shift=09=09=3D 32,=0A=09.rating=09=09=3D 300,=0A=09.set_nex=
t_event=09=3D orion_clkevt_next_event,=0A=09.set_mode=09=3D orion_clkevt_mo=
de,=0A};=0A=0Astatic irqreturn_t orion_timer_interrupt(int irq, void *dev_i=
d)=0A{=0A=0A#ifndef CONFIG_IPIPE=0A=09/*=0A=09 * ACK timer interrupt and ca=
ll event handler.=0A=09 */=0A=09writel(BRIDGE_INT_TIMER1_CLR, BRIDGE_CAUSE)=
;=0A=0A#else=0A=0A=09ipipe_mach_update_tsc();=0A=0A#endif /* CONFIG_IPIPE *=
/=0A=0A=0A=0A=09/* hrtimer_interrupt is the event handle of the clock event=
 device "orion_tick", i got by cat /proc/timer_list=0A=09 * it is defined i=
n krnl_src/kernel/hrtimer.c=0A=09 * which does not use timer_tick in a whil=
e loop so the timer interrupt function is gonna be let as it is.=0A=09 */=
=0A=09orion_clkevt.event_handler(&orion_clkevt);=0A=0A=09return IRQ_HANDLED=
;=0A}=0A=0Astatic struct irqaction orion_timer_irq =3D {=0A=09.name=09=09=
=3D "orion_tick",=0A=09.flags=09=09=3D IRQF_DISABLED | IRQF_TIMER,=0A=09.ha=
ndler=09=3D orion_timer_interrupt=0A};=0A=0Avoid __init orion_time_init(uns=
igned int irq, unsigned int tclk)=0A{=0A=09u32 u;=0A=0A#ifdef CONFIG_IPIPE=
=0A#ifndef CONFIG_SMP=0A=09orion_tsc =3D (union tsc_reg *) __ipipe_tsc_area=
;=0A=09barrier();=0A#endif /* CONFIG_SMP */=0A=0A=09orion_timer_initialized=
 =3D 1;=0A#endif /* CONFIG_IPIPE */=0A=0A=0A=09ticks_per_jiffy =3D (tclk + =
HZ/2) / HZ;=0A=0A=0A=09/*=0A=09 * Setup free-running clocksource timer (int=
errupts=0A=09 * disabled.) using TIMER0=0A=09 */=0A=09writel(0xffffffff, TI=
MER0_VAL);=0A=09writel(0xffffffff, TIMER0_RELOAD);=0A=09u =3D readl(BRIDGE_=
MASK);=0A=09writel(u & ~BRIDGE_INT_TIMER0, BRIDGE_MASK);=0A=09u =3D readl(T=
IMER_CTRL);=0A=09writel(u | TIMER0_EN | TIMER0_RELOAD_EN, TIMER_CTRL);=0A=
=09orion_clksrc.mult =3D clocksource_hz2mult(tclk, orion_clksrc.shift);=0A=
=09clocksource_register(&orion_clksrc);=0A=0A=0A=09/*=0A=09 * Setup clockev=
ent timer (interrupt-driven.) using TIMER1=0A=09 */=0A=09setup_irq(irq, &or=
ion_timer_irq);=0A=09orion_clkevt.mult =3D div_sc(tclk, NSEC_PER_SEC, orion=
_clkevt.shift);=0A=09orion_clkevt.max_delta_ns =3D clockevent_delta2ns(0xff=
fffffe, &orion_clkevt);=0A=09orion_clkevt.min_delta_ns =3D clockevent_delta=
2ns(MIN_TIMER1_DELTA, &orion_clkevt);=0A=09orion_clkevt.cpumask =3D cpumask=
_of(0);=0A=09clockevents_register_device(&orion_clkevt);=0A}=0A=0A=0A=0A#if=
def CONFIG_IPIPE=0A=0A/*=0A * Acknowledge the hardware timer interrupt at h=
ardware timer level.  =0A */=0Avoid __ipipe_mach_acktimer(void)=0A{=0A=09/*=
=0A=09 * ACK timer interrupt and call event handler.=0A=09 */=0A=09writel(B=
RIDGE_INT_TIMER1_CLR, BRIDGE_CAUSE);=0A=0A}=0A=0A=0A/* =0A * __ipipe_mach_g=
et_tsc=0A * High resolution counter, or its emulation using the hardware de=
crementer or free-running counter =0A */=0Anotrace unsigned long long __ipi=
pe_mach_get_tsc(void)=0A{=0A    if (likely(orion_timer_initialized)) {=0A  =
      union tsc_reg *local_tsc, result;=0A        unsigned long stamp;=0A=
=0A        local_tsc =3D orion_tsc;=0A        __asm__ ("ldmia %1, %M0\n":=
=0A             "=3Dr"(result.full): "r"(local_tsc), "m"(*local_tsc));=0A  =
      barrier();=0A        stamp =3D readl(TIMER0_VAL);=0A=0A=0A        if =
(unlikely(stamp < result.low))=0A            /* 32 bit counter wrapped, inc=
rement high word. */=0A            result.high++;=0A        result.low =3D =
stamp;=0A=0A        return result.full;=0A    }=0A=0A        return 0;=0A}=
=0AEXPORT_SYMBOL(__ipipe_mach_get_tsc);=0A=0A=0A/* =0A * __ipipe_mach_get_t=
scinfo=0A * export the tsc to user-space=0A */=0A=0Avoid __ipipe_mach_get_t=
scinfo(struct __ipipe_tscinfo *info)=0A{=0A=09/* info->type indicates that =
the tsc is based on a free-running counter */=0A=09info->type =3D IPIPE_TSC=
_TYPE_FREERUNNING;=0A=0A=09/* info->u.fr.counter is set to the PHYSICAL add=
ress of the free-running counter =0A           since we are using the free-=
running counter (i.e. TIMER0) for TSC emulation */=0A=09info->u.fr.counter =
=3D (unsigned *) TIMER0_VAL;=0A=0A=09/* info->u.fr.mask is a mask indicatin=
g which bits in the free-running counter are valid */=0A=09info->u.fr.mask =
=3D 0xffffffff;=0A=0A=09/* info->u.fr.tsc is a pointer to the shared tsc ar=
ea */=0A=09info->u.fr.tsc =3D &orion_tsc->full;=0A}=0AEXPORT_SYMBOL(__ipipe=
_mach_get_tscinfo);=0A=0A=0A/* __ipipe_mach_get_dec=0A * Returns the count =
of hardware timer ticks remaining before the next timer interrupt. =0A */=
=0Aunsigned long __ipipe_mach_get_dec(void)=0A{=0A    /* return OSMR0 - OSC=
R; */=0A    /* since we are using clockevent timer(i.e. TIMER1) for hardwar=
e timer */=0A    return (readl(TIMER1_RELOAD) - readl(TIMER1_VAL));=0A=0A}=
=0AEXPORT_SYMBOL(__ipipe_mach_get_dec);=0A=0A/*=0A * __ipipe_mach_set_dec=
=0A * Program the hardware timer to trig an interrupt in 'delay' hardware t=
imer ticks.=0A */=0Avoid __ipipe_mach_set_dec(unsigned long delay)=0A{=0A  =
  u32 u;=0A=0A    /* check if the required delay is greater than the min th=
reshold ticks (delta) of TIMER1 */=0A    if (delay > MIN_TIMER1_DELTA) {=0A=
        unsigned long flags;=0A=0A        local_irq_save(flags);=0A=0A=09/*=
 load the relaod register of TIMER1 with the ner value */=0A        writel(=
delay + readl(TIMER1_VAL), TIMER1_RELOAD);=0A=0A=0A        /*=0A         * =
Clear and enable clockevent timer interrupt.=0A         */=0A        writel=
(BRIDGE_INT_TIMER1_CLR, BRIDGE_CAUSE);=0A=0A        u =3D readl(BRIDGE_MASK=
);=0A        u |=3D BRIDGE_INT_TIMER1;=0A        writel(u, BRIDGE_MASK);=0A=
=0A=0A        local_irq_restore(flags);=0A    } else=0A=09/* generate the i=
nterrupt now */=0A        ipipe_trigger_irq(IRQ_MV88FXX_ORION_BRIDGE);=0A=
=0A}=0AEXPORT_SYMBOL(__ipipe_mach_set_dec);=0A=0A=0A/*=0A * __ipipe_mach_re=
lease_timer=0A */=0Avoid __ipipe_mach_release_timer(void)=0A{=0A        ori=
on_clkevt_mode(orion_clkevt.mode, &orion_clkevt);=0A        if (orion_clkev=
t.mode =3D=3D CLOCK_EVT_MODE_ONESHOT)=0A                orion_clkevt_next_e=
vent(LATCH, &orion_clkevt);=0A}=0A=0Aint __ipipe_check_tickdev(const char *=
devname)=0A{=0A    return !strcmp(devname, orion_clkevt.name);=0A}=0A=0A=0A=
/*=0A * ipipe_mach_update_tsc=0A * If the free-running counter wraps fast, =
the best place to do this is __ipipe_mach_acktimer. =0A * If the free-runni=
ng counter wraps slowly, doing this from Linux timer interrupt will reduce =
the timer interrupt latency. =0A * Assume the implementation wraps slowly=
=0A */=0Astatic void ipipe_mach_update_tsc(void)=0A{=0A=09union tsc_reg *lo=
cal_tsc;=0A=09unsigned long stamp, flags;=0A=0A=09local_irq_save_hw(flags);=
=0A=09local_tsc =3D &orion_tsc[ipipe_processor_id()];=0A=09/*local_tsc =3D =
orion_tsc;*/=0A=0A=0A=09/* since we are using the free-running counter (i.e=
. TIMER0) for TSC emulation */=0A=09stamp =3D readl(TIMER0_VAL);=0A=0A=09if=
 (unlikely(stamp < local_tsc->low))=0A=09=09/* 32 bit counter wrapped, incr=
ement high word. */=0A=09=09local_tsc->high++;=0A=09local_tsc->low =3D stam=
p;=0A=09local_irq_restore_hw(flags);=0A}=0A=0A#endif /* CONFIG_IPIPE */=0A=
=0A************************************************************************=
************=0A=0A=0A=0AAnd here is the kernel booting output:=0A=0A#######=
###########################################################################=
##=0AUncompressing Linux...................................................=
......................................................................... d=
one, bootin.=0ALinux version 2.6.29.5-xenomai (root@domain.hid) (gcc version=
 4.3.2 (Debian 4.3.2-1.1) ) #14 PREEMPT Tue Nov 3 16:11:38 EST 2009=0ACPU: =
Feroceon [41069260] revision 0 (ARMv5TEJ), cr=3Db0053177=0ACPU: VIVT data c=
ache, VIVT instruction cache=0AMachine: Technologic Systems TS-78xx SBC=0AM=
emory policy: ECC disabled, Data cache writeback=0ABuilt 1 zonelists in Zon=
e order, mobility grouping on.  Total pages: 32512=0AKernel command line: r=
oot=3D/dev/nfs rw nfsroot=3D172.25.25.100:/home/wael/LTE/exports/emdebian-r=
ootfs ip=3Ddhcp console=3DttyS0,115200=0APID hash table entries: 512 (order=
: 9, 2048 bytes)=0AI-pipe 1.13-03: pipeline enabled.=0ADentry cache hash ta=
ble entries: 16384 (order: 4, 65536 bytes)=0AInode-cache hash table entries=
: 8192 (order: 3, 32768 bytes)=0AMemory: 128MB =3D 128MB total=0AMemory: 12=
1472KB available (3584K code, 452K data, 148K init)=0ASLUB: Genslabs=3D12, =
HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1, Nodes=3D1=0ACalibratin=
g delay loop... 331.77 BogoMIPS (lpj=3D1658880)=0AMount-cache hash table en=
tries: 512=0ACPU: Testing write buffer coherency: ok=0Anet_namespace: 520 b=
ytes=0ANET: Registered protocol family 16=0AOrion ID: MV88F5182-A2. TCLK=3D=
166666667.=0ATS-78xx Info: FPGA rev=3D05, Board Magic=3D00b480, JP1=3D1, JP=
2=3D1=0ATS-78xx RTC not detected or enabled=0Abio: create slab <bio-0> at 0=
=0ASCSI subsystem initialized=0Ausbcore: registered new interface driver us=
bfs=0Ausbcore: registered new interface driver hub=0Ausbcore: registered ne=
w device driver usb=0ANET: Registered protocol family 2=0AIP route cache ha=
sh table entries: 1024 (order: 0, 4096 bytes)=0ATCP established hash table =
entries: 4096 (order: 3, 32768 bytes)=0ATCP bind hash table entries: 4096 (=
order: 2, 16384 bytes)=0ATCP: Hash tables configured (established 4096 bind=
 4096)=0ATCP reno registered=0ANET: Registered protocol family 1=0Achecking=
 if image is initramfs...it isn't (bad gzip magic numbers); looks like an i=
nitrd=0AFreeing initrd memory: 4096K=0ANetWinder Floating Point Emulator V0=
.97 (double precision)=0AI-pipe: Domain Xenomai registered.=0AXenomai: hal/=
arm started.=0AXenomai: real-time nucleus v2.4.9.1 (Big Bad Moon) loaded.=
=0AXenomai: starting POSIX services.=0AXenomai: starting RTDM services.=0AJ=
FFS2 version 2.2. (NAND) =EF=BF=BD=C2=A9 2001-2006 Red Hat, Inc.=0Amsgmni h=
as been set to 245=0Aio scheduler noop registered=0Aio scheduler anticipato=
ry registered=0Aio scheduler deadline registered=0Aio scheduler cfq registe=
red (default)=0ASerial: 8250/16550 driver, 2 ports, IRQ sharing disabled=0A=
serial8250.0: ttyS0 at MMIO 0xf1012000 (irq =3D 3) is a 16550A=0Aconsole [t=
tyS0] enabled=0Aserial8250.1: ttyS1 at MMIO 0xf1012100 (irq =3D 4) is a 165=
50A=0Abrd: module loaded=0Aloop: module loaded=0AMV-643xx 10/100/1000 ether=
net driver version 1.4=0Amv643xx_eth smi: probed=0Aeth0 (mv643xx_eth_port):=
 not using net_device_ops yet=0Anet eth0: port 0 with MAC address 00:d0:69:=
41:cc:43=0ADriver 'sd' needs updating - please use bus_type methods=0Asata_=
mv sata_mv.0: version 1.25=0Asata_mv sata_mv.0: slots 32 ports 2=0Ascsi0 : =
sata_mv=0Ascsi1 : sata_mv=0Aata1: SATA max UDMA/133 irq 29=0Aata2: SATA max=
 UDMA/133 irq 29=0A=0A#####################################################=
###############################=0A=0AI cant guess what is my error?=0AIs th=
ere any hint to solve this problem?=0A=0Athanks,=0AWael=0A=0A=0A      
--0-7397329-1257260426=:56219
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:verdana,helvetica,sans-serif;font-size:1=
2pt"><div>Hi All,<br>i have TS-7800 board based on Marvell 88F5182 processo=
r core. Unfortunately it is not supported by I-Pipe patch so according to t=
he following link:<br><pre><a rel=3D"nofollow" href=3D"http://www.xenomai.o=
rg/index.php/I-pipe:ArmPorting">http://www.xenomai.org/index.php/I-pipe:Arm=
Porting</a><br><br>And with aid of this forum thread:<br><br><span><a targe=
t=3D"_blank" href=3D"http://www.mail-archive.com/xenomai@xenomai.org=
486.html">http://www.mail-archive.com/xenomai@xenomai.org</a=
></span><br><br>I have now reached to the same error:<br>patched Linux is s=
tarting to boot as original kernel<br>and it hangs right after line<br><br>=
"ata2: SATA max UDMA/133 irq 29"<br><br>here is the time.c file that i have
 edited:<br><br>***********************************************************=
*************************<br><br>/*<br> * arch/arm/plat-orion/time.c<br> *<=
br> * Marvell Orion SoC timer handling.<br> *<br> * This file is licensed u=
nder the terms of the GNU General Public<br> * License version 2.  This pro=
gram is licensed "as is" without any<br> * warranty of any kind, whether ex=
press or implied.<br> *<br> * Timer 0 is used as free-running clocksource, =
while timer 1 is<br> * used as clock_event_device.<br> */<br><br>#include &=
lt;linux/kernel.h&gt;<br>#include &lt;linux/clockchips.h&gt;<br>#include &l=
t;linux/interrupt.h&gt;<br>#include &lt;linux/irq.h&gt;<br>#include &lt;asm=
/mach/time.h&gt;<br>#include &lt;mach/hardware.h&gt;<br><br>/*<br> * Number=
 of timer ticks per jiffy.<br> */<br>static u32 ticks_per_jiffy;<br><br>/*<=
br> * Timer block registers.<br> */<br>#define TIMER_CTRL=09=09(TIMER_VIRT_=
BASE + 0x0000)<br>#define  TIMER0_EN=09=090x0001<br>#define=20
 TIMER0_RELOAD_EN=090x0002<br>#define  TIMER1_EN=09=090x0004<br>#define  TI=
MER1_RELOAD_EN=090x0008<br>#define TIMER0_RELOAD=09=09(TIMER_VIRT_BASE + 0x=
0010)<br>#define TIMER0_VAL=09=09(TIMER_VIRT_BASE + 0x0014)<br>#define TIME=
R1_RELOAD=09=09(TIMER_VIRT_BASE + 0x0018)<br>#define TIMER1_VAL=09=09(TIMER=
_VIRT_BASE + 0x001c)<br><br>#ifdef CONFIG_IPIPE<br><br>#define MIN_TIMER1_D=
ELTA=09=091<br><br>#ifdef CONFIG_NO_IDLE_HZ<br>#error "dynamic tick timer n=
ot yet supported with IPIPE"<br>#endif /* CONFIG_NO_IDLE_HZ */<br><br>/* Th=
e implementation is instead of io_v2p since the addresses are virtual addre=
sses*/<br>//# define __PREG(x)    io_v2p(x)<br><br>/* #define __REG(x) (*(v=
olatile unsigned long *)x) <br>#define OSCR_0        __REG(TIMER0_VAL)     =
<br>*/<br><br><br>/*<br> *IRQ number of hardware timer  <br> *According to =
the board manual, tables 59 &amp; 61<br> *the timer0,1 interrupts are set i=
n Local to System Bridge Interrupt Cause Register <br> *which in turn set b=
it number zero in the
 Main Interrupt Cause Register<br> *so the __ipipe_mach_timerint variable w=
ill be set to zero or one<br> */<br>#define IRQ_MV88FXX_ORION_BRIDGE=090<br=
>int __ipipe_mach_timerint =3D IRQ_MV88FXX_ORION_BRIDGE;<br>EXPORT_SYMBOL(_=
_ipipe_mach_timerint);<br><br><br>/*TODO: what is this value really represe=
nts? is it always intialized by zero?<br> * Initialized to 0, it became non=
 zero when the hardware timer is handled by<br> * Xenomai. <br> */<br>int _=
_ipipe_mach_timerstolen =3D 0;<br>EXPORT_SYMBOL(__ipipe_mach_timerstolen);<=
br><br><br>/*<br> * Count of hardware timer ticks between two timer interru=
pts, same thing as<br> * the LATCH constant.<br> */<br>unsigned int __ipipe=
_mach_ticks_per_jiffy =3D LATCH;<br>EXPORT_SYMBOL(__ipipe_mach_ticks_per_ji=
ffy);<br><br>static int orion_timer_initialized =3D 0;<br><br>/* this union=
 represents the shared tsc area */<br>union tsc_reg {<br>#ifdef __BIG_ENDIA=
N<br>    struct {<br>        unsigned long high;<br>        unsigned long
 low;<br>    };<br>#else /* __LITTLE_ENDIAN */<br>    struct {<br>        u=
nsigned long low;<br>        unsigned long high;<br>    };<br>#endif /* __L=
ITTLE_ENDIAN */<br>    <br>    unsigned long long full;<br>};<br><br><br>#i=
fdef CONFIG_SMP<br>static union tsc_reg orion_tsc[NR_CPUS];<br><br>void __i=
pipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)<br>{<br>    info-&gt;ty=
pe =3D IPIPE_TSC_TYPE_NONE;<br>}<br><br>#else /* !CONFIG_SMP */<br>static u=
nion tsc_reg *orion_tsc;<br>#endif /* !CONFIG_SMP */<br><br>static void ipi=
pe_mach_update_tsc(void);<br><br>#endif /* CONFIG_IPIPE */<br><br>/*<br> * =
Clocksource handling.<br> */<br>static cycle_t orion_clksrc_read(void)<br>{=
<br>=09return 0xffffffff - readl(TIMER0_VAL);<br>}<br><br>static struct clo=
cksource orion_clksrc =3D {<br>=09.name=09=09=3D "orion_clocksource",<br>=
=09.shift=09=09=3D 20,<br>=09.rating=09=09=3D 300,<br>=09.read=09=09=3D ori=
on_clksrc_read,<br>=09.mask=09=09=3D CLOCKSOURCE_MASK(32),<br>=09.flags=09=
=09=3D
 CLOCK_SOURCE_IS_CONTINUOUS,<br>};<br><br><br><br>/*<br> * Clockevent handl=
ing.<br> */<br>static int<br>orion_clkevt_next_event(unsigned long delta, s=
truct clock_event_device *dev)<br>{<br>=09unsigned long flags;<br>=09u32 u;=
<br><br>=09if (delta =3D=3D 0)<br>=09=09return -ETIME;<br><br>=09local_irq_=
save(flags);<br><br>=09/*<br>=09 * Clear and enable clockevent timer interr=
upt.<br>=09 */<br>=09writel(BRIDGE_INT_TIMER1_CLR, BRIDGE_CAUSE);<br><br>=
=09u =3D readl(BRIDGE_MASK);<br>=09u |=3D BRIDGE_INT_TIMER1;<br>=09writel(u=
, BRIDGE_MASK);<br><br>=09/*<br>=09 * Setup new clockevent timer value.<br>=
=09 */<br>=09writel(delta, TIMER1_VAL);<br><br>=09/*<br>=09 * Enable the ti=
mer.<br>=09 */<br>=09u =3D readl(TIMER_CTRL);<br>=09u =3D (u &amp; ~TIMER1_=
RELOAD_EN) | TIMER1_EN;<br>=09writel(u, TIMER_CTRL);<br><br>=09local_irq_re=
store(flags);<br><br>=09return 0;<br>}<br><br>static void<br>orion_clkevt_m=
ode(enum clock_event_mode mode, struct clock_event_device *dev)<br>{<br>=09=
unsigned long flags;<br>=09u32 u;<br><br>
=09local_irq_save(flags);<br>=09if (mode =3D=3D CLOCK_EVT_MODE_PERIODIC) {<=
br>=09=09/*<br>=09=09 * Setup timer to fire at 1/HZ intervals.<br>=09=09 */=
<br>=09=09writel(ticks_per_jiffy - 1, TIMER1_RELOAD);<br>=09=09writel(ticks=
_per_jiffy - 1, TIMER1_VAL);<br><br>=09=09/*<br>=09=09 * Enable timer inter=
rupt.<br>=09=09 */<br>=09=09u =3D readl(BRIDGE_MASK);<br>=09=09writel(u | B=
RIDGE_INT_TIMER1, BRIDGE_MASK);<br><br>=09=09/*<br>=09=09 * Enable timer.<b=
r>=09=09 */<br>=09=09u =3D readl(TIMER_CTRL);<br>=09=09writel(u | TIMER1_EN=
 | TIMER1_RELOAD_EN, TIMER_CTRL);<br>=09} else {<br>=09=09/*<br>=09=09 * Di=
sable timer.<br>=09=09 */<br>=09=09u =3D readl(TIMER_CTRL);<br>=09=09writel=
(u &amp; ~TIMER1_EN, TIMER_CTRL);<br><br>=09=09/*<br>=09=09 * Disable timer=
 interrupt.<br>=09=09 */<br>=09=09u =3D readl(BRIDGE_MASK);<br>=09=09writel=
(u &amp; ~BRIDGE_INT_TIMER1, BRIDGE_MASK);<br><br>=09=09/*<br>=09=09 * ACK =
pending timer interrupt.<br>=09=09 */<br>=09=09writel(BRIDGE_INT_TIMER1_CLR=
, BRIDGE_CAUSE);<br><br>=09}<br>=09local_irq_restore(flags);<br>}<br><br>st=
atic struct clock_event_device orion_clkevt =3D {<br>
=09.name=09=09=3D "orion_tick",<br>=09.features=09=3D CLOCK_EVT_FEAT_ONESHO=
T | CLOCK_EVT_FEAT_PERIODIC,<br>=09.shift=09=09=3D 32,<br>=09.rating=09=09=
=3D 300,<br>=09.set_next_event=09=3D orion_clkevt_next_event,<br>=09.set_mo=
de=09=3D orion_clkevt_mode,<br>};<br><br>static irqreturn_t orion_timer_int=
errupt(int irq, void *dev_id)<br>{<br><br>#ifndef CONFIG_IPIPE<br>=09/*<br>=
=09 * ACK timer interrupt and call event handler.<br>=09 */<br>=09writel(BR=
IDGE_INT_TIMER1_CLR, BRIDGE_CAUSE);<br><br>#else<br><br>=09ipipe_mach_updat=
e_tsc();<br><br>#endif /* CONFIG_IPIPE */<br><br><br><br>=09/* hrtimer_inte=
rrupt is the event handle of the clock event device "orion_tick", i got by =
cat /proc/timer_list<br>=09 * it is defined in krnl_src/kernel/hrtimer.c<br=
>=09 * which does not use timer_tick in a while loop so the timer interrupt=
 function is gonna be let as it is.<br>=09 */<br>=09orion_clkevt.event_hand=
ler(&amp;orion_clkevt);<br><br>=09return IRQ_HANDLED;<br>}<br><br>static st=
ruct irqaction orion_timer_irq =3D {<br>=09.name=09=09=3D
 "orion_tick",<br>=09.flags=09=09=3D IRQF_DISABLED | IRQF_TIMER,<br>=09.han=
dler=09=3D orion_timer_interrupt<br>};<br><br>void __init orion_time_init(u=
nsigned int irq, unsigned int tclk)<br>{<br>=09u32 u;<br><br>#ifdef CONFIG_=
IPIPE<br>#ifndef CONFIG_SMP<br>=09orion_tsc =3D (union tsc_reg *) __ipipe_t=
sc_area;<br>=09barrier();<br>#endif /* CONFIG_SMP */<br><br>=09orion_timer_=
initialized =3D 1;<br>#endif /* CONFIG_IPIPE */<br><br><br>=09ticks_per_jif=
fy =3D (tclk + HZ/2) / HZ;<br><br><br>=09/*<br>=09 * Setup free-running clo=
cksource timer (interrupts<br>=09 * disabled.) using TIMER0<br>=09 */<br>=
=09writel(0xffffffff, TIMER0_VAL);<br>=09writel(0xffffffff, TIMER0_RELOAD);=
<br>=09u =3D readl(BRIDGE_MASK);<br>=09writel(u &amp; ~BRIDGE_INT_TIMER0, B=
RIDGE_MASK);<br>=09u =3D readl(TIMER_CTRL);<br>=09writel(u | TIMER0_EN | TI=
MER0_RELOAD_EN, TIMER_CTRL);<br>=09orion_clksrc.mult =3D clocksource_hz2mul=
t(tclk, orion_clksrc.shift);<br>=09clocksource_register(&amp;orion_clksrc);=
<br><br><br>=09/*<br>=09 * Setup clockevent timer
 (interrupt-driven.) using TIMER1<br>=09 */<br>=09setup_irq(irq, &amp;orion=
_timer_irq);<br>=09orion_clkevt.mult =3D div_sc(tclk, NSEC_PER_SEC, orion_c=
lkevt.shift);<br>=09orion_clkevt.max_delta_ns =3D clockevent_delta2ns(0xfff=
ffffe, &amp;orion_clkevt);<br>=09orion_clkevt.min_delta_ns =3D clockevent_d=
elta2ns(MIN_TIMER1_DELTA, &amp;orion_clkevt);<br>=09orion_clkevt.cpumask =
=3D cpumask_of(0);<br>=09clockevents_register_device(&amp;orion_clkevt);<br=
>}<br><br><br><br>#ifdef CONFIG_IPIPE<br><br>/*<br> * Acknowledge the hardw=
are timer interrupt at hardware timer level.  <br> */<br>void __ipipe_mach_=
acktimer(void)<br>{<br>=09/*<br>=09 * ACK timer interrupt and call event ha=
ndler.<br>=09 */<br>=09writel(BRIDGE_INT_TIMER1_CLR, BRIDGE_CAUSE);<br><br>=
}<br><br><br>/* <br> * __ipipe_mach_get_tsc<br> * High resolution counter, =
or its emulation using the hardware decrementer or free-running counter <br=
> */<br>notrace unsigned long long __ipipe_mach_get_tsc(void)<br>{<br>    i=
f
 (likely(orion_timer_initialized)) {<br>        union tsc_reg *local_tsc, r=
esult;<br>        unsigned long stamp;<br><br>        local_tsc =3D orion_t=
sc;<br>        __asm__ ("ldmia %1, %M0\n":<br>             "=3Dr"(result.fu=
ll): "r"(local_tsc), "m"(*local_tsc));<br>        barrier();<br>        sta=
mp =3D readl(TIMER0_VAL);<br>       <br><br>        if (unlikely(stamp &lt;=
 result.low))<br>            /* 32 bit counter wrapped, increment high word=
. */<br>            result.high++;<br>        result.low =3D stamp;<br><br>=
        return result.full;<br>    }<br><br>        return 0;<br>}<br>EXPOR=
T_SYMBOL(__ipipe_mach_get_tsc);<br><br><br>/* <br> * __ipipe_mach_get_tscin=
fo<br> * export the tsc to user-space<br> */<br><br>void __ipipe_mach_get_t=
scinfo(struct __ipipe_tscinfo *info)<br>{<br>=09/* info-&gt;type indicates =
that the tsc is based on a free-running counter */<br>=09info-&gt;type =3D =
IPIPE_TSC_TYPE_FREERUNNING;<br><br>=09/* info-&gt;u.fr.counter is set to th=
e
 PHYSICAL address of the free-running counter <br>           since we are u=
sing the free-running counter (i.e. TIMER0) for TSC emulation */<br>=09info=
-&gt;u.fr.counter =3D (unsigned *) TIMER0_VAL;<br><br>=09/* info-&gt;u.fr.m=
ask is a mask indicating which bits in the free-running counter are valid *=
/<br>=09info-&gt;u.fr.mask =3D 0xffffffff;<br><br>=09/* info-&gt;u.fr.tsc i=
s a pointer to the shared tsc area */<br>=09info-&gt;u.fr.tsc =3D &amp;orio=
n_tsc-&gt;full;<br>}<br>EXPORT_SYMBOL(__ipipe_mach_get_tscinfo);<br><br><br=
>/* __ipipe_mach_get_dec<br> * Returns the count of hardware timer ticks re=
maining before the next timer interrupt. <br> */<br>unsigned long __ipipe_m=
ach_get_dec(void)<br>{<br>    /* return OSMR0 - OSCR; */<br>    /* since we=
 are using clockevent timer(i.e. TIMER1) for hardware timer */<br>    retur=
n (readl(TIMER1_RELOAD) - readl(TIMER1_VAL));<br><br>}<br>EXPORT_SYMBOL(__i=
pipe_mach_get_dec);<br><br>/*<br> * __ipipe_mach_set_dec<br> * Program the =
hardware
 timer to trig an interrupt in 'delay' hardware timer ticks.<br> */<br>void=
 __ipipe_mach_set_dec(unsigned long delay)<br>{<br>    u32 u;<br><br>    /*=
 check if the required delay is greater than the min threshold ticks (delta=
) of TIMER1 */<br>    if (delay &gt; MIN_TIMER1_DELTA) {<br>        unsigne=
d long flags;<br><br>        local_irq_save(flags);<br>=09<br>=09/* load th=
e relaod register of TIMER1 with the ner value */<br>        writel(delay +=
 readl(TIMER1_VAL), TIMER1_RELOAD);<br><br><br>        /*<br>         * Cle=
ar and enable clockevent timer interrupt.<br>         */<br>        writel(=
BRIDGE_INT_TIMER1_CLR, BRIDGE_CAUSE);<br><br>        u =3D readl(BRIDGE_MAS=
K);<br>        u |=3D BRIDGE_INT_TIMER1;<br>        writel(u, BRIDGE_MASK);=
<br><br><br>        local_irq_restore(flags);<br>    } else<br>=09/* genera=
te the interrupt now */<br>        ipipe_trigger_irq(IRQ_MV88FXX_ORION_BRID=
GE);<br><br>}<br>EXPORT_SYMBOL(__ipipe_mach_set_dec);<br><br><br>/*<br> *
 __ipipe_mach_release_timer<br> */<br>void __ipipe_mach_release_timer(void)=
<br>{<br>        orion_clkevt_mode(orion_clkevt.mode, &amp;orion_clkevt);<b=
r>        if (orion_clkevt.mode =3D=3D CLOCK_EVT_MODE_ONESHOT)<br>         =
       orion_clkevt_next_event(LATCH, &amp;orion_clkevt);<br>}<br><br>int _=
_ipipe_check_tickdev(const char *devname)<br>{<br>    return !strcmp(devnam=
e, orion_clkevt.name);<br>}<br><br><br>/*<br> * ipipe_mach_update_tsc<br> *=
 If the free-running counter wraps fast, the best place to do this is __ipi=
pe_mach_acktimer. <br> * If the free-running counter wraps slowly, doing th=
is from Linux timer interrupt will reduce the timer interrupt latency. <br>=
 * Assume the implementation wraps slowly<br> */<br>static void ipipe_mach_=
update_tsc(void)<br>{<br>=09union tsc_reg *local_tsc;<br>=09unsigned long s=
tamp, flags;<br><br>=09local_irq_save_hw(flags);<br>=09local_tsc =3D &amp;o=
rion_tsc[ipipe_processor_id()];<br>=09/*local_tsc =3D orion_tsc;*/<br><br><=
br>=09/*
 since we are using the free-running counter (i.e. TIMER0) for TSC emulatio=
n */<br>=09stamp =3D readl(TIMER0_VAL);<br><br>=09if (unlikely(stamp &lt; l=
ocal_tsc-&gt;low))<br>=09=09/* 32 bit counter wrapped, increment high word.=
 */<br>=09=09local_tsc-&gt;high++;<br>=09local_tsc-&gt;low =3D stamp;<br>=
=09local_irq_restore_hw(flags);<br>}<br><br>#endif /* CONFIG_IPIPE */<br><b=
r>*************************************************************************=
***********<br><br><br><br>And here is the kernel booting output:<br><br>##=
###########################################################################=
#######<br>Uncompressing Linux.............................................=
...........................................................................=
.... done, bootin.<br>Linux version 2.6.29.5-xenomai (root@domain.hid) (gcc =
version 4.3.2 (Debian 4.3.2-1.1) ) #14 PREEMPT Tue Nov 3 16:11:38 EST 2009<=
br>CPU: Feroceon [41069260] revision 0 (ARMv5TEJ), cr=3Db0053177<br>CPU: VI=
VT data cache,
 VIVT instruction cache<br>Machine: Technologic Systems TS-78xx SBC<br>Memo=
ry policy: ECC disabled, Data cache writeback<br>Built 1 zonelists in Zone =
order, mobility grouping on.  Total pages: 32512<br>Kernel command line: ro=
ot=3D/dev/nfs rw nfsroot=3D172.25.25.100:/home/wael/LTE/exports/emdebian-ro=
otfs ip=3Ddhcp console=3DttyS0,115200<br>PID hash table entries: 512 (order=
: 9, 2048 bytes)<br>I-pipe 1.13-03: pipeline enabled.<br>Dentry cache hash =
table entries: 16384 (order: 4, 65536 bytes)<br>Inode-cache hash table entr=
ies: 8192 (order: 3, 32768 bytes)<br>Memory: 128MB =3D 128MB total<br>Memor=
y: 121472KB available (3584K code, 452K data, 148K init)<br>SLUB: Genslabs=
=3D12, HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1, Nodes=3D1<br>Ca=
librating delay loop... 331.77 BogoMIPS (lpj=3D1658880)<br>Mount-cache hash=
 table entries: 512<br>CPU: Testing write buffer coherency: ok<br>net_names=
pace: 520 bytes<br>NET: Registered protocol family 16<br>Orion ID: MV88F518=
2-A2.
 TCLK=3D166666667.<br>TS-78xx Info: FPGA rev=3D05, Board Magic=3D00b480, JP=
1=3D1, JP2=3D1<br>TS-78xx RTC not detected or enabled<br>bio: create slab &=
lt;bio-0&gt; at 0<br>SCSI subsystem initialized<br>usbcore: registered new =
interface driver usbfs<br>usbcore: registered new interface driver hub<br>u=
sbcore: registered new device driver usb<br>NET: Registered protocol family=
 2<br>IP route cache hash table entries: 1024 (order: 0, 4096 bytes)<br>TCP=
 established hash table entries: 4096 (order: 3, 32768 bytes)<br>TCP bind h=
ash table entries: 4096 (order: 2, 16384 bytes)<br>TCP: Hash tables configu=
red (established 4096 bind 4096)<br>TCP reno registered<br>NET: Registered =
protocol family 1<br>checking if image is initramfs...it isn't (bad gzip ma=
gic numbers); looks like an initrd<br>Freeing initrd memory: 4096K<br>NetWi=
nder Floating Point Emulator V0.97 (double precision)<br>I-pipe: Domain Xen=
omai registered.<br>Xenomai: hal/arm started.<br>Xenomai: real-time nucleus
 v2.4.9.1 (Big Bad Moon) loaded.<br>Xenomai: starting POSIX services.<br>Xe=
nomai: starting RTDM services.<br>JFFS2 version 2.2. (NAND) =EF=BF=BD=C2=A9=
 2001-2006 Red Hat, Inc.<br>msgmni has been set to 245<br>io scheduler noop=
 registered<br>io scheduler anticipatory registered<br>io scheduler deadlin=
e registered<br>io scheduler cfq registered (default)<br>Serial: 8250/16550=
 driver, 2 ports, IRQ sharing disabled<br>serial8250.0: ttyS0 at MMIO 0xf10=
12000 (irq =3D 3) is a 16550A<br>console [ttyS0] enabled<br>serial8250.1: t=
tyS1 at MMIO 0xf1012100 (irq =3D 4) is a 16550A<br>brd: module loaded<br>lo=
op: module loaded<br>MV-643xx 10/100/1000 ethernet driver version 1.4<br>mv=
643xx_eth smi: probed<br>eth0 (mv643xx_eth_port): not using net_device_ops =
yet<br>net eth0: port 0 with MAC address 00:d0:69:41:cc:43<br>Driver 'sd' n=
eeds updating - please use bus_type methods<br>sata_mv sata_mv.0: version 1=
.25<br>sata_mv sata_mv.0: slots 32 ports 2<br>scsi0 : sata_mv<br>scsi1 :
 sata_mv<br>ata1: SATA max UDMA/133 irq 29<br>ata2: SATA max UDMA/133 irq 2=
9<br><br>##################################################################=
##################<br><br>I cant guess what is my error?<br>Is there any hi=
nt to solve this problem?<br><br>thanks,<br>Wael<br><br></pre><br></div>=0A=
<!-- cg11.c2.mail.ac4.yahoo.com compressed/chunked Tue Nov  3 06:24:04 PST =
2009 -->=0A</div><br>=0A=0A      </body></html>
--0-7397329-1257260426=:56219--

