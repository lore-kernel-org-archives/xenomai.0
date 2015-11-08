Message-ID: <BLU436-SMTP502B67C2B024CF139D04DEF0160@phx.gbl>
References: <56377DF5.5090202@xenomai.org>
 <BLU437-SMTP10132C0DA57E69E6D1C8359F02A0@phx.gbl>
 <20151104070414.GD24848@hermes.click-hack.org>
 <BLU436-SMTP43B29DB76F59896D9FB7C0F0290@phx.gbl>
 <BLU436-SMTP73BE7B77324E5FEB445F80F0290@phx.gbl>
 <BLU436-SMTP6F35FE1B18A156B3D57E4F0160@phx.gbl>
 <20151108084205.GG1798@hermes.click-hack.org>
 <BLU436-SMTP73E9091DCDE4C2D26FB175F0160@phx.gbl>
 <20151108171031.GR1798@hermes.click-hack.org>
 <BLU436-SMTP122F0286E6E48736DB2C3A6F0160@phx.gbl>
 <20151108172614.GS1798@hermes.click-hack.org>
From: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Date: Sun, 8 Nov 2015 09:36:16 -0800
MIME-Version: 1.0
In-Reply-To: <20151108172614.GS1798@hermes.click-hack.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Support for Raspberry PI 2 B
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 15-11-08 09:26 AM=2C Gilles Chanteperdrix wrote:
> On Sun=2C Nov 08=2C 2015 at 09:20:47AM -0800=2C Mathieu Rondonneau wrote:
>> On 15-11-08 09:10 AM=2C Gilles Chanteperdrix wrote:
>>> On Sun=2C Nov 08=2C 2015 at 09:04:38AM -0800=2C Mathieu Rondonneau wrot=
e:
>>>> On 15-11-08 12:42 AM=2C Gilles Chanteperdrix wrote:
>>>>> On Sat=2C Nov 07=2C 2015 at 09:55:48PM -0800=2C Mathieu Rondonneau wr=
ote:
>>>>>> On 15-11-04 10:08 PM=2C Mathieu Rondonneau wrote:
>>>>>>> On 15-11-04 04:51 PM=2C Mathieu Rondonneau wrote:
>>>>>>>> On 15-11-03 11:04 PM=2C Gilles Chanteperdrix wrote:
>>>>>>>>> On Tue=2C Nov 03=2C 2015 at 07:18:37PM -0800=2C Mathieu Rondonnea=
u wrote:
>>>>>>>>>> On 15-11-02 07:15 AM=2C Philippe Gerum wrote:
>>>>>>>>>>> On 11/02/2015 06:23 AM=2C Mathieu Rondonneau wrote:
>>>>>>>>>>>> On 15-11-01 07:21 PM=2C Mathieu Rondonneau wrote:
>>>>>>>>>>>>> On 15-11-01 06:58 PM=2C Mathieu Rondonneau wrote:
>>>>>>>>>>>>>> On 15-10-31 08:58 PM=2C Mathieu Rondonneau wrote:
>>>>>>>>>>>>>>> Hi=2C
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> irq handlers registered with devm_request_threaded_irq does=
 not
>>>>>>>>>>>>>>> get
>>>>>>>>>>>>>>> triggered when interrupt fires.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The mmc driver uses this (can not load the rootfs).
>>>>>>>>>>>>>>> Only the IPIPE patch is enabled.
>>>>>>>>>>>>>>> the armctrl chipirq is triggering the .ack handler instead =
so the
>>>>>>>>>>>>>>> interrupt is happening.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Any suggestion on where I should look? how is this supporte=
d by
>>>>>>>>>>>>>>> the
>>>>>>>>>>>>>>> ipipe layer?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Thanks=2C
>>>>>>>>>>>>>>> -Mathieu
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I think I might have answered my own question.
>>>>>>>>>>>>>> Looks like I need to use ipipe_request_irq() instead.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Regards=2C
>>>>>>>>>>>>>> -Mathieu
>>>>>>>>>>>>> mmmm it is not true=2C it seems we still need a
>>>>>>>>>>>>> ipipe_request_threaded_irq() to call the ackfn=2C put the han=
dler in
>>>>>>>>>>>>> the
>>>>>>>>>>>>> queue and wake up the thread once handler is executed. Or use=
r
>>>>>>>>>>>>> will have
>>>>>>>>>>>>> to move this functionality into their driver's IRQ handler.
>>>>>>>>>>>>>
>>>>>>>>>>>>> It strangely looks like ipipe_request_irq's idea is similar t=
o what
>>>>>>>>>>>>> request_threaded_irq is already doing (delaying IRQ process l=
ater).
>>>>>>>>>>>>>
>>>>>>>>>>>>> -Mathieu
>>>>>>>>>>>> Looks like my bigger problem is that the handler_level_irq is =
not
>>>>>>>>>>>> called. Only the timer handler is called (handler_percpu_devid=
_irq).
>>>>>>>>>>>
>>>>>>>>>>> Which may mean that the regular IRQ top half for that interrupt=
 source
>>>>>>>>>>> is not connected to the pipeline. You may want to check whether=
 the
>>>>>>>>>>> irqchip handling that device's IRQs has been made aware of the
>>>>>>>>>>> interrupt
>>>>>>>>>>> pipeline.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Thanks for replying Philippe=2C
>>>>>>>>>> This is the think=2C I did change the arch_irq_default_handler t=
o call
>>>>>>>>>> the
>>>>>>>>>> __ipipe_grab_irq and __ipipe_grab_ipi.
>>>>>>>>>> Is that what you are referring to when you say "interrupt source=
 is not
