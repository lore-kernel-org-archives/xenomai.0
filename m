MIME-Version: 1.0
In-Reply-To: <4B4750E1.20703@domain.hid>
References: <725957.56219.qm@domain.hid>
	<4B446D99.708@domain.hid>
	<4303dd241001060338w7876debaxa9e290b89d79a143@domain.hid>
	<4B4497BE.7040605@domain.hid>
	<4303dd241001061116q40315012v3b0459c3b245efa@domain.hid>
	<4B44E349.1000305@domain.hid>
	<4303dd241001080611t6ab0dafch785bcf967572e69a@domain.hid>
	<4B4742B7.5010306@domain.hid>
	<4303dd241001080658q224a43feqafa77aedd694b41c@domain.hid>
	<4B4750E1.20703@domain.hid>
Date: Fri, 8 Jan 2010 15:43:05 -0200
Message-ID: <4303dd241001080943v2d279019s1164a5b2aa34790a@domain.hid>
From: Flavio de Castro Alves Filho <flavio.alves@domain.hid>
Content-Type: multipart/alternative; boundary=0003255550ce594062047caab8a3
Subject: Re: [Xenomai-help] Porting I-Pipe for new ARM board
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

--0003255550ce594062047caab8a3
Content-Type: text/plain; charset=ISO-8859-1

Hello,

The functions level_egde_irq and __ipipe_ack_edge_irq are not called during
boot process.

I'm sending attached the boot log with my traces separated

irq = 21
__ipipe_mach_irq_mux_p false

Linux version 2.6.29-rc8-davinci1 (flavio@domain.hid) (gcc version 4.3.3
(Sourcery G++ Lite 2009q1-203) ) #57 PREEMPT Fri Jan 8 13:58:39 BRST 2010
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
CPU: VIVT data cache, VIVT instruction cache
Machine: DaVinci DA850 EVM
Memory policy: ECC disabled, Data cache writeback
DA0850 variant 0x0
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8128
Kernel command line: mem=32M console=ttyS2,115200n8 root=/dev/ram0 rw
initrd=0xc1180000,4M ip=10.1.1.2:10.1.1.1
PID hash table entries: 128 (order: 7, 512 bytes)
I-pipe 1.13-03: pipeline enabled.
Console: colour dummy device 80x30
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 32MB = 32MB total
Memory: 24236KB available (3592K code, 367K data, 148K init)
Calibrating delay loop... 86.63 BogoMIPS (lpj=433152)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
net_namespace: 880 bytes
NET: Registered protocol family 16
Pin I2C1_SCL already used for UART2_RXD.
Pin I2C1_SDA already used for UART2_TXD.
DaVinci: 144 gpio irqs
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
musb_hdrc: version 6.0, cppi4.1-dma, host, debug=0
Waiting for PHY clock good...
musb_hdrc: USB Host mode controller at fee00000 using DMA, IRQ 58
musb_hdrc musb_hdrc: MUSB HDRC host driver
musb_hdrc musb_hdrc: new USB bus registered, assigned bus number 1
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP reno registered
NET: Registered protocol family 1
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
Freeing initrd memory: 4096K
I-pipe: Domain Xenomai registered.
Xenomai: hal/arm started.
Xenomai: real-time nucleus v2.4.9.1 (Big Bad Moon) loaded.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
msgmni has been set to 55
io scheduler noop registered
io scheduler anticipatory registered (default)
Serial: 8250/16550 driver, 3 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0x1c42000 (irq = 25) is a 16550A
serial8250.0: ttyS1 at MMIO 0x1d0c000 (irq = 53) is a 16550A
serial8250.0: ttyS2 at MMIO 0x1d0d000 (irq = 61) is a 16550A
console [ttyS2] enabled
brd: module loaded
davinci_emac_probe: using random MAC addr: fe:1e:01:fe:ce:b4
emac-mii: probed
dm9000 Ethernet Driver, V1.31
console [netcon0] enabled
netconsole: network logging started
Linux video capture interface: v2.00
Driver 'sd' needs updating - please use bus_type methods
davinci_nand davinci_nand.1: Using 4-bit hardware ECC - Syndrome
No NAND device found!!!

irq = 12
__ipipe_mach_irq_mux_p false
dma_ccerr_handler
IRQ_HANDLED
irq = 12
__ipipe_mach_irq_mux_p false
dma_ccerr_handler
IRQ_HANDLED

