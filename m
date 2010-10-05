Message-ID: <4CAB3450.5090105@domain.hid>
Date: Tue, 05 Oct 2010 16:21:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4CAAF0CA.7060603@domain.hid> <4CAB24D9.5000308@domain.hid>
	<4CAB2994.40505@domain.hid> <4CAB2B37.7010104@domain.hid>
	<4CAB2C4B.6090005@domain.hid> <4CAB2D1C.70907@domain.hid>
	<4CAB305B.60406@domain.hid>
In-Reply-To: <4CAB305B.60406@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Overcoming the "foreign" stack
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

Jan Kiszka wrote:
> Am 05.10.2010 15:50, Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Am 05.10.2010 15:42, Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Am 05.10.2010 15:15, Gilles Chanteperdrix wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> quite a few limitations and complications of using Linux services over
>>>>>>> non-Linux domains relate to potentially invalid "current" and
>>>>>>> "thread_info". The non-Linux domain could maintain their own kernel
>>>>>>> stacks while Linux tend to derive current and thread_info from the stack
>>>>>>> pointer. This is not an issue anymore on x86-64 (both states are stored
>>>>>>> in per-cpu variables) but other archs (e.g. x86-32 or ARM) still use the
>>>>>>> stack and may continue to do so.
>>>>>>>
>>>>>>> I just looked into this thing again as I'm evaluating ways to exploit
>>>>>>> the kernel's tracing framework also under Xenomai. Unfortunately, it
>>>>>>> does a lot of fiddling with preempt_count and need_resched, so patching
>>>>>>> it for Xenomai use would become a maintenance nightmare.
>>>>>>>
>>>>>>> An alternative, also for other use cases like kgdb and probably perf, is
>>>>>>> to get rid of our dependency on home-grown stacks. I think we are on
>>>>>>> that way already as in-kernel skins have been deprecated. The only
>>>>>>> remaining user after them will be RTDM driver tasks. But I think those
>>>>>>> could simply become in-kernel shadows of kthreads which would bind their
>>>>>>> stacks to what Linux provides. Moreover, Xenomai could start updating
>>>>>>> "current" and "thread_info" on context switches (unless this already
>>>>>>> happens implicitly). That would give us proper contexts for system-level
>>>>>>> tracing and profiling.
>>>>>>>
>>>>>>> My key question is currently if and how much of this could be realized
>>>>>>> in 2.6. Could we drop in-kernel skins in that version? If not, what
>>>>>>> about disabling them by default, converting RTDM tasks to a
>>>>>>> kthread-based approach, and enabling tracing etc. only in that case?
>>>>>>> However, this might be a bit fragile unless we can establish
>>>>>>> compile-time or run-time requirements negotiation between Adeos and its
>>>>>>> users (Xenomai) about the stack model.
>>>>>> A stupid question: why not make things the other way around: patch the
>>>>>> current and current_thread_info functions to be made I-pipe aware and
>>>>>> use an "ipipe_current" pointer to the current thread task_struct. Of
>>>>>> course, there are places where the current or current_thread_info macros
>>>>>> are implemented in assembly, so it may be not simple as it sounds, but
>>>>>> it would allow to keep 128 Kb stacks if we want. This also means that we
>>>>>> would have to put a task_struct at the bottom of every Xenomai task.
>>>>> First of all, overhead vs. maintenance. Either every access to
>>>>> preempt_count() would require a check for the current domain and its
>>>>> foreign stack flag, or I would have to patch dozens (if that is enough)
>>>>> of code sites in the tracer framework.
>>>> No. I mean we would dereference a pointer named ipipe_current. That is
>>>> all, no other check. This pointer would be maintained elsewhere. And we
>>>> modify the "current" macro, like:
>>>>
>>>> #ifdef CONFIG_IPIPE
>>>> extern struct task_struct *ipipe_current;
>>>> #define current ipipe_current
>>>> #endif
>>>>
>>>> Any calll site gets modified automatically. Or current_thread_info, if
>>>> it is current_thread_info which is obtained using the stack pointer mask
>>>> trick.
>>> The stack pointer mask trick only works with fixed-sized stacks, not a
>>> guaranteed property of in-kernel Xenomai threads.
>> Precisely the reason why I propose to replace it with a global variable
>> reference, or a per-cpu variable for SMP systems.
> 
> Then why is Linux not using this in favor of the stack pointer approach
> on, say, ARM?
> 
> For sure, we can patch all Adeos-supported archs away from stack-based
> to per-cpu current & thread_info, but I don't feel comfortable with this
> in some way invasive approach as well. Well, maybe it's just my personal
> misperception.

It is as much invasive as modifying local_irq_save/local_irq_restore.
The real question about the global pointer approach, is, if it so much
less efficient, how does Xenomai, which uses this scheme, manage to have
good performances on ARM?

-- 
					    Gilles.

