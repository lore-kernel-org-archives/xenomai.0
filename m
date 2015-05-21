From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 21 May 2015 12:59:13 -0400
Message-ID: <20150521165913.GM6169@csclub.uwaterloo.ca>
References: <20150513203301.GC6169@csclub.uwaterloo.ca>
 <20150513203743.GG3759@hermes.click-hack.org>
 <20150513203833.GD6169@csclub.uwaterloo.ca>
 <20150514162351.GE6169@csclub.uwaterloo.ca>
 <20150514162831.GH3759@hermes.click-hack.org>
 <20150514164745.GF6169@csclub.uwaterloo.ca>
 <20150514193433.GG6169@csclub.uwaterloo.ca>
 <20150521163208.GL6169@csclub.uwaterloo.ca>
 <20150521163440.GM10686@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150521163440.GM10686@hermes.click-hack.org>
Subject: Re: [Xenomai] 3.14 hangs with ipipe patch applied
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, May 21, 2015 at 06:34:40PM +0200, Gilles Chanteperdrix wrote:
> On Thu, May 21, 2015 at 12:32:08PM -0400, Lennart Sorensen wrote:
> > On Thu, May 14, 2015 at 03:34:33PM -0400, Lennart Sorensen wrote:
> > > I managed to confirm that jiffies is in fact stuck at the boot time
> > > -300000 value.  Now if I could only track down what code is supposed to
> > > increment it.  The code I found (do_timer called by xtime_update) does
> > > not appear to get called by anyone.
> > 
> > I have narrowed it down.  If I apply the ipipe patch except for
> > drivers/irqchip/irq-gic.c then it still boots.
> > 
> > So only about 200 lines of patch left to investigate.
> > 
> > I guess the reason the timer ticks were not happening was that no
> > interrupts were happening.
> 
> There is no need to guess that, it can be verified easily.

This seems to solve my problem:

root@lennartsorensen-386:~/linux-3.14-wip/linux-3.14.39.rr1# diff -u debian/patches/ipipe-core-3.14.39.diff.original debian/patches/ipipe-core-3.14.39.diff
--- debian/patches/ipipe-core-3.14.39.diff.original     2015-05-21 12:32:53.669255161 -0400
+++ debian/patches/ipipe-core-3.14.39.diff      2015-05-21 12:50:20.096497809 -0400
@@ -24605,12 +24605,12 @@
  static void gic_mask_irq(struct irq_data *d)
  {
 -      u32 mask = 1 << (gic_irq(d) % 32);
-+      u32 mask = 1 << (d->irq % 32);
++      u32 mask = 1 << (gic_irq(d) % 32);
 +      unsigned long flags;
  
 -      raw_spin_lock(&irq_controller_lock);
 +      raw_spin_lock_irqsave_cond(&irq_controller_lock, flags);
-+      ipipe_lock_irq(d->irq);
++      ipipe_lock_irq(gic_irq(d));
        writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 32) * 4);
        if (gic_arch_extn.irq_mask)
                gic_arch_extn.irq_mask(d);
@@ -24621,7 +24621,7 @@
  static void gic_unmask_irq(struct irq_data *d)
  {
 -      u32 mask = 1 << (gic_irq(d) % 32);
-+      u32 mask = 1 << (d->irq % 32);
++      u32 mask = 1 << (gic_irq(d) % 32);
 +      unsigned long flags;
  
 -      raw_spin_lock(&irq_controller_lock);
@@ -24630,7 +24630,7 @@
                gic_arch_extn.irq_unmask(d);
        writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABLE_SET + (gic_irq(d) / 32) * 4);
 -      raw_spin_unlock(&irq_controller_lock);
-+      ipipe_unlock_irq(d->irq);
++      ipipe_unlock_irq(gic_irq(d));
 +      raw_spin_unlock_irqrestore_cond(&irq_controller_lock, flags);
  }
  
@@ -24652,7 +24652,7 @@
 +
 +static void gic_hold_irq(struct irq_data *d)
 +{
-+      u32 mask = 1 << (d->irq % 32);
++      u32 mask = 1 << (gic_irq(d) % 32);
 +      unsigned long flags;
 +
 +      raw_spin_lock_irqsave_cond(&irq_controller_lock, flags);
@@ -24668,7 +24668,7 @@
 +
 +static void gic_release_irq(struct irq_data *d)
 +{
-+      u32 mask = 1 << (d->irq % 32);
++      u32 mask = 1 << (gic_irq(d) % 32);
 +      unsigned long flags;
 +
 +      raw_spin_lock_irqsave_cond(&irq_controller_lock, flags);

gic_irq(d) returns d->hwirq, which is not the same as d->irq (or at
least does not have to be, but probably is on many systems).

Does this make sense?

-- 
Len Sorensen

