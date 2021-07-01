Subject: Re: resume_oob_task & not actually resuming
References: <558c11ab-794c-29f6-be73-6045a0b90198@siemens.com>
 <87wnqbgs91.fsf@xenomai.org> <87tulfgrzh.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b2fac120-76d8-5501-cbfe-a8e5d40ef5a9@siemens.com>
Date: Thu, 1 Jul 2021 08:11:05 +0200
MIME-Version: 1.0
In-Reply-To: <87tulfgrzh.fsf@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 30.06.21 19:52, Philippe Gerum wrote:
> 
> Philippe Gerum via Xenomai <xenomai@xenomai.org> writes:
> 
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>
>>> Hi Philippe,
>>>
>>> need you guidance here to fix the "thread ... switched to non-rt CPU,
>>> aborted" issue:
>>>
>>> For some reason, I-pipe is fine and kicks the migrating non-rt task
>>> again when ipipe_migration_hook() does not resume the target thread due
>>> to failing cobalt_affinity_ok() check. Over dovetail, this is not
>>> working, and the thread is stuck in nirvana, i.e. suspended as hardened
>>> from Linux POV but not resumed on the Xenomai side. Looking at how
>>> finalize_oob_transition() is called in the dovetail kernel, it does not
>>> seem like it is prepared for not being in oob after that call
>>> (finish_task_switch is not called - not sure if that makes the difference).
>>>
>>> So, either the point of checking and failing the migration in Xenomai is
>>> wrong for dovetail, or we need some extension of the latter to account
>>> for that case. What was the intended design?
>>>
>>
>> Dovetail has it right, Cobalt is wrong in this case. Cobalt-wise: we
>> should always 1) raise a cancellation request upon any issue with
>> switching to the oob stage on behalf of resume_oob_task(), 2) lift the
>> XNRELAX suspension bit, 3) detect the pending cancellation in
>> xnshadow_harden(), forcing the current thread to exit. I did not dive
>> into the details yet, but I suspect that Cobalt might be lucky with the
>> I-pipe in skipping xnthread_resume() upon failure (some pending signal,
>> forcing sigwake maybe?).
>>
>> IOW, we should complete the switch to oob in any case, then kick out the
>> thread with a bad affinity when unwinding from xnshadow_harden().
> 
> Of course, this means that all runqueues must be built for all possible
> CPUs, NOT restricted to the CPUs which are part of the oob-capable
> set. Cobalt sets up a runqueue for each online CPU in xnsched_init_all()
> which is more restrictive, but that should still work provided the
> hot-plug scenario is dismissed.

The hot-plug scenario cannot be dismissed, obviously. It was one of
motivations to enable partial CPU sets.

I don't think we are on the right way yet. Can't we prevent entering the
migration procedure in the first place when detecting affinity issues?
That would be way cleaner than letting a misguided thread pop up on a
CPU it does not belong or creating data structures (or even more) for
CPUs Xenomai has no business in.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

