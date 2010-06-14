Message-ID: <4C167FB8.2050803@domain.hid>
Date: Mon, 14 Jun 2010 21:15:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C1672ED.4080101@domain.hid>
In-Reply-To: <4C1672ED.4080101@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_set_periodic
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ramoncostacastello@domain.hid
Cc: xenomai@xenomai.org

Ramon wrote:
> Hi,
> 
> I'm beginning to work with periodical task in xenomai. Currently I'm 
> using rt_task_set_periodic.
> 
> The third parameter RTIME period allows to specify the period in  clock 
> ticks (taken from : 
> http://www.xenomai.org/documentation/xenomai-2.5/html/api/group__task.html).
> 
> I would like to know how can I get information from the clock tick 
> (which is the value? , can be changed ?) ?

the API provides some functions to convert between ticks and durations
in nanoseconds. If the timer runs in aperiodic mode, however, the
duration of the tick is one nanosecond. If the timer runs in periodic
mode, the tick duration is the period of the periodic timer. All this,
of course, is documented in Xenomai API documentation.

> 
> Why Is the minimum period I can use in user space ? (experimentally it 
> seems to be 0.1ms in my system)

Depends on your system. Also depends on the load you are running. You
can measure this with the "latency" test.

> Working in kernel space this period is lower ?

Probably, again, depends on your system.

> 
> 
> When using the POSIX skin
> int pthread_make_periodic_np    (    pthread_t     thread,struct 
> timespec *     starttp,struct timespec *     periodtp    )
> the resolution is the same ? (performance will be the same ?)

I guess you mean latency. Yes, the latency depends on your system, not
really on the skin you are using. The various Xenomai skins rely on a
the same common core. This is explained in the various documents which
you will find on Xenomai web site.

> 
> Is there any simple approach to develop a periodic task using the POSIX 
>      commands (pthread_cond_timedwait 
> <group__posix__cond.html#gfc43955fc3f1cb43723a9e0be19d0ad1> ?) ?

The POSIX way to run periodic tasks is with the clock_nanosleep with
absolute dates. Or to create a timer and run sigwait to wait for next
period, but this will not work (yet) with Xenomai.



-- 
					    Gilles.

