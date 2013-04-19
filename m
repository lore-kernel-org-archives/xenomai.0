MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 19 Apr 2013 12:23:20 +0000
From: chrono <chrono@open-resource.org>
Message-ID: <bbc6252ba3dfdbef5f91d311e740e966@apollo.open-resource.org>
Subject: Re: [Xenomai] Xenomai, Raspberry Pi, 3.5.7 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, paul_c@tuxcnc.org

Hi everyone, Paul

> > > On 02/14/2013 01:27 PM, Paul wrote:
> > > Attached, a patch set aimed at providing support for the Broadcom
> > > BCM2835 SoC as used in the Raspberry Pi[1].
> > >
> > > In the meantime, we can put it in a raspberry subdirectory in
> > > Xenomai sources. Would you mind making a single patch? Or do you
> > > prefer the patches to be kept separated?

> > A single patch would be preferable for most people - The 
> multi-patch
> > set was mainly for the benefit of the guys who had a working kernel
> > but were sturggling with the GPIO problem (patch No.4 should apply 
> on
> > a 3.2.2x kernel).
> >
> > I'll rename the defconfig and add some recent changes made to
> > the "official" Raspberry kernel. Expect a single patch in a day or
> > two.

> Attached, a single patch against ipipe-core-3.5.7. This assumes the
> appropriate arm patch has already been applied to a virgin stable 
> 3.5.7
> tree as per standard instructions.

> The raspberry-post.patch provides support for the BCM2835 SoC 
> backported
> from the rpi-3.6.y branch[1] up to, and including commit 871eef1b84. 
> A
> minimal config is provided (bcmrpi_xenomai_defconfig) in place of the
> usual bcmrpi_*_defconfigs.

> Credit for the original 3.2.21 Xenomai support should go to ian-cim 
> as
> noted in earlier emails - My efforts are limited to backporting and
> hacks to the gpio interrupts.

I was looking for a more recent xenomai + pi setup than 3.2.27 and 
found
your post on the ML which encouraged me to try to compile a more recent
PI Kernel with Xenomai in order to play with LinuxCNC on the PI.

I've setup a cross-compile env which seems to be working fine, but I've 
never
build a xenomai kernel before, so I'm not quite sure what I'm doing 
wrong, this
is a short trace of what I've tried to do, maybe someone else can offer
some advice what I seem to be missing:

Test 1:

1. Fetched the RPI Kernel sources:

git clone git://github.com/raspberrypi/linux.git linux-rpi

2. Tried to get back to the commit you suggested (871eef1b84)

cd linux-rpi
git reset --hard 871eef1b84

3. Download xenomai-2.6.1 and unpack

