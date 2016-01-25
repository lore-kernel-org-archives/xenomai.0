References: <56A5761B.70501@grom.net>
 <CA+CJOCykM6VeHwyRtjwVC9H+RZw--=qTySzCv8bBXdJU1PHbpQ@mail.gmail.com>
From: Elmar Grom <elmar@grom.net>
Message-ID: <56A63F7F.4030109@grom.net>
Date: Mon, 25 Jan 2016 07:30:07 -0800
MIME-Version: 1.0
In-Reply-To: <CA+CJOCykM6VeHwyRtjwVC9H+RZw--=qTySzCv8bBXdJU1PHbpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai build for Raspberry Pi
Reply-To: elmar@grom.net
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Nicolas SCHURANDO <schurann@ext.essilor.com>
Cc: xenomai@xenomai.org

Nicolas,

thanks a bunch. Of course I cannot be not sure if it helps yet but it 
gives me some next steps to work on. Looks like a potential path to success.

BTW, I am working with the Raspberry Pi 2. I will definitely report back 
about my level of success.

Elmar

On 1/25/2016 7:16 AM, Nicolas SCHURANDO wrote:
> Hi Elmar,
>
> The version of the linux kernel you should use is determined by the 
> version of the i-pipe patch that is available for the hardware you are 
> targeting. Here, as it is probably the case for most embedded boards, 
> it turns out that the i-pipe patch alone is not enough.
>
> If you are using a raspberry pi 1, you will also have to apply the 
> ipipe-core-3.8.13-raspberry-pre-2.patch and 
> ipipe-core-3.8.13-raspberry-post-2.patch patches. And you'll then have 
> to use the 'rpi-3.8.y' branch of the raspberry pi kernel source.
>
> If you are using a raspberry pi 2, you can find the necessary patch 
> that Mathieu Rondonneau wrote two months ago at 
> https://xenomai.org/pipermail/xenomai/2015-November/035487.html. And 
> you'll then have to use the 'rpi-3.18.y' branch of the raspberry pi 
> kernel source.
>
> Hope this helps,
>
> Nicolas
>
> 2016-01-25 2:10 GMT+01:00 Elmar Grom <elmar@grom.net 
> <mailto:elmar@grom.net>>:
>
>     Hi,
>
>     I think before jumping right into my current problem it might be a
>     good
>     idea to explain where I am coming from, as there might be other
>     solutions to my problem.
>
>     What I need is Xenomai running on a Raspberry Pi to operate Machine
>     Kit. This can be downloaded pre-compiled, which I did and it's running
>     fine. So, there shouldn't be any need for me to build Xenomai from
>     sources. The problem is that I need the touchscreen driver for the now
>     available official Raspberry Pi touchscreen. That was not in the build
>     I managed to get, as it was obviously compiled before the touchscreen
>     was available. Using a copy of the driver binary
>     (drivers/input/touchscreen/rpi-ft5406.ko) and re-building
>     dependencies made the
>     driver available but the load attempt failed with a message indicating
>     binary format incompatibilities. At this point I saw myself forced to
>     build the OS myself from sources. My goals was, once that worked to
>     include the driver source in the build and hopefully have myself a
>     functioning installation. BTW, I am trying to cross compile form
>     an x86 machine running Ubuntu.
>
>     Now, I am not a Linux hot-shot and have never built a kernel
>     before, so
>     things are a bit shaky. Though I did a good bit of studying on the
>     topic in recent weeks.
>
>     I think I have finally figured out all the things I need to download
>     and install. I also think I managed to generate a good build of the
>     basic Raspberry Pi. Perhaps I should try to install the image and see
>     if that is true, but I wanted to press on and try to get compiles to
>     function.
>
>     At this point I m trying to do step number 1, configure the patch for
>     Xenomai 3.0.1 with linux-rpi 4.1 using ipipe-core-4.1-arm-1.patch.
>     As I
>     understand it, the patch number must match the release number of the
>     target core as closely as possible. So this should be the correct
>     patch.
>
>     Below is the output captured from the console. As you can see it
>     failed
>     to apply the patch. I can see two locations indicated where it failed.
>     At this point I am really at a loss as to what to do next. Any advise
>     would be greatly appreciated.
>
>     scripts/prepare-kernel.sh --arch=arm --linux=~/linux \
>     --ipipe=ipipe-core-4.1-arm-1.patch
>
>     checking file arch/arm/Kconfig
>     Hunk #3 succeeded at 533 (offset 36 lines).
>     Hunk #4 succeeded at 720 (offset 37 lines).
>     Hunk #5 succeeded at 1023 (offset 40 lines).
>     Hunk #6 succeeded at 1542 (offset 40 lines).
>     checking file arch/arm/boot/compressed/decompress.c
>     checking file arch/arm/boot/compressed/head.S
>     checking file arch/arm/boot/compressed/string.c
>     checking file arch/arm/boot/dts/Makefile
>     Hunk #1 succeeded at 1 with fuzz 1.
>     checking file arch/arm/boot/dts/imx6qdl.dtsi
>     checking file arch/arm/boot/dts/omap3-igep0020-3430.dts
>     checking file arch/arm/boot/dts/omap3430-igep.dtsi
>     checking file arch/arm/boot/dts/omap4.dtsi
>     checking file arch/arm/common/it8152.c
>     checking file arch/arm/common/timer-sp.c
>     checking file arch/arm/include/asm/arch_timer.h
>     checking file arch/arm/include/asm/assembler.h
>     checking file arch/arm/include/asm/atomic.h
>     checking file arch/arm/include/asm/barrier.h
>     checking file arch/arm/include/asm/bitops.h
>     checking file arch/arm/include/asm/cacheflush.h
>     checking file arch/arm/include/asm/cmpxchg.h
>     checking file arch/arm/include/asm/entry-macro-multi.S
>     Hunk #1 succeeded at 12 (offset 1 line).
>     Hunk #2 succeeded at 29 with fuzz 1 (offset 1 line).
>     checking file arch/arm/include/asm/fcse.h
>     checking file arch/arm/include/asm/hardware/timer-sp.h
>     checking file arch/arm/include/asm/ipipe.h
>     checking file arch/arm/include/asm/ipipe_base.h
>     checking file arch/arm/include/asm/ipipe_hwirq.h
>     checking file arch/arm/include/asm/irq.h
>     checking file arch/arm/include/asm/irqflags.h
>     Hunk #2 succeeded at 175 (offset 10 lines).
>     checking file arch/arm/include/asm/memory.h
>     checking file arch/arm/include/asm/mmu.h
>     checking file arch/arm/include/asm/mmu_context.h
>     checking file arch/arm/include/asm/percpu.h
>     checking file arch/arm/include/asm/pgtable.h
>     checking file arch/arm/include/asm/proc-fns.h
>     checking file arch/arm/include/asm/processor.h
>     checking file arch/arm/include/asm/resource.h
>     checking file arch/arm/include/asm/setup.h
>     checking file arch/arm/include/asm/switch_to.h
>     checking file arch/arm/include/asm/thread_info.h
>     checking file arch/arm/include/asm/tlbflush.h
>     checking file arch/arm/include/asm/uaccess.h
>     Hunk #6 succeeded at 473 with fuzz 1.
>     checking file arch/arm/include/uapi/asm/mman.h
>     checking file arch/arm/include/uapi/asm/unistd.h
>     checking file arch/arm/kernel/Makefile
>     checking file arch/arm/kernel/asm-offsets.c
>     checking file arch/arm/kernel/devtree.c
>     checking file arch/arm/kernel/entry-armv.S
>     checking file arch/arm/kernel/entry-common.S
>     checking file arch/arm/kernel/entry-header.S
>     checking file arch/arm/kernel/hibernate.c
>     checking file arch/arm/kernel/ipipe.c
>     checking file arch/arm/kernel/ipipe_tsc.c
>     checking file arch/arm/kernel/ipipe_tsc_asm.S
>     checking file arch/arm/kernel/perf_callchain.c
>     checking file arch/arm/kernel/process.c
>     checking file arch/arm/kernel/ptrace.c
>     checking file arch/arm/kernel/raw_printk.c
>     checking file arch/arm/kernel/setup.c
>     checking file arch/arm/kernel/signal.c
>     Hunk #1 succeeded at 569 (offset 5 lines).
>     Hunk #2 succeeded at 594 (offset 5 lines).
>     checking file arch/arm/kernel/smp.c
>     checking file arch/arm/kernel/smp_twd.c
>     checking file arch/arm/kernel/suspend.c
>     checking file arch/arm/kernel/traps.c
>     checking file arch/arm/kernel/vdso.c
>     checking file arch/arm/mach-at91/Kconfig
>     checking file arch/arm/mach-at91/Makefile
>     checking file arch/arm/mach-at91/at91_ipipe.c
>     checking file arch/arm/mach-at91/at91_ipipe.h
>     checking file arch/arm/mach-at91/at91sam926x_time.c
>     checking file arch/arm/mach-at91/include/mach/at91_ipipe.h
>     checking file arch/arm/mach-davinci/Kconfig
>     checking file arch/arm/mach-davinci/cp_intc.c
>     checking file arch/arm/mach-davinci/time.c
>     checking file arch/arm/mach-imx/3ds_debugboard.c
>     checking file arch/arm/mach-imx/Kconfig
>     checking file arch/arm/mach-imx/avic.c
>     checking file arch/arm/mach-imx/clk-imx1.c
>     checking file arch/arm/mach-imx/clk-imx21.c
>     checking file arch/arm/mach-imx/clk-imx27.c
>     checking file arch/arm/mach-imx/clk-imx31.c
>     checking file arch/arm/mach-imx/clk-imx35.c
>     checking file arch/arm/mach-imx/clk-imx51-imx53.c
>     checking file arch/arm/mach-imx/common.h
>     checking file arch/arm/mach-imx/gpc.c
>     checking file arch/arm/mach-imx/mach-imx25.c
>     checking file arch/arm/mach-imx/mach-imx51.c
>     checking file arch/arm/mach-imx/mach-imx53.c
>     checking file arch/arm/mach-imx/mach-imx6q.c
>     checking file arch/arm/mach-imx/mach-mx31_3ds.c
>     checking file arch/arm/mach-imx/mach-mx31ads.c
>     checking file arch/arm/mach-imx/mm-imx1.c
>     checking file arch/arm/mach-imx/mm-imx27.c
>     checking file arch/arm/mach-imx/mm-imx3.c
>     checking file arch/arm/mach-imx/mm-imx5.c
>     checking file arch/arm/mach-imx/time.c
>     checking file arch/arm/mach-imx/tzic.c
>     checking file arch/arm/mach-integrator/core.c
>     checking file arch/arm/mach-integrator/integrator_cp.c
>     checking file arch/arm/mach-ixp4xx/common.c
>     checking file arch/arm/mach-ixp4xx/include/mach/platform.h
>     checking file arch/arm/mach-mxs/Kconfig
>     checking file arch/arm/mach-omap2/Kconfig
>     checking file arch/arm/mach-omap2/io.c
>     checking file arch/arm/mach-omap2/irq.c
>     checking file arch/arm/mach-omap2/mux.c
>     checking file arch/arm/mach-omap2/omap-wakeupgen.c
>     Hunk #3 succeeded at 411 with fuzz 2.
>     checking file arch/arm/mach-omap2/pm34xx.c
>     checking file arch/arm/mach-omap2/pm44xx.c
>     checking file arch/arm/mach-omap2/prm_common.c
>     checking file arch/arm/mach-omap2/timer.c
>     checking file arch/arm/mach-pxa/irq.c
>     checking file arch/arm/mach-pxa/lpd270.c
>     checking file arch/arm/mach-pxa/pcm990-baseboard.c
>     checking file arch/arm/mach-pxa/time.c
>     checking file arch/arm/mach-pxa/viper.c
>     checking file arch/arm/mach-realview/core.c
>     checking file arch/arm/mach-realview/core.h
>     checking file arch/arm/mach-realview/realview_eb.c
>     checking file arch/arm/mach-realview/realview_pb1176.c
>     checking file arch/arm/mach-realview/realview_pb11mp.c
>     checking file arch/arm/mach-realview/realview_pba8.c
>     checking file arch/arm/mach-realview/realview_pbx.c
>     checking file arch/arm/mach-s3c24xx/bast-irq.c
>     checking file arch/arm/mach-sa1100/irq.c
>     checking file arch/arm/mach-spear/Kconfig
>     checking file arch/arm/mach-spear/time.c
>     checking file arch/arm/mach-versatile/core.c
>     checking file arch/arm/mm/Kconfig
>     checking file arch/arm/mm/Makefile
>     checking file arch/arm/mm/alignment.c
>     checking file arch/arm/mm/cache-l2x0.c
>     checking file arch/arm/mm/context.c
>     checking file arch/arm/mm/copypage-v4mc.c
>     checking file arch/arm/mm/copypage-xscale.c
>     checking file arch/arm/mm/fault-armv.c
>     checking file arch/arm/mm/fault.c
>     checking file arch/arm/mm/fcse.c
>     checking file arch/arm/mm/flush.c
>     checking file arch/arm/mm/idmap.c
>     checking file arch/arm/mm/ioremap.c
>     checking file arch/arm/mm/mmap.c
>     checking file arch/arm/mm/pgd.c
>     checking file arch/arm/mm/proc-arm920.S
>     checking file arch/arm/mm/proc-arm926.S
>     checking file arch/arm/mm/proc-feroceon.S
>     checking file arch/arm/mm/proc-xscale.S
>     checking file arch/arm/plat-omap/dmtimer.c
>     checking file arch/arm/plat-omap/include/plat/dmtimer.h
>     checking file arch/arm/plat-samsung/include/plat/gpio-core.h
>     checking file arch/arm/vfp/entry.S
>     checking file arch/arm/vfp/vfphw.S
>     checking file arch/arm/vfp/vfpmodule.c
>     checking file drivers/clocksource/arm_arch_timer.c
>     checking file drivers/clocksource/arm_global_timer.c
>     checking file drivers/clocksource/mxs_timer.c
>     checking file drivers/clocksource/pxa_timer.c
>     checking file drivers/gpio/gpio-davinci.c
>     checking file drivers/gpio/gpio-mvebu.c
>     checking file drivers/gpio/gpio-mxc.c
>     checking file drivers/gpio/gpio-mxs.c
>     checking file drivers/gpio/gpio-omap.c
>     checking file drivers/gpio/gpio-pxa.c
>     checking file drivers/gpio/gpio-sa1100.c
>     checking file drivers/gpio/gpio-zynq.c
>     checking file drivers/gpu/ipu-v3/ipu-common.c
>     checking file drivers/gpu/ipu-v3/ipu-prv.h
>     checking file drivers/irqchip/irq-atmel-aic.c
>     checking file drivers/irqchip/irq-atmel-aic5.c
>     Hunk #2 FAILED at 96.
>     Hunk #3 FAILED at 110.
>     Hunk #4 succeeded at 147 (offset 8 lines).
>     Hunk #5 succeeded at 169 (offset 8 lines).
>     Hunk #6 succeeded at 185 (offset 8 lines).
>     Hunk #7 succeeded at 194 (offset 8 lines).
>     Hunk #8 succeeded at 210 (offset 8 lines).
>     Hunk #9 succeeded at 219 (offset 8 lines).
>     Hunk #10 succeeded at 275 (offset 8 lines).
>     Hunk #11 succeeded at 289 (offset 8 lines).
>     Hunk #12 succeeded at 351 (offset 8 lines).
>     2 out of 12 hunks FAILED
>     checking file drivers/irqchip/irq-bcm7120-l2.c
>     checking file drivers/irqchip/irq-brcmstb-l2.c
>     checking file drivers/irqchip/irq-dw-apb-ictl.c
>     checking file drivers/irqchip/irq-gic-v3.c
>     checking file drivers/irqchip/irq-gic.c
>     checking file drivers/irqchip/irq-mxs.c
>     checking file drivers/irqchip/irq-omap-intc.c
>     checking file drivers/irqchip/irq-s3c24xx.c
>     checking file drivers/irqchip/irq-sunxi-nmi.c
>     checking file drivers/irqchip/irq-versatile-fpga.c
>     checking file drivers/irqchip/irq-vic.c
>     checking file drivers/irqchip/spear-shirq.c
>     checking file drivers/memory/omap-gpmc.c
>     checking file drivers/mfd/twl4030-irq.c
>     checking file drivers/mfd/twl6030-irq.c
>     checking file drivers/misc/Kconfig
>     Hunk #1 succeeded at 69 (offset 8 lines).
>     checking file drivers/pinctrl/pinctrl-at91.c
>     Hunk #3 succeeded at 1629 (offset 15 lines).
>     Hunk #4 succeeded at 1684 (offset 15 lines).
>     Hunk #5 succeeded at 1784 (offset 15 lines).
>     Hunk #6 succeeded at 1853 (offset 15 lines).
>     checking file drivers/pinctrl/pinctrl-rockchip.c
>     checking file drivers/pinctrl/pinctrl-single.c
>     checking file drivers/tty/serial/xilinx_uartps.c
>     checking file drivers/cpuidle/Kconfig
>     checking file drivers/tty/serial/8250/8250_core.c
>     Hunk #1 succeeded at 3442 (offset 10 lines).
>     Hunk #2 succeeded at 3593 (offset 10 lines).
>     checking file fs/exec.c
>     checking file include/asm-generic/atomic.h
>     checking file include/asm-generic/bitops/atomic.h
>     checking file include/asm-generic/cmpxchg-local.h
>     checking file include/asm-generic/percpu.h
>     checking file include/asm-generic/preempt.h
>     checking file include/asm-generic/switch_to.h
>     checking file include/ipipe/setup.h
>     checking file include/ipipe/thread_info.h
>     checking file include/linux/clockchips.h
>     checking file include/linux/clocksource.h
>     checking file include/linux/console.h
>     checking file include/linux/hardirq.h
>     checking file include/linux/i8253.h
>     checking file include/linux/ipipe.h
>     checking file include/linux/ipipe_base.h
>     checking file include/linux/ipipe_compat.h
>     checking file include/linux/ipipe_debug.h
>     checking file include/linux/ipipe_domain.h
>     checking file include/linux/ipipe_lock.h
>     checking file include/linux/ipipe_tickdev.h
>     checking file include/linux/ipipe_trace.h
>     checking file include/linux/irq.h
>     Hunk #3 succeeded at 583 (offset 1 line).
>     Hunk #4 succeeded at 758 (offset 1 line).
>     Hunk #5 succeeded at 859 (offset 1 line).
>     checking file include/linux/irqchip/arm-gic.h
>     checking file include/linux/irqdesc.h
>     checking file include/linux/irqnr.h
>     checking file include/linux/kernel.h
>     checking file include/linux/kvm_host.h
>     checking file include/linux/preempt.h
>     Hunk #2 succeeded at 126 (offset 1 line).
>     Hunk #3 succeeded at 154 (offset 1 line).
>     checking file include/linux/printk.h
>     checking file include/linux/rwlock.h
>     checking file include/linux/rwlock_api_smp.h
>     checking file include/linux/sched.h
>     checking file include/linux/spinlock.h
>     checking file include/linux/spinlock_api_smp.h
>     checking file include/linux/spinlock_up.h
>     checking file include/linux/timekeeper_internal.h
>     checking file include/uapi/asm-generic/mman-common.h
>     checking file include/uapi/asm-generic/resource.h
>     checking file include/uapi/linux/resource.h
>     checking file init/Kconfig
>     checking file init/main.c
>     Hunk #4 succeeded at 882 (offset 1 line).
>     checking file kernel/Makefile
>     checking file kernel/context_tracking.c
>     checking file kernel/debug/debug_core.c
>     checking file kernel/debug/gdbstub.c
>     checking file kernel/exit.c
>     checking file kernel/fork.c
>     checking file kernel/ipipe/Kconfig
>     checking file kernel/ipipe/Kconfig.debug
>     checking file kernel/ipipe/Makefile
>     checking file kernel/ipipe/compat.c
>     checking file kernel/ipipe/core.c
>     checking file kernel/ipipe/timer.c
>     checking file kernel/ipipe/tracer.c
>     checking file kernel/irq/chip.c
>     checking file kernel/irq/generic-chip.c
>     checking file kernel/irq/internals.h
>     checking file kernel/irq/irqdesc.c
>     checking file kernel/irq/manage.c
>     checking file kernel/locking/lockdep.c
>     checking file kernel/locking/spinlock.c
>     checking file kernel/module.c
>     Hunk #1 succeeded at 943 (offset 4 lines).
>     Hunk #2 succeeded at 951 (offset 4 lines).
>     Hunk #3 succeeded at 962 (offset 4 lines).
>     checking file kernel/panic.c
>     checking file kernel/power/hibernate.c
>     checking file kernel/printk/printk.c
>     Hunk #2 succeeded at 1260 (offset 1 line).
>     Hunk #3 succeeded at 1313 (offset -3 lines).
>     Hunk #4 succeeded at 1333 (offset -3 lines).
>     Hunk #5 succeeded at 1624 (offset -3 lines).
>     Hunk #6 succeeded at 1692 (offset -3 lines).
>     Hunk #7 succeeded at 1707 (offset -3 lines).
>     Hunk #8 succeeded at 1785 (offset -3 lines).
>     Hunk #9 succeeded at 1828 (offset -3 lines).
>     Hunk #10 succeeded at 1888 (offset -3 lines).
>     Hunk #11 succeeded at 1960 (offset -3 lines).
>     Hunk #12 succeeded at 1999 (offset -3 lines).
>     Hunk #13 succeeded at 2647 (offset -3 lines).
>     Hunk #14 succeeded at 2703 (offset -3 lines).
>     Hunk #15 succeeded at 2798 (offset -3 lines).
>     checking file kernel/sched/core.c
>     Hunk #6 succeeded at 2568 (offset 7 lines).
>     Hunk #7 succeeded at 2597 (offset 7 lines).
>     Hunk #8 succeeded at 2652 (offset 7 lines).
>     Hunk #9 succeeded at 2750 (offset 7 lines).
>     Hunk #10 succeeded at 2763 (offset 7 lines).
>     Hunk #11 succeeded at 2820 (offset 7 lines).
>     Hunk #12 succeeded at 2853 (offset 7 lines).
>     Hunk #13 succeeded at 2894 (offset 7 lines).
>     Hunk #14 succeeded at 2918 (offset 7 lines).
>     Hunk #15 succeeded at 3647 (offset 7 lines).
>     Hunk #16 succeeded at 4831 (offset 7 lines).
>     Hunk #17 succeeded at 8423 (offset 15 lines).
>     checking file kernel/sched/wait.c
>     checking file kernel/signal.c
>     checking file kernel/time/clockevents.c
>     checking file kernel/time/clocksource.c
>     checking file kernel/time/tick-common.c
>     checking file kernel/time/tick-sched.c
>     checking file kernel/time/timekeeping.c
>     checking file kernel/time/timer.c
>     checking file kernel/trace/Kconfig
>     checking file kernel/trace/ftrace.c
>     Hunk #2 succeeded at 2519 (offset 18 lines).
>     Hunk #3 succeeded at 2535 (offset 18 lines).
>     Hunk #4 succeeded at 4887 (offset 18 lines).
>     Hunk #5 succeeded at 4989 (offset 18 lines).
>     Hunk #6 succeeded at 5186 (offset 15 lines).
>     checking file kernel/trace/ring_buffer.c
>     checking file kernel/trace/trace.c
>     checking file kernel/trace/trace_clock.c
>     checking file kernel/trace/trace_functions.c
>     checking file kernel/trace/trace_functions_graph.c
>     checking file lib/Kconfig.debug
>     checking file lib/atomic64.c
>     checking file lib/bust_spinlocks.c
>     checking file lib/ioremap.c
>     checking file lib/smp_processor_id.c
>     checking file mm/Kconfig
>     checking file mm/memory.c
>     Hunk #7 succeeded at 3887 (offset 6 lines).
>     checking file mm/mlock.c
>     checking file mm/mmap.c
>     checking file mm/mmu_context.c
>     checking file mm/mprotect.c
>     checking file mm/vmalloc.c
>     prepare-kernel.sh: Unable to patch kernel 4.1.15 with
>     ipipe-core-4.1-arm-1.patch
>
>
>     _______________________________________________
>     Xenomai mailing list
>     Xenomai@xenomai.org <mailto:Xenomai@xenomai.org>
>     http://xenomai.org/mailman/listinfo/xenomai
>
>

