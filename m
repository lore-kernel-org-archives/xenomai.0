Message-ID: <474D499D.3090204@domain.hid>
Date: Wed, 28 Nov 2007 11:57:33 +0100
From: Philippe Gerum <philippe.gerum@domain.hid>
MIME-Version: 1.0
References: <BF58A8AFB316514587D61EADBFBF4C410165FD61@domain.hid>
In-Reply-To: <BF58A8AFB316514587D61EADBFBF4C410165FD61@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Interrupts lost during sleep / unblock cycles
Reply-To: philippe.gerum@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kyle Howell <khowell@domain.hid>
Cc: xenomai@xenomai.org

Kyle Howell wrote:
>>  > >  > I have been debugging a stall problem for a couple of 
>>  > > days, and I think  > I've put together enough info to check 
>>  > > with the pros. Everything below  > was experienced on a P4 
>>  > > (Celeron) running 2.6.20 / Xenomai 2.3.4. I've  > also 
>>  > > reproduced it on 2.6.19.7 / 2.3.1. A quick test *did not* 
>>  > > reproduce  > this problem on a Core2 running x86_64 2.6.22.9 
>>  > > / 2.4RC3. 
>>  > >  >
>>  > >  > I've reduced the problem to a fairly simple example below:
>>  > >  >
>>  > >  > The Overview:
>>  > >  > - Running a single real-time process with one standard 
>>  > > thread and one RT  > task  > - The RT task loops on a 1sec 
>>  > > rt_task_sleep  > - The standard thread loops on 
>>  > > nanosleep(10msec) and rt_task_unblock of  > the RT task.
>>  > >  > - When an unrelated interrupt arrives at the wrong time, 
>>  > > the entire  > system will hang until the 1sec task_sleep expires.
>>  > >  > - After resuming, everything runs normally until another 
>>  > > interrupt lands  > at the wrong moment.
>>  > > 
>>  > > Do you observe the same behaviour without the interrupt shield ?
>>  > 
>>  > It doesn't appear so. I'll have to let it run longer to be 
>> 100% sure,
>>  > but the usual stressing isn't causing the problem. That's 
>> not expected
>>  > behavior with the interrupt shield, is it?
>>
>> No, it is not an expected behavior.
>>
> 
> After considerable staring and code surfing, I think I have an idea of
> what's happening. There are still enough parts of the code I don't fully
> undertand that I'm not positive, though. Check this theory out for me:
> 
> Flow of events when it works:
> 1. Process running in root domain.
> 2. Interrupt fires, IShield pending bit set.
> 3. ipipe_walk_pipeline calls IShield handler.
> 4. IShield propagates interrupt to root domain.
> 5. Root domain finishes restoring the APIC.
> 6. Everything continues as expected.
>  - or -
> 1. Process running in Xenomai domain.
> 2. Interrupt fires, IShield pending bit set.
> 3. ipipe_walk_pipeline resumes high-priority Xenomai domain.
> 4. Xenomai domain finishes and suspends.
> 3. ipipe_walk_pipeline calls IShield handler.
> 4. IShield propagates interrupt to root domain.
> 5. Root domain finishes restoring the APIC.
> 6. Everything continues as expected.
> 
> Flow of events when it fails:
> 1. Process running in root domain, makes syscall *requiring Xenomai
> domain*.
> 2. Thread is temporarily promoted to Xenomai domain to execute syscall.
> 3. (Optional) Syscall results in another Xenomai task gaining control.
> 3. Interrupt fires, IShield pending bit set.
> 4. ipipe_walk_pipeline resumes high-priority Xenomai domain.
> 5. (Optional) Other Xenomai task completes, promoted syscall resumes.
> 6. Syscall returns to root domain, never calling ipipe_sync_pipeline on
> IShield domain.
> 7. Root domain sleeps without ever restoring the APIC.
> 8. System hangs until event-timer fires for Xenomai task.
> 9. Xenomai task finishes and suspends.
> 10. ipipe_walk_pipeline calls Ishield handler.
> 11. IShield propagates interrupt to root domain.
> 12. Root domain finishes restoring the APIC.
> 13. Everything continues as expected.
> 
> To put it in a sentence, it looks like there's a loop-hole where a
> promoted syscall can get back to the root domain without the
> intermediate domains being checked for pending interrupts.

Your analysis makes a lot of sense, even if I can't spot the loophole
immediately in the I-pipe code.

 The propagate
> logic in ipipe_dispatch_event *seems* like it would take care of this,

This routine is indeed where I would point my finger at, as a first
guess. As you explained, it does look like an adverse effect of domain
migration taking some sideway in the pipeline logic, which ends up
breaking the propagation of events. Normally, the interrupt shield
domain is never stalled, so the only reason for such issue to pop up
could only be due to this domain being bypassed somehow.

-- 
Philippe.

