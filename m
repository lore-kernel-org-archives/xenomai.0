From: Iker Amescua <iamescua@domain.hid>
In-Reply-To: <4C2DC68C.1040306@domain.hid>
References: <1278061090.2358.33.camel@domain.hid>
	<4C2DAF63.4040708@domain.hid> <1278066286.8669.9.camel@domain.hid>
	<4C2DC68C.1040306@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 02 Jul 2010 13:24:34 +0200
Message-ID: <1278069874.8669.25.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Adeos-main] Adeos I-PIPE NS9215 port problem
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org



Changing to handle_ir_level make the system boot a bit further, but
still locks.

In the ns921x_timer_init function there is a  call to to
clocksource_register(&ns921x_clocksource) and it is configured (timer 0)
in enabled mode REGSET(tc, SYS_TCx, TE, EN), up counter, 32 bits
autoreload, so I think this is the clocksource. I attach full
time-ns921x.c (I hope I haven't missed anything).

Added lines in hal.h
#elif defined(CONFIG_MACH_CC9P9215JS)
#define RTHAL_TIMER_DEVICE	"ns921x-timer" __stringify(TIMER_CLOCKEVENT)
#define RTHAL_CLOCK_DEVICE	"ns921x-timer" __stringify(TIMER_CLOCKSOURCE)


Thanks again.
-----------------------------------------------------------------
/*
 * arch/arm/mach-ns9xxx/time-ns921x.c
 *
 * Copyright (C) 2007 by Digi International Inc.
 * All rights reserved.
 *
 * This program is free software; you can redistribute it and/or modify
it
 * under the terms of the GNU General Public License version 2 as
published by
 * the Free Software Foundation.
 */
#include <linux/jiffies.h>
#include <linux/interrupt.h>
#include <linux/irq.h>
#include <linux/stringify.h>
#include <linux/clocksource.h>
#include <linux/clockchips.h>

#include <mach/regs-sys-ns921x.h>
#include <mach/irqs.h>

#include "irq.h"
#include "processor-ns921x.h"

#define TIMER_CLOCKSOURCE 0
#define TIMER_CLOCKEVENT 1

static u32 latch;

#ifdef CONFIG_IPIPE
#ifdef CONFIG_NO_IDLE_HZ
#error "dynamic tick timer not yet supported with IPIPE"
#endif				/* CONFIG_NO_IDLE_HZ */
int __ipipe_mach_timerint =3D IRQ_NS921X_TIMER0 + TIMER_CLOCKEVENT;
EXPORT_SYMBOL(__ipipe_mach_timerint);

int __ipipe_mach_timerstolen =3D 0;
EXPORT_SYMBOL(__ipipe_mach_timerstolen);

unsigned int __ipipe_mach_ticks_per_jiffy =3D LATCH;
EXPORT_SYMBOL(__ipipe_mach_ticks_per_jiffy);

static int ns921x_timer_initialized;
union tsc_reg {
#ifdef __BIG_ENDIAN
	struct {
		unsigned long high;
		unsigned long low;
	};
#else				/* __LITTLE_ENDIAN */
	struct {
		unsigned long low;
		unsigned long high;
	};
#endif				/* __LITTLE_ENDIAN */
	unsigned long long full;
};

static union tsc_reg *tsc;

void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
{
	info->type =3D IPIPE_TSC_TYPE_FREERUNNING;
	info->u.fr.counter =3D (unsigned *)SYS_TRC(TIMER_CLOCKSOURCE);
	info->u.fr.mask =3D 0xffffffff;
	info->u.fr.tsc =3D &tsc->full;
}


static void ipipe_mach_update_tsc(void);

#endif				/* CONFIG_IPIPE */



static cycle_t ns921x_clocksource_read(void)
{
	return __raw_readl(SYS_TRC(TIMER_CLOCKSOURCE));
}

static struct clocksource ns921x_clocksource =3D {
	.name	=3D "ns921x-timer" __stringify(TIMER_CLOCKSOURCE),
	.rating	=3D 300,
	.read	=3D ns921x_clocksource_read,
	.mask	=3D CLOCKSOURCE_MASK(32),
	.shift	=3D 20,
	.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS,
};

static void ns921x_clockevent_setmode(enum clock_event_mode mode,
		struct clock_event_device *clk)
{
	u32 oldtc, tc =3D __raw_readl(SYS_TC(TIMER_CLOCKEVENT));
	oldtc =3D tc;

	switch (mode) {
	case CLOCK_EVT_MODE_PERIODIC:
		__raw_writel(latch, SYS_TRCC(TIMER_CLOCKEVENT));
		REGSET(tc, SYS_TCx, RELENBL, EN);
		REGSET(tc, SYS_TCx, INTSEL, EN);
		REGSET(tc, SYS_TCx, TE, EN);
		//printk("ns921x_clockevent_setmode CLOCK_EVT_MODE_PERIODIC\n");
		break;

	case CLOCK_EVT_MODE_ONESHOT:
		REGSET(tc, SYS_TCx, RELENBL, DIS);
		REGSET(tc, SYS_TCx, INTSEL, EN);
		REGSET(tc, SYS_TCx, TE, DIS);
		//printk("ns921x_clockevent_setmode CLOCK_EVT_MODE_ONESHOT\n");
		break;

	case CLOCK_EVT_MODE_UNUSED:
	case CLOCK_EVT_MODE_SHUTDOWN:
	default:
		REGSET(tc, SYS_TCx, TE, DIS);
		//printk("ns921x_clockevent_setmode default\n");
		break;
	}

	/* ack an possibly pending irq
	 * This might stuck the irq priority encoder, but only until the next
	 * timer irq ... */
	if (REGGET(tc, SYS_TCx, TE) =3D=3D SYS_TCx_TE_DIS &&
			REGGET(oldtc, SYS_TCx, TE) =3D=3D SYS_TCx_TE_EN) {
		REGSETIM(tc, SYS_TCx, INTCLR, 1);
		__raw_writel(tc, SYS_TC(TIMER_CLOCKEVENT));
		REGSETIM(tc, SYS_TCx, INTCLR, 0);
	}

	__raw_writel(tc, SYS_TC(TIMER_CLOCKEVENT));
}

static int ns921x_clockevent_setnextevent(unsigned long evt,
		struct clock_event_device *clk)
{
	u32 tc =3D __raw_readl(SYS_TC(TIMER_CLOCKEVENT));

	if (REGGET(tc, SYS_TCx, TE)) {
		REGSET(tc, SYS_TCx, TE, DIS);
		__raw_writel(tc, SYS_TC(TIMER_CLOCKEVENT));
	}

	REGSET(tc, SYS_TCx, TE, EN);

	__raw_writel(evt, SYS_TRCC(TIMER_CLOCKEVENT));

	__raw_writel(tc, SYS_TC(TIMER_CLOCKEVENT));

	return 0;
}


static struct clock_event_device ns921x_clockevent_device =3D {
	.name		=3D "ns921x-timer" __stringify(TIMER_CLOCKEVENT),
	.shift		=3D 20,
	.features	=3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
	.set_mode	=3D ns921x_clockevent_setmode,
	.set_next_event	=3D ns921x_clockevent_setnextevent,
};

#ifdef CONFIG_IPIPE
int __ipipe_check_tickdev(const char *devname)
{
	return !strcmp(devname, ns921x_clockevent_device.name);
	//printk("__ipipe_check_tickdev devname: %s\n", devname);
}
#endif /* CONFIG_IPIPE */

static irqreturn_t ns921x_clockevent_handler(int irq, void *dev_id)
{
	struct clock_event_device *evt =3D &ns921x_clockevent_device;
	//struct clock_event_device *evt =3D dev_id;
#ifndef CONFIG_IPIPE
	int timerno =3D irq - IRQ_NS921X_TIMER0;
	u32 tc;

	/* clear irq */
	tc =3D __raw_readl(SYS_TC(timerno));
	if (REGGET(tc, SYS_TCx, RELENBL) =3D=3D SYS_TCx_RELENBL_DIS) {
		REGSET(tc, SYS_TCx, TE, DIS);
		__raw_writel(tc, SYS_TC(timerno));
	}
	REGSETIM(tc, SYS_TCx, INTCLR, 1);
	__raw_writel(tc, SYS_TC(timerno));
	REGSETIM(tc, SYS_TCx, INTCLR, 0);
	__raw_writel(tc, SYS_TC(timerno));

#else /* CONFIG_IPIPE */
	ipipe_mach_update_tsc();
#endif /* CONFIG_IPIPE */
	evt->event_handler(evt);
	//printk("ns921x_clockevent_handler irq: %d\n", irq);
	//printk("ns921x_clockevent_handler __ipipe_mach_timerstolen: %d\n",
__ipipe_mach_timerstolen);
	//printk("ns921x_clockevent_handler __ipipe_mach_ticks_per_jiffy: %d
\n", __ipipe_mach_ticks_per_jiffy);
	//printk("ns921x_clockevent_handler __ipipe_mach_timerint: %d\n",
__ipipe_mach_timerint);
	//printk("ns921x_clockevent_handler ns921x_clockevent_device.mode: %d
