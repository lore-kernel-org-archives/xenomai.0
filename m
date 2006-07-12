Message-ID: <b647ffbd0607120744p7bf0860atb9e42d8644fc2d31@domain.hid>
Date: Wed, 12 Jul 2006 16:44:53 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] relax context check for rt_task_suspend
In-Reply-To: <44B4F9CB.2070605@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_90577_14243897.1152715493660"
References: <44B4C09F.209@domain.hid>
	<b647ffbd0607120500jccf65cdqd781ff668f2c7ba8@domain.hid>
	<44B4EA3B.1010109@domain.hid>
	<17588.60439.678980.545437@domain.hid>
	<44B4F9CB.2070605@domain.hid>
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

------=_Part_90577_14243897.1152715493660
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 12/07/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Gilles Chanteperdrix wrote:
> > Jan Kiszka wrote:
> >  >
> >  > -  if (xnpod_unblockable_p()) {
> >  > +  if (xnpod_locked_p()) {
> >
> > Why not if (task == xeno_current_task() && xnpod_unblockable_p()) ?
> >
>
> Is it legal to suspend a foreign task when XNLOCK is set? If yes, I
> would vote for your version as well.



You mean if the current task holds XNLOCK and wanna suspend another task ->
which, in turn, seemingly implies some "scheduling" action?

The only (probably) idea behind XNLOCK is to avoid rescheduling for as long
as the current task (on this scheduler) locks the scheduler.

So it disallows _rescheduling_ but any actions like manipulating e.g. the
list of active tasks should still remain allowed. One may recall
preempt_enable/disable() in Linux.

(ummm... actually, xnpod_thread_mode() doesn't seem to cause re-scheduling
in case of removing the lock as it's done by xnpod_unlock_sched())

Moreover, we have per-cpu schedulers so that a task that locks the scheduler
on cpu0 may still suspend (and cause re-scheduling) of any really running
task on another cpu (or it likely should be so :)

So I don't see any problem here. Sure I don't know all the implementation
details and can be just driven by my own misunderstanding.



Jan
>
>
>
>

-- 
Best regards,
Dmitry Adamushko

------=_Part_90577_14243897.1152715493660
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div><span class="gmail_quote">On 12/07/06, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Gilles Chanteperdrix wrote:<br>&gt; Jan Kiszka wrote:<br>&gt;&nbsp;&nbsp;&gt;<br>&gt;&nbsp;&nbsp;&gt; -&nbsp;&nbsp;if (xnpod_unblockable_p()) {<br>&gt;&nbsp;&nbsp;&gt; +&nbsp;&nbsp;if (xnpod_locked_p()) {<br>&gt;<br>&gt; Why not if (task == xeno_current_task() &amp;&amp; xnpod_unblockable_p()) ?
<br>&gt;<br><br>Is it legal to suspend a foreign task when XNLOCK is set? If yes, I<br>would vote for your version as well.</blockquote><div><br>
<br>
You mean if the current task holds XNLOCK and wanna suspend another
task -&gt; which, in turn, seemingly implies some &quot;scheduling&quot; action?<br>
<br>
The only (probably) idea behind XNLOCK is to avoid rescheduling for as
long as the current task (on this scheduler) locks the scheduler.<br>
<br>
So it disallows _rescheduling_ but any actions like manipulating e.g.
the list of active tasks should still remain allowed. One may recall
preempt_enable/disable() in Linux.<br>
<br>
(ummm... actually, xnpod_thread_mode() doesn't seem to cause
re-scheduling in case of removing the lock as it's done by
xnpod_unlock_sched())<br>
<br>
Moreover, we have per-cpu schedulers so that a task that locks the
scheduler on cpu0 may still suspend (and cause re-scheduling) of any
really running task on another cpu (or it likely should be so :)<br>
<br>
So I don't see any problem here. Sure I don't know all the
implementation details and can be just driven by my own
misunderstanding.<br>
&nbsp;<br>
&nbsp;<br>
<br>
</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Jan<br><br><br><br></blockquote></div><br><br clear="all">-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_90577_14243897.1152715493660--

