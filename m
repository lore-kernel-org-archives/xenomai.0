From: Flavio Alves <flavio.alves@domain.hid>
In-Reply-To: <4C4E8A64.1000701@domain.hid>
References: <1279046702.31665.65.camel@domain.hid> <4C3CB655.1020801@domain.hid>
	<1279048661.31665.81.camel@domain.hid> <1280149567.1856.15.camel@domain.hid>
	<4C4D9131.7080504@domain.hid> <1280153187.1856.25.camel@domain.hid>
	<4C4D97AC.2030609@domain.hid> <1280154697.1856.29.camel@domain.hid>
	<4C4D9E04.6060407@domain.hid> <1280156219.1856.32.camel@domain.hid>
	<4C4DA340.4030400@domain.hid> <1280187666.1963.34.camel@domain.hid>
	<4C4E8A64.1000701@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Jul 2010 11:12:52 -0300
Message-ID: <1280239972.1865.7.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Kernel compilation procedures for imx51
Reply-To: flavio.alves@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,

I am still having problems with the patch:

I performed the following procedures

1) git clone
http://opensource.freescale.com/pub/scm/imx/linux-2.6-imx.git
2) cd linux-2.6-imx
3) git checkout rel_imx_2.6.31_10.02.00
4) patch -p0 < ../adeos-ipipe-2.6.31-arm-1.16-01.patch

And I have the following errors:

