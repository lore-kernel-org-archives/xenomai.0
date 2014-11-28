MIME-Version: 1.0
In-Reply-To: <CAPozGfkxmv+7=Q3LXAmOv_eTPZ08XV3SO9SETPomSAs+bbxV0A@mail.gmail.com>
References: <CAPozGf=zAFgV=fbinambu1_xEiR3qD7Affppw-i6ZbD4nvJsRw@mail.gmail.com>
 <20141128111325.GD5069@hermes>
 <CAPozGf=6OQBChvSAfypNH7KpAReg+u6PS3dhEJDtVZ-jrnW7bg@mail.gmail.com>
 <CAPozGfkxmv+7=Q3LXAmOv_eTPZ08XV3SO9SETPomSAs+bbxV0A@mail.gmail.com>
Date: Fri, 28 Nov 2014 19:19:14 +0100
Message-ID: <CAPozGfk9LizYFbCRKUDS1-mhX+bw3fOpgqzwF6AcH64Pspw4Gg@mail.gmail.com>
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

I have added __init attribute in the ipipe-core-3.8-arm-1.patch and applied
patches and now I have no more warning you mentioned. I got rid of the
warning which was not related to Xenomai. The only warning that I am
getting now is this one:$

WARNING: vmlinux.o(.cpuinit.text+0xdc4): Section mismatch in reference from
the function gt_setup.part.2.constprop.4() to the function
.init.text:__ipipe_tsc_register()
The function __cpuinit gt_setup.part.2.constprop.4() references
a function __init __ipipe_tsc_register().
If __ipipe_tsc_register is only used by gt_setup.part.2.constprop.4 then
annotate __ipipe_tsc_register with a matching annotation.


When I try to boot, I get the following:

U-Boot 2013.01 (Nov 28 2014 - 18:58:34)

DRAM:  512 MiB
WARNING: Caches not enabled
MMC:   zynq_sdhci: 0
SF: Detected S25FL256S with page size 64 KiB, total 32 MiB
*** Warning - bad CRC, using default environment

