Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1278)
From: Stephan Kappertz <stephan.kappertz@kabelmail.de>
In-Reply-To: <4FFF37FF.9080406@xenomai.org>
Date: Fri, 13 Jul 2012 09:09:21 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <8A91EB22-F549-4065-A21E-043AA6DD9BC1@kabelmail.de>
References: <B8BB1834-3B77-49F2-8F40-C4801E858698@kabelmail.de>
	<4FFF33F9.9020000@xenomai.org> <4FFF37FF.9080406@xenomai.org>
Subject: Re: [Xenomai] Xenomai 2.6.1 on beaglebone (TI AM3359 SoC)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi Gilles,

the problem was not the .config file but the fact that =
CONFIG_OMAP_32K_TIMER was ignored for the AM3359 implementation.

So in arch/arm/mach_omap2/timer.c I changed=20

--------------------------------------------
#ifdef CONFIG_ARCH_OMAP3
#ifndef CONFIG_IPIPE
OMAP_SYS_TIMER_INIT(3, 1, OMAP3_CLKEV_SOURCE, 2, OMAP3_MPU_SOURCE)
#else
OMAP_SYS_TIMER_INIT(3, 2, OMAP3_CLKEV_SOURCE, 3, OMAP3_MPU_SOURCE)
#endif
OMAP_SYS_TIMER(3)
OMAP_SYS_TIMER_INIT(3_secure, OMAP3_SECURE_TIMER, OMAP3_CLKEV_SOURCE,
			2, OMAP3_MPU_SOURCE)
OMAP_SYS_TIMER(3_secure)
OMAP_SYS_TIMER_INIT(3_am33xx, 2, OMAP4_MPU_SOURCE, 1, =
AM33XX_RTC32K_SOURCE) <--- ignoring CONFIG_OMAP_32K_TIMER here
OMAP_SYS_TIMER(3_am33xx)

#endif
--------------------------------------------

to

--------------------------------------------
#ifdef CONFIG_ARCH_OMAP3

#ifndef CONFIG_SOC_OMAPAM33XX

#ifndef CONFIG_IPIPE
OMAP_SYS_TIMER_INIT(3, 1, OMAP3_CLKEV_SOURCE, 2, OMAP3_MPU_SOURCE)
#else
OMAP_SYS_TIMER_INIT(3, 2, OMAP3_CLKEV_SOURCE, 3, OMAP3_MPU_SOURCE)
#endif
OMAP_SYS_TIMER(3)
OMAP_SYS_TIMER_INIT(3_secure, OMAP3_SECURE_TIMER, OMAP3_CLKEV_SOURCE,
			2, OMAP3_MPU_SOURCE)
OMAP_SYS_TIMER(3_secure)

#else // #ifdef CONFIG_SOC_OMAPAM33XX

#ifndef CONFIG_IPIPE
OMAP_SYS_TIMER_INIT(3_am33xx, 2, AM33XX_CLKEV_SOURCE, 1, =
AM33XX_MPU_SOURCE)
#else
OMAP_SYS_TIMER_INIT(3_am33xx, 2, AM33XX_CLKEV_SOURCE, 3, =
AM33XX_MPU_SOURCE)
#endif
OMAP_SYS_TIMER(3_am33xx)

#endif

#endif
--------------------------------------------

With the AM33XX_CLKEV_SOURCE and AM33XX_MPU_SOURCE defined as=20

--------------------------------------------
#define OMAP4_MPU_SOURCE	"sys_clkin_ck"
#define AM33XX_MPU_SOURCE	OMAP4_MPU_SOURCE
#define AM33XX_RTC32K_SOURCE	"clk_32768_ck"

#ifdef CONFIG_OMAP_32K_TIMER
#define AM33XX_CLKEV_SOURCE	AM33XX_RTC32K_SOURCE
#define OMAP3_SECURE_TIMER	12
#else
#define AM33XX_CLKEV_SOURCE	OMAP4_MPU_SOURCE
#define OMAP3_SECURE_TIMER	1
#endif
--------------------------------------------

That fixes the clock rate but otherwise does not change the fact that =
I'm stuck in a non ack'd interrupt at boot:=20

Uncompressing Linux... done, booting the kernel.
Linux version 3.2.21 (stephan@ubuntu) (gcc version 4.6.2 (Buildroot =
2011.11) ) #14 PREEMPT Fri Jul 13 19:58:14 CEST 2012
CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=3D10c53c7d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: am335xevm
Ignoring tag cmdline (using the default kernel command line)
bootconsole [earlycon0] enabled
Memory policy: ECC disabled, Data cache writeback
AM335X ES1.0 (sgx neon )
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: =
65024
Kernel command line: console=3DttyO0,115200n8 mem=3D256M =
earlyprintk=3DttyO0 lpj=3D2494464
PID hash table entries: 1024 (order: 0, 4096 bytes)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256MB =3D 256MB total
Memory: 250944k/250944k available, 11200k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xd0800000 - 0xff000000   ( 744 MB)
    lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0xc0008000 - 0xc03e3000   (3948 kB)
      .init : 0xc03e3000 - 0xc083b000   (4448 kB)
      .data : 0xc083c000 - 0xc087e440   ( 266 kB)
       .bss : 0xc087e464 - 0xc08b3270   ( 212 kB)
NR_IRQS:396
IRQ: Found an INTC at 0xfa200000 (revision 5.0) with 128 interrupts
Total of 128 interrupts on 1 active controller
OMAP clockevent source: GPTIMER2 at 24000000 Hz
OMAP clocksource: GPTIMER3 at 24000000 Hz
I-pipe, 24.000 MHz clocksource
sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956ms
Interrupt pipeline (release #1)
------------[ cut here ]------------

- Stephan

Am 12.07.2012 um 22:47 schrieb Gilles Chanteperdrix:

> On 07/12/2012 10:30 PM, Gilles Chanteperdrix wrote:
>> On 07/12/2012 09:54 PM, Stephan Kappertz wrote:
>>> OMAP clockevent source: GPTIMER2 at 24000000 Hz
>>> OMAP clocksource: GPTIMER1 at 32768 Hz
>>> I-pipe, 0.032 MHz clocksource
>>=20
>> This is wrong, normally, you should have something like:
>> [    0.000000] OMAP clockevent source: GPTIMER2 at 13000000 Hz
>> [    0.000000] OMAP clocksource: GPTIMER3 at 13000000 Hz
>> [    0.000000] I-pipe, 13.000 MHz clocksource
>>=20
>> This is ensured by this piece of code in arch/arm/mach-omap2/timer.c:
>> #ifndef CONFIG_IPIPE
>> OMAP_SYS_TIMER_INIT(3, 1, OMAP3_CLKEV_SOURCE, 2, OMAP3_MPU_SOURCE)
>> #else
>> OMAP_SYS_TIMER_INIT(3, 2, OMAP3_CLKEV_SOURCE, 3, OMAP3_MPU_SOURCE)
>> #endif
>>=20
>> So, my guess is that you have some other patch changing this.
>>=20
>=20
> Sending your .config would help. Because you probably have
> CONFIG_OMAP_32K_TIMER on, which should not be normally possible.
>=20
> --=20
>                                                                Gilles.
>=20



