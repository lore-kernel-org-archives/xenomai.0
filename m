References: <1413464642.48297.YahooMailNeo@web141701.mail.bf1.yahoo.com>
 <20141016174309.GD30661@sisyphus.hd.free.fr>
Message-ID: <1413540390.40452.YahooMailNeo@web141704.mail.bf1.yahoo.com>
Date: Fri, 17 Oct 2014 03:06:30 -0700
From: =?iso-8859-1?Q?R=F3bert_Marc?= <rob_marc2003@yahoo.com>
In-Reply-To: <20141016174309.GD30661@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] RTDM problem with Advantech PCM-3680I
Reply-To: =?iso-8859-1?Q?R=F3bert_Marc?= <rob_marc2003@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Gilles,=0A=0AI've looked into dmesg again. At around [ 4.554430] ADV-PCI=
-CAN: probe of 0000:01:04.0 failed with error -5. Might be this the problem=
? Tried to google this error code, no luck.=0A=0AIf somebody has a clue, or=
 had similar issues with the driver let me know your ideas.=0A=0AI run out =
of ideas to be honest with you.=0A=0AOne more thing what I can try is to di=
sable the original can4linux driver. Will post the outcome.=0A=0A=0AHere is=
 the output.=0A=0A[    0.164991] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 =
5 *6 10 11 12 14 15)=0A[    0.165122] ACPI: PCI Interrupt Link [LNKE] (IRQs=
 3 4 5 6 7 10 11 12 14 15) *0, disabled.=0A[    0.165256] ACPI: PCI Interru=
pt Link [LNKF] (IRQs 3 4 *5 6 7 10 11 12 14 15)=0A[    0.165388] ACPI: PCI =
Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.=0A[    =
0.165523] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 10 11 12 14 15)=
=0A[    0.165692] vgaarb: device added: PCI:0000:00:02.0,decodes=3Dio+mem,o=
wns=3Dio+mem,locks=3Dnone=0A[    0.165692] vgaarb: loaded=0A[    0.165692] =
vgaarb: bridge control possible 0000:00:02.0=0A[    0.165692] SCSI subsyste=
m initialized=0A[    0.165692] libata version 3.00 loaded.=0A[    0.165692]=
 ACPI: bus type usb registered=0A[    0.165692] usbcore: registered new int=
erface driver usbfs=0A[    0.165692] usbcore: registered new interface driv=
er hub=0A[    0.165692] usbcore: registered new device driver usb=0A[    0.=
165692] PCI: Using ACPI for IRQ routing=0A[    0.165692] PCI: pci_cache_lin=
e_size set to 64 bytes=0A[    0.165692] Expanded resource reserved due to c=
onflict with PCI Bus 0000:00=0A[    0.165692] e820: reserve RAM buffer [mem=
 0x0009fc00-0x0009ffff]=0A[    0.165692] e820: reserve RAM buffer [mem 0x3f=
6a0000-0x3fffffff]=0A[    0.165692] NetLabel: Initializing=0A[    0.165692]=
 NetLabel:  domain hash size =3D 128=0A[    0.165692] NetLabel:  protocols =
=3D UNLABELED CIPSOv4=0A[    0.165692] NetLabel:  unlabeled traffic allowed=
 by default=0A[    0.165692] HPET: 3 timers in total, 0 timers will be used=
 for per-cpu timer=0A[    0.165692] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0=
=0A[    0.165692] hpet0: 3 comparators, 64-bit 14.318180 MHz counter=0A[   =
 0.172048] Switching to clocksource hpet=0A[    0.187866] AppArmor: AppArmo=
r Filesystem Enabled=0A[    0.187949] pnp: PnP ACPI init=0A[    0.188002] A=
CPI: bus type pnp registered=0A[    0.188316] pnp 00:00: [bus 00-ff]=0A[   =
 0.188325] pnp 00:00: [io  0x0cf8-0x0cff]=0A[    0.188332] pnp 00:00: [io  =
0x0000-0x0cf7 window]=0A[    0.188339] pnp 00:00: [io  0x0d00-0xffff window=
]=0A[    0.188346] pnp 00:00: [mem 0x000a0000-0x000bffff window]=0A[    0.1=
88352] pnp 00:00: [mem 0x000d0000-0x000dffff window]=0A[    0.188359] pnp 0=
0:00: [mem 0x3f700000-0xdfffffff window]=0A[    0.188365] pnp 00:00: [mem 0=
xf0000000-0xfed8ffff window]=0A[    0.188485] pnp 00:00: Plug and Play ACPI=
 device, IDs PNP0a08 PNP0a03 (active)=0A[    0.188514] pnp 00:01: [mem 0xfe=
d14000-0xfed19fff]=0A[    0.188522] pnp 00:01: [mem 0xfed90000-0xfed93fff]=
=0A[    0.188604] system 00:01: [mem 0xfed14000-0xfed19fff] has been reserv=
ed=0A[    0.188612] system 00:01: [mem 0xfed90000-0xfed93fff] has been rese=
rved=0A[    0.188621] system 00:01: Plug and Play ACPI device, IDs PNP0c01 =
(active)=0A[    0.188706] pnp 00:02: [dma 4]=0A[    0.188714] pnp 00:02: [i=
o  0x0000-0x000f]=0A[    0.188720] pnp 00:02: [io  0x0081-0x0083]=0A[    0.=
188726] pnp 00:02: [io  0x0087]=0A[    0.188732] pnp 00:02: [io  0x0089-0x0=
08b]=0A[    0.188738] pnp 00:02: [io  0x008f]=0A[    0.188748] pnp 00:02: [=
io  0x00c0-0x00df]=0A[    0.188804] pnp 00:02: Plug and Play ACPI device, I=
Ds PNP0200 (active)=0A[    0.188842] pnp 00:03: [io  0x0070-0x0071]=0A[    =
0.188865] pnp 00:03: [irq 8]=0A[    0.188921] pnp 00:03: Plug and Play ACPI=
 device, IDs PNP0b00 (active)=0A[    0.188948] pnp 00:04: [io  0x0061]=0A[ =
   0.189003] pnp 00:04: Plug and Play ACPI device, IDs PNP0800 (active)=0A[=
    0.189030] pnp 00:05: [io  0x00f0-0x00ff]=0A[    0.189044] pnp 00:05: [i=
rq 13]=0A[    0.189106] pnp 00:05: Plug and Play ACPI device, IDs PNP0c04 (=
active)=0A[    0.189944] pnp 00:06: [io  0x0000-0xffffffff disabled]=0A[   =
 0.189952] pnp 00:06: [io  0x0a00-0x0a7f]=0A[    0.190037] system 00:06: [i=
o  0x0a00-0x0a7f] has been reserved=0A[    0.190047] system 00:06: Plug and=
 Play ACPI device, IDs PNP0c02 (active)=0A[    0.190350] pnp 00:07: [io  0x=
0010-0x001f]=0A[    0.190358] pnp 00:07: [io  0x0022-0x003f]=0A[    0.19036=
4] pnp 00:07: [io  0x0044-0x005f]=0A[    0.190370] pnp 00:07: [io  0x0062-0=
x0063]=0A[    0.190376] pnp 00:07: [io  0x0065-0x006f]=0A[    0.190382] pnp=
 00:07: [io  0x0072-0x007f]=0A[    0.190387] pnp 00:07: [io  0x0080]=0A[   =
 0.190393] pnp 00:07: [io  0x0084-0x0086]=0A[    0.190399] pnp 00:07: [io  =
0x0088]=0A[    0.190405] pnp 00:07: [io  0x008c-0x008e]=0A[    0.190411] pn=
p 00:07: [io  0x0090-0x009f]=0A[    0.190416] pnp 00:07: [io  0x00a2-0x00bf=
]=0A[    0.190422] pnp 00:07: [io  0x00e0-0x00ef]=0A[    0.190428] pnp 00:0=
7: [io  0x04d0-0x04d1]=0A[    0.190434] pnp 00:07: [io  0x0800-0x087f]=0A[ =
   0.190441] pnp 00:07: [io  0x0000-0xffffffff disabled]=0A[    0.190447] p=
