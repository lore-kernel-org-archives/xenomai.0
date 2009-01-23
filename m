Message-ID: <497A09E5.5080906@domain.hid>
Date: Fri, 23 Jan 2009 19:18:13 +0100
From: Federico Ridolfo <federico.ridolfo@domain.hid>
MIME-Version: 1.0
References: <4979727E.6060304@domain.hid> <49799B02.1010202@domain.hid>
	<4979F92A.70702@domain.hid> <497A074A.1050104@domain.hid>
In-Reply-To: <497A074A.1050104@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] PowerPC irq unmask
Reply-To: federico.ridolfo@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Thanks in advance.
~ # modprobe   mpc52xx_psc_spi
~ # dmesg
Using mpc5200-simple-platform machine description
Linux version 2.6.26.2-cirneco (root@domain.hid) (gcc version 4.1.0) #1
PREEMPT Fri Jan 23 16:46:14 CET 2009
console [udbg0] enabled
Entering add_active_range(0, 0, 16384) 0 entries of 256 used
PCI host bridge /pci@domain.hid (primary) ranges:
 MEM 0x0000000080000000..0x000000009fffffff -> 0x0000000080000000 Prefetc=
h
 MEM 0x00000000a0000000..0x00000000afffffff -> 0x00000000a0000000
  IO 0x00000000b0000000..0x00000000b0ffffff -> 0x0000000000000000
Top of RAM: 0x4000000, Total RAM: 0x4000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA             0 ->    16384
  Normal      16384 ->    16384
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->    16384
On node 0 totalpages: 16384
  DMA zone: 128 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 16256 pages, LIFO batch:3
  Normal zone: 0 pages used for memmap
  Movable zone: 0 pages used for memmap
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1625=
6
Kernel command line: console=3DttyPSC0 root=3D/dev/sda3 rw console=3DttyP=
SC0
irq: Allocated host of type 2 @0xc041d2a0
MPC52xx PIC is up and running!
PID hash table entries: 256 (order: 8, 1024 bytes)
time_init: decrementer frequency =3D 33.000000 MHz
time_init: processor frequency   =3D 396.000000 MHz
clocksource: timebase mult[79364d9] shift[22] registered
clockevent: decrementer mult[872] shift[16] cpu[0]
I-pipe 2.4-03: pipeline enabled.
Console: colour dummy device 80x25
irq: irq_create_mapping(0xc041d2a0, 0x81)
irq: -> using host @c041d2a0
irq: -> obtained virq 129
console handover: boot [udbg0] -> real [ttyPSC0]
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 61180k/65536k available (3304k kernel code, 4288k reserved, 140k
data, 207k bss, 144k init)
Calibrating delay loop... 65.79 BogoMIPS (lpj=3D131584)
Mount-cache hash table entries: 512
net_namespace: 192 bytes
NET: Registered protocol family 16
irq: irq_create_mapping(0xc041d2a0, 0x8f)
irq: -> using host @c041d2a0
irq: -> obtained virq 143
irq: irq_create_mapping(0xc041d2a0, 0x90)
irq: -> using host @c041d2a0
irq: -> obtained virq 144
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of PCI bridge 1, will remap
PCI: Cannot allocate resource region 1 of PCI bridge 1, will remap
PCI: Bridge: 0000:00:0f.0
  IO window: 1000-1fff
  MEM window: 0xa0000000-0xa00fffff
  PREFETCH window: 0x0000000080000000-0x00000000800fffff
