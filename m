Message-ID: <5015491D.80907@xenomai.org>
Date: Sun, 29 Jul 2012 16:30:53 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CE2E43470FE5444A811B580382FE5EDF2113D8D95A@KEMPMAIL2.woodward.com>
	<5009A292.4060508@grandegger.com>
	<CE2E43470FE5444A811B580382FE5EDF2113EA8DE7@KEMPMAIL2.woodward.com>
	<501028DC.8000803@xenomai.org> <50102E8D.1040004@xenomai.org>
	<CE2E43470FE5444A811B580382FE5EDF2113EA8E07@KEMPMAIL2.woodward.com>
	<50105A22.3090704@xenomai.org>
	<CE2E43470FE5444A811B580382FE5EDF2113EA8FD2@KEMPMAIL2.woodward.com>
	<50113143.50101@xenomai.org>
	<CE2E43470FE5444A811B580382FE5EDF2113EA9383@KEMPMAIL2.woodward.com>
	<5012BB11.9000407@xenomai.org> <5012BD08.8030305@xenomai.org>
	<CE2E43470FE5444A811B580382FE5EDF2113EA9385@KEMPMAIL2.woodward.com>
	<5012BF81.90404@xenomai.org>
In-Reply-To: <5012BF81.90404@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai installation on P1020RDB
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lukasz Zemla <Lukasz.Zemla@woodward.com>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 07/27/2012 06:19 PM, Philippe Gerum wrote:
> On 07/27/2012 06:12 PM, Lukasz Zemla wrote:
>>
>>> -----Original Message-----
>>> From: Philippe Gerum [mailto:rpm@xenomai.org]
>>> Sent: Friday, July 27, 2012 6:09 PM
>>> To: Gilles Chanteperdrix
>>> Cc: Lukasz Zemla; Xenomai@xenomai.org
>>> Subject: Re: [Xenomai] Xenomai installation on P1020RDB
>>>
>>> On 07/27/2012 06:00 PM, Gilles Chanteperdrix wrote:
>>>> On 07/27/2012 05:53 PM, Lukasz Zemla wrote:
>>>>
>>>>> What I discovered, the source of the '76s problem' could be
>>> preemption model. Now, when I set:
>>>>>    - CONFIG_PREEMPT - the lag exists exactly after eth0
>>> initialization.
>>>>>    - CONFIG_PREEMPT_VOLUNTARY - the boot process stops for a while
>>> (about 50-70s) in different places.
>>>>>    - CONFIG_PREEMPT_NONE then all is fine, I cannot observe any
>>> described problems.
>>>>
>>>>
>>>> CONFIG_PREEMPT or PREEMPT_VOLUNTARY. Try this patch:
>>>>
>>>> diff --git a/arch/powerpc/kernel/ipipe.c
>>> b/arch/powerpc/kernel/ipipe.c
>>>> index 45302c1..5b706da 100644
>>>> --- a/arch/powerpc/kernel/ipipe.c
>>>> +++ b/arch/powerpc/kernel/ipipe.c
>>>> @@ -344,8 +344,10 @@ static void __ipipe_do_IRQ(unsigned int irq,
>>> void
>>>> *cookie)
>>>>
>>>>    static void __ipipe_do_timer(unsigned int irq, void *cookie)
>>>>    {
>>>> +    irq_enter();
>>>>        check_stack_overflow();
>>>>        timer_interrupt(__this_cpu_ptr(&ipipe_percpu.tick_regs));
>>>> +    irq_exit();
>>>>    }
>>>>
>>>>    asmlinkage int __ipipe_grab_timer(struct pt_regs *regs)
>>>>
>>>> Or to remove the #ifdef CONFIG_IPIPE / #endif around the calls to
>>>> irq_enter/irq_exit in arch/powerpc/kernel/time.c
>>>>
>>>
>>> Mm, no. On ppc, we use a virtual irq to map the decrementer, so the
>>> pipeline core already took care of marking the irq entry before calling
>>> the __ipipe_do_timer handler. The issue may be in the log syncer
>>> instead.
>>
>> Maybe I have some symptom which I forgot to write. When the system
>> with CONFIG_PREEMPT stayed unused for last night I saw following errors:
>
> I should be able to reproduce this issue on some hw I have access to.
> I'll have a look and let you know. Thanks.
>

Unlucky. I can't reproduce this issue, enabling preemption on a P1022 
board. So we'll need to chase this bug differently.

Did you try disabling CONFIG_XENOMAI, while leaving CONFIG_IPIPE 
enabled? This would tells us whether the issue is triggered by having a 
high priority domain stacked.

Also, if you intend to debug further, I'd suggest that you enable 
CONFIG_IPIPE_DEBUG_CONTEXT and CONFIG_IPIPE_DEBUG_INTERNAL. Since you 
have CONFIG_SERIAL_8250_CONSOLE enabled already, you would have access 
to the __ipipe_serial_debug() service, which is a replacement for 
printk() in desperate cases, which does brute force output to the uart, 
and therefore does not suffer from any delay/buffering (*).

TIA,

(*) caution: this service only works after the 16650 MMIO area has been 
mapped in, so don't try it before the early serial devices have initialized.

-- 
Philippe.

