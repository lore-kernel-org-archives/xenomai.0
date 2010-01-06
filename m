MIME-Version: 1.0
In-Reply-To: <4B446D99.708@domain.hid>
References: <725957.56219.qm@domain.hid>
	<1f3e02580911060139q60bc91f8k4e71d933a50895ba@domain.hid>
	<20091215213210.19d5b6a5@domain.hid>
	<1f3e02580912151715n1f587e87x48834799baf7eea7@domain.hid>
	<4303dd240912310452m6db83032rb42d13777efbf5a3@domain.hid>
	<4B3CC62D.6070709@domain.hid>
	<1262643246.20365.10.camel@domain.hid>
	<4B426A3D.5020706@domain.hid> <1262775394.7828.9.camel@domain.hid>
	<4B446D99.708@domain.hid>
Date: Wed, 6 Jan 2010 09:38:09 -0200
Message-ID: <4303dd241001060338w7876debaxa9e290b89d79a143@domain.hid>
From: Flavio de Castro Alves Filho <flavio.alves@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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

Hello Gilles,

The boot log is the following (I hope this time it works).

Starting kernel ...

Uncompressing Linux........................................................=
.....
Linux version 2.6.29-rc8-davinci1 (flavio@domain.hid) (gcc version 4.3.3=
 (So0
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=3D00053177
CPU: VIVT data cache, VIVT instruction cache
Machine: DaVinci DA850 EVM
Memory policy: ECC disabled, Data cache writeback
DA0850 variant 0x0
Built 1 zonelists in Zone order, mobility grouping on.=A0 Total pages: 8128
Kernel command line: mem=3D32M console=3DttyS2,115200n8 root=3D/dev/ram0 rw=
 initrd=3D0x1
PID hash table entries: 128 (order: 7, 512 bytes)
I-pipe 1.13-03: pipeline enabled.
Console: colour dummy device 80x30
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 32MB =3D 32MB total
Memory: 24248KB available (3580K code, 368K data, 148K init)
Calibrating delay loop... 149.09 BogoMIPS (lpj=3D745472)
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
musb_hdrc: version 6.0, cppi4.1-dma, host, debug=3D0
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
checking if image is initramfs...it isn't (no cpio magic); looks like an in=
itrd
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
serial8250.0: ttyS0 at MMIO 0x1c42000 (irq =3D 25) is a 16550A
serial8250.0: ttyS1 at MMIO 0x1d0c000 (irq =3D 53) is a 16550A
serial8250.0: ttyS2 at MMIO 0x1d0d000 (irq =3D 61) is a 16550A
console [ttyS2] enabled
brd: module loaded
davinci_emac_probe: using random MAC addr: 6a:c9:27:5d:9b:5c
emac-mii: probed
dm9000 Ethernet Driver, V1.31
console [netcon0] enabled
netconsole: network logging started
Linux video capture interface: v2.00
Driver 'sd' needs updating - please use bus_type methods
ahci ahci: forcing PORTS_IMPL to 0x1
ahci ahci: AHCI 0001.0100 32 slots 1 ports 3 Gbps 0x1 impl SATA mode
ahci ahci: flags: ncq sntf pm led clo only pmp pio slum part
scsi0 : ahci
ata1: SATA max UDMA/133 irq 67

Thank you and best regards,

Flavio

Flavio de Castro Alves Filho
Embedded Software Services
www.phiinnovations.com
+55 11 84 94 56 76


2010/1/6 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>
> Flavio Alves wrote:
> > Indeed ...
> >
> > Making this pointer not null (initializing the tsc pointer) solve this
> > issue. Thanks again for your help.
> >
> > Now I have the following situation in my xenomai boot process:
>
> Your boot log is unreadable, please tell your MUA no to wrap it or post
> it to some pastebin.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.

