Message-ID: <4464B300.8010002@domain.hid>
Date: Fri, 12 May 2006 18:08:32 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] starnge latencies with native
References: <20060512172456.555caf51@domain.hid>
In-Reply-To: <20060512172456.555caf51@domain.hid>
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
To: Daniel Simon <Daniel.Simon@domain.hid>
Cc: Xenomai-help@domain.hid

Daniel Simon wrote:
> Hi all,
> 
> I'm doing some tests with the native skins. The attached program uses
> an alarm to trigger a periodic task and measures the sampling latency. 
> 
> Initial latencies are in the range of tens of millisecs. and then
> decrease slowly to the range of microsecs:
> 
> rt_timer_set_mode(TM_ONESHOT) started 
> alarm started with period 1000000000 ns 
> increment 1124642266 absjitter 124642266  
> increment 937743828 absjitter 62256172  
> increment 1031095424 absjitter 31095424  
> increment 984466651 absjitter 15533349  
> increment 1007758686 absjitter 7758686  
> increment 996126407 absjitter 3873593  
> increment 1001934707 absjitter 1934707  
> increment 999039749 absjitter 960251  
> increment 1000477139 absjitter 477139  
> increment 999759707 absjitter 240293  
> increment 1000119631 absjitter 119631  
> increment 999938964 absjitter 61036  
> increment 1000029816 absjitter 29816  
> increment 999985508 absjitter 14492  
> increment 1000004750 absjitter 4750  
> increment 999998882 absjitter 1118  
> increment 1000000946 absjitter 946  
> increment 999998780 absjitter 1220  
> increment 1000001951 absjitter 1951  
> increment 999999514 absjitter 486  
> increment 999998746 absjitter 1254  
> [...]
> 
>  What may be wrong? 
> 
> I observe the same behaviour if the periodic sampling is given by a
> rt_periodic task or by a rt_sleep_until in the clock loop...
> 

This code works here, so there might be an issue with your environment.
Does some Xenomai message appear in the kernel log, such as SMI warning?
Or did you activate the ACPI+cpufreq support for your kernel?
Also, what does /proc/xenomai/timer and /proc/xenomai/sched say when 
your app is running?

Additionally, three remarks on your code:
- do NOT call rt_task_set_mode(0, T_PRIMARY, NULL); in your 
applications. It's utterly useless and at best a waste of cycles since
Xenomai will move your thread to the proper mode as needed to run the
syscalls. This call is here for the 0.00000001% of situations where 
eager control over the current mode is required by some internal Xenomai 
code, but normal applications should not need this unless they are doing 
something really weird.
- In the same vein, calling rt_timer_set_mode() is useless, unless you 
want to override the default timing mode you set up during the kernel 
configuration (CONFIG_XENO_OPT_TIMING_PERIODIC et al.) If you disabled
the previous option, then your system can only work in aperiodic mode
anyway, so you don't need to re-specify it by a call to rt_timer_set_mode().
- calling printf() in the middle of your measurement loop adds 
uncertainty to your results, since migrating from Xenomai to Linux for 
this purpose - and the other way around to get blocked on 
rt_alarm_wait() - has a cost wrt latency. A 1 second period should not 
be that much perturbated by a printf() though, but still, it's a wrong 
way of writing time predictable code.

{rpm@xenomai.org} sudo ./orcalarm
rt_timer_set_mode(TM_ONESHOT) started
alarm started with period 1000000000 ns
increment 999986989 absjitter 13011
increment 1000006146 absjitter 6146
increment 999989806 absjitter 10194
increment 1000022829 absjitter 22829
increment 999997693 absjitter 2307
increment 1000003468 absjitter 3468
increment 999997452 absjitter 2548
increment 999999961 absjitter 39
increment 1000001230 absjitter 1230
increment 1000025352 absjitter 25352
increment 999985543 absjitter 14457
increment 999998970 absjitter 1030
Ctrl C Interrupt
increment 1000012630 absjitter 12630
jittermoy = 7682, jittermax = 25352
deleting rt devices

-- 

Philippe.

