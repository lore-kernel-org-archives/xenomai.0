References: <CAHoW4hGmcH5kLzwi-B3LfMrioqdj3TQ_5S8rGP6MbRudcwEBDA@mail.gmail.com>
 <56BB9BE5.80505@xenomai.org>
 <CAHoW4hGESwFmrK5w4zTRSdqdTXSmOZcbM-SY+rU=PpWH92eDjg@mail.gmail.com>
 <56BDB759.1010008@xenomai.org>
 <CAHoW4hFb7HpkAVBEFYpzrTLeBJfouKoYruSUvJsL6OH5t-ntjg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <56BDF969.2050208@xenomai.org>
Date: Fri, 12 Feb 2016 16:25:29 +0100
MIME-Version: 1.0
In-Reply-To: <CAHoW4hFb7HpkAVBEFYpzrTLeBJfouKoYruSUvJsL6OH5t-ntjg@mail.gmail.com>
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

On 02/12/2016 03:08 PM, Charles Kiorpes wrote:
> 
> 
> On Fri, Feb 12, 2016 at 5:43 AM, Philippe Gerum <rpm@xenomai.org
> <mailto:rpm@xenomai.org>> wrote:
> 
>     On 02/11/2016 01:57 PM, Charles Kiorpes wrote:
>     >
>     > I attempted to run several tests:  'task-1', 'event-1', and 'mutex-1'.
>     > Each of these hung indefinitely.  A gdb trace indicated that they were
>     > hanging on __libc_do_syscall() within __pthread_cond_wait() within
>     > threadobj_cond_wait().
>     >
>     > I have attached the full backtrace from mutex-1 as mutex-1_bt.txt
>     >
> 
>     Ok, if the test suite does not pass, something is badly wrong, so we
>     should investigate that hang issue before anything else.
> 
>     The backtrace reveals that copperplate cannot handshake with a newly
>     spawned task, this is the purpose of the wait_on_barrier() call over the
>     context of rt_task_start(). That barrier should be signaled by a call to
>     threadobj_notify_entry() from the internal trampoline code of the
>     emerging thread (task_entry() in alchemy/task.c).
> 
>     - maybe task_prologue_2() (alchemy/task.c) which is called earlier hangs
>     indefinitely, and therefore prevents threadobj_notify_entry() from
>     running?
> 
>     - maybe the new thread does not even start for some reason, are we sure
>     task_entry() is reached (e.g. do we hit a breakpoint there?)
> 
>     Could you inspect the current thread list under gdb when the program
>     hangs?
> 
>     Also, I would recommend to enable full debugging for now
>     (--enable-debug=full) to get accurate line information, assuming the
>     issue should still show up with a non-optimized code. Hopefully.
> 
>     --
>     Philippe.
> 
> 
> I ran the task-1 test under gdb with this Xenomai configuration:
> --with-core=mercury \
> --enable-debug=full \
> --enable-registry \
> --enable-smp \
> --enable-pshared \
> --enable-condvar-workaround
> 
> It appears that the new thread is being launched, and getting stuck in
> threadobj_wait_start() within task_prologue_2(), as you indicated might
> be the case.
> I have attached the thread list and a full backtrace for each thread (in
> separate files by thread id).
> 
> As per your other message, my kernel configs all include CONFIG_FUTEX.
> 
> I have tried glibc 2.19 and 2.21, as well as RT patched and vanilla kernels.
> 
> Interestingly, when I removed --enable-pshared from my configuration,
> the task-1 test passed.
> 

Here is the sync pattern the code normally achieves, once the parent has successfully spawned a child thread, which has to wait for a start signal before it may run application code:

1. parent calls threadobj_start(child)
	1.1 child->status |= __THREAD_S_STARTED
	1.2 wait for child->status & __THREAD_S_ACTIVE

2. child calls threadobj_wait_start(self)
	2.1 wait for self->status & __THREAD_S_STARTED
	2.2 raise self->status |= __THREAD_S_ACTIVE

All accesses to the status bits are serialized by a per-thread mutex, operated by the threadobj_lock/unlock accessors, which also covers the condvar signaling/waiting as one would expect.

When running in pshared mode, thread descriptors (holding ->status, mutex and barrier sync) are obtained from /dev/shm. If --disable-pshared, we are using 100% process-private memory.

Case 1: a race when manipulating the thread status due to inconsistent locking. I could not find any so far.

Case 2: a cache coherence issue in SMP, also caused by improper locking. Otherwise, the locking should enforce memory barriers as expected.

Case 3: anything not mentioned in other cases...

- Could you paste/copy the disassembly (objdump -dl rather than gdb's disass) of the wait_on_barrier() function?

- Does running both programs with --cpu-affinity=0/1 change the outcome?

- Without specifying any affinity this time, could you run the current test with the debug patch below applied (this is clearly not a fix)? The patch forces the code to read the value of the ->status field before waiting on the barrier. With that code in and a backtrace showing locals, we should be able to check the status word when threadobj_wait_start() is entered.

diff --git a/lib/copperplate/threadobj.c b/lib/copperplate/threadobj.c
index cc64caa..ed85a12 100644
--- a/lib/copperplate/threadobj.c
+++ b/lib/copperplate/threadobj.c
@@ -1273,7 +1273,9 @@ void threadobj_wait_start(void) /* current->lock free. */
 	int status;
 
 	threadobj_lock(current);
-	status = wait_on_barrier(current, __THREAD_S_STARTED|__THREAD_S_ABORTED);
+	status = current->status;
+	if (!(status & __THREAD_S_STARTED))
+		status = wait_on_barrier(current, __THREAD_S_STARTED|__THREAD_S_ABORTED);
 	threadobj_unlock(current);
 
 	/*

-- 
Philippe.

