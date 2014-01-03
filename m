Message-ID: <52C7260C.1010004@xenomai.org>
Date: Fri, 03 Jan 2014 22:05:16 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52BD3D0E.3010802@xenomai.org> <52C6C14C.9000306@web.de>
 <52C6F57B.3090101@xenomai.org> <52C71AE0.3090807@web.de>
In-Reply-To: <52C71AE0.3090807@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] reworking rtdm
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/03/2014 09:17 PM, Jan Kiszka wrote:
> On 2014-01-03 18:38, Gilles Chanteperdrix wrote:
>> On 01/03/2014 02:55 PM, Jan Kiszka wrote:
>>> On 2013-12-27 09:40, Gilles Chanteperdrix wrote:
>>>>
>>>> Hi Jan, Philippe,
>>>>
>>>> The xnfd support is taking shape, and I think it is time to start
>>>> rebasing rtdm on it. However, looking at rtdm, I have some questions
>>>> first:
>>>>
>>>> _rt/_nrt callbacks: the open_rt, close_rt, socket_rt callbacks have been
>>>> deprecated for some time now, would not it make sense to remove them
>>>> completely from -forge?
>>>
>>> Yes, we can drop them.
>>>
>>>>
>>>> syscall flags: this is an issue which was discussed some time ago, the
>>>> syscall flags for rtdm callback which would make most sense are
>>>> __xn_exec_conforming|__xn_exec_adaptive, for reasons of compatibility
>>>> (if I understood correctly), rtdm still uses
>>>> __xn_exec_current|__xn_exec_adaptive, with an "emulation" of
>>>> __xn_exec_conforming in analogy code relying on rtdm_is_rt_capable.
>>>> Would not it make sense to change the syscall flags now, and remove the
>>>> hack from analogy? If you have not changed your mind, would changing
>>>> __xn_exec_conforming so that secondary mode is preferred for threads
>>>> with the XNWEAK flag help?
>>>
>>> The original idea of __xn_exec_current|__xn_exec_adaptive was to enable
>>> userspace to select RT vs. non-RT by adjusting the its execution mode.
>>> As we deprecated this interface long ago, we can probably also remove
>>> this property from RTDM now.
>>>
>>> That said and given that XNWEAK threads fall back to secondary mode
>>> after executing primary mode syscalls, it's probably more "conforming"
>>> for them to enter RTDM services from secondary mode first.
>>>
>>>>
>>>> rtdm_user_info: with the switch to xnfd, a file descriptor will be, by
>>>> construction, either an application file descriptor, or a kernel file
>>>> descriptor. The information can be retrieved from the mm it is attached
>>>> to. This makes the rtdm_user_info_t arguments passed to the callbacks
>>>> essentially redundant. Besides, despite the fact that this information
>>>> is passed to a lot of rtdm services, only a few of them actually use it.
>>>
>>> There are few drivers that are ready to be used in kernel space. And
>>> some (RTnet) still lack safe copy to/from user space. So the lack of use
>>> just indicates incomplete implementations.
>>>
>>>> So, there are several possibilities.
>>>>
>>>> Either we remove the rtdm_user_info_t completely from the fd callbacks,
>>>> and from the services like rtdm_copy_from_user which do not use it. For
>>>> the few services which need it, they can be offered an accessor giving
>>>> this information either from the xnfd pointer of from the driver "priv"
>>>> pointer (the latter makes more sense, since analogy only passes its priv
>>>> pointer down the driver functions, and it currently resorts to saving
>>>> the user_info pointer in its private structure so as to be able to
>>>> retrieve it anywhere in the driver). This solution is the cleanest, the
>>>> drawback is that it breaks the drivers API, so out-of-tree drivers which
>>>> want to be compatible with xenomai classic and xenomai forge will have a
>>>> hard time. We can help them by providing macros both in forge and 2.x to
>>>> cope with the differences.
>>>
>>> The idea of having rtdm_user_info_t in the copy functions was once to
>>> keep the door open for user-space prototyping of RTDM drivers. But that
>>> is unrealistic to happen any time soon, and if the parameter could be
>>> helpful at all is questionable.
>>>
>>> If we can find a reasonable migration concept, I'm fine with cleaning
>>> up. I guess user_info could become a field of rtdm_dev_context.
>>
>> I was rather thinking of an accessor, like
>>
>> static inline struct task_struct *rtdm_user_info(struct xnfd *fd)
>> {
>>     return fd->mm ? current : NULL;
>> }
> 
> rtdm_user_info should accept and return only RTDM(-wrapped) types, so
> "typdef struct xnfd rtdm_fd_t" would be needed.
> 
>>
>> And typedefing struct xnfd to rtdm_dev_context
> 
> Cannot follow this.
> 
> rtdm_dev_context contains an fd field, currently holding an integer (as
> that used to be the unique identifier). We may retype it to rtdm_fd_t,
> probaby, and use that for rtdm_user_info. Or just let rtdm_user_info
> take rtdm_dev_context itself as the that will always be the source for
> rtdm_fd_t.

As I probably did not explain correctly, my idea is to put some (or all 
of) the callbacks in the xnfd->ops structure, so read, write, ioctl, 
etc;.. would become

ssize_t (*read)(struct xnfd *fd, char *__user buf, size_t size);

So, xnfd is the new rtdm_dev_context if we do not want to have 
callbacks calling callbacks, it does not really matter, because we can 
convert it to the larger real struct rtdm_dev_context structure, and 
access whatever is currently provided by the rtdm_dev_context accessors.

So, for instance, rtdm_context_to_private could become:

static inline void *
rtdm_context_to_private(struct xnfd *fd)
{
	struct rtdm_dev_context *c = container_of(fd, struct rtdm_dev_context, fd);
	return c->dev_private;
}

Or something along these lines.

> 
>>
>> Now the question is, do we want to have a macro allowing to fix the
>> callbacks signature to compile for both 2.x and forge? Or do you plan to
>> stop supporting 2.x for instance for rtnet, when 3.0 is out?
>>
> 
> I guess RTnet will not be the only affected project.

I understand you want to be able to support both API I take it?

- -- 
                                                                Gilles.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iD8DBQFSxyYMGpcgE6m/fboRAlTAAKCEfHjnttolehFeI034pT3Xhju2jQCfQD9t
GrP4KCtK6ZlY954uVccU60k=
=qCu8
-----END PGP SIGNATURE-----

