Message-ID: <44870475.8030705@domain.hid>
Date: Wed, 07 Jun 2006 18:53:09 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: AW: [Xenomai-core] Ipipe hook at system call exit
References: <88AEA5AC18A141439A0D954EB037B0D30439F329@domain.hid>
In-Reply-To: <88AEA5AC18A141439A0D954EB037B0D30439F329@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Krause, Karl-Heinz" <karl-heinz.krause@domain.hid>
Cc: xenomai@xenomai.org

Krause, Karl-Heinz wrote:
> Thanks Philippe for your quick reply.
>=20
> May be a few additional remarks will clarify some remaining misundersta=
nding. Compared to Xenomai the basic differences are=20
> -- there are no shadow threads
> -- we use the standard glibc with futex based synchronization/communica=
tion=20
>    working across domain boundary transparently.
> This transparency is demonstrated by having the  process binary running=
 on a ipipe-patched Linux only. After loading the realtime module the sam=
e binary runs but the responding threads provide for the realtime guarant=
ees.
> Now lets go beyond marketing:
> First the glibc implementation is not completely realtime capable. This=
 concerns two functions
> - the implementation of the SIGEV_THREAD notification=20
> - the implementation of the spinlock() function
> For both we do have realtime capable implementations. Since these issue=
s hold also for a natively realtime capable Linux it also must be solved =
for=20
> a "natively" realtime capable Linux (PREMPT_RT) and the chances to have=
 one standard implemention are quite good.  The only difference may be th=
e spinlock(). Here the protection needed for static priorities can be don=
e
> differently. For a two kernel solution the protection must work across =
(interrupt disable).
>=20
> I guess the transparency also explains why we cannot rely on lazy migra=
tion back.
If for e.g. a thread which should provide for realtime response does an=20
open() or a mmap() during
  its setup phase and then a sigwait() for responding, then the=20
sigwait() call has to be executed
in the realtime domain from the very beginning. Having the check for=20
migration back to realtime
at the system call epilog of Linux is the most convenient way, otherwise=20
we would neet hooks in
  every system call function which is propagatable.

But, intercepting the SYSCALL event for all domains is equivalent to=20
having such hook.

>=20
> Concerning the futex function. Currently we intercept at the system cal=
l exit and call the corresponding rt-function when the number of requeste=
d=20
> wakeups could not be performed.

You mean that if Linux fails to identify one of its own futexes during a=20
get/release operation, then the handling is passed to the RT side?

  This provides for an excellent filtering
> but works for regular mutexes only. If we want to preserve the exact se=
mantics for PI mutexes we have to call the rt-function upfront.=20
> For mutexes with priority ceiling migration the migration check at syst=
em call exit is sufficient. For priority inheritance we would need to use=
 the scheduler hook.
>=20
> Concerning the mlock-stuff we view it to be not sufficient, since if so=
mebody does a malloc() and sets up preallocated structures, they are not =
necessarily touched.
>=20

I still don't get the point here. mlocking the data segment should cause=20
all pages included into this segment to be touched by the mm during the=20
fixup, basically by forcing the invocation of the page fault handler for=20
each page found in the associated VMAs. So there is no way the=20
underlying physical memory could not be committed after mlock.

> Concerning the performance issues and your remark that you have still w=
ork to do.
For us treating system calls what they really are namely synchronous=20
exceptions which
should be handled by the causing domain only would be perfect fit and=20
would be faster.(as an option)
>=20

IPIPE_EVENT_SELF does it for recent I-pipe patches. It's a modifier=20
telling Adeos to send the event only to the causing domain's handler.

> Hopefully this clears up the issues somewhat.

Well, yes and no. Talking about the syscall exit hook, I don't get why=20
it is absolutely required since the co-kernel can control the migrations=20
as part of a preamble and/or postamble code surrounding the syscall=20
demux, given that all syscalls from any domain can be filtered through=20
it by Adeos. I do understand that changing the existing and working code=20
might not be the preferred solution though, but additions to the=20
critical path must enable a mandatory feature which could not be=20
obtained by other means.

