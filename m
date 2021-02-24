Date: Wed, 24 Feb 2021 17:33:33 -0300
From: Gabriel Dinse <gabriel_dinse@hotmail.com>
Subject: Re: Re: Re: Incompatible pointer type error when compiling kernel
Message-ID: <SN6PR08MB566102D4F3A8A7097DF1EA9F939F9@SN6PR08MB5661.namprd08.prod.outlook.com>
In-Reply-To: <CALLqZ8Ti4ebTvEotoTk_jGsAt2NhOFQhSz583TjZAmd+=RX-oA@mail.gmail.com>
References: <SN6PR08MB5661C6BD469CBCA19242507593819@SN6PR08MB5661.namprd08.prod.outlook.com>
 <SN6PR08MB566124E000C52029F78A42F093819@SN6PR08MB5661.namprd08.prod.outlook.com>
 <CALLqZ8Ti4ebTvEotoTk_jGsAt2NhOFQhSz583TjZAmd+=RX-oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: xenomai@xenomai.org



On Wed, Feb 24, 2021 at 12:05 am, Greg Gallagher=20
<greg@embeddedgreg.com> wrote:
>=20
>=20
> On Mon, Feb 22, 2021 at 6:30 PM Gabriel Dinse=20
> <gabriel_dinse@hotmail.com <mailto:gabriel_dinse@hotmail.com>> wrote:
>>=20
>>=20
>> On Mon, Feb 22, 2021 at 6:08 pm, Greg Gallagher=20
>> <greg@embeddedgreg.com <mailto:greg@embeddedgreg.com>> wrote:
>>>=20
>>>=20
>>> On Mon, Feb 22, 2021 at 5:44 PM Gabriel Dinse=20
>>> <gabriel_dinse@hotmail.com <mailto:gabriel_dinse@hotmail.com>>=20
>>> wrote:
>>>>=20
>>>>=20
>>>> On Mon, Feb 22, 2021 at 5:26 pm, Greg Gallagher=20
>>>> <greg@embeddedgreg.com <mailto:greg@embeddedgreg.com>> wrote:
>>>>>=20
>>>>>=20
>>>>> On Mon, Feb 22, 2021 at 3:19 PM Gabriel Dinse=20
>>>>> <gabriel_dinse@hotmail.com <mailto:gabriel_dinse@hotmail.com>>=20
>>>>> wrote:
>>>>>>=20
>>>>>>=20
>>>>>> On Mon, Feb 22, 2021 at 9:12 am, Greg Gallagher=20
>>>>>> <greg@embeddedgreg.com <mailto:greg@embeddedgreg.com>> wrote:
>>>>>>>=20
>>>>>>>=20
>>>>>>> On Mon, Feb 22, 2021 at 5:15 AM Gabriel Dinse via Xenomai=20
>>>>>>> <xenomai@xenomai.org <mailto:xenomai@xenomai.org>> wrote:
>>>>>>>>  > This is a 32-bit build running on the rpi3?
>>>>>>>>  Yes, it is
>>>>>>>>=20
>>>>>>>>   > I have some ipipe fixes coming, but I don't think these=20
>>>>>>>> are ipipe
>>>>>>>>  related.
>>>>>>>>   > Can you show how you patched and built your kernel? I'll=20
>>>>>>>> try to
>>>>>>>>  reproduce
>>>>>>>>   > on my end.  What compiler are you using?
>>>>>>>>=20
>>>>>>>>  For patching the kernel, I did:
>>>>>>>>  xenomai-3.1 on =EE=82=A0 main =E2=9E=9C ./scripts/prepare-kernel.=
sh
>>>>>>>>  --linux=3D~/Projects/linux-kernels/linux-5.4.93-ipipe --arch=3Dar=
m
>>>>>>>>  --ipipe=3D~/Projects/linux-kernels/ipipe-core-5.4.93-arm-0.patch
>>>>>>>>=20
>>>>>>>>  The config I'm using is multi_v7_defconfig modified a little=20
>>>>>>>> bit. The
>>>>>>>>  same configuration was fine for Vanilla kernel using the same=20
>>>>>>>> version
>>>>>>>>  (5.4.93), as I was pretending to compare both.
>>>>>>>>=20
>>>>>>>>  Toolchain I'm using, selected directly on=20
>>>>>>>> buildroot-2020.02.11 long
>>>>>>>>  term is: Linaro ARM 2018.05
>>>>>>>=20
>>>>>>> Okay, I used that defconfig during the port so there=20
>>>>>>> shouldn=E2=80=99t be a problem. Let me try with my repos and I=E2=
=80=99ll=20
>>>>>>> let you know shortly.
>>>>>>>=20
>>>>>>=20
>>>>>> Ok, sure
>>>>>> Let me know if I need to change configuration on my side from=20
>>>>>> compiling it again.
>>>>>>=20
>>>>>>> -Greg
>>>>>>>>=20
>>>>>>>>=20
>>>>> I built directly from the ipipe-arm tree, using Xenomai 3.1 ang=20
>>>>> gcc 10.  Other than a few warnings that I'll silence later=20
>>>>> everything built okay.  Let me take a look at the patch and see=20
>>>>> if something went wrong there.  In the meantime if you want to=20
>>>>> sync the ipipe-arm tree and use the ipipe/5.4.y patch you should=20
>>>>> be able to build no problem.  In the meantime I'll look at the=20
>>>>> patch, but I think our CI system uses the patch and hasn't seen=20
>>>>> any build issues.  If you could run your patch command again with=20
>>>>> --verbose and send the output maybe that may tell us something.
>>>>>=20
>>>>> Thanks
>>>>>=20
>>>>> Greg
>>>>=20
>>>> Could the problem be related to the toolchain used (Linaro ARM=20
>>>> 2018.05)?
>>>>=20
>>>> Another thing: when doing the Kernel configuration, I get the=20
>>>> warning:
>>>> *** WARNING! Page migration (CONFIG_MIGRATION) may increase ***
>>>> *** latency. ***
>>>> But I'm not able to disable "Page migration", nor "Contiguous=20
>>>> Memory Allocator", in "Memory Management options" menu.
>>>>=20
>>>> About running with --verbose, I got:
>>>>=20
>>>> xenomai-3.1 $ ./scripts/prepare-kernel.sh=20
>>>> --linux=3D~/Projects/linux-kernels/linux-5.4.93-ipipe --arch=3Darm=20
>>>> --ipipe=3D~/Projects/linux-kernels/ipipe-core-5.4.93-arm-0.patch=20
>>>> --verbose
>>>> Preparing kernel 5.4.94 in=20
>>>> /home/gabriel/Projects/linux-kernels/linux-5.4.93-ipipe
>>>> prepare-kernel.sh: no I-pipe support found.
>>>> checking file Documentation/ipipe-arm.rst
>>>> checking file Documentation/ipiperst
>>>> checking file arch/arm/Kconfig
>>>> checking file arch/arm/common/it8152.c
>>>> checking file arch/arm/include/asm/arch_timerh
>>>> checking file arch/arm/include/asm/assembler.h
>>>> checking file arch/arm/include/asm/atomic.h
>>>> checking file arch/arm/include/asm/bitops.h
>>>> checking file arch/arm/include/asm/cmpxchg.h
>>>> checking file arch/arm/include/asm/efi.h
>>>> checking file arch/arm/include/asm/entry-macro-multi.S
>>>> checking file arch/arm/include/asm/hw_irq.h
>>>> checking file arch/arm/include/asm/ipipe.h
>>>> checking file arch/arm/include/asm/ipipe_base.h
>>>> checking file arch/arm/include/asm/ipipe_hwirq.h
>>>> checking file arch/arm/include/asm/irq.h
>>>> checking file arch/arm/include/asm/irqflags.h
>>>> checking file arch/arm/include/asm/mmu_context.h
>>>> checking file arch/arm/include/asm/percpu.h
>>>> checking file arch/arm/include/asm/setup.h
>>>> checking file arch/arm/include/asm/switch_to.h
>>>> checking file arch/arm/include/asm/thread_info.h
>>>> checking file arch/arm/include/asm/uaccess.h
>>>> checking file arch/arm/include/uapi/asm/unistd.h
>>>> checking file arch/arm/kernel/Makefile
>>>> checking file arch/arm/kernel/asm-offsets.c
>>>> checking file arch/arm/kernel/devtree.c
>>>> checking file arch/arm/kernel/entry-armv.S
>>>> checking file arch/arm/kernel/entry-common.S
>>>> checking file arch/arm/kernel/entry-header.S
>>>> checking file arch/arm/kernel/ipipe.c
>>>> checking file arch/arm/kernel/ipipe_tsc.c
>>>> checking file arch/arm/kernel/ipipe_tsc_asm.S
>>>> checking file arch/arm/kernel/perf_callchain.c
>>>> checking file arch/arm/kernel/process.c
>>>> checking file arch/arm/kernel/ptrace.c
>>>> checking file arch/arm/kernel/raw_printk.c
>>>> checking file arch/arm/kernel/setup.c
>>>> checking file arch/arm/kernel/signal.c
>>>> checking file arch/arm/kernel/smp.c
>>>> checking file arch/arm/kernel/smp_twd.c
>>>> checking file arch/arm/kernel/traps.c
>>>> checking file arch/arm/kernel/vdso.c
>>>> checking file arch/arm/mach-at91/Kconfig
>>>> checking file arch/arm/mach-davinci/Kconfig
>>>> checking file arch/arm/mach-davinci/time.c
>>>> checking file arch/arm/mach-imx/Kconfig
>>>> checking file arch/arm/mach-imx/avic.c
>>>> checking file arch/arm/mach-imx/gpc.c
>>>> checking file arch/arm/mach-imx/mach-imx51.c
>>>> checking file arch/arm/mach-imx/mach-imx53.c
>>>> checking file arch/arm/mach-imx/tzic.c
>>>> checking file arch/arm/mach-omap2/Kconfig
>>>> checking file arch/arm/mach-omap2/omap-wakeupgen.c
>>>> checking file arch/arm/mach-omap2/prm_common.c
>>>> checking file arch/arm/mach-omap2/timer.c
>>>> checking file arch/arm/mach-socfpga/Kconfig
>>>> checking file arch/arm/mach-sti/Kconfig
>>>> checking file arch/arm/mach-sunxi/Kconfig
>>>> checking file arch/arm/mach-zynq/Kconfig
>>>> checking file arch/arm/mm/Kconfig
>>>> checking file arch/arm/mm/alignment.c
>>>> checking file arch/arm/mm/cache-l2x0.c
>>>> checking file arch/arm/mm/context.c
>>>> checking file arch/arm/mm/fault.c
>>>> checking file arch/arm/plat-omap/Kconfig
>>>> checking file arch/arm/vfp/entry.S
>>>> checking file arch/arm/vfp/vfphwS
>>>> checking file arch/arm/vfp/vfpmodule.c
>>>> checking file drivers/base/core.c
>>>> checking file drivers/base/regmap/regmap-irqc
>>>> checking file drivers/clocksource/Kconfig
>>>> checking file drivers/clocksource/arm_arch_timer.c
>>>> checking file drivers/clocksource/arm_global_timer.c
>>>> checking file drivers/clocksource/bcm2835_timer.c
>>>> checking file drivers/clocksource/dw_apb_timer.c
>>>> checking file drivers/clocksource/dw_apb_timer_of.c
>>>> checking file drivers/clocksource/timer-atmel-tcb.c
>>>> checking file drivers/clocksource/timer-imx-gpt.c
>>>> checking file drivers/clocksource/timer-sp804.c
>>>> checking file drivers/clocksource/timer-ti-dm.c
>>>> checking file drivers/cpuidle/Kconfig
>>>> checking file drivers/cpuidle/cpuidle.c
>>>> checking file drivers/gpio/gpio-davinci.c
>>>> checking file drivers/gpio/gpio-mvebu.c
>>>> Hunk #8 succeeded at 1238 (offset -5 lines).
>>>> Hunk #9 succeeded at 1248 (offset -5 lines).
>>>> checking file drivers/gpio/gpio-mxc.c
>>>> checking file drivers/gpio/gpio-omap.c
>>>> checking file drivers/gpio/gpio-pl061.c
>>>> checking file drivers/gpio/gpio-zynq.c
>>>> checking file drivers/gpu/ipu-v3/ipu-common.c
>>>> checking file drivers/gpu/ipu-v3/ipu-prv.h
>>>> checking file drivers/irqchip/irq-atmel-aic.c
>>>> checking file drivers/irqchip/irq-atmel-aic5.c
>>>> checking file drivers/irqchip/irq-bcm2835.c
>>>> checking file drivers/irqchip/irq-bcm2836.c
>>>> checking file drivers/irqchip/irq-bcm7120-l2.c
>>>> checking file drivers/irqchip/irq-brcmstb-l2.c
>>>> checking file drivers/irqchip/irq-crossbar.c
>>>> checking file drivers/irqchip/irq-dw-apb-ictl.c
>>>> checking file drivers/irqchip/irq-gic-v2m.c
>>>> checking file drivers/irqchip/irq-gic-v3.c
>>>> checking file drivers/irqchip/irq-gic.c
>>>> checking file drivers/irqchip/irq-imx-gpcv2.c
>>>> checking file drivers/irqchip/irq-omap-intc.c
>>>> checking file drivers/irqchip/irq-stm32-exti.c
>>>> checking file drivers/irqchip/irq-sunxi-nmi.c
>>>> checking file drivers/irqchip/irq-versatile-fpga.c
>>>> checking file drivers/irqchip/irq-vic.c
>>>> checking file drivers/memory/omap-gpmc.c
>>>> checking file drivers/mfd/tps65217.c
>>>> checking file drivers/misc/Kconfig
>>>> checking file drivers/pci/controller/dwc/pcie-designware-host.c
>>>> checking file drivers/pci/controller/pcie-altera.c
>>>> checking file drivers/pinctrl/bcm/pinctrl-bcm2835.c
>>>> checking file drivers/pinctrl/pinctrl-at91.c
>>>> checking file drivers/pinctrl/pinctrl-rockchip.c
>>>> checking file drivers/pinctrl/pinctrl-single.c
>>>> checking file drivers/pinctrl/sunxi/pinctrl-sunxi.c
>>>> checking file drivers/pinctrl/sunxi/pinctrl-sunxi.h
>>>> checking file drivers/soc/dove/pmu.c
>>>> checking file drivers/tty/serial/8250/8250_core.c
>>>> checking file drivers/tty/serial/amba-pl011.c
>>>> checking file drivers/tty/serial/xilinx_uartps.c
>>>> checking file fs/exec.c
>>>> checking file include/asm-generic/atomic.h
>>>> checking file include/asm-generic/cmpxchg-localh
>>>> checking file include/asm-generic/ipipe.h
>>>> checking file include/asm-generic/percpu.h
>>>> checking file include/asm-generic/switch_to.h
>>>> checking file include/clocksource/timer-sp804.h
>>>> checking file include/clocksource/timer-ti-dm.h
>>>> checking file include/ipipe/setup.h
>>>> checking file include/ipipe/thread_infoh
>>>> checking file include/linux/clockchips.h
>>>> checking file include/linux/console.h
>>>> checking file include/linux/dw_apb_timer.h
>>>> checking file include/linux/ftrace.h
>>>> checking file include/linux/gpio/driver.h
>>>> checking file include/linux/hardirqh
>>>> checking file include/linux/interrupt.h
>>>> checking file include/linux/ipipe.h
>>>> checking file include/linux/ipipe_debug.h
>>>> checking file include/linux/ipipe_domain.h
>>>> checking file include/linux/ipipe_lock.h
>>>> checking file include/linux/ipipe_tickdev.h
>>>> checking file include/linux/ipipe_trace.h
>>>> checking file include/linux/irq.h
>>>> checking file include/linux/irqchip/arm-gic-common.h
>>>> checking file include/linux/irqdesc.h
>>>> checking file include/linux/irqflags.h
>>>> checking file include/linux/irqnr.h
>>>> checking file include/linux/kernel.h
>>>> checking file include/linux/kvm_host.h
>>>> checking file include/linux/preempth
>>>> checking file include/linux/printk.h
>>>> checking file include/linux/rwlock.h
>>>> checking file include/linux/rwlock_api_smp.h
>>>> checking file include/linux/sched.h
>>>> checking file include/linux/sched/coredump.h
>>>> checking file include/linux/spinlock.h
>>>> checking file include/linux/spinlock_api_smp.h
>>>> checking file include/linux/spinlock_up.h
>>>> checking file include/linux/stop_machine.h
>>>> checking file init/Kconfig
>>>> checking file init/main.c
>>>> checking file kernel/Makefile
>>>> checking file kernel/context_tracking.c
>>>> checking file kernel/debug/debug_core.c
>>>> checking file kernel/exit.c
>>>> checking file kernel/forkc
>>>> checking file kernel/ipipe/Kconfig
>>>> checking file kernel/ipipe/Kconfig.debug
>>>> checking file kernel/ipipe/Makefile
>>>> checking file kernel/ipipe/core.c
>>>> checking file kernel/ipipe/timer.c
>>>> checking file kernel/ipipe/tracer.c
>>>> checking file kernel/irq/chip.c
>>>> checking file kernel/irq/dummychip.c
>>>> checking file kernel/irq/generic-chip.c
>>>> checking file kernel/irq/internals.h
>>>> checking file kernel/irq/irqdesc.c
>>>> checking file kernel/irq/manage.c
>>>> checking file kernel/irq/msi.c
>>>> checking file kernel/locking/lockdep.c
>>>> checking file kernel/locking/lockdep_internals.h
>>>> checking file kernel/locking/spinlock.c
>>>> checking file kernel/module.c
>>>> checking file kernel/notifier.c
>>>> checking file kernel/panic.c
>>>> checking file kernel/power/hibernate.c
>>>> checking file kernel/printk/printk.c
>>>> checking file kernel/ptrace.c
>>>> checking file kernel/rcu/Kconfig.debug
>>>> checking file kernel/sched/core.c
>>>> checking file kernel/sched/idle.c
>>>> checking file kernel/sched/sched.h
>>>> checking file kernel/sched/wait.c
>>>> checking file kernel/signal.c
>>>> checking file kernel/stop_machine.c
>>>> checking file kernel/time/clockevents.c
>>>> checking file kernel/time/timer.c
>>>> checking file kernel/trace/Kconfig
>>>> checking file kernel/trace/ftrace.c
>>>> checking file kernel/trace/ring_buffer.c
>>>> checking file kernel/trace/trace.c
>>>> checking file kernel/trace/trace_clock.c
>>>> checking file kernel/trace/trace_functions.c
>>>> checking file kernel/trace/trace_functions_graph.c
>>>> checking file kernel/trace/trace_preemptirq.c
>>>> checking file lib/Kconfig.debug
>>>> checking file lib/atomic64.c
>>>> checking file lib/bust_spinlocksc
>>>> checking file lib/dump_stack.c
>>>> checking file lib/ioremap.c
>>>> checking file lib/smp_processor_id.c
>>>> checking file mm/memory.c
>>>> checking file mm/mlock.c
>>>> checking file mm/mmu_context.c
>>>> checking file mm/mprotect.c
>>>> checking file mm/vmalloc.c
>>>> I-pipe core/arm #0 installed.
>>>> Links installed.
>>>> Build system ready
>>>=20
>>> Are you using a 32-bit arm compiler or the aarch64 compiler?
>>>=20
>>> -Greg
>>=20
>> I'm using a 32-bit compiler
>=20
> Can you send me your build commands?
>=20
> thanks
>=20
> Greg

I'm using buildroot for building the image using the patched kernel. I=20
use the default configuration "make raspberrypi3_defconfig" and setup=20
the kernel using custom git repository (patched kernel). I tried all=20
latest toolchains available in Buildroot, but I get the same errors=20
when building.

Thank you,
Gabriel Dinse

