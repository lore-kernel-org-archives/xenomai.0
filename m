References: <20210220151840.409745-1-rpm@xenomai.org>
 <20210220151840.409745-2-rpm@xenomai.org>
 <f369db49a43257fc7e7ae3f800dc1dbaed79f624.camel@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 2/5] cobalt/kernel: y2038: convert struct timespec to
 timespec64
In-reply-to: <f369db49a43257fc7e7ae3f800dc1dbaed79f624.camel@siemens.com>
Date: Thu, 04 Mar 2021 10:35:59 +0100
Message-ID: <878s731csg.fsf@xenomai.org>
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
Cc: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, "chensong@kylinos.cn" <chensong@kylinos.cn>


florian.bezdeka@siemens.com <florian.bezdeka@siemens.com> writes:

> On Sat, 2021-02-20 at 16:18 +0100, Philippe Gerum via Xenomai wrote:
> [snip]
>> diff --git a/kernel/cobalt/posix/sem.c b/kernel/cobalt/posix/sem.c
>> index 05a861dfe..467a9b7dd 100644
>> --- a/kernel/cobalt/posix/sem.c
>> +++ b/kernel/cobalt/posix/sem.c
>> @@ -267,7 +267,7 @@ out:
>>  	return ret;
>>  }
>>  
>> -static inline int sem_fetch_timeout(struct timespec *ts,
>> +static inline int sem_fetch_timeout(struct timespec64 *ts,
>>  				    const void __user *u_ts)
>
> Handle the following with care, maybe my understanding of
> CONFIG_XENO_ARCH_SYS3264 is wrong. See below...
>
> My understanding is that this is a breaking change for 32 bit kernels.
> The broken part is hidden here, but sem_fetch_timeout() now assumes
> that the user provided timespec64, which is not be the case for 32 bit
> applications running on a 32 bit kernel.
>

The user-provided memory is referred to by u_ts, not ts, which receives
the timestamp fetch_timeout() is supposed to return. The change should
only affect the return type, not the source one. sys32_fetch_timeout()
should still do the right thing via sys32_get_timespec().

Did you observe a manifest breakage with 32_64 setups?

>
>>  {
>>  	return u_ts == NULL ? -EFAULT :
>> @@ -276,10 +276,10 @@ static inline int sem_fetch_timeout(struct timespec *ts,
>>  
>>  int __cobalt_sem_timedwait(struct cobalt_sem_shadow __user *u_sem,
>>  			   const void __user *u_ts,
>> -			   int (*fetch_timeout)(struct timespec *ts,
>> +			   int (*fetch_timeout)(struct timespec64 *ts,
>>  						const void __user *u_ts))
>>  {
>> -	struct timespec ts = { .tv_sec = 0, .tv_nsec = 0 };
>> +	struct timespec64 ts = { .tv_sec = 0, .tv_nsec = 0 };
>>  	int pull_ts = 1, ret, info;
>>  	struct cobalt_sem *sem;
>>  	xnhandle_t handle;
>> @@ -434,7 +434,7 @@ COBALT_SYSCALL(sem_wait, primary,
>>  
>>  COBALT_SYSCALL(sem_timedwait, primary,
>>  	       (struct cobalt_sem_shadow __user *u_sem,
>> -		struct timespec __user *u_ts))
>> +		struct __user_old_timespec __user *u_ts))
>
> This change is still correct, but this is where the journey begins. If
> my understanding of CONFIG_XENO_ARCH_SYS3264 is correct, this syscall
> is being used on 32 bit kernels as well. Is that understanding correct?

COBALT_SYSCALL(sem_timedwait, ...) is only used in native (e.g. mere
64bit, or 32bit) mode. The following one is used in 32bit over 64bit
mode specifically:

COBALT_SYSCALL32emu(sem_timedwait, primary,
		    (struct cobalt_sem_shadow __user *u_sem,
		     struct old_timespec32 __user *u_ts))


-- 
Philippe.

