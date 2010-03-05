Message-ID: <4B913C71.4060006@domain.hid>
Date: Fri, 05 Mar 2010 18:16:33 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B90ED0A.40101@domain.hid> <4B90F2D3.8020508@domain.hid>
	<4B91290C.7070005@domain.hid> <4B9131B4.6060105@domain.hid>
In-Reply-To: <4B9131B4.6060105@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC][PATCH v2] Allow for deregistering current
 mode user space address
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> This adds __xn_sys_drop_u_mode, a syscall to deregister the u_mode user
>>>> space address passed on shadow creation for the current thread. We need
>>>> this in order to safely shut down a thread that wants to release its
>>>> u_mode memory (either malloc'ed or TLS-allocated). So far, the kernel
>>>> might have touched this memory even after the release which caused
>>>> subtle corruptions.
>>>>
>>>> After we released u_mode, we can no longer make reliable decisions based
>>>> on it. For the fast mutex use case, we then assume the worst case, ie.
>>>> we enforce syscall-based acquisitions unconditionally. For the
>>>> assert_nrt case, we simply acquire the required information via
>>>> __xn_sys_current_info.
>>> As usual, you are firing patches too fast:
>>> - you are lacking the exit syscall trap.
>> Don't worry, my memory is not yet _that_ bad. :)
>>
>>> - the patch is not correct and will cause kernel-space addresses to be
>>> passed to put_user, which probably yields bugs when the kernel is
>>> compiled with proper debug flags;
>> Right, e.g. ARM requires set_fs() fiddling in addition. But then a simple
>> NULL-check is way better. Fixed.
>>
>>> - I do not see the point where the new syscall is called with __thread,
>>> but I am not sure it is missing, and if it is missing, you will get the
>>> rightfull warning when hitting the exit syscall.
>> Destructor of (now unconditionally used) xeno_current_mode_key.
>>
>>> - the user-space users of the function to get current_mode are still
>>> cluttered with special cases to handle the invalid state. And
>>> illustrating nicely the deficiency of this approach, you have forgot one
>>> user.
>> My impression is that you are still a bit biased due to TLS limitations
>> on ARM.
> 
> No, I think the __thread stuff thinks make C code look too much like C++
> where the compiler makes things behind your back for such simple code as:
> 
> void *foo = &bar;
> 
> This is not what I expect from a C compiler, and I suspect a lot of C
> developers, including the people who advocate that C, as a simple
> language, and not C++ should be used for free software development.
> 
> Yes, there is no gain on ARM, where this generates a function call as
> pthread_getspecific and causes bugs with gcc >= 4.3, but not much gain
> on x86 either where a function call is so cheap.

As are individual memory accesses. The sum makes the difference.

> And using __thread in
> Xenomai source code adds an awful lot of code, and what is more, an
> awful lot of conditionnaly compiled code, which inevitably gets less
> testing. So, from a maintenance point of view, this looks like a bad call.
> 
>> And nope, I didn't forget to address it, I just forgot to mention that
>> there is nothing to address (the torture test does not use
>> xeno_get_current_mode from within a TSD destructor, thus potentially
>> after drop_u_mode).
> 
> Expect that if someone changes the test code, he will have not to forget
> about this. As soon as other users exist, we will have to think about
> updating them.

Once someone starts testing mutexes or other stuff from TSD destructors,
not earlier. And this is so special that anyone of us interested in this
test case will naturally be aware of its specifics.

> 
>>> I am not going to make my version before tomorrow, so you have plenty of
>>> time to send me an at least correct version which would take into
>>> account all of our discussions.
>> Well... what should I reply?
> 
> That starting from now, you are going to test your patches before
> sending them.
> 
>>> Please also consider that your "patch machinegun" way of working is not
>>> really sane. When there are so many often untested patches to review
>>> coming from you, we sometime let some errors slip through. And from a
>>> user point of view, seeing so many buggy patches refused is not really
>>> reassuring.
>> Please don't make me cite counter examples for issues with different
>> workflows we also experienced.
>>
>> The key of an open development process is open discussion, and that
>> ideally based on code, even if it is not yet perfect. I can't imagine
>> you want Xenomai being developed in closed chambers (or even just a
>> single one). If you are afraid of imperfect patches being posted or even
>> merged into some software, you shouldn't use e.g. the Linux kernel as
>> well.
> 
> You misunderstand me. What I would like you to do is to avoid sending me
> patches which are a 5 minutes, untested hack, to fix something which
> took much longer to think and nevertheless get wrong. Because most of
> these patches get it inevitably wrong too.
> 
> I think every sane free-software projects ask people to test their
> patches/pull requests before sending them, even the Linux kernel. See
> for instance:
> http://lwn.net/Articles/377091/
> 
> I am not asking you for one week. 24 hours would be enough.

As you may know, complete test coverage is near to impossible. On
unlucky days, I happen to send out stuff that broke while continuing to
type after the last test ran. But specifically these things were tested
in various combinations.

It is not very polite to assume the contrary. I'm trying to avoid the
same assumption about other people as well, even when things look
differently from time to time. To err is human, to always write correct
code is divine.

But as you already mentioned in another mail, there is room for
improvement /wrt testability. On step forward would be an automated
build and run of some git tree that we can check into. One board per
arch would be enough to avoid issues we face from time to time when we
only stress our favorite archs with new features or fixes.

> 
> In fact, the mistake is partly mine too, I am replying to your patches
> as fast as you send them. We were going crazy tuesday with the condition
> variable patches, I do not think it gives a reassuring image to the
> users.

I can only say that, as a developer in this business, I trust code
having been discussed to the extreme _way_ more than stuff a single
clever person checked in even after meditating over it for weeks. I've
seen enough of this, produced by non-clever /me as well as way more
clever people in all kinds of projects.

> So that at some point, I stopped reviewing your patches. I have
> not even read the last 8 you sent. Without going to the other extreme of
> a "closed door" development model, I think we can find a more reasonable
> trade off than the current one.

Well, you have to decide which piece to take, or to request it to be
rewritten, or to write yourself.

> 
> Our objective now, is to put 2.5.2 in a stable state.
> 
>> +substitute_linux_syscall(xnthread_t *thread, struct pt_regs *regs)
>> +{
>> +	if (unlikely(__xn_reg_mux(regs) == __NR_exit))
>> +		handle_shadow_exit(thread);
>> +
> 
> Not your fault, but this does not work on ARM. Do not know if
> __xn_reg_mux needs fixing there or if we need to add a new macro to get
> the roots syscall number.

And that's the point of sending patches for discussion.

It's regs->ARM_r7 == __NR_SYSCALL_BASE + __NR_MY_SYSCALL, right? If
__xn_reg_mux is supposed to be only a mux value for Xenomai, we need a
separate accessor for the Linux syscall number on all archs.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

