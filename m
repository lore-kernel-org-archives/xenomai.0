References: <cover.1620233588.git.jan.kiszka@siemens.com>
 <4dc1ffb5915931d49c3240d28b4b5fa8abd7eca8.1620233588.git.jan.kiszka@siemens.com>
 <779dcb98-37d4-80d7-9a40-c154ae9dff49@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH v2 1/9] cobalt/kernel: y2038: convert struct timespec to
 timespec64
In-reply-to: <779dcb98-37d4-80d7-9a40-c154ae9dff49@siemens.com>
Date: Fri, 07 May 2021 08:54:44 +0200
Message-ID: <87k0obqbij.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org


Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> On 05.05.21 18:53, Jan Kiszka via Xenomai wrote:
>> From: Philippe Gerum <rpm@xenomai.org>
>> 
>> As internal interfaces are gradually being made y2038-safe, the
>> timespec64 type should be used internally by the kernel to represent
>> time values. Apply the same reasoning to Cobalt.
>> 
>> We still use a legacy y2038-unsafe timespec type at the kernel<->user
>> interface boundary (struct __user_old_timespec) until libcobalt is
>> y2038-safe.
>> 
>> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>> [Florian: Fix regression in 32bit mode]
>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  include/cobalt/kernel/clock.h                 |  6 +-
>>  include/cobalt/kernel/compat.h                |  4 +-
>>  .../cobalt/kernel/dovetail/pipeline/clock.h   |  4 +-
>>  include/cobalt/kernel/ipipe/pipeline/clock.h  |  4 +-
>>  include/cobalt/kernel/rtdm/fd.h               |  2 +-
>>  include/cobalt/uapi/kernel/types.h            | 10 ++++
>>  include/cobalt/uapi/sched.h                   | 12 ++--
>>  .../include/asm-generic/xenomai/syscall.h     | 58 +++++++++++++++++++
>>  kernel/cobalt/ipipe/clock.c                   |  2 +-
>>  kernel/cobalt/posix/clock.c                   | 38 ++++++------
>>  kernel/cobalt/posix/clock.h                   | 39 +++++++++----
>>  kernel/cobalt/posix/compat.c                  | 46 ++++++++++-----
>>  kernel/cobalt/posix/cond.c                    | 11 ++--
>>  kernel/cobalt/posix/cond.h                    |  4 +-
>>  kernel/cobalt/posix/event.c                   |  8 +--
>>  kernel/cobalt/posix/event.h                   |  4 +-
>>  kernel/cobalt/posix/io.c                      |  6 +-
>>  kernel/cobalt/posix/io.h                      |  2 +-
>>  kernel/cobalt/posix/monitor.c                 |  8 +--
>>  kernel/cobalt/posix/monitor.h                 |  4 +-
>>  kernel/cobalt/posix/mqueue.c                  | 21 ++++---
>>  kernel/cobalt/posix/mqueue.h                  |  8 +--
>>  kernel/cobalt/posix/mutex.c                   | 13 ++---
>>  kernel/cobalt/posix/mutex.h                   |  6 +-
>>  kernel/cobalt/posix/sched.c                   | 16 ++---
>>  kernel/cobalt/posix/sem.c                     |  8 +--
>>  kernel/cobalt/posix/sem.h                     |  4 +-
>>  kernel/cobalt/posix/signal.c                  |  6 +-
>>  kernel/cobalt/posix/signal.h                  |  4 +-
>>  kernel/cobalt/posix/syscall32.c               | 26 ++++-----
>>  kernel/cobalt/posix/syscall32.h               |  2 +-
>>  kernel/cobalt/posix/thread.c                  |  6 +-
>>  kernel/cobalt/rtdm/fd.c                       |  4 +-
>>  kernel/cobalt/trace/cobalt-posix.h            | 30 +++++-----
>>  34 files changed, 262 insertions(+), 164 deletions(-)
>> 
>> diff --git a/include/cobalt/kernel/clock.h b/include/cobalt/kernel/clock.h
>> index bbf34c53cf..1c99173ff8 100644
>> --- a/include/cobalt/kernel/clock.h
>> +++ b/include/cobalt/kernel/clock.h
>> @@ -54,7 +54,7 @@ struct xnclock {
>>  		xnticks_t (*read_raw)(struct xnclock *clock);
>>  		xnticks_t (*read_monotonic)(struct xnclock *clock);
>>  		int (*set_time)(struct xnclock *clock,
>> -				const struct timespec *ts);
>> +				const struct timespec64 *ts);
>>  		xnsticks_t (*ns_to_ticks)(struct xnclock *clock,
>>  					  xnsticks_t ns);
>>  		xnsticks_t (*ticks_to_ns)(struct xnclock *clock,
>> @@ -211,7 +211,7 @@ static inline xnticks_t xnclock_read_monotonic(struct xnclock *clock)
>>  }
>>  
>>  static inline int xnclock_set_time(struct xnclock *clock,
>> -				   const struct timespec *ts)
>> +				   const struct timespec64 *ts)
>>  {
>>  	if (likely(clock == &nkclock))
>>  		return -EINVAL;
>> @@ -264,7 +264,7 @@ static inline xnticks_t xnclock_read_monotonic(struct xnclock *clock)
>>  }
>>  
>>  static inline int xnclock_set_time(struct xnclock *clock,
>> -				   const struct timespec *ts)
>> +				   const struct timespec64 *ts)
>>  {
>>  	/*
>>  	 * There is no way to change the core clock's idea of time.
>> diff --git a/include/cobalt/kernel/compat.h b/include/cobalt/kernel/compat.h
>> index 313b6251b4..c57ef65325 100644
>> --- a/include/cobalt/kernel/compat.h
>> +++ b/include/cobalt/kernel/compat.h
>> @@ -86,11 +86,11 @@ struct compat_rtdm_mmap_request {
>>  	int flags;
>>  };
>>  
>> -int sys32_get_timespec(struct timespec *ts,
>> +int sys32_get_timespec(struct timespec64 *ts,
>>  		       const struct compat_timespec __user *cts);
>>  
>>  int sys32_put_timespec(struct compat_timespec __user *cts,
>> -		       const struct timespec *ts);
>> +		       const struct timespec64 *ts);
>>  
>>  int sys32_get_itimerspec(struct itimerspec *its,
>>  			 const struct compat_itimerspec __user *cits);
>> diff --git a/include/cobalt/kernel/dovetail/pipeline/clock.h b/include/cobalt/kernel/dovetail/pipeline/clock.h
>> index 933e100baf..19e3d89865 100644
>> --- a/include/cobalt/kernel/dovetail/pipeline/clock.h
>> +++ b/include/cobalt/kernel/dovetail/pipeline/clock.h
>> @@ -8,7 +8,7 @@
>>  #include <cobalt/uapi/kernel/types.h>
>>  #include <cobalt/kernel/assert.h>
>>  
>> -struct timespec;
>> +struct timespec64;
>>  
>>  static inline u64 pipeline_read_cycle_counter(void)
>>  {
>> @@ -49,7 +49,7 @@ static inline const char *pipeline_clock_name(void)
>>  	return "?";
>>  }
>>  
>> -static inline int pipeline_get_host_time(struct timespec *tp)
>> +static inline int pipeline_get_host_time(struct timespec64 *tp)
>>  {
>>  	/* Convert ktime_get_real_fast_ns() to timespec. */
>>  	TODO();
>> diff --git a/include/cobalt/kernel/ipipe/pipeline/clock.h b/include/cobalt/kernel/ipipe/pipeline/clock.h
>> index fa7ac2a5e0..d35aea17b1 100644
>> --- a/include/cobalt/kernel/ipipe/pipeline/clock.h
>> +++ b/include/cobalt/kernel/ipipe/pipeline/clock.h
>> @@ -7,7 +7,7 @@
>>  
>>  #include <linux/ipipe_tickdev.h>
>>  
>> -struct timespec;
>> +struct timespec64;
>>  
>>  static inline u64 pipeline_read_cycle_counter(void)
>>  {
>> @@ -31,7 +31,7 @@ static inline const char *pipeline_clock_name(void)
>>  	return ipipe_clock_name();
>>  }
>>  
>> -int pipeline_get_host_time(struct timespec *tp);
>> +int pipeline_get_host_time(struct timespec64 *tp);
>>  
>>  void pipeline_update_clock_freq(unsigned long long freq);
>>  
>> diff --git a/include/cobalt/kernel/rtdm/fd.h b/include/cobalt/kernel/rtdm/fd.h
>> index 289065082b..37a09c43e8 100644
>> --- a/include/cobalt/kernel/rtdm/fd.h
>> +++ b/include/cobalt/kernel/rtdm/fd.h
>> @@ -380,7 +380,7 @@ int __rtdm_fd_recvmmsg(int ufd, void __user *u_msgvec, unsigned int vlen,
>>  		       unsigned int flags, void __user *u_timeout,
>>  		       int (*get_mmsg)(struct mmsghdr *mmsg, void __user *u_mmsg),
>>  		       int (*put_mmsg)(void __user **u_mmsg_p, const struct mmsghdr *mmsg),
>> -		       int (*get_timespec)(struct timespec *ts, const void __user *u_ts));
>> +		       int (*get_timespec)(struct timespec64 *ts, const void __user *u_ts));
>>  
>>  ssize_t rtdm_fd_sendmsg(int ufd, const struct user_msghdr *msg,
>>  			int flags);
>> diff --git a/include/cobalt/uapi/kernel/types.h b/include/cobalt/uapi/kernel/types.h
>> index ee5bbadcae..8ce9b03df4 100644
>> --- a/include/cobalt/uapi/kernel/types.h
>> +++ b/include/cobalt/uapi/kernel/types.h
>> @@ -57,4 +57,14 @@ static inline xnhandle_t xnhandle_get_id(xnhandle_t handle)
>>  	return handle & ~XN_HANDLE_TRANSIENT_MASK;
>>  }
>>  
>> +/*
>> + * Our representation of time at the kernel<->user interface boundary
>> + * at the moment, until we have fully transitioned to a y2038-safe
>> + * implementation in libcobalt.
>> + */
>> +struct __user_old_timespec {
>> +	long  tv_sec;
>> +	long  tv_nsec;
>> +};
>> +
>>  #endif /* !_COBALT_UAPI_KERNEL_TYPES_H */
>> diff --git a/include/cobalt/uapi/sched.h b/include/cobalt/uapi/sched.h
>> index b672095c3b..14095870f3 100644
>> --- a/include/cobalt/uapi/sched.h
>> +++ b/include/cobalt/uapi/sched.h
>> @@ -18,6 +18,8 @@
>>  #ifndef _COBALT_UAPI_SCHED_H
>>  #define _COBALT_UAPI_SCHED_H
>>  
>> +#include <cobalt/uapi/kernel/types.h>
>> +
>>  #define SCHED_COBALT		42
>>  #define SCHED_WEAK		43
>>  
>> @@ -31,15 +33,15 @@
>>  
>>  struct __sched_ss_param {
>>  	int __sched_low_priority;
>> -	struct timespec __sched_repl_period;
>> -	struct timespec __sched_init_budget;
>> +	struct __user_old_timespec __sched_repl_period;
>> +	struct __user_old_timespec __sched_init_budget;
>>  	int __sched_max_repl;
>>  };
>>  
>>  #define sched_rr_quantum	sched_u.rr.__sched_rr_quantum
>>  
>>  struct __sched_rr_param {
>> -	struct timespec __sched_rr_quantum;
>> +	struct __user_old_timespec __sched_rr_quantum;
>>  };
>>  
>>  #ifndef SCHED_TP
>> @@ -52,8 +54,8 @@ struct __sched_tp_param {
>>  };
>>  
>>  struct sched_tp_window {
>> -	struct timespec offset;
>> -	struct timespec duration;
>> +	struct __user_old_timespec offset;
>> +	struct __user_old_timespec duration;
>>  	int ptid;
>>  };
>>  
>> diff --git a/kernel/cobalt/include/asm-generic/xenomai/syscall.h b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
>> index 0d50d4107d..05a7d28685 100644
>> --- a/kernel/cobalt/include/asm-generic/xenomai/syscall.h
>> +++ b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
>> @@ -26,6 +26,7 @@
>>  #include <asm/xenomai/wrappers.h>
>>  #include <asm/xenomai/machine.h>
>>  #include <cobalt/uapi/asm-generic/syscall.h>
>> +#include <cobalt/uapi/kernel/types.h>
>>  
>>  #if LINUX_VERSION_CODE >= KERNEL_VERSION(5, 0, 0)
>>  #define access_rok(addr, size)	access_ok((addr), (size))
>> @@ -81,6 +82,63 @@ static inline int cobalt_strncpy_from_user(char *dst, const char __user *src,
>>  	return __xn_strncpy_from_user(dst, src, count);
>>  }
>>  
>> +#if __BITS_PER_LONG == 64
>> +
>> +/*
>> + * NOTE: those copy helpers won't work in compat mode: use
>> + * sys32_get_timespec(), sys32_put_timespec() instead.
>> + */
>> +
>> +static inline int cobalt_get_u_timespec(struct timespec64 *dst,
>> +			const struct __user_old_timespec __user *src)
>> +{
>> +	return cobalt_copy_from_user(dst, src, sizeof(*dst));
>> +}
>> +
>> +static inline int cobalt_put_u_timespec(
>> +	struct __user_old_timespec __user *dst,
>> +	const struct timespec64 *src)
>> +{
>> +	return cobalt_copy_to_user(dst, src, sizeof(*dst));
>> +}
>> +
>> +#else /* __BITS_PER_LONG == 32 */
>> +
>> +static inline int cobalt_get_u_timespec(struct timespec64 *dst,
>> +			const struct __user_old_timespec __user *src)
>> +{
>> +	struct __user_old_timespec u_ts;
>> +	int ret;
>> +
>> +	ret = cobalt_copy_from_user(&u_ts, src, sizeof(u_ts));
>> +	if (ret)
>> +		return ret;
>> +
>> +	dst->tv_sec = u_ts.tv_sec;
>> +	dst->tv_nsec = u_ts.tv_nsec;
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int cobalt_put_u_timespec(
>> +	struct __user_old_timespec __user *dst,
>> +	const struct timespec64 *src)
>> +{
>> +	struct __user_old_timespec u_ts;
>> +	int ret;
>> +
>> +	u_ts.tv_sec = src->tv_sec;
>> +	u_ts.tv_nsec = src->tv_nsec;
>> +
>> +	ret = cobalt_copy_to_user(dst, &u_ts, sizeof(*dst));
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +#endif
>> +
>
> IIRC I already mentioned that after the first post of this patch:
>
> The __BITS_PER_LONG == 32 version of that helpers work in both worlds.
> So if we don't care about a few additional element on the stack (and a
> few instructions) we could simplify the code a bit.
>

Please submit a patch on top of my queue which Jan is currently
upstreaming. Since I already agreed on this issue, let's be flexible.

-- 
Philippe.

