Subject: Re: Dovetail <-> PREEMPT_RT hybridization
References: <2c2da877-f9e7-9be7-d659-c51235738bc0@xenomai.org>
 <BYAPR11MB3765087193BDF5EB45094A5DEE780@BYAPR11MB3765.namprd11.prod.outlook.com>
 <b4c53b27-3de9-3264-0a3f-0563f95321ec@xenomai.org>
 <4555996.GXAFRqVoOG@omoikane>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <8309db4f-3579-4e91-bd36-4da868e5cabc@xenomai.org>
Date: Thu, 23 Jul 2020 18:23:53 +0200
MIME-Version: 1.0
In-Reply-To: <4555996.GXAFRqVoOG@omoikane>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steven Seeger <steven.seeger@flightsystems.net>, "Meng, Fino" <fino.meng@intel.com>, Evl <evl@evlproject.org>, xenomai@xenomai.org

On 7/23/20 3:09 PM, Steven Seeger wrote:
> On Tuesday, July 21, 2020 1:18:21 PM EDT Philippe Gerum wrote:
>>
>> - identifying and quantifying the longest interrupt-free sections in the
>> target preempt-rt kernel under meaningful stress load, with the irqoff
>> tracer. I wrote down some information [1] about the stress workloads which
>> actually make a difference when benchmarking as far as I can tell. At any
>> rate, the results we would get there would be crucial in order to figure
>> out where to add the out-of-band synchronization points, and likely of some
>> interest upstream too. I'm primarily targeting armv7 and armv8, it would be
>> great if you could help with x86.
> 
> So from my perspective, one of the beauties of Xenomai with traditional IPIPE 
> is you can analyze the fast interrupt path and see that by design you have an 
> upper bound on latency. You can even calculate it. It's based on the number of 
> cpu cycles at irq entry multiplied by the total numbers of IRQs that could 
> happen at the same time. Depending on your hardware, maybe you know the 
> priority of handling the interrupt in question.
> 
> The point was the system was analyzable by design.
>

Two misunderstandings it seems:

- this work is all about evolving Dovetail, not Xenomai. If such work does
bring the upsides I'm expecting, then I would surely switch EVL to it. In
parallel, you would still have the opportunity to keep the current Dovetail
implementation - currently under validation on top of 5.8 - and maintain it
for Xenomai, once the latter is rebased over the former. You could also stick
to the I-pipe for Xenomai, so no issue.

- you seem to be assuming that every code paths of the kernel is interruptible
with the I-pipe/Dovetail, this is not the case, by far. Some keys portions run
with hard irqs off, just because there is no other way to 1) share some code
paths between the regular kernel and the real-time core, 2) the hardware may
require it (as hinted in my introductory post). Some of those sections may
take ages under cache pressure (switch_to comes to mind), tenths of
micro-seconds, happening mostly randomly from the standpoint of the external
observer (i.e. you, me). So much for quantifying timings by design.

We can only figure out a worst-case value by submitting the system to a
reckless stress workload, for long enough. This game of sharing the very same
hardware between GPOS and a RTOS activities has been based on a probabilistic
approach so far, which can be summarized as: do your best to keep the
interrupts enabled as long as possible, ensure fine-grained preemption of
tasks, make sure to give the result hell to detect issues, and hope for the
hardware not to rain on the parade.

Back to the initial point: virtualizing the effect of the local_irq helpers
you refer to is required when their use is front and center in serializing
kernel activities. However, in a preempt-rt kernel, most interrupt handlers
are threaded, regular spinlocks are blocking mutexes in disguise, so what
remains is:

- sections covered by the raw_spin_lock API, which is primarily a problem
because we would spin with hard irqs off attempting to acquire the lock. There
is a proven technical solution to this based on a application of interrupt
pipelining.

- few remaining local_irq disabled sections which may run for too long, but
could be relaxed enough in order for the real-time core to preempt without
prejudice. This is where pro-actively tracing the kernel under stress comes
into play.

Working on these three aspects specifically does not bring less guarantees
than hoping for no assembly code to create long uninterruptible section
(therefore not covered by local_irq_* helpers), no driver talking to a GPU
killing latency with CPU stalls, no shared cache architecture causing all sort
of insane traffic between cache levels, causing memory access speed to sink
and overall performances to degrade.

Again, the key issue there is about running two competing workloads on the
same hardware, GPOS and RTOS. They tend to not get along that much. Each time
the latter pauses, the former may resume and happily trash some hardware
sub-system both rely on. So for your calculation to be right, you would have
not only to involve the RTOS code, but also what the GPOS is up to, and how
this might change the timings.

In this respect, no I-pipe - and for that matter no current or future Dovetail
implementation - can provide any guarantee. In short, I'm pretty convinced
that any calculation you would try would be wrong by design, missing quite a
few significant variables in the equation, at least for precise timing.

However, it is true that relying on native preemption creates more
opportunities for some hog code to cause havoc in the latency chart because of
braindamage locking for instance, which may have been solved in a
serendipitous way with the current I-pipe/Dovetail model, due to the
systematized virtualization of the local_irq helpers. This said, spinlock-wise
for preempt-rt, this would only be an issue with rogue code contributions
explicitly using raw spinlocks mindlessly, which would be yet another step
toward a nomination of their author for the Darwin awards (especially if they
get caught by some upstream reviewer on the lkml).

At this point, there are two options:

- consider that direct or indirect local_irq* usage is the only factor of
increased interrupt latency, which is provably wrong.

- assume that future work aimed at statically detecting misbehaving code
(rt-wise) in the kernel may succeed, which may be optimistic but at least not
fundamentally flawed. So I'll go for the optimistic view.

> When you start talking about looking for long critical sections and adding 
> sync points in it, I think you take away the by-design guarantees for latency. 
> This might make it less-suitable for hard realtime systems.
> 
> IMHO this is not any better than Preempt-RT. But maybe I am missing something. 
> :)
> 

You may be missing the reasoning behind the alternate scheduling Dovetail
implements, which is a generalization of what the I-pipe and Xenomai do to
schedule tasks regardless of the preemption status of the regular kernel.

IMHO, the issue shouldn't be about decreasing interrupt masking throughout the
kernel, which should be fine-grained enough to only require manual fixups for
addressing the remaining problems - this assumption triggered the idea of a
Dovetail overhaul. The other granularity, the one that still matters today,
relates to task preemption. How snappy can the kernel be made in order to
direct the CPU to running a different task when some urgent event has to be
handled asap. Dovetail still brings the alternate scheduling feature for
expedited tasks preempt-rt has no reason to have, by essence.

This task preemption issue is a harder nut to crack, because techniques which
make the granularity finer may also increase the overall cost induced in
maintaining the infrastructure (complex priority inheritance for mutexes,
threaded irq model and sleeping spinlocks which increase the context switching
rate, preemptible RCU and so on). That cost, which is clearly visible in
latency analysis, is by design not applicable to tasks scheduled by a
companion core, with much simpler locking semantics which are not shared with
the regular kernel. In that sense specifically, I would definitely agree that
estimating a WCET based on the scheduling behavior of Xenomai or EVL is way
simpler than mathematizing what might happen in the linux kernel.

-- 
Philippe.

