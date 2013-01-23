In-Reply-To: <50FF8B16.3060100@xenomai.org>
References: <OF682F5C70.F8F7AA50-ON85257AF1.005F580A-85257AF1.005F580C@aanddtech.com>	<50F3DD9A.9050306@gmail.com>
	<OF5CF00330.868585F8-ON85257AFA.00801D57-85257AFB.00000E92@aanddtech.com>
	<50FE45E9.1040909@xenomai.org>	<OF518EBAA9.1B02356C-ON85257AFC.00002A9B-85257AFC.00028E23@aanddtech.com>
	<50FF4434.7030405@xenomai.org>
	<CAFVR4DVpsR026fvgybs91iC7-gDLVvBS8wsXBRO0XdzLBcXzpg@mail.gmail.com>
	<50FF8B16.3060100@xenomai.org>
MIME-Version: 1.0
Message-ID: <OFC84FDBBF.88E9186F-ON85257AFC.007B4CC3-85257AFC.008309FB@aanddtech.com>
From: mfornero@aanddtech.com
Date: Wed, 23 Jan 2013 18:51:17 -0500
Content-Type: text/plain; charset="US-ASCII"
Subject: Re: [Xenomai] Porting Ipipe to new ARM SoC (Xilinx Zynq)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai@xenomai.org

Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote on 
01/23/2013 02:02:46 AM:

> From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> To: Matthew Fornero <matthew.fornero@gmail.com>, 
> Cc: Xenomai@xenomai.org, mfornero@aanddtech.com
> Date: 01/23/2013 02:02 AM
> Subject: Re: [Xenomai] Porting Ipipe to new ARM SoC (Xilinx Zynq)
> 
> On 01/23/2013 04:43 AM, Matthew Fornero wrote:
> 
> > I'll cat out the proc/interrupts when I get to the office tomorrow. I
> > did read the porting guide, but stupidly missed that function call. On
> > this dev kit, we're not initially planning to use GPIO from our code
> > (real time or otherwise), but of course they could be used by various
> > peripherals.
> > 
> > I'm somewhat new to arm (mostly worked on x86 until now), so please
> > excuse my ignorance-- would there be another irq chip or something I
> > need to multiplex in other driver files (other than the
> > gpio-xilinxps.c file)? Is there an existing platform I can reference
> > for this? Maybe some code in the board level file as well?

Here's /proc/interrupts on the running system (before xeno_nucleus module 
is loaded)
/ # cat /proc/interrupts
           CPU0       CPU1
 29:        429        161       GIC  twd
 40:          0          0       GIC  xdevcfg
 43:          8          0       GIC  xttcpss clockevent
 45:          0          0       GIC  pl330
 46:          0          0       GIC  pl330
 47:          0          0       GIC  pl330
 48:          0          0       GIC  pl330
 49:          0          0       GIC  pl330
 51:          0          0       GIC  e000d000.ps7-qspi
 53:          0          0       GIC  ehci_hcd:usb1
 54:        815          0       GIC  eth0
 56:        465          0       GIC  mmc0
 72:          0          0       GIC  pl330
 73:          0          0       GIC  pl330
 74:          0          0       GIC  pl330
 75:          0          0       GIC  pl330
 82:         43          0       GIC  xuartps
IPI0:          0          0  Timer broadcast interrupts
IPI1:       1425       1551  Rescheduling interrupts
IPI2:          0          0  Function call interrupts
IPI3:         50         49  Single function call interrupts
IPI4:          0          0  CPU stop interrupts
Err:          0

Things of note:
twd is the (per cpu) timer used by the ipipe
xttcpss is a triple timer counter within the SoC, which appears to only be 
used until the twd timer is setup-- this timer is *not* ported to the 
Ipipe, which I assumed was okay because the twd is used-- is this 
assumption correct?

