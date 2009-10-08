MIME-Version: 1.0
Date: Thu, 8 Oct 2009 17:27:27 +0900
Message-ID: <1f3e02580910080127k766f2407o317ae8a2ce088b4a@domain.hid>
From: Didenko Sergey <didenkos@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd14468d316530475683ba2
Subject: [Xenomai-help] Support for ARCH_MV88F6290
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

--000e0cd14468d316530475683ba2
Content-Type: text/plain; charset=UTF-8

Dear Xenomai Experts,

So far I did not progress too much.

What I have now is that patched Linux is starting to boot as original kernel
and it hangs right after line
[42949373.240000] ata1: SATA max UDMA/133 irq 27

Next characters are printed out:
"?" - from __ipipe_mach_acktimer()
"^" - from orion_timer_interrupt()
"-" - from __ipipe_mach_set_dec()
"_" - from __ipipe_mach_get_tsc()

=========================== LOG - Start
Starting kernel ...

Uncompressing
Linux..........................................................................................................................................
[    0.000000] Linux version 2.6.29_V02.00.29 (gcc version 4.2.1
(CodeSourcery Sourcery G++ Lite 2007q3-51)) #46 PREEMPT Thu Oct 8 15:059
[    0.000000] CPU: Feroceon [41159260] revision 0 (ARMv5TE), cr=00053177
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: Marvell 88f6290 Board
[    0.000000] Using u-boot passing parameters structure
[    0.000000] uboot version: 33757680
[    0.000000] board id: 240
[    0.000000] usb host: 3
[    0.000000] over ethernet address: 0x0
[    0.000000] MAC address: 00:00:00:00:51:81
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total
pages: 130048
[    0.000000] Kernel command line: root=/dev/nfs rw
nfsroot=10.88.198.79:/nfs/rootfs
ip=10.88.197.82:10.88.198.79:10.88.197.1:255.255.255.0::eth0:off conso8
[    0.000000] PID hash table entries: 2048 (order: 11, 8192 bytes)
[    0.000000]
[    0.000000] ===[Break point] orion_time_init - IN
[    0.000000] ===[Break point] orion_clkevt_mode - IN
[    0.000000] ===[Break point] orion_clkevt_mode - IN<6>I-pipe 1.13-03:
pipeline enabled.
[42949372.960000] Console: colour dummy device 80x30
[42949372.960000] Dentry cache hash table entries: 65536 (order: 6, 262144
bytes)
[42949372.960000] Inode-cache hash table entries: 32768 (order: 5, 131072
bytes)
[42949372.960000] ?^?^<6>Memory: 256MB 256MB = 512MB total
[42949372.980000] Memory: 383744KB available (4188K code, 389K data, 116K
init)
[42949372.980000] SLUB: Genslabs=12, HWalign=32, Order=0-3, MinObjects=0,
CPUs=1, Nodes=1
[42949372.980000] Calibrating delay loop...
?^?^?^?^?^?^?^?^?^?^?^?^?^?^?^?^?^?^?^?^?^797.90 BogoMIPS (lpj=3989504)
[42949373.190000] ?^Mount-cache hash table entries: 512
[42949373.200000] CPU: Testing write buffer coherency: ok
[42949373.200000]
[42949373.200000] ===[Break point] rest_init - IN<6>net_namespace: 884 bytes
[42949373.200000] NET: Registered protocol family 16
[42949373.200000] MV88F6290: MV88F6290-A0, TCLK=166666667.
[42949373.200000] GPIO-17 autorequested
[42949373.200000] MV88F6290 PCIe #0: <6>link up
[42949373.200000] MV88F6290 PCIe #1: <6>link down, ignoring
[42949373.200000] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[42949373.200000] pci 0000:00:01.0: PME# disabled
[42949373.200000] PCI: bus0: Fast back to back transfers disabled
[42949373.200000] PCI: bus1: Fast back to back transfers enabled
[42949373.200000] pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
[42949373.200000] pci 0000:00:01.0:   IO window: disabled
[42949373.200000] pci 0000:00:01.0:   MEM window: disabled
[42949373.200000] pci 0000:00:01.0:   PREFETCH window: disabled
[42949373.200000] ?^?^bio: create slab <bio-0> at 0
[42949373.220000] SCSI subsystem initialized
[42949373.220000] usbcore: registered new interface driver usbfs
[42949373.220000] usbcore: registered new interface driver hub
[42949373.220000] usbcore: registered new device driver usb
[42949373.220000] ?^<6>NET: Registered protocol family 2
[42949373.230000] IP route cache hash table entries: 16384 (order: 4, 65536
bytes)
[42949373.230000] TCP established hash table entries: 65536 (order: 7,
524288 bytes)
[42949373.230000] TCP bind hash table entries: 65536 (order: 6, 262144
bytes)
[42949373.230000] TCP: Hash tables configured (established 65536 bind 65536)
[42949373.230000] TCP reno registered
[42949373.230000] NET: Registered protocol family 1
[42949373.230000]
[42949373.230000] ===[Break point] __ipipe_mach_get_tscinfo - IN
[42949373.230000] ===[Break point] __ipipe_mach_get_tscinfo - IN<6>I-pipe:
Domain Xenomai registered.
[42949373.230000] Xenomai: hal/arm started.
[42949373.230000] ?^<6>Xenomai: real-time nucleus v2.4.9.1 (Big Bad Moon)
loaded.
[42949373.240000] _-___-__<6>Xenomai: starting native API services.
[42949373.240000] Xenomai: starting POSIX services.
[42949373.240000] Xenomai: starting RTDM services.
[42949373.240000] ?___-__<6>bigphysarea: Allocated 32768 pages at
0xc08a8000.
[42949373.240000] ?___-__<6>NTFS driver 2.1.29 [Flags: R/O].
[42949373.240000] JFFS2 version 2.2. (NAND) .. 2001-2006 Red Hat, Inc.
[42949373.240000] msgmni has been set to 749
[42949373.240000] alg: No test for stdrng (krng)
[42949373.240000] io scheduler noop registered
[42949373.240000] io scheduler anticipatory registered
[42949373.240000] io scheduler deadline registered
[42949373.240000] io scheduler cfq registered (default)
[42949373.240000] ?___-__?___-__?___-__<6>Serial: 8250/16550 driver, 2
ports, IRQ sharing disabled
[42949373.240000] serial8250.0: ttyS0 at MMIO 0xf1012000 (irq = 3) is a
16550A
[42949373.240000] console [ttyS0] enabled
[42949373.240000]
??????????????????????????????????????????___-_____-_____-_____-_____-_____-_____-_____-_____-_____-_____-_____-_____-_____-_____-_____-__d
[42949373.240000] ?___-__<5>MV-643xx 10/100/1000 ethernet driver version 1.4
[42949373.240000] mv643xx_eth smi: probed
[42949373.240000] ?___-__?___-__<6>eth0 (mv643xx_eth_port): not using
net_device_ops yet
[42949373.240000] net eth0: port 0 with MAC address 00:00:00:00:51:81
[42949373.240000] ?___-__<6>usbcore: registered new interface driver
cdc_ether
[42949373.240000] ?___-__<6>usbcore: registered new interface driver
rndis_host
[42949373.240000] ?___-__<6>usbcore: registered new interface driver
cdc_subset
[42949373.240000] Driver 'sd' needs updating - please use bus_type methods
[42949373.240000] ?___-__<6>sata_mv sata_mv.0: version 1.25
[42949373.240000] ?___-__<6>sata_mv sata_mv.0: slots 32 ports 1
[42949373.240000] scsi0 : sata_mv
[42949373.240000] ?___-__<6>ata1: SATA max UDMA/133 irq 27
[42949373.240000] ?___-__?___-__?___-__?___-__?___-__?___-__?___-__?___-__