DMA: MPC52xx BestComm driver
DMA: MPC52xx BestComm engine @f0001200 ok !
SCSI subsystem initialized
libata version 3.00 loaded.
Switched to high resolution mode on CPU 0
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
NET: Registered protocol family 1
I-pipe: Domain Xenomai registered.
Xenomai: hal/powerpc started.
Xenomai: real-time nucleus v2.5-devel (Flying In A Blue Dream) loaded.
Xenomai: debug mode enabled.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
JFFS2 version 2.2. (NAND) =A9 2001-2006 Red Hat, Inc.
msgmni has been set to 119
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci 0000:01:04.0: Firmware left e100 interrupts enabled; disabling
pci 0000:01:05.0: Firmware left e100 interrupts enabled; disabling
Serial: 8250/16550 driver $Revision: 1.90 $ 16 ports, IRQ sharing enabled
Serial: MPC52xx PSC UART driver
irq: irq_create_mapping(0xc041d2a0, 0x81)
irq: -> using host @c041d2a0
irq: -> existing mapping on virq 129
f0002000.serial: ttyPSC0 at MMIO 0xf0002000 (irq =3D 129) is a MPC52xx PS=
C
irq: irq_create_mapping(0xc041d2a0, 0x82)
irq: -> using host @c041d2a0
irq: -> obtained virq 130
f0002200.serial: ttyPSC1 at MMIO 0xf0002200 (irq =3D 130) is a MPC52xx PS=
C
irq: irq_create_mapping(0xc041d2a0, 0x8b)
irq: -> using host @c041d2a0
irq: -> obtained virq 139
f0002600.serial: ttyPSC3 at MMIO 0xf0002600 (irq =3D 139) is a MPC52xx PS=
C
irq: irq_create_mapping(0xc041d2a0, 0x8c)
irq: -> using host @c041d2a0
irq: -> obtained virq 140
f0002800.serial: ttyPSC4 at MMIO 0xf0002800 (irq =3D 140) is a MPC52xx PS=
C
eepro100.c:v1.09j-t 9/29/99 Donald Becker
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@domain.hid> and others
eepro100 0000:01:04.0: enabling device (0006 -> 0007)
eth0: OEM i82557/i82558 10/100 Ethernet, 00:40:42:01:2a:e3, IRQ 0.
  Board assembly ffffff-255, Physical connectors present: RJ45 BNC AUI MI=
I
  Primary interface chip unknown-15 PHY #31.
    Secondary interface chip i82555.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x14c7a6d0).
eepro100 0000:01:05.0: enabling device (0006 -> 0007)
eth1: OEM i82557/i82558 10/100 Ethernet, 00:40:42:01:2a:e4, IRQ 0.
  Board assembly ffffff-255, Physical connectors present: RJ45 BNC AUI MI=
I
  Primary interface chip unknown-15 PHY #31.
    Secondary interface chip i82555.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x14c7a6d0).
