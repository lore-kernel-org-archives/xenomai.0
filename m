Message-ID: <4FDE2A66.8000904@laposte.net>
Date: Sun, 17 Jun 2012 21:05:10 +0200
From: Marc Le Douarain <marc.le-douarain@laposte.net>
MIME-Version: 1.0
References: <4FCD0BD8.70103@laposte.net> <4FCD0C4D.6000004@xenomai.org>
	<4FD4EB23.7080203@laposte.net> <4FD4FF04.2030804@xenomai.org>
	<4FD61BF8.9090901@laposte.net> <4FD62635.7040501@xenomai.org>
In-Reply-To: <4FD62635.7040501@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] "illegal instruction",
 then "rt_task_start()" error -38 (on a 486/no fpu)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Le 11/06/2012 19:09, Gilles Chanteperdrix a écrit :
> I think vortex86sx has a tsc, so, you should try and modify the linux
> kernel configuration to select  CONFIG_X86_TSC, or simply select a
> processor which has a tsc. You will get better latencies.
>
I've made two more tests:
- compiling for Pentium-Classic (M586-TSC)
=> Kernel doesn't boot at all
(I've seen invalid opcode, and after I-pipe stack call-trace 
ftrace_make_nop)

- modifying arch/x86/Kconfig.cpu (there isn't any M486-TSC ! and X86-TSC 
can't be acceded directly!?)
   in config X86_TSC, adding for depends on M486
=> But also kernel not working.

I'm finally not sure if there is a TSC available in the Vortex86sx,
perhaps only on the Vortex86dx (fpu difference only normally),
or none !?

Here with my previous 486 kernel, what gives /proc/cpuinfo:
processor       : 0
vendor_id       : CyrixInstead
cpu family      : 4
model           : 1
model name      : Cx486SLC
stepping        : unknown
fdiv_bug        : yes
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : no
fpu_exception   : no
cpuid level     : -1
wp              : yes
flags           :
bogomips        : 96.51
clflush size    : 32
cache_alignment : 32
address sizes   : 32 bits physical, 32 bits virtual
power management:


If could be interesting, here the kernel messages with my 486 + X86_TSC 
kernel:
(we can see strange frequency detected by Xenomai before inits failures)

[    0.000000] Linux version 2.6.38.8-xeno_mld (marc@marc-laptop-airis) 
(gcc version 4.6.1 (Ubuntu/Linaro 4.6.1-9ubuntu3) ) #9 Sun Jun 17 
14:42:40 CEST 2012
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
[    0.000000]  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
[    0.000000] Notice: NX (Execute Disable) protection missing in CPU!
[    0.000000] DMI not present or invalid.
[    0.000000] last_pfn = 0x8000 max_arch_pfn = 0x100000
[    0.000000] init_memory_mapping: 0000000000000000-0000000008000000
[    0.000000] 0MB HIGHMEM available.
[    0.000000] 128MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 08000000
[    0.000000]   low ram: 0 - 08000000
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   Normal   0x00001000 -> 0x00008000
[    0.000000]   HighMem  empty
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x00008000
[    0.000000] Allocating PCI resources starting at 8000000 (gap: 
8000000:f7000000)
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  
Total pages: 32399
[    0.000000] Kernel command line: root=/dev/sda2 console=tty1 
console=ttyS0,115200n8 BOOT_IMAGE=kernxeno
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 
bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] allocated 655040 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't 
want memory cgroups
[    0.000000] Initializing HighMem for node 0 (00000000:00000000)
[    0.000000] Memory: 120672k/131072k available (4078k kernel code, 
9948k reserved, 2447k data, 488k init, 0k highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xfffe4000 - 0xfffff000   ( 108 kB)
[    0.000000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff7fe000   ( 879 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]       .init : 0xc1660000 - 0xc16da000   ( 488 kB)
[    0.000000]       .data : 0xc13fbaf2 - 0xc165fac0   (2447 kB)
[    0.000000]       .text : 0xc1000000 - 0xc13fbaf2   (4078 kB)
[    0.000000] Checking if this processor honours the WP bit even in 
supervisor mode...Ok.
[    0.000000] SLUB: Genslabs=15, HWalign=32, Order=0-3, MinObjects=0, 
CPUs=1, Nodes=1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] I-pipe 2.11-02: pipeline enabled.
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty1] enabled
[    0.000000] console [ttyS0] enabled
[    0.008000] Calibrating delay loop... 96.25 BogoMIPS (lpj=192512)
[    0.084004] pid_max: default: 32768 minimum: 301
[    0.092004] Security Framework initialized
[    0.096005] AppArmor: AppArmor initialized
[    0.104005] Mount-cache hash table entries: 512
[    0.112006] Initializing cgroup subsys cpuacct
[    0.116006] Initializing cgroup subsys memory
[    0.124007] Initializing cgroup subsys devices
[    0.128007] Initializing cgroup subsys freezer
[    0.132007] Initializing cgroup subsys net_cls
[    0.136007] Initializing cgroup subsys blkio
[    0.144008] CPU: Cyrix Cx486SLC
[    0.148008] Checking 'hlt' instruction... OK.
[    0.168009] ftrace: allocating 17291 entries in 34 pages
[    0.188011] Performance Events:
[    0.272016] NET: Registered protocol family 16
[    0.280016] EISA bus registered
[    0.296017] PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=0
[    0.300018] PCI: Using configuration type 1 for base access
[    0.376022] bio: create slab <bio-0> at 0
[    0.384023] vgaarb: loaded
[    0.396024] SCSI subsystem initialized
[    0.404024] usbcore: registered new interface driver usbfs
[    0.408024] usbcore: registered new interface driver hub
[    0.416025] usbcore: registered new device driver usb
[    0.424025] PCI: Probing PCI hardware
[    0.448027] pci 0000:00:07.0: default IRQ router [17f3:6031]
[    0.452027] pci 0000:00:0a.0: address space collision: [mem 
0x000e2000-0x000e2fff] conflicts with reserved [mem 0x000e0000-0x000fffff]
[    0.456027] pci 0000:00:0a.1: address space collision: [mem 
0x000e3000-0x000e30ff] conflicts with reserved [mem 0x000e0000-0x000fffff]
[    0.460028] pci 0000:00:0b.0: address space collision: [mem 
0x000e0000-0x000e0fff] conflicts with reserved [mem 0x000e0000-0x000fffff]
[    0.464028] pci 0000:00:0b.1: address space collision: [mem 
0x000e1000-0x000e10ff] conflicts with reserved [mem 0x000e0000-0x000fffff]
[    0.472028] NetLabel: Initializing
[    0.476029] NetLabel:  domain hash size = 128
[    0.480029] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.484029] NetLabel:  unlabeled traffic allowed by default
[    0.488029] Switching to clocksource pit
[    0.914581] AppArmor: AppArmor Filesystem Enabled
[    0.922561] PnPBIOS: Scanning system for PnP BIOS support...
[    0.929492] PnPBIOS: Found PnP BIOS installation structure at 0xc00f3be0
[    0.933086] PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x45aa, dseg 
0xf0000
[    0.938563] system 00:00: [mem 0x00000000-0x0009fbff] could not be 
reserved
[    0.943898] system 00:00: [mem 0x0009fc00-0x0009ffff] could not be 
reserved
[    0.947569] system 00:00: [mem 0x000e0000-0x000fffff] could not be 
reserved
[    0.951234] system 00:00: [mem 0x00100000-0x07ffffff] could not be 
reserved
[    0.954899] system 00:00: [mem 0xff000000-0xffffffff] has been reserved
[    0.974613] system 00:08: [io  0x04d0-0x04d1] has been reserved
[    0.979824] system 00:08: [io  0x0cf8-0x0cff] could not be reserved
[    0.982805] system 00:08: [io  0xfc00-0xfc0f] has been reserved
[    0.989400] system 00:08: [io  0x0a00-0x0a0f] has been reserved
[    0.991984] system 00:08: [io  0x0a20-0x0a2f] has been reserved
[    0.994600] system 00:08: [io  0x0a10-0x0a1f] has been reserved
[    1.001249] system 00:08: [io  0x0a30-0x0a3f] has been reserved
[    1.003837] system 00:08: [io  0x0a40-0x0a4f] has been reserved
[    1.010569] system 00:08: [io  0x0a50-0x0a5f] has been reserved
[    1.026579] system 00:0c: [io  0x0a60-0x0a6f] has been reserved
[    1.034694] pnp 00:0d: disabling [io  0x03f0-0x03f5] because it 
overlaps 0000:00:0c.0 BAR 1 [io  0x03f4-0x03f7]
[    1.038884] PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
[    1.110586] pci 0000:00:0c.0: BAR 6: assigned [mem 
0x08000000-0x0801ffff pref]
[    1.118013] pci 0000:00:0a.0: BAR 0: assigned [mem 0x08020000-0x08020fff]
[    1.121509] pci 0000:00:0a.0: BAR 0: set to [mem 
0x08020000-0x08020fff] (PCI address [0x8020000-0x8020fff])
[    1.124114] pci 0000:00:0b.0: BAR 0: assigned [mem 0x08021000-0x08021fff]
[    1.127596] pci 0000:00:0b.0: BAR 0: set to [mem 
0x08021000-0x08021fff] (PCI address [0x8021000-0x8021fff])
[    1.134201] pci 0000:00:0a.1: BAR 0: assigned [mem 0x08022000-0x080220ff]
[    1.137710] pci 0000:00:0a.1: BAR 0: set to [mem 
0x08022000-0x080220ff] (PCI address [0x8022000-0x80220ff])
[    1.140310] pci 0000:00:0b.1: BAR 0: assigned [mem 0x08022100-0x080221ff]
[    1.143788] pci 0000:00:0b.1: BAR 0: set to [mem 
0x08022100-0x080221ff] (PCI address [0x8022100-0x80221ff])
[    1.150560] NET: Registered protocol family 2
[    1.156919] IP route cache hash table entries: 1024 (order: 0, 4096 
bytes)
[    1.166597] TCP established hash table entries: 4096 (order: 3, 32768 
bytes)
[    1.171227] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
[    1.175192] TCP: Hash tables configured (established 4096 bind 4096)
[    1.178652] TCP reno registered
[    1.178652] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    1.184609] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    1.187610] NET: Registered protocol family 1
[    1.198597] audit: initializing netlink socket (disabled)
[    1.206724] type=2000 audit(1339944309.204:1): initialized
[    1.438622] Xenomai has detected a CPU frequency of 0. Aborting.
[    1.446655] Xenomai: system init failed, code -19.
[    1.451993] Xenomai: native skin init failed, code -19.
[    1.457796] Xenomai: starting POSIX services.
[    1.458692] Xenomai: POSIX skin init failed, code -19.
[    1.464382] Xenomai: RTDM skin init failed, code -19.
[    1.590614] VFS: Disk quotas dquot_6.5.2
[    1.598624] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.622626] NTFS driver 2.1.30 [Flags: R/O].
[    1.630604] fuse init (API version 7.16)
[    1.638628] msgmni has been set to 235
[    1.662636] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 253)
[    1.667904] io scheduler noop registered
[    1.673944] io scheduler deadline registered
[    1.674840] io scheduler cfq registered (default)
[    1.682609] isapnp: Scanning for PnP cards...
[    2.050606] isapnp: No Plug & Play device found
[    3.194715] Serial: 8250/16550 driver, 12 ports, IRQ sharing enabled
[    3.207294] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    3.223603] serial8250: ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
[    3.237021] serial8250: ttyS3 at I/O 0x2e8 (irq = 3) is a 16550A
[    3.279379] 00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    3.297701] 00:0a: ttyS2 at I/O 0x3e8 (irq = 10) is a 16550A
[    3.312118] 00:0b: ttyS3 at I/O 0x2e8 (irq = 11) is a 16550A
[    3.378725] brd: module loaded
[    3.410729] loop: module loaded
[    3.434736] scsi0 : pata_it821x
[    3.442725] scsi1 : pata_it821x
[    3.447508] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f4 bmdma 0xfff0 irq 14
[    3.452870] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x374 bmdma 0xfff8 irq 14
[    3.486714] Fixed MDIO Bus: probed
[    3.494704] r6040: RDC R6040 NAPI net driver,version 0.28 (07Oct2011)
[    3.514698] r6040_eth_mii: probed
[    3.519193] r6040 0000:00:08.0: attached PHY driver [Generic PHY] 
(mii_bus:phy_addr=0000:00:08.0-0:01)
[    3.530740] PPP generic driver version 2.4.2
[    3.538688] tun: Universal TUN/TAP device driver, 1.6
[    3.542763] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    3.550721] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.557673] ehci_hcd 0000:00:0a.1: EHCI Host Controller
[    3.562736] ehci_hcd 0000:00:0a.1: new USB bus registered, assigned 
bus number 1
[    3.590727] ehci_hcd 0000:00:0a.1: irq 5, io mem 0x08022000
[    3.606728] ehci_hcd 0000:00:0a.1: USB 2.0 started, EHCI 1.00
[    3.614731] hub 1-0:1.0: USB hub found
[    3.622700] hub 1-0:1.0: 2 ports detected
[    3.628965] ata1.00: CFA: InnoDisk Corp. - iCF4000 512MB, 100511B, 
max UDMA/66
[    3.633922] ata1.00: 1009008 sectors, multi 0: LBA
[    3.635377] ata1.00: configured for MWDMA2
[    3.642731] scsi 0:0:0:0: Direct-Access     ATA      InnoDisk Corp. - 
1005 PQ: 0 ANSI: 5
[    3.647019] ehci_hcd 0000:00:0b.1: EHCI Host Controller
[    3.654801] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    3.659914] sd 0:0:0:0: [sda] 1009008 512-byte logical blocks: (516 
MB/492 MiB)
[    3.666735] ehci_hcd 0000:00:0b.1: new USB bus registered, assigned 
bus number 2
[    3.678761] sd 0:0:0:0: [sda] Write Protect is off
[    3.686731] sd 0:0:0:0: [sda] Write cache: disabled, read cache: 
enabled, doesn't support DPO or FUA
[    3.702758] ehci_hcd 0000:00:0b.1: irq 9, io mem 0x08022100
[    3.714835] invalid opcode: 0000 [#1]
[    3.714835] last sysfs file:
[    3.714835] Modules linked in:
[    3.714835]
[    3.714835] Pid: 3, comm: ksoftirqd/0 Not tainted 2.6.38.8-xeno_mld #9
[    3.714835] EIP: 0060:[<c1276b3c>] EFLAGS: 00000287 CPU: 0
[    3.714835] EIP is at add_timer_randomness+0x3c/0xf0
[    3.714835] EAX: fffedea9 EBX: c79cfac0 ECX: 00800100 EDX: 00800100
[    3.714835] ESI: 00000000 EDI: 00000000 EBP: c780becc ESP: c780beb4
[    3.714835]  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
[    3.714835] Process ksoftirqd/0 (pid: 3, ti=c780a000 task=c7849900 
task.ti=c7858000)
[    3.714835] I-pipe domain Linux
[    3.714835] Stack:
[    3.714835]  00000000 00000000 c7a023a0 fffedea9 00001000 c7a023a0 
c780bed4 c12773d9
[    3.714835]  c780bee8 c1211f90 00000000 c7a023a0 00000000 c780befc 
c1212171 00000000
[    3.714835]  c780ea00 c7a023a0 c780bf50 c12910d0 fffffff1 c780007b 
c102007b c7840000
[    3.714835] Call Trace:
[    3.714835]  [<c12773d9>] add_disk_randomness+0x29/0x30
[    3.714835]  [<c1211f90>] blk_update_bidi_request+0x60/0x80
[    3.714835]  [<c1212171>] blk_end_request+0x21/0x50
[    3.714835]  [<c12910d0>] scsi_io_completion+0x90/0x520
[    3.714835]  [<c102007b>] ? __enqueue_entity+0xb/0xc0
[    3.714835]  [<c1086e74>] ? __xirq_end+0x0/0x3c
[    3.714835]  [<c10873fd>] ? __ipipe_restore_root+0x1d/0x30
[    3.714835]  [<c12883ca>] scsi_finish_command+0x9a/0xf0
[    3.714835]  [<c128e404>] ? scsi_decide_disposition+0x184/0x1b0
[    3.714835]  [<c1290f78>] scsi_softirq_done+0x118/0x140
[    3.714835]  [<c10362e0>] ? __do_softirq+0x0/0x190
[    3.714835]  [<c1216f88>] blk_done_softirq+0x68/0x80
[    3.714835]  [<c1036358>] __do_softirq+0x78/0x190
[    3.714835]  [<c1003069>] ? common_interrupt+0x29/0x40
[    3.714835]  [<c1036690>] ? raise_softirq+0xc0/0xd0
[    3.714835]  [<c10362e0>] ? __do_softirq+0x0/0x190
[    3.714835] <IRQ>
[    3.714835]  [<c1036545>] ? irq_exit+0x65/0x70
[    3.714835]  [<c13faab8>] ? do_IRQ+0x48/0x94
[    3.714835]  [<c1036517>] ? irq_exit+0x37/0x70
[    3.714835]  [<c13faab8>] ? do_IRQ+0x48/0x94
[    3.714835]  [<c1086e6f>] ? __ipipe_sync_stage+0xef/0xf4
[    3.714835]  [<c13faa70>] ? do_IRQ+0x0/0x94
[    3.714835]  [<c1086e74>] ? __xirq_end+0x0/0x3c
[    3.714835]  [<c10873d2>] ? __ipipe_unstall_root+0x22/0x30
[    3.714835]  [<c10222ef>] ? finish_task_switch.isra.145+0x2f/0x80
[    3.714835]  [<c13f2cc7>] ? schedule+0x2f7/0x6a0
[    3.714835]  [<c13f2cc7>] ? schedule+0x2f7/0x6a0
[    3.714835]  [<c10237d0>] ? default_wake_function+0x10/0x20
[    3.714835]  [<c102517b>] ? __cond_resched+0x1b/0x30
[    3.714835]  [<c13f3179>] ? _cond_resched+0x29/0x30
[    3.714835]  [<c1035a75>] ? run_ksoftirqd+0x55/0xc0
[    3.714835]  [<c1035a20>] ? run_ksoftirqd+0x0/0xc0
[    3.714835]  [<c104b66c>] ? kthread+0x6c/0x80
[    3.714835]  [<c104b600>] ? kthread+0x0/0x80
[    3.714835]  [<c1003086>] ? kernel_thread_helper+0x6/0x10
[    3.714835] Code: 65 c1 89 d1 39 05 38 36 64 c1 7e 17 b8 01 00 00 00 
0f c1 05 4c 36 64 c1 a9 ff 0f 00 00 0f 85 9f 00 00 00 a1 c8 ac 61 c1 89 
45 f4 <0f> 31 89 45 ec b8 20 36 64 c1 89 55 f0 8d 55 ec 89 4d f8 b9 10
[    3.714835] EIP: [<c1276b3c>] add_timer_randomness+0x3c/0xf0 SS:ESP 
0068:c780beb4
[    3.720096] ---[ end trace c0c72ecfd80ce698 ]---
[    3.725356] Kernel panic - not syncing: Fatal exception in interrupt
[    3.728275] Pid: 3, comm: ksoftirqd/0 Tainted: G      D     
2.6.38.8-xeno_mld #9
[    3.732379] Call Trace:
[    3.735254]  [<c13ee18c>] ? panic+0x5c/0x145
[    3.740104]  [<c13f56c9>] ? oops_end+0xb9/0xc0
[    3.745142]  [<c10050d4>] ? die+0x54/0x80
[    3.749729]  [<c13f4e86>] ? do_trap+0x96/0xd0
[    3.754802]  [<c100333b>] ? do_invalid_op+0x8b/0xa0
[    3.760264]  [<c1276b3c>] ? add_timer_randomness+0x3c/0xf0
[    3.766369]  [<c104ba49>] ? wake_bit_function+0x59/0x60
[    3.768226]  [<c101eff7>] ? __wake_up_common+0x47/0x70
[    3.773966]  [<c10873fd>] ? __ipipe_restore_root+0x1d/0x30
[    3.776067]  [<c110cbdf>] ? kmem_cache_free+0xcf/0xf0
[    3.781718]  [<c10e07b3>] ? mempool_free_slab+0x13/0x20
[    3.783550]  [<c10e07b3>] ? mempool_free_slab+0x13/0x20
[    3.789388]  [<c10e0a2d>] ? mempool_free+0x5d/0xe0
[    3.790791]  [<c10151f8>] ? __ipipe_handle_exception+0xc8/0x240
[    3.797334]  [<c1142f6c>] ? bio_free+0x4c/0x50
[    3.802386]  [<c13f4bed>] ? error_code+0x5d/0x70
[    3.803623]  [<c1210000>] ? ftrace_define_fields_block_bio+0x50/0x1b0
[    3.806739]  [<c1276b3c>] ? add_timer_randomness+0x3c/0xf0
[    3.812857]  [<c12773d9>] ? add_disk_randomness+0x29/0x30
[    3.814899]  [<c1211f90>] ? blk_update_bidi_request+0x60/0x80
[    3.821265]  [<c1212171>] ? blk_end_request+0x21/0x50
[    3.822927]  [<c12910d0>] ? scsi_io_completion+0x90/0x520
[    3.828932]  [<c102007b>] ? __enqueue_entity+0xb/0xc0
[    3.834728]  [<c1086e74>] ? __xirq_end+0x0/0x3c
[    3.839841]  [<c10873fd>] ? __ipipe_restore_root+0x1d/0x30
[    3.845948]  [<c12883ca>] ? scsi_finish_command+0x9a/0xf0
[    3.847995]  [<c128e404>] ? scsi_decide_disposition+0x184/0x1b0
[    3.854758]  [<c1290f78>] ? scsi_softirq_done+0x118/0x140
[    3.860751]  [<c10362e0>] ? __do_softirq+0x0/0x190
[    3.866151]  [<c1216f88>] ? blk_done_softirq+0x68/0x80
[    3.867905]  [<c1036358>] ? __do_softirq+0x78/0x190
[    3.873391]  [<c1003069>] ? common_interrupt+0x29/0x40
[    3.875119]  [<c1036690>] ? raise_softirq+0xc0/0xd0
[    3.880593]  [<c10362e0>] ? __do_softirq+0x0/0x190
[    3.885983] <IRQ>  [<c1036545>] ? irq_exit+0x65/0x70
[    3.891845]  [<c13faab8>] ? do_IRQ+0x48/0x94
[    3.896718]  [<c1036517>] ? irq_exit+0x37/0x70
[    3.901745]  [<c13faab8>] ? do_IRQ+0x48/0x94
[    3.906743]  [<c1086e6f>] ? __ipipe_sync_stage+0xef/0xf4
[    3.912666]  [<c13faa70>] ? do_IRQ+0x0/0x94
[    3.917445]  [<c1086e74>] ? __xirq_end+0x0/0x3c
[    3.922712]  [<c10873d2>] ? __ipipe_unstall_root+0x22/0x30
[    3.928810]  [<c10222ef>] ? finish_task_switch.isra.145+0x2f/0x80
[    3.931563]  [<c13f2cc7>] ? schedule+0x2f7/0x6a0
[    3.936787]  [<c13f2cc7>] ? schedule+0x2f7/0x6a0
[    3.942007]  [<c10237d0>] ? default_wake_function+0x10/0x20
[    3.944257]  [<c102517b>] ? __cond_resched+0x1b/0x30
[    3.949879]  [<c13f3179>] ? _cond_resched+0x29/0x30
[    3.951354]  [<c1035a75>] ? run_ksoftirqd+0x55/0xc0
[    3.956831]  [<c1035a20>] ? run_ksoftirqd+0x0/0xc0
[    3.962217]  [<c104b66c>] ? kthread+0x6c/0x80
[    3.963158]  [<c104b600>] ? kthread+0x0/0x80
[    3.968012]  [<c1003086>] ? kernel_thread_helper+0x6/0x10