m25p80 spi1.0: m25p64 (8192 Kbytes)
Creating 3 MTD partitions on "m25p80":
0x000000000000-0x000000040000 : "U-Boot"
0x000000040000-0x000000044000 : "U-Boot Environment"
Moving partition 2: 0x000000044000 -> 0x000000050000
0x000000050000-0x000000800000 : "Linux"
dm_spi.1: davinci SPI Controller driver at 0xfef0e000 (irq = 56) use_dma=1
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
usb1 usb1: DA8XX OHCI
usb1 usb1: new USB bus registered, assigned bus number 2
usb1 usb1: irq 59, io mem 0x01e25000

<some time later ... a couple of minutes>

irq = 22
__ipipe_mach_irq_mux_p false
irq = 22
__ipipe_mach_irq_mux_p false


Best regards,

Flavio

Flavio de Castro Alves Filho
Phi Innovations - Embedded Software Services
www.phiinnovations.com
Phone: +55 11 84 94 56 76
Skype: flavio.de.castro.alves.filho


2010/1/8 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Flavio de Castro Alves Filho wrote:
> > In fact,
> >
> > The problem is not really related to the other timer, I believe.
> >
> > Before the timer with irq 22 is called, another irq is called by
> > __ipipe_grab_irq(): the irq number 12 (IRQ_DA8XX_CCERRINT).
> >
> > Now I'm looking for the place there this irq number is passed.
> >
> > And thank you for this important information about the timers.
>
> I think your problem really is that irq22 uses handle_edge_irq, somehow.
> Could you check whether this is the case, for instance by putting a
> printk in the __ipipe_ack_edge_irq function, file kernel/irq/chip.c ?
>
> --
>                                             Gilles.
>

--0003255550ce594062047caab8a3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>The functions level_egde_irq and __ipipe_ack_edge_irq are not=
 called during boot process.<br><br>I&#39;m sending attached the boot log w=
ith my traces separated<br><br>irq =3D 21<br>__ipipe_mach_irq_mux_p false<b=
r>
<br>Linux version 2.6.29-rc8-davinci1 (flavio@domain.hid) (gcc version 4=
.3.3 (Sourcery G++ Lite 2009q1-203) ) #57 PREEMPT Fri Jan 8 13:58:39 BRST 2=
010<br>

CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=3D00053177<br>CPU: VIV=
T data cache, VIVT instruction cache<br>Machine: DaVinci DA850 EVM<br>Memor=
y policy: ECC disabled, Data cache writeback<br>DA0850 variant 0x0<br>Built=
 1 zonelists in Zone order, mobility grouping on.=A0 Total pages: 8128<br>


Kernel command line: mem=3D32M console=3DttyS2,115200n8 root=3D/dev/ram0 rw=
 initrd=3D0xc1180000,4M ip=3D10.1.1.2:10.1.1.1<br>PID hash table entries: 1=
28 (order: 7, 512 bytes)<br>I-pipe 1.13-03: pipeline enabled.<br>Console: c=
olour dummy device 80x30<br>


Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)<br>Inode-cach=
e hash table entries: 2048 (order: 1, 8192 bytes)<br>Memory: 32MB =3D 32MB =
total<br>Memory: 24236KB available (3592K code, 367K data, 148K init)<br>


Calibrating delay loop... 86.63 BogoMIPS (lpj=3D433152)<br>Mount-cache hash=
 table entries: 512<br>CPU: Testing write buffer coherency: ok<br>net_names=
pace: 880 bytes<br>NET: Registered protocol family 16<br>Pin I2C1_SCL alrea=
dy used for UART2_RXD.<br>


Pin I2C1_SDA already used for UART2_TXD.<br>DaVinci: 144 gpio irqs<br>bio: =
create slab &lt;bio-0&gt; at 0<br>SCSI subsystem initialized<br>usbcore: re=
gistered new interface driver usbfs<br>usbcore: registered new interface dr=
iver hub<br>


usbcore: registered new device driver usb<br>musb_hdrc: version 6.0, cppi4.=
1-dma, host, debug=3D0<br>Waiting for PHY clock good...<br>musb_hdrc: USB H=
ost mode controller at fee00000 using DMA, IRQ 58<br>musb_hdrc musb_hdrc: M=
USB HDRC host driver<br>


musb_hdrc musb_hdrc: new USB bus registered, assigned bus number 1<br>usb u=
sb1: configuration #1 chosen from 1 choice<br>hub 1-0:1.0: USB hub found<br=
>hub 1-0:1.0: 1 port detected<br>NET: Registered protocol family 2<br>

IP route cache hash table entries: 1024 (order: 0, 4096 bytes)<br>
TCP established hash table entries: 1024 (order: 1, 8192 bytes)<br>TCP bind=
 hash table entries: 1024 (order: 0, 4096 bytes)<br>TCP: Hash tables config=
ured (established 1024 bind 1024)<br>TCP reno registered<br>NET: Registered=
 protocol family 1<br>


