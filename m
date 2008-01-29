Message-ID: <8b3b30860801290115m197afc80p3ee98cb42bea334f@domain.hid>
Date: Tue, 29 Jan 2008 10:15:30 +0100
From: "Racconico Lambrati" <racconico.lambrati@domain.hid>
In-Reply-To: <2ff1a98a0801230610t366862dbmcb36ff9fb50604c4@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_9921_12301373.1201598130361"
References: <8b3b30860712271756n526daf67yc8e5be203ae5421d@domain.hid>
	<2ff1a98a0712280630t7d524928r2f66355fd0731d67@domain.hid>
	<8b3b30860712301217p6ee4e724lebd1b1c2740d2ebf@domain.hid>
	<2ff1a98a0712310616n58d0a63en4c36e75e5ed2ab53@domain.hid>
	<8b3b30860712310658n4729fc2bo300f01a59b333b06@domain.hid>
	<2ff1a98a0712310704s65b6d7fbv106c7a4bd17d4677@domain.hid>
	<8b3b30860712310723y39bae134o8bcefbd16f582541@domain.hid>
	<2ff1a98a0801230610t366862dbmcb36ff9fb50604c4@domain.hid>
Subject: Re: [Xenomai-help] update from fusion 0.9.1 to xenomai 2.4.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

------=_Part_9921_12301373.1201598130361
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2008/1/23, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>
> On Dec 31, 2007 4:23 PM, Racconico Lambrati
> <racconico.lambrati@domain.hid> wrote:
> >
> >
> >
> >
> > 2007/12/31, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> > > On Dec 31, 2007 3:58 PM, Racconico Lambrati
> > > <racconico.lambrati@domain.hid> wrote:
> > > >
> > > >
> > > > 2007/12/31, Gilles Chanteperdrix < gilles.chanteperdrix@xenomai.org>:
> > > > > On Dec 30, 2007 9:17 PM, Racconico Lambrati
> > > > > <racconico.lambrati@domain.hid> wrote:
> > > > > > I've done some works, and searched in xenomai's native function.
> > > > > >
> > > > > > To replace SysClkConnect I've created a periodic task with
> > priority=90
> > > > that
> > > > > > wait 5ms.
> > > > > > The last operation in a task's cycle is semGive(gServiceSem);
> > > > > > A second task, non periodic, have as first operation of the
> cycle
> > > > > > semTake(gServiceSem,WAIT_FOREVER);
> > > > > > the second task has priority=50
> > > > > >
> > > > > > when the total time for one cycle of task1 and task2 everything
> > seems
> > > > run
> > > > > > properly , when task2 take more then 5ms for do it's cycle
> > > > > > rt_task_wait_period(NULL) return me 146 and not 0, and the time
> for
> > > > task1 is
> > > > > > not respected.
> > > > > >
> > > > > > This sound strange for me, why the scheduler don't switch the
> task
> > in
> > > > > > execution?
> > > > >
> > > > > This looks strange, could you try and reduce your application to a
> > > > > simple example which exhibits the same behaviour ? Maybe you lock
> the
> > > > > scheduler with taskLock/taskUnlock ?
> > > >
> > > > I use the rt_task_set_mode with T_LOCK option in critical section,
> could
> > it
> > > > be the cause of the problem?
> > >
> > > Yes, the aim of T_LOCK is precisely to prevent the scheduler from
> > > switching to another task as long as the bit is armed.
> >
> > But I reset the mask after the critical section...  I'll try
> without  this
> > lock and report the result
>
> I recently noticed something strange in xnpod_schedule which might
> explain this bug: when the T_LOCK bit is set, xnpod_schedule clears
> the rescheduling bit even though it does not reschedule. So, could you
> try, in xnpod_schedule, to replace:
>
> if (xnthread_test_state(runthread, XNLOCK))
>         goto signal_unlock_and_exit;
>
> with:
>
> if (xnthread_test_state(runthread, XNLOCK)) {
>         xnsched_set_resched(sched);
>         goto signal_unlock_and_exit;
> }
>
> --
>                                                Gilles Chanteperdrix
>

I make this change but nothing changed...

The deadlock it seem not connected to rt_task_set_mode because if I remove
it the deadlock is always present.

when the cycle for(i=0;i<=1000;i++)    appo*=1.01;
do more then 100000 cycle came the deadlock...

It's seems that is related to rt_task_wait_period

