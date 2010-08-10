From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C603899.5050402@domain.hid>
References: <307507.12667.qm@domain.hid>
	<1281350069.1706.139.camel@domain.hid>
	<4C5FEB8C.200@domain.hid>
	<1281361025.1706.143.camel@domain.hid>
	<4C603899.5050402@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 Aug 2010 07:35:22 +0200
Message-ID: <1281418522.2986.21.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-help] Having trouble with a BeagleBoard
 GPIO interrupt pin
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, bob.feretich@domain.hid, xenomai@xenomai.org

On Mon, 2010-08-09 at 19:19 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > On Mon, 2010-08-09 at 13:50 +0200, Gilles Chanteperdrix wrote:
> >> Philippe Gerum wrote:
> >>> On Mon, 2010-08-09 at 02:54 -0700, Bob Feretich wrote:
> >>>> I am converting my second driver to RTDM. This one receives a
> >>>> negativing going edge triggered interrupt on GPIO133 of the OMAP3
> >>>> chip.
> >>>>
> >>>> I have...
> >>>> ret = rtdm_irq_request(&adis_data_rdy_irq_handle, irq, 
> >>>>                    adis_data_rdy_irq_handler, 
> >>>>                    RTDM_IRQTYPE_EDGE, 
> >>>>                    "asuspidvr", ctx);
> >>>> then...
> >>>> ret = rtdm_irq_enable(&adis_data_rdy_irq_handle);
> >>>>
> >>>> but the interrupt handler is never invoked.
> >>>>
> >>>> cat /proc/xenomai/irq shows:
> >>>> IRQ         CPU0
> >>>>  37:       15815         [timer]
> >>>>  39:           0         asuspidvr
> >>>>  48:           0         asuspidvr
> >>>>  91:           0         asuspidvr
> >>>> 293:           0         asuspidvr
> >>>> 418:           0         [virtual]
> >>>>
> >>>> IRQ 293 in the interrupt that should be happening.
> >>>>
> >>>> I can see the pulses on the input pin and the non-rt version of the
> >>>> driver sees the interrupts, so that excludes hardware issues and
> >>>> u-boot pin configuration issues.
> >>>>
> >>>> Any suggestions?
> >>>> Regards,
> >>>> Bob Feretich
> >>>>
> >>>>
> >>>> __
> >>> For some reason, that IRQ line may not be properly enabled by the core
> >>> code. Could you introduce this patch? If a valid routine is reported in
> >>> the kernel log message, you could locate it by address, from a kernel
> >>> image objdump.
> >> There may also be more to do than enabling the irq line, such as
> >> programming the hardware to enable irq for this gpio, set the type
> >> (edge, level) and so on. You can try and call request_irq, then free_irq
> >> before calling rtdm_request_irq to see if request_irq would trigger some
> >> actions that rtdm_request_irq does not trigger.
> >>
> > 
> > If you mean that beagle_twl_gpio_setup() still has to be called at this
> > point, then we probably have something broken at ipipe level.
> 
> I was rather thinking about gpio_irq_type, which is normally called
> through "set_irq_type". I wonder however, if calling this function for
> an irq registered through rtdm will not screw things up, especially
> since it changes the flow handler, or do nothing because the irq has not
> been registered with request_irq.
> 

chip->set_type() should be called when setting the IRQ trigger; this one
completely depends on the per-chip routine. In the gpio_irq_type(), that
should be fine, since we relay the settings through
__fixup_irq_handler(), which is Adeos-defined.

Xenomai is not currently setting the IRQ trigger when requesting an
interrupt, which is the problem. However, set_type() handlers are often
required to run in secondary mode; this means than any call on behalf of
rtdm_irq_request() would restrict the latter to secondary mode only,
which is not currently the case.

This means that we should probably force this requirement on
rthal_irq_request() at some point, because connecting a Xenomai
interrupt descriptor to the Linux core may impose secondary mode on us.

PS: switching the discussion to -core where it belongs now.

-- 
Philippe.



