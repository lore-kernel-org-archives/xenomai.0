Subject: Re: [PATCH v2 1/9] cobalt/kernel: y2038: convert struct timespec to
 timespec64
References: <cover.1620233588.git.jan.kiszka@siemens.com>
 <4dc1ffb5915931d49c3240d28b4b5fa8abd7eca8.1620233588.git.jan.kiszka@siemens.com>
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Message-ID: <779dcb98-37d4-80d7-9a40-c154ae9dff49@siemens.com>
Date: Fri, 7 May 2021 08:09:05 +0200
In-Reply-To: <4dc1ffb5915931d49c3240d28b4b5fa8abd7eca8.1620233588.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

On 05.05.21 18:53, Jan Kiszka via Xenomai wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> As internal interfaces are gradually being made y2038-safe, the
> timespec64 type should be used internally by the kernel to represent
> time values. Apply the same reasoning to Cobalt.
> 
> We still use a legacy y2038-unsafe timespec type at the kernel<->user
> interface boundary (struct __user_old_timespec) until libcobalt is
> y2038-safe.
> 
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> [Florian: Fix regression in 32bit mode]
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  include/cobalt/kernel/clock.h                 |  6 +-
>  include/cobalt/kernel/compat.h                |  4 +-
>  .../cobalt/kernel/dovetail/pipeline/clock.h   |  4 +-
>  include/cobalt/kernel/ipipe/pipeline/clock.h  |  4 +-
>  include/cobalt/kernel/rtdm/fd.h               |  2 +-
>  include/cobalt/uapi/kernel/types.h            | 10 ++++
>  include/cobalt/uapi/sched.h                   | 12 ++--
>  .../include/asm-generic/xenomai/syscall.h     | 58 +++++++++++++++++++
>  kernel/cobalt/ipipe/clock.c                   |  2 +-
>  kernel/cobalt/posix/clock.c                   | 38 ++++++------
>  kernel/cobalt/posix/clock.h                   | 39 +++++++++----
>  kernel/cobalt/posix/compat.c                  | 46 ++++++++++-----
>  kernel/cobalt/posix/cond.c                    | 11 ++--
>  kernel/cobalt/posix/cond.h                    |  4 +-
>  kernel/cobalt/posix/event.c                   |  8 +--
>  kernel/cobalt/posix/event.h                   |  4 +-
>  kernel/cobalt/posix/io.c                      |  6 +-
>  kernel/cobalt/posix/io.h                      |  2 +-
>  kernel/cobalt/posix/monitor.c                 |  8 +--
>  kernel/cobalt/posix/monitor.h                 |  4 +-
>  kernel/cobalt/posix/mqueue.c                  | 21 ++++---
>  kernel/cobalt/posix/mqueue.h                  |  8 +--
>  kernel/cobalt/posix/mutex.c                   | 13 ++---
>  kernel/cobalt/posix/mutex.h                   |  6 +-
>  kernel/cobalt/posix/sched.c                   | 16 ++---
>  kernel/cobalt/posix/sem.c                     |  8 +--
>  kernel/cobalt/posix/sem.h                     |  4 +-
>  kernel/cobalt/posix/signal.c                  |  6 +-
>  kernel/cobalt/posix/signal.h                  |  4 +-
>  kernel/cobalt/posix/syscall32.c               | 26 ++++-----
>  kernel/cobalt/posix/syscall32.h               |  2 +-
>  kernel/cobalt/posix/thread.c                  |  6 +-
>  kernel/cobalt/rtdm/fd.c                       |  4 +-
>  kernel/cobalt/trace/cobalt-posix.h            | 30 +++++-----
>  34 files changed, 262 insertions(+), 164 deletions(-)
> 
> diff --git a/include/cobalt/kernel/clock.h b/include/cobalt/kernel/clock.h
> index bbf34c53cf..1c99173ff8 100644
> --- a/include/cobalt/kernel/clock.h
> +++ b/include/cobalt/kernel/clock.h
> @@ -54,7 +54,7 @@ struct xnclock {
>  		xnticks_t (*read_raw)(struct xnclock *clock);
>  		xnticks_t (*read_monotonic)(struct xnclock *clock);
>  		int (*set_time)(struct xnclock *clock,
> -				const struct timespec *ts);
> +				const struct timespec64 *ts);
>  		xnsticks_t (*ns_to_ticks)(struct xnclock *clock,
>  					  xnsticks_t ns);
>  		xnsticks_t (*ticks_to_ns)(struct xnclock *clock,
> @@ -211,7 +211,7 @@ static inline xnticks_t xnclock_read_monotonic(struct xnclock *clock)
>  }
>  
>  static inline int xnclock_set_time(struct xnclock *clock,
> -				   const struct timespec *ts)
> +				   const struct timespec64 *ts)
>  {
>  	if (likely(clock == &nkclock))
>  		return -EINVAL;
> @@ -264,7 +264,7 @@ static inline xnticks_t xnclock_read_monotonic(struct xnclock *clock)
>  }
>  
>  static inline int xnclock_set_time(struct xnclock *clock,
> -				   const struct timespec *ts)
> +				   const struct timespec64 *ts)
>  {
>  	/*
>  	 * There is no way to change the core clock's idea of time.
> diff --git a/include/cobalt/kernel/compat.h b/include/cobalt/kernel/compat.h
> index 313b6251b4..c57ef65325 100644
> --- a/include/cobalt/kernel/compat.h
> +++ b/include/cobalt/kernel/compat.h
> @@ -86,11 +86,11 @@ struct compat_rtdm_mmap_request {
>  	int flags;
>  };
>  
> -int sys32_get_timespec(struct timespec *ts,
> +int sys32_get_timespec(struct timespec64 *ts,
>  		       const struct compat_timespec __user *cts);
>  
>  int sys32_put_timespec(struct compat_timespec __user *cts,
> -		       const struct timespec *ts);
> +		       const struct timespec64 *ts);
>  
>  int sys32_get_itimerspec(struct itimerspec *its,
>  			 const struct compat_itimerspec __user *cits);
> diff --git a/include/cobalt/kernel/dovetail/pipeline/clock.h b/include/cobalt/kernel/dovetail/pipeline/clock.h
> index 933e100baf..19e3d89865 100644
> --- a/include/cobalt/kernel/dovetail/pipeline/clock.h
> +++ b/include/cobalt/kernel/dovetail/pipeline/clock.h
> @@ -8,7 +8,7 @@
>  #include <cobalt/uapi/kernel/types.h>
>  #include <cobalt/kernel/assert.h>
>  
> -struct timespec;
> +struct timespec64;
>  
>  static inline u64 pipeline_read_cycle_counter(void)
>  {
> @@ -49,7 +49,7 @@ static inline const char *pipeline_clock_name(void)
>  	return "?";
>  }
>  
> -static inline int pipeline_get_host_time(struct timespec *tp)
> +static inline int pipeline_get_host_time(struct timespec64 *tp)
>  {
>  	/* Convert ktime_get_real_fast_ns() to timespec. */
>  	TODO();
> diff --git a/include/cobalt/kernel/ipipe/pipeline/clock.h b/include/cobalt/kernel/ipipe/pipeline/clock.h
> index fa7ac2a5e0..d35aea17b1 100644
> --- a/include/cobalt/kernel/ipipe/pipeline/clock.h
> +++ b/include/cobalt/kernel/ipipe/pipeline/clock.h
> @@ -7,7 +7,7 @@
>  
>  #include <linux/ipipe_tickdev.h>
>  
> -struct timespec;
> +struct timespec64;
>  
>  static inline u64 pipeline_read_cycle_counter(void)
>  {
> @@ -31,7 +31,7 @@ static inline const char *pipeline_clock_name(void)
>  	return ipipe_clock_name();
>  }
>  
> -int pipeline_get_host_time(struct timespec *tp);
> +int pipeline_get_host_time(struct timespec64 *tp);
>  
>  void pipeline_update_clock_freq(unsigned long long freq);
>  
> diff --git a/include/cobalt/kernel/rtdm/fd.h b/include/cobalt/kernel/rtdm/fd.h
> index 289065082b..37a09c43e8 100644
> --- a/include/cobalt/kernel/rtdm/fd.h
> +++ b/include/cobalt/kernel/rtdm/fd.h
> @@ -380,7 +380,7 @@ int __rtdm_fd_recvmmsg(int ufd, void __user *u_msgvec, unsigned int vlen,
>  		       unsigned int flags, void __user *u_timeout,
>  		       int (*get_mmsg)(struct mmsghdr *mmsg, void __user *u_mmsg),
>  		       int (*put_mmsg)(void __user **u_mmsg_p, const struct mmsghdr *mmsg),
> -		       int (*get_timespec)(struct timespec *ts, const void __user *u_ts));
> +		       int (*get_timespec)(struct timespec64 *ts, const void __user *u_ts));
>  
>  ssize_t rtdm_fd_sendmsg(int ufd, const struct user_msghdr *msg,
>  			int flags);
> diff --git a/include/cobalt/uapi/kernel/types.h b/include/cobalt/uapi/kernel/types.h
> index ee5bbadcae..8ce9b03df4 100644
> --- a/include/cobalt/uapi/kernel/types.h
> +++ b/include/cobalt/uapi/kernel/types.h
> @@ -57,4 +57,14 @@ static inline xnhandle_t xnhandle_get_id(xnhandle_t handle)
>  	return handle & ~XN_HANDLE_TRANSIENT_MASK;
>  }
>  
> +/*
> + * Our representation of time at the kernel<->user interface boundary
> + * at the moment, until we have fully transitioned to a y2038-safe
> + * implementation in libcobalt.
> + */
> +struct __user_old_timespec {
> +	long  tv_sec;
> +	long  tv_nsec;
> +};
> +
>  #endif /* !_COBALT_UAPI_KERNEL_TYPES_H */
> diff --git a/include/cobalt/uapi/sched.h b/include/cobalt/uapi/sched.h
> index b672095c3b..14095870f3 100644
> --- a/include/cobalt/uapi/sched.h
> +++ b/include/cobalt/uapi/sched.h
> @@ -18,6 +18,8 @@
>  #ifndef _COBALT_UAPI_SCHED_H
>  #define _COBALT_UAPI_SCHED_H
>  
> +#include <cobalt/uapi/kernel/types.h>
> +
>  #define SCHED_COBALT		42
>  #define SCHED_WEAK		43
>  
> @@ -31,15 +33,15 @@
>  
>  struct __sched_ss_param {
>  	int __sched_low_priority;
> -	struct timespec __sched_repl_period;
> -	struct timespec __sched_init_budget;
> +	struct __user_old_timespec __sched_repl_period;
> +	struct __user_old_timespec __sched_init_budget;
>  	int __sched_max_repl;
>  };
>  
>  #define sched_rr_quantum	sched_u.rr.__sched_rr_quantum
>  
>  struct __sched_rr_param {
> -	struct timespec __sched_rr_quantum;
> +	struct __user_old_timespec __sched_rr_quantum;
>  };
>  
>  #ifndef SCHED_TP
> @@ -52,8 +54,8 @@ struct __sched_tp_param {
>  };
>  
>  struct sched_tp_window {
> -	struct timespec offset;
> -	struct timespec duration;
> +	struct __user_old_timespec offset;
> +	struct __user_old_timespec duration;
>  	int ptid;
>  };
>  
> diff --git a/kernel/cobalt/include/asm-generic/xenomai/syscall.h b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
> index 0d50d4107d..05a7d28685 100644
> --- a/kernel/cobalt/include/asm-generic/xenomai/syscall.h
> +++ b/kernel/cobalt/include/asm-generic/xenomai/syscall.h
> @@ -26,6 +26,7 @@
>  #include <asm/xenomai/wrappers.h>
>  #include <asm/xenomai/machine.h>
>  #include <cobalt/uapi/asm-generic/syscall.h>
> +#include <cobalt/uapi/kernel/types.h>
>  
>  #if LINUX_VERSION_CODE >= KERNEL_VERSION(5, 0, 0)
>  #define access_rok(addr, size)	access_ok((addr), (size))
> @@ -81,6 +82,63 @@ static inline int cobalt_strncpy_from_user(char *dst, const char __user *src,
>  	return __xn_strncpy_from_user(dst, src, count);
>  }
>  
> +#if __BITS_PER_LONG == 64
> +
> +/*
> + * NOTE: those copy helpers won't work in compat mode: use
> + * sys32_get_timespec(), sys32_put_timespec() instead.
> + */
> +
> +static inline int cobalt_get_u_timespec(struct timespec64 *dst,
> +			const struct __user_old_timespec __user *src)
> +{
> +	return cobalt_copy_from_user(dst, src, sizeof(*dst));
> +}
> +
> +static inline int cobalt_put_u_timespec(
> +	struct __user_old_timespec __user *dst,
> +	const struct timespec64 *src)
> +{
> +	return cobalt_copy_to_user(dst, src, sizeof(*dst));
> +}
> +
> +#else /* __BITS_PER_LONG == 32 */
> +
> +static inline int cobalt_get_u_timespec(struct timespec64 *dst,
> +			const struct __user_old_timespec __user *src)
> +{
> +	struct __user_old_timespec u_ts;
> +	int ret;
> +
> +	ret = cobalt_copy_from_user(&u_ts, src, sizeof(u_ts));
> +	if (ret)
> +		return ret;
> +
> +	dst->tv_sec = u_ts.tv_sec;
> +	dst->tv_nsec = u_ts.tv_nsec;
> +
> +	return 0;
> +}
> +
> +static inline int cobalt_put_u_timespec(
> +	struct __user_old_timespec __user *dst,
> +	const struct timespec64 *src)
> +{
> +	struct __user_old_timespec u_ts;
> +	int ret;
> +
> +	u_ts.tv_sec = src->tv_sec;
> +	u_ts.tv_nsec = src->tv_nsec;
> +
> +	ret = cobalt_copy_to_user(dst, &u_ts, sizeof(*dst));
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +#endif
> +

IIRC I already mentioned that after the first post of this patch:

The __BITS_PER_LONG == 32 version of that helpers work in both worlds.
So if we don't care about a few additional element on the stack (and a
few instructions) we could simplify the code a bit.


