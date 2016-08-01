References: <20160709132949.GA22236@hermes.click-hack.org>
 <20160801132946.368f30eb@md1em3qc>
 <20160801123510.jxujyigrecnbpkiy@hermes.click-hack.org>
 <64e9fed7-ae79-b7fc-04f7-0e74ef1c9239@siemens.com>
 <20160801140555.7wtzxtbqnd7iecd6@hermes.click-hack.org>
 <2930884c-9198-1da8-40ab-b9ad8bd360e0@siemens.com>
 <20160801173334.v5twlqgs73obpeup@hermes.click-hack.org>
 <2b4ba869-5e35-9a23-aaa2-bf4b7096a480@siemens.com>
 <20160801192343.z2kkr2zhlis7gkoz@hermes.click-hack.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e08d5e7f-e031-102b-c582-e93a77de1c9a@siemens.com>
Date: Mon, 1 Aug 2016 21:58:34 +0200
MIME-Version: 1.0
In-Reply-To: <20160801192343.z2kkr2zhlis7gkoz@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Announce] Xenomai 2.6.5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2016-08-01 21:23, Gilles Chanteperdrix wrote:
> On Mon, Aug 01, 2016 at 09:04:55PM +0200, Jan Kiszka wrote:
>> On 2016-08-01 19:33, Gilles Chanteperdrix wrote:
>>> On Mon, Aug 01, 2016 at 07:18:36PM +0200, Jan Kiszka wrote:
>>>> On 2016-08-01 16:05, Gilles Chanteperdrix wrote:
>>>>> On Mon, Aug 01, 2016 at 02:58:54PM +0200, Jan Kiszka wrote:
>>>>>> On 2016-08-01 14:35, Gilles Chanteperdrix wrote:
>>>>>>> On Mon, Aug 01, 2016 at 01:29:46PM +0200, Henning Schild wrote:
>>>>>>>> Hey Gilles,
>>>>>>>>
>>>>>>>> i just checked out the new release, which came as a surprise. Thanks
>>>>>>>> for publishing that!
>>>>>>>>
>>>>>>>> Some of the patches prepare for kernel 4.0+ but one specifically makes
>>>>>>>> sure the combination 4.0+ and 2.6.5 wont work.
>>>>>>>>
>>>>>>>> Am Sat, 9 Jul 2016 15:29:49 +0200
>>>>>>>> schrieb Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>>>>>>>>
>>>>>>>> ...
>>>>>>>>>       hal/x86: forbid compilation with Linux 4.0+
>>>>>>>> ...
>>>>>>>>
>>>>>>>> Could you please provide details on how the FPU support is broken. I am
>>>>>>>> successfully using xenomai 2.6 with 4.1.18 for some time now. I am not
>>>>>>>> sure whether the applications on top use the FPU and if so, if there
>>>>>>>> are multiple FPU-users per core.
>>>>>>>
>>>>>>> The FPU support is broken in the way it detects that Linux was using
>>>>>>> FPU in kernel-space (for RAID, or memcpy on oldish AMD processors,
>>>>>>> geode, K6, etc...) when Linux gets preempted. We can no longer rely
>>>>>>> on checking the bit TS in CR0, and need instead to use an accessor
>>>>>>> that was added in the I-pipe patch to know that. For details, see
>>>>>>> the changes that were made to FPU support for x86 in Xenomai 3.x.
>>>>>>>
>>>>>>
>>>>>> Are we doing eager switching there already? Would allow to use things
>>>>>> as-is (i.e. without having to trap FPU accesses) on CPUs that are recent
>>>>>> enough to do this switching lazily in hardware.
>>>>>
>>>>> The problem has nothing to do with trapping FPU accesses or eager
>>>>> switching. Xenomai has always done eager switching. Xenomai 3 traps
>>>>> fpu access in order to arm the XNFPU bit on first fpu use and then
>>>>> does eager switching as usual.
>>>>
>>>> Eager means always switch on flipping the context, irrespective of the
>>>> previous usage. There is no trapping of FPU usage anymore then. Hardware
>>>> does this much faster today when using xsave. Therefore upstream moved
>>>> away from the lazy pattern apparently also still used in Xenomai.
>>>
>>> I know what eager means and Xenomai has always switched eagerly. But
>>> the difference with Linux is that a Xenomai task has an XNFPU bit
>>> indicating whether it wants to use the FPU or not. And obviously we
>>> do not switch eagerly FPU for tasks which do not have the XNFPU bit.
>>>
>>> Now, in Xenomai 2.x the XNFPU bit was systematically set for
>>> user-space tasks, so that Xenomai always switched eagerly FPU for
>>> user-space tasks. With Xenomai 3, the change I have made for x86 and
>>> ARM is that a user-space task starts without the XNFPU bit, and if
>>> it uses the FPU once, it gets the trap, the XNFPU is set, then it
>>> gets eager switches forever after. So, it only gets a trap once.
>>> Now, that means that you have to pay the price of a fault, once. So,
>>> to do even better, Philippe has proposed to add the XNFPU bit to
>>> pthread_set_mode_np/rt_task_set_mode so that a user-space task can
>>> forcibly set the XNFPU bit.
>>>
>>> But clearly, Xenomai switches FPU eagerly, and always has.
>>>
>>> I am surprised to have to explain all this to you, I thought this
>>> was common knowledge.
>>>
>>
>> Commit 304bceda6a upstream:
>>
>>     x86, fpu: use non-lazy fpu restore for processors supporting xsave
>>     
>>     Fundamental model of the current Linux kernel is to lazily init and
>>     restore FPU instead of restoring the task state during context switch.
>>     This changes that fundamental lazy model to the non-lazy model for
>>     the processors supporting xsave feature.
>>     
>>     Reasons driving this model change are:
>>     
>>     i. Newer processors support optimized state save/restore using xsaveopt and
>>     xrstor by tracking the INIT state and MODIFIED state during context-switch.
>>     This is faster than modifying the cr0.TS bit which has serializing semantics.
>>     [...]
>>
>> (so it's xsaveopt, not just xsave - weak memory...)
>>
>> Eager switching in this context means *unconditionally* eager, just
>> dependent on the availability of this hardware feature, which is present
>> on all modern system, high-end or low-end (will check tomorrow if we
>> even have it on the Quark which is seriously low-end). This makes the
>> code much simpler than the semi-eager model of Xenomai, at least for
>> modern x86.
> 
> As usual, you are spreading nonsense. Xenomai has been eager all the
> time. The difference is:
> - Linux kernel threads do not have an FPU context
> - Xenomai threads without the XNFPU bit do not have an FPU context.
> 
> So Xenomai, like Linux, chooses who has an FPU context that needs to
> be switched. And it has always been done it like that. Linux, like
> Xenomai, is conditionally eager. Some Xenomai kernel threads do have
> an FPU context (still, even in Xenomai 3.x, even though I doubt
> anyone uses it, because compiling kernel modules to use the FPU is
> probably not an easy task). Historically, all user-space threads had
> an FPU context (and were switched eagerly, not semi-anything).
> 
> What has changed is that in Xenomai 3.x, I have decided to start
> user-space threads without an FPU context, because I thought not
> all of them use it. This may add some overhead on the first FPU use,
> but after that, we switch eagerly. And if need be, Philippe
> solution to force the bit can be implemented. Or the 2.x behaviour
> can be reverted. But please stop making it a big deal.
> 
> It is the third time I explain the same thing a different way. There
> will not be a fourth time. I will not answer your next mail.

Sorry if I wasn't clear enough. I can only recommend to re-read the
Xenomai code, specifically xnarch_switch_to (hint: clts, stts...), and
then compare to the upstream kernel again and the commit I cited. It's
probably best you figure this out yourself.

> 
>>
>> So the question here is not about low- vs. high-end but rather modern
>> vs. legacy. We can't remove the lazy model yet, but the eager makes
>> sense as well. Yes, this is an optimization (so is lazy switching), but
>> apparently even of the worst case (which is nothing lazy switching is
>> about) because we save the costly fiddling with cr0, unconditionally.
> 
> I think Atom processors can be considered "modern", but I doubt all
> off them have the new instructions. Especially the low power ones.
> And the embedded processors have always been Xenomai dual kernel
> targets. Because, on high-end processor, the differences in
> performances between dual kernel and native preemption are so
> ridiculously low.
> 
> And I think, with the dovetail project, this point is moot, because
> we are going to stop duplicating the FPU support in Xenomai code,
> which has been a pain to maintain, really, and get the I-pipe patch
> to provide access to Linux FPU handling code to the head domain. So,
> we are going to use the new instructions, without having to reinvent
> the wheel once again.
> 

That will indeed resolve this issue elegantly.

Jan

