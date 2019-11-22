MIME-Version: 1.0
References: <CADYdroN-i9yrpd-wjPSW36GUptRV+kOCJT=Yv6+Z5sCVBmo_SQ@mail.gmail.com>
 <2012667816.853.1574437363737.JavaMail.zimbra@efficios.com>
 <4aab99be-5451-4582-f75d-7637614b1d37@siemens.com>
 <CADYdroOh+T8pOcNBW74KSMfCh--ujD8L3_G96LWR1migpsUq0g@mail.gmail.com>
 <63a51fa5-db96-9cf9-0eb3-51954ebf98f4@siemens.com>
In-Reply-To: <63a51fa5-db96-9cf9-0eb3-51954ebf98f4@siemens.com>
From: Norbert Lange <nolange79@gmail.com>
Date: Fri, 22 Nov 2019 19:01:32 +0100
Message-ID: <CADYdroP+H3DiqCaH9o1jHxAurh_2YG_p7MK4H2kFqSoTCV0w6A@mail.gmail.com>
Subject: Re: [lttng-dev] Using lttng-ust with xenomai
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, lttng-dev <lttng-dev@lists.lttng.org>, Xenomai <xenomai@xenomai.org>, paulmck <paulmck@kernel.org>

Am Fr., 22. Nov. 2019 um 18:52 Uhr schrieb Jan Kiszka <jan.kiszka@siemens.com>:
>
> On 22.11.19 18:44, Norbert Lange wrote:
> > Am Fr., 22. Nov. 2019 um 16:52 Uhr schrieb Jan Kiszka <jan.kiszka@siemens.com>:
> >>
> >> On 22.11.19 16:42, Mathieu Desnoyers wrote:
> >>> ----- On Nov 22, 2019, at 4:14 AM, Norbert Lange nolange79@gmail.com wrote:
> >>>
> >>>> Hello,
> >>>>
> >>>> I already started a thread over at xenomai.org [1], but I guess its
> >>>> more efficient to ask here aswell.
> >>>> The basic concept is that xenomai thread run *below* Linux (threads
> >>>> and irg handlers), which means that xenomai threads must not use any
> >>>
> >>> I guess you mean "irq handlers" here.
> >>>
> >>>> linux services like the futex syscall or socket communication.
> >>>>
> >>>> ## tracepoints
> >>>>
> >>>> expecting that tracepoints are the only thing that should be used from
> >>>> the xenomai threads, is there anything using linux services.
> >>>> the "bulletproof" urcu apparently does not need anything for the
> >>>> reader lock (aslong as the thread is already registered),
> >>>
> >>> Indeed the first time the urcu-bp read-lock is encountered by a thread,
> >>> the thread registration is performed, which requires locks, memory allocation,
> >>> and so on. After that, the thread can use urcu-bp read-side lock without
> >>> requiring any system call.
> >>
> >> So, we will probably want to perform such a registration unconditionally
> >> (in case lttng usage is enabled) for our RT threads during their setup.
> >
> > Who is we? Do you plan to add automatic support at xenomai mainline?
> >
> > But yes, some setup is likely needed if one wants to use lttng
>
> I wouldn't refuse patches to make this happen in mainline. If patches
> are best applied there. We could use a deterministic and fast
> application tracing frame work people can build upon, and that they can
> smoothly combine with system level traces.

Sure (good to hear), I just dont think enabling it automatic/unconditionally
is a good thing.


>
> >
> >>
> >>>
> >>>> liburcu has configure options allow forcing the usage of this syscall
> >>>> but not disabling it, which likely is necessary for Xenomai.
> >>>
> >>> I suspect what you'd need there is a way to allow a process to tell
> >>> liburcu-bp (or liburcu) to always use the fall-back mechanism which does
> >>> not rely on sys_membarrier. This could be allowed before the first use of
> >>> the library. I think extending the liburcu APIs to allow this should be
> >>> straightforward enough. This approach would be more flexible than requiring
> >>> liburcu to be specialized at configure time. This new API would return an error
> >>> if invoked with a liburcu library compiled with --disable-sys-membarrier-fallback.
> >>>
> >>> If you have control over your entire system's kernel, you may want to try
> >>> just configuring the kernel within CONFIG_MEMBARRIER=n in the meantime.
> >>>
> >>> Another thing to make sure is to have a glibc and Linux kernel which perform
> >>> clock_gettime() as vDSO for the monotonic clock, because you don't want a
> >>> system call there. If that does not work for you, you can alternatively
> >>> implement your own lttng-ust and lttng-modules clock plugin .so/.ko to override
> >>> the clock used by lttng, and for instance use TSC directly. See for instance
> >>> the lttng-ust(3) LTTNG_UST_CLOCK_PLUGIN environment variable.
> >>
> >> clock_gettime & Co for a Xenomai application is syscall-free as well.
> >
> > Yes, and that gave me a deadlock already, if a library us not compiled
> > for Xenomai,
> > it will either use the syscall (and you detect that immediatly) or it
> > will work most of the time,
> > and lock up once in a while if a Linux thread took the "writer lock"
> > of the VDSO structures
> > and your high priority xenomai thread is busy waiting infinitely.
> >
> > Only sane approach would be to use either the xenomai function directly,
> > or recreate the function (rdtsc + interpolation on x86).
>
> rdtsc is not portable, thus a no-go.

Its not portable, but you have equivalents on ARM, powerpc.
ie. "Do the same think as Xenomai"

> > Either compiling/patching lttng for Cobalt (which I really would not
> > want to do) or using a
> > clock plugin.
>
> I suspect you will want to have at least a plugin that was built against
> Xenomai libs.

That will then do alot other stuff like spwaning a printf thread.

>
> > If the later is supposed to be minimal, then that would mean I would
> > have to get the
> > interpolation factors cobalt uses (without bringing in libcobalt).
> >
> > Btw. the Xenomai and Linux monotonic clocks arent synchronised at all
> > AFAIK, so timestamps will
> > be different to the rest of Linux.
>
> CLOCK_HOST_REALTIME is synchronized.

Thats not monotonic?

>
> > On my last plattform I did some tracing using internal stamp and
> > regulary wrote a
> > block with internal and external timestamps so those could be
> > converted "offline".
>
> Sounds not like something we want to promote.

This was a questing to lttng and its tool environment. I suppose we
werent the first
ones with multiple clocks in a system.
If anything needs to be done in Xenomai it might be a concurrent
readout of Linux/cobalt time(s),
the rest would be done offline, potentially on another system.

 regards, Norbert

