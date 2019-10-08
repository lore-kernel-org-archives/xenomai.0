Subject: Re: Warning on arm64 boot with debugging on
References: <2349a1e9-d2c6-dc05-eca9-d4015b80746c@siemens.com>
 <c21d5129-73a4-a430-b17b-64d82d933ab8@siemens.com>
 <487ec1ed-93b4-aafd-8368-b11dff21be2c@xenomai.org>
 <c90406ea-930e-bc44-f6ea-6f778ffbda17@siemens.com>
 <33fa068e-2e8c-1784-d9c4-88a15829083d@xenomai.org>
 <372729dd-50e7-5269-08c6-4fd9cfcf843d@siemens.com>
 <f170f17d-c64e-9e22-1b65-cfb1765048b4@xenomai.org>
 <0732a7b4-008e-4182-c1fe-035e859509ee@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2624d7da-4d6b-f863-8560-d548b1f1cd10@siemens.com>
Date: Tue, 8 Oct 2019 22:44:23 +0200
MIME-Version: 1.0
In-Reply-To: <0732a7b4-008e-4182-c1fe-035e859509ee@siemens.com>
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
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 08.10.19 22:26, Jan Kiszka via Xenomai wrote:
> On 08.10.19 22:21, Philippe Gerum wrote:
>> On 10/8/19 9:43 PM, Jan Kiszka wrote:
>>> On 08.10.19 21:31, Philippe Gerum wrote:
>>>> On 10/8/19 7:52 PM, Jan Kiszka wrote:
>>>>> On 08.10.19 19:31, Philippe Gerum wrote:
>>>>>> On 10/8/19 5:25 PM, Jan Kiszka wrote:
>>>>>>> On 08.10.19 17:21, Jan Kiszka wrote:
>>>>>>>> Hi Philippe,
>>>>>>>>
>>>>>>>> just a note, probably harmless (instrumentation issue), but it may
>>>>>>>>  prevent debugging real issues. This is ipipe-core-4.19.55-arm64-2
>>>>>>>> with lock validation on:
>>>>>>>>
>>>>>>
>>>>>> Indeed it's not. The virtual IRQ state should be reconciled before calling the trap information handler in do_debug_exception(). Something around these lines:
>>>>>>
>>>>>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>>>>>> index d7ea82c0b8c7..ade0271fd7cc 100644
>>>>>> --- a/arch/arm64/mm/fault.c
>>>>>> +++ b/arch/arm64/mm/fault.c
>>>>>> @@ -986,23 +986,24 @@ asmlinkage int __exception do_debug_exception(unsigned long addr_if_watchpoint,
>>>>>>  	if (user_mode(regs) && pc > TASK_SIZE)
>>>>>>  		arm64_apply_bp_hardening();
>>>>>>  
>>>>>> +	irqflags = fault_entry(regs);
>>>>>> +
>>>>>>  	if (!inf->fn(addr_if_watchpoint, esr, regs)) {
>>>>>>  		rv = 1;
>>>>>>  	} else {
>>>>>>  		struct siginfo info;
>>>>>>  
>>>>>> -		irqflags = fault_entry(regs);
>>>>>> -
>>>>>>  		clear_siginfo(&info);
>>>>>>  		info.si_signo = inf->sig;
>>>>>>  		info.si_errno = 0;
>>>>>>  		info.si_code  = inf->code;
>>>>>>  		info.si_addr  = (void __user *)pc;
>>>>>>  		arm64_notify_die(inf->name, regs, &info, esr);
>>>>>> -		fault_exit(irqflags);
>>>>>>  		rv = 0;
>>>>>>  	}
>>>>>>  
>>>>>> +	fault_exit(irqflags);
>>>>>> +
>>>>>>  	if (interrupts_enabled(regs))
>>>>>>  		trace_hardirqs_on();
>>>>>>
>>>>>
>>>>> I've just thrown this at my setup but it had no impact. If you can't
>>>>> reproduce, let me know.
>>>>>
>>>>
>>>> You seem to be running kvm/arm64, so I will likely be able to reproduce.
>>>>
>>>
>>> More precisely, it's just QEMU: I was using the image we generate with
>>> xenomai-images and that startup script.
>>>
>>> Jan
>>>
>>
>> No issue to reproduce both splashes. However, applying the patch I just sent silences the warning triggered by send_user_sigtrap() here. Can you confirm it does not on your end? (the other one at tick-sched.c:982 is still there as expected though). If so, please send your .config, just in case I got lucky with the configuration.
>>
> 
> Hmm, I checked twice that I actually ran the kernel with your patch, and
> it really had no effect for me. Attached the .config I used. With that,
> I only had to run "smokey --run=gdb".
> 

Checked again, and there is actually an effect, possibly the same one
you saw: the splash backtrace changed - or we moved on to another bug.

[   90.051993] DEBUG_LOCKS_WARN_ON(!irqs_disabled() && !hard_irqs_disabled())
[   90.052566] WARNING: CPU: 0 PID: 1661 at ../kernel/locking/lockdep.c:2899 lockdep_hardirqs_off+0xb0/0xc0
[   90.053469] Modules linked in: crc32_ce crct10dif_ce
[   90.054372] CPU: 0 PID: 1661 Comm: smokey Tainted: G        W         4.19.55+ #12
[   90.055416] Hardware name: linux,dummy-virt (DT)
[   90.055987] I-pipe domain: Linux
[   90.056457] pstate: 40000345 (nZcv DAiF -PAN -UAO)
[   90.056848] pc : lockdep_hardirqs_off+0xb0/0xc0
[   90.057210] lr : lockdep_hardirqs_off+0xb0/0xc0
[   90.057477] sp : ffff00000d1d3d70
[   90.057686] x29: ffff00000d1d3d70 x28: ffff8000363f4380 
[   90.058066] x27: 0000000000000000 x26: 0000000000000000 
[   90.058446] x25: 0000aaaaaaab39ec x24: 000000000000003c 
[   90.058895] x23: 0000ffffbf67a750 x22: 00000000f2000000 
[   90.059621] x21: ffff000008081a70 x20: ffff000008081a70 
[   90.060059] x19: ffff8000363f4380 x18: 0000000000000400 
[   90.060426] x17: 0000000000000000 x16: 0000000000000000 
[   90.060769] x15: 0000000000000400 x14: 0000000000000400 
[   90.061135] x13: 0000000000000000 x12: 0000000000000000 
[   90.061480] x11: 0000000000000000 x10: 0000000000000001 
[   90.061956] x9 : 0000000000000000 x8 : ffff0000092df808 
[   90.062307] x7 : ffff000008152fd8 x6 : 0000000000000000 
[   90.062653] x5 : 0000000000000000 x4 : 0000000000000001 
[   90.063099] x3 : 0000000000000007 x2 : 0000000000000006 
[   90.063448] x1 : d421eb0c5053da00 x0 : 0000000000000000 
[   90.063890] Call trace:
[   90.064090]  lockdep_hardirqs_off+0xb0/0xc0
[   90.064351]  trace_hardirqs_off+0x100/0x200
[   90.064608]  do_debug_exception+0x210/0x268
[   90.064854]  el0_dbg+0x14/0x1c
[   90.065087] irq event stamp: 22309
[   90.065362] hardirqs last  enabled at (22309): [<ffff000008c36774>] _raw_spin_unlock_irq+0x2c/0x60
[   90.065886] hardirqs last disabled at (22308): [<ffff000008c2fe40>] __schedule+0x90/0x9f0
[   90.066356] softirqs last  enabled at (22302): [<ffff00000808212c>] __do_softirq+0x2dc/0x480
[   90.066836] softirqs last disabled at (22285): [<ffff0000080ed304>] irq_exit+0x13c/0x148
[   90.067417] ---[ end trace 7724171b5c7790e1 ]---

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

