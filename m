From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1282282775.1730.504.camel@domain.hid>
References: <6FCCA913376DD7488F4139A4D11B8F4801465AC9@domain.hid>
	<1282149528.1730.348.camel@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F4801465AF8@domain.hid>
	<1282164261.1730.359.camel@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F4801465B76@domain.hid>
	<1282236153.1730.474.camel@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F4801465C00@domain.hid>
	<1282282775.1730.504.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 20 Aug 2010 08:03:11 +0200
Message-ID: <1282284191.1730.505.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RTDM task blocks when connecting gdb to realtime
 task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Herrera-Bendezu, Luis" <lherrera@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2010-08-20 at 07:39 +0200, Philippe Gerum wrote:
> On Thu, 2010-08-19 at 13:13 -0400, Herrera-Bendezu, Luis wrote:
> > Philippe,
> > 
> > Yes, the patch you sent me works, timers do not stop and RTDM task in my
> > driver continuous to run when realtime app is stopped by debugger.
> > 
> 
> Ah. Ok, so _that_ is a bug.
> 
> > My statement bellow was not clear. I meant that on the unpatched kernel,
> > resuming execution of realtime app does not resume execution of the RTDM task.
> > 

Yeah, I mean... _that_ is a bug. Oh, well...

> > There are two functions lock_/unlock_timers(), are these functions used
> > to stop/start timers when a breakpoint is hit? If yes, I can put some
> > tracing information to check if timers are unblocked.
> 
> Yes, those are the functions involved in this issue, and unlock_timers()
> is expected to unblock all timers belonging to the master time base,
> which it does. However, the timing code is messing badly when it comes
> to postpone non-periodic timers while the time base is locked, hence the
> bug. Could you try this patch? TIA,
> 
> diff --git a/ksrc/nucleus/timer.c b/ksrc/nucleus/timer.c
> index 5fe8d08..828244a 100644
> --- a/ksrc/nucleus/timer.c
> +++ b/ksrc/nucleus/timer.c
> @@ -283,9 +283,9 @@ void xntimer_tick_aperiodic(void)
>  {
>  	xnsched_t *sched = xnpod_current_sched();
>  	xntimerq_t *timerq = &sched->timerqueue;
> +	xnticks_t now, interval;
>  	xntimerh_t *holder;
>  	xntimer_t *timer;
> -	xnticks_t now;
>  
>  	/* Optimisation: any local timer reprogramming triggered by invoked
>  	   timer handlers can wait until we leave the tick handler. Use this
> @@ -324,8 +324,8 @@ void xntimer_tick_aperiodic(void)
>  				/* Postpone the next tick to a reasonable date in
>  				   the future, waiting for the timebase to be unlocked
>  				   at some point. */
> -				xntimerh_date(&timer->aplink) = xntimerh_date(&sched->htimer.aplink);
> -				continue;
> +				interval = xnarch_ns_to_tsc(500000000ULL);
> +				goto requeue;
>  			}
>  		} else {
>  			/* By postponing the propagation of the low-priority host
> @@ -337,8 +337,10 @@ void xntimer_tick_aperiodic(void)
>  				continue;
>  		}
>  
> +		interval = timer->interval;
> +	requeue:
>  		do {
> -			xntimerh_date(&timer->aplink) += timer->interval;
> +			xntimerh_date(&timer->aplink) += interval;
>  		} while (xntimerh_date(&timer->aplink) < now + nklatency);
>  		xntimer_enqueue_aperiodic(timer);
>  	}
> 
> > 
> > Luis
> > 
> > >-----Original Message-----
> > >From: Philippe Gerum [mailto:rpm@xenomai.org]
> > >Sent: Thursday, August 19, 2010 12:43 PM
> > >To: Herrera-Bendezu, Luis
> > >Cc: xenomai@xenomai.org
> > >Subject: RE: [Xenomai-help] RTDM task blocks when connecting gdb to realtime task
> > >
> > >
> > >On Thu, 2010-08-19 at 08:26 -0400, Herrera-Bendezu, Luis wrote:
> > >> >-----Original Message-----
> > >> >From: Philippe Gerum [mailto:rpm@xenomai.org]
> > >> >Sent: Wednesday, August 18, 2010 4:44 PM
> > >> >To: Herrera-Bendezu, Luis
> > >> >Cc: xenomai@xenomai.org
> > >> >Subject: RE: [Xenomai-help] RTDM task blocks when connecting gdb to realtime task
> > >> >
> > >> >
> > >> >On Wed, 2010-08-18 at 13:29 -0400, Herrera-Bendezu, Luis wrote:
> > >> >> Philippe,
> > >> >>
> > >> >> >-----Original Message-----
> > >> >> >From: Philippe Gerum [mailto:rpm@xenomai.org]
> > >> >> >Sent: Wednesday, August 18, 2010 12:39 PM
> > >> >> >To: Herrera-Bendezu, Luis
> > >> >> >Cc: xenomai@xenomai.org
> > >> >> >Subject: Re: [Xenomai-help] RTDM task blocks when connecting gdb to realtime task
> > >> >> >
> > >> >> >
> > >> >> >On Wed, 2010-08-18 at 12:03 -0400, Herrera-Bendezu, Luis wrote:
> > >> >> >> Hello:
> > >> >> >>
> > >> >> >> I am using Xenomai 2.4.10 on PPC. An RTDM driver creates an RTDM task
> > >> >> >> using rtdm_task_init() and goes to sleep periodically via function
> > >> >> >> rtdm_task_sleep().
> > >> >> >>
> > >> >> >> When driver is loaded, RTDM task executes as expected. Then a realtime
> > >> >> >> application is started via gdbserver on target board and on a linux host
> > >> >> >> a gdb client is connected to that board. As soon as gdb breakpoints the
> > >> >> >> realtime application the RTDM task never returns from rtdm_task_sleep().
> > >> >> >> The application does not open the RTMD driver so at this point there is
> > >> >> >> no interaction with the driver.
> > >> >> >>
> > >> >> >> The RTDM task is intr_sim and the timer is no longer firing
> > >> >> >> # cat /proc/xenomai/timerstat/master
> > >> >> >> CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME
> > >> >> >> 0    29198042    9132085     3724750    -          NULL
> > >> >> >> [host-timer]
> > >> >> >> 0    1340        1340        -          -          xnthread_ti  intr_sim
> > >> >> >>
> > >> >> >> The realtime application is ancvbirt.
> > >> >> >> # cat /proc/xenomai/sched
> > >> >> >> CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
> > >> >> >>   0  0       -1      0          0          master    R          ROOT
> > >> >> >>   0  0       90      0          0          master    D          intr_sim
> > >> >> >>   0  1869     0      0          0          master    XT         ancvbirt
> > >> >> >>
> > >> >> >> Any ideas on the cause of the problem and fix?
> > >> >> >
> > >> >> >This is a side-effect of hitting a breakpoint in your application
> > >> >> >introduced by Xenomai: all Xenomai timers are frozen system-wide, until
> > >> >> >the application is continued. This includes the per-thread timer which
> > >> >> >is used to have your RTDM task wake up after a delay.
> > >> >> After continuing the application, the RTDM task does not resume execution.
> > >> >> I had to reload driver to have it working again.
> > >> >> >
> > >> >> >There is a way to prevent this behavior, which was defined for internal
> > >> >> >purposes only so far. Since Jan is not watching, here is a patch against
> > >> >> >2.4.10 which happily butchers his nifty interface, that should prevent
> > >> >> >the per-thread timers of _all_ RTDM tasks from being blocked in that
> > >> >> >case, which may be enough to help you though:
> > >> >> >
> > >> >> >diff --git a/ksrc/skins/rtdm/drvlib.c b/ksrc/skins/rtdm/drvlib.c
> > >> >> >index 65c630f..0295690 100644
> > >> >> >--- a/ksrc/skins/rtdm/drvlib.c
> > >> >> >+++ b/ksrc/skins/rtdm/drvlib.c
> > >> >> >@@ -144,6 +144,7 @@ int rtdm_task_init(rtdm_task_t *task, const char *name,
> > >> >> > 	res = xnpod_init_thread(task, rtdm_tbase, name, priority, 0, 0, NULL);
> > >> >> > 	if (res)
> > >> >> > 		goto error_out;
> > >> >> >+	task->rtimer.status |= XNTIMER_NOBLCK;
> > >> >> >
> > >> >> > 	if (period > 0) {
> > >> >> > 		res = xnpod_set_thread_periodic(task, XN_INFINITE,
> > >> >> >@@ -151,6 +152,7 @@ int rtdm_task_init(rtdm_task_t *task, const char *name,
> > >> >> > 						(rtdm_tbase,  period));
> > >> >> > 		if (res)
> > >> >> > 			goto cleanup_out;
> > >> >> >+		task->ptimer.status |= XNTIMER_NOBLCK;
> > >> >> > 	}
> > >> >> >
> > >> >> > 	res = xnpod_start_thread(task, 0, 0, XNPOD_ALL_CPUS, task_proc, arg);
> > >> >> >
> > >> >> Yes, this patch avoids stopping the timers. I see the value on stopping the
> > >> >> timers on the RTDM driver when application hits a breakpoint but for some
> > >> >> reason timer does not recover. I am using Linux 2.6.30.
> > >> >
> > >> >Could you paste the output from:
> > >> >/proc/xenomai/stat
> > >> >/proc/xenomai/timerstat/master
> > >> >
> > >> >after the application has resumed execution?
> > >> >
> > >> >TIA,
> > >> >
> > >> >
> > >> >--
> > >> >Philippe.
> > >> >
> > >> Status with application at breakpoint:
> > >> # cat /proc/xenomai/stat
> > >> CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
> > >>   0  0      0          14984      0     00400080   99.7  ROOT
> > >>   0  0      0          3976       0     00000084    0.0  intr_sim
> > >>   0  1261   1          1          1     00301380    0.0  ancvbirt
> > >>   0  0      0          0          0     00000000    0.0  IRQ22: _vip_fpga_codec@domain.hid
> > >>   0  0      0          337375     0     00000000    0.2  IRQ512: [timer]
> > >>
> > >> # cat /proc/xenomai/timerstat/master
> > >> CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME
> > >> 0    1005240     326161      1844335    -          NULL         [host-timer]
> > >> 0    3976        3976        -          -          xnthread_ti  intr_sim
> > >>
> > >> Status of application after application execution is resumed:
> > >> # cat /proc/xenomai/stat
> > >> CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
> > >>   0  0      0          15034      0     00400080   99.6  ROOT
> > >>   0  0      0          3976       0     00000084    0.0  intr_sim
> > >>   0  1261   2          2          2     00300380    0.0  ancvbirt
> > >>   0  0      0          0          0     00000000    0.0  IRQ22: _vip_fpga_codec@domain.hid
> > >>   0  0      0          428462     0     00000000    0.4  IRQ512: [timer]
> > >>
> > >> # cat /proc/xenomai/timerstat/master
> > >> CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME
> > >> 0    1314446     412961      410890     -          NULL         [host-timer]
> > >> 0    3976        3976        -          -          xnthread_ti  intr_sim
> > >> 0    5           2           -          -          xnthread_ti  AncVbiRt-in-int
> > >> 0    4           1           -          -          xnthread_ti  AncVbiRt-out-in
> > >> 0    2           2           -          -          xnthread_ti  AncVbiRt-client
> > >> 0    3           1           -          -          xnthread_ti  AncVbiRt-tsout
> > >> 0    3           1           -          -          xnthread_ti  AncVbiRt-pudi
> > >> 0    1           1           -          -          xnthread_ti  AncVbiRt-ancx
> > >> 0    1           0           -          -          xnthread_ti  AncVbiRt-vbix
> > >> 0    1           0           -          -          xnthread_ti  AncVbiRt-gpispl
> > >>
> > >> Notes:
> > >> 1. GNU gdb Red Hat Linux (6.7-1rh)
> > >> 2. GNU gdbserver Red Hat Linux (6.7-1rh)
> > >> 3. set gdb to not stop/print/pass SIGXCPU signal.
> > >> 4. Same behavior if program is executed within gdb and no breakpoints.
> > >
> > >Please check that you are running the modified kernel, and specifically
> > >the updated xeno_rtdm module. This patch does work as expected.
> > >
> > >>
> > >> Thanks,
> > >> Luis
> > >
> > >--
> > >Philippe.
> > >
> > 
> 

-- 
Philippe.



