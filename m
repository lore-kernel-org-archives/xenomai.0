Date: Wed, 4 Nov 2015 08:04:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151104070414.GD24848@hermes.click-hack.org>
References: <56358DE3.8030308@hotmail.com>
 <BLU437-SMTP82C3E059EB476E2624582EF02C0@phx.gbl>
 <BLU437-SMTP38CA2663CEF65BBDBD9AFCF02C0@phx.gbl>
 <BLU437-SMTP11676D7F7E77869B206F3AF02C0@phx.gbl>
 <56377DF5.5090202@xenomai.org>
 <BLU437-SMTP10132C0DA57E69E6D1C8359F02A0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLU437-SMTP10132C0DA57E69E6D1C8359F02A0@phx.gbl>
Subject: Re: [Xenomai] Support for Raspberry PI 2 B
 (devm_request_threaded_irq)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Cc: xenomai@xenomai.org

On Tue, Nov 03, 2015 at 07:18:37PM -0800, Mathieu Rondonneau wrote:
> On 15-11-02 07:15 AM, Philippe Gerum wrote:
> > On 11/02/2015 06:23 AM, Mathieu Rondonneau wrote:
> >> On 15-11-01 07:21 PM, Mathieu Rondonneau wrote:
> >>> On 15-11-01 06:58 PM, Mathieu Rondonneau wrote:
> >>>> On 15-10-31 08:58 PM, Mathieu Rondonneau wrote:
> >>>>> Hi,
> >>>>>
> >>>>> irq handlers registered with devm_request_threaded_irq does not get
> >>>>> triggered when interrupt fires.
> >>>>>
> >>>>> The mmc driver uses this (can not load the rootfs).
> >>>>> Only the IPIPE patch is enabled.
> >>>>> the armctrl chipirq is triggering the .ack handler instead so the
> >>>>> interrupt is happening.
> >>>>>
> >>>>> Any suggestion on where I should look? how is this supported by the
> >>>>> ipipe layer?
> >>>>>
> >>>>> Thanks,
> >>>>> -Mathieu
> >>>>
> >>>> I think I might have answered my own question.
> >>>> Looks like I need to use ipipe_request_irq() instead.
> >>>>
> >>>> Regards,
> >>>> -Mathieu
> >>> mmmm it is not true, it seems we still need a
> >>> ipipe_request_threaded_irq() to call the ackfn, put the handler in the
> >>> queue and wake up the thread once handler is executed. Or user will have
> >>> to move this functionality into their driver's IRQ handler.
> >>>
> >>> It strangely looks like ipipe_request_irq's idea is similar to what
> >>> request_threaded_irq is already doing (delaying IRQ process later).
> >>>
> >>> -Mathieu
> >> Looks like my bigger problem is that the handler_level_irq is not
> >> called. Only the timer handler is called (handler_percpu_devid_irq).
> >
> > Which may mean that the regular IRQ top half for that interrupt source
> > is not connected to the pipeline. You may want to check whether the
> > irqchip handling that device's IRQs has been made aware of the interrupt
> > pipeline.
> >
> 
> Thanks for replying Philippe,
> This is the think, I did change the arch_irq_default_handler to call the 
> __ipipe_grab_irq and __ipipe_grab_ipi.
> Is that what you are referring to when you say "interrupt source is not 
> connected to the pipile", that's what __ipipe_grab_xxx does isn't it?
> 
> Obviously I am still missing something.
> If I use irq_set_chained_handler in the driver then the handler gets 
> called but it's just replacing the handler_irq by the driver one.
> When I use request_irq then it does not call my handler (the 
> action.handler one).
> I will keep looking.

This is explained here:
http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/#GPIOs_as_interrupt_sources
and here:
http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/#CONFIG_MULTI_IRQ_HANDLER

Chained handlers have to call ipipe_handle_demuxed_irq instead of
generic_handle_irq.
And the arch irq handler has to call ipipe_handle_multi_irq or
ipipe_handle_multi_ipi instead of handle_IRQ

-- 
					    Gilles.
https://click-hack.org

