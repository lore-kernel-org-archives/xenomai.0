From: Iker Amescua <iamescua@domain.hid>
In-Reply-To: <4C2DAF63.4040708@domain.hid>
References: <1278061090.2358.33.camel@domain.hid>
	<4C2DAF63.4040708@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 02 Jul 2010 12:24:46 +0200
Message-ID: <1278066286.8669.9.camel@domain.hid>
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

Thanks a lot!

Now at least it boots. This is what I have done (I expect correctly):

IRQ are now handled by=20
#ifndef CONFIG_IPIPE
		set_irq_handler(i, handle_prio_irq);
#else
		set_irq_handler(i, handle_edge_irq);
#endif /*CONFIG_IPIPE*/

And in irqs.h
#define irq_finish(irq) irq_desc[irq].chip->eoi(irq);

Is this correct?

The problem now it locks up during boot. This is the console output:

Uncompressing
Linux....................................................................=
.............. done, booting the kernel.
[    0.000000] Linux version 2.6.28.10 (iames@domain.hid) (gcc version
4.3.2 (GCC) ) #92 Fri Jul 2 12:06:18 CEST 2010
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
[42949373.130000] Memory: 29776KB available (2332K code, 226K data, 104K
init)
[42949373.160000] Calibrating delay loop... 4.99 BogoMIPS (lpj=3D24960)
[42949373.360000] Mount-cache hash table entries: 512
[42949373.420000] CPU: Testing write buffer coherency: ok
[42949373.660000] net_namespace: 288 bytes
[42949373.690000] NET: Registered protocol family 16
[42949376.000000] NET: Registered protocol family 2
[42949376.120000] IP route cache hash table entries: 1024 (order: 0,
4096 bytes)
[42949376.160000] TCP established hash table entries: 1024 (order: 1,
8192 bytes)
[42949376.170000] TCP bind hash table entries: 1024 (order: 0, 4096
bytes)
[42949376.170000] TCP: Hash tables configured (established 1024 bind
1024)
[42949376.180000] TCP reno registered
[42949376.220000] NET: Registered protocol family 1
[42949376.480000] I-pipe: Domain Xenomai registered.
[42949376.490000] Xenomai: hal/arm started.
[42949376.490000] Xenomai: scheduling class idle registered.
[42949376.500000] Xenomai: scheduling class rt registered.
[42949377.740000] Xenomai: real-time nucleus v2.5.3 (Hordes Of Locusts)
loaded.
[42949378.290000] Xenomai: native skin init failed, code -38.
[42949378.290000] Xenomai: starting POSIX services.
[42949378.830000] Xenomai: POSIX skin init failed, code -38.
[42949379.370000] Xenomai: RTDM skin init failed, code -38.
[42949379.550000] JFFS2 version 2.2. (NAND) (SUMMARY)  =C2=A9 2001-2006 R=
ed
Hat, Inc.
[42949379.600000] msgmni has been set to 58
[42949379.610000] io scheduler noop registered (default)
[42949379.740000] adc-ns9215: ADC available on MAJOR 254
[42949379.790000] ns921x-serial.1: ttyNS1 at MMIO 0x90018000 (irq =3D 8)
is a NS921X
[42949379.840000] ns921x-serial.2: ttyNS2 at MMIO 0x90020000 (irq =3D 9)
is a NS921X
[42949379.880000] ns921x-serial.3: ttyNS3 at MMIO 0x90028000 (irq =3D 10)
is a NS921X
[42949379.890000] console [ttyNS3] enabled
[42949379.970000] Digi NS921x UART driver
[42949381.330000] brd: module loaded
[42949381.450000] ns9xxx-eth-mii: probed
[42949381.550000] ns9xxx-eth ns9xxx-eth: eth0 at MMIO c2928000
[42949381.590000] Digi NS9XXX Ethernet driver
[42949381.660000] physmap platform flash device: 10000000 at 50000000
[42949382.010000] physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit
bank
[42949382.060000]  Amd/Fujitsu Extended Query Table at 0x0040
[42949382.070000] physmap-flash.0: CFI does not contain boot bank
location. Assuming top.
[42949382.080000] number of CFI chips: 1
[42949382.090000] cfi_cmdset_0002: Disabling erase-suspend-program due
to code brokenness.
[42949382.110000] 4 cmdlinepart partitions found on MTD device
physmap-flash.0
[42949382.120000] Creating 4 MTD partitions on "physmap-flash.0":
[42949382.140000] 0x00000000-0x00040000 : "U-Boot"
[42949382.320000] 0x00040000-0x00080000 : "NVRAM"
[42949382.470000] 0x00080000-0x00200000 : "Kernel"
[42949382.610000] 0x00200000-0x01000000 : "RootFS-JFFS2"
[42949382.810000] spi_ns921x spi_ns921x.1: NS921x SPI controller at
0xc2960000 (irq: 11)
[42949382.900000] TCP cubic registered
[42949382.910000] NET: Registered protocol family 17
[42949382.970000] RPC: Registered udp transport module.
[42949382.980000] RPC: Registered tcp transport module.
[42949383.330000] IP-Config: Complete:
[42949383.340000]      device=3Deth0, addr=3D192.168.1.55,
mask=3D255.255.255.0, gw=3D192.168.1.1,
[42949383.380000]      host=3Dcc9p9215js, domain=3D, nis-domain=3D(none),
[42949383.400000]      bootserver=3D192.168.1.21, rootserver=3D192.168.1.=
21,
rootpath=3D
[42949383.480000] Looking up port of RPC 100003/2 on 192.168.1.21

