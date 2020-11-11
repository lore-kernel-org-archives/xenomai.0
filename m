Subject: Re: [PATCH 2/5] cobalt/kernel: introduce old_timespec32 to
 clock_settime
References: <1604372692-2850-1-git-send-email-chensong@tj.kylinos.cn>
 <670208b7-b221-e0fe-6aea-2d26c7564f76@siemens.com>
From: chensong <chensong@tj.kylinos.cn>
Message-ID: <5FAB58BF.8060707@tj.kylinos.cn>+4564338E5B021E63
Date: Wed, 11 Nov 2020 11:21:35 +0800
MIME-Version: 1.0
In-Reply-To: <670208b7-b221-e0fe-6aea-2d26c7564f76@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org, henning.schild@siemens.com



On 2020年11月10日 18:14, Jan Kiszka wrote:
>
> On 03.11.20 04:04, chensong wrote:
>> Replace timespec with old_timespec32 as the parameter passed from
>> processes with 32bit timespec in clock_settime.
>>
>> Also, replace timespec with timespec64 inside clock_settime.
>>
>> Signed-off-by: chensong <chensong@tj.kylinos.cn>
>> ---
>>   include/cobalt/kernel/clock.h      |  6 +++---
>>   kernel/cobalt/posix/clock.c        | 14 +++++++++-----
>>   kernel/cobalt/posix/clock.h        | 15 +++++++++++++--
>>   kernel/cobalt/trace/cobalt-posix.h | 24 ++++++++++++++++++++++--
>>   4 files changed, 47 insertions(+), 12 deletions(-)
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
>> diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
>> index 561358e..d169ffd 100644
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
>> @@ -243,14 +243,18 @@ int __cobalt_clock_adjtime(clockid_t clock_id, struct timex *tx)
>>   }
>>
>>   COBALT_SYSCALL(clock_settime, current,
>> -	       (clockid_t clock_id, const struct timespec __user *u_ts))
>> +	       (clockid_t clock_id, const struct old_timespec32 __user *u_ts))
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
>> diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
>> index aa78efb..f764872 100644
>> --- a/kernel/cobalt/trace/cobalt-posix.h
>> +++ b/kernel/cobalt/trace/cobalt-posix.h
>> @@ -748,6 +748,26 @@ DECLARE_EVENT_CLASS(cobalt_clock_timespec,
>>   	)
>>   );
>>
>> +DECLARE_EVENT_CLASS(cobalt_clock_timespec64,
>> +	TP_PROTO(clockid_t clk_id, const struct timespec64 *val),
>> +	TP_ARGS(clk_id, val),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(clockid_t, clk_id)
>> +		__timespec_fields(val)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->clk_id = clk_id;
>> +		__assign_timespec(val, val);
>> +	),
>> +
>> +	TP_printk("clock_id=%d timeval=(%ld.%09ld)",
>> +		  __entry->clk_id,
>> +		  __timespec_args(val)
>> +	)
>> +);
>> +
>>   DEFINE_EVENT(cobalt_clock_timespec, cobalt_clock_getres,
>>   	TP_PROTO(clockid_t clk_id, const struct timespec *res),
>>   	TP_ARGS(clk_id, res)
>> @@ -758,8 +778,8 @@ DEFINE_EVENT(cobalt_clock_timespec, cobalt_clock_gettime,
>>   	TP_ARGS(clk_id, time)
>>   );
>>
>> -DEFINE_EVENT(cobalt_clock_timespec, cobalt_clock_settime,
>> -	TP_PROTO(clockid_t clk_id, const struct timespec *time),
>> +DEFINE_EVENT(cobalt_clock_timespec64, cobalt_clock_settime,
>
> I don't think we need to rename this event. We just now ensure that it
> can now handle timespec64. If that came from a legacy 32-bit or a new
> 64-bit syscall will be traced via the cobalt syscall event.
>
I defined a new event class cobalt_clock_timespec64 specific for 
timespec64, it will hit a compiling mistake without it, here is the 
information:

kernel/xenomai/posix/clock.c:219:39: error: passing argument 2 of 
‘trace_cobalt_clock_settime’ from incompatible pointer type 
[-Werror=incompatible-pointer-types]
   trace_cobalt_clock_settime(clock_id, ts);

my idea is defining a new event class cobalt_clock_timespec64, and every
trace event(clock_settime, clock_gettime and clock_getres) goes to it 
and the original event class,cobalt_clock_timespec, will be removed 
eventually.

if i understand you correctly(If that came from a legacy 32-bit or a new
64-bit syscall will be traced via the cobalt syscall event), i just need 
to remove trace_cobalt_clock_settime from __cobalt_clock_settime?

chensong


>> +	TP_PROTO(clockid_t clk_id, const struct timespec64 *time),
>>   	TP_ARGS(clk_id, time)
>>   );
>>
>>
>
> Jan
>

