Message-ID: <50016B43.3030109@laposte.net>
Date: Sat, 14 Jul 2012 14:51:15 +0200
From: Marc Le Douarain <marc.le-douarain@laposte.net>
MIME-Version: 1.0
References: <4FCD0BD8.70103@laposte.net>
	<4FCD0C4D.6000004@xenomai.org>	<4FD4EB23.7080203@laposte.net>
	<4FD4FF04.2030804@xenomai.org>	<4FD61BF8.9090901@laposte.net>
	<4FD62635.7040501@xenomai.org> <4FDE2A66.8000904@laposte.net>
	<4FDE2DDC.1080508@xenomai.org>
In-Reply-To: <4FDE2DDC.1080508@xenomai.org>
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

Le 17/06/2012 21:19, Gilles Chanteperdrix a écrit :
> On 06/17/2012 09:05 PM, Marc Le Douarain wrote:
>> Le 11/06/2012 19:09, Gilles Chanteperdrix a écrit :
>>> I think vortex86sx has a tsc, so, you should try and modify the linux
>>> kernel configuration to select  CONFIG_X86_TSC, or simply select a
>>> processor which has a tsc. You will get better latencies.
>>>
>> I've made two more tests:
>> - compiling for Pentium-Classic (M586-TSC)
>> =>  Kernel doesn't boot at all
>> (I've seen invalid opcode, and after I-pipe stack call-trace
>> ftrace_make_nop)
>>
>> - modifying arch/x86/Kconfig.cpu (there isn't any M486-TSC ! and X86-TSC
>> can't be acceded directly!?)
>>     in config X86_TSC, adding for depends on M486
>> =>  But also kernel not working.
>>
>> I'm finally not sure if there is a TSC available in the Vortex86sx,
>> perhaps only on the Vortex86dx (fpu difference only normally),
>> or none !?
> Someone on this list claimed that vortex86sx may have a tsc:
> http://www.xenomai.org/pipermail/xenomai-help/2010-01/msg00153.html
>
> I do not know for sure however.
>
>> Here with my previous 486 kernel, what gives /proc/cpuinfo:
>> processor       : 0
>> vendor_id       : CyrixInstead
>> cpu family      : 4
>> model           : 1
>> model name      : Cx486SLC
>> stepping        : unknown
>> fdiv_bug        : yes
>> hlt_bug         : no
>> f00f_bug        : no
>> coma_bug        : no
>> fpu             : no
>> fpu_exception   : no
>> cpuid level     : -1
>> wp              : yes
>> flags           :
>> bogomips        : 96.51
>> clflush size    : 32
>> cache_alignment : 32
>> address sizes   : 32 bits physical, 32 bits virtual
>> power management:
> You would have "tsc" in the flags if that cpu had a tsc. So, I guess you
> are right, this cpu does not have a tsc.
>
I've tested again with another card having this time a Vortex86DX on it.
Reused the same kernel sources, choosing "Pentium-classic" M586TSC and 
no more activated "math emulation".
And surprise it works perfectly !
So for me, it's seems not to be really the same processor, and not only 
a FPU add-on difference...
Even if when I asked ICOP, they tell me only performance & FPU 
difference, strange.

Interesting, this time here what cat /proc/cpuinfo gives me :
processor       : 0
vendor_id       : Vortex86 SoC
cpu family      : 5
model           : 2
model name      : 05/02
stepping        : 2
cpu MHz         : 799.974
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu tsc cx8
bogomips        : 1599.94
clflush size    : 32
cache_alignment : 32
address sizes   : 32 bits physical, 32 bits virtual
power management:


For information, Xenomai has been configured like that :
./configure --disable-x86-sep CFLAGS="-march=i586 
-fno-omit-frame-pointer" LDFLAGS="-march=i586"
(I was surprised that the -fno-omit-frame-pointer were again necessary!!!)

With latency -p 10000 with load, best = 19 micro-secs & worst = 63 
micro-secs.
The price is quite less for the vsx version, and even if also less 
efficient for real-time, for my application it should be yet enough (2-3 
tasks at 5-10 milli-secs) !?
(With VSX version, worst latency gives 200 micro-secs... finally not so 
much ?)


And lastly, dmesg for people that could be interested with:
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.38.8-xeno_mld (marc@marc-laptop-airis) 
(gcc ver
sion 4.6.1 (Ubuntu/Linaro 4.6.1-9ubuntu3) ) #10 Mon Jul 9 14:29:52 CEST 
2012
[    0.000000] CPU: vendor_id 'Vortex86 SoC' unknown, using generic init.
[    0.000000] CPU: Your system may be unstable.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
[    0.000000]  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
[    0.000000] Notice: NX (Execute Disable) protection missing in CPU!
[    0.000000] DMI not present or invalid.
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 
(usable) =
=> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 
(usable)
[    0.000000] last_pfn = 0x10000 max_arch_pfn = 0x100000
[    0.000000] initial memory mapped : 0 - 01c00000
[    0.000000] init_memory_mapping: 0000000000000000-0000000010000000
[    0.000000]  0000000000 - 0010000000 page 4k
[    0.000000] kernel direct mapping tables up to 10000000 @ 
1bbd000-1c00000
[    0.000000] 0MB HIGHMEM available.
[    0.000000] 256MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 10000000
[    0.000000]   low ram: 0 - 10000000
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   Normal   0x00001000 -> 0x00010000
[    0.000000]   HighMem  empty
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x00010000
[    0.000000] On node 0 totalpages: 65423
[    0.000000] free_area_init_node: node 0, pgdat c1649ba0, node_mem_map 
cfdff20
0
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3951 pages, LIFO batch:0
[    0.000000]   Normal zone: 480 pages used for memmap
[    0.000000]   Normal zone: 60960 pages, LIFO batch:15
[    0.000000] Allocating PCI resources starting at 10000000 (gap: 
10000000:ef00
0000)
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  
Total pag
es: 64911
[    0.000000] Kernel command line: root=/dev/sda2 BOOT_IMAGE=kernxeno
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 
bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 
bytes)
[    0.000000] Initializing CPU#0
[    0.000000] allocated 1310400 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't 
want memor
y cgroups
[    0.000000] Initializing HighMem for node 0 (00000000:00000000)
[    0.000000] Memory: 249920k/262144k available (4022k kernel code, 
11772k rese
rved, 2439k data, 488k init, 0k highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xfffe4000 - 0xfffff000   ( 108 kB)
[    0.000000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff7fe000   ( 751 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]       .init : 0xc1650000 - 0xc16ca000   ( 488 kB)
[    0.000000]       .data : 0xc13edb02 - 0xc164fa80   (2439 kB)
[    0.000000]       .text : 0xc1000000 - 0xc13edb02   (4022 kB)
[    0.000000] Checking if this processor honours the WP bit even in 
supervisor
mode...Ok.
[    0.000000] SLUB: Genslabs=15, HWalign=32, Order=0-3, MinObjects=0, 
CPUs=1, N
odes=1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] CPU 0 irqstacks, hard=cf808000 soft=cf80a000
[    0.000000] I-pipe 2.11-02: pipeline enabled.
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 799.974 MHz processor.
[    0.004014] Calibrating delay loop (skipped), value calculated using 
timer fr
equency.. 1599.94 BogoMIPS (lpj=3199896)
[    0.008083] pid_max: default: 32768 minimum: 301
[    0.008400] Security Framework initialized
[    0.008649] AppArmor: AppArmor initialized
[    0.009134] Mount-cache hash table entries: 512
[    0.010210] Initializing cgroup subsys cpuacct
[    0.010325] Initializing cgroup subsys memory
[    0.010488] Initializing cgroup subsys devices
[    0.010559] Initializing cgroup subsys freezer
[    0.010625] Initializing cgroup subsys net_cls
[    0.010690] Initializing cgroup subsys blkio
[    0.011090] CPU: Vortex86 SoC 05/02 stepping 02
[    0.011487] ftrace: allocating 17134 entries in 34 pages
[    0.016427] Performance Events:
[    0.038785] NET: Registered protocol family 16
[    0.040152] EISA bus registered
[    0.049416] PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=0
[    0.049509] PCI: Using configuration type 1 for base access
[    0.068221] bio: create slab <bio-0> at 0
[    0.069499] vgaarb: loaded
[    0.070813] SCSI subsystem initialized
[    0.071654] libata version 3.00 loaded.
[    0.072629] usbcore: registered new interface driver usbfs
[    0.072927] usbcore: registered new interface driver hub
[    0.073448] usbcore: registered new device driver usb
[    0.074005] PCI: Probing PCI hardware
[    0.074080] PCI: Probing PCI hardware (bus 00)
[    0.074422] pci 0000:00:00.0: [17f3:6021] type 0 class 0x000600
[    0.074607] pci 0000:00:07.0: [17f3:6031] type 0 class 0x000601
[    0.074781] pci 0000:00:08.0: [17f3:6040] type 0 class 0x000200
[    0.074832] pci 0000:00:08.0: reg 10: [io  0xdf00-0xdfff]
[    0.074872] pci 0000:00:08.0: reg 14: [mem 0xfefff800-0xfefff8ff]
[    0.074947] pci 0000:00:08.0: reg 30: [mem 0xfefe0000-0xfefeffff pref]
[    0.075056] pci 0000:00:0b.0: [17f3:6060] type 0 class 0x000c03
[    0.075103] pci 0000:00:0b.0: reg 10: [mem 0x000e0000-0x000e0fff]
[    0.075258] pci 0000:00:0b.1: [17f3:6061] type 0 class 0x000c03
[    0.075303] pci 0000:00:0b.1: reg 10: [mem 0x000e1000-0x000e10ff]
[    0.075475] pci 0000:00:0c.0: [17f3:1010] type 0 class 0x000180
[    0.075525] pci 0000:00:0c.0: reg 10: [io  0x01f0-0x01f7]
[    0.075562] pci 0000:00:0c.0: reg 14: [io  0x03f4-0x03f7]
[    0.075600] pci 0000:00:0c.0: reg 18: [io  0x0170-0x0177]
[    0.075637] pci 0000:00:0c.0: reg 1c: [io  0x0374-0x0377]
[    0.075674] pci 0000:00:0c.0: reg 20: [io  0xfff0-0xffff]
[    0.075722] pci 0000:00:0c.0: reg 30: [mem 0x00000000-0x0001ffff pref]
[    0.077844] pci 0000:00:07.0: default IRQ router [17f3:6031]
[    0.078034] PCI: pci_cache_line_size set to 32 bytes
[    0.078114] pci 0000:00:0b.0: address space collision: [mem 
0x000e0000-0x000e
0fff] conflicts with reserved [mem 0x000e0000-0x000fffff]
[    0.078278] pci 0000:00:0b.1: address space collision: [mem 
0x000e1000-0x000e
10ff] conflicts with reserved [mem 0x000e0000-0x000fffff]
[    0.078484] reserve RAM buffer: 000000000009fc00 - 000000000009ffff
[    0.079509] NetLabel: Initializing
[    0.079605] NetLabel:  domain hash size = 128
[    0.079665] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.079870] NetLabel:  unlabeled traffic allowed by default
[    0.080128] Switching to clocksource pit
[    0.157707] AppArmor: AppArmor Filesystem Enabled
[    0.158033] PnPBIOS: Scanning system for PnP BIOS support...
[    0.158201] PnPBIOS: Found PnP BIOS installation structure at 0xc00f3be0
[    0.158288] PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x45aa, dseg 
0xf0000
[    0.158750] pnp 00:00: [mem 0x00000000-0x0009fbff]
[    0.158786] pnp 00:00: [mem 0x0009fc00-0x0009ffff]
[    0.158813] pnp 00:00: [mem 0x000e0000-0x000fffff]
[    0.158841] pnp 00:00: [mem 0x00100000-0x0fffffff]
[    0.158869] pnp 00:00: [mem 0xff000000-0xffffffff]
[    0.159199] system 00:00: [mem 0x00000000-0x0009fbff] could not be 
reserved
[    0.159319] system 00:00: [mem 0x0009fc00-0x0009ffff] could not be 
reserved
[    0.159414] system 00:00: [mem 0x000e0000-0x000fffff] could not be 
reserved
[    0.159509] system 00:00: [mem 0x00100000-0x0fffffff] could not be 
reserved
[    0.159603] system 00:00: [mem 0xff000000-0xffffffff] has been reserved
[    0.159699] system 00:00: Plug and Play BIOS device, IDs PNP0c01 
(active)
[    0.159899] pnp 00:01: [io  0x0020-0x0021]
[    0.159933] pnp 00:01: [io  0x00a0-0x00a1]
[    0.159961] pnp 00:01: [irq 2]
[    0.160184] pnp 00:01: Plug and Play BIOS device, IDs PNP0000 (active)
[    0.160290] pnp 00:02: [dma 4]
[    0.160317] pnp 00:02: [io  0x0000-0x000f]
[    0.160343] pnp 00:02: [io  0x0080-0x0090]
[    0.160369] pnp 00:02: [io  0x0094-0x009f]
[    0.160395] pnp 00:02: [io  0x00c0-0x00de]
[    0.160602] pnp 00:02: Plug and Play BIOS device, IDs PNP0200 (active)
[    0.160704] pnp 00:03: [irq 0]
[    0.160731] pnp 00:03: [io  0x0040-0x0043]
[    0.160938] pnp 00:03: Plug and Play BIOS device, IDs PNP0100 (active)
[    0.161043] pnp 00:04: [irq 8]
[    0.161070] pnp 00:04: [io  0x0070-0x0071]
[    0.161308] pnp 00:04: Plug and Play BIOS device, IDs PNP0b00 (active)
[    0.161595] pnp 00:05: Plug and Play BIOS device, IDs PNP0a03 (disabled)
[    0.161707] pnp 00:06: [io  0x0061]
[    0.161927] pnp 00:06: Plug and Play BIOS device, IDs PNP0800 (active)
[    0.162048] pnp 00:07: [irq 13]
[    0.162075] pnp 00:07: [io  0x00f0-0x00ff]
[    0.162286] pnp 00:07: Plug and Play BIOS device, IDs PNP0c04 (active)
[    0.162416] pnp 00:08: [io  0x04d0-0x04d1]
[    0.162444] pnp 00:08: [io  0x0cf8-0x0cff]
[    0.162470] pnp 00:08: [io  0xfc00-0xfc0f]
[    0.162496] pnp 00:08: [io  0x002e-0x002f]
[    0.162522] pnp 00:08: [io  0x0a00-0x0a0f]
[    0.162548] pnp 00:08: [io  0x0a20-0x0a2f]
[    0.162574] pnp 00:08: [io  0x0a10-0x0a1f]
[    0.162600] pnp 00:08: [io  0x0a30-0x0a3f]
[    0.162627] pnp 00:08: [io  0x0a40-0x0a4f]
[    0.162653] pnp 00:08: [io  0x0a50-0x0a5f]
[    0.162681] pnp 00:08: [io  0x0000-0xffffffff disabled]
[    0.162712] pnp 00:08: [mem 0x00000000-0xffffffff disabled]
[    0.162743] pnp 00:08: [mem 0x00000000-0xffffffff disabled]
[    0.162773] pnp 00:08: [mem 0x00000000-0xffffffff disabled]
[    0.162803] pnp 00:08: [mem 0x00000000-0xffffffff disabled]
[    0.162833] pnp 00:08: [mem 0x00000000-0xffffffff disabled]
[    0.162863] pnp 00:08: [mem 0x00000000-0xffffffff disabled]
[    0.162892] pnp 00:08: [mem 0x00000000-0xffffffff disabled]
[    0.162922] pnp 00:08: [mem 0x00000000-0xffffffff disabled]
[    0.163265] system 00:08: [io  0x04d0-0x04d1] has been reserved
[    0.163386] system 00:08: [io  0x0cf8-0x0cff] could not be reserved
[    0.163475] system 00:08: [io  0xfc00-0xfc0f] has been reserved
[    0.163562] system 00:08: [io  0x0a00-0x0a0f] has been reserved
[    0.163648] system 00:08: [io  0x0a20-0x0a2f] has been reserved
[    0.163734] system 00:08: [io  0x0a10-0x0a1f] has been reserved
[    0.163905] system 00:08: [io  0x0a30-0x0a3f] has been reserved
[    0.163999] system 00:08: [io  0x0a40-0x0a4f] has been reserved
[    0.164086] system 00:08: [io  0x0a50-0x0a5f] has been reserved
[    0.164186] system 00:08: Plug and Play BIOS device, IDs PNP0c02 
(active)
[    0.164335] pnp 00:09: [io  0x03f8-0x03ff]
[    0.164364] pnp 00:09: [irq 4]
[    0.164882] pnp 00:09: Plug and Play BIOS device, IDs PNP0501 (active)
[    0.165048] pnp 00:0a: [io  0x02f8-0x02ff]
[    0.165077] pnp 00:0a: [irq 3]
[    0.165594] pnp 00:0a: Plug and Play BIOS device, IDs PNP0501 (active)
[    0.165743] pnp 00:0b: [io  0x03e8-0x03ef]
[    0.165771] pnp 00:0b: [irq 10]
[    0.166269] pnp 00:0b: Plug and Play BIOS device, IDs PNP0501 (active)
[    0.166418] pnp 00:0c: [io  0x02e8-0x02ef]
[    0.166446] pnp 00:0c: [irq 11]
[    0.166944] pnp 00:0c: Plug and Play BIOS device, IDs PNP0501 (active)
[    0.167178] pnp 00:0d: [io  0x0278-0x027f]
[    0.167206] pnp 00:0d: [io  0x0678-0x067a]
[    0.167232] pnp 00:0d: [irq 7]
[    0.167258] pnp 00:0d: [dma 4294967295 disabled]
[    0.167677] pnp 00:0d: Plug and Play BIOS device, IDs PNP0400 (active)
[    0.167913] pnp 00:0e: [io  0x0a60-0x0a6f]
[    0.168245] system 00:0e: [io  0x0a60-0x0a6f] has been reserved
[    0.168375] system 00:0e: Plug and Play BIOS device, IDs PNP0c02 
(active)
[    0.168541] pnp 00:0f: [io  0x03f0-0x03f5]
[    0.168635] pnp 00:0f: disabling [io  0x03f0-0x03f5] because it 
overlaps 0000
:00:0c.0 BAR 1 [io  0x03f4-0x03f7]
[    0.168994] system 00:0f: Plug and Play BIOS device, IDs PNP0c02 
(active)
[    0.169165] pnp 00:10: [irq 1]
[    0.169190] pnp 00:10: [io  0x0060]
[    0.169214] pnp 00:10: [io  0x0064]
[    0.169459] pnp 00:10: Plug and Play BIOS device, IDs PNP0303 (active)
[    0.169524] PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by 
driver
[    0.186137] pci 0000:00:0c.0: BAR 6: assigned [mem 
0x10000000-0x1001ffff pref
]
[    0.186309] pci 0000:00:0b.0: BAR 0: assigned [mem 
0x10020000-0x10020fff]
[    0.186415] pci 0000:00:0b.0: BAR 0: set to [mem 
0x10020000-0x10020fff] (PCI
address [0x10020000-0x10020fff])
[    0.186552] pci 0000:00:0b.1: BAR 0: assigned [mem 
0x10021000-0x100210ff]
[    0.186648] pci 0000:00:0b.1: BAR 0: set to [mem 
0x10021000-0x100210ff] (PCI
address [0x10021000-0x100210ff])
[    0.186781] pci_bus 0000:00: resource 0 [io  0x0000-0xffff]
[    0.186810] pci_bus 0000:00: resource 1 [mem 0x00000000-0xffffffff]
[    0.187203] NET: Registered protocol family 2
[    0.187733] IP route cache hash table entries: 2048 (order: 1, 8192 
bytes)
[    0.189452] TCP established hash table entries: 8192 (order: 4, 65536 
bytes)
[    0.189872] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[    0.190091] TCP: Hash tables configured (established 8192 bind 8192)
[    0.190167] TCP reno registered
[    0.190231] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.190331] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.191063] NET: Registered protocol family 1
[    1.787950] pci 0000:00:0b.1: EHCI: BIOS handoff failed (BIOS bug?) 
01010001
[    1.788208] PCI: CLS 16 bytes, default 32
[    1.790726] audit: initializing netlink socket (disabled)
[    1.790915] type=2000 audit(1341918028.784:1): initialized
[    1.869449] I-pipe: Domain Xenomai registered.
[    1.869596] Xenomai: hal/i386 started.
[    1.869800] Xenomai: scheduling class idle registered.
[    1.869874] Xenomai: scheduling class rt registered.
[    1.881426] Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards) loaded.
[    1.882357] Xenomai: starting native API services.
[    1.882463] Xenomai: starting POSIX services.
[    1.882725] Xenomai: starting RTDM services.
[    1.909753] VFS: Disk quotas dquot_6.5.2
[    1.910547] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    1.915003] NTFS driver 2.1.30 [Flags: R/O].
[    1.916533] fuse init (API version 7.16)
[    1.917999] msgmni has been set to 488
[    1.922326] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 2
53)
[    1.922864] io scheduler noop registered
[    1.922957] io scheduler deadline registered
[    1.923276] io scheduler cfq registered (default)
[    1.924641] isapnp: Scanning for PnP cards...
[    2.278726] isapnp: No Plug & Play device found
[    2.605483] Serial: 8250/16550 driver, 12 ports, IRQ sharing enabled
[    2.608258] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    2.612262] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    2.620253] serial8250: ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
[    2.624261] serial8250: ttyS3 at I/O 0x2e8 (irq = 3) is a 16550A
[    2.636263] 00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    2.644265] 00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    2.652262] 00:0b: ttyS2 at I/O 0x3e8 (irq = 10) is a 16550A
[    2.656266] 00:0c: ttyS3 at I/O 0x2e8 (irq = 11) is a 16550A
[    2.676340] brd: module loaded
[    2.683087] loop: module loaded
[    2.687986] scsi0 : pata_it821x
[    2.689291] scsi1 : pata_it821x
[    2.689898] ata1: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f4 bmdma 0xfff0 
irq 14
[    2.690006] ata2: PATA max UDMA/133 cmd 0x170 ctl 0x374 bmdma 0xfff8 
irq 14
[    2.698384] Fixed MDIO Bus: probed
[    2.699124] r6040: RDC R6040 NAPI net driver,version 0.28 (07Oct2011)
[    2.706690] r6040_eth_mii: probed
[    2.707041] r6040 0000:00:08.0: attached PHY driver [Generic PHY] 
(mii_bus:ph
y_addr=0000:00:08.0-0:01)
[    2.709121] PPP generic driver version 2.4.2
[    2.710022] tun: Universal TUN/TAP device driver, 1.6
[    2.710130] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    2.711531] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.711858] ehci_hcd 0000:00:0b.1: EHCI Host Controller
[    2.712807] ehci_hcd 0000:00:0b.1: new USB bus registered, assigned 
bus numbe
r 1
[    2.736324] ehci_hcd 0000:00:0b.1: irq 9, io mem 0x10021000
[    2.748261] ehci_hcd 0000:00:0b.1: USB 2.0 started, EHCI 1.00
[    2.749640] hub 1-0:1.0: USB hub found
[    2.749790] hub 1-0:1.0: 2 ports detected
[    2.750377] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.750652] ohci_hcd 0000:00:0b.0: OHCI Host Controller
[    2.751395] ohci_hcd 0000:00:0b.0: new USB bus registered, assigned 
bus numbe
r 2
[    2.751679] ohci_hcd 0000:00:0b.0: irq 15, io mem 0x10020000
[    2.835327] hub 2-0:1.0: USB hub found
[    2.835479] hub 2-0:1.0: 2 ports detected
[    2.836037] uhci_hcd: USB Universal Host Controller Interface driver
[    2.836882] usbcore: registered new interface driver cdc_acm
[    2.836994] cdc_acm: v0.26:USB Abstract Control Model driver for USB 
modems a
nd ISDN adapters
[    2.837310] usbcore: registered new interface driver uas
[    2.837393] Initializing USB Mass Storage driver...
[    2.837854] usbcore: registered new interface driver usb-storage
[    2.837940] USB Mass Storage support registered.
[    2.838460] usbcore: registered new interface driver usbserial
[    2.838706] USB Serial support registered for generic
[    2.838976] usbcore: registered new interface driver usbserial_generic
[    2.839061] usbserial: USB Serial Driver core
[    2.839282] USB Serial support registered for FTDI USB Serial Device
[    2.839993] usbcore: registered new interface driver ftdi_sio
[    2.840091] ftdi_sio: v1.6.0:USB FTDI Serial Converters Driver
[    2.840426] USB Serial support registered for pl2303
[    2.840754] usbcore: registered new interface driver pl2303
[    2.840836] pl2303: Prolific PL2303 USB to serial adaptor driver
[    2.841579] i8042: PNP: PS/2 Controller [PNP0303] at 0x60,0x64 irq 1
[    2.841669] i8042: PNP: PS/2 appears to have AUX port disabled, if 
this is in
correct please boot with i8042.nopnp
[    2.842598] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.844440] rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
[    2.844637] rtc0: alarms up to one day, 114 bytes nvram
[    2.845303] EISA: Probing bus 0 at eisa.0
[    2.845555] EISA: Detected 0 cards.
[    2.848593] TCP cubic registered
[    2.851196] NET: Registered protocol family 10
[    2.858157] NET: Registered protocol family 17
[    2.858540] Registering the dns_resolver key type
[    2.860882] ata1.00: CFA: EmbedDisk 128MB, 081107, max UDMA/66
[    2.861008] ata1.00: 256000 sectors, multi 0: LBA
[    2.861748] registered taskstats version 1
[    2.868751] Switching to clocksource tsc
[    2.868994] ata1.00: configured for UDMA/66
[    2.870321] scsi 0:0:0:0: Direct-Access     ATA      EmbedDisk 128MB  
0811 PQ
: 0 ANSI: 5
[    2.871847] sd 0:0:0:0: [sda] 256000 512-byte logical blocks: (131 
MB/125 MiB
)
[    2.872607] sd 0:0:0:0: [sda] Write Protect is off
[    2.872714] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.873189] sd 0:0:0:0: [sda] Write cache: disabled, read cache: 
enabled, doe
sn't support DPO or FUA
[    2.875067] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.881479]  sda: sda1 sda2
[    2.884271] rtc_cmos 00:04: setting system clock to 2012-07-10 
18:00:30 UTC (
1341918030)
[    2.884433] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    2.884506] EDD information not available.
[    2.887218] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.037432] VFS: Mounted root (ext2 filesystem) readonly on device 8:2.
[    3.037772] Freeing unused kernel memory: 488k freed
[    3.040953] Write protecting the kernel text: 4024k
[    3.041354] Write protecting the kernel read-only data: 2088k
[    5.703955] eth0: link UP - 100/full
[   13.423554] eth0: no IPv6 routers present
[ 4233.710868] EXT2-fs (sda2): warning: mounting unchecked fs, running 
e2fsck is
  recommended

Bye, bye.





