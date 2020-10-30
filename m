Subject: Re: [PATCH V2] y2038: replace timespec with timespec64 in
 clock_settime
References: <1601363964-19346-1-git-send-email-chensong@tj.kylinos.cn>
 <fedcac2a-e197-4581-7d2f-bb044ed0245a@siemens.com>
 <5F9BD3C8.1040606@tj.kylinos.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <bcae0322-904d-3f15-68b0-a47fea2b95a5@siemens.com>
Date: Fri, 30 Oct 2020 10:09:26 +0100
MIME-Version: 1.0
In-Reply-To: <5F9BD3C8.1040606@tj.kylinos.cn>
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
To: chensong <chensong@tj.kylinos.cn>, xenomai@xenomai.org

On 30.10.20 09:50, chensong wrote:
> 
> 
> On 2020年10月28日 00:33, Jan Kiszka wrote:
>> On 29.09.20 09:19, chensong wrote:
>>> Upstream has used timespec64 to replace timespec inside kernel and
>>> used __kernel_timespec to replace timespect in syscalls, therefore
>>> we must keep aligned with upstream.
>>>
>>> clock_settime is a point to get started at, it involves 2 parts:
>>> 1, syscall in ./include/trace/events/cobalt-posix.h for 64bits
>>> 2, compat syscall in kernel/cobalt/posix/syscall32.c for 32bits
>>> 3, define __kernel_timespec in wrapper.h for compatibility
>>>
>>> some new functions are implemented to keep the compatibility with
>>> other syscalls which haven't been handled yet and will be removed
>>> in the end of the work.
>>>
>>> Signed-off-by: chensong <chensong@tj.kylinos.cn>
>>>
>>> CC: Jan Kiszka <jan.kiszka@siemens.com>
>>> CC: Henning Schild <henning.schild@siemens.com>
>>> ---
>>>   include/cobalt/kernel/clock.h                      |  6 ++---
>>>   include/cobalt/kernel/compat.h                     |  3 +++
>>>   .../cobalt/include/asm-generic/xenomai/wrappers.h  |  9 +++++++
>>>   kernel/cobalt/posix/clock.c                        | 28
>>> +++++++++++++++++-----
>>>   kernel/cobalt/posix/clock.h                        | 15 ++++++++++--
>>>   kernel/cobalt/posix/compat.c                       | 11 +++++++++
>>>   kernel/cobalt/posix/syscall32.c                    |  6 ++---
>>>   kernel/cobalt/trace/cobalt-posix.h                 | 24
>>> +++++++++++++++++--
>>>   8 files changed, 86 insertions(+), 16 deletions(-)
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
>>>
>>>   static inline int xnclock_set_time(struct xnclock *clock,
>>> -                   const struct timespec *ts)
>>> +                   const struct timespec64 *ts)
>>>   {
>>>       if (likely(clock == &nkclock))
>>>           return -EINVAL;
>>> @@ -266,7 +266,7 @@ static inline xnticks_t
>>> xnclock_read_monotonic(struct xnclock *clock)
>>>   }
>>>
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
>>>
>>> +int sys64_get_timespec(struct timespec64 *ts,
>>> +               const struct compat_timespec __user *cts);
>>> +
>>>   int sys32_put_timespec(struct compat_timespec __user *cts,
>>>                  const struct timespec *ts);
>>>
>>> diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
>>> b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
>>> index 23993dc..e5375de 100644
>>> --- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
>>> +++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
>>> @@ -156,4 +156,13 @@ devm_hwmon_device_register_with_groups(struct
>>> device *dev, const char *name,
>>>   #error "Xenomai/cobalt requires Linux kernel 3.10 or above"
>>>   #endif /* < 3.10 */
>>>
>>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 18, 0)
>>> +typedef long long __kernel_time64_t;
>>> +struct __kernel_timespec {
>>> +    __kernel_time64_t       tv_sec;                 /* seconds */
>>> +    long long               tv_nsec;                /* nanoseconds */
>>> +};
>>> +#endif /* < 4.18 */
>>> +
>>> +
>>>   #endif /* _COBALT_ASM_GENERIC_WRAPPERS_H */
>>> diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
>>> index 561358e..c960d7b 100644
>>> --- a/kernel/cobalt/posix/clock.c
>>> +++ b/kernel/cobalt/posix/clock.c
>>> @@ -194,7 +194,7 @@ COBALT_SYSCALL(clock_gettime, current,
>>>       return 0;
>>>   }
>>>
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
>>>
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
>>
>> This is still a point where I see ABI breakage: On a 32-bit system,
>> struct timespec was using a 32-bit tv_sec. Now with struct
>> _kernel_timespec, this will become a 64-bit value. That is what we want
>> for new applications being built after this patch. However, existing
>> application - and that includes existing Xenomai libs built before this
>> change (stable kernel ABI...) will continue to deliver 32-bit tv_sec
>> here and break over this syscall change.
>>
>> To model such a change in an ABI-preserving way, we need some
>> "clock_settime64" syscall that new userspace will pick by default, and
>> an unmodified (those 2038-wise broken) clock_settime. Same for all other
>> syscalls and drivers taking time_t directly or indirectly.
>>
>> Jan
> 
> how about this way:
> 
> we copy the idea from musl's clock_settime(./src/time/clock_settime.c)
> which is:
> 
> #define IS32BIT(x) !((x)+0x80000000ULL>>32)
> 
> int clock_settime(clockid_t clk, const struct timespec *ts)
> {
> #ifdef SYS_clock_settime64
>     time_t s = ts->tv_sec;
>     long ns = ts->tv_nsec;
>     int r = -ENOSYS;
>     if (SYS_clock_settime == SYS_clock_settime64 || !IS32BIT(s))
>         r = __syscall(SYS_clock_settime64, clk,
>             ((long long[]){s, ns}));
>     if (SYS_clock_settime == SYS_clock_settime64 || r!=-ENOSYS)
>         return __syscall_ret(r);
>     if (!IS32BIT(s))
>         return __syscall_ret(-ENOTSUP);
>     return syscall(SYS_clock_settime, clk, ((long[]){s, ns}));
> #else
>     return syscall(SYS_clock_settime, clk, ts);
> #endif
> }
> 
> to ./lib/cobalt/clock.c, which is
> 
> COBALT_IMPL(int, clock_settime, (clockid_t clock_id, const struct
> timespec *tp))
> {
>     int ret;
> 
>     ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_settime, clock_id, tp);
>     if (ret) {
>         errno = ret;
>         return -1;
>     }
> 
>     return 0;
> }
> 
> in userspace, we use IS32BIT to check if tv_sec is 32bits, and switch it
> to long long and pass to kernel space.

But that does not address the problem that old userspace libs will pass
down 32-bit tv_sec, ie. will hand over smaller data structures. Also
musl expects that there is a SYS_clock_settime64.

At the same time, we won't have to address the case of running a newer
lib over an older kernel.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

