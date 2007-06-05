From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <465FC2FC.1010902@domain.hid>
References: <465ABD99.1090301@domain.hid> <1180630376.5020.131.camel@domain.hid>
	<465F3277.1080400@domain.hid> <1180651652.5020.197.camel@domain.hid>
	<465FC2FC.1010902@domain.hid>
Content-Type: text/plain
Date: Tue, 05 Jun 2007 10:27:21 +0200
Message-Id: <1181032041.32137.68.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [ANNOUNCE] Xenomai and I-pipe	patch	series,
	LTTng bits
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Fri, 2007-06-01 at 08:55 +0200, Jan Kiszka wrote:
> > 
> > panic. See the code flow from xntimer_start_*periodic for instance, up
> > to the point where the timer is enqueued.
> 
> With wrong I meant valid sched, but for an incorrect CPU.
> 

As explained earlier, nothing really bad would happen, except a
sub-optimal setup.

> > 
> >>  Anyway, if you say it does matter, my instrumentation would
> >> have caught the first bug in Xenomai! That xnpod_raw_current_sched() is
> >> there because xntimer_init is used in non-atomic contexts (I got
> >> warnings from DEBUG_PREEMPT).
> > 
> > Thread migration in Xenomai only happens upon request from the migrating
> > thread itself, so it becomes an issue if the caller belongs to the Linux
> > domain (i.e. preemption in init_module, the rest is not much
> 
> ...or preemption during shadow thread creation. But this requires the
> that Linux thread to be shadowed has no clearly defined single-CPU
> affinity and might happen to be pushed around by a loadbalancer during
> init. This sounds like a fatal user error /wrt RT.
> 

The point is that in any case, this would make no difference with a
shadow with a lose affinity being moved to another CPU while running, by
a call to sched_setscheduler(), or as a result of load balancing.
xnshadow_map per-se brings nothing more to the picture with respect to
this issue, except that at some point, it really pins the current task
on the current CPU. Per Xenomai-thread timers have been initialized
before xnshadow_map is entered anyway.

> > 
> >>>> librtutils.patch
> >>>>
> >>>>     My original librtprint patch. I now renamed the library to
> >>>>     librtutils to express that more stuff beyond rt_print may find its
> >>>>     home here in the future. Hopefully acceptable now.
> >>>>
> >>> Will merge, but... since I'm something of a pain, I'm still pondering
> >>> whether rtutils is our best shot for picking up a name here. We already
> >>> have src/utils, so we would add src/librtutils as yet another set of
> >>> utilities; I'm not sure both belong to the same class of helpers.
> >> /me hesitated as well and put the "lib" prefix into the directory name.
> >> So I'm all ears for a better name!
> >>
> > 
> > TssTssTss... _You_ got the brain, _I_ am the cumbersome one.
> 
> But my brain needs some pointers what _you_ would be happy with. Is your
> current problem only related to the clash librtutils vs. utils, or don't
> you like the term "rtutils" at all? If it's the former, would moving
> "utils" to "tools" raise or lower your pain?
> 

I don't like utils and beyond that it clashes with other "utils". I will
try to suggest something a bit less generic than utils/tools.

> > 
> >>>> rtsystrace-v2.patch
> >>>>
> >>>>     Updated proposal to add rt_print-based Xenomai syscall tracing.
> >>>>     Still in early stage, and I'm lacking feedback on this approach, if
> >>>>     it makes sense to pursue it.
> >>>>
> >>> Gasp. I really don't like the idea of having tons of explicit trace
> >>> points spread all over the code, this just makes the task of reading it
> >>> a total nightmare. There are some user-space tracing infrastructure
> >>> already, starting with LTTng, or maybe older ones like Ctrace, with or
> >>> without automatic instrumentation of the source files.
> >>> We may want to get some facts about those before reinventing a square
> >>> wheel.
> >> Let me elaborate about the motivation a bit more: My idea is to have an
> >> rt-safe replacement for strace. The latter is based on ptrace, requires
> >> evil signals, and is far to invasive for tracing high-speed RT
> >> applications IMHO (even if we had that RT-safe). But with low-impact,
> >> per-process rt_printf, we have a pure user space mechanism at hand that
> >> you can quickly set up for a single RT application (using your private
> >> libs e.g.). No need to have an LTTng-prepared kernel, no need to trace
> >> the whole system if you only want to know where your damn applications
> >> now hangs again, no need to disturb other RT users with your debugging
> >> stuff.
> >>
> >> But I agree, the source code impact on the skin libs is far from being
> >> negligible. Maybe we can find a smarter solution, something that just
> >> hooks into the library calls (reminds me of --wrap...) to capture entry
> >> parameters and then the returned values. This will still require some
> >> work (for each instrumented library function), but we might be able to
> >> do this out-of-line.
> > 
> > At some point, I think we should really put some brain cycles into
> > looking into Valgrind, and evaluate the actual cost of adapting it to
> > our needs (for both the existing memory tracker skin, and maybe a trace
> > skin too).
> 
> Valgrind is not a replacement for strace, even if it would work for
> multi-threaded strickly timed RT apps (which I doubt, I _did_ look at it
> already, understood that it requires a complex and temporal invasive VM,

I basically don't care of temporal invasiveness when talking about
detailed tracing features, really. From a strictly personal POV, the
best way to get to temporal non-invasiveness and efficient debugging for
that matter is to strongly decorrelate hardware and software issues.
IOW, I would rather go for simulating the environment by software
models, not trying to be "as non-invasive as possible" with the real
world hardware. Tracing is most often too invasive when it comes to
time-sensitive issues anyway. But that's not the gist of the matter,
anyway, so let's move on.

> and also read their warnings regarding standard pthread support).

The only real problem is that atomic sequences on shared memory between
_processes_ won't work because Valgrind cannot emulate them properly.
Fact is that the vast majority of Xenomai apps are multi-threaded in a
single process space, so this is not even a limitation for most of us.
Being a regular Valgrind user, I never personally hit this problem, even
on significantly large POSIX applications. [Actually, the usual problem
one may run into when tracking, say, memory corruption with Valgrind, is
that large applications often reinvent the wheel, and manage to
reimplement yet-another-my-own-crappy-malloc support which Valgrind does
not know about, and as such cannot monitor].

On the other hand, bringing something like Helgrind which helps
pinpointing thread synchronization issues, would offset the shared
memory issue, by far. The same goes for detecting memory overwrites, use
of uninitialized memory and so on with the default Valgrind skin.

>  This
> is a widely orthogonal issue, so please let us come back to my original
> point.
> 

The original proposal suggests an ad hoc solution for a specific class
of tracing needs (code flow analysis with low temporal invasiveness)
(*).

I suggest that we _also_ take the time to think ahead, about a common
infrastructure which would host the basic, well-supported tools people
need to debug Xenomai applications. It is always possible to work around
temporal invasiveness by simulating external input, there are a few
techniques that work pretty well for that purpose, people working with a
co-design approach are doing that all the time. But before this, it
would be great that the code one relies on does not include silly or
less silly basic coding issues. Valgrind is such a framework defining a
possible infrastructure.

To sum up, I'm going to follow your work on usystrace to see where it
leads us, even if I'm not happy with its potential impact on the code.
Whether it gets eventually merged or not really depends on that aspect.
At the same time, or at least in a reasonable future, we should REALLY
think about making Xenomai Valgrind-compatible, so that we could cover
the rest of the needs for debug tools. This is something I might pick
when my TODO list shortens, if nobody did it before.

(*) You could avoid passing the function name in the systrace calls, by
relying on the value of __FUNCTION__, with a small hack to trimm the
__wrap_ prefix when needed. Making tracepoints less hairy would ease my
pain reading this stuff.

> > 
> >>>> lttng.patch
> >>>>
> >>>>     Very rough patch to make LTTng work with Xenomai again. This patch
> >>>>     tries to follow Jean-Olivier Villemure's original work very closely
> >>>>     to get something working first. Needs more cleanups and enhancements
> >>>>     as I explained earlier in the LTTng announcement.
> >>>>
> >>> Will merge to ease further work on this feature. xenoltt.xml might be
> >>> left in another directory than src/utils, or at least in a separate
> >>> subdir, like can/.
> >> Note that the patch is a big fat construction site (see the earlier
> >> announcement). I'm happy to see your interest, and we should already
> >> discuss details like the location of xenoltt.xml. But I think it's not
> >> yet ready for merge.
> >>
> >> I would like to get the structure right first (multiple probe modules),
> >> and I'm lacking the understanding about what the Xenomai plugin for LTTV
> >> is actually able to do, what kind of trace point formats it needs to
> >> work correctly. Well, this situation can quickly improve once we play a
> >> bit more with it, but resources remain limited.
> >>
> > 
> > The decision is rather simple here: whether our current LTT
> > instrumentation works and is usable with decent LTT releases, and we
> > should keep it, waiting for the new LTTng support to mature out of tree.
> 
> Current LTT support is useless for a fairly long time as we had no LTT
> patches for I-pipe - also for a long time. From this POV, we can happily
> change the code without causing regressions (as long as it builds, of
> course).
> 
> > Or, this is not the case, and we would be better off putting this patch
> > where it has a better chance to be seen and evaluated, i.e. into the
> > development tree. So the basic issue here is that we might have to make
> > the patch you sent working well enough to trigger interest in improving
> > it, unless it does already. What's the situation regarding this?
> > 
> 
> Daniel indicated interest in looking at this, but he is fairly busy for
> the near future. No further feedback so far.
> 
> My suggestion is to keep the patch out-of-tree for now. Everyone
> interested in trying LTTng needs patching anyway (LTTV, ipipe, Xenomai).
> I will keep this patch in my stack and take care that it remains applicable.
> 

Ok, no merge for now.

-- 
Philippe.