np 00:07: [io  0x0500-0x053f]=0A[    0.190453] pnp 00:07: [mem 0xfed1c000-0=
xfed1ffff]=0A[    0.190460] pnp 00:07: [mem 0xfed20000-0xfed3ffff]=0A[    0=
.190466] pnp 00:07: [mem 0xfed40000-0xfed8ffff]=0A[    0.190587] system 00:=
07: [io  0x04d0-0x04d1] has been reserved=0A[    0.190595] system 00:07: [i=
o  0x0800-0x087f] has been reserved=0A[    0.190602] system 00:07: [io  0x0=
500-0x053f] has been reserved=0A[    0.190610] system 00:07: [mem 0xfed1c00=
0-0xfed1ffff] has been reserved=0A[    0.190618] system 00:07: [mem 0xfed20=
000-0xfed3ffff] has been reserved=0A[    0.190625] system 00:07: [mem 0xfed=
40000-0xfed8ffff] has been reserved=0A[    0.190634] system 00:07: Plug and=
 Play ACPI device, IDs PNP0c02 (active)=0A[    0.190783] pnp 00:08: [mem 0x=
fed00000-0xfed003ff]=0A[    0.190845] pnp 00:08: Plug and Play ACPI device,=
 IDs PNP0103 (active)=0A[    0.190980] pnp 00:09: [mem 0xffb00000-0xffbffff=
f]=0A[    0.190988] pnp 00:09: [mem 0xfff00000-0xffffffff]=0A[    0.191049]=
 pnp 00:09: Plug and Play ACPI device, IDs INT0800 (active)=0A[    0.191162=
] pnp 00:0a: [mem 0xffc00000-0xffefffff]=0A[    0.191250] system 00:0a: [me=
m 0xffc00000-0xffefffff] has been reserved=0A[    0.191260] system 00:0a: P=
lug and Play ACPI device, IDs PNP0c02 (active)=0A[    0.191484] pnp 00:0b: =
[io  0x0060]=0A[    0.191491] pnp 00:0b: [io  0x0064]=0A[    0.191498] pnp =
00:0b: [mem 0xfec00000-0xfec00fff]=0A[    0.191504] pnp 00:0b: [mem 0xfee00=
000-0xfee00fff]=0A[    0.191591] system 00:0b: [mem 0xfec00000-0xfec00fff] =
could not be reserved=0A[    0.191600] system 00:0b: [mem 0xfee00000-0xfee0=
0fff] has been reserved=0A[    0.191609] system 00:0b: Plug and Play ACPI d=
evice, IDs PNP0c02 (active)=0A[    0.192211] pnp 00:0c: [io  0x03f8-0x03ff]=
=0A[    0.192221] pnp 00:0c: IRQ 4 override to edge, high=0A[    0.192237] =
pnp 00:0c: [irq 4]=0A[    0.192368] pnp 00:0c: Plug and Play ACPI device, I=
Ds PNP0501 (active)=0A[    0.192931] pnp 00:0d: [io  0x02f8-0x02ff]=0A[    =
0.192940] pnp 00:0d: IRQ 3 override to edge, high=0A[    0.192958] pnp 00:0=
d: [irq 3]=0A[    0.193086] pnp 00:0d: Plug and Play ACPI device, IDs PNP05=
01 (active)=0A[    0.193649] pnp 00:0e: [io  0x03e8-0x03ef]=0A[    0.193657=
] pnp 00:0e: IRQ 11 override to edge, high=0A[    0.193671] pnp 00:0e: [irq=
 11]=0A[    0.193817] pnp 00:0e: Plug and Play ACPI device, IDs PNP0501 (ac=
tive)=0A[    0.194207] pnp 00:0f: [mem 0xe0000000-0xefffffff]=0A[    0.1943=
03] system 00:0f: [mem 0xe0000000-0xefffffff] has been reserved=0A[    0.19=
4313] system 00:0f: Plug and Play ACPI device, IDs PNP0c02 (active)=0A[    =
0.194740] pnp 00:10: [mem 0x00000000-0x0009ffff]=0A[    0.194747] pnp 00:10=
: [mem 0x000c0000-0x000cffff]=0A[    0.194754] pnp 00:10: [mem 0x000e0000-0=
x000fffff]=0A[    0.194760] pnp 00:10: [mem 0x00100000-0x3f6fffff]=0A[    0=
.194766] pnp 00:10: [mem 0xfed90000-0xffffffff]=0A[    0.194876] system 00:=
10: [mem 0x00000000-0x0009ffff] could not be reserved=0A[    0.194885] syst=
em 00:10: [mem 0x000c0000-0x000cffff] could not be reserved=0A[    0.194892=
] system 00:10: [mem 0x000e0000-0x000fffff] could not be reserved=0A[    0.=
194899] system 00:10: [mem 0x00100000-0x3f6fffff] could not be reserved=0A[=
    0.194907] system 00:10: [mem 0xfed90000-0xffffffff] could not be reserv=