>  /* 32bit syscall emulation */
>  #define __COBALT_COMPAT_BIT	0x1
>  /* 32bit syscall emulation - extended form */
> diff --git a/kernel/cobalt/ipipe/clock.c b/kernel/cobalt/ipipe/clock.c
> index 606c6bf8c0..d40b0ac890 100644
> --- a/kernel/cobalt/ipipe/clock.c
> +++ b/kernel/cobalt/ipipe/clock.c
> @@ -67,7 +67,7 @@ EXPORT_SYMBOL_GPL(xnclock_core_ticks_to_ns);
>  EXPORT_SYMBOL_GPL(xnclock_core_ticks_to_ns_rounded);
>  EXPORT_SYMBOL_GPL(xnclock_core_ns_to_ticks);
>  
> -int pipeline_get_host_time(struct timespec *tp)
> +int pipeline_get_host_time(struct timespec64 *tp)
>  {
>  #ifdef CONFIG_IPIPE_HAVE_HOSTRT
>  	struct xnvdso_hostrt_data *hostrt_data;
> diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
> index e957dd9569..4a3365d2a9 100644
> --- a/kernel/cobalt/posix/clock.c
> +++ b/kernel/cobalt/posix/clock.c
> @@ -51,7 +51,7 @@ DECLARE_BITMAP(cobalt_clock_extids, COBALT_MAX_EXTCLOCKS);
>  	__val;							\
>  })
>  
> -int __cobalt_clock_getres(clockid_t clock_id, struct timespec *ts)
> +int __cobalt_clock_getres(clockid_t clock_id, struct timespec64 *ts)
>  {
>  	xnticks_t ns;
>  	int ret;
> @@ -75,16 +75,16 @@ int __cobalt_clock_getres(clockid_t clock_id, struct timespec *ts)
>  }
>  
>  COBALT_SYSCALL(clock_getres, current,
> -	       (clockid_t clock_id, struct timespec __user *u_ts))
> +	       (clockid_t clock_id, struct __user_old_timespec __user *u_ts))
>  {
> -	struct timespec ts;
> +	struct timespec64 ts;
>  	int ret;
>  
>  	ret = __cobalt_clock_getres(clock_id, &ts);
>  	if (ret)
>  		return ret;
>  
> -	if (u_ts && cobalt_copy_to_user(u_ts, &ts, sizeof(ts)))
> +	if (u_ts && cobalt_put_u_timespec(u_ts, &ts))
>  		return -EFAULT;
>  
>  	trace_cobalt_clock_getres(clock_id, &ts);
> @@ -92,7 +92,7 @@ COBALT_SYSCALL(clock_getres, current,
>  	return 0;
>  }
>  
> -int __cobalt_clock_gettime(clockid_t clock_id, struct timespec *ts)
> +int __cobalt_clock_gettime(clockid_t clock_id, struct timespec64 *ts)
>  {
>  	xnticks_t ns;
>  	int ret;
> @@ -122,16 +122,16 @@ int __cobalt_clock_gettime(clockid_t clock_id, struct timespec *ts)
>  }
>  
>  COBALT_SYSCALL(clock_gettime, current,
> -	       (clockid_t clock_id, struct timespec __user *u_ts))
> +	       (clockid_t clock_id, struct __user_old_timespec __user *u_ts))
>  {
> -	struct timespec ts;
> +	struct timespec64 ts;
>  	int ret;
>  
>  	ret = __cobalt_clock_gettime(clock_id, &ts);
>  	if (ret)
>  		return ret;
>  
> -	if (cobalt_copy_to_user(u_ts, &ts, sizeof(*u_ts)))
> +	if (cobalt_put_u_timespec(u_ts, &ts))
>  		return -EFAULT;
>  
>  	trace_cobalt_clock_gettime(clock_id, &ts);
> @@ -139,7 +139,7 @@ COBALT_SYSCALL(clock_gettime, current,
>  	return 0;
>  }
>  
> -int __cobalt_clock_settime(clockid_t clock_id, const struct timespec *ts)
> +int __cobalt_clock_settime(clockid_t clock_id, const struct timespec64 *ts)
>  {
>  	int _ret, ret = 0;
>  	xnticks_t now;
> @@ -188,11 +188,11 @@ int __cobalt_clock_adjtime(clockid_t clock_id, struct timex *tx)
>  }
>  
>  COBALT_SYSCALL(clock_settime, current,
> -	       (clockid_t clock_id, const struct timespec __user *u_ts))
> +	       (clockid_t clock_id, const struct __user_old_timespec __user *u_ts))
>  {
> -	struct timespec ts;
> +	struct timespec64 ts;
>  
> -	if (cobalt_copy_from_user(&ts, u_ts, sizeof(ts)))
> +	if (cobalt_get_u_timespec(&ts, u_ts))
>  		return -EFAULT;
>  
>  	return __cobalt_clock_settime(clock_id, &ts);
> @@ -215,8 +215,8 @@ COBALT_SYSCALL(clock_adjtime, current,
>  }
>  
>  int __cobalt_clock_nanosleep(clockid_t clock_id, int flags,
> -			     const struct timespec *rqt,
> -			     struct timespec *rmt)
> +			     const struct timespec64 *rqt,
> +			     struct timespec64 *rmt)
>  {
>  	struct restart_block *restart;
>  	struct xnthread *cur;
> @@ -296,21 +296,21 @@ int __cobalt_clock_nanosleep(clockid_t clock_id, int flags,
>  
>  COBALT_SYSCALL(clock_nanosleep, primary,
>  	       (clockid_t clock_id, int flags,
> -		const struct timespec __user *u_rqt,
> -		struct timespec __user *u_rmt))
> +		const struct __user_old_timespec __user *u_rqt,
> +		struct __user_old_timespec __user *u_rmt))
>  {
> -	struct timespec rqt, rmt, *rmtp = NULL;
> +	struct timespec64 rqt, rmt, *rmtp = NULL;
>  	int ret;
>  
>  	if (u_rmt)
>  		rmtp = &rmt;
>  
> -	if (cobalt_copy_from_user(&rqt, u_rqt, sizeof(rqt)))
> +	if (cobalt_get_u_timespec(&rqt, u_rqt))
>  		return -EFAULT;
>  
>  	ret = __cobalt_clock_nanosleep(clock_id, flags, &rqt, rmtp);
>  	if (ret == -EINTR && flags == 0 && rmtp) {
> -		if (cobalt_copy_to_user(u_rmt, rmtp, sizeof(*u_rmt)))
> +		if (cobalt_put_u_timespec(u_rmt, rmtp))
>  			return -EFAULT;
>  	}
>  
> diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
> index 7cb161df24..7e45fdcc6b 100644
> --- a/kernel/cobalt/posix/clock.h
> +++ b/kernel/cobalt/posix/clock.h
> @@ -28,12 +28,27 @@
>  
>  struct xnclock;
>  
> -static inline void ns2ts(struct timespec *ts, xnticks_t nsecs)
> +static inline void ns2ts(struct timespec64 *ts, xnticks_t nsecs)
>  {
>  	ts->tv_sec = xnclock_divrem_billion(nsecs, &ts->tv_nsec);
>  }
>  
> -static inline xnticks_t ts2ns(const struct timespec *ts)
> +static inline void u_ns2ts(struct __user_old_timespec *ts, xnticks_t nsecs)
> +{
> +	ts->tv_sec = xnclock_divrem_billion(nsecs, &ts->tv_nsec);
> +}
> +
> +static inline xnticks_t ts2ns(const struct timespec64 *ts)
> +{
> +	xnticks_t nsecs = ts->tv_nsec;
> +
> +	if (ts->tv_sec)
> +		nsecs += (xnticks_t)ts->tv_sec * ONE_BILLION;
> +
> +	return nsecs;
> +}
> +
> +static inline xnticks_t u_ts2ns(const struct __user_old_timespec *ts)
>  {
>  	xnticks_t nsecs = ts->tv_nsec;
>  
> @@ -80,37 +95,37 @@ static inline int clock_flag(int flag, clockid_t clock_id)
>  }
>  
>  int __cobalt_clock_getres(clockid_t clock_id,
> -			  struct timespec *ts);
> +			  struct timespec64 *ts);
>  
>  int __cobalt_clock_gettime(clockid_t clock_id,
> -			   struct timespec *ts);
> +			   struct timespec64 *ts);
>  
>  int __cobalt_clock_settime(clockid_t clock_id,
> -			   const struct timespec *ts);
> +			   const struct timespec64 *ts);
>  
>  int __cobalt_clock_adjtime(clockid_t clock_id,
>  			   struct timex *tx);
>  
>  int __cobalt_clock_nanosleep(clockid_t clock_id, int flags,
> -			     const struct timespec *rqt,
> -			     struct timespec *rmt);
> +			     const struct timespec64 *rqt,
> +			     struct timespec64 *rmt);
>  
>  COBALT_SYSCALL_DECL(clock_getres,
> -		    (clockid_t clock_id, struct timespec __user *u_ts));
> +		    (clockid_t clock_id, struct __user_old_timespec __user *u_ts));
>  
>  COBALT_SYSCALL_DECL(clock_gettime,
> -		    (clockid_t clock_id, struct timespec __user *u_ts));
> +		    (clockid_t clock_id, struct __user_old_timespec __user *u_ts));
>  
>  COBALT_SYSCALL_DECL(clock_settime,
> -		    (clockid_t clock_id, const struct timespec __user *u_ts));
> +		    (clockid_t clock_id, const struct __user_old_timespec __user *u_ts));
>  
>  COBALT_SYSCALL_DECL(clock_adjtime,
>  		    (clockid_t clock_id, struct timex __user *u_tx));
>  
>  COBALT_SYSCALL_DECL(clock_nanosleep,
>  		    (clockid_t clock_id, int flags,
> -		     const struct timespec __user *u_rqt,
> -		     struct timespec __user *u_rmt));
> +		     const struct __user_old_timespec __user *u_rqt,
> +		     struct __user_old_timespec __user *u_rmt));
>  
>  int cobalt_clock_register(struct xnclock *clock,
>  			  const cpumask_t *affinity,
> diff --git a/kernel/cobalt/posix/compat.c b/kernel/cobalt/posix/compat.c
> index 2ffc0dbdf4..1852950821 100644
> --- a/kernel/cobalt/posix/compat.c
> +++ b/kernel/cobalt/posix/compat.c
> @@ -22,23 +22,41 @@
>  #include <asm/xenomai/syscall.h>
>  #include <xenomai/posix/mqueue.h>
>  
> -int sys32_get_timespec(struct timespec *ts,
> -		       const struct compat_timespec __user *cts)
> +int sys32_get_timespec(struct timespec64 *ts,
> +		       const struct compat_timespec __user *u_cts)
>  {
> -	return (cts == NULL ||
> -		!access_rok(cts, sizeof(*cts)) ||
> -		__xn_get_user(ts->tv_sec, &cts->tv_sec) ||
> -		__xn_get_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
> +	struct compat_timespec cts;
> +
> +	if (u_cts == NULL || !access_rok(u_cts, sizeof(*u_cts)))
> +		return -EFAULT;
> +
> +	if (__xn_get_user(cts.tv_sec, &u_cts->tv_sec) ||
> +		__xn_get_user(cts.tv_nsec, &u_cts->tv_nsec))
> +		return -EFAULT;
> +
> +	ts->tv_sec = cts.tv_sec;
> +	ts->tv_nsec = cts.tv_nsec;
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(sys32_get_timespec);
>  
> -int sys32_put_timespec(struct compat_timespec __user *cts,
> -		       const struct timespec *ts)
> +int sys32_put_timespec(struct compat_timespec __user *u_cts,
> +		       const struct timespec64 *ts)
>  {
> -	return (cts == NULL ||
> -		!access_wok(cts, sizeof(*cts)) ||
> -		__xn_put_user(ts->tv_sec, &cts->tv_sec) ||
> -		__xn_put_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
> +	struct compat_timespec cts;
> +
> +	if (u_cts == NULL || !access_wok(u_cts, sizeof(*u_cts)))
> +		return -EFAULT;
> +
> +	cts.tv_sec = ts->tv_sec;
> +	cts.tv_nsec = ts->tv_nsec;
> +
> +	if (__xn_put_user(cts.tv_sec, &u_cts->tv_sec) ||
> +	    __xn_put_user(cts.tv_nsec, &u_cts->tv_nsec))
> +		return -EFAULT;
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(sys32_put_timespec);
>  
> @@ -478,7 +496,7 @@ int sys32_get_iovec(struct iovec *iov,
>  	const struct compat_iovec __user *p;
>  	struct compat_iovec ciov;
>  	int ret, n;
> -	
> +
>  	for (n = 0, p = u_ciov; n < ciovlen; n++, p++) {
>  		ret = cobalt_copy_from_user(&ciov, p, sizeof(ciov));
>  		if (ret)
> @@ -498,7 +516,7 @@ int sys32_put_iovec(struct compat_iovec __user *u_ciov,
>  	struct compat_iovec __user *p;
>  	struct compat_iovec ciov;
>  	int ret, n;
> -	
> +
>  	for (n = 0, p = u_ciov; n < iovlen; n++, p++) {
>  		ciov.iov_base = ptr_to_compat(iov[n].iov_base);
>  		ciov.iov_len = iov[n].iov_len;
> diff --git a/kernel/cobalt/posix/cond.c b/kernel/cobalt/posix/cond.c
> index 35a8f7176d..bb18fe316e 100644
> --- a/kernel/cobalt/posix/cond.c
> +++ b/kernel/cobalt/posix/cond.c
> @@ -270,25 +270,24 @@ struct us_cond_data {
>  	int err;
>  };
>  
> -static inline int cond_fetch_timeout(struct timespec *ts,
> +static inline int cond_fetch_timeout(struct timespec64 *ts,
>  				     const void __user *u_ts)
>  {
> -	return u_ts == NULL ? -EFAULT :
> -		cobalt_copy_from_user(ts, u_ts, sizeof(*ts));
> +	return u_ts == NULL ? -EFAULT :	cobalt_get_u_timespec(ts, u_ts);
>  }
>  
>  int __cobalt_cond_wait_prologue(struct cobalt_cond_shadow __user *u_cnd,
>  				struct cobalt_mutex_shadow __user *u_mx,
>  				int *u_err,
>  				void __user *u_ts,
> -				int (*fetch_timeout)(struct timespec *ts,
> +				int (*fetch_timeout)(struct timespec64 *ts,
>  						     const void __user *u_ts))
>  {
>  	struct xnthread *cur = xnthread_current();
>  	struct cobalt_cond *cond;
>  	struct cobalt_mutex *mx;
>  	struct us_cond_data d;
> -	struct timespec ts;
> +	struct timespec64 ts;
>  	xnhandle_t handle;
>  	int err, perr = 0;
>  	__u32 offset;
> @@ -349,7 +348,7 @@ COBALT_SYSCALL(cond_wait_prologue, nonrestartable,
>  		struct cobalt_mutex_shadow __user *u_mx,
>  		int *u_err,
>  		unsigned int timed,
> -		struct timespec __user *u_ts))
> +		struct __user_old_timespec __user *u_ts))
>  {
>  	return __cobalt_cond_wait_prologue(u_cnd, u_mx, u_err, u_ts,
>  					   timed ? cond_fetch_timeout : NULL);
> diff --git a/kernel/cobalt/posix/cond.h b/kernel/cobalt/posix/cond.h
> index c7a9be4514..7bec2a649a 100644
> --- a/kernel/cobalt/posix/cond.h
> +++ b/kernel/cobalt/posix/cond.h
> @@ -43,7 +43,7 @@ int __cobalt_cond_wait_prologue(struct cobalt_cond_shadow __user *u_cnd,
>  				struct cobalt_mutex_shadow __user *u_mx,
>  				int *u_err,
>  				void __user *u_ts,
> -				int (*fetch_timeout)(struct timespec *ts,
> +				int (*fetch_timeout)(struct timespec64 *ts,
>  						     const void __user *u_ts));
>  COBALT_SYSCALL_DECL(cond_init,
>  		    (struct cobalt_cond_shadow __user *u_cnd,
> @@ -57,7 +57,7 @@ COBALT_SYSCALL_DECL(cond_wait_prologue,
>  		     struct cobalt_mutex_shadow __user *u_mx,
>  		     int *u_err,
>  		     unsigned int timed,
> -		     struct timespec __user *u_ts));
> +		     struct __user_old_timespec __user *u_ts));
>  
>  COBALT_SYSCALL_DECL(cond_wait_epilogue,
>  		    (struct cobalt_cond_shadow __user *u_cnd,
> diff --git a/kernel/cobalt/posix/event.c b/kernel/cobalt/posix/event.c
> index c566a09e36..3712154f53 100644
> --- a/kernel/cobalt/posix/event.c
> +++ b/kernel/cobalt/posix/event.c
> @@ -104,7 +104,7 @@ COBALT_SYSCALL(event_init, current,
>  int __cobalt_event_wait(struct cobalt_event_shadow __user *u_event,
>  			unsigned int bits,
>  			unsigned int __user *u_bits_r,
> -			int mode, const struct timespec *ts)
> +			int mode, const struct timespec64 *ts)
>  {
>  	unsigned int rbits = 0, testval;
>  	xnticks_t timeout = XN_INFINITE;
> @@ -193,14 +193,14 @@ COBALT_SYSCALL(event_wait, primary,
>  	       (struct cobalt_event_shadow __user *u_event,
>  		unsigned int bits,
>  		unsigned int __user *u_bits_r,
> -		int mode, const struct timespec __user *u_ts))
> +		int mode, const struct __user_old_timespec __user *u_ts))
>  {
> -	struct timespec ts, *tsp = NULL;
> +	struct timespec64 ts, *tsp = NULL;
>  	int ret;
>  
>  	if (u_ts) {
>  		tsp = &ts;
> -		ret = cobalt_copy_from_user(&ts, u_ts, sizeof(ts));
> +		ret = cobalt_get_u_timespec(&ts, u_ts);
>  		if (ret)
>  			return ret;
>  	}
> diff --git a/kernel/cobalt/posix/event.h b/kernel/cobalt/posix/event.h
> index 28d4516acf..ef592f72c0 100644
> --- a/kernel/cobalt/posix/event.h
> +++ b/kernel/cobalt/posix/event.h
> @@ -39,7 +39,7 @@ struct cobalt_event {
>  int __cobalt_event_wait(struct cobalt_event_shadow __user *u_event,
>  			unsigned int bits,
>  			unsigned int __user *u_bits_r,
> -			int mode, const struct timespec *ts);
> +			int mode, const struct timespec64 *ts);
>  
>  COBALT_SYSCALL_DECL(event_init,
>  		    (struct cobalt_event_shadow __user *u_evtsh,
> @@ -51,7 +51,7 @@ COBALT_SYSCALL_DECL(event_wait,
>  		     unsigned int bits,
>  		     unsigned int __user *u_bits_r,
>  		     int mode,
> -		     const struct timespec __user *u_ts));
> +		     const struct __user_old_timespec __user *u_ts));
>  
>  COBALT_SYSCALL_DECL(event_sync,
>  		    (struct cobalt_event_shadow __user *u_evtsh));
> diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
> index e9908feeb4..97a1f6afcd 100644
> --- a/kernel/cobalt/posix/io.c
> +++ b/kernel/cobalt/posix/io.c
> @@ -93,10 +93,10 @@ COBALT_SYSCALL(recvmsg, handover,
>  	return cobalt_copy_to_user(umsg, &m, sizeof(*umsg)) ?: ret;
>  }
>  
> -static int get_timespec(struct timespec *ts,
> +static int get_timespec(struct timespec64 *ts,
>  			const void __user *u_ts)
>  {
> -	return cobalt_copy_from_user(ts, u_ts, sizeof(*ts));
> +	return cobalt_get_u_timespec(ts, u_ts);
>  }
>  
>  static int get_mmsg(struct mmsghdr *mmsg, void __user *u_mmsg)
> @@ -114,7 +114,7 @@ static int put_mmsg(void __user **u_mmsg_p, const struct mmsghdr *mmsg)
>  
>  COBALT_SYSCALL(recvmmsg, primary,
>  	       (int fd, struct mmsghdr __user *u_msgvec, unsigned int vlen,
> -		unsigned int flags, struct timespec *u_timeout))
> +		unsigned int flags, struct __user_old_timespec __user *u_timeout))
>  {
>  	return __rtdm_fd_recvmmsg(fd, u_msgvec, vlen, flags, u_timeout,
>  				  get_mmsg, put_mmsg, get_timespec);
> diff --git a/kernel/cobalt/posix/io.h b/kernel/cobalt/posix/io.h
> index 82187cc7ba..e4f7d4d51f 100644
> --- a/kernel/cobalt/posix/io.h
> +++ b/kernel/cobalt/posix/io.h
> @@ -53,7 +53,7 @@ COBALT_SYSCALL_DECL(recvmsg,
>  
>  COBALT_SYSCALL_DECL(recvmmsg,
>  		    (int fd, struct mmsghdr __user *u_msgvec, unsigned int vlen,
> -		     unsigned int flags, struct timespec *u_timeout));
> +		     unsigned int flags, struct __user_old_timespec __user *u_timeout));
>  
>  COBALT_SYSCALL_DECL(sendmsg,
>  		    (int fd, struct user_msghdr __user *umsg, int flags));
> diff --git a/kernel/cobalt/posix/monitor.c b/kernel/cobalt/posix/monitor.c
> index 5237545bec..b907e0050a 100644
> --- a/kernel/cobalt/posix/monitor.c
> +++ b/kernel/cobalt/posix/monitor.c
> @@ -203,7 +203,7 @@ drain:
>  }
>  
>  int __cobalt_monitor_wait(struct cobalt_monitor_shadow __user *u_mon,
> -			  int event, const struct timespec *ts,
> +			  int event, const struct timespec64 *ts,
>  			  int __user *u_ret)
>  {
>  	struct cobalt_thread *curr = cobalt_current_thread();
> @@ -291,15 +291,15 @@ out:
>  
>  COBALT_SYSCALL(monitor_wait, nonrestartable,
>  	       (struct cobalt_monitor_shadow __user *u_mon,
> -	       int event, const struct timespec __user *u_ts,
> +	       int event, const struct __user_old_timespec __user *u_ts,
>  	       int __user *u_ret))
>  {
> -	struct timespec ts, *tsp = NULL;
> +	struct timespec64 ts, *tsp = NULL;
>  	int ret;
>  
>  	if (u_ts) {
>  		tsp = &ts;
> -		ret = cobalt_copy_from_user(&ts, u_ts, sizeof(ts));
> +		ret = cobalt_get_u_timespec(&ts, u_ts);
>  		if (ret)
>  			return ret;
>  	}
> diff --git a/kernel/cobalt/posix/monitor.h b/kernel/cobalt/posix/monitor.h
> index 8b321aaec6..d4a4aa24e5 100644
> --- a/kernel/cobalt/posix/monitor.h
> +++ b/kernel/cobalt/posix/monitor.h
> @@ -39,7 +39,7 @@ struct cobalt_monitor {
>  };
>  
>  int __cobalt_monitor_wait(struct cobalt_monitor_shadow __user *u_mon,
> -			  int event, const struct timespec *ts,
> +			  int event, const struct timespec64 *ts,
>  			  int __user *u_ret);
>  
>  COBALT_SYSCALL_DECL(monitor_init,
> @@ -58,7 +58,7 @@ COBALT_SYSCALL_DECL(monitor_exit,
>  
>  COBALT_SYSCALL_DECL(monitor_wait,
>  		    (struct cobalt_monitor_shadow __user *u_monsh,
> -		     int event, const struct timespec __user *u_ts,
> +		     int event, const struct __user_old_timespec __user *u_ts,
>  		     int __user *u_ret));
>  
>  COBALT_SYSCALL_DECL(monitor_destroy,
> diff --git a/kernel/cobalt/posix/mqueue.c b/kernel/cobalt/posix/mqueue.c
> index b58d111db8..dd8acd55b0 100644
> --- a/kernel/cobalt/posix/mqueue.c
> +++ b/kernel/cobalt/posix/mqueue.c
> @@ -471,13 +471,13 @@ mq_tryrcv(struct cobalt_mqd *mqd, size_t len)
>  static struct cobalt_msg *
>  mq_timedsend_inner(struct cobalt_mqd *mqd,
>  		   size_t len, const void __user *u_ts,
> -		   int (*fetch_timeout)(struct timespec *ts,
> +		   int (*fetch_timeout)(struct timespec64 *ts,
>  					const void __user *u_ts))
>  {
>  	struct cobalt_mqwait_context mwc;
>  	struct cobalt_msg *msg;
>  	struct cobalt_mq *mq;
> -	struct timespec ts;
> +	struct timespec64 ts;
>  	xntmode_t tmode;
>  	xnticks_t to;
>  	spl_t s;
> @@ -600,13 +600,13 @@ static struct cobalt_msg *
>  mq_timedrcv_inner(struct cobalt_mqd *mqd,
>  		  size_t len,
>  		  const void __user *u_ts,
> -		  int (*fetch_timeout)(struct timespec *ts,
> +		  int (*fetch_timeout)(struct timespec64 *ts,
>  				       const void __user *u_ts))
>  {
>  	struct cobalt_mqwait_context mwc;
>  	struct cobalt_msg *msg;
>  	struct cobalt_mq *mq;
> -	struct timespec ts;
> +	struct timespec64 ts;
>  	xntmode_t tmode;
>  	xnticks_t to;
>  	spl_t s;
> @@ -883,16 +883,15 @@ COBALT_SYSCALL(mq_getattr, current,
>  	return cobalt_copy_to_user(u_attr, &attr, sizeof(attr));
>  }
>  
> -static inline int mq_fetch_timeout(struct timespec *ts,
> +static inline int mq_fetch_timeout(struct timespec64 *ts,
>  				   const void __user *u_ts)
>  {
> -	return u_ts == NULL ? -EFAULT :
> -		cobalt_copy_from_user(ts, u_ts, sizeof(*ts));
> +	return u_ts == NULL ? -EFAULT : cobalt_get_u_timespec(ts, u_ts);
>  }
>  
>  int __cobalt_mq_timedsend(mqd_t uqd, const void __user *u_buf, size_t len,
>  			  unsigned int prio, const void __user *u_ts,
> -			  int (*fetch_timeout)(struct timespec *ts,
> +			  int (*fetch_timeout)(struct timespec64 *ts,
>  					       const void __user *u_ts))
>  {
>  	struct cobalt_msg *msg;
> @@ -936,7 +935,7 @@ out:
>  
>  COBALT_SYSCALL(mq_timedsend, primary,
>  	       (mqd_t uqd, const void __user *u_buf, size_t len,
> -		unsigned int prio, const struct timespec __user *u_ts))
> +		unsigned int prio, const struct __user_old_timespec __user *u_ts))
>  {
>  	return __cobalt_mq_timedsend(uqd, u_buf, len, prio,
>  				     u_ts, u_ts ? mq_fetch_timeout : NULL);
> @@ -946,7 +945,7 @@ int __cobalt_mq_timedreceive(mqd_t uqd, void __user *u_buf,
>  			     ssize_t *lenp,
>  			     unsigned int __user *u_prio,
>  			     const void __user *u_ts,
> -			     int (*fetch_timeout)(struct timespec *ts,
> +			     int (*fetch_timeout)(struct timespec64 *ts,
>  						  const void __user *u_ts))
>  {
>  	struct cobalt_mqd *mqd;
> @@ -997,7 +996,7 @@ COBALT_SYSCALL(mq_timedreceive, primary,
>  	       (mqd_t uqd, void __user *u_buf,
>  		ssize_t __user *u_len,
>  		unsigned int __user *u_prio,
> -		const struct timespec __user *u_ts))
> +		const struct __user_old_timespec __user *u_ts))
>  {
>  	ssize_t len;
>  	int ret;
> diff --git a/kernel/cobalt/posix/mqueue.h b/kernel/cobalt/posix/mqueue.h
> index acae2a4247..d33220227e 100644
> --- a/kernel/cobalt/posix/mqueue.h
> +++ b/kernel/cobalt/posix/mqueue.h
> @@ -37,14 +37,14 @@ int __cobalt_mq_getattr(mqd_t uqd, struct mq_attr *attr);
>  
>  int __cobalt_mq_timedsend(mqd_t uqd, const void __user *u_buf, size_t len,
>  			  unsigned int prio, const void __user *u_ts,
> -			  int (*fetch_timeout)(struct timespec *ts,
> +			  int (*fetch_timeout)(struct timespec64 *ts,
>  					       const void __user *u_ts));
>  
>  int __cobalt_mq_timedreceive(mqd_t uqd, void __user *u_buf,
>  			     ssize_t *lenp,
>  			     unsigned int __user *u_prio,
>  			     const void __user *u_ts,
> -			     int (*fetch_timeout)(struct timespec *ts,
> +			     int (*fetch_timeout)(struct timespec64 *ts,
>  						  const void __user *u_ts));
>  
>  int __cobalt_mq_notify(mqd_t fd, const struct sigevent *evp);
> @@ -61,12 +61,12 @@ COBALT_SYSCALL_DECL(mq_getattr, (mqd_t uqd, struct mq_attr __user *u_attr));
>  
>  COBALT_SYSCALL_DECL(mq_timedsend,
>  		    (mqd_t uqd, const void __user *u_buf, size_t len,
> -		     unsigned int prio, const struct timespec __user *u_ts));
> +		     unsigned int prio, const struct __user_old_timespec __user *u_ts));
>  
>  COBALT_SYSCALL_DECL(mq_timedreceive,
>  		    (mqd_t uqd, void __user *u_buf, ssize_t __user *u_len,
>  		     unsigned int __user *u_prio,
> -		     const struct timespec __user *u_ts));
> +		     const struct __user_old_timespec __user *u_ts));
>  
>  COBALT_SYSCALL_DECL(mq_notify,
>  		    (mqd_t fd, const struct sigevent *__user evp));
> diff --git a/kernel/cobalt/posix/mutex.c b/kernel/cobalt/posix/mutex.c
> index 79260b5448..70fe7960a0 100644
> --- a/kernel/cobalt/posix/mutex.c
> +++ b/kernel/cobalt/posix/mutex.c
> @@ -71,7 +71,7 @@ static int cobalt_mutex_init_inner(struct cobalt_mutex_shadow *shadow,
>  /* must be called with nklock locked, interrupts off. */
>  int __cobalt_mutex_acquire_unchecked(struct xnthread *cur,
>  				     struct cobalt_mutex *mutex,
> -				     const struct timespec *ts)
> +				     const struct timespec64 *ts)
>  {
>  	int ret;
>  
> @@ -134,11 +134,11 @@ int cobalt_mutex_release(struct xnthread *curr,
>  
>  int __cobalt_mutex_timedlock_break(struct cobalt_mutex_shadow __user *u_mx,
>  				   const void __user *u_ts,
> -				   int (*fetch_timeout)(struct timespec *ts,
> +				   int (*fetch_timeout)(struct timespec64 *ts,
>  							const void __user *u_ts))
>  {
>  	struct xnthread *curr = xnthread_current();
> -	struct timespec ts, *tsp = NULL;
> +	struct timespec64 ts, *tsp = NULL;
>  	struct cobalt_mutex *mutex;
>  	xnhandle_t handle;
>  	spl_t s;
> @@ -346,16 +346,15 @@ COBALT_SYSCALL(mutex_lock, primary,
>  	return __cobalt_mutex_timedlock_break(u_mx, NULL, NULL);
>  }
>  
> -static inline int mutex_fetch_timeout(struct timespec *ts,
> +static inline int mutex_fetch_timeout(struct timespec64 *ts,
>  				      const void __user *u_ts)
>  {
> -	return u_ts == NULL ? -EFAULT :
> -		cobalt_copy_from_user(ts, u_ts, sizeof(*ts));
> +	return u_ts == NULL ? -EFAULT : cobalt_get_u_timespec(ts, u_ts);
>  }
>  
>  COBALT_SYSCALL(mutex_timedlock, primary,
>  	       (struct cobalt_mutex_shadow __user *u_mx,
> -		const struct timespec __user *u_ts))
> +		const struct __user_old_timespec __user *u_ts))
>  {
>  	return __cobalt_mutex_timedlock_break(u_mx, u_ts, mutex_fetch_timeout);
>  }
> diff --git a/kernel/cobalt/posix/mutex.h b/kernel/cobalt/posix/mutex.h
> index ac1c50291d..d76f2a9ead 100644
> --- a/kernel/cobalt/posix/mutex.h
> +++ b/kernel/cobalt/posix/mutex.h
> @@ -37,12 +37,12 @@ struct cobalt_mutex {
>  
>  int __cobalt_mutex_timedlock_break(struct cobalt_mutex_shadow __user *u_mx,
>  				   const void __user *u_ts,
> -				   int (*fetch_timeout)(struct timespec *ts,
> +				   int (*fetch_timeout)(struct timespec64 *ts,
>  							const void __user *u_ts));
>  
>  int __cobalt_mutex_acquire_unchecked(struct xnthread *cur,
>  				     struct cobalt_mutex *mutex,
> -				     const struct timespec *ts);
> +				     const struct timespec64 *ts);
>  
>  COBALT_SYSCALL_DECL(mutex_check_init,
>  		    (struct cobalt_mutex_shadow __user *u_mx));
> @@ -62,7 +62,7 @@ COBALT_SYSCALL_DECL(mutex_lock,
>  
>  COBALT_SYSCALL_DECL(mutex_timedlock,
>  		    (struct cobalt_mutex_shadow __user *u_mx,
> -		     const struct timespec __user *u_ts));
> +		     const struct __user_old_timespec __user *u_ts));
>  
>  COBALT_SYSCALL_DECL(mutex_unlock,
>  		    (struct cobalt_mutex_shadow __user *u_mx));
> diff --git a/kernel/cobalt/posix/sched.c b/kernel/cobalt/posix/sched.c
> index 798a172d7f..4fd9c2b46e 100644
> --- a/kernel/cobalt/posix/sched.c
> +++ b/kernel/cobalt/posix/sched.c
> @@ -73,7 +73,7 @@ cobalt_sched_policy_param(union xnsched_policy_param *param,
>  		break;
>  	case SCHED_RR:
>  		/* if unspecified, use current one. */
> -		tslice = ts2ns(&param_ex->sched_rr_quantum);
> +		tslice = u_ts2ns(&param_ex->sched_rr_quantum);
>  		if (tslice == XN_INFINITE && tslice_r)
>  			tslice = *tslice_r;
>  		/* fallthrough */
> @@ -92,8 +92,8 @@ cobalt_sched_policy_param(union xnsched_policy_param *param,
>  		param->pss.normal_prio = param_ex->sched_priority;
>  		param->pss.low_prio = param_ex->sched_ss_low_priority;
>  		param->pss.current_prio = param->pss.normal_prio;
> -		param->pss.init_budget = ts2ns(&param_ex->sched_ss_init_budget);
> -		param->pss.repl_period = ts2ns(&param_ex->sched_ss_repl_period);
> +		param->pss.init_budget = u_ts2ns(&param_ex->sched_ss_init_budget);
> +		param->pss.repl_period = u_ts2ns(&param_ex->sched_ss_repl_period);
>  		param->pss.max_repl = param_ex->sched_ss_max_repl;
>  		sched_class = &xnsched_class_sporadic;
>  		break;
> @@ -280,11 +280,11 @@ int set_tp_config(int cpu, union sched_config *config, size_t len)
>  		 * be defined using windows assigned to the pseudo
>  		 * partition #-1.
>  		 */
> -		offset = ts2ns(&p->offset);
> +		offset = u_ts2ns(&p->offset);
>  		if (offset != next_offset)
>  			goto cleanup_and_fail;
>  
> -		duration = ts2ns(&p->duration);
> +		duration = u_ts2ns(&p->duration);
>  		if (duration <= 0)
>  			goto cleanup_and_fail;
>  
> @@ -357,11 +357,11 @@ ssize_t get_tp_config(int cpu, void __user *u_config, size_t len,
>  	config->tp.nr_windows = gps->pwin_nr;
>  	for (n = 0, pp = p = config->tp.windows, pw = w = gps->pwins;
>  	     n < gps->pwin_nr; pp = p, p++, pw = w, w++, n++) {
> -		ns2ts(&p->offset, w->w_offset);
> -		ns2ts(&pp->duration, w->w_offset - pw->w_offset);
> +		u_ns2ts(&p->offset, w->w_offset);
> +		u_ns2ts(&pp->duration, w->w_offset - pw->w_offset);
>  		p->ptid = w->w_part;
>  	}
> -	ns2ts(&pp->duration, gps->tf_duration - pw->w_offset);
> +	u_ns2ts(&pp->duration, gps->tf_duration - pw->w_offset);
>  	ret = put_config(SCHED_TP, u_config, len, config, elen);
>  	xnfree(config);
>  out:
> diff --git a/kernel/cobalt/posix/sem.c b/kernel/cobalt/posix/sem.c
> index 05a861dfe3..467a9b7dd6 100644
> --- a/kernel/cobalt/posix/sem.c
> +++ b/kernel/cobalt/posix/sem.c
> @@ -267,7 +267,7 @@ out:
>  	return ret;
>  }
>  
> -static inline int sem_fetch_timeout(struct timespec *ts,
> +static inline int sem_fetch_timeout(struct timespec64 *ts,
>  				    const void __user *u_ts)
>  {
>  	return u_ts == NULL ? -EFAULT :
> @@ -276,10 +276,10 @@ static inline int sem_fetch_timeout(struct timespec *ts,
>  
>  int __cobalt_sem_timedwait(struct cobalt_sem_shadow __user *u_sem,
>  			   const void __user *u_ts,
> -			   int (*fetch_timeout)(struct timespec *ts,
> +			   int (*fetch_timeout)(struct timespec64 *ts,
>  						const void __user *u_ts))
>  {
> -	struct timespec ts = { .tv_sec = 0, .tv_nsec = 0 };
> +	struct timespec64 ts = { .tv_sec = 0, .tv_nsec = 0 };
>  	int pull_ts = 1, ret, info;
>  	struct cobalt_sem *sem;
>  	xnhandle_t handle;
> @@ -434,7 +434,7 @@ COBALT_SYSCALL(sem_wait, primary,
>  
>  COBALT_SYSCALL(sem_timedwait, primary,
>  	       (struct cobalt_sem_shadow __user *u_sem,
> -		struct timespec __user *u_ts))
> +		struct __user_old_timespec __user *u_ts))
>  {
>  	return __cobalt_sem_timedwait(u_sem, u_ts, sem_fetch_timeout);
>  }
> diff --git a/kernel/cobalt/posix/sem.h b/kernel/cobalt/posix/sem.h
> index 17238078e5..d172994950 100644
> --- a/kernel/cobalt/posix/sem.h
> +++ b/kernel/cobalt/posix/sem.h
> @@ -65,7 +65,7 @@ __cobalt_sem_open(struct cobalt_sem_shadow __user *usm,
>  
>  int __cobalt_sem_timedwait(struct cobalt_sem_shadow __user *u_sem,
>  			   const void __user *u_ts,
> -			   int (*fetch_timeout)(struct timespec *ts,
> +			   int (*fetch_timeout)(struct timespec64 *ts,
>  						const void __user *u_ts));
>  
>  int __cobalt_sem_destroy(xnhandle_t handle);
> @@ -91,7 +91,7 @@ COBALT_SYSCALL_DECL(sem_wait,
>  
>  COBALT_SYSCALL_DECL(sem_timedwait,
>  		    (struct cobalt_sem_shadow __user *u_sem,
> -		     struct timespec __user *u_ts));
> +		     struct __user_old_timespec __user *u_ts));
>  
>  COBALT_SYSCALL_DECL(sem_trywait,
>  		    (struct cobalt_sem_shadow __user *u_sem));
> diff --git a/kernel/cobalt/posix/signal.c b/kernel/cobalt/posix/signal.c
> index 862a644c0b..0b43b5fcfa 100644
> --- a/kernel/cobalt/posix/signal.c
> +++ b/kernel/cobalt/posix/signal.c
> @@ -407,7 +407,7 @@ COBALT_SYSCALL(sigwait, primary,
>  }
>  
>  int __cobalt_sigtimedwait(sigset_t *set,
> -			  const struct timespec *timeout,
> +			  const struct timespec64 *timeout,
>  			  void __user *u_si,
>  			  bool compat)
>  {
> @@ -426,9 +426,9 @@ int __cobalt_sigtimedwait(sigset_t *set,
>  COBALT_SYSCALL(sigtimedwait, nonrestartable,
>  	       (const sigset_t __user *u_set,
>  		struct siginfo __user *u_si,
> -		const struct timespec __user *u_timeout))
> +		const struct __user_old_timespec __user *u_timeout))
>  {
> -	struct timespec timeout;
> +	struct timespec64 timeout;
>  	sigset_t set;
>  
>  	if (cobalt_copy_from_user(&set, u_set, sizeof(set)))
> diff --git a/kernel/cobalt/posix/signal.h b/kernel/cobalt/posix/signal.h
> index 7a0b4b22b8..fc26ad0653 100644
> --- a/kernel/cobalt/posix/signal.h
> +++ b/kernel/cobalt/posix/signal.h
> @@ -59,7 +59,7 @@ void cobalt_copy_siginfo(int code,
>  int __cobalt_sigwait(sigset_t *set);
>  
>  int __cobalt_sigtimedwait(sigset_t *set,
> -			  const struct timespec *timeout,
> +			  const struct timespec64 *timeout,
>  			  void __user *u_si,
>  			  bool compat);
>  
> @@ -94,7 +94,7 @@ COBALT_SYSCALL_DECL(sigwait,
>  COBALT_SYSCALL_DECL(sigtimedwait,
>  		    (const sigset_t __user *u_set,
>  		     struct siginfo __user *u_si,
> -		     const struct timespec __user *u_timeout));
> +		     const struct __user_old_timespec __user *u_timeout));
>  
>  COBALT_SYSCALL_DECL(sigwaitinfo,
>  		    (const sigset_t __user *u_set,
> diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
> index cb02dacd3d..ae25a6e743 100644
> --- a/kernel/cobalt/posix/syscall32.c
> +++ b/kernel/cobalt/posix/syscall32.c
> @@ -97,7 +97,7 @@ COBALT_SYSCALL32emu(thread_setschedprio, conforming,
>  	return cobalt_thread_setschedprio(pth, prio, u_winoff, u_promoted);
>  }
>  
> -static inline int sys32_fetch_timeout(struct timespec *ts,
> +static inline int sys32_fetch_timeout(struct timespec64 *ts,
>  				      const void __user *u_ts)
>  {
>  	return u_ts == NULL ? -EFAULT :
> @@ -133,7 +133,7 @@ COBALT_SYSCALL32emu(clock_getres, current,
>  		    (clockid_t clock_id,
>  		     struct compat_timespec __user *u_ts))
>  {
> -	struct timespec ts;
> +	struct timespec64 ts;
>  	int ret;
>  
>  	ret = __cobalt_clock_getres(clock_id, &ts);
> @@ -147,7 +147,7 @@ COBALT_SYSCALL32emu(clock_gettime, current,
>  		    (clockid_t clock_id,
>  		     struct compat_timespec __user *u_ts))
>  {
> -	struct timespec ts;
> +	struct timespec64 ts;
>  	int ret;
>  
>  	ret = __cobalt_clock_gettime(clock_id, &ts);
> @@ -161,7 +161,7 @@ COBALT_SYSCALL32emu(clock_settime, current,
>  		    (clockid_t clock_id,
>  		     const struct compat_timespec __user *u_ts))
>  {
> -	struct timespec ts;
> +	struct timespec64 ts;
>  	int ret;
>  
>  	ret = sys32_get_timespec(&ts, u_ts);
> @@ -193,7 +193,7 @@ COBALT_SYSCALL32emu(clock_nanosleep, nonrestartable,
>  		     const struct compat_timespec __user *u_rqt,
>  		     struct compat_timespec __user *u_rmt))
>  {
> -	struct timespec rqt, rmt, *rmtp = NULL;
> +	struct timespec64 rqt, rmt, *rmtp = NULL;
>  	int ret;
>  
>  	if (u_rmt)
> @@ -289,12 +289,10 @@ COBALT_SYSCALL32emu(mq_timedreceive, primary,
>  	return ret ?: cobalt_copy_to_user(u_len, &clen, sizeof(*u_len));
>  }
>  
> -static inline int mq_fetch_timeout(struct timespec *ts,
> +static inline int mq_fetch_timeout(struct timespec64 *ts,
>  				   const void __user *u_ts)
>  {
> -	return u_ts == NULL ? -EFAULT :
> -		cobalt_copy_from_user(ts, u_ts, sizeof(*ts));
> -
> +	return u_ts == NULL ? -EFAULT : cobalt_get_u_timespec(ts, u_ts);
>  }
>  
>  COBALT_SYSCALL32emu(mq_notify, primary,
> @@ -610,7 +608,7 @@ COBALT_SYSCALL32emu(sigtimedwait, nonrestartable,
>  		     struct compat_siginfo __user *u_si,
>  		     const struct compat_timespec __user *u_timeout))
>  {
> -	struct timespec timeout;
> +	struct timespec64 timeout;
>  	sigset_t set;
>  	int ret;
>  
> @@ -663,7 +661,7 @@ COBALT_SYSCALL32emu(monitor_wait, nonrestartable,
>  		     int event, const struct compat_timespec __user *u_ts,
>  		     int __user *u_ret))
>  {
> -	struct timespec ts, *tsp = NULL;
> +	struct timespec64 ts, *tsp = NULL;
>  	int ret;
>  
>  	if (u_ts) {
> @@ -682,7 +680,7 @@ COBALT_SYSCALL32emu(event_wait, primary,
>  		     unsigned int __user *u_bits_r,
>  		     int mode, const struct compat_timespec __user *u_ts))
>  {
> -	struct timespec ts, *tsp = NULL;
> +	struct timespec64 ts, *tsp = NULL;
>  	int ret;
>  
>  	if (u_ts) {
> @@ -810,7 +808,7 @@ COBALT_SYSCALL32emu(recvmsg, handover,
>  	return sys32_put_msghdr(umsg, &m) ?: ret;
>  }
>  
> -static int get_timespec32(struct timespec *ts,
> +static int get_timespec32(struct timespec64 *ts,
>  			  const void __user *u_ts)
>  {
>  	return sys32_get_timespec(ts, u_ts);
> @@ -924,7 +922,7 @@ COBALT_SYSCALL32x(mq_timedreceive, primary,
>  		  (mqd_t uqd, void __user *u_buf,
>  		   compat_ssize_t __user *u_len,
>  		   unsigned int __user *u_prio,
> -		   const struct timespec __user *u_ts))
> +		   const struct __user_old_timespec __user *u_ts))
>  {
>  	compat_ssize_t clen;
>  	ssize_t len;
> diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
> index eb3e4bd300..9da4052297 100644
> --- a/kernel/cobalt/posix/syscall32.h
> +++ b/kernel/cobalt/posix/syscall32.h
> @@ -105,7 +105,7 @@ COBALT_SYSCALL32x_DECL(mq_timedreceive,
>  		       (mqd_t uqd, void __user *u_buf,
>  			compat_ssize_t __user *u_len,
>  			unsigned int __user *u_prio,
> -			const struct timespec __user *u_ts));
> +			const struct __user_old_timespec __user *u_ts));
>  
>  COBALT_SYSCALL32emu_DECL(mq_notify,
>  			 (mqd_t fd, const struct compat_sigevent *__user u_cev));
> diff --git a/kernel/cobalt/posix/thread.c b/kernel/cobalt/posix/thread.c
> index bf9c082123..cdeb66d4f3 100644
> --- a/kernel/cobalt/posix/thread.c
> +++ b/kernel/cobalt/posix/thread.c
> @@ -302,7 +302,7 @@ int __cobalt_thread_getschedparam_ex(struct cobalt_thread *thread,
>  
>  	if (base_class == &xnsched_class_rt) {
>  		if (xnthread_test_state(base_thread, XNRRB)) {
> -			ns2ts(&param_ex->sched_rr_quantum, base_thread->rrperiod);
> +			u_ns2ts(&param_ex->sched_rr_quantum, base_thread->rrperiod);
>  			*policy_r = SCHED_RR;
>  		}
>  		goto out;
> @@ -318,8 +318,8 @@ int __cobalt_thread_getschedparam_ex(struct cobalt_thread *thread,
>  #ifdef CONFIG_XENO_OPT_SCHED_SPORADIC
>  	if (base_class == &xnsched_class_sporadic) {
>  		param_ex->sched_ss_low_priority = base_thread->pss->param.low_prio;
> -		ns2ts(&param_ex->sched_ss_repl_period, base_thread->pss->param.repl_period);
> -		ns2ts(&param_ex->sched_ss_init_budget, base_thread->pss->param.init_budget);
> +		u_ns2ts(&param_ex->sched_ss_repl_period, base_thread->pss->param.repl_period);
> +		u_ns2ts(&param_ex->sched_ss_init_budget, base_thread->pss->param.init_budget);
>  		param_ex->sched_ss_max_repl = base_thread->pss->param.max_repl;
>  		goto out;
>  	}
> diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
> index 7956a88008..038247d54f 100644
> --- a/kernel/cobalt/rtdm/fd.c
> +++ b/kernel/cobalt/rtdm/fd.c
> @@ -650,11 +650,11 @@ int __rtdm_fd_recvmmsg(int ufd, void __user *u_msgvec, unsigned int vlen,
>  		       unsigned int flags, void __user *u_timeout,
>  		       int (*get_mmsg)(struct mmsghdr *mmsg, void __user *u_mmsg),
>  		       int (*put_mmsg)(void __user **u_mmsg_p, const struct mmsghdr *mmsg),
> -		       int (*get_timespec)(struct timespec *ts, const void __user *u_ts))
> +		       int (*get_timespec)(struct timespec64 *ts, const void __user *u_ts))
>  {
>  	struct cobalt_recvmmsg_timer rq;
>  	xntmode_t tmode = XN_RELATIVE;
> -	struct timespec ts = { 0 };
> +	struct timespec64 ts = { 0 };
>  	int ret = 0, datagrams = 0;
>  	xnticks_t timeout = 0;
>  	struct mmsghdr mmsg;
> diff --git a/kernel/cobalt/trace/cobalt-posix.h b/kernel/cobalt/trace/cobalt-posix.h
> index aa78efbc01..3a649a6712 100644
> --- a/kernel/cobalt/trace/cobalt-posix.h
> +++ b/kernel/cobalt/trace/cobalt-posix.h
> @@ -30,7 +30,7 @@
>  #include <xenomai/posix/event.h>
>  
>  #define __timespec_fields(__name)				\
> -	__field(__kernel_time_t, tv_sec_##__name)		\
> +	__field(time64_t, tv_sec_##__name)			\
>  	__field(long, tv_nsec_##__name)
>  
>  #define __assign_timespec(__to, __from)				\
> @@ -40,7 +40,7 @@
>  	} while (0)
>  
>  #define __timespec_args(__name)					\
> -	__entry->tv_sec_##__name, __entry->tv_nsec_##__name
> +	(long long)__entry->tv_sec_##__name, __entry->tv_nsec_##__name
>  
>  #ifdef CONFIG_X86_X32
>  #define __sc_x32(__name)	, { sc_cobalt_##__name + __COBALT_X32_BASE, "x32-" #__name }
> @@ -729,7 +729,7 @@ TRACE_EVENT(cobalt_psem_unlink,
>  );
>  
>  DECLARE_EVENT_CLASS(cobalt_clock_timespec,
> -	TP_PROTO(clockid_t clk_id, const struct timespec *val),
> +	TP_PROTO(clockid_t clk_id, const struct timespec64 *val),
>  	TP_ARGS(clk_id, val),
>  
>  	TP_STRUCT__entry(
> @@ -742,24 +742,24 @@ DECLARE_EVENT_CLASS(cobalt_clock_timespec,
>  		__assign_timespec(val, val);
>  	),
>  
> -	TP_printk("clock_id=%d timeval=(%ld.%09ld)",
> +	TP_printk("clock_id=%d timeval=(%lld.%09ld)",
>  		  __entry->clk_id,
>  		  __timespec_args(val)
>  	)
>  );
>  
>  DEFINE_EVENT(cobalt_clock_timespec, cobalt_clock_getres,
> -	TP_PROTO(clockid_t clk_id, const struct timespec *res),
> +	TP_PROTO(clockid_t clk_id, const struct timespec64 *res),
>  	TP_ARGS(clk_id, res)
>  );
>  
>  DEFINE_EVENT(cobalt_clock_timespec, cobalt_clock_gettime,
> -	TP_PROTO(clockid_t clk_id, const struct timespec *time),
> +	TP_PROTO(clockid_t clk_id, const struct timespec64 *time),
>  	TP_ARGS(clk_id, time)
>  );
>  
>  DEFINE_EVENT(cobalt_clock_timespec, cobalt_clock_settime,
> -	TP_PROTO(clockid_t clk_id, const struct timespec *time),
> +	TP_PROTO(clockid_t clk_id, const struct timespec64 *time),
>  	TP_ARGS(clk_id, time)
>  );
>  
> @@ -788,7 +788,7 @@ TRACE_EVENT(cobalt_clock_adjtime,
>  		      {TIMER_ABSTIME, "TIMER_ABSTIME"})
>  
>  TRACE_EVENT(cobalt_clock_nanosleep,
> -	TP_PROTO(clockid_t clk_id, int flags, const struct timespec *time),
> +	TP_PROTO(clockid_t clk_id, int flags, const struct timespec64 *time),
>  	TP_ARGS(clk_id, flags, time),
>  
>  	TP_STRUCT__entry(
> @@ -803,7 +803,7 @@ TRACE_EVENT(cobalt_clock_nanosleep,
>  		__assign_timespec(time, time);
>  	),
>  
> -	TP_printk("clock_id=%d flags=%#x(%s) rqt=(%ld.%09ld)",
> +	TP_printk("clock_id=%d flags=%#x(%s) rqt=(%lld.%09ld)",
>  		  __entry->clk_id,
>  		  __entry->flags, cobalt_print_timer_flags(__entry->flags),
>  		  __timespec_args(time)
> @@ -875,7 +875,7 @@ TRACE_EVENT(cobalt_cond_destroy,
>  TRACE_EVENT(cobalt_cond_timedwait,
>  	TP_PROTO(const struct cobalt_cond_shadow __user *u_cnd,
>  		 const struct cobalt_mutex_shadow __user *u_mx,
> -		 const struct timespec *timeout),
> +		 const struct timespec64 *timeout),
>  	TP_ARGS(u_cnd, u_mx, timeout),
>  	TP_STRUCT__entry(
>  		__field(const struct cobalt_cond_shadow __user *, u_cnd)
> @@ -887,7 +887,7 @@ TRACE_EVENT(cobalt_cond_timedwait,
>  		__entry->u_mx = u_mx;
>  		__assign_timespec(timeout, timeout);
>  	),
> -	TP_printk("cond=%p, mutex=%p, timeout=(%ld.%09ld)",
> +	TP_printk("cond=%p, mutex=%p, timeout=(%lld.%09ld)",
>  		  __entry->u_cnd, __entry->u_mx, __timespec_args(timeout))
>  );
>  
> @@ -1001,7 +1001,7 @@ TRACE_EVENT(cobalt_mq_send,
>  
>  TRACE_EVENT(cobalt_mq_timedreceive,
>  	TP_PROTO(mqd_t mqd, const void __user *u_buf, size_t len,
> -		 const struct timespec *timeout),
> +		 const struct timespec64 *timeout),
>  	TP_ARGS(mqd, u_buf, len, timeout),
>  	TP_STRUCT__entry(
>  		__field(mqd_t, mqd)
> @@ -1015,7 +1015,7 @@ TRACE_EVENT(cobalt_mq_timedreceive,
>  		__entry->len = len;
>  		__assign_timespec(timeout, timeout);
>  	),
> -	TP_printk("mqd=%d buf=%p len=%zu timeout=(%ld.%09ld)",
> +	TP_printk("mqd=%d buf=%p len=%zu timeout=(%lld.%09ld)",
>  		  __entry->mqd, __entry->u_buf, __entry->len,
>  		  __timespec_args(timeout))
>  );
> @@ -1105,7 +1105,7 @@ TRACE_EVENT(cobalt_event_init,
>  TRACE_EVENT(cobalt_event_timedwait,
>  	TP_PROTO(const struct cobalt_event_shadow __user *u_event,
>  		 unsigned long bits, int mode,
> -		 const struct timespec *timeout),
> +		 const struct timespec64 *timeout),
>  	TP_ARGS(u_event, bits, mode, timeout),
>  	TP_STRUCT__entry(
>  		__field(const struct cobalt_event_shadow __user *, u_event)
> @@ -1119,7 +1119,7 @@ TRACE_EVENT(cobalt_event_timedwait,
>  		__entry->mode = mode;
>  		__assign_timespec(timeout, timeout);
>  	),
> -	TP_printk("event=%p bits=%#lx mode=%#x(%s) timeout=(%ld.%09ld)",
> +	TP_printk("event=%p bits=%#lx mode=%#x(%s) timeout=(%lld.%09ld)",
>  		  __entry->u_event, __entry->bits, __entry->mode,
>  		  cobalt_print_evmode(__entry->mode),
>  		  __timespec_args(timeout))
> 


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

