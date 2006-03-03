Message-ID: <4408287D.7040004@domain.hid>
Date: Fri, 03 Mar 2006 12:29:01 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <C029D34C.25A3%steve@domain.hid>
	<440575EB.4080304@domain.hid>	
	<b647ffbd0603010725t60066558h@domain.hid>	
	<4405C527.8060908@domain.hid>
	<b647ffbd0603011101p1247cd87t@domain.hid>
In-Reply-To: <b647ffbd0603011101p1247cd87t@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Xenomai-help] rt_task_wait_period() and overruns
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Dmitry Adamushko wrote:
> 
> On 01/03/06, *Philippe Gerum* <rpm@xenomai.org <mailto:rpm@xenomai.org>> 
> wrote:
> 
>     Dmitry Adamushko wrote:
>      >
>      > On 01/03/06, *Philippe Gerum* <rpm@xenomai.org
>     <mailto:rpm@xenomai.org> <mailto:rpm@xenomai.org
>     <mailto:rpm@xenomai.org>>>
>      > wrote:
>      >
>      >
>      >      The other option I've described for
>      >     dealing with overruns in rt_task_wait_period would be as follows:
>      >
>      >     - save the count of overruns
>      >     - clear the count of overruns  /* i.e. "purge" */
>      >     - return both the saved count and -ETIMEDOUT to the user.
>      >
>      >     This way, rt_task_wait_period would return only once with an
>     error
>      >     status, telling
>      >     the user about the exact count of pending overruns in the
>     same time.
>      >
>      >
>      >
>      > I definitely agree with you here.
>      >
>      > IMHO, there is no point in calling rt_task_wait_period() a few
>      > times in a row just to clean up the "poverrun" counter
>      > (if there were a few overruns) when the whole may be reported at
>     once.
>      > This former way just gives unnecessary overhead.
>      >
> 
>     My concern is that some recovery procedure might require to get the
>     exact number
>     of pending overruns to operate properly in order to catch up with
>     the missing
>     expiries, and there is no way to get this information out of the
>     current API (!).
>     Even calling rt_task_wait_period in loop and testing for -ETIMEDOUT
>     is unusable,
>     since well, we would obviously get blocked when the overrun count
>     drops to zero,
>     which is not what we want in order to be able to run the recovery
>     procedure asap.
> 
> 
> All in all, I would vote for changing the current rt_task_wait_period() 
> interface.

I'm convinced now that this is the way to go too, because the current interface is 
not only limited, but broken, since it does not allow to tell the recovery 
procedure the exact count of pending overruns.

This is a widely used routine unfortunately, so the change won't go unnoticed, but 
on the other hand, v2.1 is likely the last opportunity we have to clean the native 
API from legacy issues, without resorting to using weird hacks aimed at keeping 
the binary and source compatibilities, many of which end up polluting the API they 
are supposed to protect.

>  
> 
> 
>      >
>      > Actually, there is a kind of application that must not rely on
>      > the "poverrun" counter, the klatency/latency utility and alike.
>      >
>      > They are run normally (at least at the very first time) in the
>     untrusted
>      > environment
>      > where SMI or something similar - that may prevent a CPU from
>     handling normal
>      > interrupts for quite a long time - make occur happily.
>      > As the "poeverrun" counting is dependent on the timer interrupt,
>      > it becomes irrelevant.
>      >
>      > Something like
>      > overruns = (real_time_of_wakeup - desired_time_of_wakeup) /
>     period (*)
>      > should be rather used there (of course, the timing source must not be
>      > interrupt-dependent).
> 
>     Ah! you know what, I'm pretty sure that one of your very first
>     public posts on the
>     RTAI/fusion mailing list at that time, was exactely about this issue
>     :o) 
> 
> 
> Good memory indeed; so it's too earlier for you to get retired :o)
>  

"G3" still means "inspired guitar masters" to me, and not some obscure powerpc 
thingy, so I guess that I've not been spoiled by IT yet. Way too early to retire then.

> 
>     --
> 
>     Philippe.
> 
> 
> 
> 
> -- 
> Best regards,
> Dmitry Adamushko


-- 

Philippe.

