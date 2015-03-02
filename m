Date: Mon, 2 Mar 2015 18:42:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150302174210.GB1574@hermes.click-hack.org>
References: <54F0CF9E.1040707@siemens.com>
 <20150227202453.GK434@hermes.click-hack.org>
 <54F0D584.1030307@siemens.com> <54F0D7E9.2080209@siemens.com>
 <20150227205004.GO434@hermes.click-hack.org>
 <54F4A086.5000007@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54F4A086.5000007@siemens.com>
Subject: Re: [Xenomai] [RFC] Consolidated exception prologue/epiloge for x86
 and ARM
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

On Mon, Mar 02, 2015 at 06:40:22PM +0100, Jan Kiszka wrote:
> On 2015-02-27 21:50, Gilles Chanteperdrix wrote:
> > On Fri, Feb 27, 2015 at 09:47:37PM +0100, Jan Kiszka wrote:
> >> On 2015-02-27 21:37, Jan Kiszka wrote:
> >>> On 2015-02-27 21:24, Gilles Chanteperdrix wrote:
> >>>> On Fri, Feb 27, 2015 at 09:12:14PM +0100, Jan Kiszka wrote:
> >>>>> Hi,
> >>>>>
> >>>>> just pushed a first implementation of the general model that I proposed
> >>>>> for exception handling. You can find it at
> >>>>>
> >>>>> http://git.xenomai.org/ipipe-jki.git/log/?h=queues/trap-rework
> >>>>
> >>>> NACK. The ARM implementation is broken, re-enabling hardware irqs
> >>>> before stalling root is wrong.
> >>>
> >>> Ok, will adjust.
> >>
> >> But I need to think about this again first. It seems we are doing this
> >> for ages on x86, and I need to understand why it could be a problem on
> >> ARM. Can you provide an example that would breaks?
> > 
> > You are creating a point where a Linux irq can happen which does not
> > exist on the mainline kernel.
> > 
> > If you do:
> > local_irq_save(flags);
> > hard_local_irq_enable();
> > 
> > There is no way a Linux interrupt can squeeze in.
> > 
> > (I mean in the case of exception over root domamin, in the case of
> > an exception over head, irqs are enabled anyway).
> 
> That is clear. I'm looking for examples where that is a real problem in
> the given code path.

It is really hard to be sure. Better safe than sorry.

-- 
					    Gilles.

