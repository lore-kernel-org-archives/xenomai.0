From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTimsAJMuamJsuEZ8p=OOHEt+oSyUzDr7OAsugewh@domain.hid>
References: <AANLkTi=ptfmh+VVBB29cmsg10od0FLdxY=p-yGj3xLFb@domain.hid>
	<1301412534.2109.24.camel@domain.hid> <4D922EF5.8020808@domain.hid>
	<1301426227.2109.35.camel@domain.hid> <4D9230C5.7050007@domain.hid>
	<1301426830.2109.41.camel@domain.hid> <4D923306.60409@domain.hid>
	<1301461081.2092.14.camel@domain.hid>
	<AANLkTim=xKo51rErYUN9+h2MONaAg9BJ5E_dJuRCwYg_@domain.hid>
	<1301472945.2092.21.camel@domain.hid>
	<AANLkTikNq2r+wjC0z+mkczjq8F67ztmXRDBMnHQ4-a9E@mail.gmail.com>
	<AANLkTinAFpi1rAsU-DbgQUPKpEev4215evzRWmYZJzWP@mail.gmail.com>
	<4D948F87.9010109@domain.hid> <4D9494B6.6040304@domain.hid>
	<AANLkTimsAJMuamJsuEZ8p=OOHEt+oSyUzDr7OAsugewh@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 01 Apr 2011 13:20:55 +0200
Message-ID: <1301656855.2155.232.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Priority coupling broken?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2011-04-01 at 11:36 +0200, Henri Roosen wrote:
> On Thu, Mar 31, 2011 at 4:50 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> > Gilles Chanteperdrix wrote:
> >> Henri Roosen wrote:
> >>> Did some more tracing to see why the lower priority thread is
> >>> scheduled before the higher prio thread is ended.
> >>>
> >>> The highest priority task makes a system call and gets relaxed by
> >>> xnshadow_relax. The rpi is pushed here and a Linux call with
> >>> LO_WAKEUP_REQ is scheduled. Then I see the scheduler scheduling to the
> >>> ROOT task. So far so good!
> >>>
> >>> In the Linux domain, we run into the lostage_handler, where the
> >>> scheduled LO_WAKEUP_REQ is executed. Here there is a call to
> >>> xnpod_schedule() which actually causes a switch back to the primary
> >>> domain and the lower priority Xenomai task to be scheduled in, even
> >>> before the wanted process is woken up.
> >>>
> >>> Now, I am unsure what is faulty here and maybe Philippe or someone can
> >>> answer that. Personally I would have expected the xnpod_schedule (or
> >>> xnsched_pick_next) to know about the rpi list and not schedule a lower
> >>> priority task than of any on that list. I was unable to find such
> >>> code.
> >>>
> >>
> >> Unless I am wrong, what happens is whait is intended, at least if we
> >> read the comment:
> >>               case LO_WAKEUP_REQ:
> >>                       /*
> >>                        * We need to downgrade the root thread
> >>                        * priority whenever the APC runs over a
> >>                        * non-shadow, so that the temporary boost we
> >>                        * applied in xnshadow_relax() is not
> >>                        * spuriously inherited by the latter until
> >>                        * the relaxed shadow actually resumes in
> >>                        * secondary mode.
> >>                        */
> >>                       rpi_clear_local(xnshadow_thread(current));
> >>                       xnpod_schedule();
> >>
> >> Which means that we do not want other Linux kernel code than the
> >> real-time thread itself to inherit from this thread priority. Except
> >> that all the code from the switch to root thread to the lostage_handler
> >> (which means any Linux currently preempted critical section) already
> >> inherited the priority.
> >
> > The problem is that calling wake_up_process (a bit below that code) does
> > not guarantee that the next thread scheduled is the shadow running in
> > secondary mode. There may be other Linux threads with higher priorities,
> > and we do not want them to inherit this priority. The idea is that if
> > the next process scheduled is indeed the real-time shadow running in
> > secondary mode, the RPI will be applied in do_schedule_event. But of
> > course, this leaves a window for another real-time thread to preempt. At
> > least it is the way I would understand this, but I am not sure I
> > understand RPI all that well, so, I will shut up and let Philippe answer.
> >
> > --
> >                                            Gilles.
> >
> 
> Thanks Gilles for your input. This Priority Coupling stuff is a little
> complex and input about the corner cases is always welcome and
> helpful!
> 
> I did a little more tests with xnpod_schedule() commented out on
> LO_WAKEUP_REQ. Scheduling shows as expected to me: the lower and level
> primary tasks don't interrupt the migrated thread while higher
> priority tasks do interrupt that task. I have not seen any deadlocks
> yet or ran into corner cases, but of course I don't know all.
> 
> Now, looking back in the history of shadow.c I see that
> xnpod_schedule() was introduced when the xnsched_renice_root() was
> introduced, which is now part of rpi_clear_local. In my point of view,
> the xnpod_schedule() call is only needed when the
> xnsched_renice_root() has been done, so should be moved inside the if
> of rpi_clear_local. But again, it is my point of view and don't know
> all the corner cases.
> 

