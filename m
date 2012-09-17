Message-ID: <50577F11.7050901@xenomai.org>
Date: Mon, 17 Sep 2012 21:50:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5050E1F2.8090702@free.fr> <5050F04C.6030707@xenomai.org>
	<50521433.9060807@free.fr> <505228B1.9010009@xenomai.org>
	<50577AB4.6050006@free.fr>
In-Reply-To: <50577AB4.6050006@free.fr>
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

On 09/17/2012 09:32 PM, Pierre Quelin wrote:

>>>>> After your answer, I try xenomai 2.6.1 and I increase the size of t=
he
>>>>>    private stack pool from 128 to 2048 with the same result.
>>>>>
>>>>> Is there any limits for the number of threads in Xenomai ?
>>>> Not that I know of. There are only a few dynamic allocations in the
>>>> various pools you already mentioned. The corresponding options are:
>>>> XENO_OPT_REGISTRY_NRSLOTS (maximum number of objects in the registry=
,
>>>> each thread is registered in the registry)
>>>> XENO_OPT_SYS_HEAPSZ (system heap, used for various calls to xnmalloc=
)
>>>> XENO_OPT_SEM_HEAPSZ (semaphore heap, use for allocating 4 bytes per
>>>> thread + 4 bytes per mutex)
>>>>
>>>> But anyway, debugging the issue you have should be relatively easy b=
y
>>>> adding printfs/printks, starting from src/skins/posix/thread.c (func=
tion
>>>> __wrap_pthread_create), continuing in ksrc/skins/posix/syscall.c,
>>>> function __pthread_create, etc...
>>> I try to obtain information about my context but all seems to be ok.
>>
>> You have to put a "pause" after the failing call to pthread_create,
>> because otherwise if calling exit, when the process fails, all the
>> memory it allocated in the various pools is freed.
> I found the problem. It seems that the private sem heap is to small.
>=20
> I'm not sure about which parameter to increase in kernel menu so at=20
> first I increase :


"private sem heap" -> "private semaphores heap", how can this not be clea=
r?

> generation@emb:~$ cat /proc/xenomai/heap

> TOTAL USED PAGESZ NAME
> 118784 64 4096 global sem heap
> 2600960 287120 512 main heap
> 129536 0 512 stack pool
> *118784 13424 4096 private sem heap [5633]*
>=20
> and now it works fine.
> But just to understand, could you explain to me how I can retrive the=20
> value 118784 with the kernel parameters ?


see include/nucleus/heap.h

> ? Is calling pthread_set_mode_np (PTHREAD_WARNSW, 0) inhibits the rise =

> of the signal for a page fault?


Yes, it inhibits the rise of the signal for any cause of switch to
secondary mode. Quoting the documentation:

"PTHREAD_WARNSW, when set, cause the signal SIGXCPU to be sent to the
current thread, whenever it involontary switches to secondary mode;"

so, obviously, when clear, the SIGXCPU is NOT SENT to the current thread
whenever it involontary switches to secondary mode. What else did you
understand when reading this documentation ?

>>> When I switch between xenomai 2.6.0 to xenomai 2.6.1 It seems that an=

>>> #include is missing in the include/xenomai/posix/stdio.h file for the=

>>> new size_t type.
>>>
>>> #include_next <stdio.h>
>>>
>>> #ifndef STDIO_H
>>> #define STDIO_H
>>>
>>> #include <stdarg.h>
>>> *#include <unistd.h> /* size_t */*
>>
>> Thanks for reporting this issue.
>>
>> That is strange, given the fact that stdio.h defines fwrite for
>> instance, which uses size_t. Could you provide a small .c or .C file
>> which fails to compile?
>>
>> We are certainly not going to include unistd.h, which is a POSIX heade=
r,
>> in stdio.h, which is an ANSI header, more like stddef.h, but AFAIK,
>> stddef.h should already be included in the system stdio.h
>>
>>
> cf. pme.h / pme.cpp
>=20
> In file included from /usr/include/wchar.h:37:0,
>                   from /usr/include/c++/4.6/cwchar:46,
>                   from /usr/include/c++/4.6/bits/postypes.h:42,
>                   from /usr/include/c++/4.6/bits/char_traits.h:42,
>                   from /usr/include/c++/4.6/string:42,
>                   from=20
> /home/generation/workspace/Projects/Application.xenomai/Libraries/libpm=
e/pme/pme.h:16,
>                   from=20
> /home/generation/workspace/Projects/Application.xenomai/Libraries/libpm=
e/pme/pme.cpp:14:
> /usr/include/xenomai/posix/stdio.h:30:1: erreur: =E2=80=98size_t=E2=80=99=
 does not name=20
> a type


weird localization, it is an "erreur", but the rest of the error
messages are in english. Ok, will check. Thanks for posting the test case=
s.

--=20
                                                                Gilles.


