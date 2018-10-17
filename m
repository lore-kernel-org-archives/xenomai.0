References: <20181016103450.3189-1-norbert.lange@andritz.com>
 <457aa74c-8fde-8e95-3065-41d41de0a15e@xenomai.org>
 <d62437da1905437abadb9c24fa9384eb@andritz.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b8fc3972-99be-eee3-1779-8f1927710ef0@xenomai.org>
Date: Wed, 17 Oct 2018 17:26:34 +0200
MIME-Version: 1.0
In-Reply-To: <d62437da1905437abadb9c24fa9384eb@andritz.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] [PATCH] cobalt: fcntl uses void* instead of int
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/17/2018 01:30 PM, Lange Norbert wrote:
>>> @@ -139,11 +139,11 @@ static int do_ioctl(int fd, unsigned int
>>> request, void *arg)  COBALT_IMPL(int, fcntl, (int fd, int cmd, ...))
>>> {
>>>       va_list ap;
>>> -     int arg;
>>> +     void *arg;
>>>       int ret;
>>>
>>>       va_start(ap, cmd);
>>> -     arg = va_arg(ap, int);
>>> +     arg = va_arg(ap, void *);
>>>       va_end(ap);
>>>
>>>       ret = XENOMAI_SYSCALL3(sc_cobalt_fcntl, fd, cmd, arg); diff
>>> --git a/lib/cobalt/wrappers.c b/lib/cobalt/wrappers.c index
>>> 20ad63a61..2540e3c50 100644
>>> --- a/lib/cobalt/wrappers.c
>>> +++ b/lib/cobalt/wrappers.c
>>> @@ -216,10 +216,10 @@ __weak
>>>  int __real_fcntl(int fd, int cmd, ...)  {
>>>       va_list ap;
>>> -     int arg;
>>> +     void *arg;
>>>
>>>       va_start(ap, cmd);
>>> -     arg = va_arg(ap, int);
>>> +     arg = va_arg(ap, void *);
>>>       va_end(ap);
>>>
>>>       return fcntl(fd, cmd, arg);
>>>
>>
>> Fair enough, however a generic 'long' may be a better pick than an
>> opaque pointer type in this case (*), then you would need to fix up the
>> Cobalt kernel side implementing the actual syscall to reflect this change.
> 
> Some fcntl calls use a pointer-to-struct, so void* or uintptr_t seems fitting for this?
>  (TBH I just looked at what glibc is doing, and some weird archs might have sizeof(long) < sizeof(void*))

The glibc is not involved in Cobalt calls, the Cobalt core in kernel
space (obviously) is. In that space, a pointer always fits in a long
word (it may even be shorter in the ia32emu/x32 ABI models).

> 
> If Xenomai only supports calls with an int, maybe truncate it just for the syscall?
>        ret = XENOMAI_SYSCALL3(sc_cobalt_fcntl, fd, cmd, (int)arg);
> (rest of the patch untouched)
> 
> Not sure how syscalls are done, I expected the arguments are just passed in registers,
> In which case it does not matter (unless you don’t fit a pointer in a register)
> 

Kernel-wise, register values are native long words.

>> Moving away from 'int' to a longer type will also require to make
>> Cobalt's fcntl() syscall implementation aware of the mixed ABI models
>> when CONFIG_XENO_ARCH_SYS3264 is enabled. i.e. the argument would
>> still
>> be conveyed as a 32bit value for applications conforming to the ia32emu
>> or x32 ABIs running over a 64bit kernel.
> 
> Ok, I haven't thought about that at all. But since you apparently don't expect a pointer now,
> truncating the value to an int for the syscall seems fitting.
> 

Generally speaking, having the userland interface and the kernel
implementation disagree on some argument type is hard to justify. In
contrast, we may want to enable long argument types right now in the
fcntl implementation, so that we would not have to break the ABI twice
to support them later. That would align both userland and kernel space
on using a long type for the argument, fixing the issue you observed in
the same move.

-- 
Philippe.