[42949383.510000] net eth0: link up (100/full)

With wireshark I don't see any NFS packet and there is no ping response.

What are these errors?
[42949376.490000] Xenomai: hal/arm started.
[42949376.490000] Xenomai: scheduling class idle registered.
[42949376.500000] Xenomai: scheduling class rt registered.
[42949377.740000] Xenomai: real-time nucleus v2.5.3 (Hordes Of Locusts)
loaded.
[42949378.290000] Xenomai: native skin init failed, code -38.
[42949378.290000] Xenomai: starting POSIX services.
[42949378.830000] Xenomai: POSIX skin init failed, code -38.
[42949379.370000] Xenomai: RTDM skin init failed, code -38.

Thanks

--=20
Iker Amescua

FENSOM SYSTEM S.L.

iamescua@domain.hid

http://www.fensomsystem.com

Ingenier=C3=ADa de sistemas electr=C3=B3nicos
Ciclo de vida de producto electr=C3=B3nico
Sistemas dedicados, hardware y software
Tfno.  845 05 01 69


El vie, 02-07-2010 a las 11:20 +0200, Gilles Chanteperdrix escribi=C3=B3:
> Iker Amescua wrote:
> > Hello
> >=20
> > I am trying to port adeos i-pipe patch to run xenomai in an unsupport=
ed
> > arch, NS9215 from Digi. I have followed instructions from
> > http://www.xenomai.org/index.php/I-pipe:ArmPorting and looked at
> > currently supported ports (mach-imx) but I am stuck witch the followi=
ng
> > error during boot
> >=20
> >=20
> > [42949375.440000] ->handle_irq():  c002c39c, handle_prio_irq+0x0/0xec
> > [42949375.440000] ->chip(): c026e104, 0xc026e104
> > [42949375.440000] ->action(): c026e24c
> > [42949375.440000] ->action->handler(): c002c7a0,
> > ns921x_clockevent_handler+0x0/0x68
> > [42949375.440000]    IRQ_NOPROBE set
> > [42949375.440000] irq 19, desc: c02712a4, depth: 0, count: 248,
> > unhandled: 0
> > [42949375.450000] irq 19, desc: c02712a4, depth: 0, count: 249,
> > unhandled: 0
> > [42949375.450000] ->handle_irq():  c002c39c, handle_prio_irq+0x0/0xec
> > [42949375.450000] ->chip(): c026e104, 0xc026e104
> > [42949375.450000] ->action(): c026e24c
> > [42949375.450000] ->action->handler(): c002c7a0,
> > ns921x_clockevent_handler+0x0/0x68
> > [42949375.450000]    IRQ_NOPROBE set
> > [42949375.460000] ->handle_irq():  c002c39c, handle_prio_irq+0x0/0xec
> > [42949375.460000] ->chip(): c026e104, 0xc026e104
> >=20
> > [42949375.460000] ->action(): c026e24c
> > [42949375.460000] ->action->handler(): c002c7a0,
> > ns921x_clockevent_handler+0x0/0x68
> > [42949375.460000]    IRQ_NOPROBE set
> > [42949375.460000] irq 19, desc: c02712a4, depth: 0, count: 250,
> > unhandled: 0
> >=20
> > These messages repeat endlessly.
> >=20
> > The board kernel 2.6.28.10 customized by Digi for adding support to
> > their ns92xx processors. The configuration is done using
> > CONFIG_GENERIC_TIME and CONFIG_GENERIC_CLOCKEVENTS. IRQ 19 is the
> > clockevent_device's irq.
> >=20
> > My clock event handler function is
> >=20
> > static irqreturn_t ns921x_clockevent_handler(int irq, void *dev_id)
> > {
> > 	struct clock_event_device *evt =3D &ns921x_clockevent_device;
> > #ifndef CONFIG_IPIPE
> > 	int timerno =3D irq - IRQ_NS921X_TIMER0;
> > 	u32 tc;
> >=20
> > 	/* clear irq */
> > 	tc =3D __raw_readl(SYS_TC(timerno));
> > 	if (REGGET(tc, SYS_TCx, RELENBL) =3D=3D SYS_TCx_RELENBL_DIS) {
> > 		REGSET(tc, SYS_TCx, TE, DIS);
> > 		__raw_writel(tc, SYS_TC(timerno));
> > 	}
> > 	REGSETIM(tc, SYS_TCx, INTCLR, 1);
> > 	__raw_writel(tc, SYS_TC(timerno));
> > 	REGSETIM(tc, SYS_TCx, INTCLR, 0);
> > 	__raw_writel(tc, SYS_TC(timerno));
> >=20
> > #else /* CONFIG_IPIPE */
> > 	ipipe_mach_update_tsc();
> > #endif /* CONFIG_IPIPE */
> > 	evt->event_handler(evt);
> > 	return  IRQ_HANDLED;
> > }
> >=20
> > and
> >=20
> > void __ipipe_mach_acktimer(void)
> > {
> > 	int timerno =3D IRQ_NS921X_TIMER1 - IRQ_NS921X_TIMER0;
> > 	u32 tc;
> > 	tc =3D __raw_readl(SYS_TC(timerno));
> > 	if (REGGET(tc, SYS_TCx, RELENBL) =3D=3D SYS_TCx_RELENBL_DIS) {
> > 		REGSET(tc, SYS_TCx, TE, DIS);
> > 		__raw_writel(tc, SYS_TC(timerno));
> > 	}
> >=20
> > 	REGSETIM(tc, SYS_TCx, INTCLR, 1);
> > 	__raw_writel(tc, SYS_TC(timerno));
> > 	REGSETIM(tc, SYS_TCx, INTCLR, 0);+static int __netdev_printk(const c=
har *level, const struct net_device *dev,
> +			   struct va_format *vaf)
> +{
> +	int r;
> +
> +	if (dev && dev->dev.parent)
> +		r =3D dev_printk(level, dev->dev.parent, "%s: %pV",
> +			       netdev_name(dev), vaf);
> +	else if (dev)
> +		r =3D printk("%s%s: %pV", level, netdev_name(dev), vaf);
> +	else
> +		r =3D printk("%s(NULL net_device): %pV", level, vaf);
> +
> +	return r;
> +}
> +
> +int netdev_printk(const char *level, const struct net_device *dev,
> +		  const char *format, ...)
> +{
> +	struct va_format vaf;
> +	va_list args;
> +	int r;
> +
> +	va_start(args, format);
> +
> +	vaf.fmt =3D format;
> +	vaf.va =3D &args;
> +
> +	r =3D __netdev_printk(level, dev, &vaf);
> +	va_end(args);
> +
> +	return r;
> +}
>=20
> > 	__raw_writel(tc, SYS_TC(timerno));
> > }
> >=20
> > Using printk I see both functions (first ns921x_clockevent_handler an=
d
> > then __ipipe_mach_acktimer) are called
> >=20
> > handle_prio_irq is a Digi's custom irq handler used in all interrupts
> > set_irq_handler(i, handle_prio_irq);
> >=20
> > /* this is similar to handle_fasteoi_irq.  The differences are:
> >  *  - handle_prio_irq calls desc->chip->ack at the beginning;
> >  *  - handle_prio_irq disables an irq directly after handle_IRQ_event=
 to
> > work
> >  *    around the bug in the ns9xxx' irq priority encoder;
> >  *  - currently some debug code;
> >  */
> > static void handle_prio_irq(unsigned int irq, struct irq_desc *desc)
> > {
> > 	unsigned int cpu =3D smp_processor_id();
> > 	struct irqaction *action;
> > 	irqreturn_t action_ret;
> >=20
> > 	spin_lock(&desc->lock);
> >=20
> > 	desc->chip->ack(irq);
> >=20
> > 	if (unlikely(desc->status & IRQ_INPROGRESS)) {
> > 		desc->status |=3D IRQ_PENDING;
> > 		goto out_unlock;
> > 	}
> >=20
> > 	desc->status &=3D ~(IRQ_REPLAY | IRQ_WAITING);
> > 	kstat_cpu(cpu).irqs[irq]++;
> >=20
> > 	action =3D desc->action;
> > 	if (unlikely(!action || (desc->status & IRQ_DISABLED))) {
> > 		desc->status |=3D IRQ_PENDING;
> > 		goto out_mask;
> > 	}
> >=20
> > 	desc->status |=3D IRQ_INPROGRESS;
> > 	desc->status &=3D ~IRQ_PENDING;
> > 	spin_unlock(&desc->lock);
> >=20
> > 	action_ret =3D handle_IRQ_event(irq, action);
> > 	if (!noirqdebug)
> > 		note_interrupt(irq, desc, action_ret);
> >=20
> > 	spin_lock(&desc->lock);
> > 	desc->status &=3D ~IRQ_INPROGRESS;
> >=20
> > 	if (desc->status & IRQ_DISABLED)
> > out_mask:
> > 		desc->chip->mask(irq);
> >=20
> > 	desc->chip->eoi(irq);
> >=20
> > out_unlock:
> > 	spin_unlock(&desc->lock);
> > }=20
> >=20
> > Adeos i-pipe patch used: adeos-ipipe-2.6.28.10-arm-1.12-07.patch
> >=20
> > Any ideas what is wrong?
>=20
> This is hard to say, the full code, and the config you use would help
> more. However, the I-pipe patch does a few operations to get the kernel
> irq handlers working with it. Obviously, by using handle_prio_irq, you
> completely avoid these operations, this could explain why your system
> does not work. Now looking at its code, I see that it calls eoi at the
> end of the handler. This is wrong, because it will cause interrupts
> handlers running in the linux domain to block interrupts of lower
> priority running in xenomai domain. If all interrupts in your system
> uses this handler, it is better to define the "irq_finish" macro to cal=
l
> the eoi, use handle_edge_irq and drop this custom irq handler. The
> system will work with no further.
>=20
> Otherwise, you will have to patch the kernel more heavily to get the
> handler working (starting by calling the eoi callback in the ack
> callback, otherwise, your kernel will be wrong with regard to determini=
sm).
>=20
> Besides, the timer irq handler does not go trough the kernel handlers,
> it is handled directly by the I-pipe, so moving the eoi in the ack
> callback or use the irq_finish macro is mandatory to get the timer irq
> properly eoied.
>=20