\n", evt->mode);
	return  IRQ_HANDLED;
}

static struct irqaction ns921x_clockevent_action =3D {
	.name		=3D "ns921x-timer" __stringify(TIMER_CLOCKEVENT),
	.flags		=3D IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
	.handler	=3D ns921x_clockevent_handler,
};

static void __init ns921x_timer_init(void)
{
	int tc;

	tc =3D __raw_readl(SYS_TC(TIMER_CLOCKSOURCE));
	if (REGGET(tc, SYS_TCx, TE)) {
		REGSET(tc, SYS_TCx, TE, DIS);
		__raw_writel(tc, SYS_TC(TIMER_CLOCKSOURCE));
	}

	__raw_writel(0, SYS_TRC(TIMER_CLOCKSOURCE));

	REGSET(tc, SYS_TCx, TE, EN);
	REGSET(tc, SYS_TCx, DEBUG, STOP);
	REGSET(tc, SYS_TCx, TCS, 2AHB);
	REGSET(tc, SYS_TCx, MODE, INTERNAL);
	REGSET(tc, SYS_TCx, INTSEL, DIS);
	REGSET(tc, SYS_TCx, UPDOWN, UP);
	REGSET(tc, SYS_TCx, BITTIMER, 32);
	REGSET(tc, SYS_TCx, RELENBL, EN);

	__raw_writel(tc, SYS_TC(TIMER_CLOCKSOURCE));

	ns921x_clocksource.mult =3D clocksource_hz2mult(ns921x_ahbclock() * 2,
			ns921x_clocksource.shift);

	clocksource_register(&ns921x_clocksource);

	latch =3D SH_DIV(ns921x_ahbclock() * 2, HZ, 0);
	//__ipipe_mach_ticks_per_jiffy =3D latch;
	//latch =3D LATCH;

	tc =3D __raw_readl(SYS_TC(TIMER_CLOCKEVENT));
	REGSET(tc, SYS_TCx, TE, DIS);
	REGSET(tc, SYS_TCx, DEBUG, STOP);
	REGSET(tc, SYS_TCx, TCS, 2AHB);
	REGSET(tc, SYS_TCx, MODE, INTERNAL);
	REGSET(tc, SYS_TCx, INTSEL, DIS);
	REGSET(tc, SYS_TCx, UPDOWN, DOWN);
	REGSET(tc, SYS_TCx, BITTIMER, 32);
	REGSET(tc, SYS_TCx, RELENBL, EN);
	__raw_writel(tc, SYS_TC(TIMER_CLOCKEVENT));

	ns921x_clockevent_device.mult =3D div_sc(ns921x_ahbclock() * 2,
			NSEC_PER_SEC, ns921x_clockevent_device.shift);
	ns921x_clockevent_device.max_delta_ns =3D
		clockevent_delta2ns(-1, &ns921x_clockevent_device);
	ns921x_clockevent_device.min_delta_ns =3D
		clockevent_delta2ns(1, &ns921x_clockevent_device);

	ns921x_clockevent_device.cpumask =3D cpumask_of_cpu(0);
	clockevents_register_device(&ns921x_clockevent_device);

#ifdef CONFIG_IPIPE
	tsc =3D (union tsc_reg *)__ipipe_tsc_area;
	barrier();
	ns921x_timer_initialized =3D 1;
#endif	=09

	setup_irq(IRQ_NS921X_TIMER0 + TIMER_CLOCKEVENT,
			&ns921x_clockevent_action);
}

