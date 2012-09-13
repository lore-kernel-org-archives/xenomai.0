Message-ID: <505228B1.9010009@xenomai.org>
Date: Thu, 13 Sep 2012 20:40:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5050E1F2.8090702@free.fr> <5050F04C.6030707@xenomai.org>
	<50521433.9060807@free.fr>
In-Reply-To: <50521433.9060807@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] posix skin pthread_create issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pierre Quelin <pierre.quelin@free.fr>
Cc: pierre.quelin@solystic.com, xenomai@xenomai.org

On 09/13/2012 07:13 PM, Pierre Quelin wrote:

>=20
> Le 12/09/2012 22:27, Gilles Chanteperdrix a =C3=A9crit :
>> On 09/12/2012 09:26 PM, Pierre Quelin wrote:
>>
>>> Thank you for quick answer.
>>>
>>> my context
>>>
>>> xenomai : 2.6.0 adeos : 2.11-02 kernel : 2.6.38.8 arch : pentium pro
>>> gcc : 4.6.3 distro : Ubuntu 12.04
>>
>> If you use this version, add "-fno-omit-frame-pointer" to the CFLAGS
>> passed to the configure script.
> I have tryed this with xenomai 2.6.0 and 2.6.1 without success. Maybe a=
n=20
> incompatible option in my CMakeLists file.
> ...
> ELSEIF ($ENV{SOLYSTIC_BUILD_TARGET} STREQUAL "linux-x86")
>     SET(CMAKE_C_FLAGS "-O0 -g3 -mtune=3Dpentium -march=3Dpentium -ansi =

> -fno-builtin -fno-defer-pop -Wall -finput-charset=3Diso-8859-1=20
> -fexec-charset=3Diso-8859-1")
>     SET(CMAKE_CXX_FLAGS "-O0 -g3 -mtune=3Dpentium -march=3Dpentium -ans=
i=20
> -fno-builtin -fno-defer-pop -Wall -Wreorder -finput-charset=3Diso-8859-=
1=20
> -fexec-charset=3Diso-8859-1")
> ELSEIF ($ENV{SOLYSTIC_BUILD_TARGET} STREQUAL "xenomai-x86")
>      EXECUTE_PROCESS(COMMAND xeno-config --skin posix --cflags=20
> OUTPUT_VARIABLE XENO_POSIX_CFLAGS OUTPUT_STRIP_TRAILING_WHITESPACE)
>      SET(CMAKE_C_FLAGS "${XENO_POSIX_CFLAGS} -O0 -g3 -mtune=3Dpentium=20
> -march=3Dpentium -ansi *-fno-omit-frame-pointer* -fno-builtin=20
> -fno-defer-pop -Wall -finput-charset=3Diso-8859-1 -fexec-charset=3Diso-=
8859-1")
>      SET(CMAKE_CXX_FLAGS "${XENO_POSIX_CFLAGS} -O0 -g3 -mtune=3Dpentium=
=20
> -march=3Dpentium -ansi *-fno-omit-frame-pointer* -fno-builtin=20
> -fno-defer-pop -Wall -Wreorder -finput-charset=3Diso-8859-1=20
> -fexec-charset=3Diso-8859-1")
> ...


If you have a compilation issue, you will know it, because the syscall
in __wrap_pthread_create will not return the same value as the value
printed in __pthread_create in kernel space, or the arguments received
in kernel space will not be the same as the ones you pass in user-space.
So, printf/printk is the way to go. Anyway, I am talking about the
CFLAGS of the Xenomai library, the one passed to Xenomai configure
script. Not the CFLAGS of your application. As I said, you should not
need this with Xenomai 2.6.1.

>>> After your answer, I try xenomai 2.6.1 and I increase the size of the=

>>>   private stack pool from 128 to 2048 with the same result.
>>>
>>> Is there any limits for the number of threads in Xenomai ?
>>
>> Not that I know of. There are only a few dynamic allocations in the
>> various pools you already mentioned. The corresponding options are:
>> XENO_OPT_REGISTRY_NRSLOTS (maximum number of objects in the registry,
>> each thread is registered in the registry)
>> XENO_OPT_SYS_HEAPSZ (system heap, used for various calls to xnmalloc)
>> XENO_OPT_SEM_HEAPSZ (semaphore heap, use for allocating 4 bytes per
>> thread + 4 bytes per mutex)
>>
>> But anyway, debugging the issue you have should be relatively easy by
>> adding printfs/printks, starting from src/skins/posix/thread.c (functi=
on
>> __wrap_pthread_create), continuing in ksrc/skins/posix/syscall.c,
>> function __pthread_create, etc...
> I try to obtain information about my context but all seems to be ok.


You have to put a "pause" after the failing call to pthread_create,
because otherwise if calling exit, when the process fails, all the
memory it allocated in the various pools is freed.

>>   After mlockall() in
>>> //proc/xenomai/faults/ I obtain 2 or more Page fault without visible
>>> software effects. I can't locate it. If you could help me.
>>>
>>>
>>> Our application is writting in C++. At the begining it initialise a
>>> lot of static objects as mutex and do a lot of allocation/syscall. So=

>>> it do a lot of switch in secondary mode. To solve this, at first, I
>>> just catch the SIGXCPU in a static class..
>>
>> Well, you should be able to catch the page faults with SIGXCPU, but yo=
u
>> have to ensure that pthread_set_mode and the signal handler installati=
on
>> are done before the static objects constructors. And of course, you ha=
ve
>> to ensure that Xenomai libpthread_rt library constructor gets run befo=
re
>> your static initializers. That is a problem with C++. Also note that
>> PTHREAD_MUTEX_INITIALIZER and PTHREAD_COND_INITIALIZER do not work wit=
h
>> Xenomai posix skin.
> I watch this problem for the first time when I try to resolve the=20
> pthread_create() error.
> The problem, there is a lot of SIGXCPU generated by the switch between =

> rt and linux domain that mask the page fault in a lot of noise.
> I tried to disable everything with pthread_set_mode_np(PTHREAD_WARNSW, =

> 0) in all the thread context (body) but I don't understand why, it stil=
l=20
> remains.


Not all SIGXCPU are due to page faults. There are various reasons for
SIGXCPU, for an example of how to know for which reason you receive the
signal, see examples/sigdebug.c in xenomai sources.

>=20
> I know that the application is not real time with the domain switch but=
=20
> at first how can I disable the SIGXCPU in every context to solve this=20
> page fault ?
>=20
> You say that I have to be sure that Xenomai libpthread_rt library=20
> constructor gets run before our static initializers, but how to do that=
 ?


Well, the static objects constructors order is a general C++ problem
which goes well beyond the context of Xenomai. See:
http://www.parashift.com/c++-faq-lite/static-init-order.html
The short story is: don't use static objects with constructors.

> When I switch between xenomai 2.6.0 to xenomai 2.6.1 It seems that an=20
> #include is missing in the include/xenomai/posix/stdio.h file for the=20
> new size_t type.
>=20
> #include_next <stdio.h>
>=20
> #ifndef STDIO_H
> #define STDIO_H
>=20
> #include <stdarg.h>
> *#include <unistd.h> /* size_t */*


Thanks for reporting this issue.

That is strange, given the fact that stdio.h defines fwrite for
instance, which uses size_t. Could you provide a small .c or .C file
which fails to compile?

We are certainly not going to include unistd.h, which is a POSIX header,
in stdio.h, which is an ANSI header, more like stddef.h, but AFAIK,
stddef.h should already be included in the system stdio.h


--=20
                                                                Gilles.


