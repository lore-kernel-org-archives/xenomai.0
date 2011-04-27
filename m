Message-ID: <4DB84B70.70109@domain.hid>
Date: Wed, 27 Apr 2011 18:59:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <21817662.201303825804906.JavaMail.SYSTEM@pc-msalvini>
In-Reply-To: <21817662.201303825804906.JavaMail.SYSTEM@pc-msalvini>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_join() call hangs in shared lib
	destructor
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mauro Salvini <mauro.salvini@domain.hid>
Cc: xenomai@xenomai.org

Mauro Salvini wrote:
> Hi, 
> 
> as from mail subject, I have an issue with rt_task_join() when called into shared object destructor.
> 
> I run xenomai 2.5.5.2 IPipe patch 2.7-4 on x86 2.6.35.7 kernel, Ubuntu Lucid 10.04.1. 
> I have a simple code attached to mail, where main program opens a shared object with dlopen(). Shared object constructor launches a joinable real-time task. Main program sleeps 5 seconds and then calls dlclose(). Shared object destructor breaks real time task cycle and joins task, but rt_join_call() hangs application indefinitely. 
> 
> Initially it seems me to be due to this libc bug: 
> https://bugzilla.redhat.com/show_bug.cgi?id=549813 
> 
> In facts my system originally has libc6 version 2.11.1 that contains this bug (attached example to bugtrace hangs on pthread_join() call). 
> So I patched libc with suggested patch (that was applied on libc6 2.12, but unfortunately I cannot install it from .deb package because it was built for Ubuntu 10.10 only). Then I rebuild deb package with debuild command and updated my libc6 library: pthread_join() issue disappears, but rt_task_join() issue stills remain. 
> 
> I tried to run same xenomai-patched kernel on an Ubuntu 10.10 system (that comes with libc6 version 2.12), same result obtained (rt_task_join() hangs). 
> 
> I run test application under gdb, this is the backtrace for each task when it hangs: 
> 
> (gdb) info thread
>   3 Thread 0xb7e34b70 (LWP 1684)  0xb7fe2424 in __kernel_vsyscall ()
>   2 Thread 0xb7e42b70 (LWP 1683)  0xb7fe2424 in __kernel_vsyscall ()
> * 1 Thread 0xb7e436d0 (LWP 1680)  0xb7fe2424 in __kernel_vsyscall ()
> 
> 
> thread 1: 
> (gdb) bt
> #0  0xb7fe2424 in __kernel_vsyscall ()
> #1  0xb7fb7b5d in pthread_join () from /lib/tls/i686/cmov/libpthread.so.0
> #2  0xb7fd7181 in rt_task_join () from /usr/xenomai/lib/libnative.so.3
> #3  0xb7e357ad in TestModExit () at TestMod.c:35
> #4  0xb7e35668 in __do_global_dtors_aux () from ./libTestMod.so
> #5  0xb7e35820 in _fini () from ./libTestMod.so
> #6  0xb7ff578e in ?? () from /lib/ld-linux.so.2
> #7  0xb7ff6247 in ?? () from /lib/ld-linux.so.2
> #8  0xb7fa8ca4 in ?? () from /lib/tls/i686/cmov/libdl.so.2
> #9  0xb7ff0836 in ?? () from /lib/ld-linux.so.2
> #10 0xb7fa909c in ?? () from /lib/tls/i686/cmov/libdl.so.2
> #11 0xb7fa8cda in dlclose () from /lib/tls/i686/cmov/libdl.so.2
> #12 0x080486b1 in main (argc=1, argv=0xbffff864) at main.c:18
> 
> 
> thread 2: 
> (gdb) bt
> #0  0xb7fe2424 in __kernel_vsyscall ()
> #1  0xb7fbe736 in nanosleep () from /lib/tls/i686/cmov/libpthread.so.0
> #2  0xb7fad92e in printer_loop () from /usr/xenomai/lib/librtdk.so.0
> #3  0xb7fb696e in start_thread () from /lib/tls/i686/cmov/libpthread.so.0
> #4  0xb7f1ba4e in clone () from /lib/tls/i686/cmov/libc.so.6
> 
> 
> thread 3: 
> (gdb) bt
> #0  0xb7fe2424 in __kernel_vsyscall ()
> #1  0xb7fbdaf9 in __lll_lock_wait () from /lib/tls/i686/cmov/libpthread.so.0
> #2  0xb7fb9149 in _L_lock_839 () from /lib/tls/i686/cmov/libpthread.so.0
> #3  0xb7fb8fdb in pthread_mutex_lock () from /lib/tls/i686/cmov/libpthread.so.0
> #4  0xb7ff45cd in ?? () from /lib/ld-linux.so.2
> #5  0xb7f524a2 in ?? () from /lib/tls/i686/cmov/libc.so.6
> #6  0xb7ff0836 in ?? () from /lib/ld-linux.so.2
> #7  0xb7f525a1 in ?? () from /lib/tls/i686/cmov/libc.so.6
> #8  0xb7f526bb in __libc_dlopen_mode () from /lib/tls/i686/cmov/libc.so.6
> #9  0xb7fbfb47 in pthread_cancel_init () from /lib/tls/i686/cmov/libpthread.so.0
> #10 0xb7fbfcbd in _Unwind_ForcedUnwind () from /lib/tls/i686/cmov/libpthread.so.0
> #11 0xb7fbd788 in __pthread_unwind () from /lib/tls/i686/cmov/libpthread.so.0
> #12 0xb7fb79e0 in pthread_exit () from /lib/tls/i686/cmov/libpthread.so.0
> #13 0xb7fd8665 in rt_task_trampoline () from /usr/xenomai/lib/libnative.so.3
> #14 0xb7fb696e in start_thread () from /lib/tls/i686/cmov/libpthread.so.0
> #15 0xb7f1ba4e in clone () from /lib/tls/i686/cmov/libc.so.6
> 
> 
> It seems to be another issue into libc6. Or my Xenomai system could be corrupted/misconfigured elsewhere?

It looks like a typical pthread_join deadlock. The thread you are
joining is locked on a pthread mutex, that some other thread (I would
say, the one calling pthread_join) has. It can not work. You should not
call pthread_join while holding a mutex.

If this is not the issue, would you please take the time to post a
self-contained test case which I can run to reproduce the issue?

Thanks.


-- 
                                                                Gilles.