struct sys_timer ns921x_timer =3D {
	.init =3D ns921x_timer_init,
};

#ifdef CONFIG_IPIPE
void __ipipe_mach_acktimer(void)
{
	int timerno =3D IRQ_NS921X_TIMER1 - IRQ_NS921X_TIMER0;
	u32 tc;
	tc =3D __raw_readl(SYS_TC(timerno));
	if (REGGET(tc, SYS_TCx, RELENBL) =3D=3D SYS_TCx_RELENBL_DIS) {
		REGSET(tc, SYS_TCx, TE, DIS);
		__raw_writel(tc, SYS_TC(timerno));
	}

	REGSETIM(tc, SYS_TCx, INTCLR, 1);
	__raw_writel(tc, SYS_TC(timerno));
	REGSETIM(tc, SYS_TCx, INTCLR, 0);
	__raw_writel(tc, SYS_TC(timerno));
	//printk("__ipipe_mach_acktimer INTCLR: %d\n", REGGET(tc, SYS_TCx,
INTCLR) );
	//printk("__ipipe_mach_acktimer timerno: %d\n", timerno );
}

static void ipipe_mach_update_tsc(void)
{
	union tsc_reg *local_tsc;
	unsigned long stamp, flags;

	local_irq_save_hw(flags);
	local_tsc =3D &tsc[ipipe_processor_id()];
	stamp =3D __raw_readl(SYS_TRC(TIMER_CLOCKSOURCE));
	if (unlikely(stamp < local_tsc->low))
		/* 32 bit counter wrapped, increment high word. */
		local_tsc->high++;
	local_tsc->low =3D stamp;
	local_irq_restore_hw(flags);
	//printk("ipipe_mach_update_tsc stamp: %ld\n", stamp );
}

