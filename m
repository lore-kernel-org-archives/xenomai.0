MIME-Version: 1.0
In-Reply-To: <53BD0AA6.30901@xenomai.org>
References: <CAKc2Hpb0S50P=9iWvw3z9NexHmyZEjuAU=7SGyT77EPpub_D2A@mail.gmail.com>
 <53B57361.1000603@xenomai.org>
 <CAKc2HpZROnFhxVZo3PWQzAoTYZHvvRCydFqxokKS_bQT2LHYVg@mail.gmail.com>
 <53BC20E5.6090607@xenomai.org>
 <CAKc2HpbWrU7_1JG4_K9+P_3H8Vs5-xq6W7aZ4ELjVNB+ReOD0A@mail.gmail.com>
 <53BD0AA6.30901@xenomai.org>
Date: Wed, 9 Jul 2014 12:23:08 +0200
Message-ID: <CAKc2Hpaaqi69CSgJZc54kqAYNVdPyTS_D0hnXjKAKLDb41BSuw@mail.gmail.com>
From: Kim De Mey <kim.demey@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Xenomai-forge: Deadlock in finalize_thread()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

2014-07-09 11:25 GMT+02:00 Philippe Gerum <rpm@xenomai.org>:
> On 07/09/2014 10:09 AM, Kim De Mey wrote:
>
>> Newer version --dump-config output:
>> ...
>> CONFIG_XENO_COMPILER="gcc version 4.7.0 (Cavium Inc. Version:
>> SDK_3_1_0 build 27) "
>> ...
>>
>
> Thanks. I can't reproduce this issue yet, so posting the current gdb
> backtraces for all the threads still shown by "info threads" after a
> deadlock would help.
>
> TIA,
>

Below backtraces of all the threads. It is a case with two "worker"
tasks in deadlock. The "main" and "create_delete" tasks continued to
their "tm_wkafter" loop.


(gdb) thread a a bt

Thread 4 (Thread 9406):
#0  0x77cc2d94 in __pthread_mutex_lock_full (mutex=0x77b03300) at
pthread_mutex_lock.c:321
#1  0x77cc7e64 in __GI___pthread_mutex_lock (mutex=0x77b03300) at
pthread_mutex_lock.c:55
#2  0x77cf91e0 in threadobj_lock () from
/repo/kdemey/buildroot-sdk31/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
#3  0x77cf92e4 in finalize_thread () from
/repo/kdemey/buildroot-sdk31/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
#4  0x77cc5704 in __nptl_deallocate_tsd () at pthread_create.c:156
#5  0x77cc5940 in start_thread (arg=0x75dff490) at pthread_create.c:315
#6  0x77bf1bbc in __thread_start () from
output/host/usr/mips64-buildroot-linux-gnu/sysroot/lib32/libc.so.6
Backtrace stopped: frame did not save the PC

Thread 3 (Thread 31145):
#0  0x77cc2d94 in __pthread_mutex_lock_full (mutex=0x77b030b8) at
pthread_mutex_lock.c:321
#1  0x77cc7e64 in __GI___pthread_mutex_lock (mutex=0x77b030b8) at
pthread_mutex_lock.c:55
#2  0x77cf91e0 in threadobj_lock () from
/repo/kdemey/buildroot-sdk31/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
#3  0x77cf92e4 in finalize_thread () from
/repo/kdemey/buildroot-sdk31/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
#4  0x77cc5704 in __nptl_deallocate_tsd () at pthread_create.c:156
#5  0x77cc5940 in start_thread (arg=0x766ff490) at pthread_create.c:315
#6  0x77bf1bbc in __thread_start () from
output/host/usr/mips64-buildroot-linux-gnu/sysroot/lib32/libc.so.6
Backtrace stopped: frame did not save the PC

Thread 2 (Thread 6970):
#0  clock_nanosleep (clock_id=<optimized out>, flags=<optimized out>,
req=<optimized out>, rem=<optimized out>)
    at ../sysdeps/unix/sysv/linux/clock_nanosleep.c:50
#1  0x77cfa0bc in threadobj_sleep () from
/repo/kdemey/buildroot-sdk31/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
#2  0x77d2af08 in tm_wkafter () from
/repo/kdemey/buildroot-sdk31/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libpsos.so.0
#3  0x10000b64 in create_delete (a=0, b=0, c=0, d=0) at delete_child_hangs.c:31
#4  0x77d296fc in task_trampoline () from
/repo/kdemey/buildroot-sdk31/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libpsos.so.0
#5  0x77cf7d84 in thread_trampoline () from
/repo/kdemey/buildroot-sdk31/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
#6  0x77cc592c in start_thread (arg=0x77a00490) at pthread_create.c:310
#7  0x77bf1bbc in __thread_start () from
output/host/usr/mips64-buildroot-linux-gnu/sysroot/lib32/libc.so.6
Backtrace stopped: frame did not save the PC

Thread 1 (Thread 6969):
#0  clock_nanosleep (clock_id=<optimized out>, flags=<optimized out>,
req=<optimized out>, rem=<optimized out>)
    at ../sysdeps/unix/sysv/linux/clock_nanosleep.c:50
#1  0x77cfa0bc in threadobj_sleep () from
/repo/kdemey/buildroot-sdk31/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libcopperplate.so.0
#2  0x77d2af08 in tm_wkafter () from
/repo/kdemey/buildroot-sdk31/output/host/usr/mips64-buildroot-linux-gnu/sysroot/usr/lib/libpsos.so.0
#3  0x10000c00 in main (argc=1, argv=0x10011030) at delete_child_hangs.c:43

