Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <51660709.3010809@xenomai.org>
Date: Thu, 11 Apr 2013 09:00:38 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C6B8C75-5498-4645-AA10-5651431A1E90@mah.priv.at>
References: <FD5EBA50-E222-4012-A755-A20FF5D5971D@mah.priv.at>
	<5165E85B.2040609@xenomai.org>
	<E9BAB42D-B8E9-4E23-8A15-934A72AC7823@mah.priv.at>
	<51660709.3010809@xenomai.org>
Subject: Re: [Xenomai] shared memory compatibility - advice sought
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles,

I think I see the light although I'm not totally clear on all details =
yet:

Am 11.04.2013 um 02:42 schrieb Gilles Chanteperdrix:

> On 04/11/2013 01:39 AM, Michael Haberler wrote:
>=20
>> Gilles,
>>=20
>> thank you for your detailed answer.
>>=20
>> I'll concentrate on the RTDM suggestion because I'm after a long-term
>> stable solution, and also because I feel RTAI needs a similar
>> approach
>>=20
>> please let me make sure I fully understand your suggestions, see
>> below inline:
>>=20
>> Am 11.04.2013 um 00:31 schrieb Gilles Chanteperdrix:
>>=20
>>> On 04/10/2013 11:24 PM, Michael Haberler wrote:
>>>=20
>>>> I am building an RT application which is portable across RTAI,=20
>>>> Xenomai/userland threads, Xenomai/kernel threads, RT-preempt and=20
>>>> vanilla kernels (modulo timing restrictions). The xenomai kernel=20
>>>> threads build is on a deprecation path but build for coverage
>>>> reasons atm.
>>>>=20
>>>> The application already does support several instances on one=20
>>>> machine, for instance one instance could be Xenomai kernel
>>>> threads, a second one Xenomai user threads, a third one Posix
>>>> threads (thats an example and doesnt make sense, just pointing
>>>> out whats possible)
>>>>=20
>>>> The userland threads instances uses sysvipc shm; RTAI instance
>>>> uses rtai_malloc/rtai_kmalloc; Xenomai kernel uses=20
>>>> rt_heap_create/rt_heap_alloc.
>>>>=20
>>>> --
>>>>=20
>>>> A requirement has come up to enable access of shared memory
>>>> between instances and that's where I dont know how to proceed -
>>>> the issues I have are:
>>>>=20
>>>> - incompatible shared memory models between RTAI, Xenomai and=20
>>>> shmctl() - sequencing imposed by kernel threads models - shared=20
>>>> memory must be created in-kernel and can attached to in userland
>>>> but not vice versa
>>>>=20
>>>> I know it is a faint hope, let me try nevertheless:
>>>>=20
>>>> - is there a way to make Xenomai kernel threads use shared
>>>> memory created in userland by shmctl(2) or mmap for that matter
>>>=20
>>>=20
>>> RTDM skin (the future-proof way): rtdm_mmap_to_user will allow you
>>> to map a piece of memory (obtained for instance with kmalloc or
>>> even vmalloc in kernel-space), in a process user-space. You have to
>>> devise the interactions between user and kernel-space through a
>>> driver if you want the user-space to seem to do the allocation
>>> first.
>>=20
>> I understand this to mean:
>>=20
>> - in case the application runs on Xenomai, either thread style
>> (xenomai user, xenomai kernel, posix): - in this case shared memory
>> creation and attaching would go through a xenomai-dependent layer
>> handled by an RTDM device driver - this driver can allocate memory
>> (or return a reference to an existing memory area) and return a
>> handle which can be used in userland similar to a sysvip segment
>=20
>=20
> I would forget about sysv ipcs, and think more POSIX.

that's the legacy code I inherited, but not a big change to adapt.

>=20
> - it
>> would provide the same function to kernel threads modules whishing to
>> attach a shared memory segment - whoever initiated its creation
>>=20
>> Does this sound about right?
>=20
>=20
> Let us talk concretely. If I assume you want to share the same piece =
of
> memory in all the cases (which I originally did not).

