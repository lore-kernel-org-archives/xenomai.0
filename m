From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <465ABD99.1090301@domain.hid>
References: <465ABD99.1090301@domain.hid>
Content-Type: text/plain
Date: Thu, 31 May 2007 18:52:56 +0200
Message-Id: <1180630376.5020.131.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [ANNOUNCE] Xenomai and I-pipe patch series,
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

On Mon, 2007-05-28 at 13:31 +0200, Jan Kiszka wrote:
> Instead of posting yet another stream of individual patches from my
> queue, I decided to put them all into a series and upload them. See
> 
> 	http://www.rts.uni-hannover.de/rtaddon/patches
> 
> for my latest I-pipe, Xenomai, and LTTng enhancements and fixes. Here is
> a short overview of the content:
> 

Note to users: Those patches are all for trunk/v2.4, so don't search for
them into the v2.3.x stable branch.

> 
> /xenomai
> --------
> 
> rt-safe-skin-dereference.patch
> 
>     As posted a few days ago: Fixes the usage of module_put over
>     the Xenomai domain.
> 

Merged.

> inline-rt_timer-services.patch
> 
>     Inline trivial rt_timer services of the native skin for kernel
>     usage. Saves object size, micro-optimises their usage.
> 

Merged.

> uninline-tsc-ns.patch
> 
>     Uninlines the huge xnarch_tsc_to_ns and xnarch_ns_to_tsc functions.
>     Specifically on low-end boxes with small caches, this appears to buy
>     us several microseconds worst-case latency. :)
> 

Will merge.

> fast-tsc-to-ns.patch
> 
>     Integration of my scaled-math-based xnarch_tsc_to_ns service for
>     i386 at least. xnarch_ns_to_tsc remains untouched in order to keep
>     conversion errors small. clocktest reports no significant precision
>     regression here, and both code size and execution speed improved.
> 

Postponed. I need some feedback from Gilles who wrote the generic
support for the funky arithmetics we use.

> flatten-timer-irq.patch
> 
>     As posted earlier: Refactor the timer IRQ path.
> 

Merged.

> xntimer-start-in-tick.patch
> 
>     As posted earlier: Only reprogram the hardware timer once per tick.
> 

Merged.

> optimise-periodic-xntimers.patch
> 
>     Simplifies the tests that have to be done in the tick handler in
>     order to decide if an xntimer shall be reloaded by introducing a new
>     timer state XNTIMER_PERIODIC and testing all states at once.
> 

Merged.

> xeno-kill-ipipe_processor_id.patch
>     Refreshed cleanup patch to remove ipipe_processor_id completely.
> 

The logic of this patch is flawed. rthal_processor_id() already implies
rawness wrt how we fetch the current CPU number, so
rthal_raw_processor_id() is redundant, and xnarch_raw_current_cpu() too
for the same reason. Additionally, xnpod_current_sched() also implies to
use a raw accessor to the CPU number, so xnpod_current_raw_sched() is
pointless. For this reason, we must be extra-careful about replacing
rthal_processor_id() with smp_processor_id(), because 1) we may want to
bypass DEBUG_PREEMPT checks sometimes, 2) not all supported archs do
have a stack-insensitive smp_processor_id() implementation yet
(blackfin, ARM, and Linux/x86 2.4).

To answer the inlined question about the need to initialize the ->sched
field when setting up a timer, I would say yes, we have to set this up
too. It might seem a bit silly, but nothing would prevent a migration
call to occur for a just initialized timer, in which case, we would need
the sched pointer to reflect the current situation (i.e. at init time).

> remove-rthal_rwlock.patch
> 
>     Refreshed removal patch for the now unused rthal_rwlocks.
> 

Merged.

> librtutils.patch
> 
>     My original librtprint patch. I now renamed the library to
>     librtutils to express that more stuff beyond rt_print may find its
>     home here in the future. Hopefully acceptable now.
> 

Will merge, but... since I'm something of a pain, I'm still pondering
whether rtutils is our best shot for picking up a name here. We already
have src/utils, so we would add src/librtutils as yet another set of
utilities; I'm not sure both belong to the same class of helpers.

> rtsystrace-v2.patch
> 
>     Updated proposal to add rt_print-based Xenomai syscall tracing.
>     Still in early stage, and I'm lacking feedback on this approach, if
>     it makes sense to pursue it.
> 

Gasp. I really don't like the idea of having tons of explicit trace
points spread all over the code, this just makes the task of reading it
a total nightmare. There are some user-space tracing infrastructure
already, starting with LTTng, or maybe older ones like Ctrace, with or
without automatic instrumentation of the source files.
We may want to get some facts about those before reinventing a square
wheel.

> lttng.patch
> 
>     Very rough patch to make LTTng work with Xenomai again. This patch
>     tries to follow Jean-Olivier Villemure's original work very closely
>     to get something working first. Needs more cleanups and enhancements
>     as I explained earlier in the LTTng announcement.
> 

Will merge to ease further work on this feature. xenoltt.xml might be
left in another directory than src/utils, or at least in a separate
subdir, like can/.

Thanks,

-- 
Philippe.



