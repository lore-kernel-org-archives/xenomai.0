From: Steven Seeger <steven.seeger@flightsystems.net>
Subject: Re: Dovetail <-> PREEMPT_RT hybridization
Date: Thu, 23 Jul 2020 17:53:37 -0400
Message-ID: <5531288.MhkbZ0Pkbq@omoikane>
In-Reply-To: <8309db4f-3579-4e91-bd36-4da868e5cabc@xenomai.org>
References: <2c2da877-f9e7-9be7-d659-c51235738bc0@xenomai.org>
 <4555996.GXAFRqVoOG@omoikane>
 <8309db4f-3579-4e91-bd36-4da868e5cabc@xenomai.org>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Meng, Fino" <fino.meng@intel.com>, Evl <evl@evlproject.org>, xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

On Thursday, July 23, 2020 12:23:53 PM EDT Philippe Gerum wrote:
> Two misunderstandings it seems:
> 
> - this work is all about evolving Dovetail, not Xenomai. If such work does
> bring the upsides I'm expecting, then I would surely switch EVL to it. In
> parallel, you would still have the opportunity to keep the current Dovetail
> implementation - currently under validation on top of 5.8 - and maintain it
> for Xenomai, once the latter is rebased over the former. You could also
> stick to the I-pipe for Xenomai, so no issue.

That may be my misunderstanding. I thought Dovetail's ultimate goal is at 
least the performance of IPIPE but being simpler to maintain.

> - you seem to be assuming that every code paths of the kernel is
> interruptible with the I-pipe/Dovetail, this is not the case, by far. Some
> keys portions run with hard irqs off, just because there is no other way to
> 1) share some code paths between the regular kernel and the real-time core,
> 2) the hardware may require it (as hinted in my introductory post). Some of
> those sections may take ages under cache pressure (switch_to comes to
> mind), tenths of micro-seconds, happening mostly randomly from the
> standpoint of the external observer (i.e. you, me). So much for quantifying
> timings by design.

So with switch_to having hard irqs off, the cache pressure should be 
deterministic because there's an upper bound on cache lines, the number of 
memory pages that need to be accessed, and the code path is pretty straight 
forward if memory serfves. I would think that this being well bounded should 
serve to my initial point.

> 
> We can only figure out a worst-case value by submitting the system to a
> reckless stress workload, for long enough. This game of sharing the very
> same hardware between GPOS and a RTOS activities has been based on a
> probabilistic approach so far, which can be summarized as: do your best to
> keep the interrupts enabled as long as possible, ensure fine-grained
> preemption of tasks, make sure to give the result hell to detect issues,
> and hope for the hardware not to rain on the parade.

I agree that in practice, a reckless stress workload is necessary to quantify 
system latency. However, relying on this is a problem when it comes time to 
convince managers who want to spend tons of money for expensive and proven OS 
solutions instead of using the fun and cool stuff we do. ;)

At some point, if possible, someone should try and actually prove the system 
given the bounds.

1) There's only so many pages of memory
2) There's only so much cache and so many cache lines
3) There's only so many sources of interrupts
4) There's only so many sources of CPU stalls where those number of stalls 
should have a limit in hardware.

I can't really think of anything else, but I don't know why there'd be any 
sort of randomness on top of this.

One thing we might be not on the same page of is that typically (especially 
single processor systems) when I talk about timing by design calculations I am 
referring to one single high priority thing. That could be a timer interrupt 
to the first instruction running in that timer interrupt handler, or it could 
be to the point where the highest priority thread in the system resumes.

> 
> Back to the initial point: virtualizing the effect of the local_irq helpers
> you refer to is required when their use is front and center in serializing
> kernel activities. However, in a preempt-rt kernel, most interrupt handlers
> are threaded, regular spinlocks are blocking mutexes in disguise, so what
> remains is:

Yes but this depends on a cooperative model. Other drivers can mess you up, as 
described by you below.

> 
> - sections covered by the raw_spin_lock API, which is primarily a problem
> because we would spin with hard irqs off attempting to acquire the lock.
> There is a proven technical solution to this based on a application of
> interrupt pipelining.