ed=0A[    0.194916] system 00:10: Plug and Play ACPI device, IDs PNP0c01 (a=
ctive)=0A[    0.195257] pnp: PnP ACPI: found 17 devices=0A[    0.195263] AC=
PI: ACPI bus type pnp unregistered=0A[    0.235435] pci 0000:00:1e.0: PCI b=
ridge to [bus 01-01]=0A[    0.235447] pci 0000:00:1e.0:   bridge window [io=
  0xe000-0xefff]=0A[    0.235478] pci 0000:00:1e.0: setting latency timer t=
o 64=0A[    0.235487] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]=0A[  =
  0.235494] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]=0A[    0.235500=
] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]=0A[    0.235507] =
pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff]=0A[    0.235514] pc=
i_bus 0000:00: resource 8 [mem 0x3f700000-0xdfffffff]=0A[    0.235520] pci_=
bus 0000:00: resource 9 [mem 0xf0000000-0xfed8ffff]=0A[    0.235527] pci_bu=
s 0000:01: resource 0 [io  0xe000-0xefff]=0A[    0.235533] pci_bus 0000:01:=
 resource 4 [io  0x0000-0x0cf7]=0A[    0.235540] pci_bus 0000:01: resource =
5 [io  0x0d00-0xffff]=0A[    0.235546] pci_bus 0000:01: resource 6 [mem 0x0=
00a0000-0x000bffff]=0A[    0.235552] pci_bus 0000:01: resource 7 [mem 0x000=
d0000-0x000dffff]=0A[    0.235559] pci_bus 0000:01: resource 8 [mem 0x3f700=
000-0xdfffffff]=0A[    0.235565] pci_bus 0000:01: resource 9 [mem 0xf000000=
0-0xfed8ffff]=0A[    0.235636] NET: Registered protocol family 2=0A[    0.2=
35767] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)=0A=
[    0.236042] TCP established hash table entries: 131072 (order: 8, 104857=
6 bytes)=0A[    0.236964] TCP bind hash table entries: 65536 (order: 7, 524=
288 bytes)=0A[    0.237389] TCP: Hash tables configured (established 131072=
 bind 65536)=0A[    0.237395] TCP: reno registered=0A[    0.237404] UDP has=
h table entries: 512 (order: 2, 16384 bytes)=0A[    0.237422] UDP-Lite hash=
 table entries: 512 (order: 2, 16384 bytes)=0A[    0.237595] NET: Registere=
d protocol family 1=0A[    0.237636] pci 0000:00:02.0: Boot video device=0A=
[    0.237888] PCI: CLS mismatch (32 !=3D 4), using 64 bytes=0A[    0.23800=
3] Trying to unpack rootfs image as initramfs...=0A[    0.799553] Freeing i=
nitrd memory: 12740k freed=0A[    0.810830] audit: initializing netlink soc=
ket (disabled)=0A[    0.810858] type=3D2000 audit(1413539144.804:1): initia=
lized=0A[    0.862061] I-pipe: head domain Xenomai registered.=0A[    0.862=
136] Xenomai: hal/i386 started.=0A[    0.862182] Xenomai: scheduling class =
idle registered.=0A[    0.862187] Xenomai: scheduling class rt registered.=
=0A[    0.865014] Xenomai: real-time nucleus v2.6.3 (Lies and Truths) loade=
d.=0A[    0.865020] Xenomai: debug mode enabled.=0A[    0.865192] Xenomai: =
SMI-enabled chipset found, but SMI workaround disabled=0A[    0.865192]    =
      (see xeno_hal.smi parameter). You may encounter=0A[    0.865192]     =
     high interrupt latencies!=0A[    0.865257] Xenomai: starting native AP=
I services.=0A[    0.865265] Xenomai: starting POSIX services.=0A[    0.865=
313] Xenomai: starting RTDM services.=0A[    0.865653] highmem bounce pool =
size: 64 pages=0A[    0.865679] HugeTLB registered 4 MB page size, pre-allo=
cated 0 pages=0A[    0.868932] VFS: Disk quotas dquot_6.5.2=0A[    0.869051=
] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)=0A[    0.87008=
7] fuse init (API version 7.19)=0A[    0.870338] msgmni has been set to 173=
5=0A[    0.871365] Block layer SCSI generic (bsg) driver version 0.4 loaded=
 (major 252)=0A[    0.871373] io scheduler noop registered=0A[    0.871378]=
 io scheduler deadline registered (default)=0A[    0.871396] io scheduler c=
fq registered=0A[    0.871623] pci_hotplug: PCI Hot Plug PCI Core version: =
0.5=0A[    0.871672] pciehp: PCI Express Hot Plug Controller Driver version=
: 0.4=0A[    0.871677] acpiphp: ACPI Hot Plug PCI Controller Driver version=
: 0.5=0A[    0.872637] input: Power Button as /devices/LNXSYSTM:00/device:0=
0/PNP0C0C:00/input/input0=0A[    0.872649] ACPI: Power Button [PWRB]=0A[   =
 0.872749] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/in=
put1=0A[    0.872757] ACPI: Power Button [PWRF]=0A[    0.873620] Monitor-Mw=
ait will be used to enter C-1 state=0A[    0.873637] Monitor-Mwait will be =
used to enter C-2 state=0A[    0.873649] Monitor-Mwait will be used to ente=
r C-3 state=0A[    0.873658] Marking TSC unstable due to TSC halts in idle=
=0A[    0.873675] ACPI: acpi_idle registered with cpuidle=0A[    0.874479] =
GHES: HEST is not enabled!=0A[    0.874506] isapnp: Scanning for PnP cards.=
..=0A[    1.116005] isapnp: No Plug & Play device found=0A[    1.227695] Se=
rial: 8250/16550 driver, 32 ports, IRQ sharing enabled=0A[    1.248144] ser=
ial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A=0A[    1.268610] serial=
8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A=0A[    1.289067] serial825=
0: ttyS2 at I/O 0x3e8 (irq =3D 4) is a 16550A=0A[    1.312071] 00:0c: ttyS0=
 at I/O 0x3f8 (irq =3D 4) is a 16550A=0A[    1.332672] 00:0d: ttyS1 at I/O =
0x2f8 (irq =3D 3) is a 16550A=0A[    1.353264] 00:0e: ttyS2 at I/O 0x3e8 (i=
rq =3D 11) is a 16550A=0A[    1.353851] Linux agpgart interface v0.103=0A[ =
   1.353992] agpgart-intel 0000:00:00.0: Intel GMA3150 Chipset=0A[    1.354=
089] agpgart-intel 0000:00:00.0: detected gtt size: 524288K total, 262144K =
mappable=0A[    1.354243] agpgart-intel 0000:00:00.0: detected 8192K stolen=
 memory=0A[    1.354485] agpgart-intel 0000:00:00.0: AGP aperture is 256M @=
 0xd0000000=0A[    1.357915] brd: module loaded=0A[    1.359681] loop: modu=
