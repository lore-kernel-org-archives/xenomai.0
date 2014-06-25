Message-ID: <53AA7F39.90706@axelsw.it>
Date: Wed, 25 Jun 2014 09:50:17 +0200
From: Marco Tessore <marco.tessore@axelsw.it>
MIME-Version: 1.0
References: <53A3FAB0.4050100@axelsw.it> <53A4207F.9040801@xenomai.org>
 <53A9AA38.3090005@axelsw.it> <53A9B0FB.1070809@xenomai.org>
In-Reply-To: <53A9B0FB.1070809@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Kernel freezes in __ipipe_sync_stage
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

Il 24/06/2014 19:10, Philippe Gerum ha scritto:
> On 06/24/2014 06:41 PM, Marco Tessore wrote:
>> Hi,
>>
>> Il 20/06/2014 13:52, Gilles Chanteperdrix ha scritto:
>>> On 06/20/2014 11:11 AM, Marco Tessore wrote:
>>>> The kernel is version 2.6.31 for ARM architecture - specifically a
>>> Do you have the same problem with a recent I-pipe patches, like one for
>>> 3.8 or 3.10 kernel?
>>>
>>
>> I managed to do some tests on 3.10 kernel but on onother board with
>> imx28 CPU, actually it happens that that kernel freezes too,
>> but I haven't debugged it with the jtag debugger.
>>
>> I have, instead, some information on the original problem, that is the
>> one that worried me more:
>>
>> In summary:
>> I have a board based on imx25, with kernel 2.6.31, Xenomai 2.5.6 and
>> ipipe patch 1.16-02.
>>
>> Rarely, but often enough to be a problem, the kernel freezes at boot.
>> Thanks to a JTAG debugger I'm able to observe the kernel in the
>> following situation:
>> I'm in an infinite loop with the following stack trace:
>> __ipipe_set_irqpending
>> xnintr_host_tick (__ipipe_propagate_irq)
>> xnintr_clock_handler
>> __ipipe_sync_stage    <- (1)
>> ipipe_suspend_domain
>> __ipipe_walk_pipeline
>> __ipipe_restore_pipeline_head
>> xnarch_next_tick_shot
>> clockevents_program_event
>> tick_dev_program_event
>> hrtimer_interrupt
>> mxc_interrupt
>> handle_IRQ_event
>> handle_level_irq
>> asm_do_IRQ
>> __ipipe_sync_stage <- (2)
>> ipipe_suspend_domain
>> __ipipe_walk_pipeline
>> __ipipe_restore_pipeline_head
>> xnpod_enable_timesource
>> xnpod_init
>> __native_skin_init
>> ...
>> ...
>>
>> Specifically, it happens that the first call to __ipipe_sync_stage, the
>> one marked with the number (2), is working on a stage that I can not
>> determine,
>> let's say for convenience stage S1, I think is the Linux secondary
>> domain but I'm not sure,
>> so the function invokes the interrupt handler of the system timer.
>> Continuing in the stack trace, I have a nested call to
>> __ipipe_sync_stage, indicated with (1),
>> but this call works on another stage, for convenience domain S2,
>> in turn this function invokes a handler for the timer irq, which at a
>> certain point invokes the __ipipe_propagate_irq which raises the flags
>> for the stage S1,
>> thus making the first call to __ipipe_sync_stage (2) fails to get out of
>> their while loops.
>>
>> I should add that I do not see hardware interrupt for the timer in
>> function __ipipe_grab_IRQ.
>> I have no idea how the cycle is triggered,but when the kernel is locked,
>> the kernel is located in the software exclusively infinite loop
>> described above.
>>
>>
>> In the hope that you could help me understand what is going on,
>> I would have liked groped a patch like this:
>> - Store, for each level of nesting of __ipipe_sync_stage, the irq number
>> currently running and on behalf of which stage.
>> - Patch the function __ipipe_set_irqpending in such a way as not to set
>> the flags for the pair (irq, stage) if the pair is already present at
>> some level in the current stack trace, that is,
>> - if the function __ipipe_sync_stage is executing the handler for a
>> stage, and then he had reset the flags in irqpend_himask and
>> irqpend_lomask, it does not expect the handler goes to raise again the
>> same flag for the same stage.
>>
>> What do you think about this?
>>
>> Thank you very much for any kind of advice you could give me
>>
>
> You mentioned random lockups during boot. Does you board ever lock up 
> when passing xeno_hal.disable=1 on the kernel command line?
>
Yes, I mentioned random lockups, but always the kernel enters in the 
infinite loop described above.
Following your suggestion I tried to pass parameter xeno_hal.disable=1 
but kernel sayed
"Unknown boot option `xeno_hal.disable=1': ignoring"

What is supposed to do this option anyway? If it would disable HAL, does 
not this inhibits xenomai realtime services?

What about the patch,described above, that I would apply? say, don't 
permit that the interrupt handlers called in __ipipe_sync_stage raise a 
couple (stage, irq) already handled in the current stack?

Thank you
Marco Tessore


