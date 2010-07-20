Message-ID: <4C454DA2.4080302@domain.hid>
Date: Tue, 20 Jul 2010 09:17:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C43C83F.5030401@domain.hid> <4C43D265.9080609@domain.hid>
	<4C43FC4F.3010006@domain.hid> <4C440D6F.1060204@domain.hid>
	<4C454D18.1030207@domain.hid>
In-Reply-To: <4C454D18.1030207@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Adeos patched kernel hangs mounting root file
 system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bob Feretich <bob.feretich@domain.hid>
Cc: xenomai@xenomai.org

Bob Feretich wrote:
>   On the BeagleBoard...
> 
>     * The SD card/MMC is attached to the OMAP3530 chip MMC1 hardware
>       Port. (The chip has 3 SD/MMC ports, numbered 1, 2, and 3.) The
>       BeagleBoard connects the MMC2 port to an expansion connector and
>       its not used in my application. The BeagleBoard does not use MMC3
>       (not connected to anything).
>     * The MMC1 hardware port is the first mmc port and is referred to in
>       the kernel mmc0.
>     * The OMAP controller for this port interrupts on IRQ 83.
>     * The OMAP controller also uses SDMA channels 60 and 61 which
>       results in other IRQs from the DMA controller.
>     * The Card Detect signal from the SD card/MMC interface is wired to
>       a TPS65950 chip
>     * This TPS65950 chip presents the Card Detect interrupt to the
>       OMAP3530 via sys_nirq[0]. This signal is mapped to IRQ 7. The
>       TPS65950 can funnel up to 18 interrupts into sys_nirq[0].
>     * The Level 2 interrupt handler maps the Card Detect interrupt to
>       IRQ 384.  IRQ 384 is the first IRQ of the TWL4030 GPIO IRQ space.
>       Apparently the the TWL4030 interrupt mapping is used for the TPS65950.
>     * My SD card has two partitions. The first is a FAT partition
>       containing the u-boot and kernel boot image. The second is a ext3
>       partition containing the root file system.
> 
> It's possible that the kernel is expecting a Card Detect interrupt to 
> proceed with the mounting of the root file system. I noticed that the 
> /proc/interrupts listing that I mailed you showed 2 interrupts each on 
> IRQ 384 and on IRQ 7.
> Does Xenomai support TWL4030 style Level 2 interrupts?
> Could pending interrupts have gotten lost when when Adeos initializes?

Could you test 2.6.33 ?

-- 
					    Gilles.

