References: <E1bORzl-00034s-19@xenomai.org>
 <2c1f909e-f50a-fca6-5f23-64e1284951aa@siemens.com>
 <49cc3433-7149-0713-2de6-afdddfe8d66d@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4b602c22-1a2f-c918-4041-cade4cf1bc85@siemens.com>
Date: Fri, 16 Sep 2016 09:56:23 +0200
MIME-Version: 1.0
In-Reply-To: <49cc3433-7149-0713-2de6-afdddfe8d66d@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Philippe Gerum : cobalt/rtdm: leave mode selection to
 I/O syscall handlers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 2016-09-16 09:28, Philippe Gerum wrote:
> On 09/16/2016 06:54 AM, Jan Kiszka wrote:
>> On 2016-07-16 17:59, git repository hosting wrote:
>>> Module: xenomai-3
>>> Branch: wip/dovetail
>>> Commit: 37f90fb2a9d1d8ad6e120e01c8972817b315baf6
>>> URL:    http://git.xenomai.org/?p=xenomai-3.git;a=commit;h=37f90fb2a9d1d8ad6e120e01c8972817b315baf6
>>>
>>> Author: Philippe Gerum <rpm@xenomai.org>
>>> Date:   Thu Jul  7 18:35:47 2016 +0200
>>>
>>> cobalt/rtdm: leave mode selection to I/O syscall handlers
>>>
>>> We don't want requests bearing invalid file descriptors (RTDM-wise) to
>>> trigger any mode switch, so that RTDM requests on regular fildes can
>>> be rejected with little overhead.
>>>
>>> Tell the core to hand over mode selection to RTDM I/O syscall
>>> handlers, which now check the file descriptor prior to triggering any
>>> mode transition.
>>>
>>> ---
>>>
>>>  kernel/cobalt/posix/io.c        |   10 +--
>>>  kernel/cobalt/posix/syscall32.c |    4 +-
>>>  kernel/cobalt/rtdm/fd.c         |  144 +++++++++++++++++++++++----------------
>>>  3 files changed, 92 insertions(+), 66 deletions(-)
>>>
>>> diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
>>> index 7110d21..42b7b00 100644
>>> --- a/kernel/cobalt/posix/io.c
>>> +++ b/kernel/cobalt/posix/io.c
>>> @@ -58,25 +58,25 @@ COBALT_SYSCALL(fcntl, current, (int fd, int cmd, int arg))
>>>  	return rtdm_fd_fcntl(fd, cmd, arg);
>>>  }
>>>  
>>> -COBALT_SYSCALL(ioctl, probing,
>>> +COBALT_SYSCALL(ioctl, handover,
>>>  	       (int fd, unsigned int request, void __user *arg))
>>>  {
>>>  	return rtdm_fd_ioctl(fd, request, arg);
>>>  }
>>>  
>>> -COBALT_SYSCALL(read, probing,
>>> +COBALT_SYSCALL(read, handover,
>>>  	       (int fd, void __user *buf, size_t size))
>>>  {
>>>  	return rtdm_fd_read(fd, buf, size);
>>>  }
>>>  
>>> -COBALT_SYSCALL(write, probing,
>>> +COBALT_SYSCALL(write, handover,
>>>  	       (int fd, const void __user *buf, size_t size))
>>>  {
>>>  	return rtdm_fd_write(fd, buf, size);
>>>  }
>>>  
>>> -COBALT_SYSCALL(recvmsg, probing,
>>> +COBALT_SYSCALL(recvmsg, handover,
>>>  	       (int fd, struct user_msghdr __user *umsg, int flags))
>>>  {
>>>  	struct user_msghdr m;
>>> @@ -93,7 +93,7 @@ COBALT_SYSCALL(recvmsg, probing,
>>>  	return cobalt_copy_to_user(umsg, &m, sizeof(*umsg)) ?: ret;
>>>  }
>>>  
>>> -COBALT_SYSCALL(sendmsg, probing,
>>> +COBALT_SYSCALL(sendmsg, handover,
>>>  	       (int fd, struct user_msghdr __user *umsg, int flags))
>>>  {
>>>  	struct user_msghdr m;
>>> diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
>>> index 0576b37..bc8b9d9 100644
>>> --- a/kernel/cobalt/posix/syscall32.c
>>> +++ b/kernel/cobalt/posix/syscall32.c
>>> @@ -766,7 +766,7 @@ COBALT_SYSCALL32emu(select, nonrestartable,
>>>  	return err;
>>>  }
>>>  
>>> -COBALT_SYSCALL32emu(recvmsg, probing,
>>> +COBALT_SYSCALL32emu(recvmsg, handover,
>>>  		    (int fd, struct compat_msghdr __user *umsg,
>>>  		     int flags))
>>>  {
>>> @@ -784,7 +784,7 @@ COBALT_SYSCALL32emu(recvmsg, probing,
>>>  	return sys32_put_msghdr(umsg, &m) ?: ret;
>>>  }
>>>  
>>> -COBALT_SYSCALL32emu(sendmsg, probing,
>>> +COBALT_SYSCALL32emu(sendmsg, handover,
>>>  		    (int fd, struct compat_msghdr __user *umsg, int flags))
>>>  {
>>>  	struct user_msghdr m;
>>> diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
>>> index d82cfe4..3381dea 100644
>>> --- a/kernel/cobalt/rtdm/fd.c
>>> +++ b/kernel/cobalt/rtdm/fd.c
>>> @@ -392,6 +392,44 @@ int rtdm_fd_fcntl(int ufd, int cmd, ...)
>>>  }
>>>  EXPORT_SYMBOL_GPL(rtdm_fd_fcntl);
>>>  
>>> +static struct rtdm_fd *get_fd_fixup_mode(int ufd)
>>> +{
>>> +	struct xnthread *thread;
>>> +	struct rtdm_fd *fd;
>>> +	
>>> +	fd = rtdm_fd_get(ufd, 0);
>>> +	if (IS_ERR(fd))
>>> +		return fd;
>>> +
>>> +	/*
>>> +	 * Mode is selected according to the following convention:
>>> +	 *
>>> +	 * - Cobalt threads must try running the syscall from primary
>>> +	 * mode as a first attempt, regardless of their scheduling
>>> +	 * class. The driver handler may ask for demoting the caller
>>> +	 * to secondary mode by returning -ENOSYS.
>>> +	 *
>>> +	 * - Regular threads (i.e. not bound to Cobalt) may only run
>>> +	 * the syscall from secondary mode.
>>> +	 */
>>
>> In case of IOCTLs, we would also have to push the decision one level
>> further, into the driver. Only in few cases, default would remain this
>> policy here. Do you already have a suggestion how to do that?
>>
> 
> Yes, by tagging the specific ioctl codes accordingly in a way the RTDM
> core can detect (e.g. some bit set in the request code), so that the
> driver may eventually enforce the policy. A tag meaning "that ioctl
> request should run in secondary mode" would cover all requirements.
> 

Ah - weak memory, you proposed this already. Let me look into this.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