patching file b/arch/arm/Kconfig
Hunk #1 FAILED at 235.
Hunk #2 FAILED at 962.
2 out of 2 hunks FAILED -- saving rejects to file b/arch/arm/Kconfig.rej
patching file b/arch/arm/boot/compressed/head.S
Hunk #1 FAILED at 1012.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/boot/compressed/head.S.rej
patching file b/arch/arm/common/it8152.c
Hunk #1 FAILED at 26.
Hunk #2 FAILED at 120.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/common/it8152.c.rej
patching file b/arch/arm/include/asm/assembler.h
Hunk #1 FAILED at 81.
Hunk #2 FAILED at 89.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/assembler.h.rej
patching file b/arch/arm/include/asm/atomic.h
Hunk #1 FAILED at 170.
Hunk #2 FAILED at 184.
Hunk #3 FAILED at 198.
Hunk #4 FAILED at 211.
4 out of 4 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/atomic.h.rej
patching file b/arch/arm/include/asm/bitops.h
Hunk #1 FAILED at 41.
Hunk #2 FAILED at 53.
Hunk #3 FAILED at 65.
Hunk #4 FAILED at 79.
Hunk #5 FAILED at 96.
Hunk #6 FAILED at 113.
6 out of 6 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/bitops.h.rej
patching file b/arch/arm/include/asm/cacheflush.h
Hunk #1 FAILED at 15.
Hunk #2 FAILED at 334.
Hunk #3 FAILED at 381.
Hunk #4 FAILED at 426.
4 out of 4 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/cacheflush.h.rej
patching file b/arch/arm/include/asm/cpu-multi32.h
Hunk #1 FAILED at 52.
Hunk #2 FAILED at 66.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/cpu-multi32.h.rej
patching file b/arch/arm/include/asm/cpu-single.h
Hunk #1 FAILED at 39.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/include/asm/cpu-single.h.rej
patching file b/arch/arm/include/asm/fcse.h
patching file b/arch/arm/include/asm/ipipe.h
patching file b/arch/arm/include/asm/ipipe_base.h
patching file b/arch/arm/include/asm/irqflags.h
Hunk #1 FAILED at 10.
Hunk #2 FAILED at 44.
Hunk #3 FAILED at 59.
Hunk #4 FAILED at 74.
Hunk #5 FAILED at 89.
Hunk #6 FAILED at 106.
Hunk #7 FAILED at 128.
7 out of 7 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/irqflags.h.rej
patching file b/arch/arm/include/asm/memory.h
Hunk #1 FAILED at 33.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/include/asm/memory.h.rej
patching file b/arch/arm/include/asm/mmu.h
Hunk #1 FAILED at 7.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/include/asm/mmu.h.rej
patching file b/arch/arm/include/asm/mmu_context.h
Hunk #1 FAILED at 19.
Hunk #2 FAILED at 66.
Hunk #3 FAILED at 93.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/mmu_context.h.rej
patching file b/arch/arm/include/asm/pgtable.h
Hunk #1 FAILED at 112.
Hunk #2 FAILED at 250.
Hunk #3 FAILED at 261.
Hunk #4 FAILED at 271.
Hunk #5 FAILED at 355.
5 out of 5 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/pgtable.h.rej
patching file b/arch/arm/include/asm/proc-fns.h
Hunk #1 FAILED at 239.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/include/asm/proc-fns.h.rej
patching file b/arch/arm/include/asm/processor.h
Hunk #1 FAILED at 23.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/include/asm/processor.h.rej
patching file b/arch/arm/include/asm/system.h
Hunk #1 FAILED at 213.
Hunk #2 FAILED at 277.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/system.h.rej
patching file b/arch/arm/include/asm/thread_info.h
Hunk #1 FAILED at 140.
Hunk #2 FAILED at 147.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/thread_info.h.rej
patching file b/arch/arm/include/asm/tlbflush.h
Hunk #1 FAILED at 210.
Hunk #2 FAILED at 350.
Hunk #3 FAILED at 383.
Hunk #4 FAILED at 504.
4 out of 4 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/tlbflush.h.rej
patching file b/arch/arm/kernel/Makefile
Hunk #1 FAILED at 48.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/kernel/Makefile.rej
patching file b/arch/arm/kernel/entry-armv.S
Hunk #1 FAILED at 4.
Hunk #2 FAILED at 28.
Hunk #3 FAILED at 44.
Hunk #4 FAILED at 211.
Hunk #5 FAILED at 240.
Hunk #6 FAILED at 258.
Hunk #7 FAILED at 442.
Hunk #8 FAILED at 565.
Hunk #9 FAILED at 607.
Hunk #10 FAILED at 643.
Hunk #11 FAILED at 694.
Hunk #12 FAILED at 735.
Hunk #13 FAILED at 773.
13 out of 13 hunks FAILED -- saving rejects to file
b/arch/arm/kernel/entry-armv.S.rej
patching file b/arch/arm/kernel/entry-common.S
Hunk #1 FAILED at 2.
Hunk #2 FAILED at 22.
Hunk #3 FAILED at 30.
Hunk #4 FAILED at 41.
Hunk #5 FAILED at 53.
Hunk #6 FAILED at 70.
Hunk #7 FAILED at 268.
Hunk #8 FAILED at 315.
Hunk #9 FAILED at 485.
9 out of 9 hunks FAILED -- saving rejects to file
b/arch/arm/kernel/entry-common.S.rej
patching file b/arch/arm/kernel/entry-header.S
Hunk #1 FAILED at 49.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/kernel/entry-header.S.rej
patching file b/arch/arm/kernel/fcse.c
patching file b/arch/arm/kernel/ipipe.c
patching file b/arch/arm/kernel/irq.c
Hunk #1 FAILED at 121.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/kernel/irq.c.rej
patching file b/arch/arm/kernel/process.c
Hunk #1 FAILED at 127.
Hunk #2 FAILED at 148.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/kernel/process.c.rej
patching file b/arch/arm/kernel/ptrace.c
Hunk #1 FAILED at 479.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/kernel/ptrace.c.rej
patching file b/arch/arm/kernel/smp.c
Hunk #1 FAILED at 36.
Hunk #2 FAILED at 643.
Hunk #3 FAILED at 654.
Hunk #4 FAILED at 677.
4 out of 4 hunks FAILED -- saving rejects to file
b/arch/arm/kernel/smp.c.rej
patching file b/arch/arm/kernel/traps.c
Hunk #1 FAILED at 325.
Hunk #2 FAILED at 719.
Hunk #3 FAILED at 734.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/kernel/traps.c.rej
patching file b/arch/arm/mach-at91/Kconfig
Hunk #1 FAILED at 311.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-at91/Kconfig.rej
patching file b/arch/arm/mach-at91/Makefile
Hunk #1 FAILED at 71.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-at91/Makefile.rej
patching file b/arch/arm/mach-at91/at91_ipipe_time.c
patching file b/arch/arm/mach-at91/at91rm9200.c
Hunk #1 FAILED at 33.
Hunk #2 FAILED at 300.
Hunk #3 FAILED at 332.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mach-at91/at91rm9200.c.rej
patching file b/arch/arm/mach-at91/at91sam9260.c
Hunk #1 FAILED at 31.
Hunk #2 FAILED at 350.
Hunk #3 FAILED at 382.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mach-at91/at91sam9260.c.rej
patching file b/arch/arm/mach-at91/at91sam9261.c
Hunk #1 FAILED at 30.
Hunk #2 FAILED at 286.
Hunk #3 FAILED at 318.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mach-at91/at91sam9261.c.rej
patching file b/arch/arm/mach-at91/at91sam9263.c
Hunk #1 FAILED at 30.
Hunk #2 FAILED at 311.
Hunk #3 FAILED at 343.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mach-at91/at91sam9263.c.rej
patching file b/arch/arm/mach-at91/at91sam9rl.c
Hunk #1 FAILED at 30.
Hunk #2 FAILED at 303.
Hunk #3 FAILED at 335.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mach-at91/at91sam9rl.c.rej
patching file b/arch/arm/mach-at91/gpio.c
Hunk #1 FAILED at 25.
Hunk #2 FAILED at 377.
Hunk #3 FAILED at 424.
Hunk #4 FAILED at 435.
Hunk #5 FAILED at 511.
Hunk #6 FAILED at 540.
6 out of 6 hunks FAILED -- saving rejects to file
b/arch/arm/mach-at91/gpio.c.rej
patching file b/arch/arm/mach-at91/include/mach/hardware.h
Hunk #1 FAILED at 61.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-at91/include/mach/hardware.h.rej
patching file b/arch/arm/mach-at91/include/mach/irqs.h
Hunk #1 FAILED at 45.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-at91/include/mach/irqs.h.rej
patching file b/arch/arm/mach-at91/include/mach/timex.h
Hunk #1 FAILED at 72.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-at91/include/mach/timex.h.rej
patching file b/arch/arm/mach-at91/irq.c
Hunk #1 FAILED at 121.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-at91/irq.c.rej
patching file b/arch/arm/mach-integrator/core.c
Hunk #1 FAILED at 2.
Hunk #2 FAILED at 230.
Hunk #3 FAILED at 285.
Hunk #4 FAILED at 301.
Hunk #5 FAILED at 326.
5 out of 5 hunks FAILED -- saving rejects to file
b/arch/arm/mach-integrator/core.c.rej
patching file b/arch/arm/mach-integrator/include/mach/entry-macro.S
Hunk #1 FAILED at 28.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-integrator/include/mach/entry-macro.S.rej
patching file b/arch/arm/mach-integrator/include/mach/irqs.h
Hunk #1 FAILED at 79.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-integrator/include/mach/irqs.h.rej
patching file b/arch/arm/mach-integrator/include/mach/platform.h
Hunk #1 FAILED at 417.
Hunk #2 FAILED at 430.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mach-integrator/include/mach/platform.h.rej
patching file b/arch/arm/mach-integrator/include/mach/timex.h
Hunk #1 FAILED at 21.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-integrator/include/mach/timex.h.rej
patching file b/arch/arm/mach-integrator/integrator_cp.c
Hunk #1 FAILED at 2.
Hunk #2 FAILED at 20.
Hunk #3 FAILED at 161.
Hunk #4 FAILED at 180.
Hunk #5 FAILED at 199.
Hunk #6 FAILED at 218.
Hunk #7 FAILED at 569.
7 out of 7 hunks FAILED -- saving rejects to file
b/arch/arm/mach-integrator/integrator_cp.c.rej
patching file b/arch/arm/mach-ixp4xx/common.c
Hunk #1 FAILED at 45.
Hunk #2 FAILED at 269.
Hunk #3 FAILED at 294.
Hunk #4 FAILED at 470.
Hunk #5 FAILED at 492.
5 out of 5 hunks FAILED -- saving rejects to file
b/arch/arm/mach-ixp4xx/common.c.rej
patching file b/arch/arm/mach-mx3/mx31ads.c
Hunk #1 FAILED at 134.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-mx3/mx31ads.c.rej
patching file b/arch/arm/mach-mx3/mx31pdk.c
Hunk #1 FAILED at 23.
Hunk #2 FAILED at 108.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mach-mx3/mx31pdk.c.rej
patching file b/arch/arm/mach-omap2/timer-gp.c
Hunk #1 FAILED at 47.
Hunk #2 FAILED at 125.
Hunk #3 FAILED at 156.
Hunk #4 FAILED at 166.
Hunk #5 FAILED at 185.
Hunk #6 FAILED at 223.
Hunk #7 FAILED at 242.
7 out of 7 hunks FAILED -- saving rejects to file
b/arch/arm/mach-omap2/timer-gp.c.rej
patching file b/arch/arm/mach-pxa/irq.c
Hunk #1 FAILED at 49.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-pxa/irq.c.rej
patching file b/arch/arm/mach-pxa/leds-idp.c
Hunk #1 FAILED at 13.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-pxa/leds-idp.c.rej
patching file b/arch/arm/mach-pxa/leds-lubbock.c
Hunk #1 FAILED at 12.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-pxa/leds-lubbock.c.rej
patching file b/arch/arm/mach-pxa/leds-mainstone.c
Hunk #1 FAILED at 11.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-pxa/leds-mainstone.c.rej
patching file b/arch/arm/mach-pxa/lpd270.c
Hunk #1 FAILED at 24.
Hunk #2 FAILED at 124.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mach-pxa/lpd270.c.rej
patching file b/arch/arm/mach-pxa/lubbock.c
Hunk #1 FAILED at 22.
Hunk #2 FAILED at 161.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mach-pxa/lubbock.c.rej
patching file b/arch/arm/mach-pxa/mainstone.c
Hunk #1 FAILED at 27.
Hunk #2 FAILED at 165.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mach-pxa/mainstone.c.rej
patching file b/arch/arm/mach-pxa/pcm990-baseboard.c
Hunk #1 FAILED at 24.
Hunk #2 FAILED at 263.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mach-pxa/pcm990-baseboard.c.rej
patching file b/arch/arm/mach-pxa/time.c
Hunk #1 FAILED at 24.
Hunk #2 FAILED at 66.
Hunk #3 FAILED at 79.
Hunk #4 FAILED at 125.
Hunk #5 FAILED at 168.
Hunk #6 FAILED at 213.
6 out of 6 hunks FAILED -- saving rejects to file
b/arch/arm/mach-pxa/time.c.rej
patching file b/arch/arm/mach-pxa/viper.c
Hunk #1 FAILED at 41.
Hunk #2 FAILED at 270.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mach-pxa/viper.c.rej
patching file b/arch/arm/mach-s3c2410/include/mach/irqs.h
Hunk #1 FAILED at 3.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-s3c2410/include/mach/irqs.h.rej
patching file b/arch/arm/mach-s3c2440/irq.c
Hunk #1 FAILED at 3.
Hunk #2 FAILED at 25.
Hunk #3 FAILED at 57.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mach-s3c2440/irq.c.rej
patching file b/arch/arm/mach-sa1100/irq.c
Hunk #1 FAILED at 15.
Hunk #2 FAILED at 125.
Hunk #3 FAILED at 217.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mach-sa1100/irq.c.rej
patching file b/arch/arm/mach-sa1100/leds-assabet.c
Hunk #1 FAILED at 10.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-sa1100/leds-assabet.c.rej
patching file b/arch/arm/mach-sa1100/leds-badge4.c
Hunk #1 FAILED at 11.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-sa1100/leds-badge4.c.rej
patching file b/arch/arm/mach-sa1100/leds-cerf.c
Hunk #1 FAILED at 4.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-sa1100/leds-cerf.c.rej
patching file b/arch/arm/mach-sa1100/leds-hackkit.c
Hunk #1 FAILED at 10.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-sa1100/leds-hackkit.c.rej
patching file b/arch/arm/mach-sa1100/leds-lart.c
Hunk #1 FAILED at 10.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-sa1100/leds-lart.c.rej
patching file b/arch/arm/mach-sa1100/leds-simpad.c
Hunk #1 FAILED at 4.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-sa1100/leds-simpad.c.rej
patching file b/arch/arm/mach-sa1100/time.c
Hunk #1 FAILED at 20.
Hunk #2 FAILED at 77.
Hunk #3 FAILED at 116.
Hunk #4 FAILED at 156.
4 out of 4 hunks FAILED -- saving rejects to file
b/arch/arm/mach-sa1100/time.c.rej
patching file b/arch/arm/mm/Kconfig
Hunk #1 FAILED at 771.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mm/Kconfig.rej
patching file b/arch/arm/mm/alignment.c
Hunk #1 FAILED at 713.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mm/alignment.c.rej
patching file b/arch/arm/mm/context.c
Hunk #1 FAILED at 14.
Hunk #2 FAILED at 31.
Hunk #3 FAILED at 57.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mm/context.c.rej
patching file b/arch/arm/mm/copypage-v4mc.c
Hunk #1 FAILED at 44.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mm/copypage-v4mc.c.rej
patching file b/arch/arm/mm/copypage-xscale.c
Hunk #1 FAILED at 42.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mm/copypage-xscale.c.rej
patching file b/arch/arm/mm/fault-armv.c
Hunk #1 FAILED at 25.
Hunk #2 FAILED at 94.
Hunk #3 FAILED at 125.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mm/fault-armv.c.rej
patching file b/arch/arm/mm/fault.c
Hunk #1 FAILED at 57.
Hunk #2 FAILED at 251.
Hunk #3 FAILED at 351.
Hunk #4 FAILED at 386.
Hunk #5 FAILED at 396.
Hunk #6 FAILED at 468.
Hunk #7 FAILED at 487.
7 out of 7 hunks FAILED -- saving rejects to file
b/arch/arm/mm/fault.c.rej
patching file b/arch/arm/mm/flush.c
Hunk #1 FAILED at 50.
Hunk #2 FAILED at 73.
Hunk #3 FAILED at 98.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mm/flush.c.rej
patching file b/arch/arm/mm/ioremap.c
Hunk #1 FAILED at 316.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mm/ioremap.c.rej
patching file b/arch/arm/mm/mmap.c
Hunk #1 FAILED at 56.
Hunk #2 FAILED at 71.
Hunk #3 FAILED at 105.
Hunk #4 FAILED at 113.
4 out of 4 hunks FAILED -- saving rejects to file
b/arch/arm/mm/mmap.c.rej
patching file b/arch/arm/mm/pgd.c
Hunk #1 FAILED at 18.
Hunk #2 FAILED at 26.
Hunk #3 FAILED at 37.
Hunk #4 FAILED at 74.
Hunk #5 FAILED at 81.
Hunk #6 FAILED at 95.
6 out of 6 hunks FAILED -- saving rejects to file
b/arch/arm/mm/pgd.c.rej
patching file b/arch/arm/mm/proc-arm920.S
Hunk #1 FAILED at 321.
Hunk #2 FAILED at 338.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mm/proc-arm920.S.rej
patching file b/arch/arm/mm/proc-arm926.S
Hunk #1 FAILED at 337.
Hunk #2 FAILED at 346.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mm/proc-arm926.S.rej
patching file b/arch/arm/mm/proc-xscale.S
Hunk #1 FAILED at 415.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mm/proc-xscale.S.rej
patching file b/arch/arm/plat-mxc/gpio.c
Hunk #1 FAILED at 25.
Hunk #2 FAILED at 157.
Hunk #3 FAILED at 174.
Hunk #4 FAILED at 195.
Hunk #5 FAILED at 269.
5 out of 5 hunks FAILED -- saving rejects to file
b/arch/arm/plat-mxc/gpio.c.rej
patching file b/arch/arm/plat-mxc/time.c
Hunk #1 FAILED at 57.
Hunk #2 FAILED at 120.
Hunk #3 FAILED at 238.
Hunk #4 FAILED at 326.
4 out of 4 hunks FAILED -- saving rejects to file
b/arch/arm/plat-mxc/time.c.rej
patching file b/arch/arm/plat-omap/Kconfig
Hunk #1 FAILED at 131.
Hunk #2 FAILED at 140.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/plat-omap/Kconfig.rej
patching file b/arch/arm/plat-omap/dmtimer.c
Hunk #1 FAILED at 475.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/plat-omap/dmtimer.c.rej
patching file b/arch/arm/plat-omap/gpio.c
Hunk #1 FAILED at 20.
Hunk #2 FAILED at 1200.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/plat-omap/gpio.c.rej
patching file b/arch/arm/plat-omap/include/mach/dmtimer.h
Hunk #1 FAILED at 56.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/plat-omap/include/mach/dmtimer.h.rej
patching file b/arch/arm/plat-pxa/gpio.c
Hunk #1 FAILED at 17.
Hunk #2 FAILED at 220.
Hunk #3 FAILED at 285.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/plat-pxa/gpio.c.rej
patching file b/arch/arm/plat-s3c/time.c
Hunk #1 FAILED at 3.
Hunk #2 FAILED at 27.
Hunk #3 FAILED at 42.
Hunk #4 FAILED at 61.
Hunk #5 FAILED at 91.
Hunk #6 FAILED at 132.
Hunk #7 FAILED at 153.
Hunk #8 FAILED at 164.
Hunk #9 FAILED at 175.
Hunk #10 FAILED at 204.
Hunk #11 FAILED at 226.
Hunk #12 FAILED at 283.
12 out of 12 hunks FAILED -- saving rejects to file
b/arch/arm/plat-s3c/time.c.rej
patching file b/arch/arm/plat-s3c24xx/irq.c
Hunk #1 FAILED at 3.
Hunk #2 FAILED at 23.
Hunk #3 FAILED at 87.
Hunk #4 FAILED at 283.
Hunk #5 FAILED at 310.
Hunk #6 FAILED at 337.
Hunk #7 FAILED at 385.
Hunk #8 FAILED at 413.
Hunk #9 FAILED at 466.
Hunk #10 FAILED at 489.
10 out of 10 hunks FAILED -- saving rejects to file
b/arch/arm/plat-s3c24xx/irq.c.rej
patching file b/arch/arm/plat-s3c24xx/s3c244x-irq.c
Hunk #1 FAILED at 3.
Hunk #2 FAILED at 57.
Hunk #3 FAILED at 89.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/plat-s3c24xx/s3c244x-irq.c.rej
patching file b/arch/arm/vfp/entry.S
Hunk #1 FAILED at 25.
Hunk #2 FAILED at 33.
Hunk #3 FAILED at 50.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/vfp/entry.S.rej
patching file b/arch/arm/vfp/vfphw.S
Hunk #1 FAILED at 19.
Hunk #2 FAILED at 31.
Hunk #3 FAILED at 44.
Hunk #4 FAILED at 87.
Hunk #5 FAILED at 139.
Hunk #6 FAILED at 164.
6 out of 6 hunks FAILED -- saving rejects to file
b/arch/arm/vfp/vfphw.S.rej
patching file b/arch/arm/vfp/vfpmodule.c
Hunk #1 FAILED at 42.
Hunk #2 FAILED at 71.
Hunk #3 FAILED at 87.
Hunk #4 FAILED at 122.
Hunk #5 FAILED at 219.
Hunk #6 FAILED at 267.
Hunk #7 FAILED at 285.
Hunk #8 FAILED at 301.
8 out of 8 hunks FAILED -- saving rejects to file
b/arch/arm/vfp/vfpmodule.c.rej
patching file b/drivers/misc/Kconfig
Hunk #1 FAILED at 32.
1 out of 1 hunk FAILED -- saving rejects to file
b/drivers/misc/Kconfig.rej
patching file b/drivers/pci/htirq.c
Hunk #1 FAILED at 21.
1 out of 1 hunk FAILED -- saving rejects to file
b/drivers/pci/htirq.c.rej
patching file b/drivers/serial/8250.c
Hunk #1 FAILED at 3010.
1 out of 1 hunk FAILED -- saving rejects to file
b/drivers/serial/8250.c.rej
patching file b/fs/aio.c
Hunk #1 FAILED at 608.
1 out of 1 hunk FAILED -- saving rejects to file b/fs/aio.c.rej
patching file b/fs/exec.c
Hunk #1 FAILED at 699.
Hunk #2 FAILED at 721.
2 out of 2 hunks FAILED -- saving rejects to file b/fs/exec.c.rej
patching file b/include/asm-generic/atomic.h
Hunk #1 FAILED at 60.
Hunk #2 FAILED at 82.
Hunk #3 FAILED at 139.
3 out of 3 hunks FAILED -- saving rejects to file
b/include/asm-generic/atomic.h.rej
patching file b/include/asm-generic/bitops/atomic.h
Hunk #1 FAILED at 21.
1 out of 1 hunk FAILED -- saving rejects to file
b/include/asm-generic/bitops/atomic.h.rej
patching file b/include/asm-generic/cmpxchg-local.h
Hunk #1 FAILED at 20.
Hunk #2 FAILED at 41.
Hunk #3 FAILED at 54.
3 out of 3 hunks FAILED -- saving rejects to file
b/include/asm-generic/cmpxchg-local.h.rej
patching file b/include/asm-generic/percpu.h
Hunk #1 FAILED at 56.
Hunk #2 FAILED at 66.
2 out of 2 hunks FAILED -- saving rejects to file
b/include/asm-generic/percpu.h.rej
patching file b/include/linux/hardirq.h
Hunk #1 FAILED at 177.
1 out of 1 hunk FAILED -- saving rejects to file
b/include/linux/hardirq.h.rej
patching file b/include/linux/ipipe.h
patching file b/include/linux/ipipe_base.h
patching file b/include/linux/ipipe_compat.h
patching file b/include/linux/ipipe_percpu.h
patching file b/include/linux/ipipe_tickdev.h
patching file b/include/linux/ipipe_trace.h
patching file b/include/linux/irq.h
Hunk #1 FAILED at 119.
Hunk #2 FAILED at 165.
Hunk #3 FAILED at 345.
Hunk #4 FAILED at 359.
4 out of 4 hunks FAILED -- saving rejects to file
b/include/linux/irq.h.rej
patching file b/include/linux/kernel.h
Hunk #1 FAILED at 14.
Hunk #2 FAILED at 119.
2 out of 2 hunks FAILED -- saving rejects to file
b/include/linux/kernel.h.rej
patching file b/include/linux/lockdep.h
Hunk #1 FAILED at 379.
1 out of 1 hunk FAILED -- saving rejects to file
b/include/linux/lockdep.h.rej
patching file b/include/linux/mm.h
Hunk #1 FAILED at 104.
1 out of 1 hunk FAILED -- saving rejects to file
b/include/linux/mm.h.rej
patching file b/include/linux/preempt.h
Hunk #1 FAILED at 9.
1 out of 1 hunk FAILED -- saving rejects to file
b/include/linux/preempt.h.rej
patching file b/include/linux/sched.h
Hunk #1 FAILED at 59.
Hunk #2 FAILED at 188.
Hunk #3 FAILED at 295.
Hunk #4 FAILED at 342.
Hunk #5 FAILED at 1435.
Hunk #6 FAILED at 1674.
6 out of 6 hunks FAILED -- saving rejects to file
b/include/linux/sched.h.rej
patching file b/include/linux/spinlock.h
Hunk #1 FAILED at 90.
Hunk #2 FAILED at 101.
Hunk #3 FAILED at 195.
Hunk #4 FAILED at 217.
Hunk #5 FAILED at 234.
Hunk #6 FAILED at 249.
Hunk #7 FAILED at 266.
Hunk #8 FAILED at 280.
Hunk #9 FAILED at 316.
Hunk #10 FAILED at 380.
10 out of 10 hunks FAILED -- saving rejects to file
b/include/linux/spinlock.h.rej
patching file b/include/linux/spinlock_types.h
Hunk #1 FAILED at 31.
Hunk #2 FAILED at 92.
2 out of 2 hunks FAILED -- saving rejects to file
b/include/linux/spinlock_types.h.rej
patching file b/init/Kconfig
Hunk #1 FAILED at 78.
1 out of 1 hunk FAILED -- saving rejects to file b/init/Kconfig.rej
patching file b/init/main.c
Hunk #1 FAILED at 568.
Hunk #2 FAILED at 632.
Hunk #3 FAILED at 811.
3 out of 3 hunks FAILED -- saving rejects to file b/init/main.c.rej
patching file b/kernel/Makefile
Hunk #1 FAILED at 86.
1 out of 1 hunk FAILED -- saving rejects to file b/kernel/Makefile.rej
patching file b/kernel/exit.c
Hunk #1 FAILED at 959.
1 out of 1 hunk FAILED -- saving rejects to file b/kernel/exit.c.rej
patching file b/kernel/fork.c
Hunk #1 FAILED at 487.
Hunk #2 FAILED at 878.
Hunk #3 FAILED at 1257.
Hunk #4 FAILED at 1658.
4 out of 4 hunks FAILED -- saving rejects to file b/kernel/fork.c.rej
patching file b/kernel/ipipe/Kconfig
patching file b/kernel/ipipe/Kconfig.debug
patching file b/kernel/ipipe/Makefile
patching file b/kernel/ipipe/core.c
patching file b/kernel/ipipe/tracer.c
patching file b/kernel/irq/chip.c
Hunk #1 FAILED at 358.
Hunk #2 FAILED at 435.
Hunk #3 FAILED at 478.
Hunk #4 FAILED at 519.
Hunk #5 FAILED at 533.
Hunk #6 FAILED at 545.
Hunk #7 FAILED at 570.
Hunk #8 FAILED at 580.
Hunk #9 FAILED at 590.
9 out of 9 hunks FAILED -- saving rejects to file
b/kernel/irq/chip.c.rej
patching file b/kernel/irq/handle.c
Hunk #1 FAILED at 458.
Hunk #2 FAILED at 470.
2 out of 2 hunks FAILED -- saving rejects to file
b/kernel/irq/handle.c.rej
patching file b/kernel/lockdep.c
Hunk #1 FAILED at 2135.
Hunk #2 FAILED at 2178.
2 out of 2 hunks FAILED -- saving rejects to file b/kernel/lockdep.c.rej
patching file b/kernel/panic.c
Hunk #1 FAILED at 22.
Hunk #2 FAILED at 303.
2 out of 2 hunks FAILED -- saving rejects to file b/kernel/panic.c.rej
patching file b/kernel/power/hibernate.c
Hunk #1 FAILED at 238.
Hunk #2 FAILED at 267.
Hunk #3 FAILED at 355.
Hunk #4 FAILED at 386.
Hunk #5 FAILED at 467.
5 out of 5 hunks FAILED -- saving rejects to file
b/kernel/power/hibernate.c.rej
patching file b/kernel/printk.c
Hunk #1 FAILED at 551.
Hunk #2 FAILED at 575.
Hunk #3 FAILED at 584.
3 out of 3 hunks FAILED -- saving rejects to file b/kernel/printk.c.rej
patching file b/kernel/sched.c
Hunk #1 FAILED at 2442.
Hunk #2 FAILED at 2854.
Hunk #3 FAILED at 2902.
Hunk #4 FAILED at 5168.
Hunk #5 FAILED at 5190.
Hunk #6 FAILED at 5238.
Hunk #7 FAILED at 5314.
Hunk #8 FAILED at 5328.
Hunk #9 FAILED at 5368.
Hunk #10 FAILED at 5384.
Hunk #11 FAILED at 6222.
Hunk #12 FAILED at 6574.
Hunk #13 FAILED at 10581.
13 out of 13 hunks FAILED -- saving rejects to file b/kernel/sched.c.rej
patching file b/kernel/signal.c
Hunk #1 FAILED at 518.
1 out of 1 hunk FAILED -- saving rejects to file b/kernel/signal.c.rej
patching file b/kernel/spinlock.c
Hunk #1 FAILED at 87.
1 out of 1 hunk FAILED -- saving rejects to file b/kernel/spinlock.c.rej
patching file b/kernel/time/tick-common.c
Hunk #1 FAILED at 69.
Hunk #2 FAILED at 177.
2 out of 2 hunks FAILED -- saving rejects to file
b/kernel/time/tick-common.c.rej
patching file b/kernel/time/tick-sched.c
Hunk #1 FAILED at 520.
Hunk #2 FAILED at 671.
2 out of 2 hunks FAILED -- saving rejects to file
b/kernel/time/tick-sched.c.rej
patching file b/kernel/timer.c
Hunk #1 FAILED at 1163.
1 out of 1 hunk FAILED -- saving rejects to file b/kernel/timer.c.rej
patching file b/kernel/trace/Kconfig
Hunk #1 FAILED at 415.
1 out of 1 hunk FAILED -- saving rejects to file
b/kernel/trace/Kconfig.rej
patching file b/kernel/trace/ftrace.c
Hunk #1 FAILED at 28.
Hunk #2 FAILED at 1179.
Hunk #3 FAILED at 1186.
Hunk #4 FAILED at 2793.
Hunk #5 FAILED at 2878.
5 out of 5 hunks FAILED -- saving rejects to file
b/kernel/trace/ftrace.c.rej
patching file b/lib/Kconfig.debug
Hunk #1 FAILED at 128.
1 out of 1 hunk FAILED -- saving rejects to file b/lib/Kconfig.debug.rej
patching file b/lib/bust_spinlocks.c
Hunk #1 FAILED at 13.
Hunk #2 FAILED at 24.
2 out of 2 hunks FAILED -- saving rejects to file
b/lib/bust_spinlocks.c.rej
patching file b/lib/ioremap.c
Hunk #1 FAILED at 85.
1 out of 1 hunk FAILED -- saving rejects to file b/lib/ioremap.c.rej
patching file b/lib/smp_processor_id.c
Hunk #1 FAILED at 12.
1 out of 1 hunk FAILED -- saving rejects to file
b/lib/smp_processor_id.c.rej
patching file b/lib/spinlock_debug.c
Hunk #1 FAILED at 133.
Hunk #2 FAILED at 148.
Hunk #3 FAILED at 199.
Hunk #4 FAILED at 212.
Hunk #5 FAILED at 275.
Hunk #6 FAILED at 290.
6 out of 6 hunks FAILED -- saving rejects to file
b/lib/spinlock_debug.c.rej
patching file b/mm/memory.c
Hunk #1 FAILED at 55.
Hunk #2 FAILED at 533.
Hunk #3 FAILED at 541.
Hunk #4 FAILED at 581.
Hunk #5 FAILED at 611.
Hunk #6 FAILED at 638.
Hunk #7 FAILED at 1900.
Hunk #8 FAILED at 3350.
8 out of 8 hunks FAILED -- saving rejects to file b/mm/memory.c.rej
patching file b/mm/mlock.c
Hunk #1 FAILED at 511.
1 out of 1 hunk FAILED -- saving rejects to file b/mm/mlock.c.rej
patching file b/mm/vmalloc.c
Hunk #1 FAILED at 173.
1 out of 1 hunk FAILED -- saving rejects to file b/mm/vmalloc.c.rej
flavio@domain.hid$ cd ..
flavio@domain.hid$ rm -rf linux-2.6-imx
flavio@domain.hid$ cp linux-2.6-imx- linux-2.6-imx
linux-2.6-imx-bkp/         linux-2.6-imx-xen.tar.bz2
flavio@domain.hid$ cp linux-2.6-imx- linux-2.6-imx
linux-2.6-imx-bkp/         linux-2.6-imx-xen.tar.bz2
flavio@domain.hid$ cp linux-2.6-imx-bkp linux-2.6-imx
cp: omitting directory `linux-2.6-imx-bkp'
flavio@domain.hid$ cp -r linux-2.6-imx-bkp linux-2.6-imx
flavio@domain.hid$ cd linux-2.6-imx
flavio@domain.hid$ ls
arch     crypto         fs       Kbuild       Makefile  REPORTING-BUGS
sound
block    Documentation  include  kernel       mm        samples
tools
COPYING  drivers        init     lib          net       scripts
usr
CREDITS  firmware       ipc      MAINTAINERS  README    security
virt
flavio@domain.hid$ patch -p0
< ../adeos-ipipe-2.6.31-arm-1.15-01.patch 
patching file b/arch/arm/Kconfig
Hunk #1 FAILED at 235.
Hunk #2 FAILED at 962.
2 out of 2 hunks FAILED -- saving rejects to file b/arch/arm/Kconfig.rej
patching file b/arch/arm/boot/compressed/head.S
Hunk #1 FAILED at 1012.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/boot/compressed/head.S.rej
patching file b/arch/arm/common/it8152.c
Hunk #1 FAILED at 26.
Hunk #2 FAILED at 120.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/common/it8152.c.rej
patching file b/arch/arm/include/asm/assembler.h
Hunk #1 FAILED at 81.
Hunk #2 FAILED at 89.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/assembler.h.rej
patching file b/arch/arm/include/asm/atomic.h
Hunk #1 FAILED at 170.
Hunk #2 FAILED at 184.
Hunk #3 FAILED at 198.
Hunk #4 FAILED at 211.
4 out of 4 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/atomic.h.rej
patching file b/arch/arm/include/asm/bitops.h
Hunk #1 FAILED at 41.
Hunk #2 FAILED at 53.
Hunk #3 FAILED at 65.
Hunk #4 FAILED at 79.
Hunk #5 FAILED at 96.
Hunk #6 FAILED at 113.
6 out of 6 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/bitops.h.rej
patching file b/arch/arm/include/asm/cacheflush.h
Hunk #1 FAILED at 15.
Hunk #2 FAILED at 334.
Hunk #3 FAILED at 381.
Hunk #4 FAILED at 426.
4 out of 4 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/cacheflush.h.rej
patching file b/arch/arm/include/asm/cpu-multi32.h
Hunk #1 FAILED at 52.
Hunk #2 FAILED at 66.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/cpu-multi32.h.rej
patching file b/arch/arm/include/asm/cpu-single.h
Hunk #1 FAILED at 39.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/include/asm/cpu-single.h.rej
patching file b/arch/arm/include/asm/fcse.h
patching file b/arch/arm/include/asm/ipipe.h
patching file b/arch/arm/include/asm/ipipe_base.h
patching file b/arch/arm/include/asm/irqflags.h
Hunk #1 FAILED at 10.
Hunk #2 FAILED at 44.
Hunk #3 FAILED at 59.
Hunk #4 FAILED at 74.
Hunk #5 FAILED at 89.
Hunk #6 FAILED at 106.
Hunk #7 FAILED at 128.
7 out of 7 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/irqflags.h.rej
patching file b/arch/arm/include/asm/memory.h
Hunk #1 FAILED at 33.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/include/asm/memory.h.rej
patching file b/arch/arm/include/asm/mmu.h
Hunk #1 FAILED at 7.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/include/asm/mmu.h.rej
patching file b/arch/arm/include/asm/mmu_context.h
Hunk #1 FAILED at 19.
Hunk #2 FAILED at 66.
Hunk #3 FAILED at 93.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/mmu_context.h.rej
patching file b/arch/arm/include/asm/pgtable.h
Hunk #1 FAILED at 112.
Hunk #2 FAILED at 250.
Hunk #3 FAILED at 261.
Hunk #4 FAILED at 271.
Hunk #5 FAILED at 355.
5 out of 5 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/pgtable.h.rej
patching file b/arch/arm/include/asm/proc-fns.h
Hunk #1 FAILED at 239.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/include/asm/proc-fns.h.rej
patching file b/arch/arm/include/asm/processor.h
Hunk #1 FAILED at 23.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/include/asm/processor.h.rej
patching file b/arch/arm/include/asm/system.h
Hunk #1 FAILED at 213.
Hunk #2 FAILED at 277.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/system.h.rej
patching file b/arch/arm/include/asm/thread_info.h
Hunk #1 FAILED at 140.
Hunk #2 FAILED at 147.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/thread_info.h.rej
patching file b/arch/arm/include/asm/tlbflush.h
Hunk #1 FAILED at 210.
Hunk #2 FAILED at 350.
Hunk #3 FAILED at 383.
Hunk #4 FAILED at 504.
4 out of 4 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/tlbflush.h.rej
patching file b/arch/arm/kernel/Makefile
Hunk #1 FAILED at 48.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/kernel/Makefile.rej
patching file b/arch/arm/kernel/entry-armv.S
Hunk #1 FAILED at 4.
Hunk #2 FAILED at 28.
Hunk #3 FAILED at 44.
Hunk #4 FAILED at 211.
Hunk #5 FAILED at 240.
Hunk #6 FAILED at 258.
Hunk #7 FAILED at 442.
Hunk #8 FAILED at 565.
Hunk #9 FAILED at 607.
Hunk #10 FAILED at 643.
Hunk #11 FAILED at 694.
Hunk #12 FAILED at 735.
Hunk #13 FAILED at 773.
13 out of 13 hunks FAILED -- saving rejects to file
b/arch/arm/kernel/entry-armv.S.rej
patching file b/arch/arm/kernel/entry-common.S
Hunk #1 FAILED at 2.
Hunk #2 FAILED at 22.
Hunk #3 FAILED at 30.
Hunk #4 FAILED at 41.
Hunk #5 FAILED at 53.
Hunk #6 FAILED at 70.
Hunk #7 FAILED at 268.
Hunk #8 FAILED at 315.
Hunk #9 FAILED at 485.
9 out of 9 hunks FAILED -- saving rejects to file
b/arch/arm/kernel/entry-common.S.rej
patching file b/arch/arm/kernel/entry-header.S
Hunk #1 FAILED at 49.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/kernel/entry-header.S.rej
patching file b/arch/arm/kernel/fcse.c
patching file b/arch/arm/kernel/ipipe.c
patching file b/arch/arm/kernel/irq.c
Hunk #1 FAILED at 121.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/kernel/irq.c.rej
patching file b/arch/arm/kernel/process.c
Hunk #1 FAILED at 127.
Hunk #2 FAILED at 148.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/kernel/process.c.rej
patching file b/arch/arm/kernel/ptrace.c
Hunk #1 FAILED at 479.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/kernel/ptrace.c.rej
patching file b/arch/arm/kernel/smp.c
Hunk #1 FAILED at 36.
Hunk #2 FAILED at 643.
Hunk #3 FAILED at 654.
Hunk #4 FAILED at 677.
4 out of 4 hunks FAILED -- saving rejects to file
b/arch/arm/kernel/smp.c.rej
patching file b/arch/arm/kernel/traps.c
Hunk #1 FAILED at 325.
Hunk #2 FAILED at 719.
Hunk #3 FAILED at 734.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/kernel/traps.c.rej
patching file b/arch/arm/mach-at91/Kconfig
Hunk #1 FAILED at 311.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-at91/Kconfig.rej
patching file b/arch/arm/mach-at91/Makefile
Hunk #1 FAILED at 71.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-at91/Makefile.rej
patching file b/arch/arm/mach-at91/at91_ipipe_time.c
patching file b/arch/arm/mach-at91/at91rm9200.c
Hunk #1 FAILED at 33.
Hunk #2 FAILED at 300.
Hunk #3 FAILED at 332.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mach-at91/at91rm9200.c.rej
patching file b/arch/arm/mach-at91/at91sam9260.c
Hunk #1 FAILED at 31.
Hunk #2 FAILED at 350.
Hunk #3 FAILED at 382.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mach-at91/at91sam9260.c.rej
patching file b/arch/arm/mach-at91/at91sam9261.c
Hunk #1 FAILED at 30.
Hunk #2 FAILED at 286.
Hunk #3 FAILED at 318.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mach-at91/at91sam9261.c.rej
patching file b/arch/arm/mach-at91/at91sam9263.c
Hunk #1 FAILED at 30.
Hunk #2 FAILED at 311.
Hunk #3 FAILED at 343.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mach-at91/at91sam9263.c.rej
patching file b/arch/arm/mach-at91/at91sam9rl.c
Hunk #1 FAILED at 30.
Hunk #2 FAILED at 303.
Hunk #3 FAILED at 335.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mach-at91/at91sam9rl.c.rej
patching file b/arch/arm/mach-at91/gpio.c
Hunk #1 FAILED at 25.
Hunk #2 FAILED at 377.
Hunk #3 FAILED at 424.
Hunk #4 FAILED at 435.
Hunk #5 FAILED at 511.
Hunk #6 FAILED at 540.
6 out of 6 hunks FAILED -- saving rejects to file
b/arch/arm/mach-at91/gpio.c.rej
patching file b/arch/arm/mach-at91/include/mach/hardware.h
Hunk #1 FAILED at 61.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-at91/include/mach/hardware.h.rej
patching file b/arch/arm/mach-at91/include/mach/irqs.h
Hunk #1 FAILED at 45.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-at91/include/mach/irqs.h.rej
patching file b/arch/arm/mach-at91/include/mach/timex.h
Hunk #1 FAILED at 72.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-at91/include/mach/timex.h.rej
patching file b/arch/arm/mach-at91/irq.c
Hunk #1 FAILED at 121.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-at91/irq.c.rej
patching file b/arch/arm/mach-integrator/core.c
Hunk #1 FAILED at 2.
Hunk #2 FAILED at 230.
Hunk #3 FAILED at 285.
Hunk #4 FAILED at 301.
Hunk #5 FAILED at 326.
5 out of 5 hunks FAILED -- saving rejects to file
b/arch/arm/mach-integrator/core.c.rej
patching file b/arch/arm/mach-integrator/include/mach/entry-macro.S
Hunk #1 FAILED at 28.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-integrator/include/mach/entry-macro.S.rej
patching file b/arch/arm/mach-integrator/include/mach/irqs.h
Hunk #1 FAILED at 79.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-integrator/include/mach/irqs.h.rej
patching file b/arch/arm/mach-integrator/include/mach/platform.h
Hunk #1 FAILED at 417.
Hunk #2 FAILED at 430.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mach-integrator/include/mach/platform.h.rej
patching file b/arch/arm/mach-integrator/include/mach/timex.h
Hunk #1 FAILED at 21.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-integrator/include/mach/timex.h.rej
patching file b/arch/arm/mach-integrator/integrator_cp.c
Hunk #1 FAILED at 2.
Hunk #2 FAILED at 20.
Hunk #3 FAILED at 161.
Hunk #4 FAILED at 180.
Hunk #5 FAILED at 199.
Hunk #6 FAILED at 218.
Hunk #7 FAILED at 569.
7 out of 7 hunks FAILED -- saving rejects to file
b/arch/arm/mach-integrator/integrator_cp.c.rej
patching file b/arch/arm/mach-ixp4xx/common.c
Hunk #1 FAILED at 45.
Hunk #2 FAILED at 269.
Hunk #3 FAILED at 294.
Hunk #4 FAILED at 470.
Hunk #5 FAILED at 492.
5 out of 5 hunks FAILED -- saving rejects to file
b/arch/arm/mach-ixp4xx/common.c.rej
patching file b/arch/arm/mach-mx3/mx31ads.c
Hunk #1 FAILED at 134.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-mx3/mx31ads.c.rej
patching file b/arch/arm/mach-mx3/mx31pdk.c
Hunk #1 FAILED at 23.
Hunk #2 FAILED at 108.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mach-mx3/mx31pdk.c.rej
patching file b/arch/arm/mach-omap2/timer-gp.c
Hunk #1 FAILED at 47.
Hunk #2 FAILED at 125.
Hunk #3 FAILED at 156.
Hunk #4 FAILED at 166.
Hunk #5 FAILED at 185.
Hunk #6 FAILED at 223.
Hunk #7 FAILED at 242.
7 out of 7 hunks FAILED -- saving rejects to file
b/arch/arm/mach-omap2/timer-gp.c.rej
patching file b/arch/arm/mach-pxa/irq.c
Hunk #1 FAILED at 49.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-pxa/irq.c.rej
patching file b/arch/arm/mach-pxa/leds-idp.c
Hunk #1 FAILED at 13.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-pxa/leds-idp.c.rej
patching file b/arch/arm/mach-pxa/leds-lubbock.c
Hunk #1 FAILED at 12.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-pxa/leds-lubbock.c.rej
patching file b/arch/arm/mach-pxa/leds-mainstone.c
Hunk #1 FAILED at 11.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-pxa/leds-mainstone.c.rej
patching file b/arch/arm/mach-pxa/lpd270.c
Hunk #1 FAILED at 24.
Hunk #2 FAILED at 124.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mach-pxa/lpd270.c.rej
patching file b/arch/arm/mach-pxa/lubbock.c
Hunk #1 FAILED at 22.
Hunk #2 FAILED at 161.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mach-pxa/lubbock.c.rej
patching file b/arch/arm/mach-pxa/mainstone.c
Hunk #1 FAILED at 27.
Hunk #2 FAILED at 165.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mach-pxa/mainstone.c.rej
patching file b/arch/arm/mach-pxa/pcm990-baseboard.c
Hunk #1 FAILED at 24.
Hunk #2 FAILED at 263.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mach-pxa/pcm990-baseboard.c.rej
patching file b/arch/arm/mach-pxa/time.c
Hunk #1 FAILED at 24.
Hunk #2 FAILED at 66.
Hunk #3 FAILED at 79.
Hunk #4 FAILED at 125.
Hunk #5 FAILED at 168.
Hunk #6 FAILED at 213.
6 out of 6 hunks FAILED -- saving rejects to file
b/arch/arm/mach-pxa/time.c.rej
patching file b/arch/arm/mach-pxa/viper.c
Hunk #1 FAILED at 41.
Hunk #2 FAILED at 270.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mach-pxa/viper.c.rej
patching file b/arch/arm/mach-s3c2410/include/mach/irqs.h
Hunk #1 FAILED at 3.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-s3c2410/include/mach/irqs.h.rej
patching file b/arch/arm/mach-s3c2440/irq.c
Hunk #1 FAILED at 3.
Hunk #2 FAILED at 25.
Hunk #3 FAILED at 57.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mach-s3c2440/irq.c.rej
patching file b/arch/arm/mach-sa1100/irq.c
Hunk #1 FAILED at 15.
Hunk #2 FAILED at 125.
Hunk #3 FAILED at 217.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mach-sa1100/irq.c.rej
patching file b/arch/arm/mach-sa1100/leds-assabet.c
Hunk #1 FAILED at 10.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-sa1100/leds-assabet.c.rej
patching file b/arch/arm/mach-sa1100/leds-badge4.c
Hunk #1 FAILED at 11.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-sa1100/leds-badge4.c.rej
patching file b/arch/arm/mach-sa1100/leds-cerf.c
Hunk #1 FAILED at 4.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-sa1100/leds-cerf.c.rej
patching file b/arch/arm/mach-sa1100/leds-hackkit.c
Hunk #1 FAILED at 10.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-sa1100/leds-hackkit.c.rej
patching file b/arch/arm/mach-sa1100/leds-lart.c
Hunk #1 FAILED at 10.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-sa1100/leds-lart.c.rej
patching file b/arch/arm/mach-sa1100/leds-simpad.c
Hunk #1 FAILED at 4.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-sa1100/leds-simpad.c.rej
patching file b/arch/arm/mach-sa1100/time.c
Hunk #1 FAILED at 20.
Hunk #2 FAILED at 77.
Hunk #3 FAILED at 116.
Hunk #4 FAILED at 156.
4 out of 4 hunks FAILED -- saving rejects to file
b/arch/arm/mach-sa1100/time.c.rej
patching file b/arch/arm/mm/Kconfig
Hunk #1 FAILED at 771.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mm/Kconfig.rej
patching file b/arch/arm/mm/alignment.c
Hunk #1 FAILED at 713.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mm/alignment.c.rej
patching file b/arch/arm/mm/context.c
Hunk #1 FAILED at 14.
Hunk #2 FAILED at 31.
Hunk #3 FAILED at 57.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mm/context.c.rej
patching file b/arch/arm/mm/copypage-v4mc.c
Hunk #1 FAILED at 44.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mm/copypage-v4mc.c.rej
patching file b/arch/arm/mm/copypage-xscale.c
Hunk #1 FAILED at 42.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mm/copypage-xscale.c.rej
patching file b/arch/arm/mm/fault-armv.c
Hunk #1 FAILED at 25.
Hunk #2 FAILED at 94.
Hunk #3 FAILED at 125.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mm/fault-armv.c.rej
patching file b/arch/arm/mm/fault.c
Hunk #1 FAILED at 57.
Hunk #2 FAILED at 251.
Hunk #3 FAILED at 351.
Hunk #4 FAILED at 386.
Hunk #5 FAILED at 396.
Hunk #6 FAILED at 468.
Hunk #7 FAILED at 487.
7 out of 7 hunks FAILED -- saving rejects to file
b/arch/arm/mm/fault.c.rej
patching file b/arch/arm/mm/flush.c
Hunk #1 FAILED at 50.
Hunk #2 FAILED at 73.
Hunk #3 FAILED at 98.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mm/flush.c.rej
patching file b/arch/arm/mm/ioremap.c
Hunk #1 FAILED at 316.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mm/ioremap.c.rej
patching file b/arch/arm/mm/mmap.c
Hunk #1 FAILED at 56.
Hunk #2 FAILED at 71.
Hunk #3 FAILED at 105.
Hunk #4 FAILED at 113.
4 out of 4 hunks FAILED -- saving rejects to file
b/arch/arm/mm/mmap.c.rej
patching file b/arch/arm/mm/pgd.c
Hunk #1 FAILED at 18.
Hunk #2 FAILED at 26.
Hunk #3 FAILED at 37.
Hunk #4 FAILED at 74.
Hunk #5 FAILED at 81.
Hunk #6 FAILED at 95.
6 out of 6 hunks FAILED -- saving rejects to file
b/arch/arm/mm/pgd.c.rej
patching file b/arch/arm/mm/proc-arm920.S
Hunk #1 FAILED at 321.
Hunk #2 FAILED at 338.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mm/proc-arm920.S.rej
patching file b/arch/arm/mm/proc-arm926.S
Hunk #1 FAILED at 337.
Hunk #2 FAILED at 346.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mm/proc-arm926.S.rej
patching file b/arch/arm/mm/proc-xscale.S
Hunk #1 FAILED at 415.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mm/proc-xscale.S.rej
patching file b/arch/arm/plat-mxc/gpio.c
Hunk #1 FAILED at 25.
Hunk #2 FAILED at 157.
Hunk #3 FAILED at 174.
Hunk #4 FAILED at 195.
Hunk #5 FAILED at 269.
5 out of 5 hunks FAILED -- saving rejects to file
b/arch/arm/plat-mxc/gpio.c.rej
patching file b/arch/arm/plat-mxc/time.c
Hunk #1 FAILED at 57.
Hunk #2 FAILED at 120.
Hunk #3 FAILED at 238.
Hunk #4 FAILED at 326.
4 out of 4 hunks FAILED -- saving rejects to file
b/arch/arm/plat-mxc/time.c.rej
patching file b/arch/arm/plat-omap/Kconfig
Hunk #1 FAILED at 131.
Hunk #2 FAILED at 140.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/plat-omap/Kconfig.rej
patching file b/arch/arm/plat-omap/dmtimer.c
Hunk #1 FAILED at 475.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/plat-omap/dmtimer.c.rej
patching file b/arch/arm/plat-omap/gpio.c
Hunk #1 FAILED at 20.
Hunk #2 FAILED at 1200.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/plat-omap/gpio.c.rej
patching file b/arch/arm/plat-omap/include/mach/dmtimer.h
Hunk #1 FAILED at 56.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/plat-omap/include/mach/dmtimer.h.rej
patching file b/arch/arm/plat-pxa/gpio.c
Hunk #1 FAILED at 17.
Hunk #2 FAILED at 220.
Hunk #3 FAILED at 285.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/plat-pxa/gpio.c.rej
patching file b/arch/arm/plat-s3c/time.c
Hunk #1 FAILED at 3.
Hunk #2 FAILED at 27.
Hunk #3 FAILED at 42.
Hunk #4 FAILED at 61.
Hunk #5 FAILED at 91.
Hunk #6 FAILED at 132.
Hunk #7 FAILED at 153.
Hunk #8 FAILED at 164.
Hunk #9 FAILED at 175.
Hunk #10 FAILED at 204.
Hunk #11 FAILED at 226.
Hunk #12 FAILED at 283.
12 out of 12 hunks FAILED -- saving rejects to file
b/arch/arm/plat-s3c/time.c.rej
patching file b/arch/arm/plat-s3c24xx/irq.c
Hunk #1 FAILED at 3.
Hunk #2 FAILED at 23.
Hunk #3 FAILED at 87.
Hunk #4 FAILED at 283.
Hunk #5 FAILED at 310.
Hunk #6 FAILED at 337.
Hunk #7 FAILED at 385.
Hunk #8 FAILED at 413.
Hunk #9 FAILED at 466.
Hunk #10 FAILED at 489.
10 out of 10 hunks FAILED -- saving rejects to file
b/arch/arm/plat-s3c24xx/irq.c.rej
patching file b/arch/arm/plat-s3c24xx/s3c244x-irq.c
Hunk #1 FAILED at 3.
Hunk #2 FAILED at 57.
Hunk #3 FAILED at 89.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/plat-s3c24xx/s3c244x-irq.c.rej
patching file b/arch/arm/vfp/entry.S
Hunk #1 FAILED at 25.
Hunk #2 FAILED at 33.
Hunk #3 FAILED at 50.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/vfp/entry.S.rej
patching file b/arch/arm/vfp/vfphw.S
Hunk #1 FAILED at 19.
Hunk #2 FAILED at 31.
Hunk #3 FAILED at 44.
Hunk #4 FAILED at 87.
Hunk #5 FAILED at 139.
Hunk #6 FAILED at 164.
6 out of 6 hunks FAILED -- saving rejects to file
b/arch/arm/vfp/vfphw.S.rej
patching file b/arch/arm/vfp/vfpmodule.c
Hunk #1 FAILED at 42.
Hunk #2 FAILED at 71.
Hunk #3 FAILED at 87.
Hunk #4 FAILED at 122.
Hunk #5 FAILED at 219.
Hunk #6 FAILED at 267.
Hunk #7 FAILED at 285.
Hunk #8 FAILED at 301.
8 out of 8 hunks FAILED -- saving rejects to file
b/arch/arm/vfp/vfpmodule.c.rej
patching file b/drivers/misc/Kconfig
Hunk #1 FAILED at 32.
1 out of 1 hunk FAILED -- saving rejects to file
b/drivers/misc/Kconfig.rej
patching file b/drivers/pci/htirq.c
Hunk #1 FAILED at 21.
1 out of 1 hunk FAILED -- saving rejects to file
b/drivers/pci/htirq.c.rej
patching file b/drivers/serial/8250.c
Hunk #1 FAILED at 3010.
1 out of 1 hunk FAILED -- saving rejects to file
b/drivers/serial/8250.c.rej
patching file b/fs/aio.c
Hunk #1 FAILED at 608.
1 out of 1 hunk FAILED -- saving rejects to file b/fs/aio.c.rej
patching file b/fs/exec.c
Hunk #1 FAILED at 699.
Hunk #2 FAILED at 721.
2 out of 2 hunks FAILED -- saving rejects to file b/fs/exec.c.rej
patching file b/include/asm-generic/atomic.h
Hunk #1 FAILED at 60.
Hunk #2 FAILED at 82.
Hunk #3 FAILED at 139.
3 out of 3 hunks FAILED -- saving rejects to file
b/include/asm-generic/atomic.h.rej
patching file b/include/asm-generic/bitops/atomic.h
Hunk #1 FAILED at 21.
1 out of 1 hunk FAILED -- saving rejects to file
b/include/asm-generic/bitops/atomic.h.rej
patching file b/include/asm-generic/cmpxchg-local.h
Hunk #1 FAILED at 20.
Hunk #2 FAILED at 41.
Hunk #3 FAILED at 54.
3 out of 3 hunks FAILED -- saving rejects to file
b/include/asm-generic/cmpxchg-local.h.rej
patching file b/include/asm-generic/percpu.h
Hunk #1 FAILED at 56.
Hunk #2 FAILED at 66.
2 out of 2 hunks FAILED -- saving rejects to file
b/include/asm-generic/percpu.h.rej
patching file b/include/linux/hardirq.h
Hunk #1 FAILED at 177.
1 out of 1 hunk FAILED -- saving rejects to file
b/include/linux/hardirq.h.rej
patching file b/include/linux/ipipe.h
patching file b/include/linux/ipipe_base.h
patching file b/include/linux/ipipe_compat.h
patching file b/include/linux/ipipe_percpu.h
patching file b/include/linux/ipipe_tickdev.h
patching file b/include/linux/ipipe_trace.h
patching file b/include/linux/irq.h
Hunk #1 FAILED at 119.
Hunk #2 FAILED at 165.
Hunk #3 FAILED at 345.
Hunk #4 FAILED at 359.
4 out of 4 hunks FAILED -- saving rejects to file
b/include/linux/irq.h.rej
patching file b/include/linux/kernel.h
Hunk #1 FAILED at 14.
Hunk #2 FAILED at 119.
2 out of 2 hunks FAILED -- saving rejects to file
b/include/linux/kernel.h.rej
patching file b/include/linux/lockdep.h
Hunk #1 FAILED at 379.
1 out of 1 hunk FAILED -- saving rejects to file
b/include/linux/lockdep.h.rej
patching file b/include/linux/mm.h
Hunk #1 FAILED at 104.
1 out of 1 hunk FAILED -- saving rejects to file
b/include/linux/mm.h.rej
patching file b/include/linux/preempt.h
Hunk #1 FAILED at 9.
1 out of 1 hunk FAILED -- saving rejects to file
b/include/linux/preempt.h.rej
patching file b/include/linux/sched.h
Hunk #1 FAILED at 59.
Hunk #2 FAILED at 188.
Hunk #3 FAILED at 295.
Hunk #4 FAILED at 342.
Hunk #5 FAILED at 1435.
Hunk #6 FAILED at 1674.
6 out of 6 hunks FAILED -- saving rejects to file
b/include/linux/sched.h.rej
patching file b/include/linux/spinlock.h
Hunk #1 FAILED at 90.
Hunk #2 FAILED at 101.
Hunk #3 FAILED at 195.
Hunk #4 FAILED at 217.
Hunk #5 FAILED at 234.
Hunk #6 FAILED at 249.
Hunk #7 FAILED at 266.
Hunk #8 FAILED at 280.
Hunk #9 FAILED at 316.
Hunk #10 FAILED at 380.
10 out of 10 hunks FAILED -- saving rejects to file
b/include/linux/spinlock.h.rej
patching file b/include/linux/spinlock_types.h
Hunk #1 FAILED at 31.
Hunk #2 FAILED at 92.
2 out of 2 hunks FAILED -- saving rejects to file
b/include/linux/spinlock_types.h.rej
patching file b/init/Kconfig
Hunk #1 FAILED at 78.
1 out of 1 hunk FAILED -- saving rejects to file b/init/Kconfig.rej
patching file b/init/main.c
Hunk #1 FAILED at 568.
Hunk #2 FAILED at 632.
Hunk #3 FAILED at 811.
3 out of 3 hunks FAILED -- saving rejects to file b/init/main.c.rej
patching file b/kernel/Makefile
Hunk #1 FAILED at 86.
1 out of 1 hunk FAILED -- saving rejects to file b/kernel/Makefile.rej
patching file b/kernel/exit.c
Hunk #1 FAILED at 959.
1 out of 1 hunk FAILED -- saving rejects to file b/kernel/exit.c.rej
patching file b/kernel/fork.c
Hunk #1 FAILED at 487.
Hunk #2 FAILED at 878.
Hunk #3 FAILED at 1257.
Hunk #4 FAILED at 1658.
4 out of 4 hunks FAILED -- saving rejects to file b/kernel/fork.c.rej
patching file b/kernel/ipipe/Kconfig
patching file b/kernel/ipipe/Kconfig.debug
patching file b/kernel/ipipe/Makefile
patching file b/kernel/ipipe/core.c
patching file b/kernel/ipipe/tracer.c
patching file b/kernel/irq/chip.c
Hunk #1 FAILED at 358.
Hunk #2 FAILED at 435.
Hunk #3 FAILED at 478.
Hunk #4 FAILED at 519.
Hunk #5 FAILED at 533.
Hunk #6 FAILED at 545.
Hunk #7 FAILED at 570.
Hunk #8 FAILED at 580.
Hunk #9 FAILED at 590.
9 out of 9 hunks FAILED -- saving rejects to file
b/kernel/irq/chip.c.rej
patching file b/kernel/irq/handle.c
Hunk #1 FAILED at 458.
Hunk #2 FAILED at 470.
2 out of 2 hunks FAILED -- saving rejects to file
b/kernel/irq/handle.c.rej
patching file b/kernel/lockdep.c
Hunk #1 FAILED at 2135.
Hunk #2 FAILED at 2178.
2 out of 2 hunks FAILED -- saving rejects to file b/kernel/lockdep.c.rej
patching file b/kernel/panic.c
Hunk #1 FAILED at 22.
Hunk #2 FAILED at 303.
2 out of 2 hunks FAILED -- saving rejects to file b/kernel/panic.c.rej
patching file b/kernel/power/hibernate.c
Hunk #1 FAILED at 238.
Hunk #2 FAILED at 267.
Hunk #3 FAILED at 355.
Hunk #4 FAILED at 386.
Hunk #5 FAILED at 467.
5 out of 5 hunks FAILED -- saving rejects to file
b/kernel/power/hibernate.c.rej
patching file b/kernel/printk.c
Hunk #1 FAILED at 551.
Hunk #2 FAILED at 575.
Hunk #3 FAILED at 584.
3 out of 3 hunks FAILED -- saving rejects to file b/kernel/printk.c.rej
patching file b/kernel/sched.c
Hunk #1 FAILED at 2442.
Hunk #2 FAILED at 2854.
Hunk #3 FAILED at 2902.
Hunk #4 FAILED at 5168.
Hunk #5 FAILED at 5190.
Hunk #6 FAILED at 5238.
Hunk #7 FAILED at 5314.
Hunk #8 FAILED at 5328.
Hunk #9 FAILED at 5368.
Hunk #10 FAILED at 5384.
Hunk #11 FAILED at 6222.
Hunk #12 FAILED at 6574.
Hunk #13 FAILED at 10581.
13 out of 13 hunks FAILED -- saving rejects to file b/kernel/sched.c.rej
patching file b/kernel/signal.c
Hunk #1 FAILED at 518.
1 out of 1 hunk FAILED -- saving rejects to file b/kernel/signal.c.rej
patching file b/kernel/spinlock.c
Hunk #1 FAILED at 87.
1 out of 1 hunk FAILED -- saving rejects to file b/kernel/spinlock.c.rej
patching file b/kernel/time/tick-common.c
Hunk #1 FAILED at 69.
Hunk #2 FAILED at 177.
2 out of 2 hunks FAILED -- saving rejects to file
b/kernel/time/tick-common.c.rej
patching file b/kernel/time/tick-sched.c
Hunk #1 FAILED at 520.
Hunk #2 FAILED at 671.
2 out of 2 hunks FAILED -- saving rejects to file
b/kernel/time/tick-sched.c.rej
patching file b/kernel/timer.c
Hunk #1 FAILED at 1163.
1 out of 1 hunk FAILED -- saving rejects to file b/kernel/timer.c.rej
patching file b/kernel/trace/Kconfig
Hunk #1 FAILED at 415.
1 out of 1 hunk FAILED -- saving rejects to file
b/kernel/trace/Kconfig.rej
patching file b/kernel/trace/ftrace.c
Hunk #1 FAILED at 28.
Hunk #2 FAILED at 1179.
Hunk #3 FAILED at 1186.
Hunk #4 FAILED at 2793.
Hunk #5 FAILED at 2878.
5 out of 5 hunks FAILED -- saving rejects to file
b/kernel/trace/ftrace.c.rej
patching file b/lib/Kconfig.debug
Hunk #1 FAILED at 128.
1 out of 1 hunk FAILED -- saving rejects to file b/lib/Kconfig.debug.rej
patching file b/lib/bust_spinlocks.c
Hunk #1 FAILED at 13.
Hunk #2 FAILED at 24.
2 out of 2 hunks FAILED -- saving rejects to file
b/lib/bust_spinlocks.c.rej
patching file b/lib/ioremap.c
Hunk #1 FAILED at 85.
1 out of 1 hunk FAILED -- saving rejects to file b/lib/ioremap.c.rej
patching file b/lib/smp_processor_id.c
Hunk #1 FAILED at 12.
1 out of 1 hunk FAILED -- saving rejects to file
b/lib/smp_processor_id.c.rej
patching file b/lib/spinlock_debug.c
Hunk #1 FAILED at 133.
Hunk #2 FAILED at 148.
Hunk #3 FAILED at 199.
Hunk #4 FAILED at 212.
Hunk #5 FAILED at 275.
Hunk #6 FAILED at 290.
6 out of 6 hunks FAILED -- saving rejects to file
b/lib/spinlock_debug.c.rej
patching file b/mm/memory.c
Hunk #1 FAILED at 55.
Hunk #2 FAILED at 533.
Hunk #3 FAILED at 541.
Hunk #4 FAILED at 581.
Hunk #5 FAILED at 611.
Hunk #6 FAILED at 638.
Hunk #7 FAILED at 1900.
Hunk #8 FAILED at 3350.
8 out of 8 hunks FAILED -- saving rejects to file b/mm/memory.c.rej
patching file b/mm/mlock.c
Hunk #1 FAILED at 511.
1 out of 1 hunk FAILED -- saving rejects to file b/mm/mlock.c.rej
patching file b/mm/vmalloc.c
Hunk #1 FAILED at 173.
1 out of 1 hunk FAILED -- saving rejects to file b/mm/vmalloc.c.rej
flavio@domain.hid$ cd ..
flavio@domain.hid$ rm -rf linux-2.6-imx
flavio@domain.hid$ cp -r linux-2.6-imx-bkp linux-2.6-imx
flavio@domain.hid$ cd linux-2.6-imx
flavio@domain.hid$ patch -p0
< ../adeos-ipipe-2.6.31-arm-1.16-01.patch 
patching file b/arch/arm/Kconfig
Hunk #1 FAILED at 235.
Hunk #2 FAILED at 962.
2 out of 2 hunks FAILED -- saving rejects to file b/arch/arm/Kconfig.rej
patching file b/arch/arm/boot/compressed/head.S
Hunk #1 FAILED at 1012.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/boot/compressed/head.S.rej
patching file b/arch/arm/common/it8152.c
Hunk #1 FAILED at 26.
Hunk #2 FAILED at 120.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/common/it8152.c.rej
patching file b/arch/arm/include/asm/assembler.h
Hunk #1 FAILED at 81.
Hunk #2 FAILED at 89.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/assembler.h.rej
patching file b/arch/arm/include/asm/atomic.h
Hunk #1 FAILED at 170.
Hunk #2 FAILED at 184.
Hunk #3 FAILED at 198.
Hunk #4 FAILED at 211.
4 out of 4 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/atomic.h.rej
patching file b/arch/arm/include/asm/bitops.h
Hunk #1 FAILED at 41.
Hunk #2 FAILED at 53.
Hunk #3 FAILED at 65.
Hunk #4 FAILED at 79.
Hunk #5 FAILED at 96.
Hunk #6 FAILED at 113.
6 out of 6 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/bitops.h.rej
patching file b/arch/arm/include/asm/cacheflush.h
Hunk #1 FAILED at 15.
Hunk #2 FAILED at 311.
Hunk #3 FAILED at 334.
Hunk #4 FAILED at 360.
Hunk #5 FAILED at 381.
Hunk #6 FAILED at 426.
6 out of 6 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/cacheflush.h.rej
patching file b/arch/arm/include/asm/cpu-multi32.h
Hunk #1 FAILED at 52.
Hunk #2 FAILED at 66.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/cpu-multi32.h.rej
patching file b/arch/arm/include/asm/cpu-single.h
Hunk #1 FAILED at 39.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/include/asm/cpu-single.h.rej
patching file b/arch/arm/include/asm/fcse.h
patching file b/arch/arm/include/asm/ipipe.h
patching file b/arch/arm/include/asm/ipipe_base.h
patching file b/arch/arm/include/asm/irqflags.h
Hunk #1 FAILED at 10.
Hunk #2 FAILED at 44.
Hunk #3 FAILED at 59.
Hunk #4 FAILED at 74.
Hunk #5 FAILED at 89.
Hunk #6 FAILED at 106.
Hunk #7 FAILED at 128.
7 out of 7 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/irqflags.h.rej
patching file b/arch/arm/include/asm/memory.h
Hunk #1 FAILED at 33.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/include/asm/memory.h.rej
patching file b/arch/arm/include/asm/mmu.h
Hunk #1 FAILED at 7.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/include/asm/mmu.h.rej
patching file b/arch/arm/include/asm/mmu_context.h
Hunk #1 FAILED at 19.
Hunk #2 FAILED at 66.
Hunk #3 FAILED at 93.
Hunk #4 FAILED at 106.
4 out of 4 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/mmu_context.h.rej
patching file b/arch/arm/include/asm/pgtable.h
Hunk #1 FAILED at 112.
Hunk #2 FAILED at 250.
Hunk #3 FAILED at 261.
Hunk #4 FAILED at 271.
Hunk #5 FAILED at 355.
5 out of 5 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/pgtable.h.rej
patching file b/arch/arm/include/asm/proc-fns.h
Hunk #1 FAILED at 239.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/include/asm/proc-fns.h.rej
patching file b/arch/arm/include/asm/processor.h
Hunk #1 FAILED at 23.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/include/asm/processor.h.rej
patching file b/arch/arm/include/asm/resource.h
Hunk #1 FAILED at 1.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/include/asm/resource.h.rej
patching file b/arch/arm/include/asm/system.h
Hunk #1 FAILED at 213.
Hunk #2 FAILED at 277.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/system.h.rej
patching file b/arch/arm/include/asm/thread_info.h
Hunk #1 FAILED at 140.
Hunk #2 FAILED at 147.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/thread_info.h.rej
patching file b/arch/arm/include/asm/tlbflush.h
Hunk #1 FAILED at 210.
Hunk #2 FAILED at 383.
Hunk #3 FAILED at 504.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/include/asm/tlbflush.h.rej
patching file b/arch/arm/kernel/Makefile
Hunk #1 FAILED at 48.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/kernel/Makefile.rej
patching file b/arch/arm/kernel/entry-armv.S
Hunk #1 FAILED at 4.
Hunk #2 FAILED at 28.
Hunk #3 FAILED at 44.
Hunk #4 FAILED at 74.
Hunk #5 FAILED at 180.
Hunk #6 FAILED at 211.
Hunk #7 FAILED at 240.
Hunk #8 FAILED at 258.
Hunk #9 FAILED at 421.
Hunk #10 FAILED at 442.
Hunk #11 FAILED at 565.
Hunk #12 FAILED at 607.
Hunk #13 FAILED at 643.
Hunk #14 FAILED at 694.
Hunk #15 FAILED at 735.
Hunk #16 FAILED at 773.
Hunk #17 FAILED at 814.
Hunk #18 FAILED at 984.
18 out of 18 hunks FAILED -- saving rejects to file
b/arch/arm/kernel/entry-armv.S.rej
patching file b/arch/arm/kernel/entry-common.S
Hunk #1 FAILED at 2.
Hunk #2 FAILED at 22.
Hunk #3 FAILED at 30.
Hunk #4 FAILED at 41.
Hunk #5 FAILED at 53.
Hunk #6 FAILED at 70.
Hunk #7 FAILED at 268.
Hunk #8 FAILED at 315.
Hunk #9 FAILED at 485.
9 out of 9 hunks FAILED -- saving rejects to file
b/arch/arm/kernel/entry-common.S.rej
patching file b/arch/arm/kernel/entry-header.S
Hunk #1 FAILED at 49.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/kernel/entry-header.S.rej
patching file b/arch/arm/kernel/fcse.c
patching file b/arch/arm/kernel/ipipe.c
patching file b/arch/arm/kernel/irq.c
Hunk #1 FAILED at 121.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/kernel/irq.c.rej
patching file b/arch/arm/kernel/process.c
Hunk #1 FAILED at 127.
Hunk #2 FAILED at 148.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/kernel/process.c.rej
patching file b/arch/arm/kernel/ptrace.c
Hunk #1 FAILED at 479.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/kernel/ptrace.c.rej
patching file b/arch/arm/kernel/smp.c
Hunk #1 FAILED at 36.
Hunk #2 FAILED at 643.
Hunk #3 FAILED at 654.
Hunk #4 FAILED at 677.
4 out of 4 hunks FAILED -- saving rejects to file
b/arch/arm/kernel/smp.c.rej
patching file b/arch/arm/kernel/traps.c
Hunk #1 FAILED at 325.
Hunk #2 FAILED at 719.
Hunk #3 FAILED at 734.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/kernel/traps.c.rej
patching file b/arch/arm/mach-at91/Kconfig
Hunk #1 FAILED at 311.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-at91/Kconfig.rej
patching file b/arch/arm/mach-at91/Makefile
Hunk #1 FAILED at 71.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-at91/Makefile.rej
patching file b/arch/arm/mach-at91/at91_ipipe_time.c
patching file b/arch/arm/mach-at91/at91rm9200.c
Hunk #1 FAILED at 33.
Hunk #2 FAILED at 300.
Hunk #3 FAILED at 332.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mach-at91/at91rm9200.c.rej
patching file b/arch/arm/mach-at91/at91sam9260.c
Hunk #1 FAILED at 31.
Hunk #2 FAILED at 350.
Hunk #3 FAILED at 382.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mach-at91/at91sam9260.c.rej
patching file b/arch/arm/mach-at91/at91sam9261.c
Hunk #1 FAILED at 30.
Hunk #2 FAILED at 286.
Hunk #3 FAILED at 318.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mach-at91/at91sam9261.c.rej
patching file b/arch/arm/mach-at91/at91sam9263.c
Hunk #1 FAILED at 30.
Hunk #2 FAILED at 311.
Hunk #3 FAILED at 343.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mach-at91/at91sam9263.c.rej
patching file b/arch/arm/mach-at91/at91sam9rl.c
Hunk #1 FAILED at 30.
Hunk #2 FAILED at 303.
Hunk #3 FAILED at 335.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mach-at91/at91sam9rl.c.rej
patching file b/arch/arm/mach-at91/gpio.c
Hunk #1 FAILED at 25.
Hunk #2 FAILED at 377.
Hunk #3 FAILED at 424.
Hunk #4 FAILED at 435.
Hunk #5 FAILED at 511.
Hunk #6 FAILED at 540.
6 out of 6 hunks FAILED -- saving rejects to file
b/arch/arm/mach-at91/gpio.c.rej
patching file b/arch/arm/mach-at91/include/mach/hardware.h
Hunk #1 FAILED at 61.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-at91/include/mach/hardware.h.rej
patching file b/arch/arm/mach-at91/include/mach/irqs.h
Hunk #1 FAILED at 45.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-at91/include/mach/irqs.h.rej
patching file b/arch/arm/mach-at91/include/mach/timex.h
Hunk #1 FAILED at 72.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-at91/include/mach/timex.h.rej
patching file b/arch/arm/mach-at91/irq.c
Hunk #1 FAILED at 121.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-at91/irq.c.rej
patching file b/arch/arm/mach-integrator/core.c
Hunk #1 FAILED at 2.
Hunk #2 FAILED at 230.
Hunk #3 FAILED at 285.
Hunk #4 FAILED at 301.
Hunk #5 FAILED at 326.
5 out of 5 hunks FAILED -- saving rejects to file
b/arch/arm/mach-integrator/core.c.rej
patching file b/arch/arm/mach-integrator/include/mach/entry-macro.S
Hunk #1 FAILED at 28.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-integrator/include/mach/entry-macro.S.rej
patching file b/arch/arm/mach-integrator/include/mach/irqs.h
Hunk #1 FAILED at 79.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-integrator/include/mach/irqs.h.rej
patching file b/arch/arm/mach-integrator/include/mach/platform.h
Hunk #1 FAILED at 417.
Hunk #2 FAILED at 430.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mach-integrator/include/mach/platform.h.rej
patching file b/arch/arm/mach-integrator/include/mach/timex.h
Hunk #1 FAILED at 21.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-integrator/include/mach/timex.h.rej
patching file b/arch/arm/mach-integrator/integrator_cp.c
Hunk #1 FAILED at 2.
Hunk #2 FAILED at 20.
Hunk #3 FAILED at 161.
Hunk #4 FAILED at 180.
Hunk #5 FAILED at 199.
Hunk #6 FAILED at 218.
Hunk #7 FAILED at 569.
7 out of 7 hunks FAILED -- saving rejects to file
b/arch/arm/mach-integrator/integrator_cp.c.rej
patching file b/arch/arm/mach-ixp4xx/common.c
Hunk #1 FAILED at 45.
Hunk #2 FAILED at 269.
Hunk #3 FAILED at 294.
Hunk #4 FAILED at 470.
Hunk #5 FAILED at 492.
5 out of 5 hunks FAILED -- saving rejects to file
b/arch/arm/mach-ixp4xx/common.c.rej
patching file b/arch/arm/mach-mx3/devices.c
Hunk #1 FAILED at 22.
Hunk #2 FAILED at 432.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mach-mx3/devices.c.rej
patching file b/arch/arm/mach-mx3/mx31ads.c
Hunk #1 FAILED at 134.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-mx3/mx31ads.c.rej
patching file b/arch/arm/mach-mx3/mx31pdk.c
Hunk #1 FAILED at 23.
Hunk #2 FAILED at 108.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mach-mx3/mx31pdk.c.rej
patching file b/arch/arm/mach-omap2/irq.c
Hunk #1 FAILED at 25.
Hunk #2 FAILED at 132.
Hunk #3 FAILED at 151.
Hunk #4 FAILED at 200.
4 out of 4 hunks FAILED -- saving rejects to file
b/arch/arm/mach-omap2/irq.c.rej
patching file b/arch/arm/mach-omap2/timer-gp.c
Hunk #1 FAILED at 47.
Hunk #2 FAILED at 125.
Hunk #3 FAILED at 156.
Hunk #4 FAILED at 166.
Hunk #5 FAILED at 185.
Hunk #6 FAILED at 223.
Hunk #7 FAILED at 242.
7 out of 7 hunks FAILED -- saving rejects to file
b/arch/arm/mach-omap2/timer-gp.c.rej
patching file b/arch/arm/mach-pxa/irq.c
Hunk #1 FAILED at 49.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-pxa/irq.c.rej
patching file b/arch/arm/mach-pxa/leds-idp.c
Hunk #1 FAILED at 13.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-pxa/leds-idp.c.rej
patching file b/arch/arm/mach-pxa/leds-lubbock.c
Hunk #1 FAILED at 12.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-pxa/leds-lubbock.c.rej
patching file b/arch/arm/mach-pxa/leds-mainstone.c
Hunk #1 FAILED at 11.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-pxa/leds-mainstone.c.rej
patching file b/arch/arm/mach-pxa/lpd270.c
Hunk #1 FAILED at 24.
Hunk #2 FAILED at 124.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mach-pxa/lpd270.c.rej
patching file b/arch/arm/mach-pxa/lubbock.c
Hunk #1 FAILED at 22.
Hunk #2 FAILED at 161.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mach-pxa/lubbock.c.rej
patching file b/arch/arm/mach-pxa/mainstone.c
Hunk #1 FAILED at 27.
Hunk #2 FAILED at 165.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mach-pxa/mainstone.c.rej
patching file b/arch/arm/mach-pxa/pcm990-baseboard.c
Hunk #1 FAILED at 24.
Hunk #2 FAILED at 263.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mach-pxa/pcm990-baseboard.c.rej
patching file b/arch/arm/mach-pxa/time.c
Hunk #1 FAILED at 24.
Hunk #2 FAILED at 66.
Hunk #3 FAILED at 79.
Hunk #4 FAILED at 125.
Hunk #5 FAILED at 168.
Hunk #6 FAILED at 213.
6 out of 6 hunks FAILED -- saving rejects to file
b/arch/arm/mach-pxa/time.c.rej
patching file b/arch/arm/mach-pxa/viper.c
Hunk #1 FAILED at 41.
Hunk #2 FAILED at 270.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mach-pxa/viper.c.rej
patching file b/arch/arm/mach-s3c2410/include/mach/irqs.h
Hunk #1 FAILED at 3.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-s3c2410/include/mach/irqs.h.rej
patching file b/arch/arm/mach-s3c2440/irq.c
Hunk #1 FAILED at 3.
Hunk #2 FAILED at 25.
Hunk #3 FAILED at 57.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mach-s3c2440/irq.c.rej
patching file b/arch/arm/mach-sa1100/irq.c
Hunk #1 FAILED at 15.
Hunk #2 FAILED at 125.
Hunk #3 FAILED at 217.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mach-sa1100/irq.c.rej
patching file b/arch/arm/mach-sa1100/leds-assabet.c
Hunk #1 FAILED at 10.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-sa1100/leds-assabet.c.rej
patching file b/arch/arm/mach-sa1100/leds-badge4.c
Hunk #1 FAILED at 11.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-sa1100/leds-badge4.c.rej
patching file b/arch/arm/mach-sa1100/leds-cerf.c
Hunk #1 FAILED at 4.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-sa1100/leds-cerf.c.rej
patching file b/arch/arm/mach-sa1100/leds-hackkit.c
Hunk #1 FAILED at 10.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-sa1100/leds-hackkit.c.rej
patching file b/arch/arm/mach-sa1100/leds-lart.c
Hunk #1 FAILED at 10.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-sa1100/leds-lart.c.rej
patching file b/arch/arm/mach-sa1100/leds-simpad.c
Hunk #1 FAILED at 4.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mach-sa1100/leds-simpad.c.rej
patching file b/arch/arm/mach-sa1100/time.c
Hunk #1 FAILED at 20.
Hunk #2 FAILED at 77.
Hunk #3 FAILED at 116.
Hunk #4 FAILED at 156.
4 out of 4 hunks FAILED -- saving rejects to file
b/arch/arm/mach-sa1100/time.c.rej
patching file b/arch/arm/mm/Kconfig
Hunk #1 FAILED at 771.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mm/Kconfig.rej
patching file b/arch/arm/mm/alignment.c
Hunk #1 FAILED at 713.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mm/alignment.c.rej
patching file b/arch/arm/mm/context.c
Hunk #1 FAILED at 14.
Hunk #2 FAILED at 31.
Hunk #3 FAILED at 57.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mm/context.c.rej
patching file b/arch/arm/mm/copypage-v4mc.c
Hunk #1 FAILED at 44.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mm/copypage-v4mc.c.rej
patching file b/arch/arm/mm/copypage-xscale.c
Hunk #1 FAILED at 42.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mm/copypage-xscale.c.rej
patching file b/arch/arm/mm/fault-armv.c
Hunk #1 FAILED at 25.
Hunk #2 FAILED at 94.
Hunk #3 FAILED at 125.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/mm/fault-armv.c.rej
patching file b/arch/arm/mm/fault.c
Hunk #1 FAILED at 57.
Hunk #2 FAILED at 141.
Hunk #3 FAILED at 251.
Hunk #4 FAILED at 351.
Hunk #5 FAILED at 386.
Hunk #6 FAILED at 396.
Hunk #7 FAILED at 471.
Hunk #8 FAILED at 487.
8 out of 8 hunks FAILED -- saving rejects to file
b/arch/arm/mm/fault.c.rej
patching file b/arch/arm/mm/flush.c
Hunk #1 FAILED at 50.
Hunk #2 FAILED at 73.
Hunk #3 FAILED at 97.
Hunk #4 FAILED at 113.
4 out of 4 hunks FAILED -- saving rejects to file
b/arch/arm/mm/flush.c.rej
patching file b/arch/arm/mm/ioremap.c
Hunk #1 FAILED at 316.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mm/ioremap.c.rej
patching file b/arch/arm/mm/mmap.c
Hunk #1 FAILED at 29.
Hunk #2 FAILED at 56.
Hunk #3 FAILED at 71.
Hunk #4 FAILED at 105.
4 out of 4 hunks FAILED -- saving rejects to file
b/arch/arm/mm/mmap.c.rej
patching file b/arch/arm/mm/pgd.c
Hunk #1 FAILED at 18.
Hunk #2 FAILED at 26.
Hunk #3 FAILED at 37.
Hunk #4 FAILED at 74.
Hunk #5 FAILED at 81.
Hunk #6 FAILED at 95.
6 out of 6 hunks FAILED -- saving rejects to file
b/arch/arm/mm/pgd.c.rej
patching file b/arch/arm/mm/proc-arm920.S
Hunk #1 FAILED at 321.
Hunk #2 FAILED at 338.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mm/proc-arm920.S.rej
patching file b/arch/arm/mm/proc-arm926.S
Hunk #1 FAILED at 337.
Hunk #2 FAILED at 346.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mm/proc-arm926.S.rej
patching file b/arch/arm/mm/proc-feroceon.S
Hunk #1 FAILED at 421.
Hunk #2 FAILED at 428.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/mm/proc-feroceon.S.rej
patching file b/arch/arm/mm/proc-xscale.S
Hunk #1 FAILED at 415.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/mm/proc-xscale.S.rej
patching file b/arch/arm/plat-mxc/cpu.c
Hunk #1 FAILED at 1.
Hunk #2 FAILED at 9.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/plat-mxc/cpu.c.rej
patching file b/arch/arm/plat-mxc/gpio.c
Hunk #1 FAILED at 25.
Hunk #2 FAILED at 157.
Hunk #3 FAILED at 174.
Hunk #4 FAILED at 195.
Hunk #5 FAILED at 269.
5 out of 5 hunks FAILED -- saving rejects to file
b/arch/arm/plat-mxc/gpio.c.rej
patching file b/arch/arm/plat-mxc/include/mach/common.h
Hunk #1 FAILED at 30.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/plat-mxc/include/mach/common.h.rej
patching file b/arch/arm/plat-mxc/time.c
Hunk #1 FAILED at 57.
Hunk #2 FAILED at 120.
Hunk #3 FAILED at 238.
Hunk #4 FAILED at 326.
4 out of 4 hunks FAILED -- saving rejects to file
b/arch/arm/plat-mxc/time.c.rej
patching file b/arch/arm/plat-omap/Kconfig
Hunk #1 FAILED at 131.
Hunk #2 FAILED at 140.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/plat-omap/Kconfig.rej
patching file b/arch/arm/plat-omap/dmtimer.c
Hunk #1 FAILED at 475.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/plat-omap/dmtimer.c.rej
patching file b/arch/arm/plat-omap/gpio.c
Hunk #1 FAILED at 20.
Hunk #2 FAILED at 1200.
2 out of 2 hunks FAILED -- saving rejects to file
b/arch/arm/plat-omap/gpio.c.rej
patching file b/arch/arm/plat-omap/include/mach/dmtimer.h
Hunk #1 FAILED at 56.
1 out of 1 hunk FAILED -- saving rejects to file
b/arch/arm/plat-omap/include/mach/dmtimer.h.rej
patching file b/arch/arm/plat-pxa/gpio.c
Hunk #1 FAILED at 17.
Hunk #2 FAILED at 220.
Hunk #3 FAILED at 285.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/plat-pxa/gpio.c.rej
patching file b/arch/arm/plat-s3c/time.c
Hunk #1 FAILED at 3.
Hunk #2 FAILED at 27.
Hunk #3 FAILED at 42.
Hunk #4 FAILED at 61.
Hunk #5 FAILED at 91.
Hunk #6 FAILED at 132.
Hunk #7 FAILED at 153.
Hunk #8 FAILED at 164.
Hunk #9 FAILED at 175.
Hunk #10 FAILED at 210.
Hunk #11 FAILED at 226.
Hunk #12 FAILED at 283.
12 out of 12 hunks FAILED -- saving rejects to file
b/arch/arm/plat-s3c/time.c.rej
patching file b/arch/arm/plat-s3c24xx/irq.c
Hunk #1 FAILED at 3.
Hunk #2 FAILED at 23.
Hunk #3 FAILED at 87.
Hunk #4 FAILED at 283.
Hunk #5 FAILED at 310.
Hunk #6 FAILED at 337.
Hunk #7 FAILED at 385.
Hunk #8 FAILED at 413.
Hunk #9 FAILED at 466.
Hunk #10 FAILED at 489.
10 out of 10 hunks FAILED -- saving rejects to file
b/arch/arm/plat-s3c24xx/irq.c.rej
patching file b/arch/arm/plat-s3c24xx/s3c244x-irq.c
Hunk #1 FAILED at 3.
Hunk #2 FAILED at 57.
Hunk #3 FAILED at 89.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/plat-s3c24xx/s3c244x-irq.c.rej
patching file b/arch/arm/vfp/entry.S
Hunk #1 FAILED at 25.
Hunk #2 FAILED at 33.
Hunk #3 FAILED at 50.
3 out of 3 hunks FAILED -- saving rejects to file
b/arch/arm/vfp/entry.S.rej
patching file b/arch/arm/vfp/vfphw.S
Hunk #1 FAILED at 19.
Hunk #2 FAILED at 31.
Hunk #3 FAILED at 44.
Hunk #4 FAILED at 87.
Hunk #5 FAILED at 139.
Hunk #6 FAILED at 164.
6 out of 6 hunks FAILED -- saving rejects to file
b/arch/arm/vfp/vfphw.S.rej
patching file b/arch/arm/vfp/vfpmodule.c
Hunk #1 FAILED at 42.
Hunk #2 FAILED at 71.
Hunk #3 FAILED at 87.
Hunk #4 FAILED at 219.
Hunk #5 FAILED at 249.
Hunk #6 FAILED at 261.
Hunk #7 FAILED at 301.
7 out of 7 hunks FAILED -- saving rejects to file
b/arch/arm/vfp/vfpmodule.c.rej
patching file b/drivers/i2c/busses/i2c-omap.c
Hunk #1 FAILED at 449.
Hunk #2 FAILED at 492.
Hunk #3 FAILED at 503.
3 out of 3 hunks FAILED -- saving rejects to file
b/drivers/i2c/busses/i2c-omap.c.rej
patching file b/drivers/misc/Kconfig
Hunk #1 FAILED at 32.
1 out of 1 hunk FAILED -- saving rejects to file
b/drivers/misc/Kconfig.rej
patching file b/drivers/pci/htirq.c
Hunk #1 FAILED at 21.
1 out of 1 hunk FAILED -- saving rejects to file
b/drivers/pci/htirq.c.rej
patching file b/drivers/serial/8250.c
Hunk #1 FAILED at 3010.
1 out of 1 hunk FAILED -- saving rejects to file
b/drivers/serial/8250.c.rej
patching file b/fs/aio.c
Hunk #1 FAILED at 608.
1 out of 1 hunk FAILED -- saving rejects to file b/fs/aio.c.rej
patching file b/fs/exec.c
Hunk #1 FAILED at 699.
Hunk #2 FAILED at 721.
2 out of 2 hunks FAILED -- saving rejects to file b/fs/exec.c.rej
patching file b/include/asm-generic/atomic.h
Hunk #1 FAILED at 60.
Hunk #2 FAILED at 82.
Hunk #3 FAILED at 139.
3 out of 3 hunks FAILED -- saving rejects to file
b/include/asm-generic/atomic.h.rej
patching file b/include/asm-generic/bitops/atomic.h
Hunk #1 FAILED at 21.
1 out of 1 hunk FAILED -- saving rejects to file
b/include/asm-generic/bitops/atomic.h.rej
patching file b/include/asm-generic/cmpxchg-local.h
Hunk #1 FAILED at 20.
Hunk #2 FAILED at 41.
Hunk #3 FAILED at 54.
3 out of 3 hunks FAILED -- saving rejects to file
b/include/asm-generic/cmpxchg-local.h.rej
patching file b/include/asm-generic/percpu.h
Hunk #1 FAILED at 56.
Hunk #2 FAILED at 66.
2 out of 2 hunks FAILED -- saving rejects to file
b/include/asm-generic/percpu.h.rej
patching file b/include/asm-generic/resource.h
Hunk #1 FAILED at 58.
1 out of 1 hunk FAILED -- saving rejects to file
b/include/asm-generic/resource.h.rej
patching file b/include/linux/hardirq.h
Hunk #1 FAILED at 177.
1 out of 1 hunk FAILED -- saving rejects to file
b/include/linux/hardirq.h.rej
patching file b/include/linux/ipipe.h
patching file b/include/linux/ipipe_base.h
patching file b/include/linux/ipipe_compat.h
patching file b/include/linux/ipipe_percpu.h
patching file b/include/linux/ipipe_tickdev.h
patching file b/include/linux/ipipe_trace.h
patching file b/include/linux/irq.h
Hunk #1 FAILED at 119.
Hunk #2 FAILED at 165.
Hunk #3 FAILED at 345.
Hunk #4 FAILED at 359.
4 out of 4 hunks FAILED -- saving rejects to file
b/include/linux/irq.h.rej
patching file b/include/linux/kernel.h
Hunk #1 FAILED at 14.
Hunk #2 FAILED at 119.
2 out of 2 hunks FAILED -- saving rejects to file
b/include/linux/kernel.h.rej
patching file b/include/linux/lockdep.h
Hunk #1 FAILED at 379.
1 out of 1 hunk FAILED -- saving rejects to file
b/include/linux/lockdep.h.rej
patching file b/include/linux/mm.h
Hunk #1 FAILED at 104.
1 out of 1 hunk FAILED -- saving rejects to file
b/include/linux/mm.h.rej
patching file b/include/linux/preempt.h
Hunk #1 FAILED at 9.
1 out of 1 hunk FAILED -- saving rejects to file
b/include/linux/preempt.h.rej
patching file b/include/linux/resource.h
Hunk #1 FAILED at 53.
1 out of 1 hunk FAILED -- saving rejects to file
b/include/linux/resource.h.rej
patching file b/include/linux/sched.h
Hunk #1 FAILED at 59.
Hunk #2 FAILED at 188.
Hunk #3 FAILED at 295.
Hunk #4 FAILED at 342.
Hunk #5 FAILED at 1435.
Hunk #6 FAILED at 1674.
6 out of 6 hunks FAILED -- saving rejects to file
b/include/linux/sched.h.rej
patching file b/include/linux/spinlock.h
Hunk #1 FAILED at 90.
Hunk #2 FAILED at 101.
Hunk #3 FAILED at 195.
Hunk #4 FAILED at 217.
Hunk #5 FAILED at 234.
Hunk #6 FAILED at 249.
Hunk #7 FAILED at 266.
Hunk #8 FAILED at 280.
Hunk #9 FAILED at 316.
Hunk #10 FAILED at 380.
10 out of 10 hunks FAILED -- saving rejects to file
b/include/linux/spinlock.h.rej
patching file b/include/linux/spinlock_types.h
Hunk #1 FAILED at 31.
Hunk #2 FAILED at 92.
2 out of 2 hunks FAILED -- saving rejects to file
b/include/linux/spinlock_types.h.rej
patching file b/init/Kconfig
Hunk #1 FAILED at 78.
1 out of 1 hunk FAILED -- saving rejects to file b/init/Kconfig.rej
patching file b/init/main.c
Hunk #1 FAILED at 568.
Hunk #2 FAILED at 632.
Hunk #3 FAILED at 811.
3 out of 3 hunks FAILED -- saving rejects to file b/init/main.c.rej
patching file b/kernel/Makefile
Hunk #1 FAILED at 86.
1 out of 1 hunk FAILED -- saving rejects to file b/kernel/Makefile.rej
patching file b/kernel/exit.c
Hunk #1 FAILED at 959.
1 out of 1 hunk FAILED -- saving rejects to file b/kernel/exit.c.rej
patching file b/kernel/fork.c
Hunk #1 FAILED at 487.
Hunk #2 FAILED at 878.
Hunk #3 FAILED at 1257.
Hunk #4 FAILED at 1658.
4 out of 4 hunks FAILED -- saving rejects to file b/kernel/fork.c.rej
patching file b/kernel/ipipe/Kconfig
patching file b/kernel/ipipe/Kconfig.debug
patching file b/kernel/ipipe/Makefile
patching file b/kernel/ipipe/core.c
patching file b/kernel/ipipe/tracer.c
patching file b/kernel/irq/chip.c
Hunk #1 FAILED at 358.
Hunk #2 FAILED at 435.
Hunk #3 FAILED at 478.
Hunk #4 FAILED at 519.
Hunk #5 FAILED at 533.
Hunk #6 FAILED at 545.
Hunk #7 FAILED at 570.
Hunk #8 FAILED at 580.
Hunk #9 FAILED at 590.
9 out of 9 hunks FAILED -- saving rejects to file
b/kernel/irq/chip.c.rej
patching file b/kernel/irq/handle.c
Hunk #1 FAILED at 458.
Hunk #2 FAILED at 470.
2 out of 2 hunks FAILED -- saving rejects to file
b/kernel/irq/handle.c.rej
patching file b/kernel/lockdep.c
Hunk #1 FAILED at 2135.
Hunk #2 FAILED at 2178.
2 out of 2 hunks FAILED -- saving rejects to file b/kernel/lockdep.c.rej
patching file b/kernel/panic.c
Hunk #1 FAILED at 22.
Hunk #2 FAILED at 303.
2 out of 2 hunks FAILED -- saving rejects to file b/kernel/panic.c.rej
patching file b/kernel/power/hibernate.c
Hunk #1 FAILED at 238.
Hunk #2 FAILED at 267.
Hunk #3 FAILED at 355.
Hunk #4 FAILED at 386.
Hunk #5 FAILED at 467.
5 out of 5 hunks FAILED -- saving rejects to file
b/kernel/power/hibernate.c.rej
patching file b/kernel/printk.c
Hunk #1 FAILED at 551.
Hunk #2 FAILED at 575.
Hunk #3 FAILED at 584.
3 out of 3 hunks FAILED -- saving rejects to file b/kernel/printk.c.rej
patching file b/kernel/sched.c
Hunk #1 FAILED at 2442.
Hunk #2 FAILED at 2854.
Hunk #3 FAILED at 2902.
Hunk #4 FAILED at 5168.
Hunk #5 FAILED at 5190.
Hunk #6 FAILED at 5238.
Hunk #7 FAILED at 5314.
Hunk #8 FAILED at 5328.
Hunk #9 FAILED at 5368.
Hunk #10 FAILED at 5384.
Hunk #11 FAILED at 6222.
Hunk #12 FAILED at 6574.
Hunk #13 FAILED at 10581.
13 out of 13 hunks FAILED -- saving rejects to file b/kernel/sched.c.rej
patching file b/kernel/signal.c
Hunk #1 FAILED at 518.
1 out of 1 hunk FAILED -- saving rejects to file b/kernel/signal.c.rej
patching file b/kernel/spinlock.c
Hunk #1 FAILED at 87.
1 out of 1 hunk FAILED -- saving rejects to file b/kernel/spinlock.c.rej
patching file b/kernel/time/tick-common.c
Hunk #1 FAILED at 69.
Hunk #2 FAILED at 177.
2 out of 2 hunks FAILED -- saving rejects to file
b/kernel/time/tick-common.c.rej
patching file b/kernel/time/tick-sched.c
Hunk #1 FAILED at 520.
Hunk #2 FAILED at 671.
2 out of 2 hunks FAILED -- saving rejects to file
b/kernel/time/tick-sched.c.rej
patching file b/kernel/timer.c
Hunk #1 FAILED at 1163.
1 out of 1 hunk FAILED -- saving rejects to file b/kernel/timer.c.rej
patching file b/kernel/trace/Kconfig
Hunk #1 FAILED at 415.
1 out of 1 hunk FAILED -- saving rejects to file
b/kernel/trace/Kconfig.rej
patching file b/kernel/trace/ftrace.c
Hunk #1 FAILED at 28.
Hunk #2 FAILED at 1179.
Hunk #3 FAILED at 1186.
Hunk #4 FAILED at 2793.
Hunk #5 FAILED at 2878.
5 out of 5 hunks FAILED -- saving rejects to file
b/kernel/trace/ftrace.c.rej
patching file b/lib/Kconfig.debug
Hunk #1 FAILED at 128.
1 out of 1 hunk FAILED -- saving rejects to file b/lib/Kconfig.debug.rej
patching file b/lib/bust_spinlocks.c
Hunk #1 FAILED at 13.
Hunk #2 FAILED at 24.
2 out of 2 hunks FAILED -- saving rejects to file
b/lib/bust_spinlocks.c.rej
patching file b/lib/ioremap.c
Hunk #1 FAILED at 85.
1 out of 1 hunk FAILED -- saving rejects to file b/lib/ioremap.c.rej
patching file b/lib/smp_processor_id.c
Hunk #1 FAILED at 12.
1 out of 1 hunk FAILED -- saving rejects to file
b/lib/smp_processor_id.c.rej
patching file b/lib/spinlock_debug.c
Hunk #1 FAILED at 133.
Hunk #2 FAILED at 148.
Hunk #3 FAILED at 199.
Hunk #4 FAILED at 212.
Hunk #5 FAILED at 275.
Hunk #6 FAILED at 290.
6 out of 6 hunks FAILED -- saving rejects to file
b/lib/spinlock_debug.c.rej
patching file b/mm/memory.c
Hunk #1 FAILED at 55.
Hunk #2 FAILED at 533.
Hunk #3 FAILED at 541.
Hunk #4 FAILED at 581.
Hunk #5 FAILED at 611.
Hunk #6 FAILED at 638.
Hunk #7 FAILED at 1900.
Hunk #8 FAILED at 3350.
8 out of 8 hunks FAILED -- saving rejects to file b/mm/memory.c.rej
patching file b/mm/mlock.c
Hunk #1 FAILED at 511.
1 out of 1 hunk FAILED -- saving rejects to file b/mm/mlock.c.rej
patching file b/mm/vmalloc.c
Hunk #1 FAILED at 173.
1 out of 1 hunk FAILED -- saving rejects to file b/mm/vmalloc.c.rej

What is the procedure that I am doing wrong?

Best regards,

Flavio


On Tue, 2010-07-27 at 09:27 +0200, Gilles Chanteperdrix wrote:
> Flavio Alves wrote:
> > Hello,
> > 
> > I finally could get the linux-imx from the Freescale's git site.
> > 
> > As you mentioned in the readme, when the patch is applied to the kernel,
> > I found errors during the patch.
> 
> There should not be errors, there should be only one reject.
> 
>  But, it was found errors on the patch,
> > the remaining operations of the scripts/prepare-kernel.sh script are
> > stopped.
> > 
> > Should I continue anyway? Does this patch execution problem does not
> > cause any other problem during the kernel build?
> 
> You have to apply the patch by hand, then run the prepare-kernel.sh script.
> 



