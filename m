From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4718C00B.9040607@domain.hid>
References: <4718C00B.9040607@domain.hid>
Content-Type: text/plain
Date: Fri, 19 Oct 2007 19:14:17 +0200
Message-Id: <1192814057.6252.32.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Replacement of taskDelay(0) call
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On Fri, 2007-10-19 at 16:32 +0200, Johan Borkhuis wrote:
> When using VxWorks we used "taskDelay(0)" to invoke the scheduler. 
> Within Xenomai this call was translated into "rt_task_yield()". However,

You mean xnpod_yield(), the VxWorks skin is directly based on the
Xenomai abstract core, not on the native skin.

>  
> when using a number of tasks at the same priority using this mechanism 
> the watchdog timeout kicks in and kills the Xenomai task(s).

Well, that's the point of the watchdog. If you application does not
reliquish enough CPU time to the regular Linux kernel activities, the
system is wil have a problem sooner or later. taskDelay(0) will perform
some kind of manual round-robin scheduling, therefore doing so among one
or several real-time tasks for a long time could indeed prevent Linux to
grab the CPU. In that case, the watchdog really notifies you from a
problem with the dynamics of your application.

IOW, what is allowed with a dedicated RTOS controlling the whole
hardware may not be valid in the context of a GPOS and a RTOS sharing
the same hardware, which is the case with Xenomai. You have to make sure
Linux has some time left to perform the regular housekeeping duties
(process non real-time device interrupts, Linux scheduler ticks and so
on).

>  This also 
> happens when a rt_task_sleep is used with a delay < 100 usec.
> 

Are you using both the VxWorks and native skins in your app?

This said, the watchog is programmed to trigger after 4s of
uninterrupted real-time activity - in the sense that Linux never gets
any CPU time during that period. What comes to mind is that your
application has several real-time tasks which are ready to run in that
situation, so despite some of them is delaying for 100 us, another one
always manages to grab the CPU, still preventing the regular Linux
kernel from running. Raising the delay value above 100 us probably gives
more opportunities to Linux to eventually grab the CPU, by relaxing the
timeline enough. I suspect that this is basically a problem of processor
timeline: at some point, the dispatching of your various real-time tasks
creates a CPU starvation enough for the watchdog to trigger, especially
if they tend to work in some polling/round-robin mode.

> Is there a possibility to trigger the watchdog to avoid the killing of 
> the tasks?

The watchdog must kill the task, there is no way out from there; e.g.
only suspending them would create bugous situations with user-space
tasks due to internal reasons. The real problem I see here is not about
preventing the watchdog to perform its job, but rather to make sure that
your application is not misbehaving with respect to the common rules of
sharing the same hardware with Linux. In case you really deeply need the
real-time application to starve Linux from CPU for periods longer than
4s, then you may just disable the watchdog service at configuration
time, or increase the 4s timeout threshold to a greater value. Still, I
think that such situation may be questionable: 4s is already a very long
time for Linux to be starved from CPU, especially if this is regular
practice from your application and happens frequently.

> 
> Kind regards,
>     Johan Borkhuis
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



