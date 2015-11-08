Date: Mon, 9 Nov 2015 00:22:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151108232202.GW1798@hermes.click-hack.org>
References: <BLU436-SMTP73BE7B77324E5FEB445F80F0290@phx.gbl>
 <BLU436-SMTP6F35FE1B18A156B3D57E4F0160@phx.gbl>
 <20151108084205.GG1798@hermes.click-hack.org>
 <BLU436-SMTP73E9091DCDE4C2D26FB175F0160@phx.gbl>
 <20151108171031.GR1798@hermes.click-hack.org>
 <BLU436-SMTP122F0286E6E48736DB2C3A6F0160@phx.gbl>
 <20151108172614.GS1798@hermes.click-hack.org>
 <BLU436-SMTP502B67C2B024CF139D04DEF0160@phx.gbl>
 <20151108174512.GT1798@hermes.click-hack.org>
 <BLU436-SMTP32474C5F5180D497EB0B7CF0160@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <BLU436-SMTP32474C5F5180D497EB0B7CF0160@phx.gbl>
Subject: Re: [Xenomai] Support for Raspberry PI 2 B
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

On Sun, Nov 08, 2015 at 01:47:02PM -0800, Mathieu Rondonneau wrote:
> On 15-11-08 09:45 AM, Gilles Chanteperdrix wrote:
> > On Sun, Nov 08, 2015 at 09:36:16AM -0800, Mathieu Rondonneau wrote:
> >> On 15-11-08 09:26 AM, Gilles Chanteperdrix wrote:
> >>> On Sun, Nov 08, 2015 at 09:20:47AM -0800, Mathieu Rondonneau wrote:
> >>>> On 15-11-08 09:10 AM, Gilles Chanteperdrix wrote:
> >>>>> On Sun, Nov 08, 2015 at 09:04:38AM -0800, Mathieu Rondonneau wrote:
> >>>>>> On 15-11-08 12:42 AM, Gilles Chanteperdrix wrote:
> >>>>>>> On Sat, Nov 07, 2015 at 09:55:48PM -0800, Mathieu Rondonneau wrot=
e:
> >>>>>>>> On 15-11-04 10:08 PM, Mathieu Rondonneau wrote:
> >>>>>>>>> On 15-11-04 04:51 PM, Mathieu Rondonneau wrote:
> >>>>>>>>>> On 15-11-03 11:04 PM, Gilles Chanteperdrix wrote:
> >>>>>>>>>>> On Tue, Nov 03, 2015 at 07:18:37PM -0800, Mathieu Rondonneau =
wrote:
> >>>>>>>>>>>> On 15-11-02 07:15 AM, Philippe Gerum wrote:
> >>>>>>>>>>>>> On 11/02/2015 06:23 AM, Mathieu Rondonneau wrote:
> >>>>>>>>>>>>>> On 15-11-01 07:21 PM, Mathieu Rondonneau wrote:
> >>>>>>>>>>>>>>> On 15-11-01 06:58 PM, Mathieu Rondonneau wrote:
> >>>>>>>>>>>>>>>> On 15-10-31 08:58 PM, Mathieu Rondonneau wrote:
> >>>>>>>>>>>>>>>>> Hi,
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> irq handlers registered with devm_request_threaded_irq =
does not
> >>>>>>>>>>>>>>>>> get
> >>>>>>>>>>>>>>>>> triggered when interrupt fires.
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> The mmc driver uses this (can not load the rootfs).
> >>>>>>>>>>>>>>>>> Only the IPIPE patch is enabled.
> >>>>>>>>>>>>>>>>> the armctrl chipirq is triggering the .ack handler inst=
ead so the
> >>>>>>>>>>>>>>>>> interrupt is happening.
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> Any suggestion on where I should look? how is this supp=
orted by
> >>>>>>>>>>>>>>>>> the
> >>>>>>>>>>>>>>>>> ipipe layer?
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> Thanks,
> >>>>>>>>>>>>>>>>> -Mathieu
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> I think I might have answered my own question.
> >>>>>>>>>>>>>>>> Looks like I need to use ipipe_request_irq() instead.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Regards,
> >>>>>>>>>>>>>>>> -Mathieu
> >>>>>>>>>>>>>>> mmmm it is not true, it seems we still need a
> >>>>>>>>>>>>>>> ipipe_request_threaded_irq() to call the ackfn, put the h=
andler in
> >>>>>>>>>>>>>>> the
> >>>>>>>>>>>>>>> queue and wake up the thread once handler is executed. Or=
 user
