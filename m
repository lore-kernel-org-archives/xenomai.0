Subject: Re: Fwd: [Patch 1/5] Problems with upstream SPECTRE mitigation found
 in sendmsg/recvmsg syscalls
References: <1176-5fd32880-167-12dbaa60@116805486>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <69f2a808-f763-0c14-1d48-965bed9cd271@siemens.com>
Date: Fri, 11 Dec 2020 09:36:20 +0100
MIME-Version: 1.0
In-Reply-To: <1176-5fd32880-167-12dbaa60@116805486>
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
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>
Cc: xenomai@xenomai.org

On 11.12.20 09:05, François Legal wrote:
> Le Vendredi, Décembre 11, 2020 07:55 CET, Jan Kiszka <jan.kiszka@siemens.com> a écrit: 
>  
>> On 07.12.20 11:55, François Legal via Xenomai wrote:
>>> From: François LEGAL <devel@thom.fr.eu.org>
>>>
>>> Remove the copy of struct struct user_msghdr onto stack allocated buffer.
>>>
>>
>> Reasoning is missing here: The driver callbacks are supposed to do that
>> copy-from-user.
>>
>> But the Question is: why? Is that local copy history left-over, or do
>> only the drivers know how much to copy?
>>
>> Jan
>>
> 
> Hi Jan,
> 
> The drivers are effectively doing that, hence the problem that happens with SPECTRE mitigation activated (at least on arm arch).
> About the length of the copy, the drivers do about the the same, sizeof (struct user_msghdr)

Then we should move the common code into the common place, i.e. drop the
copies in the drivers instead.

> 
> So now about the "WHY ?", that I can't say for sure. It might be history, as the other modified parts are IPCs and RTCAN (which I believe are older than RTNET integration). I dug this a little bit, and what I can say is that in 2.6.x, in rtdm/syscall.c, the copy_to/from_user calls were already present and in IPC, they were absent.
> 

Yeah, for a long time, we didn't notice such mess automatically...

Jan

> François
> 
>>> Signed-off-by: François LEGAL <devel@thom.fr.eu.org>
>>> ---
>>>  kernel/cobalt/posix/io.c          | 20 ++------------------
>>>  1 file changed, 2 insertions(+), 18 deletions(-)
>>>  
>>> diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
>>> index f35aaf8..85272a5 100644
>>> --- a/kernel/cobalt/posix/io.c
>>> +++ b/kernel/cobalt/posix/io.c
>>> @@ -79,18 +79,7 @@ COBALT_SYSCALL(write, handover,
>>>  COBALT_SYSCALL(recvmsg, handover,
>>>  	       (int fd, struct user_msghdr __user *umsg, int flags))
>>>  {
>>> -	struct user_msghdr m;
>>> -	ssize_t ret;
>>> -
>>> -	ret = cobalt_copy_from_user(&m, umsg, sizeof(m));
>>> -	if (ret)
>>> -		return ret;
>>> -
>>> -	ret = rtdm_fd_recvmsg(fd, &m, flags);
>>> -	if (ret < 0)
>>> -		return ret;
>>> -
>>> -	return cobalt_copy_to_user(umsg, &m, sizeof(*umsg)) ?: ret;
>>> +	return rtdm_fd_recvmsg(fd, umsg, flags);
>>>  }
>>>  
>>>  static int get_timespec(struct timespec *ts,
>>> @@ -123,12 +112,7 @@ COBALT_SYSCALL(recvmmsg, primary,
>>>  COBALT_SYSCALL(sendmsg, handover,
>>>  	       (int fd, struct user_msghdr __user *umsg, int flags))
>>>  {
>>> -	struct user_msghdr m;
>>> -	int ret;
>>> -
>>> -	ret = cobalt_copy_from_user(&m, umsg, sizeof(m));
>>> -
>>> -	return ret ?: rtdm_fd_sendmsg(fd, &m, flags);
>>> +	return rtdm_fd_sendmsg(fd, umsg, flags);
>>>  }
>>>  
>>>  static int put_mmsglen(void __user **u_mmsg_p, const struct mmsghdr *mmsg)
>>>
>>>
>>
>> -- 
>> Siemens AG, T RDA IOT
>> Corporate Competence Center Embedded Linux
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

