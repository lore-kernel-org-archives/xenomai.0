MIME-Version: 1.0
In-Reply-To: <5542299B.30409@xenomai.org>
References: <CAMJ=MEceJGYZ+RQ4eW9vnvfM=iLNTUv7sN0ePij4aEbegdAM+w@mail.gmail.com>
 <5541FD72.3090806@xenomai.org>
 <CAMJ=MEcq-VE-QK021_RigRUVbbXOtKwL4G27bhtP=y+hX3eE6w@mail.gmail.com>
 <5542299B.30409@xenomai.org>
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Thu, 30 Apr 2015 15:55:23 +0200
Message-ID: <CAMJ=MEcC11C1Th6NjWMH6Ld3NthFvWpcSY+5tZAbk_akc6hS5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] [xenomai-forge] Task blocked in t_delete
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "martin.bielik.sk" <martin.bielik.sk@gmail.com>, xenomai@xenomai.org

On Thu, Apr 30, 2015 at 3:09 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 04/30/2015 02:39 PM, Ronny Meeus wrote:
>> If I run the test I see:
>>
>> /tmp # ./task_delete
>> Start of test
>> Create and start main task:Create task M:
>> Create task L:
>> Start task M:
>> Start task L:
>> M: entry
>> L: entry
>> M: Dead loop starts
>> Cleaning ..
>> End of test
>>
>> Here is the piece of the code that goes wrong:
>>
>>   printf("Cleaning ..\r\n");
>>   /* Remove tasks */
>>   t_delete(L_id);
>>   /* Followed code is not executed because t_delete is somehow blocked */
>>   printf("Removed L task id = 0x%lx\r\n", L_id);
>>   t_delete(M_id);
>>   printf("Removed M task id = 0x%lx\r\n", M_id);
>> }
>>
>> Since the trace "Removed L task id..." is not generated, my assumption
>> it that the t_delete(L_id) blocks.
>>
>>
>
> Could you attach GDB to the hung process, then dump a backtrace for all
> the remaining threads?
>
> --
> Philippe.

Philippe

I have put a breakpoint in main @ line 62:

57        printf("Create and start main task:");
58        t_create("MaIn",10, 16000, 16000,0,&tid);
59        ret = t_start(tid, 0, main_task, NULL);
60        if (0 != ret) {printf("Failed %lu\r\n",ret);return -1;}
61        sleep(10);
62        t_delete(tid);
63        printf("End of test\n\r");
64        return 0;

and I generated a backtrace for all threads, see below.
It looks like the "MaIn" task is wating on a semaphore.

(gdb) set pagination off
(gdb) info threads
  Id   Target Id         Frame
  6    Thread 16395      0xb6eb6c34 in nanosleep () from
/repo/meeusr/sw-memmngt/vobs/esam/build/reborn/buildroot-isam-reborn-arm-nrnti/output/staging/lib/libc.so.6
  5    Thread 16394      m_task () at task_delete.c:12
  4    Thread 16374      0xb6f9fcf4 in do_sigwait () from
/repo/meeusr/sw-memmngt/vobs/esam/build/reborn/buildroot-isam-reborn-arm-nrnti/output/staging/lib/libpthread.so.0
* 3    Thread 16372      0xb6f9e900 in read () from
/repo/meeusr/sw-memmngt/vobs/esam/build/reborn/buildroot-isam-reborn-arm-nrnti/output/staging/lib/libpthread.so.0
  2    Thread 16393      0xb6f9d700 in sem_wait@@GLIBC_2.4 () from
/repo/meeusr/sw-memmngt/vobs/esam/build/reborn/buildroot-isam-reborn-arm-nrnti/output/staging/lib/libpthread.so.0
  1    Thread 16325      main (argc=1, argv=0x11110, envp=0xbefffc08)
at task_delete.c:62

   0    16325    16322   20 N    0     t (main)
   0    16372    16322   20 N    0     t (task_delete)
   0    16374    16322  -95 F    0     t (timer-internal)
   0    16393    16322  -11 F    0     t (MaIn)
   0    16394    16322   -6 F    0     t (M)
   0    16395    16322   -5 F    0     t (L)

