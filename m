Date: Thu, 15 Apr 2010 08:59:25 -0400
Message-ID: <20100415125925.GD26116@domain.hid>
References: <4BB5B7C1.4020301@domain.hid> <4BB5B874.5090904@domain.hid>
	<k2pb88603c31004020232z28e10d59vc546b1b8803113f2@domain.hid>
	<4BB5BA2D.1080604@domain.hid>
	<245373446233674495BCA5CA2FC1EB17378D015932@domain.hid>
	<4BBAD880.5040603@domain.hid>
	<20100415001912.GB26116@domain.hid>
	<1271328418.2365.622.camel@domain.hid>
	<20100415123607.GC26116@domain.hid>
	<4BC70920.9060002@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4BC70920.9060002@domain.hid>
From: Andreas Glatz <andreasglatz@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Andreas Glatz <AndreasGlatz@domain.hid>, Jan Kiszka <jan.kiszka@domain.hid>

On Thu, Apr 15, 2010 at 08:40:00AM -0400, Gilles Chanteperdrix wrote:
> Andreas Glatz wrote:
> > Hi,
> > 
> > On Thu, Apr 15, 2010 at 06:46:58AM -0400, Philippe Gerum wrote:
> >> On Wed, 2010-04-14 at 20:19 -0400, Andreas Glatz wrote:
> >>
> >>> One thing I've noticed though, and this is not related to the patch (I verified it on a
> >>> vanilla Xenomai system): Consider the example I included. It prints average cycle times
> >>> and the cycle time variance of the high priority task ("T2"). I noticed a big difference
> >>> in the cycle time variance when switching the first task ("T1") to secondary mode with
> >>> rt_task_set_mode() and setting the scheduler policy to either SCHED_FIFO, SCHED_IDLE or
> >>> SCHED_NORMAL. I'm assuming someone asked this before and I didn't pay attention :)
> >>> Can someone give me a short explanation or point me somewhere to get an explanation for
> >>> this behaviour? I didn't expect such a difference in variance:
> >>>
> >> Moving back to secondary mode is nothing more than triggering the
> >> rescheduling procedure linux-wise, so the time credit for
> >> SCHED_OTHER/IDLE tasks decay as usual during your work loop, preemption
> >> by high priority task is more likely and so on. This variance is just
> >> the sign that those tasks cannot ask for more than what their scheduling
> >> policy grants.
> >>
> > 
> > I think, I didn't express myself clearly enough. I was more puzzled about 
> > the variance of the pure RT task (task w/o any secondary mode switches).
> > So it seems that changing the scheduling policy of the "relaxed" task has
> > an influence on the variance of the pure RT task. So the RT task seems
> > to wait for the "relaxed" task. But where exacly does it wait for it? Mmmmm...
> 
> When waiting for the mutex?
>

Ok. Maybe it's as ovvious as that. But I'm not quite there yet. Let me explain:
I know that the "relaxed" task ("T1") is in primary mode between rt_mutex_aquire()
and rt_mutex_release(). In other words when the pure RT task ("T2") starts waiting
on the mutex, "T1" should be primary mode and not be affected by the Linux 
scheduling policy. After "T1" releases the mutex it switches back to secondary mode.
So I would expect the variance to be constant. 

Thanks, Andreas

 

