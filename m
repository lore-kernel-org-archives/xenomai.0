Message-ID: <4B5ADAD8.9070002@domain.hid>
Date: Sat, 23 Jan 2010 12:17:44 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B59D952.30202@domain.hid>	<1264181859.2350.152.camel@domain.hid>	<4B59E2D4.5040004@domain.hid>
	<4B59E33E.1040203@domain.hid>	<1264182738.2350.158.camel@domain.hid>	<4B59E87F.80108@domain.hid>	<1264183719.2350.159.camel@domain.hid>	<1264240767.2350.164.camel@domain.hid>	<4B5ACAD7.5070607@domain.hid>
	<1264241541.2350.166.camel@domain.hid>
	<4B5ACD80.3030208@domain.hid> <4B5AD11A.8010709@domain.hid>
In-Reply-To: <4B5AD11A.8010709@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Domain switch during page fault handling
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>, "Mauerer,
	Wolfgang" <wolfgang.mauerer@domain.hid>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> The arguably less ambitious following patch works for me on x86_32:
>>
>> diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
>> index 4442d96..a7e1241 100644
>> --- a/arch/x86/kernel/ipipe.c
>> +++ b/arch/x86/kernel/ipipe.c
>> @@ -703,6 +703,7 @@ static int __ipipe_xlate_signo[] = {
>>  int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
>>  {
>>  	unsigned long flags;
>> +	unsigned root_on_entry = 0;
>>  
>>  	/* Pick up the root domain state of the interrupted context. */
>>  	local_save_flags(flags);
>> @@ -715,6 +716,7 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
>>  		 */
>>  		if (irqs_disabled_hw())
>>  			local_irq_disable();
>> +		root_on_entry = 1;
>>  	}
>>  #ifdef CONFIG_KGDB
>>  	/* catch exception KGDB is interested in over non-root domains */
>> @@ -725,7 +727,8 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
>>  #endif /* CONFIG_KGDB */
>>  
>>  	if (unlikely(ipipe_trap_notify(vector, regs))) {
>> -		local_irq_restore_nosync(flags);
>> +		if (root_on_entry)
>> +			local_irq_restore_nosync(flags);
>>  		return 1;
>>  	}
>>  
>> @@ -734,7 +737,8 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
>>  	 * handler, restore the original IF from exception entry as the
>>  	 * low-level return code will evaluate it.
>>  	 */
>> -	__fixup_if(raw_irqs_disabled_flags(flags), regs);
>> +	if (root_on_entry)
>> +		__fixup_if(raw_irqs_disabled_flags(flags), regs);
> 
> See my other mail, this is conflicting with what was once documented as
> the purpose of this fixup. I think we need to pick up the current root
> state here and push it into regs - if we are running over root.
> 

What about this (draft, not yet tested)?

diff --git a/arch/x86/kernel/ipipe.c b/arch/x86/kernel/ipipe.c
index 4442d96..99c5346 100644
--- a/arch/x86/kernel/ipipe.c
+++ b/arch/x86/kernel/ipipe.c
@@ -702,19 +702,17 @@ static int __ipipe_xlate_signo[] = {
 
 int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
 {
+	bool restore_flags = false;
 	unsigned long flags;
 
-	/* Pick up the root domain state of the interrupted context. */
-	local_save_flags(flags);
-
-	if (ipipe_root_domain_p) {
+	if (ipipe_root_domain_p && irqs_disabled_hw()) {
 		/*
 		 * Replicate hw interrupt state into the virtual mask before
 		 * calling the I-pipe event handler over the root domain. Also
 		 * required later when calling the Linux exception handler.
 		 */
-		if (irqs_disabled_hw())
-			local_irq_disable();
+		local_irq_save(flags);
+		restore_flags = true;
 	}
 #ifdef CONFIG_KGDB
 	/* catch exception KGDB is interested in over non-root domains */
@@ -725,18 +723,20 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
 #endif /* CONFIG_KGDB */
 
 	if (unlikely(ipipe_trap_notify(vector, regs))) {
-		local_irq_restore_nosync(flags);
+		if (restore_flags)
+			local_irq_restore_nosync(flags);
 		return 1;
 	}
 
-	/*
-	 * 32-bit: In case we migrated to root domain inside the event
-	 * handler, restore the original IF from exception entry as the
-	 * low-level return code will evaluate it.
-	 */
-	__fixup_if(raw_irqs_disabled_flags(flags), regs);
-
-	if (unlikely(!ipipe_root_domain_p)) {
+	if (likely(ipipe_root_domain_p)) {
+		/*
+		 * 32-bit: In case we migrated to root domain inside the event
+		 * handler, align regs.flags with the root domain state as the
+		 * low-level return code will evaluate it.
+		 */
+		__fixup_if(test_bit(IPIPE_STALL_FLAG,
+				    &ipipe_root_cpudom_var(status)), regs);
+	} else {
 		/* Detect unhandled faults over non-root domains. */
 		struct ipipe_domain *ipd = ipipe_current_domain;
 
@@ -770,21 +770,26 @@ int __ipipe_handle_exception(struct pt_regs *regs, long error_code, int vector)
 	 * Relevant for 64-bit: Restore root domain state as the low-level
 	 * return code will not align it to regs.flags.
 	 */
-	local_irq_restore_nosync(flags);
+	if (restore_flags)
+		local_irq_restore_nosync(flags);
 
 	return 0;
 }
 
 int __ipipe_divert_exception(struct pt_regs *regs, int vector)
 {
+	bool restore_flags = false;
 	unsigned long flags;
 
-	/* Same root state handling as in __ipipe_handle_exception. */
-	local_save_flags(flags);
-
 	if (ipipe_root_domain_p) {
 		if (irqs_disabled_hw())
-			local_irq_disable();
+			/*
+			 * Same root state handling as in
+			 * __ipipe_handle_exception.
+			 */
+			local_irq_save(flags);
+			restore_flags = true;
+		}
 	}
 #ifdef CONFIG_KGDB
 	/* catch int1 and int3 over non-root domains */
@@ -804,16 +809,22 @@ int __ipipe_divert_exception(struct pt_regs *regs, int vector)
 #endif /* CONFIG_KGDB */
 
 	if (unlikely(ipipe_trap_notify(vector, regs))) {
-		local_irq_restore_nosync(flags);
+		if (restore_flags)
+			local_irq_restore_nosync(flags);
 		return 1;
 	}
 
+
+	if (likely(ipipe_root_domain_p)) {
+		/* see __ipipe_handle_exception */
+		__fixup_if(test_bit(IPIPE_STALL_FLAG,
+				    &ipipe_root_cpudom_var(status)), regs);
+	}
+
 	/*
-	 * 32-bit: Due to possible migration inside the event handler, we have
-	 * to restore IF so that low-level return code sets the root domain
-	 * state correctly.
+	 * No need to restore root state in the 64-bit case, the Linux handler
+	 * and the return code will take care of it.
 	 */
-	__fixup_if(raw_irqs_disabled_flags(flags), regs);
 
 	return 0;
 }

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

