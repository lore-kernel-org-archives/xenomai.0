Message-ID: <4C46141F.50103@domain.hid>
Date: Tue, 20 Jul 2010 23:24:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C43C83F.5030401@domain.hid>
	<4C43D265.9080609@domain.hid>	<4C43FC4F.3010006@domain.hid>
	<4C440D6F.1060204@domain.hid>	<4C44E9C9.3020600@domain.hid>
	<4C454C0C.6000100@domain.hid>	<4C4550C8.3070504@domain.hid>
	<4C45541C.5090507@domain.hid> <4C45CEE6.5000903@domain.hid>
	<4C460506.3010103@domain.hid>
In-Reply-To: <4C460506.3010103@domain.hid>
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
>   I have downloaded the 2.6.33 omap kernel and I 'm starting to work 
> with it. I'll write again when I have a clean boot of the vanilla kernel 
> and tried to boot again with the Adeos patch.
> 
> I think that I figured out how to tell OpenEmbedded to build it.
> 
> When you display /proc/interrupts on the IGEPv2, do you see interrupts 
> occuring at IRQs greater or equal to IRQ 384?
> Do you see the same number reflected in IRQ 7?

I see this:
           CPU0
  7:     104068        INTC  TWL4030-PIH
 12:          4        INTC  DMA
 37:       1408        INTC  gp timer
 56:     313486        INTC  i2c_omap
 61:          0        INTC  i2c_omap
 74:         42        INTC  serial
 77:         93        INTC  ehci_hcd:usb2
 83:         66        INTC  mmc0
 86:         12        INTC  mmc1
 92:          1        INTC  musb_hdrc
336:        809        GPIO  eth0
378:          0     twl4030  twl4030_usb
384:          0     twl4030  mmc0

I believe the interrupts tagged "twl4030" are chained interrupts. Having
looked at the code, these interrupts are not chained the usual way
because they require i2c communication, which in turn requires a context
allowed to sleep, so they are dispatched by a kernel thread.


-- 
					    Gilles.

