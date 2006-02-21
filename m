Message-ID: <43FB480E.9020808@domain.hid>
Date: Tue, 21 Feb 2006 18:04:14 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [PATCH] Shared interrupts (ready to merge)
References: <b647ffbd0602150939g59256b2bx@domain.hid>	
	<43F4E2D3.4010705@domain.hid>	
	<b647ffbd0602181204u518296fev@domain.hid>	
	<43F793AF.4080805@domain.hid> <43F9C9C1.60101@domain.hid>	
	<b647ffbd0602200840v5f066d0bv@domain.hid>	
	<43FAD322.4060001@domain.hid>	
	<b647ffbd0602210254p19086a0au@domain.hid>	
	<43FAF94C.4080709@domain.hid>	
	<43FAFE58.5060201@domain.hid>
	<b647ffbd0602210848g321ffedei@domain.hid>
In-Reply-To: <b647ffbd0602210848g321ffedei@domain.hid>
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
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

Dmitry Adamushko wrote:
> 
>  > Good point, leaves us with 2 possible return values for shared handlers:
>  >
>  >   HANDLED
>  >   NOT_HANDLED
>  >
>  > i.e. shared handlers should never defer the end'ing of the interrupt 
> (which
>  > makes sense, since this would affect the other [shared] handlers).
> 
> HANDLED_NOEBNABLE could be supported too. 
Yes, but it breaks decoupling between shared handlers; interrupts will be 
deferred for all [shared] handlers until it is properly ended.

> There would be no need in 
> reenventing
> a wheel, just do it the way Linux does it.
> But it's about some additional re-designing of the current codebase
> (e.g. nested calling for irq_enable/disable())
> I'm not sure we do need it for something else rather than irq sharing 
> code but it affects the rest of the code.
> 
> And we have a kind of wrong concept :
> 
> XN_ISR_ENABLE (or NOENABLE) corresponds to xnarch_end_irq().
Agree

> 
> But the later one is not only about enabling the line, but
> on some archs - about .end-ing it too (sending EOI).
> 
> And to support HANDLED_NOENABLE properly, those 2 have to be decoupled, i.e.
> EOI should always be sent from xnintr_shirq_handler().
But the one returning HANDLED_NOENABLE is likely to leave the interrupt 
asserted, hence we can't EOI at this point (unless NO_ENABLE means DISABLE).

> 
>  > Yes, "should". And this "should" is best be handled by
>  >
>  > a) Documenting the potential conflict in the same place when describing
>  > the return values
>  >
>  > b) Placing some debug warning in the nucleus' IRQ trampoline function to
>  > bail out (once per line) when running into such situation
>  >
>  > But I'm against any further runtime restrictions, especially as most
>  > drivers will never return anything else than NOT_HANDLED or HANDLED.
>  > Actually, this was the reason why I tried to separate the NO_ENABLE and
>  > PROPAGATE features as *additional* bits from HANDLED and
>  > NOT_HANDLED/UNHANDLED/NOINT. But I acknowledge that having all valid bit
>  > combination present as constants can be more helpful for the user. We
>  > just have to draw some line between the standard values and the
>  > additional gurus return codes
>  >
> (documentation: "don't use NO_ENABLE or
>  > PROPAGATE unless you understand their side-effects and pitfalls 
> precisely").
> 
> I agree with you on PROPAGATE case, but NO_ENABLE that, as pointed out 
> above,
> should (IMHO and at least, in theory) only mean "keep the IRQ line disabled"
> (and have nothing to do with .end-ing the IRQ line) would be better 
> supported.
> But this is, again as was pointed out above, about some redesigning of the
> current code => some overhead that likely affects non-shared aware code too.
> 
> 
> So on one hand,
> 
> I'm ready to re-work code with :
> 
> HANDLED and UNHANDLED (or NOINT)
> 
> + 2 additional bits : NOENABLE and PROPAGATE.
> 
> and document it like you suggested "don't use NO_ENABLE or
> PROPAGATE with shared interrupts
> unless you understand their side-effects and pitfalls precisely";
> 
> on the other hand,
> 
> I'd say that I'm almost ready to vote against merging the irq sharing 
> code at all as it looks to be a rather partial solution.
I vote for (even though I'm the one who complains the most), BUT I think it is 
important to keep the rules for using it simple (that's why I worry about the 
plethora of return-flags).


-- 

Regards

Anders

