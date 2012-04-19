Message-ID: <4F9019B0.9020500@domain.hid>
Date: Thu, 19 Apr 2012 15:57:04 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <loom.20120419T145521-358@domain.hid>
In-Reply-To: <loom.20120419T145521-358@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] P2020RDB with 3.1.5 kernel oops
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roger Kalt <roger.kalt@domain.hid>
Cc: xenomai@xenomai.org

On 04/19/2012 03:07 PM, Roger Kalt wrote:
> I've applied Xenomai patch from xenomai-head
>
> commit 0ce3ed58074fa4d593ba556157d1edc288aff3f1
> Author: Philippe Gerum<rpm@xenomai.org>
> Date:   Wed Dec 14 10:46:27 2011 +0100
>
> powerpc: upgrade I-pipe support to 3.0.13-powerpc-2.13-06,
> ipipe-3.1.5-powerpc-2.13-06
>
>
> to linux mainline 3.1.5 kernel.
>
> The board is a P2020RDB where I've used defconfig: mpc85xx_smp_defconfig
>
> Please advice.

Try disabling CONFIG_DEBUGGER.

>
>
>
> WARNING: adjusting available memory to 30000000
> ## Booting kernel from Legacy Image at 01000000 ...
>     Image Name:   Linux-3.1.5-xenomai-KR84-mpc85xx
>     Created:      2012-04-19  12:37:26 UTC
>     Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>     Data Size:    3419182 Bytes = 3.3 MiB
>     Load Address: 00000000
>     Entry Point:  00000000
>     Verifying Checksum ... OK
> ## Flattened Device Tree blob at 00c00000
>     Booting using the fdt blob at 0x00c00000
>     Uncompressing Kernel Image ... OK
>     Loading Device Tree to 03ffa000, end 03fffb55 ... OK
> WARNING: could not find compatible node fsl-usb2-dr: FDT_ERR_NOTFOUND.
> Using P2020 RDB machine description
> Memory CAM mapping: 256/256/256 Mb, residual: 256Mb
> Linux version 3.1.5-xenomai-KR84-mpc85xx_defconfig-ipipe (kalt_r@domain.hid) (gcc
> version 4.6.1 20110627 (prerelease) (GCC) ) #1 SMP Thu Apr 19 14:36:41 CEST 2012
> CPU maps initialized for 1 thread per core
> bootconsole [udbg0] enabled
> setup_arch: bootmem
> mpc85xx_rdb_setup_arch()
> Found FSL PCI host bridge at 0x00000000ffe0a000. Firmware bus number: 0->16
> PCI host bridge /pcie@domain.hid  ranges:
>   MEM 0x00000000a0000000..0x00000000dfffffff ->  0x00000000a0000000
>    IO 0x00000000ffc30000..0x00000000ffc3ffff ->  0x0000000000000000
> /pcie@domain.hid: PCICSRBAR @ 0xfff00000
> MPC85xx RDB board from Freescale Semiconductor
> arch: exit
> Zone PFN ranges:
>    DMA      0x00000000 ->  0x00030000
>    Normal   empty
>    HighMem  0x00030000 ->  0x00040000
> Movable zone start PFN for each node
> early_node_map[1] active PFN ranges
>      0: 0x00000000 ->  0x00040000
> MMU: Allocated 1088 bytes of context maps for 255 contexts
> PERCPU: Embedded 9 pages/cpu @c0f4c000 s14912 r8192 d13760 u36864
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260096
> Kernel command line: ip=dhcp root=/dev/nfs rw
> nfsroot=129.129.145.35:/export/eldk9 console=ttyS0,115200
> PID hash table entries: 4096 (order: 2, 16384 bytes)
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Memory: 1031932k/1048576k available (6900k kernel code, 16644k reserved, 196k
> data, 333k bss, 276k init)
> Kernel virtual memory layout:
>    * 0xfff5f000..0xfffff000  : fixmap
>    * 0xffc00000..0xffe00000  : highmem PTEs
>    * 0xffbec000..0xffc00000  : early ioremap
>    * 0xf1000000..0xffbec000  : vmalloc&  ioremap
> SLUB: Genslabs=15, HWalign=32, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
> Hierarchical RCU implementation.
> NR_IRQS:512 nr_irqs:512 16
> mpic: Setting up MPIC " OpenPIC  " version 1.2 at ffe40000, max 2 CPUs
> mpic: ISU size: 256, shift: 8, mask: ff
> mpic: Initializing for 256 sources
> clocksource: timebase mult[3555555] shift[22] registered
> I-pipe 2.13-06: pipeline enabled.
> Console: colour dummy device 80x25
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 512
> mpic: requesting IPIs...
> Unable to handle kernel paging request for instruction fetch
> Faulting instruction address: 0x00000000
> Oops: Kernel access of bad area, sig: 11 [#1]
> SMP NR_CPUS=8 P2020 RDB
> Modules linked in:
> NIP: 00000000 LR: c000e924 CTR: 00000000
> REGS: ef03fea0 TRAP: 0400   Not tainted
> (3.1.5-xenomai-KR84-mpc85xx_defconfig-ipipe)
> MSR: 00029000<EE,ME,CE>   CR: 84044082  XER: 00000000
> TASK = ef040000[1] 'swapper' THREAD: ef03e000 CPU: 0
> GPR00: 00000000 ef03ff50 ef040000 ef007e40 000000fe 00000000 00000000 00000000
> GPR08: ffffffff ef008064 ef007e40 fffffffa 84044088 0649cac0 00000000 00000000
> GPR16: 3ff926dc 00000000 3fe315b8 3fe313c8 3ffb0bf0 3ff37aa4 c06e8000 00000000
> GPR24: 00000000 c0f4c1c8 c06ec530 c06f0000 ffffffea 000000fe ef008000 00000003
> NIP [00000000]   (null)
> LR [c000e924] __ipipe_register_ipi+0x38/0x48
> Call Trace:
> [ef03ff50] [c000e908] __ipipe_register_ipi+0x1c/0x48 (unreliable)
> [ef03ff60] [c00112f8] smp_request_message_ipi+0x78/0xb8
> [ef03ff80] [c001a108] mpic_request_ipis+0x64/0xa0
> [ef03ffa0] [c067fdf4] smp_mpic_probe+0x2c/0x40
> [ef03ffb0] [c067cf04] smp_prepare_cpus+0x178/0x18c
> [ef03ffe0] [c067880c] kernel_init+0x50/0x12c
> [ef03fff0] [c000e574] kernel_thread+0x4c/0x68
> Instruction dump:
> XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> ---[ end trace 31fd0ba7d8756001 ]---
> Kernel panic - not syncing: Attempted to kill init!
> Call Trace:
> [ef03fd60] [c0008004] show_stack+0x4c/0x174 (unreliable)
> [ef03fda0] [c04f85e4] panic+0xa8/0x1ec
> [ef03fe00] [c004cb10] do_exit+0x648/0x728
> [ef03fe60] [c000a730] die+0xfc/0x1f4
> [ef03fe80] [c0014550] bad_page_fault+0xbc/0x110
> [ef03fe90] [c00108ac] handle_page_fault+0x7c/0x80
> --- Exception: 400 at   (null)
>      LR = __ipipe_register_ipi+0x38/0x48
> [ef03ff50] [c000e908] __ipipe_register_ipi+0x1c/0x48 (unreliable)
> [ef03ff60] [c00112f8] smp_request_message_ipi+0x78/0xb8
> [ef03ff80] [c001a108] mpic_request_ipis+0x64/0xa0
> [ef03ffa0] [c067fdf4] smp_mpic_probe+0x2c/0x40
> [ef03ffb0] [c067cf04] smp_prepare_cpus+0x178/0x18c
> [ef03ffe0] [c067880c] kernel_init+0x50/0x12c
> [ef03fff0] [c000e574] kernel_thread+0x4c/0x68
> Rebooting in 180 seconds..
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>


-- 
Philippe.

