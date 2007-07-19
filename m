From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <469F9CE2.9080603@domain.hid>
References: <469BF43D.1040704@domain.hid> <46973753.6010206@domain.hid>
	<4694ED98.6000000@domain.hid>	<46937E70.10903@domain.hid>
	<469345EB.6060302@domain.hid>
	<22554361.1184054457326.JavaMail.ngmail@domain.hid>
	<2026261.1184070574283.JavaMail.ngmail@domain.hid>
	<1982070.1184078400928.JavaMail.ngmail@domain.hid>
	<4693A702.1010604@domain.hid>
	<913919.1184311634860.JavaMail.ngmail@domain.hid>
	<21969019.1184569651818.JavaMail.ngmail@domain.hid>
	<29054475.1184842736562.JavaMail.ngmail@domain.hid>
	<469F4A98.3080307@domain.hid> <1184847549.28303.46.camel@domain.hid>
	<469F5BA5.1030407@domain.hid> <1184858093.28303.85.camel@domain.hid>
	<469F84B3.6070104@domain.hid> <1184861035.28303.108.camel@domain.hid>
	<469F9CE2.9080603@domain.hid>
Content-Type: text/plain
Date: Thu, 19 Jul 2007 20:24:09 +0200
Message-Id: <1184869450.28303.155.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [Xenomai-help] Sporadic PC freeze after
	rt_task_start
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
Cc: xenomai@xenomai.org

On Thu, 2007-07-19 at 19:18 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Thu, 2007-07-19 at 17:35 +0200, Jan Kiszka wrote:
> >> Philippe Gerum wrote:
> >>> On Thu, 2007-07-19 at 14:40 +0200, Jan Kiszka wrote:
> >>>> Philippe Gerum wrote:
> >>>>>> And when looking at the holders of rpilock, I think one issue could be
> >>>>>> that we hold that lock while calling into xnpod_renice_root [1], ie.
> >>>>>> doing a potential context switch. Was this checked to be save?
> >>>>> xnpod_renice_root() does no reschedule immediately on purpose, we would
> >>>>> never have been able to run any SMP config more than a couple of seconds
> >>>>> otherwise. (See the NOSWITCH bit).
> >>>> OK, then it's not the cause.
> >>>>
> >>>>>> Furthermore, that code path reveals that we take nklock nested into
> >>>>>> rpilock [2]. I haven't found a spot for the other way around (and I hope
> >>>>>> there is none)
> >>>>> xnshadow_start().
> >>>> Nope, that one is not holding nklock. But I found an offender...
> >>> Gasp. xnshadow_renice() kills us too.
> >> Looks like we are approaching mainline "qualities" here - but they have
> >> at least lockdep (and still face nasty races regularly).
> >>
> > 
> > We only have a 2-level locking depth at most, thare barely qualifies for
> > being compared to the situation with mainline. Most often, the more
> > radical the solution, the less relevant it is: simple nesting on very
> > few levels is not bad, bugous nesting sequence is.
> > 
> >> As long as you can't avoid nesting or the inner lock only protects
> >> really, really trivial code (list manipulation etc.), I would say there
> >> is one lock too much... Did I mention that I consider nesting to be
> >> evil? :-> Besides correctness, there is also an increasing worst-case
> >> behaviour issue with each additional nesting level.
> >>
> > 
> > In this case, we do not want the RPI manipulation to affect the
> > worst-case of all other threads by holding the nklock. This is
> > fundamentally a migration-related issue, which is a situation that must
> > not impact all other contexts relying on the nklock. Given this, you
> > need to protect the RPI list and prevent the scheduler data to be
> > altered at the same time, there is no cheap trick to avoid this.
> > 
> > We need to keep the rpilock, otherwise we would have significantly large
> > latency penalties, especially when domain migration are frequent, and
> > yes, we do need RPI, otherwise the sequence for emulated RTOS services
> > would be plain wrong (e.g. task creation).
> 
> If rpilock is known to protect potentially costly code, you _must not_
> hold other locks while taking it. Otherwise, you do not win a dime by
> using two locks, rather make things worse (overhead of taking two locks
> instead of just one).

I guess that by now you already understood that holding such outer lock
is what should not be done, and what should be fixed, right? So let's
focus on the real issue here: holding two locks is not the problem,
holding them in the wrong sequence, is.

>  That all relates to the worst case, of course, the
> one thing we are worried about most.
> 
> In that light, the nesting nklock->rpilock must go away, independently
> of the ordering bug. The other way around might be a different thing,
> though I'm not sure if there is actually so much difference between the
> locks in the worst case.
> 
> What is the actual _combined_ lock holding time in the longest
> nklock/rpilock nesting path?

It is short.

>  Is that one really larger than any other
> pre-existing nklock path?

Yes. Look, could you please assume one second that I did not choose this
implementation randomly? :o)

>  Only in that case, it makes sense to think
> about splitting, though you will still be left with precisely the same
> (rather a few cycles more) CPU-local latency. Is there really no chance
> to split the lock paths?
> 

The answer to your question is into the dynamics of migrating tasks
between domains, and how this relates to the overall dynamics of the
system. Migration needs priority tracking, priority tracking requires
almost the same amount of work than updating the scheduler data. Since
we can reduce the pressure on the nklock during migration which is a
thread-local action additionally involving the root thread, it is _good_
to do so. Even if this costs a few brain cycles more.

> > Ok, the rpilock is local, the nesting level is bearable, let's focus on
> > putting this thingy straight.
> 
> The whole RPI thing, though required for some scenarios, remains ugly
> and error-prone (including worst-case latency issues).
>  I can only
> underline my recommendation to switch off complexity in Xenomai when one
> doesn't need it - which often includes RPI.
>  Sorry, Philippe, but I think
> we have to be honest to the users here. RPI remains problematic, at
> least /wrt your beloved latency.

The best way to be honest to users is to depict things as they are:

1) RPI is there because we currently rely on a co-kernel technology, and
we have to make our best to fix the consequences of having two
schedulers by at least coupling their priority scheme when applicable.
Otherwise, you just _cannot_ emulate common RTOS behaviour properly.
Additionally, albeit disabling RPI is perfectly fine and allows to run
most applications the RTAI way, it is _utterly flawed_ at the logical
level, if you intend to integrate the two kernels. I do understand that
you might not care about such integration, that you might even find it
silly, and this is not even an issue for me. But the whole purpose of
Xenomai has never ever been to reel off the "yet-another-co-kernel"
mantra once again. I -very fundamentally- don't give a dime about
co-kernels per se, what I want is a framework which exhibits real-time
OS behaviours, with deep Linux integration, in order to build skins upon
it, and give users access to the regular programming model, and RPI does
help here. Period.

2) RPI is not perfect, has been rewritten a couple of times already, and
has suffered a handful of severe bugs. Would you throw away any software
only on this basis? I guess not, otherwise you would not run Linux,
especially not in SMP.

3) As time passes, RPI is stabilizing because it is now handled using
the right core logic, albeit it involves tricky situations. Besides, the
RPI bug we have been talking about is nothing compared to the issue
regarding the deletion path I'm currently fixing, which has much large
implications, and is way more rotten. However, we are not going to
prevent people from deleting threads instead in order to solve the bug,
are we?

Let's keep the issue on the plain technical ground:
- is there a bug? You bet there is.
- is the issue fixable? I think so.
- is it worth investing some brain cycles to do so? Yes.

I don't see any reason for getting nervous here.

> 
> Jan
> 
-- 
Philippe.



