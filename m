MIME-Version: 1.0
Date: Thu, 3 Jul 2014 10:11:29 +0200
Message-ID: <CAKc2Hpb0S50P=9iWvw3z9NexHmyZEjuAU=7SGyT77EPpub_D2A@mail.gmail.com>
From: Kim De Mey <kim.demey@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Xenomai-forge: Deadlock in finalize_thread()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

I've encountered a deadlock in the finalize_thread() call in threadobj.c

I can easy reproduce the problem with a simple test case where I have
a psos task which in a loop creates, starts and deletes another psos
task.
The created tasks have a priority lower or equal to the priority of
the task that creates it.

When running the test case, some of the tasks don't get deleted
properly (the majority does), they are still visible when doing "ps"
command.
When attaching gdb I notice that these tasks are stuck on
__pthread_mutex_lock() called from threadobj_lock() >
finalize_thread().

See gdb debug information below:
(gdb) info thread
  Id   Target Id         Frame
  9    Thread 18694      0x00edf280 in __pthread_mutex_lock
(mutex=<optimized out>) at pthread_mutex_lock.c:293
  8    Thread 18572      0x00edf280 in __pthread_mutex_lock
(mutex=<optimized out>) at pthread_mutex_lock.c:293
  7    Thread 18355      0x00edf280 in __pthread_mutex_lock
(mutex=<optimized out>) at pthread_mutex_lock.c:293
  6    Thread 18201      0x00edf280 in __pthread_mutex_lock
(mutex=<optimized out>) at pthread_mutex_lock.c:293
  5    Thread 18110      0x00edf280 in __pthread_mutex_lock
(mutex=<optimized out>) at pthread_mutex_lock.c:293
  4    Thread 18037      0x00edf280 in __pthread_mutex_lock
(mutex=<optimized out>) at pthread_mutex_lock.c:293
* 3    Thread 17943      0x00edf280 in __pthread_mutex_lock
(mutex=<optimized out>) at pthread_mutex_lock.c:293
  2    Thread 17734      clock_nanosleep (clock_id=<optimized out>,
flags=<optimized out>, req=<optimized out>, rem=<optimized out>)
    at ../sysdeps/unix/sysv/linux/clock_nanosleep.c:51
  1    Thread 17733      clock_nanosleep (clock_id=<optimized out>,
flags=<optimized out>, req=<optimized out>, rem=<optimized out>)
    at ../sysdeps/unix/sysv/linux/clock_nanosleep.c:51
(gdb) bt
#0  0x00edf280 in __pthread_mutex_lock (mutex=<optimized out>) at
pthread_mutex_lock.c:293
#1  0x00ec0304 in threadobj_lock () from
/repo/kdemey/buildroot-cgroups/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
#2  0x00ec0404 in finalize_thread () from
/repo/kdemey/buildroot-cgroups/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
#3  0x00edc10c in __nptl_deallocate_tsd () at pthread_create.c:154
#4  0x00edd838 in start_thread (arg=<optimized out>) at pthread_create.c:304
#5  0x00ff7f4c in __thread_start () from
output/host/usr/mips64-buildroot-linux-gnu/sysroot/lib32/libc.so.6
Backtrace stopped: frame did not save the PC

What I think that goes wrong is that the lock which is taken in
threadobj_notify_entry() is not released before threadobj_start()
continues at wait_on_barrier(thobj, __THREAD_S_ACTIVE). As there is a
t_delete() done right after t_start() returns in my test case, this
could mean that the thread gets in finalize_thread() after the
pthread_cancel() and blocks there on the threadobj_lock() as the
threadobj_unlock() from threadobj_notify_entry() was possibly not yet
called.
Does this scenario sound plausible?

As a quick test I removed the lock & unlock in the
threadobj_notify_entry() and the deadlock on __pthread_mutex_lock() no
longer occurs. So this could mean that it is indeed this lock causing
the deadlock.
However when I do this change another deadlock occurs. This time on
destroy_thread() > uninit_thread() > pthread_cond_destroy() >
__lll_lock_wait()
I think pthread_cond_destroy() blocks if there is still a thread
blocked on the condition variable. I am unsure about this though. And
also when looking I don't see what could still be blocking on it. So I
am a bit stuck here.

Here is some gdb debugging info in the case that I removed the lock in
threadobj_notify_entry():
(gdb) info thread
  Id   Target Id         Frame
  5    Thread 16596      __lll_lock_wait (futex=<optimized out>,
private=<optimized out>) at
../nptl/sysdeps/unix/sysv/linux/lowlevellock.c:46
  4    Thread 16494      __lll_lock_wait (futex=<optimized out>,
private=<optimized out>) at
../nptl/sysdeps/unix/sysv/linux/lowlevellock.c:46
* 3    Thread 15944      __lll_lock_wait (futex=<optimized out>,
private=<optimized out>) at
../nptl/sysdeps/unix/sysv/linux/lowlevellock.c:46
  2    Thread 15798      clock_nanosleep (clock_id=<optimized out>,
flags=<optimized out>, req=<optimized out>, rem=<optimized out>)
    at ../sysdeps/unix/sysv/linux/clock_nanosleep.c:51
  1    Thread 15797      clock_nanosleep (clock_id=<optimized out>,
flags=<optimized out>, req=<optimized out>, rem=<optimized out>)
    at ../sysdeps/unix/sysv/linux/clock_nanosleep.c:51
(gdb) bt
#0  __lll_lock_wait (futex=<optimized out>, private=<optimized out>)
at ../nptl/sysdeps/unix/sysv/linux/lowlevellock.c:46
#1  0x00d11298 in __pthread_cond_destroy (cond=0xcc21d0) at
pthread_cond_destroy.c:33
#2  0x00cef12c in uninit_thread () from
/repo/kdemey/buildroot-cgroups/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
#3  0x00cef494 in finalize_thread () from
/repo/kdemey/buildroot-cgroups/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
#4  0x00d0b10c in __nptl_deallocate_tsd () at pthread_create.c:154
#5  0x00d0c838 in start_thread (arg=<optimized out>) at pthread_create.c:304
#6  0x00e26f4c in __thread_start () from
output/host/usr/mips64-buildroot-linux-gnu/sysroot/lib32/libc.so.6
Backtrace stopped: frame did not save the PC

Any insight on these issues?

