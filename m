Message-ID: <44030109.8050603@domain.hid>
Date: Mon, 27 Feb 2006 14:39:21 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: AW: [Xenomai-core] vxworks-skin taskSpawn
References: <5D63919D95F87E4D9D34FF7748CE2C2A1C3C46@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A1C3C46@domain.hid>
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
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org, xenomai@xenomai.org

Roderik_Wildenburg@domain.hid wrote:
> Thank you for caring about my problem !
> Perhaps I should have mentioned in my earlier postings that I am using =
a PowerPC platform. I hope this does not nullify your prior analyses.
>=20
> These are the outputs (with some of my debug outputs), when I start sat=
ch.
>=20
> # ./satch
> Xenomai: UVM skin or CONFIG_XENO_OPT_PERVASIVE disabled.
> (modprobe xeno_uvm?)=20
>=20
> # insmod xeno_uvm.o
> Using xeno_uvm.o
> Xenomai: starting UVM services.
> Dec 12 06:21:02 trgt user.info kernel: Xenomai: starting UVM services.
>=20
> # ./satch
> Xenomai/uvm: real-time nucleus v2.1-rc2 (Champagne) loaded.
> starting VxWorks services.
> spawning consumer 805462824
> taskSpawn before TaskInit
> taskInit before xnpod_init_thread
> taskSpawn before TaskActivate
> taskActivate before xnpod_start_thread
> xnpod_start_thread before xnarch_init_thread ConsumerTask
> xnpod_start_thread after xnarch_init_thread
> xnpod_start_thread after xnpod_resume_thread
> xnpod_start_thread before xnpod_schedule
>=20
> satch stalled !!
> =3D> ouput form an other terminal
>=20
> ~ # cat /proc/xenomai/sched=20
> CPU  PID    PRI  TIMEOUT  STAT       NAME
>   0  0      0    0        R          ROOT
>   0  42     1    0        S          uvm-root
>   0  44     3    0        W          uvm-timer
> ~ # cat /proc/xenomai/timer=20
> status=3Doneshot:setup=3D40:tickval=3D1:jiffies=3D940509634545
>=20

It looks like for some reason, the newly created thread vanishes. I'll ch=
eck this=20
on a PPC board later since I cannot reproduce this on x86.

>=20
>=20
> So far the debug outputs. I never worked with gdb before, but I will tr=
y to establish a remote debug session with it, to get some more informati=
ons.
> But in the meantime could you perhaps be so kind to answer a questions =
occured with your answer (thank you) :
> You have written :
>=20
>=20
>>More precisely, the VxWorks API is compiled as a user-space=20
>>library (instead of a kernel module) when using the UVM mode,=20
>>and the VxWorks services are obtained from this library,=20
>>within the Linux process that embodies it. This is why there=20
>>is no point in loading the in-kernel VxWorks module in this case.
>=20
>=20
> O.k., I understand that the vxWorks API is done by some kind of wrapper=
 functionalities provided by the
  user-space vxworks library. What I don=B4t understand is, why do I need=
 the uvm=20
kernel module for vxWorks
  but not for the  native xenomai API ?
And, what is the vxWorks kernel module (xeno_vxworks.o) for, when do I ne=
ed it ??
>=20

Ok, long story:

When I first implemented the pervasive real-time support in user-space fo=
r Xenomai=20
at core level, a question arose: how do I make the existing real-time ski=
ns that=20
stack over this core (vxworks, psos+, vrtx and uitron at that time) runna=
ble in=20
user-space over this new support? Those skins where previously only runna=
ble in=20
kernel space, providing their services to applications compiled as kernel=
 modules,=20
through plain function calls.

Normally, I should have created a library containing all the needed syste=
m call=20
wrappers for each skin, allowing user-space applications to link against,=
 and=20
issue requests to the kernel module implementing the real-time services (=
e.g.=20
xeno_vxworks.ko), the same way the glibc exports system call wrappers to=20
applications for invoking Linux kernel services. But doing so would have =
required=20
to code ~300 wrappers (i.e. the sum of all services exported by the four =
existing=20
skins) and their associated handlers in kernel space that eventually invo=
ke the=20
system call, handling the parameters and the return value. For instance, =
this is=20
what has been done for the native and POSIX skins, which do not need the =
UVM=20
support to provide their services to user-space applications.

To solve this, and since I'm a lazy bastard with all the required imagina=
tion to=20
make an art of procrastination, I devised the UVM support, which allowed =
to run=20
the original real-time skins in user-space without having to provide thos=
e=20
wrappers. To this end, the UVM requires a copy of the nucleus, the real-t=
ime skin=20
and the application to be compiled as user-space code, which ends up bein=
g=20
embodied into a single Linux process image. A thin layer is then added to=
 connect=20
the "local" nucleus to the "global" one running in kernel space. This way=
, the=20
embodied skin calls the services of the local nucleus, and each time a sc=
heduling=20
decision is taken by the local nucleus as a consequence of such action, i=
t is=20
transparently delegated to the global one which actually performs context=
=20
switches. Since threads created within the context of a UVM are regular X=
enomai's=20
shadow threads (and _not_ some kind of lightweight/green threads), there =
is no=20
limitation on what you could do over such context compared to threads cre=
ated from=20
the native or POSIX skins [1].

The upside of the UVM is that for the most part, the real-time engine is=20
self-contained into a single Linux process, so the number of "real" syste=
m calls=20
issued by an application is slightly reduced (e.g. if your application gr=
abs an=20
uncontended VxWorks semaphore in the context of a UVM, it only costs a fu=
nction=20
call and no actual system call, since the operation has no incidence on t=
he=20
current scheduling state). The other nice part - out of lazyness - is tha=
t we=20
don't have to provide the system call wrappers for each and every service=
 exported=20
by the skin, but only a few ones implemented by the UVM support, in order=
 to=20
connect both cores (local and global), so that xeno_uvm.ko can receive re=
quests=20
from all running UVMs, and change the scheduling state appropriately, and=
 also=20
control the timer and a few other specific resources). Therefore, the rea=
son you=20
don't need to load xeno_vxworks.ko to run a VxWorks personality over the =
UVM is=20
that the VxWorks services are already provided by the same code but compi=
led as a=20
user-space library (libvxworks.so). On the other hand, libnative.so (nati=
ve skin)=20
or libpthread_rt.so (POSIX skin) only contain system call wrappers invoki=
ng the=20
real-time API in kernel space (i.e. xeno_native.ko and xeno_posix.ko).

The downside of the UVM is that your application can trash the runtime=20
environment, since both are embodied into a single address space; at wors=
t (maybe=20
at best, actually) this would "only" cause a process termination, but thi=
s is=20
still an issue to keep an eye on. Perhaps more importantly, giving the=20
applications access to machine-level resources is made much harder by the=
 UVM; for=20
instance, connecting IRQ handlers is not that fun in this environment.

Incidentally, a significant work toward v2.2 will be to progressively pro=
vide=20
fully native user-space support to the skins that currently miss it, like=
 it is=20
already available for the native and POSIX APIs. This will underly one of=
 v2.2's=20
major goals: keep improving Xenomai as a system of choice for migrating=20
applications from proprietary environments to GNU/Linux.

[1] http://download.gna.org/xenomai/documentation/trunk/pdf/Introduction-=
to-UVMs.pdf

--=20

Philippe.