le loaded=0A[    1.359804] megasas: 00.00.06.15-rc1 Mon. Mar. 19 17:00:00 P=
DT 2012=0A[    1.359969] ata_piix 0000:00:1f.2: version 2.13=0A[    1.36003=
6] ata_piix 0000:00:1f.2: MAP [=0A[    1.360042]  P0 P2 IDE IDE ]=0A[    1.=
516066] ata_piix 0000:00:1f.2: setting latency timer to 64=0A[    1.516679]=
 scsi0 : ata_piix=0A[    1.516870] scsi1 : ata_piix=0A[    1.519746] ata1: =
SATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xffa0 irq 14=0A[    1.519754] =
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xffa8 irq 15=0A[    1.52=
0640] Fixed MDIO Bus: probed=0A[    1.520768] tun: Universal TUN/TAP device=
 driver, 1.6=0A[    1.520773] tun: (C) 1999-2004 Max Krasnyansky <maxk@qual=
comm.com>=0A[    1.520906] PPP generic driver version 2.4.2=0A[    1.521043=
] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver=0A[    1.52111=
3] ehci_hcd 0000:00:1d.7: setting latency timer to 64=0A[    1.521122] ehci=
_hcd 0000:00:1d.7: EHCI Host Controller=0A[    1.521136] ehci_hcd 0000:00:1=
d.7: new USB bus registered, assigned bus number 1=0A[    1.521179] ehci_hc=
d 0000:00:1d.7: debug port 1=0A[    1.525077] ehci_hcd 0000:00:1d.7: cache =
line size of 64 is not supported=0A[    1.525120] ehci_hcd 0000:00:1d.7: ir=
q 23, io mem 0xfebff800=0A[    1.536034] ehci_hcd 0000:00:1d.7: USB 2.0 sta=
rted, EHCI 1.00=0A[    1.536112] usb usb1: New USB device found, idVendor=
=3D1d6b, idProduct=3D0002=0A[    1.536119] usb usb1: New USB device strings=
: Mfr=3D3, Product=3D2, SerialNumber=3D1=0A[    1.536125] usb usb1: Product=
: EHCI Host Controller=0A[    1.536131] usb usb1: Manufacturer: Linux 3.5.7=
-xenomai-2.6.3 ehci_hcd=0A[    1.536137] usb usb1: SerialNumber: 0000:00:1d=
.7=0A[    1.536400] hub 1-0:1.0: USB hub found=0A[    1.536412] hub 1-0:1.0=
: 8 ports detected=0A[    1.536554] ohci_hcd: USB 1.1 'Open' Host Controlle=
r (OHCI) Driver=0A[    1.536582] uhci_hcd: USB Universal Host Controller In=
terface driver=0A[    1.536633] uhci_hcd 0000:00:1d.0: setting latency time=
r to 64=0A[    1.536641] uhci_hcd 0000:00:1d.0: UHCI Host Controller=0A[   =
 1.536654] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus numb=
er 2=0A[    1.536691] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000d880=0A[=
    1.536764] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=3D=
0001=0A[    1.536771] usb usb2: New USB device strings: Mfr=3D3, Product=3D=
2, SerialNumber=3D1=0A[    1.536777] usb usb2: Product: UHCI Host Controlle=
r=0A[    1.536783] usb usb2: Manufacturer: Linux 3.5.7-xenomai-2.6.3 uhci_h=
cd=0A[    1.536789] usb usb2: SerialNumber: 0000:00:1d.0=0A[    1.537014] h=
ub 2-0:1.0: USB hub found=0A[    1.537026] hub 2-0:1.0: 2 ports detected=0A=
[    1.537144] uhci_hcd 0000:00:1d.1: setting latency timer to 64=0A[    1.=
537152] uhci_hcd 0000:00:1d.1: UHCI Host Controller=0A[    1.537165] uhci_h=
cd 0000:00:1d.1: new USB bus registered, assigned bus number 3=0A[    1.537=
220] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000d800=0A[    1.537291] usb=
 usb3: New USB device found, idVendor=3D1d6b, idProduct=3D0001=0A[    1.537=
298] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=
=3D1=0A[    1.537304] usb usb3: Product: UHCI Host Controller=0A[    1.5373=
10] usb usb3: Manufacturer: Linux 3.5.7-xenomai-2.6.3 uhci_hcd=0A[    1.537=
316] usb usb3: SerialNumber: 0000:00:1d.1=0A[    1.537538] hub 3-0:1.0: USB=
 hub found=0A[    1.537550] hub 3-0:1.0: 2 ports detected=0A[    1.537664] =
uhci_hcd 0000:00:1d.2: setting latency timer to 64=0A[    1.537672] uhci_hc=
d 0000:00:1d.2: UHCI Host Controller=0A[    1.537684] uhci_hcd 0000:00:1d.2=
: new USB bus registered, assigned bus number 4=0A[    1.537734] uhci_hcd 0=
000:00:1d.2: irq 18, io base 0x0000d480=0A[    1.537805] usb usb4: New USB =
device found, idVendor=3D1d6b, idProduct=3D0001=0A[    1.537813] usb usb4: =
New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1=0A[    1.537=
818] usb usb4: Product: UHCI Host Controller=0A[    1.537824] usb usb4: Man=
ufacturer: Linux 3.5.7-xenomai-2.6.3 uhci_hcd=0A[    1.537830] usb usb4: Se=
rialNumber: 0000:00:1d.2=0A[    1.538048] hub 4-0:1.0: USB hub found=0A[   =
 1.538064] hub 4-0:1.0: 2 ports detected=0A[    1.538176] uhci_hcd 0000:00:=
1d.3: setting latency timer to 64=0A[    1.538184] uhci_hcd 0000:00:1d.3: U=
HCI Host Controller=0A[    1.538197] uhci_hcd 0000:00:1d.3: new USB bus reg=
istered, assigned bus number 5=0A[    1.538246] uhci_hcd 0000:00:1d.3: irq =
16, io base 0x0000d400=0A[    1.538319] usb usb5: New USB device found, idV=
endor=3D1d6b, idProduct=3D0001=0A[    1.538326] usb usb5: New USB device st=
rings: Mfr=3D3, Product=3D2, SerialNumber=3D1=0A[    1.538332] usb usb5: Pr=
oduct: UHCI Host Controller=0A[    1.538338] usb usb5: Manufacturer: Linux =
3.5.7-xenomai-2.6.3 uhci_hcd=0A[    1.538343] usb usb5: SerialNumber: 0000:=
00:1d.3=0A[    1.538557] hub 5-0:1.0: USB hub found=0A[    1.538569] hub 5-=
0:1.0: 2 ports detected=0A[    1.538800] i8042: PNP: No PS/2 controller fou=
nd. Probing ports directly.=0A[    1.541147] serio: i8042 KBD port at 0x60,=
0x64 irq 1=0A[    1.541164] serio: i8042 AUX port at 0x60,0x64 irq 12=0A[  =
  1.541475] mousedev: PS/2 mouse device common for all mice=0A[    1.541801=
] rtc_cmos 00:03: RTC can wake from S4=0A[    1.541999] rtc_cmos 00:03: rtc=
 core: registered rtc_cmos as rtc0=0A[    1.542037] rtc0: alarms up to one =
