MIME-Version: 1.0
In-Reply-To: <1286190175.1702.101.camel@domain.hid>
References: <j2yb88603c31004020058i3aae7947s1428f1b87f4b1097@domain.hid>
	<4BB5B64B.6040803@domain.hid> <4BB5B7C1.4020301@domain.hid>
	<4BB5B874.5090904@domain.hid>
	<k2pb88603c31004020232z28e10d59vc546b1b8803113f2@domain.hid>
	<4BB5BA2D.1080604@domain.hid>
	<245373446233674495BCA5CA2FC1EB17378D015932@domain.hid>
	<4BBAD880.5040603@domain.hid>
	<20100415001912.GB26116@domain.hid>
	<1271322120.2365.605.camel@domain.hid>
	<20100420141227.GB9203@domain.hid>
	<1272020058.9515.753.camel@domain.hid>
	<AANLkTi=0WtJnPrX1GX-Hd+erzABbNPVP=o5zr4-4=p5Q@mail.gmail.com>
	<1286190175.1702.101.camel@domain.hid>
Date: Mon, 4 Oct 2010 15:14:03 +0200
Message-ID: <AANLkTimdhQOP41LQ-OoiezcuxxbRfrw+xxQq79gNULNn@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

Thanks Philippe, Gilles,

Looking forward to this feature!

On Mon, Oct 4, 2010 at 1:02 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On Thu, 2010-09-30 at 14:52 +0200, Henri Roosen wrote:
>> On Fri, Apr 23, 2010 at 12:54 PM, Philippe Gerum <rpm@xenomai.org> wrote=
:
>> > On Tue, 2010-04-20 at 10:12 -0400, Andreas Glatz wrote:
>> >> > > > >> For the time being, you can work around this by issuing a Li=
nux syscall
>> >> > > > >> before entering long processing loops - unless your task doe=
sn't do this
>> >> > > > >> anyway, e.g. to perform some Linux I/O.
>> >> > > > >>
>> >> > > > >
>> >> > > > > I think that's need. Currently the statistics task takes a mu=
tex and waits on a message queue for messages. That's the only time it shou=
ld potentially run in primary mode. After it returns the Mutex it should co=
ntinue running with a policy similar to SCHED_IDLE to give other tasks a ch=
ance to run. I see how switching back to secondary mode could be achieved b=
y issuing a Linux syscall. Is there another way which doesn't involve chang=
ing the source code of our application? (The proper way?)
>> >> > > >
>> >> > > > The proper way would be to not having to change the application=
 code.
>> >> > > > But this workaround (Linux syscall or *_set_mode()) is required=
 until we
>> >> > > > improve the nucleus.
>> >> > >
>> >> > > I generated a patch against 2.4.10.1 to get this behaviour (see f=
urther down). Instead of having
>> >> > > to review and insert a Linux syscall or *_set_mode() in the appli=
cation code I just call
>> >> > > rt_task_set_mode(0, T_IDLE, NULL) at the beginning of the task bo=
dy of the task which
>> >> > > should mostly run in secondary mode under SCHED_IDLE (see example=
 further down). The task
>> >> > > marked with T_IDLE will switch to primary mode at every Xenomai s=
kincall and immediately
>> >> > > switch back to secondary mode once the Xenomai skincall is done.
>> >> > >
>> >> > > We identified just one case where this task has to stay in primar=
y mode. This is between
>> >> > > rt_mutex_aquire() and rt_mutex_release() since it may undergo a p=
riority inversion boost.
>> >> > > If the task stayed in secondary mode during that time it either w=
ould potentally delay the
>> >> > > execution of a high priority task or would kill the system.
>> >> > >
>> >> > > The patch seems to work for us. Our statistics task which blocked=
 the system for a long
>> >> > > time (and made the UI running under Linux unresponsive) is runnin=
g with T_IDLE. If Linux is
>> >> > > heavily loaded now the statistics will get out of sync but the UI=
 will still be responsive.
