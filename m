From: Paul <paul_c@tuxcnc.org>
Date: Thu, 31 Jan 2013 02:11:44 +0000
References: <CALJOq=VtrBhMzCaT=7omDVN9hnnwZ+cmM1_1eff9DTS-fvLjaw@mail.gmail.com>
	<5101719D.9080908@logilin.fr> <51024BA3.9040402@xenomai.org>
In-Reply-To: <51024BA3.9040402@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201301310211.44277.paul_c@tuxcnc.org>
Subject: Re: [Xenomai] GPIO Interrupts problem with RTDM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Friday 25 January 2013, Gilles Chanteperdrix wrote:
> On 01/24/2013 06:38 PM, Christophe Blaess wrote:
> > On 24/01/2013 18:12, Paul wrote:
> >> On Thursday 24 January 2013, Christophe Blaess wrote:
> >>> On 22/01/2013 04:06, Paul wrote:
> >>>> On Sunday 20 January 2013, Gilles Chanteperdrix wrote:
> >>>>> Yes, this patch is based on 3.5.7 and is used with and without
> >>>>> GENERIC_CLOCKEVENTS.
> >>>>
> >>>> Short version: Updated my kernel to 3.5.7 and backported the
> >>>> Raspberry Pi changes from 3.6.11 and added in the ipipe support.
> >>>> Interrupts are not being recognised unless irq_set_irq_type() is
> >>>> called. Digging through the rtdm, nucleus, and ipipe code, at no
> >>>> point is
> >>>> irq_chip->irq_set_type() called - Also have a problem that none
> >>>> of the ipipe_pic_muter fields are set, so
> >>>> __ipipe_enable_irqdesc() & friends do nothing.
> >>>
> >>> I'm trying to follow the same steps as you but I still have some
> >>> compilation errors while porting
> >>> R-Pi modifications to 3.5.7. (especially arm timer code).
> >>>
> >>> Do you have any available patch against 3.5.7 vanilla kernel ?
> >>
> >> Funny that you should ask - I am in the middle of generating a
> >> patch set against 3.5.7 with the Raspberry Pi additions. This will
> >> include the ipipe modifications along with a fix to the gpio
> >> interrupt handler.
> >
> > Great.
> >
> >>> I have a working GPIO interrupt rtdm driver with 3.2.21 kernel
> >>> (Xenomai 2.6.2) but the interrupt latencies seems terrible (about
> >>> 20us and jiterring up to 150us without any load). To compare with
> >>> the 7us latency I see on a vanilla Linux GPIO interrupt handler.
> >>
> >> Should be better than that - Did you make any changes to the
> >> interrupt handler in bcm207_gpio.c ?
> >
> > I replaced generic_handle_irq() by ipipe_handle_demuxed_irq().
> >
> >
> > My interrupt handler toggle an ouput GPIO pin :
> >
> > static int handler_irq(rtdm_irq_t * irq)
> > {
> >          static int value = 0;
> >          gpio_set_value(GPIO_OUT, value);
> >          value = 1 - value;
> >          return RTDM_IRQ_HANDLED;
> > }
> >
> > I think that gpio_set_value() doesn't call any Linux services, but
> > I may be wrong.
>
> Two things to check then:
> http://xenomai.org/index.php/I-pipe-core:ArmPorting#GPIOs_in_real-tim
>e_drivers
>
> And the second I forgot in the porting guide is the idle loop. The
> processor dependent idle routine is called by the I-pipe kernel with
> hardware irqs on, this could result in an interrupt being handled
> with part of the processor still prepared for sleeping. For instance,
> on arm926ejs, this could result in interrupts being handled with
> I-cache off, which resulted in high latencies.
>
> As a first step  to check that it is not the issue you observe, boot
> with the "nohlt" kernel option. If the latencies improve, then
> something needs to be done about the idle loop.
>
> If that is your issue, there are two ways around:
> - call hard_local_irq_disable() at the beginning of the processor
> dependent idle routine
> - if this results in to high latencies (due to the time it takes to
> execute the handler), then simply disable this idle routine.

Booting with "dwc_otg.fiq_fix_enable=0" in cmdline.txt improves matters 
considerably - The problem is in the FIQ handler and/or the dwc_otg 
driver.

This will have to wait until the weekend and hopefully I can get time to 
dig further. One option is to route the timer through the FIQ which may 
improve latency a little, another is to disable it altogether.


Regards, Paul.




