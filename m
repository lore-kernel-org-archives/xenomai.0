Message-ID: <49A29871.90807@domain.hid>
Date: Mon, 23 Feb 2009 13:37:05 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <499EBF45.900@domain.hid> <49A290E8.5030400@domain.hid>
In-Reply-To: <49A290E8.5030400@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [PATCH] x86: Proper root domain state management
	for ipipe_handle_exception
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-help <xenomai@xenomai.org>, adeos-main <adeos-main@gna.org>

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> This is an attempt to fix the broken root domain state adjustment in
>> __ipipe_handle_exception. Patch below fixes the issues recently reported
>> by Roman Pisl. Also, it currently makes much more sense to me than what
>> we have so far.
>>
>> In short, this patch propagates the hardware irq state into the root
>> domains stall flag shortly before calling into the Linux handler, and
>> only then. This avoids spurious root domain stalls the end up over the
>> wrong Linux context due to context switches between enter and exit of
>> ipipe_handle_exception. Also, this patch drops the bogus
>> local_irq_save/restore pair that doesn't account for Linux irq state
>> changes inside its fault handler.
>>
> 
> Actually, it is not bogus at all, it is even mandatory on x86_64, given that we
> don't branch to any sysretq/iretq emulation unlike with x86_32. So if we don't
> restore the stall bit for the root domain properly there, we could end up
> running with interrupts off in user-space.
> 
> However, the way the interrupt state is currently saved is wrong: we should not
> local_irq_disable() over non-root domains. Here is some on-line documentation to
> explain why:
> 
> The main difference between x86_32 and 64 is that the former does virtualize the
> interrupt state in entry_32.S, unlike the latter. For that reason, x86_64 does
> not require (actually, we should not be doing) any fixup. So, to sum up:
> 
> - we use fixup_if() to restore the virtual interrupt state properly when control
> is given back to the code that triggered the fault/exception (x86_32). We need
> to do that because of task migrations between primary and secondary modes.
> 
> - we must clear the virtual interrupt flag before calling the I-pipe handler /
> Linux regular exception handler, because our callee may/must run in the root
> domain as well, and expect that interrupt state to reflect the hw one, as set by
> the x86 exception gate / fault prologue in entry_*.S.
> 
> - because of the above, we must use local_irq_save()/local_irq_restore_nosync()
> in our fault handler to make sure to restore the virtual interrupt flag properly
> between this routine, and the exception return statement (i.e. during the Linux
> fault epilogue in entry_*.S).

OK, if there is a reason to enforce a stalled root domain while calling
into the exception hook, this makes some sense. But I don't think it is
formally correct to save the root state on entry and blindly restore it
_after_ calling the Linux handler. I rather think we should keep the
state that Linux leaves behind to remain transparent to it. Maybe no
practical issue ATM, but it makes the code at least illogical.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

