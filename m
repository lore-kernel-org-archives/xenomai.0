MIME-Version: 1.0
References: <CAOVUHqZudUKeT+8=_w_5o3FSComTbAyqbsa0oDx+YHkNSP_GNw@mail.gmail.com>
 <871qz2fem1.fsf@xenomai.org>
 <CAOVUHqY9B3t9teWK9GBPeAf70M-kGsDRpK7c+vLTQfMCMs-BPQ@mail.gmail.com>
In-Reply-To: <CAOVUHqY9B3t9teWK9GBPeAf70M-kGsDRpK7c+vLTQfMCMs-BPQ@mail.gmail.com>
From: Matt Klass <Matt.Klass@telosalliance.com>
Date: Mon, 18 Apr 2022 11:25:55 -0400
Message-ID: <CAOVUHqZL9ZnJ+PokDE0o+=xqgHtic_UpYj5pEPRr0_uF-sV1Eg@mail.gmail.com>
Subject: Re: waitqueue vs. mutex behavior
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

We've figured out our problem here and I wanted to update the thread to
give closure, and to make sure any future inquiring minds don't have to
wonder what was going on here.

First, we confirmed that our colleague's usage of
rtdm_waitqueue_lock/unlock was only for it's creation of an atomic section.
We decided to make things less confusing and simply use
atomic_section_enter/leave.

Second, we discovered that one of our atomic sections had a udelay call
which, as you mentioned Jan, is not allowed in an atomic section. After
reworking the code to avoid making the call to udelay, our problems have
disappeared.

Thanks to you two for your help!

Matt

On Thu, Mar 17, 2022 at 9:02 AM Matt Klass <Matt.Klass@telosalliance.com>
wrote:

> Thank you Jan, Philippe. Your responses have given us a lot to look into
> and a lot to learn. We'll come back with a more detailed response once
> we've gained a little more understanding on our end.
>
> Matt
>
> On Wed, Mar 16, 2022 at 5:09 AM Philippe Gerum <rpm@xenomai.org> wrote:
>
>>
>> Matt Klass via Xenomai <xenomai@xenomai.org> writes:
>>
>> > Using Xenomai 3.0.10, with kernel 4.9.128-05789, on armv7, we're having
>> > problems with the functionality of rtdm_waitqueues. The code was
>> written by
>> > a Xenomai-adept developer who has since left for greener pastures.
>> >
>> > We have two functions that use rtdm_waitqueue_lock/unlock on the same
>> > rtdm_waitqueue_t to manage access to a shared data structure. One is an
>> > rtdm_task_t that runs periodically every 1ms, the second is an IOCTL
>> > handler.
>>
>> Is that a RTDM non-rt ioctl() handler?
>>
>> >
>> > Problem: In some circumstances, one of the two functions will acquire
>> the
>> > lock, and access the shared data structure. But before the first
>> function
>> > releases the lock, the second function seems to also acquire the lock,
>> and
>> > begin to access its own access of the shared data structure. The second
>> > function releases its lock after its work is complete, and then when the
>> > first function tries to release the lock, it gets an "already unlocked"
>> > error from Xenomai:
>> >
>> > [Xenomai] lock 80f10020 already unlocked on CPU #0
>> >           last owner = kernel/xenomai/sched.c:908 (___xnsched_run(),
>> CPU #0)
>> > [<8010ed78>] (unwind_backtrace) from [<8010b5f0>] (show_stack+0x10/0x14)
>> > [<8010b5f0>] (show_stack) from [<801c8c08>]
>> (xnlock_dbg_release+0x12c/0x138)
>> > [<801c8c08>] (xnlock_dbg_release) from [<801be110>]
>> (___xnlock_put+0xc/0x38)
>> > [<801be110>] (___xnlock_put) from [<7f000434>]
>> > (myengine_rtdm_waitqueue_unlock_with_num+0xf8/0x13c [engine_rtnet])
>> > [<7f000434>] (myengine_rtdm_waitqueue_unlock_with_num [engine_rtnet])
>> from
>> > [<7f00ace8>] (engine_rtnet_periodic_task+0x604/0x660 [engine_rtnet])
>> > [<7f00ace8>] (engine_rtnet_periodic_task [engine_rtnet]) from
>> [<801c73ac>]
>> > (kthread_trampoline+0x68/0xa4)
>> > [<801c73ac>] (kthread_trampoline) from [<80147190>]
>> (kthread+0x108/0x110)
>> > [<80147190>] (kthread) from [<80107cd4>] (ret_from_fork+0x18/0x24)
>> >
>>
>> This is difficult to comment on this without seeing the whole code using
>> the wait queue, there are several wait() calls for RTDM waitqueues. It
>> is possible that the waitqueue construct may be misused.
>>
>> >
>> > These waitqueues were originally mutexes, and the above-mentioned adept
>> > committed this change to waitqueues seven years ago with the following
>> > comment: "Use Wait Queue instead of Mutex, because Mutex can't be called
>> > from the non-RT context."
>> >
>> > We'd expect that once one of the functions obtains the lock on the
>> > waitqueue, the other would be blocked until the first function releases
>> the
>> > lock. It's quite possible, likely really, that we don't understand the
>> > differences between mutexes and waitqueues. We've looked at the online
>> > Xenomai documentation on waitqueues, but we have not been enlightened.
>> >
>>
>> RTDM mutexes follow the common POSIX mutex semantics, with priority
>> inheritance force enabled. On the other hand, waitqueues allow for any
>> number of threads to wait for an arbitrary condition only known by the
>> application to happen.
>>
>> Strictly speaking, rtdm_waitqueue_lock/unlock is supposed to bind the
>> condition and the waitqueue access atomically together, in order to
>> prevent wakeup signals from being missed (pretty much like the common
>> POSIX mutex+condvar logic). Typically, this lock is taken by a waiter
>> before it checks the condition then goes sleeping on the associated wq,
>> and released atomically by the scheduler right before switching out that
>> waiter as the condition is still unmet.
>>
>> So if this is about serializing all accesses to a user-defined shared
>> memory, the wq semantics would not fit well, and waitqueue_lock/unlock
>> would not serialize anything past the waitqueue handling code itself.
>>
>> >
>> > Would you have any suggestions on things we should do (or not do) to
>> figure
>> > out what's going on?
>> >
>>
>> If the idea is to serialize non-RT (ioctl_nrt handler?) vs RT contexts,
>> then no RTDM synchronization object will do, these can only do RT/RT
>> serialization.
>>
>> Xenomai 3 cannot do write/write serialization between non-RT and RT
>> stages natively (Xenomai 4 can do so via the so-called 'stax' objects,
>> but this is not going to help you ATM I guess). If this is read/write,
>> and the non-RT ioctl handler is the reader, _and_ the shared data is
>> fairly small, then you might resort to some kind of ad hoc sequence lock
>> mechanism to implement this.
>>
>> --
>> Philippe.
>>
>
