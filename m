References: <CAHoW4hGmcH5kLzwi-B3LfMrioqdj3TQ_5S8rGP6MbRudcwEBDA@mail.gmail.com>
 <56BB9BE5.80505@xenomai.org>
 <CAHoW4hGESwFmrK5w4zTRSdqdTXSmOZcbM-SY+rU=PpWH92eDjg@mail.gmail.com>
 <56BDB759.1010008@xenomai.org>
 <CAHoW4hFb7HpkAVBEFYpzrTLeBJfouKoYruSUvJsL6OH5t-ntjg@mail.gmail.com>
 <56BDF969.2050208@xenomai.org>
 <CAHoW4hG5FNud8wR6P8jN4UH7WQbar7X_k+8K0DqO0Omw-Scz3g@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <56C342F8.6030701@xenomai.org>
Date: Tue, 16 Feb 2016 16:40:40 +0100
MIME-Version: 1.0
In-Reply-To: <CAHoW4hG5FNud8wR6P8jN4UH7WQbar7X_k+8K0DqO0Omw-Scz3g@mail.gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Process shared rt_event_wait() never signaled on ARM
 with Mercury core
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Kiorpes <ckiorpes@gmail.com>
Cc: xenomai@xenomai.org

On 02/12/2016 08:07 PM, Charles Kiorpes wrote:
> =

>     Here is the sync pattern the code normally achieves, once the parent
>     has successfully spawned a child thread, which has to wait for a
>     start signal before it may run application code:
> =

>     1. parent calls threadobj_start(child)
>             1.1 child->status |=3D __THREAD_S_STARTED
>             1.2 wait for child->status & __THREAD_S_ACTIVE
> =

>     2. child calls threadobj_wait_start(self)
>             2.1 wait for self->status & __THREAD_S_STARTED
>             2.2 raise self->status |=3D __THREAD_S_ACTIVE
> =

>     All accesses to the status bits are serialized by a per-thread
>     mutex, operated by the threadobj_lock/unlock accessors, which also
>     covers the condvar signaling/waiting as one would expect.
> =

>     When running in pshared mode, thread descriptors (holding ->status,
>     mutex and barrier sync) are obtained from /dev/shm. If
>     --disable-pshared, we are using 100% process-private memory.
> =

>     Case 1: a race when manipulating the thread status due to
>     inconsistent locking. I could not find any so far.
> =

>     Case 2: a cache coherence issue in SMP, also caused by improper
>     locking. Otherwise, the locking should enforce memory barriers as
>     expected.
> =

>     Case 3: anything not mentioned in other cases...
> =

>     - Could you paste/copy the disassembly (objdump -dl rather than
>     gdb's disass) of the wait_on_barrier() function?
> =

>  =

> I have attached the disassembly as wait_on_barrier_disas.txt
>  =

> =

>     - Does running both programs with --cpu-affinity=3D0/1 change the out=
come?
> =

>  =

> There is no change in behavior when trying any combination of cpu
> affinities, with either the "task-1" alchemy test or my event test apps.
>  =

> =

>     - Without specifying any affinity this time, could you run the
>     current test with the debug patch below applied (this is clearly not
>     a fix)? The patch forces the code to read the value of the ->status
>     field before waiting on the barrier. With that code in and a
>     backtrace showing locals, we should be able to check the status word
>     when threadobj_wait_start() is entered.
>      =

> =

>     diff --git a/lib/copperplate/threadobj.c b/lib/copperplate/threadobj.c
>     index cc64caa..ed85a12 100644
>     --- a/lib/copperplate/threadobj.c
>     +++ b/lib/copperplate/threadobj.c
>     @@ -1273,7 +1273,9 @@ void threadobj_wait_start(void) /*
>     current->lock free. */
>             int status;
> =

>             threadobj_lock(current);
>     -       status =3D wait_on_barrier(current,
>     __THREAD_S_STARTED|__THREAD_S_ABORTED);
>     +       status =3D current->status;
>     +       if (!(status & __THREAD_S_STARTED))
>     +               status =3D wait_on_barrier(current,
>     __THREAD_S_STARTED|__THREAD_S_ABORTED);
>             threadobj_unlock(current);
> =

>             /*
> =

>     --
>     Philippe.
> =

> =

> I patched in the debug and I have attached the full backtraces of
> threads 1 and 3 of the "task-1" alchemy test.
> =

> At the time of the hang:
>  - parent sees status =3D 73    (matches the flags set during
> threadobj_start())
>  - child sees status =3D 8        (locked?)
> =


Yes, this is a debugging status with --enable-debug to check for locking
consistency, also raised while holding the lock. From the traces, it
looks like the child never sees any of the status bits raised by the
parent when entering wait_on_barrier(), although its priority is
strictly lower.

At this point, we need to consider the toolchain. Which one are you
using, and specifically, is it built for supporting multi-thread
applications (such as implementing atomic operations)?

I have attached a test code basically reproducing what copperplate does
under the hood over a native kernel.

e.g.:
(term-1) ./basic-shm --create
(term-2) ./basic-shm --listen

or you can invert the logic by having the listener create the shm
segment, waiting for the signals:

(term-1) ./basic-shm --create --listen
(term-2) ./basic-shm

The code is not smart enough to detect when the listener attempts to
reuse an obsolete shared memory file from a previous run. For this
reason, the creator should always run first in a new test.

-- =

Philippe.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: basic-shm.c
Type: text/x-csrc
Size: 3294 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20160216/1e20b172/at=
tachment.c>
-------------- next part --------------

CFLAGS =3D -O2 -g
LDFLAGS =3D

all: basic-shm

%: %.c
	$(CROSS_COMPILE)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< -lpthread -lrt

clean:
	$(RM) basic-shm
