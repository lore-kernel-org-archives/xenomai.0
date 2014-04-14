Message-ID: <534BD044.9010400@mail.de>
Date: Mon, 14 Apr 2014 14:10:44 +0200
From: Ralf <ralf.moder@mail.de>
MIME-Version: 1.0
References: <5334334D.4050300@mail.de> <53352740.3060900@mail.de>
 <534B8669.2050904@mail.de> <534B94E1.1000408@xenomai.org>
In-Reply-To: <534B94E1.1000408@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] error / bugfix in ipipe-core-3-10.28-powerpc-1.patch
 (from eldk 5.5, company denx)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

Am 14.04.2014 09:57, schrieb Philippe Gerum:
> On 04/14/2014 08:55 AM, Ralf wrote:
>> Am 28.03.2014 08:39, schrieb Ralf:
>>> Hello,
>>>
>>> i have found an error in the ipipe-patch above.
>>> Here ist the error description:
>>>
>>> Our system:
>>> Linux 3.10.28 with xenomai 2.6 patch on a PowerPC MPC5200
>>>
>>> Error description:
>>> We use the xenomai-(posix-skin-)function clock_gettime(
>>> CLOCK_HOST_REALTIME, ..) to read out our system time. Thus, we set up a
>>> NTP clock that runs on an FPGA. Later, we compare the system time and
>>> NTP time deviations. Unfortunately we recognize in any comparison with
>>> the nanoseconds a deviation of at least 100 million nsecs. We then
>>> started the xenomai test suite and get the following prints on our console:
>>>
> [snip]
>
>>> tk_xtime() makes a shift to the right on the nanoseconds. This shift is
>>> at our clock source 24. If this shift now run twice consecutively, that
>>> explains naturally why we only get the most significant 8 bits of the
>>> nanosecond value.
>>>
>>> a fix that might solve the problem, looks like this
>>>
>>> void ipipe_update_hostrt(struct timekeeper *tk)
>>> {
>>>      struct ipipe_hostrt_data data;
>>>      struct timespec xt;
>>>
>>> //     xt = tk_xtime(tk);
>>>      ipipe_root_only();
>>>      data.live = 1;
>>>      data.cycle_last = tk->clock->cycle_last;
>>>      data.mask = tk->clock->mask;
>>>      data.mult = tk->mult;
>>>      data.shift = tk->shift;
>>>      data.wall_time_sec = tk->xtime_sec;
>>>      data.wall_time_nsec = (long)tk->xtime_nsec;
>>>      data.wall_to_monotonic = tk->wall_to_monotonic;
>>>      __ipipe_notify_kevent(IPIPE_KEVT_HOSTRT, &data);
>>> }
>>>
>> Has anyone observed the same thing? Do you think that bugfix correct?
>> How can i bring it into mainline? I would be very grateful for some help.
>>
> Good catch, thanks. This bug is introduced by a work-around specific to the few architectures which do not implement the newest VSYSCALL interface yet, like powerpc. However, the suggested change would break others which do, could you test the patch below instead? TIA,
>
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index e1214ba..5b01356 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -749,7 +749,7 @@ static cycle_t timebase_read(struct clocksource *cs)
>   * API.
>   */
>  static inline void update_hostrt(struct timespec *wall_time, struct timespec *wtm,
> -				 struct clocksource *clock, u32 mult)
> +				 struct clocksource *clock, u32 mult, u32 shift)
>  {
>  	/*
>  	 * This is a temporary work-around until powerpc implements
> @@ -761,7 +761,7 @@ static inline void update_hostrt(struct timespec *wall_time, struct timespec *wt
>  		.shift = clock->shift,
>  		.mult = mult,
>  		.xtime_sec = wall_time->tv_sec,
> -		.xtime_nsec = wall_time->tv_nsec,
> +		.xtime_nsec = wall_time->tv_nsec << shift,
Unfortunately, this solution does not work on our powerpc, because
"wall_time->tv_nsec" is only a 32 bit value and "xtime_nsec" a 64 bit
value. It seems that the shift on the 32 bit value happens first and
only then the assignment to the 64 bit value. So the shifted bits
greater than 32 bit are lost.
A cast avoids this problem:

                        .xtime_nsec = (u64)wall_time->tv_nsec << shift;

After that everything works well.
>  		.wall_to_monotonic = *wtm,
>  	};
>  
> @@ -771,7 +771,7 @@ static inline void update_hostrt(struct timespec *wall_time, struct timespec *wt
>  #endif
>  
>  void update_vsyscall_old(struct timespec *wall_time, struct timespec *wtm,
> -			struct clocksource *clock, u32 mult)
> +			 struct clocksource *clock, u32 mult, u32 shift)
>  {
>  	u64 new_tb_to_xs, new_stamp_xsec;
>  	u32 frac_sec;
> @@ -814,7 +814,7 @@ void update_vsyscall_old(struct timespec *wall_time, struct timespec *wtm,
>  	smp_wmb();
>  	++(vdso_data->tb_update_count);
>  
> -	update_hostrt(wall_time, wtm, clock, mult);
> +	update_hostrt(wall_time, wtm, clock, mult, shift);
>  }
>  
>  void update_vsyscall_tz(void)
> diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_internal.h
> index c1825eb..93ee8d6 100644
> --- a/include/linux/timekeeper_internal.h
> +++ b/include/linux/timekeeper_internal.h
> @@ -89,7 +89,7 @@ extern void update_vsyscall_tz(void);
>  #elif defined(CONFIG_GENERIC_TIME_VSYSCALL_OLD)
>  
>  extern void update_vsyscall_old(struct timespec *ts, struct timespec *wtm,
> -				struct clocksource *c, u32 mult);
> +				struct clocksource *c, u32 mult, u32 shift);
>  extern void update_vsyscall_tz(void);
>  
>  static inline void update_vsyscall(struct timekeeper *tk)
> @@ -97,7 +97,7 @@ static inline void update_vsyscall(struct timekeeper *tk)
>  	struct timespec xt;
>  
>  	xt = tk_xtime(tk);
> -	update_vsyscall_old(&xt, &tk->wall_to_monotonic, tk->clock, tk->mult);
> +	update_vsyscall_old(&xt, &tk->wall_to_monotonic, tk->clock, tk->mult, tk->shift);
>  }
>  
>  #else
>


