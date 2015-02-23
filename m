Date: Mon, 23 Feb 2015 19:33:23 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150223183323.GL22377@hermes.click-hack.org>
References: <20150223165549.GC22377@hermes.click-hack.org>
 <54EB5D02.8080105@xenomai.org>
 <20150223171250.GE22377@hermes.click-hack.org>
 <20150223172146.GG22377@hermes.click-hack.org>
 <54EB66BB.2060703@siemens.com>
 <20150223175110.GI22377@hermes.click-hack.org>
 <54EB695C.4000909@siemens.com>
 <20150223180425.GJ22377@hermes.click-hack.org>
 <20150223181124.GK22377@hermes.click-hack.org>
 <54EB6E68.3010200@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54EB6E68.3010200@siemens.com>
Subject: Re: [Xenomai] ipipe: issues with ARM exception handling
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

On Mon, Feb 23, 2015 at 07:16:08PM +0100, Jan Kiszka wrote:
> On 2015-02-23 19:11, Gilles Chanteperdrix wrote:
> > On Mon, Feb 23, 2015 at 07:04:25PM +0100, Gilles Chanteperdrix wrote:
> >> So, finally, I propose:
> > 
> > Mmmm. try again.
> > 
> >>
> >> static inline unsigned long ipipe_fault_entry(void)
> >> {
> >> 	unsigned long flags;
> >>
> >> 	local_irq_save(flags);      /* Re-enables hw irqs */
> > 
> > We need the explicit hard_local_irq_enable() here.
> > 
> >>
> >> 	return flags;
> >> }
> >>
> >> static inline void ipipe_fault_exit(unsigned long x)
> >> {
> >> 	if (irqs_disabled()) {
> >> 		__ipipe_restore_root_nosync(x);
> >> 		hard_local_irq_disable();
> >> 	}
> >> }
> > 
> > We need hard_local_irq_disable() before __ipipe_restore_root_nosync,
> > to avoid the preemption of a Linux interrupt where this should not
> > be possible.
> 
> ipipe_restore_root_nosync?

Since we called hard_local_irq_disable(), we know irqs are off, and
can call the underscored version.

> 
> But we first need to understand the differences to x86 to be sure that
> we don't miss something. The remaining differences either have to have
> an architecture-specific reason - or one side is still wrong (or
> needlessly complex).

What I have written here is completely specific to the situation we
described for ARM, I doubt very much it can be compared with what
happens on x86.

-- 
					    Gilles.