notrace unsigned long long __ipipe_mach_get_tsc(void)
{
	if (likely(ns921x_timer_initialized)) {
		union tsc_reg *local_tsc, result;
		unsigned long stamp;

		local_tsc =3D &tsc[ipipe_processor_id()];

		__asm__("ldmia %1, %M0\n":
			"=3Dr"(result.full): "r"(local_tsc), "m"(*local_tsc));
		barrier();
		stamp =3D __raw_readl(SYS_TRC(TIMER_CLOCKSOURCE));
		if (unlikely(stamp < result.low))
			result.high++;
		result.low =3D stamp;
		//printk("__ipipe_mach_get_tsc stamp: %ld\n", stamp );
		return result.full;
	}
	return 0;
}

EXPORT_SYMBOL(__ipipe_mach_get_tsc);

/*
 * Reprogram the timer
 */
void __ipipe_mach_set_dec(unsigned long delay)
{
	unsigned long flags;
	if (delay > 8) {
		u32 tc;
		local_irq_save_hw(flags);
		tc =3D __raw_readl(SYS_TC(TIMER_CLOCKEVENT));

		if (REGGET(tc, SYS_TCx, TE)) {
			REGSET(tc, SYS_TCx, TE, DIS);
			__raw_writel(tc, SYS_TC(TIMER_CLOCKEVENT));
		}
=09
		REGSET(tc, SYS_TCx, TE, EN);
=09
		__raw_writel(delay, SYS_TRCC(TIMER_CLOCKEVENT));

		__raw_writel(tc, SYS_TC(TIMER_CLOCKEVENT));
		local_irq_restore_hw(flags);
	} else
		ipipe_trigger_irq(IRQ_NS921X_TIMER0 + TIMER_CLOCKEVENT);
	//printk("__ipipe_mach_set_dec delay: %ld\n", delay );
}

EXPORT_SYMBOL(__ipipe_mach_set_dec);

void __ipipe_mach_release_timer(void)
{
	//__ipipe_mach_set_dec(__ipipe_mach_ticks_per_jiffy);
	ns921x_clockevent_setmode(ns921x_clockevent_device.mode,
&ns921x_clockevent_device);
        if (ns921x_clockevent_device.mode =3D=3D CLOCK_EVT_MODE_ONESHOT)
                ns921x_clockevent_setnextevent(LATCH,
&ns921x_clockevent_device);
	//printk("__ipipe_mach_release_timer\n" );
}

