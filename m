Message-ID: <BLU437-SMTP73704258277408A0F2C238F0150@phx.gbl>
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
 <20151108230959.GV1798@hermes.click-hack.org>
From: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Date: Sun, 8 Nov 2015 16:54:39 -0800
MIME-Version: 1.0
In-Reply-To: <20151108230959.GV1798@hermes.click-hack.org>
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

On 15-11-08 03:09 PM=2C Gilles Chanteperdrix wrote:
> On Sun=2C Nov 08=2C 2015 at 01:47:02PM -0800=2C Mathieu Rondonneau wrote:
>> On 15-11-08 09:45 AM=2C Gilles Chanteperdrix wrote:
>>> On Sun=2C Nov 08=2C 2015 at 09:36:16AM -0800=2C Mathieu Rondonneau wrot=
e:
>>>> On 15-11-08 09:26 AM=2C Gilles Chanteperdrix wrote:
>>>>> On Sun=2C Nov 08=2C 2015 at 09:20:47AM -0800=2C Mathieu Rondonneau wr=
ote:
>>>>>> On 15-11-08 09:10 AM=2C Gilles Chanteperdrix wrote:
>>>>>>> On Sun=2C Nov 08=2C 2015 at 09:04:38AM -0800=2C Mathieu Rondonneau =
wrote:
>>>>>>>> On 15-11-08 12:42 AM=2C Gilles Chanteperdrix wrote:
>>>>>>>>> On Sat=2C Nov 07=2C 2015 at 09:55:48PM -0800=2C Mathieu Rondonnea=
u wrote:
>>>>>>>>>> On 15-11-04 10:08 PM=2C Mathieu Rondonneau wrote:
>>>>>>>>>>> On 15-11-04 04:51 PM=2C Mathieu Rondonneau wrote:
>>>>>>>>>>>> On 15-11-03 11:04 PM=2C Gilles Chanteperdrix wrote:
>>>>>>>>>>>>> On Tue=2C Nov 03=2C 2015 at 07:18:37PM -0800=2C Mathieu Rondo=
nneau wrote:
>>>>>>>>>>>>>> On 15-11-02 07:15 AM=2C Philippe Gerum wrote:
>>>>>>>>>>>>>>> On 11/02/2015 06:23 AM=2C Mathieu Rondonneau wrote:
>>>>>>>>>>>>>>>> On 15-11-01 07:21 PM=2C Mathieu Rondonneau wrote:
>>>>>>>>>>>>>>>>> On 15-11-01 06:58 PM=2C Mathieu Rondonneau wrote:
>>>>>>>>>>>>>>>>>> On 15-10-31 08:58 PM=2C Mathieu Rondonneau wrote:
>>>>>>>>>>>>>>>>>>> Hi=2C
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> irq handlers registered with devm_request_threaded_irq =
does not
>>>>>>>>>>>>>>>>>>> get
>>>>>>>>>>>>>>>>>>> triggered when interrupt fires.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> The mmc driver uses this (can not load the rootfs).
>>>>>>>>>>>>>>>>>>> Only the IPIPE patch is enabled.
>>>>>>>>>>>>>>>>>>> the armctrl chipirq is triggering the .ack handler inst=
ead so the
>>>>>>>>>>>>>>>>>>> interrupt is happening.
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Any suggestion on where I should look? how is this supp=
orted by
>>>>>>>>>>>>>>>>>>> the
>>>>>>>>>>>>>>>>>>> ipipe layer?
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> Thanks=2C
>>>>>>>>>>>>>>>>>>> -Mathieu
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> I think I might have answered my own question.
>>>>>>>>>>>>>>>>>> Looks like I need to use ipipe_request_irq() instead.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Regards=2C
>>>>>>>>>>>>>>>>>> -Mathieu
>>>>>>>>>>>>>>>>> mmmm it is not true=2C it seems we still need a
>>>>>>>>>>>>>>>>> ipipe_request_threaded_irq() to call the ackfn=2C put the=
 handler in
>>>>>>>>>>>>>>>>> the
>>>>>>>>>>>>>>>>> queue and wake up the thread once handler is executed. Or=
 user
>>>>>>>>>>>>>>>>> will have
>>>>>>>>>>>>>>>>> to move this functionality into their driver's IRQ handle=
r.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> It strangely looks like ipipe_request_irq's idea is simil=
ar to what
>>>>>>>>>>>>>>>>> request_threaded_irq is already doing (delaying IRQ proce=
ss later).
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> -Mathieu
>>>>>>>>>>>>>>>> Looks like my bigger problem is that the handler_level_irq=
 is not
