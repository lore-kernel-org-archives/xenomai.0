Subject: Re: [PATCH] cobalt/kernel: Simplify mayday processing
References: <3e868e4f-7bd5-2874-d72b-fc2449ef4b65@siemens.com>
 <111becaa-9e0f-f8ad-4802-62f51379fc07@xenomai.org>
 <efcd107e-d48d-6dac-96e0-890203c072ba@siemens.com>
 <5c1fae9d-3098-1f5b-bc51-fa7f9a798f1e@xenomai.org>
 <967ff4fb-2272-88be-f46c-4b7c40e64956@siemens.com>
 <bef5cc29-6379-8cd8-4a1e-4cc8a10761a4@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <6000a5c2-2944-d078-7df7-2efe271cb7f6@siemens.com>
Date: Wed, 28 Nov 2018 07:56:27 +0100
MIME-Version: 1.0
In-Reply-To: <bef5cc29-6379-8cd8-4a1e-4cc8a10761a4@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>, Steven Seeger <steven.seeger@nasa.gov>, Dmitriy Cherkasov <dmitriy@oss-tech.org>

On 27.11.18 19:54, Philippe Gerum wrote:
> On 11/27/18 6:44 PM, Jan Kiszka wrote:
>> On 08.11.18 14:24, Philippe Gerum wrote:
>>> On 11/8/18 2:14 PM, Jan Kiszka wrote:
>>>> On 08.11.18 14:05, Philippe Gerum wrote:
>>>>> On 11/5/18 1:20 PM, Jan Kiszka wrote:
>>>>>> The mayday mechanism exists in order to kick a xenomai userspace task
>>>>>> into secondary mode while it is running userspace code. For that,
>>>>>> we ask
>>>>>> I-pipe to call us back when the task was interrupted and is about to
>>>>>> return to userspace.
>>>>>>
>>>>>> So far we defer the relaxation from that callback via a VDSO-like
>>>>>> mechanism that triggers a special syscall to the return path of that
>>>>>> very same syscall. However, that is not desirable because it is a
>>>>>> complex, arch-specific mechanism that can easily break and,
>>>>>> specifically, that destroys the backtrace of ptraced tasks.
>>>>>>
>>>>>> Fortunately, we can fulfill the needs of mayday also by relaxing
>>>>>> the task directly from the mayday callback. Tested successfully on
>>>>>> x86-64 and ARM.
>>>>>
>>>>> ARM-wise, this change requires ipipe-core-4.14.71-arm-3 or later to
>>>>> work
>>>>> properly. This method would cause an interrupt state breakage with any
>>>>> older ARM patch.
>>>>
>>>> That would be a change compared to my past ARM experiments (4.x, if not
>>>> 3.x based). Can you point me to the problem in more details?
>>>>
>>>
>>> Calling    __ipipe_notify_trap(IPIPE_TRAP_MAYDAY, regs) may result in
>>> re-enabling IRQs unexpectedly for the caller, due to the callee
>>> relaxing. AFAIR, a core debug level assertion should trip when that
>>> happens.
>>>
>>
>> Coming back to that topic: Just tested ARM on 4.4 with all debug
>> switches of core and ipipe enabled but nothing triggered. So, either the
>> issue is more subtle, or it not really an issue.
> 
> xnthread_relax() forces hard irqs on:
> 
> __ipipe_exit_irq -> back from irq_handler (entry-armv.S), so you end up
> running the interrupt return path with irqs on both for svc or usr
> modes, including the regular preemption management stuff which assumes
> the opposite.
> 
> WARN_ON_ONCE(!hard_irqs_disabled()) should trigger from
> __ipipe_check_root_interruptible() if added there.
> 

Ah! Now we are on the same page. But this does not trigger anymore, and that's 
because of these two:

- 
https://gitlab.denx.de/Xenomai/ipipe/commit/b2bb695a1ece2320ab04cba9aa359bed8953baf7
- 
https://gitlab.denx.de/Xenomai/ipipe/commit/da42030eb2e1afc6f3f8f4f6d40ae9b336e3d635

I've noticed that issue back then and urged on addressing it. So we are already 
safe on ARM as well. That's good.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