Here's /proc/interrupts after xeno_nucleus is loaded:
~ # cat /proc/interrupts
           CPU0       CPU1
 29:        922        331       GIC  twd
 40:          0          0       GIC  xdevcfg
 43:          8          0       GIC  xttcpss clockevent
 45:          0          0       GIC  pl330
 46:          0          0       GIC  pl330
 47:          0          0       GIC  pl330
 48:          0          0       GIC  pl330
 49:          0          0       GIC  pl330
 51:          0          0       GIC  e000d000.ps7-qspi
 53:          0          0       GIC  ehci_hcd:usb1
 54:       2237          0       GIC  eth0
 56:        620          0       GIC  mmc0
 72:          0          0       GIC  pl330
 73:          0          0       GIC  pl330
 74:          0          0       GIC  pl330
 75:          0          0       GIC  pl330
 82:        268          0       GIC  xuartps
IPI0:          0          0  Timer broadcast interrupts
IPI1:       1519       1762  Rescheduling interrupts
IPI2:          0          0  Function call interrupts
IPI3:         50         49  Single function call interrupts
IPI4:          0          0  CPU stop interrupts
Err:          0

Here's /proc/xenomai

~ # cat /proc/xenomai/irq
IRQ         CPU0        CPU1
520:           0           0         [sync]
523:           0           1         [virtual]
526:           0           0         [virtual]

~ # cat /proc/xenomai/timer
status=off:setup=417:clock=181689455350:timerdev=local_timer:clockdev=ipipe_tsc

> 
> 
> Each platform defines its own irqchips for multiplexed GPIOs. If you
> want to track all invalid GPIO demuxers, you can enable ipipe debugging
> and add ipipe_root_only() inside "generic_handle_irq".

I tested this, and never triggered the debug code-- I assume this means no 
calls to generic_handle_irq were made in the head domain?

