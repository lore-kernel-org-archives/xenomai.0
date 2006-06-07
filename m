Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: AW: [Xenomai-core] Ipipe hook at system call exit
Date: Wed, 7 Jun 2006 17:16:24 +0200
Message-ID: <88AEA5AC18A141439A0D954EB037B0D30439F329@domain.hid>
In-Reply-To: <4486D2BD.7040101@domain.hid>
From: "Krause, Karl-Heinz" <karl-heinz.krause@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Thanks Philippe for your quick reply.

May be a few additional remarks will clarify some remaining =
misunderstanding. Compared to Xenomai the basic differences are=20
-- there are no shadow threads
-- we use the standard glibc with futex based =
synchronization/communication=20
   working across domain boundary transparently.
This transparency is demonstrated by having the  process binary running =
on a ipipe-patched Linux only. After loading the realtime module the =
same binary runs but the responding threads provide for the realtime =
guarantees.
Now lets go beyond marketing:
First the glibc implementation is not completely realtime capable. This =
concerns two functions
- the implementation of the SIGEV_THREAD notification=20
- the implementation of the spinlock() function
For both we do have realtime capable implementations. Since these issues =
hold also for a natively realtime capable Linux it also must be solved =
for=20
a "natively" realtime capable Linux (PREMPT_RT) and the chances to have =
one standard implemention are quite good.  The only difference may be =
the spinlock(). Here the protection needed for static priorities can be =
done
differently. For a two kernel solution the protection must work across =
(interrupt disable).

I guess the transparency also explains why we cannot rely on lazy =
migration back. If for e.g. a thread which should provide for realtime =
response does an open() or a mmap() during its setup phase and then a =
sigwait() for responding, then the sigwait() call has to be executed in =
the realtime domain from the very beginning. Having the check for =
migration back to realtime at the system call epilog of Linux is the =
most convenient way, otherwise we would neet hooks in every system call =
function which is propagatable.=20

Concerning the futex function. Currently we intercept at the system call =
exit and call the corresponding rt-function when the number of requested =

wakeups could not be performed. This provides for an excellent filtering
but works for regular mutexes only. If we want to preserve the exact =
semantics for PI mutexes we have to call the rt-function upfront.=20
For mutexes with priority ceiling migration the migration check at =
system call exit is sufficient. For priority inheritance we would need =
to use the scheduler hook.

Concerning the mlock-stuff we view it to be not sufficient, since if =
somebody does a malloc() and sets up preallocated structures, they are =
not necessarily touched.

Concerning the performance issues and your remark that you have still =
work to do. For us treating system calls what they really are namely =
synchronous exceptions which should be handled by the causing domain =
only would be perfect fit and would be faster.(as an option)

Hopefully this clears up the issues somewhat.


Karl-Heinz
 =20

