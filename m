References: <56358DE3.8030308@hotmail.com>
 <BLU437-SMTP82C3E059EB476E2624582EF02C0@phx.gbl>
 <BLU437-SMTP38CA2663CEF65BBDBD9AFCF02C0@phx.gbl>
 <BLU437-SMTP11676D7F7E77869B206F3AF02C0@phx.gbl>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <56377DF5.5090202@xenomai.org>
Date: Mon, 2 Nov 2015 16:15:01 +0100
MIME-Version: 1.0
In-Reply-To: <BLU437-SMTP11676D7F7E77869B206F3AF02C0@phx.gbl>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
To: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>, xenomai@xenomai.org

On 11/02/2015 06:23 AM, Mathieu Rondonneau wrote:
> On 15-11-01 07:21 PM, Mathieu Rondonneau wrote:
>> On 15-11-01 06:58 PM, Mathieu Rondonneau wrote:
>>> On 15-10-31 08:58 PM, Mathieu Rondonneau wrote:
>>>> Hi,
>>>>
>>>> irq handlers registered with devm_request_threaded_irq does not get
>>>> triggered when interrupt fires.
>>>>
>>>> The mmc driver uses this (can not load the rootfs).
>>>> Only the IPIPE patch is enabled.
>>>> the armctrl chipirq is triggering the .ack handler instead so the
>>>> interrupt is happening.
>>>>
>>>> Any suggestion on where I should look? how is this supported by the
>>>> ipipe layer?
>>>>
>>>> Thanks,
>>>> -Mathieu
>>>
>>> I think I might have answered my own question.
>>> Looks like I need to use ipipe_request_irq() instead.
>>>
>>> Regards,
>>> -Mathieu
>> mmmm it is not true, it seems we still need a
>> ipipe_request_threaded_irq() to call the ackfn, put the handler in the
>> queue and wake up the thread once handler is executed. Or user will have
>> to move this functionality into their driver's IRQ handler.
>>
>> It strangely looks like ipipe_request_irq's idea is similar to what
>> request_threaded_irq is already doing (delaying IRQ process later).
>>
>> -Mathieu
> Looks like my bigger problem is that the handler_level_irq is not
> called. Only the timer handler is called (handler_percpu_devid_irq).

Which may mean that the regular IRQ top half for that interrupt source
is not connected to the pipeline. You may want to check whether the
irqchip handling that device's IRQs has been made aware of the interrupt
pipeline.

-- 
Philippe.

