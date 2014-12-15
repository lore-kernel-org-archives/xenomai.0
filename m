Date: Mon, 15 Dec 2014 16:19:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141215151954.GN11058@hermes.click-hack.org>
References: <20141211160616.GA27793@hermes.click-hack.org>
 <e8d20d65a12c4549a2a1737501ea48dc@EX132MBOX1A.de2.local>
 <20141211163807.GD27793@hermes.click-hack.org>
 <609e4e03a401411fa6bc14de1ad4d3a5@EX132MBOX1A.de2.local>
 <ea7b0e38bbc54fb693aa93e0acd4cb22@EX132MBOX1A.de2.local>
 <54d4a4e8070b4811bfa13471cce38745@EX132MBOX1A.de2.local>
 <20141215132315.GK11058@hermes.click-hack.org>
 <40a594c20ef2443e9f61bbf12885a3c2@EX132MBOX1A.de2.local>
 <20141215142021.GL11058@hermes.click-hack.org>
 <80c7a5eb4be9451eb0f847a58ee91c27@EX132MBOX1A.de2.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80c7a5eb4be9451eb0f847a58ee91c27@EX132MBOX1A.de2.local>
Subject: Re: [Xenomai] Sleeping function called from invalid context
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Stoidner, Christoph" <c.stoidner@arvero.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Dec 15, 2014 at 03:11:45PM +0000, Stoidner, Christoph wrote:
> 
> >> >> > it seems to me as APC interrupts on ipipe got lost. I have added two counters:
> >> >> > One increments in schedule_linux_call() when a request for a specific application
> >> >> > task is queued. Another one is incremented in lostage_handler() when the
> >> >> > specific task was waked up. When I output the counter's values after tasks have
> >> >> > freezed the counter of lostage_handler is exactly one value less than
> >> >> > schedule_linux_call's counter.
> >> >> >
> >> >> > And then, when I wake-up APC thread manually all freezed tasks continue for a
> >> >> > moment, until all are freezing again.
> >> >>
> >> >> As said above waking APC thread using
> >> >>
> >> >>   wake_up_process(rthal_apc_servers[smp_processor_id()]);
> >> >>
> >> >> does reactivate all Xenomai threads for scheduling. Incontrast using
> >> >>
> >> >>   rthal_apc_schedule(lostage_apc);
> >> >>
> >> >> does not help. So it seems as APC interrupt is pending but won't be  executed.
> >> >>
> >> >> Any idea?
> >> >
> >> > Do you have the same issue if you run a kernel patched with Xenomai
> >> > and without the PREEMPT_RT patch?
> >>
> >> No, without PREEMPT_RT the problem did not yet occur.
> >
> > Have you tried to follow the path from rthal_apc_schedule to
> > rthal_apc_handler to see where the notification gets lost?
> 
> I am about to do that. Unfortunately I am not very familiar with ipipe
> implementation. Do you know if there are some tracing or debug 
> features that could help me here?

The APC code mostly happens in ksrc/arch/generic/hal.c and the
PREEMPT_RT path is distinct from the non PREEMPT_RT one, so, I would
tend to believe that the problem is in that code. As for tracing,
same as usual, you can  use the I-pipe tracer, injecting some calls
to ipipe_trace_special() perhaps, to save some values in the trace.

-- 
					    Gilles.

