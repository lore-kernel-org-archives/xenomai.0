From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <6FCCA913376DD7488F4139A4D11B8F4801465AC9@domain.hid>
References: <6FCCA913376DD7488F4139A4D11B8F4801465AC9@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 18 Aug 2010 18:38:48 +0200
Message-ID: <1282149528.1730.348.camel@domain.hid>
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

On Wed, 2010-08-18 at 12:03 -0400, Herrera-Bendezu, Luis wrote:
> Hello:
> 
> I am using Xenomai 2.4.10 on PPC. An RTDM driver creates an RTDM task
> using rtdm_task_init() and goes to sleep periodically via function
> rtdm_task_sleep().
> 
> When driver is loaded, RTDM task executes as expected. Then a realtime
> application is started via gdbserver on target board and on a linux host
> a gdb client is connected to that board. As soon as gdb breakpoints the
> realtime application the RTDM task never returns from rtdm_task_sleep().
> The application does not open the RTMD driver so at this point there is
> no interaction with the driver.
> 
> The RTDM task is intr_sim and the timer is no longer firing
> # cat /proc/xenomai/timerstat/master
> CPU  SCHEDULED   FIRED       TIMEOUT    INTERVAL   HANDLER      NAME
> 0    29198042    9132085     3724750    -          NULL
> [host-timer]
> 0    1340        1340        -          -          xnthread_ti  intr_sim
> 
> The realtime application is ancvbirt.
> # cat /proc/xenomai/sched
> CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
>   0  0       -1      0          0          master    R          ROOT
>   0  0       90      0          0          master    D          intr_sim
>   0  1869     0      0          0          master    XT         ancvbirt
> 
> Any ideas on the cause of the problem and fix?

This is a side-effect of hitting a breakpoint in your application
introduced by Xenomai: all Xenomai timers are frozen system-wide, until
the application is continued. This includes the per-thread timer which
is used to have your RTDM task wake up after a delay.

There is a way to prevent this behavior, which was defined for internal
purposes only so far. Since Jan is not watching, here is a patch against
2.4.10 which happily butchers his nifty interface, that should prevent
the per-thread timers of _all_ RTDM tasks from being blocked in that
case, which may be enough to help you though:

diff --git a/ksrc/skins/rtdm/drvlib.c b/ksrc/skins/rtdm/drvlib.c
index 65c630f..0295690 100644
--- a/ksrc/skins/rtdm/drvlib.c
+++ b/ksrc/skins/rtdm/drvlib.c
@@ -144,6 +144,7 @@ int rtdm_task_init(rtdm_task_t *task, const char *name,
 	res = xnpod_init_thread(task, rtdm_tbase, name, priority, 0, 0, NULL);
 	if (res)
 		goto error_out;
+	task->rtimer.status |= XNTIMER_NOBLCK;
 
 	if (period > 0) {
 		res = xnpod_set_thread_periodic(task, XN_INFINITE,
@@ -151,6 +152,7 @@ int rtdm_task_init(rtdm_task_t *task, const char *name,
 						(rtdm_tbase,  period));
 		if (res)
 			goto cleanup_out;
+		task->ptimer.status |= XNTIMER_NOBLCK;
 	}
 
 	res = xnpod_start_thread(task, 0, 0, XNPOD_ALL_CPUS, task_proc, arg);

NOTE: please don't take this patch as an official way to handle this
issue, it is not. It's an ugly kludge, until we find a better way to
selectively enable this behavior for built-in timers (2.5.x has a way to
do this for user-defined timers already, it is called
xntimer_init_noblock()).

> 
> Thanks,
> Luis G. Herrera-Bendezu
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



