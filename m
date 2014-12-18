Date: Thu, 18 Dec 2014 16:30:01 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141218153001.GT2012@hermes.click-hack.org>
References: <549072DC.1030901@xenomai.org>
 <CAMJ=MEfzrJQGYKT41F2hSirn8q0MGt-kWuT2GYQE7YTbSCNG5A@mail.gmail.com>
 <549090FA.7000901@xenomai.org>
 <CAMJ=MEc9UXa4P18kNmPeKH-SziXMj9Grbxagj7Wm_MckHcOC7Q@mail.gmail.com>
 <5492989C.9070106@siemens.com>
 <CAMJ=MEeWPyBFBbjj7_JLENZQ+xBkxbaKGiZBehKCatVa-1owqA@mail.gmail.com>
 <20141218141248.GN2012@hermes.click-hack.org>
 <5492EBAC.10502@siemens.com>
 <20141218150435.GP2012@hermes.click-hack.org>
 <CAMJ=MEc2V0P4nLXVwmxn7LNuY92PrPg=TnPa6UJi=0oCRz=w0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMJ=MEc2V0P4nLXVwmxn7LNuY92PrPg=TnPa6UJi=0oCRz=w0g@mail.gmail.com>
Subject: Re: [Xenomai] [xenomai-forge] timer-internal consume a lot of cpu
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On Thu, Dec 18, 2014 at 04:25:40PM +0100, Ronny Meeus wrote:
> On Thu, Dec 18, 2014 at 4:04 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> > On Thu, Dec 18, 2014 at 03:58:52PM +0100, Jan Kiszka wrote:
> >> On 2014-12-18 15:12, Gilles Chanteperdrix wrote:
> >> > Otherwise, have you tried some alternate libc, such as musl:
> >> > http://www.musl-libc.org/
> >> >
> >> > The following blog:
> >> > http://ewontfix.com/
> >> >
> >> > Seems to show that the musl maintainers try and report glibc bugs
> >> > and avoid them in their implementation.
> >> >
> >> > I have not tried xenomai with musl at all, so, maybe it does not
> >> > even compile. But maybe just compiling a testcase for the condvar
> >> > issue with that libc would help know if it has the same issue or
> >> > not.
> >>
> >> Well, like with many of those "light-weight" re-implementations, the are
> >> "small" issues with bits required for real-time:
> >>
> >> http://git.musl-libc.org/cgit/musl/tree/src/thread/pthread_mutexattr_setprotocol.c
> >
> > On the other hand, no implementation with a clear ENOTSUPP is better
> > than a partial and buggy implementation that can not be trusted anyway.
> >
> > --
> >                                             Gilles.
> 
> Gilles I agree.
> 
> In the meantime I tried it already.
> 
> This is indeed the trace I get when running my test application with musl.
> # ./cond_test_arm
> # hread_mutexattr_setprotocol: Not supported
> 
> Cobalt is not an option for us either since in that case all Linux
> applications will run in low-priority. Next to that we also have a
> huge priority inversion each time a Linux system call is done.
> 
> Do we have other options to fix forge?

Well, three options have been proposed if I followed this thread
correctly: 
- stop using priority inheritance for these internal mutexes, at the
risk of creating priority inversions
- switch to priority ceiling (but what will be the ceiling? 99?)
- use cobalt.

-- 
					    Gilles.

