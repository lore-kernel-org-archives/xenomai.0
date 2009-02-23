Message-ID: <49A2E00C.1090201@domain.hid>
Date: Mon, 23 Feb 2009 18:42:36 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <499EBF45.900@domain.hid> <49A290E8.5030400@domain.hid>
	<49A29871.90807@domain.hid> <49A29CBF.80701@domain.hid>
	<49A2A654.7040706@domain.hid>
In-Reply-To: <49A2A654.7040706@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [PATCH] x86: Proper root domain state management
	for ipipe_handle_exception
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main <adeos-main@gna.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> Jan Kiszka wrote:
>>> Philippe Gerum wrote:
>>>> Jan Kiszka wrote:
>>>>> This is an attempt to fix the broken root domain state adjustment in
>>>>> __ipipe_handle_exception. Patch below fixes the issues recently reported
>>>>> by Roman Pisl. Also, it currently makes much more sense to me than what
>>>>> we have so far.
>>>>>
>>>>> In short, this patch propagates the hardware irq state into the root
>>>>> domains stall flag shortly before calling into the Linux handler, and
>>>>> only then. This avoids spurious root domain stalls the end up over the
>>>>> wrong Linux context due to context switches between enter and exit of
>>>>> ipipe_handle_exception. Also, this patch drops the bogus
>>>>> local_irq_save/restore pair that doesn't account for Linux irq state
>>>>> changes inside its fault handler.
>>>>>
>>>> Actually, it is not bogus at all, it is even mandatory on x86_64, given that we
>>>> don't branch to any sysretq/iretq emulation unlike with x86_32. So if we don't
>>>> restore the stall bit for the root domain properly there, we could end up
>>>> running with interrupts off in user-space.
>>>>
>>>> However, the way the interrupt state is currently saved is wrong: we should not
>>>> local_irq_disable() over non-root domains. Here is some on-line documentation to
>>>> explain why:
>>>>
>>>> The main difference between x86_32 and 64 is that the former does virtualize the
>>>> interrupt state in entry_32.S, unlike the latter. For that reason, x86_64 does
>>>> not require (actually, we should not be doing) any fixup. So, to sum up:
>>>>
>>>> - we use fixup_if() to restore the virtual interrupt state properly when control
>>>> is given back to the code that triggered the fault/exception (x86_32). We need
>>>> to do that because of task migrations between primary and secondary modes.
>>>>
>>>> - we must clear the virtual interrupt flag before calling the I-pipe handler /
>>>> Linux regular exception handler, because our callee may/must run in the root
>>>> domain as well, and expect that interrupt state to reflect the hw one, as set by
>>>> the x86 exception gate / fault prologue in entry_*.S.
>>>>
>>>> - because of the above, we must use local_irq_save()/local_irq_restore_nosync()
>>>> in our fault handler to make sure to restore the virtual interrupt flag properly
>>>> between this routine, and the exception return statement (i.e. during the Linux
>>>> fault epilogue in entry_*.S).
>>> OK, if there is a reason to enforce a stalled root domain while calling
>>> into the exception hook, this makes some sense. But I don't think it is
>>> formally correct to save the root state on entry and blindly restore it
>>> _after_ calling the Linux handler. I rather think we should keep the
>>> state that Linux leaves behind to remain transparent to it. Maybe no
>>> practical issue ATM, but it makes the code at least illogical.
>>>
>> Please re-read the explanations, and you will find the logic. I cannot do
>> anything more than re-hashing what I just said. What you perceive as illogical
>> is actually the only sane way to do this. Formally speaking, a linux fault
>> handler may NOT alter the interrupt state blindly, so we must be able to assume
>> that we ought to restore it the way the lower code set it.
> 
> I got your first and second point, but they don't imply to me that the
> third shall be correct as well. "...to make sure to restore the virtual
> interrupt flag properly" is not directly an clear explanation (for me)
> why we have to restore the flag across calls to the _Linux_ handler. We
> can demand that the hook handler leaves the root state untouched, but
> requiring the same from Linux is a restriction that you don't find in
> the ipipe-less case, nor do I see the reason for this under ipipe control.
> 

The make my question a bit more concrete (and help me writing the right
comments around these lines): What makes the following change bogus,
which scenario will fail?

Index: b/arch/x86/kernel/ipipe.c
===================================================================
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -685,7 +685,9 @@ int __ipipe_handle_exception(struct pt_r
 	}
 
 	__ipipe_std_extable[vector](regs, error_code);
-	local_irq_restore_nosync(flags);
+
+	__fixup_if(test_bit(IPIPE_STALL_FLAG, &ipipe_root_cpudom_var(status)),
+		   regs);
 
 	return 0;
 }

My reasoning behind is: Once we call into the Linux handler (after
properly transferring the hardware IRQ state into a pipeline state, of
course), it's up to the Linux handler to decide about the root domain
state on exit. We really shouldn't overwrite it with what we found on
entry. That state is only to be replayed when we leave without calling
Linux.

BTW, I'm currently failing to find the code path that enables hardware
IRQs before calling the Linux handler. There's no related change in this
particular patch, so I guess I'm just blind ATM.

Thanks for insights,
Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

