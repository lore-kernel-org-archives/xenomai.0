References: <bd6a8257-9986-df8b-182d-b1b5d41e3a2a@xenomai.org>
 <41222b4c-b99c-2745-f1df-f00785c52104@xenomai.org>
 <d8f7d33e-a6fc-2911-56d8-f985981b1698@xenomai.org>
 <5B1EDD8E.2010707@freyder.net>
 <6d63abf1-0b15-5c55-5ab5-f0f424848dd3@xenomai.org>
 <5B201BCD.1060600@freyder.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <f529188c-4a06-000c-985a-e46a30a919c1@xenomai.org>
Date: Wed, 13 Jun 2018 09:06:27 +0200
MIME-Version: 1.0
In-Reply-To: <5B201BCD.1060600@freyder.net>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
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
To: Steve Freyder <steve@freyder.net>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 06/12/2018 09:15 PM, Steve Freyder wrote:
> On 6/12/2018 1:39 AM, Philippe Gerum wrote:
>> On 06/11/2018 10:37 PM, Steve Freyder wrote:
>>> On 6/8/2018 7:48 AM, Philippe Gerum wrote:
>>>> On 05/20/2018 08:15 PM, Philippe Gerum wrote:
>>>>> On 04/27/2018 08:23 PM, Philippe Gerum wrote:
>>>>>> After a comprehensive series of tests, it is now obvious that
>>>>>> heapobj-pshared has gruesome performances when releasing bursts of
>>>>>> small-sized objects. Allocation of large objects is not particularly
>>>>>> efficient either, although not as bad. The Cobalt core allocator is
>>>>>> affected by the same bug too.
>>>>>>
>>>>>> Those new tests are available from the wip/heapmem branch, they are
>>>>>> based on the smokey framework (e.g. smokey --run=3Dmemory_*
>>>>>> --verbose=3D2).
>>>>>>
>>>>>> Work is ongoing into the wip/heapmem branch to fix the mess, first
>>>>>> addressing the issue with the core (in-kernel) allocator,
>>>>>> heapobj-pshared next. Please note that wip/heapmem is a development
>>>>>> branch I'm working on for testing improvements - hopefully - to the
>>>>>> memory allocators, which should not be used in production.
>>>>>>
>>>>>> I would strongly recommend that users running single-process
>>>>>> applications - i.e. not needing the shared heap feature - make
>>>>>> sure to
>>>>>> turn off heapobj-pshared when configuring, by passing
>>>>>> --disable-pshared
>>>>>> to the configuration script (or leave the feature to the default
>>>>>> off state).
>>>>>>
>>>>>> As the benchmark figures show when running 'memory_pshared', the
>>>>>> shared
>>>>> memory allocator still needs to be fixed. This is next on my list.
>>>> The pshared allocator is now fixed in the next branch.
>>>>
>>> I tried to build with the -next branch, I'm not sure if I'm doing
>>> something wrong, but I'm getting the errors below.=A0 I thought perhaps
>>> the "struct shared_heap" should have been "struct shared_heap_memory",
>>> so I made that change, and that resulted in the second set of errors
>>> shown below that, then I decided time to post to the group:
>>>
>>> Thanks,
>>> Steve
>>>
>>> ------------------------------------------------------------------------
>>>
>>> make[3]: Entering directory
>>> '/home/sdf/xenobuild/imx-xenomai/build/xenomai-3/lib/copperplate/regd'
>>> =A0=A0 CC=A0=A0=A0=A0=A0=A0 regd.o
>>> =A0=A0 CC=A0=A0=A0=A0=A0=A0 fs-common.o
>>> In file included from
>>> ../../../../../xenomai-3/include/cobalt/wrappers.h:21:0,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from
>>> /home/sdf/xenobuild/imx-xenomai/xenomai-3/include/cobalt/time.h:26,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from
>>> /opt/emac/5.1/sysroots/armv7a-neon-emac-linux-gnueabi/usr/include/sys/t=
ypes.h:132,
>>>
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from
>>> ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c:19:
>>> ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c: In function
>>> =E2?~open_heaps=E2?T:
>>> ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c:247:10: error:
>>> dereferencing pointer to incomplete type =E2?~struct shared_heap=E2?T
>>> =A0=A0=A0 heap =3D container_of(obj, struct shared_heap, memspec);
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ^
>>> ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c:247:10: error:
>>> initialization from incompatible pointer type
>>> [-Werror=3Dincompatible-pointer-types]
>>> =A0=A0=A0 heap =3D container_of(obj, struct shared_heap, memspec);
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ^
>>> In file included from
>>> /opt/emac/5.1/sysroots/armv7a-neon-emac-linux-gnueabi/usr/include/strin=
g.h:32:0,
>>>
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from
>>> ../../../../../xenomai-3/include/copperplate/heapobj.h:24,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from
>>> ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c:27:
>>> ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c:247:35: error:
>>> invalid use of undefined type =E2?~struct shared_heap=E2?T
>>> =A0=A0=A0 heap =3D container_of(obj, struct shared_heap, memspec);
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ^
>>> ------------------------------------------------------------------------
>>> This is with "struct shared_heap" changed to "struct
>>> shared_heap_memory":
>>>
>>> make[3]: Entering directory
>>> '/home/sdf/xenobuild/imx-xenomai/build/xenomai-3/lib/copperplate/regd'
>>> =A0=A0 CC=A0=A0=A0=A0=A0=A0 regd.o
>>> =A0=A0 CC=A0=A0=A0=A0=A0=A0 fs-common.o
>>> ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c: In function
>>> =E2open_heaps=E2:
>>> ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c:249:17: error:
>>> =E2struct shared_heap_memory=E2 has no member named =E2ubytes=E2
>>> =A0=A0=A0 p->used =3D heap->ubytes;
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ^
>>> ../../../../../xenomai-3/lib/copperplate/regd/fs-common.c:250:18: error:
>>> =E2struct shared_heap_memory=E2 has no member named =E2total=E2
>>> =A0=A0=A0 p->total =3D heap->total;
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ^
>>> Makefile:472: recipe for target 'fs-common.o' failed
>>> make[3]: *** [fs-common.o] Error 1
>>>
>> This may help:
>>
>> diff --git a/lib/copperplate/regd/fs-common.c
>> b/lib/copperplate/regd/fs-common.c
>> index ef2e6dae9..e0bdd3d04 100644
>> --- a/lib/copperplate/regd/fs-common.c
>> +++ b/lib/copperplate/regd/fs-common.c
>> @@ -211,8 +211,8 @@ int open_heaps(struct fsobj *fsobj, void *priv)
>> =A0 {
>> =A0=A0=A0=A0=A0 struct sysgroup_memspec *obj, *tmp;
>> =A0=A0=A0=A0=A0 struct heap_data *heap_data, *p;
>> +=A0=A0=A0 struct shared_heap_memory *heap;
>> =A0=A0=A0=A0=A0 struct fsobstack *o =3D priv;
>> -=A0=A0=A0 struct shared_heap *heap;
>> =A0=A0=A0=A0=A0 int ret, count, len =3D 0;
>> =A0 =A0=A0=A0=A0=A0 ret =3D
>> heapobj_bind_session(__copperplate_setup_data.session_label);
>> @@ -244,10 +244,10 @@ int open_heaps(struct fsobj *fsobj, void *priv)
>> =A0=A0=A0=A0=A0 for_each_sysgroup(obj, tmp, heap) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (p - heap_data >=3D count)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
>> -=A0=A0=A0=A0=A0=A0=A0 heap =3D container_of(obj, struct shared_heap, me=
mspec);
>> +=A0=A0=A0=A0=A0=A0=A0 heap =3D container_of(obj, struct shared_heap_mem=
ory, memspec);
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 namecpy(p->name, heap->name);
>> -=A0=A0=A0=A0=A0=A0=A0 p->used =3D heap->ubytes;
>> -=A0=A0=A0=A0=A0=A0=A0 p->total =3D heap->total;
>> +=A0=A0=A0=A0=A0=A0=A0 p->used =3D heap->used_size;
>> +=A0=A0=A0=A0=A0=A0=A0 p->total =3D heap->usable_size;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 p++;
>> =A0=A0=A0=A0=A0 }
>>
> Philippe,
>=20
> Thanks for that update, I see that it made it into the -next branch.=A0
> The build went fine
> and I updated my SDK as well with the new heapobj headers, etc.=A0 But now
> it appears as though
> g++ is unhappy with casting between void* and heapobj*, heap_memory*,
> etc that I'm guessing has
> to do with alchemy headers ref'ing the heap pointers using void *. I'm
> ignoring this for now, focusing on the apps which are in C, which is 95%
> of what I have, and will look at using
> -fpermissive or #pragma's to fix the C++ issues later.
>=20

