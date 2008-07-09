Date: Wed, 09 Jul 2008 17:19:58 +0200
From: "Petr Cervenka" <grugh@domain.hid>
MIME-Version: 1.0
Message-ID: <200807091719.17625@domain.hid>
References: 200807071745.31720@domain.hid> <48723D5D.6020008@domain.hid>
	<48732793.7090605@domain.hid> <487331AE.5070009@domain.hid>
	<48733483.2050204@domain.hid>
In-Reply-To: <48733483.2050204@domain.hid>
Content-Type: text/plain; charset="windows-1250"
Content-Transfer-Encoding: 8bit
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
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
>Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Philippe Gerum wrote:
>>>> Petr Cervenka wrote:
>>>>> Hello,
>>>>> I'm not sure if I'm not off topic.
>>>>> We use Linux 2.6.24 and Xenomai 2.4.1. Occasionally (once in few
>>>>> days) we get an kernel panic and I don't know If it's our fault or a
>>>>> problem of kernel/xenomai/adeos/configuration/hw/...
>>>>> If you have any questions, i'll try to answer them. Any help is
>>>>> welcome.
>>>> It is an I-pipe issue, probably. We have to somewhat forge the
>>>> register frame
>>>> passed to the Linux tick handler, since we may delay that call. Some
>>>> register
>>>> values the profiling code attempts to dereference to find the
>>>> preempted code may
>>>> be wrong in our case.
>>>>
>>>> Could you 1) send back a disassembly of the profile_tick routine in
>>>> your kernel
>>>> image, then apply the following patch to check whether it improves
>>>> the situation
>>>> as well? TIA,
>>>>
>>>> --- 2.6.24-x86-2.0-03/arch/x86/kernel/ipipe.c~    2008-02-11
>>>> 10:48:24.000000000 +0100
>>>> +++ 2.6.24-x86-2.0-03/arch/x86/kernel/ipipe.c    2008-07-07
>>>> 17:55:36.000000000 +0200
>>>> @@ -933,12 +933,7 @@
>>>>          tick_regs->eip = regs.eip;
>>>>          tick_regs->ebp = regs.ebp;
>>>>  #else /* !CONFIG_X86_32 */
>>>> -        tick_regs->ss = regs->ss;
>>>> -        tick_regs->rsp = regs->rsp;
>>>> -        tick_regs->eflags = regs->eflags;
>>>> -        tick_regs->cs = regs->cs;
>>>> -        tick_regs->rip = regs->rip;
>>>> -        tick_regs->rbp = regs->rbp;
>>>> +        *tick_regs = *regs;
>>>>  #endif /* !CONFIG_X86_32 */
>>>
>>> I'm fairly sure that this won't make a difference. According to Petr's
>>> first dump we crash in profile_pc, and there the kernel pokes around
on
>>> the stack of the interrupted context (Petr, you are running SMP,
>>> right?). The question is if this stack may have vanished or may have
>>> been swapped out after capturing the registers.
>> 
>> When Xenomai has forwarded the tick to linux, Linux tick handler is
>> executed upon resume to user-space, so, if the stack had to vanish, it
>> would have to vanish upon execution of another interrupt handler before
>> the tick handler. However, I believe that only do_exit can kill a task,
>> and I am not sure if it can be called from an interrupt handler. As for
>> the stack being swapped out, it is kmalloced memory, so, it is
impossible.
>> 
>
>Yes, vanishing stack is unlikely, more probable is an invalid state
>right from the beginning. I guess we need a full oops to say more.
>
>Petr, any chance to attach a serial cable to your box and catch those
>oopses completely via a second box? The register state would be telling,
>but also, as Philippe already requested, a disassembly of the involved
>function - in case it remain profile_pc: objdump -dS
>linux-.../arch/x86/kernel/time_64.o.
>

To your questions:
we have only user space tasks, but we use rtdm driver (with ioctl, no tasks).
The processor is Athlon X2, 64-bit distribution (Kubuntu ?7.10?), x86_64 SMP PREEMPT,
Kernel 2.6.24, Xenomai 2.4.1, adeos-ipipe-2.6.24-x86-2.0-03
I could send you my kernel config file if you want.
I will try to learn the method of oopses catching via serial cable attached second box. But I don't know if it will be possible to setup such experiment for time long enough to reproduce the error.

The following disassembly is from different machine than the one which has the kernel panics. I use it for developing and testing but it should have the same HW and kernel configuration. I can't totally sure, that the disassembly is correct, but i hope so. I junst can't recognise it. Could you explain me what does "profile_pc+0x46/0x80"? I assume the first number is the current RIP address (relative to routine start), so 0x256 in this case. But what does mean the second number?

0000000000000210 <profile_pc>:
 210:	48 83 ec 18          	sub    $0x18,%rsp
 214:	48 89 5c 24 08       	mov    %rbx,0x8(%rsp)
 219:	48 89 6c 24 10       	mov    %rbp,0x10(%rsp)
 21e:	48 89 fb             	mov    %rdi,%rbx
 221:	f6 87 88 00 00 00 03 	testb  $0x3,0x88(%rdi)
 228:	48 8b af 80 00 00 00 	mov    0x80(%rdi),%rbp
 22f:	74 12                	je     243 <profile_pc+0x33>
 231:	48 89 e8             	mov    %rbp,%rax
 234:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
 239:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
 23e:	48 83 c4 18          	add    $0x18,%rsp
 242:	c3                   	retq   
 243:	48 89 ef             	mov    %rbp,%rdi
 246:	e8 00 00 00 00       	callq  24b <profile_pc+0x3b>
 24b:	85 c0                	test   %eax,%eax
 24d:	74 e2                	je     231 <profile_pc+0x21>
 24f:	48 8b 8b 98 00 00 00 	mov    0x98(%rbx),%rcx
 256:	48 8b 11             	mov    (%rcx),%rdx
 259:	48 89 d0             	mov    %rdx,%rax
 25c:	48 c1 e8 16          	shr    $0x16,%rax
 260:	48 85 c0             	test   %rax,%rax
 263:	75 1b                	jne    280 <profile_pc+0x70>
 265:	48 8b 51 08          	mov    0x8(%rcx),%rdx
 269:	48 89 d0             	mov    %rdx,%rax
 26c:	48 c1 e8 16          	shr    $0x16,%rax
 270:	48 85 c0             	test   %rax,%rax
 273:	48 0f 45 ea          	cmovne %rdx,%rbp
 277:	eb b8                	jmp    231 <profile_pc+0x21>
 279:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
 280:	48 89 d5             	mov    %rdx,%rbp
 283:	eb ac                	jmp    231 <profile_pc+0x21>
 285:	66 66 2e 0f 1f 84 00 	nopw   %cs:0x0(%rax,%rax,1)
 28c:	00 00 00 00  