> 
> > 
> > I'll try the remainder of the above debug steps as well. Unfortunately
> > our JTAG environment isn't totally stable, but I should be able to get
> > something going.
> > 
> >>> If I boot with Xenomai off (CONFIG_XENOMAI = n) but IPIPE still on
> >>> (CONFIG_IPIPE = y), I get a warning at boot. Haven't looked into the
> >>> root cause of this-- but maybe it's related?
> >>>
> >>> mmc0: new high speed SDHC card at address b368
> >>> mmcblk0: mmc0:b368 F0F0F 3.71 GiB
> >>>  mmcblk0: p1 p2
> >>> EXT4-fs (mmcblk0p2): recovery complete
> >>> EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. 
Opts:
> >>> (null)
> >>> VFS: Mounted root (ext4 filesystem) on device 179:2.
> >>> devtmpfs: mounted
> >>> Freeing init memory: 160K
> >>> ------------[ cut here ]------------
> >>> WARNING: at arch/arm/mm/context.c:182 __new_context+0x40/0x118()
> >>
> >>
> >> Known issue, which I thought was fixed, but maybe not. Try this 
patch:
> >>
> >> diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
> >> index 3ae015f..79de5dc 100644
> >> --- a/arch/arm/mm/context.c
> >> +++ b/arch/arm/mm/context.c
> >> @@ -167,11 +167,12 @@ static inline void set_mm_context(struct 
mm_struct
> >> *mm, unsigned int asid)
> >>
> >>  void __new_context(struct mm_struct *mm)
> >>  {
> >> -       int cpu = ipipe_processor_id();
> >>         unsigned long flags;
> >>         unsigned int asid;
> >> +       int cpu;
> >>
> >>         asid_lock(flags);
> >> +       cpu = ipipe_processor_id();
> >>  #ifdef CONFIG_SMP
> >>         /*
> >>          * Check the ASID again, in case the change was broadcast 
from
> > 
> > Will try tomorrow and report if it resolves it.
> 
> 
> Forget it, it is purely a problem due to CONFIG_XENOMAI=n and
> CONFIG_IPIPE=y, in that case preemptible context switches do not get
> selected, __new_context gets called with irqs off, which can not work
> with CONFIG_IPIPE. The fix is to select IPIPE_WANT_PREEMPTIBLE_SWITCH
> with CONFIG_SMP, I thought I did it, but it probably got lost.
> 
> > 
> >>
> >>> If I boot with Xenomai on (CONFIG_XENOMAI = y) and Nucleus as a 
module
> >>> (CONFIG_XENO_OPT_NUCLEUS = m), the system boots without issue (not 
even
> >>> a warning at boot), but the Nucleus module fails to compile with the
> >>> following error:
> >>>
> >>> [mfornero@hwbuild linux]$ make -j8 modules
> >>>   CHK     include/linux/version.h
> >>>   CHK     include/generated/utsrelease.h
> >>> make[1]: `include/generated/mach-types.h' is up to date.
> >>>   CALL    scripts/checksyscalls.sh
> >>>   Building modules, stage 2.
> >>>   MODPOST 22 modules
> >>> ERROR: "current_mm" [kernel/xenomai/nucleus/xeno_nucleus.ko] 
undefined!
> >>> make[1]: *** [__modpost] Error 1
> >>> make: *** [modules] Error 2
> >>
> >>
> >> It simply means EXPORT_SYMBOL_GPL(current_mm) is missing.
> > 
> > So this export should go in something like arch/arm/include/asm/
> mmu_context.h?
> > 
> > Do I need to do anything special for the export given that it's
> > defined via "DECLARE_PER_CPU"?
> 
> 
> Right, you need to use EXPORT_PER_CPU_SYMBOL_GPL(current_mm).

Thanks-- this let me compile Xenomai as a module, which may help with 
debugging.

I found that the hang seems to occur when a skin is loaded, not nucleus. 
Something seems to happen at this point that prevents further SDHC 
interrupts.
It's not clear, but it also may have some effect on the UART (maybe all?) 
interrupt as well-- I observed a printk stop partway through a string as 
the nucleus module was loaded [note-- I am running through a serial 
console, and have MMC_DEBUG turned on] -- see timestamp 151.49

~ # insmod xeno_native.ko && watch -n 1 "dmesg | tail -n 40"
[  151.520000] Xenomai: starting native API services.

Every 1s: dmesg | tail -n 40                                1970-01-01 
00:02:31

[  151.470000] mmc0: req done (CMD18): 0: 00000900 00000000 00000000 
00000000
[  151.470000] mmc0:     131072 bytes transferred: 0
[  151.470000] mmc0:     (CMD12): 0: 00000b00 00000000 00000000 00000000
[  151.480000] mmc0: starting CMD18 arg 000ec822 flags 000000b5
[  151.480000] mmc0:     blksz 512 blocks 256 flags 00000200 tsac 100 ms 
nsac 0
[  151.480000] mmc0:     CMD12 arg 00000000 flags 0000049d
[  151.480000] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[  151.480000] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[  151.480000] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000003
[  151.480000] mmc0: req done (CMD18): 0: 00000900 00000000 00000000 
00000000
[  151.480000] mmc0:     131072 bytes transferred: 0
[  151.480000] mmc0:     (CMD12): 0: 00000b00 00000000 00000000 00000000
[  151.480000] mmc0: starting CMD18 arg 000ec922 flags 000000b5
[  151.480000] mmc0:     blksz 512 blocks 256 flags 00000200 tsac 100 ms 
nsac 0
[  151.480000] mmc0:     CMD12 arg 00000000 flags 0000049d
[  151.480000] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001
[  151.490000] sdhci [sdhci_irq()]: *** mmc0 got [  164.980000] mmc0: 
Timeout waiting for hardware interrupt.
[  164.980000] ------------[ cut here ]------------
[  164.990000] WARNING: at drivers/mmc/host/sdhci.c:963 
sdhci_send_command+0x28/0xbb8()
[  164.990000] Modules linked in: xeno_native xeno_nucleus
[  165.000000] [<c001423c>] (unwind_backtrace+0x0/0x11c) from [<c0021c68>] 
(warn_slowpath_common+0x4c/0x64)
[  165.010000] [<c0021c68>] (warn_slowpath_common+0x4c/0x64) from 
[<c0021c98>] (warn_slowpath_null+0x18/0x1c)
[  165.020000] [<c0021c98>] (warn_slowpath_null+0x18/0x1c) from 
[<c0294f60>] (sdhci_send_command+0x28/0xbb8)
[  165.030000] [<c0294f60>] (sdhci_send_command+0x28/0xbb8) from 
[<c0296370>] (sdhci_finish_data+0x2b4/0x2e8)
[  165.040000] [<c0296370>] (sdhci_finish_data+0x2b4/0x2e8) from 
[<c0296404>] (sdhci_timeout_timer+0x60/0xb4)
[  165.050000] [<c0296404>] (sdhci_timeout_timer+0x60/0xb4) from 
[<c002d8ec>] (run_timer_softirq+0x17c/0x234)
[  165.060000] [<c002d8ec>] (run_timer_softirq+0x17c/0x234) from 
[<c0028194>] (__do_softirq+0xb8/0x164)
[  165.070000] [<c0028194>] (__do_softirq+0xb8/0x164) from [<c00286c4>] 
(irq_exit+0x4c/0xa8)
[  165.070000] [<c00286c4>] (irq_exit+0x4c/0xa8) from [<c000f0d0>] 
(handle_IRQ+0x8c/0xd0)
[  165.080000] [<c000f0d0>] (handle_IRQ+0x8c/0xd0) from [<c0069794>] 
(__ipipe_do_sync_stage+0x1dc/0x260)
[  165.090000] [<c0069794>] (__ipipe_do_sync_stage+0x1dc/0x260) from 
[<c00084b0>] (__ipipe_grab_irq+0xc0/0xe4)
[  165.100000] [<c00084b0>] (__ipipe_grab_irq+0xc0/0xe4) from [<c00086dc>] 
(gic_handle_irq+0x38/0x5c)
[  165.110000] Exception stack(0xde867f88 to 0xde867fd0)
[  165.110000] 7f80:                   c000f41c c001c428 60000013 c000e300 
c09cfbdc 00000000
[  165.120000] 7fa0: 00524000 00000000 c04abbdc 00000015 10c0387d c04fc624 
0000406a 413fc090
[  165.130000] 7fc0: 00000000 00000000 c04fc308 de867fe0
[  165.140000] [<c00086dc>] (gic_handle_irq+0x38/0x5c) from [<c000e300>] 
(__irq_svc+0x40/0x6c)
[  165.140000] Exception stack(0xde867f98 to 0xde867fe0)
[  165.150000] 7f80: c09cfbdc 00000000
[  165.160000] 7fa0: 00524000 00000000 c04abbdc 00000015 10c0387d c04fc624 
0000406a 413fc090
[  165.170000] 7fc0: 00000000 00000000 c04fc308 de867fe0 c000f41c c001c428 
60000013 ffffffff
[  165.170000] [<c000e300>] (__irq_svc+0x40/0x6c) from [<c001c428>] 
(cpu_v7_do_idle+0x8/0xc)
[  165.180000] ---[ end trace 393701ba28551f74 ]---


I started to look into tracing the above warning-- but it appears to be 
the symptom rather than the root problem. I believe it occurs because the 
sdhc timeout has expired but the sdhc->cmd has not been cleared yet 
(normally cleared by the sdhc irq). 

Unfortunately, I also observed that the behavior is somewhat erratic-- 
sometimes loading the skin causes no issues, others it seems to prevent 
the above mentioned interrupts. Maybe some sort of timing has to line up 
between the skin loading and another interrupt to cause the issue?


> 
> -- 
>                                                                 Gilles.
