Message-ID: <5249C08F.20100@xenomai.org>
Date: Mon, 30 Sep 2013 20:18:55 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5249A8D5.4070401@axelsw.it>
In-Reply-To: <5249A8D5.4070401@axelsw.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai smp - how it works
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Roberto Bielli <roberto.bielli@axelsw.it>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/30/2013 06:37 PM, Roberto Bielli wrote:
> Hi,
>
> i would like to know how works in theory xenomai on smp system (with
> local timers, imx6q for example).

When per-cpu timers are available, Xenomai commonly uses them. They are 
usually shared with linux, so Xenomai interposes on the tick management 
code, to grab these timers for dealing with its own timing duties, and 
forwards the required ticks to the regular kernel. We use software-based 
timers for that, aka "host timer" in your IRQ/timer views.

There are two schedulers in a dual kernel Xenomai system, one for linux, 
the other maintained by Xenomai. Each scheduler defines a set of per-cpu 
runqueue to track threads.

> For example linux is always on one cpu and xenomai on other ?

Not necessarily, you may chose cpu affinity for threads depending on 
your requirements. You may also chose to dedicate a set of cpus -mostly- 
to running Xenomai threads using the common linux mechanism, with a 
varying degree of isolation (e.g. isolcpus, cpu sets).

> Or is there a complex algorithm to determine who is in a processor in a
> instance ?

No complex algorithm at all. A Xenomai thread is given a static affinity 
when it emerges, based on the one linux chose when cloning the new task. 
Then the Xenomai app may chose to change that affinity, using the 
relevant API calls (i.e. sched_setaffinity for the POSIX one). Xenomai 
will notice and maintain consistency between schedulers.

At any rate, Xenomai deliberately refrains from doing any dynamic load 
balancing over CPUs, because this is a latency killer (resuming from a 
cold cache, cost of the migration process and so on). If a Xenomai 
thread wants to move to another CPU, it has to request it explicitly.
We don't know how to do CPU migration efficiently wrt latency, so we 
don't do it, and accept dumbness.

> Linux can disturb xenomai more than single processor ?

I'd say only marginally, specifically in cases when the regular kernel 
code traverses a section which deals with a "hard" spinlock, i.e. one 
for which interrupt disabling is not emulated using a software-based PIC 
by the I-pipe, but really enforced by disabling hw interrupts in the CPU 
state. These sections are few and short, required for serializing the 
regular kernel and the Xenomai core, when a re-entry of the same code 
would be unsafe.

There may be SMP-specific interrupts causing additional jitter, but this 
overhead is marginal (unless the PIC management code executed upon 
interrupt is really crappy).

If that section is contented with another processor, the interrupt 
lockout has to be longer than in uniprocessor mode. But again, those 
sections are supposed to be as short as possible.

> Is better (jitter, latency, etc...) xenomai on a multi-core than to
> single core ?

Single core is better latency-wise, because there is no contention on 
CPU-shared resources, cache artifacts are less visible (no cache 
coherence management involved). SMP may even be worse with 
hyperthreading enabled on x86, unless the applications globally know 
what they are doing with respect to balancing the load over the core 
threads, which have to share portions of the cpu's execution resources 
internally.

>
> Thanks a lot
>


-- 
Philippe.