> >>>>>>>>>>>>>>> will have
> >>>>>>>>>>>>>>> to move this functionality into their driver's IRQ handle=
r.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> It strangely looks like ipipe_request_irq's idea is simil=
ar to what
> >>>>>>>>>>>>>>> request_threaded_irq is already doing (delaying IRQ proce=
ss later).
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> -Mathieu
> >>>>>>>>>>>>>> Looks like my bigger problem is that the handler_level_irq=
 is not
> >>>>>>>>>>>>>> called. Only the timer handler is called (handler_percpu_d=
evid_irq).
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Which may mean that the regular IRQ top half for that inter=
rupt source
> >>>>>>>>>>>>> is not connected to the pipeline. You may want to check whe=
ther the
> >>>>>>>>>>>>> irqchip handling that device's IRQs has been made aware of =
the
> >>>>>>>>>>>>> interrupt
> >>>>>>>>>>>>> pipeline.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> Thanks for replying Philippe,
> >>>>>>>>>>>> This is the think, I did change the arch_irq_default_handler=
 to call
> >>>>>>>>>>>> the
> >>>>>>>>>>>> __ipipe_grab_irq and __ipipe_grab_ipi.
> >>>>>>>>>>>> Is that what you are referring to when you say "interrupt so=
urce is not
> >>>>>>>>>>>> connected to the pipile", that's what __ipipe_grab_xxx does =
isn't it?
> >>>>>>>>>>>>
> >>>>>>>>>>>> Obviously I am still missing something.
> >>>>>>>>>>>> If I use irq_set_chained_handler in the driver then the hand=
ler gets
> >>>>>>>>>>>> called but it's just replacing the handler_irq by the driver=
 one.
> >>>>>>>>>>>> When I use request_irq then it does not call my handler (the
> >>>>>>>>>>>> action.handler one).
> >>>>>>>>>>>> I will keep looking.
> >>>>>>>>>>>
> >>>>>>>>>>> This is explained here:
> >>>>>>>>>>> http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-n=
ew-arm-soc/#GPIOs_as_interrupt_sources
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> and here:
> >>>>>>>>>>> http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-n=
ew-arm-soc/#CONFIG_MULTI_IRQ_HANDLER
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> Chained handlers have to call ipipe_handle_demuxed_irq instea=
d of
> >>>>>>>>>>> generic_handle_irq.
> >>>>>>>>>>> And the arch irq handler has to call ipipe_handle_multi_irq or
> >>>>>>>>>>> ipipe_handle_multi_ipi instead of handle_IRQ
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Thanks Gilles for the pointers,
> >>>>>>>>>> MULTI_IRQ_HANDLER is not enabled for RPI2 (so I did not look a=
t the
> >>>>>>>>>> multi_irq_handler section), is it a requirement for the ipipe =
patch to
> >>>>>>>>>> work?
> >>>>>>>>>>
> >>>>>>>>>> For GPIO I got it to work, but it is easier to me because they=
 have
