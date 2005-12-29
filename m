Message-ID: <43B40254.601@domain.hid>
Date: Thu, 29 Dec 2005 16:35:48 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] autostart timer, rt_timer_start/stop
References: <43B3EAFA.2050906@domain.hid> <43B3FABA.4050903@domain.hid>
In-Reply-To: <43B3FABA.4050903@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Stefan Kisdaroczi wrote:
> 
>>Hi,
>>
>>cant the timer be started by default ?
>>
>>The current state (2.0.1) seems to lead to the following scenario:
>>1) Every app calls rt_timer_start()
>>2) If you call rt_timer_stop you can hurt other rt-apps, so dont
>>   call it
>>3) As some apps dont stop the timer, check in 1) if its already running
>>
>>I think most apps do not care in which mode the timer is running if it is already,
>>and just go on, of course you can stop and restart the timer if its a wrong state,
>>but you do not know if you hurt others.
>>
>>Now, as i read in the other thread that the periodic timer support isnt configured by default,
>>why not start the oneshot timer automatic ?
>>
>>Like this, a 'normal' app doesnt need to fiddle with the timer and
>>an app that really cares can still call rt_timer_inquire,_stop,_start.
>>
> 
> 
> Yea, that's good that someone else brings this topic up again! :) I've
> been pointing on this several times, but as we did not come to a
> conclusion how to handle the system timer in a consistent way across all
> skins, no one (me included...) came up with a fix of this issue so far.
> 

Looks like pending, indeed:
https://gna.org/bugs/?func=detailitem&item_id=4551

> The thing is that most skins start the timer during module init via some
> parameter (nowadays also as a kernel boot option for compiled-in skins).
> As far as I remember, only the native and the RTAI compat skin do their
> own dance - the latter one has to remain compatible, ok, but the former
> one should be allowed to perform smarter.
> 
> Ok, to be more concrete: autostarting the one-shot time in the absence
> of periodic mode is certainly worth considering. For the other cases and
> as sysfs is no option on 2.4 kernels, what about adding a /proc-exported
> control mechanism for the timer mode (and period) to either the HAL or
> the nucleus?

Nucleus.

  Additionally, we could provide some CONFIG_xyz to set the
> default mode during compile time.
> 

Since we can't have more than a single timer setting at any time, a 
CONFIG switch in the General menu would be ok. In such a case, moving 
the currently arch-dep CONFIG_XENO_HW_PERIODIC_TIMER to the General 
config section would make sense too, so that we would have all timer 
options at the same place (periodic timing can always be emulated using 
some underlying oneshot hw timer, and all archs are expected to provide 
at least some form of oneshot timer anyway).

> Ceterum censeo rt_timer_start/stop esse delendam. ;)
> 

Perhaps not, otherwise we would have some trouble crafting tests and 
benchmarks for instance. But these are indeed relics from the Stone Age 
we'd better deprecate for normal use.

> Jan


-- 

Philippe.

