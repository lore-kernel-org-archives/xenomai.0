Subject: Re: [PATCH v2 1/3] [y2038]clock_settime:introduce old_timespec32 in
 clock_settime
References: <1605774986-4553-1-git-send-email-chensong@tj.kylinos.cn>
 <82cca45bd82473a3bb7a207474722d48017f3c96.camel@siemens.com>
From: chensong <chensong@tj.kylinos.cn>
Message-ID: <5FBB970B.8040204@tj.kylinos.cn>+B857558DFEF18DD0
Date: Mon, 23 Nov 2020 19:03:39 +0800
MIME-Version: 1.0
In-Reply-To: <82cca45bd82473a3bb7a207474722d48017f3c96.camel@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>



On 2020年11月19日 20:11, florian.bezdeka@siemens.com wrote:
> On Thu, 2020-11-19 at 16:36 +0800, chensong wrote:
>> old_timespec32 was introduced in vanilla kernel at version 4.19
>> for y2038, it replaces timespec in syscalls to keep compatibility
>> for 32bit timespec.
>>
>> In this patch, i follow it's idea, replace timespec with
>> old_timespec32 as the argument passed to clock_settime from user
>> space. Inside clock_settime, timespec is replaced by timespec64.
>>
>> V2:
>> 1, remove trace point trace_cobalt_clock_gettime.
>>
>> Signed-off-by: chensong <chensong@tj.kylinos.cn>
>> ---
>>   include/cobalt/kernel/clock.h                        |  6 +++---
>>   include/cobalt/kernel/compat.h                       |  3 +++
>>   kernel/cobalt/include/asm-generic/xenomai/wrappers.h |  9 +++++++++
>>   kernel/cobalt/posix/clock.c                          | 16 +++++++++-------
>>   kernel/cobalt/posix/clock.h                          | 15 +++++++++++++--
>>   kernel/cobalt/posix/compat.c                         | 10 ++++++++++
>>   kernel/cobalt/posix/syscall32.c                      |  6 +++---
>>   kernel/cobalt/posix/syscall32.h                      |  2 +-
>>   8 files changed, 51 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/cobalt/kernel/clock.h b/include/cobalt/kernel/clock.h
>> index c26776a..cf9d5ec 100644
>> --- a/include/cobalt/kernel/clock.h
>> +++ b/include/cobalt/kernel/clock.h
>> @@ -52,7 +52,7 @@ struct xnclock {
>>   		xnticks_t (*read_raw)(struct xnclock *clock);
>>   		xnticks_t (*read_monotonic)(struct xnclock *clock);
>>   		int (*set_time)(struct xnclock *clock,
>> -				const struct timespec *ts);
>> +				const struct timespec64 *ts);
>>   		xnsticks_t (*ns_to_ticks)(struct xnclock *clock,
>>   					  xnsticks_t ns);
>>   		xnsticks_t (*ticks_to_ns)(struct xnclock *clock,
>> @@ -213,7 +213,7 @@ static inline xnticks_t xnclock_read_monotonic(struct xnclock *clock)
>>   }
>>
>>   static inline int xnclock_set_time(struct xnclock *clock,
>> -				   const struct timespec *ts)
>> +				   const struct timespec64 *ts)
>>   {
>>   	if (likely(clock == &nkclock))
>>   		return -EINVAL;
>> @@ -266,7 +266,7 @@ static inline xnticks_t xnclock_read_monotonic(struct xnclock *clock)
>>   }
>>
>>   static inline int xnclock_set_time(struct xnclock *clock,
>> -				   const struct timespec *ts)
>> +				   const struct timespec64 *ts)
>>   {
>>   	/*
>>   	 * There is no way to change the core clock's idea of time.
>> diff --git a/include/cobalt/kernel/compat.h b/include/cobalt/kernel/compat.h
>> index 05754cb..c3a6b4f 100644
>> --- a/include/cobalt/kernel/compat.h
>> +++ b/include/cobalt/kernel/compat.h
>> @@ -89,6 +89,9 @@ struct compat_rtdm_mmap_request {
>>   int sys32_get_timespec(struct timespec *ts,
>>   		       const struct compat_timespec __user *cts);
>>
>> +int sys32_get_timespec_old(struct timespec64 *ts,
>> +		       const struct old_timespec32 __user *cts);
>> +
>>   int sys32_put_timespec(struct compat_timespec __user *cts,
>>   		       const struct timespec *ts);
>>
>> diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
>> index 23993dc..07faa26 100644
>> --- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
>> +++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
>> @@ -156,4 +156,13 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
>>   #error "Xenomai/cobalt requires Linux kernel 3.10 or above"
>>   #endif /* < 3.10 */
>>
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 19, 0)
>> +typedef s32		old_time32_t;
>> +
>> +struct old_timespec32 {
>> +	old_time32_t	tv_sec;
>> +	s32		tv_nsec;
>> +};
>> +#endif /* < 4.19 */
>> +
>>   #endif /* _COBALT_ASM_GENERIC_WRAPPERS_H */
>> diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
>> index 561358e..5fbfbfd 100644
>> --- a/kernel/cobalt/posix/clock.c
>> +++ b/kernel/cobalt/posix/clock.c
>> @@ -194,7 +194,7 @@ COBALT_SYSCALL(clock_gettime, current,
>>   	return 0;
>>   }
>>
>> -int __cobalt_clock_settime(clockid_t clock_id, const struct timespec *ts)
>> +int __cobalt_clock_settime(clockid_t clock_id, const struct timespec64 *ts)
>>   {
>>   	int _ret, ret = 0;
>>   	xnticks_t now;
>> @@ -207,7 +207,7 @@ int __cobalt_clock_settime(clockid_t clock_id, const struct timespec *ts)
>>   	case CLOCK_REALTIME:
>>   		xnlock_get_irqsave(&nklock, s);
>>   		now = xnclock_read_realtime(&nkclock);
>> -		xnclock_adjust(&nkclock, (xnsticks_t) (ts2ns(ts) - now));
>> +		xnclock_adjust(&nkclock, (xnsticks_t) (ts2ns64(ts) - now));
>>   		xnlock_put_irqrestore(&nklock, s);
>>   		break;
>>   	default:
>> @@ -216,8 +216,6 @@ int __cobalt_clock_settime(clockid_t clock_id, const struct timespec *ts)
>>   			return _ret ?: ret;
>>   	}
>>
>> -	trace_cobalt_clock_settime(clock_id, ts);
>> -
>>   	return 0;
>>   }
>>
>> @@ -243,14 +241,18 @@ int __cobalt_clock_adjtime(clockid_t clock_id, struct timex *tx)
>>   }
>>
>>   COBALT_SYSCALL(clock_settime, current,
>> -	       (clockid_t clock_id, const struct timespec __user *u_ts))
>> +	       (clockid_t clock_id, const struct old_timespec32 __user *u_ts))
>
> Sorry, but that's wrong.
>
> Consider a 64 bit kernel (where the internal data type was "long", so
> 64 bit): It is now changed to a 32 bit data type (s32), which is wrong.

