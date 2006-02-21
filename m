Message-ID: <43FAF94C.4080709@domain.hid>
Date: Tue, 21 Feb 2006 12:28:12 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [PATCH] Shared interrupts (ready to merge)
References: <b647ffbd0602150939g59256b2bx@domain.hid>	
	<b647ffbd0602160558i4112313an@domain.hid>	
	<43F48832.7060804@domain.hid>	
	<b647ffbd0602161128t70d1f08ax@domain.hid>	
	<43F4E2D3.4010705@domain.hid>	
	<b647ffbd0602181204u518296fev@domain.hid>	
	<43F793AF.4080805@domain.hid> <43F9C9C1.60101@domain.hid>	
	<b647ffbd0602200840v5f066d0bv@domain.hid>	
	<43FAD322.4060001@domain.hid>
	<b647ffbd0602210254p19086a0au@domain.hid>
In-Reply-To: <b647ffbd0602210254p19086a0au@domain.hid>
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
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>, xenomai@xenomai.org

Dmitry Adamushko wrote:
> 
> On 21/02/06, *Anders Blomdell* <anders.blomdell@domain.hid 
> <mailto:anders.blomdell@domain.hid>> wrote:
> 
>     Dmitry Adamushko wrote:
>      >
>      > N.B. Amongst other things, some thoughts about CHAINED with shared
>      > interrupts.
>      >
>      >
>      > On 20/02/06, *Anders Blomdell* < anders.blomdell@domain.hid
>     <mailto:anders.blomdell@domain.hid>
>      > <mailto:anders.blomdell@domain.hid
>     <mailto:anders.blomdell@domain.hid>>> wrote:
>      >
>      >
>      >
>      >     A number of questions arise:
>      >
>      >     1. What happens if one of the shared handlers leaves the
>     interrupt
>      >     asserted,
>      >     returns NOENABLE|HANDLED and another return only HANDLED?
>      >
>      >     2. What happens if one returns PROPAGATE and another returns
>     HANDLED?
>      >
>      >
>      > Yep, each ISR may return a different value and all of them are
>      > accumulated in the "s" variable ( s |= intr->isr(intr); ).
>      >
>      > So the loop may end up with "s" which contains all of the
>     possible bits:
>      >
>      > (e.g.
>      >
>      > isr1 - HANDLED | ENABLE
>      > isr2 - HANDLED (don't want the irq to be enabled)
>      > isr3 - CHAINED
>      >
>      > )
>      >
>      > s = HANDLED | ENABLE | CHAINED;
>      >
>      > Then CHAINED will be ignored because of the following code :
>      >
>      > +    if (s & XN_ISR_ENABLE)
>      > +       xnarch_end_irq(irq);
>      > +    else if (s & XN_ISR_CHAINED)    (*)
>      > +       xnarch_chain_irq(irq);
>     Which is the worst way possible of prioritizing them, if a Linux
>     interrupt is
>     active when we get there with ENABLE|CHAINED, interrupts will be
>     enabled with
>     the Linux interrupt still asserted -> the IRQ-handlers will be
>     called once more,
>     probably returning ENABLE|CHAINED again -> infinite loop...
> 
>      >
>      > the current code in the CVS doen not contain "else" in (*), so that
>      > ENABLE | CHAINED is possible, though it's a wrong combination.
>      >
>      > This said, we suppose that one knows what he is doing.
>      >
>      > In the case of a single ISR per line, it's not that difficult to
>      > achieve. But if there are a few ISRs, then one should analize and
>     take
>      > into account all possible return values of all the ISRs, as each
>     of them
>      > may affect others (e.g. if one returns CHAINED when another -
>     HANDLED |
>      > ENABLE).
>     Which is somewhat contrary to the concept of shared interrupts, if
>     we have to
>     take care of the global picture, why make them shared in the first
>     place?
>     (I like the concept of shared interrupts, but it is important that
>     the framework
>     gives a separation of concerns)
> 
> 
> Unfortunately, it looks to me that the current picture (even with your 
> scalar values) requires from the user who develops a given IRQ to take 
> into account the possible return values of other ISRs.
> 
> As I pointed out, the situation when 2 ISRs return HANDLED_NOENABLE may 
> lead to problems on some archs.
Good point, leaves us with 2 possible return values for shared handlers:

   HANDLED
   NOT_HANDLED

i.e. shared handlers should never defer the end'ing of the interrupt (which 
makes sense, since this would affect the other [shared] handlers).

-- 
Anders

