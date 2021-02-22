Subject: Re: [PATCH 2/5] cobalt/kernel: y2038: convert struct timespec to
 timespec64
References: <20210220151840.409745-1-rpm@xenomai.org>
 <20210220151840.409745-2-rpm@xenomai.org> <6031C2CF.3050202@kylinos.cn>
 <87h7m54f1i.fsf@xenomai.org>
From: chensong <chensong@kylinos.cn>
Message-ID: <60330307.2050108@kylinos.cn>
Date: Mon, 22 Feb 2021 09:04:07 +0800
MIME-Version: 1.0
In-Reply-To: <87h7m54f1i.fsf@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org



On 2021年02月21日 23:27, Philippe Gerum wrote:
>
> chensong via Xenomai <xenomai@xenomai.org> writes:
>
>>> +/*
>>> + * Our representation of time at the kernel<->user interface boundary
>>> + * at the moment, until we have fully transitioned to a y2038-safe
>>> + * implementation in libcobalt.
>>> + */
>>> +struct __user_old_timespec {
>>> +	long  tv_sec;
>>> +	long  tv_nsec;
>>> +};
>>
>> why not use old_timespec32, which is timespec32 representation defined
>> in include/linux/time32?
>>
>
> Using old_timespec32 in this context would mean that any time value
> received from userland by the core should be restricted to 32bit time_t,
> which is not what we want, at least for 64bit platforms:
>
> include/vdso/time32.h:
>
> struct old_timespec32 {
> 	old_time32_t	tv_sec;
> 	s32		tv_nsec;
> };
>
> __user_old_timespec conveys the notion that we are generically talking
> about "the old timespec type which has a y2038 problem"; this is not
> specifically about the legacy timespec type on 32bit machines.
>
> Since v5.4-rc6, we do have __kernel_old_timespec though, which could
> have been used instead of __user_old_timespec:
>
> include/uapi/asm-generic/posix_types.h:
>
> typedef long __kernel_long_t;
>
> include/uapi/linux/time_types.h:
>
> struct __kernel_old_timespec {
> 	__kernel_long_t		tv_sec;		/* seconds */
> 	long			tv_nsec;	/* nanoseconds */
> };
>
> However, older (non-x86) toolchains do not define __kernel_old_timespec,
> so I went for adding __user_old_timespec to the Cobalt UAPI. This may be
> seen as a temporary option until stricter requirements on the minimum
> toolchain support for building Cobalt is decided.

what if we define __kernel_old_timespec in 
./kernel/cobalt/include/asm-generic/xenomai/wrappers.h, like we always 
do. we don't have to introduce a new struct.


>
>>>
>>>    COBALT_SYSCALL(clock_settime, current,
>>> -	       (clockid_t clock_id, const struct timespec __user *u_ts))
>>> +	       (clockid_t clock_id, const struct __user_old_timespec __user *u_ts))
>>
>> I planned to still use timespec as the argument, tv_sec is defined as
>> long, 32bit long in 32bit system, 64bit long in 64bit system, use
>> timespec64 in implementation.
>>

same with above, like "__kernel_old_timespec __user *u_ts",.

>
> Keeping struct timespec for the argument does not seem the right thing
> to do, as this type has been phased out from recent kernels, precisely
> to stop spreading ambiguity wrt 32/64 bit time_t. It is only available
> from the UAPI section as a compat tweak for user code, not for kernel
> code.
>
agree, in linux kernel, __kernel_timespec is specific for 64bit and 
old_timespec32 is specific for 32bit, clear. but we kind of need a 
blurry timespec, that's why we planed to keep timespec. 
__kernel_old_timespec looks like a good solution in this case.

> What should be done wrt addressing the y2038 issue fully is beyond this
> patch series. __user_old_timespec is merely an annotation on the
> existing implementation in order to highlight the kernel<->user
> interface boundary, which may help in fully addressing y2038 later on.
>
> Eventually, it should be decided whether a legacy timespec32 should
> still be supported for 32bit applications building in dual-time
> configurations (time32_t and time64_t), or single-time configuration
> should be the norm with user-space using time64_t exclusively. This is
> beyond the scope of this patch series to decide of the way to go.
>

