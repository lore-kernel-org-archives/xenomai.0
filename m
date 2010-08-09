From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C5FEB8C.200@domain.hid>
References: <307507.12667.qm@domain.hid>
	<1281350069.1706.139.camel@domain.hid>
	<4C5FEB8C.200@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 09 Aug 2010 15:37:05 +0200
Message-ID: <1281361025.1706.143.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Having trouble with a BeagleBoard GPIO interrupt
 pin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, bob.feretich@domain.hid

On Mon, 2010-08-09 at 13:50 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > On Mon, 2010-08-09 at 02:54 -0700, Bob Feretich wrote:
> >> I am converting my second driver to RTDM. This one receives a
> >> negativing going edge triggered interrupt on GPIO133 of the OMAP3
> >> chip.
> >>
> >> I have...
> >> ret = rtdm_irq_request(&adis_data_rdy_irq_handle, irq, 
> >>                    adis_data_rdy_irq_handler, 
> >>                    RTDM_IRQTYPE_EDGE, 
> >>                    "asuspidvr", ctx);
> >> then...
> >> ret = rtdm_irq_enable(&adis_data_rdy_irq_handle);
> >>
> >> but the interrupt handler is never invoked.
> >>
> >> cat /proc/xenomai/irq shows:
> >> IRQ         CPU0
> >>  37:       15815         [timer]
> >>  39:           0         asuspidvr
> >>  48:           0         asuspidvr
> >>  91:           0         asuspidvr
> >> 293:           0         asuspidvr
> >> 418:           0         [virtual]
> >>
> >> IRQ 293 in the interrupt that should be happening.
> >>
> >> I can see the pulses on the input pin and the non-rt version of the
> >> driver sees the interrupts, so that excludes hardware issues and
> >> u-boot pin configuration issues.
> >>
> >> Any suggestions?
> >> Regards,
> >> Bob Feretich
> >>
> >>
> >> __
> > 
> > For some reason, that IRQ line may not be properly enabled by the core
> > code. Could you introduce this patch? If a valid routine is reported in
> > the kernel log message, you could locate it by address, from a kernel
> > image objdump.
> 
> There may also be more to do than enabling the irq line, such as
> programming the hardware to enable irq for this gpio, set the type
> (edge, level) and so on. You can try and call request_irq, then free_irq
> before calling rtdm_request_irq to see if request_irq would trigger some
> actions that rtdm_request_irq does not trigger.
> 

If you mean that beagle_twl_gpio_setup() still has to be called at this
point, then we probably have something broken at ipipe level.

-- 
Philippe.



