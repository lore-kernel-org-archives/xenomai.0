Message-ID: <b647ffbd0601240514m11a11a64u@domain.hid>
Date: Tue, 24 Jan 2006 15:14:52 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [BUG] racy xnshadow_harden under CONFIG_PREEMPT
In-Reply-To: <E1F16LA-0001ku-C4@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_50306_18768656.1138108492258"
References: <43D21144.8040005@domain.hid>
	<b647ffbd0601220010x3cc023an@domain.hid>
	<fd6a47a90601220819n3f4cd382t@domain.hid>
	<E1F16LA-0001ku-C4@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

------=_Part_50306_18768656.1138108492258
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 23/01/06, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>
> Jeroen Van den Keybus wrote:
> > Hello,



> [ skip-skip-skip ]
>


> Since in xnshadow_harden, the running thread marks itself as suspended
> before running wake_up_interruptible_sync, the gatekeeper will run when
> schedule() get called, which in turn, depend on the CONFIG_PREEMPT*
> configuration. In the non-preempt case, the current thread will be
> suspended and the gatekeeper will run when schedule() is explicitely
> called in xnshadow_harden(). In the preempt case, schedule gets called
> when the outermost spinlock is unlocked in wake_up_interruptible_sync().


In fact, no.

wake_up_interruptible_sync() doesn't set the need_resched "flag" up. That's
why it's "sync" actually.

Only if the need_resched was already set before calling
wake_up_interruptible_sync(), then yes.

The secuence is as follows :

wake_up_interruptible_sync ---> wake_up_sync ---> wake_up_common(...,
sync=3D1, ...) ---> ... ---> try_to_wake_up(..., sync=3D1)

Look at the end of  try_to_wake_up() to see when it calls resched_task().
The comment there speaks for itself.

So let's suppose need_resched =3D=3D 0 (it's per-task of course).
As a result of wake_up_interruptible_sync() the new task is added to the
current active run-queue but need_resched remains to be unset in the hope
that the waker will call schedule() on its own soon.

I have CONFIG_PREEMPT set on my machine but I have never encountered a bug
described by Jan.

The catalyst of the problem,  I guess, is  that some IRQ interrupts a task
between wake_up_interruptible_sync() and schedule() and its ISR, in turn,
wakes up another task which prio is higher than the one of our waker (as a
result, the need_resched flag is set). And now, rescheduling occurs on
return from irq handling code (ret_from_intr -> ...-> preempt_irq_schedule(=
)
-> schedule()).

Some events should coincide, yep. But I guess that problem does not occur
every time?

I have not checked it yet but my presupposition that something as easy as :

preempt_disable()

wake_up_interruptible_sync();
schedule();

preempt_enable();


could work... err.. and don't blame me if no, it's some one else who has
written that nonsense :o)

--
Best regards,
Dmitry Adamushko

------=_Part_50306_18768656.1138108492258
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><div><span class=3D"gmail_quote">On 23/01/06, <b class=3D"gmail_sendern=
ame">Gilles Chanteperdrix</b> &lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
poste.net">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span><blockquot=
e class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204);=
 margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Jeroen Van den Keybus wrote:<br> &gt; Hello,</blockquote><div>&nbsp;<br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">[ skip-skip=
-skip ]<br>
</blockquote><div>&nbsp;<br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Since in xn=
shadow_harden, the running thread marks itself as suspended<br>before runni=
ng wake_up_interruptible_sync, the gatekeeper will run when
<br>schedule() get called, which in turn, depend on the CONFIG_PREEMPT*<br>=
configuration. In the non-preempt case, the current thread will be<br>suspe=
nded and the gatekeeper will run when schedule() is explicitely<br>called i=
n xnshadow_harden(). In the preempt case, schedule gets called
<br>when the outermost spinlock is unlocked in wake_up_interruptible_sync()=
.</blockquote><div><br>
In fact, no.<br>
<br>
wake_up_interruptible_sync() doesn't set the need_resched &quot;flag&quot; =
up. That's why it's &quot;sync&quot; actually.<br>
<br>
Only if the need_resched was already set before calling wake_up_interruptib=
le_sync(), then yes.<br>
<br>
The secuence is as follows :<br>
<br>
wake_up_interruptible_sync ---&gt; wake_up_sync ---&gt;
wake_up_common(..., sync=3D1, ...) ---&gt; ... ---&gt;
try_to_wake_up(..., sync=3D1)<br>
<br>
Look at the end of&nbsp; try_to_wake_up() to see when it calls resched_task=
(). The comment there speaks for itself.<br>
<br>
So let's suppose need_resched =3D=3D 0 (it's per-task of course).<br>
As a result of wake_up_interruptible_sync() the new task is added to
the current active run-queue but need_resched remains to be unset in
the hope that the waker will call schedule() on its own soon.<br>
<br>
I have CONFIG_PREEMPT set on my machine but I have never encountered a bug =
described by Jan.<br>
<br>
The catalyst of the problem,&nbsp; I guess, is&nbsp; that some IRQ
interrupts a task between wake_up_interruptible_sync() and schedule()
and its ISR, in turn, wakes up another task which prio is higher than
the one of our waker (as a result, the need_resched flag is set). And
now, rescheduling occurs on return from irq handling code
(ret_from_intr -&gt; ...-&gt; preempt_irq_schedule() -&gt; schedule()).<br>
</div><br>
Some events should coincide, yep. But I guess that problem does not occur e=
very time?<br>
<br>
I have not checked it yet but my presupposition that something as easy as :=
<br>
<br>
preempt_disable() <br>
<br>
wake_up_interruptible_sync();<br>
schedule();<br>
<br>
preempt_enable();<br>
<br>
<br>
could work... err.. and don't blame  me if no, it's some one else who has w=
ritten that nonsense :o)<br clear=3D"all">
</div><br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_50306_18768656.1138108492258--

