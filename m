Message-ID: <4F0F2C08.3000208@domain.hid>
Date: Thu, 12 Jan 2012 19:52:56 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4F0F1E23.5060400@domain.hid>
In-Reply-To: <4F0F1E23.5060400@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
> xenomai 2.6.0/kernel: linux-omap3-2.6.38 / i-pipe patch
> 2.6.38.8-arm-1.18.04
> 
> I would like to use the UART devices in a RT-application,
>  and I was following the following guidelines:
> http://www.xenomai.org/index.php/16550A
> 
> I had to do some changes to Kconfig in arch/arm/mach-omap2:Kconfig,
> so that the omap_serial driver would not be compiled-in and so that
>  I could actually disable the driver with setserial
> (and correspondingly had to make some changes here and there because the
>  devices are now called /dev/ttySx and not /dev/ttyOx, as in the
> omap_serial driver...)

I wonder why that's all necessary. On x86, just just do "setserial
/dev/ttyS0 uart none" before loading 16550A. Why is the name a problem?

> dmesg then reports:
> serial8250.0: ttyS0 at MMIO 0x4806a000 (irq = 72) is a ST16654
> serial8250.1: ttyS1 at MMIO 0x4806c000 (irq = 73) is a ST16654
> serial8250.2: ttyS2 at MMIO 0x49020000 (irq = 74) is a ST16654
> serial8250.3: ttyS3 at MMIO 0x49042000 (irq = 80) is a ST16654
> 
> Anyway, finally I was able to the following:
>>setserial /dev/ttyS0 uart none
>>modprobe xeno_16550A mem=0x4806a000 irq=72 baud_base=3000000
> 
> (parameters same as here:
> http://www.mail-archive.com/xenomai@xenomai.org
> )
> 
> And then I immediately get the following Error:
> 
> --------------------
> Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa06a002
> Internal error: : 1028 [#1]

Hm, address might be unaligned. Maybe you need a regshift=2... and some
other quirks as well.

Wolfgang.



