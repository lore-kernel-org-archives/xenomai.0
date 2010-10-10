From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTi=0WtJnPrX1GX-Hd+erzABbNPVP=o5zr4-4=p5Q@mail.gmail.com>
References: <j2yb88603c31004020058i3aae7947s1428f1b87f4b1097@domain.hid>
	<4BB5B64B.6040803@domain.hid> <4BB5B7C1.4020301@domain.hid>
	<4BB5B874.5090904@domain.hid>
	<k2pb88603c31004020232z28e10d59vc546b1b8803113f2@domain.hid>
	<4BB5BA2D.1080604@domain.hid>
	<245373446233674495BCA5CA2FC1EB17378D015932@domain.hid>
	<4BBAD880.5040603@domain.hid> <20100415001912.GB26116@domain.hid>
	<1271322120.2365.605.camel@domain.hid>
	<20100420141227.GB9203@domain.hid>
	<1272020058.9515.753.camel@domain.hid>
	<AANLkTi=0WtJnPrX1GX-Hd+erzABbNPVP=o5zr4-4=p5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 10 Oct 2010 23:17:18 +0200
Message-ID: <1286745438.13186.208.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] New scheduler class
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

On Thu, 2010-09-30 at 14:52 +0200, Henri Roosen wrote:
> On Fri, Apr 23, 2010 at 12:54 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> > On Tue, 2010-04-20 at 10:12 -0400, Andreas Glatz wrote:
> >> > > > >> For the time being, you can work around this by issuing a Linux syscall
> >> > > > >> before entering long processing loops - unless your task doesn't do this
> >> > > > >> anyway, e.g. to perform some Linux I/O.
> >> > > > >>
> >> > > > >
> >> > > > > I think that's need. Currently the statistics task takes a mutex and waits on a message queue for messages. That's the only time it should potentially run in primary mode. After it returns the Mutex it should continue running with a policy similar to SCHED_IDLE to give other tasks a chance to run. I see how switching back to secondary mode could be achieved by issuing a Linux syscall. Is there another way which doesn't involve changing the source code of our application? (The proper way?)
> >> > > >
> >> > > > The proper way would be to not having to change the application code.
> >> > > > But this workaround (Linux syscall or *_set_mode()) is required until we
> >> > > > improve the nucleus.
> >> > >
> >> > > I generated a patch against 2.4.10.1 to get this behaviour (see further down). Instead of having
> >> > > to review and insert a Linux syscall or *_set_mode() in the application code I just call
> >> > > rt_task_set_mode(0, T_IDLE, NULL) at the beginning of the task body of the task which
> >> > > should mostly run in secondary mode under SCHED_IDLE (see example further down). The task
> >> > > marked with T_IDLE will switch to primary mode at every Xenomai skincall and immediately
> >> > > switch back to secondary mode once the Xenomai skincall is done.
> >> > >
> >> > > We identified just one case where this task has to stay in primary mode. This is between
> >> > > rt_mutex_aquire() and rt_mutex_release() since it may undergo a priority inversion boost.
> >> > > If the task stayed in secondary mode during that time it either would potentally delay the
> >> > > execution of a high priority task or would kill the system.
> >> > >
> >> > > The patch seems to work for us. Our statistics task which blocked the system for a long
> >> > > time (and made the UI running under Linux unresponsive) is running with T_IDLE. If Linux is
> >> > > heavily loaded now the statistics will get out of sync but the UI will still be responsive.
> >> > >
> >> >
> >> > The logic of this patch looks ok for the native skin, given that 2.4.x
> >> > does not provide a centralized implementation for dealing with exclusive
> >> > resources, like 2.5.x with xnsynch_acquire/release, and always emits a
> >> > syscall to manage those resources.
> >> >
> >> > This said, you could spare the T_IDLE tag by assuming that any non-RT
> >> > shadow thread has to switch back to secondary mode after a syscall,
> >> > unless the owned resource count is non-zero. This is where we are
> >> > heading to in 2.5.x, since the preferred mode of operation for such
> >> > thread has to be fundamentally "relaxed" (otherwise, one would have
> >> > created a RT thread, right).
> >> >
> >> > I'm also unsure you should force SCHED_IDLE, instead of picking
> >> > SCHED_OTHER for a more general approach to this issue. You can't assume
> >> > that userland does want to be reniced that way, at least not from the
> >> > nucleus. But I guess this fits your problem though.
> >> >
> >> > To sum up, since we can't really provide a true SCHED_IDLE policy on
> >> > linux (i.e. not a nice-level hack), and implementing a sched class in
> >> > Xenomai having a lower priority than the existing xnsched_class_idle (in
> >> > 2.5.x) is not feasible (we could not run any userland task in it
> >> > anyway), we'd better stick with SCHED_OTHER.
> >> >
> >>
> >> Thanks a lot for the feedback. Your suggestions simplified the patch. I
> >> also changed SCHED_IDLE to SCHED_OTHER since it might be more beneficial
> >> for the broader audience. Any other suggestions?
> >
> > For an even broader audience, the POSIX skin mutexes should be tracked
> > as well.
> >
> >>
> >> After applying this patch, a thread with priority 0 will automatically
> >> switch back to secondary mode after every (native) skincall unless the
> >> task holds a mutex (simple and nested).
> >>
> >> The benefit is, that the task with priority 0 (which I called a linux
> >> domain rt thread)
> >
> > Actually, no. This is not a rt thread at all, in the sense that you have
> > zero guarantee wrt latency in that case. Such a thread is actually a non
> > real-time Xenomai shadow thread, meaning that it may invoke Xenomai
> > services that require the caller to be a Xenomai thread, without
> > real-time support though.
> >
> >>  can issue (native) skincalls and share resources with
> >> high prioritiy task. But it doesn't hold up Linux tasks unless it holds
> >> a mutex since it mostly runs in secondary mode and just switches to
> >> primary mode when needed.
> >>
> >> Just one more questions: Philippe said that you have something similar in
> >> 2.5. How do you enable it there? By setting the correct sheduling policy?
> >>
> >
> > There are plans to have it. That behavior would be enabled whenever the
> > linux policy is SCHED_OTHER, and the base priority is 0 Xenomai-wise.
> > The latter would be enough for now, but it seems more future-proof not
> > to assume that only SCHED_OTHER tasks could be assigned Xenomai priority
> > 0.
> >
> 
> Is there any update on the plans to have Xenomai base priority 0
> threads to be operating by default in relaxed mode? We are using 2.5.4
> and currently apply the patch below as a workaround. The patch is
> similar to the 2.4 patch of Andreas in that it actively switches back
> base prio 0 shadowed threads into relaxed mode, but doesn't take any
> held locks into account.
> 
> Please comment on this patch. If there is any preliminary code for
> 2.5.x available regarding this functionality I'll be happy to test it
> ;-)

The auto-relax feature is now available from -head (upcoming 2.6.x). You
will need all commits from
http://git.xenomai.org/?p=xenomai-head.git;a=commit;h=b75cec19387e561f82ac55595db8c993b049f071
to
http://git.xenomai.org/?p=xenomai-head.git;a=commit;h=6653a9e8eb7339b749989bd74adc3ac3bd29e4da

-- 
Philippe.



