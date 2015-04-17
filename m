Date: Fri, 17 Apr 2015 20:50:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150417185058.GB17020@hermes.click-hack.org>
References: <20150417175028.GP1589@hermes.click-hack.org>
 <55314B85.2030708@siemens.com>
 <20150417180819.GQ1589@hermes.click-hack.org>
 <55314CA0.7070705@siemens.com>
 <20150417181254.GR1589@hermes.click-hack.org>
 <55314E36.3040201@siemens.com>
 <20150417182459.GS1589@hermes.click-hack.org>
 <55315058.6090502@siemens.com>
 <20150417183022.GT1589@hermes.click-hack.org>
 <55315218.70009@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55315218.70009@siemens.com>
Subject: Re: [Xenomai] Dealing with too small thread stacks
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On Fri, Apr 17, 2015 at 08:34:00PM +0200, Jan Kiszka wrote:
> On 2015-04-17 20:30, Gilles Chanteperdrix wrote:
> > On Fri, Apr 17, 2015 at 08:26:32PM +0200, Jan Kiszka wrote:
> >> On 2015-04-17 20:24, Gilles Chanteperdrix wrote:
> >>> On Fri, Apr 17, 2015 at 08:17:26PM +0200, Jan Kiszka wrote:
> >>>> On 2015-04-17 20:12, Gilles Chanteperdrix wrote:
> >>>>> On Fri, Apr 17, 2015 at 08:10:40PM +0200, Jan Kiszka wrote:
> >>>>>> On 2015-04-17 20:08, Gilles Chanteperdrix wrote:
> >>>>>>> On Fri, Apr 17, 2015 at 08:05:57PM +0200, Jan Kiszka wrote:
> >>>>>>>> On 2015-04-17 19:50, Gilles Chanteperdrix wrote:
> >>>>>>>>> On Fri, Apr 17, 2015 at 07:34:30PM +0200, Jan Kiszka wrote:
> >>>>>>>>>> Hi,
> >>>>>>>>>>
> >>>>>>>>>> analyzing page faults of an application that prefers to set its own
> >>>>>>>>>> stacks, I noticed a problem in Xenomai (2 and 3), at least from the
> >>>>>>>>>> usability POV: We document the minimum stack stack as PTHREAD_STACK_MIN
> >>>>>>>>>> + 1 page, at least in Xenomai 3, and we enforce that on thread creation.
> >>>>>>>>>> However, enforcement is doomed to fail if the stack is preallocated (and
> >>>>>>>>>> that too small).
> >>>>>>>>>>
> >>>>>>>>>> As we cannot detect if the user set a stack address in pthread_attr_t, I
> >>>>>>>>>> would suggest to fail thread creation instead of performing it with
> >>>>>>>>>> improper parameters. Other suggestions? If not, I would prepare a patch
> >>>>>>>>>> for Xenomai 3 (for 2 only if desired).
> >>>>>>>>>
> >>>>>>>>> It seems to me we can detect the parameters in the pthread_attr_t
> >>>>>>>>> using pthread_attr_getstack. So, we can get __wrap_pthread_create to
> >>>>>>>>> fail if the size is not sufficient.
> >>>>>>>>
> >>>>>>>> Nope, unfortunately not:
> >>>>>>>>
> >>>>>>>> "If the pthread_attr_getstack() function is called before the stackaddr
> >>>>>>>> attribute has been set, the behavior is unspecified."
> >>>>>>>
> >>>>>>> It is unspecified by POSIX, but Xenomai supports only two
> >>>>>>> implementations, glibc and uClibc, so, we can look at what these two
> >>>>>>> libraries do. I would bet they return you a NULL stack pointer or
> >>>>>>> something.
> >>>>>>
> >>>>>> I would have expected that, too, but the results for glibc seem random.
> >>>>>> Plus there is the risk that something changes, thus we become
> >>>>>> version-dependent.
> >>>>>
> >>>>> Ok then, what about the influence of pthread_attr_setstack() on
> >>>>> pthread_attr_getstacksize(), maybe more luck there?
> >>>>
> >>>> setstack defines the size getstacksize returns. So does setstacksize.
> >>>>
> >>>> What happens during setstacksize is apparently that the address is set
> >>>> to NULL - size. But, again, that is just the current glibc behaviour.
> >>>
> >>> Yes, ok, but in order to test the stack size passed by the user, it
> >>> simply means we can use getstacksize and bail out if not sufficient.
> >>
> >> Sure, that would be the best way.
> >>
> >> Along that, I would recommend raising the minimum to 2*PTHREAD_STACK_MIN.
> > 
> > What for ? We know that the system crashes if the stack is too
> > small, but that is the consequence of the user choice, there is not
> > much we can do about it. What I would concentrate on, and I think we
> > had that on xenomai 2.x is to have a reasonable default stack size.
> > Actually, we could wrap pthread_attr_init to define our own default
> > and be done with it.
> > 
> 
> The current minimum PTHREAD_STACK_MIN + PAGE doesn't work reliably (see
> my other posting). Thus we can either give up on checking the minimum
> completely (much simpler) or raise it to a value that has at least an
> effect.

As in xenomai 2.x, I would suggest the maximum of __WORDSIZE * 1024
and PTHREAD_STACK_MIN as a default stack size.

I think the idea of adding pagesize to PTHREAD_STACK_MIN comes from
the implementation of signals which were pulling siginfo structs
from kernel after each syscall. Since this thing is long gone (even
in xenomai 2.6 I believe), we have no reason to try and enforce
another minimum than POSIX.

-- 
					    Gilles.

