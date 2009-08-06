From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <A69C5498-65D6-4DC7-B3E5-DB9FE2581DBD@su.sabanciuniv.edu>
References: <A69C5498-65D6-4DC7-B3E5-DB9FE2581DBD@su.sabanciuniv.edu>
Content-Type: text/plain
Date: Thu, 06 Aug 2009 17:13:15 +0200
Message-Id: <1249571595.3809.214.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Periodic Task Time Drift
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alphan Ulusoy <alphan@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2009-07-30 at 08:59 +0300, Alphan Ulusoy wrote:
> Hello,
> 
> I wonder if using a periodic alarm with the rt_alarm_wait() function  
> can suffer from drift in alarm expiration times when a kernel module  
> or an ISR remains in a non-preemptible section for too long (upto 1  
> msec). Please note that I'm concerned with alarm expiration time drift  
> not overruns. How does the behavior change when the task is declared  
> periodic and triggered with rt_task_wait_period() ?

rt_alarm services are working with relative time specs, and your own
code is supposed to re-arm the next shot when the last expiration took
place, therefore this construct inherently induces a time drift.

The reason is that rt_alarms are not meant to build periodic loops, but
rather timeout constructs, e.g. to escape from infinite wait situations,
provide watchdogs and so on. Periodic timing is best performed via
rt_task_wait_period(), which is implemented in a way that is not subject
to drifting.

> 
> I'm using Xenomai 2.4.5 w/ kernel 2.6.27.10.
> 
> best regards,
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



