Message-ID: <4FD218A5.7030207@xenomai.org>
Date: Fri, 08 Jun 2012 17:22:13 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <623784B6C75D274389918D358E89E8BB0B7FF136@OPTELIAN5.optelian.local>
	<4FD1A689.8050107@xenomai.org>
	<623784B6C75D274389918D358E89E8BB0B7FF282@OPTELIAN5.optelian.local>
	<4FD216BD.3080409@xenomai.org>
	<623784B6C75D274389918D358E89E8BB0B7FF2B2@OPTELIAN5.optelian.local>
In-Reply-To: <623784B6C75D274389918D358E89E8BB0B7FF2B2@OPTELIAN5.optelian.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] GPIO irq handler on powerpc.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Chris Stone <chris.stone@optelian.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/08/2012 05:18 PM, Chris Stone wrote:
> I am not using a 3.2.x kernel. It was not a vendor specific tree, but
> a mainline 3.0.13 kernel.

Ok, so this moved to drivers/gpio. Patch queued, thanks.

>
> Cheers,
>      Chris.
>
>> -----Original Message-----
>> From: Philippe Gerum [mailto:rpm@xenomai.org]
>> Sent: Friday, June 08, 2012 11:14 AM
>> To: Chris Stone
>> Cc: xenomai@xenomai.org
>> Subject: Re: [Xenomai] GPIO irq handler on powerpc.
>>
>> On 06/08/2012 04:50 PM, Chris Stone wrote:
>>
>>> There was a call to generic_handle_irq that should have been calling
>>> ipipe_handle_chained_irq so I have a fix for the problem. Here is a
>>> diff:
>>>
>>> diff -r 0f7a4ec77dc0 arch/powerpc/sysdev/mpc8xxx_gpio.c
>>> --- a/arch/powerpc/sysdev/mpc8xxx_gpio.c        Mon Jun 04 11:04:14
>> 2012 -0400
>>> +++ b/arch/powerpc/sysdev/mpc8xxx_gpio.c        Fri Jun 08 10:39:40
>> 2012 -0400
>>> @@ -151,7 +151,7 @@
>>>
>>>           mask = in_be32(mm->regs + GPIO_IER)&   in_be32(mm->regs +
>> GPIO_IMR);
>>>           if (mask)
>>> -               generic_handle_irq(irq_linear_revmap(mpc8xxx_gc->irq,
>>> +
>>> + ipipe_handle_chained_irq(irq_linear_revmap(mpc8xxx_gc->irq,
>>>                                                        32 -
>> ffs(mask)));
>>>    }
>>>
>>> I did not see this in the core-3.2 branch of the ipipe git, so you
>> may
>>> need to merge this in. Let me know if I should be providing this fix
>> in another form.
>>>
>>
>> This won't apply to a mainline 3.2.x kernel. Are these bits part of a
>> vendor-specific tree?
>>
>> --
>> Philippe.
>


-- 
Philippe.