-----Urspr=FCngliche Nachricht-----
Von: Philippe Gerum [mailto:rpm@xenomai.org
Gesendet: Mittwoch, 7. Juni 2006 15:21
An: Krause, Karl-Heinz
Cc: xenomai@xenomai.org
Betreff: Re: [Xenomai-core] Ipipe hook at system call exit


Hello,

Krause, Karl-Heinz wrote:
> Hallo Philippe
>=20
> =20
>=20
> Jan Kiszka referred me to you discussing our problem with a missing=20
> Ipipe hook at system call exit.
>=20
> We at Siemens A&D do have a Linux realtime approach which is based on =
a=20
> previous ADEOS version. When trying to port an improved version to the =

> Ipipe version for kernel 2.6.15.4 we ran into the problem of not =
having=20
> an event hook at system call exit. Let me explain the need for it by=20
> briefly outlining our approach.
>=20
> It is a two kernel approach based on the model of a multihreaded =
process=20
> (means 2.6 kernel) where the threads above  a certain static priority=20
> level e.g. 68 are scheduled by the  scheduler of the realtime kernel.=20
> The realtime kernel maintains exactly the same systemcall interface as =

> the Linux kernel. The entire process works uniformely with the glibc.=20
> The glibc isn't aware under which scheduler the current thread is=20
> executing. To make this happen and having both schedulers  to work =
with=20
> the same struct task struct  we had to put some restrictions on the=20
> signalling for the realtime domain (restrictions which make sense for=20
> the realtime arena anyway). Because of that transparency this approach =

> combines somehow the advantages of a separated realtime kernel with =
the=20
> user convenience of  PREEMPT_RT. (the user convenience was the driving =

> requirement for our approach)
>=20

There seems to be quite a lot of commonality with the way Xenomai deals=20
with shadow threads to enable realtime processing in user-space, while=20
providing a seamless integration with Linux. One difference might be the =

way your system deals with Linux syscalls fired on behalf of a thread=20
controlled by the real-time scheduler; Xenomai migrates the thread to=20
the Linux scheduler transparently, but I did not figure out yet if this=20
was a relevant issue in your system. Anyway, I think that I now roughly=20
understand the general dynamics of it, thanks for the explanations.

> =20
>=20
> Now to the question why we need a hook at systemcall exit.
>=20
> The hook at systemcall entry branches to the system call handling of =
the=20
> realtime kernel, which is also entered via a systemcall table. The=20
> handling can be grouped in three classes
>=20
> -         complete handling in the realtime domain e.g. =
timer_settime(),=20
> sigwait()
>=20
> -         only migration of the thread to the Linux scheduler. =
Basically=20
> all calls needed for setup e.g. open(), mmap(), pthread_create().  The =

> migration is transparent for the ipipe code, the thread continues=20
> execution in the Linux domain with the call of the Linux system call=20
> table (the priority hasn't changed).
>=20
> -         handling in the realtime domain and migration to the Linux=20
> domain if the thread priority has dropped unter the boundary (e.g=20
> releasing a mutex with priority ceiling)
>=20
> =20
>=20
> In particular for the second case a check needs to be done at sytem =
call=20
> exit as to whether the thread has to migrate (back) to the realtime=20
> scheduler. But this is also needed when a call issued in the Linux=20
> raises the priority above the threshold. A third reason for the hook =
is=20
> to touch the corresponding pages after a brk() or mmap() call for=20
> getting residency.
>=20
>  Note:
>=20
> The migration only takes place for threads of a process marked as =
realtime.
>=20
> Currently we allow only for one realtime process. First it is =
sufficient=20
> for us and second it allows us to maintain the futex queue (each =
domain=20
> maintains a local queue) of the realtime domain with virtual addresses =

> (no mm_lock). =20
>

Does this mean that you specifically intercept futex ops to process them =

in real-time mode when fired over the real-time context? Which would in=20
turn allow you to traverse most of the glibc code and get it=20
synchronized with the plain Linux threads?

> =20
>=20
> So this hook at system call exit is a necessity for us. Of course we=20
> could do a private patch, but do you see a possibility to have it in =
the=20
> standard Ipipe-patch?
>

Basically, I removed the sysexit hook from the I-pipe patch because it=20
added a non-negligible overhead to each syscall. Even the sysenter hook=20
needs some work to reduce its CPU footprint and I've planned to tackle=20
the issue soon. For this reason, the current Xeno implementation only=20
relies on the sysenter (IPIPE_EVENT_SYSCALL) hook to deal with=20
migrations between the Linux and Xenomai schedulers, usually enforcing a =

lazy migration scheme, i.e. the syscall prologue added by the RT=20
extension switches the caller to the proper domain before running the=20
system call handler, but does not eagerly switch back to the originating =

domain (well, there are exceptions to this, but that's the usual way=20
things are handled).

Reading your description, a few questions came to my mind:

- why do you force a switch back to the originating domain? IOW, are=20
eager transitions absolutely required in your design, since your RT=20
thread is underlaid by a regular Linux task anyway, so it could continue =

its processing and switch back to the RT side only when needed?

- would not it be possible to intercept the IPIPE_EVENT_SETSCHED=20
notifications, which are fired by the I-pipe when a Linux task is about=20
to have its priority changed? It's a direct hook from the kernel's=20
sched_setscheduler(), which is given the task_struct pointer of the=20
altered task, right after its priority field has been updated, but still =

before the Linux runqueue is reordered.

- would mlocking the data segment of your application be enough/possible =

to ensure that brk() and mmapped() segments get committed to physical=20
memory automatically, and as such spare you the need for touching those=20
areas explicitely? AFAIK, mlocked pages are going to be fixed up this=20
way by the mm layer during the mlocking call.

- generally speaking, since you control the prologue and epilogue of all =

system calls (Linux or real-time) which go through your own syscall=20
demux by mean of the IPIPE_EVENT_SYSCALL hook, it should be possible to=20
handle the whole migration issue (be it eager or lazy in this case) from =

your code, instead of relying on a hook inserted in Linux's syscall=20
return path. Or am I missing something?

> =20
>=20
> =20
>=20
> Karl-Heinz Krause
>=20
> Siemens A&D
>=20
> Nbg.-Moorenbrunn
>=20
> =20
>=20
> =20
>=20
> =20
>=20
> =20
>=20
>=20
> =
------------------------------------------------------------------------
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


--=20

Philippe.


