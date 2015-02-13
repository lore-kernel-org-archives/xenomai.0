Message-ID: <54DDE419.5030502@siemens.com>
Date: Fri, 13 Feb 2015 12:46:33 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
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
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 2015-02-13 11:55, Jan Kiszka wrote:
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
> But I'm also confused that my tests without this patch were still
> successful...

...because it makes no difference in practice. It seems that the
kernel's signal path saves and restores userspace sp, overwriting the
fixup so far (at least on x86-64).

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

