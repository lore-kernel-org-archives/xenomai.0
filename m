Message-ID: <b647ffbd0601300502y3f33c3cdv@domain.hid>
Date: Mon, 30 Jan 2006 15:02:18 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [BUG] racy xnshadow_harden under CONFIG_PREEMPT
In-Reply-To: <43DDFD03.5030104@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1950_11775726.1138626138069"
References: <43D21144.8040005@domain.hid>
	<b647ffbd0601220010x3cc023an@domain.hid>
	<fd6a47a90601220819n3f4cd382t@domain.hid>
	<E1F16LA-0001ku-C4@domain.hid>
	<b647ffbd0601240514m11a11a64u@domain.hid>
	<43D62B07.3030703@domain.hid>
	<b647ffbd0601300337g2387b9f5w@domain.hid>
	<43DDFD03.5030104@domain.hid>
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

------=_Part_1950_11775726.1138626138069
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 30/01/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Dmitry Adamushko wrote:
> >>> ...
> >
> >> I have not checked it yet but my presupposition that something as easy
> as
> >> :
> >>> preempt_disable()
> >>>
> >>> wake_up_interruptible_sync();
> >>> schedule();
> >>>
> >>> preempt_enable();
> >> It's a no-go: "scheduling while atomic". One of my first attempts to
> >> solve it.
> >
> >
> > My fault. I meant the way preempt_schedule() and preempt_irq_schedule()
> call
> > schedule() while being non-preemptible.
> > To this end, ACTIVE_PREEMPT is set up.
> > The use of preempt_enable/disable() here is wrong.
> >
> >
> > The only way to enter schedule() without being preemptible is via
> >> ACTIVE_PREEMPT. But the effect of that flag should be well-known now.
> >> Kind of Gordian knot. :(
> >
> >
> > Maybe I have missed something so just for my curiosity : what does
> prevent
> > the use of PREEMPT_ACTIVE here?
> > We don't have a "preempted while atomic" message here as it seems to be
> a
> > legal way to call schedule() with that flag being set up.
>
> When PREEMPT_ACTIVE is set, task gets /preempted/ but not removed from
> the run queue - independent of its current status.


Err...  that's exactly the reason I have explained in my first mail for thi=
s
thread :) Blah.. I wish I was smoking something special before so I would
point that as the reason of my forgetfulness.

Actually, we could use PREEMPT_ACTIVE indeed + something else (probably
another flag) to distinguish between a case when PREEMPT_ACTIVE is set by
Linux and another case when it's set by xnshadow_harden().

xnshadow_harden()
{
struct task_struct *this_task =3D current;
...
xnthread_t *thread =3D xnshadow_thread(this_task);

if (!thread)
    return;

...
gk->thread =3D thread;

+ add_preempt_count(PREEMPT_ACTIVE);

// should be checked in schedule()
+ xnthread_set_flags(thread, XNATOMIC_TRANSIT);

set_current_state(TASK_INTERRUPTIBLE);
wake_up_interruptible_sync(&gk->waitq);
+ schedule();

+ sub_preempt_count(PREEMPT_ACTIVE);
...
}

Then, something like the following code should be called from schedule() :

void ipipe_transit_cleanup(struct task_struct *task, runqueue_t *rq)
{
xnthread_t *thread =3D xnshadow_thread(task);

if (!thread)
    return;

if (xnthread_test_flags(thread, XNATOMIC_TRANSIT))
    {
    xnthread_clear_flags(thread, XNATOMIC_TRANSIT);
    deactivate_task(task, rq);
    }
}

-----

schedule.c :
...
    switch_count =3D &prev->nivcsw;
    if (prev->state && !(preempt_count() & PREEMPT_ACTIVE))
switch_count =3D &prev->nvcsw;
        if (unlikely((prev->state & TASK_INTERRUPTIBLE) &&
                unlikely(signal_pending(prev)) ))
            prev->state =3D TASK_RUNNING;
        else {
            if (prev->state =3D=3D TASK_UNINTERRUPTIBLE)
                rq->nr_uninterruptible++;
            deactivate_task(prev, rq);
        }
    }

// removes a task from the active queue if PREEMPT_ACTIVE + //
XNATOMIC_TRANSIT

+ #ifdef CONFIG_IPIPE
+ ipipe_transit_cleanup(prev, rq);
+ #endif /* CONFIG_IPIPE */
...

 Not very gracefully maybe, but could work or am I missing something
important?

--
Best regards,
Dmitry Adamushko

