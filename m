Message-ID: <485FD357.2030007@domain.hid>
Date: Mon, 23 Jun 2008 18:46:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <485F7A69.7080004@domain.hid>	<5b5edafe752e2ab744303b0262edc05c@domain.hid>
	<485FC7F3.7020001@domain.hid> <485FD06A.8060805@domain.hid>
	<485FD207.9010901@domain.hid>
In-Reply-To: <485FD207.9010901@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai scheduler's ticks period
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-help <xenomai@xenomai.org>

Philippe Gerum wrote:
> Gilles Chanteperdrix wrote:
>> Philippe Gerum wrote:
>>> Matthieu wrote:
>>>
>>>> I have a segmentation fault error when I use modprobe xeno_vxworks
>>>> tick_arg=0 (tick_arg=1000 works)
>>>>
>>> Any kernel log?
>>>
>> wind_sysclk_init uses its argument for a division.
>>
> 
> --- ksrc/skins/vxworks/sysLib.c	(revision 3975)
> +++ ksrc/skins/vxworks/sysLib.c	(working copy)
> @@ -39,12 +39,12 @@
>  int wind_sysclk_init(u_long period)
>  {
>  	extern u_long sync_time;
> -	u_long init_rate = ONE_BILLION / period;
> +	u_long init_rate = period ? ONE_BILLION / period : XN_APERIODIC_TICK;
>  	int err;
> 
>  	err = xntbase_alloc("vxworks", period, sync_time ? 0 : XNTBISO,
>  			    &wind_tbase);
> -	if (err)
> +	if (err || period == 0)
>  		return err;
> 
>  	err = sysClkRateSet(init_rate);
> 

Ok, but what about sysClkRateGet then ? It is needed for conversion
between durations and ticks count. It will not work since sysClkRateSet
was not called, and we can not call sysClkRateSet since it would start
the timer.



-- 
                                                 Gilles.

