Message-ID: <48CE2224.105@domain.hid>
Date: Mon, 15 Sep 2008 10:51:48 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200809141519.01180.niklaus.giger@domain.hid>
	<48CD4F89.4050601@domain.hid>
In-Reply-To: <48CD4F89.4050601@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Deviation in Xenomai-Solo from vxWorks behaviour
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Niklaus Giger wrote:
>> Hi
>>
>> The attached program works fine under vxWorks 6.6 (powerpc).
>> Running it under the current xenomai-solo (trunk) on my GNU/Debian
>> x86 system it gets stuck at line 82:
>>
>> Here is the output from vxWorks
>>> timex tSysMain
>>> assert passed at tSysMain line 66
>>> assert passed at tSysMain line 67
>>> assert passed at tSysMain line 70
>>> assert passed at tSysMain line 71
>>> assert passed at tSysMain line 74
>>> assert passed at tSysMain line 75
>>> assert passed at tSysMain line 77
>>> assert passed at tSysMain line 78
>>> assert passed at tSysMain line 79
>>> assert passed at tSysMain line 80
>>> assert passed at tSysMain line 82
>>> assert passed at tSysMain line 83
>>> tSysMain done
>>> timex: time of execution = 600 +/- 2 (0%) millisecs
>> whereas my gdb reports the following
> 
> Forget about gdb: it is known to affect the threading order. Does the wrong
> behaviour also happen when running the program without GDB?
>

Forget about my previous comment, I misread your description; GDB only affects
scheduling when ptraced tasks rely on implicit FIFO ordering like some of the
testsuite programs do, but in no case when explicit synchronization (e.g. via
sema4s) is involved, of course. I will have a look at the issue and let you know.

>>> Starting program:
>>> /home/hcu/celsius/project/metaFrame/bin/BSys/mak/xeno_vx-solo/debug/tst
>>> [Thread debugging using libthread_db enabled]
>>> [New Thread 0xb7c056c0 (LWP 32206)]
>>> [New Thread 0xb7f02b90 (LWP 32210)]
>>> [New Thread 0xb7ef1b90 (LWP 32213)]
>>> assert passed at testTask line 66
>>> assert passed at testTask line 67
>>> assert passed at testTask line 70
>>> assert passed at testTask line 71
>>> assert passed at testTask line 74
>>> assert passed at testTask line 75
>>> assert passed at testTask line 77
>>> assert passed at testTask line 78
>>> assert passed at testTask line 79
>>> assert passed at testTask line 80
>>> ^C
>>> Program received signal SIGINT, Interrupt.
>>> [Switching to Thread 0xb7c056c0 (LWP 32206)]
>>> 0xb7f05424 in __kernel_vsyscall ()
>>> (gdb) t 3
>>> [Switching to thread 3 (Thread 0xb7ef1b90 (LWP 32213))]#0  0xb7f05424 in
>>> __kernel_vsyscall () (gdb) i s
>>> #0  0xb7f05424 in __kernel_vsyscall ()
>>> #1  0xb7e9b025 in pthread_cond_wait@domain.hid () from
>>> /lib/i686/cmov/libpthread.so.0 #2  0xb7eaff2f in syncobj_pend
>>> (sobj=0x83fd0d0, timeout=0x0, syns=0xb7ef12a4) at syncobj.c:152 #3 
>>> 0xb7ebff80 in xsem_take (sem=0x83fd0c8, timeout=-1) at semLib.c:83 #4 
>>> 0xb7ec0837 in semTake (sem_id=138399944, timeout=-1) at semLib.c:404 #5 
>>> 0x08048a8d in testTask (a1=0, a2=0, a3=0, a4=0, a5=0, a6=0, a7=0, a8=0,
>>> a9=0, a10=0) at ../../BSys/src/tst_main.cpp:82 #6  0xb7ec116b in
>>> task_trampoline (arg=0x83fcee8) at taskLib.c:255 #7  0xb7e974c0 in
>>> start_thread () from /lib/i686/cmov/libpthread.so.0 #8  0xb7ceb55e in clone
>>> () from /lib/i686/cmov/libc.so.6
>> It looks like under xenomai a failing semTake(aSemaphore, nWaitTime))
>> erroneously decrements the counter instead of leaving .
>>
>> Best regards
>>
>>
>>
>> ------------------------------------------------------------------------
>>
>> _______________________________________________
>> Xenomai-core mailing list
>> Xenomai-core@domain.hid
>> https://mail.gna.org/listinfo/xenomai-core
> 
> 


-- 
Philippe.



