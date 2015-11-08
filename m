Message-ID: <BLU436-SMTP6F35FE1B18A156B3D57E4F0160@phx.gbl>
References: <56358DE3.8030308@hotmail.com>
 <BLU437-SMTP82C3E059EB476E2624582EF02C0@phx.gbl>
 <BLU437-SMTP38CA2663CEF65BBDBD9AFCF02C0@phx.gbl>
 <BLU437-SMTP11676D7F7E77869B206F3AF02C0@phx.gbl>
 <56377DF5.5090202@xenomai.org>
 <BLU437-SMTP10132C0DA57E69E6D1C8359F02A0@phx.gbl>
 <20151104070414.GD24848@hermes.click-hack.org>
 <BLU436-SMTP43B29DB76F59896D9FB7C0F0290@phx.gbl>
 <BLU436-SMTP73BE7B77324E5FEB445F80F0290@phx.gbl>
From: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Date: Sat, 7 Nov 2015 21:55:48 -0800
MIME-Version: 1.0
In-Reply-To: <BLU436-SMTP73BE7B77324E5FEB445F80F0290@phx.gbl>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
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

On 15-11-04 10:08 PM, Mathieu Rondonneau wrote:
> On 15-11-04 04:51 PM, Mathieu Rondonneau wrote:
>> On 15-11-03 11:04 PM, Gilles Chanteperdrix wrote:
>>> On Tue, Nov 03, 2015 at 07:18:37PM -0800, Mathieu Rondonneau wrote:
>>>> On 15-11-02 07:15 AM, Philippe Gerum wrote:
>>>>> On 11/02/2015 06:23 AM, Mathieu Rondonneau wrote:
>>>>>> On 15-11-01 07:21 PM, Mathieu Rondonneau wrote:
>>>>>>> On 15-11-01 06:58 PM, Mathieu Rondonneau wrote:
>>>>>>>> On 15-10-31 08:58 PM, Mathieu Rondonneau wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> irq handlers registered with devm_request_threaded_irq does not
>>>>>>>>> get
>>>>>>>>> triggered when interrupt fires.
>>>>>>>>>
>>>>>>>>> The mmc driver uses this (can not load the rootfs).
>>>>>>>>> Only the IPIPE patch is enabled.
>>>>>>>>> the armctrl chipirq is triggering the .ack handler instead so the
>>>>>>>>> interrupt is happening.
>>>>>>>>>
>>>>>>>>> Any suggestion on where I should look? how is this supported by
>>>>>>>>> the
>>>>>>>>> ipipe layer?
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> -Mathieu
>>>>>>>>
>>>>>>>> I think I might have answered my own question.
>>>>>>>> Looks like I need to use ipipe_request_irq() instead.
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> -Mathieu
>>>>>>> mmmm it is not true, it seems we still need a
>>>>>>> ipipe_request_threaded_irq() to call the ackfn, put the handler in
>>>>>>> the
>>>>>>> queue and wake up the thread once handler is executed. Or user
>>>>>>> will have
>>>>>>> to move this functionality into their driver's IRQ handler.
>>>>>>>
>>>>>>> It strangely looks like ipipe_request_irq's idea is similar to what
>>>>>>> request_threaded_irq is already doing (delaying IRQ process later).
>>>>>>>
>>>>>>> -Mathieu
>>>>>> Looks like my bigger problem is that the handler_level_irq is not
>>>>>> called. Only the timer handler is called (handler_percpu_devid_irq).
>>>>>
>>>>> Which may mean that the regular IRQ top half for that interrupt source
>>>>> is not connected to the pipeline. You may want to check whether the
>>>>> irqchip handling that device's IRQs has been made aware of the
>>>>> interrupt
>>>>> pipeline.
>>>>>
>>>>
>>>> Thanks for replying Philippe,
>>>> This is the think, I did change the arch_irq_default_handler to call
>>>> the
>>>> __ipipe_grab_irq and __ipipe_grab_ipi.
>>>> Is that what you are referring to when you say "interrupt source is not
>>>> connected to the pipile", that's what __ipipe_grab_xxx does isn't it?
>>>>
>>>> Obviously I am still missing something.
>>>> If I use irq_set_chained_handler in the driver then the handler gets
>>>> called but it's just replacing the handler_irq by the driver one.
>>>> When I use request_irq then it does not call my handler (the
>>>> action.handler one).
>>>> I will keep looking.
>>>
>>> This is explained here:
>>> http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/#GPIOs_as_interrupt_sources
>>>
>>>
>>> and here:
>>> http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/#CONFIG_MULTI_IRQ_HANDLER
>>>
>>>
>>>
>>> Chained handlers have to call ipipe_handle_demuxed_irq instead of
>>> generic_handle_irq.
>>> And the arch irq handler has to call ipipe_handle_multi_irq or
>>> ipipe_handle_multi_ipi instead of handle_IRQ
>>>
>>
>> Thanks Gilles for the pointers,
>> MULTI_IRQ_HANDLER is not enabled for RPI2 (so I did not look at the
>> multi_irq_handler section), is it a requirement for the ipipe patch to
>> work?
>>
>> For GPIO I got it to work, but it is easier to me because they have
>> their own irqchip.
>> It is the arch irq handler that cause me trouble.
>>
>> Maybe I just have to enable MULTI_IRQ_HANDLER.
>> I will play around with it.
>>
>> Thanks again for your feedback, it helps,
>> Regards,
>> -Mathieu
>>
>>
> Also confirming that the ipipe_handler_multi_irq and
> ipipe_handler_multi_ipi are called properly.
> so it looks like the arch irq handler is working as expected.
>
> it is the handle_level_irq that is not called properly when I use the
> request_irq in the driver.
> the desc->irq_data.chip->irq_ack is called properly but not the
> irqaction->handler (that is the handler of my driver) that should have
> been triggered by handle_level_irq.
>
> So I think my problem is that handle_level_irq() is not called.
> if I register my driver handler with irq_set_chained_handler then
> ipipe_handler_multi_irq is still called, but the
> desc->irq_data.chip->irq_ack does not get called and my driver handle
> gets called properly.
> In this case, the ipipe is bypassed it seems since if I understand
> correctly, the irq_ack is still expected to trigger.
>
> Maybe I am missing a ipipe_handle_demuxed_irq call in an interrupt
> handler that gets called before my driver interrupt handler gets a
> chance to get called.
>
> I have to look at what interrupt happens before mine.
>
> -Mathieu

more info:
1) interrupt (lets say #I) triggers, the ipipe_dispatch_irq calls the 
irqchip->mask() which calls ipipe_lock_irq (IPIPE_LOCK_FLAG is now set).
2) then the ipipe_dispatch_irq calls the __ipipe_set_irq_pending which 
moves the irq on the holding list because of 1).
3) then __ipipe_do_sync_stage does not call my irq handler because 
__ipipe_next_irq return -1 due to 2).

this is where I get stuck: some hw init code took a semaphore, the irq 
handler (for #I) (that is supposed to release a semaphore) never gets 
called.

In order to get back on the pending list, the irqchip->unmask must be 
called but I am not too sure when this is supposed to happen.
ideally, unmask should be called after the handler gets executed.
So it sounds to me a chicken and egg issue.

CONFIG_MULTI_IRQ_HANDLER is not set (although I don't think it matters).
this is with handle_level_irq.
handle_percpu_devid_irq works fine.
ipi path is also working fine.

any idea what I am missing?

Regards,
-Mathieu

