Message-ID: <444A008A.7000100@domain.hid>
Date: Sat, 22 Apr 2006 12:08:10 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] some questions about alarms
References: <200604211711.44211.tmarscha@domain.hid>
In-Reply-To: <200604211711.44211.tmarscha@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Tobias Marschall <tmarscha@domain.hid>
Cc: xenomai@xenomai.org

Tobias Marschall wrote:
> Hello,
> 
> my application needs (besides doing some other stuff) to set some output 
> signals on an interface card at specific points in time. I think such a 
> simple thing doesn't deserve its own thread and am considering to use alarms 
> for this.
> 
> Is it correct that the handler of an alarm is executed with the same priority 
> as the thread that created it? Meaning that the alarm execution will be 
> delayed if a higher-priority (primary mode) thread is running at the time the 
> alarm expires?
>

Alarms used in kernel context are run on behalf of the Xenomai timer ISR 
context. In user-space, real-time alarms are currently handled by server 
threads you create, which call the rt_alarm_wait() service to wait for 
the next alarm shot, then process the timeout from their own context. As 
a side-effect, this service boosts the calling thread priority above all 
regular Xenomai threads, i.e. to some kind of pseudo-interrupt level.

> In my case it would be most convenient to be able to program an alarm timer 
> using an absolute time (date). I didn't find such a function in the API 
> documentation (native skin). Is the absense of such a function intended or 
> did simply nobody implement it? Is it possible to implement such a function 
> by just modifying the native skin?
> 

Yes, but I don't think that alarms are the most appropriate feature to 
use in your case. Alarms are basically provided for setting watchdogs 
that would handle timeout conditions.

> But perhaps there is a better way to solve my issue. Is there any "best 
> practice" for my problem? By now I see to possibilities: 1) Use a 
> rt_timer_read in connection with alarms. 2) Spawn a whole thread and use 
> rt_task_sleep_until.
>

Spawning a thread and use rt_task_set_periodic()+rt_task_wait_period() 
would be better here. You would be able to specify an absolute starting 
date, and a fixed period.

> Any Ideas?
> 
> Best regards and thanks in advance,
> Tobias
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

