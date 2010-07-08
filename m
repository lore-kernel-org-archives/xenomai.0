From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C359326.1090509@domain.hid>
References: <AANLkTik-cpk4RfJGxj422mOvU1xQFdQCfB8gno7uzD7N@mail.gmail.com>
	<4C34438D.9020905@domain.hid>
	<AANLkTiklX49KAfAlZND9FhVaTJZpdADFpuUIO-lkm6f6@domain.hid>
	<4C34EF76.2040602@domain.hid>
	<AANLkTik9RCKn90TnCj3JWBQF_XWaHbH0vSgp2vOu8HfH@mail.gmail.com>
	<4C3508E1.7090100@domain.hid>
	<1278578261.1810.67.camel@domain.hid>
	<4C359326.1090509@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Jul 2010 11:31:19 +0200
Message-ID: <1278581479.1810.111.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] native: A 32k stack is not always a 'reasonable'
 size
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

On Thu, 2010-07-08 at 10:58 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > On Thu, 2010-07-08 at 01:08 +0200, Gilles Chanteperdrix wrote:
> >> Peter Soetens wrote:
> >>> On Wed, Jul 7, 2010 at 11:19 PM, Gilles Chanteperdrix
> >>> <gilles.chanteperdrix@xenomai.org> wrote:
> >>>> Peter Soetens wrote:
> >>>>> On Wed, Jul 7, 2010 at 11:06 AM, Gilles Chanteperdrix
> >>>>> <gilles.chanteperdrix@xenomai.org> wrote:
> >>>>>> Peter Soetens wrote:
> >>>>>>> At least, not for Orocos applications. We've had hard to debug
> >>>>>>> application segfaults that used just a 'little' bit more than 32k. We
> >>>>>>> had to raise the stack size to 128k to get reliably through our
> >>>>>>> application startup. I stem from the old 'mlockall ate my RAM'
> >>>>>>> generation where we typically reduced stack sizes in order to have
> >>>>>>> some crumbles left for the heap. But 32k wasn't really what we were
> >>>>>>> aiming for.
> >>>>>>>
> >>>>>>> Maybe we should explicitly document the 32k limit and its limitations
> >>>>>>> for certain applications...?
> >>>>>> Again, things have been fixed in 2.5.3 with regard to stack sizes, could
> >>>>>> you check that you have the same behaviour?
> >>>>> I think we had, but I'm uncertain right now.
> >>>>>
> >>>>>> As for 32KiB, it is only a default stack size, it is only reasonable in
> >>>>>> the sense that 2MiB is unreasonable on a low-end system. 32KiB was
> >>>>>> picked because it allows printf to work. Now, whatever stack size we
> >>>>>> choose, there will be applications which need more, this does not really
> >>>>>> make the default unreasonable.
> >>>>> I knew you would say that. It deserves an entry in the faq or some
> >>>>> trouble shooting document though.
> >>>> It is documented. For instance, rt_task_create says:
> >>>> stksize         The size of the stack (in bytes) for the new task. If
> >>>>                zero is passed, a reasonable pre-defined size will be substituted.
> >>>>
> >>>> What else can we say? Documenting that this size is 32 KiB would be
> >>>> wrong, because we do not want applications to rely on a particular
> >>>> value, in case we want to change it. And the fact that if your stack is
> >>>> too small, you will get problems is kind of obvious. For anyone having
> >>>> played with stack sizes with Linux or any proprietary RTOS, at least.
> >>> And what with new RTOS/Xenomai users ?
> >>>
> >>> You have to take the user perspective here. The problem with stack
> >>> overflows is that they occur when the development of a program has
> >>> progressed a while and applications reached a certain level of
> >>> complexity (otherwise the overflow wouldn't have happend in the first
> >>> place). So it suddenly starts to segfault (from time to time). What he
> >>> does is this: he fires up the debugger to get a backtrace, sees
> >>> trouble and wrongly assumes that gdb can't really handle these Xenomai
> >>> threads and tries to eliminate causes of the crashes.. 
> >> Last time I tried, debugging a stack overflow with gdb was possible. You
> >> can print the stack pointer and compare the value with the contents of
> >> /proc/pid/maps.
> >>
> >> The user comes
> >>> quickly to the conclusion that 'putting it all together' causes the
> >>> crash (the single unit tests pass) and is looking for a software
> >>> integration problem. In reality, it's the stack.
> >>>
> >>> If you've been through all this and then came to the correct
> >>> conclusion the same day, you've been burnt before, or are the
> >>> exception.
> >>>
> >>> In my view, 32k is a premature optimization. At least, it shows the
> >>> side effects of one.
> >> I guess you run Xenomai on one of these big irons, do you? Because if
> >> you ran on a low-end machine, you would have understand why we can not
> >> keep the 2MB default limit. 32 KiB looks already like a pretty large
> >> limit, so, maybe there is a problem in your application?
> >>
> >> The I-pipe patch for ARM detects stack overflows, I guess we can modify
> >> the kernel on all architectures to do the same thing on all architectures.
> >>
> > 
> > Peter made a good point considering the various braindamage outcomes a
> > stack smashing issue could trigger. I'm unsure whether anyone can
> > immediately suspect a stack overflow to be the cause of any random
> > application behavior; typically, that issue could cause a branch to any
> > random IP value on x86 since the return address is living on the stack
> > and could get trashed, but not necessarily on architectures with
> > branch-and-link registers. In the former case, GDB is of little help,
> > except for single-stepping until the offending statement is reached and
> > we can observe the trashing live, which means that we actually did the
> > work of spotting the issue manually.
> > 
> > It turns out that people with large applications and lots of contexts
> > often end up naked in the cold most of the time when facing those
> > things, and the only option left to them is to go backward on the
> > integration path, in order to find a possibly faulty component. Before
> > people can reasonably compare %sp values, they need some help to narrow
> > the search, otherwise, it's hopeless.
> > 
> > To this end, maybe an option would be to enable gcc's
> > -fstack-protector[-all] -fstack-check when the debug switch is given to
> > the configure script, provided the compiler in use supports this.
> > 
> > Granted, a stack overflow is not identical to a smashing, but quite
> > often the stack memory unduly consumed by a thread belongs to some other
> > memory object, and therefore usually gets trashed when that object is
> > modified. At least, enabling some canary word checking in that case may
> > help.
> 
> I do not think so. The glibc maps an unreadable/unwritable page below
> the stack. So, what you get is a segmentation fault. Unless, of course,
> you overflow more than one page. But we can map more than one page by
> using pthread_attr_setguardsize, if one page is not enough.

