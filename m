Sender: chensong_2000@189.cn
Subject: Re: [PATCH v2 1/3] y2038: cobalt/posix/io: Adding recvmmsg64
References: <1631071827-3757-1-git-send-email-chensong_2000@189.cn>
 <13445d5c6b84d2686cee9896a45f34b02341b4b2.camel@siemens.com>
From: "chensong_2000@189.cn" <chensong_2000@189.cn>
Message-ID: <83543500-8ee4-81c9-56e4-9bd1650bbe85@189.cn>
Date: Thu, 9 Sep 2021 10:24:15 +0800
MIME-Version: 1.0
In-Reply-To: <13445d5c6b84d2686cee9896a45f34b02341b4b2.camel@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
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
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>



在 2021/9/8 下午5:03, Bezdeka, Florian 写道:
> On Wed, 2021-09-08 at 11:30 +0800, Song Chen wrote:
>> Add a syscall specific for recvmmsg64 with 64bit time_t.
>>
>> ---
>> v2:
>> 1, adjust indentation, different files have different indentation, see
>>     ./kernel/cobalt/posix/io.h
>>     ./kernel/cobalt/posix/syscall32.h
>>     I followed the function definition around mine
>> 2, remove duplicated helper get_timespec64_xeno
>>     get_timespec64 is defined in vanilla kernel, that's why suffix _xeno,
>>     but it still looks weired, it does nothing but just call
>>     cobalt_get_timespec64, so why not call cobalt_get_timespec64 directly
>>     with a little change of its definition.
>>
>> Signed-off-by: Song Chen <chensong_2000@189.cn>
>> ---
>>   include/cobalt/kernel/time.h    |  6 ++----
>>   include/cobalt/uapi/syscall.h   |  1 +
>>   kernel/cobalt/posix/io.c        |  9 +++++++++
>>   kernel/cobalt/posix/io.h        |  5 +++++
>>   kernel/cobalt/posix/syscall32.c | 15 +++++++++++++--
>>   kernel/cobalt/posix/syscall32.h |  6 ++++++
>>   kernel/cobalt/rtdm/fd.c         |  2 +-
>>   kernel/cobalt/time.c            |  6 ++----
>>   8 files changed, 39 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/cobalt/kernel/time.h b/include/cobalt/kernel/time.h
>> index e48022f..ace6086 100644
>> --- a/include/cobalt/kernel/time.h
>> +++ b/include/cobalt/kernel/time.h
>> @@ -14,8 +14,7 @@
>>    * @param uts The source, provided by an application
>>    * @return 0 on success, -EFAULT otherwise
>>    */
>> -int cobalt_get_timespec64(struct timespec64 *ts,
>> -			  const struct __kernel_timespec __user *uts);
>> +int cobalt_get_timespec64(struct timespec64 *ts, const void __user *uts);
> 
> Should not be necessary. See below.
> 
>>   
>>   /**
>>    * Covert struct timespec64 to struct __kernel_timespec
>> @@ -25,7 +24,6 @@ int cobalt_get_timespec64(struct timespec64 *ts,
>>    * @param uts The destination, will be filled
>>    * @return 0 on success, -EFAULT otherwise
>>    */
>> -int cobalt_put_timespec64(const struct timespec64 *ts,
>> -			   struct __kernel_timespec __user *uts);
>> +int cobalt_put_timespec64(const struct timespec64 *ts, void __user *uts);
>>   
>>   #endif //_COBALT_KERNEL_TIME_H
>> diff --git a/include/cobalt/uapi/syscall.h b/include/cobalt/uapi/syscall.h
>> index 16edce1..1523ddd 100644
>> --- a/include/cobalt/uapi/syscall.h
>> +++ b/include/cobalt/uapi/syscall.h
>> @@ -134,6 +134,7 @@
>>   #define sc_cobalt_sigtimedwait64		111
>>   #define sc_cobalt_monitor_wait64		112
>>   #define sc_cobalt_event_wait64			113
>> +#define sc_cobalt_recvmmsg64			114
>>   
>>   #define __NR_COBALT_SYSCALLS			128 /* Power of 2 */
>>   
>> diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
>> index 0c17f55..571b720 100644
>> --- a/kernel/cobalt/posix/io.c
>> +++ b/kernel/cobalt/posix/io.c
>> @@ -26,6 +26,7 @@
>>   #include "internal.h"
>>   #include "clock.h"
>>   #include "io.h"
>> +#include <cobalt/kernel/time.h>
>>   
>>   COBALT_SYSCALL(open, lostage,
>>   	       (const char __user *u_path, int oflag))
>> @@ -121,6 +122,14 @@ COBALT_SYSCALL(recvmmsg, primary,
>>   				  get_mmsg, put_mmsg, get_timespec);
>>   }
>>   
>> +COBALT_SYSCALL(recvmmsg64, primary,
>> +	       (int fd, struct mmsghdr __user *u_msgvec, unsigned int vlen,
>> +		unsigned int flags, struct __kernel_timespec __user *u_timeout))
>> +{
>> +	return __rtdm_fd_recvmmsg(fd, u_msgvec, vlen, flags, u_timeout,
>> +				  get_mmsg, put_mmsg, cobalt_get_timespec64);
>> +}
>> +
> 
> When looking at the callbacks for mutex timedlock stuff I wonder if the
> error reporting in case of NULL for the cobalt_get_timespec64 is still
> correct. It looks like the tests claim that...
> 
> Instead of changing the signature of cobalt_get_timespec64 I would
> suggest the following pattern (that we already follow in all other
> cases):
> 
> - Implement __rtdm_fd_recvmmsg64(), which calls __rtdm_fd_recvmmsg()
> with a static callback implemented inside the same compile unit.
> 
> - The (static) callback can implement the usual checks and call
> cobalt_get_timespec64
> 
> - Call __rtdm_fd_recvmmsg64() from both syscalls
> 

