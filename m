Message-ID: <54DDE4B8.2020902@xenomai.org>
Date: Fri, 13 Feb 2015 12:49:12 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <mailman.178.1423763115.27969.xenomai-git@xenomai.org>
 <54DDD826.7020509@siemens.com>
In-Reply-To: <54DDD826.7020509@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Philippe Gerum : cobalt/x86: exclude
 %rsp from mayday fixup
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 02/13/2015 11:55 AM, Jan Kiszka wrote:
> On 2015-02-12 18:45, xenomai-git-request@xenomai.org wrote:
>> Module: xenomai-3
>> Branch: next
>> Commit: 667a361408e34b69ea761dcaf0ec8d8081d18cb3
>> URL:    http://git.xenomai.org/?p=xenomai-3.git;a=commit;h=667a361408e34b69ea761dcaf0ec8d8081d18cb3
>>
>> Author: Philippe Gerum <rpm@xenomai.org>
>> Date:   Thu Feb 12 18:39:02 2015 +0100
>>
>> cobalt/x86: exclude %rsp from mayday fixup
>>
>> ---
>>
>>  kernel/cobalt/arch/x86/mayday.c |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/cobalt/arch/x86/mayday.c b/kernel/cobalt/arch/x86/mayday.c
>> index 62c5eea..22a9196 100644
>> --- a/kernel/cobalt/arch/x86/mayday.c
>> +++ b/kernel/cobalt/arch/x86/mayday.c
>> @@ -204,11 +204,12 @@ void xnarch_fixup_mayday(struct xnarchtcb *tcb, struct pt_regs *regs)
>>  		test_thread_flag(TIF_IA32)) {
>>  		regs->ip = tcb->mayday.ip;
>>  		regs->ax = tcb->mayday.ax;
>> +		regs->sp = tcb->mayday.sp;
>>  	} else
>>  		regs->ax = tcb->mayday.ip;
>>  #else
>>  	regs->ip = tcb->mayday.ip;
>>  	regs->ax = tcb->mayday.ax;
>> -#endif
>>  	regs->sp = tcb->mayday.sp;
>> +#endif
>>  }
> 
> That makes me wonder why we have to save/restore at all? In the end, the
> syscall triggered by the ia32 trampoline code doesn't push anything to
> the user's stack, does it?
> 

Saving %esp in this case is a leftover from the legacy implementation
still available in 2.x, which allows invoking the mayday trap using the
sysenter mechanism. We had to save/restore %esp in this case, since we
could not run the syscall epilogue for fixing up the stack prior to
returning to userland. I'll remove this in -rc4, but after some tests.
int80 already saves all we need on stack, so no need to plan for this.

> But I'm also confused that my tests without this patch were still
> successful...
> 

Because %rsp is saved in per_cpu(old_rsp), not restored from the stack
when entering via the syscall instruction in long mode. This saved us.

-- 
Philippe.