=========================== LOG - End

As you can see after line

[42949373.230000] ?^<6>Xenomai: real-time nucleus v2.4.9.1 (Big Bad Moon)
loaded.

System does not go to timer_interrupt() function any more.

What I'm worring about is that the system has 2 timers, one is free-running
with disabled interrupts, second one is interrupt-driven clockevent timer.

=========================== Code - Start

/*
 * Clockevent handling.
 */
static int
orion_clkevt_next_event(unsigned long delta, struct clock_event_device *dev)
{
    unsigned long flags;
    u32 u;

    XEN_PRINT("-ne-");

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

    local_irq_save(flags);
    if (mode == CLOCK_EVT_MODE_PERIODIC) {

        XEN_PRINT("-cm1-");

        /*
         * Setup timer to fire at 1/HZ intervals.
         */
        writel(ticks_per_jiffy - 1, TIMER1_RELOAD);
        writel(ticks_per_jiffy - 1, TIMER1_VAL);

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

        XEN_PRINT("-cm2-");

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
    .features    = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
    .shift        = 32,
    .rating        = 300,
    .set_next_event    = orion_clkevt_next_event,
    .set_mode    = orion_clkevt_mode,
};

static irqreturn_t orion_timer_interrupt(int irq, void *dev_id)
{
    XEN_PRINT("^");

    /*
     * ACK timer interrupt and call event handler.
     */
    writel(BRIDGE_INT_TIMER1_CLR, BRIDGE_CAUSE);
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

    ticks_per_jiffy = (tclk + HZ/2) / HZ;


    /*
     * Setup free-running clocksource timer (interrupts
     * disabled.)
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
     * Setup clockevent timer (interrupt-driven.)
     */
    setup_irq(irq, &orion_timer_irq);
    orion_clkevt.mult = div_sc(tclk, NSEC_PER_SEC, orion_clkevt.shift);
    orion_clkevt.max_delta_ns = clockevent_delta2ns(0xfffffffe,
&orion_clkevt);
    orion_clkevt.min_delta_ns = clockevent_delta2ns(1, &orion_clkevt);
    orion_clkevt.cpumask = cpumask_of(0);
    clockevents_register_device(&orion_clkevt);
}

=========================== Code - End

According to HOWTO Xenomai needs free-running counter, in my case it is
Timer 0, but all functions are configured to work with Timer 1, which is not
free running.

What would you sugest to do?

Sergey

--000e0cd14468d316530475683ba2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Dear Xenomai Experts, <br><br>So far I did not progress too much.<br><br>Wh=
at I have now is that patched Linux is starting to boot as original kernel =
and it hangs right after line<br>[42949373.240000] ata1: SATA max UDMA/133 =
irq 27<br>
<br>Next characters are printed out:<br>&quot;?&quot; - from __ipipe_mach_a=
cktimer()<br>&quot;^&quot; - from orion_timer_interrupt()<br>&quot;-&quot; =
- from __ipipe_mach_set_dec()<br>&quot;_&quot; - from __ipipe_mach_get_tsc(=
)<br>
<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D LOG - Start<br>Starting kernel ...<br><br>Uncompressing Linux.=
...........................................................................=
..............................................................<br>
[=C2=A0=C2=A0=C2=A0 0.000000] Linux version 2.6.29_V02.00.29 (gcc version 4=
.2.1 (CodeSourcery Sourcery G++ Lite 2007q3-51)) #46 PREEMPT Thu Oct 8 15:0=
59<br>[=C2=A0=C2=A0=C2=A0 0.000000] CPU: Feroceon [41159260] revision 0 (AR=
Mv5TE), cr=3D00053177<br>[=C2=A0=C2=A0=C2=A0 0.000000] CPU: VIVT data cache=
, VIVT instruction cache<br>
[=C2=A0=C2=A0=C2=A0 0.000000] Machine: Marvell 88f6290 Board<br>[=C2=A0=C2=
=A0=C2=A0 0.000000] Using u-boot passing parameters structure<br>[=C2=A0=C2=
=A0=C2=A0 0.000000] uboot version: 33757680<br>[=C2=A0=C2=A0=C2=A0 0.000000=
] board id: 240<br>[=C2=A0=C2=A0=C2=A0 0.000000] usb host: 3<br>[=C2=A0=C2=
=A0=C2=A0 0.000000] over ethernet address: 0x0<br>
[=C2=A0=C2=A0=C2=A0 0.000000] MAC address: 00:00:00:00:51:81<br>[=C2=A0=C2=
=A0=C2=A0 0.000000] Memory policy: ECC disabled, Data cache writeback<br>[=
=C2=A0=C2=A0=C2=A0 0.000000] Built 1 zonelists in Zone order, mobility grou=
ping on.=C2=A0 Total pages: 130048<br>[=C2=A0=C2=A0=C2=A0 0.000000] Kernel =
command line: root=3D/dev/nfs rw nfsroot=3D10.88.198.79:/nfs/rootfs ip=3D10=
.88.197.82:10.88.198.79:10.88.197.1:255.255.255.0::eth0:off conso8<br>
[=C2=A0=C2=A0=C2=A0 0.000000] PID hash table entries: 2048 (order: 11, 8192=
 bytes)<br>[=C2=A0=C2=A0=C2=A0 0.000000] <br>[=C2=A0=C2=A0=C2=A0 0.000000] =
=3D=3D=3D[Break point] orion_time_init - IN<br>[=C2=A0=C2=A0=C2=A0 0.000000=
] =3D=3D=3D[Break point] orion_clkevt_mode - IN<br>[=C2=A0=C2=A0=C2=A0 0.00=
0000] =3D=3D=3D[Break point] orion_clkevt_mode - IN&lt;6&gt;I-pipe 1.13-03:=
 pipeline enabled.<br>
[42949372.960000] Console: colour dummy device 80x30<br>[42949372.960000] D=
entry cache hash table entries: 65536 (order: 6, 262144 bytes)<br>[42949372=
.960000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)<br>
[42949372.960000] ?^?^&lt;6&gt;Memory: 256MB 256MB =3D 512MB total<br>[4294=
9372.980000] Memory: 383744KB available (4188K code, 389K data, 116K init)<=
br>[42949372.980000] SLUB: Genslabs=3D12, HWalign=3D32, Order=3D0-3, MinObj=
ects=3D0, CPUs=3D1, Nodes=3D1<br>
[42949372.980000] Calibrating delay loop... ?^?^?^?^?^?^?^?^?^?^?^?^?^?^?^?=
^?^?^?^?^?^797.90 BogoMIPS (lpj=3D3989504)<br>[42949373.190000] ?^Mount-cac=
he hash table entries: 512<br>[42949373.200000] CPU: Testing write buffer c=
oherency: ok<br>
[42949373.200000] <br>[42949373.200000] =3D=3D=3D[Break point] rest_init - =
IN&lt;6&gt;net_namespace: 884 bytes<br>[42949373.200000] NET: Registered pr=
otocol family 16<br>[42949373.200000] MV88F6290: MV88F6290-A0, TCLK=3D16666=
6667.<br>
[42949373.200000] GPIO-17 autorequested<br>[42949373.200000] MV88F6290 PCIe=
 #0: &lt;6&gt;link up<br>[42949373.200000] MV88F6290 PCIe #1: &lt;6&gt;link=
 down, ignoring<br>[42949373.200000] pci 0000:00:01.0: PME# supported from =
D0 D3hot D3cold<br>
[42949373.200000] pci 0000:00:01.0: PME# disabled<br>[42949373.200000] PCI:=
 bus0: Fast back to back transfers disabled<br>[42949373.200000] PCI: bus1:=
 Fast back to back transfers enabled<br>[42949373.200000] pci 0000:00:01.0:=
 PCI bridge, secondary bus 0000:01<br>
[42949373.200000] pci 0000:00:01.0:=C2=A0=C2=A0 IO window: disabled<br>[429=
49373.200000] pci 0000:00:01.0:=C2=A0=C2=A0 MEM window: disabled<br>[429493=
73.200000] pci 0000:00:01.0:=C2=A0=C2=A0 PREFETCH window: disabled<br>[4294=
9373.200000] ?^?^bio: create slab &lt;bio-0&gt; at 0<br>
[42949373.220000] SCSI subsystem initialized<br>[42949373.220000] usbcore: =
registered new interface driver usbfs<br>[42949373.220000] usbcore: registe=
red new interface driver hub<br>[42949373.220000] usbcore: registered new d=
evice driver usb<br>
[42949373.220000] ?^&lt;6&gt;NET: Registered protocol family 2<br>[42949373=
.230000] IP route cache hash table entries: 16384 (order: 4, 65536 bytes)<b=
r>[42949373.230000] TCP established hash table entries: 65536 (order: 7, 52=
4288 bytes)<br>
[42949373.230000] TCP bind hash table entries: 65536 (order: 6, 262144 byte=
s)<br>[42949373.230000] TCP: Hash tables configured (established 65536 bind=
 65536)<br>[42949373.230000] TCP reno registered<br>[42949373.230000] NET: =
Registered protocol family 1<br>
[42949373.230000] <br>[42949373.230000] =3D=3D=3D[Break point] __ipipe_mach=
_get_tscinfo - IN<br>[42949373.230000] =3D=3D=3D[Break point] __ipipe_mach_=
get_tscinfo - IN&lt;6&gt;I-pipe: Domain Xenomai registered.<br>[42949373.23=
0000] Xenomai: hal/arm started.<br>
[42949373.230000] ?^&lt;6&gt;Xenomai: real-time nucleus v2.4.9.1 (Big Bad M=
oon) loaded.<br>[42949373.240000] _-___-__&lt;6&gt;Xenomai: starting native=
 API services.<br>[42949373.240000] Xenomai: starting POSIX services.<br>
[42949373.240000] Xenomai: starting RTDM services.<br>[42949373.240000] ?__=
_-__&lt;6&gt;bigphysarea: Allocated 32768 pages at 0xc08a8000.<br>[42949373=
.240000] ?___-__&lt;6&gt;NTFS driver 2.1.29 [Flags: R/O].<br>[42949373.2400=
00] JFFS2 version 2.2. (NAND) .. 2001-2006 Red Hat, Inc.<br>
[42949373.240000] msgmni has been set to 749<br>[42949373.240000] alg: No t=
est for stdrng (krng)<br>[42949373.240000] io scheduler noop registered<br>=
[42949373.240000] io scheduler anticipatory registered<br>[42949373.240000]=
 io scheduler deadline registered<br>
[42949373.240000] io scheduler cfq registered (default)<br>[42949373.240000=
] ?___-__?___-__?___-__&lt;6&gt;Serial: 8250/16550 driver, 2 ports, IRQ sha=
ring disabled<br>[42949373.240000] serial8250.0: ttyS0 at MMIO 0xf1012000 (=
irq =3D 3) is a 16550A<br>
[42949373.240000] console [ttyS0] enabled<br>[42949373.240000] ????????????=
??????????????????????????????___-_____-_____-_____-_____-_____-_____-_____=
-_____-_____-_____-_____-_____-_____-_____-_____-__d<br>[42949373.240000] ?=
___-__&lt;5&gt;MV-643xx 10/100/1000 ethernet driver version 1.4<br>
[42949373.240000] mv643xx_eth smi: probed<br>[42949373.240000] ?___-__?___-=
__&lt;6&gt;eth0 (mv643xx_eth_port): not using net_device_ops yet<br>[429493=
73.240000] net eth0: port 0 with MAC address 00:00:00:00:51:81<br>[42949373=
.240000] ?___-__&lt;6&gt;usbcore: registered new interface driver cdc_ether=
<br>
[42949373.240000] ?___-__&lt;6&gt;usbcore: registered new interface driver =
rndis_host<br>[42949373.240000] ?___-__&lt;6&gt;usbcore: registered new int=
erface driver cdc_subset<br>[42949373.240000] Driver &#39;sd&#39; needs upd=
ating - please use bus_type methods<br>
[42949373.240000] ?___-__&lt;6&gt;sata_mv sata_mv.0: version 1.25<br>[42949=
373.240000] ?___-__&lt;6&gt;sata_mv sata_mv.0: slots 32 ports 1<br>[4294937=
3.240000] scsi0 : sata_mv<br>[42949373.240000] ?___-__&lt;6&gt;ata1: SATA m=
ax UDMA/133 irq 27<br>
[42949373.240000] ?___-__?___-__?___-__?___-__?___-__?___-__?___-__?___-__<=
br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D LOG - End<br><br>As you can see after line <br><br>[4294937=
3.230000] ?^&lt;6&gt;Xenomai: real-time nucleus v2.4.9.1 (Big Bad Moon) loa=
ded.<br>
<br>System does not go to timer_interrupt() function any more.<br><br>What =
I&#39;m worring about is that the system has 2 timers, one is free-running =
with disabled interrupts, second one is interrupt-driven clockevent timer.<=
br>
<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D Code - Start<br><br>/*<br>=C2=A0* Clockevent handling.<br>=C2=
=A0*/<br>static int<br>orion_clkevt_next_event(unsigned long delta, struct =
clock_event_device *dev)<br>{<br>=C2=A0=C2=A0=C2=A0 unsigned long flags;<br=
>=C2=A0=C2=A0=C2=A0 u32 u;<br>
<br>=C2=A0=C2=A0=C2=A0 XEN_PRINT(&quot;-ne-&quot;);<br><br>=C2=A0=C2=A0=C2=
=A0 if (delta =3D=3D 0)<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -ET=
IME;<br><br>=C2=A0=C2=A0=C2=A0 local_irq_save(flags);<br><br>=C2=A0=C2=A0=
=C2=A0 /*<br>=C2=A0=C2=A0=C2=A0 =C2=A0* Clear and enable clockevent timer i=
nterrupt.<br>=C2=A0=C2=A0=C2=A0 =C2=A0*/<br>=C2=A0=C2=A0=C2=A0 writel(BRIDG=
E_INT_TIMER1_CLR, BRIDGE_CAUSE);<br>
<br>=C2=A0=C2=A0=C2=A0 u =3D readl(BRIDGE_MASK);<br>=C2=A0=C2=A0=C2=A0 u |=
=3D BRIDGE_INT_TIMER1;<br>=C2=A0=C2=A0=C2=A0 writel(u, BRIDGE_MASK);<br><br=
>=C2=A0=C2=A0=C2=A0 /*<br>=C2=A0=C2=A0=C2=A0 =C2=A0* Setup new clockevent t=
imer value.<br>=C2=A0=C2=A0=C2=A0 =C2=A0*/<br>=C2=A0=C2=A0=C2=A0 writel(del=
ta, TIMER1_VAL);<br><br>=C2=A0=C2=A0=C2=A0 /*<br>=C2=A0=C2=A0=C2=A0 =C2=A0*=
 Enable the timer.<br>
=C2=A0=C2=A0=C2=A0 =C2=A0*/<br>=C2=A0=C2=A0=C2=A0 u =3D readl(TIMER_CTRL);<=
br>=C2=A0=C2=A0=C2=A0 u =3D (u &amp; ~TIMER1_RELOAD_EN) | TIMER1_EN;<br>=C2=
=A0=C2=A0=C2=A0 writel(u, TIMER_CTRL);<br><br>=C2=A0=C2=A0=C2=A0 local_irq_=
restore(flags);<br><br>=C2=A0=C2=A0=C2=A0 return 0;<br>}<br><br>static void=
<br>orion_clkevt_mode(enum clock_event_mode mode, struct clock_event_device=
 *dev)<br>
{<br>=C2=A0=C2=A0=C2=A0 unsigned long flags;<br>=C2=A0=C2=A0=C2=A0 u32 u;<b=
r><br>=C2=A0=C2=A0=C2=A0 local_irq_save(flags);<br>=C2=A0=C2=A0=C2=A0 if (m=
ode =3D=3D CLOCK_EVT_MODE_PERIODIC) {<br><br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 XEN_PRINT(&quot;-cm1-&quot;);<br><br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 /*<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0* Setup timer t=
o fire at 1/HZ intervals.<br>
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0*/<br>=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 writel(ticks_per_jiffy - 1, TIMER1_RELOAD);<br>=C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 writel(ticks_per_jiffy - 1, TIMER1_VAL);<br><br>=C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /*<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0* Enable timer interrupt.<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0*/<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 u =3D readl(BRIDGE_MA=
SK);<br>
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 writel(u | BRIDGE_INT_TIMER1, BRIDGE_=
MASK);<br><br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /*<br>=C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0* Enable timer.<br>=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 =C2=A0*/<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 u =3D readl(=
TIMER_CTRL);<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 writel(u | TIMER1_EN =
| TIMER1_RELOAD_EN, TIMER_CTRL);<br>=C2=A0=C2=A0=C2=A0 } else {<br>
<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 XEN_PRINT(&quot;-cm2-&quot;);<br>=
<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /*<br>=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 =C2=A0* Disable timer.<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0*/<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 u =3D readl(TIMER_CTR=
L);<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 writel(u &amp; ~TIMER1_EN, TIM=
ER_CTRL);<br><br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /*<br>=C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0* Disable timer interrupt.<br>
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0*/<br>=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 u =3D readl(BRIDGE_MASK);<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 writel(u &amp; ~BRIDGE_INT_TIMER1, BRIDGE_MASK);<br><br>=C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 /*<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0* ACK pending timer interrupt.<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0*/<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 writel(BRIDGE_INT_TIMER1_=
CLR, BRIDGE_CAUSE);<br>
<br>=C2=A0=C2=A0=C2=A0 }<br>=C2=A0=C2=A0=C2=A0 local_irq_restore(flags);<br=
>}<br><br>static struct clock_event_device orion_clkevt =3D {<br>=C2=A0=C2=
=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =3D &quot;orion_tick&q=
uot;,<br>=C2=A0=C2=A0=C2=A0 .features=C2=A0=C2=A0=C2=A0 =3D CLOCK_EVT_FEAT_=
ONESHOT | CLOCK_EVT_FEAT_PERIODIC,<br>
=C2=A0=C2=A0=C2=A0 .shift=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =3D 32,<br>=
=C2=A0=C2=A0=C2=A0 .rating=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =3D 300,<br=
>=C2=A0=C2=A0=C2=A0 .set_next_event=C2=A0=C2=A0=C2=A0 =3D orion_clkevt_next=
_event,<br>=C2=A0=C2=A0=C2=A0 .set_mode=C2=A0=C2=A0=C2=A0 =3D orion_clkevt_=
mode,<br>};<br><br>static irqreturn_t orion_timer_interrupt(int irq, void *=
dev_id)<br>
{<br>=C2=A0=C2=A0=C2=A0 XEN_PRINT(&quot;^&quot;);<br><br>=C2=A0=C2=A0=C2=A0=
 /*<br>=C2=A0=C2=A0=C2=A0 =C2=A0* ACK timer interrupt and call event handle=
r.<br>=C2=A0=C2=A0=C2=A0 =C2=A0*/<br>=C2=A0=C2=A0=C2=A0 writel(BRIDGE_INT_T=
IMER1_CLR, BRIDGE_CAUSE);<br>=C2=A0=C2=A0=C2=A0 orion_clkevt.event_handler(=
&amp;orion_clkevt);<br>
<br>=C2=A0=C2=A0=C2=A0 return IRQ_HANDLED;<br>}<br><br>static struct irqact=
ion orion_timer_irq =3D {<br>=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =3D &quot;orion_tick&quot;,<br>=C2=A0=C2=A0=C2=A0 .flags=C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =3D IRQF_DISABLED | IRQF_TIMER,<br>=C2=
=A0=C2=A0=C2=A0 .handler=C2=A0=C2=A0=C2=A0 =3D orion_timer_interrupt<br>
};<br><br>void __init orion_time_init(unsigned int irq, unsigned int tclk)<=
br>{<br>=C2=A0=C2=A0=C2=A0 u32 u;<br><br>=C2=A0=C2=A0=C2=A0 ticks_per_jiffy=
 =3D (tclk + HZ/2) / HZ;<br><br><br>=C2=A0=C2=A0=C2=A0 /*<br>=C2=A0=C2=A0=
=C2=A0 =C2=A0* Setup free-running clocksource timer (interrupts<br>
=C2=A0=C2=A0=C2=A0 =C2=A0* disabled.)<br>=C2=A0=C2=A0=C2=A0 =C2=A0*/<br>=C2=
=A0=C2=A0=C2=A0 writel(0xffffffff, TIMER0_VAL);<br>=C2=A0=C2=A0=C2=A0 write=
l(0xffffffff, TIMER0_RELOAD);<br>=C2=A0=C2=A0=C2=A0 u =3D readl(BRIDGE_MASK=
);<br>=C2=A0=C2=A0=C2=A0 writel(u &amp; ~BRIDGE_INT_TIMER0, BRIDGE_MASK);<b=
r>=C2=A0=C2=A0=C2=A0 u =3D readl(TIMER_CTRL);<br>
=C2=A0=C2=A0=C2=A0 writel(u | TIMER0_EN | TIMER0_RELOAD_EN, TIMER_CTRL);<br=
>=C2=A0=C2=A0=C2=A0 orion_clksrc.mult =3D clocksource_hz2mult(tclk, orion_c=
lksrc.shift);<br>=C2=A0=C2=A0=C2=A0 clocksource_register(&amp;orion_clksrc)=
;<br><br><br>=C2=A0=C2=A0=C2=A0 /*<br>=C2=A0=C2=A0=C2=A0 =C2=A0* Setup cloc=
kevent timer (interrupt-driven.)<br>
=C2=A0=C2=A0=C2=A0 =C2=A0*/<br>=C2=A0=C2=A0=C2=A0 setup_irq(irq, &amp;orion=
_timer_irq);<br>=C2=A0=C2=A0=C2=A0 orion_clkevt.mult =3D div_sc(tclk, NSEC_=
PER_SEC, orion_clkevt.shift);<br>=C2=A0=C2=A0=C2=A0 orion_clkevt.max_delta_=
ns =3D clockevent_delta2ns(0xfffffffe, &amp;orion_clkevt);<br>=C2=A0=C2=A0=
=C2=A0 orion_clkevt.min_delta_ns =3D clockevent_delta2ns(1, &amp;orion_clke=
vt);<br>
=C2=A0=C2=A0=C2=A0 orion_clkevt.cpumask =3D cpumask_of(0);<br>=C2=A0=C2=A0=
=C2=A0 clockevents_register_device(&amp;orion_clkevt);<br>}<br><br>=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 Code - End<br><br>According to HOWTO Xenomai needs free-running counter, i=
n my case it is Timer 0, but all functions are configured to work with Time=
r 1, which is not free running.<br>
<br>What would you sugest to do?<br><br>Sergey

--000e0cd14468d316530475683ba2--

