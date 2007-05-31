From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <465F3277.1080400@domain.hid>
References: <465ABD99.1090301@domain.hid> <1180630376.5020.131.camel@domain.hid>
	<465F3277.1080400@domain.hid>
Content-Type: text/plain
Date: Fri, 01 Jun 2007 00:43:29 +0200
Message-Id: <1180651410.5020.193.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [ANNOUNCE] Xenomai and I-pipe patch	series,
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

On Thu, 2007-05-31 at 22:39 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Mon, 2007-05-28 at 13:31 +0200, Jan Kiszka wrote:
> >> Instead of posting yet another stream of individual patches from my
> >> queue, I decided to put them all into a series and upload them. See
> >>
> >> 	http://www.rts.uni-hannover.de/rtaddon/patches
> >>
> >> for my latest I-pipe, Xenomai, and LTTng enhancements and fixes. Here is
> >> a short overview of the content:
> >>
> > 
> > Note to users: Those patches are all for trunk/v2.4, so don't search for
> > them into the v2.3.x stable branch.
> 
> Of course, I wouldn't dare to shake the stable tree. :)
> 
> ...
> >> fast-tsc-to-ns.patch
> >>
> >>     Integration of my scaled-math-based xnarch_tsc_to_ns service for
> >>     i386 at least. xnarch_ns_to_tsc remains untouched in order to keep
> >>     conversion errors small. clocktest reports no significant precision
> >>     regression here, and both code size and execution speed improved.
> >>
> > 
> > Postponed. I need some feedback from Gilles who wrote the generic
> > support for the funky arithmetics we use.
> 
> Yeah, looking forward. I would also be interested to hear if/what this
> approach may buy us on non-x86 architectures.
> 
> ...
> >> xeno-kill-ipipe_processor_id.patch
> >>     Refreshed cleanup patch to remove ipipe_processor_id completely.
> >>
> > 
> > The logic of this patch is flawed. rthal_processor_id() already implies
> > rawness wrt how we fetch the current CPU number, so
> > rthal_raw_processor_id() is redundant, and xnarch_raw_current_cpu() too
> 
> It isn't when you take a look at the corresponding I-pipe patch as well:
> This enables debug instrumentation of smp_processor_id to validate also
> the atomicity of Xenomai core code /wrt cpuid handling!
> 

Nope, not for archs which do _not_ have a stack-insensitive
smp_processor_id() and get_current() yet (if it's even possible for all
of them, since the in-kernel ABI would likely have to be amended for
reserving the PDA register). Some archs even have stack-insensitive
get_current(), but stack-sensitive current_thread_info(), so we might be
toast in a way or another.

I'm not arguing that the I-pipe changes you suggest have no value in the
2.6.20/x86 context for instance, but since they also affect the generic
code area, they can't work for all our supported configurations right
now. For instance, on an I-pipe setup with a non-heading Xenomai domain
and DEBUG_PREEMPT enabled, a kernel-based Xenomai thread calling
smp_processor_id() from a stalled context (which would be legal) would
_require_ preemption control macros and get_current() to be
stack-insensitive. At that point, we would have some problem propagating
this assumptions to the generic Xenomai core, specifically for the
Blackfin and ARM variants, which do not have stack-insensitive accessors
here.

Also, my point is that we don't want to change the usability of
rthal_processor_id(). So either it does not change with this patch, and
the raw* forms are useless, or it changes, and this is a no-go. Keep in
mind that a number of external modules may rely on this aspect already;
so either we kill rthal_processor_id() completely to force a proper
update in depending code, or we keep the basic assumptions about the
usability context unchanged, but we just cannot make the situation more
fragile for the out of tree code by changing such a fundamental
assumption (i.e. that rthal_processor_id() is context-agnostic).

> > for the same reason. Additionally, xnpod_current_sched() also implies to
> > use a raw accessor to the CPU number, so xnpod_current_raw_sched() is
> > pointless. For this reason, we must be extra-careful about replacing
> > rthal_processor_id() with smp_processor_id(), because 1) we may want to
> > bypass DEBUG_PREEMPT checks sometimes, 2) not all supported archs do
> > have a stack-insensitive smp_processor_id() implementation yet
> > (blackfin, ARM, and Linux/x86 2.4).
> 
> For 1) see ipipe again, but 2), granted, is a problem. Likely the cut is
> too radical and we must leave the infrastructure in place. Still, making
> use of DEBUG_PREEMPT also for Xenomai is IMHO worth some changes that
> will then at least have effect on a subset of archs.

It becomes very useful precisely because ipipe_processor_id() gets
killed.

> 
> > 
> > To answer the inlined question about the need to initialize the ->sched
> > field when setting up a timer, I would say yes, we have to set this up
> > too. It might seem a bit silly, but nothing would prevent a migration
> > call to occur for a just initialized timer, in which case, we would need
> > the sched pointer to reflect the current situation (i.e. at init time).
> 
> But what would be the effect of a wrong sched until the timer is
> started?

