Message-ID: <499D8549.30900@domain.hid>
Date: Thu, 19 Feb 2009 17:14:01 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <499B36C5.3060104@domain.hid>
	<499B3F35.2080604@domain.hid>	<499B5136.2030107@domain.hid>
	<499B55CF.3020005@domain.hid>	<499BBF88.9000207@domain.hid>
	<499BE2E7.4090704@domain.hid>	<499BF9BB.3090700@domain.hid>
	<499C0E33.3070606@domain.hid> <499D7F88.1000906@domain.hid>
In-Reply-To: <499D7F88.1000906@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Adeos-main] __ipipe_syscall_root logic
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
>> Jan Kiszka wrote:
>>> ...
>>> However, let's assumed we entered __ipipe_syscall_root with root domain
>>> stalled. If we then return from __ipipe_dispatch_event with 0 (=>
>>> forward this syscall to Linux), we would not call __fixup_if again so
>>> that the stalled state is kept. Is this a valid scenario for the given
>>> task, or would this be broken already? At least it looks like the path
>>> taken here
>> Could someone explain __ipipe_syscall_root to me? The comment before the
>> second __fixup_if() does not help me understanding why we only have to
>> call it when we do not forward the syscall to Linux. In other words,
>> this version would make more sense to me (32-bit variant, but 64-bit
>> looks as fishy as its little brother):
>>
>> --- a/arch/x86/kernel/ipipe.c
>> +++ b/arch/x86/kernel/ipipe.c
>> @@ -540,6 +540,7 @@ asmlinkage void __ipipe_unstall_iret_roo
>>  asmlinkage int __ipipe_syscall_root(struct pt_regs regs)
>>  {
>>  	unsigned long flags;
>> +	int pass;
>>  
>>  	__fixup_if(&regs);
>>  
>> @@ -551,8 +552,9 @@ asmlinkage int __ipipe_syscall_root(stru
>>  	   tail work has to be performed (for handling signals etc). */
>>  
>>  	if (__ipipe_syscall_watched_p(current, regs.orig_ax) &&
>> -	    __ipipe_event_monitored_p(IPIPE_EVENT_SYSCALL) &&
>> -	    __ipipe_dispatch_event(IPIPE_EVENT_SYSCALL,&regs) > 0) {
>> +	    __ipipe_event_monitored_p(IPIPE_EVENT_SYSCALL)) {
>> +		pass = !__ipipe_dispatch_event(IPIPE_EVENT_SYSCALL,&regs);
>> +
>>  		/* We might enter here over a non-root domain and exit
>>  		 * over the root one as a result of the syscall
>>  		 * (i.e. by recycling the register set of the current
>> @@ -562,6 +564,9 @@ asmlinkage int __ipipe_syscall_root(stru
>>  		 * stall bit on exit. */
>>  		__fixup_if(&regs);
>>  
>> +		if (pass)
>> +			return 0;
>> +
>>  		if (ipipe_root_domain_p && !in_atomic()) {
>>  			/* Sync pending VIRQs before _TIF_NEED_RESCHED is tested. */
>>  			local_irq_save_hw(flags);
>>
> 
> Good point, but unfortunately, this is not enough to explain the issue. Your
> patch does plug a hole when a primary mode context issues a syscall that
> migrates to secondary. In such a case, we are indeed missing a second fixup.
> However, this issue is not going to bite us unless the caller disabled hw IRQs
> by playing the iopl+cli game from userland, which the latency test surely
> doesn't do.

That was my feeling as well. Roman's first trace was not fully
explainable anyway: we run along DISABLE_INTERRUPTS under syscall_exit,
but then __ipipe_unstall_iret_root finds Linux IRQs enabled - weird.

Maybe the (or another) problem is actually elsewhere, causing an entry
to __ipipe_syscall_root with Linux IRQs incorrectly disabled. The trace
was too short... :(

Roman, is there by chance some longer trace available now?

> 
> I'm still unable to reproduce this bug after a whole day spent in tuning the
> configuration and trying different workloads. But I suspect this has something
> to do with the iret_root emulation being called to exit an execution path that
> did not ran the fixup_if prologue. If anyone out there has a .config file for a
> kernel that exhibits the problem, I'm a taker.

But what would be the path? I banged my head against the code but didn't
found another possibility.

> 
> Nevertheless, your fix is relevant. We may even want to sync the interrupts
> pending for the root stage before propagating normally to Linux, the same way we
> do in the bypass case.

IRQs or only VIRQs as it is now?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

