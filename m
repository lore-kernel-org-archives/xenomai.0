Message-ID: <53593F7F.5000106@xenomai.org>
Date: Thu, 24 Apr 2014 18:44:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1WdMf6-0003VG-Mu@sd-51317.dedibox.fr>
In-Reply-To: <E1WdMf6-0003VG-Mu@sd-51317.dedibox.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/kernel: Instrument
	syscalls
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 04/24/2014 06:38 PM, git repository hosting wrote:
> +#if 0
> +#define __optional_timespec_fields(name)			\
> +	__field(int, using_##name)				\
> +	__timespec_fields(name)
> +#endif
> +#if 0
> +#define __timespec_used(name)					\
> +	__entry->using_##name ? "used" : "unused"
> +#endif
> +#if 0
> +#define show_protocol(protocol)						\
> +	__print_symbolic(protocol,					\
> +			 {PTHREAD_PRIO_NONE, "prio-none"},		\
> +			 {PTHREAD_PRIO_INHERIT, "prio-inherit"},	\
> +			 {PTHREAD_PRIO_PROTECT, "prio-protect"})
> +
> +#define __protocol_args()					\
> +        __entry->protocol, show_protocol(__entry->protocol)
> +
> +#define show_type(type)							\
> +	__print_symbolic(type,						\
> +			 {PTHREAD_MUTEX_NORMAL, "normal"},		\
> +			 {PTHREAD_MUTEX_RECURSIVE, "recursive"},	\
> +			 {PTHREAD_MUTEX_ERRORCHECK, "errorcheck"})
> +
> +#define __type_args()						\
> +        __entry->type, show_type(__entry->type)
> +
> +#define show_pshared(pshared)					\
> +	__print_symbolic(pshared,				\
> +			 {PTHREAD_PROCESS_PRIVATE, "private"},	\
> +			 {PTHREAD_PROCESS_SHARED, "shared"})
> +
> +#define __pshared_args()					\
> +        __entry->pshared, show_pshared(__entry->pshared)
> +
> +#define show_sigev_notify(notify)				\
> +	__print_symbolic(notify,				\
> +			 {SIGEV_NONE, "none"},			\
> +			 {SIGEV_SIGNAL, "signal"})
> +
> +#define __sigev_notify_args()					\
> +        __entry->notify, show_sigev_notify(__entry->notify)
> +
> +#define show_intr_mode(mode)					\
> +	__print_flags(mode, "|",				\
> +		      {PTHREAD_INOAUTOENA, "inoautoena"},	\
> +		      {PTHREAD_IPROPAGATE, "ipropagate"})
> +
> +#define __intr_mode_args()					\
> +        __entry->mode, show_intr_mode(__entry->mode)
> +
> +#define show_intr_cmd(cmd)					\
> +	__print_symbolic(cmd,					\
> +			 {PTHREAD_IENABLE, "ienable"},		\
> +			 {PTHREAD_IDISABLE, "idisable"})
> +
> +#define __intr_cmd_args()					\
> +        __entry->cmd, show_intr_cmd(__entry->cmd)
> +#endif
> +#if 0
> +DECLARE_EVENT_CLASS(posix_fd,
> +	TP_PROTO(int fd),
> +	TP_ARGS(fd),
> +	TP_STRUCT__entry(
> +		__field(int, fd)
> +	),
> +	TP_fast_assign(
> +		__entry->fd = fd;
> +	),
> +	TP_printk("fd=%d", __entry->fd)
> +);
> +
> +DECLARE_EVENT_CLASS(posix_timespec,
> +	TP_PROTO(struct timespec *ts),
> +	TP_ARGS(ts),
> +	TP_STRUCT__entry(
> +		__timespec_fields(ts)
> +	),
> +	TP_fast_assign(
> +		__assign_timespec(ts, ts);
> +	),
> +	TP_printk("time={%ld.%09ld}", __timespec_args(ts))
> +);
> +#endif
> +#if 0
> +DECLARE_EVENT_CLASS(posix_timer,
> +	TP_PROTO(unsigned long timer),
> +	TP_ARGS(timer),
> +	TP_STRUCT__entry(
> +		__field(unsigned long, timer)
> +	),
> +	TP_fast_assign(
> +		__entry->timer = timer;
> +	),
> +	TP_printk("timerid=%ld", __entry->timer)
> +);
> +
> +DECLARE_EVENT_CLASS(posix_timer_timespec,
> +	TP_PROTO(unsigned long timer, struct itimerspec *itimer),
> +	TP_ARGS(timer, itimer),
> +	TP_STRUCT__entry(
> +		__field(unsigned long, timer)
> +		__timespec_fields(interval)
> +		__timespec_fields(value)
> +	),
> +	TP_fast_assign(
> +		__entry->timer = timer;
> +		__assign_timespec(interval, &itimer->it_interval);
> +		__assign_timespec(value, &itimer->it_value);
> +	),
> +	TP_printk("timerid=%ld "
> +		"itimer.interval=%ld.%09ld itimer.value=%ld.%09ld",
> +		__entry->timer, __timespec_args(interval),
> +		__timespec_args(value))
> +);
> +#endif
> +#if 0
> +/* int timer_create(clockid_t clockid, const struct sigevent *evp, timer_t *timerid)
> + */
> +TRACE_EVENT(xn_posix_timer_create,
> +	TP_PROTO(unsigned long clock_id, struct sigevent *evt),
> +	TP_ARGS(clock_id, evt),
> +	TP_STRUCT__entry(
> +		__field(unsigned long, clock_id)
> +		__field(int, sigev_signo)
> +		__field(int, sigev_notify)
> +	),
> +	TP_fast_assign(
> +		__entry->clock_id = clock_id;
> +		__entry->sigev_signo = evt->sigev_signo;
> +		__entry->sigev_notify = evt->sigev_notify;
> +	),
> +	TP_printk("clockid=%ld(%s) sigev-signo=%d sigev-notify=%d(%s)",
> +		__clock_args(clock_id), __entry->sigev_signo,
> +		__sigev_notify_args(sigev_notify))
> +);
> +
> +DEFINE_EVENT(posix_timer, xn_posix_timer_create_return,
> +	TP_PROTO(unsigned long timer),
> +	TP_ARGS(timer)
> +);
> +
> +/* int timer_delete(timer_t timerid)
> + */
> +DEFINE_EVENT(posix_timer, xn_posix_timer_delete,
> +	TP_PROTO(unsigned long timer),
> +	TP_ARGS(timer)
> +);
> +
> +/* int timer_settime(timer_t timerid, int flags, const struct itimerspec *value, struct itimerspec *ovalue)
> + */
> +TRACE_EVENT(xn_posix_timer_settime,
> +	TP_PROTO(unsigned long timer, int flags, struct itimerspec *itimer),
> +	TP_ARGS(timer, flags, itimer),
> +	TP_STRUCT__entry(
> +		__field(unsigned long, timer)
> +		__field(int, flags)
> +		__timespec_fields(interval)
> +		__timespec_fields(value)
> +	),
> +	TP_fast_assign(
> +		__entry->timer = timer;
> +		__entry->flags = flags;
> +		__assign_timespec(interval, &itimer->it_interval);
> +		__assign_timespec(value, &itimer->it_value);
> +	),
> +	TP_printk("timerid=%ld flags=%#x(%s) "
> +		"itimer.interval=%ld.%09ld itimer.value=%ld.%09ld",
> +		__entry->timer, __clock_mode_args(flags),
> +		__timespec_args(interval), __timespec_args(value))
> +);
> +
> +DEFINE_EVENT(posix_timer_timespec, xn_posix_timer_settime_return,
> +	TP_PROTO(unsigned long timer, struct itimerspec *itimer),
> +	TP_ARGS(timer, itimer)
> +);
> +
> +/* int timer_gettime(timer_t timerid, struct itimerspec *value)
> + */
> +DEFINE_EVENT(posix_timer_timespec, xn_posix_timer_gettime,
> +	TP_PROTO(unsigned long timer, struct itimerspec *itimer),
> +	TP_ARGS(timer, itimer)
> +);
> +
> +/* int timer_getoverrun(timer_t timerid)
> + */
> +DEFINE_EVENT(posix_timer, xn_posix_timer_getoverrun,
> +	TP_PROTO(unsigned long timer),
> +	TP_ARGS(timer)
> +);
> +
> +/*
> + * Mutex services.
> + */
> +DECLARE_EVENT_CLASS(posix_mutexattr,
> +	TP_PROTO(pthread_mutexattr_t *attr),
> +	TP_ARGS(attr),
> +	TP_STRUCT__entry(
> +		__field(pthread_mutexattr_t *, attr)
> +	),
> +	TP_fast_assign(
> +		__entry->attr = attr;
> +	),
> +	TP_printk("mutexattr=%p", __entry->attr)
> +);
> +
> +DECLARE_EVENT_CLASS(posix_mutexattr_type,
> +	TP_PROTO(pthread_mutexattr_t *attr, int type),
> +	TP_ARGS(attr, type),
> +	TP_STRUCT__entry(
> +		__field(pthread_mutexattr_t *, attr)
> +		__field(int, type)
> +	),
> +	TP_fast_assign(
> +		__entry->attr = attr;
> +		__entry->type = type;
> +	),
> +	TP_printk("mutexattr=%p type=%d(%s)",
> +		__entry->attr, __type_args(type))
> +);
> +
> +DECLARE_EVENT_CLASS(posix_mutexattr_pshared,
> +	TP_PROTO(pthread_mutexattr_t *attr, int pshared),
> +	TP_ARGS(attr, pshared),
> +	TP_STRUCT__entry(
> +		__field(pthread_mutexattr_t *, attr)
> +		__field(int, pshared)
> +	),
> +	TP_fast_assign(
> +		__entry->attr = attr;
> +		__entry->pshared = pshared;
> +	),
> +	TP_printk("mutexattr=%p pshared=%d(%s)",
> +		__entry->attr, __pshared_args(pshared))
> +);
> +
> +DECLARE_EVENT_CLASS(posix_mutexattr_protocol,
> +	TP_PROTO(pthread_mutexattr_t *attr, int protocol),
> +	TP_ARGS(attr, protocol),
> +	TP_STRUCT__entry(
> +		__field(pthread_mutexattr_t *, attr)
> +		__field(int, protocol)
> +	),
> +	TP_fast_assign(
> +		__entry->attr = attr;
> +		__entry->protocol = protocol;
> +	),
> +	TP_printk("mutexattr=%p protocol=%d(%s)",
> +		__entry->attr, __protocol_args(protocol))
> +);
> +
> +DECLARE_EVENT_CLASS(posix_mutex,
> +	TP_PROTO(union __xeno_mutex *mutex),
> +	TP_ARGS(mutex),
> +	TP_STRUCT__entry(
> +		__field(union __xeno_mutex *, mutex)
> +	),
> +	TP_fast_assign(
> +		__entry->mutex = mutex;
> +	),
> +	TP_printk("mutex=%p", __entry->mutex)
> +);
> +
> +/* int pthread_mutexattr_init(pthread_mutexattr_t *attr)
> + */
> +DEFINE_EVENT(posix_mutexattr, xn_posix_mutexattr_init,
> +	TP_PROTO(pthread_mutexattr_t *attr),
> +	TP_ARGS(attr)
> +);
> +
> +/* int pthread_mutexattr_destroy(pthread_mutexattr_t *attr)
> + */
> +DEFINE_EVENT(posix_mutexattr, xn_posix_mutexattr_destroy,
> +	TP_PROTO(pthread_mutexattr_t *attr),
> +	TP_ARGS(attr)
> +);
> +
> +/* int pthread_mutexattr_gettype(const pthread_mutexattr_t *attr, int *type)
> + */
> +DEFINE_EVENT(posix_mutexattr_type, xn_posix_mutexattr_gettype,
> +	TP_PROTO(pthread_mutexattr_t *attr, int type),
> +	TP_ARGS(attr, type)
> +);
> +
> +/* int pthread_mutexattr_settype(pthread_mutexattr_t *attr, int type)
> + */
> +DEFINE_EVENT(posix_mutexattr_type, xn_posix_mutexattr_settype,
> +	TP_PROTO(pthread_mutexattr_t *attr, int type),
> +	TP_ARGS(attr, type)
> +);
> +
> +/* int pthread_mutexattr_getprotocol(const pthread_mutexattr_t *attr, int *proto)
> + */
> +DEFINE_EVENT(posix_mutexattr_protocol, xn_posix_mutexattr_getprotocol,
> +	TP_PROTO(pthread_mutexattr_t *attr, int protocol),
> +	TP_ARGS(attr, protocol)
> +);
> +
> +/* int pthread_mutexattr_setprotocol(pthread_mutexattr_t *attr, int proto)
> + */
> +DEFINE_EVENT(posix_mutexattr_protocol, xn_posix_mutexattr_setprotocol,
> +	TP_PROTO(pthread_mutexattr_t *attr, int protocol),
> +	TP_ARGS(attr, protocol)
> +);
> +
> +/* int pthread_mutexattr_getpshared(const pthread_mutexattr_t *attr, int *pshared)
> + */
> +DEFINE_EVENT(posix_mutexattr_pshared, xn_posix_mutexattr_getpshared,
> +	TP_PROTO(pthread_mutexattr_t *attr, int pshared),
> +	TP_ARGS(attr, pshared)
> +);
> +
> +/* int pthread_mutexattr_setpshared(pthread_mutexattr_t *attr, int pshared)
> + */
> +DEFINE_EVENT(posix_mutexattr_pshared, xn_posix_mutexattr_setpshared,
> +	TP_PROTO(pthread_mutexattr_t *attr, int pshared),
> +	TP_ARGS(attr, pshared)
> +);
> +#endif
> +#if 0
> +/* int pthread_mutex_destroy(pthread_mutex_t *mx)
> + */
> +DEFINE_EVENT(posix_mutex, xn_posix_mutex_destroy,
> +	TP_PROTO(union __xeno_mutex *mutex),
> +	TP_ARGS(mutex)
> +);
> +
> +/* int pthread_mutex_trylock(pthread_mutex_t *mx)
> + */
> +DEFINE_EVENT(posix_mutex, xn_posix_mutex_trylock,
> +	TP_PROTO(union __xeno_mutex *mutex),
> +	TP_ARGS(mutex)
> +);
> +
> +/* int pthread_mutex_lock(pthread_mutex_t *mx)
> + */
> +DEFINE_EVENT(posix_mutex, xn_posix_mutex_lock,
> +	TP_PROTO(union __xeno_mutex *mutex),
> +	TP_ARGS(mutex)
> +);
> +
> +/* int pthread_mutex_timedlock(pthread_mutex_t *mx, const struct timespec *to)
> + */
> +TRACE_EVENT(xn_posix_mutex_timedlock,
> +	TP_PROTO(union __xeno_mutex * mutex, const struct timespec *timeout),
> +	TP_ARGS(mutex, timeout),
> +	TP_STRUCT__entry(
> +		__field(union __xeno_mutex *, mutex)
> +		__timespec_fields(timeout)
> +	),
> +	TP_fast_assign(
> +		__entry->mutex = mutex;
> +		__assign_timespec(timeout, timeout);
> +	),
> +	TP_printk("mutex=%p timeout=%ld.%09ld", __entry->mutex,
> +		__timespec_args(timeout))
> +);
> +
> +/* int pthread_mutex_unlock(pthread_mutex_t *mx)
> + */
> +DEFINE_EVENT(posix_mutex, xn_posix_mutex_unlock,
> +	TP_PROTO(union __xeno_mutex *mutex),
> +	TP_ARGS(mutex)
> +);
> +
> +/*
> + * Condition variables services.
> + */
> +DECLARE_EVENT_CLASS(posix_condattr,
> +	TP_PROTO(pthread_condattr_t *attr),
> +	TP_ARGS(attr),
> +	TP_STRUCT__entry(
> +		__field(pthread_condattr_t *, attr)
> +	),
> +	TP_fast_assign(
> +		__entry->attr = attr;
> +	),
> +	TP_printk("condattr=%p", __entry->attr)
> +);
> +
> +DECLARE_EVENT_CLASS(posix_condattr_pshared,
> +	TP_PROTO(pthread_condattr_t *attr, int pshared),
> +	TP_ARGS(attr, pshared),
> +	TP_STRUCT__entry(
> +		__field(pthread_condattr_t *, attr)
> +		__field(int, pshared)
> +	),
> +	TP_fast_assign(
> +		__entry->attr = attr;
> +		__entry->pshared = pshared;
> +	),
> +	TP_printk("condattr=%p pshared=%d(%s)",
> +		__entry->attr, __pshared_args(pshared))
> +);
> +
> +DECLARE_EVENT_CLASS(posix_condattr_clock,
> +	TP_PROTO(pthread_condattr_t *attr, int clock_id),
> +	TP_ARGS(attr, clock_id),
> +	TP_STRUCT__entry(
> +		__field(pthread_condattr_t *, attr)
> +		__field(int, clock_id)
> +	),
> +	TP_fast_assign(
> +		__entry->attr = attr;
> +		__entry->clock_id = clock_id;
> +	),
> +	TP_printk("condattr=%p clockid=%d(%s)",
> +		__entry->attr, __clock_args(clock_id))
> +);
> +
> +DECLARE_EVENT_CLASS(posix_cond,
> +	TP_PROTO(union __xeno_cond *cond),
> +	TP_ARGS(cond),
> +	TP_STRUCT__entry(
> +		__field(union __xeno_cond *, cond)
> +	),
> +	TP_fast_assign(
> +		__entry->cond = cond;
> +	),
> +	TP_printk("cond=%p", __entry->cond)
> +);
> +
> +DECLARE_EVENT_CLASS(posix_cond_wait,
> +	TP_PROTO(union __xeno_cond *cond, union __xeno_mutex *mutex),
> +	TP_ARGS(cond, mutex),
> +	TP_STRUCT__entry(
> +		__field(union __xeno_cond*, cond)
> +		__field(union __xeno_mutex*, mutex)
> +	),
> +	TP_fast_assign(
> +		__entry->cond = cond;
> +		__entry->mutex = mutex;
> +	),
> +	TP_printk("cond=%p mutex=%p", __entry->cond, __entry->mutex)
> +);
> +
> +/* int pthread_condattr_init(pthread_condattr_t *attr)
> + */
> +DEFINE_EVENT(posix_condattr, xn_posix_condattr_init,
> +	TP_PROTO(pthread_condattr_t *attr),
> +	TP_ARGS(attr)
> +);
> +
> +/* int pthread_condattr_destroy(pthread_condattr_t *attr)
> + */
> +DEFINE_EVENT(posix_condattr, xn_posix_condattr_destroy,
> +	TP_PROTO(pthread_condattr_t *attr),
> +	TP_ARGS(attr)
> +);
> +
> +/* int pthread_condattr_getclock(const pthread_condattr_t *attr, clockid_t *clk_id)
> + */
> +DEFINE_EVENT(posix_condattr_clock, xn_posix_condattr_getclock,
> +	TP_PROTO(pthread_condattr_t *attr, int clock_id),
> +	TP_ARGS(attr, clock_id)
> +);
> +
> +/* int pthread_condattr_setclock(pthread_condattr_t *attr, clockid_t clk_id)
> + */
> +DEFINE_EVENT(posix_condattr_clock, xn_posix_condattr_setclock,
> +	TP_PROTO(pthread_condattr_t *attr, int clock_id),
> +	TP_ARGS(attr, clock_id)
> +);
> +
> +/* int pthread_condattr_getpshared(const pthread_condattr_t *attr, int *pshared)
> + */
> +DEFINE_EVENT(posix_condattr_pshared, xn_posix_condattr_getpshared,
> +	TP_PROTO(pthread_condattr_t *attr, int pshared),
> +	TP_ARGS(attr, pshared)
> +);
> +
> +/* int pthread_condattr_setpshared(pthread_condattr_t *attr, int pshared)
> + */
> +DEFINE_EVENT(posix_condattr_pshared, xn_posix_condattr_setpshared,
> +	TP_PROTO(pthread_condattr_t *attr, int pshared),
> +	TP_ARGS(attr, pshared)
> +);
> +
> +/* int pthread_cond_init(pthread_cond_t *cnd, const pthread_condattr_t *attr)
> + */
> +TRACE_EVENT(xn_posix_cond_init,
> +	TP_PROTO(union __xeno_cond *cond, pthread_condattr_t *attr),
> +	TP_ARGS(cond, attr),
> +	TP_STRUCT__entry(
> +		__field(union __xeno_cond *, cond)
> +		__field(pthread_condattr_t *, attr)
> +	),
> +	TP_fast_assign(
> +		__entry->cond = cond;
> +		__entry->attr = attr;
> +	),
> +	TP_printk("cond=%p condattr=%p ",
> +		__entry->cond, __entry->attr)
> +);
> +
> +/* int pthread_cond_destroy(pthread_cond_t *cnd)
> + */
> +DEFINE_EVENT(posix_cond, xn_posix_cond_destroy,
> +	TP_PROTO(union __xeno_cond *cond),
> +	TP_ARGS(cond)
> +);
> +
> +/* int pthread_cond_wait(pthread_cond_t *cnd, pthread_mutex_t *mx)
> + */
> +DEFINE_EVENT(posix_cond_wait, xn_posix_cond_wait,
> +	TP_PROTO(union __xeno_cond *cond, union __xeno_mutex *mutex),
> +	TP_ARGS(cond, mutex)
> +);
> +
> +DEFINE_EVENT(posix_cond_wait, xn_posix_cond_wait_restart,
> +	TP_PROTO(union __xeno_cond *cond, union __xeno_mutex *mutex),
> +	TP_ARGS(cond, mutex)
> +);
> +
> +/* int pthread_cond_timedwait(pthread_cond_t *cnd, pthread_mutex_t *mx, const struct timespec *abstime)
> + */
> +TRACE_EVENT(xn_posix_cond_timedwait,
> +	TP_PROTO(union __xeno_cond *cond, union __xeno_mutex *mutex,
> +		const struct timespec *timeout),
> +	TP_ARGS(cond, mutex, timeout),
> +	TP_STRUCT__entry(
> +		__field(union __xeno_cond*, cond)
> +		__field(union __xeno_mutex*, mutex)
> +		__timespec_fields(timeout)
> +	),
> +	TP_fast_assign(
> +		__entry->cond = cond;
> +		__entry->mutex = mutex;
> +		__assign_timespec(timeout, timeout);
> +	),
> +	TP_printk("cond=%p mutex=%p timeout=%ld.%09ld",
> +		__entry->cond, __entry->mutex,
> +		__timespec_args(timeout))
> +);
> +
> +/* int pthread_cond_signal(pthread_cond_t *cnd)
> + */
> +DEFINE_EVENT(posix_cond, xn_posix_cond_signal,
> +	TP_PROTO(union __xeno_cond *cond),
> +	TP_ARGS(cond)
> +);
> +
> +/* int pthread_cond_broadcast(pthread_cond_t *cnd)
> + */
> +DEFINE_EVENT(posix_cond, xn_posix_cond_broadcast,
> +	TP_PROTO(union __xeno_cond *cond),
> +	TP_ARGS(cond)
> +);
> +
> +/*
> + * Message queues services.
> + */
> +DECLARE_EVENT_CLASS(posix_mq_sendrecv,
> +	TP_PROTO(int fd, char *buf, size_t len, unsigned prio),
> +	TP_ARGS(fd, buf, len, prio),
> +	TP_STRUCT__entry(
> +		__field(int, fd)
> +		__field(char *, buf)
> +		__field(size_t, len)
> +		__field(unsigned, prio)
> +	),
> +	TP_fast_assign(
> +		__entry->fd = fd;
> +		__entry->buf = buf;
> +		__entry->len = len;
> +		__entry->prio = prio;
> +	),
> +	TP_printk("fd=%d buf=%p len=%zu prio=%d",
> +		__entry->fd, __entry->buf,
> +		__entry->len, __entry->prio)
> +);
> +
> +DECLARE_EVENT_CLASS(posix_mq_sendrecv_timespec,
> +	TP_PROTO(int fd, char *buf, size_t len, unsigned prio,
> +		struct timespec *timeout),
> +	TP_ARGS(fd, buf, len, prio, timeout),
> +	TP_STRUCT__entry(
> +		__field(int, fd)
> +		__field(char *, buf)
> +		__field(size_t, len)
> +		__field(unsigned, prio)
> +		__optional_timespec_fields(timeout)
> +	),
> +	TP_fast_assign(
> +		__entry->fd = fd;
> +		__entry->buf = buf;
> +		__entry->len = len;
> +		__entry->prio = prio;
> +		__assign_optional_timespec(timeout, timeout);
> +	),
> +	TP_printk("fd=%d buf=%p len=%zu prio=%d timeout(%s)=%ld.%09ld",
> +		__entry->fd, __entry->buf, __entry->len, __entry->prio,
> +		__timespec_used(timeout), __timespec_args(timeout))
> +);
> +
> +/* mqd_t mq_open(const char *name, int oflags,...)
> + */
> +TRACE_EVENT(xn_posix_mq_open,
> +	TP_PROTO(int fd, char *name, int oflags, int mode,
> +		struct mq_attr *attr),
> +	TP_ARGS(fd, name, oflags, mode, attr),
> +	TP_STRUCT__entry(
> +		__field(int, fd)
> +		__string(name, name)
> +		__field(int, oflags)
> +		__field(int, mode)
> +		__field(struct mq_attr *, attr)
> +	),
> +	TP_fast_assign(
> +		__entry->fd = fd;
> +		__assign_str(name, name);
> +		__entry->oflags = oflags;
> +		__entry->mode = mode;
> +		__entry->attr = attr;
> +	),
> +	TP_printk("fd=%d name=%s oflags=%#x(%s) mode=%04o attr=%p",
> +		__entry->fd, __get_str(name), __oflags_args(oflags),
> +		__entry->mode, __entry->attr)
> +);
> +
> +/* int mq_close(mqd_t fd)
> + */
> +DEFINE_EVENT(posix_fd, xn_posix_mq_close,
> +	TP_PROTO(int fd),
> +	TP_ARGS(fd)
> +);
> +
> +/* int mq_unlink(const char *name)
> + */
> +DEFINE_EVENT(posix_name, xn_posix_mq_unlink,
> +	TP_PROTO(char *name),
> +	TP_ARGS(name)
> +);
> +
> +/* int mq_send(mqd_t fd, const char *buffer, size_t len, unsigned prio)
> + */
> +DEFINE_EVENT(posix_mq_sendrecv, xn_posix_mq_send,
> +	TP_PROTO(int fd, char *buf, size_t len, unsigned prio),
> +	TP_ARGS(fd, buf, len, prio)
> +);
> +
> +/* int mq_timedsend(mqd_t fd, const char *buffer, size_t len, unsigned prio, const struct timespec *abs_timeout)
> + */
> +DEFINE_EVENT(posix_mq_sendrecv_timespec, xn_posix_mq_timedsend,
> +	TP_PROTO(int fd, char *buf, size_t len, unsigned prio,
> +		struct timespec *timeout),
> +	TP_ARGS(fd, buf, len, prio, timeout)
> +);
> +
> +/* ssize_t mq_receive(mqd_t fd, char *buffer, size_t len, unsigned *priop)
> + */
> +DEFINE_EVENT(posix_mq_sendrecv, xn_posix_mq_receive,
> +	TP_PROTO(int fd, char *buf, size_t len, unsigned prio),
> +	TP_ARGS(fd, buf, len, prio)
> +);
> +
> +DEFINE_EVENT(posix_mq_sendrecv, xn_posix_mq_receive_return,
> +	TP_PROTO(int fd, char *buf, size_t len, unsigned prio),
> +	TP_ARGS(fd, buf, len, prio)
> +);
> +
> +/* ssize_t mq_timedreceive(mqd_t fd, char *buffer, size_t len, unsigned *priop, const struct timespec *abs_timeout)
> + */
> +DEFINE_EVENT(posix_mq_sendrecv_timespec, xn_posix_mq_timedreceive,
> +	TP_PROTO(int fd, char *buf, size_t len, unsigned prio,
> +		struct timespec *timeout),
> +	TP_ARGS(fd, buf, len, prio, timeout)
> +);
> +
> +DEFINE_EVENT(posix_mq_sendrecv, xn_posix_mq_timedreceive_return,
> +	TP_PROTO(int fd, char *buf, size_t len, unsigned prio),
> +	TP_ARGS(fd, buf, len, prio)
> +);
> +
> +/* int mq_notify(mqd_t fd, const struct sigevent *evp)
> + * FIXME: add signal number
> + */
> +DEFINE_EVENT(posix_fd, xn_posix_mq_notify,
> +	TP_PROTO(int fd),
> +	TP_ARGS(fd)
> +);
> +
> +/*
> + * Interruptions management services.
> + */
> +DECLARE_EVENT_CLASS(posix_intr,
> +	TP_PROTO(pthread_intr_t intr),
> +	TP_ARGS(intr),
> +	TP_STRUCT__entry(
> +		__field(pthread_intr_t, intr)
> +	),
> +	TP_fast_assign(
> +		__entry->intr = intr;
> +	),
> +	TP_printk("intr=%p", __entry->intr)
> +);
> +
> +/* int pthread_intr_attach_np(pthread_intr_t * intr, unsigned irq, int mode)
> + */
> +TRACE_EVENT(xn_posix_intr_attach_np,
> +	TP_PROTO(pthread_intr_t intr, int irq, int mode),
> +	TP_ARGS(intr, irq, mode),
> +	TP_STRUCT__entry(
> +		__field(pthread_intr_t , intr)
> +		__field(int, irq)
> +		__field(int, mode)
> +	),
> +	TP_fast_assign(
> +		__entry->intr = intr;
> +		__entry->irq = irq;
> +		__entry->mode = mode;
> +	),
> +	TP_printk("intr=%p irq=%d mode=%#x(%s)",
> +		  __entry->intr, __entry->irq, __intr_mode_args(mode))
> +);
> +
> +/* int pthread_intr_detach_np(pthread_intr_t intr)
> + */
> +DEFINE_EVENT(posix_intr, xn_posix_intr_detach_np,
> +	TP_PROTO(pthread_intr_t intr),
> +	TP_ARGS(intr)
> +);
> +
> +/*  int pthread_intr_wait_np(pthread_intr_t intr, const struct timespec *to)
> + */
> +TRACE_EVENT(xn_posix_intr_wait_np,
> +	TP_PROTO(pthread_intr_t intr, const struct timespec *timeout),
> +	TP_ARGS(intr, timeout),
> +	TP_STRUCT__entry(
> +		__field(pthread_intr_t, intr)
> +		__optional_timespec_fields(timeout)
> +	),
> +	TP_fast_assign(
> +		__entry->intr = intr;
> +		__assign_optional_timespec(timeout, timeout);
> +	),
> +	TP_printk("intr=%p timeout(%s)=%ld.%09ld", __entry->intr,
> +		__timespec_used(timeout), __timespec_args(timeout))
> +);
> +
> +/* int pthread_intr_control_np(pthread_intr_t intr, int cmd)
> + */
> +TRACE_EVENT(xn_posix_intr_control_np,
> +	TP_PROTO(pthread_intr_t intr, int cmd),
> +	TP_ARGS(intr, cmd),
> +	TP_STRUCT__entry(
> +		__field(pthread_intr_t , intr)
> +		__field(int, cmd)
> +	),
> +	TP_fast_assign(
> +		__entry->intr = intr;
> +		__entry->cmd = cmd;
> +	),
> +	TP_printk("intr=%p cmd=%#x(%s)",
> +		__entry->intr, __intr_cmd_args(cmd))
> +);
> +
> +/*
> + * Shared memory services.
> + */
> +DECLARE_EVENT_CLASS(posix_map,
> +	TP_PROTO(void *addr, size_t len),
> +	TP_ARGS(addr, len),
> +	TP_STRUCT__entry(
> +		__field(void *, addr)
> +		__field(int, len)
> +	),
> +	TP_fast_assign(
> +		__entry->addr = addr;
> +		__entry->len = len;
> +	),
> +	TP_printk("addr=%p len=%d", __entry->addr, __entry->len)
> +);
> +
> +/* int shm_open(const char *name, int oflags, mode_t mode)
> + */
> +TRACE_EVENT(xn_posix_shm_open,
> +	TP_PROTO(int fd, char *name, int oflags, int mode),
> +	TP_ARGS(fd, name, oflags, mode),
> +	TP_STRUCT__entry(
> +		__field(int, fd)
> +		__string(name, name)
> +		__field(int, oflags)
> +		__field(int, mode)
> +	),
> +	TP_fast_assign(
> +		__entry->fd = fd;
> +		__assign_str(name, name);
> +		__entry->oflags = oflags;
> +		__entry->mode = mode;
> +	),
> +	TP_printk("fd=%d name=%s oflags=%#x(%s) mode=%04o",
> +		__entry->fd, __get_str(name), __oflags_args(oflags),
> +		__entry->mode)
> +);
> +
> +/* int shm_close(int fd)
> + */
> +DEFINE_EVENT(posix_fd, xn_posix_shm_close,
> +	TP_PROTO(int fd),
> +	TP_ARGS(fd)
> +);
> +
> +/* int shm_unlink(const char *name)
> + */
> +DEFINE_EVENT(posix_name, xn_posix_shm_unlink,
> +	TP_PROTO(char *name),
> +	TP_ARGS(name)
> +);
> +
> +/* int ftruncate(int fd, off_t len)
> + */
> +TRACE_EVENT(xn_posix_ftruncate,
> +	TP_PROTO(int fd, off_t len),
> +	TP_ARGS(fd, len),
> +	TP_STRUCT__entry(
> +		__field(int, fd)
> +		__field(off_t, len)
> +	),
> +	TP_fast_assign(
> +		__entry->fd = fd;
> +		__entry->len = len;
> +	),
> +	TP_printk("fd=%d len=%ld", __entry->fd, __entry->len)
> +);
> +
> +/* void * mmap(void *addr, size_t len, int prot, int flags, int fd, off_t off)
> + */
> +TRACE_EVENT(xn_posix_mmap,
> +	TP_PROTO(size_t len, int fd, off_t off),
> +	TP_ARGS(len, fd, off),
> +	TP_STRUCT__entry(
> +		__field(int, len)
> +		__field(int, fd)
> +		__field(off_t, off)
> +	),
> +	TP_fast_assign(
> +		__entry->len = len;
> +		__entry->fd = fd;
> +		__entry->off = off;
> +	),
> +	TP_printk("len=%d fd=%d off=%ld",
> +		__entry->len, __entry->fd, __entry->off)
> +);
> +
> +DEFINE_EVENT(posix_map, xn_posix_mmap_return,
> +	TP_PROTO(void *addr, size_t len),
> +	TP_ARGS(addr, len)
> +);
> +
> +/* int munmap(void *addr, size_t len)
> + */
> +DEFINE_EVENT(posix_map, xn_posix_munmap,
> +	TP_PROTO(void *addr, size_t len),
> +	TP_ARGS(addr, len)
> +);
> +
> +/*
> + * I/O multiplexing (select) services.
> + */
> +
> +/* int select(int, fd_set **, int, struct timeval *)
> + */
> +TRACE_EVENT(xn_posix_select,
> +	TP_PROTO(int nfds, fd_set **fds, int using_to, struct timeval *to),
> +	TP_ARGS(nfds, fds, using_to, to),
> +	TP_STRUCT__entry(
> +		__field(int, nfds)
> +		__field(unsigned long, in_fds)
> +		__field(unsigned long, out_fds)
> +		__field(unsigned long, exc_fds)
> +		__optional_timespec_fields(timeout)
> +	),
> +	TP_fast_assign(
> +		__entry->nfds = nfds;
> +		__entry->in_fds = fds[0] ? fds[0]->fds_bits[0] : 0;
> +		__entry->out_fds = fds[1] ? fds[1]->fds_bits[0] : 0;
> +		__entry->exc_fds = fds[2] ? fds[2]->fds_bits[0] : 0;
> +		__entry->using_timeout = using_to;
> +		if (using_to) {
> +			__entry->tv_sec_timeout = to->tv_sec;
> +			__entry->tv_nsec_timeout = to->tv_usec * 1000;
> +		} else {
> +			__entry->tv_sec_timeout = 0;
> +			__entry->tv_nsec_timeout = 0;
> +		}
> +	),
> +	TP_printk("nfds=%d in=%lx... out=%lx... exc=%lx..."
> +		  " timeout(%s)=%ld.%09ld", __entry->nfds, __entry->in_fds,
> +		  __entry->out_fds, __entry->exc_fds,
> +		  __timespec_used(timeout), __timespec_args(timeout))
> +);
> +#endif

Do we really have to add all that dead code?

-- 
					    Gilles.

