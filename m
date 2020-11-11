Subject: Re: [PATCH 4/5] kernel/cobalt/posix/syscall32:introduce
 old_timespec32 and __kernel_timespec to clock_settime of syscall32
References: <1604372723-2941-1-git-send-email-chensong@tj.kylinos.cn>
 <a071abb0-b4e3-582b-5493-20c479c39965@siemens.com>
 <5FAB7BBB.4040405@tj.kylinos.cn>
 <e9b44fff-fb59-b28f-8818-3582177fa116@siemens.com>
From: chensong <chensong@tj.kylinos.cn>
Message-ID: <5FABB4F9.8070105@tj.kylinos.cn>+E3092FE75AEB029D
Date: Wed, 11 Nov 2020 17:55:05 +0800
MIME-Version: 1.0
In-Reply-To: <e9b44fff-fb59-b28f-8818-3582177fa116@siemens.com>
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



On 2020年11月11日 15:34, Jan Kiszka wrote:
> On 11.11.20 06:50, chensong wrote:
>>
>>
>> On 2020年11月10日 18:17, Jan Kiszka wrote:
>>>
>>> On 03.11.20 04:05, chensong wrote:
>>>> 1, introduce old_timespec32 for 32bit process with 32bit timespec
>>>> 2, implement clock_settime64 for 32bit process with 64bit timespec
>>>>
>>>> Signed-off-by: chensong <chensong@tj.kylinos.cn>
>>>> ---
>>>>    include/cobalt/kernel/compat.h  |  6 ++++++
>>>>    kernel/cobalt/posix/compat.c    | 20 ++++++++++++++++++++
>>>>    kernel/cobalt/posix/syscall32.c | 20 +++++++++++++++++---
>>>>    kernel/cobalt/posix/syscall32.h |  6 +++++-
>>>>    4 files changed, 48 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/include/cobalt/kernel/compat.h
>>>> b/include/cobalt/kernel/compat.h
>>>> index 05754cb..adf8bae 100644
>>>> --- a/include/cobalt/kernel/compat.h
>>>> +++ b/include/cobalt/kernel/compat.h
>>>> @@ -89,6 +89,12 @@ struct compat_rtdm_mmap_request {
>>>>    int sys32_get_timespec(struct timespec *ts,
>>>>                   const struct compat_timespec __user *cts);
>>>>
>>>> +int sys32_get_timespec_old(struct timespec64 *ts,
>>>> +               const struct old_timespec32 __user *cts);
>>>> +
>>>> +int sys32_get_timespec64(struct timespec64 *ts,
>>>> +               const struct __kernel_timespec __user *cts);
>>>> +
>>>>    int sys32_put_timespec(struct compat_timespec __user *cts,
>>>>                   const struct timespec *ts);
>>>>
>>>> diff --git a/kernel/cobalt/posix/compat.c b/kernel/cobalt/posix/compat.c
>>>> index 17968bf..3042dc0 100644
>>>> --- a/kernel/cobalt/posix/compat.c
>>>> +++ b/kernel/cobalt/posix/compat.c
>>>> @@ -32,6 +32,26 @@ int sys32_get_timespec(struct timespec *ts,
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(sys32_get_timespec);
>>>>
>>>> +int sys32_get_timespec_old(struct timespec64 *ts,
>>>> +               const struct old_timespec32 __user *cts)
>>>> +{
>>>> +    return (cts == NULL ||
>>>> +        !access_rok(cts, sizeof(*cts)) ||
>>>> +        __xn_get_user(ts->tv_sec, &cts->tv_sec) ||
>>>> +        __xn_get_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(sys32_get_timespec_old);
>>>> +
>>>> +int sys32_get_timespec64(struct timespec64 *ts,
>>>> +               const struct __kernel_timespec __user *cts)
>>>> +{
>>>> +    return (cts == NULL ||
>>>> +        !access_rok(cts, sizeof(*cts)) ||
>>>> +        __xn_get_user(ts->tv_sec, &cts->tv_sec) ||
>>>> +        __xn_get_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(sys32_get_timespec64);
>>>> +
>>>>    int sys32_put_timespec(struct compat_timespec __user *cts,
>>>>                   const struct timespec *ts)
>>>>    {
>>>> diff --git a/kernel/cobalt/posix/syscall32.c
>>>> b/kernel/cobalt/posix/syscall32.c
>>>> index faa7ef5..47a8ad3 100644
>>>> --- a/kernel/cobalt/posix/syscall32.c
>>>> +++ b/kernel/cobalt/posix/syscall32.c
>>>> @@ -159,12 +159,26 @@ COBALT_SYSCALL32emu(clock_gettime, current,
>>>>
>>>>    COBALT_SYSCALL32emu(clock_settime, current,
>>>>                (clockid_t clock_id,
>>>> -             const struct compat_timespec __user *u_ts))
>>>> +             const struct old_timespec32 __user *u_ts))
>>>>    {
>>>> -    struct timespec ts;
>>>> +    struct timespec64 ts;
>>>> +    int ret;
>>>> +
>>>> +    ret = sys32_get_timespec_old(&ts, u_ts);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    return __cobalt_clock_settime(clock_id, &ts);
>>>> +}
>>>> +
>>>> +COBALT_SYSCALL32emu(clock_settime64, current,
>>>> +            (clockid_t clock_id,
>>>> +             const struct __kernel_timespec __user *u_ts))
>>>
>>> Hmm, do we need that as compat syscall? I would expect that the new
>>> settime64 ABI would work for both 32-bit and 64-bit applications, no?
>>>
>> i'm not quite sure about this part, clock_settime64 is specific for
>> 32bit process with 64bit timespect running on a 64bit kernel.
>>
>> compat_timespec is old_timespec32 in linux5.4.
>
> Dont' believe me blindly on this, I'm also trying to understand the
> matrix. My understanding is - as well - that clock_settime64 is only
> interesting for that compat path (32-bit on 64-bit). So maybe that
> other, common syscall declaration of patch 3 is redundant as our users
> will only take this compat path?
>
> Jan
>
patch 3 is not redundant, on the contrary, it's the most important one, 
please don't drop it.

patch 4 is for 32bit process with 32bit lib running in 64bit kernel(too 
complicated, is it?), but as our discussion, i don't think it's gonna 
happen, how about we drop patch 4?

chensong





