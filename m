Message-ID: <9905f7c4-fcbe-a61e-1dd5-a76d8ad24075@siemens.com>
Date: Tue, 15 Mar 2022 20:31:23 +0100
MIME-Version: 1.0
Subject: Re: waitqueue vs. mutex behavior
Content-Language: en-US
References: <CAOVUHqZudUKeT+8=_w_5o3FSComTbAyqbsa0oDx+YHkNSP_GNw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAOVUHqZudUKeT+8=_w_5o3FSComTbAyqbsa0oDx+YHkNSP_GNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matt Klass <Matt.Klass@telosalliance.com>, xenomai@xenomai.org

On 15.03.22 19:27, Matt Klass via Xenomai wrote:
> Using Xenomai 3.0.10, with kernel 4.9.128-05789, on armv7, we're having
> problems with the functionality of rtdm_waitqueues. The code was written by
> a Xenomai-adept developer who has since left for greener pastures.
> 
> We have two functions that use rtdm_waitqueue_lock/unlock on the same
> rtdm_waitqueue_t to manage access to a shared data structure. One is an
> rtdm_task_t that runs periodically every 1ms, the second is an IOCTL
> handler.
> 
> Problem: In some circumstances, one of the two functions will acquire the
> lock, and access the shared data structure. But before the first function
> releases the lock, the second function seems to also acquire the lock, and
> begin to access its own access of the shared data structure. The second
> function releases its lock after its work is complete, and then when the
> first function tries to release the lock, it gets an "already unlocked"
> error from Xenomai:
> 
> [Xenomai] lock 80f10020 already unlocked on CPU #0
>           last owner = kernel/xenomai/sched.c:908 (___xnsched_run(), CPU #0)
> [<8010ed78>] (unwind_backtrace) from [<8010b5f0>] (show_stack+0x10/0x14)
> [<8010b5f0>] (show_stack) from [<801c8c08>] (xnlock_dbg_release+0x12c/0x138)
> [<801c8c08>] (xnlock_dbg_release) from [<801be110>] (___xnlock_put+0xc/0x38)
> [<801be110>] (___xnlock_put) from [<7f000434>]
> (myengine_rtdm_waitqueue_unlock_with_num+0xf8/0x13c [engine_rtnet])
> [<7f000434>] (myengine_rtdm_waitqueue_unlock_with_num [engine_rtnet]) from
> [<7f00ace8>] (engine_rtnet_periodic_task+0x604/0x660 [engine_rtnet])
> [<7f00ace8>] (engine_rtnet_periodic_task [engine_rtnet]) from [<801c73ac>]
> (kthread_trampoline+0x68/0xa4)
> [<801c73ac>] (kthread_trampoline) from [<80147190>] (kthread+0x108/0x110)
> [<80147190>] (kthread) from [<80107cd4>] (ret_from_fork+0x18/0x24)
> 
> 
> These waitqueues were originally mutexes, and the above-mentioned adept
> committed this change to waitqueues seven years ago with the following
> comment: "Use Wait Queue instead of Mutex, because Mutex can't be called
> from the non-RT context."
> 
> We'd expect that once one of the functions obtains the lock on the
> waitqueue, the other would be blocked until the first function releases the
> lock. It's quite possible, likely really, that we don't understand the
> differences between mutexes and waitqueues. We've looked at the online
> Xenomai documentation on waitqueues, but we have not been enlightened.
> 
> 
> Would you have any suggestions on things we should do (or not do) to figure
> out what's going on?
> 

rtdm_waitqueue_lock/unlock is surely no replacement for
rtdm_mutex_lock/unlock to be used in non-rt contexts. It exists in order
to prepare the caller for waiting in a queue, and that waiting shares
the same constraint that rtdm_mutex_lock have: the caller must be RT.
Furthermore, the lock will obviously be dropped while being blocked on
the waitqueue.

If you need synchronization between RT and non-RT contexts, you should
use rtdm_lock_get_irqsave/put_irqrestore AND have little code in the
critical section. Definitely not any code that could sleep, call random
Linux functions or do even worse things. Or you need to ensure to
promote the non-RT caller to RT on entry.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