------=_Part_9921_12301373.1201598130361
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">2008/1/23, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Dec 31, 2007 4:23 PM, Racconico Lambrati<br>&lt;<a href="mailto:racconico.lambrati@domain.hid">racconico.lambrati@domain.hid</a>&gt; wrote:<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt; 2007/12/31, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;:<br>
&gt; &gt; On Dec 31, 2007 3:58 PM, Racconico Lambrati<br>&gt; &gt; &lt;<a href="mailto:racconico.lambrati@domain.hid">racconico.lambrati@domain.hid</a>&gt; wrote:<br>&gt; &gt; &gt;<br>&gt; &gt; &gt;<br>&gt; &gt; &gt; 2007/12/31, Gilles Chanteperdrix &lt; <a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;:<br>
&gt; &gt; &gt; &gt; On Dec 30, 2007 9:17 PM, Racconico Lambrati<br>&gt; &gt; &gt; &gt; &lt;<a href="mailto:racconico.lambrati@domain.hid">racconico.lambrati@domain.hid</a>&gt; wrote:<br>&gt; &gt; &gt; &gt; &gt; I&#39;ve done some works, and searched in xenomai&#39;s native function.<br>
&gt; &gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; &gt; To replace SysClkConnect I&#39;ve created a periodic task with<br>&gt; priority=90<br>&gt; &gt; &gt; that<br>&gt; &gt; &gt; &gt; &gt; wait 5ms.<br>&gt; &gt; &gt; &gt; &gt; The last operation in a task&#39;s cycle is semGive(gServiceSem);<br>
&gt; &gt; &gt; &gt; &gt; A second task, non periodic, have as first operation of the cycle<br>&gt; &gt; &gt; &gt; &gt; semTake(gServiceSem,WAIT_FOREVER);<br>&gt; &gt; &gt; &gt; &gt; the second task has priority=50<br>&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; when the total time for one cycle of task1 and task2 everything<br>&gt; seems<br>&gt; &gt; &gt; run<br>&gt; &gt; &gt; &gt; &gt; properly , when task2 take more then 5ms for do it&#39;s cycle<br>&gt; &gt; &gt; &gt; &gt; rt_task_wait_period(NULL) return me 146 and not 0, and the time for<br>
&gt; &gt; &gt; task1 is<br>&gt; &gt; &gt; &gt; &gt; not respected.<br>&gt; &gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; &gt; This sound strange for me, why the scheduler don&#39;t switch the task<br>&gt; in<br>&gt; &gt; &gt; &gt; &gt; execution?<br>
&gt; &gt; &gt; &gt;<br>&gt; &gt; &gt; &gt; This looks strange, could you try and reduce your application to a<br>&gt; &gt; &gt; &gt; simple example which exhibits the same behaviour ? Maybe you lock the<br>&gt; &gt; &gt; &gt; scheduler with taskLock/taskUnlock ?<br>
&gt; &gt; &gt;<br>&gt; &gt; &gt; I use the rt_task_set_mode with T_LOCK option in critical section, could<br>&gt; it<br>&gt; &gt; &gt; be the cause of the problem?<br>&gt; &gt;<br>&gt; &gt; Yes, the aim of T_LOCK is precisely to prevent the scheduler from<br>
&gt; &gt; switching to another task as long as the bit is armed.<br>&gt;<br>&gt; But I reset the mask after the critical section...&nbsp;&nbsp;I&#39;ll try without&nbsp;&nbsp;this<br>&gt; lock and report the result<br><br>I recently noticed something strange in xnpod_schedule which might<br>
explain this bug: when the T_LOCK bit is set, xnpod_schedule clears<br>the rescheduling bit even though it does not reschedule. So, could you<br>try, in xnpod_schedule, to replace:<br><br>if (xnthread_test_state(runthread, XNLOCK))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto signal_unlock_and_exit;<br><br>with:<br><br>if (xnthread_test_state(runthread, XNLOCK)) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;xnsched_set_resched(sched);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;goto signal_unlock_and_exit;<br>}<br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gilles Chanteperdrix<br>
</blockquote></div><br>I make this change but nothing changed...<br><br>The deadlock it seem not connected to rt_task_set_mode because if I remove it the deadlock is always present.<br><br>when the cycle for(i=0;i&lt;=1000;i++)&nbsp;&nbsp;&nbsp; appo*=1.01;<br>
do more then 100000 cycle came the deadlock...<br><br>It&#39;s seems that is related to rt_task_wait_period<br>

------=_Part_9921_12301373.1201598130361--

