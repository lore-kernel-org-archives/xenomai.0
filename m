MIME-Version: 1.0
In-Reply-To: <55C8BBB4.1050706@xenomai.org>
References: <CAJ-wHnbT+=x0JLZDbpipGOuuTWA9CFhKrtPZqTXtcTLW+YGS9Q@mail.gmail.com>
 <55C8BBB4.1050706@xenomai.org>
Date: Mon, 10 Aug 2015 10:45:19 -0500
Message-ID: <CAJ-wHnaiFLLfmGJO2-Mi4+Ta9ZDkEKWSq4p3gckhTP2F5EVVRA@mail.gmail.com>
From: Timothy Duncan <tduncan5149@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] fix_alignment trap returns nan on PowerPC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai@xenomai.org

On Mon, Aug 10, 2015 at 10:37 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 08/10/2015 05:32 PM, Timothy Duncan wrote:
>> On Mon, Aug 10, 2015 at 9:56 AM, Philippe Gerum <rpm@xenomai.org> wrote:
>>> On 08/10/2015 03:01 PM, Timothy Duncan wrote:
>>>> I'm getting not a numbers on floating point unaligned access. I have
>>>> traced it down to where it converts double to float in the
>>>> fix_alignment function in arch/powerpc/kernel/align.c. I cannot
>>>> reproduce the issue on vanilla kernel.
>>>>
>>>> preempt_disable();
>>>> enable_kernel_fp();
>>>>> cvt_df(&data.dd, (float *)&data.v[4], &current->thread);
>>>> preempt_enable();
>>>>
>>>> The double value is sometimes not converted correctly. I am guessing
>>>> it gets interrupted by a higher priority task that is also doing
>>>> floating point.
>>>>
>>>> I am on an older version of everything and wondering if anyone
>>>> remembers there being and issue/fix for something along these lines.
>>>>
>>>> I'm using the ipipe version 2.10-03 patch that was bundled with Xenomai 2.5.4
>>>> on Linux 2.6.33.5.
>>>
>>> [snip]
>>>
>>>> Any help would be appreciated. I am going to start looking at going to
>>>> a more recent version of everything, but that may take some time as I
>>>> will have to update some drivers that we wrote our board.
>>>>
>>>
>>>
>>> alignment_exception() may re-enable interrupts as a result of relaxing
>>> the rt thread causing the fp exception, so your analysis is likely
>>> right. Recent kernels even force IRQs on in fix_alignment(), so this
>>> issue exists in another form there too.
>>>
>>> I can't test with your demo code at the moment, but using the ironed
>>> variants of preemption helpers as illustrated below may help.
>>>
>>> diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
>>> index b876e989..a78ecf8 100644
>>> --- a/arch/powerpc/kernel/align.c
>>> +++ b/arch/powerpc/kernel/align.c
>>> @@ -705,7 +705,7 @@ int fix_alignment(struct pt_regs *regs)
>>>         unsigned int reg, areg;
>>>         unsigned int dsisr;
>>>         unsigned char __user *addr;
>>> -       unsigned long p, swiz;
>>> +       unsigned long p, swiz, irqflags;
>>>         int ret, t;
>>>         union {
>>>                 u64 ll;
>>> @@ -887,10 +887,10 @@ int fix_alignment(struct pt_regs *regs)
>>>                 if (flags & S) {
>>>                         /* Single-precision FP store requires conversion... */
>>>  #ifdef CONFIG_PPC_FPU
>>> -                       preempt_disable();
>>> +                       ipipe_preempt_disable(irqflags);
>>>                         enable_kernel_fp();
>>>                         cvt_df(&data.dd, (float *)&data.v[4], &current->thread);
>>> -                       preempt_enable();
>>> +                       ipipe_preempt_enable(irqflags);
>>>  #else
>>>                         return 0;
>>>  #endif
>>> @@ -931,10 +931,10 @@ int fix_alignment(struct pt_regs *regs)
>>>         /* Single-precision FP load requires conversion... */
>>>         case LD+F+S:
>>>  #ifdef CONFIG_PPC_FPU
>>> -               preempt_disable();
>>> +               ipipe_preempt_disable(irqflags);
>>>                 enable_kernel_fp();
>>>                 cvt_fd((float *)&data.v[4], &data.dd, &current->thread);
>>> -               preempt_enable();
>>> +               ipipe_preempt_enable(irqflags);
>>>  #else
>>>                 return 0;
>>>  #endif
>>>
>>> --
>>> Philippe.
>>
>> That appears to be working. Thanks. Other than the small time it takes
>> to execute the conversion I would not expect this to have any other
>> side effects. Correct?
>>
>
> Correct.
>
> --
> Philippe.

Sorry wanted this to show on the mailing list if anyone else runs into this.
-- Tim

