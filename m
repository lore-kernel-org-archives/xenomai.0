From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <2ff1a98a0708080140w4191c988je6e980ed4940e4ab@domain.hid>
References: <46B86E53.1030803@domain.hid>
	<2ff1a98a0708070724j5afecf20q22994d053553ed57@domain.hid>
	<46B885E3.6060605@domain.hid>
	<2ff1a98a0708070756q60794718wb1bc55675ea05ba4@domain.hid>
	<46B888B4.2070301@domain.hid>
	<2ff1a98a0708070809h2ac1a0b7q2178297d5a824bb9@domain.hid>
	<1186505723.5408.8.camel@domain.hid> <46B8A57D.8010606@domain.hid>
	<46B8ACBB.5030001@domain.hid>
	<18105.28848.229659.110775@domain.hid>
	<2ff1a98a0708080140w4191c988je6e980ed4940e4ab@domain.hid>
Content-Type: text/plain
Date: Wed, 08 Aug 2007 14:33:10 +0200
Message-Id: <1186576391.5051.5.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [Adeos-main] [COW-BUG] __alloc_pages called from
	atomic context
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>, Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Wed, 2007-08-08 at 10:40 +0200, Gilles Chanteperdrix wrote:
> On 8/8/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> > Jan Kiszka wrote:
> >  > Jan Kiszka wrote:
> >  > > Philippe Gerum wrote:
> >  > >> On Tue, 2007-08-07 at 17:09 +0200, Gilles Chanteperdrix wrote:
> >  > >>> On 8/7/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> >  > >>>> Gilles Chanteperdrix wrote:
> >  > >>>>> The fact that you are in a hurry should not be an excuse to propose a
> >  > >>>>> fix which is much worse than the bug itself.
> >  > >>>> Please explain.
> >  > >>> Using GFP_ATOMIC is not a good idea, because the kernel needs the
> >  > >>> GFP_ATOMIC pools for allocation that take place from really atomic
> >  > >>> contexts such as interruption handlers for instance. fork should not
> >  > >>> be an atomic context.
> >  > >>>
> >  > >>> So the only reason I see why you propose this patch is because you are
> >  > >>> in a hurry. Ok, before we fix this properly, you can use GFP_ATOMIC
> >  > >>> locally, but please do not make
> >  > >>> this an official patch.
> >  > >>>
> >  > >> I'm afraid you are both right. Draining pages from the atomic pool might
> >  > >> starve truely atomic contexts, and releasing the lock guarding the
> >  > >> pagetable pages for the source mm seems contradictory with what the
> >  > >> current code tries to achieve in holding it.
> >  > >>
> >  > >> Here is a patch preallocating the page for the cow-breaking code, which
> >  > >> relies on the lock breaking pattern already in place. Not exactly
> >  > >> pretty, slightly tested here (UP, spinlock debug), but looks ok so far.
> >  > >> Needs SMP testing before any attempt is made to merge it.
> >  > >
> >  > > Funny. I just finished my own patch of this kind and made it pass a
> >  > > basic COW stress test here. Find it below, it is very similar. Will
> >  > > now analyse yours to see which one looks nicer and/or is more correct.
> >  >
> >  > Yours is clearly nicer, but it required/allowed a few more cleanups.
> >  > Find my variant attached (against our local 2.6.20 kernel).
> >  >
> >  > From my POV: problem solved. 8)
> >
> > It seems you solved this problem before I even had a chance to have
> > a look at the code.
> 
> Finally looking at the I-pipe patch, I see something suspicious:
> the patch replaces a "return err" with a "return 0" in zeromap_pud_range.
> 

Looks like a collision between mm/memory.c updates pertaining to
different kernel versions. I've been incorporating generic changes from
your ARM tree into my generic tree when they both were at different
kernel release levels. Will fix, thanks.

-- 
Philippe.



