Subject: Re: [PATCH] y2038: replace timespec with timespec64 in clock_settime
References: <1600691577-12011-1-git-send-email-chensong@tj.kylinos.cn>
 <01014f7c-76ed-46ea-0c7c-920f6eb63b0e@siemens.com>
 <27465fc4-ab13-ffb7-eec4-21160fbeec8a@tj.kylinos.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <7e00b8e7-4029-00f0-38dc-6d9452b552e7@siemens.com>
Date: Mon, 28 Sep 2020 18:52:38 +0200
MIME-Version: 1.0
In-Reply-To: <27465fc4-ab13-ffb7-eec4-21160fbeec8a@tj.kylinos.cn>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: song <chensong@tj.kylinos.cn>, xenomai@xenomai.org

On 23.09.20 03:40, song wrote:
> 
> 
> On 2020/9/22 下午11:16, Jan Kiszka wrote:
>> On 21.09.20 14:32, chensong wrote:
>>> Upstream has used timespec64 to replace timespec inside kernel and
>>> used __kernel_timespec to replace timespect in syscalls, therefore
>>> we must keep aligned with upstream.
>>>
>>> clock_settime is a point to get started at, it involves 2 parts:
>>> 1, syscall in ./include/trace/events/cobalt-posix.h for 64bits
>>> 2, compat syscall in kernel/cobalt/posix/syscall32.c for 32bits
>>>
>>> some new functions are implemented to keep the compatibility with
>>> other syscalls which haven't been handled yet and will be removed
>>> in the end of the work.
>>
>> So, this switches also existing syscalls to 64-bit types, breaking the
>> current ABI, no? How much effort would it be to keep the old ABI,
>> adding a 64-bit one aside of it?
> 
> Not breaking current ABI, i didn't add any new ABIs specific for 64bits,
> i added some new static functions, like ts2ns and ts2ns64,
> sys32_put_timespec and sys64_put_timespec, specific for clock_settime.
> 

clock_settime accepts struct timespec so far, you are changing that to
struct __kernel_timespec. If I look at its definition in the kernel, it
uses __kernel_time64_t as tv_sec type. But our current 32-bit users
still expects a 32-bit type here, no? Would that change already require
a new clock_settime64 syscall if we wanted to stay binary compatible?