>=20
>=20
> Karl-Heinz
>  =20
>=20
> -----Urspr=FCngliche Nachricht-----
> Von: Philippe Gerum [mailto:rpm@xenomai.org
> Gesendet: Mittwoch, 7. Juni 2006 15:21
> An: Krause, Karl-Heinz
> Cc: xenomai@xenomai.org
> Betreff: Re: [Xenomai-core] Ipipe hook at system call exit
>=20
>=20
> Hello,
>=20
> Krause, Karl-Heinz wrote:
>=20
>>Hallo Philippe
>>
>>=20
>>
>>Jan Kiszka referred me to you discussing our problem with a missing=20
>>Ipipe hook at system call exit.
>>
>>We at Siemens A&D do have a Linux realtime approach which is based on a=
=20
>>previous ADEOS version. When trying to port an improved version to the=20
>>Ipipe version for kernel 2.6.15.4 we ran into the problem of not having=
=20
>>an event hook at system call exit. Let me explain the need for it by=20
>>briefly outlining our approach.
>>
>>It is a two kernel approach based on the model of a multihreaded proces=
s=20
>>(means 2.6 kernel) where the threads above  a certain static priority=20
>>level e.g. 68 are scheduled by the  scheduler of the realtime kernel.=20
>>The realtime kernel maintains exactly the same systemcall interface as=20
>>the Linux kernel. The entire process works uniformely with the glibc.=20
>>The glibc isn't aware under which scheduler the current thread is=20
>>executing. To make this happen and having both schedulers  to work with=
=20
>>the same struct task struct  we had to put some restrictions on the=20
>>signalling for the realtime domain (restrictions which make sense for=20
>>the realtime arena anyway). Because of that transparency this approach=20
>>combines somehow the advantages of a separated realtime kernel with the=
=20
>>user convenience of  PREEMPT_RT. (the user convenience was the driving=20
>>requirement for our approach)
>>
>=20
>=20
> There seems to be quite a lot of commonality with the way Xenomai deals=
=20
> with shadow threads to enable realtime processing in user-space, while=20
> providing a seamless integration with Linux. One difference might be th=
e=20
> way your system deals with Linux syscalls fired on behalf of a thread=20
> controlled by the real-time scheduler; Xenomai migrates the thread to=20
> the Linux scheduler transparently, but I did not figure out yet if this=
=20
> was a relevant issue in your system. Anyway, I think that I now roughly=
=20
> understand the general dynamics of it, thanks for the explanations.
>=20
>=20
>>=20
>>
>>Now to the question why we need a hook at systemcall exit.
>>
>>The hook at systemcall entry branches to the system call handling of th=
e=20
>>realtime kernel, which is also entered via a systemcall table. The=20
>>handling can be grouped in three classes
>>
>>-         complete handling in the realtime domain e.g. timer_settime()=
,=20
>>sigwait()
>>
>>-         only migration of the thread to the Linux scheduler. Basicall=
y=20
>>all calls needed for setup e.g. open(), mmap(), pthread_create().  The=20
>>migration is transparent for the ipipe code, the thread continues=20
>>execution in the Linux domain with the call of the Linux system call=20
>>table (the priority hasn't changed).
>>
>>-         handling in the realtime domain and migration to the Linux=20
>>domain if the thread priority has dropped unter the boundary (e.g=20
>>releasing a mutex with priority ceiling)
>>
>>=20
>>
>>In particular for the second case a check needs to be done at sytem cal=
l=20
>>exit as to whether the thread has to migrate (back) to the realtime=20
>>scheduler. But this is also needed when a call issued in the Linux=20
>>raises the priority above the threshold. A third reason for the hook is=
=20
>>to touch the corresponding pages after a brk() or mmap() call for=20
>>getting residency.
>>
>> Note:
>>
>>The migration only takes place for threads of a process marked as realt=
ime.
>>
>>Currently we allow only for one realtime process. First it is sufficien=
t=20
>>for us and second it allows us to maintain the futex queue (each domain=
=20
>>maintains a local queue) of the realtime domain with virtual addresses=20
>>(no mm_lock). =20
>>
>=20
>=20
> Does this mean that you specifically intercept futex ops to process the=
m=20
> in real-time mode when fired over the real-time context? Which would in=
=20
> turn allow you to traverse most of the glibc code and get it=20
> synchronized with the plain Linux threads?
>=20
>=20
>>=20
>>
>>So this hook at system call exit is a necessity for us. Of course we=20
>>could do a private patch, but do you see a possibility to have it in th=
e=20
>>standard Ipipe-patch?
>>
>=20
>=20
> Basically, I removed the sysexit hook from the I-pipe patch because it=20
> added a non-negligible overhead to each syscall. Even the sysenter hook=
=20
> needs some work to reduce its CPU footprint and I've planned to tackle=20
> the issue soon. For this reason, the current Xeno implementation only=20
> relies on the sysenter (IPIPE_EVENT_SYSCALL) hook to deal with=20
> migrations between the Linux and Xenomai schedulers, usually enforcing =
a=20
> lazy migration scheme, i.e. the syscall prologue added by the RT=20
> extension switches the caller to the proper domain before running the=20
> system call handler, but does not eagerly switch back to the originatin=
g=20
> domain (well, there are exceptions to this, but that's the usual way=20
> things are handled).
>=20
> Reading your description, a few questions came to my mind:
>=20
> - why do you force a switch back to the originating domain? IOW, are=20
> eager transitions absolutely required in your design, since your RT=20
> thread is underlaid by a regular Linux task anyway, so it could continu=
e=20
> its processing and switch back to the RT side only when needed?
>=20
> - would not it be possible to intercept the IPIPE_EVENT_SETSCHED=20
> notifications, which are fired by the I-pipe when a Linux task is about=
=20
> to have its priority changed? It's a direct hook from the kernel's=20
> sched_setscheduler(), which is given the task_struct pointer of the=20
> altered task, right after its priority field has been updated, but stil=
l=20
> before the Linux runqueue is reordered.
>=20
> - would mlocking the data segment of your application be enough/possibl=
e=20
> to ensure that brk() and mmapped() segments get committed to physical=20
> memory automatically, and as such spare you the need for touching those=
=20
> areas explicitely? AFAIK, mlocked pages are going to be fixed up this=20
> way by the mm layer during the mlocking call.
>=20
> - generally speaking, since you control the prologue and epilogue of al=
l=20
> system calls (Linux or real-time) which go through your own syscall=20
> demux by mean of the IPIPE_EVENT_SYSCALL hook, it should be possible to=
=20
> handle the whole migration issue (be it eager or lazy in this case) fro=
m=20
> your code, instead of relying on a hook inserted in Linux's syscall=20
> return path. Or am I missing something?
>=20
>=20
>>=20
>>
>>=20
>>
>>Karl-Heinz Krause
>>
>>Siemens A&D
>>
>>Nbg.-Moorenbrunn
>>
>>=20
>>
>>=20
>>
>>=20
>>
>>=20
>>
>>
>>-----------------------------------------------------------------------=
-
>>
>>_______________________________________________
>>Xenomai-core mailing list
>>Xenomai-core@domain.hid
>>https://mail.gna.org/listinfo/xenomai-core
>=20
>=20
>=20


--=20

Philippe.

