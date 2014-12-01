MIME-Version: 1.0
In-Reply-To: <20141128182141.GB4817@hermes>
References: <CAPozGf=zAFgV=fbinambu1_xEiR3qD7Affppw-i6ZbD4nvJsRw@mail.gmail.com>
 <20141128111325.GD5069@hermes>
 <CAPozGf=6OQBChvSAfypNH7KpAReg+u6PS3dhEJDtVZ-jrnW7bg@mail.gmail.com>
 <CAPozGfkxmv+7=Q3LXAmOv_eTPZ08XV3SO9SETPomSAs+bbxV0A@mail.gmail.com>
 <CAPozGfk9LizYFbCRKUDS1-mhX+bw3fOpgqzwF6AcH64Pspw4Gg@mail.gmail.com>
 <20141128182141.GB4817@hermes>
Date: Mon, 1 Dec 2014 15:35:51 +0100
Message-ID: <CAPozGfk-okS5TDn-zPua3uvHkcppm3CpnqAKXYs6-VWVPb4cpg@mail.gmail.com>
From: John Sini <jhnsini@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Section mismatch - Porting Xenomai to
 linux-xlnx-V14.5 zynq SoC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

 Hi,


Thank you for your reply. I have disabled lockdep by disabling following
two options in Kernel configuration :Lock debugging:prove locking
correctness and  Lock debugging: detect incorrect freeing of live locks.
The problem that i am facing now is:

U-Boot 2013.01 (Dec 01 2014 - 11:11:00)

DRAM:  512 MiB
WARNING: Caches not enabled
MMC:   zynq_sdhci: 0
SF: Detected S25FL256S with page size 64 KiB, total 32 MiB
*** Warning - bad CRC, using default environment

In:    serial
Out:   serial
Err:   serial
Net:   Gem.e000b000
Hit any key to stop autoboot:  0
Copying Linux from SD to RAM...
Device: zynq_sdhci
Manufacturer ID: 27
OEM: 5048
Name: SD04G
Tran Speed: 50000000
Rd Block Len: 512
SD version 2.0
High Capacity: Yes
Capacity: 3.7 GiB
Bus Width: 4-bit
reading uImage
6495840 bytes read in 865 ms (7.2 MiB/s)
reading devicetree.dtb
7313 bytes read in 11 ms (648.4 KiB/s)
reading uramdisk.image.gz
5289509 bytes read in 707 ms (7.1 MiB/s)
## Booting kernel from Legacy Image at 03000000 ...
   Image Name:   Linux-3.8.0-xilinx-dirty
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    6495776 Bytes = 6.2 MiB
   Load Address: 00008000
   Entry Point:  00008000
   Verifying Checksum ... OK
## Loading init Ramdisk from Legacy Image at 02000000 ...
   Image Name:
   Image Type:   ARM Linux RAMDisk Image (gzip compressed)
   Data Size:    5289445 Bytes = 5 MiB
   Load Address: 00800000
   Entry Point:  00800000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 02a00000
   Booting using the fdt blob at 0x02a00000
   Loading Kernel Image ... OK
OK
   Loading Ramdisk to 1f64b000, end 1fb565e5 ... OK
   Loading Device Tree to 1f646000, end 1f64ac90 ... OK

Starting kernel ...

