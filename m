From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTi=BQfeyZ-SRP8=+QX-ufwQVd=bjMw_d6bQp3KM0@domain.hid>
References: <AANLkTingRPWqG1SZAaNs4TKeJFXicZWGqmL2A1rT8vrf@domain.hid>
	<1301041270.2079.8.camel@domain.hid>
	<AANLkTikkkj0GTbpG2m8ozy8TjTJ1Yz0CHoU4FEP8dqsS@mail.gmail.com>
	<1301083171.3221.93.camel@domain.hid>
	<AANLkTinANQJYmAi942WcvnGWL4FZFJBo4S6-WxG2obKH@mail.gmail.com>
	<1301086366.3221.105.camel@domain.hid>
	<AANLkTin6ooP_SZpNoTW3+Wb_0GA2U7SotV6LTeH_qOnY@mail.gmail.com>
	<1301460841.2092.10.camel@domain.hid>
	<AANLkTi=BQfeyZ-SRP8=+QX-ufwQVd=bjMw_d6bQp3KM0@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 31 Mar 2011 10:54:37 +0200
Message-ID: <1301561677.2155.57.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Scheduling questions...
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Eric Eric <ericrebates@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2011-03-30 at 14:37 -0400, Eric Eric wrote:
> Thanks Philippe.  I was thinking of avoiding POSIX only because some
> of my colleagues have noticed severe performance hits using non-native
> skins in commercial RTOSs, particularly Integrity.  Would you expect
> POSIX performance to be roughly the same as native?

Unlike most RTOSs, Xenomai provides a set of basic building blocks, all
APIs are built over. Think of it as a LEGO box for people with way too
much free time, toying with real-time API design and implementation.

This means that posix, native, vxworks, psos, vrtx ... whatever
API/emulator built over Xenomai is actually based on the same set of
building blocks, we call this set the "nucleus".

So the only way for a Xenomai API to be significantly "slower" than its
neighbor on the same stack is to have been badly implemented, not
because several APIs were piled up to build it, introducing overhead.  I
suspect this is the issue you had in mind about some POSIX
implementations.

The other reason for not deriving our POSIX implementation from any
so-called "native" API was standard conformance: we just don't know how
to match all POSIX semantics on top of traditional RTOS semantics, given
they are often at odds in significant aspects of their respective
standard.

