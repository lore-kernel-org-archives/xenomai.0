Message-ID: <8b3b30860712310658n4729fc2bo300f01a59b333b06@domain.hid>
Date: Mon, 31 Dec 2007 15:58:54 +0100
From: "Racconico Lambrati" <racconico.lambrati@domain.hid>
In-Reply-To: <2ff1a98a0712310616n58d0a63en4c36e75e5ed2ab53@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_20258_22870773.1199113134457"
References: <8b3b30860712271756n526daf67yc8e5be203ae5421d@domain.hid>
	<2ff1a98a0712280630t7d524928r2f66355fd0731d67@domain.hid>
	<8b3b30860712301217p6ee4e724lebd1b1c2740d2ebf@domain.hid>
	<2ff1a98a0712310616n58d0a63en4c36e75e5ed2ab53@domain.hid>
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

------=_Part_20258_22870773.1199113134457
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2007/12/31, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>
> On Dec 30, 2007 9:17 PM, Racconico Lambrati
> <racconico.lambrati@domain.hid> wrote:
> > I've done some works, and searched in xenomai's native function.
> >
> > To replace SysClkConnect I've created a periodic task with priority=90
> that
> > wait 5ms.
> > The last operation in a task's cycle is semGive(gServiceSem);
> > A second task, non periodic, have as first operation of the cycle
> > semTake(gServiceSem,WAIT_FOREVER);
> > the second task has priority=50
> >
> > when the total time for one cycle of task1 and task2 everything seems
> run
> > properly , when task2 take more then 5ms for do it's cycle
> > rt_task_wait_period(NULL) return me 146 and not 0, and the time for
> task1 is
> > not respected.
> >
> > This sound strange for me, why the scheduler don't switch the task in
> > execution?
>
> This looks strange, could you try and reduce your application to a
> simple example which exhibits the same behaviour ? Maybe you lock the
> scheduler with taskLock/taskUnlock ?


I use the rt_task_set_mode with T_LOCK option in critical section, could it
be the cause of the problem?


> A second question is, if can I change (TaskIdSelf() == IdTask) with
> > (rt_task_self() == &IdTask)?
>
> No, the task id spaces are distinct. You can only use TaskIdSelf in a
> vxworks skin task (created with taskInit or taskSpawn) and
> rt_task_self with a native skin task (created with rt_task_create).
> You can use most native skin services (such as rt_task_set_periodic
> with a NULL task id) in  a vxworks skin task, but vxworks skin
> services expect a vxworks skin task. If I were you, I would use only
> vxworks skin services (for example, watchdog services to make a task
> perdioc).


I changed all the handling of task to native skin, so IdTask now is a
RT_TASK variable.

------=_Part_20258_22870773.1199113134457
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">2007/12/31, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Dec 30, 2007 9:17 PM, Racconico Lambrati<br>&lt;<a href="mailto:racconico.lambrati@domain.hid">racconico.lambrati@domain.hid</a>&gt; wrote:<br>&gt; I&#39;ve done some works, and searched in xenomai&#39;s native function.
<br>&gt;<br>&gt; To replace SysClkConnect I&#39;ve created a periodic task with priority=90 that<br>&gt; wait 5ms.<br>&gt; The last operation in a task&#39;s cycle is semGive(gServiceSem);<br>&gt; A second task, non periodic, have as first operation of the cycle
<br>&gt; semTake(gServiceSem,WAIT_FOREVER);<br>&gt; the second task has priority=50<br>&gt;<br>&gt; when the total time for one cycle of task1 and task2 everything seems run<br>&gt; properly , when task2 take more then 5ms for do it&#39;s cycle
<br>&gt; rt_task_wait_period(NULL) return me 146 and not 0, and the time for task1 is<br>&gt; not respected.<br>&gt;<br>&gt; This sound strange for me, why the scheduler don&#39;t switch the task in<br>&gt; execution?<br>
<br>This looks strange, could you try and reduce your application to a<br>simple example which exhibits the same behaviour ? Maybe you lock the<br>scheduler with taskLock/taskUnlock ?</blockquote><div><br>I use the rt_task_set_mode with T_LOCK option in critical section, could it be the cause of the problem?
<br>&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; A second question is, if can I change (TaskIdSelf() == IdTask) with<br>&gt; (rt_task_self() == &amp;IdTask)?
<br><br>No, the task id spaces are distinct. You can only use TaskIdSelf in a<br>vxworks skin task (created with taskInit or taskSpawn) and<br>rt_task_self with a native skin task (created with rt_task_create).<br>You can use most native skin services (such as rt_task_set_periodic
<br>with a NULL task id) in&nbsp;&nbsp;a vxworks skin task, but vxworks skin<br>services expect a vxworks skin task. If I were you, I would use only<br>vxworks skin services (for example, watchdog services to make a task<br>perdioc).
</blockquote><br>I changed all the handling of task to native skin, so IdTask now is a RT_TASK variable.<br></div>

------=_Part_20258_22870773.1199113134457--

