Message-ID: <43F5F971.7050203@domain.hid>
Date: Fri, 17 Feb 2006 17:27:29 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] no-brainer realtime issue
References: <C01B3432.2453%steve@domain.hid>
In-Reply-To: <C01B3432.2453%steve@domain.hid>
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
To: Steven Seeger <steve@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Steven Seeger wrote:
>>Yous seem to be running in periodic timing mode, with a default slice of 125
>>us.
>>Which parameters are passed to rt_task_set_periodic() and
>>rt_task_wait_period() in
>>your sampling task?
> 
> 
> I am confused why this matters? You said the latency test shows my realtime
> does not work, so clearly the problem I have isn't specific to my code, but
> rather to my system, right?
> 

The latency figures obtained are totally braindamage, so either something weird is 
happening in 1) the real-time core, or 2) with the hw config selected, or 3) in 
the application.

1) is always possible, but you might also consider that early timer shots beyond 
two _milliseconds_ (-2293218 ns) would have been caught by a few other people on 
the list; this has not been the case yet. So considering a massive breakage in the 
real-time behaviour of that magnitude at this point of the investigation seems a 
bit premature.

2) Geode brings its own set of issues. SMI is one of them. Something may also go 
wrong when upgrading a kernel while reusing an old config file. Given your past 
answers, I now take for granted that it is not the case, but asking first is better.

3) v2.1 has changed a lot of things wrt v2.0, including the way some key 
configurations are made. Timing mode is one of those critical changes, and maybe 
one of those changes has had a negative impact in some unexpected way. Looking at 
the application to see what it requests to the real-time core and how it does it, 
is the usual way to start digging the issue.

> Here is my call to rt_task_set_periodic:
> 
> rt_task_set_periodic(&task, TM_NOW, rt_timer_ns2ticks(500000));
> 

Ok, I think we might be dealing with a timing mode issue. Could you try disabling 
CONFIG_XENO_OPT_TIMING_PERIODIC in your kernel config (Timing menu) and re-run the 
latency test? TIA,

> I don't pass any parameters to rt_task_wait_period()
> 

Yep, my mistake.

> Steven
> 
> 


-- 

Philippe.