checking if image is initramfs...it isn&#39;t (no cpio magic); looks like a=
n initrd<br>Freeing initrd memory: 4096K<br>I-pipe: Domain Xenomai register=
ed.<br>Xenomai: hal/arm started.<br>Xenomai: real-time nucleus v2.4.9.1 (Bi=
g Bad Moon) loaded.<br>


Xenomai: starting native API services.<br>Xenomai: starting POSIX services.=
<br>Xenomai: starting RTDM services.<br>msgmni has been set to 55<br>io sch=
eduler noop registered<br>io scheduler anticipatory registered (default)<br=
>


Serial: 8250/16550 driver, 3 ports, IRQ sharing disabled<br>serial8250.0: t=
tyS0 at MMIO 0x1c42000 (irq =3D 25) is a 16550A<br>serial8250.0: ttyS1 at M=
MIO 0x1d0c000 (irq =3D 53) is a 16550A<br>serial8250.0: ttyS2 at MMIO 0x1d0=
d000 (irq =3D 61) is a 16550A<br>


console [ttyS2] enabled<br>brd: module loaded<br>davinci_emac_probe: using =
random MAC addr: fe:1e:01:fe:ce:b4<br>emac-mii: probed<br>dm9000 Ethernet D=
river, V1.31<br>console [netcon0] enabled<br>netconsole: network logging st=
arted<br>


Linux video capture interface: v2.00<br>Driver &#39;sd&#39; needs updating =
- please use bus_type methods<br>davinci_nand davinci_nand.1: Using 4-bit h=
ardware ECC - Syndrome<br>No NAND device found!!!<br><br>irq =3D 12<br>__ip=
ipe_mach_irq_mux_p false<br>


dma_ccerr_handler<br>IRQ_HANDLED<br>irq =3D 12<br>__ipipe_mach_irq_mux_p fa=
lse<br>dma_ccerr_handler<br>IRQ_HANDLED<br><br>m25p80 spi1.0: m25p64 (8192 =
Kbytes)<br>Creating 3 MTD partitions on &quot;m25p80&quot;:<br>0x0000000000=
00-0x000000040000 : &quot;U-Boot&quot;<br>


0x000000040000-0x000000044000 : &quot;U-Boot Environment&quot;<br>Moving pa=
rtition 2: 0x000000044000 -&gt; 0x000000050000<br>0x000000050000-0x00000080=
0000 : &quot;Linux&quot;<br>dm_spi.1: davinci SPI Controller driver at 0xfe=
f0e000 (irq =3D 56) use_dma=3D1<br>


ohci_hcd: USB 1.1 &#39;Open&#39; Host Controller (OHCI) Driver<br>usb1 usb1=
: DA8XX OHCI<br>usb1 usb1: new USB bus registered, assigned bus number 2<br=
>usb1 usb1: irq 59, io mem 0x01e25000<br><br>&lt;some time later ... a coup=
le of minutes&gt;<br>


<br>irq =3D 22<br>__ipipe_mach_irq_mux_p false<br>irq =3D 22<br>__ipipe_mac=
h_irq_mux_p false<br><br><br>Best regards,<br><br>Flavio<br><br clear=3D"al=
l">Flavio de Castro Alves Filho<br>Phi Innovations - Embedded Software Serv=
ices<br>
<a href=3D"http://www.phiinnovations.com" target=3D"_blank">www.phiinnovati=
ons.com</a><br>
Phone: +55 11 84 94 56 76<br>Skype: flavio.de.castro.alves.filho<br>

<br><br><div class=3D"gmail_quote">2010/1/8 Gilles Chanteperdrix <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org" target=3D"=
_blank">gilles.chanteperdrix@xenomai.org</a>&gt;</span><br><blockquote clas=
s=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margi=
n: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">


<div>Flavio de Castro Alves Filho wrote:<br>
</div><div>&gt; In fact,<br>
&gt;<br>
&gt; The problem is not really related to the other timer, I believe.<br>
&gt;<br>
&gt; Before the timer with irq 22 is called, another irq is called by<br>
&gt; __ipipe_grab_irq(): the irq number 12 (IRQ_DA8XX_CCERRINT).<br>
&gt;<br>
&gt; Now I&#39;m looking for the place there this irq number is passed.<br>
&gt;<br>
&gt; And thank you for this important information about the timers.<br>
<br>
</div>I think your problem really is that irq22 uses handle_edge_irq, someh=
ow.<br>
Could you check whether this is the case, for instance by putting a<br>
printk in the __ipipe_ack_edge_irq function, file kernel/irq/chip.c ?<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br>

--0003255550ce594062047caab8a3--