yes, that is the requirement

> You would have a
> common kernel module able to allocate a piece of memory and associate =
it
> with an identifier (a string, ala shm_open/sem_open, for instance).

fine (we're using instance id/shm id tuples but conceptually similar)

> Then an rtdm module, with an ioctl allowing to retrieve that piece of
> memory or allocate it given the id, and if called from user-space use
> rtdm_mmap_to_user to put it in the process adress-space, if called =
from
> kernel-space, return the memory directly. The same RTDM code can be
> compiled both for RTAI and Xenomai and covers 4 cases. And RTDM =
drivers
> can be called as well from kernel space as from user-space, if I
> remember correctly.

I understand this is more or less the old captain.at RTDM driver =
modified to use the module above instead of directly doing a kmalloc() =
(it seems to have vanished from the Internet-accessible earth but I =
think I have collected the pieces needed to resurrect it)

are the workarounds mentioned here still needed? =
http://www.xenomai.org/pipermail/xenomai/2008-October/014958.html


> Then another linux module, with an ioctl and an mmap call allowing to
> retrieve the same piece of memory with the same ID and map it in the
> process user-space.

the point where I am lost is this one, and the suggestion you state at =
the bottom:

> the common API already exists and is POSIX, simply use POSIX, and you =
do not need a useless abstraction layer.

are you suggesting this array of modules will plug underneath the =
userland Posix shared memory routines unchanged?

>=20
>>=20
>> I can imagine funneling all shm-type calls through say a shared
>> object which is dlopen'd by the using layer after autodetection of
>> the running environment; thats a vehicle we#ve been using sucessfully
>> so far
>=20
>=20
> I am not sure I understand why you need that level of complication. =
What
> you can dlopen is simply something which defines wrappers for posix
> services, ioctl, mmap, and simply use libpthread_rt.so when a xenomai
> user-space application is wanted.

Sorry if I was unclear on the goals.

What we intend to build is a binary package, plus RTOS-dependent modules =
packages, to run on _any_ kernel unchanged, not just Xenomai or RTAI for =
that matter, but also rt-preempt and vanilla (with no timing guarantees =
as this is only a 'simulator')

in the latter two cases there would be no RTDM environment and no need =
to go through a kernel module to do the shm allocation stunt; hence no =
kernel modules included for rt-preempt and vanilla

but it seems to me the unified shm handling can be done in userland code =
detecting the RTDM driver, use that if present, and if not, fall back to =
posix shm

(this is where I might not have fully understood how Posix shm can be =
used in the former scenario as single API)


>> in the xenomai case the shm functions in this object would go through
>> the steps outlined above in the userland/sysvipc/vanilla kernel they
>> would just use sysvipc shm and no kernel driver
>>=20
>> I know I'm barking up the wrong tree here but you mentioned wrapping
>> RTAI shm services:
>>=20
>> do you suggest to make RTAI shm work with the RTDM model (I'm fuzzy
>> how that would work) or is it a vanilla device driver approach you're
>> suggesting?
>=20
>=20
> RTAI definitely has RTDM, but I do not know how far the integration =
goes
> and if rtdm_mmap_to_user is available. If it is not available it seems
> simple to add it.

it seems RTAI has rtdm_mmap_to_user() since 3.8.1

>> I assume in the RTAI case there would need to be a similar driver to
>> do rtai_kmalloc() in-kernel and eventually rtai_malloc() when
>> returned on behalf of the using layer
>>=20
>> I might be overlooking something obvious, but atm I see this panning
>> out to virtualizing the shared memory creation/attachment layer
>> across platforms - that's fine, Private Haberler just needs to
>> understand the General's commands ;)
>=20
>=20
> This is where I disagree. The common API already exists and is POSIX,
> simply use POSIX, and you do not need a useless abstraction layer.
>=20
> --=20
>                                                                Gilles.

thansk a lot in advance!

Michael