month, y3k, 114 bytes nvram, hpet irqs=0A[    1.542152] device-mapper: ueve=
nt: version 1.0.3=0A[    1.542310] device-mapper: ioctl: 4.22.0-ioctl (2011=
-10-19) initialised: dm-devel@redhat.com=0A[    1.542384] EISA: Probing bus=
 0 at eisa.0=0A[    1.542390] EISA: Cannot allocate resource for mainboard=
=0A[    1.542395] Cannot allocate resource for EISA slot 1=0A[    1.542399]=
 Cannot allocate resource for EISA slot 2=0A[    1.542403] Cannot allocate =
resource for EISA slot 3=0A[    1.542407] Cannot allocate resource for EISA=
 slot 4=0A[    1.542411] Cannot allocate resource for EISA slot 5=0A[    1.=
542415] Cannot allocate resource for EISA slot 6=0A[    1.542419] Cannot al=
locate resource for EISA slot 7=0A[    1.542423] Cannot allocate resource f=
or EISA slot 8=0A[    1.542427] EISA: Detected 0 cards.=0A[    1.542516] cp=
uidle: using governor ladder=0A[    1.542638] cpuidle: using governor menu=
=0A[    1.542644] EFI Variables Facility v0.08 2004-May-17=0A[    1.543352]=
 TCP: cubic registered=0A[    1.543580] NET: Registered protocol family 10=
=0A[    1.543944] NET: Registered protocol family 17=0A[    1.543980] Key t=
ype dns_resolver registered=0A[    1.544188] Using IPI No-Shortcut mode=0A[=
    1.544510] registered taskstats version 1=0A[    1.549688] Key type trus=
ted registered=0A[    1.554703] Key type encrypted registered=0A[    1.5603=
13] rtc_cmos 00:03: setting system clock to 2014-10-17 09:45:46 UTC (141353=
9146)=0A[    1.560432] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found=
=0A[    1.560438] EDD information not available.=0A[    1.680293] ata1.00: =
supports DRM functions and may not be fully accessible=0A[    1.680304] ata=
1.00: ATA-9: Samsung SSD 840 EVO 250GB, EXT0BB6Q, max UDMA/133=0A[    1.680=
310] ata1.00: 488397168 sectors, multi 1: LBA48 NCQ (depth 0/32)=0A[    1.6=
85368] ata2.00: CFA: SQF-P10S2-16G-P8C, Ver6.A1J, max UDMA/66=0A[    1.6853=
83] ata2.00: 30146256 sectors, multi 1: LBA48 =0A[    1.688277] ata1.00: su=
pports DRM functions and may not be fully accessible=0A[    1.688288] ata1.=
00: configured for UDMA/133=0A[    1.688552] scsi 0:0:0:0: Direct-Access   =
  ATA      Samsung SSD 840  EXT0 PQ: 0 ANSI: 5=0A[    1.688902] sd 0:0:0:0:=
 [sda] 488397168 512-byte logical blocks: (250 GB/232 GiB)=0A[    1.688929]=
 sd 0:0:0:0: Attached scsi generic sg0 type 0=0A[    1.689258] sd 0:0:0:0: =
[sda] Write Protect is off=0A[    1.689269] sd 0:0:0:0: [sda] Mode Sense: 0=
0 3a 00 00=0A[    1.689365] sd 0:0:0:0: [sda] Write cache: enabled, read ca=
che: enabled, doesn't support DPO or FUA=0A[    1.695803]  sda: sda1 sda2 <=
 sda5 >=0A[    1.696847] sd 0:0:0:0: [sda] Attached SCSI disk=0A[    1.7012=
89] ata2.00: configured for UDMA/66=0A[    1.701530] scsi 1:0:0:0: Direct-A=
ccess     ATA      SQF-P10S2-16G-P8 Ver6 PQ: 0 ANSI: 5=0A[    1.701828] sd =
1:0:0:0: [sdb] 30146256 512-byte logical blocks: (15.4 GB/14.3 GiB)=0A[    =
1.701909] sd 1:0:0:0: Attached scsi generic sg1 type 0=0A[    1.702027] sd =
1:0:0:0: [sdb] Write Protect is off=0A[    1.702043] sd 1:0:0:0: [sdb] Mode=
 Sense: 00 3a 00 00=0A[    1.702116] sd 1:0:0:0: [sdb] Write cache: disable=
d, read cache: enabled, doesn't support DPO or FUA=0A[    1.704312]  sdb: s=
db1 sdb2=0A[    1.705011] sd 1:0:0:0: [sdb] Attached SCSI disk=0A[    1.705=
121] Freeing unused kernel memory: 708k freed=0A[    1.705650] Write protec=
ting the kernel text: 5936k=0A[    1.705736] Write protecting the kernel re=
ad-only data: 2348k=0A[    1.747036] udevd[94]: starting version 175=0A[   =
 1.848085] usb 1-7: new high-speed USB device number 2 using ehci_hcd=0A[  =
  1.983332] usb 1-7: New USB device found, idVendor=3D2109, idProduct=3D281=
2=0A[    1.983346] usb 1-7: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0=0A[    1.983356] usb 1-7: Product: USB2.0 Hub             =
=0A[    1.983365] usb 1-7: Manufacturer: VIA Labs, Inc.         =0A[    1.9=
83948] hub 1-7:1.0: USB hub found=0A[    1.984329] hub 1-7:1.0: 4 ports det=
ected=0A[    1.992099] e1000e: Intel(R) PRO/1000 Network Driver - 2.0.0-k=
=0A[    1.992108] e1000e: Copyright(c) 1999 - 2012 Intel Corporation.=0A[  =
  1.995199] e1000e 0000:00:19.0: setting latency timer to 64=0A[    1.99534=
9] e1000e 0000:00:19.0: (unregistered net_device): Interrupt Throttling Rat=
e (ints/sec) set to dynamic conservative mode=0A[    1.995432] e1000e 0000:=
00:19.0: irq 40 for MSI/MSI-X=0A[    2.181536] EXT4-fs (sdb1): mounted file=
system with ordered data mode. Opts: (null)=0A[    2.190518] e1000e 0000:00=
:19.0: eth0: (PCI Express:2.5GT/s:Width x1) 00:0b:ab:7c:c6:0c=0A[    2.1905=
31] e1000e 0000:00:19.0: eth0: Intel(R) PRO/1000 Network Connection=0A[    =
2.192179] e1000e 0000:00:19.0: eth0: MAC: 6, PHY: 8, PBA No: FFFFFF-0FF=0A[=
    2.272369] usb 1-7.1: new full-speed USB device number 3 using ehci_hcd=
