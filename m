Message-ID: <4366708B.8010501@domain.hid>
Date: Mon, 31 Oct 2005 20:29:15 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] General Xenomai / RTAI Skin Usage Questions
References: <OF8F0700EC.A1D80BF4-ONC12570AB.004AE3CB-C12570AB.005254F3@domain.hid>
In-Reply-To: <OF8F0700EC.A1D80BF4-ONC12570AB.004AE3CB-C12570AB.005254F3@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: andreas.spieker@domain.hid
Cc: xenomai@xenomai.org

andreas.spieker@domain.hid wrote:
> Hello,
>=20
> I have an existing user-space Application,
> programmed as a multithreaded C Program,
> until now relying on RTAI3.2, mostly on time + task services,
> basically to let all the threads run periodically,
> for IPC Stuff  I use SystemV-IPC (!).
>=20
> After the Split between RTAI and Xenomai I'm looking
> for an alternative to RTAI, because since Kernel 2.6.10,
> I was not longer able to get RTAI running (Kernel freezes)
> and the Mailing List Members were not really willing to give me
> some hints or a "functioning" kernel config file.
>=20
> So my questions are:
> 1.)  Do you think Xenomai (with RTAI Skin ?) is the right way for me to=
 go?

Note: As a consequence of the split, the once dubbed "rtai" or "native" s=
kin=20
available with RTAI/fusion has been strictly renamed Xenomai's "native" s=
kin.=20
The legacy RTAI compatibility skin for apps in kernel space available as =
the=20
"compat" skin with RTAI/fusion has been renamed Xenomai's "rtai" skin.

Xenomai's native skin focuses on compactness, consistency and orthogonali=
ty; I'm=20
not the right one to ask if this goal has been achieved, but at least, I'=
m not=20
receiving hate mail for this stuff, so this should be mostly ok. The doc =
is=20
available on-line:  http://download.gna.org/xenomai/documentation/html/ap=
i/

You could also use the POSIX skin, which is also fully available to user-=
space=20
apps. The idea of this skin is to provide a seamless and deterministic=20
replacement for a set of POSIX services applications can use. As a matter=
 of=20
fact, applications only using this subset can be linked with no change ag=
ainst=20
the Xenomai libpthread_rt library, or the regular LinuxThreads/NPTL libra=
ries.
The list of POSIX services which have been "shadowed" this way is availab=
le in=20
skins/posix/lib/posix.wrappers. Service calls that do not appear in this =
list=20
are simply redirected to and processed by the underlying LinuxThreads/NPT=
L=20
layer. The difference between a shadowed call and a regular one is of cou=
rse=20
determinism: the former will be processed by the Xenomai subsystem, the l=
atter=20
by the Linux kernel.

If you want an API that resembles traditional RTOS interfaces, then the n=
ative=20
skin is likely the best choice. If you prefer going for the 1003.1x stand=
ards,=20
the the POSIX skin is best. Xenomai is API agnostic anyway, use the one t=
hat=20
fits your needs, all are equally maintained.

> 2.)  Is there a simple (LXRT-like) demo with makefile for RTAI-Skin usa=
ge?

There are snippets which sketch the use of the native skin: look at=20
skins/native/snippets. There is also a rather detailed tech. article abou=
t using=20
it: http://download.gna.org/xenomai/documentation/pdf/Native-API-Tour.pdf

> 3.)  Actually, AFTER having created my threads, I use rt_task_init() +
>  rt_task_make_periodic() + rt_task_wait_period() in these threads to
> get them running periodically. So I turn an existing thread into someth=
ing
> with soft-realtime capabilities, the API calls refer to the already run=
ning
> thread. .
> When using Xenomai, do I have to change to rt_task_create() +
> rt_task_start(),
> therefore creating my threads from the xenomai api?

No, the corresponding call is rt_task_shadow() for the native API, or inv=
oking=20
pthread_setschedparam(pthread_self(),SCHED_FIFO,&schedparam) with the POS=
IX skin.

> I fear this would bring a lot of changes to my existing program, is thi=
s
> right and is this
> unavoidable?
> 4.) Is there a documentation which options must be set or unset in the
> linux kernel .config to get
> xenomai running? I had some problems, but was able to get them solved u=
sing
> an old
> "functioning" kernel config file (in contrast to RTAI).
>=20

Unfortunately, there is no cookbook for this purpose, yet. This said, her=
e are a=20
few guidelines:

- Only use _vanilla_ Adeos patches, either obtained from there:
http://download.gna.org/adeos/patches/v2.6/adeos/, or contained in the Xe=
nomai=20
distros.

- A kernel option that causes Xenomai (or Adeos) to blatantly malfunction=
 or=20
even crash is a freaking BUG, and should be reported asap to the Xenomai-=
core=20
list or the Adeos-main list. IOW, there is no such thing as options allow=
ed to=20
crash your box with Adeos/Xenomai because of some "don't care attitude"; =
would=20
such bug happen, it must and will be fixed. All the people involved in=20
contributing to both projects try to make sure that any option could be e=
nabled=20
without risking terminal damage to anyone's setup. The worst thing that s=
hould=20
be allowed to happen is high latency spots, because some options might ca=
use=20
some hardware to interact badly with critical resources Adeos/Xenomai als=
o=20
happen manage.

- Usual suspects for high (in the pathological sense) latency spots due t=
o=20
particular kernel configuration are (from the top of my head):
	+ APM
	+ possibly ACPI depending on what hw is controlled (Like Emacs I'm using=
, ACPI=20
seems to handle everything but the kitchen sink, so some configs with ACP=
I on=20
may work, others might not)
	+ CPU frequency scaling (cpufreq stuff, of course)
	+ some DMA supports may cause bus mastering artefacts delaying interrupt=
=20
service but again, a lot don't.

There are even some interesting cases where you actually need some option=
s to be=20
on for the latencies to go down. Read the TROUBLESHOOTING file in Xenomai=
's top=20
level dir, it's usually helpful.

- Other sources of increased latency, but less pathological usually comes=
 from
the Kernel hacking section: CONFIG_FRAME_POINTER for x86, CONFIG_DEBUG_SP=
INLOCK,=20
CONFIG_DEBUG_SPINLOCK_SLEEP are known to add some overhead, but the incre=
ase is=20
still bareable compared to the valuable debugging information those optio=
ns=20
bring in if needed. In any case, Xenomai/Adeos developers actually always=
 turn=20
those options on to make sure that the real-time side always plays well w=
ith the=20
Linux kernel. IOW, production systems should have those off, but developm=
ent=20
setups may want them on.

- On x86, APIC is _good_ for you when you have one on your CPU, Xenomai p=
lays=20
nicely with it, and the overall latency is significantly reduced, especia=
lly in=20
oneshot mode.

> Thanks for any hints and comments,
> Andreas Spieker
>=20
> PS: *** I will be in holidays the next weeks, so will notbe able to rep=
ly
> immediately to postings ***
>=20
>=20
> -----------------------------------------------------
> Dr.-Ing. Andreas Spieker
> Research Information and Communication
> Assisting Systems (REI/AA)
>=20
> DaimlerChrysler AG
> HPC 050-G023
> D-71059 Sindelfingen
> Telefon: +49 7031 4389 774
> Telefax:  +49 7031 4389 264
> Mobil:     (+49) (0)179 -10 84 718
> email: andreas.spieker@domain.hid
>=20
> Besucheradresse:
> DaimlerChrysler AG
> REI/AA, Zimmer 1.103
> Hanns-Klemm-Stra=DFe 45
> 71034 B=F6blingen,
> -----------------------------------------------------
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20


--=20

Philippe.

