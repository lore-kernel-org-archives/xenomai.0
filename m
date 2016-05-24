Date: Tue, 24 May 2016 11:19:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160524091918.GG27631@hermes.click-hack.org>
References: <E1b4nHE-0003qK-1y@sd-51317.xenomai.org>
 <20160523120749.GB27631@hermes.click-hack.org>
 <5742F5F4.2020402@siemens.com>
 <20160523124443.GC27631@hermes.click-hack.org>
 <5742FCDB.9080608@siemens.com>
 <20160523130913.GD27631@hermes.click-hack.org>
 <574305A5.2010103@siemens.com>
 <20160524070307.GL13609@hermes.click-hack.org>
 <57441B14.5090104@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57441B14.5090104@siemens.com>
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/kernel: Introduce
 __SCHED_CURRENT policy to setschedparam_ex
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

On Tue, May 24, 2016 at 11:12:52AM +0200, Jan Kiszka wrote:
> On 2016-05-24 09:03, Gilles Chanteperdrix wrote:
> > On Mon, May 23, 2016 at 03:29:09PM +0200, Jan Kiszka wrote:
> >> On 2016-05-23 15:09, Gilles Chanteperdrix wrote:
> >>> On Mon, May 23, 2016 at 02:51:39PM +0200, Jan Kiszka wrote:
> >>>> On 2016-05-23 14:44, Gilles Chanteperdrix wrote:
> >>>>> On Mon, May 23, 2016 at 02:22:12PM +0200, Jan Kiszka wrote:
> >>>>>> On 2016-05-23 14:07, Gilles Chanteperdrix wrote:
> >>>>>>> On Mon, May 23, 2016 at 12:40:00PM +0200, git repository hosting wrote:
> >>>>>>>> Module: xenomai-3
> >>>>>>>> Branch: next
> >>>>>>>> Commit: c821cbaa31c4a816615a82d7cbbd049987da6f1a
> >>>>>>>> URL:    http://git.xenomai.org/?p=xenomai-3.git;a=commit;h=c821cbaa31c4a816615a82d7cbbd049987da6f1a
> >>>>>>>>
> >>>>>>>> Author: Jan Kiszka <jan.kiszka@siemens.com>
> >>>>>>>> Date:   Tue Mar  8 14:41:28 2016 +0100
> >>>>>>>>
> >>>>>>>> cobalt/kernel: Introduce __SCHED_CURRENT policy to setschedparam_ex
> >>>>>>>>
> >>>>>>>> Define the internal scheduling policy "current": it shall refer to the
> >>>>>>>> target thread's current scheduling policy. This will allow to model
> >>>>>>>> pthread_setschedprio on top of pthread_setschedparam_ex with only a
> >>>>>>>> single syscall.
> >>>>>>>
> >>>>>>> I am not sure I understand the use of __SCHED_CURRENT all that well.
> >>>>>>> Since different scheduling policies have different priority ranges,
> >>>>>>> a particular priority may only make sense for a couple of scheduling
> >>>>>>> policies. This, means, to use __SCHED_CURRENT, the programmer has to
> >>>>>>> know the scheduling policy of the current thread anyway. So, since
> >>>>>>> he knows it, why not specifying it clearly? This will make the
> >>>>>>> application code more readable, will not change anything with regard
> >>>>>>> to the number of calls, and avoid to have to change Xenomai core.
> >>>>>>
> >>>>>> See "Wrap pthread_setschedprio for proper real-time support" for the use
> >>>>>> case. I'm open to address that one differently, via a separate syscall
> >>>>>> or whatever, if preferred. This one was just most simple.
> >>>>>
> >>>>> Ok, my point shift to: de we need to support pthread_setschedprio()?
> >>>>
> >>>> Yes, for existing programs that we want to support over Xenomai without
> >>>> modifying them.
> >>>>
> >>>>> The programmer has to know the target thread scheduling policy to be
> >>>>> able to call that function sanely, so why not using
> >>>>> pthread_setschedparam instead, which has a "self documenting" effect
> >>>>> on indicating clearly which policy the target thread is using?
> >>>>
> >>>> Think of a layer that has no knowledge if the caller has SCHED_RR or
> >>>> SCHED_FIFO set (or any other policy that have compatible prio scales)
> >>>> but needs to adjust only the prio. That's the scenario we have to deal with.
> >>>
> >>> Your argument seems to always be the same: "my application is badly
> >>> designed, let us fix it in Xenomai core". What about fixing your
> >>> application for a change?
> >>
> >> It's a) not badly designed and b) it's Xenomai's role to enable
> >> application porting as seamlessly as possible. So I don't see any value
> >> in NOT providing this POSIX interface now also without migrations. It's
> >> there anyway, it's usable, it's just lacking migration-free support.
> > 
> > It is not there an all platforms it seems:
> > https://xenomai.org/build-test-next/distcheck-bfin-linux-uclibc-gcc-4.3.5/cobalt/log.html#1
> > 
> 
> Hmm, is it somehow configurable there? I don't have this setup around, I
> just see pthread_setschedprio being part of the uclibc code base
> (https://git.busybox.net/uClibc/log/libpthread/nptl/pthread_setschedprio.c).
> Confused.
> 
> Yes, needs probing if there isn't any implementation available on that
> platform. Will push an update.

I believe Philippe pushed a fix on the next branch.

-- 
					    Gilles.
https://click-hack.org

