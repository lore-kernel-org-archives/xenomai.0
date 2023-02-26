Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E156185E
	for <xenomai@lists.linux.dev>; Sun, 26 Feb 2023 10:13:47 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id BA0CEFF803;
	Sun, 26 Feb 2023 10:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1677406420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RYmJNr+GZJir7YBtDDSasyBUJYvQ4lZfMbDLrUZ6on4=;
	b=LWGwq58td/47f6+5bTwCKtpJoNXYDRT6A6xJ8qw46wS4rU99Fwqw8G4TTaNXu0zItfOeku
	D7ZIR/+HY0pr452Q1SnKn1yi/mG5unMkVFLVEzQNI38O6da4XCC6iBIa0Gc3ekLkUl8lGI
	pO+JQ7ba2JDqIHpJjxfZGvCAidwb3bretAgsAOHorjlSbas66rPlzqZnIEdj6CRrvdJZgA
	XKS2nkKbtWPB0IKWX/GR1FPM3GelYbNNi82ogJyoECZ9lgPzgH+IuDs/+YnRBVrXA2sMqJ
	wAaKHQeOHoJbmaY7N89lklnKgauzvRZRvXsQj1JwOWZ8qYwSVOCuwOM6RlPWZg==
References: <VE1PR08MB49090AD3D9BB287AFBD16EEA92AB9@VE1PR08MB4909.eurprd08.prod.outlook.com>
 <87y1olh9i4.fsf@xenomai.org>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Jan Kiszka
 <jan.kiszka@siemens.com>
Subject: Re: problem while handling exceptions in oob stage
Date: Sun, 26 Feb 2023 10:47:32 +0100
In-reply-to: <87y1olh9i4.fsf@xenomai.org>
Message-ID: <874jr8vinh.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Philippe Gerum <rpm@xenomai.org> writes:

> Johannes Kirchmair <johannes.kirchmair@sigmatek.at> writes:
>
>> Hello,
>>
>> we encountered a problem, while handling invalid opcode exception in oob stage. 
>> Our fixup code works fine if we execute ud2 instruction the first time.
>> Upon second execution of ud2, we encounter the problem that our fixup code is not reached.
>>
>> The problem is that the first time entering the kernel, mark_trap_entry_raw is called and in a subsequent call the _TLF_OOBTRAP flag is set.
>> But because we do not switch to inband stage, we do not call mark_trap_exit_raw and the _TLF_OOBTRAP flag is not cleared.
>>
>> The second time we enter the kernel on execution of ud2,  we encounter (again) the following code:
>>
>> static __always_inline void oob_trap_notify(unsigned int exception,
>>                                          struct pt_regs *regs)
>> {
>>          if (running_oob() && !test_thread_local_flags(_TLF_OOBTRAP))
>>                  __oob_trap_notify(exception, regs);
>> }
>>
>> Because _TLF_OOBTRAP is set and because we are still oob, we just leave the kernel without calling __oob_trap_notify and subsequently our clean up code.
>> This results in re-execution of the same ud2 again and again.
>>
>> I fixed it for me in the following way:
>>
>> --- a/arch/x86/kernel/traps.c
>> +++ b/arch/x86/kernel/traps.c
>> @@ -414,8 +414,9 @@ DEFINE_IDTENTRY_RAW(exc_invalid_op)
>>                 handle_invalid_op(regs);
>>                 instrumentation_end();
>>                 irqentry_exit(regs, state);
>> -               mark_trap_exit_raw(X86_TRAP_UD, regs);
>>         }
>> +
>> +       mark_trap_exit_raw(X86_TRAP_UD, regs);
>>  }
>>
>> I am not sure it this is a valid way to fix this issue.
>> If it is, I could work up a patch next week that addresses all the places where this problem could trigger.
>>
>> What do you think?
>
> That would work in the current implementation of mark_trap_exit*(), I
> would recommend to keep the semantics of the mark_trap* pairs unchanged
> though, meaning that no exit should take place if the corresponding
> entry failed.
>
> Dovetail-wise, the inner oob_trap_entry/oob_trap_unwind pair should mark
> the start/end of the in-band handling of a trap, so that the core can do
> some housekeeping before and after such handling. As you rightfully
> noticed, because such entry was actually notified unconditionally to the
> core, we should always tell it about the matching exit point as well,
> especially if we plan not to do anything about the trap event.
>
> Something like this should do for x86 (same issue for arm64 and arm,
> I'll fix them up too):
>
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 7238f5c90b998..234e8ab84c221 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -174,6 +174,13 @@ bool mark_trap_entry(int trapnr, struct pt_regs *regs)
>  		return true;
>  	}
>  
> +	/*
> +	 * If the oob core did not switch us inband, our caller is
> +	 * expected to leave the trap handler immediately, so we may
> +	 * notify the core about this right now.
> +	 */
> +	oob_trap_unwind(trapnr, regs);
> +
>  	return false;
>  }
>  
> @@ -188,7 +195,13 @@ static __always_inline
>  bool mark_trap_entry_raw(int trapnr, struct pt_regs *regs)
>  {
>  	oob_trap_notify(trapnr, regs);
> -	return running_inband();
> +
> +	if (unlikely(running_oob())) {
> +		oob_trap_unwind(trapnr, regs);
> +		return false;
> +	}
> +
> +	return true;
>  }
>  
>  static __always_inline

The patch for mm/fault.c above is not correct, the following one is
better, i.e. since we are still running oob, we must not alter the
in-band interrupt state, plus oob_trap_unwind() turns hard irqs off
unconditionally on entry and leaves them that way, therefore we can and
_must_ skip local_irq_disable_full():

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 4b697ef4bd678..c7999b493865b 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -922,10 +922,8 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		return;
 
 	oob_trap_notify(X86_TRAP_PF, regs);
-	if (!running_inband()) {
-		local_irq_disable_full();
-		return;
-	}
+	if (!running_inband())
+		goto out;
 
 	if (likely(show_unhandled_signals))
 		show_signal_msg(regs, error_code, address, tsk);
@@ -938,6 +936,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
 
 	local_irq_disable_full();
+out:
 	oob_trap_unwind(X86_TRAP_PF, regs);
 }
 
@@ -1401,7 +1400,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 */
 	oob_trap_notify(X86_TRAP_PF, regs);
 	if (!running_inband())
-		return;
+		goto out;
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);

-- 
Philippe.