EXPORT_SYMBOL(__ipipe_mach_release_timer);

unsigned long __ipipe_mach_get_dec(void)
{
	return __raw_readl(SYS_TRC(TIMER_CLOCKSOURCE));
}
#endif				/* CONFIG_IPIPE */

/* We have no cascaded interrupts. */
void __ipipe_mach_demux_irq(unsigned irq, struct pt_regs *regs) {}




------------------------------------------------------------------------
Boot log (still no nfs packets):

Uncompressing
Linux....................................................................=
............... done, booting the kernel.
[    0.000000] Linux version 2.6.28.10 (iames@domain.hid) (gcc version
4.3.2 (GCC) ) #96 Fri Jul 2 13:01:19 CEST 2010
[    0.000000] CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ),
cr=3D00053177
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: ConnectCore 9P 9215 on a JSCC9P9215 Devboard
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 8128
[    0.000000] Kernel command line:
ip=3D192.168.1.55:192.168.1.21:192.168.1.1:255.255.255.0:cc9p9215js:eth0:=
off console=3DttyNS3,38400 root=3Dnfs nfsroot=3D192.168.1.21:/exports/nfs=
root-cc9p9215js/exports/nfsroot-cc9p9215js mtdparts=3Dphysmap-flash.0:0x4=
0000(U-Boot),0x40000@domain.hid=
00000(RootFS-JFFS2)
[    0.000000] PID hash table entries: 128 (order: 7, 512 bytes)
[42949372.960000] I-pipe 1.12-07: pipeline enabled.
[42949372.960000] Dentry cache hash table entries: 4096 (order: 2, 16384
bytes)
[42949372.970000] Inode-cache hash table entries: 2048 (order: 1, 8192
bytes)
[42949373.130000] Memory: 32MB =3D 32MB total
[42949373.130000] Memory: 29760KB available (2348K code, 227K data, 104K
init)
[42949373.170000] Calibrating delay loop... 4.92 BogoMIPS (lpj=3D24640)
[42949373.390000] Mount-cache hash table entries: 512
[42949373.460000] CPU: Testing write buffer coherency: ok
[42949373.710000] net_namespace: 288 bytes
[42949373.750000] NET: Registered protocol family 16
[42949376.170000] NET: Registered protocol family 2
[42949376.280000] IP route cache hash table entries: 1024 (order: 0,
4096 bytes)
[42949376.330000] TCP established hash table entries: 1024 (order: 1,
8192 bytes)
[42949376.340000] TCP bind hash table entries: 1024 (order: 0, 4096
bytes)
[42949376.340000] TCP: Hash tables configured (established 1024 bind
1024)
[42949376.340000] TCP reno registered
[42949376.400000] NET: Registered protocol family 1
[42949376.670000] I-pipe: Domain Xenomai registered.
[42949376.670000] Xenomai: hal/arm started.

[42949376.680000] Xenomai: scheduling class idle registered.
[42949376.680000] Xenomai: scheduling class rt registered.

