References: <bd6a8257-9986-df8b-182d-b1b5d41e3a2a@xenomai.org>
 <41222b4c-b99c-2745-f1df-f00785c52104@xenomai.org>
 <d8f7d33e-a6fc-2911-56d8-f985981b1698@xenomai.org>
 <5B1EDD8E.2010707@freyder.net>
 <6d63abf1-0b15-5c55-5ab5-f0f424848dd3@xenomai.org>
 <5B201BCD.1060600@freyder.net>
 <f529188c-4a06-000c-985a-e46a30a919c1@xenomai.org>
From: Steve Freyder <steve@freyder.net>
Message-ID: <5B21A065.3020707@freyder.net>
Date: Wed, 13 Jun 2018 17:53:25 -0500
MIME-Version: 1.0
In-Reply-To: <f529188c-4a06-000c-985a-e46a30a919c1@xenomai.org>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Performance issue with memory allocators
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 6/13/2018 2:06 AM, Philippe Gerum wrote:
> On 06/12/2018 09:15 PM, Steve Freyder wrote:
>> On 6/12/2018 1:39 AM, Philippe Gerum wrote:
>>> On 06/11/2018 10:37 PM, Steve Freyder wrote:
>>>> On 6/8/2018 7:48 AM, Philippe Gerum wrote:
>>>>> On 05/20/2018 08:15 PM, Philippe Gerum wrote:
>>>>>> On 04/27/2018 08:23 PM, Philippe Gerum wrote:
>>>>>>> After a comprehensive series of tests, it is now obvious that
>>>>>>> heapobj-pshared has gruesome performances when releasing bursts of
>>>>>>> small-sized objects. Allocation of large objects is not particularly
>>>>>>> efficient either, although not as bad. The Cobalt core allocator is
>>>>>>> affected by the same bug too.
>>>>>>>
>>>>>>> Those new tests are available from the wip/heapmem branch, they are
>>>>>>> based on the smokey framework (e.g. smokey --run=3Dmemory_*
>>>>>>> --verbose=3D2).
>>>>>>>
>>>>>>> Work is ongoing into the wip/heapmem branch to fix the mess, first
>>>>>>> addressing the issue with the core (in-kernel) allocator,
>>>>>>> heapobj-pshared next. Please note that wip/heapmem is a development
>>>>>>> branch I'm working on for testing improvements - hopefully - to the
>>>>>>> memory allocators, which should not be used in production.
>>>>>>>
>>>>>>> I would strongly recommend that users running single-process
>>>>>>> applications - i.e. not needing the shared heap feature - make
>>>>>>> sure to
>>>>>>> turn off heapobj-pshared when configuring, by passing
>>>>>>> --disable-pshared
>>>>>>> to the configuration script (or leave the feature to the default
>>>>>>> off state).
>>>>>>>
>>>>>>> As the benchmark figures show when running 'memory_pshared', the
>>>>>>> shared
>>>>>> memory allocator still needs to be fixed. This is next on my list.
>>>>> The pshared allocator is now fixed in the next branch.
>>>>>
>>>> I tried to build with the -next branch, I'm not sure if I'm doing
>>>> something wrong, but I'm getting the errors below.  I thought perhaps
>>>> the "struct shared_heap" should have been "struct shared_heap_memory",
>>>> so I made that change, and that resulted in the second set of errors
>>>> shown below that, then I decided time to post to the group:
>>>>
>>>> Thanks,
>>>> Steve
>>>>
>>>> ----------------------------------------------------------------------=
--
>>>>
>>>> make[3]: Entering directory
>>>> '/home/sdf/xenobuild/imx-xenomai/build/xenomai-3/lib/copperplate/regd'
>>>>     CC       regd.o
>>>>     CC       fs-common.o
>>>> In file included from
>>>> ../../../../../xenomai-3/include/cobalt/wrappers.h:21:0,
>>>>                    from
>>>> /home/sdf/xenobuild/imx-xenomai/xenomai-3/include/cobalt/time.h:26,
>>>>                    from
>>>> /opt/emac/5.1/sysroots/armv7a-neon-emac-linux-gnueabi/usr/include/sys/=
types.h:132,
>>>>
>>>>                    from
>>>> ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c:19:
>>>> ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c: In function
>>>> =E2?~open_heaps=E2?T:
>>>> ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c:247:10: erro=
r:
>>>> dereferencing pointer to incomplete type =E2?~struct shared_heap=E2?T
>>>>      heap =3D container_of(obj, struct shared_heap, memspec);
>>>>             ^
>>>> ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c:247:10: erro=
r:
>>>> initialization from incompatible pointer type
>>>> [-Werror=3Dincompatible-pointer-types]
>>>>      heap =3D container_of(obj, struct shared_heap, memspec);
>>>>             ^
>>>> In file included from
>>>> /opt/emac/5.1/sysroots/armv7a-neon-emac-linux-gnueabi/usr/include/stri=
ng.h:32:0,
>>>>
>>>>                    from
>>>> ../../../../../xenomai-3/include/copperplate/heapobj.h:24,
>>>>                    from
>>>> ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c:27:
>>>> ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c:247:35: erro=
r:
>>>> invalid use of undefined type =E2?~struct shared_heap=E2?T
>>>>      heap =3D container_of(obj, struct shared_heap, memspec);
>>>>                                      ^
>>>> ----------------------------------------------------------------------=
--
>>>> This is with "struct shared_heap" changed to "struct
>>>> shared_heap_memory":
>>>>
>>>> make[3]: Entering directory
>>>> '/home/sdf/xenobuild/imx-xenomai/build/xenomai-3/lib/copperplate/regd'
>>>>     CC       regd.o
>>>>     CC       fs-common.o
>>>> ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c: In function
>>>> =E2open_heaps=E2:
>>>> ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c:249:17: erro=
r:
>>>> =E2struct shared_heap_memory=E2 has no member named =E2ubytes=E2
>>>>      p->used =3D heap->ubytes;
>>>>                    ^
>>>> ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c:250:18: erro=
r:
>>>> =E2struct shared_heap_memory=E2 has no member named =E2total=E2
>>>>      p->total =3D heap->total;
>>>>                     ^
>>>> Makefile:472: recipe for target 'fs-common.o' failed
>>>> make[3]: *** [fs-common.o] Error 1
>>>>
>>> This may help:
>>>
>>> diff --git a/lib/copperplate/regd/fs-common.c
>>> b/lib/copperplate/regd/fs-common.c
>>> index ef2e6dae9..e0bdd3d04 100644
>>> --- a/lib/copperplate/regd/fs-common.c
>>> +++ b/lib/copperplate/regd/fs-common.c
>>> @@ -211,8 +211,8 @@ int open_heaps(struct fsobj *fsobj, void *priv)
>>>    {
>>>        struct sysgroup_memspec *obj, *tmp;
>>>        struct heap_data *heap_data, *p;
>>> +    struct shared_heap_memory *heap;
>>>        struct fsobstack *o =3D priv;
>>> -    struct shared_heap *heap;
>>>        int ret, count, len =3D 0;
>>>          ret =3D
>>> heapobj_bind_session(__copperplate_setup_data.session_label);
>>> @@ -244,10 +244,10 @@ int open_heaps(struct fsobj *fsobj, void *priv)
>>>        for_each_sysgroup(obj, tmp, heap) {
>>>            if (p - heap_data >=3D count)
>>>                break;
>>> -        heap =3D container_of(obj, struct shared_heap, memspec);
>>> +        heap =3D container_of(obj, struct shared_heap_memory, memspec);
>>>            namecpy(p->name, heap->name);
>>> -        p->used =3D heap->ubytes;
>>> -        p->total =3D heap->total;
>>> +        p->used =3D heap->used_size;
>>> +        p->total =3D heap->usable_size;
>>>            p++;
>>>        }
>>>
>> Philippe,
>>
>> Thanks for that update, I see that it made it into the -next branch.
>> The build went fine
>> and I updated my SDK as well with the new heapobj headers, etc.  But now
>> it appears as though
>> g++ is unhappy with casting between void* and heapobj*, heap_memory*,
>> etc that I'm guessing has
>> to do with alchemy headers ref'ing the heap pointers using void *. I'm
>> ignoring this for now, focusing on the apps which are in C, which is 95%
>> of what I have, and will look at using
>> -fpermissive or #pragma's to fix the C++ issues later.
>>
> I fixed this in the repo, only tested with a trivial C++ app pulling in
> the headers though. Please let me know if that works for you too.
>
>> This is my first attempt with pshared since the new allocator went in.
>> I've always launched
>> sysregd during system startup, like this:
>>
>> sysregd --daemon --root /var/run/xenomai/root/opus --linger
>>
>> Here's a traceback which happens with our rt_queue reader app, it only
>> happens when the
>> session already exists, not when it's the first process (except sysregd)
>> in the session:
>>
>> ./mqueue-reader
>> 2165 Segmentation fault      (core dumped) ./mqueue-reader "$@"
>>
>> gdb session with core file:
>>
>> Core was generated by `./mqueue-readerE --mem-pool-size=3D32M
>> --session=3Dopus'.
>> Program terminated with signal SIGSEGV, Segmentation fault.
>> #0  0x76ee8704 in ?? ()
>> [Current thread is 1 (LWP 2104)]
>> (gdb) bt
>> #0  0x76ee8704 in ?? ()
>> #1  0x76fc38c0 in shavl_search_inner (delta=3D0x7ec7b9f0, n=3D0x7ec7ba04,
>> avl=3D0x7445c8f4) at
>> ../../../../xenomai-3/include/boilerplate/avl-inner.h:285
>> #2  shavl_search_nearest (dir=3D1, node=3D0x7ec7ba04, avl=3D0x7445c8f4) =
at
>> ../../../../xenomai-3/include/boilerplate/avl-inner.h:393
>> #3  shavl_search_ge (node=3D0x7ec7ba04, avl=3D0x7445c8f4) at
>> ../../../../xenomai-3/include/boilerplate/avl-inner.h:411
>> #4  find_suitable_range (size=3D1536, ext=3D0x7445c8b8) at
>> ../../../../xenomai-3/lib/copperplate/heapobj-pshared.c:204
>> #5  reserve_page_range (size=3D1536, ext=3D0x7445c8b8) at
>> ../../../../xenomai-3/lib/copperplate/heapobj-pshared.c:215
>> #6  add_free_range (heap=3D0x2, heap@entry=3D0x7445c000, bsize=3D2127018=
500,
>> bsize@entry=3D1536, log2size=3D1950728192, log2size@entry=3D0)
>>      at ../../../../xenomai-3/lib/copperplate/heapobj-pshared.c:422
>> #7  0x76fc3b9c in sheapmem_alloc (heap=3D0x7445c000, size=3Dsize@entry=
=3D1272)
>> at ../../../../xenomai-3/lib/copperplate/heapobj-pshared.c:543
>>
> Going from heap=3D0x7445c000 with size=3D1272 to heap=3D0x2 with
> size=3D2127018500 looks weird, and won't work obviously. Any chance a
> stack overflow would be at work here?
>
>> The mqueue-reader app is larger than it should be so if this traceback
>> isn't enough to lead
>> you to a solution and you need some test code I will trim it down to
>> something much smaller that
>> still shows the issue and send that along.
>>
> You may want to run the new stress test exercising all of the memory
> allocators, specifically for the heapmem-pshared:
>
> $ smokey --run=3Dmemory_pshared --verbose=3D2
>
> If that one runs properly on your setup, I would suspect an issue local
> to the app (e.g. such as a stack overflow).
>
Philippe,

First, thanks for the update on the g++ header issue, my compiles are=20
all clean now.

I rebuilt my program with a 512K stack, same problem with the SEGV.

Tried something different, without running my application at all, I ran=20
this script:

ulimit -c unlimited
smokey --run=3Dmemory_pshared --verbose=3D2 --mem-pool-size=3D32M --session=
=3Dfoo

it ran fine, but if I ran it a second time, without waiting for the=20
first invocation to
finish, then I got the same SEGV that I previously was seeing with my=20
program and the
traceback looks the same.

It's as if there's an initialization issue when you're not the creator=20
of the
pshared heap.