(gdb) thread apply all bt full

Thread 6 (Thread 16395):
#0  0xb6eb6c34 in nanosleep () from
/repo/meeusr/sw-memmngt/vobs/esam/build/reborn/buildroot-isam-reborn-arm-nrnti/output/staging/lib/libc.so.6
No symbol table info available.
#1  0xb6eb69cc in sleep () from
/repo/meeusr/sw-memmngt/vobs/esam/build/reborn/buildroot-isam-reborn-arm-nrnti/output/staging/lib/libc.so.6
No symbol table info available.
#2  0x00008718 in l_task () at task_delete.c:18
No locals.
#3  0xb6fd2400 in task_trampoline (arg=<optimized out>) at task.c:225
        task = 0x23218
        param_ex = {__sched_priority = -1224959724, sched_u = {rr =
{__sched_rr_quantum = {tv_sec = 0, tv_nsec = -1227485752}}}}
        svc = {cancel_type = 1}
        __FUNCTION__ = "task_trampoline"
#4  0xb6fb6a78 in thread_trampoline (arg=<optimized out>) at
internal.c:234
        cta = <optimized out>
        _cta = {stacksize = 131072, detachstate = 1, policy = 1,
param_ex = {__sched_priority = 4, sched_u = {rr = {__sched_rr_quantum
= {tv_sec = -1227287440, tv_nsec = 16}}}}, prologue = 0xb6fd2424
<task_prologue>, run = 0xb6fd22f4 <task_trampoline>, arg = 0x23218,
__reserved = {status = -38, warm = {__size =
"\000\000\000\000\000\000\000\200\000\000\000\000\266\364\265\300",
__align = 0}, released = 0xb6f4c220}}
        released = {__size =
"\000\000\000\000\000\000\000\200\000\000\000\000\000\000\000",
__align = 0}
        ret = 0
        __FUNCTION__ = "thread_trampoline"
#5  0xb6f956fc in start_thread () from
/repo/meeusr/sw-memmngt/vobs/esam/build/reborn/buildroot-isam-reborn-arm-nrnti/output/staging/lib/libpthread.so.0
No symbol table info available.
#6  0xb6ee8c08 in clone () from
/repo/meeusr/sw-memmngt/vobs/esam/build/reborn/buildroot-isam-reborn-arm-nrnti/output/staging/lib/libc.so.6
No symbol table info available.
#7  0xb6ee8c08 in clone () from
/repo/meeusr/sw-memmngt/vobs/esam/build/reborn/buildroot-isam-reborn-arm-nrnti/output/staging/lib/libc.so.6
No symbol table info available.
Backtrace stopped: previous frame identical to this frame (corrupt
stack?)

Thread 5 (Thread 16394):
#0  m_task () at task_delete.c:12
No locals.
#1  0xb6fd2400 in task_trampoline (arg=<optimized out>) at task.c:225
        task = 0x22ea0
        param_ex = {__sched_priority = -1224959724, sched_u = {rr =
{__sched_rr_quantum = {tv_sec = 0, tv_nsec = -1227354680}}}}
        svc = {cancel_type = 1}
        __FUNCTION__ = "task_trampoline"
#2  0xb6fb6a78 in thread_trampoline (arg=<optimized out>) at
internal.c:234
        cta = <optimized out>
        _cta = {stacksize = 131072, detachstate = 1, policy = 1,
param_ex = {__sched_priority = 5, sched_u = {rr = {__sched_rr_quantum
= {tv_sec = -1227287440, tv_nsec = 44}}}}, prologue = 0xb6fd2424
<task_prologue>, run = 0xb6fd22f4 <task_trampoline>, arg = 0x22ea0,
__reserved = {status = -38, warm = {__size =
"\000\000\000\000\000\000\000\200\000\000\000\000\266\364\265\300",
__align = 0}, released = 0xb6f4c220}}
        released = {__size =
"\000\000\000\000\000\000\000\200\000\000\000\000\000\000\000",
__align = 0}
        ret = 0
        __FUNCTION__ = "thread_trampoline"
