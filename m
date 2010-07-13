Message-ID: <4C3CF5E8.7040709@domain.hid>
Date: Wed, 14 Jul 2010 01:25:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <181804936ABC2349BE503168465576460F48EB21@domain.hid>
	<4C3CE5C3.30403@domain.hid>
	<181804936ABC2349BE503168465576460F48EB4B@exchserver.basler.com>
In-Reply-To: <181804936ABC2349BE503168465576460F48EB4B@exchserver.basler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Timed waits with POSIX skin using CLOCK_REALTIME
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Deiters <SteveDeiters@domain.hid>
Cc: xenomai@xenomai.org

Steve Deiters wrote:
>> -----Original Message-----
>> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org] 
>> Sent: Tuesday, July 13, 2010 5:17 PM
>> To: Steve Deiters
>> Cc: xenomai@xenomai.org
>> Subject: Re: [Xenomai-help] Timed waits with POSIX skin using 
>> CLOCK_REALTIME
>>
>> Steve Deiters wrote:
>>> This is probably more of a general POSIX programming 
>> question.  Some 
>>> of the timed wait routines in POSIX (pthread_mutex_timedlock, etc) 
>>> take an absolute timeout value in terms of CLOCK_REALTIME.  
>> How then 
>>> are these routines not subject to timing error when the 
>> CLOCK_REALTIME 
>>> is changed, e.g. with clock_settime?
>> I am not sure I understand the question. We tried and 
>> implement what is described for instance here:
>>
>> http://www.opengroup.org/onlinepubs/009695399/functions/clock_
>> settime.html
>>
>> -- 
>> 					    Gilles.
>>
> 
> It is not a question of the implementation, but more so of the
> specification.
> 
> For example, if I do something similar to the following:
> 
> clock_gettime(CLOCK_REALTIME, &tv);     /* Point A */
> tv.tv_sec += 5;
> pthread_mutex_timedlock(&mutex, &tv);   /* Point B */
> 
> And somewhere else in the sytem after point A but before point B returns
> the time is changed:
> 
> clock_settime(CLOCK_REALTIME, &new_time);
> 
> If the new_time differs from the original time by a significant amount
> then point B will either return ETIMEDOUT if the time was set forward,
> or block for a potentially long period if the time was set backward.
> 
> This behavior seems to be indicated in the following paragraph from the
> specification:
> 
> "If the value of the CLOCK_REALTIME clock is set via clock_settime(),
> the new value of the clock shall be used to determine the time of
> expiration for absolute time services based upon the CLOCK_REALTIME
> clock. This applies to the time at which armed absolute timers expire.
> If the absolute time requested at the invocation of such a time service
> is before the new value of the clock, the time service shall expire
> immediately as if the clock had reached the requested time normally."

Yes.

> 
> 
> I'm not actually having any problems with this, as I am not using these
> routines.  I just thought it was a curious contrast compared to e.g.
> rt_mutex_acquire which specifies a relative timeout.  I don't understand
> how the POSIX timed services expect to have consistent timing using
> absolute timeout values if they are not based at least on
> CLOCK_MONOTONIC which cannot be set.

We only implemented the thing, we did not write the specification.

Most POSIX calls use absolute CLOCK_REALTIME timeouts,
pthread_cond_timedait allow to choose either CLOCK_REALTIME or
CLOCK_MONOTONIC, the clock and timers functions allow any type of
timeout, and the "old" services such as select and nanosleep use
relative timeouts.

I am sure in each of these services, separately, the choice was made for
valid reasons. But on the whole, it looks a bit inconsistent.

The advantage of absolute timeouts is that they allow easy restarting of
syscalls when they are interrupted by signals. And in fact, the native
API also provides for absolute timeouts with the *_until set of services
(such as rt_mutex_acquire_until).

Allowing to use the CLOCK_MONOTONIC instead of CLOCK_REALTIME is in fact
equivalent to allowing relative timeouts. So, adding some more clock
attributes for mutex, semaphores and message queues would in fact allow
the user to choose, which seems to be the best solution.

-- 
					    Gilles.