4. Downloaded Paul's combined patch 
(http://www.xenomai.org/pipermail/xenomai/attachments/20130216/4f487e30/attachment.patch)

xenomai-2.6.1/scripts/prepare-kernel.sh  --arch=arm 
--adeos=/usr/src/xenomai-2.6.1/ksrc/arch/arm/patches/ipipe-core-3.5.7-arm.patch 
--linux=/usr/src/linux-rpi

Almost all hunks failed to apply and it ends with:

prepare-kernel.sh: Unable to patch kernel 3.6.11 with 
ipipe-core-3.5.7-arm.patch.


Test 2:

1. Reset kernel to suggested commit

git reset --hard 871eef1b84

2. Download xenomai-2.6.2.1 and unpack

3. Trying to patch with the bundled ipipe arm patch

xenomai-2.6.2.1/scripts/prepare-kernel.sh  --arch=arm 
--adeos=/usr/src/xenomai-2.6.2.1/ksrc/arch/arm/patches/ipipe-core-3.5.7-arm-3.patch 
--linux=/usr/src/linux-rpi

patching file arch/arm/Kconfig
Hunk #1 succeeded at 421 (offset 23 lines).
Hunk #2 succeeded at 555 (offset 25 lines).
Hunk #3 succeeded at 992 (offset 42 lines).
Hunk #4 succeeded at 1180 (offset 60 lines).
Hunk #5 succeeded at 1668 (offset 71 lines).
patching file arch/arm/boot/compressed/decompress.c
patching file arch/arm/boot/compressed/head.S
patching file arch/arm/boot/compressed/string.c
patching file arch/arm/common/gic.c
patching file arch/arm/common/it8152.c
patching file arch/arm/common/timer-sp.c
patching file arch/arm/common/vic.c
patching file arch/arm/include/asm/Kbuild
patching file arch/arm/include/asm/assembler.h
patching file arch/arm/include/asm/atomic.h
patching file arch/arm/include/asm/bitops.h
patching file arch/arm/include/asm/bug.h
patching file arch/arm/include/asm/cacheflush.h
patching file arch/arm/include/asm/cmpxchg.h
patching file arch/arm/include/asm/entry-macro-multi.S
patching file arch/arm/include/asm/fcse.h
patching file arch/arm/include/asm/hardware/timer-sp.h
patching file arch/arm/include/asm/ipipe.h
patching file arch/arm/include/asm/ipipe_base.h
patching file arch/arm/include/asm/ipipe_hwirq.h
patching file arch/arm/include/asm/irq.h
patching file arch/arm/include/asm/irqflags.h
patching file arch/arm/include/asm/memory.h
patching file arch/arm/include/asm/mman.h
patching file arch/arm/include/asm/mmu.h
patching file arch/arm/include/asm/mmu_context.h
patching file arch/arm/include/asm/percpu.h
patching file arch/arm/include/asm/pgtable.h
patching file arch/arm/include/asm/proc-fns.h
patching file arch/arm/include/asm/processor.h
patching file arch/arm/include/asm/resource.h
patching file arch/arm/include/asm/switch_to.h
patching file arch/arm/include/asm/thread_info.h
patching file arch/arm/include/asm/tlbflush.h
patching file arch/arm/kernel/Makefile
patching file arch/arm/kernel/entry-armv.S
patching file arch/arm/kernel/entry-common.S
Hunk #3 FAILED at 70.
Hunk #4 FAILED at 77.
Hunk #5 succeeded at 84 (offset -8 lines).
Hunk #6 succeeded at 92 with fuzz 1 (offset -8 lines).
Hunk #7 succeeded at 346 (offset -14 lines).
Hunk #8 succeeded at 401 (offset -14 lines).
Hunk #9 FAILED at 435.
Hunk #10 succeeded at 429 (offset -13 lines).
Hunk #11 succeeded at 446 (offset -13 lines).
Hunk #12 succeeded at 481 (offset -14 lines).
Hunk #13 succeeded at 639 (offset -14 lines).
3 out of 13 hunks FAILED -- saving rejects to file 
arch/arm/kernel/entry-common.S.rej
patching file arch/arm/kernel/entry-header.S
patching file arch/arm/kernel/ipipe.c
patching file arch/arm/kernel/ipipe_tsc.c
patching file arch/arm/kernel/ipipe_tsc_asm.S
patching file arch/arm/kernel/irq.c
Hunk #1 FAILED at 85.
1 out of 1 hunk FAILED -- saving rejects to file 
arch/arm/kernel/irq.c.rej
patching file arch/arm/kernel/process.c
patching file arch/arm/kernel/ptrace.c
Hunk #1 succeeded at 211 (offset 1 line).
patching file arch/arm/kernel/setup.c
patching file arch/arm/kernel/smp.c
Hunk #2 FAILED at 238.
Hunk #3 succeeded at 411 (offset 6 lines).
Hunk #4 succeeded at 608 (offset 6 lines).
Hunk #5 succeeded at 618 (offset 6 lines).
1 out of 5 hunks FAILED -- saving rejects to file 
arch/arm/kernel/smp.c.rej
patching file arch/arm/kernel/smp_twd.c
Hunk #1 succeeded at 21 (offset -1 lines).
Hunk #2 succeeded at 38 (offset -1 lines).
Hunk #3 succeeded at 114 (offset -1 lines).
Hunk #4 succeeded at 300 (offset 44 lines).
Hunk #5 succeeded at 313 (offset 44 lines).
Hunk #6 succeeded at 349 (offset 44 lines).
Hunk #7 succeeded at 357 (offset 44 lines).
Hunk #8 succeeded at 369 (offset 44 lines).
Hunk #9 succeeded at 414 (offset 44 lines).
Hunk #10 succeeded at 441 (offset 44 lines).
Hunk #11 succeeded at 479 (offset 44 lines).
patching file arch/arm/kernel/suspend.c
patching file arch/arm/kernel/traps.c
Hunk #2 succeeded at 468 (offset 32 lines).
Hunk #3 succeeded at 483 (offset 32 lines).
Hunk #4 succeeded at 836 (offset 32 lines).
Hunk #5 succeeded at 853 (offset 32 lines).
patching file arch/arm/mach-at91/Kconfig
Hunk #1 succeeded at 457 (offset 6 lines).
Hunk #2 succeeded at 507 (offset 6 lines).
patching file arch/arm/mach-at91/Makefile
patching file arch/arm/mach-at91/at91_ipipe.c
patching file arch/arm/mach-at91/at91_ipipe.h
patching file arch/arm/mach-at91/at91rm9200.c
Hunk #1 succeeded at 150 (offset 1 line).
Hunk #2 succeeded at 306 (offset 1 line).
Hunk #3 succeeded at 340 (offset 1 line).
Hunk #4 succeeded at 373 (offset 1 line).
patching file arch/arm/mach-at91/at91rm9200_time.c
patching file arch/arm/mach-at91/at91sam9260.c
Hunk #1 succeeded at 29 (offset 1 line).
Hunk #2 succeeded at 323 (offset 1 line).
Hunk #3 succeeded at 368 (offset 1 line).
Hunk #4 succeeded at 401 (offset 1 line).
patching file arch/arm/mach-at91/at91sam9261.c
Hunk #1 succeeded at 28 (offset 1 line).
Hunk #2 succeeded at 278 (offset 1 line).
Hunk #3 succeeded at 312 (offset 1 line).
Hunk #4 succeeded at 345 (offset 1 line).
patching file arch/arm/mach-at91/at91sam9263.c
Hunk #1 succeeded at 27 (offset 1 line).
Hunk #2 succeeded at 308 (offset 1 line).
Hunk #3 succeeded at 343 (offset 1 line).
Hunk #4 succeeded at 376 (offset 1 line).
patching file arch/arm/mach-at91/at91sam926x_time.c
patching file arch/arm/mach-at91/at91sam9g45.c
Hunk #1 succeeded at 27 (offset 1 line).
Hunk #2 succeeded at 351 (offset 12 lines).
Hunk #3 succeeded at 385 (offset 12 lines).
Hunk #4 succeeded at 420 (offset 12 lines).
patching file arch/arm/mach-at91/at91sam9rl.c
Hunk #1 succeeded at 28 (offset 1 line).
Hunk #2 succeeded at 283 (offset 1 line).
Hunk #3 succeeded at 316 (offset 1 line).
Hunk #4 succeeded at 349 (offset 1 line).
patching file arch/arm/mach-at91/at91x40.c
Hunk #1 succeeded at 47 (offset 2 lines).
patching file arch/arm/mach-at91/at91x40_time.c
patching file arch/arm/mach-at91/clock.c
Hunk #1 succeeded at 897 (offset 12 lines).
patching file arch/arm/mach-at91/gpio.c
Hunk #1 FAILED at 25.
Hunk #2 succeeded at 42 (offset 2 lines).
Hunk #3 succeeded at 585 (offset 2 lines).
Hunk #4 FAILED at 604.
Hunk #5 succeeded at 621 (offset 1 line).
Hunk #6 succeeded at 1098 (offset 1 line).
2 out of 6 hunks FAILED -- saving rejects to file 
arch/arm/mach-at91/gpio.c.rej
patching file arch/arm/mach-at91/include/mach/hardware.h
patching file arch/arm/mach-at91/irq.c
Hunk #1 succeeded at 296 with fuzz 2 (offset 166 lines).
patching file arch/arm/mach-bcmring/core.c
patching file arch/arm/mach-highbank/highbank.c
Hunk #1 succeeded at 113 (offset 5 lines).
Hunk #2 FAILED at 122.
1 out of 2 hunks FAILED -- saving rejects to file 
arch/arm/mach-highbank/highbank.c.rej
patching file arch/arm/mach-imx/clk-imx1.c
patching file arch/arm/mach-imx/clk-imx21.c
patching file arch/arm/mach-imx/clk-imx25.c
Hunk #1 FAILED at 241.
1 out of 1 hunk FAILED -- saving rejects to file 
arch/arm/mach-imx/clk-imx25.c.rej
patching file arch/arm/mach-imx/clk-imx27.c
Hunk #1 succeeded at 265 (offset 2 lines).
patching file arch/arm/mach-imx/clk-imx31.c
Hunk #1 succeeded at 176 (offset 1 line).
patching file arch/arm/mach-imx/clk-imx35.c
patching file arch/arm/mach-imx/clk-imx51-imx53.c
Hunk #1 succeeded at 376 (offset 9 lines).
Hunk #2 succeeded at 462 (offset 9 lines).
patching file arch/arm/mach-imx/clk-imx6q.c
Hunk #1 succeeded at 447 (offset 15 lines).
patching file arch/arm/mach-imx/mach-imx6q.c
Hunk #1 succeeded at 211 (offset 45 lines).
patching file arch/arm/mach-imx/mach-mx31_3ds.c
patching file arch/arm/mach-imx/mach-mx31ads.c
Hunk #1 FAILED at 21.
Hunk #2 FAILED at 162.
2 out of 2 hunks FAILED -- saving rejects to file 
arch/arm/mach-imx/mach-mx31ads.c.rej
patching file arch/arm/mach-imx/mm-imx1.c
patching file arch/arm/mach-imx/mm-imx3.c
Hunk #1 succeeded at 142 (offset -1 lines).
Hunk #2 succeeded at 221 (offset -1 lines).
patching file arch/arm/mach-imx/mm-imx5.c
Hunk #1 FAILED at 105.
1 out of 1 hunk FAILED -- saving rejects to file 
arch/arm/mach-imx/mm-imx5.c.rej
patching file arch/arm/mach-integrator/core.c
patching file arch/arm/mach-integrator/include/mach/platform.h
patching file arch/arm/mach-integrator/include/mach/timex.h
patching file arch/arm/mach-integrator/integrator_cp.c
Hunk #2 succeeded at 379 (offset -59 lines).
patching file arch/arm/mach-ixp4xx/common.c
patching file arch/arm/mach-ixp4xx/include/mach/platform.h
patching file arch/arm/mach-mxs/Kconfig
Hunk #1 succeeded at 16 with fuzz 1 (offset -2 lines).
patching file arch/arm/mach-mxs/icoll.c
patching file arch/arm/mach-mxs/mach-m28evk.c
patching file arch/arm/mach-mxs/timer.c
patching file arch/arm/mach-omap1/leds-innovator.c
patching file arch/arm/mach-omap2/clock3xxx_data.c
Hunk #1 FAILED at 3391.
1 out of 1 hunk FAILED -- saving rejects to file 
arch/arm/mach-omap2/clock3xxx_data.c.rej
patching file arch/arm/mach-omap2/gpmc.c
Hunk #2 succeeded at 786 (offset 1 line).
patching file arch/arm/mach-omap2/io.c
Hunk #2 succeeded at 435 (offset 36 lines).
Hunk #3 succeeded at 472 (offset 36 lines).
patching file arch/arm/mach-omap2/irq.c
Hunk #2 succeeded at 43 (offset 1 line).
Hunk #3 succeeded at 52 (offset 1 line).
Hunk #4 succeeded at 88 (offset 1 line).
Hunk #5 succeeded at 127 (offset 1 line).
Hunk #6 succeeded at 165 (offset 1 line).
Hunk #7 succeeded at 267 (offset 1 line).
Hunk #8 FAILED at 299.
1 out of 8 hunks FAILED -- saving rejects to file 
arch/arm/mach-omap2/irq.c.rej
patching file arch/arm/mach-omap2/mux.c
patching file arch/arm/mach-omap2/omap-wakeupgen.c
Hunk #1 succeeded at 432 (offset 64 lines).
Hunk #2 succeeded at 440 (offset 64 lines).
patching file arch/arm/mach-omap2/pm34xx.c
Hunk #1 succeeded at 346 (offset -47 lines).
patching file arch/arm/mach-omap2/pm44xx.c
patching file arch/arm/mach-omap2/prm_common.c
Hunk #1 FAILED at 122.
1 out of 1 hunk FAILED -- saving rejects to file 
arch/arm/mach-omap2/prm_common.c.rej
patching file arch/arm/mach-omap2/timer.c
Hunk #2 succeeded at 77 (offset -5 lines).
Hunk #3 succeeded at 107 (offset -5 lines).
Hunk #4 succeeded at 117 (offset -5 lines).
Hunk #5 succeeded at 125 (offset -5 lines).
Hunk #6 succeeded at 149 (offset -4 lines).
Hunk #7 succeeded at 207 (offset -4 lines).
Hunk #8 succeeded at 217 (offset -4 lines).
Hunk #9 FAILED at 314.
Hunk #10 succeeded at 392 (offset -3 lines).
Hunk #11 succeeded at 445 (offset -3 lines).
Hunk #12 succeeded at 461 (offset -3 lines).
Hunk #13 succeeded at 508 (offset 2 lines).
1 out of 13 hunks FAILED -- saving rejects to file 
arch/arm/mach-omap2/timer.c.rej
patching file arch/arm/mach-pxa/irq.c
patching file arch/arm/mach-pxa/leds-idp.c
patching file arch/arm/mach-pxa/leds-lubbock.c
patching file arch/arm/mach-pxa/leds-mainstone.c
patching file arch/arm/mach-pxa/lpd270.c
patching file arch/arm/mach-pxa/lubbock.c
patching file arch/arm/mach-pxa/mainstone.c
patching file arch/arm/mach-pxa/pcm990-baseboard.c
patching file arch/arm/mach-pxa/time.c
Hunk #2 FAILED at 43.
Hunk #3 FAILED at 61.
Hunk #6 FAILED at 148.
3 out of 6 hunks FAILED -- saving rejects to file 
arch/arm/mach-pxa/time.c.rej
patching file arch/arm/mach-pxa/viper.c
patching file arch/arm/mach-realview/core.c
patching file arch/arm/mach-realview/core.h
patching file arch/arm/mach-realview/realview_eb.c
patching file arch/arm/mach-realview/realview_pb1176.c
patching file arch/arm/mach-realview/realview_pb11mp.c
patching file arch/arm/mach-realview/realview_pba8.c
patching file arch/arm/mach-realview/realview_pbx.c
patching file arch/arm/mach-s3c24xx/bast-irq.c
patching file arch/arm/mach-s3c24xx/irq-s3c2412.c
patching file arch/arm/mach-s3c24xx/irq-s3c2416.c
patching file arch/arm/mach-s3c24xx/irq-s3c2440.c
patching file arch/arm/mach-s3c24xx/irq-s3c2443.c
patching file arch/arm/mach-s3c24xx/irq-s3c244x.c
patching file arch/arm/mach-sa1100/irq.c
Hunk #1 succeeded at 16 (offset 1 line).
Hunk #2 succeeded at 128 (offset 1 line).
Hunk #3 succeeded at 220 (offset 1 line).
Hunk #4 succeeded at 258 (offset 1 line).
patching file arch/arm/mach-sa1100/leds-assabet.c
patching file arch/arm/mach-sa1100/leds-badge4.c
patching file arch/arm/mach-sa1100/leds-cerf.c
Hunk #1 FAILED at 4.
1 out of 1 hunk FAILED -- saving rejects to file 
arch/arm/mach-sa1100/leds-cerf.c.rej
patching file arch/arm/mach-sa1100/leds-hackkit.c
Hunk #1 FAILED at 10.
1 out of 1 hunk FAILED -- saving rejects to file 
arch/arm/mach-sa1100/leds-hackkit.c.rej
patching file arch/arm/mach-sa1100/leds-lart.c
Hunk #1 FAILED at 10.
1 out of 1 hunk FAILED -- saving rejects to file 
arch/arm/mach-sa1100/leds-lart.c.rej
patching file arch/arm/mach-sa1100/time.c
Hunk #2 FAILED at 29.
Hunk #4 FAILED at 113.
2 out of 4 hunks FAILED -- saving rejects to file 
arch/arm/mach-sa1100/time.c.rej
patching file arch/arm/mach-versatile/core.c
patching file arch/arm/mach-vexpress/v2m.c
Hunk #1 succeeded at 80 (offset 3 lines).
patching file arch/arm/mm/Kconfig
patching file arch/arm/mm/Makefile
patching file arch/arm/mm/alignment.c
Hunk #3 succeeded at 915 (offset 2 lines).
Hunk #4 succeeded at 942 (offset 2 lines).
patching file arch/arm/mm/cache-l2x0.c
patching file arch/arm/mm/context.c
Hunk #1 FAILED at 12.
Hunk #2 succeeded at 130 (offset 36 lines).
Hunk #3 succeeded at 140 (offset 36 lines).
Hunk #4 succeeded at 157 (offset 36 lines).
Hunk #5 succeeded at 165 (offset 36 lines).
Hunk #6 succeeded at 202 (offset 36 lines).
1 out of 6 hunks FAILED -- saving rejects to file 
arch/arm/mm/context.c.rej
patching file arch/arm/mm/copypage-v4mc.c
patching file arch/arm/mm/copypage-xscale.c
patching file arch/arm/mm/fault-armv.c
patching file arch/arm/mm/fault.c
patching file arch/arm/mm/fcse.c
patching file arch/arm/mm/flush.c
patching file arch/arm/mm/idmap.c
patching file arch/arm/mm/ioremap.c
patching file arch/arm/mm/mmap.c
patching file arch/arm/mm/mmu.c
patching file arch/arm/mm/pgd.c
patching file arch/arm/mm/proc-arm920.S
patching file arch/arm/mm/proc-arm926.S
patching file arch/arm/mm/proc-feroceon.S
patching file arch/arm/mm/proc-xscale.S
patching file arch/arm/plat-mxc/3ds_debugboard.c
Hunk #1 succeeded at 20 (offset 2 lines).
Hunk #2 FAILED at 105.
1 out of 2 hunks FAILED -- saving rejects to file 
arch/arm/plat-mxc/3ds_debugboard.c.rej
patching file arch/arm/plat-mxc/Kconfig
patching file arch/arm/plat-mxc/avic.c
Hunk #1 succeeded at 152 (offset 9 lines).
Hunk #2 FAILED at 164.
1 out of 2 hunks FAILED -- saving rejects to file 
arch/arm/plat-mxc/avic.c.rej
patching file arch/arm/plat-mxc/cpu.c
patching file arch/arm/plat-mxc/devices.c
patching file arch/arm/plat-mxc/include/mach/common.h
Hunk #1 succeeded at 56 with fuzz 2 (offset 1 line).
Hunk #2 succeeded at 161 (offset 5 lines).
patching file arch/arm/plat-mxc/include/mach/irqs.h
Hunk #1 FAILED at 11.
Hunk #2 succeeded at 2 with fuzz 2 (offset -28 lines).
1 out of 2 hunks FAILED -- saving rejects to file 
arch/arm/plat-mxc/include/mach/irqs.h.rej
patching file arch/arm/plat-mxc/time.c
Hunk #2 succeeded at 228 (offset 1 line).
Hunk #3 succeeded at 238 (offset 1 line).
Hunk #4 succeeded at 285 (offset 1 line).
Hunk #5 succeeded at 311 (offset 1 line).
Hunk #6 succeeded at 350 (offset 1 line).
patching file arch/arm/plat-mxc/tzic.c
Hunk #1 FAILED at 15.
Hunk #2 succeeded at 118 (offset 2 lines).
Hunk #3 FAILED at 143.
Hunk #4 succeeded at 171 (offset 5 lines).
2 out of 4 hunks FAILED -- saving rejects to file 
arch/arm/plat-mxc/tzic.c.rej
patching file arch/arm/plat-omap/dmtimer.c
Hunk #1 FAILED at 40.
Hunk #2 succeeded at 235 (offset 22 lines).
Hunk #3 succeeded at 269 (offset 22 lines).
Hunk #4 succeeded at 496 (offset 63 lines).
1 out of 4 hunks FAILED -- saving rejects to file 
arch/arm/plat-omap/dmtimer.c.rej
patching file arch/arm/plat-omap/include/plat/dmtimer.h
Hunk #1 succeeded at 331 (offset -12 lines).
Hunk #2 succeeded at 415 (offset -12 lines).
patching file arch/arm/plat-s3c24xx/irq.c
patching file arch/arm/plat-samsung/include/plat/gpio-core.h
patching file arch/arm/plat-samsung/time.c
patching file arch/arm/plat-spear/shirq.c
patching file arch/arm/plat-spear/time.c
patching file arch/arm/plat-versatile/fpga-irq.c
patching file arch/arm/vfp/entry.S
patching file arch/arm/vfp/vfphw.S
Hunk #1 succeeded at 20 (offset 1 line).
Hunk #2 succeeded at 32 (offset 1 line).
Hunk #3 succeeded at 45 (offset 1 line).
Hunk #4 succeeded at 92 (offset 1 line).
Hunk #5 succeeded at 134 (offset 1 line).
Hunk #6 succeeded at 177 (offset 1 line).
Hunk #7 succeeded at 206 (offset 1 line).
Hunk #8 succeeded at 252 (offset 1 line).
patching file arch/arm/vfp/vfpmodule.c
patching file drivers/gpio/gpio-mxc.c
Hunk #1 succeeded at 31 with fuzz 2 (offset 1 line).
Hunk #2 succeeded at 67 with fuzz 1 (offset 1 line).
Hunk #3 FAILED at 230.
Hunk #4 succeeded at 295 (offset 39 lines).
Hunk #5 succeeded at 310 (offset 39 lines).
Hunk #6 succeeded at 528 (offset 50 lines).
1 out of 6 hunks FAILED -- saving rejects to file 
drivers/gpio/gpio-mxc.c.rej
patching file drivers/gpio/gpio-omap.c
Hunk #14 succeeded at 1071 (offset -2 lines).
Hunk #15 succeeded at 1179 (offset -2 lines).
patching file drivers/gpio/gpio-pxa.c
Hunk #2 succeeded at 93 (offset 1 line).
Hunk #3 succeeded at 418 (offset 24 lines).
patching file drivers/gpio/gpio-sa1100.c
patching file drivers/mfd/twl6030-irq.c
patching file drivers/misc/Kconfig
Hunk #1 succeeded at 80 (offset 1 line).
Hunk #2 succeeded at 356 (offset 1 line).
patching file drivers/cpuidle/Kconfig
patching file drivers/tty/serial/8250/8250.c
Hunk #1 succeeded at 3063 (offset 8 lines).
patching file fs/exec.c
patching file fs/proc/array.c
patching file include/asm-generic/atomic.h
patching file include/asm-generic/bitops/atomic.h
patching file include/asm-generic/cmpxchg-local.h
patching file include/asm-generic/mman-common.h
patching file include/asm-generic/percpu.h
patching file include/asm-generic/resource.h
patching file include/ipipe/setup.h
patching file include/ipipe/thread_info.h
patching file include/linux/clockchips.h
patching file include/linux/clocksource.h
patching file include/linux/hardirq.h
patching file include/linux/i8253.h
patching file include/linux/ipipe.h
patching file include/linux/ipipe_base.h
patching file include/linux/ipipe_compat.h
patching file include/linux/ipipe_debug.h
patching file include/linux/ipipe_domain.h
patching file include/linux/ipipe_lock.h
patching file include/linux/ipipe_tickdev.h
patching file include/linux/ipipe_trace.h
patching file include/linux/irq.h
Hunk #1 succeeded at 320 (offset -2 lines).
Hunk #2 succeeded at 527 (offset -1 lines).
Hunk #3 succeeded at 670 (offset -1 lines).
Hunk #4 succeeded at 732 (offset -1 lines).
patching file include/linux/irqdesc.h
patching file include/linux/irqnr.h
patching file include/linux/kernel.h
Hunk #2 succeeded at 150 (offset 8 lines).
patching file include/linux/kvm_host.h
patching file include/linux/preempt.h
patching file include/linux/resource.h
patching file include/linux/rwlock.h
patching file include/linux/rwlock_api_smp.h
patching file include/linux/sched.h
Hunk #4 succeeded at 463 (offset 5 lines).
Hunk #5 succeeded at 1545 (offset 5 lines).
Hunk #6 succeeded at 1829 (offset 3 lines).
patching file include/linux/spinlock.h
patching file include/linux/spinlock_api_smp.h
patching file include/linux/spinlock_up.h
patching file include/linux/time.h
patching file init/Kconfig
patching file init/main.c
Hunk #1 succeeded at 483 (offset 1 line).
Hunk #2 succeeded at 521 (offset 1 line).
Hunk #3 succeeded at 554 (offset 1 line).
Hunk #4 succeeded at 784 (offset 5 lines).
patching file kernel/Makefile
patching file kernel/exit.c
Hunk #1 succeeded at 988 (offset -3 lines).
patching file kernel/fork.c
Hunk #1 FAILED at 315.
Hunk #2 succeeded at 610 (offset -4 lines).
Hunk #3 succeeded at 1101 (offset -4 lines).
Hunk #4 succeeded at 1490 (offset -4 lines).
1 out of 4 hunks FAILED -- saving rejects to file kernel/fork.c.rej
patching file kernel/ipipe/Kconfig
patching file kernel/ipipe/Kconfig.debug
patching file kernel/ipipe/Makefile
patching file kernel/ipipe/compat.c
patching file kernel/ipipe/core.c
patching file kernel/ipipe/timer.c
patching file kernel/ipipe/tracer.c
patching file kernel/irq/chip.c
patching file kernel/irq/generic-chip.c
patching file kernel/irq/irqdesc.c
patching file kernel/lockdep.c
patching file kernel/panic.c
Hunk #2 succeeded at 361 (offset 8 lines).
patching file kernel/power/hibernate.c
Hunk #1 succeeded at 274 (offset 4 lines).
Hunk #2 succeeded at 428 (offset 4 lines).
Hunk #3 succeeded at 544 (offset 4 lines).
patching file kernel/printk.c
Hunk #1 succeeded at 1643 (offset 63 lines).
Hunk #2 succeeded at 1703 (offset 63 lines).
Hunk #3 succeeded at 1773 with fuzz 1 (offset 63 lines).
Hunk #4 succeeded at 2482 (offset 86 lines).
patching file kernel/sched/core.c
Hunk #15 succeeded at 4410 (offset -2 lines).
Hunk #16 succeeded at 5158 (offset -2 lines).
Hunk #17 succeeded at 8574 (offset -14 lines).
patching file kernel/signal.c
patching file kernel/spinlock.c
patching file kernel/time/clockevents.c
patching file kernel/time/clocksource.c
patching file kernel/time/tick-common.c
patching file kernel/time/tick-sched.c
Hunk #1 succeeded at 680 (offset 23 lines).
Hunk #2 succeeded at 838 with fuzz 2 (offset 24 lines).
patching file kernel/time/timekeeping.c
Hunk #1 succeeded at 1440 (offset 78 lines).
patching file kernel/timer.c
Hunk #1 succeeded at 1374 (offset 15 lines).
patching file kernel/trace/Kconfig
patching file kernel/trace/ftrace.c
patching file lib/Kconfig.debug
patching file lib/bust_spinlocks.c
patching file lib/ioremap.c
patching file lib/smp_processor_id.c
patching file mm/Kconfig
Hunk #1 succeeded at 319 (offset 5 lines).
patching file mm/memory.c
Hunk #1 succeeded at 826 (offset 4 lines).
Hunk #2 succeeded at 860 (offset 4 lines).
Hunk #3 succeeded at 913 (offset 4 lines).
Hunk #4 succeeded at 965 (offset 4 lines).
Hunk #5 succeeded at 1008 (offset 4 lines).
Hunk #6 succeeded at 2539 (offset 12 lines).
Hunk #7 succeeded at 4084 (offset 12 lines).
patching file mm/mlock.c
patching file mm/mmap.c
Hunk #1 succeeded at 2173 (offset -1 lines).
patching file mm/mmu_context.c
patching file mm/mprotect.c
patching file mm/vmalloc.c
prepare-kernel.sh: Unable to patch kernel 3.6.11 with 
ipipe-core-3.5.7-arm-3.patch.

Paul, you mentioned: "This assumes the appropriate arm patch has 
already
been applied to a virgin stable 3.5.7 tree as per standard 
instructions."

What am I missing here?

Thanks a lot for all your time and efforts to put Xenomai/LinuxCNC to 
the PI :)

chrono







