Message-ID: <4AF81E44.6010702@domain.hid>
Date: Mon, 09 Nov 2009 14:51:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4AF8125F.60009@domain.hid>	
	<1257773876.2210.357.camel@domain.hid>
	<1257774521.2210.363.camel@domain.hid>
In-Reply-To: <1257774521.2210.363.camel@domain.hid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] task_hijacked,
	prepare_arch_switch and irq disabling
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

Philippe Gerum wrote:
> On Mon, 2009-11-09 at 14:37 +0100, Philippe Gerum wrote:
>> On Mon, 2009-11-09 at 14:00 +0100, Jan Kiszka wrote:
>>> Hi Philippe,
>>>
>>> a customer just stumbled over some unclear spots in current I-pipe patches:
>>>
>>> Why is there local_irq_enable_hw in task_hijacked? Looks like it was
>>> once paired with prepare_arch_switch, but that call is now only used by
>>> legacy 2.4 PPC.
>> It is still used in all trees, since we define it in asm/ipipe.h. We
>> could not context switch properly on the linux side with hw interrupts
>> on anyway, due to the conflicts that would raise with Xenomai's tasking
>> code.
>>
>>>  Can we safely drop it from all other patches (it's in
>>> the context switch fast-path...)?
>> No, since prepare_arch_switch() is still applicable.
>>
>>>  Moreover, I bet the
>>> ENABLE_INTERRUPTS_HW_COND in entry_32.S' ret_from_fork is related to
>>> this as well, right?
>> No, it's there to prevent the scheduling tail from running hw IRQs off,
>> given that copy_thread() may set a copy for eflags which prevents
>> preemption.
> 
> Forget about this one, this does not apply to x86 anymore. So the answer
> to this question is rather: that used to be required on x86 a long time
> ago due to the implementation of the task switching code in system.h
> (2.4 era IIRC); but in any case, yes, this is still required for the
> reasons explained above, since we must run the switch code with hw IRQs
> off.  

Still can't follow: Where is prepare_arch_switch referenced? My dumb
approach to do a text search over the ipipe patch and Xenomai failed to
find that spot. And then the question: How is disabling the IRQs that
task_hijacked reenables?

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

