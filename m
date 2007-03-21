Message-ID: <46015C03.2090006@domain.hid>
Date: Wed, 21 Mar 2007 17:23:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Newbie question : rt_timer_inquire and
	RT_TIMER_INFO precisions
References: <5C40CD1E4697424ABDE3AC57CF1B22C603221027@domain.hid>
In-Reply-To: <5C40CD1E4697424ABDE3AC57CF1B22C603221027@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "RAKOTOSALAMA, Nirilanto" <NIRILANTO.RAKOTOSALAMA@airbus.com>
Cc: xenomai@xenomai.org

RAKOTOSALAMA, Nirilanto wrote:
> Hello !!!
> I'm total newbie in programming with xenomai (it's the purpose of my internship :-s) ! 
> I've to use xenomai to implement a timer library so, I would like some precisions about 
> RT_TIMER_INFO type. After reading the API I've understood what the RTIME period field is 
> but I ignore what are the RTIME date and tsc fields (meanings ?, time unit ?, time origin ?).
> 
> Also, what is the difference between using rt_alarm_inquire and rt_timer_tsc ? I'd like to calulate
> elapsed time since the timer start for example.

Xenomai has two time sources: the sytem timer, which counts the number
of nanoseconds since 1970, and a hardware dependent high resolution
counter which counts the time since an unspecified point in time
(usually the system boot time). This hardware dependent high resolution
counter is called "tsc" on a PC, and gave its name to Xenomai native API
calls.

rt_timer_tsc returns the value of this hardware dependent
high-resolution counter.
rt_timer_info returns the same thing in the tsc member of the
RT_TIMER_INFO structure, and the value of the system timer at exactly
the same time as when the high-resolution counter was read.

This allows to have a correspondance between the two time sources.

rt_alarm_inquire is not related to this and returns some information
about a given alarm.

Now, if you allow me, a little advice for the implementation of a "timer
library": you could be tempted to create only one periodic alarm object
with Xenomai, and to manage a timer list yourself. Don't do this.
Creating an alarm object for each timer library object make Xenomai
aware of the existence of all your application timers, this has several
advantages:
- it gives you information about all your timers in /proc/xenomai
- it allows Xenomai to use its anticipation algorithm for all your timers
- if you are concerned about the scalability of Xenomai timers list
management, you can check the options in the "Scalability" menu of
Xenomai configuration menu ("Real-time subsystem" sub-menu of kernel
configuration menu).

-- 
                                                 Gilles Chanteperdrix

