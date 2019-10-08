Subject: Re: Warning on arm64 boot with debugging on
References: <2349a1e9-d2c6-dc05-eca9-d4015b80746c@siemens.com>
 <c21d5129-73a4-a430-b17b-64d82d933ab8@siemens.com>
 <487ec1ed-93b4-aafd-8368-b11dff21be2c@xenomai.org>
 <c90406ea-930e-bc44-f6ea-6f778ffbda17@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <33fa068e-2e8c-1784-d9c4-88a15829083d@xenomai.org>
Date: Tue, 8 Oct 2019 21:31:29 +0200
MIME-Version: 1.0
In-Reply-To: <c90406ea-930e-bc44-f6ea-6f778ffbda17@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 10/8/19 7:52 PM, Jan Kiszka wrote:
> On 08.10.19 19:31, Philippe Gerum wrote:
>> On 10/8/19 5:25 PM, Jan Kiszka wrote:
>>> On 08.10.19 17:21, Jan Kiszka wrote:
>>>> Hi Philippe,
>>>>
>>>> just a note, probably harmless (instrumentation issue), but it may
>>>>  prevent debugging real issues. This is ipipe-core-4.19.55-arm64-2
>>>> with lock validation on:
>>>>
>>
>> Indeed it's not. The virtual IRQ state should be reconciled before calling the trap information handler in do_debug_exception(). Something around these lines:
>>
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index d7ea82c0b8c7..ade0271fd7cc 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -986,23 +986,24 @@ asmlinkage int __exception do_debug_exception(unsigned long addr_if_watchpoint,
>>  	if (user_mode(regs) && pc > TASK_SIZE)
>>  		arm64_apply_bp_hardening();
>>  
>> +	irqflags = fault_entry(regs);
>> +
>>  	if (!inf->fn(addr_if_watchpoint, esr, regs)) {
>>  		rv = 1;
>>  	} else {
>>  		struct siginfo info;
>>  
>> -		irqflags = fault_entry(regs);
>> -
>>  		clear_siginfo(&info);
>>  		info.si_signo = inf->sig;
>>  		info.si_errno = 0;
>>  		info.si_code  = inf->code;
>>  		info.si_addr  = (void __user *)pc;
>>  		arm64_notify_die(inf->name, regs, &info, esr);
>> -		fault_exit(irqflags);
>>  		rv = 0;
>>  	}
>>  
>> +	fault_exit(irqflags);
>> +
>>  	if (interrupts_enabled(regs))
>>  		trace_hardirqs_on();
>>
> 
> I've just thrown this at my setup but it had no impact. If you can't
> reproduce, let me know.
> 

You seem to be running kvm/arm64, so I will likely be able to reproduce.

-- 
Philippe.