>>>>>>>>>>>>>>>> called. Only the timer handler is called (handler_percpu_d=
evid_irq).
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Which may mean that the regular IRQ top half for that inter=
rupt source
>>>>>>>>>>>>>>> is not connected to the pipeline. You may want to check whe=
ther the
>>>>>>>>>>>>>>> irqchip handling that device's IRQs has been made aware of =
the
>>>>>>>>>>>>>>> interrupt
>>>>>>>>>>>>>>> pipeline.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Thanks for replying Philippe=2C
>>>>>>>>>>>>>> This is the think=2C I did change the arch_irq_default_handl=
er to call
>>>>>>>>>>>>>> the
>>>>>>>>>>>>>> __ipipe_grab_irq and __ipipe_grab_ipi.
>>>>>>>>>>>>>> Is that what you are referring to when you say "interrupt so=
urce is not
>>>>>>>>>>>>>> connected to the pipile"=2C that's what __ipipe_grab_xxx doe=
s isn't it?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Obviously I am still missing something.
>>>>>>>>>>>>>> If I use irq_set_chained_handler in the driver then the hand=
ler gets
>>>>>>>>>>>>>> called but it's just replacing the handler_irq by the driver=
 one.
>>>>>>>>>>>>>> When I use request_irq then it does not call my handler (the
>>>>>>>>>>>>>> action.handler one).
>>>>>>>>>>>>>> I will keep looking.
>>>>>>>>>>>>>
>>>>>>>>>>>>> This is explained here:
>>>>>>>>>>>>> http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-n=
ew-arm-soc/#GPIOs_as_interrupt_sources
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> and here:
>>>>>>>>>>>>> http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-n=
ew-arm-soc/#CONFIG_MULTI_IRQ_HANDLER
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Chained handlers have to call ipipe_handle_demuxed_irq instea=
d of
>>>>>>>>>>>>> generic_handle_irq.
>>>>>>>>>>>>> And the arch irq handler has to call ipipe_handle_multi_irq o=
r
>>>>>>>>>>>>> ipipe_handle_multi_ipi instead of handle_IRQ
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks Gilles for the pointers=2C
>>>>>>>>>>>> MULTI_IRQ_HANDLER is not enabled for RPI2 (so I did not look a=
t the
>>>>>>>>>>>> multi_irq_handler section)=2C is it a requirement for the ipip=
e patch to
>>>>>>>>>>>> work?
>>>>>>>>>>>>
>>>>>>>>>>>> For GPIO I got it to work=2C but it is easier to me because th=
ey have
>>>>>>>>>>>> their own irqchip.
>>>>>>>>>>>> It is the arch irq handler that cause me trouble.
>>>>>>>>>>>>
>>>>>>>>>>>> Maybe I just have to enable MULTI_IRQ_HANDLER.
>>>>>>>>>>>> I will play around with it.
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks again for your feedback=2C it helps=2C
>>>>>>>>>>>> Regards=2C
>>>>>>>>>>>> -Mathieu
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>> Also confirming that the ipipe_handler_multi_irq and
>>>>>>>>>>> ipipe_handler_multi_ipi are called properly.
>>>>>>>>>>> so it looks like the arch irq handler is working as expected.
>>>>>>>>>>>
>>>>>>>>>>> it is the handle_level_irq that is not called properly when I u=
se the
>>>>>>>>>>> request_irq in the driver.
>>>>>>>>>>> the desc->irq_data.chip->irq_ack is called properly but not the
>>>>>>>>>>> irqaction->handler (that is the handler of my driver) that shou=
ld have
>>>>>>>>>>> been triggered by handle_level_irq.
>>>>>>>>>>>
>>>>>>>>>>> So I think my problem is that handle_level_irq() is not called.
>>>>>>>>>>> if I register my driver handler with irq_set_chained_handler th=
en
>>>>>>>>>>> ipipe_handler_multi_irq is still called=2C but the
>>>>>>>>>>> desc->irq_data.chip->irq_ack does not get called and my driver =
handle
>>>>>>>>>>> gets called properly.
>>>>>>>>>>> In this case=2C the ipipe is bypassed it seems since if I under=
stand
>>>>>>>>>>> correctly=2C the irq_ack is still expected to trigger.
>>>>>>>>>>>
>>>>>>>>>>> Maybe I am missing a ipipe_handle_demuxed_irq call in an interr=
upt
>>>>>>>>>>> handler that gets called before my driver interrupt handler get=
s a
>>>>>>>>>>> chance to get called.
>>>>>>>>>>>
>>>>>>>>>>> I have to look at what interrupt happens before mine.
>>>>>>>>>>>
>>>>>>>>>>> -Mathieu
>>>>>>>>>>
>>>>>>>>>> more info:
>>>>>>>>>> 1) interrupt (lets say #I) triggers=2C the ipipe_dispatch_irq ca=
lls the
>>>>>>>>>> irqchip->mask() which calls ipipe_lock_irq (IPIPE_LOCK_FLAG is n=
ow
>>>>>>>>>> set).
>>>>>>>>>
>>>>>>>>> it should not call irqchip->mask=2C but irqchip->ipipe_ack=2C whi=
ch
>>>>>>>>> should not call ipipe_lock_irq. See for instance the documentatio=
n
>>>>>>>>> about fasteoi irq:
>>>>>>>>> http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-a=
rm-soc/#flow_handler
>>>>>>>>>
>>>>>>>>
>>>>>>>> Gilles=2C thanks again for you response=2C
>>>>>>>> the code (and execution path observed) does not seem to match with=
 what
>>>>>>>> you are saying (please don't take this the wrong way :))=2C please=
 help
>>>>>>>> clarifying. See explanation below:
>>>>>>>>
>>>>>>>>      From the doc:
>>>>>>>> "the irq_mask handler should call ipipe_lock_irq before accessing =
the
>>>>>>>> interrupt controller registers"
>>>>>>>> So I did put a ipipe_lock_irq in the irq_mask.
>>>>>>>
>>>>>>> The documentation also says:
>>>>>>> "If the flow handler is =93handle_fasteoi_irq=94 the implementation=
 of
>>>>>>> the =93struct irq_chip=94 members should be modified:"
>>>>>>> and
>>>>>>>      an irq_hold handler should be added (when CONFIG_IPIPE is enab=
led)
>>>>>>>      having the same effect as the irq_mask handler (but without th=
e
>>>>>>>      call to ipipe_lock_irq)=2C and the irq_eoi handler.
>>>>>>>
>>>>>>> In which case the irq_hold handler is called upon handling the
>>>>>>> interrupt.
>>>>>>>
>>>>>>> You can not just apply half of what the documentation says and hope
>>>>>>> to have a working system.
>>>>>>>
>>>>>>
>>>>>> But I don't use handle_fasteoi_irq=2C I use handle_level_irq.
>>>>>
>>>>> Exactly my point.
>>>>>
>>>>
>>>> ok so you are saying=2C that for handle_level_irq=2C do not add the
>>>> ipipe_lock_irq in the irq_mask?
>>>> Can you confirm this?
>>>> Does it mean for handle_level_irq=2C the irq_hold and irq_release are =
not
>>>> needed as well.
>>>> Ok this is the part I did not understood from the doc then. I think th=
is
>>>> could be clarified in the doc. (more clarification does not hurt).
>>>
>>> The doc looks clear enough to me. It says:
>>>
>>> if condition=2C then
>>>      do 1
>>>      do 2
>>>      do 3
>>>
>>> if condition is not true=2C there is no reason to do 1=2C 2=2C or 3.
>>>
>>> perhaps you want me to add
>>>
>>> else
>>>      do nothing
>>> ?
>>>
>>> As a C programmer=2C do you put=2C
>>>       else
>>> 	=3B
>>> To all your ifs with no else ?
>>>
>>
>> Maybe I was not expecting the doc to be structured in a coding language =
way.
>> But that's ok=2C now I know it=2C the doc make sense :)
>
> Well=2C I am sorry=2C I am unable to communicate in a language where the
> (universal) rules of logic do not apply. I suspect very few people
> can.
>
I don't think it is about that.
What i am saying is the doc does not need to follow the coding structure.
I think what I take from it (and I tend to forget) is that the doc is=20
for specific port and does not mean to be generic.
And like you said it is difficult to maintain such doc.

Maybe a solution would be to have one doc per target. For example=2C when=20
people propose a port=2C get them to also produce a one page document to=20
add on to your website.
This would create a database of port for different targets.
Users would be then able to browse the port document that matches his=20
target as much as possible.

That way=2C the port's document will be simpler=2C and only focus on the=20
target changes (one doc per port).

I think that could help.
The port's doc won't need to change unless fixes are added to that=20
specific target's port.

>>
>> the doc focus on the handle_fasteoi_irq (and briefly handle_edge_irq)=2C
>> there are other flow handler that could use some more porting details:
>>
>> if (handle =3D=3D handle_percpu_irq ||
>> 	handle =3D=3D handle_percpu_devid_irq) {
>> 	if (irq_desc_get_chip(desc) &&
>> 		irq_desc_get_chip(desc)->irq_hold) {
>> 			desc->ipipe_ack =3D __ipipe_ack_fasteoi_irq=3B
>> 			desc->ipipe_end =3D __ipipe_end_fasteoi_irq=3B
>> 		} else {
>> 			desc->ipipe_ack =3D __ipipe_ack_percpu_irq=3B
>> 			desc->ipipe_end =3D __ipipe_nop_irq=3B
>> 		}
>>
>> In the RPI2 case=2C it needs to have two chipirq=2C one for the
>> handle_percpu_devid_irq and one for the handle_level_irq.
>>
>> reading the doc=2C I have assumed (wrongly) that the handle_level_irq
>> could also be using the same chipirq than the handle_percpu_devid_irq
>> since the doc did not say otherwise.
>>
>> For the RPI2=2C both handle_level_irq and handle_percpu_devid_irq are
>> using the same chipirq already so when I ported ipipe to it=2C nothing w=
as
>> mentioned for handle_percpu_devid_irq which I learned by reading the
>> code (see copy past above).
>>
>> So the part of the doc that says: "if the flow handler is
>> =93handle_edge_irq=94=2C and the systems locks up when the first interru=
pt
>> happens=2C try replacing =93handle_edge_irq=94 with =93handle_level_irq=
=94.
>>
>> could use some additional clarification as follow: "...=2C try replacing
>> =93handle_edge_irq=94 with =93handle_level_irq=94 since those should not=
 have
>> any call to ipipe_lock_irq/ipipe_unlock_irq in their respective irqchip
>> handler irq_mask/irq_unmask".
>>
>> Also=2C a mention to handle_percpu_devid_irq could be added as follow:
>> "If the flow handler is =93handle_fasteoi_irq=94  or
>> "handle_percpu_devid_irq" or "handle_percpu_irq"=2C the implementation o=
f
>> the =93struct irq_chip=94 members should be modified".
>
> the struct irq_chip CAN be modified. The code posted above shows
> that the I-pipe also supports the case where you do not implement
> irq_hold/irq_release. If you implement them=2C you can put an
> ipipe_lock/unlock in mask/unmask. If you don't=2C then you can't.
>
I do have the hold implemented=2C I think that is why it works for the=20
handle_percpu_devid_irq in my case.
But if I understand correctly=2C you are saying from your comment below=2C =
I=20
could get away with only the mask that does not call the irq_hold.
That would simplify things=2C only one chipirq=2C no irq_hold.

So then=2C when does one need irq_hold?

>>
>> Just a suggestion.
>> I just fell into a crack and I am proposing a change so that others
>> don't do the same mistake.
>>
>>
>>>>
>>>> Just to confirm=2C you were saying "it should not call irqchip->mask=
=2C but
>>>> irqchip->ipipe_ack".
>>>> But for handle_level_irq the mask and the ack are called.
>>>> Is that correct?
>>>
>>> The answer is in the implementation of ipipe_ack for level
>>> interrupts. It calls mask_ack_irq.
>>>
>> Correct=2C so it does call mask=2C but you said it does not earlier.
>
> I meant that the mask callback is not called directly. The mask
> callback being called directly would be the sign that the I-pipe
> somehow does not do its work of interposing in the interruption
> handling=2C which can happen during a port for a variety of reasons.
>
the "mask callback is not called directly" here you mean mask callback=20
is not called but as part of __ipipe_dispatch_irq.
I think we are on the same page.

>>
>>>>
>>>> I think understand what my mistake was.
>>>> I have not tested it yet but without the irq_lock=2C it should call th=
e
>>>> handler.
>>>> Thank you Gilles again!
>>>
>>> You are welcome. I suggest however to take the time to read the
>>> documentation completely from beginning to end=2C before jumping
>>> head-on in the port=2C only reading parts of it=2C and wasting time
>>> stupidly because you only read part of a sentence.
>>>
>> It was not a waste of time to me=2C I got the opportunity to look at the
>> internal of the ipipe code to understand what my problem was.
>> I see this has a learning exercise (at spare time).
>>
>> The code is well written.
>> Writing a porting guide is difficult because it does not cover newer
>> targets implementation. The document could still evolve with user's
>> input. After all=2C I think the goal is to encourage users to create mor=
e
>> port.
>
> Writing a porting guide is easy. Keeping it up to date is what's
> hard. When that guide was first written=2C I had never ported the
> I-pipe to any ARM board which used handle_percpu_devid_irq=2C I am not
> even sure the kernel used it on any ARM platform.
>
> Anyway=2C I am interested by your contribution=2C but as it is=2C I am
> afraid you still misunderstood.
>
Please explain one more time=2C I really would like to understand :)
I like what you guys are doing.
the RPI2 uses handle_percpu_devid_irq for the local=20
timers/counters/IPI/videocore.

Once I get something working=2C I definitely will send you a patch for you=
=20
guys to review.

>>
>> Side note: with two irqchip (one for handle_level_irq that does not
>> lock_irq in mask and the one for handle_percpu_devid_irq that does the
>> lock_irq in mask()) it does work.
>
> You can probably have only one irqchip and not bother to insert the
> calls to ipipe_lock/unlock_irq.

Ok=2C this is new peace of information=2C that would work too. But then=2C=
=20
when one needs a lock_irq in mask and one does not?
(it is the same question as 2 comments above.


