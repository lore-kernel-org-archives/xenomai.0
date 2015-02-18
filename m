Date: Wed, 18 Feb 2015 20:05:49 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150218190549.GI30317@hermes.click-hack.org>
References: <54E4D14E.1060104@siemens.com>
 <20150218175507.GD30317@hermes.click-hack.org>
 <54E4D61B.1020006@siemens.com>
 <20150218181334.GE30317@hermes.click-hack.org>
 <54E4D835.1040204@siemens.com>
 <20150218182632.GG30317@hermes.click-hack.org>
 <54E4DDEA.3060909@siemens.com>
 <20150218184943.GH30317@hermes.click-hack.org>
 <54E4E166.5030701@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54E4E166.5030701@siemens.com>
Subject: Re: [Xenomai] arm: Late delivery of pending Linux signals?
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

On Wed, Feb 18, 2015 at 08:00:54PM +0100, Jan Kiszka wrote:
> On 2015-02-18 19:49, Gilles Chanteperdrix wrote:
> > On Wed, Feb 18, 2015 at 07:46:02PM +0100, Jan Kiszka wrote:
> >> On 2015-02-18 19:26, Gilles Chanteperdrix wrote:
> >>> On Wed, Feb 18, 2015 at 07:21:41PM +0100, Jan Kiszka wrote:
> >>>> On 2015-02-18 19:13, Gilles Chanteperdrix wrote:
> >>>>> On Wed, Feb 18, 2015 at 07:12:43PM +0100, Jan Kiszka wrote:
> >>>>>> On 2015-02-18 18:55, Gilles Chanteperdrix wrote:
> >>>>>>> On Wed, Feb 18, 2015 at 06:52:14PM +0100, Jan Kiszka wrote:
> >>>>>>>> Hi Gilles,
> >>>>>>>>
> >>>>>>>> I noticed on ARM (AM335 TI board) that the SIGDEBUG if the related test
> >>>>>>>> apparently only gets delivered to the receiver after it invokes a
> >>>>>>>> syscall, not on return from its secondary mode migration. Therefore the
> >>>>>>>> page fault test of the sigdebug smokey test fails (tested with Xenomai
> >>>>>>>> 3), and I bet the watchdog test as well. Is this a known limitation?
> >>>>>>>
> >>>>>>> Xenomai 2.6 sigdebug works fine on omap3 (very near from an
> >>>>>>
> >>>>>> Will try 2.6 next.
> >>>>>>
> >>>>>>> arm33xx). That being said, the AM3xx port is not part of the main
> >>>>>>> line I-pipe, and based on a non mainline kernel, so it is difficult
> >>>>>>> for me to answer this question.
> >>>>>>
> >>>>>> Then I'm possibly not building all recommended bits - I'm on 3.14 I-pipe
> >>>>>> upstream. That seems to work fine in general. Which version are you
> >>>>>> referring to?
> >>>>>
> >>>>> The one documented in arm/patches/README
> >>>>
> >>>> https://github.com/RobertCNelson/linux-dev/commits/am33x-v3.8? There is
> >>>> nothing explicitly stated regarding the AM3xx board, just that reference
> >>>> in the context of the Beaglebone.
> >>>>
> >>>> Anyway, I thought that syscall and exception handling should not be
> >>>> dependent on board patches, should they?
> >>>
> >>> If you had been using a Linux fork (which I assumed you did,
> >>> because you mentioned a processor which is not mainline officially),
> >>> it would have been very possible for the Linux fork you used to
> >>> break the changes in entry.S due to a bad conflict resolution.
> >>> Linux forks very often tend to push changes in generic code even
> >>> though they should not.
> >>
> >> The TI AM335x (Cortex-A8) comes with full mainline support, even for
> >> 3.14. That's probably why vanilla I-pipe 3.14 works for us.
> >>
> >> Against all odds, I just got Debian installed into an Integrator/CP
> >> machine model. Let's see if I can debug the issue that way. But I will
> >> keep porting I-pipe to the Versatile Express in mind.
> > 
> > If you have an ARM board, why going over all these contorsions? Why
> > not simply enabling the I-pipe tracer and looking at what happens
> > when you observe the problem you observe ?
> 
> Because it's easier to debug than to trace such an issue. Emulation, and
> even more virtualization, is more handy than real hw. E.g., this
> particular board has the nice feature of not booting up automatically
> when being power-cycled.

I would tend to think that having to port the I-pipe to a virtual
board consumes useless time, and useless maintenance time (because
once you add the support for a board it takes time to maintain it),
as is installing a debian distribution for that virtual board.
During all that time you would have had the time to fix the bug 10
times using printk and the I-pipe tracer. And also, ARM processors
have a nice feature called JTAG, which is much more reliable than
hoping that a virtual hardware will have the same behaviour than
real hardware.

-- 
					    Gilles.