> 
> When all the syscalls has been finished, every one uses timespec64,
> those new static functions can be removed.
> 
> e.g
> clock_settime is the ABI i'm working on, it calls ts2ns, but ts2ns only
> accepts timespec, clock_gettime uses ts2ns as well, therefore, i
> couldn't make them both work, i have to add a new ts2ns64(timespec64),
> after i finish clock_gettime and nobody else uses ts2ns, i can remove
> ts2ns64 and switch back to ts2ns(timespec64 as its parameter)
> 
> Arnd Bergmann followed the similar process. He also added some ABIs
> which 32bit is not compatible of, but not this one.
> 
> Effort, as far as i can tell, not too much, around 10 fucntions as my
> estimation.
> 
>>
>>>
>>> Signed-off-by: chensong <chensong@tj.kylinos.cn>
>>> ---
>>>   include/cobalt/kernel/clock.h      |  6 +++---
>>>   include/cobalt/kernel/compat.h     |  3 +++
>>>   kernel/cobalt/posix/clock.c        | 28 ++++++++++++++++++++++------
>>>   kernel/cobalt/posix/clock.h        | 12 +++++++++++-
>>>   kernel/cobalt/posix/compat.c       | 11 +++++++++++
>>>   kernel/cobalt/posix/syscall32.c    |  6 +++---
>>>   kernel/cobalt/trace/cobalt-posix.h | 24 ++++++++++++++++++++++--
>>>   7 files changed, 75 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/include/cobalt/kernel/clock.h
>>> b/include/cobalt/kernel/clock.h
>>> index c26776a..cf9d5ec 100644
>>> --- a/include/cobalt/kernel/clock.h
>>> +++ b/include/cobalt/kernel/clock.h
>>> @@ -52,7 +52,7 @@ struct xnclock {
>>>           xnticks_t (*read_raw)(struct xnclock *clock);
>>>           xnticks_t (*read_monotonic)(struct xnclock *clock);
>>>           int (*set_time)(struct xnclock *clock,
>>> -                const struct timespec *ts);
>>> +                const struct timespec64 *ts);
>>>           xnsticks_t (*ns_to_ticks)(struct xnclock *clock,
>>>                         xnsticks_t ns);
>>>           xnsticks_t (*ticks_to_ns)(struct xnclock *clock,
>>> @@ -213,7 +213,7 @@ static inline xnticks_t
>>> xnclock_read_monotonic(struct xnclock *clock)
>>>   }
>>>   static inline int xnclock_set_time(struct xnclock *clock,
>>> -                   const struct timespec *ts)
>>> +                   const struct timespec64 *ts)
>>>   {
>>>       if (likely(clock == &nkclock))
>>>           return -EINVAL;
>>> @@ -266,7 +266,7 @@ static inline xnticks_t
>>> xnclock_read_monotonic(struct xnclock *clock)
>>>   }
>>>   static inline int xnclock_set_time(struct xnclock *clock,
>>> -                   const struct timespec *ts)
>>> +                   const struct timespec64 *ts)
>>>   {
>>>       /*
>>>        * There is no way to change the core clock's idea of time.
>>> diff --git a/include/cobalt/kernel/compat.h
>>> b/include/cobalt/kernel/compat.h
>>> index 05754cb..70e2c03 100644
>>> --- a/include/cobalt/kernel/compat.h
>>> +++ b/include/cobalt/kernel/compat.h
>>> @@ -89,6 +89,9 @@ struct compat_rtdm_mmap_request {
>>>   int sys32_get_timespec(struct timespec *ts,
>>>                  const struct compat_timespec __user *cts);
>>> +int sys64_get_timespec(struct timespec64 *ts,
>>> +               const struct compat_timespec __user *cts);
>>> +
>>>   int sys32_put_timespec(struct compat_timespec __user *cts,
>>>                  const struct timespec *ts);
>>> diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
>>> index 561358e..c960d7b 100644
>>> --- a/kernel/cobalt/posix/clock.c
>>> +++ b/kernel/cobalt/posix/clock.c
>>> @@ -194,7 +194,7 @@ COBALT_SYSCALL(clock_gettime, current,
>>>       return 0;
>>>   }
>>> -int __cobalt_clock_settime(clockid_t clock_id, const struct timespec
>>> *ts)
>>> +int __cobalt_clock_settime(clockid_t clock_id, const struct
>>> timespec64 *ts)
>>>   {
>>>       int _ret, ret = 0;
>>>       xnticks_t now;
>>> @@ -207,7 +207,7 @@ int __cobalt_clock_settime(clockid_t clock_id,
>>> const struct timespec *ts)
>>>       case CLOCK_REALTIME:
>>>           xnlock_get_irqsave(&nklock, s);
>>>           now = xnclock_read_realtime(&nkclock);
>>> -        xnclock_adjust(&nkclock, (xnsticks_t) (ts2ns(ts) - now));
>>> +        xnclock_adjust(&nkclock, (xnsticks_t) (ts2ns64(ts) - now));
>>>           xnlock_put_irqrestore(&nklock, s);
>>>           break;
>>>       default:
>>> @@ -242,15 +242,31 @@ int __cobalt_clock_adjtime(clockid_t clock_id,
>>> struct timex *tx)
>>>       return 0;
>>>   }
>>> +static int __cobalt_get_timespec64(struct timespec64 *ts,
>>> +             const struct __kernel_timespec __user *uts)
>>> +{
>>> +    struct __kernel_timespec kts;
>>> +    int ret;
>>> +
>>> +    ret = cobalt_copy_from_user(&kts, uts, sizeof(kts));
>>> +    if (ret)
>>> +        return -EFAULT;
>>> +
>>> +    ts->tv_sec  = kts.tv_sec;
>>> +    ts->tv_nsec = kts.tv_nsec;
>>> +
>>> +    return 0;
>>> +
>>> +}
>>>   COBALT_SYSCALL(clock_settime, current,
>>> -           (clockid_t clock_id, const struct timespec __user *u_ts))
>>> +    (clockid_t clock_id, const struct __kernel_timespec __user *u_ts))
>>>   {
>>> -    struct timespec ts;
>>> +    struct timespec64 new_ts;
>>> -    if (cobalt_copy_from_user(&ts, u_ts, sizeof(ts)))
>>> +    if (__cobalt_get_timespec64(&new_ts, u_ts))
>>>           return -EFAULT;
>>> -    return __cobalt_clock_settime(clock_id, &ts);
>>> +    return __cobalt_clock_settime(clock_id, &new_ts);
>>>   }
>>>   COBALT_SYSCALL(clock_adjtime, current,
>>> diff --git a/kernel/cobalt/posix/clock.h b/kernel/cobalt/posix/clock.h
>>> index 0b06b93..3b0f910 100644
>>> --- a/kernel/cobalt/posix/clock.h
>>> +++ b/kernel/cobalt/posix/clock.h
>>> @@ -43,6 +43,16 @@ static inline xnticks_t ts2ns(const struct
>>> timespec *ts)
>>>       return nsecs;
>>>   }
>>> +static inline xnticks_t ts2ns64(const struct timespec64 *ts)
>>> +{
>>> +    xnticks_t nsecs = ts->tv_nsec;
>>> +
>>> +    if (ts->tv_sec)
>>> +        nsecs += (xnticks_t)ts->tv_sec * ONE_BILLION;
>>> +
>>> +    return nsecs;
>>> +}
>>> +
>>>   static inline xnticks_t tv2ns(const struct timeval *tv)
>>>   {
>>>       xnticks_t nsecs = tv->tv_usec * 1000;
>>> @@ -86,7 +96,7 @@ int __cobalt_clock_gettime(clockid_t clock_id,
>>>                  struct timespec *ts);
>>>   int __cobalt_clock_settime(clockid_t clock_id,
>>> -               const struct timespec *ts);
>>> +               const struct timespec64 *ts);
>>>   int __cobalt_clock_adjtime(clockid_t clock_id,
>>>                  struct timex *tx);
>>> diff --git a/kernel/cobalt/posix/compat.c b/kernel/cobalt/posix/compat.c
>>> index 17968bf..08aedcf 100644
>>> --- a/kernel/cobalt/posix/compat.c
>>> +++ b/kernel/cobalt/posix/compat.c
>>> @@ -32,6 +32,17 @@ int sys32_get_timespec(struct timespec *ts,
>>>   }
>>>   EXPORT_SYMBOL_GPL(sys32_get_timespec);
>>> +int sys64_get_timespec(struct timespec64 *ts,
>>> +               const struct compat_timespec __user *cts)
>>> +{
>>> +    return (cts == NULL ||
>>> +        !access_rok(cts, sizeof(*cts)) ||
>>> +        __xn_get_user(ts->tv_sec, &cts->tv_sec) ||
>>> +        __xn_get_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(sys64_get_timespec);
>>> +
>>> +
>>>   int sys32_put_timespec(struct compat_timespec __user *cts,
>>>                  const struct timespec *ts)
>>>   {
>>> diff --git a/kernel/cobalt/posix/syscall32.c
>>> b/kernel/cobalt/posix/syscall32.c
>>> index faa7ef5..4b1dfcc 100644
>>> --- a/kernel/cobalt/posix/syscall32.c
>>> +++ b/kernel/cobalt/posix/syscall32.c
>>> @@ -161,14 +161,14 @@ COBALT_SYSCALL32emu(clock_settime, current,
>>>               (clockid_t clock_id,
>>>                const struct compat_timespec __user *u_ts))
>>>   {
>>> -    struct timespec ts;
>>> +    struct timespec64 new_ts;
>>>       int ret;
>>> -    ret = sys32_get_timespec(&ts, u_ts);
>>> +    ret = sys64_get_timespec(&new_ts, u_ts);
>>>       if (ret)
>>>           return ret;
>>> -    return __cobalt_clock_settime(clock_id, &ts);
>>> +    return __cobalt_clock_settime(clock_id, &new_ts);
>>>   }
>>>   COBALT_SYSCALL32emu(clock_adjtime, current,
>>> diff --git a/kernel/cobalt/trace/cobalt-posix.h
>>> b/kernel/cobalt/trace/cobalt-posix.h
>>> index aa78efb..f764872 100644
>>> --- a/kernel/cobalt/trace/cobalt-posix.h
>>> +++ b/kernel/cobalt/trace/cobalt-posix.h
>>> @@ -748,6 +748,26 @@ DECLARE_EVENT_CLASS(cobalt_clock_timespec,
>>>       )
>>>   );
>>> +DECLARE_EVENT_CLASS(cobalt_clock_timespec64,
>>> +    TP_PROTO(clockid_t clk_id, const struct timespec64 *val),
>>> +    TP_ARGS(clk_id, val),
>>> +
>>> +    TP_STRUCT__entry(
>>> +        __field(clockid_t, clk_id)
>>> +        __timespec_fields(val)
>>> +    ),
>>> +
>>> +    TP_fast_assign(
>>> +        __entry->clk_id = clk_id;
>>> +        __assign_timespec(val, val);
>>> +    ),
>>> +
>>> +    TP_printk("clock_id=%d timeval=(%ld.%09ld)",
>>> +          __entry->clk_id,
>>> +          __timespec_args(val)
>>> +    )
>>> +);
>>> +
>>>   DEFINE_EVENT(cobalt_clock_timespec, cobalt_clock_getres,
>>>       TP_PROTO(clockid_t clk_id, const struct timespec *res),
>>>       TP_ARGS(clk_id, res)
>>> @@ -758,8 +778,8 @@ DEFINE_EVENT(cobalt_clock_timespec,
>>> cobalt_clock_gettime,
>>>       TP_ARGS(clk_id, time)
>>>   );
>>> -DEFINE_EVENT(cobalt_clock_timespec, cobalt_clock_settime,
>>> -    TP_PROTO(clockid_t clk_id, const struct timespec *time),
>>> +DEFINE_EVENT(cobalt_clock_timespec64, cobalt_clock_settime,
>>> +    TP_PROTO(clockid_t clk_id, const struct timespec64 *time),
>>>       TP_ARGS(clk_id, time)
>>>   );
>>>
>>
>> Thanks for this first step! Did you also test that it works with older
>> kernels? I see no wrappers, so I suspect breakages.
> I only have 64bit system, both 32bit process and 64bit process are
> working fine with clock_settime.

I meant: Please also try building your changes against kernel 4.4. If
that breaks because of some later introduced type, identify the kernel
version that did it and add that conditionally for older versions to
kernel/cobalt/include/asm-generic/xenomai/wrappers.h.

> 32bit process could still break unless it's recompiled as you said in
> last email. But in theory, it could be 2038safe after recompiled because
> process and system are both use 64bit sec. I will work on it when i
> start clock_gettime.
> 
> I tried to use timespec64 explicitly in my userspace, but i got this
> "storage size of ts isn't know"

timespec64 is not userspace-exposed type, is it? It's kernel internal.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

