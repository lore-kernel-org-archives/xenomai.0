Subject: Re: Still getting Deadlocks with condition variables
References: <VI1PR05MB59177F9BC5CD74A181467003F6860@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <260342fe-450f-a30b-72c2-751961bc28dd@xenomai.org>
Date: Sun, 7 Jun 2020 22:15:51 +0200
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB59177F9BC5CD74A181467003F6860@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 6/5/20 4:36 PM, Lange Norbert wrote:
> Hello,
> 
> I brought this up once or twice at this ML [1], I am still getting some occasional lockups. Now the first time without running under an debugger,
> 
> Harwdare is a TQMxE39M (Goldmont Atom)
> Kernel: 4.19.124-cip27-xeno12-static x86_64
> I-pipe Version: 12
> Xenomai Version: 3.1
> Glibc Version 2.28
> 
> What happens (as far as I understand it):
> 
> The setup is an project with several cobalt threads (no "native" Linux thread as far as I can tell, apart maybe from the cobalt's printf thread).
> They mostly sleep, and are triggered if work is available, the project also can load DSOs (specialized maths) during configuration stage - during this stages is when the exceptions occur
> 
> 
> 1.   Linux Thread LWP 682 calls SYS_futex "wake"
> 
> Code immediately before syscall, file x86_64/lowlevellock.S:
> movl$0, (%rdi)
> LOAD_FUTEX_WAKE (%esi)
> movl$1, %edx/* Wake one thread.  */
> movl$SYS_futex, %eax
> syscall
> 
> 2. Xenomai switches a cobalt thread to secondary, potentially because all threads are in primary:
> 
> Jun 05 12:35:19 buildroot kernel: [Xenomai] switching dispatcher to secondary mode after exception #14 from user-space at 0x7fd731299115 (pid 681)
> 

This kernel message tells a different story, thread pid 681 received a #PF,
maybe due to accessing its own stack (cond.c, line 316). This may be a minor
fault though, nothing invalid. Such fault is not supposed to occur for Xenomai
threads on x86, but that would be another issue. Code-wise, I'm referring to
the current state of the master branch for lib/cobalt/cond.c, which seems to
match your description.

> Note that most threads are stuck waiting for a condvar in sc_cobalt_cond_wait_prologue (cond.c:313), LWP 681 is at the next instruction.
> 
> 3. Xenomai gets XCPU signal -> coredump
> 

More precisely, Xenomai is likely sending this signal to your application,
since it had to switch pid 681 to secondary mode for fixing up the #PF event.
You may have set PTHREAD_WARNSW with pthread_setmode_np() for that thread.

> gdb) thread apply all bt 3
> 
> Thread 9 (LWP 682):
> #0  __lll_unlock_wake () at ../sysdeps/unix/sysv/linux/x86_64/lowlevellock.S:339
> #1  0x00007fd731275d65 in __pthread_mutex_unlock_usercnt (mutex=0x7fd7312f6968 <_rtld_global+2312>, decr=1) at pthread_mutex_unlock.c:54
> #2  0x00007fd7312e0442 in ?? () from /home/lano/Downloads/bugcrash/lib64/ld-linux-x86-64.so.2
> #3  0x00007fd7312c72ac in ?? () from /lib/libdl.so.2
> #4  0x00007fd73104211f in _dl_catch_exception () from /lib/libc.so.6
> #5  0x00007fd731042190 in _dl_catch_error () from /lib/libc.so.6
> #6  0x00007fd7312c7975 in ?? () from /lib/libdl.so.2
> #7  0x00007fd7312c7327 in dlopen () from /lib/libdl.so.2
> (More stack frames follow...)
> 
> Thread 8 (LWP 686):
> #0  0x00007fd731298d48 in __cobalt_clock_nanosleep (clock_id=0, flags=0, rqtp=0x7fd727e3ad10, rmtp=0x0) at /opt/hipase2/src/xenomai-3.1.0/lib/cobalt/clock.c:312
> #1  0x00007fd731298d81 in __cobalt_nanosleep (rqtp=<optimized out>, rmtp=<optimized out>) at /opt/hipase2/src/xenomai-3.1.0/lib/cobalt/clock.c:354
> #2  0x0000000000434590 in operator() (__closure=0x7fd720006fb8) at ../../acpu.runner/asim/asim_com.cpp:685
> (More stack frames follow...)
> 
> Thread 7 (LWP 677):
> #0  0x00007fd73127b6c6 in __GI___nanosleep (requested_time=requested_time@entry=0x7fd7312b1fb0 <syncdelay>, remaining=remaining@entry=0x0) at ../sysdeps/unix/sysv/linux/nanosleep.c:28
> #1  0x00007fd73129b746 in printer_loop (arg=<optimized out>) at /opt/hipase2/src/xenomai-3.1.0/lib/cobalt/printf.c:635
> #2  0x00007fd7312720f7 in start_thread (arg=<optimized out>) at pthread_create.c:486
> (More stack frames follow...)
> 
> Thread 6 (LWP 685):
> #0  0x00007fd73129910a in __cobalt_pthread_cond_wait (cond=0x7fd72f269660, mutex=0x7fd72f269630) at /opt/hipase2/src/xenomai-3.1.0/lib/cobalt/cond.c:313
> #1  0x000000000046377c in conditionvar_wait (pData=0x7fd72f269660, pMutex=0x7fd72f269630) at ../../alib/src/alib/posix/conditionvar.c:66
> #2  0x000000000040a620 in HIPASE::Posix::CAlib_ConditionVariable::wait (this=0x7fd72f269660, lock=...) at ../../alib/include/alib/alib_conditionvar_posix.h:67
> (More stack frames follow...)
> 
> Thread 5 (LWP 684):
> #0  0x00007fd73129910a in __cobalt_pthread_cond_wait (cond=0x7fd72f267790, mutex=0x7fd72f267760) at /opt/hipase2/src/xenomai-3.1.0/lib/cobalt/cond.c:313
> #1  0x000000000046377c in conditionvar_wait (pData=0x7fd72f267790, pMutex=0x7fd72f267760) at ../../alib/src/alib/posix/conditionvar.c:66
> #2  0x000000000040a620 in HIPASE::Posix::CAlib_ConditionVariable::wait (this=0x7fd72f267790, lock=...) at ../../alib/include/alib/alib_conditionvar_posix.h:67
> (More stack frames follow...)
> 
> Thread 4 (LWP 680):
> #0  0x00007fd73129910a in __cobalt_pthread_cond_wait (cond=0xfeafa0 <(anonymous namespace)::m_MainTaskStart>, mutex=0xfeaf60 <(anonymous namespace)::m_TaskMutex>) at /opt/hipase2/src/xenomai-3.1.0/lib/cobalt/cond.c:313
> #1  0x000000000046377c in conditionvar_wait (pData=0xfeafa0 <(anonymous namespace)::m_MainTaskStart>, pMutex=0xfeaf60 <(anonymous namespace)::m_TaskMutex>) at ../../alib/src/alib/posix/conditionvar.c:66
> #2  0x000000000040a620 in HIPASE::Posix::CAlib_ConditionVariable::wait (this=0xfeafa0 <(anonymous namespace)::m_MainTaskStart>, lock=...) at ../../alib/include/alib/alib_conditionvar_posix.h:67
> (More stack frames follow...)
> 
> Thread 3 (LWP 683):
> #0  0x00007fd73129910a in __cobalt_pthread_cond_wait (cond=0x7fd72f2658c0, mutex=0x7fd72f265890) at /opt/hipase2/src/xenomai-3.1.0/lib/cobalt/cond.c:313
> #1  0x000000000046377c in conditionvar_wait (pData=0x7fd72f2658c0, pMutex=0x7fd72f265890) at ../../alib/src/alib/posix/conditionvar.c:66
> #2  0x000000000040a620 in HIPASE::Posix::CAlib_ConditionVariable::wait (this=0x7fd72f2658c0, lock=...) at ../../alib/include/alib/alib_conditionvar_posix.h:67
> (More stack frames follow...)
> 
> Thread 2 (LWP 675):
> #0  0x00007fd73129aea4 in __cobalt_pthread_mutex_lock (mutex=<optimized out>) at /opt/hipase2/src/xenomai-3.1.0/lib/cobalt/mutex.c:375
> #1  0x000000000046390a in mutex_lock (pData=0xfeaf60 <(anonymous namespace)::m_TaskMutex>) at ../../alib/src/alib/posix/mutex.c:33
> #2  0x000000000040a530 in HIPASE::Posix::CAlib_Mutex::lock (this=0xfeaf60 <(anonymous namespace)::m_TaskMutex>) at ../../alib/include/alib/alib_mutex_posix.h:67
> (More stack frames follow...)
> 
> Thread 1 (LWP 681):
> #0  __cobalt_pthread_cond_wait (cond=0xfeafe0 <(anonymous namespace)::m_DispatcherTaskStart>, mutex=0xfeaf60 <(anonymous namespace)::m_TaskMutex>) at /opt/hipase2/src/xenomai-3.1.0/lib/cobalt/cond.c:316
> #1  0x000000000046377c in conditionvar_wait (pData=0xfeafe0 <(anonymous namespace)::m_DispatcherTaskStart>, pMutex=0xfeaf60 <(anonymous namespace)::m_TaskMutex>) at ../../alib/src/alib/posix/conditionvar.c:66
> #2  0x000000000040a620 in HIPASE::Posix::CAlib_ConditionVariable::wait (this=0xfeafe0 <(anonymous namespace)::m_DispatcherTaskStart>, lock=...) at ../../alib/include/alib/alib_conditionvar_posix.h:67
> (More stack frames follow...)
> 
> 
> 
> [1] - https://xenomai.org/pipermail/xenomai/2020-January/042299.html
> 

You refer to an older post describing a lockup, but this post describes an
application crashing with a core dump. What made you draw the conclusion that
the same bug would be at work? Also, could you give some details regarding the
following:

- what do you mean by 'lockup' in this case? Can you still access the board or
is there some runaway real-time code locking out everything else when this
happens? My understanding is that this is no hard lock up otherwise the
watchdog would have triggered. If this is a softer kind of lockup instead,
what does /proc/xenomai/sched/stat tell you about the thread states after the
problem occurred?

- did you determine that using the dynamic linker is required to trigger the
bug yet? Or could you observe it without such interaction with dl?

- what is the typical size of your Xenomai thread stack? It defaults to 64k
min with Xenomai 3.1.

-- 
Philippe.

