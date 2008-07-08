Message-ID: <487331AE.5070009@domain.hid>
Date: Tue, 08 Jul 2008 11:21:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <200807071745.31720@domain.hid> <48723D5D.6020008@domain.hid>
	<48732793.7090605@domain.hid>
In-Reply-To: <48732793.7090605@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Kernel panic: not syncing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Petr Cervenka <grugh@domain.hid>, xenomai@xenomai.org

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> Petr Cervenka wrote:
>>> Hello,
>>> I'm not sure if I'm not off topic.
>>> We use Linux 2.6.24 and Xenomai 2.4.1. Occasionally (once in few days) we get an kernel panic and I don't know If it's our fault or a problem of kernel/xenomai/adeos/configuration/hw/...
>>> If you have any questions, i'll try to answer them. Any help is welcome.
>> It is an I-pipe issue, probably. We have to somewhat forge the register frame
>> passed to the Linux tick handler, since we may delay that call. Some register
>> values the profiling code attempts to dereference to find the preempted code may
>> be wrong in our case.
>>
>> Could you 1) send back a disassembly of the profile_tick routine in your kernel
>> image, then apply the following patch to check whether it improves the situation
>> as well? TIA,
>>
>> --- 2.6.24-x86-2.0-03/arch/x86/kernel/ipipe.c~	2008-02-11 10:48:24.000000000 +0100
>> +++ 2.6.24-x86-2.0-03/arch/x86/kernel/ipipe.c	2008-07-07 17:55:36.000000000 +0200
>> @@ -933,12 +933,7 @@
>>  		tick_regs->eip = regs.eip;
>>  		tick_regs->ebp = regs.ebp;
>>  #else /* !CONFIG_X86_32 */
>> -		tick_regs->ss = regs->ss;
>> -		tick_regs->rsp = regs->rsp;
>> -		tick_regs->eflags = regs->eflags;
>> -		tick_regs->cs = regs->cs;
>> -		tick_regs->rip = regs->rip;
>> -		tick_regs->rbp = regs->rbp;
>> +		*tick_regs = *regs;
>>  #endif /* !CONFIG_X86_32 */
> 
> I'm fairly sure that this won't make a difference. According to Petr's
> first dump we crash in profile_pc, and there the kernel pokes around on
> the stack of the interrupted context (Petr, you are running SMP,
> right?). The question is if this stack may have vanished or may have
> been swapped out after capturing the registers.

When Xenomai has forwarded the tick to linux, Linux tick handler is 
executed upon resume to user-space, so, if the stack had to vanish, it 
would have to vanish upon execution of another interrupt handler before 
the tick handler. However, I believe that only do_exit can kill a task, 
and I am not sure if it can be called from an interrupt handler. As for 
the stack being swapped out, it is kmalloced memory, so, it is impossible.


-- 
                                                  Gilles.

