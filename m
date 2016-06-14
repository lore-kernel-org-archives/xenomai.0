Date: Tue, 14 Jun 2016 20:40:22 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160614184022.GI23680@hermes.click-hack.org>
References: <E1b6BNz-0003TC-QN@sd-51317.xenomai.org>
 <20160614155740.GE23680@hermes.click-hack.org>
 <57602CA7.5050108@siemens.com>
 <20160614170443.GH23680@hermes.click-hack.org>
 <57603EB6.9040605@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57603EB6.9040605@siemens.com>
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/kernel: Allow to
 restart clock_nanosleep and select after signal processing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On Tue, Jun 14, 2016 at 07:28:22PM +0200, Jan Kiszka wrote:
> On 2016-06-14 19:04, Gilles Chanteperdrix wrote:
> > On Tue, Jun 14, 2016 at 06:11:19PM +0200, Jan Kiszka wrote:
> >> On 2016-06-14 17:57, Gilles Chanteperdrix wrote:
> >>> On Fri, May 27, 2016 at 08:36:43AM +0200, git repository hosting wrote:
> >>>> diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
> >>>> index 060ce85..0f9ab14 100644
> >>>> --- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
> >>>> +++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
> >>>> @@ -133,4 +133,10 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
> >>>>  #error "Xenomai/cobalt requires Linux kernel 3.10 or above"
> >>>>  #endif /* < 3.10 */
> >>>>  
> >>>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4,0,0)
> >>>> +#define cobalt_get_restart_block(p)	(&task_thread_info(p)->restart_block)
> >>>> +#else
> >>>> +#define cobalt_get_restart_block(p)	(&(p)->restart_block)
> >>>> +#endif
> >>>> +
> >>>
> >>> This is bad. First off as explained in the comment heading
> >>> wrappers.h the wrappers are ordered by kernel version and the most
> >>> recent is first. Second, no other wrapper has a #else clause, the
> >>> idea is that we want to be able to remove some old wrappers from
> >>> time to time, and removing the #if completely should be enough.
> >>> Obviously, if you put a #else, this does not work. I agree that in
> >>> that case it is going to be hard, but please try anyway...
> >>
> >> I'm open for concrete ideas.
> > 
> > There are examples in wrapper.h, with COBALT_BACKPORT. Maybe this
> > can be used? The thing is that wrappers.h is supposed to contain
> > implementation of new services for older kernels;
> > cobalt_get_restart_block does not fit that definition.
> 
> Generally a good pattern, but the problem here is that the location of
> the structure completely changed. If there were an accessor for the
> struct in newer kernels, we could use and warp that. But also upstream
> does direct access, and I had to introduce this particular accessor for
> backporting purposes.

Yes, OK, but for instance, you could put the definition for old
kernels in wrappers.h then in another header (like, says,
ancillaries.h), include wrappers.h and if the symbol has not be
defined in wrappers.h, define it in ancillaries.h. This way, it will
continue to work if we carelessly remove the #ifdef in wrappers.h.
This will also make things a bit easier to maintain if the way to
access the restart_block changes again. Basically, constructs like:

#if version > 4.0
    definition 1
#elif version > 3.99
    definition 2
#else
    definition 3
#endif

Will not work with the new wrappers.h organization. Because we want
a #ifdef for each kernel version. So that they can be put in
descending kernel versions order.


> > Ok, but much of the code you add runs under nklock, I am not sure I
> 
> Just as the code tells you: everything that was under nklock before,
> still is (+ some additional time calculation for nanosleep), and
> everything that was not is also not with the patch.
> 
> What are your concerns?

My concern is: the XNRESTART bit or the restart block contents are
not going to be modified under the feet of the thread calling
nanosleep, these are synchronously set by that same thread, so there
is no reason, a priori, for that test and the timeout calculation to
be under nklock. And in fact, I do not see why this could not be
done prior to calling nanosleep, by the cobalt core.

Another solution, is for the kernel side to only implement an
absolute delay (so only clock_nanosleep(TIMER_ABSTIME)) and have the
user-space take care of the rest. This way, the syscall can be
restarted without having to recalculate its arguments, and in fact,
the computation of the remaining time in case the syscall is
interrupted by a signal will be more accurate if done in user-space.
The same goes for select. Since in 3.x we do not have to support the
POSIX API in kernel space, there is no reason to want to implement
POSIX completely in kernel space.

This, of course, means an ABI change, so would only go in 3.1.x, but
is not changing the behaviour of nanosleep with signals an ABI
change already?

> > see the use for this. Also, this code reuses an existing status bit
> > (XNLBALERT) for a different purpose, I foresee unforeseen
> 
> No, it introduces a new status bit XNRESTART - or did I mess something
> up? Argh, I did: That XNLBALERT should be XNRESTART, of course.
> Copy&pasted from the header, working fine in practice, there I didn't
> notice. Will fix.

BTW, XNRESTART is a bad name. It does not say at all what this bit
means.

> 
> > consequences with that. Also the case you handle is a corner case,
> > and with your patch, handling that corner case ends-up taking the
> > majority of the nanosleep code. And finally, maybe some changes
> > could be moved in the I-pipe patch, if that helps (reading the
> > commit message, I believe it could help).
> > 
> > So, all and all, I do not think this patch is acceptable as is.
> > 
> 
> Again, I'm open for better, concrete, less invasive, whatever design
> proposals.
> 
> The code solves a generic problem that we share with Linux in a way that
> is very similar to Linux, even reuses a lot of Linux so that our I-pipe
> patch doesn't grow, and that even per arch. It may not look very
> friendly, but neither does the Linux code.

For such a core, generic feature as syscall restarting, I see no
problem with moving some stuff to the I-pipe patch.

-- 
					    Gilles.
https://click-hack.org