=0A[    2.377476] usb 1-7.1: New USB device found, idVendor=3D413c, idProdu=
ct=3D1003=0A[    2.377496] usb 1-7.1: New USB device strings: Mfr=3D1, Prod=
uct=3D2, SerialNumber=3D0=0A[    2.377503] usb 1-7.1: Product: Dell USB Key=
board Hub=0A[    2.377508] usb 1-7.1: Manufacturer: Dell=0A[    2.378493] h=
ub 1-7.1:1.0: USB hub found=0A[    2.378718] hub 1-7.1:1.0: 3 ports detecte=
d=0A[    2.508365] usb 1-7.2: new low-speed USB device number 4 using ehci_=
hcd=0A[    2.609242] init: ureadahead main process (236) terminated with st=
atus 5=0A[    2.656454] usb 1-7.2: New USB device found, idVendor=3D03f0, i=
dProduct=3D094a=0A[    2.656468] usb 1-7.2: New USB device strings: Mfr=3D1=
, Product=3D2, SerialNumber=3D0=0A[    2.656478] usb 1-7.2: Product: HP USB=
 Optical Mouse=0A[    2.656488] usb 1-7.2: Manufacturer: PixArt=0A[    2.72=
8349] usb 1-7.1.1: new full-speed USB device number 5 using ehci_hcd=0A[   =
 2.821344] usb 1-7.1.1: New USB device found, idVendor=3D413c, idProduct=3D=
2010=0A[    2.821360] usb 1-7.1.1: New USB device strings: Mfr=3D1, Product=
=3D3, SerialNumber=3D0=0A[    2.821371] usb 1-7.1.1: Product: Dell USB Keyb=
oard=0A[    2.821380] usb 1-7.1.1: Manufacturer: Dell=0A[    2.845237] Addi=
ng 976892k swap on /dev/sdb2.  Priority:-1 extents:1 across:976892k =0A[   =
 3.055988] udevd[312]: starting version 175=0A[    3.152388] EXT4-fs (sdb1)=
: re-mounted. Opts: errors=3Dremount-ro=0A[    3.221193] lp: driver loaded =
but no devices found=0A[    3.675046] [drm] Initialized drm 1.1.0 20060810=
=0A[    4.042262] ppdev: user-space parallel port driver=0A[    4.074535] B=
luetooth: Core ver 2.16=0A[    4.074628] NET: Registered protocol family 31=
=0A[    4.074636] Bluetooth: HCI device and connection manager initialized=
=0A[    4.074644] Bluetooth: HCI socket layer initialized=0A[    4.074650] =
Bluetooth: L2CAP socket layer initialized=0A[    4.074665] Bluetooth: SCO s=
ocket layer initialized=0A[    4.116533] i915 0000:00:02.0: setting latency=
 timer to 64=0A[    4.124103] Bluetooth: RFCOMM TTY layer initialized=0A[  =
  4.124121] Bluetooth: RFCOMM socket layer initialized=0A[    4.124128] Blu=
etooth: RFCOMM ver 1.11=0A[    4.144596] i915 0000:00:02.0: irq 41 for MSI/=
MSI-X=0A[    4.144629] [drm] Supports vblank timestamp caching Rev 1 (10.10=
.2010).=0A[    4.144635] [drm] Driver supports precise vblank timestamp que=
ry.=0A[    4.168854] vgaarb: device changed decodes: PCI:0000:00:02.0,oldde=
codes=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem=0A[    4.204362] Bluetooth: B=
NEP (Ethernet Emulation) ver 1.3=0A[    4.204371] Bluetooth: BNEP filters: =
protocol multicast=0A[    4.214504] i915: fixme: max PWM is zero=0A[    4.2=
24832] [drm] initialized overlay support=0A[    4.427947] RT-Socket-CAN 0.9=
0.2 - (C) 2006 RT-Socket-CAN Development Team=0A[    4.464552] RTCAN SJA100=
0 driver initialized=0A[    4.554273] ADV-PCI-CAN 0000:01:04.0: RTCAN Regis=
tering card=0A[    4.554300] ADV-PCI-CAN 0000:01:04.0: RTCAN detected Advan=
tech PCI card at slot #4=0A[    4.554313] ADV-PCI-CAN: Initializing device =
13fe:c002:c002=0A[    4.554330] ADV-PCI-CAN: base_addr=3D0001ef00 conf_addr=
=3D  (null) irq=3D16 ocr=3D0xfa cdr=3D0xc0=0A[    4.554375] rtcan: register=
ed rtcan0=0A[    4.554390] Unregistering SJA1000 device rtcan0=0A[    4.554=
407] RTCAN: unregistered rtcan0=0A[    4.554430] ADV-PCI-CAN: probe of 0000=
:01:04.0 failed with error -5=0A[    4.600200] fbcon: inteldrmfb (fb0) is p=
rimary device=0A[    4.681356] =0A[    4.681356] =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A[    4.68136=
1] CAN Communication Driver.=0A[    4.681361] Version: 2.17 (2013-08-30)=0A=
[    4.681363] ADVANTECH Co,Ltd.=0A[    4.681364] =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A[    4.68483=
5] Console: switching to colour frame buffer device 128x48=0A[    4.698538]=
 fb0: inteldrmfb frame buffer device=0A[    4.698544] drm: registered panic=
 notifier=0A[    4.718128] usbcore: registered new interface driver usbhid=
=0A[    4.718137] usbhid: USB HID core driver=0A[    4.757145] Advantech CA=
N Port CAN Driver (c) Oct  3 2014 15:12:52=0A[    4.757210] Advanteh PCI CA=
N devie c002 found( 2 CAN port)=0A[    4.757224] Port 0 ( Addr =3D 0xee00, =
Irq =3D 0x10 )=0A[    4.828104] [drm] Initialized i915 1.6.0 20080730 for 0=
000:00:02.0 on minor 0=0A[    4.830242] ACPI Warning: 0x00000860-0x0000087f=
 SystemIO conflicts with Region \_SB_.PCI0.GFX0.TCOI 1 (20120320/utaddress-=
251)=0A[    4.830265] ACPI: If an ACPI driver is available for this device,=
 you should use it instead of the native driver=0A[    4.830272] lpc_ich: R=