panic. See the code flow from xntimer_start_*periodic for instance, up
to the point where the timer is enqueued.

>  Anyway, if you say it does matter, my instrumentation would
> have caught the first bug in Xenomai! That xnpod_raw_current_sched() is
> there because xntimer_init is used in non-atomic contexts (I got
> warnings from DEBUG_PREEMPT).

Thread migration in Xenomai only happens upon request from the migrating
thread itself, so it becomes an issue if the caller belongs to the Linux
domain (i.e. preemption in init_module, the rest is not much
preemptible), in which case the timer might be queued on a different CPU
than the thread's. But since we don't migrate timers upon
sched_setaffinity() requests already, but only upon
xnpod_migrate_thread() calls, this seems a non-issue. We would have an
extra cost for managing a remote timer, but this would work, and above
all, this would be no different from enduring such migration caused by
sched_setaffinity() outside of xntimer_init().

> 
> >> librtutils.patch
> >>
> >>     My original librtprint patch. I now renamed the library to
> >>     librtutils to express that more stuff beyond rt_print may find its
> >>     home here in the future. Hopefully acceptable now.
> >>
> > 
> > Will merge, but... since I'm something of a pain, I'm still pondering
> > whether rtutils is our best shot for picking up a name here. We already
> > have src/utils, so we would add src/librtutils as yet another set of
> > utilities; I'm not sure both belong to the same class of helpers.
> 
> /me hesitated as well and put the "lib" prefix into the directory name.
> So I'm all ears for a better name!
> 

TssTssTss... _You_ got the brain, _I_ am the cumbersome one.

> > 
> >> rtsystrace-v2.patch
> >>
> >>     Updated proposal to add rt_print-based Xenomai syscall tracing.
> >>     Still in early stage, and I'm lacking feedback on this approach, if
> >>     it makes sense to pursue it.
> >>
> > 
> > Gasp. I really don't like the idea of having tons of explicit trace
> > points spread all over the code, this just makes the task of reading it
> > a total nightmare. There are some user-space tracing infrastructure
> > already, starting with LTTng, or maybe older ones like Ctrace, with or
> > without automatic instrumentation of the source files.
> > We may want to get some facts about those before reinventing a square
> > wheel.
> 
> Let me elaborate about the motivation a bit more: My idea is to have an
> rt-safe replacement for strace. The latter is based on ptrace, requires
> evil signals, and is far to invasive for tracing high-speed RT
> applications IMHO (even if we had that RT-safe). But with low-impact,
> per-process rt_printf, we have a pure user space mechanism at hand that
> you can quickly set up for a single RT application (using your private
> libs e.g.). No need to have an LTTng-prepared kernel, no need to trace
> the whole system if you only want to know where your damn applications
> now hangs again, no need to disturb other RT users with your debugging
> stuff.
> 
> But I agree, the source code impact on the skin libs is far from being
> negligible. Maybe we can find a smarter solution, something that just
> hooks into the library calls (reminds me of --wrap...) to capture entry
> parameters and then the returned values. This will still require some
> work (for each instrumented library function), but we might be able to
> do this out-of-line.

At some point, I think we should really put some brain cycles into
looking into Valgrind, and evaluate the actual cost of adapting it to
our needs (for both the existing memory tracker skin, and maybe a trace
skin too).

> 
> > 
> >> lttng.patch
> >>
> >>     Very rough patch to make LTTng work with Xenomai again. This patch
> >>     tries to follow Jean-Olivier Villemure's original work very closely
> >>     to get something working first. Needs more cleanups and enhancements
> >>     as I explained earlier in the LTTng announcement.
> >>
> > 
> > Will merge to ease further work on this feature. xenoltt.xml might be
> > left in another directory than src/utils, or at least in a separate
> > subdir, like can/.
> 
> Note that the patch is a big fat construction site (see the earlier
> announcement). I'm happy to see your interest, and we should already
> discuss details like the location of xenoltt.xml. But I think it's not
> yet ready for merge.
> 
> I would like to get the structure right first (multiple probe modules),
> and I'm lacking the understanding about what the Xenomai plugin for LTTV
> is actually able to do, what kind of trace point formats it needs to
> work correctly. Well, this situation can quickly improve once we play a
> bit more with it, but resources remain limited.
> 

The decision is rather simple here: whether our current LTT
instrumentation works and is usable with decent LTT releases, and we
should keep it, waiting for the new LTTng support to mature. Or, it is
not, and we would be better off putting this patch where it has a better
chance to be seen and evaluated, i.e. into the development tree. So the
basic issue here is that we might have to make the patch you sent
working well enough to trigger interest in improving it, unless it does
already. What's the situation regarding this?

-- 
Philippe.



