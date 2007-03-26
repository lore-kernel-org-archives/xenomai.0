Message-ID: <b647ffbd0703260853r1437d388tfb8b5ed350b8124f@domain.hid>
Date: Mon, 26 Mar 2007 17:53:18 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] Spinlock question.
In-Reply-To: <4607EA58.1070004@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_270255_26501169.1174924398997"
References: <4607E038.8070505@domain.hid> <4607EA58.1070004@domain.hid>
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

------=_Part_270255_26501169.1174924398997
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 26/03/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Gilles Chanteperdrix wrote:
> > Hi,
> >
> > I am porting a network driver from Linux to RTnet, and I have a sudden
> > doubt about what I am doing: is it safe to call a function like
> > wake_up_interruptible, from a non real-time context, with CONFIG_PREEMPT
> > enabled, while holding an rthal spinlock ? Do not I risk a rescheduling
> > with the spinlock locked ?
>
> Mmh, doesn't stalling the primary domain (what rthal_spin_lock_irqsave
> surely does) also make the root domain think it is running in interrupt
> context, thus will prevent any Linux reschedule?


I don't know the PREEMPT_RT code. Although, I do remember I asked Philippe
once and the subject was some code in nucleus/pipe.c

Just read the comments on PREEMPT_RT in xnpipe_wakeup_proc()... Philippe may
comment more on that.


However, there is one big fat issue with this approach:
> wake_up_interruptible takes some Linux spin lock. So you must never call
> it from primary context on UP to avoid corruption. And an SMP, you
> create a nice source for priority inversion: CPU2 holds wait_queue lock,
> gets preempted by Xenomai and runs some longer low-prio RT job.
> Meanwhile CPU1 tries to acquire wait_queue as well with IRQs disabled,
> blocking any RT task on that CPU.


Jan, Gilles is talking about calling this function from non-rt context :o)

"...is it safe to call a function like wake_up_interruptible, from a *non
real-time* context, with CONFIG_PREEMPT"

And for calling it from the real-time context, It's not only about a
spinlock but a list (of pending tasks) as well and, in general, any data
this routine may access and which can be /inconsistent/ at the moment. So
it's a no go.


Better defer the Linux wake-up via a rtdm_nrtsig. Alternatively, make
> the Linux waiter also a Xenomai task and use a rtdm_event e.g. (mmh,
> maybe we should discuss the auto-shadow-any-Linux-task-on-demand feature
> for Xenomai once again...).
>
> Jan
>
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
>
>
>


-- 
Best regards,
Dmitry Adamushko

------=_Part_270255_26501169.1174924398997
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 26/03/07, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Gilles Chanteperdrix wrote:<br>&gt; Hi,<br>&gt;<br>&gt; I am porting a network driver from Linux to RTnet, and I have a sudden<br>&gt; doubt about what I am doing: is it safe to call a function like<br>&gt; wake_up_interruptible, from a non real-time context, with CONFIG_PREEMPT
<br>&gt; enabled, while holding an rthal spinlock ? Do not I risk a rescheduling<br>&gt; with the spinlock locked ?<br><br>Mmh, doesn&#39;t stalling the primary domain (what rthal_spin_lock_irqsave<br>surely does) also make the root domain think it is running in interrupt
<br>context, thus will prevent any Linux reschedule?</blockquote><div><br>
I don&#39;t know the PREEMPT_RT code. Although, I do remember I asked Philippe once and the subject was some code in nucleus/pipe.c<br>
<br>
Just read the comments on PREEMPT_RT in xnpipe_wakeup_proc()... Philippe may comment more on that.<br>
&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">However, there is one big fat issue with this approach:<br>wake_up_interruptible takes some Linux spin lock. So you must never call
<br>it from primary context on UP to avoid corruption. And an SMP, you<br>create a nice source for priority inversion: CPU2 holds wait_queue lock,<br>gets preempted by Xenomai and runs some longer low-prio RT job.<br>Meanwhile CPU1 tries to acquire wait_queue as well with IRQs disabled,
<br>blocking any RT task on that CPU.</blockquote><div><br>
Jan, Gilles is talking about calling this function from non-rt context :o)<br>
<br>
&quot;...is it safe to call a function like wake_up_interruptible, from a *non real-time* context, with CONFIG_PREEMPT&quot;<br>
&nbsp;<br>
And for calling it from the real-time context, It&#39;s not only about a
spinlock but a list (of pending tasks) as well and, in general, any
data this routine may access and which can be /inconsistent/ at the
moment. So it&#39;s a no go.<br>
<br>
</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Better defer the Linux wake-up via a rtdm_nrtsig. Alternatively, make<br>the Linux waiter also a Xenomai task and use a rtdm_event 
e.g. (mmh,<br>maybe we should discuss the auto-shadow-any-Linux-task-on-demand feature<br>for Xenomai once again...).<br><br>Jan<br><br><br>_______________________________________________<br>Xenomai-core mailing list<br><a href="mailto:Xenomai-core@domain.hid">
Xenomai-core@domain.hid</a><br><a href="https://mail.gna.org/listinfo/xenomai-core">https://mail.gna.org/listinfo/xenomai-core</a><br><br><br></blockquote></div><br><br clear="all"><br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_270255_26501169.1174924398997--

