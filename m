Date: Thu, 21 May 2015 19:20:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150521172058.GP10686@hermes.click-hack.org>
References: <20150514164745.GF6169@csclub.uwaterloo.ca>
 <20150514193433.GG6169@csclub.uwaterloo.ca>
 <20150521163208.GL6169@csclub.uwaterloo.ca>
 <20150521163440.GM10686@hermes.click-hack.org>
 <20150521165913.GM6169@csclub.uwaterloo.ca>
 <20150521170301.GN10686@hermes.click-hack.org>
 <20150521170432.GN6169@csclub.uwaterloo.ca>
 <20150521170716.GO6169@csclub.uwaterloo.ca>
 <20150521171018.GO10686@hermes.click-hack.org>
 <20150521171641.GQ6169@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150521171641.GQ6169@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] 3.14 hangs with ipipe patch applied
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On Thu, May 21, 2015 at 01:16:41PM -0400, Lennart Sorensen wrote:
> On Thu, May 21, 2015 at 07:10:18PM +0200, Gilles Chanteperdrix wrote:
> > On Thu, May 21, 2015 at 01:07:16PM -0400, Lennart Sorensen wrote:
> > > On Thu, May 21, 2015 at 01:04:32PM -0400, Lennart Sorensen wrote:
> > > > OK, I was not sure, hence why I wanted to ask.
> > > > 
> > > > Let me fix that up and try that.  Then I should do a build with
> > > > CONFIG_IPIPE=y and see if that then starts to work.
> > > > 
> > > > At least this is progress.
> > > 
> > > So this perhaps:
> > > 
> > > --- debian/patches/ipipe-core-3.14.39.diff.original     2015-05-21 12:32:53.669255161 -0400
> > > +++ debian/patches/ipipe-core-3.14.39.diff      2015-05-21 13:06:12.075112664 -0400
> > > @@ -24605,7 +24605,7 @@
> > >   static void gic_mask_irq(struct irq_data *d)
> > >   {
> > >  -      u32 mask = 1 << (gic_irq(d) % 32);
> > > -+      u32 mask = 1 << (d->irq % 32);
> > > ++      u32 mask = 1 << (gic_irq(d) % 32);
> > >  +      unsigned long flags;
> > >   
> > >  -      raw_spin_lock(&irq_controller_lock);
> > > @@ -24621,7 +24621,7 @@
> > >   static void gic_unmask_irq(struct irq_data *d)
> > >   {
> > >  -      u32 mask = 1 << (gic_irq(d) % 32);
> > > -+      u32 mask = 1 << (d->irq % 32);
> > > ++      u32 mask = 1 << (gic_irq(d) % 32);
> > >  +      unsigned long flags;
> > >   
> > >  -      raw_spin_lock(&irq_controller_lock);
> > > @@ -24652,7 +24652,7 @@
> > >  +
> > >  +static void gic_hold_irq(struct irq_data *d)
> > >  +{
> > > -+      u32 mask = 1 << (d->irq % 32);
> > > ++      u32 mask = 1 << (gic_irq(d) % 32);
> > >  +      unsigned long flags;
> > >  +
> > >  +      raw_spin_lock_irqsave_cond(&irq_controller_lock, flags);
> > > @@ -24668,7 +24668,7 @@
> > >  +
> > >  +static void gic_release_irq(struct irq_data *d)
> > >  +{
> > > -+      u32 mask = 1 << (d->irq % 32);
> > > ++      u32 mask = 1 << (gic_irq(d) % 32);
> > >  +      unsigned long flags;
> > >  +
> > >  +      raw_spin_lock_irqsave_cond(&irq_controller_lock, flags);
> > 
> > Actually, gic_mask_irq and gic_unmask_irq should be identical to the
> > unpatched kernel with regard to registers reads and writes. And
> > gic_hold_irq/gic_release_irq should be identical to gic_mask/unmask.
> 
> Well I am reverting the change to gic_mask_irq and gic_unmask_irq, so
> that should make them identical to the unpatched kernel, and that does
> in fact make the system now boot.

Of course, you should keep the addition of ipipe_lock/unlock irq.
which is the point of patching these functions.

> 
> And I am changing the mask in gic_hold_irq/gic_release_irq to match
> gic_mask_irq/gic_unmask_irq, so that seems like it should be correct
> too then.
> 
> Should I make a proper patch based on the current 3.14 git tree to make
> it easier to read?  diffs of diffs are a bit messy.

If you are working with something more recent like 3.16 or 3.18,
please post as a patch to these.

-- 
					    Gilles.

