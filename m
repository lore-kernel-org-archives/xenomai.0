MIME-Version: 1.0
In-Reply-To: <4B4497BE.7040605@domain.hid>
References: <725957.56219.qm@domain.hid>
	<1f3e02580912151715n1f587e87x48834799baf7eea7@domain.hid>
	<4303dd240912310452m6db83032rb42d13777efbf5a3@domain.hid>
	<4B3CC62D.6070709@domain.hid>
	<1262643246.20365.10.camel@domain.hid>
	<4B426A3D.5020706@domain.hid> <1262775394.7828.9.camel@domain.hid>
	<4B446D99.708@domain.hid>
	<4303dd241001060338w7876debaxa9e290b89d79a143@domain.hid>
	<4B4497BE.7040605@domain.hid>
Date: Wed, 6 Jan 2010 17:16:39 -0200
Message-ID: <4303dd241001061116q40315012v3b0459c3b245efa@domain.hid>
From: Flavio de Castro Alves Filho <flavio.alves@domain.hid>
Content-Type: multipart/alternative; boundary=00032555fdbe49ab99047c83cb0f
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--00032555fdbe49ab99047c83cb0f
Content-Type: text/plain; charset=ISO-8859-1

I believe there is a lockup during the irq handling process.

I could not find where it is blocking.

I performed the following tests:

1) add traces in every function related to interrupt ... and none was called

2) add traces in every function in time.c file. After the last message
("ata1: SATA max UDMA/133 irq 67"), the following functions were called:
- read_cycles()
- timer32_read()

Looking at these functions, they seam to be fine. I have no clue about where
to start debugging.

Thank you for all your help.

Regards,

Flavio

Flavio de Castro Alves Filho
Phi Innovations - Embedded Software Services
www.phiinnovations.com
Phone: +55 11 84 94 56 76
Skype: flavio.de.castro.alves.filho



