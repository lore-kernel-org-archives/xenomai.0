Subject: Re: Enable/Disable of ftrace events crashes kernel
References: <CAFLxGvzoCXUq_QFMT=b54nnLd8Oeu3XfFeiCKoCj3a0Q3Xg8yA@mail.gmail.com>
 <3b8bf95c-5170-d229-b27f-1577a2e0942b@siemens.com>
 <CAFLxGvzgCuoaG+O9EyiJZG_YD-2KQxVWd1LG-FepiEAjebqJnQ@mail.gmail.com>
 <fb2a4587-5180-663b-1dee-e2b7b114fc63@siemens.com>
 <CAFLxGvwJx=JkQc-s6TkvmP=_JM+VYxTt9Qiyko9u8CguoeS0sw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <015e6243-88eb-f12b-64d1-37e62fb5f713@siemens.com>
Date: Thu, 11 Jul 2019 23:20:36 +0200
MIME-Version: 1.0
In-Reply-To: <CAFLxGvwJx=JkQc-s6TkvmP=_JM+VYxTt9Qiyko9u8CguoeS0sw@mail.gmail.com>
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
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: xenomai@xenomai.org

On 11.07.19 22:48, Richard Weinberger wrote:
> On Thu, Jul 11, 2019 at 8:30 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 11.07.19 12:25, Richard Weinberger wrote:
>>> On Thu, Jul 11, 2019 at 12:21 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>> Can't reproduce so far, even with a while-true loop. Can you share your .config?
>>>
>>> Sure, see attachment.
>>>
>>
>> This seems to fix the issue here:
>>
>> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
>> index 119fd66d111e..8f647c208cf2 100644
>> --- a/arch/x86/entry/entry_64.S
>> +++ b/arch/x86/entry/entry_64.S
>> @@ -997,8 +997,8 @@ apicinterrupt IRQ_WORK_VECTOR                       irq_work_interrupt              smp_irq_work_interrupt
>>  \skip_label:
>>         UNWIND_HINT_REGS
>>         DISABLE_INTERRUPTS(CLBR_ANY)
>> -       testl   %ebx, %ebx      /* %ebx: return to kernel mode */
>> -       jnz     retint_kernel_early
>> +       testb   $3, CS(%rsp)
>> +       jz      retint_kernel_early
>>         jmp     retint_user_early
>>         .endif
>>  1001:
>>
>> Tests welcome!
> 
> With that change I can no longer trigger the crash.

Perfect.

> Can you please give more context? I'd like to understand the problem.
> 

We were basing the decision whether to switch GS on return or not on a stale
register (ebx). That register used to contain the information, but that changed
with "x86/entry/64: Remove %ebx handling from error_entry/exit". This caused CPU
state corruptions under certain conditions, apparently only when dealing with
#DB exceptions, not with the way more frequent #PF.

The issue is also present in 4.14, but in 4.4 and the unmaintained 4.9 as I
first thought.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

