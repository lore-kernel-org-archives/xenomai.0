From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <Pine.LNX.4.64.0906021420300.21660@domain.hid>
References: <4A157FD9.40106@domain.hid> <1243933749.27443.557.camel@domain.hid>
	<Pine.LNX.4.64.0906021420300.21660@domain.hid>
Content-Type: text/plain
Date: Thu, 02 Jul 2009 16:19:40 +0200
Message-Id: <1246544380.7803.217.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] About HARD real time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Martin Shepherd <mcs@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, 2009-06-02 at 15:40 -0700, Martin Shepherd wrote:
> On Tue, 2 Jun 2009, Philippe Gerum wrote:
> > For that reason, x3 will allow users to base their RT system over -rt or
> > the I-pipe, as they see fit, as the requirements mandate. When running
> > over -rt, Xenomai will only be in charge of providing real-time APIs;
> > when running over the I-pipe, it will also provide the real-time bedrock
> > that keeps latencies low, like it already does with earlier versions.
> 
> Is the following a feasible development approach at the current time?
> 
> 1. Start by developing one's realtime drivers and applications using
>     RTDM-native for device drivers, and standard POSIX realtime threads
>     and timers for one's applications, all running under a PREEMPT_RT
>     patched kernel. This presents a comfortable and familiar
>     development environment, with lots of tools, and the ability to
>     reduce realtime priorities while investigating a bug that
>     would otherwise lock up the computer.
> 
> 2. After doing most of the hard work of debugging, testing and
>     commissioning in the above environment, set up a Xenomai patched
>     kernel, and recompile one's RTDM drivers and applications under
>     Xenomai-duo. Even on systems which performed well under PREEMPT_RT,
>     doing this would eliminate the worry that some un-excersized
>     latency-generating path in PREEMPT_RT wouldn't cause mysterious
>     occasional missed deadlines.
> 
> 3. If later one wants to add significant features, or debug any
>     residual problems, go back to step 1 to do further development
>     and/or debugging.
> 

Let's put this differently: if one wants to be able to run the same
application code either over a dual kernel system or a native preemption
core, the strictest requirement comes from the co-kernel side: one has
to carefully segregate real-time and non real-time APIs, so that a time
critical thread won't switch to non-deterministic mode inadvertently.
For instance, by calling common malloc() or whatever glibc/pthread
service which may issue plain linux syscalls under the hood.

Therefore, the strictest requirement would already been there, even
before you start coding your app on top of preempt-rt, since I'm sure
you would not want to have to amend it later too much when time has come
to move it on top of the dual kernel. For instance, assuming that POSIX
signals are always delivered within a given time frame so as to use it
as an async real-time IPC might be fine with preempt-rt, but this would
be obviously wrong in a dual kernel system for userland code (this might
change at some point, but we still have to work on this).

Then, one should have some incentive to start working on a native
preemption core first if that is not the final RT framework to support
the application, and you mentioned the availability of tools in this
respect. I'm not sure this would be enough of an incentive in most
cases, since most of the common tools can be used over Xenomai as well
(gdb, ltt, profiling come to mind). Granted, using e.g. gdb over a
Xenomai RT thread makes it non-RT while the debugger holds it for
breakpointing, s-stepping etc., but in such a case, you just could not
claim any RT requirement anyway. However, valgrind-based tools are not
currently usable over a dual kernel Xenomai framework, that's a fact,
and may represent an incentive to use native preemption first in some
cases.

To sum up, I'm unsure that you would gain that a significant edge from
working over a native preemption core before porting everything to your
co-kernel system, in most cases. In any case, would you do so, you would
still have to abide by the co-kernel design and API constraints in your
initial implementation over preempt-rt.

There is one exception I see to the above though, when you actually want
to develop an application system on a powerful workstation before
eventually embedding it into your final target. In such a case, you
could use the desktop running preempt-rt as a development platform that
provides correct real-time behavior to the arch-independent part of your
application system.

> Provided that one didn't mix realtime and non-realtime threads in a
> single application, am I correct that the only thing that one would
> have to do, to go back and forth between steps 1 to 2, would be to use
> different makefiles and appropriately patched kernels?

Should be ok, but as suggested earlier, the "only thing" part you
mention here is likely to be the most demanding one when you will be at
the drawing board.

> 
> Is RTDM-native sufficiently mature to use under a PREEMPT_RT kernel?
> 

The question is two-fold:

- is preempt-rt mature enough to run on your particular target
- is RTDM-native mature enough

AFAIR, I don't think there are strong preempt-rt deps in RTDM native,
even if it was designed with preempt-rt in mind.

> In the future, when Xenomai 3 comes out, will there be any practical
> difference between the environment described above in step-1, and
> using the POSIX skin of Xenomai-solo?
> 

The point is that Xenomai-solo brings no POSIX skin at all; when coding
on top of POSIX with preempt-rt, you would just use the standard glibc.
Xenomai-solo brings our RTOS emulators to native linux platforms, and
being one of those, preempt-rt aims at delivering the real-time
performance for the set of services which should be RT capable per the
POSIX spec. So, when preempt-rt delivers on the RT promise, -solo does
as well, but you don't need -solo to run plain POSIX apps.

Xenomai-solo is three things:

1) a migration tool for people currently running a traditional RTOS
(e.g. VxWorks), who want to move over a preempt-rt based system whenever
available and mature for their target hw.

2) a migration tool for people currently running a traditional RTOS
emulator over a co-kernel based Xenomai environment, who want to move
over a preempt-rt based system.

3) a reusable workbench for the Xenomai project on the road to 3.0, so
that we may have a single code base for each traditional RTOS emulator
(VxWorks, pSOS...) we provide, that works both over a co-kernel and
native preemption cores. For that, we need two sets of building blocks
composing our generic RTOS core: one that works in dual kernel mode
(i.e. our "nucleus" thing), and another one that is built over common
real-time services from the POSIX standard, i.e. the -solo base library.

Put this library on top of the Xenomai POSIX skin in dual kernel mode,
and you should be able to stack the existing -solo RTOS emulators over
it as well. Use the plain glibc to get the POSIX services instead, but
over a preempt-rt enabled kernel, and you should get timely behavior as
well for those emulators, in native linux mode.

Well, that's the plan. If things start to hit the crapper, we will
probably have to resort to a successful technique commonly used among
software vendors: issue v4, which was there to paper over a serious
mis-design in v3, which was rolled out to fix half of v2's bugs, which
explained why we should not have even bothered with implementing v1 in
the first place. This technique is usually called "Customer Advantage
Program".

> Martin
-- 
Philippe.



