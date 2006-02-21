Message-ID: <43FAFBF5.9060008@domain.hid>
Date: Tue, 21 Feb 2006 12:39:33 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [PATCH] Shared interrupts (ready to merge)
References: <b647ffbd0602150939g59256b2bx@domain.hid>	
	<b647ffbd0602160220we254aacx@domain.hid>
	<43F47705.90309@domain.hid>	
	<b647ffbd0602160558i4112313an@domain.hid>	
	<43F48832.7060804@domain.hid>	
	<b647ffbd0602161128t70d1f08ax@domain.hid>	
	<43F4E2D3.4010705@domain.hid>	
	<b647ffbd0602181204u518296fev@domain.hid>	
	<43F793AF.4080805@domain.hid> <43F9C9C1.60101@domain.hid>
	<b647ffbd0602200840v5f066d0bv@domain.hid>
In-Reply-To: <b647ffbd0602200840v5f066d0bv@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Dmitry Adamushko wrote:
> 
> N.B. Amongst other things, some thoughts about CHAINED with shared 
> interrupts.
> 
> 
> On 20/02/06, *Anders Blomdell* <anders.blomdell@domain.hid 
> <mailto:anders.blomdell@domain.hid>> wrote:
> 
> 
> 
>     A number of questions arise:
> 
>     1. What happens if one of the shared handlers leaves the interrupt
>     asserted,
>     returns NOENABLE|HANDLED and another return only HANDLED?
> 
>     2. What happens if one returns PROPAGATE and another returns HANDLED?
> 
> 
> Yep, each ISR may return a different value and all of them are
> accumulated in the "s" variable ( s |= intr->isr(intr); ).
> 
> So the loop may end up with "s" which contains all of the possible bits:
> 
> (e.g.
> 
> isr1 - HANDLED | ENABLE
> isr2 - HANDLED (don't want the irq to be enabled)
> isr3 - CHAINED
> 
> )
> 
> s = HANDLED | ENABLE | CHAINED;
> 
> Then CHAINED will be ignored because of the following code :
>  
> +    if (s & XN_ISR_ENABLE)
> +       xnarch_end_irq(irq);
> +    else if (s & XN_ISR_CHAINED)    (*)
> +       xnarch_chain_irq(irq);
Which is the worst way possible of prioritizing them, if a Linux interrupt is
active when we get there with ENABLE|CHAINED, interrupts will be enabled with
the Linux interrupt still asserted -> the IRQ-handlers will be called once more,
probably returning ENABLE|CHAINED again -> infinite loop...

> 
> the current code in the CVS doen not contain "else" in (*), so that 
> ENABLE | CHAINED is possible, though it's a wrong combination.
> 
> This said, we suppose that one knows what he is doing.
> 
> In the case of a single ISR per line, it's not that difficult to 
> achieve. But if there are a few ISRs, then one should analize and take 
> into account all possible return values of all the ISRs, as each of them 
> may affect others (e.g. if one returns CHAINED when another - HANDLED | 
> ENABLE).
Which is somewhat contrary to the concept of shared interrupts, if we have to
take care of the global picture, why make them shared in the first place?
(I like the concept of shared interrupts, but it is important that the framework
gives a separation of concerns)

> So my feeling is that CHAINED should not be used by drivers which 
> registered their ISRs as SHARED.
Well, CHAINED should not be used by drivers which return ENABLE (and are of
course hence incompatible with true realtime IRQ's)
> 
> Moreover, I actually see the only scenario of CHAINED (I provided it 
> before) :
> 
> all ISRs in the primary domain have reported UNHANDLED  =>  nucleus 
> propagates the interrupt down the pipeline with xnacrh_chain_irq().
> This call actually returns 1 upon successful propagation (some domain 
> down the pipeline was interested in this irq) and 0 otherwise.
> 
> Upon 0, this is a spurious irq (none of domains was interested in its 
> handling).
> 
> ok, let's suppose now :
> 
> we have 2 ISRs on the same shared line :
> 
> isr1 : HANDLED (will be enabled by rt task. Note, rt task must call 
> xnarch_end_irq() and not just xnarch_enable_irq()! )
> 
> isr2 : CHAINED
> 
> So HANDLED | CHAINED is ok for the single ISR on the line, but it may 
> lead to HANDLED | CHAINED | ENABLE in a case of the shared line.
> 
> rt task that works jointly with isr1 just calls xnarch_end_irq() at some 
> moment of time and some ISR in the linux domain does the same later  =>  
> the line is .end-ed 2 times.
> 
> ISR should never return CHAINED as to indicate _only_ that it is not 
> interested in this irq, but ~HANDLED or NOINT (if we'll support it) instead.
> 
> If the ISR nevertheless wants to propagate the IRQ to the Linux domain 
> _explicitly_, it _must not_ register itself as SHARED, i.e. it _must_ be 
> the only ISR on this line, otherwise that may lead to the IRQ line being 
> .end-ed twice (lost interrupts in some cases).
> 
> 
>     #define UNHANDLED 0
>     #define HANDLED_ENABLE 1
>     #define HANDLED_NOENABLE 2
>     #define PROPAGATE 3 
> 
> 
> Yep, I'd agree with you. Moreover, PROPAGATE should not be used for 
> shared interrupts.
My feeling is that it should be considered an error to attach a RT IRQ handler
to a line that has a Linux IRQ handler (this should be possible to check, since
/proc/interrupts contains the relevant information), unless a "Linux IRQ-mask"
function is installed. This IRQ-mask function should the be called:

   1. each time domains are switched
   2. each time an interrupt is generated

The IRQ-mask function should look something like:

unsigned int rt_irq_mask(struct ipipe_domain *ipd, unsigned int irq)
{
   int result = 0;
   static int enabled = true;
   int enable = enabled;

   if (irq >= 0) {
     // Interrupt has occured, we are about to run IRQ handlers
     if (disable_early) {
       enable = false;
     }
     if (for_linux(irq)) {
       result = XN_ISR_CHAINED;
     }
   } else if (ipd == ipipe_root_domain) {
     // Entering Linux
     enable = true;
   } else {
     // Other doamin, block linux interrupts
     enable = false;
   }
   if (enable != enabled) {
     enabled = enable
     if (enable) {
       // Enable Linux interrupts by unmasking appropriate
       // device registers (and possibly entire IRQ's)
     } else {
       // Disable Linux interrupts by masking appropriate
       // device registers (and possibly entire IRQ's)
     }
   }
   return result;
}

The advantages with this scheme is:

1. Linux interrupts are handled in one (platform specific) routine, and does not
clobber the RT IRQ-handlers, thus making it simpler to port a RT application to
a new platform: only the irq_mask funtion needs to be changed, i.e. separation
of concerns.

2. By setting disable_early and masking out all Linux IRQ's, the RT part only
needs to take the hit from one Linux interrupt even if they all occur.

-- 

Regards

Anders


