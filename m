Message-ID: <4F0F2A00.4040508@domain.hid>
Date: Thu, 12 Jan 2012 19:44:16 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F0F1E23.5060400@domain.hid>
In-Reply-To: <4F0F1E23.5060400@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Omap3630, rtserial, xeno_16550A: crash on insmod
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Manfred <manfred@domain.hid>
Cc: xenomai@xenomai.org

On 01/12/2012 06:53 PM, Manfred wrote:
> Dear Xenomai-Developers/Users,
> 
> I am trying to get xenomai running on an omap3630 device (gumstix overo).
> xenomai 2.6.0/kernel: linux-omap3-2.6.38 / i-pipe patch 2.6.38.8-arm-1.18.04
> 
> I would like to use the UART devices in a RT-application,
>   and I was following the following guidelines:
> http://www.xenomai.org/index.php/16550A
> 
> I had to do some changes to Kconfig in arch/arm/mach-omap2:Kconfig,
> so that the omap_serial driver would not be compiled-in and so that
>   I could actually disable the driver with setserial
> (and correspondingly had to make some changes here and there because the
>   devices are now called /dev/ttySx and not /dev/ttyOx, as in the 
> omap_serial driver...)
> 
> dmesg then reports:
> serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
> serial8250.1: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654
> serial8250.2: ttyS2 at MMIO 0x49020000 (irq = 74) is a ST16654
> serial8250.3: ttyS3 at MMIO 0x49042000 (irq = 80) is a ST16654
> 
> Anyway, finally I was able to the following:
>  >setserial /dev/ttyS0 uart none
>  >modprobe xeno_16550A mem=0x4806a000 irq=72 baud_base=3000000
> 
> (parameters same as here:
> http://www.mail-archive.com/xenomai@xenomai.org
> )
> 
> And then I immediately get the following Error:
> 
> -------------------- 
> Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa06a002

The address is not aligned on a 4 bytes boundary, and clearly in the
ioremap/vmalloc range, so, disassemble the module code and check what
happens at bf0f0170 (you have to add the module load address as from
/proc/modules to the addresses obtained when disassembling the .ko
file), if you see an "ldrh" there, then something went wrong with the
mapping of hardware registers. If you see an "ldr", then you get an
unaligned access.

> pc : [<bf0f0170>]    lr : [<bf0f011c>]    psr: 60000013


-- 
					    Gilles.