yes, it's correct.
If i just leave the argument as timespec, like what you said "untouch", 
and implement clock_settime64 specific for timespec64, how does it sound 
to you?

>
> I guess you are following a pattern from Arnd Bergmann which cannot be
> applied here. The patch from Arnd may look as he was updating the "old"
> syscall but he was introducing a new one instead.
>

Arnd Bergmann's solution is clear, one is for 32bit, the other is for 
64bit.
If we keep clock_settime(const struct timespec __user *u_ts) untouched, 
in 64bit kernel, timespect is 64bit, in 32bit, timespec is 32bit, it can 
handle both of them although it's a little blurry.
If in 32bit kernel, a process with 64bit timespec, it must have been 
recompiled, which mean libcobalt is new and be able to redirect syscall 
to 64bit variant.
Is it ok for you?

> The introduction may be hidden because he did some magic in the syscall
> table. The position / index of the syscall changed. So he was not
> updating an existing one but adding a new one...
>
> All "old" syscalls, so the native ones (which were 32 for 32 bit
> systems) have a "32" suffix now, so "clock_gettime32".
>
> Instead of upating existing Cobalt syscalls we have to introduce a new
> set of syscalls.
>>   {
>> -	struct timespec ts;
>> +	struct old_timespec32 ts;
>> +	struct timespec64 ts64;
>>
>>   	if (cobalt_copy_from_user(&ts, u_ts, sizeof(ts)))
>>   		return -EFAULT;
>>
>> -	return __cobalt_clock_settime(clock_id, &ts);
>> +	ts64.tv_sec  = ts.tv_sec;
>> +	ts64.tv_nsec = ts.tv_nsec;
>> +
>> +	return __cobalt_clock_settime(clock_id, &ts64);
>>   }
>>
>>   COBALT_SYSCALL(clock_adjtime, current,
>> diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
>> index 0b06b93..bcc608e 100644
>> --- a/kernel/cobalt/posix/clock.h
>> +++ b/kernel/cobalt/posix/clock.h
>> @@ -43,6 +43,16 @@ static inline xnticks_t ts2ns(const struct timespec *ts)
>>   	return nsecs;
>>   }
>>
>> +static inline xnticks_t ts2ns64(const struct timespec64 *ts)
>> +{
>> +	xnticks_t nsecs = ts->tv_nsec;
>> +
>> +	if (ts->tv_sec)
>> +		nsecs += (xnticks_t)ts->tv_sec * ONE_BILLION;
>> +
>> +	return nsecs;
>> +}
>> +
>>   static inline xnticks_t tv2ns(const struct timeval *tv)
>>   {
>>   	xnticks_t nsecs = tv->tv_usec * 1000;
>> @@ -86,7 +96,7 @@ int __cobalt_clock_gettime(clockid_t clock_id,
>>   			   struct timespec *ts);
>>
>>   int __cobalt_clock_settime(clockid_t clock_id,
>> -			   const struct timespec *ts);
>> +			   const struct timespec64 *ts);
>>
>>   int __cobalt_clock_adjtime(clockid_t clock_id,
>>   			   struct timex *tx);
>> @@ -102,7 +112,8 @@ COBALT_SYSCALL_DECL(clock_gettime,
>>   		    (clockid_t clock_id, struct timespec __user *u_ts));
>>
>>   COBALT_SYSCALL_DECL(clock_settime,
>> -		    (clockid_t clock_id, const struct timespec __user *u_ts));
>> +		    (clockid_t clock_id,
>> +			 const struct old_timespec32 __user *u_ts));
>>
>>   COBALT_SYSCALL_DECL(clock_adjtime,
>>   		    (clockid_t clock_id, struct timex __user *u_tx));
>> diff --git a/kernel/cobalt/posix/compat.c b/kernel/cobalt/posix/compat.c
>> index 17968bf..63df3b0 100644
>> --- a/kernel/cobalt/posix/compat.c
>> +++ b/kernel/cobalt/posix/compat.c
>> @@ -32,6 +32,16 @@ int sys32_get_timespec(struct timespec *ts,
>>   }
>>   EXPORT_SYMBOL_GPL(sys32_get_timespec);
>>
>> +int sys32_get_timespec_old(struct timespec64 *ts,
>> +		       const struct old_timespec32 __user *cts)
>> +{
>> +	return (cts == NULL ||
>> +		!access_rok(cts, sizeof(*cts)) ||
>> +		__xn_get_user(ts->tv_sec, &cts->tv_sec) ||
>> +		__xn_get_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
>> +}
>> +EXPORT_SYMBOL_GPL(sys32_get_timespec_old);
>> +
>>   int sys32_put_timespec(struct compat_timespec __user *cts,
>>   		       const struct timespec *ts)
>>   {
>> diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
>> index faa7ef5..5b317f8 100644
>> --- a/kernel/cobalt/posix/syscall32.c
>> +++ b/kernel/cobalt/posix/syscall32.c
>> @@ -159,12 +159,12 @@ COBALT_SYSCALL32emu(clock_gettime, current,
>>
>>   COBALT_SYSCALL32emu(clock_settime, current,
>>   		    (clockid_t clock_id,
>> -		     const struct compat_timespec __user *u_ts))
>> +		     const struct old_timespec32 __user *u_ts))
>>   {
>> -	struct timespec ts;
>> +	struct timespec64 ts;
>>   	int ret;
>>
>> -	ret = sys32_get_timespec(&ts, u_ts);
>> +	ret = sys32_get_timespec_old(&ts, u_ts);
>>   	if (ret)
>>   		return ret;
>>
>> diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
>> index 34904f9..c2834ad 100644
>> --- a/kernel/cobalt/posix/syscall32.h
>> +++ b/kernel/cobalt/posix/syscall32.h
>> @@ -61,7 +61,7 @@ COBALT_SYSCALL32emu_DECL(clock_gettime,
>>
>>   COBALT_SYSCALL32emu_DECL(clock_settime,
>>   			 (clockid_t clock_id,
>> -			  const struct compat_timespec __user *u_ts));
>> +			  const struct old_timespec32 __user *u_ts));
>>
>>   COBALT_SYSCALL32emu_DECL(clock_adjtime,
>>   			 (clockid_t clock_id,