#3  0xb6f956fc in start_thread () from
/repo/meeusr/sw-memmngt/vobs/esam/build/reborn/buildroot-isam-reborn-arm-nrnti/output/staging/lib/libpthread.so.0
No symbol table info available.
#4  0xb6ee8c08 in clone () from
/repo/meeusr/sw-memmngt/vobs/esam/build/reborn/buildroot-isam-reborn-arm-nrnti/output/staging/lib/libc.so.6
No symbol table info available.
#5  0xb6ee8c08 in clone () from
/repo/meeusr/sw-memmngt/vobs/esam/build/reborn/buildroot-isam-reborn-arm-nrnti/output/staging/lib/libc.so.6
No symbol table info available.
Backtrace stopped: previous frame identical to this frame (corrupt
stack?)

Thread 4 (Thread 16374):
#0  0xb6f9fcf4 in do_sigwait () from
/repo/meeusr/sw-memmngt/vobs/esam/build/reborn/buildroot-isam-reborn-arm-nrnti/output/staging/lib/libpthread.so.0
No symbol table info available.
#1  0xb6f9fd90 in sigwait () from
/repo/meeusr/sw-memmngt/vobs/esam/build/reborn/buildroot-isam-reborn-arm-nrnti/output/staging/lib/libpthread.so.0
No symbol table info available.
#2  0xb6fb9c00 in timerobj_server (arg=<optimized out>) at
timerobj.c:141
        now = {tv_sec = 199495, tv_nsec = 940506114}
        value = {tv_sec = 0, tv_nsec = -1225166640}
        interval = {tv_sec = -1227027076, tv_nsec = 0}
        tmobj = 0xb6fc9ce8
        tmp = 0xb6fc9ce8
        set = {__val = {8192, 0 <repeats 31 times>}}
        sig = 14
        sev = {sigev_value = {sival_int = 0, sival_ptr = 0x0},
sigev_signo = 14, sigev_notify = 4, _sigev_un = {_pad = {16374, 0
<repeats 12 times>}, _tid = 16374, _sigev_thread = {_function =
0x3ff6, _attribute = 0x0}}}
        periodic_timer = 0x30b47
        it = {it_interval = {tv_sec = 0, tv_nsec = 10000000}, it_value
= {tv_sec = 0, tv_nsec = 10000000}}
        ticks = 983
        __FUNCTION__ = "timerobj_server"
#3  0xb6fb6a78 in thread_trampoline (arg=<optimized out>) at
internal.c:234
        cta = <optimized out>
        _cta = {stacksize = 262144, detachstate = 1, policy = 1,
param_ex = {__sched_priority = 94, sched_u = {rr = {__sched_rr_quantum
= {tv_sec = 1, tv_nsec = 5}}}}, prologue = 0xb6fb9714
<server_prologue>, run = 0xb6fb9b3c <timerobj_server>, arg = 0x0,
__reserved = {status = -38, warm = {__size =
"\000\000\000\000\000\000\000\200\000\000\000\001\266\374\231\024",
__align = 0}, released = 0xbefffb94}}
        released = {__size =
"\000\000\000\000\000\000\000\200\000\000\000\000\000\000\000",
__align = 0}
        ret = 0
        __FUNCTION__ = "thread_trampoline"
#4  0xb6f956fc in start_thread () from
/repo/meeusr/sw-memmngt/vobs/esam/build/reborn/buildroot-isam-reborn-arm-nrnti/output/staging/lib/libpthread.so.0
No symbol table info available.
#5  0xb6ee8c08 in clone () from
/repo/meeusr/sw-memmngt/vobs/esam/build/reborn/buildroot-isam-reborn-arm-nrnti/output/staging/lib/libc.so.6
No symbol table info available.
#6  0xb6ee8c08 in clone () from
/repo/meeusr/sw-memmngt/vobs/esam/build/reborn/buildroot-isam-reborn-arm-nrnti/output/staging/lib/libc.so.6
No symbol table info available.
Backtrace stopped: previous frame identical to this frame (corrupt
stack?)

