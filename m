Message-ID: <479B7938.2000206@domain.hid>
Date: Sat, 26 Jan 2008 19:17:28 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <2ff1a98a0801020231k19be7d89k1a6f04b7d497cc34@domain.hid>	
	<18315.63245.160672.547658@domain.hid>	
	<18326.21480.397736.413726@domain.hid>	
	<47977DE1.8060207@domain.hid>	
	<2ff1a98a0801230953m2a67e614s6c921b3b6ec77c3c@domain.hid>	
	<479788A5.80407@domain.hid>
	<2ff1a98a0801240218y1f09ae38w93e244a47218900@domain.hid>
In-Reply-To: <2ff1a98a0801240218y1f09ae38w93e244a47218900@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] High latencies on ARM.
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> On Jan 23, 2008 7:34 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>> Gilles Chanteperdrix wrote:
>>> On Jan 23, 2008 6:48 PM, Philippe Gerum <rpm@xenomai.org> wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>  > Please find attached a patch implementing these ideas. This adds some
>>>>>  > clutter, which I would be happy to reduce. Better ideas are welcome.
>>>>>  >
>>>>>
>>>>> Ok. New version of the patch, this time split in two parts, should
>>>>> hopefully make it more readable.
>>>>>
>>>> Ack. I'd suggest the following:
>>>>
>>>> - let's have a rate limiter when walking the zombie queue in
>>>> __xnpod_finalize_zombies. We hold the superlock here, and what the patch
>>>> also introduces is the potential for flushing more than a single TCB at
>>>> a time, which might not always be a cheap operation, depending on which
>>>> cra^H^Hode runs on behalf of the deletion hooks for instance. We may
>>>> take for granted that no sane code would continuously create more
>>>> threads than we would be able to finalize in a given time frame anyway.
>>> The maximum number of zombies in the queue is
>>> 1 + XNARCH_WANT_UNLOCKED_CTXSW, since a zombie is added to the queue
>>> only if a deleted thread is xnpod_current_thread(), or if the XNLOCKSW
>>> bit is armed.
>> Ack. rate_limit = 1? I'm really reluctant to increase the WCET here,
>> thread deletion isn't cheap already.
> 
> I am not sure that holding the nklock while we run the thread deletion
> hooks is really needed.
> 

Deletion hooks may currently rely on the following assumptions when running:

- rescheduling is locked
- nklock is held, interrupts are off
- they run on behalf of the deletor context

The self-delete refactoring currently kills #3 because we now run the
hooks after the context switch, and would also kill #2 if we did not
hold the nklock (btw, enabling the nucleus debug while running with this
patch should raise an abort, from xnshadow_unmap, due to the second
assertion).

It should be possible to get rid of #3 for xnshadow_unmap (serious
testing needed here), but we would have to grab the nklock from this
routine anyway.

-- 
Philippe.