>   TP is
> interesting, and may work for my applications since we are likely to
> do much of our real-time work in-kernel to get the absolute minimum
> latency possible.
> 
> On a related note, I noticed on page 14 of
> http://retis.sssup.it/~lipari/courses/str09/12.xeno-handout.pdf that
> when Xenomai is in secondary mode, all Linux interrupts are stalled.
> This would seem to imply that doing something like select in a Xenomai
> user-task would be problematic, as we would have wait until Linux goes
> into background mode to unstall Linux interrupts.  Is there any way
> around this?  The slide suggests that this behavior is "to reduce
> latency" although I suspect there may be other motivations.
> 
> Thank you again for helping to answer my questions.  It has been
> extremely helpful as I continue to evaluate Xenomai.
> 
> - Eric
> 
> On Wed, Mar 30, 2011 at 12:54 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> > On Fri, 2011-03-25 at 17:28 -0400, Eric Eric wrote:
> >> Great, I think that clears it up.  Let me just make sure I understand.
> >>  First, setting background priority (I assume you mean
> >> sched_ss_low_priority in pthreads) to -1 will cause a thread to be
> >> unrunnable after exhausting its credit.  Next, if I had say 4 real
> >> time threads, and set them all to get 20mS credit every 100mS, that
> >> would leave 20mS during which Linux would be come runnable due to the
> >> low_priority being -1 for all RT threads, correct?
> >
> > Correct. An even more fine grained control over the scheduling slots
> > could be achieved using the temporal partitioning scheduling class (TP).
> > This one precisely defines usable time windows for threads on each CPU,
> > typical of IMA systems. But there is no userland programming interface
> > for this one, it is currently aimed at supporting skins which would then
> > export the TP feature via their own API to user-space. There is no such
> > skin in the baseline yet.
> >
> >>
> >> So I think I understand how this would work using the POSIX skin, but
> >> I'm planning to do all my work with the native API.  I'm a bit
> >> concerned because it appears things like xnsched_sporadic members are
> >> only manipulated in nucleus and POSIX, not native.  Can I achieve the
> >> goal of ensuring the Linux kernel gets time to run using only the
> >> native API?
> >>
> >
> > Nope. This scheduler interface is only available with the POSIX skin,
> > and there is no plan to extend the native interface for this.
> >
> >> Thanks again.
> >>
> >> - Eric
> >>
> >> On Fri, Mar 25, 2011 at 4:52 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> >> > On Fri, 2011-03-25 at 16:43 -0400, Eric Eric wrote:
> >> >> What I'm really asking about is specifically the "unless" clause at
> >> >> the end of your response.  Assume a high priority RT thread is doing
> >> >> something like while(1) { } and just spinning and eating CPU.  I would
> >> >> like to force the Linux kernel to be scheduled for, say, up to 20mS
> >> >> every 200mS to give it the opportunity to service Linux interrupts
> >> >> even if the high-priority RT task is runnable (ie I want to
> >> >> periodically preempt the RT thread and allow the Linux kernel to run
> >> >> for a limited amount of time).  It looks like SCHED_SPORADIC is a way
> >> >> to do this, I'm just not sure how to apply that to the kernel itself.
> >> >
> >> > Scheduling all threads your create within the SCHED_SPORADIC class, with
> >> > specifying a background priority set to -1 for all of them would do the
> >> > job.
> >> >
> >> >>
> >> >> Thanks,
> >> >>
> >> >> - Eric
> >> >>
> >> >> On Fri, Mar 25, 2011 at 3:59 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> >> >> > On Fri, 2011-03-25 at 15:48 -0400, Eric Eric wrote:
> >> >> >> Roger on the RR/FIFO scheduling question.  Regarding Linux starvation,
> >> >> >> it looks like pthread_setschedparam_ex can be used on a particular
> >> >> >> Linux thread to avoid starvation, however I'm more concerned about the
> >> >> >> Linux kernel itself.  In the example below, I may want the kernel to
> >> >> >> have some time to service interrupts even if an RT task is behaving
> >> >> >> badly.  How could I achieve this?
> >> >> >
> >> >> > As an extension, Xenomai interprets param.low_prio == -1 as "suspend the
> >> >> > thread". So each time the thread exceed its runtime credit, the nucleus
> >> >> > suspends it until it is replenished, instead of merely downgrading its
> >> >> > priority. As a side-effect, Linux becomes runnable again (unless another
> >> >> > -rt thread is requesting the CPU immediately, but you get the point).
> >> >> >
> >> >> >>
> >> >> >> Thanks again for the fast and helpful responses!
> >> >> >>
> >> >> >> - Eric
> >> >> >>
> >> >> >> On Fri, Mar 25, 2011 at 4:21 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> >> >> >> > On Thu, 2011-03-24 at 19:47 -0400, Eric Eric wrote:
> >> >> >> >> Hello, I've been reading through some of the documentation and have a
> >> >> >> >> few questions regarding scheduling:
> >> >> >> >>
> >> >> >> >> - API docs say that rt_task_set_mode can allow a task to undergo
> >> >> >> >> round-robin scheduling.  This seems to imply that we can have an
> >> >> >> >> environment of mixed round-robin and FIFO task scheduling.  Is this
> >> >> >> >> correct?  If so, what is the scheduling relationship between tasks
> >> >> >> >> running in FIFO and RR modes?
> >> >> >> >
> >> >> >> > RR are FIFO threads within the same priority group.
> >> >> >> >
> >> >> >> >>
> >> >> >> >> - I am concerned about Linux starvation.  For example, suppose a
> >> >> >> >> misbehaving RT task spins and burns CPU indefinitely (watchdog
> >> >> >> >> notwithstanding).  I would still like to preempt this task and allow
> >> >> >> >> Linux to run for up to some maximum time (say up to 30mS every 200mS).
> >> >> >> >>  So, if using RR scheduling, is there a way to use rt_task_slice to
> >> >> >> >> allocate time to Linux?  Is there a Linux shadow thread that I can
> >> >> >> >> allocate time to?
> >> >> >> >
> >> >> >> > Xenomai implements sporadic server scheduling. See SCHED_SPORADIC,
> >> >> >> > usable with int pthread_setschedparam_ex().
> >> >> >> >
> >> >> >> >>
> >> >> >> >> Thank you.
> >> >> >> >>
> >> >> >> >> - Eric
> >> >> >> >>
> >> >> >> >> _______________________________________________
> >> >> >> >> Xenomai-help mailing list
> >> >> >> >> Xenomai-help@domain.hid
> >> >> >> >> https://mail.gna.org/listinfo/xenomai-help
> >> >> >> >
> >> >> >> > --
> >> >> >> > Philippe.
> >> >> >> >
> >> >> >> >
> >> >> >> >
> >> >> >
> >> >> > --
> >> >> > Philippe.
> >> >> >
> >> >> >
> >> >> >
> >> >
> >> > --
> >> > Philippe.
> >> >
> >> >
> >> >
> >
> > --
> > Philippe.
> >
> >
> >

-- 
Philippe.