>> >> > >
>> >> >
>> >> > The logic of this patch looks ok for the native skin, given that 2.=
4.x
>> >> > does not provide a centralized implementation for dealing with excl=
usive
>> >> > resources, like 2.5.x with xnsynch_acquire/release, and always emit=
s a
>> >> > syscall to manage those resources.
>> >> >
>> >> > This said, you could spare the T_IDLE tag by assuming that any non-=
RT
>> >> > shadow thread has to switch back to secondary mode after a syscall,
>> >> > unless the owned resource count is non-zero. This is where we are
>> >> > heading to in 2.5.x, since the preferred mode of operation for such
>> >> > thread has to be fundamentally "relaxed" (otherwise, one would have
>> >> > created a RT thread, right).
>> >> >
>> >> > I'm also unsure you should force SCHED_IDLE, instead of picking
>> >> > SCHED_OTHER for a more general approach to this issue. You can't as=
sume
>> >> > that userland does want to be reniced that way, at least not from t=
he
>> >> > nucleus. But I guess this fits your problem though.
>> >> >
>> >> > To sum up, since we can't really provide a true SCHED_IDLE policy o=
n
>> >> > linux (i.e. not a nice-level hack), and implementing a sched class =
in
>> >> > Xenomai having a lower priority than the existing xnsched_class_idl=
e (in
>> >> > 2.5.x) is not feasible (we could not run any userland task in it
>> >> > anyway), we'd better stick with SCHED_OTHER.
>> >> >
>> >>
>> >> Thanks a lot for the feedback. Your suggestions simplified the patch.=
 I
>> >> also changed SCHED_IDLE to SCHED_OTHER since it might be more benefic=
ial
>> >> for the broader audience. Any other suggestions?
>> >
>> > For an even broader audience, the POSIX skin mutexes should be tracked
>> > as well.
>> >
>> >>
>> >> After applying this patch, a thread with priority 0 will automaticall=
y
>> >> switch back to secondary mode after every (native) skincall unless th=
e
>> >> task holds a mutex (simple and nested).
>> >>
>> >> The benefit is, that the task with priority 0 (which I called a linux
>> >> domain rt thread)
>> >
>> > Actually, no. This is not a rt thread at all, in the sense that you ha=
ve
>> > zero guarantee wrt latency in that case. Such a thread is actually a n=
on
>> > real-time Xenomai shadow thread, meaning that it may invoke Xenomai
>> > services that require the caller to be a Xenomai thread, without
>> > real-time support though.
>> >
>> >> =A0can issue (native) skincalls and share resources with
>> >> high prioritiy task. But it doesn't hold up Linux tasks unless it hol=
ds
>> >> a mutex since it mostly runs in secondary mode and just switches to
>> >> primary mode when needed.
>> >>
>> >> Just one more questions: Philippe said that you have something simila=
r in
>> >> 2.5. How do you enable it there? By setting the correct sheduling pol=
icy?
>> >>
>> >
>> > There are plans to have it. That behavior would be enabled whenever th=
e
>> > linux policy is SCHED_OTHER, and the base priority is 0 Xenomai-wise.
>> > The latter would be enough for now, but it seems more future-proof not
>> > to assume that only SCHED_OTHER tasks could be assigned Xenomai priori=
ty
>> > 0.
>> >
>>
>> Is there any update on the plans to have Xenomai base priority 0
>> threads to be operating by default in relaxed mode? We are using 2.5.4
>> and currently apply the patch below as a workaround. The patch is
>> similar to the 2.4 patch of Andreas in that it actively switches back
>> base prio 0 shadowed threads into relaxed mode, but doesn't take any
>> held locks into account.
>>
>> Please comment on this patch. If there is any preliminary code for
>> 2.5.x available regarding this functionality I'll be happy to test it
>> ;-)
>>
>
> I have blackfin festivity to handle right now, but next in queue is this
> issue.
>
> --
> Philippe.
>
>
>

