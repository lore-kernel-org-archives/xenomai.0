Message-ID: <b647ffbd0601220010x3cc023an@domain.hid>
Date: Sun, 22 Jan 2006 10:10:23 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [BUG] racy xnshadow_harden under CONFIG_PREEMPT
In-Reply-To: <43D21144.8040005@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_24224_12183979.1137917423605"
References: <43D21144.8040005@domain.hid>
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

------=_Part_24224_12183979.1137917423605
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> Hi,
>
> well, if I'm not totally wrong, we have a design problem in the
> RT-thread hardening path. I dug into the crash Jeroen reported > and I'm
> quite sure that this is the reason.
>
> So that's the bad news. The good one is that we can at least
> work around
> it by switching off CONFIG_PREEMPT for Linux (this implicitly means that
> it's a 2.6-only issue).
>
>
> But let's start with two assumptions my further analysis is
> based on:
>
> [Xenomai]
>  o Shadow threads have only one stack, i.e. one context. If the
>   real-time part is active (this includes it is blocked on some
> xnsynch object or delayed), the original Linux task must
> NEVER EVER be
>   executed, even if it will immediately fall asleep again. That's
>   because the stack is in use by the real-time part at that time. > And
this condition is checked in do_schedule_event() [1].
>
> [Linux]
>  o A Linux task which has called
> set_current_state(<blocking_bit>) will
>  remain in the run-queue as long as it calls schedule() on its
> own.

Yes, you are right.

Let's keep in mind the following piece of code.

[*]

[code]    from sched.c::schedule()
...
    switch_count =3D &prev->nivcsw;
    if (prev->state && !(preempt_count() & PREEMPT_ACTIVE)) {    <--- MUST
BE TRUE FOR A TASK TO BE REMOVED
        switch_count =3D &prev->nvcsw;
        if (unlikely((prev->state & TASK_INTERRUPTIBLE) &&
                unlikely(signal_pending(prev))))
            prev->state =3D TASK_RUNNING;
        else {
            if (prev->state =3D=3D TASK_UNINTERRUPTIBLE)
                rq->nr_uninterruptible++;
            deactivate_task(prev, rq);            <--- removing from the
active queue
        }
    }
...
[/code]

On executing schedule(), a "current" (prev =3D current) task is not removed
from the active queue in one of the following cases:

[1] prev->state =3D=3D 0, i.e. =3D=3D TASK_RUNNING (since #define TASK_RUNN=
ING  0);

[2] add_preempt_count(PREEMPT_ACTIVE) has been called before calling
schedule() from the task's context
    i.e. from the context of the "current" task (prev =3D current in
schedule());

[3] there is a pending signal for the "current" task.

Keeping that in mind too, let's take a look at what happens in your
"crash"-scenario.

> ...
>
> 3) Interruption by some Linux IRQ. This may cause other
> threads to become runnable as well, but the gatekeeper has
> the highest prio and will therefore be the next. The problem is
> that the rescheduling on Linux IRQ exit will PREEMPT our task > in
xnshadow_harden(), it will NOT remove it from the Linux
> run-queue.

Right. But what actually happens is the following sequence of calls:

ret_from_intr ---> resume_kernel ---> need_resched --->
sched.c::preempt_schedule_irq() ---> schedule()        (**)

As a result, schedule() is called indeed but it does not execute the [*]
code -
the "current" task is not removed from the active queue.
The reason is [2] (from the list above) and that's done in
preempt_schedule_irq().

> And now we are in real troubles: The
> gatekeeper will kick off our RT part which will take over the
> thread's stack. As soon as the RT domain falls asleep and
> Linux takes over again, it will continue our non-RT part as well! >
Actually, this seems to be the reason for the panic in
> do_schedule_event(). Without CONFIG_XENO_OPT_DEBUG
> and this check, we will run both parts AT THE SAME
> TIME now, thus violating my first assumption. The system gets > fatally
corrupted.
>
> Well, I would be happy if someone can prove me wrong here.

I'm afraid you are right.


> The problem is that I don't see a solution because Linux does
> not provide an atomic wake-up + schedule-out under
> CONFIG_PREEMPT. I'm
> currently considering a hack to remove the migrating Linux
> thread manually from the run-queue, but this could easily break > the
Linux scheduler.

I have a "stupid" idea on top of my head but I'd prefer to test it on my ow=
n
first so not to look as a complete idiot if it's totally wrong. Err... it's
difficult to look more an idiot than I'm already? :o)


> Jan

--
Best regards,
Dmitry Adamushko

------=_Part_24224_12183979.1137917423605
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

