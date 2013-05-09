Message-ID: <518BACDB.8040203@xenomai.org>
Date: Thu, 09 May 2013 16:04:11 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <51826EEA.1090202@mitrol.it>	<51830D98.7090309@xenomai.org>	<5183CDD6.80400@mitrol.it>	<518A06C9.50204@mitrol.it>
	<518A4C09.8030906@xenomai.org>	<518A505C.2090207@mitrol.it>
	<518A52A7.5000801@xenomai.org>	<518A5600.20508@mitrol.it>
	<518A6195.7030206@mitrol.it>	<518A77F8.3070404@xenomai.org>
	<518A78DF.7020300@xenomai.org>	<518BA678.9030406@xenomai.org>
	<518BAA18.2090209@mitrol.it> <518BAB98.4030108@xenomai.org>
In-Reply-To: <518BAB98.4030108@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Re : Sporadic problem : rt_task_sleep locked after
 debugging
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 05/09/2013 03:58 PM, Gilles Chanteperdrix wrote:
> On 05/09/2013 03:52 PM, Paolo Minazzi wrote:
>
>> Il 09/05/2013 15.36, Philippe Gerum ha scritto:
>>> On 05/08/2013 06:10 PM, Philippe Gerum wrote:
>>>> On 05/08/2013 06:06 PM, Philippe Gerum wrote:
>>>>> On 05/08/2013 04:30 PM, Paolo Minazzi wrote:
>>>>>> I think to be very near to the solution of this problem.
>>>>>> Thanks to Gilles for his patience.
>>>>>>
>>>>>> Now I will retry to make a summary of the problem.
>>>>>>
>>>>> <snip>
>>>>>
>>>>>> The thread 1 finds thread 70 in debug mode !
>>>>>>
>>>>> Which is expected. thread 70 has to be scheduled in with no pending
>>>>> ptrace signals for leaving this mode, and this may happen long after
>>>>> the truckload of other threads releases the CPU.
>>>>>
>>>>>> My patch adjust this problem.
>>>>>>
>>>>>> I realize that it is a very special case, but it is my case.
>>>>>>
>>>>>> I'd like to know if the patch is valid or can be written in a different
>>>>>> way.
>>>>>> For example, I could insert my patch directly in xnpod_delete_thread().
>>>>>>
>>>>>> The function unlock_timers() cannot be called from
>>>>>> xenomai-2.5.6/ksrc/skins/native/task.c
>>>>>> because it is defined static. This is a detail. There are simple ways to
>>>>>> solve this.
>>>>>>
>>>>> No, really the patch is wrong, but what you expose does reveal a bug
>>>>> in the Xenomai core for sure. As Gilles told you, you would be only
>>>>> papering over that real bug, which would likely show up in a different
>>>>> situation.
>>>>>
>>>>> First we need to check for a lock imbalance, I don't think that code
>>>>> is particularly safe.
>>>> I mean a lock imbalance introduced by an unexpected race between the
>>>> locking/unlocking calls. The assertions introduced by this patch might
>>>> help detecting this, with some luck.
>>>>
>>> Could you apply that patch below, and report whether some task triggers
>>> the message it introduces, when things go wrong with gdb? TIA,
>>>
>>> diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
>>> index 868f98f..2da3265 100644
>>> --- a/ksrc/nucleus/pod.c
>>> +++ b/ksrc/nucleus/pod.c
>>> @@ -1215,6 +1215,10 @@ void xnpod_delete_thread(xnthread_t *thread)
>>>    #else /* !CONFIG_XENO_HW_UNLOCKED_SWITCH */
>>>    	} else {
>>>    #endif /* !CONFIG_XENO_HW_UNLOCKED_SWITCH */
>>> +		if (xnthread_test_state(thread, XNSHADOW|XNMAPPED) == XNSHADOW)
>>> +			printk(KERN_WARNING "%s: deleting unmapped shadow %s\n",
>>> +			       __func__, thread->name);
>>> +
>>>    		xnpod_run_hooks(&nkpod->tdeleteq, thread, "DELETE");
>>>
>>>    		xnsched_forget(thread);
>>>
>> I have tried but no messages on the console.
>> This time I'm sure. To be sure I have added other messages and I see them.
>> Paolo
>
>
> On my side, I have run your example with CONFIG_XENO_OPT_DEBUG_NUCLEUS
> turned on, and I get the following message in the same conditions as
> you:
>
> Xenomai: xnshadow_unmap invoked for a non-current task (t=demo0/p=demo0)
> Master time base: clock=8300431919
> (...)
> [<c002da88>] (unwind_backtrace+0x0/0xf4) from [<c002bf68>] (show_stack+0x20/0x24)
> [<c002bf68>] (show_stack+0x20/0x24) from [<c00e6198>] (xnshadow_unmap+0x1e0/0x270)
> [<c00e6198>] (xnshadow_unmap+0x1e0/0x270) from [<c010918c>] (__shadow_delete_hook+0x4c/0x54)
> [<c010918c>] (__shadow_delete_hook+0x4c/0x54) from [<c00a3c78>] (xnpod_fire_callouts+0x44/0x80)
> [<c00a3c78>] (xnpod_fire_callouts+0x44/0x80) from [<c00ae220>] (xnpod_delete_thread+0x91c/0x15b4)
> [<c00ae220>] (xnpod_delete_thread+0x91c/0x15b4) from [<c0106fc4>] (rt_task_delete+0x100/0x344)
> [<c0106fc4>] (rt_task_delete+0x100/0x344) from [<c01119a8>] (__rt_task_delete+0x8c/0x90)
> [<c01119a8>] (__rt_task_delete+0x8c/0x90) from [<c00e6f08>] (losyscall_event+0xd8/0x268)
> [<c00e6f08>] (losyscall_event+0xd8/0x268) from [<c007f7f0>] (__ipipe_dispatch_event+0x100/0x264)
> [<c007f7f0>] (__ipipe_dispatch_event+0x100/0x264) from [<c002e444>] (__ipipe_syscall_root+0x64/0x13c)
> [<c002e444>] (__ipipe_syscall_root+0x64/0x13c) from [<c002736c>] (vector_swi+0x6c/0xac)
>
> So, maybe the XNSHADOW bit is not set yet? Because the deletion hooks
> are definitely run when the bug happens.
>

XNSHADOW is set early when the tcb is created over the userland 
trampoline routine. The problem is that such thread may be still bearing 
XNDORMANT, so it would not be caught in the userland kill redirect, 
earlier in xnpod_delete(). This would explain in turn why the latest 
assertion did not trigger. Ok, that would be a bug. Need to think about 
this now.

-- 
Philippe.

