Message-ID: <4979920B.7050104@domain.hid>
Date: Fri, 23 Jan 2009 10:46:51 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <8e2adebc0812311008j76d745f9r539a1b9108f8903d@domain.hid>	<495BB5AE.1010805@domain.hid>	<8e2adebc0901221104y18d09bb5l3d5645f77e4f42ed@domain.hid>	<4978C5A1.4080302@domain.hid>	<8e2adebc0901221408q3bd65bfeu29b7cfe8ce3bb05e@domain.hid>	<4978EEDC.6040307@domain.hid>
	<8e2adebc0901221506y31e9930aq51e3b26fe4ce4e15@domain.hid>
In-Reply-To: <8e2adebc0901221506y31e9930aq51e3b26fe4ce4e15@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] ARM I-pipe port to OMAP osk board
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
To: Mandar Thite <mandarthite@domain.hid>
Cc: xenomai@xenomai.org

Mandar Thite wrote:
> Hi Gilles,
> 
> I have a problem in following paragraph...
> 
> /**********
> a function is expected to update the tsc area from time to time (at
> least once before the underlying counter reaches the same value again,
> in order to avoid losing some wrap arounds). If the free-running counter
> wraps fast, the best place to do this is __ipipe_mach_acktimer. If the
> free-running counter wraps slowly, doing this from Linux timer interrupt
> will reduce the timer interrupt latency.
> **********/
> 
> How do I decide if, for my platform, "free-running counter" wraps fast
> or slow? Or iow, what does it depend upon?
>

If you need someone to explain what a free running counter is, or why a
timer-related counter may wrap fast or slow, then I'm afraid there is no way you
could achieve your port before hell freezes. Make everyone a favor, do your
homework first, please.

Besides, the least you could do is attaching your code since you want people to
help with it. A good practice is to send the current state of your work as a
patch with your initial question so that people understand where you are at this
point, then update the list with improved releases of this work from time to
time, as progress is made. This would clear a rather irritating feeling we have
that you are offloading your work to the list.

> On Fri, Jan 23, 2009 at 3:40 AM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org
> <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
> 
>     Mandar Thite wrote:
>     > Hi again,
>     > Platform specific code for "clock_event_device" timer
>     initialization in
>     > "arch/arm/mach-omap1/time.c" is starting the timer in "autoreload
>     mode" as
>     > per "HZ" value. Is this ok for functioning of I-pipe or needs a
>     > modification(i mean should it be started in "one shot mode")?
>     > Thanks. ---Mandar
> 
>     Xenomai requires one shot mode.
> 
>     --
>                                                Gilles.
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

