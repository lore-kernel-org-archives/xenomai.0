Message-ID: <4B5ED4F7.4030006@domain.hid>
Date: Tue, 26 Jan 2010 12:41:43 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B5EB6D2.9040206@domain.hid> <4B5ED445.1040908@domain.hid>
In-Reply-To: <4B5ED445.1040908@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH v2] x86: Fix root domain state restoring
 on exception return
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Cc: adeos-main <adeos-main@gna.org>, xenomai-core <xenomai@xenomai.org>

Wolfgang Mauerer wrote:
> Jan Kiszka wrote:
>> If we enter __ipipe_handle_exception over a non-root domain and leave it
>> due to migration in the event handler over root, we must not restore the
>> root domain state so far saved on entry. This caused subtle pipeline
>> state corruptions. Instead, only save and restore them if we were
>> entering over root.
>>
>> However, the x86-32 regs.flags fixup is required nevertheless to take
>> care of mismatches between the root domain state and the hardware flags
>> on entry. That may happen if we fault in the iret path. But also in this
>> case we must not restore an invalid root domain state. So if we entered
>> over non-root, pick up the input for __fixup_if from the root domain
>> after running the ipipe handler.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>> ---
>>
>> Next try. But this time I think I finally understood what scenario
>> __fixup_if is actually fixing. Please correct me if I'm still missing
>> one.
> 
> looks good - it works for my test cases and solves the problems with
> the hw/pipeline state mismatch during early bootup. But do you happen
> to have any scenario at hand with ipipe_domain_root_p && !root_entry?
> Couldn't trigger this one yet so only the raw_irqs_disabled_flags
> fixup is excercised, though I guess it can't do any harm to really
> ensure that the explanation fits reality this time...

You mean non-root entry -> migration -> __fixup_if? In that case we pick
up the flags for fixup _after_ the migration (raw_irqs_disabled()). Or
what do you mean?

> 
> Wolfgang
> 
>>  arch/x86/kernel/ipipe.c |   81 +++++++++++++++++++++++++++++-----------------
>>  1 files changed, 51 insertions(+), 30 deletions(-)
>>
>> diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
>> index 4442d96..b471355 100644
>> --- a/arch/x86/kernel/ipipe.c
>> +++ b/arch/x86/kernel/ipipe.c
>> @@ -702,19 +702,23 @@ static int __ipipe_xlate_signo[] = {
>>  
>>  int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
>>  {
>> -	unsigned long flags;
>> -
>> -	/* Pick up the root domain state of the interrupted context. */
>> -	local_save_flags(flags);
>> +	bool root_entry = false;
>> +	unsigned long flags = 0;
>>  
>>  	if (ipipe_root_domain_p) {
>> -		/*
>> -		 * Replicate hw interrupt state into the virtual mask before
>> -		 * calling the I-pipe event handler over the root domain. Also
>> -		 * required later when calling the Linux exception handler.
>> -		 */
>> -		if (irqs_disabled_hw())
>> +		root_entry = true;
>> +
>> +		local_save_flags(flags);
>> +
>> +		if (irqs_disabled_hw()) {
>> +			/*
>> +			 * Replicate hw interrupt state into the virtual mask
>> +			 * before calling the I-pipe event handler over the
>> +			 * root domain. Also required later when calling the
>> +			 * Linux exception handler.
>> +			 */
>>  			local_irq_disable();
>> +		}
>>  	}
>>  #ifdef CONFIG_KGDB
>>  	/* catch exception KGDB is interested in over non-root domains */
>> @@ -725,18 +729,22 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
>>  #endif /* CONFIG_KGDB */
>>  
>>  	if (unlikely(ipipe_trap_notify(vector, regs))) {
>> -		local_irq_restore_nosync(flags);
>> +		if (root_entry)
>> +			local_irq_restore_nosync(flags);
>>  		return 1;
>>  	}
>>  
>> -	/*
>> -	 * 32-bit: In case we migrated to root domain inside the event
>> -	 * handler, restore the original IF from exception entry as the
>> -	 * low-level return code will evaluate it.
>> -	 */
>> -	__fixup_if(raw_irqs_disabled_flags(flags), regs);
>> -
>> -	if (unlikely(!ipipe_root_domain_p)) {
>> +	if (likely(ipipe_root_domain_p)) {
>> +		/*
>> +		 * 32-bit: In case we faulted in the iret path, regs.flags do
>> +		 * not match the root domain state as the low-level return
>> +		 * code will evaluate it. Fix this up, either by the root
>> +		 * state sampled on entry or, if we migrated to root, with the
>> +		 * current state.
>> +		 */
>> +		__fixup_if(root_entry ? raw_irqs_disabled_flags(flags) :
>> +					raw_irqs_disabled(), regs);
>> +	} else {
>>  		/* Detect unhandled faults over non-root domains. */
>>  		struct ipipe_domain *ipd = ipipe_current_domain;
>>  
>> @@ -770,21 +778,29 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
>>  	 * Relevant for 64-bit: Restore root domain state as the low-level
>>  	 * return code will not align it to regs.flags.
>>  	 */
>> -	local_irq_restore_nosync(flags);
>> +	if (root_entry)
>> +		local_irq_restore_nosync(flags);
>>  
>>  	return 0;
>>  }
>>  
>>  int __ipipe_divert_exception(struct pt_regs *regs, int vector)
>>  {
>> -	unsigned long flags;
>> -
>> -	/* Same root state handling as in __ipipe_handle_exception. */
>> -	local_save_flags(flags);
>> +	bool root_entry = false;
>> +	unsigned long flags = 0;
>>  
>>  	if (ipipe_root_domain_p) {
>> -		if (irqs_disabled_hw())
>> +		root_entry = true;
>> +
>> +		local_save_flags(flags);
>> +
>> +		if (irqs_disabled_hw()) {
>> +			/*
>> +			 * Same root state handling as in
>> +			 * __ipipe_handle_exception.
>> +			 */
>>  			local_irq_disable();
>> +		}
>>  	}
>>  #ifdef CONFIG_KGDB
>>  	/* catch int1 and int3 over non-root domains */
>> @@ -804,16 +820,21 @@ int __ipipe_divert_exception(struct pt_regs *regs, int vector)
>>  #endif /* CONFIG_KGDB */
>>  
>>  	if (unlikely(ipipe_trap_notify(vector, regs))) {
>> -		local_irq_restore_nosync(flags);
>> +		if (root_entry)
>> +			local_irq_restore_nosync(flags);
>>  		return 1;
>>  	}
>>  
>> +	if (likely(ipipe_root_domain_p)) {
>> +		/* see __ipipe_handle_exception */
>> +		__fixup_if(root_entry ? raw_irqs_disabled_flags(flags) :
>> +					raw_irqs_disabled(), regs);
>> +	}
>> +
>>  	/*
>> -	 * 32-bit: Due to possible migration inside the event handler, we have
>> -	 * to restore IF so that low-level return code sets the root domain
>> -	 * state correctly.
>> +	 * No need to restore root state in the 64-bit case, the Linux handler
>> +	 * and the return code will take care of it.
>>  	 */
>> -	__fixup_if(raw_irqs_disabled_flags(flags), regs);
>>  
>>  	return 0;
>>  }
> 

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