2010/1/6 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> Flavio de Castro Alves Filho wrote:
>> Hello Gilles,
>>
>> The boot log is the following (I hope this time it works).
>>
>> Starting kernel ...
>>
>> Uncompressing
Linux.............................................................
>> Linux version 2.6.29-rc8-davinci1 (flavio@domain.hid) (gcc version
4.3.3 (So0
>> CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
>> CPU: VIVT data cache, VIVT instruction cache
>> Machine: DaVinci DA850 EVM
>> Memory policy: ECC disabled, Data cache writeback
>> DA0850 variant 0x0
>> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8128
>> Kernel command line: mem=32M console=ttyS2,115200n8 root=/dev/ram0 rw
initrd=0x1
>> PID hash table entries: 128 (order: 7, 512 bytes)
>> I-pipe 1.13-03: pipeline enabled.
>> Console: colour dummy device 80x30
>> Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
>> Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
>> Memory: 32MB = 32MB total
>> Memory: 24248KB available (3580K code, 368K data, 148K init)
>> Calibrating delay loop... 149.09 BogoMIPS (lpj=745472)
>> Mount-cache hash table entries: 512
>> CPU: Testing write buffer coherency: ok
>> net_namespace: 880 bytes
>> NET: Registered protocol family 16
>> Pin I2C1_SCL already used for UART2_RXD.
>> Pin I2C1_SDA already used for UART2_TXD.
>> DaVinci: 144 gpio irqs
>> bio: create slab <bio-0> at 0
>> SCSI subsystem initialized
>> usbcore: registered new interface driver usbfs
>> usbcore: registered new interface driver hub
>> usbcore: registered new device driver usb
>> musb_hdrc: version 6.0, cppi4.1-dma, host, debug=0
>> Waiting for PHY clock good...
>> musb_hdrc: USB Host mode controller at fee00000 using DMA, IRQ 58
>> musb_hdrc musb_hdrc: MUSB HDRC host driver
>> musb_hdrc musb_hdrc: new USB bus registered, assigned bus number 1
>> usb usb1: configuration #1 chosen from 1 choice
>> hub 1-0:1.0: USB hub found
>> hub 1-0:1.0: 1 port detected
>> NET: Registered protocol family 2
>> IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
>> TCP established hash table entries: 1024 (order: 1, 8192 bytes)
>> TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
>> TCP: Hash tables configured (established 1024 bind 1024)
>> TCP reno registered
>> NET: Registered protocol family 1
>> checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
>> Freeing initrd memory: 4096K
>> I-pipe: Domain Xenomai registered.
>> Xenomai: hal/arm started.
>> Xenomai: real-time nucleus v2.4.9.1 (Big Bad Moon) loaded.
>> Xenomai: starting native API services.
>> Xenomai: starting POSIX services.
>> Xenomai: starting RTDM services.
>> msgmni has been set to 55
>> io scheduler noop registered
>> io scheduler anticipatory registered (default)
>> Serial: 8250/16550 driver, 3 ports, IRQ sharing disabled
>> serial8250.0: ttyS0 at MMIO 0x1c42000 (irq = 25) is a 16550A
>> serial8250.0: ttyS1 at MMIO 0x1d0c000 (irq = 53) is a 16550A
>> serial8250.0: ttyS2 at MMIO 0x1d0d000 (irq = 61) is a 16550A
>> console [ttyS2] enabled
>> brd: module loaded
>> davinci_emac_probe: using random MAC addr: 6a:c9:27:5d:9b:5c
>> emac-mii: probed
>> dm9000 Ethernet Driver, V1.31
>> console [netcon0] enabled
>> netconsole: network logging started
>> Linux video capture interface: v2.00
>> Driver 'sd' needs updating - please use bus_type methods
>> ahci ahci: forcing PORTS_IMPL to 0x1
>> ahci ahci: AHCI 0001.0100 32 slots 1 ports 3 Gbps 0x1 impl SATA mode
>> ahci ahci: flags: ncq sntf pm led clo only pmp pio slum part
>> scsi0 : ahci
>> ata1: SATA max UDMA/133 irq 67
>>
>> Thank you and best regards,
>
> Well your log does not show any error. If there is a lockup, bisect to
> find where it happens.
>
> --
>                                            Gilles.
>

--00032555fdbe49ab99047c83cb0f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I believe there is a lockup during the irq handling process.<br><br>I could=
 not find where it is blocking.<br><br>I performed the following tests:<br>=
<br>1) add traces in every function related to interrupt ... and none was c=
alled<br>
<br>2) add traces in every function in time.c file. After the last message =
(&quot;ata1: SATA max UDMA/133 irq 67&quot;), the following functions were =
called:<br>- read_cycles()<br>- timer32_read()<br><br>Looking at these func=
tions, they seam to be fine. I have no clue about where to start debugging.=
<br>
<br>Thank you for all your help.<br><br>Regards,<br><br>Flavio<br><br>Flavi=
o de Castro Alves Filho<br>Phi Innovations - Embedded Software Services<br>=
<a href=3D"http://www.phiinnovations.com">www.phiinnovations.com</a><br>Pho=
ne: +55 11 84 94 56 76<br>
Skype: flavio.de.castro.alves.filho<br><br><br><br>2010/1/6 Gilles Chantepe=
rdrix &lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chante=
perdrix@domain.hid</a>&gt;:<br>&gt; Flavio de Castro Alves Filho wrote:<br=
>
&gt;&gt; Hello Gilles,<br>&gt;&gt;<br>&gt;&gt; The boot log is the followin=
g (I hope this time it works).<br>&gt;&gt;<br>&gt;&gt; Starting kernel ...<=
br>&gt;&gt;<br>&gt;&gt; Uncompressing Linux................................=
.............................<br>
&gt;&gt; Linux version 2.6.29-rc8-davinci1 (flavio@domain.hid) (gcc vers=
ion 4.3.3 (So0<br>&gt;&gt; CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ)=
, cr=3D00053177<br>&gt;&gt; CPU: VIVT data cache, VIVT instruction cache<br=
>
&gt;&gt; Machine: DaVinci DA850 EVM<br>&gt;&gt; Memory policy: ECC disabled=
, Data cache writeback<br>&gt;&gt; DA0850 variant 0x0<br>&gt;&gt; Built 1 z=
onelists in Zone order, mobility grouping on. =A0Total pages: 8128<br>&gt;&=
gt; Kernel command line: mem=3D32M console=3DttyS2,115200n8 root=3D/dev/ram=
0 rw initrd=3D0x1<br>
&gt;&gt; PID hash table entries: 128 (order: 7, 512 bytes)<br>&gt;&gt; I-pi=
pe 1.13-03: pipeline enabled.<br>&gt;&gt; Console: colour dummy device 80x3=
0<br>&gt;&gt; Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)=
<br>
&gt;&gt; Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)<br>&gt=
;&gt; Memory: 32MB =3D 32MB total<br>&gt;&gt; Memory: 24248KB available (35=
80K code, 368K data, 148K init)<br>&gt;&gt; Calibrating delay loop... 149.0=
9 BogoMIPS (lpj=3D745472)<br>
&gt;&gt; Mount-cache hash table entries: 512<br>&gt;&gt; CPU: Testing write=
 buffer coherency: ok<br>&gt;&gt; net_namespace: 880 bytes<br>&gt;&gt; NET:=
 Registered protocol family 16<br>&gt;&gt; Pin I2C1_SCL already used for UA=