I fixed this in the repo, only tested with a trivial C++ app pulling in
the headers though. Please let me know if that works for you too.

> This is my first attempt with pshared since the new allocator went in.=A0
> I've always launched
> sysregd during system startup, like this:
>=20
> sysregd --daemon --root /var/run/xenomai/root/opus --linger
>=20
> Here's a traceback which happens with our rt_queue reader app, it only
> happens when the
> session already exists, not when it's the first process (except sysregd)
> in the session:
>=20
> ./mqueue-reader
> 2165 Segmentation fault=A0=A0=A0=A0=A0 (core dumped) ./mqueue-reader "$@"
>=20
> gdb session with core file:
>=20
> Core was generated by `./mqueue-readerE --mem-pool-size=3D32M
> --session=3Dopus'.
> Program terminated with signal SIGSEGV, Segmentation fault.
> #0=A0 0x76ee8704 in ?? ()
> [Current thread is 1 (LWP 2104)]
> (gdb) bt
> #0=A0 0x76ee8704 in ?? ()
> #1=A0 0x76fc38c0 in shavl_search_inner (delta=3D0x7ec7b9f0, n=3D0x7ec7ba0=
4,
> avl=3D0x7445c8f4) at
> ../../../../xenomai-3/include/boilerplate/avl-inner.h:285
> #2=A0 shavl_search_nearest (dir=3D1, node=3D0x7ec7ba04, avl=3D0x7445c8f4)=
 at
> ../../../../xenomai-3/include/boilerplate/avl-inner.h:393
> #3=A0 shavl_search_ge (node=3D0x7ec7ba04, avl=3D0x7445c8f4) at
> ../../../../xenomai-3/include/boilerplate/avl-inner.h:411
> #4=A0 find_suitable_range (size=3D1536, ext=3D0x7445c8b8) at
> ../../../../xenomai-3/lib/copperplate/heapobj-pshared.c:204
> #5=A0 reserve_page_range (size=3D1536, ext=3D0x7445c8b8) at
> ../../../../xenomai-3/lib/copperplate/heapobj-pshared.c:215
> #6=A0 add_free_range (heap=3D0x2, heap@entry=3D0x7445c000, bsize=3D212701=
8500,
> bsize@entry=3D1536, log2size=3D1950728192, log2size@entry=3D0)
> =A0=A0=A0 at ../../../../xenomai-3/lib/copperplate/heapobj-pshared.c:422
> #7=A0 0x76fc3b9c in sheapmem_alloc (heap=3D0x7445c000, size=3Dsize@entry=
=3D1272)
> at ../../../../xenomai-3/lib/copperplate/heapobj-pshared.c:543
>

Going from heap=3D0x7445c000 with size=3D1272 to heap=3D0x2 with
size=3D2127018500 looks weird, and won't work obviously. Any chance a
stack overflow would be at work here?

> The mqueue-reader app is larger than it should be so if this traceback
> isn't enough to lead
> you to a solution and you need some test code I will trim it down to
> something much smaller that
> still shows the issue and send that along.
>=20

You may want to run the new stress test exercising all of the memory
allocators, specifically for the heapmem-pshared:

$ smokey --run=3Dmemory_pshared --verbose=3D2

If that one runs properly on your setup, I would suspect an issue local
to the app (e.g. such as a stack overflow).

--=20
Philippe.