The page guard is restricted to MMU-enabled systems, we have two over
six of our architectures running without MMU. In this case, the only
option left that may work is the stack protector based on the canary
word checking.

Relying on pthread_attr_setguardsize() when available will trigger the
same amount of uncertainty than we have now with setting the minimum
stack size. Which guard value would a sane default? one, two, four
pages?

> 
> We can detect the stack overflow in kernel-space, there it is easy to
> detect, the problem is that x86 users, which are the ones more likely to
> be hit by a stack overflow, may not be watching the console, so may not
> see the message.
> 

Kernel-space is another issue, people writing applications in kernel
space are mostly on their own these days, and others implementing
drivers are expected to always consider stack space as a scarce resource
anyway. But helping with solving userland problems seems to be the most
urgent thing to do, since common practices in that environment may
conflict badly with real-time restrictions and requirements.

> Or we can install a handler for SIGSEGV which detects stack overflows
> (it will be a litlle harder than in kernel-space) and prints a clear
> message in that case but we will have to use an alternate stack for the
> signal handler (obviously, the SIGSEGV handler can not be stacked over
> the stack overflow).
> 
> Or we can increase the default stack size, but in my view, we will only
> be delaying the problem a bit further down the "new users" development
> process.
> 

I agree with your view here, but this also creates the requirement for
helping people to detect stack trashing early enough.

-- 
Philippe.