RT2_RXD.<br>
&gt;&gt; Pin I2C1_SDA already used for UART2_TXD.<br>&gt;&gt; DaVinci: 144 =
gpio irqs<br>&gt;&gt; bio: create slab &lt;bio-0&gt; at 0<br>&gt;&gt; SCSI =
subsystem initialized<br>&gt;&gt; usbcore: registered new interface driver =
usbfs<br>
&gt;&gt; usbcore: registered new interface driver hub<br>&gt;&gt; usbcore: =
registered new device driver usb<br>&gt;&gt; musb_hdrc: version 6.0, cppi4.=
1-dma, host, debug=3D0<br>&gt;&gt; Waiting for PHY clock good...<br>&gt;&gt=
; musb_hdrc: USB Host mode controller at fee00000 using DMA, IRQ 58<br>
&gt;&gt; musb_hdrc musb_hdrc: MUSB HDRC host driver<br>&gt;&gt; musb_hdrc m=
usb_hdrc: new USB bus registered, assigned bus number 1<br>&gt;&gt; usb usb=
1: configuration #1 chosen from 1 choice<br>&gt;&gt; hub 1-0:1.0: USB hub f=
ound<br>
&gt;&gt; hub 1-0:1.0: 1 port detected<br>&gt;&gt; NET: Registered protocol =
family 2<br>&gt;&gt; IP route cache hash table entries: 1024 (order: 0, 409=
6 bytes)<br>&gt;&gt; TCP established hash table entries: 1024 (order: 1, 81=
92 bytes)<br>
&gt;&gt; TCP bind hash table entries: 1024 (order: 0, 4096 bytes)<br>&gt;&g=
t; TCP: Hash tables configured (established 1024 bind 1024)<br>&gt;&gt; TCP=
 reno registered<br>&gt;&gt; NET: Registered protocol family 1<br>&gt;&gt; =
checking if image is initramfs...it isn&#39;t (no cpio magic); looks like a=
n initrd<br>
&gt;&gt; Freeing initrd memory: 4096K<br>&gt;&gt; I-pipe: Domain Xenomai re=
gistered.<br>&gt;&gt; Xenomai: hal/arm started.<br>&gt;&gt; Xenomai: real-t=
ime nucleus v2.4.9.1 (Big Bad Moon) loaded.<br>&gt;&gt; Xenomai: starting n=
ative API services.<br>
&gt;&gt; Xenomai: starting POSIX services.<br>&gt;&gt; Xenomai: starting RT=
DM services.<br>&gt;&gt; msgmni has been set to 55<br>&gt;&gt; io scheduler=
 noop registered<br>&gt;&gt; io scheduler anticipatory registered (default)=
<br>
&gt;&gt; Serial: 8250/16550 driver, 3 ports, IRQ sharing disabled<br>&gt;&g=
t; serial8250.0: ttyS0 at MMIO 0x1c42000 (irq =3D 25) is a 16550A<br>&gt;&g=
t; serial8250.0: ttyS1 at MMIO 0x1d0c000 (irq =3D 53) is a 16550A<br>&gt;&g=
t; serial8250.0: ttyS2 at MMIO 0x1d0d000 (irq =3D 61) is a 16550A<br>
&gt;&gt; console [ttyS2] enabled<br>&gt;&gt; brd: module loaded<br>&gt;&gt;=
 davinci_emac_probe: using random MAC addr: 6a:c9:27:5d:9b:5c<br>&gt;&gt; e=
mac-mii: probed<br>&gt;&gt; dm9000 Ethernet Driver, V1.31<br>&gt;&gt; conso=
le [netcon0] enabled<br>
&gt;&gt; netconsole: network logging started<br>&gt;&gt; Linux video captur=
e interface: v2.00<br>&gt;&gt; Driver &#39;sd&#39; needs updating - please =
use bus_type methods<br>&gt;&gt; ahci ahci: forcing PORTS_IMPL to 0x1<br>
&gt;&gt; ahci ahci: AHCI 0001.0100 32 slots 1 ports 3 Gbps 0x1 impl SATA mo=
de<br>&gt;&gt; ahci ahci: flags: ncq sntf pm led clo only pmp pio slum part=
<br>&gt;&gt; scsi0 : ahci<br>&gt;&gt; ata1: SATA max UDMA/133 irq 67<br>
&gt;&gt;<br>&gt;&gt; Thank you and best regards,<br>&gt;<br>&gt; Well your =
log does not show any error. If there is a lockup, bisect to<br>&gt; find w=
here it happens.<br>&gt;<br>&gt; --<br>&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
&gt;<br><br>

--00032555fdbe49ab99047c83cb0f--

