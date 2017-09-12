Date: Tue, 12 Sep 2017 13:26:32 +0000
Message-ID: <20170912132632.Horde.2n3kq1TB84KjAL7evP_5TA4@office.mrmoco.com>
From: Paul Wilkinson <paul.w@mrmoco.com>
References: <20170907153622.Horde.hT_sRaGS6VmkuifQTO4pqBa@office.mrmoco.com>
 <2ceb59af-770f-d99f-1f6a-553a669d20b5@xenomai.org>
 <20170911121830.Horde.hdU-y9sijxk8OGHoWqdylfy@office.mrmoco.com>
 <d8eca49a-1491-0e42-064e-ccbe3c188949@xenomai.org>
 <20170911161756.Horde.5576SR9hJdNX3u6KppQElrb@office.mrmoco.com>
In-Reply-To: <20170911161756.Horde.5576SR9hJdNX3u6KppQElrb@office.mrmoco.com>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Subject: Re: [Xenomai] Questions around porting app to Xenomai/Cobalt
 resulting in SIGABRT ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Quoting Paul Wilkinson <paul.w@mrmoco.com>:

> Quoting Philippe Gerum <rpm@xenomai.org>:

>>> I have installed the libstdc++ debug package now, though.
>>>
>>
>> libcobalt uses the PTHREAD_STACK_DEFAULT constant as the default stack
>> size, which is defined in include/boilerplate/libc.h. This value is
>> currently 64k. STL is prone to massive stack usage; I'm inclined to add
>> a tunable parameter for this default value.
>
>
> Thanks Philippe.
>
> A tunable parameter would be very useful.
>
> Although knowing where to change the default may save me replacing  
> std::thread with pthread*.


I changed PTHREAD_STACK_DEFAULT to ~8M and reintroduced std:thread in one case
where thread creation failed previously.

The SIGABRT failure mode returns, gdb stack trace below.

Stack frame 6 shows std:thread is using pthreads under the hood, but  
the SIGABRT
seems to imply that my increasing PTHREAD_STACK_DEFAULT hasn't had any  
effect, I
now doubt Xenomai Cobalt is wrapping the pthread calls and applying the new
PTHREAD_STACK_DEFAULT to the std::thread calls.

I'd appreciate any insight into when and when not calls such as  
pthread* will be
intercepted by Xenomai Cobalt.

Thank you.



terminate called after throwing an instance of 'std::system_error'
   what():  Operation not permitted

Program received signal SIGABRT, Aborted.
[Switching to Thread 0x7ffff49c2700 (LWP 8373)]
0x00007ffff69fc067 in __GI_raise (sig=sig@entry=6)
     at ../nptl/sysdeps/unix/sysv/linux/raise.c:56
56	../nptl/sysdeps/unix/sysv/linux/raise.c: No such file or directory.
(gdb) bt
#0  0x00007ffff69fc067 in __GI_raise (sig=sig@entry=6)
     at ../nptl/sysdeps/unix/sysv/linux/raise.c:56
#1  0x00007ffff69fd448 in __GI_abort () at abort.c:89
#2  0x00007ffff72e9b3d in __gnu_cxx::__verbose_terminate_handler ()
     at ../../../../src/libstdc++-v3/libsupc++/vterminate.cc:95
#3  0x00007ffff72e7bb6 in __cxxabiv1::__terminate (handler=<optimized out>)
     at ../../../../src/libstdc++-v3/libsupc++/eh_terminate.cc:47
#4  0x00007ffff72e7c01 in std::terminate ()
     at ../../../../src/libstdc++-v3/libsupc++/eh_terminate.cc:57
#5  0x00007ffff733fa01 in std::(anonymous  
namespace)::execute_native_thread_routine (__p=<optimized out>)
     at ../../../../../src/libstdc++-v3/src/c++11/thread.cc:92
#6  0x00007ffff77a4064 in start_thread (arg=0x7ffff49c2700)
     at pthread_create.c:309
#7  0x00007ffff6aaf62d in clone ()
     at ../sysdeps/unix/sysv/linux/x86_64/clone.S:111
(gdb)