Thread 3 (Thread 16372):
#0  0xb6f9e900 in read () from
/repo/meeusr/sw-memmngt/vobs/esam/build/reborn/buildroot-isam-reborn-arm-nrnti/output/staging/lib/libpthread.so.0
No symbol table info available.
#1  0xb6f9e1bc in __pthread_enable_asynccancel () from
/repo/meeusr/sw-memmngt/vobs/esam/build/reborn/buildroot-isam-reborn-arm-nrnti/output/staging/lib/libpthread.so.0
No symbol table info available.
#2  0x00021000 in ?? ()
No symbol table info available.
#3  0x00021000 in ?? ()
No symbol table info available.
Backtrace stopped: previous frame identical to this frame (corrupt stack?)

Thread 2 (Thread 16393):
#0  0xb6f9d700 in sem_wait@@GLIBC_2.4 () from
/repo/meeusr/sw-memmngt/vobs/esam/build/reborn/buildroot-isam-reborn-arm-nrnti/output/staging/lib/libpthread.so.0
No symbol table info available.
#1  0xb6fb87f8 in cancel_sync (thobj=<optimized out>) at threadobj.c:1274
        oldstate = 0
        ret = -1227484048
        sem = 0x235c0
#2  0xb6fb88d8 in threadobj_cancel (thobj=0x232a0) at threadobj.c:1310
No locals.
#3  0xb6fd2214 in t_delete (tid=143896) at task.c:713
        task = <optimized out>
        svc = {cancel_type = 1}
        ret = <optimized out>
#4  0x00008894 in main_task () at task_delete.c:45
        M_id = 143008
        L_id = 143896
        ret = 0
#5  0xb6fd2400 in task_trampoline (arg=<optimized out>) at task.c:225
        task = 0x22b10
        param_ex = {__sched_priority = -1224959724, sched_u = {rr =
{__sched_rr_quantum = {tv_sec = 0, tv_nsec = -1227289144}}}}
        svc = {cancel_type = 1}
        __FUNCTION__ = "task_trampoline"
#6  0xb6fb6a78 in thread_trampoline (arg=<optimized out>) at internal.c:234
        cta = <optimized out>
        _cta = {stacksize = 32000, detachstate = 1, policy = 1,
param_ex = {__sched_priority = 10, sched_u = {rr = {__sched_rr_quantum
= {tv_sec = -1224757248, tv_nsec = -1224842860}}}}, prologue =
0xb6fd2424 <task_prologue>, run = 0xb6fd22f4 <task_trampoline>, arg =
0x22b10, __reserved = {status = -38, warm = {__size =
"\000\000\000\000\000\000\000\200\000\000\000\001\000\000\000",
__align = 0}, released = 0x0}}
        released = {__size =
"\000\000\000\000\000\000\000\200\000\000\000\000\000\000\000",
__align = 0}
        ret = 0
        __FUNCTION__ = "thread_trampoline"
#7  0xb6f956fc in start_thread () from
/repo/meeusr/sw-memmngt/vobs/esam/build/reborn/buildroot-isam-reborn-arm-nrnti/output/staging/lib/libpthread.so.0
No symbol table info available.
#8  0xb6ee8c08 in clone () from
/repo/meeusr/sw-memmngt/vobs/esam/build/reborn/buildroot-isam-reborn-arm-nrnti/output/staging/lib/libc.so.6
No symbol table info available.
#9  0xb6ee8c08 in clone () from
/repo/meeusr/sw-memmngt/vobs/esam/build/reborn/buildroot-isam-reborn-arm-nrnti/output/staging/lib/libc.so.6
No symbol table info available.
Backtrace stopped: previous frame identical to this frame (corrupt stack?)

Thread 1 (Thread 16325):
#0  main (argc=1, argv=0x11110, envp=0xbefffc08) at task_delete.c:62
        tid = 142096
        ret = 0
(gdb)