Booting Linux on physical CPU 0x0
Linux version 3.8.0-xilinx-dirty (john@zedboard) (gcc version 4.8.1 (Sou
CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=18c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: Xilinx Zynq Platform, model: Xilinx Zynq
bootconsole [earlycon0] enabled
cma: CMA: reserved 16 MiB at 1e400000
Memory policy: ECC disabled, Data cache writealloc
PERCPU: Embedded 10 pages/cpu @c1239000 s18752 r8192 d14016 u40960
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: console=ttyPS0,115200 root=/dev/ram rw
ip=:::::eth0:dhcp ea
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
__ex_table already sorted, skipping sort
Memory: 512MB = 512MB total
Memory: 483520k/483520k available, 40768k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
    lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
    modules : 0xbf000000 - 0xbfe00000   (  14 MB)
      .text : 0xc0008000 - 0xc06040bc   (6129 kB)
      .init : 0xc0605000 - 0xc0d71940   (7603 kB)
      .data : 0xc0d72000 - 0xc0dab588   ( 230 kB)
       .bss : 0xc0dab588 - 0xc0e3083c   ( 533 kB)
Preemptible hierarchical RCU implementation.
        Dump stacks of tasks blocking RCU-preempt GP.
        RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
NR_IRQS:16 nr_irqs:16 16
------------[ cut here ]------------
WARNING: at /home/john/project/componen
                         xdc/0x230()
Cannot allocate irq_descs @ IRQ-1, assuming pre-allocated
Modules linked in:
Backtrace:
[<c00123c0>] (dump_backtrace+0x0/0x104) from [<c047460c>]
(dump_stack+0x18/0x1c)
 r6:c060d3e0 r5:00000009 r4:c0d73ec8 r3:c0d822d0
[<c04745f4>] (dump_stack+0x0/0x1c) from [<c00234b4>]
(warn_slowpath_common+0x54/
[<c0023460>] (warn_slowpath_common+0x0/0x6c) from [<c0023504>]
(warn_slowpath_fm
 r8:f8f00100 r7:00000050 r6:00000010 r5:c0d7a48c r4:ffffffff
r3:00000009
[<c00234cc>] (warn_slowpath_fmt+0x0/0x40) from [<c060d3e0>]
(gic_init_bases+0xdc
 r3:ffffffff r2:c05778ba
[<c060d304>] (gic_init_bases+0x0/0x230) from [<c060d5e8>]
(gic_of_init+0xb4/0x10
 r7:00000000 r6:e0800000 r5:c062d0b8 r4:c1235cd0
[<c060d534>] (gic_of_init+0x0/0x100) from [<c0620ec4>]
(of_irq_init+0x194/0x29c)
 r8:c0633864 r7:c0d73f58 r6:c0d73f60 r5:c0d73f58 r4:de0042c0
[<c0620d30>] (of_irq_init+0x0/0x29c) from [<c060e1d4>]
(xilinx_irq_init+0x14/0x1
[<c060e1c0>] (xilinx_irq_init+0x0/0x1c) from [<c060815c>]
(init_IRQ+0x1c/0x24)
[<c0608140>] (init_IRQ+0x0/0x24) from [<c06056ec>]
(start_kernel+0x1b0/0x308)
[<c060553c>] (start_kernel+0x0/0x308) from [<00008078>] (0x8078)
 r8:0000406a r7:c0d7dc44 r6:c062c738 r5:c0d7a464 r4:18c5387d
---[ end trace 1b75b31a2719ed1c ]---
------------[ cut here ]------------
WARNING: at /home//john/project/componen

                         legacy+0x90/0x13c()
Modules linked in:
Backtrace:
[<c00123c0>] (dump_backtrace+0x0/0x104) from [<c047460c>]
(dump_stack+0x18/0x1c)
 r6:c006e730 r5:00000009 r4:00000000 r3:c0d822d0
[<c04745f4>] (dump_stack+0x0/0x1c) from [<c00234b4>]
(warn_slowpath_common+0x54/
[<c0023460>] (warn_slowpath_common+0x0/0x6c) from [<c0023570>]
(warn_slowpath_nu
 r8:00000010 r7:0000004f r6:c0d73e71 r5:ffffffff r4:de001800
r3:00000009
[<c002354c>] (warn_slowpath_null+0x0/0x2c) from [<c006e730>]
(irq_domain_add_leg
[<c006e6a0>] (irq_domain_add_legacy+0x0/0x13c) from [<c060d408>]
(gic_init_bases
[<c060d304>] (gic_init_bases+0x0/0x230) from [<c060d5e8>]
(gic_of_init+0xb4/0x10
 r7:00000000 r6:e0800000 r5:c062d0b8 r4:c1235cd0
[<c060d534>] (gic_of_init+0x0/0x100) from [<c0620ec4>]
(of_irq_init+0x194/0x29c)
 r8:c0633864 r7:c0d73f58 r6:c0d73f60 r5:c0d73f58 r4:de0042c0
[<c0620d30>] (of_irq_init+0x0/0x29c) from [<c060e1d4>]
(xilinx_irq_init+0x14/0x1
[<c060e1c0>] (xilinx_irq_init+0x0/0x1c) from [<c060815c>]
(init_IRQ+0x1c/0x24)
[<c0608140>] (init_IRQ+0x0/0x24) from [<c06056ec>]
(start_kernel+0x1b0/0x308)
[<c060553c>] (start_kernel+0x0/0x308) from [<00008078>] (0x8078)
 r8:0000406a r7:c0d7dc44 r6:c062c738 r5:c0d7a464 r4:18c5387d
---[ end trace 1b75b31a2719ed1d ]---
------------[ cut here ]------------
WARNING: at /home/john/project/componencomponen
                         x11c/0x230()
Modules linked in:
Backtrace:
[<c00123c0>] (dump_backtrace+0x0/0x104) from [<c047460c>]
(dump_stack+0x18/0x1c)
 r6:c060d420 r5:00000009 r4:00000000 r3:c0d822d0
[<c04745f4>] (dump_stack+0x0/0x1c) from [<c00234b4>]
(warn_slowpath_common+0x54/
[<c0023460>] (warn_slowpath_common+0x0/0x6c) from [<c0023570>]
(warn_slowpath_nu
 r8:f8f00100 r7:00000050 r6:00000010 r5:c0d7a48c r4:c0d7a48c
r3:00000009
[<c002354c>] (warn_slowpath_null+0x0/0x2c) from [<c060d420>]
(gic_init_bases+0x1
[<c060d304>] (gic_init_bases+0x0/0x230) from [<c060d5e8>]
(gic_of_init+0xb4/0x10
 r7:00000000 r6:e0800000 r5:c062d0b8 r4:c1235cd0
[<c060d534>] (gic_of_init+0x0/0x100) from [<c0620ec4>]
(of_irq_init+0x194/0x29c)
 r8:c0633864 r7:c0d73f58 r6:c0d73f60 r5:c0d73f58 r4:de0042c0
[<c0620d30>] (of_irq_init+0x0/0x29c) from [<c060e1d4>]
(xilinx_irq_init+0x14/0x1
[<c060e1c0>] (xilinx_irq_init+0x0/0x1c) from [<c060815c>]
(init_IRQ+0x1c/0x24)
[<c0608140>] (init_IRQ+0x0/0x24) from [<c06056ec>]
(start_kernel+0x1b0/0x308)
[<c060553c>] (start_kernel+0x0/0x308) from [<00008078>] (0x8078)
 r8:0000406a r7:c0d7dc44 r6:c062c738 r5:c0d7a464 r4:18c5387d
---[ end trace 1b75b31a2719ed1e ]---
xslcr mapped to e0802000
Zynq clock init
------------[ cut here ]------------
WARNING: at /home/john/project/componen

                         recalc_rate+0xb8/0xdc()
clk_divider_recalc_rate: Invalid divisor for clock DDR_2X_DIV_CLK
Modules linked in:
Backtrace:
[<c00123c0>] (dump_backtrace+0x0/0x104) from [<c047460c>]
(dump_stack+0x18/0x1c)
 r6:c03c3780 r5:00000009 r4:c0d73e00 r3:c0d822d0
[<c04745f4>] (dump_stack+0x0/0x1c) from [<c00234b4>]
(warn_slowpath_common+0x54/
[<c0023460>] (warn_slowpath_common+0x0/0x6c) from [<c0023504>]
(warn_slowpath_fm
 r8:de007200 r7:00000000 r6:c03c36c8 r5:c0e29a78 r4:3f940aa0
r3:00000009
[<c00234cc>] (warn_slowpath_fmt+0x0/0x40) from [<c03c3780>]
(clk_divider_recalc_
 r3:c04ae058 r2:c05be007
[<c03c36c8>] (clk_divider_recalc_rate+0x0/0xdc) from [<c03c2a94>]
(__clk_init+0x
 r4:de001dc0
[<c03c27e0>] (__clk_init+0x0/0x3d8) from [<c03c2d20>]
(_clk_register+0x104/0x158
 r9:c0d73fe4 r8:de007200 r7:00000000 r6:de007180 r5:00000001
r4:de001dc0
[<c03c2c1c>] (_clk_register+0x0/0x158) from [<c03c2dc4>]
(clk_register+0x50/0x78
 r8:c0d9ef9c r7:00000020 r6:00000000 r5:de007180 r4:de001dc0
r3:00000000
[<c03c2d74>] (clk_register+0x0/0x78) from [<c03c3868>]
(_register_divider+0xc4/0
 r6:c05be452 r5:00000000 r4:de007180 r3:00000000
[<c03c37a4>] (_register_divider+0x0/0xf4) from [<c03c38dc>]
(clk_register_divide
 r7:c056f31b r6:c0d73ec0 r5:c0d9ef8c r4:00000000
[<c03c3898>] (clk_register_divider+0x0/0x4c) from [<c0621950>]
(zynq_clock_init+
[<c0621720>] (zynq_clock_init+0x0/0xa60) from [<c060e78c>]
(xslcr_init+0x1a0/0x1
[<c060e5ec>] (xslcr_init+0x0/0x1d4) from [<c060e1b8>]
(xilinx_zynq_timer_init+0x
 r7:c062c740 r6:c0d73f38 r5:c0d72000 r4:c0dab5c0
[<c060e1a8>] (xilinx_zynq_timer_init+0x0/0x18) from [<c0608fe8>]
(time_init+0x28
[<c0608fc0>] (time_init+0x0/0x38) from [<c0605700>]
(start_kernel+0x1c4/0x308)
[<c060553c>] (start_kernel+0x0/0x308) from [<00008078>] (0x8078)
 r8:0000406a r7:c0d7dc44 r6:c062c738 r5:c0d7a464 r4:18c5387d
---[ end trace 1b75b31a2719ed1f ]---
------------[ cut here ]------------
WARNING: at /home/john/project/componen
                         recalc_rate+0xb8/0xdc()
clk_divider_recalc_rate: Invalid divisor for clock DDR_3X_DIV_CLK
Modules linked in:
Backtrace:
[<c00123c0>] (dump_backtrace+0x0/0x104) from [<c047460c>]
(dump_stack+0x18/0x1c)
 r6:c03c3780 r5:00000009 r4:c0d73e00 r3:c0d822d0
[<c04745f4>] (dump_stack+0x0/0x1c) from [<c00234b4>]
(warn_slowpath_common+0x54/
[<c0023460>] (warn_slowpath_common+0x0/0x6c) from [<c0023504>]
(warn_slowpath_fm
 r8:de007400 r7:00000000 r6:c03c36c8 r5:c0e29a78 r4:3f940aa0
r3:00000009
[<c00234cc>] (warn_slowpath_fmt+0x0/0x40) from [<c03c3780>]
(clk_divider_recalc_
 r3:c04ae058 r2:c05be007
[<c03c36c8>] (clk_divider_recalc_rate+0x0/0xdc) from [<c03c2a94>]
(__clk_init+0x
 r4:de001e40
[<c03c27e0>] (__clk_init+0x0/0x3d8) from [<c03c2d20>]
(_clk_register+0x104/0x158
 r9:c0d73fe4 r8:de007400 r7:00000000 r6:de007380 r5:00000001
r4:de001e40
[<c03c2c1c>] (_clk_register+0x0/0x158) from [<c03c2dc4>]
(clk_register+0x50/0x78
 r8:c0d9ef9c r7:00000020 r6:00000000 r5:de007380 r4:de001e40
r3:00000000
[<c03c2d74>] (clk_register+0x0/0x78) from [<c03c3868>]
(_register_divider+0xc4/0
 r6:c05be473 r5:00000000 r4:de007380 r3:00000000
[<c03c37a4>] (_register_divider+0x0/0xf4) from [<c03c38dc>]
(clk_register_divide
 r7:c056f31b r6:c0d73ec0 r5:c0d9ef8c r4:00000000
[<c03c3898>] (clk_register_divider+0x0/0x4c) from [<c06219bc>]
(zynq_clock_init+
[<c0621720>] (zynq_clock_init+0x0/0xa60) from [<c060e78c>]
(xslcr_init+0x1a0/0x1
[<c060e5ec>] (xslcr_init+0x0/0x1d4) from [<c060e1b8>]
(xilinx_zynq_timer_init+0x
 r7:c062c740 r6:c0d73f38 r5:c0d72000 r4:c0dab5c0
[<c060e1a8>] (xilinx_zynq_timer_init+0x0/0x18) from [<c0608fe8>]
(time_init+0x28
[<c0608fc0>] (time_init+0x0/0x38) from [<c0605700>]
(start_kernel+0x1c4/0x308)
[<c060553c>] (start_kernel+0x0/0x308) from [<00008078>] (0x8078)
 r8:0000406a r7:c0d7dc44 r6:c062c738 r5:c0d7a464 r4:18c5387d
---[ end trace 1b75b31a2719ed20 ]---
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000, hw pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0    Tainted: G        W     (3.8.0-xilinx-dirty #3)
PC is at strcmp+0x14/0x48
LR is at __clk_init+0x310/0x3d8
pc : [<c02619dc>]    lr : [<c03c2af0>]    psr: a00001d3
sp : c0d73e48  ip : c0d73e58  fp : c0d73e54
r10: 00000001  r9 : c063278c  r8 : 00000000
r7 : de001f80  r6 : c03c4708  r5 : de001fb4  r4 : de001f80
r3 : 00000000  r2 : 00000053  r1 : 00000000  r0 : de0078c0
Flags: NzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
Control: 18c5387d  Table: 0000404a  DAC: 00000015
Process swapper/0 (pid: 0, stack limit = 0xc0d72238)
Stack: (0xc0d73e48 to 0xc0d74000)
3e40:                   c0d73e84 c0d73e58 c03c2af0 c02619d4 c0d73e84
de007a00
3e60: de001f80 00000004 de007880 00000000 de007900 c063278c c0d73eac
c0d73e88
3e80: c03c2d20 c03c27ec 00000000 de001f80 de007880 00000000 c056f31b
c063277c
3ea0: c0d73ecc c0d73eb0 c03c2dc4 c03c2c28 c0d9efcc de007880 00000000
c0d73fd8
3ec0: c0d73f04 c0d73ed0 c03c4a64 c03c2d80 c03c10bc c05be4a5 c04ae200
c063277c
3ee0: c0d73f04 00000000 c03c143c 00000000 c0d9ef8c c0d73e90 c0d73f1c
c0d73f08
3f00: c03c4ab8 c03c49f8 00000004 c0d9efcc c0d73f74 c0d73f20 c0621a64
c03c4a9c
3f20: c0d9efac 00000000 00000000 c0d9ef9c c0d9ef9c c0025454 c0d73f74
c05be473
3f40: c03bef68 c0dabc58 c0dabc58 c0dabc58 c0dabc58 c0dabc5c 00000001
c1236c00
3f60: 413fc090 00000000 c0d73f94 c0d73f78 c060e78c c062172c c0dab5c0
c0d72000
3f80: c0d73f38 c062c740 c0d73fa4 c0d73f98 c060e1b8 c060e5f8 c0d73fb4
c0d73fa8
3fa0: c0608fe8 c060e1b4 c0d73ff4 c0d73fb8 c0605700 c0608fcc ffffffff
ffffffff
3fc0: c06052d8 00000000 00000000 c062c740 00000000 18c5387d c0d7a464
c062c738
3fe0: c0d7dc44 0000406b 00000001 c0d73ff8 00008078 c0605548 00000000
00000000
Backtrace:
[<c02619c8>] (strcmp+0x0/0x48) from [<c03c2af0>] (__clk_init+0x310/0x3d8)
[<c03c27e0>] (__clk_init+0x0/0x3d8) from [<c03c2d20>]
(_clk_register+0x104/0x158
 r9:c063278c r8:de007900 r7:00000000 r6:de007880 r5:00000004
r4:de001f80
[<c03c2c1c>] (_clk_register+0x0/0x158) from [<c03c2dc4>]
(clk_register+0x50/0x78
 r8:c063277c r7:c056f31b r6:00000000 r5:de007880 r4:de001f80
r3:00000000
[<c03c2d74>] (clk_register+0x0/0x78) from [<c03c4a64>]
(clk_register_zynq_common
 r6:c0d73fd8 r5:00000000 r4:de007880 r3:c0d9efcc
[<c03c49ec>] (clk_register_zynq_common+0x0/0xa4) from [<c03c4ab8>]
(clk_register
 r6:c0d73e90 r5:c0d9ef8c r4:00000000
[<c03c4a90>] (clk_register_zynq_gd1m+0x0/0x34) from [<c0621a64>]
(zynq_clock_ini
[<c0621720>] (zynq_clock_init+0x0/0xa60) from [<c060e78c>]
(xslcr_init+0x1a0/0x1
[<c060e5ec>] (xslcr_init+0x0/0x1d4) from [<c060e1b8>]
(xilinx_zynq_timer_init+0x
 r7:c062c740 r6:c0d73f38 r5:c0d72000 r4:c0dab5c0
[<c060e1a8>] (xilinx_zynq_timer_init+0x0/0x18) from [<c0608fe8>]
(time_init+0x28
[<c0608fc0>] (time_init+0x0/0x38) from [<c0605700>]
(start_kernel+0x1c4/0x308)
[<c060553c>] (start_kernel+0x0/0x308) from [<00008078>] (0x8078)
 r8:0000406b r7:c0d7dc44 r6:c062c738 r5:c0d7a464 r4:18c5387d
Backtrace aborted due to bad frame pointer <00000001>
Code: e92dd800 e24cb004 e3a03000 e7d02003 (e7d1c003)
---[ end trace 1b75b31a2719ed21 ]---
Kernel panic - not syncing: Attempted to kill the idle task!

Can someone help me resolve the aforementioned issues?


Best,
John

On Fri, Nov 28, 2014 at 7:21 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Fri, Nov 28, 2014 at 07:19:14PM +0100, John Sini wrote:
> > Hi,
> >
> > I have added __init attribute in the ipipe-core-3.8-arm-1.patch and
> applied
> > patches and now I have no more warning you mentioned. I got rid of the
> > warning which was not related to Xenomai. The only warning that I am
> > getting now is this one:$
> >
> > WARNING: vmlinux.o(.cpuinit.text+0xdc4): Section mismatch in reference
> from
> > the function gt_setup.part.2.constprop.4() to the function
> > .init.text:__ipipe_tsc_register()
> > The function __cpuinit gt_setup.part.2.constprop.4() references
> > a function __init __ipipe_tsc_register().
> > If __ipipe_tsc_register is only used by gt_setup.part.2.constprop.4 then
> > annotate __ipipe_tsc_register with a matching annotation.
>
> Well, guess what you have to do to fix the warning?
>
> > WARNING: at
> >
> /home/john/project/components/linux-kernel/linux-xlnx-xenomai/kernel/lockdep.c:3158
>
> lockdep is currently broken with Xenomai on ARM, disable lockdep.
>


> --
>                                             Gilles.
>