In:    serial
Out:   serial
Err:   serial
Net:   Gem.e000b000
Hit any key to stop autoboot:  1

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
6690616 bytes read in 891 ms (7.2 MiB/s)
reading devicetree.dtb
7313 bytes read in 11 ms (648.4 KiB/s)
reading uramdisk.image.gz
5289509 bytes read in 707 ms (7.1 MiB/s)
## Booting kernel from Legacy Image at 03000000 ...
   Image Name:   Linux-3.8.0-xilinx-dirty
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    6690552 Bytes = 6.4 MiB
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
Linux version 3.8.0-xilinx-dirty (john@zedboard) (gcc version 4.8.1
(Sourcery CodeBench Lite 2013.11-53) ) #3 SMP PREEMPT Fri Nov 28 19:00:27
CET 2014
CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=18c5387d
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
Machine: Xilinx Zynq Platform, model: Xilinx Zynq
bootconsole [earlycon0] enabled
cma: CMA: reserved 16 MiB at 1e400000
Memory policy: ECC disabled, Data cache writealloc
PERCPU: Embedded 10 pages/cpu @c17a0000 s19392 r8192 d13376 u40960
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: console=ttyPS0,115200 root=/dev/ram rw
ip=:::::eth0:dhcp earlyprintk
PID hash table entries: 2048 (order: 1, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
__ex_table already sorted, skipping sort
Memory: 512MB = 512MB total
Memory: 477988k/477988k available, 46300k reserved, 0K highmem
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
    lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
    modules : 0xbf000000 - 0xbfe00000   (  14 MB)
      .text : 0xc0008000 - 0xc06540bc   (6449 kB)
      .init : 0xc0655000 - 0xc0ddfbc0   (7723 kB)
      .data : 0xc0de0000 - 0xc0e203a8   ( 257 kB)
       .bss : 0xc0e203a8 - 0xc1395cb4   (5591 kB)
Preemptible hierarchical RCU implementation.
        RCU lockdep checking is enabled.
        Dump stacks of tasks blocking RCU-preempt GP.
        RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
------------[ cut here ]------------
WARNING: at
/home/john/project/components/linux-kernel/linux-xlnx-xenomai/kernel/lockdep.c:3158
__lock_acquire+0x16c/0x998()
Modules linked in:
Backtrace:
[<c0012520>] (dump_backtrace+0x0/0x104) from [<c04b5bc4>]
(dump_stack+0x18/0x1c)
 r6:c00638f4 r5:00000009 r4:00000000 r3:00000000
[<c04b5bac>] (dump_stack+0x0/0x1c) from [<c00239b4>]
(warn_slowpath_common+0x54/0x6c)
[<c0023960>] (warn_slowpath_common+0x0/0x6c) from [<c0023a70>]
(warn_slowpath_null+0x24/0x2c)
 r8:c0deae80 r7:00000001 r6:00000390 r5:00000002 r4:c0de1f08
r3:00000009
[<c0023a4c>] (warn_slowpath_null+0x0/0x2c) from [<c00638f4>]
(__lock_acquire+0x16c/0x998)
[<c0063788>] (__lock_acquire+0x0/0x998) from [<c00648b0>]
(lock_acquire+0x8c/0xa8)
[<c0064824>] (lock_acquire+0x0/0xa8) from [<c04bdf64>]
(_raw_spin_lock_irqsave+0x60/0x74)
[<c04bdf04>] (_raw_spin_lock_irqsave+0x0/0x74) from [<c0679ca0>]
(rcu_cpu_notify+0xb4/0x21c)
 r6:c0de1ef8 r5:c0df4680 r4:c0de1ef8
[<c0679bec>] (rcu_cpu_notify+0x0/0x21c) from [<c06624e8>]
(rcu_init+0x1e8/0x250)
[<c0662300>] (rcu_init+0x0/0x250) from [<c06556e8>]
(start_kernel+0x1ac/0x318)
[<c065553c>] (start_kernel+0x0/0x318) from [<00008078>] (0x8078)
 r8:0000406a r7:c0dec2c4 r6:c067d028 r5:c0de8464 r4:18c5387d
---[ end trace 1b75b31a2719ed1c ]---
BUG: spinlock lockup suspected on CPU#0, swapper/0/0
 lock: init_thread_union+0x1ef8/0x2000, .magic: 00000000, .owner:
/-1067100856, .owner_cpu: -1066951520
Backtrace:
[<c0012520>] (dump_backtrace+0x0/0x104) from [<c04b5bc4>]
(dump_stack+0x18/0x1c)
 r6:00064000 r5:c0de1ef8 r4:c0de1ef8 r3:00000000
[<c04b5bac>] (dump_stack+0x0/0x1c) from [<c04b9d24>] (spin_dump+0x80/0x94)
[<c04b9ca4>] (spin_dump+0x0/0x94) from [<c028b924>]
(do_raw_spin_lock+0x10c/0x15c)
 r5:00000000 r4:00064000
[<c028b818>] (do_raw_spin_lock+0x0/0x15c) from [<c04bdf6c>]
(_raw_spin_lock_irqsave+0x68/0x74)
[<c04bdf04>] (_raw_spin_lock_irqsave+0x0/0x74) from [<c0679ca0>]
(rcu_cpu_notify+0xb4/0x21c)
 r6:c0de1ef8 r5:c0df4680 r4:c0de1ef8
[<c0679bec>] (rcu_cpu_notify+0x0/0x21c) from [<c06624e8>]
(rcu_init+0x1e8/0x250)
[<c0662300>] (rcu_init+0x0/0x250) from [<c06556e8>]
(start_kernel+0x1ac/0x318)
[<c065553c>] (start_kernel+0x0/0x318) from [<00008078>] (0x8078)
 r8:0000406a r7:c0dec2c4 r6:c067d028 r5:c0de8464 r4:18c5387d


And it stops. As I am not an expert with Linux kernel, can someone tell me
what this means and how to resolve it?

Any help would be nice.

Best,
John

On Fri, Nov 28, 2014 at 2:40 PM, John Sini <jhnsini@gmail.com> wrote:

>
>
> On Fri, Nov 28, 2014 at 2:03 PM, John Sini <jhnsini@gmail.com> wrote:
>
>>
>>
>> On Fri, Nov 28, 2014 at 12:13 PM, Gilles Chanteperdrix <
>> gilles.chanteperdrix@xenomai.org> wrote:
>>
>>> On Fri, Nov 28, 2014 at 12:03:09PM +0100, John Sini wrote:
>>> > Hello,
>>> >
>>> > I am new with Xenomai and I am trying to port it to linux-xlnx-V14.5
>>> zynq
>>> > as suggested on the following site:
>>> >
>>> > http://www.wiki.xilinx.com/Xenomai+for+Zynq
>>> >
>>> > Patches that I have applied(in the following order)
>>> >
>>> >
>>> > *ipipe-core-3.8-zynq-pre.patch*
>>> > *ipipe-core-3.8-arm-1.patch*
>>> > *ipipe-core-3.8-zynq-post.patch*
>>> >
>>> >
>>> > I have disabled the support of RPMsg ((remoteproc) and of CPU_HOTPLUG
>>> > prior to compiling the kernel(I configured the kernel as suggested on
>>> > the aforementioned website). I get getting the following warnings:
>>> >
>>> > WARNING: vmlinux.o(.text+0x106b4): Section mismatch in reference from
>>> > the function __ipipe_tsc_register() to the variable
>>> > .init.text:__kuser_helper_end
>>> > The function __ipipe_tsc_register() references
>>> > the variable __init __kuser_helper_end.
>>> > This is often because __ipipe_tsc_register lacks a __init
>>> > annotation or the annotation of __kuser_helper_end is wrong.
>>> >
>>> > WARNING: vmlinux.o(.text+0x106b8): Section mismatch in reference from
>>> > the function __ipipe_tsc_register() to the variable
>>> > .init.text:__ipipe_tsc_area_start
>>> > The function __ipipe_tsc_register() references
>>> > the variable __init __ipipe_tsc_area_start.
>>> > This is often because __ipipe_tsc_register lacks a __init
>>> > annotation or the annotation of __ipipe_tsc_area_start is wrong.
>>>
>>> For this, you can do what the warning says, add the __init attribute
>>> to the __ipipe_tsc_register function. This has been made in later
>>> patches. 3.8 is old, we do not have the necessary resources to
>>> maintain all past versions of the I-pipe patch at all times.
>>>
>>
>>    Thank you for your answer. I have found __ipipe_tsc_register function
>> in:
>>
>>     */arch/arm/kernel/ipipe_tsc.c*
>>
>
>        I guess it's like this:
>
>> *  void __init __ipipe_tsc_register(struct __ipipe_tscinfo *info) {
>> struct ipipe_tsc_value_t *vector_tsc_value; unsigned long *tsc_addr;
>> __ipipe_tsc_t *implem; unsigned long flags; int registered; char *tsc_area;*
>>
>>
>> *#if !defined(CONFIG_CPU_USE_DOMAINS) ......etc ..*
>>
>>
>> *and in the header file:*
>>
>>  */arch/arm/include/asm/ipipe.h*
>>
>> *void **__init __ipipe_tsc_register**(struct __ipipe_tscinfo *info); *
>>
>>
>> Are these only two places where I have to add  the __init attribute and
>> how exactly would you add it?
>>
>>
>>
>>>
>>> >
>>> > WARNING: vmlinux.o(.text+0x2ea760): Section mismatch in reference from
>>> > the function vexpress_sysreg_probe() to the function
>>> > .init.text:vexpress_sysreg_setup()
>>> > The function vexpress_sysreg_probe() references
>>> > the function __init vexpress_sysreg_setup().
>>> > This is often because vexpress_sysreg_probe lacks a __init
>>> > annotation or the annotation of vexpress_sysreg_setup is wrong.
>>>
>>> This probably has nothing to do with Xenomai.
>>>
>>> >
>>> >
>>> > Can any of you help me how to fix these warnings? I have seen the same
>>> > problem here:
>>> >
>>> > http://www.xenomai.org/pipermail/xenomai/2013-October/029390.html
>>> >
>>> > But I have disabled all necessary options in the kernel config and
>>> > still get these warnings.
>>>
>>> what necessary option?
>>>
>>>
>>  Are there any new Xenomai patches that work with some newer version of
>> Kernel? IIRC, xenomai 2.6.4 also uses xilinx-v14.5 and same patches, right?
>>
>>
>> Many thanks for your previous answers.
>>
>> Best,
>> John
>>
>>
>>
>> --
>>>                                             Gilles.
>>>
>>
>>
>
