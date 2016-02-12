References: <CAHoW4hGmcH5kLzwi-B3LfMrioqdj3TQ_5S8rGP6MbRudcwEBDA@mail.gmail.com>
 <56BB9BE5.80505@xenomai.org>
 <CAHoW4hGESwFmrK5w4zTRSdqdTXSmOZcbM-SY+rU=PpWH92eDjg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <56BDB759.1010008@xenomai.org>
Date: Fri, 12 Feb 2016 11:43:37 +0100
MIME-Version: 1.0
In-Reply-To: <CAHoW4hGESwFmrK5w4zTRSdqdTXSmOZcbM-SY+rU=PpWH92eDjg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Process shared rt_event_wait() never signaled on ARM
 with Mercury core
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Kiorpes <ckiorpes@gmail.com>
Cc: xenomai@xenomai.org

On 02/11/2016 01:57 PM, Charles Kiorpes wrote:
> 
> I attempted to run several tests:  'task-1', 'event-1', and 'mutex-1'. 
> Each of these hung indefinitely.  A gdb trace indicated that they were
> hanging on __libc_do_syscall() within __pthread_cond_wait() within
> threadobj_cond_wait().
> 
> I have attached the full backtrace from mutex-1 as mutex-1_bt.txt
> 

Ok, if the test suite does not pass, something is badly wrong, so we
should investigate that hang issue before anything else.

The backtrace reveals that copperplate cannot handshake with a newly
spawned task, this is the purpose of the wait_on_barrier() call over the
context of rt_task_start(). That barrier should be signaled by a call to
threadobj_notify_entry() from the internal trampoline code of the
emerging thread (task_entry() in alchemy/task.c).

- maybe task_prologue_2() (alchemy/task.c) which is called earlier hangs
indefinitely, and therefore prevents threadobj_notify_entry() from running?

- maybe the new thread does not even start for some reason, are we sure
task_entry() is reached (e.g. do we hit a breakpoint there?)

Could you inspect the current thread list under gdb when the program hangs?

Also, I would recommend to enable full debugging for now
(--enable-debug=full) to get accurate line information, assuming the
issue should still show up with a non-optimized code. Hopefully.

-- 
Philippe.

