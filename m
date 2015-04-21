Date: Tue, 21 Apr 2015 18:40:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150421164016.GB7109@hermes.click-hack.org>
References: <E1Yka0Q-00008c-Jh@sd-51317.xenomai.org>
 <20150421152715.GV7109@hermes.click-hack.org>
 <5536751A.6080609@siemens.com>
 <20150421160625.GX7109@hermes.click-hack.org>
 <553676DF.8020607@siemens.com>
 <20150421161623.GY7109@hermes.click-hack.org>
 <553678CC.5020206@siemens.com>
 <20150421163247.GZ7109@hermes.click-hack.org>
 <55367CB0.90609@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55367CB0.90609@siemens.com>
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : lib/cobalt: Rework minimum
 stack size enforcement
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On Tue, Apr 21, 2015 at 06:37:04PM +0200, Jan Kiszka wrote:
> On 2015-04-21 18:32, Gilles Chanteperdrix wrote:
> > On Tue, Apr 21, 2015 at 06:20:28PM +0200, Jan Kiszka wrote:
> >> On 2015-04-21 18:16, Gilles Chanteperdrix wrote:
> >>> On Tue, Apr 21, 2015 at 06:12:15PM +0200, Jan Kiszka wrote:
> >>>> On 2015-04-21 18:06, Gilles Chanteperdrix wrote:
> >>>>> On Tue, Apr 21, 2015 at 06:04:42PM +0200, Jan Kiszka wrote:
> >>>>>> On 2015-04-21 17:27, Gilles Chanteperdrix wrote:
> >>>>>>> On Tue, Apr 21, 2015 at 05:22:34PM +0200, git repository hosting wrote:
> >>>>>>>> +COBALT_IMPL(int, pthread_attr_setstack, (pthread_attr_t *attr, void *stackaddr,
> >>>>>>>> +					 size_t stacksize))
> >>>>>>>> +{
> >>>>>>>> +	if (stacksize < COBALT_STACKSIZE_MIN)
> >>>>>>>> +		return -EINVAL;
> >>>>>>>> +	return __STD(pthread_attr_setstack)(attr, stackaddr, stacksize);
> >>>>>>>> +}
> >>>>>>>
> >>>>>>> As I said, there is no reason for Xenomai to enforce a task size
> >>>>>>> larger than PTHREAD_STACK_MIN. This breaks POSIX compliance, and is
> >>>>>>> useless.
> >>>>>>
> >>>>>> Then we should not use printf & Co. from any trampoline function, e.g.
> >>>>>> vxworks/taskLib.c:task_trampoline. I only tried with a local skin, but I
> >>>>>> bet the issue is reproducible with that one.
> >>>>>>
> >>>>>> For that reason, I went down the conservative path.
> >>>>>
> >>>>> The path you took breaks compatibility with POSIX. On a compliant
> >>>>> system, pthread_attr_setstacksize(attr, PTHREAD_STACK_MIN) is not
> >>>>> supposed to return an error.
> >>>>
> >>>> That is true. We have to pick from one evil: fail non-compliant here or
> >>>> crash later.
> >>>
> >>> The point is: you do not know if it will crash later, you can assume
> >>> that the user calling pthread_attr_setstack knows what he is doing.
> >>
> >> The crash can be caused by the the library code and, thus, can happen
> >> even if the application code would not crash. That is my problem.
> > 
> > Yes, so what, increase the stack. The same goes with glibc when
> > using printf, you know that PTHREAD_STACK_MIN is not sufficient, so
> > you should pass a larger size. I suspect it goes this way for any
> > posix implementation. Once again, if an applications chooses to use
> > these calls, it should know what it is doing.
> 
> Possibly the crash was limited to the case where the application set a
> stack address and Xenomai messed up the size. I'm rechecking this right
> now, and if we are lucky, PTHREAD_STACK_MIN turns out to be fine for
> Xenomai as well.
> 
> > 
> >>
> >>> Any user calling this interface should. We are doing real-time in C,
> >>> not making an API for tutorials in ADA, or C++, let us try not to
> >>> prevent the user from doing what he wants.
> >>>
> >>> For pthread_attr_setstacksize, you can round to the larger size and
> >>> remain POSIX compliant.
> >>
> >> Is it specified that this call invalidate a stack address set earlier? I
> >> don't see this.
> > 
> > The way I understand the spec, the stack and stacksize attribute are
> > separate, and setting stacksize sets the size of the stack that will
> > be allocated automatically. Now if you set both, maybe stacksize is
> > ignored and the sized passed to setstack is used. But I would not
> > expect the size passed to setstack to be used for the stacksize
> > attribute.
> 
> glibc uses the same internal stacksize field for both calls.

Well, I guess it assumes that an application that uses both calls is
broken anyway.

-- 
					    Gilles.