>>>>>>>>>> connected to the pipile"=2C that's what __ipipe_grab_xxx does is=
n't it?
>>>>>>>>>>
>>>>>>>>>> Obviously I am still missing something.
>>>>>>>>>> If I use irq_set_chained_handler in the driver then the handler =
gets
>>>>>>>>>> called but it's just replacing the handler_irq by the driver one=
.
>>>>>>>>>> When I use request_irq then it does not call my handler (the
>>>>>>>>>> action.handler one).
>>>>>>>>>> I will keep looking.
>>>>>>>>>
>>>>>>>>> This is explained here:
>>>>>>>>> http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-a=
rm-soc/#GPIOs_as_interrupt_sources
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> and here:
>>>>>>>>> http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-a=
rm-soc/#CONFIG_MULTI_IRQ_HANDLER
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Chained handlers have to call ipipe_handle_demuxed_irq instead of
>>>>>>>>> generic_handle_irq.
>>>>>>>>> And the arch irq handler has to call ipipe_handle_multi_irq or
>>>>>>>>> ipipe_handle_multi_ipi instead of handle_IRQ
>>>>>>>>>
>>>>>>>>
>>>>>>>> Thanks Gilles for the pointers=2C
>>>>>>>> MULTI_IRQ_HANDLER is not enabled for RPI2 (so I did not look at th=
e
>>>>>>>> multi_irq_handler section)=2C is it a requirement for the ipipe pa=
tch to
>>>>>>>> work?
>>>>>>>>
>>>>>>>> For GPIO I got it to work=2C but it is easier to me because they h=
ave
>>>>>>>> their own irqchip.
>>>>>>>> It is the arch irq handler that cause me trouble.
>>>>>>>>
>>>>>>>> Maybe I just have to enable MULTI_IRQ_HANDLER.
>>>>>>>> I will play around with it.
>>>>>>>>
>>>>>>>> Thanks again for your feedback=2C it helps=2C
>>>>>>>> Regards=2C
>>>>>>>> -Mathieu
>>>>>>>>
>>>>>>>>
>>>>>>> Also confirming that the ipipe_handler_multi_irq and
>>>>>>> ipipe_handler_multi_ipi are called properly.
>>>>>>> so it looks like the arch irq handler is working as expected.
>>>>>>>
>>>>>>> it is the handle_level_irq that is not called properly when I use t=
he
>>>>>>> request_irq in the driver.
>>>>>>> the desc->irq_data.chip->irq_ack is called properly but not the
>>>>>>> irqaction->handler (that is the handler of my driver) that should h=
ave
>>>>>>> been triggered by handle_level_irq.
>>>>>>>
>>>>>>> So I think my problem is that handle_level_irq() is not called.
>>>>>>> if I register my driver handler with irq_set_chained_handler then
>>>>>>> ipipe_handler_multi_irq is still called=2C but the
>>>>>>> desc->irq_data.chip->irq_ack does not get called and my driver hand=
le
>>>>>>> gets called properly.
>>>>>>> In this case=2C the ipipe is bypassed it seems since if I understan=
d
>>>>>>> correctly=2C the irq_ack is still expected to trigger.
>>>>>>>
>>>>>>> Maybe I am missing a ipipe_handle_demuxed_irq call in an interrupt
>>>>>>> handler that gets called before my driver interrupt handler gets a
>>>>>>> chance to get called.
>>>>>>>
>>>>>>> I have to look at what interrupt happens before mine.
>>>>>>>
>>>>>>> -Mathieu
>>>>>>
>>>>>> more info:
>>>>>> 1) interrupt (lets say #I) triggers=2C the ipipe_dispatch_irq calls =
the
>>>>>> irqchip->mask() which calls ipipe_lock_irq (IPIPE_LOCK_FLAG is now
>>>>>> set).
>>>>>
>>>>> it should not call irqchip->mask=2C but irqchip->ipipe_ack=2C which
>>>>> should not call ipipe_lock_irq. See for instance the documentation
>>>>> about fasteoi irq:
>>>>> http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-s=
oc/#flow_handler
>>>>>
>>>>
>>>> Gilles=2C thanks again for you response=2C
>>>> the code (and execution path observed) does not seem to match with wha=
t
>>>> you are saying (please don't take this the wrong way :))=2C please hel=
p
>>>> clarifying. See explanation below:
>>>>
>>>>    From the doc:
>>>> "the irq_mask handler should call ipipe_lock_irq before accessing the
>>>> interrupt controller registers"
>>>> So I did put a ipipe_lock_irq in the irq_mask.
>>>
>>> The documentation also says:
>>> "If the flow handler is =93handle_fasteoi_irq=94 the implementation of
>>> the =93struct irq_chip=94 members should be modified:"
>>> and
>>>    an irq_hold handler should be added (when CONFIG_IPIPE is enabled)
>>>    having the same effect as the irq_mask handler (but without the
>>>    call to ipipe_lock_irq)=2C and the irq_eoi handler.
>>>
>>> In which case the irq_hold handler is called upon handling the
>>> interrupt.
>>>
>>> You can not just apply half of what the documentation says and hope
>>> to have a working system.
>>>
>>
>> But I don't use handle_fasteoi_irq=2C I use handle_level_irq.
>
> Exactly my point.
>

ok so you are saying=2C that for handle_level_irq=2C do not add the=20
ipipe_lock_irq in the irq_mask?
Can you confirm this?
Does it mean for handle_level_irq=2C the irq_hold and irq_release are not=20
needed as well.
Ok this is the part I did not understood from the doc then. I think this=20
could be clarified in the doc. (more clarification does not hurt).

Just to confirm=2C you were saying "it should not call irqchip->mask=2C but=
=20
irqchip->ipipe_ack".
But for handle_level_irq the mask and the ack are called.
Is that correct?

I think understand what my mistake was.
I have not tested it yet but without the irq_lock=2C it should call the=20
handler.
Thank you Gilles again!

