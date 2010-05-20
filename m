Message-ID: <4BF50124.20801@domain.hid>
Date: Thu, 20 May 2010 11:30:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <201005191125.51812.smolorz@domain.hid>
In-Reply-To: <201005191125.51812.smolorz@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [BUG] Interrupt recursion with libata-sff
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Sebastian Smolorz <smolorz@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

Sebastian Smolorz wrote:
> Hi Philippe,
> 
> our x86 systems are unbootable with an I-pipe patched kernel since version 
> 2.5-00. I identified the following commit as responsible for the bug:
> 
> commit ae1b39a521d535d6dbd61046666348c106d45f5e (ipipe: disable IRQ 
> recursion guard for the root domain)
> 
> When I revert the change introduced by this commit our systems boot also 
> with latest I-pipe version 2.6-03 successfully.
> 
> I have attached the boot log from an unsuccessful boot sequence.
> 
> Sebastian
> 
> 
> [    0.000000] Linux version 2.6.34-rc5 (smolorz@domain.hid) (gcc version 4.2.1 (SUSE Linux)) #5 PREEMPT Wed May 19 09:57:55 CEST 2010                                                                                                               
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000]  BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
> [    0.000000]  BIOS-e820: 000000000009ec00 - 00000000000a0000 (reserved)
> [    0.000000]  BIOS-e820: 00000000000c0000 - 00000000000c8000 (reserved)
> [    0.000000]  BIOS-e820: 00000000000dc000 - 00000000000e0000 (reserved)
> [    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
> [    0.000000]  BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
> [    0.000000]  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
> [    0.000000] Notice: NX (Execute Disable) protection missing in CPU or disabled in BIOS!
> [    0.000000] DMI not present or invalid.
> [    0.000000] last_pfn = 0x10000 max_arch_pfn = 0x100000
> [    0.000000] init_memory_mapping: 0000000000000000-0000000010000000
> [    0.000000] ACPI Error: A valid RSDP was not found (20100121/tbxfroot-219)
> [    0.000000] 256MB LOWMEM available.
> [    0.000000]   mapped low ram: 0 - 10000000
> [    0.000000]   low ram: 0 - 10000000
> [    0.000000] Zone PFN ranges:
> [    0.000000]   DMA      0x00000001 -> 0x00001000
> [    0.000000]   Normal   0x00001000 -> 0x00010000
> [    0.000000] Movable zone start PFN for each node
> [    0.000000] early_node_map[2] active PFN ranges
> [    0.000000]     0: 0x00000001 -> 0x0000009e
> [    0.000000]     0: 0x00000100 -> 0x00010000
> [    0.000000] Allocating PCI resources starting at 10000000 (gap: 10000000:effc0000)
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64925
> [    0.000000] Kernel command line: root=/dev/sda1 ro vga=773 libata.dma=0 console=ttyS0
> [    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
> [    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> [    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> [    0.000000] Initializing CPU#0
> [    0.000000] Subtract (21 early reservations)
> [    0.000000]   #0 [0001000000 - 0001371970]   TEXT DATA BSS
> [    0.000000]   #1 [000009ec00 - 0000100000]   BIOS reserved
> [    0.000000]   #2 [0001372000 - 0001378000]             BRK
> [    0.000000]   #3 [0001378000 - 0001578000]         BOOTMEM
> [    0.000000]   #4 [0001371980 - 0001371984]         BOOTMEM
> [    0.000000]   #5 [00013719c0 - 0001371a40]         BOOTMEM
> [    0.000000]   #6 [0001371a40 - 0001371a58]         BOOTMEM
> [    0.000000]   #7 [0001578000 - 0001578800]         BOOTMEM
> [    0.000000]   #8 [0001371a80 - 0001371b60]         BOOTMEM
> [    0.000000]   #9 [0001371b80 - 0001371bc0]         BOOTMEM
> [    0.000000]   #10 [0001371bc0 - 0001371c00]         BOOTMEM
> [    0.000000]   #11 [0001371c00 - 0001371c40]         BOOTMEM
> [    0.000000]   #12 [0001371c40 - 0001371c80]         BOOTMEM
> [    0.000000]   #13 [0001371c80 - 0001371cc0]         BOOTMEM
> [    0.000000]   #14 [0001371cc0 - 0001371d00]         BOOTMEM
> [    0.000000]   #15 [0001371d00 - 0001371d40]         BOOTMEM
> [    0.000000]   #16 [0001371d40 - 0001371d75]         BOOTMEM
> [    0.000000]   #17 [0001371d80 - 0001371db5]         BOOTMEM
> [    0.000000]   #18 [0001578800 - 0001579800]         BOOTMEM
> [    0.000000]   #19 [0001579800 - 0001599800]         BOOTMEM
> [    0.000000]   #20 [0001599800 - 00015a9800]         BOOTMEM
> [    0.000000] Memory: 255948k/262144k available (2040k kernel code, 5800k reserved, 980k data, 264k init, 0k highmem)
> [    0.000000] virtual kernel memory layout:
> [    0.000000]     fixmap  : 0xfffe4000 - 0xfffff000   ( 108 kB)
> [    0.000000]     vmalloc : 0xd0800000 - 0xfffe2000   ( 759 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
> [    0.000000]       .init : 0xc12f4000 - 0xc1336000   ( 264 kB)
> [    0.000000]       .data : 0xc11fe221 - 0xc12f3300   ( 980 kB)
> [    0.000000]       .text : 0xc1000000 - 0xc11fe221   (2040 kB)
> [    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000] NR_IRQS:16
> [    0.000000] I-pipe 2.6-03: pipeline enabled.
> [    0.000000] Console: colour dummy device 80x25
> [    0.000000] console [ttyS0] enabled
> [    0.000000] Fast TSC calibration using PIT
> [    0.000000] Detected 267.290 MHz processor.
> [    0.012025] Calibrating delay loop (skipped), value calculated using timer frequency.. 534.58 BogoMIPS (lpj=1069160)
> [    0.024518] Mount-cache hash table entries: 512
> [    0.032751] Intel Pentium with F0 0F bug - workaround enabled.
> [    0.036290] Performance Events: no PMU driver, software events only.
> [    0.044016] CPU: Intel Mobile Pentium MMX stepping 01
> [    0.060036] Checking 'hlt' instruction... OK.
> [    0.090307] NET: Registered protocol family 16
> [    0.110904] PCI: PCI BIOS revision 2.10 entry at 0xfd900, last bus=0
> [    0.112029] PCI: Using configuration type 1 for base access
> [    0.168873] bio: create slab <bio-0> at 0
> [    0.173480] ACPI: Interpreter disabled.
> [    0.178407] vgaarb: loaded
> [    0.185920] SCSI subsystem initialized
> [    0.193905] PCI: Probing PCI hardware
> [    0.197833] * Found PM-Timer Bug on the chipset. Due to workarounds for a bug,
> [    0.197857] * this clock source is slow. Consider trying other clock sources
> [    0.200191] pci 0000:00:07.3: quirk: [io  0x1000-0x103f] claimed by PIIX4 ACPI
> [    0.204051] pci 0000:00:07.3: quirk: [io  0x1040-0x104f] claimed by PIIX4 SMB
> [    0.216845] vgaarb: device added: PCI:0000:00:14.0,decodes=io+mem,owns=io+mem,locks=none
> [    0.225681] PCI: Discovered primary peer bus 01 [IRQ]
> [    0.228127] pci 0000:00:07.0: PIIX/ICH IRQ router [8086:7110]
> [    0.237509] Switching to clocksource tsc
> [    0.240347] pnp: PnP ACPI: disabled
> [    0.290574] pci 0000:00:12.0: BAR 6: assigned [mem 0x10000000-0x100fffff pref]
> [    0.377121] pci 0000:00:14.0: BAR 6: assigned [mem 0x10100000-0x1013ffff pref]
> [    0.464020] NET: Registered protocol family 2
> [    0.516483] IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
> [    0.600328] TCP established hash table entries: 8192 (order: 4, 65536 bytes)
> [    0.685436] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
> [    0.762866] TCP: Hash tables configured (established 8192 bind 8192)
> [    0.838862] TCP reno registered
> [    0.876417] UDP hash table entries: 256 (order: 0, 4096 bytes)
> [    0.946237] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
> [    1.022432] NET: Registered protocol family 1
> [    1.074635] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
> [    1.149969] platform rtc_cmos: registered platform RTC device (no PNP device found)
> [    1.245800] I-pipe: Domain Xenomai registered.
> [    1.299043] Xenomai: hal/i386 started.
> [    1.343994] Xenomai: scheduling class idle registered.
> [    1.405431] Xenomai: scheduling class rt registered.
> [    1.466372] Xenomai: real-time nucleus v2.5.3 (Hordes Of Locusts) loaded.
> [    1.549771] NTFS driver 2.1.29 [Flags: R/O].
> [    1.601172] msgmni has been set to 499
> [    1.646731] alg: No test for stdrng (krng)
> [    1.695901] io scheduler noop registered
> [    1.742800] io scheduler deadline registered
> [    1.794018] io scheduler cfq registered (default)
> [    1.854811] vesafb: framebuffer at 0xfd000000, mapped to 0xd0880000, using 1536k, total 2048k
> [    1.956840] vesafb: mode is 1024x768x8, linelength=1024, pages=0
> [    2.028685] vesafb: protected mode interface info at c000:7560
> [    2.098450] vesafb: pmi: set display start = c00c75b8, set palette = c00c75d7
> [    2.183807] vesafb: pmi: ports = 3c0 3d4 3d5 3d6 3d7 3d8 3d9 3da 3c7 3c8 3c9 
> [    2.269764] vesafb: scrolling: redraw
> [    2.313532] vesafb: Pseudocolor: size=6:6:6:6, shift=0:0:0:0
> [    2.417227] Console: switching to colour frame buffer device 128x48
> [    2.522817] fb0: VESA VGA frame buffer device
> [    3.396110] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> [    3.473429] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> [    3.547377] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> [    3.662038] brd: module loaded
> [    3.704340] scsi0 : ata_piix
> [    3.740375] scsi1 : ata_piix
> [    3.775868] ata1: PATA max UDMA/33 cmd 0x1f0 ctl 0x3f6 bmdma 0x1050 irq 14
> [    3.858166] ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0x1058 irq 15
> [    3.949209] PNP: No PS/2 controller found. Probing ports directly.
> [    4.041549] Clocksource tsc unstable (delta = 471093026 ns)
> [    4.108465] Switching to clocksource pit
> [    4.268305] ata1.00: CFA: SanDisk SDCFH-1024, HDX 4.04, max MWDMA2
> [    4.271401] ata1.00: 2001888 sectors, multi 0: LBA 
> [    4.276299] ata1.00: configured for PIO4
> [    4.297080] scsi 0:0:0:0: Direct-Access     ATA      SanDisk SDCFH-10 HDX  PQ: 0 ANSI: 5
> [    4.305330] sd 0:0:0:0: [sda] 2001888 512-byte logical blocks: (1.02 GB/977 MiB)
> [    4.309344] sd 0:0:0:0: [sda] Write Protect is off
> [    4.312176] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> [    4.321402]  sda: sda1 sda2 < sda5 >
> [    4.353303] sd 0:0:0:0: [sda] Attached SCSI removable disk
> [    4.379791] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    4.390356] mice: PS/2 mouse device common for all mice
> [    4.396441] input: PC Speaker as /class/input/input0
> [    4.403537] cpuidle: using governor ladder
> [    4.411578] TCP cubic registered
> [    4.415415] NET: Registered protocol family 17
> [    4.435784] VFS: Mounted root (ext2 filesystem) readonly on device 8:1.
> [    4.439476] Freeing unused kernel memory: 264k freed
> [    4.490390] BUG: unable to handle kernel paging request at 00cfd5ce
> [    4.491348] IP: [<c117e792>] ata_sff_interrupt+0x4f/0x177
> [    4.491348] *pde = 00000000 
> [    4.491348] Oops: 0000 [#1] PREEMPT 
> [    4.491348] last sysfs file: 
> [    4.491348] Modules linked in:
> [    4.491348] 
> [    4.491348] Pid: 0, comm: swapper Not tainted 2.6.34-rc5 #5 /
> [    4.491348] EIP: 0060:[<c117e792>] EFLAGS: 00010007 CPU: 0
> [    4.491348] EIP is at ata_sff_interrupt+0x4f/0x177
> [    4.491348] EAX: cfd4dded EBX: 00000000 ECX: 00cfd5c0 EDX: cfd4ddec
> [    4.491348] ESI: 00000000 EDI: 00000000 EBP: c12c8038 ESP: c12c8014
> [    4.491348]  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
> [    4.491348] Process swapper (pid: 0, ti=c12c6000 task=c12ce340 task.ti=c12c8000)
> [    4.491348] I-pipe domain Linux
> [    4.491348] Stack:
> [    4.491348]  cfd4dded 00000000 00000000 00000000 00000200 0000000e cfd4dd60 0000000e
> [    4.491348] <0> 00000000 c12c8050 c103c9df 00000000 c12d7618 cfd4dd60 0000000e c12c8064
> [    4.491348] <0> c103e6dd 0000000e 0000003e 0000000e c12c8070 c1003e46 c12d4d9c c12c8088
> [    4.491348] Call Trace:
> [    4.491348]  [<c103c9df>] ? handle_IRQ_event+0x28/0xa7
> [    4.491348]  [<c103e6dd>] ? handle_level_irq+0x46/0xc3
> [    4.491348]  [<c1003e46>] ? handle_irq+0x1a/0x24
> [    4.491348]  [<c1003b7d>] ? do_IRQ+0x33/0x75
> [    4.491348]  [<c1003b4a>] ? do_IRQ+0x0/0x75
> [    4.491348]  [<c104000c>] ? __ipipe_sync_stage+0xea/0xef
> [    4.491348]  [<c1003b4a>] ? do_IRQ+0x0/0x75
> [    4.491348]  [<c1040011>] ? __xirq_end+0x0/0x39
> [    4.491348]  [<c1003b4a>] ? do_IRQ+0x0/0x75
> [    4.491348]  [<c10109d8>] ? __ipipe_unstall_iret_root+0x39/0x3b
> [    4.491348]  [<c11fd4a0>] ? restore_ret+0x0/0xe
> [    4.491348]  [<c1003b4a>] ? do_IRQ+0x0/0x75
> [    4.491348]  [<c1040011>] ? __xirq_end+0x0/0x39
> [    4.491348]  [<c1003b4a>] ? do_IRQ+0x0/0x75
> [    4.491348]  [<c10109d8>] ? __ipipe_unstall_iret_root+0x39/0x3b
> [    4.491348]  [<c11fd4a0>] ? restore_ret+0x0/0xe
> [    4.491348]  [<c1003b4a>] ? do_IRQ+0x0/0x75
> [    4.491348]  [<c1040011>] ? __xirq_end+0x0/0x39
> [    4.491348]  [<c1003b4a>] ? do_IRQ+0x0/0x75
> [    4.491348]  [<c10109d8>] ? __ipipe_unstall_iret_root+0x39/0x3b
> [    4.491348]  [<c11fd4a0>] ? restore_ret+0x0/0xe
> [    4.491348]  [<c1003b4a>] ? do_IRQ+0x0/0x75
> [    4.491348]  [<c1040011>] ? __xirq_end+0x0/0x39
> [    4.491348]  [<c1003b4a>] ? do_IRQ+0x0/0x75
> [    4.491348]  [<c10109d8>] ? __ipipe_unstall_iret_root+0x39/0x3b
> [    4.491348]  [<c11fd4a0>] ? restore_ret+0x0/0xe
> [    4.491348]  [<c1003b4a>] ? do_IRQ+0x0/0x75
> [    4.491348]  [<c1040011>] ? __xirq_end+0x0/0x39
> [    4.491348]  [<c1003b4a>] ? do_IRQ+0x0/0x75
> [    4.491348]  [<c10109d8>] ? __ipipe_unstall_iret_root+0x39/0x3b
> [    4.491348]  [<c11fd4a0>] ? restore_ret+0x0/0xe
> [    4.491348]  [<c1003b4a>] ? do_IRQ+0x0/0x75
> [    4.491348]  [<c1040011>] ? __xirq_end+0x0/0x39
> [    4.491348]  [<c1003b4a>] ? do_IRQ+0x0/0x75
> [    4.491348]  [<c10109d8>] ? __ipipe_unstall_iret_root+0x39/0x3b
> [    4.491348]  [<c11fd4a0>] ? restore_ret+0x0/0xe
> [    4.491348]  [<c1003b4a>] ? do_IRQ+0x0/0x75
> [    4.491348]  [<c1040011>] ? __xirq_end+0x0/0x39
> [    4.491348]  [<c1003b4a>] ? do_IRQ+0x0/0x75
> [    4.491348]  [<c10109d8>] ? __ipipe_unstall_iret_root+0x39/0x3b
> [    4.491348]  [<c11fd4a0>] ? restore_ret+0x0/0xe
> 

Looks like your problem is x86-32 returning from interrupts with hard
IRQs enabled (and therefore flushing the pipeline already over the
interrupt handler). That should ideally be unified with x86-64 now, also
as x86-64 may already gain better testing than 32 bit.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

