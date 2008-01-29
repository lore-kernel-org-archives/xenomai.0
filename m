Message-ID: <2ff1a98a0801290705g54e4d98alfc11990d8098e33e@domain.hid>
Date: Tue, 29 Jan 2008 16:05:02 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <8b3b30860801290115m197afc80p3ee98cb42bea334f@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8b3b30860712271756n526daf67yc8e5be203ae5421d@domain.hid>
	<2ff1a98a0712280630t7d524928r2f66355fd0731d67@domain.hid>
	<8b3b30860712301217p6ee4e724lebd1b1c2740d2ebf@domain.hid>
	<2ff1a98a0712310616n58d0a63en4c36e75e5ed2ab53@domain.hid>
	<8b3b30860712310658n4729fc2bo300f01a59b333b06@domain.hid>
	<2ff1a98a0712310704s65b6d7fbv106c7a4bd17d4677@domain.hid>
	<8b3b30860712310723y39bae134o8bcefbd16f582541@domain.hid>
	<2ff1a98a0801230610t366862dbmcb36ff9fb50604c4@domain.hid>
	<8b3b30860801290115m197afc80p3ee98cb42bea334f@domain.hid>
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
To: Racconico Lambrati <racconico.lambrati@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Jan 29, 2008 10:15 AM, Racconico Lambrati
<racconico.lambrati@domain.hid> wrote:
>
>
> 2008/1/23, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>
> > On Dec 31, 2007 4:23 PM, Racconico Lambrati
> > <racconico.lambrati@domain.hid> wrote:
> > >
> > >
> > >
> > >
> > > 2007/12/31, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
> > > > On Dec 31, 2007 3:58 PM, Racconico Lambrati
> > > > <racconico.lambrati@domain.hid> wrote:
> > > > >
> > > > >
> > > > > 2007/12/31, Gilles Chanteperdrix < gilles.chanteperdrix@xenomai.org>:
> > > > > > On Dec 30, 2007 9:17 PM, Racconico Lambrati
> > > > > > <racconico.lambrati@domain.hid> wrote:
> > > > > > > I've done some works, and searched in xenomai's native function.
> > > > > > >
> > > > > > > To replace SysClkConnect I've created a periodic task with
> > > priority=90
> > > > > that
> > > > > > > wait 5ms.
> > > > > > > The last operation in a task's cycle is semGive(gServiceSem);
> > > > > > > A second task, non periodic, have as first operation of the
> cycle
> > > > > > > semTake(gServiceSem,WAIT_FOREVER);
> > > > > > > the second task has priority=50
> > > > > > >
> > > > > > > when the total time for one cycle of task1 and task2 everything
> > > seems
> > > > > run
> > > > > > > properly , when task2 take more then 5ms for do it's cycle
> > > > > > > rt_task_wait_period(NULL) return me 146 and not 0, and the time
> for
> > > > > task1 is
> > > > > > > not respected.
> > > > > > >
> > > > > > > This sound strange for me, why the scheduler don't switch the
> task
> > > in
> > > > > > > execution?
> > > > > >
> > > > > > This looks strange, could you try and reduce your application to a
> > > > > > simple example which exhibits the same behaviour ? Maybe you lock
> the
> > > > > > scheduler with taskLock/taskUnlock ?
> > > > >
> > > > > I use the rt_task_set_mode with T_LOCK option in critical section,
> could
> > > it
> > > > > be the cause of the problem?
> > > >
> > > > Yes, the aim of T_LOCK is precisely to prevent the scheduler from
> > > > switching to another task as long as the bit is armed.
> > >
> > > But I reset the mask after the critical section...  I'll try without
> this
> > > lock and report the result
> >
> > I recently noticed something strange in xnpod_schedule which might
> > explain this bug: when the T_LOCK bit is set, xnpod_schedule clears
> > the rescheduling bit even though it does not reschedule. So, could you
> > try, in xnpod_schedule, to replace:
> >
> > if (xnthread_test_state(runthread, XNLOCK))
> >         goto signal_unlock_and_exit;
> >
> > with:
> >
> > if (xnthread_test_state(runthread, XNLOCK)) {
> >         xnsched_set_resched(sched);
> >         goto signal_unlock_and_exit;
> > }
> >
> > --
> >                                                Gilles Chanteperdrix
> >
>
> I make this change but nothing changed...
>
> The deadlock it seem not connected to rt_task_set_mode because if I remove
> it the deadlock is always present.
>
> when the cycle for(i=0;i<=1000;i++)    appo*=1.01;
>  do more then 100000 cycle came the deadlock...
>
> It's seems that is related to rt_task_wait_period

Please do not forget that if Linux never runs, it is normal to observe a lockup.

-- 
                                               Gilles Chanteperdrix

