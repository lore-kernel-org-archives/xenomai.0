Subject: Re: [y2038][RFC PATCH 2/2] y2038: Adding sem_timedwait_time64
References: <87v9a7z0xh.fsf@xenomai.org>
 <20210304113653.45432-1-florian.bezdeka@siemens.com>
 <20210304113653.45432-3-florian.bezdeka@siemens.com>
 <6041C65D.1070109@tj.kylinos.cn>
 <20427835a99ada0a326072d8c4e2941e3b12121e.camel@siemens.com>
From: chensong <chensong@tj.kylinos.cn>
Message-ID: <6041E0F6.9060509@tj.kylinos.cn>+54A20D85F00AA805
Date: Fri, 5 Mar 2021 15:42:46 +0800
MIME-Version: 1.0
In-Reply-To: <20427835a99ada0a326072d8c4e2941e3b12121e.camel@siemens.com>
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
To: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
Cc: "rpm@xenomai.org" <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "chensong@kylinos.cn" <chensong@kylinos.cn>



On 2021年03月05日 14:36, florian.bezdeka@siemens.com wrote:
> On Fri, 2021-03-05 at 13:49 +0800, chensong wrote:
>>
>> On 2021年03月04日 19:36, Florian Bezdeka via Xenomai wrote:
>>> Implementation is heavily inspired by the sem_timedwait syscall,
>>> but expecting time64 based timespec / timeout.
>>>
>>> We need two new syscall handlers:
>>>     - The native one (COBALT_SYSCALL()) to get 32 bit kernels time64
>>>       aware. This handler is added for 64 bit kernels as well, but not
>>>       used. As we don't have separate syscall tables for this both
>>>       worlds we have to add it.
>>>
>>>    - The compat handler (COBALT_SYSCALL32emu()) for x32 or x86
>>>      applications running on an x86_64 kernel. Otherwise the redirection
>>>      to the compat / emulation syscalls is broken.
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>    include/cobalt/uapi/syscall.h   |  1 +
>>>    kernel/cobalt/posix/sem.c       | 12 ++++++++++++
>>>    kernel/cobalt/posix/sem.h       |  4 ++++
>>>    kernel/cobalt/posix/syscall32.c | 12 ++++++++++++
>>>    kernel/cobalt/posix/syscall32.h |  4 ++++
>>>    5 files changed, 33 insertions(+)
>>>
>>> diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
>>> index aa3c308d0..9b005da47 100644
>>> --- a/include/cobalt/uapi/syscall.h
>>> +++ b/include/cobalt/uapi/syscall.h
>>> @@ -122,6 +122,7 @@
>>>    #define sc_cobalt_sendmmsg			99
>>>    #define sc_cobalt_clock_adjtime			100
>>>    #define sc_cobalt_thread_setschedprio		101
>>> +#define sc_cobalt_sem_timedwait_time64		102
>>>
>>>    #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
>>>
>>> diff --git a/kernel/cobalt/posix/sem.c b/kernel/cobalt/posix/sem.c
>>> index a0565e9f8..a2211af36 100644
>>> --- a/kernel/cobalt/posix/sem.c
>>> +++ b/kernel/cobalt/posix/sem.c
>>> @@ -430,6 +430,18 @@ COBALT_SYSCALL(sem_timedwait, primary,
>>>    	return __cobalt_sem_timedwait(u_sem, &ts64);
>>>    }
>>>
>>> +COBALT_SYSCALL(sem_timedwait_time64, primary,
>>> +	       (struct cobalt_sem_shadow __user *u_sem,
>>> +		const struct __kernel_timespec __user *u_ts))
>>> +{
>>> +	struct timespec64 ts64;
>>> +
>>> +	if (get_timespec64(&ts64, u_ts))
>>
>> get_timespec64 didn't exist until kernel 4.13, shall we take care of this?
>> get_timespec64 uses copy_from_user, is  there any side effect?
>
> Yes and yes. I already noticed it but did not send out v2 due to some
> other this I have to address first. Still trying to find a way that
> allows us to prevent duplication all the necessary helpers...

Or we don't use helpers, like this
struct __kernel_timespec kts;
struct timespec64 ts64;

cobalt_copy_from_user(&kts, u_ts, sizeof(kts));

ts64.tv_sec = kts.tv_sec;

i'm working on clock.c, and will submit patches, please review.


>
>>
>>> +		return -EFAULT;
>>> +
>>> +	return __cobalt_sem_timedwait(u_sem, &ts64);
>>> +}
>>> +
>>>    COBALT_SYSCALL(sem_trywait, primary,
>>>    	       (struct cobalt_sem_shadow __user *u_sem))
>>>    {
>>> diff --git a/kernel/cobalt/posix/sem.h b/kernel/cobalt/posix/sem.h
>>> index 658e11f7a..8491b69ba 100644
>>> --- a/kernel/cobalt/posix/sem.h
>>> +++ b/kernel/cobalt/posix/sem.h
>>> @@ -66,6 +66,10 @@ __cobalt_sem_open(struct cobalt_sem_shadow __user *usm,
>>>    int __cobalt_sem_timedwait(struct cobalt_sem_shadow __user *u_sem,
>>>    			   const struct timespec64 *ts);
>>>
>>> +COBALT_SYSCALL_DECL(sem_timedwait_time64,
>>> +		    (struct cobalt_sem_shadow __user *u_sem,
>>> +		     const struct __kernel_timespec __user *u_ts));
>>> +
>>>    int __cobalt_sem_destroy(xnhandle_t handle);
>>>
>>>    void cobalt_nsem_reclaim(struct cobalt_process *process);
>>> diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
>>> index c2a2423ed..d50532952 100644
>>> --- a/kernel/cobalt/posix/syscall32.c
>>> +++ b/kernel/cobalt/posix/syscall32.c
>>> @@ -136,6 +136,18 @@ COBALT_SYSCALL32emu(sem_timedwait, primary,
>>>    	return __cobalt_sem_timedwait(u_sem, &ts64);
>>>    }
>>>
>>> +COBALT_SYSCALL32emu(sem_timedwait_time64, primary,
>>> +		    (struct cobalt_sem_shadow __user *u_sem,
>>> +		     const struct __kernel_timespec __user *u_ts))
>>> +{
>>> +	struct timespec64 ts64;
>>> +
>>> +	if (get_timespec64(&ts64, u_ts))
>>> +		return -EFAULT;
>>> +
>>> +	return __cobalt_sem_timedwait(u_sem, &ts64);
>>> +}
>>> +
>>>    COBALT_SYSCALL32emu(clock_getres, current,
>>>    		    (clockid_t clock_id,
>>>    		     struct old_timespec32 __user *u_ts))
>>> diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
>>> index d72fd2022..3612bf751 100644
>>> --- a/kernel/cobalt/posix/syscall32.h
>>> +++ b/kernel/cobalt/posix/syscall32.h
>>> @@ -231,4 +231,8 @@ COBALT_SYSCALL32emu_DECL(sem_timedwait,
>>>    			 (struct cobalt_sem_shadow __user *u_sem,
>>>    			  const struct old_timespec32 __user *u_ts));
>>>
>>> +COBALT_SYSCALL32emu_DECL(sem_timedwait_time64,
>>> +			 (struct cobalt_sem_shadow __user * u_sem,
>>> +			  const struct __kernel_timespec __user *u_ts));
>>> +
>>>    #endif /* !_COBALT_POSIX_SYSCALL32_H */
>>>
>>
>>
>