e100: Intel(R) PRO/100 Network Driver, 3.5.23-k4-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
mpc52xx MII bus: probed
irq: irq_create_mapping(0xc041d2a0, 0xc0)
irq: -> using host @c041d2a0
irq: -> obtained virq 192
irq: irq_create_mapping(0xc041d2a0, 0xc1)
irq: -> using host @c041d2a0
irq: -> obtained virq 193
irq: irq_create_mapping(0xc041d2a0, 0x85)
irq: -> using host @c041d2a0
irq: -> obtained virq 133
net eth2: Using PHY at MDIO address 0
Uniform Multi-Platform E-IDE driver
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ide_generic: please use "probe_mask=3D0x3f" module parameter for probing
all legacy ISA IDE ports
Driver 'sd' needs updating - please use bus_type methods
ata: MPC52xx IDE/ATA libata driver
irq: irq_create_mapping(0xc041d2a0, 0x87)
irq: -> using host @c041d2a0
irq: -> obtained virq 135
scsi0 : mpc52xx_ata
ata1: PATA max PIO4 ata_regs 0xf0003a00 irq 135
ata1.00: ATA-4: TRANSCEND, 20070418, max UDMA/66
ata1.00: 994896 sectors, multi 0: LBA
ata1.00: configured for PIO4
scsi 0:0:0:0: Direct-Access     ATA      TRANSCEND        2007 PQ: 0 ANSI=
: 5
sd 0:0:0:0: [sda] 994896 512-byte hardware sectors (509 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:0:0:0: [sda] 994896 512-byte hardware sectors (509 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
physmap flash device (mpc5200): 1000000 at fc000000
phys_mapped_flash: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
phys_mapped_flash: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
RedBoot partition parsing not available
i2c /dev entries driver
TCP cubic registered
NET: Registered protocol family 17
802.1Q VLAN Support v1.8 Ben Greear <greearb@domain.hid>
All bugs added by David S. Miller <davem@domain.hid>
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommend=
ed
EXT3 FS on sda3, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem).
Freeing unused kernel memory: 144k init
rtc-pcf8563 1-0051: chip found, driver version 0.4.3
rtc-pcf8563 1-0051: rtc core: registered rtc-pcf8563 as rtc0
net eth2: attached phy 0 to driver LXT971
rtc-pcf8563 1-0051: low voltage detected, date/time is not reliable.
PPP generic driver version 2.4.2
PHY: f0003000:00 - Link is Up - 100/Full
irq: irq_create_mapping(0xc041d2a0, 0x83)
irq: -> using host @c041d2a0
irq: -> obtained virq 131
mpc52xx-psc-spi f0002400.spi: probe called without platform data, no
(de)activate_cs function will be called
irq: irq_create_mapping(0xc041d2a0, 0x84)
irq: -> using host @c041d2a0
irq: -> obtained virq 132
mpc52xx-psc-spi f0002c00.spi: probe called without platform data, no
(de)activate_cs function will be called

Philippe Gerum wrote:
> Federico Ridolfo wrote:
>  =20
>> Ok, i'm debugging the problem, but i have not a solution.
>> I compiled the kernel with the debug switch for irq.c.
>> In addition i added the mpc52xx_psc_spi module in my
>> .config.
>> So, now i'm sure that the irq used in mpc52xx_psc_spi
>> for the PSC3 is 131 and for PSC6 is 132:
>>
>> # dmesg
>> mpc52xx-psc-spi f0002400.spi: probe called without platform data, no
>> (de)activate_cs function will be called
>> irq: irq_create_mapping(0xc041d2a0, 0x84)
>> irq: -> using host @c041d2a0
>> irq: -> obtained virq 132
>>
>>    =20
>
> Please send all the IRQ related information, you get in the boot log, b=
ecause
> the few lines above do not match what your dts file below says.
>
> As far as I understand those lines, the generic IRQ code is asked to cr=
eate a
> virtual mapping for hwirq 132 out of the OF specs, and this hint is kep=
t so that
> you actually get virq 132. So far so good.
>
> However, to get asked for 132, your dts file should have specified an i=
ntspec
> which rather looks like { 2 4 <sense-type> } and not { 2 3 <sense-type>=
 } as
> mentioned in the spi@domain.hid block. { 2 3 <sense-type> } for PSC3 in SPI m=
ode would
> rather give us hwirq 131 (the hairy computation determining the hwirq n=
umber
> from the inspec is available from mpc52xx_irqhost_xlate()).
>
> So either you are not booting with the blob that matches the dts file b=
elow, or
> the console output above is misleading. In short, I'm lost.
>
>  =20
>> I'm using the same irqs for my rtdm spi driver, but it doesn=ECt work.
>> If i reboot the board and try my rtdm driver, the result is -ENODEV
>>
>> If i "modprobe  mpc52xx_psc_spi"  and retry my rtdm driver -> the boar=
d
>> hangs for ever.
>> I have the same result  also if i "rrmod mpc52xx_psc_spi" before.
>> My dts is:
>> /dts-v1/;
>>
>> / {
>>     model =3D "colgp,cirneco5200";
>>     compatible =3D "colgp,cirneco5200";
>>     #address-cells =3D <1>;
>>     #size-cells =3D <1>;
>>
>>     cpus {
>>         #address-cells =3D <1>;
>>         #size-cells =3D <0>;
>>
>>         PowerPC,5200@domain.hid {
>>             device_type =3D "cpu";
>>             reg =3D <0>;
>>             d-cache-line-size =3D <32>;
>>             i-cache-line-size =3D <32>;
>>             d-cache-size =3D <0x4000>;    // L1, 16K
>>             i-cache-size =3D <0x4000>;    // L1, 16K
>>             timebase-frequency =3D <0>;    // from bootloader
>>             bus-frequency =3D <0>;        // from bootloader
>>             clock-frequency =3D <0>;        // from bootloader
>>         };
>>     };
>>
>>     memory {
>>         device_type =3D "memory";
>>         reg =3D <0x00000000 0x04000000>;    // 64MB
>>         //reg =3D <0x00000000 0x08000000>;    // 64MB
>>         //reg =3D <0x00000000 0x10000000>;    // 256MB
>>     };
>>
>>     soc5200@domain.hid {
>>         #address-cells =3D <1>;
>>         #size-cells =3D <1>;
>>         compatible =3D "fsl,mpc5200b-immr";
>>         ranges =3D <0 0xf0000000 0x0000c000>;
>>         reg =3D <0xf0000000 0x00000100>;
>>         bus-frequency =3D <0>;        // from bootloader
>>         system-frequency =3D <0>;        // from bootloader
>>
>>         cdm@domain.hid {
>>             compatible =3D "fsl,mpc5200b-cdm","fsl,mpc5200-cdm";
>>             reg =3D <0x200 0x38>;
>>         };
>>
>>         mpc5200_pic: interrupt-controller@domain.hid {
>>             // 5200 interrupts are encoded into two levels;
>>             interrupt-controller;
>>             #interrupt-cells =3D <3>;
>>             device_type =3D "interrupt-controller";
>>             compatible =3D "fsl,mpc5200b-pic","fsl,mpc5200-pic";
>>             reg =3D <0x500 0x80>;
>>         };
>>
>>         // General Purpose Timer
>>         timer@domain.hid {
>>             compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>>             cell-index =3D <0>;
>>             reg =3D <0x600 0x10>;
>>             interrupts =3D <1 9 0>;
>>             interrupt-parent =3D <&mpc5200_pic>;
>>             fsl,has-wdt;
>>         };
>>
>>         timer@domain.hid {  =20
>>             compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>>             cell-index =3D <1>;
>>             reg =3D <0x610 0x10>;
>>             interrupts =3D <1 10 0>;
>>             interrupt-parent =3D <&mpc5200_pic>;
>>         };
>>
>>         timer@domain.hid {
>>             compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>>             cell-index =3D <2>;
>>             reg =3D <0x620 0x10>;
>>             interrupts =3D <1 11 0>;
>>             interrupt-parent =3D <&mpc5200_pic>;
>>         };
>>
>>         timer@domain.hid {
>>             compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>>             cell-index =3D <3>;
>>             reg =3D <0x630 0x10>;
>>             interrupts =3D <1 12 0>;
>>             interrupt-parent =3D <&mpc5200_pic>;
>>         };
>>
>>         timer@domain.hid {
>>             compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>>             cell-index =3D <4>;
>>             reg =3D <0x640 0x10>;
>>             interrupts =3D <1 13 0>;
>>             interrupt-parent =3D <&mpc5200_pic>;
>>         };
>>
>>         timer@domain.hid {
>>             compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>>             cell-index =3D <5>;
>>             reg =3D <0x650 0x10>;
>>             interrupts =3D <1 14 0>;
>>             interrupt-parent =3D <&mpc5200_pic>;
>>         };
>>
>>         timer@domain.hid {
>>             compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>>             cell-index =3D <6>;
>>             reg =3D <0x660 0x10>;
>>             interrupts =3D <1 15 0>;
>>             interrupt-parent =3D <&mpc5200_pic>;
>>         };
>>
>>         timer@domain.hid {
>>             compatible =3D "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>>             cell-index =3D <7>;
>>             reg =3D <0x670 0x10>;
>>             interrupts =3D <1 16 0>;
>>             interrupt-parent =3D <&mpc5200_pic>;
>>         };
>>
>>         rtc@domain.hid {    // Real time clock
>>             compatible =3D "fsl,mpc5200b-rtc","fsl,mpc5200-rtc";
>>             device_type =3D "rtc";
>>             reg =3D <0x800 0x100>;
>>             interrupts =3D <1 5 0 1 6 0>;
>>             interrupt-parent =3D <&mpc5200_pic>;
>>         };
>>
>>         can@domain.hid {
>>             compatible =3D "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
>>             cell-index =3D <0>;
>>             interrupts =3D <2 17 0>;
>>             interrupt-parent =3D <&mpc5200_pic>;
>>             reg =3D <0x900 0x80>;
>>         };
>>
>>         can@domain.hid {
>>             compatible =3D "fsl,mpc5200b-mscan","fsl,mpc5200-mscan";
>>             cell-index =3D <1>;
>>             interrupts =3D <2 18 0>;
>>             interrupt-parent =3D <&mpc5200_pic>;
>>             reg =3D <0x980 0x80>;
>>         };
>>       =20
>>         gpio@domain.hid {
>>             compatible =3D "fsl,mpc5200b-gpio","fsl,mpc5200-gpio";
>>             reg =3D <0xb00 0x40>;
>>             interrupts =3D <1 7 0>;
>>             interrupt-parent =3D <&mpc5200_pic>;
>>         };
>>
>>         gpio@domain.hid {
>>             compatible =3D "fsl,mpc5200b-gpio-wkup","fsl,mpc5200-gpio-=
wkup";
>>             reg =3D <0xc00 0x40>;
>>             interrupts =3D <1 8 0 0 3 0>;
>>             interrupt-parent =3D <&mpc5200_pic>;
>>         };
>>
>>         spi@domain.hid {
>>             compatible =3D "fsl,mpc5200b-spi","fsl,mpc5200-spi";
>>             reg =3D <0xf00 0x20>;
>>             interrupts =3D <2 13 0 2 14 0>;
>>             interrupt-parent =3D <&mpc5200_pic>;
>>         };
>>
>>         usb@domain.hid {
>>             compatible =3D "fsl,mpc5200b-ohci","fsl,mpc5200-ohci","ohc=
i-be";
>>             reg =3D <0x1000 0xff>;
>>             interrupts =3D <2 6 0>;
>>             interrupt-parent =3D <&mpc5200_pic>;
>>         };
>>
>>         dma-controller@domain.hid {
>>             device_type =3D "dma-controller";
>>             compatible =3D "fsl,mpc5200b-bestcomm","fsl,mpc5200-bestco=
mm";
>>             reg =3D <0x1200 0x80>;
>>             interrupts =3D <3 0 0  3 1 0  3 2 0  3 3 0
>>                           3 4 0  3 5 0  3 6 0  3 7 0
>>                           3 8 0  3 9 0  3 10 0  3 11 0
>>                           3 12 0  3 13 0  3 14 0  3 15 0>;
>>             interrupt-parent =3D <&mpc5200_pic>;
>>         };
>>
>>         xlb@domain.hid {
>>             compatible =3D "fsl,mpc5200b-xlb","fsl,mpc5200-xlb";
>>             reg =3D <0x1f00 0x100>;
>>         };
>>
>>         serial@domain.hid {        // PSC1
>>             device_type =3D "serial";
>>             compatible =3D "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-ua=
rt";
>>             port-number =3D <0>;  // Logical port assignment
>>             cell-index =3D <0>;
>>             reg =3D <0x2000 0x100>;
>>             interrupts =3D <2 1 0>;
>>             interrupt-parent =3D <&mpc5200_pic>;
>>         };
>>
>>         serial@domain.hid {        // PSC2
>>             device_type =3D "serial";
>>             compatible =3D "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-ua=
rt";
>>             cell-index =3D <1>;
>>             port-number =3D <1>;
>>             reg =3D <0x2200 0x100>;
>>             interrupts =3D <2 2 0>;
>>             interrupt-parent =3D <&mpc5200_pic>;
>>         };
>>
>>       =20
>>         spi@domain.hid {        // PSC3 in spi mode
>>             compatible =3D "fsl,mpc5200b-psc-spi","fsl,mpc5200-psc-spi=
";
>>             cell-index =3D <2>;
>>             port-number =3D <2>;
>>             reg =3D <0x2400 0x100>;
>>             interrupts =3D <2 3 0>;
>>             interrupt-parent =3D <&mpc5200_pic>;
>>         };
>>
>>         // PSC3 in CODEC mode example
>>         //i2s@domain.hid {        // PSC3
>>         //    compatible =3D "fsl,mpc5200b-psc-i2s"; //not 5200 compat=
ible
>>         //    cell-index =3D <2>;
>>         //    reg =3D <0x2400 0x100>;
>>         //    interrupts =3D <2 3 0>;
>>         //    interrupt-parent =3D <&mpc5200_pic>;
>>         //};
>>   =20
>>         //serial@domain.hid {        // PSC3
>>         //    device_type =3D "serial";
>>         //    compatible =3D "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-=
uart";
>>         //    cell-index =3D <2>;
>>         //    reg =3D <0x2400 0x100>;
>>         //    interrupts =3D <2 3 0>;
>>         //    interrupt-parent =3D <&mpc5200_pic>;
>>         //};
>>
>>         serial@domain.hid {        // PSC4 uart
>>             device_type =3D "serial";
>>             compatible =3D "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-ua=
rt";
>>             cell-index =3D <3>;
>>             port-number =3D <3>;
>>             reg =3D <0x2600 0x100>;
>>             interrupts =3D <2 11 0>;
>>             interrupt-parent =3D <&mpc5200_pic>;
>>         };
>>
>>         serial@domain.hid {        // PSC5 uart
>>             device_type =3D "serial";
>>             compatible =3D "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-ua=
rt";
>>             cell-index =3D <4>;
>>             port-number =3D <4>;
>>             reg =3D <0x2800 0x100>;
>>             interrupts =3D <2 12 0>;
>>             interrupt-parent =3D <&mpc5200_pic>;
>>         };
>>
>>         // PSC6 in spi mode example
>>         spi@domain.hid {        // PSC6
>>             compatible =3D "fsl,mpc5200b-psc-spi","fsl,mpc5200-psc-spi=
";
>>             cell-index =3D <5>;
>>             port-number =3D <5>;
>>             reg =3D <0x2c00 0x100>;
>>             interrupts =3D <2 4 0>;
>>             interrupt-parent =3D <&mpc5200_pic>;
>>         };
>>
>>       =20
>>         //serial@domain.hid { // PSC6 in UART mode
>>         //    device_type =3D "serial";
>>         //    compatible =3D "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-=
uart";
>>         //    cell-index =3D <5>;
>>         //    port-number =3D <5>;
>>         //    reg =3D <0x2c00 0x100>;
>>         //    interrupts =3D <2 4 0>;
>>         //    interrupt-parent =3D <&mpc5200_pic>;
>>         //};
>>
>>
>>         ethernet@domain.hid {
>>             device_type =3D "network";
>>             compatible =3D "fsl,mpc5200b-fec","fsl,mpc5200-fec";
>>             reg =3D <0x3000 0x400>;
>>             local-mac-address =3D [ 00 00 00 00 00 00 ];
>>             interrupts =3D <2 5 0>;
>>             interrupt-parent =3D <&mpc5200_pic>;
>>             phy-handle =3D <&phy0>;
>>         };
>>
>>         mdio@domain.hid {
>>             #address-cells =3D <1>;
>>             #size-cells =3D <0>;
>>             compatible =3D "fsl,mpc5200b-mdio", "fsl,mpc5200-mdio";
>>             reg =3D <0x3000 0x400>;    // fec range, since we need to
>> setup fec interrupts
>>             interrupts =3D <2 5 0>;    // these are for "mii command
>> finished", not link changes & co.
>>             interrupt-parent =3D <&mpc5200_pic>;
>>
>>             phy0: ethernet-phy@domain.hid {
>>                 device_type =3D "ethernet-phy";
>>                 reg =3D <0>;
>>             };
>>         };
>>
>>         ata@domain.hid {
>>             device_type =3D "ata";
>>             compatible =3D "fsl,mpc5200b-ata","fsl,mpc5200-ata";
>>             reg =3D <0x3a00 0x100>;
>>             interrupts =3D <2 7 0>;
>>             interrupt-parent =3D <&mpc5200_pic>;
>>         };
>>
>>         i2c@domain.hid {
>>             #address-cells =3D <1>;
>>             #size-cells =3D <0>;
>>             compatible =3D "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i=
2c";
>>             cell-index =3D <0>;
>>             reg =3D <0x3d00 0x40>;
>>             interrupts =3D <2 15 0>;
>>             interrupt-parent =3D <&mpc5200_pic>;
>>             fsl5200-clocking;
>>         };
>>
>>         i2c@domain.hid {
>>             #address-cells =3D <1>;
>>             #size-cells =3D <0>;
>>             compatible =3D "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i=
2c";
>>             cell-index =3D <1>;
>>             reg =3D <0x3d40 0x40>;
>>             interrupts =3D <2 16 0>;
>>             interrupt-parent =3D <&mpc5200_pic>;
>>             fsl5200-clocking;
>>             rtc@domain.hid {
>>                 device_type =3D "rtc";
>>                 compatible =3D "epson,pcf8563";
>>                 reg =3D <0x51>;
>>             };
>>         };
>>         sram@domain.hid {
>>             compatible =3D "fsl,mpc5200b-sram","fsl,mpc5200-sram","sra=
m";
>>             reg =3D <0x8000 0x4000>;
>>         };
>>     };
>>
>>     pci@domain.hid {
>>         #interrupt-cells =3D <1>;
>>         #size-cells =3D <2>;
>>         #address-cells =3D <3>;
>>         device_type =3D "pci";
>>         compatible =3D "fsl,mpc5200b-pci","fsl,mpc5200-pci";
>>         reg =3D <0xf0000d00 0x100>;
>>         interrupt-map-mask =3D <0xf800 0 0 7>;
>>         interrupt-map =3D <0xc000 0 0 1 &mpc5200_pic 0 0 3 // 1st slot
>>                  0xc000 0 0 2 &mpc5200_pic 1 1 3
>>                  0xc000 0 0 3 &mpc5200_pic 1 2 3
>>                  0xc000 0 0 4 &mpc5200_pic 1 3 3
>>
>>                  0xc800 0 0 1 &mpc5200_pic 1 1 3 // 2nd slot
>>                  0xc800 0 0 2 &mpc5200_pic 1 2 3
>>                  0xc800 0 0 3 &mpc5200_pic 1 3 3
>>                  0xc800 0 0 4 &mpc5200_pic 0 0 3>;
>>         clock-frequency =3D <0>; // From boot loader
>>         interrupts =3D <2 8 0 2 9 0 2 10 0>;
>>         interrupt-parent =3D <&mpc5200_pic>;
>>         bus-range =3D <0 0>;
>>         ranges =3D <0x42000000 0 0x80000000 0x80000000 0 0x20000000
>>               0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
>>               0x01000000 0 0x00000000 0xb0000000 0 0x01000000>;
>>     };
>> };
>>
>> Ideas? Thanks for your help
>>
>> Philippe Gerum wrote:
>>    =20
>>> Federico Ridolfo wrote:
>>>  =20
>>>      =20
>>>> Hi all,
>>>> my platform is a mpc5200b based one. I wrote
>>>> some rtdm driver for that platform on linux-2.6.18
>>>> kernel. Some info:
>>>> - ARCH=3Dppc
>>>> - no fdt (so no dts)
>>>> - u-boot
>>>> - xenomai 2.3.2,
>>>> - adeos-ipipe-2.6.18-ppc-1.5-01.patch
>>>> All works fine.
>>>>
>>>> Now i want to use:
>>>> - ARCH =3D powerpc
>>>> - linux kernel from denx: ipipe-2.6-26-powerpc-2.4-03
>>>> - fdt (so i have a dts file)
>>>> - xenomai-2.4.6.1
>>>> - u-boot
>>>> Ok. My board boots, all peripheral s work. Xenomai works, but
>>>> my rtdm drivers don't work. The problem is that the rtdm_irq_request
>>>> returns -ENODEV coming from line 166 in wrappers.h:
>>>> ...
>>>> #else /* > 2.6.19 */
>>>> #define rthal_irq_chip_enable(irq)                    \
>>>>     ({                                \
>>>>         int __err__ =3D 0;                    \
>>>>         if (unlikely(rthal_irq_handlerp(irq)->unmask =3D=3D NULL))  =
  \
>>>>             __err__ =3D -ENODEV;     \
>>>>         else                            \
>>>>             rthal_irq_handlerp(irq)->unmask(irq);        \
>>>>         __err__;                        \
>>>>     })
>>>> ...
>>>> Seems that adeos doesn't not set the unmask function. In the linux k=
ernel
>>>> the right functions for my pic in in
>>>> arch/powerpc/platforms/52xx/mpc52xx_pic.c
>>>> I thing i have to add some code in mpc52xx_pic.c in order to match
>>>> device tree table
>>>>    =20
>>>>        =20
>>> To complete my previous answer: unless you have a very particular hw =
design, it
>>> is unlikely that the PIC code is missing anything to support your boa=
rd.
>>>
>>>  =20
>>>      =20
>>>> and also something in my dts file.
>>>>    =20
>>>>        =20
>>> However, a too generic device tree description may not reflect all th=
e
>>> peripherals you have on your board, so yes, updating it may be needed=
 so that
>>> the platform code maps the hw interrupt sources you want.
>>>
>>> I suspect you will have no regular drivers on these IRQs, so /proc/in=
terrupts
>>> should not list them.
>>>
>>> The point is: are those interrupts sources known from the kernel? Ena=
bling the
>>> debug switch in arch/powerpc/kernel/irq.c should give you some hints =
about which
>>> hw IRQ sources are actually enumerated then mapped on your board (rem=
ember to
>>> increase the console_loglevel or set ignore_loglevel to get this oupu=
t). If you
>>> don't find those you need, then you will likely want to fix the dts f=
ile.
>>>
>>>  Any help is very usefull!!!
>>>  =20
>>>      =20
>>>> Thanks
>>>>
>>>>
>>>> --
>>>> chicco
>>>>
>>>> _______________________________________________
>>>> Xenomai-help mailing list
>>>> Xenomai-help@domain.hid
>>>> https://mail.gna.org/listinfo/xenomai-help
>>>>
>>>>    =20
>>>>        =20
>>>  =20
>>>      =20
>>
>>    =20
>
>
>  =20


