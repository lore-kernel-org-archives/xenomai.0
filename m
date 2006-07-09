Subject: Re: [Xenomai-core] nervous nmi-watchdog
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <17584.64392.157061.788526@domain.hid>
References: <44736EE4.2060807@domain.hid> <44845D59.5040608@domain.hid>
	<17540.32930.566897.960413@domain.hid>
	<448482B4.2040105@domain.hid>
	<17584.64392.157061.788526@domain.hid>
Content-Type: text/plain
Date: Sun, 09 Jul 2006 18:41:41 +0200
Message-Id: <1152463301.5027.3.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Sun, 2006-07-09 at 14:50 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > > I never observe this on my dual PIII whereas I always have the NMI
>  > > watchdog option enabled. Are you running with or without the tracer ?
>  > > 
>  > 
>  > w/o.
> 
> enabling xeno nmi watchdog whereas the nucleus module is built-in break
> Linux nmi watchdog test. Maybe some setups are not done at Linux level
> when this test fails, which could explain some weird behaviour
> afterwards.
> 
> Do you have the message:
> Testing NMI watchdog... CPU#0: NMI appears to be stuck (x->y)!
> 
> In Linux boot messages ?

Nope. The NMI test looks ok.

Linux version 2.6.17-ipipe (rpm@xenomai.org) (gcc version 3.3.3 (Debian
20040321)) #1 SMP Tue Jul 11 03:17:18 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fffd000 (usable)
 BIOS-e820: 000000003fffd000 - 000000003ffff000 (ACPI data)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f6e80
On node 0 totalpages: 262141
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 32765 pages, LIFO batch:7
DMI 2.0 present.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #1 6:8 APIC version 17
Processor #0 6:8 APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 2
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Built 1 zonelists
Kernel command line: root=/dev/hdc1 ro nmi_watchdog=1 vga=1 console=tty0
console=ttyS0,115200
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 751.749 MHz processor.
Using tsc for high-res timesource
I-pipe 1.3-07: pipeline enabled.
Console: colour VGA+ 80x50
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1032916k/1048564k available (2491k kernel code, 15100k reserved,
743k data, 272k init, 131060k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay using timer specific routine.. 1505.65 BogoMIPS
(lpj=7528285)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000
00000000 00000000
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 28k freed
CPU0: Intel Pentium III (Coppermine) stepping 03
Booting processor 1/0 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 1503.45 BogoMIPS
(lpj=7517293)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000
00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000
00000000 00000000
CPU1: Intel Pentium III (Coppermine) stepping 03
Total of 2 processors activated (3009.11 BogoMIPS).
ExtINT not setup in hardware but reported by MP table
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=0 pin2=0
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=1897
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xf0730, last bus=1
Setting up standard PCI resources
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI quirk: region e400-e43f claimed by PIIX4 ACPI
PCI quirk: region e800-e80f claimed by PIIX4 SMB
PIIX4 devres B PIO at 0290-0297
Boot video device is 0000:01:00.0
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:04.0
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: e1800000-e2dfffff
  PREFETCH window: e2f00000-e3ffffff
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 9, 2621440 bytes)
TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
IA-32 Microcode Update Driver: v1.14 <tigran@domain.hid>
I-pipe: Domain Xenomai registered.
Xenomai: hal/x86 started.
Xenomai: real-time nucleus v2.2-rc3 (Engines Of Creation) loaded.
Xenomai: NMI watchdog started (threshold=100 us).
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@domain.hid).
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Limiting direct PCI/PCI transfers.
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:04.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
Probing IDE interface ide1...
hdc: SAMSUNG SV2044D, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: max request size: 128KiB
hdc: 39862368 sectors (20409 MB) w/472KiB Cache, CHS=39546/16/63,
UDMA(33)
hdc: cache flushes not supported
 hdc: hdc1 hdc2
usbmon: debugfs is not available
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
EISA: Probing bus 0 at eisa.0
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Testing NMI watchdog ... <6>input: AT Raw Set 2 keyboard
as /class/input/input0
OK.
Starting balanced_irq
Using IPI Shortcut mode
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 272k freed
EXT3 FS on hdc1, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:09.0: 3Com PCI 3c980C Python-T at f880e000.
0000:00:0a.0: 3Com PCI 3c980C Python-T at f8810000.
eth0:  setting half-duplex.
netconsole: local port 6665
netconsole: interface eth0
netconsole: remote port 6666
netconsole: remote IP 192.168.0.8
netconsole: remote ethernet address 00:11:2f:0c:f1:ca
netconsole: local IP 192.168.0.7
netconsole: network logging started


-- 
Philippe.