------=_Part_1950_11775726.1138626138069
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><div><span class=3D"gmail_quote">On 30/01/06, <b class=3D"gmail_sendern=
ame">Jan Kiszka</b> &lt;<a href=3D"mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid=
.de</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-=
left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left=
: 1ex;">
Dmitry Adamushko wrote:<br>&gt;&gt;&gt; ...<br>&gt;<br>&gt;&gt; I have not =
checked it yet but my presupposition that something as easy as<br>&gt;&gt; =
:<br>&gt;&gt;&gt; preempt_disable()<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; wake_up=
_interruptible_sync();
<br>&gt;&gt;&gt; schedule();<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; preempt_enable=
();<br>&gt;&gt; It's a no-go: &quot;scheduling while atomic&quot;. One of m=
y first attempts to<br>&gt;&gt; solve it.<br>&gt;<br>&gt;<br>&gt; My fault.=
 I meant the way preempt_schedule() and preempt_irq_schedule() call
<br>&gt; schedule() while being non-preemptible.<br>&gt; To this end, ACTIV=
E_PREEMPT is set up.<br>&gt; The use of preempt_enable/disable() here is wr=
ong.<br>&gt;<br>&gt;<br>&gt; The only way to enter schedule() without being=
 preemptible is via
<br>&gt;&gt; ACTIVE_PREEMPT. But the effect of that flag should be well-kno=
wn now.<br>&gt;&gt; Kind of Gordian knot. :(<br>&gt;<br>&gt;<br>&gt; Maybe =
I have missed something so just for my curiosity : what does prevent<br>
&gt; the use of PREEMPT_ACTIVE here?<br>&gt; We don't have a &quot;preempte=
d while atomic&quot; message here as it seems to be a<br>&gt; legal way to =
call schedule() with that flag being set up.<br><br>When PREEMPT_ACTIVE is =
set, task gets /preempted/ but not removed from
<br>the run queue - independent of its current status.</blockquote><div><br=
>
Err...&nbsp; that's exactly the reason I have explained in my first
mail for this thread :) Blah.. I wish I was smoking something special
before so I would point that as the reason of my forgetfulness.<br>
<br>
Actually, we could use PREEMPT_ACTIVE indeed + something else (probably
another flag) to distinguish between a case when PREEMPT_ACTIVE is set
by Linux and another case when it's set by xnshadow_harden().<br>
<br>
xnshadow_harden()<br>
{<br>
struct task_struct *this_task =3D current;<br>
...<br>
xnthread_t *thread =3D xnshadow_thread(this_task);<br>
<br>
if (!thread)<br>
&nbsp;&nbsp;&nbsp; return;<br>
<br>
...<br>
gk-&gt;thread =3D thread;<br>
<br>
+ add_preempt_count(PREEMPT_ACTIVE);<br>
<br>
// should be checked in schedule()<br>
+ xnthread_set_flags(thread, XNATOMIC_TRANSIT);<br>
<br>
set_current_state(TASK_INTERRUPTIBLE);<br>
wake_up_interruptible_sync(&amp;gk-&gt;waitq);<br>
+ schedule();<br>
<br>
+ sub_preempt_count(PREEMPT_ACTIVE);<br>
...<br>
}<br>
</div><br>
Then, something like the following code should be called from schedule() : =
<br>
<br>
void ipipe_transit_cleanup(struct task_struct *task, runqueue_t *rq)<br>
{<br>
xnthread_t *thread =3D xnshadow_thread(task);<br>
<br>
if (!thread)<br>
&nbsp;&nbsp;&nbsp; return;<br>
<br>
if (xnthread_test_flags(thread, XNATOMIC_TRANSIT))<br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; xnthread_clear_flags(thread, XNATOMIC_TRANSIT);<br>
&nbsp;&nbsp;&nbsp; deactivate_task(task, rq);<br>
&nbsp;&nbsp;&nbsp; }<br>
}<br>
<br>
-----<br>
<br>
schedule.c : <br>
...<br>

&nbsp;&nbsp;&nbsp; switch_count =3D &amp;prev-&gt;nivcsw;<br>

&nbsp;&nbsp;&nbsp; if (prev-&gt;state &amp;&amp; !(preempt_count()
&amp; PREEMPT_ACTIVE)) &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; switch_count =
=3D &amp;prev-&gt;nvcsw;<br>

&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (unlikely((prev-&gt;state &amp; TA=
SK_INTERRUPTIBLE) &amp;&amp;<br>

&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 unlikely(signal_pending(prev))
<div id=3D"mb_4">))<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; prev-&gt;state =3D=
 TASK_RUNNING;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; else {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (prev-&gt;state=
 =3D=3D TASK_UNINTERRUPTIBLE)<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 rq-&gt;nr_uninterruptible++;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
deactivate_task(prev, rq);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; }<br>
<br>
// removes a task from the active queue if PREEMPT_ACTIVE + // XNATOMIC_TRA=
NSIT<br>
<br>
+ #ifdef CONFIG_IPIPE<br>
+ ipipe_transit_cleanup(prev, rq);<br>
+ #endif /* CONFIG_IPIPE */<br>
...<br><br>
</div>
Not very gracefully maybe, but could work or am I missing something importa=
nt?<br>
<br>
-- <br>
</div>Best regards,<br>Dmitry Adamushko<br>
<br>


------=_Part_1950_11775726.1138626138069--

