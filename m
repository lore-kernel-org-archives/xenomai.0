From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17534.43220.103310.355438@domain.hid>
Date: Thu, 1 Jun 2006 10:44:04 +0200
Subject: Re: [Xenomai-help] How to make main sleep ? clock_nanosleep ?
	rt_alarm_wait ?
In-Reply-To: <447E9A1B.10507@domain.hid>
References: <447E9A1B.10507@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Lionel Perrin <perrin@domain.hid>
Cc: xenomai@xenomai.org

Lionel Perrin wrote:
 > I got some difficulties to use either rt_alarm_wait or clock_nanosleep.
 > It seems i haven't understood what's a "context that can sleep".
 > 
 > First of all, what do we need to use clock_nanosleep ?
 > Is it impossible to use this function in the main thread ?

Xenomai clock_nanosleep, nanosleep or rt_alarm_wait services are
reserved to Xenomai real-time threads, and will return an error of EPERM
otherwise.

If you want a non-realtime sleep, you may still access standard services
using __real_nanosleep or __real_clock_nanosleep.

If you want to obtain a Xenomai real-time thread using the posix skin
you have to make it use the SCHED_FIFO policy, either by creating it
with the pthread_create service, specifying non null creation attributes
or by changing the scheduling policy of an existing thread with
the pthread_setschedparam service.

If you want to obtain a Xenomai real-time thread using the native skin,
you may create it with the rt_task_create service or turn an existing
thread into a real-time thread with the rt_task_shadow service.

 > (...)
 >     ret = nanosleep(&tp, &rmtp);
 >     switch (errno) {
 > (...)

errno value is only meaningful if nanosleep returns -1. In particular it
is not garanteed to be zero if nanosleep did not fail.

-- 


					    Gilles Chanteperdrix.

