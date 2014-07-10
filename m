Message-ID: <53BECD7D.2060003@xenomai.org>
Date: Thu, 10 Jul 2014 19:29:33 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1404677764.4624.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <53B9BC6A.9070501@xenomai.org>
 <1404835832.96010.YahooMailNeo@web171606.mail.ir2.yahoo.com>
 <53BD10C2.60109@xenomai.org>
 <1404942153.53492.YahooMailNeo@web171605.mail.ir2.yahoo.com>
 <53BE5DC6.9040406@xenomai.org>
 <1405012399.63072.YahooMailNeo@web171605.mail.ir2.yahoo.com>
In-Reply-To: <1405012399.63072.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Issue with cobalt_monitor_wait()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/10/2014 07:13 PM, Matthias Schneider wrote:
>
>
>
>
> ----- Original Message -----
>> From: Philippe Gerum <rpm@xenomai.org>
>> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai.org" <xenomai@xenomai.org>
>> Cc:
>> Sent: Thursday, July 10, 2014 11:32 AM
>> Subject: Re: [Xenomai] Issue with cobalt_monitor_wait()
>>
>> On 07/09/2014 11:42 PM, Matthias Schneider wrote:
>>>   ----- Original Message -----
>>>
>>>>   From: Philippe Gerum <rpm@xenomai.org>
>>>>   To: Matthias Schneider <ma30002000@yahoo.de>;
>> "xenomai@xenomai.org" <xenomai@xenomai.org>
>>>>   Cc:
>>>>   Sent: Wednesday, July 9, 2014 11:52 AM
>>>>   Subject: Re: [Xenomai] Issue with cobalt_monitor_wait()
>>>>
>>>>   On 07/08/2014 06:10 PM, Matthias Schneider wrote:
>>>>>     ----- Original Message -----
>>>>>
>>>>>>     From: Philippe Gerum <rpm@xenomai.org>
>>>>>>     To: Matthias Schneider <ma30002000@yahoo.de>;
>>>>   "xenomai@xenomai.org" <xenomai@xenomai.org>
>>>>>>     Cc:
>>>>>>     Sent: Sunday, July 6, 2014 11:15 PM
>>>>>>     Subject: Re: [Xenomai] Issue with cobalt_monitor_wait()
>>>>>>
>>>>>>     On 07/06/2014 10:16 PM, Matthias Schneider wrote:
>>>>>>
>>>>>>     [snip]
>>>>>>
>>>>>>>       On thing I do not understand is:
>>>>>>>
>>>>>>>       in kernel cobalt_monitor_wait(), the synch object is
>> unlocked via
>>>>>>>       xnsynch_release(). What happens if this synchobj was
>> locked via
>>>>>>>       mon->gate.fastlock ? Shouldnt that also be released?
>>>>>>>
>>>>>>
>>>>>>     xnsynch_release() handles fastlocks as well.
>>>>>>
>>>>>>
>>>>>>>       What other reason could there be if the synch object
>> was released
>>>>>>>       via xnsynch_release, xnsynch_acquire was interrupted
>> for
>>>>>>>       xnsynch_release to block?
>>>>>>>
>>>>>>
>>>>>>     Since the issue seems to be easily reproducible, could you
>> send a
>>>>>>     self-contained piece of code illustrating it?
>>>>>>
>>>>>>     Also, please mention if you are seeing this issue only when
>> running
>>>>   your
>>>>>>     app over GDB, or if it currently happens without any debugger
>> attached.
>>>>>>
>>>>>>     TIA,
>>>>>
>>>>>
>>>>>     It seems I have not described the problematic scenario completely
>> -
>>>>>
>>>>>     there were two other threads that call called syncobj_lock()
>>>>>     / cobalt_monitor_enter() at about the same time. (Actually there
>>>>>     are three concurrent on the queue that is being tested, two
>> receive
>>>>>     operation and one send operation). I am pretty sure that the
>> issue is
>>>>>     extremely timing dependent.
>>>>>
>>>>>     Anyway, the testcase would be
>>>>>
>>>>>     queue_test_receive_peek_multiple_tasks()
>>>>>
>>>>
>>>>   I could not reproduce the issue yet, but could you check if this patch
>>>>   has any influence on this bug? TIA,
>>>>
>>>>   diff --git a/kernel/cobalt/posix/syscall.c
>> b/kernel/cobalt/posix/syscall.c
>>>>   index d921d81..3856794 100644
>>>>   --- a/kernel/cobalt/posix/syscall.c
>>>>   +++ b/kernel/cobalt/posix/syscall.c
>>>>   @@ -156,7 +156,7 @@ static struct xnsyscall cobalt_syscalls[] = {
>>>>          SKINCALL_DEF(sc_cobalt_monitor_enter, cobalt_monitor_enter,
>> primary),
>>>>          SKINCALL_DEF(sc_cobalt_monitor_wait, cobalt_monitor_wait,
>>>>   nonrestartable),
>>>>          SKINCALL_DEF(sc_cobalt_monitor_sync, cobalt_monitor_sync,
>>>>   nonrestartable),
>>>>   -    SKINCALL_DEF(sc_cobalt_monitor_exit, cobalt_monitor_exit,
>> primary),
>>>>   +    SKINCALL_DEF(sc_cobalt_monitor_exit, cobalt_monitor_exit,
>> nonrestartable),
>>>>          SKINCALL_DEF(sc_cobalt_event_init, cobalt_event_init, current),
>>>>          SKINCALL_DEF(sc_cobalt_event_destroy, cobalt_event_destroy,
>> current),
>>>>          SKINCALL_DEF(sc_cobalt_event_wait, cobalt_event_wait, primary),
>>>>   diff --git a/lib/cobalt/internal.c b/lib/cobalt/internal.c
>>>>   index e0d990d..6c1331d 100644
>>>>   --- a/lib/cobalt/internal.c
>>>>   +++ b/lib/cobalt/internal.c
>>>>   @@ -230,6 +230,7 @@ int cobalt_monitor_exit(cobalt_monitor_t *mon)
>>>>          struct cobalt_monitor_data *datp;
>>>>          unsigned long status;
>>>>          xnhandle_t cur;
>>>>   +    int ret;
>>>>
>>>>          __sync_synchronize();
>>>>
>>>>   @@ -246,9 +247,13 @@ int cobalt_monitor_exit(cobalt_monitor_t *mon)
>>>>          if (xnsynch_fast_release(&datp->owner, cur))
>>>>              return 0;
>>>>      syscall:
>>>>   -    return XENOMAI_SKINCALL1(__cobalt_muxid,
>>>>   -                 sc_cobalt_monitor_exit,
>>>>   -                 mon);
>>>>   +    do
>>>>   +        ret = XENOMAI_SKINCALL1(__cobalt_muxid,
>>>>   +                    sc_cobalt_monitor_exit,
>>>>   +                    mon);
>>>>   +    while (ret == -EINTR);
>>>>   +
>>>>   +    return ret;
>>>>      }
>>>>
>>>>      int cobalt_monitor_wait(cobalt_monitor_t *mon, int event,
>>>>
>>>
>>>
>>>   Hm, it seems when I run into the issue, cobalt_monitor_exit() isnt
>>>   called at all...
>>>
>>>   Having compiled the cobalt kernel without optimization,
>>>   I noticed that cobalt_monitor_wait() actually sets u_ret = -EINTR and
>>>   apparently cobalt_monitor_enter_inner() seems to work, thus setting ret
>>>   to 0. However, in internal.c:cobalt_monitor_wait (in user mode),
>>>     both ret and opret seem to be set to -EINTR. This would explain that
>>>   the second call of internal.c:cobalt_monitor_wait to cobalt_monitor_enter
>>>   will block indefinitely since the sync object is already locked.
>>>
>>>   Investigating what else happens on the way back to user mode, it seems
>>>   that the return code is changed from 0 to -EINTR by the following stack:
>>>
>>>   #0  __xn_error_return (regs=0xde0fffb0, v=-4) at
>> arch/arm/xenomai/include/asm/xenomai/syscall.h:62
>>>   #1  prepare_for_signal (p=<optimized out>,
>> thread=thread@entry=0xde702e08, regs=regs@entry=0xde0fffb0,
>> sysflags=sysflags@entry=134) at kernel/xenomai/shadow.c:1842
>>>   #2  0xc00c68a8 in handle_head_syscall (regs=0xde0fffb0, ipd=0xc07d63c0
>> <xnarch_machdata>) at kernel/xenomai/shadow.c:1996
>>>   #3  ipipe_syscall_hook (ipd=0xc07d63c0 <xnarch_machdata>,
>> regs=0xde0fffb0) at kernel/xenomai/shadow.c:2164
>>>   #4  0xc00959a8 in __ipipe_notify_syscall (regs=regs@entry=0xde0fffb0) at
>> kernel/ipipe/core.c:982
>>>   #5  0xc0015c90 in __ipipe_syscall_root (scno=<optimized out>,
>> regs=0xde0fffb0) at arch/arm/kernel/ipipe.c:417
>>>
>>>   Apperently, the assumption of internal.c:cobalt_monitor_wait that a
>>>   syscall return -EINTR indicates a failure to re-lock the sync object
>>>   does not hold in this case. There are probably other cases where
>>>   the same scenario may occur
>>>
>>>   Unfortunately I do not yet know how to resolve this issue...
>>>
>>
>> Actually, you did it. Thanks for the analysis. As you mentioned, the basic issue
>> is with relocking the monitor gate upon EINTR, which is wrong: there must be a
>> reason why we do this from userland...
>> The reason is with any blocking Cobalt syscall which must be aborted upon Linux
>> signal receipt, which causes XNBREAK to be present in the thread state flags
>> (handle_sigwake_event -> __xnshadow_kick()). And we must not hold the gate
>> lock until the signal handler has run.
>>
>> When a signal hits the sleeping syscall, we must unwind the context all way down
>> the regular Linux syscall path, so that a signal frame is built for it. As part
>> of this process, prepare_for_signal() switches the signaled context from primary
>> to secondary mode.
>>
>> In short, receiving EINTR in kernel space waiting for a monitor means unwinding
>> back to the userland call site first, keeping the monitor gate free while
>> running the handler, then grabbing the gate lock anew prior to returning to the
>> caller.
>>
>> Unblocking a thread forcibly can also happen when the latter receives the
>> internal/special/not-so-hidden SIGRELS notification (see __cobalt_kill()), in
>> which case XNBREAK is raised too. In such a case, we will relock from userland
>> the same way.
>>
>> I need to review the entire machinery for more non-sense of mine, but in the
>> meantime, could you try this patch?
>>
>> TIA,
>>
>> diff --git a/kernel/cobalt/posix/monitor.c b/kernel/cobalt/posix/monitor.c
>> index 0ecaa6a..a61d028 100644
>> --- a/kernel/cobalt/posix/monitor.c
>> +++ b/kernel/cobalt/posix/monitor.c
>> @@ -283,9 +283,11 @@ int cobalt_monitor_wait(struct cobalt_monitor_shadow __user
>> *u_mon,
>>          if (list_empty(&mon->waiters) &&
>> !xnsynch_pended_p(&mon->drain))
>>              datp->flags &= ~COBALT_MONITOR_PENDED;
>>
>> -        if (info & XNBREAK)
>> +        if (info & XNBREAK) {
>>              opret = -EINTR;
>> -        else if (info & XNTIMEO)
>> +            goto out;
>> +        }
>> +        if (info & XNTIMEO)
>>              opret = -ETIMEDOUT;
>>
>>      }
>>
>> --
>> Philippe.
>>
>
> Thanks, current forge/next including the above patch finally passes the test on
> my setup. However I seem to be unable to determine which signal actually interrupts
> the syscall. debugging all signals with gdb does not show a single occurance...
>

Because we cheat, we route internal notifications we need to deliver 
from secondary mode via SIGWINCH, and gdb won't trap it by default.

-- 
Philippe.