esource conflict(s) found affecting iTCO_wdt=0A[    4.833398] Port 1 ( Addr=
 =3D 0xef00, Irq =3D 0x10 )=0A[    4.843342] FPGA Version:0000=0A[    5.103=
554] microcode: CPU0 sig=3D0x106ca, pf=3D0x4, revision=3D0x107=0A[    5.513=
094] snd_hda_intel 0000:00:1b.0: irq 42 for MSI/MSI-X=0A[    5.573457] hda-=
intel: no codecs found!=0A[    7.051469] input: PixArt HP USB Optical Mouse=
 as /devices/pci0000:00/0000:00:1d.7/usb1/1-7/1-7.2/1-7.2:1.0/input/input2=
=0A[    7.068458] hid-generic 0003:03F0:094A.0001: input,hidraw0: USB HID v=
1.11 Mouse [PixArt HP USB Optical Mouse] on usb-0000:00:1d.7-7.2/input0=0A[=
    7.080091] input: Dell Dell USB Keyboard as /devices/pci0000:00/0000:00:=
1d.7/usb1/1-7/1-7.1/1-7.1.1/1-7.1.1:1.0/input/input3=0A[    7.084864] hid-g=
eneric 0003:413C:2010.0002: input,hidraw1: USB HID v1.10 Keyboard [Dell Del=
l USB Keyboard] on usb-0000:00:1d.7-7.1.1/input0=0A[    7.120083] input: De=
ll Dell USB Keyboard as /devices/pci0000:00/0000:00:1d.7/usb1/1-7/1-7.1/1-7=
.1.1/1-7.1.1:1.1/input/input4=0A[    7.120710] hid-generic 0003:413C:2010.0=
003: input,hidraw2: USB HID v1.10 Device [Dell Dell USB Keyboard] on usb-00=
00:00:1d.7-7.1.1/input1=0A[    7.221936] gpio_ich: GPIO from 206 to 255 on =
gpio_ich=0A[    7.304116] microcode: CPU1 sig=3D0x106ca, pf=3D0x4, revision=
=3D0x107=0A[    7.437231] microcode: Microcode Update Driver: v2.00 <tigran=
@aivazian.fsnet.co.uk>, Peter Oruba=0A[    7.610647] type=3D1400 audit(1413=
539152.546:2): apparmor=3D"STATUS" operation=3D"profile_load" name=3D"/sbin=
/dhclient" pid=3D597 comm=3D"apparmor_parser"=0A[    7.611328] type=3D1400 =
audit(1413539152.546:3): apparmor=3D"STATUS" operation=3D"profile_load" nam=
e=3D"/usr/lib/NetworkManager/nm-dhcp-client.action" pid=3D597 comm=3D"appar=
mor_parser"=0A[    7.611527] type=3D1400 audit(1413539152.546:4): apparmor=
=3D"STATUS" operation=3D"profile_load" name=3D"/usr/lib/connman/scripts/dhc=
lient-script" pid=3D597 comm=3D"apparmor_parser"=0A[    8.525351] type=3D14=
00 audit(1413539153.462:5): apparmor=3D"STATUS" operation=3D"profile_replac=
e" name=3D"/sbin/dhclient" pid=3D675 comm=3D"apparmor_parser"=0A[    8.5256=
01] type=3D1400 audit(1413539153.462:6): apparmor=3D"STATUS" operation=3D"p=
rofile_replace" name=3D"/usr/lib/NetworkManager/nm-dhcp-client.action" pid=
=3D675 comm=3D"apparmor_parser"=0A[    8.525799] type=3D1400 audit(14135391=
53.462:7): apparmor=3D"STATUS" operation=3D"profile_replace" name=3D"/usr/l=
ib/connman/scripts/dhclient-script" pid=3D675 comm=3D"apparmor_parser"=0A[ =
   8.876589] init: failsafe main process (761) killed by TERM signal=0A[   =
 8.890561] init: failsafe_backup main process (765) killed by TERM signal=
=0A[    8.994866] type=3D1400 audit(1413539153.930:8): apparmor=3D"STATUS" =
operation=3D"profile_load" name=3D"/usr/lib/cups/backend/cups-pdf" pid=3D59=
3 comm=3D"apparmor_parser"=0A[    8.996447] type=3D1400 audit(1413539153.93=
4:9): apparmor=3D"STATUS" operation=3D"profile_load" name=3D"/usr/sbin/cups=
d" pid=3D593 comm=3D"apparmor_parser"=0A[    9.616488] e1000e 0000:00:19.0:=
 irq 40 for MSI/MSI-X=0A[    9.720179] e1000e 0000:00:19.0: irq 40 for MSI/=
MSI-X=0A[    9.720954] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready=
=0A[   10.055334] type=3D1400 audit(1413539154.990:10): apparmor=3D"STATUS"=
 operation=3D"profile_replace" name=3D"/sbin/dhclient" pid=3D750 comm=3D"ap=
parmor_parser"=0A[   10.055589] type=3D1400 audit(1413539154.990:11): appar=
mor=3D"STATUS" operation=3D"profile_replace" name=3D"/usr/lib/NetworkManage=
r/nm-dhcp-client.action" pid=3D750 comm=3D"apparmor_parser"=0A[   14.465863=
] audit_printk_skb: 18 callbacks suppressed=0A[   14.465874] type=3D1400 au=
dit(1413539159.402:18): apparmor=3D"STATUS" operation=3D"profile_load" name=
=3D"/usr/lib/telepathy/mission-control-5" pid=3D862 comm=3D"apparmor_parser=
"=0A[   14.466734] type=3D1400 audit(1413539159.402:19): apparmor=3D"STATUS=
" operation=3D"profile_load" name=3D"/usr/lib/telepathy/telepathy-*" pid=3D=
862 comm=3D"apparmor_parser"=0A[   16.890477] type=3D1400 audit(1413539161.=
826:20): apparmor=3D"STATUS" operation=3D"profile_replace" name=3D"/usr/lib=
/cups/backend/cups-pdf" pid=3D863 comm=3D"apparmor_parser"=0A[   16.891267]=
 type=3D1400 audit(1413539161.826:21): apparmor=3D"STATUS" operation=3D"pro=
