References: <20210220151840.409745-1-rpm@xenomai.org>
 <20210220151840.409745-2-rpm@xenomai.org> <6031C2CF.3050202@kylinos.cn>
 <87h7m54f1i.fsf@xenomai.org>
 <612b2ca09cb05c5cf641b35359205b905caf2a5c.camel@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 2/5] cobalt/kernel: y2038: convert struct timespec to
 timespec64
In-reply-to: <612b2ca09cb05c5cf641b35359205b905caf2a5c.camel@siemens.com>
Date: Mon, 22 Feb 2021 10:08:55 +0100
Message-ID: <87v9ak31w8.fsf@xenomai.org>
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
To: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
Cc: "chensong@kylinos.cn" <chensong@kylinos.cn>, "xenomai@xenomai.org" <xenomai@xenomai.org>


florian.bezdeka@siemens.com <florian.bezdeka@siemens.com> writes:

> On Sun, 2021-02-21 at 16:27 +0100, Philippe Gerum via Xenomai wrote:
>> chensong via Xenomai <xenomai@xenomai.org> writes:
>> 
>> > > +/*
>> > > + * Our representation of time at the kernel<->user interface boundary
>> > > + * at the moment, until we have fully transitioned to a y2038-safe
>> > > + * implementation in libcobalt.
>> > > + */
>> > > +struct __user_old_timespec {
>> > > +	long  tv_sec;
>> > > +	long  tv_nsec;
>> > > +};
>> > 
>> > why not use old_timespec32, which is timespec32 representation defined
>> > in include/linux/time32?
>> > 
>> 
>> Using old_timespec32 in this context would mean that any time value
>> received from userland by the core should be restricted to 32bit time_t,
>> which is not what we want, at least for 64bit platforms:
>> 
>> include/vdso/time32.h:
>> 
>> struct old_timespec32 {
>> 	old_time32_t	tv_sec;
>> 	s32		tv_nsec;
>> };
>> 
>> __user_old_timespec conveys the notion that we are generically talking
>> about "the old timespec type which has a y2038 problem"; this is not
>> specifically about the legacy timespec type on 32bit machines.
>> 
>> Since v5.4-rc6, we do have __kernel_old_timespec though, which could
>> have been used instead of __user_old_timespec:
>
> According to my information (based on
> https://elixir.bootlin.com/linux/v5.5-rc1/A/ident/__kernel_old_timespec
> ) this is available since v5.5-rc1.
>

This disagrees with the git history then:

commit 94c467ddb273dc9a6a4fb09aef392c119b151edb
Author: Arnd Bergmann <arnd@arndb.de>

    y2038: add __kernel_old_timespec and __kernel_old_time_t

$ git describe 94c467ddb273dc9a6a4fb09aef392c119b151edb
v5.4-rc6-2-g94c467ddb273dc9

>> 
>> include/uapi/asm-generic/posix_types.h:
>> 
>> typedef long __kernel_long_t;
>> 
>> include/uapi/linux/time_types.h:
>> 
>> struct __kernel_old_timespec {
>> 	__kernel_long_t		tv_sec;		/* seconds */
>> 	long			tv_nsec;	/* nanoseconds */
>> };
>>  
>> so I went for adding __user_old_timespec to the Cobalt UAPI. This may be
>> seen as a temporary option until stricter requirements on the minimum
>> toolchain support for building Cobalt is decided.
>
> __kernel_old_timespec is part of the "common" Linux uapi, so not x86
> specific. Could you explain the problem you know of (or even see) with
> some of the toolchains? Sounds strange...
>

(Cross) toolchains use a snapshot of the linux UAPI taken at some point
in time. If a toolchain is somewhat outdated compared to the current
state of the kernel UAPI, then there is a problem with using the types
it defines. e.g. recent linaro toolchains for aarch32, aarch64 do not
provide any definition for __kernel_old_timespec, yet.

Now, as Song suggested, I could have defined __kernel_old_timespec in
the Cobalt UAPI to address this, instead of defining
__user_old_timespec. I found an upside in clearly stating this
particular interface boundary for time values Cobalt-wise, using a
Cobalt-specific type. What this should become in a subsequent series of
patches addressing the y2038 issue fully is beyond the scope of the
current series.

>> 
>> > > 
>> > >   COBALT_SYSCALL(clock_settime, current,
>> > > -	       (clockid_t clock_id, const struct timespec __user *u_ts))
>> > > +	       (clockid_t clock_id, const struct __user_old_timespec __user *u_ts))
>> > 
>> > I planned to still use timespec as the argument, tv_sec is defined as
>> > long, 32bit long in 32bit system, 64bit long in 64bit system, use 
>> > timespec64 in implementation.
>> > 
>> 
>> Keeping struct timespec for the argument does not seem the right thing
>> to do, as this type has been phased out from recent kernels, precisely
>> to stop spreading ambiguity wrt 32/64 bit time_t. It is only available
>> from the UAPI section as a compat tweak for user code, not for kernel
>> code.
>
> We would need a definition for older kernels anyway, but why are we not
> allowed to re-use the definition from the uapi here?
>

Because the timespec type along with all other ambiguous types are now
hidden from the kernel code in recent mainline releases:

commit c766d1472c70d25ad475cf56042af1652e792b23
Author: Arnd Bergmann <arnd@arndb.de>

    y2038: hide timeval/timespec/itimerval/itimerspec types
    
Which gives, in include/uapi/linux/time.h:

#ifndef __KERNEL__
#ifndef _STRUCT_TIMESPEC
#define _STRUCT_TIMESPEC
struct timespec {
	__kernel_old_time_t	tv_sec;		/* seconds */
	long			tv_nsec;	/* nanoseconds */
};
#endif

struct timeval {
	__kernel_old_time_t	tv_sec;		/* seconds */
	__kernel_suseconds_t	tv_usec;	/* microseconds */
};

struct itimerspec {
	struct timespec it_interval;/* timer period */
	struct timespec it_value;	/* timer expiration */
};

struct itimerval {
	struct timeval it_interval;/* timer interval */
	struct timeval it_value;	/* current value */
};
#endif

>> 
>> What should be done wrt addressing the y2038 issue fully is beyond this
>> patch series. __user_old_timespec is merely an annotation on the
>> existing implementation in order to highlight the kernel<->user
>> interface boundary, which may help in fully addressing y2038 later on.
>> 
>> Eventually, it should be decided whether a legacy timespec32 should
>> still be supported for 32bit applications building in dual-time
>> configurations (time32_t and time64_t), or single-time configuration
>> should be the norm with user-space using time64_t exclusively. This is
>> beyond the scope of this patch series to decide of the way to go.
>
> Let's discuss that within the next Community Meeting Minutes. When we
> started scanning the code base to get an overview of all the things
> that have to be done we assumed that we would need to stay fully
> backward compatible and "single time_t" defined by the libc that is
> beeing used. That may have changed in the meantime and we could take
> other patterns into account as well.

-- 
Philippe.