mutex_fetch_timeout64 likely code is redundant, in some scenarios, 
syscalls have to define new helpers to call cobalt_get_timespec64, which 
is also a helper. It makes code less clean.

new signature of cobalt_get_timespec64 seems no side effect to me, or
i prefer to define a unified helper along with cobalt_get_timespec64, like:

int cobalt_get_timespec64(struct timespec64 *ts,
                  const struct __kernel_timespec __user *uts)

int cobalt_fetch_timeout64(struct timespec64 *ts, const void __user *uts);

what do you think?

BR

Song

>>   COBALT_SYSCALL(sendmsg, handover,
>>   	       (int fd, struct user_msghdr __user *umsg, int flags))
>>   {
>> diff --git a/kernel/cobalt/posix/io.h b/kernel/cobalt/posix/io.h
>> index d9f29fa..842db08 100644
>> --- a/kernel/cobalt/posix/io.h
>> +++ b/kernel/cobalt/posix/io.h
>> @@ -58,6 +58,11 @@ COBALT_SYSCALL_DECL(recvmmsg,
>>   		    (int fd, struct mmsghdr __user *u_msgvec, unsigned int vlen,
>>   		     unsigned int flags, struct __user_old_timespec __user *u_timeout));
>>   
>> +COBALT_SYSCALL_DECL(recvmmsg64,
>> +		    (int fd, struct mmsghdr __user *u_msgvec, unsigned int vlen,
>> +		     unsigned int flags,
>> +		     struct __kernel_timespec __user *u_timeout));
>> +
>>   COBALT_SYSCALL_DECL(sendmsg,
>>   		    (int fd, struct user_msghdr __user *umsg, int flags));
>>   
>> diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
>> index 2d88fac..2cc360c 100644
>> --- a/kernel/cobalt/posix/syscall32.c
>> +++ b/kernel/cobalt/posix/syscall32.c
>> @@ -852,14 +852,25 @@ static int put_mmsg32(void __user **u_mmsg_p, const struct mmsghdr *mmsg)
>>   }
>>   
>>   COBALT_SYSCALL32emu(recvmmsg, primary,
>> -	       (int ufd, struct compat_mmsghdr __user *u_msgvec, unsigned int vlen,
>> -		unsigned int flags, struct old_timespec32 *u_timeout))
>> +		    (int ufd, struct compat_mmsghdr __user *u_msgvec,
>> +		     unsigned int vlen, unsigned int flags,
>> +		     struct old_timespec32 *u_timeout))
>>   {
>>   	return __rtdm_fd_recvmmsg(ufd, u_msgvec, vlen, flags, u_timeout,
>>   				  get_mmsg32, put_mmsg32,
>>   				  get_timespec32);
>>   }
> 
> That's unrelated and should not be part of this patch. Thanks for
> cleaning that up, but I'm unsure if maintainers will take it. Let's
> see. (Submission as separate patch expected)
> 
>>   
>> +COBALT_SYSCALL32emu(recvmmsg64, primary,
>> +		    (int ufd, struct compat_mmsghdr __user *u_msgvec,
>> +		     unsigned int vlen, unsigned int flags,
>> +		     struct __kernel_timespec *u_timeout))
>> +{
>> +	return __rtdm_fd_recvmmsg(ufd, u_msgvec, vlen, flags, u_timeout,
>> +				  get_mmsg32, put_mmsg32,
>> +				  cobalt_get_timespec64);
>> +}
>> +
>>   COBALT_SYSCALL32emu(sendmsg, handover,
>>   		    (int fd, struct compat_msghdr __user *umsg, int flags))
>>   {
>> diff --git a/kernel/cobalt/posix/syscall32.h b/kernel/cobalt/posix/syscall32.h
>> index 3eb6657..72e32f4 100644
>> --- a/kernel/cobalt/posix/syscall32.h
>> +++ b/kernel/cobalt/posix/syscall32.h
>> @@ -253,6 +253,12 @@ COBALT_SYSCALL32emu_DECL(recvmmsg,
>>   			  unsigned int vlen,
>>   			  unsigned int flags, struct old_timespec32 *u_timeout));
>>   
>> +COBALT_SYSCALL32emu_DECL(recvmmsg64,
>> +			 (int fd, struct compat_mmsghdr __user *u_msgvec,
>> +			  unsigned int vlen,
>> +			  unsigned int flags,
>> +			  struct __kernel_timespec *u_timeout));
>> +
>>   COBALT_SYSCALL32emu_DECL(sendmsg,
>>   			 (int fd, struct compat_msghdr __user *umsg,
>>   			  int flags));
>> diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
>> index 8e4e15e..99beb4e 100644
>> --- a/kernel/cobalt/rtdm/fd.c
>> +++ b/kernel/cobalt/rtdm/fd.c
>> @@ -689,7 +689,7 @@ int __rtdm_fd_recvmmsg(int ufd, void __user *u_msgvec, unsigned int vlen,
>>   		if (ret)
>>   			goto fail;
>>   
>> -		if ((unsigned long)ts.tv_nsec >= ONE_BILLION) {
>> +		if (!timespec64_valid(&ts)) {
>>   			ret = -EINVAL;
>>   			goto fail;
>>   		}
>> diff --git a/kernel/cobalt/time.c b/kernel/cobalt/time.c
>> index cb152fc..c07bf49 100644
>> --- a/kernel/cobalt/time.c
>> +++ b/kernel/cobalt/time.c
>> @@ -4,8 +4,7 @@
>>   #include <cobalt/kernel/time.h>
>>   #include <linux/compat.h>
>>   
>> -int cobalt_get_timespec64(struct timespec64 *ts,
>> -			  const struct __kernel_timespec __user *uts)
>> +int cobalt_get_timespec64(struct timespec64 *ts, const void __user *uts)
>>   {
>>   	struct __kernel_timespec kts;
>>   	int ret;
>> @@ -26,8 +25,7 @@ int cobalt_get_timespec64(struct timespec64 *ts,
>>   	return 0;
>>   }
>>   
>> -int cobalt_put_timespec64(const struct timespec64 *ts,
>> -		   struct __kernel_timespec __user *uts)
>> +int cobalt_put_timespec64(const struct timespec64 *ts, void __user *uts)
>>   {
>>   	struct __kernel_timespec kts = {
>>   		.tv_sec = ts->tv_sec,
> 