> >>>>>>>>>> their own irqchip.
> >>>>>>>>>> It is the arch irq handler that cause me trouble.
> >>>>>>>>>>
> >>>>>>>>>> Maybe I just have to enable MULTI_IRQ_HANDLER.
> >>>>>>>>>> I will play around with it.
> >>>>>>>>>>
> >>>>>>>>>> Thanks again for your feedback, it helps,
> >>>>>>>>>> Regards,
> >>>>>>>>>> -Mathieu
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>> Also confirming that the ipipe_handler_multi_irq and
> >>>>>>>>> ipipe_handler_multi_ipi are called properly.
> >>>>>>>>> so it looks like the arch irq handler is working as expected.
> >>>>>>>>>
> >>>>>>>>> it is the handle_level_irq that is not called properly when I u=
se the
> >>>>>>>>> request_irq in the driver.
> >>>>>>>>> the desc->irq_data.chip->irq_ack is called properly but not the
> >>>>>>>>> irqaction->handler (that is the handler of my driver) that shou=
ld have
> >>>>>>>>> been triggered by handle_level_irq.
> >>>>>>>>>
> >>>>>>>>> So I think my problem is that handle_level_irq() is not called.
> >>>>>>>>> if I register my driver handler with irq_set_chained_handler th=
en
> >>>>>>>>> ipipe_handler_multi_irq is still called, but the
> >>>>>>>>> desc->irq_data.chip->irq_ack does not get called and my driver =
handle
> >>>>>>>>> gets called properly.
> >>>>>>>>> In this case, the ipipe is bypassed it seems since if I underst=
and
> >>>>>>>>> correctly, the irq_ack is still expected to trigger.
> >>>>>>>>>
> >>>>>>>>> Maybe I am missing a ipipe_handle_demuxed_irq call in an interr=
upt
> >>>>>>>>> handler that gets called before my driver interrupt handler get=
s a
> >>>>>>>>> chance to get called.
> >>>>>>>>>
> >>>>>>>>> I have to look at what interrupt happens before mine.
> >>>>>>>>>
> >>>>>>>>> -Mathieu
> >>>>>>>>
> >>>>>>>> more info:
> >>>>>>>> 1) interrupt (lets say #I) triggers, the ipipe_dispatch_irq call=
s the
> >>>>>>>> irqchip->mask() which calls ipipe_lock_irq (IPIPE_LOCK_FLAG is n=
ow
> >>>>>>>> set).
> >>>>>>>
> >>>>>>> it should not call irqchip->mask, but irqchip->ipipe_ack, which
> >>>>>>> should not call ipipe_lock_irq. See for instance the documentation
> >>>>>>> about fasteoi irq:
> >>>>>>> http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-a=
rm-soc/#flow_handler
> >>>>>>>
> >>>>>>
> >>>>>> Gilles, thanks again for you response,
> >>>>>> the code (and execution path observed) does not seem to match with=
 what
> >>>>>> you are saying (please don't take this the wrong way :)), please h=
elp
> >>>>>> clarifying. See explanation below:
> >>>>>>
> >>>>>>     From the doc:
> >>>>>> "the irq_mask handler should call ipipe_lock_irq before accessing =
the
> >>>>>> interrupt controller registers"
> >>>>>> So I did put a ipipe_lock_irq in the irq_mask.
> >>>>>
> >>>>> The documentation also says:
> >>>>> "If the flow handler is =93handle_fasteoi_irq=94 the implementation=
 of
> >>>>> the =93struct irq_chip=94 members should be modified:"
> >>>>> and
> >>>>>     an irq_hold handler should be added (when CONFIG_IPIPE is enabl=
ed)
> >>>>>     having the same effect as the irq_mask handler (but without the
> >>>>>     call to ipipe_lock_irq), and the irq_eoi handler.
> >>>>>
> >>>>> In which case the irq_hold handler is called upon handling the
> >>>>> interrupt.
> >>>>>
> >>>>> You can not just apply half of what the documentation says and hope
> >>>>> to have a working system.
> >>>>>
> >>>>
> >>>> But I don't use handle_fasteoi_irq, I use handle_level_irq.
> >>>
> >>> Exactly my point.
> >>>
> >>
> >> ok so you are saying, that for handle_level_irq, do not add the
> >> ipipe_lock_irq in the irq_mask?
> >> Can you confirm this?
> >> Does it mean for handle_level_irq, the irq_hold and irq_release are not
> >> needed as well.
> >> Ok this is the part I did not understood from the doc then. I think th=
is
> >> could be clarified in the doc. (more clarification does not hurt).
> >
> > The doc looks clear enough to me. It says:
> >
> > if condition, then
> >     do 1
> >     do 2
> >     do 3
> >
> > if condition is not true, there is no reason to do 1, 2, or 3.
> >
> > perhaps you want me to add
> >
> > else
> >     do nothing
> > ?
> >
> > As a C programmer, do you put,
> >      else
> > 	;
> > To all your ifs with no else ?
> >
>=20
> Maybe I was not expecting the doc to be structured in a coding language w=
ay.
> But that's ok, now I know it, the doc make sense :)
>=20
> the doc focus on the handle_fasteoi_irq (and briefly handle_edge_irq),=20
> there are other flow handler that could use some more porting details:
>=20
> if (handle =3D=3D handle_percpu_irq ||
> 	handle =3D=3D handle_percpu_devid_irq) {
> 	if (irq_desc_get_chip(desc) &&
> 		irq_desc_get_chip(desc)->irq_hold) {
> 			desc->ipipe_ack =3D __ipipe_ack_fasteoi_irq;
> 			desc->ipipe_end =3D __ipipe_end_fasteoi_irq;
> 		} else {
> 			desc->ipipe_ack =3D __ipipe_ack_percpu_irq;
> 			desc->ipipe_end =3D __ipipe_nop_irq;
> 		}

Ironically, the aim of that piece of code is to solve a problem not
unlike yours: when an irqchip is shared between irqs using
handle_fasteoi_irq and handle_percpu_irq (which I believe is
the case on some cortex A9), we want the I-pipe to use
irq_hold/irq_release, in order to avoid calling mask/unmask and
locking the interrupts.

But it works both way, handle_percpu_irq can also share an
irqchip with handle_level_irq and use the mask/unmask. You just have
to not put an ipipe_lock/unlock in mask/unmask.

The idea is that the only case where you need to modify mask/unmask
is with handle_fasteoi_irq. Other than that, don't touch anything,
and it should just work.

--=20
					    Gilles.
https://click-hack.org

