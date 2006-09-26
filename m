Subject: Re: [Xenomai-help] Help on debugger gdb
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4518F58A.5090900@domain.hid>
References: <45188502.4060209@domain.hid>
	<1159261731.5084.46.camel@domain.hid>  <4518F58A.5090900@domain.hid>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 12:02:33 +0200
Message-Id: <1159264954.5084.69.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2006-09-26 at 11:40 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Mon, 2006-09-25 at 22:40 -0300, Rodrigo Rosenfeld Rosas wrote:
> >> Hi, it's me again, after a long while :)
> >>
> >> I'll present my Master thesis this Friday and I would like to comment 
> >> about the debugger. Since I'm in hurry with a lot other issues, I do not 
> >> have to time to test what I'm going to ask.
> >>
> >> I've never used a debugger with Xenomai (or RTAI). I mean, not GDB. I 
> >> used other techniques to debug, such as logging, etc. My doubt is:
> >>
> >> Suppose I have a user-space program with 3 independent Xenomai RT-tasks. 
> >> If I put a breakpoint in one of them, will the other two keep running? I 
> >> guess yes, but I'm not sure and that is why I'm asking.
> >>
> > 
> > Actually, they would not. The kernel would stop all of them as a
> > consequence of ptracing, and Xenomai would switch them back to secondary
> > mode if needed, to let them handle the new situation properly.
> > 
> >> Another thing. I think that the scheduler will keep counting the time 
> >> when the debugger stopped the task. So, the next call to 
> >> rt_task_wait_period() will return -ETIMEDOUT immediately, with the 
> >> overruns set accordly, if this was the case, right?
> >>
> > 
> > No, the outstanding RT timers are globally frozen whenever a ptraced
> > user-space task is stopped by the debugger, exactely to prevent the case
> > you described, so that you can step into your application without
> > causing such annoying side-effect. Since we are breakpointing/stepping
> > into the code, real-time accuracy doesn't matter anyway, so we act as if
> > the timeline was being frozen each time the debugger holds the
> > application. 
> 
> Timers are frozen, but internal timekeeping continues, e.g. in
> xnpod_wait_thread_period (which is used by rt_task_wait_period). So the
> overrun counter is in fact incremented and an error is returned after
> the interruption.

Yes, I was talking about the old behaviour we had of returning timeout
conditions repeatedly for each missed release points before
xnpod_wait_thread_period has been reworked to actually compute the
missed periods.

> 
> That raises the question for me if we shouldn't allow this freeze also
> per-process in the future to confine the effect only to those programs
> actually being debugged. I can easily imagine scenarios where the
> developer might be more happy to keep other, fairly independent parts of
> the system alive while stepping through one application.
> 

Yes, but we will need the reworked timer infrastructure to do that
properly.

> Jan
> 
-- 
Philippe.



