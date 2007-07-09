Message-ID: <4692501E.1060108@domain.hid>
Date: Mon, 09 Jul 2007 17:11:26 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <46924A1A.4010909@domain.hid>
	<1183992374.6014.84.camel@domain.hid> <46924B1B.1010308@domain.hid>
In-Reply-To: <46924B1B.1010308@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] __deprecated not defined for Linux 2.4
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> On Mon, 2007-07-09 at 16:45 +0200, Wolfgang Grandegger wrote:
>>> Hello,
>>>
>>> the attached patch changes:
>>>
>>>    2007-07-09  Wolfgang Grandegger  <wg@domain.hid>
>>>
>>>   * include/asm-generic/wrappers.h: add  __deprecated for Linux 2.4.
>>>
>> Merged, thanks.
> 
> You are too fast for me - I was still test-building my approach!

Too fast? My i-Pipe patched Linux 2.4 kernel did simply not built ;-).

> Looks rather like I picked the wrong expression for marking
> rtdm_task_sleep_until deprecated. I would prefer to go for this variant
> and back Wolfgang's patch out again:
> 
> --- include/rtdm/rtdm_driver.h  (Revision 2758)
> +++ include/rtdm/rtdm_driver.h  (Arbeitskopie)
> @@ -1009,7 +1009,7 @@ rtdm_task_sleep_abs(nanosecs_abs_t wakeu
>  }
> 
>  /* rtdm_task_sleep_abs shall be used instead */
> -static inline int __deprecated
> +static inline int __deprecated_call__
>  rtdm_task_sleep_until(nanosecs_abs_t wakeup_time)
>  {
>      return __rtdm_task_sleep(wakeup_time, XN_REALTIME);
> 
> 
> But note that I'm still test-building...

OK, __deprecated_call__ does not make trouble with 2.4.

Wolfgang.


