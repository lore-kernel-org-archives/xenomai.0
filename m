Date: Thu, 27 Aug 2015 11:12:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150827091217.GB20679@hermes.click-hack.org>
References: <1440608463-31708-1-git-send-email-henning.schild@siemens.com>
 <55DE0659.9050803@siemens.com> <20150827104248.4e4f821e@md1em3qc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150827104248.4e4f821e@md1em3qc>
Subject: Re: [Xenomai] [PATCH] x86/ipipe: reserve irq num we use for
 IRQ_MOVE_CLEANUP_VECTOR
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On Thu, Aug 27, 2015 at 10:42:48AM +0200, Henning Schild wrote:
> On Wed, 26 Aug 2015 20:32:57 +0200
> Jan Kiszka <jan.kiszka@siemens.com> wrote:
> 
> > On 2015-08-26 19:01, Henning Schild wrote:
> > > vector_irq must not contain the same irq number for two different
> > > vectors because ipipe dispatches based on irq numbers.
> > > For the special case of IRQ_MOVE_CLEANUP_VECTOR, the ipipe patch
> > > inserts a new entry in vector_irq. To ensure the required uniqueness
> > > we have to make sure Linux will never make a vector point to irq
> > > number IRQ_MOVE_CLEANUP_VECTOR.
> > > 
> > > Before that patch ipipe did dispatch device interrupts that
> > > happened to receive number 32 (IRQ_MOVE_CLEANUP_VECTOR) to the
> > > cleanup function, the device effectively lost its interrupts. Up to
> > > 3.18 that was no problem since the allocator did not hand out the
> > > number ipipe failed to reserve.
> > > 
> > > Signed-off-by: Henning Schild <henning.schild@siemens.com>
> > > ---
> > >  arch/x86/kernel/irqinit.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/arch/x86/kernel/irqinit.c b/arch/x86/kernel/irqinit.c
> > > index e850981..5ca0ec7 100644
> > > --- a/arch/x86/kernel/irqinit.c
> > > +++ b/arch/x86/kernel/irqinit.c
> > > @@ -143,9 +143,12 @@ static void __init smp_intr_init(void)
> > >  	/* Low priority IPI to cleanup after moving an irq */
> > >  	set_intr_gate(IRQ_MOVE_CLEANUP_VECTOR,
> > > irq_move_cleanup_interrupt); set_bit(IRQ_MOVE_CLEANUP_VECTOR,
> > > used_vectors); +#ifdef CONFIG_IPIPE
> > > +	BUG_ON(IRQ_MOVE_CLEANUP_VECTOR !=
> > > irq_alloc_descs(IRQ_MOVE_CLEANUP_VECTOR, 0, 1, 0));
> > > for_each_possible_cpu(cpu) per_cpu(vector_irq,
> > > cpu)[IRQ_MOVE_CLEANUP_VECTOR] = IRQ_MOVE_CLEANUP_VECTOR;
> > > +#endif
> > 
> > Looks like you picked up the instrumentation hunk instead of the
> > actual fix. ;)
> 
> Does it? No that is the fix. Alloc the irq number before using it and
> BUG if that fails.

BUG is like an assert: disabling CONFIG_BUG should not change the
behaviour.

-- 
					    Gilles.
https://click-hack.org

