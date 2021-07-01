References: <558c11ab-794c-29f6-be73-6045a0b90198@siemens.com>
 <87wnqbgs91.fsf@xenomai.org> <87tulfgrzh.fsf@xenomai.org>
 <b2fac120-76d8-5501-cbfe-a8e5d40ef5a9@siemens.com>
 <87pmw2h4pf.fsf@xenomai.org>
 <f07feb5a-a160-e516-a3ab-f708ca85ec24@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: resume_oob_task & not actually resuming
In-reply-to: <f07feb5a-a160-e516-a3ab-f708ca85ec24@siemens.com>
Date: Thu, 01 Jul 2021 10:08:16 +0200
Message-ID: <87k0mah2xb.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 01.07.21 09:29, Philippe Gerum wrote:
>> 
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>>> On 30.06.21 19:52, Philippe Gerum wrote:
>>>>
>>>> Philippe Gerum via Xenomai <xenomai@xenomai.org> writes:
>>>>
>>>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>>>
>>>>>> Hi Philippe,
>>>>>>
>>>>>> need you guidance here to fix the "thread ... switched to non-rt CPU,
>>>>>> aborted" issue:
>>>>>>
>>>>>> For some reason, I-pipe is fine and kicks the migrating non-rt task
>>>>>> again when ipipe_migration_hook() does not resume the target thread due
>>>>>> to failing cobalt_affinity_ok() check. Over dovetail, this is not
>>>>>> working, and the thread is stuck in nirvana, i.e. suspended as hardened
>>>>>> from Linux POV but not resumed on the Xenomai side. Looking at how
>>>>>> finalize_oob_transition() is called in the dovetail kernel, it does not
>>>>>> seem like it is prepared for not being in oob after that call
>>>>>> (finish_task_switch is not called - not sure if that makes the difference).
>>>>>>
>>>>>> So, either the point of checking and failing the migration in Xenomai is
>>>>>> wrong for dovetail, or we need some extension of the latter to account
>>>>>> for that case. What was the intended design?
>>>>>>
>>>>>
>>>>> Dovetail has it right, Cobalt is wrong in this case. Cobalt-wise: we
>>>>> should always 1) raise a cancellation request upon any issue with
>>>>> switching to the oob stage on behalf of resume_oob_task(), 2) lift the
>>>>> XNRELAX suspension bit, 3) detect the pending cancellation in
>>>>> xnshadow_harden(), forcing the current thread to exit. I did not dive
>>>>> into the details yet, but I suspect that Cobalt might be lucky with the
>>>>> I-pipe in skipping xnthread_resume() upon failure (some pending signal,
>>>>> forcing sigwake maybe?).
>>>>>
>>>>> IOW, we should complete the switch to oob in any case, then kick out the
>>>>> thread with a bad affinity when unwinding from xnshadow_harden().
>>>>
>>>> Of course, this means that all runqueues must be built for all possible
>>>> CPUs, NOT restricted to the CPUs which are part of the oob-capable
>>>> set. Cobalt sets up a runqueue for each online CPU in xnsched_init_all()
>>>> which is more restrictive, but that should still work provided the
>>>> hot-plug scenario is dismissed.
>>>
>>> The hot-plug scenario cannot be dismissed, obviously. It was one of
>>> motivations to enable partial CPU sets.
>>>
>> 
>> I did not know that. I-pipe wise, how/when are we turning on the per-cpu
>> tick diversion for a new CPU when it appears, so that such CPU can run
>> Xenomai threads?
>
> We never supported running Xenomai on hot-pluggable CPUs, but we allowed
> to turn "unsupported" CPUs off/on.
>

Ok, so this is not quite hotplug support just yet.

>> 
>>> I don't think we are on the right way yet. Can't we prevent entering the
>>> migration procedure in the first place when detecting affinity issues?
>>> That would be way cleaner than letting a misguided thread pop up on a
>>> CPU it does not belong or creating data structures (or even more) for
>>> CPUs Xenomai has no business in.
>> 
>> I'm not sure this would be any cleaner: there are internal callers
>> fixing up the thread affinity via do_set_cpus_allowed(), which might
>> then start receiving failure codes returned by some Dovetail hook
>> denying the move, then what should they do?
>> 
>> The upside of checking the affinity when a thread actually moves back to
>> oob context is that we can catch any wrongful situation, without
>> sprinkling the in-band code with checks and hooks, playing whack-a-mole
>> with issues induced by upstream changes.
>
> The problem remains that we cannot schedule RT threads on an unsupported
> cores. That breaks the concept of "supported_cpus", which is our way to
> ensure (non-RT) scalability and avoid any co-kernel overhead for those
> unaffected cores.

Sure, this is why such threads violating their real-time affinity are
bumped out when detected.

>
>> 
>> Before anything, this hunk should be merged into the Dovetail code
>> before testing...
>> 
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index ee6fe5e9c7faaaf..891398dc63aec07 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -2384,9 +2384,9 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>>  
>>  	__do_set_cpus_allowed(p, new_mask, flags);
>>  
>> -	return affine_move_task(rq, p, &rf, dest_cpu, flags);
>> -
>>  	inband_migration_notify(p, dest_cpu);
>> +
>> +	return affine_move_task(rq, p, &rf, dest_cpu, flags);
>>  out:
>>  	task_rq_unlock(rq, p, &rf);
>>  
>> 
>
> No compliler warned about dead code?

Nope,

gcc (GCC) 11.1.1 20210531 (Red Hat 11.1.1-3)

> But that's 5.13-only, right? 5.10 is not affected.

Correct.

-- 
Philippe.

