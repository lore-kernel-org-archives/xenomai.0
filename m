Date: Fri, 23 Jan 2015 18:47:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150123174740.GB12812@hermes.click-hack.org>
References: <129277905.Ag2XebZWbK@soho> <54C27115.7030901@xenomai.org>
 <1498823.b61P0cr1E8@indiana> <54C283D9.8020403@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54C283D9.8020403@xenomai.org>
Subject: Re: [Xenomai] Packaging Xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, Jan 23, 2015 at 06:24:41PM +0100, Philippe Gerum wrote:
> On 01/23/2015 06:02 PM, Leopold Palomo-Avellaneda wrote:
> > El Divendres, 23 de gener de 2015, a les 17:04:37, Philippe Gerum va escriure:
> >> On 01/23/2015 01:09 PM, Leopold Palomo-Avellaneda wrote:
> >>> Hi,
> >>>
> >>> now that I have some kernel to boot, I would like to ask some aspects of
> >>> Xenomai-3 in order to package it.
> >>>
> >>> Reading the documentation, now the new libxenomai could use two kind of
> >>> kernels: the patched one (Cobalt) or the preempt_rt (Mercury).
> >>
> >> Mercury does not require preempt-rt. In some cases, one may want the API
> >> emulation capabilities without actually having real-time requirements.
> > 
> > Ops, Philippe  the documentation [1] says that Mercury:
> > 
> >> Your kernel should at least provide high resolution timer support 
> > (CONFIG_HIGH_RES_TIMERS), and likely complete preemption (PREEMPT_RT) if your 
> > application requires short and bounded latencies.
> > 
> > if your application .. it's not mandatory, right?. So, you can use it in any 
> > kernel that at least has CONFIG_HIGH_RES_TIMERS
> 
> Yes. Complete preemption is only required to meet real-time requirements.
> 
> > 
> >>> 1) Is it possible to have _only_ one library (binary) that uses one or
> >>> another kernel in function which is running?
> >>
> >> No. Definitely not.
> > 
> > Ok, it's too difficult to have it? Same lib that in runtime select the interface 
> > to use? So, then someone could provide a binary, that depends on the kernel 
> > will work with cobalt or mercury. The packagers would have the life better.
> > 
> 
> Sure, but the maintainers would go nuts, which would not help the
> packagers in the end. Not to speak of the crappy performances on low-end
> hardware, due to the extra levels of encapsulation/indirection required.
> I don't see any reasonable way to implement this sanely and efficiently.
> We are chasing micro-second level optimization in some cases in the
> code, for running on CPUs with not-that-fast caches. In this user vs
> packager/maintainer trade-off, user must prevail.

The maintainers are already nuts. Due to the performance impact, it
would have to be something optional. Also, it implies two build
trees of Xenomai. And finally, it looks like a very specific need,
so unless a lot of users are asking for it, there is really no
reason to have to write and more importantly maintain such code. So,
if you need this, by all means, implement it on your side. Maybe
some day a lot of users will ask for it.

On the binary compatibility side, I am not sure cobalt's
pthread_mutex_lock is not binary compatible with glibc's
pthread_mutex_lock. I would tend to think that the same goes for all
emulated OSes API calls, unless we use inlines.


-- 
					    Gilles.