file_replace" name=3D"/usr/sbin/cupsd" pid=3D863 comm=3D"apparmor_parser"=
=0A[   17.842887] type=3D1400 audit(1413539162.778:22): apparmor=3D"STATUS"=
 operation=3D"profile_load" name=3D"/usr/sbin/tcpdump" pid=3D865 comm=3D"ap=
parmor_parser"=0A[   34.679948] type=3D1400 audit(1413539179.614:23): appar=
mor=3D"STATUS" operation=3D"profile_load" name=3D"/usr/bin/evince" pid=3D86=
0 comm=3D"apparmor_parser"=0A[   34.683050] type=3D1400 audit(1413539179.61=
8:24): apparmor=3D"STATUS" operation=3D"profile_load" name=3D"/usr/bin/evin=
ce//launchpad_integration" pid=3D860 comm=3D"apparmor_parser"=0A[   34.6838=
94] type=3D1400 audit(1413539179.618:25): apparmor=3D"STATUS" operation=3D"=
profile_load" name=3D"/usr/bin/evince//sanitized_helper" pid=3D860 comm=3D"=
apparmor_parser"=0A[   34.686367] type=3D1400 audit(1413539179.622:26): app=
armor=3D"STATUS" operation=3D"profile_load" name=3D"/usr/bin/evince-preview=
er" pid=3D860 comm=3D"apparmor_parser"=0A[   34.688640] type=3D1400 audit(1=
413539179.626:27): apparmor=3D"STATUS" operation=3D"profile_load" name=3D"/=
usr/bin/evince-previewer//launchpad_integration" pid=3D860 comm=3D"apparmor=
_parser"=0A[   34.689511] type=3D1400 audit(1413539179.626:28): apparmor=3D=
"STATUS" operation=3D"profile_load" name=3D"/usr/bin/evince-previewer//sani=
tized_helper" pid=3D860 comm=3D"apparmor_parser"=0A[   34.691328] type=3D14=
00 audit(1413539179.626:29): apparmor=3D"STATUS" operation=3D"profile_load"=
 name=3D"/usr/bin/evince-thumbnailer" pid=3D860 comm=3D"apparmor_parser"=0A=
[   34.692937] type=3D1400 audit(1413539179.630:30): apparmor=3D"STATUS" op=
eration=3D"profile_load" name=3D"/usr/bin/evince-thumbnailer//sanitized_hel=
per" pid=3D860 comm=3D"apparmor_parser"=0A[   39.634870] type=3D1400 audit(=
1413539184.570:31): apparmor=3D"DENIED" operation=3D"capable" parent=3D1 pr=
ofile=3D"/usr/sbin/cupsd" pid=3D817 comm=3D"cupsd" pid=3D817 comm=3D"cupsd"=
 capability=3D36  capname=3D"block_suspend"=0A[   57.976888] type=3D1400 au=
dit(1413539202.914:32): apparmor=3D"DENIED" operation=3D"open" parent=3D1 p=
rofile=3D"/usr/lib/telepathy/mission-control-5" name=3D"/usr/share/gvfs/rem=
ote-volume-monitors/" pid=3D1609 comm=3D"mission-control" requested_mask=3D=
"r" denied_mask=3D"r" fsuid=3D1000 ouid=3D0=0Artos@rtos-pc-104:~$ =0A=0A=0A=
=0AOn Thursday, October 16, 2014 6:43 PM, Gilles Chanteperdrix <gilles.chan=
teperdrix@xenomai.org> wrote:=0A =0A=0A=0AOn Thu, Oct 16, 2014 at 06:04:02A=
M -0700, R=F3bert Marc wrote:=0A> Dear Xenomai community,=0A=0AHi,=0A=0A> =
=0A> I am experiencing problems with my Advantech card under Xenomai.=0A> P=
lease note that the card (Advantech PCM-3680I) functions=0A> perfectly unde=
r non-RT Linux (Ubuntu 12.04). I can send and=0A> receive messages.  Althou=
gh the modules are loaded the devices=0A> can't be seen. See details below.=
=0A> =0A> =0A> Here are some technical details:=0A> =0A> rtos@rtos-pc-104:~=
$ sudo rtcanconfig rtcan0 -b 1000000 -v start=0A> mode: start (0x1)=0A> Can=
't get interface index for rtcan0, code =3D -19=0A> =0A> =0A> >>  what is e=
rror code -19?=0A=0Ahttp://xenomai.org/2014/06/resolving-error-codes/=0A=0A=
=0A> =0A> =0A> rtos@rtos-pc-104:~$ lsmod | grep adv=0A> xeno_can_adv_pci   =
    12730  0 =0A> advcan                             707511  4 =0A> xeno_ca=
n_sja1000       17366  1 xeno_can_adv_pci=0A> xeno_can                     =
    28373  2 xeno_can_adv_pci,xeno_can_sja1000=0A> =0A> =0A> >> drivers are=
 loaded =0A> =0A> =0A> rtos@rtos-pc-104:~$ dmesg | grep CAN=0A> [    4.3416=
07] RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Team=0A> [   =
 4.372061] RTCAN SJA1000 driver initialized=0A> [    4.405671] ADV-PCI-CAN =
0000:01:04.0: RTCAN Registering card=0A> [    4.405697] ADV-PCI-CAN 0000:01=
:04.0: RTCAN detected Advantech PCI card at slot #4=0A> [    4.405712] ADV-=
PCI-CAN: Initializing device 13fe:c002:c002=0A> [    4.405731] ADV-PCI-CAN:=
 base_addr=3D0001ef00 conf_addr=3D  (null) irq=3D16 ocr=3D0xfa cdr=3D0xc0=
=0A> [    4.405811] RTCAN: unregistered rtcan0=0A> [    4.405836] ADV-PCI-C=
AN: probe of 0000:01:04.0 failed with error -5=0A> [    4.494279] CAN Commu=
nication Driver.=0A> [    4.514136] Advantech CAN Port CAN Driver (c) Oct  =
3 2014 15:12:52=0A> [    4.514202] Advanteh PCI CAN devie c002 found( 2 CAN=
 port)=0A> =0A> =0A> >> conf_addr=3D  (null) might be the problem???=0A=0AW=
ell from these traces, the rtcan0 device is registered, then=0Aunregistered=
, no need to go further, rtcanconfig will not be able to=0Afind it, this ex=
plains the ENODEV.=0A=0Aconf_addr set to null should not be the problem, as=
 the driver code=0Asets it to NULL, then never uses it. See:=0Ahttp://git.x=
enomai.org/xenomai-2.6.git/tree/ksrc/drivers/can/sja1000/rtcan_adv_pci.c=0A=
=0AMaybe the full traces contain the reason for unregistering rtcan0?=0A=0A=
-- =0A                        Gilles.