[42949377.980000] Xenomai: real-time nucleus v2.5.3 (Hordes Of Locusts)
loaded.
[42949378.530000] Xenomai: native skin init failed, code -38.
[42949378.530000] Xenomai: starting POSIX services.
[42949379.070000] Xenomai: POSIX skin init failed, code -38.
[42949379.610000] Xenomai: RTDM skin init failed, code -38.
[42949379.800000] JFFS2 version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 R=
ed
Hat, Inc.
[42949379.860000] msgmni has been set to 58
[42949379.870000] io scheduler noop registered (default)
[42949380.020000] adc-ns9215: ADC available on MAJOR 254
[42949380.060000] ns921x-serial.1: ttyNS1 at MMIO 0x90018000 (irq =3D 8)
is a NS921X
[42949380.110000] ns921x-serial.2: ttyNS2 at MMIO 0x90020000 (irq =3D 9)
is a NS921X
[42949380.160000] ns921x-serial.3: ttyNS3 at MMIO 0x90028000 (irq =3D 10)
is a NS921X
[42949380.160000] console [ttyNS3] enabled
[42949380.250000] Digi NS921x UART driver
[42949381.660000] brd: module loaded
[42949381.790000] ns9xxx-eth-mii: probed
[42949381.890000] ns9xxx-eth ns9xxx-eth: eth0 at MMIO c2928000
[42949381.930000] Digi NS9XXX Ethernet driver
[42949381.990000] physmap platform flash device: 10000000 at 50000000
[42949382.340000] physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit
bank
[42949382.400000]  Amd/Fujitsu Extended Query Table at 0x0040
[42949382.420000] physmap-flash.0: CFI does not contain boot bank
location. Assuming top.
[42949382.430000] number of CFI chips: 1
[42949382.440000] cfi_cmdset_0002: Disabling erase-suspend-program due
to code brokenness.
[42949382.460000] 4 cmdlinepart partitions found on MTD device
physmap-flash.0
[42949382.470000] Creating 4 MTD partitions on "physmap-flash.0":
[42949382.490000] 0x00000000-0x00040000 : "U-Boot"
[42949382.680000] 0x00040000-0x00080000 : "NVRAM"
[42949382.830000] 0x00080000-0x00200000 : "Kernel"
[42949382.970000] 0x00200000-0x01000000 : "RootFS-JFFS2"
[42949383.170000] spi_ns921x spi_ns921x.1: NS921x SPI controller at
0xc2960000 (irq: 11)
[42949383.250000] TCP cubic registered
[42949383.260000] NET: Registered protocol family 17

[42949383.320000] RPC: Registered udp transport module.
[42949383.330000] RPC: Registered tcp transport module.
[42949383.680000] IP-Config: Complete:
[42949383.690000]      device=3Deth0, addr=3D192.168.1.55,
mask=3D255.255.255.0, gw=3D192.168.1.1,
[42949383.750000]      host=3Dcc9p9215js, domain=3D, nis-domain=3D(none),
[42949383.760000]      bootserver=3D192.168.1.21, rootserver=3D192.168.1.=
21,
rootpath=3D
[42949383.830000] Looking up port of RPC 100003/2 on 192.168.1.21
[42949383.870000] net eth0: link up (100/full)
[42949383.900000] Looking up port of RPC 100005/1 on 192.168.1.21



--=20
Iker Amescua


El vie, 02-07-2010 a las 12:59 +0200, Gilles Chanteperdrix escribi=C3=B3:
> Iker Amescua wrote:
> > Thanks a lot!
> >=20
> > Now at least it boots. This is what I have done (I expect correctly):
> >=20
> > IRQ are now handled by=20
> > #ifndef CONFIG_IPIPE
> > 		set_irq_handler(i, handle_prio_irq);
> > #else
> > 		set_irq_handler(i, handle_edge_irq);
> > #endif /*CONFIG_IPIPE*/
> >=20
> > And in irqs.h
> > #define irq_finish(irq) irq_desc[irq].chip->eoi(irq);
> >=20
> > Is this correct?
> >=20
> > The problem now it locks up during boot. This is the console output:
>=20
> Ok. Try handle_level_irq instead of handle_edge_irq, if your irq
> controller is well-behaved enough, it should work.
>=20
> > What are these errors?
> > [42949376.490000] Xenomai: hal/arm started.
> > [42949376.490000] Xenomai: scheduling class idle registered.
> > [42949376.500000] Xenomai: scheduling class rt registered.
> > [42949377.740000] Xenomai: real-time nucleus v2.5.3 (Hordes Of Locust=
s)
> > loaded.
> > [42949378.290000] Xenomai: native skin init failed, code -38.
> > [42949378.290000] Xenomai: starting POSIX services.
> > [42949378.830000] Xenomai: POSIX skin init failed, code -38.
> > [42949379.370000] Xenomai: RTDM skin init failed, code -38.
>=20
> Probably something wrong with the timer initialization. Are you sure th=
e
> kernel uses the clock you think it uses? One reason may be that the
> timer you are requesting is in the CLOCK_EVT_MODE_SHUTDOWN state,
> meaning that it is not used by the kernel. Also, I see no trace
> indicating that the Linux kernel uses your clock source. You should see
> something like:
>=20
> Switching to clocksource foo
>=20
> in the kernel sources, unless you have not implemented a clock source?
>=20


