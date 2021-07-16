References: <7321df79-b945-d152-4bb0-7792189bac2a@tin.it>
 <87k0lq79a0.fsf@xenomai.org> <e2aa120a-d4da-f288-fedc-ccd5823e5587@tin.it>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Xenomai 3: Wierd problem resuming task
In-reply-to: <e2aa120a-d4da-f288-fedc-ccd5823e5587@tin.it>
Date: Fri, 16 Jul 2021 16:58:23 +0200
Message-ID: <87h7gu71bk.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Mauro S." <mau.salvi@tin.it>
Cc: xenomai@xenomai.org


Mauro S. <mau.salvi@tin.it> writes:

> Il 16/07/21 14:06, Philippe Gerum ha scritto:
>> Mauro S. via Xenomai <xenomai@xenomai.org> writes:
>> 
>>> Hi,
>>>
>>> I'm using Xenomai3 (master branch, commit
>>> bca41678742be80c3a0d5a01935c671c385a95a1) on a X86_64bit Intel Atom
>>> x5-E8000 with 2GB RAM, using kernel from Xenomai repos, in Cobalt
>>> coniguration. SMI workaround is enabled and all latency tests are
>>> good.
>>>
>>> I'm facing with a very weird problem in my application. I have some
>>> tasks with priority < 90 that call rt_task_suspend() on themselves.
>>> Then, I have a task with priority 99 that resumes all other tasks with
>>> rt_task_resume(), when they are suspended.
>>>
>>> Sometimes a task does not get resumed.
>>>
>>> In /proc/xenomai/sched/stat I have this status for my suspendend task:
>>>
>>> CPU  PID    MSW        CSW        XSC        PF    STAT       %CPU  NAME
>>>    1  620    3          8          13         0     00048041    0.0
>>> t12
>>                                                              ^
>> That bit (XNSUSP) indicates that the core thinks the task is still
>> in
>> suspended state.
>> 
>>>
>>> Analizing the scenario attaching gdb to the application, I observe
>>> that the not-resuming task has this backtrace:
>>>
>>> #0  0x00007f0ec14c9b38 in __cobalt_kill (pid=620, sig=65) at signal.c:100
>>> 100	signal.c: No such file or directory.
>>> (gdb) bt
>>> #0  0x00007f0ec14c9b38 in __cobalt_kill (pid=620, sig=65) at signal.c:100
>>> #1  0x00007f0ec14eb379 in threadobj_suspend
>>>   (thobj=thobj@entry=0x7f0ec06bfcd0) at threadobj.c:335
>>> #2  0x00007f0ec15013dc in rt_task_suspend (task=task@entry=0x0) at
>>>   task.c:1154
>>>
>>> that seems to me OK. If I understood correctly, it is locked in its
>>> SIGSUSP handler, that calls sigsuspend() waiting SIGRESM to "restart".
>>>
>>> Then, I placed some breakpoints where rt_task_resume() were called,
>>> and in rt_task_resume() itself. I set tcb->suspends=1 with GDB and
>>> followed the subsequent call of threadobj_resume(). Then, I placed
>>> some breakpoints in threadobj_resume, I forced __THREAD_S_SUSPENDED
>>> bit in thobj->status, and I observed that __RT(kill(thobj->pid,
>>> SIGRESM)) got called, with a retval 0. thobj->pid has the right value.
>>>
>>> But the suspended task does not get resumed.
>>>
>>> Any idea/suggestion?
>>>
>> You may want to check what happens in __cobalt_kill()
>> (kernel/cobalt/posix/signal.c), and in COBALT_SYSCALL(kill, ...), to
>> make sure the call actually succeeds.
>
> I traversed the code until lib/cobalt/signal.c (__cobalt_kill()
> library-side) and I cheched retval of XENOMAI_SYSCALL2(sc_cobalt_kill, 
> pid, sig) (that is 0).
>
> If I understand correctly, kernel/cobalt/posix/signal.c is kernel
> code. Should I add printks? Or should I have to attach gdb to kernel
> (I think I'm not able)

printk() would be fine.

-- 
Philippe.