Yes.
 
> - few remaining local_irq disabled sections which may run for too long, but
> could be relaxed enough in order for the real-time core to preempt without
> prejudice. This is where pro-actively tracing the kernel under stress comes
> into play.

This is my problem with preempt-rt. Ipipe forces this preemption by changing 
what the macros do that linux devs think is turning interrupts off. We never 
need to worry about this in the RTOS domain.
 
> Working on these three aspects specifically does not bring less guarantees
> than hoping for no assembly code to create long uninterruptible section
> (therefore not covered by local_irq_* helpers), no driver talking to a GPU
> killing latency with CPU stalls, no shared cache architecture causing all
> sort of insane traffic between cache levels, causing memory access speed to
> sink and overall performances to degrade.

I havne't had a chance to work with these sorts of systems but we are doing 
more wuth arm processors with multi-level MMU and I'm very curious about how 
this will affect performance when you're trying to do AMP and RTOS and GPOS on 
the same chip.

> 
> Again, the key issue there is about running two competing workloads on the
> same hardware, GPOS and RTOS. They tend to not get along that much. Each
> time the latter pauses, the former may resume and happily trash some
> hardware sub-system both rely on. So for your calculation to be right, you
> would have not only to involve the RTOS code, but also what the GPOS is up
> to, and how this might change the timings.

That is true. This could possibly be handled with a hypervisor though that 
actually touches the hardware.

> 
> In this respect, no I-pipe - and for that matter no current or future
> Dovetail implementation - can provide any guarantee. In short, I'm pretty
> convinced that any calculation you would try would be wrong by design,
> missing quite a few significant variables in the equation, at least for
> precise timing.

There's only so many ways to break the system, so we just need to make sure we 
find all the variables. ;) I do think what I am saying is true for single 
processor systems, but you have a point for multi.

> However, it is true that relying on native preemption creates more
> opportunities for some hog code to cause havoc in the latency chart because
> of braindamage locking for instance, which may have been solved in a
> serendipitous way with the current I-pipe/Dovetail model, due to the
> systematized virtualization of the local_irq helpers. This said,
> spinlock-wise for preempt-rt, this would only be an issue with rogue code
> contributions explicitly using raw spinlocks mindlessly, which would be yet
> another step toward a nomination of their author for the Darwin awards
> (especially if they get caught by some upstream reviewer on the lkml).

There are people who insist that the system be safe and robust against rogue 
code.

> 
> At this point, there are two options:
> 
> - consider that direct or indirect local_irq* usage is the only factor of
> increased interrupt latency, which is provably wrong.

I would think this to be the largest contributor to it, though.

> 
> - assume that future work aimed at statically detecting misbehaving code
> (rt-wise) in the kernel may succeed, which may be optimistic but at least
> not fundamentally flawed. So I'll go for the optimistic view.

This is a good point. But I think a system where you depend on millions of 
lines of code to be good instead of a a few thousand lines of code is asking 
for trouble.
 
> 
> This task preemption issue is a harder nut to crack, because techniques
> which make the granularity finer may also increase the overall cost induced
> in maintaining the infrastructure (complex priority inheritance for
> mutexes, threaded irq model and sleeping spinlocks which increase the
> context switching rate, preemptible RCU and so on). That cost, which is
> clearly visible in latency analysis, is by design not applicable to tasks
> scheduled by a companion core, with much simpler locking semantics which
> are not shared with the regular kernel. In that sense specifically, I would
> definitely agree that estimating a WCET based on the scheduling behavior of
> Xenomai or EVL is way simpler than mathematizing what might happen in the
> linux kernel.

So in your opinion what is more important? Lowest possible latency on a best-
case or average basis, or determinism? What I mean is the things you mention 
that come with a higher cost in terms of latency come with more determinism 
(less jitter, more predictable result, etc.) So what is the goal you are 
working towards?

I've known you for like 20 years and probably never won an argument, so 
history says I will be headed to defeat here. ;)

Steven