Correct, but the extraneous xnpod_schedule() in case no de-boost took
place is a minor point. If the scheduler state did not change (no
de-boost), then it will lead to a cheap nop (only a bitop test). If it
has changed, it must be applied right after, because you just don't want
the reality to contradict what your scheduler state says.

Besides, if any interrupt is taken after rpi_clear_local(), the
rescheduling procedure will be called on the interrupt return path,
enforcing the new state anyway. So delaying the call to xnpod_schedule()
is not an option in any case.

> In our case the scheduled task after the switch to secondary is
> actually mostly the IDLE task, thus calling the xnsched_renice_root
> and xnpod_schedule() for doing exactly that what is in the comment. So
> my main question remains: is the call to xnpod_schedule really needed
> here after xnsched_renice_root()? And if so, why doesn't the
> xnpod_schedule not take the priorities on the rpi list into account?

No, xnpod_schedule() does what RPI wants already, and RPI wants a
temporary de-boosting of the root thread to avoid a really bad priority
inversion between the rt and non-rt domains, without affecting the RPI
settings permanently, which shall be applied anew as soon as they stop
causing a rt vs non-rt priority inversion.

Step back, and reconsider the logic:

1- RPI says "linux should be boosted when a shadow is migrated to
secondary mode, to avoid priority inversion between two xenomai threads
running in different domains".
2- xenomai says "linux should not be allowed to benefit from a boosted
priority unless it is actually running one of my relaxed threads, to
avoid priority inversion between rt and non-rt activity"
3- linux says "I do apply my own scheduling logic and priorities"

- xenomai attempts to provide #1 with the RPI scheme
- xenomai enforces #2 with rpi_clear_local().
- wake_up_process() as called by the APC handler enforces #3

Your issue all comes from the fact that #3 may well contradict #1
sometimes. And when a different non-xenomai thread is resumed by linux
prior to the relaxing one, xenomai _has to_ apply rule #2. See Gilles's
explanation for this, it is 100% to the point. If you don't do this, you
could end up with a real-time activity potentially blocked by a non
real-time one for an indefinite amount of time. And that would be much
worse than allowing a temporary priority inversion only affecting a
real-time thread which left the real-time domain willingly.

This is why rule #2 will always have precedence over expectation #1, you
just hit a limitation of the RPI scheme. It is a best effort mechanism,
limited by the fact that we can't tell linux to refrain from applying
its own scheduling rules when running within its own domain -- fair
enough.

Hence my initial comment you may want to read again: maybe the RPI is
broken by design, not in its current implementation which actually does
as much as it can to mitigate conflicts, but cannot always succeed. For
that reason, maybe RPI might even go away in the next xenomai
architecture, if it keeps on misleading people, I'm exactly pondering
that decision (*).

And yes, RPI tends to be really complex. Which makes it suspicious, even
for me now.

(*) Unless I find a way to direct the linux scheduler to the "right"
task in the migration case, but so far, I found none (none that would be
sane, I mean).

> 
> Thanks,
> Henri.

-- 
Philippe.