&gt; Hi,<br>
&gt; <br>
&gt; well, if I'm not totally wrong, we have a design problem in the<br>
&gt; RT-thread hardening path. I dug into the crash Jeroen reported &gt; an=
d I'm<br>
&gt; quite sure that this is the reason.<br>
&gt; <br>
&gt; So that's the bad news. The good one is that we can at least <br>
&gt; work around<br>
&gt; it by switching off CONFIG_PREEMPT for Linux (this implicitly means th=
at<br>
&gt; it's a 2.6-only issue).<br>
&gt; <br>
&gt; <br>
&gt; But let's start with two assumptions my further analysis is <br>
&gt; based on:<br>
&gt; <br>
&gt; [Xenomai]<br>
&gt;&nbsp; o Shadow threads have only one stack, i.e. one context. If the<b=
r>
&gt;&nbsp;&nbsp; real-time part is active (this includes it is blocked on s=
ome <br>
&gt; xnsynch object or delayed), the original Linux task must <br>
&gt; NEVER EVER be<br>
&gt;&nbsp;&nbsp; executed, even if it will immediately fall asleep again. T=
hat's<br>
&gt;&nbsp;&nbsp; because the stack is in use by the real-time part at
that time. &gt; And this condition is checked in do_schedule_event()
[1].<br>
&gt; <br>
&gt; [Linux]<br>
&gt;&nbsp; o A Linux task which has called <br>
&gt; set_current_state(&lt;blocking_bit&gt;) will<br>
&gt;&nbsp; remain in the run-queue as long as it calls schedule() on its <b=
r>
&gt; own.<br>
<br>
Yes, you are right.<br>
<br>
Let's keep in mind the following piece of code.<br>
<br>
[*]<br>
<br>
[code]&nbsp;&nbsp;&nbsp; from sched.c::schedule()<br>
...<br>
&nbsp;&nbsp;&nbsp; switch_count =3D &amp;prev-&gt;nivcsw;<br>
&nbsp;&nbsp;&nbsp; if (prev-&gt;state &amp;&amp; !(preempt_count()
&amp; PREEMPT_ACTIVE)) {&nbsp;&nbsp;&nbsp; &lt;--- MUST BE TRUE FOR A
TASK TO BE REMOVED<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; switch_count =3D &amp;prev-&gt;nvcsw;=
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (unlikely((prev-&gt;state &amp; TA=
SK_INTERRUPTIBLE) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 unlikely(signal_pending(prev))))<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; prev-&gt;state =3D=
 TASK_RUNNING;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; else {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (prev-&gt;state=
 =3D=3D TASK_UNINTERRUPTIBLE)<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 rq-&gt;nr_uninterruptible++;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
deactivate_task(prev, rq);&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp; &lt;--- removing from the active queue<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; }<br>
...<br>
[/code]<br>
<br>
On executing schedule(), a &quot;current&quot; (prev =3D current) task is n=
ot removed from the active queue in one of the following cases:<br>
<br>
[1] prev-&gt;state =3D=3D 0, i.e. =3D=3D TASK_RUNNING (since #define TASK_R=
UNNING&nbsp; 0);<br>
<br>
[2] add_preempt_count(PREEMPT_ACTIVE) has been called before calling schedu=
le() from the task's context<br>
&nbsp;&nbsp;&nbsp; i.e. from the context of the &quot;current&quot; task (p=
rev =3D current in schedule());<br>
<br>
[3] there is a pending signal for the &quot;current&quot; task.<br>
<br>
Keeping that in mind too, let's take a look at what happens in your &quot;c=
rash&quot;-scenario.<br>
<br>
&gt; ...<br>
&gt;<br>
&gt; 3) Interruption by some Linux IRQ. This may cause other <br>
&gt; threads to become runnable as well, but the gatekeeper has <br>
&gt; the highest prio and will therefore be the next. The problem is <br>
&gt; that the rescheduling on Linux IRQ exit will PREEMPT our task &gt;
in xnshadow_harden(), it will NOT remove it from the Linux <br>
&gt; run-queue.<br>
<br>
Right. But what actually happens is the following sequence of calls:<br>
<br>
ret_from_intr ---&gt; resume_kernel ---&gt; need_resched ---&gt;
sched.c::preempt_schedule_irq() ---&gt; schedule()&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp; (**)<br>
<br>
As a result, schedule() is called indeed but it does not execute the [*] co=
de -<br>
the &quot;current&quot; task is not removed from the active queue.<br>
The reason is [2] (from the list above) and that's done in preempt_schedule=
_irq().<br>
<br>
&gt; And now we are in real troubles: The<br>
&gt; gatekeeper will kick off our RT part which will take over the <br>
&gt; thread's stack. As soon as the RT domain falls asleep and <br>
&gt; Linux takes over again, it will continue our non-RT part as well!
&gt; Actually, this seems to be the reason for the panic in <br>
&gt; do_schedule_event(). Without CONFIG_XENO_OPT_DEBUG <br>
&gt; and this check, we will run both parts AT THE SAME<br>
&gt; TIME now, thus violating my first assumption. The system gets &gt; fat=
ally corrupted.<br>
&gt;<br>
&gt; Well, I would be happy if someone can prove me wrong here.<br>
<br>
I'm afraid you are right.<br>
<br>
<br>
&gt; The problem is that I don't see a solution because Linux does <br>
&gt; not provide an atomic wake-up + schedule-out under <br>
&gt; CONFIG_PREEMPT. I'm<br>
&gt; currently considering a hack to remove the migrating Linux <br>
&gt; thread manually from the run-queue, but this could easily break &gt; t=
he Linux scheduler.<br>
<br>
I have a &quot;stupid&quot; idea on top of my head but I'd prefer to test i=
t on
my own first so not to look as a complete idiot if it's totally wrong.
Err... it's difficult to look more an idiot than I'm already? :o)<br>
<br>
<br>
&gt; Jan<br>
<br>
-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_24224_12183979.1137917423605--

