Message-ID: <b647ffbd0602210848g321ffedei@domain.hid>
Date: Tue, 21 Feb 2006 18:48:50 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] Re: [PATCH] Shared interrupts (ready to merge)
In-Reply-To: <43FAFE58.5060201@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_15956_28632741.1140540530511"
References: <b647ffbd0602150939g59256b2bx@domain.hid>
	<43F4E2D3.4010705@domain.hid>
	<b647ffbd0602181204u518296fev@domain.hid>
	<43F793AF.4080805@domain.hid> <43F9C9C1.60101@domain.hid>
	<b647ffbd0602200840v5f066d0bv@domain.hid>
	<43FAD322.4060001@domain.hid>
	<b647ffbd0602210254p19086a0au@domain.hid>
	<43FAF94C.4080709@domain.hid>
	<43FAFE58.5060201@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_15956_28632741.1140540530511
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> Good point, leaves us with 2 possible return values for shared handlers:
>
>   HANDLED
>   NOT_HANDLED
>
> i.e. shared handlers should never defer the end'ing of the interrupt
(which
> makes sense, since this would affect the other [shared] handlers).

HANDLED_NOEBNABLE could be supported too. There would be no need in
reenventing
a wheel, just do it the way Linux does it.
But it's about some additional re-designing of the current codebase
(e.g. nested calling for irq_enable/disable())
I'm not sure we do need it for something else rather than irq sharing code
but it affects the rest of the code.

And we have a kind of wrong concept :

XN_ISR_ENABLE (or NOENABLE) corresponds to xnarch_end_irq().

But the later one is not only about enabling the line, but
on some archs - about .end-ing it too (sending EOI).

And to support HANDLED_NOENABLE properly, those 2 have to be decoupled, i.e=
.
EOI should always be sent from xnintr_shirq_handler().

> Yes, "should". And this "should" is best be handled by
>
> a) Documenting the potential conflict in the same place when describing
> the return values
>
> b) Placing some debug warning in the nucleus' IRQ trampoline function to
> bail out (once per line) when running into such situation
>
> But I'm against any further runtime restrictions, especially as most
> drivers will never return anything else than NOT_HANDLED or HANDLED.
> Actually, this was the reason why I tried to separate the NO_ENABLE and
> PROPAGATE features as *additional* bits from HANDLED and
> NOT_HANDLED/UNHANDLED/NOINT. But I acknowledge that having all valid bit
> combination present as constants can be more helpful for the user. We
> just have to draw some line between the standard values and the
> additional gurus return codes
>
(documentation: "don't use NO_ENABLE or
> PROPAGATE unless you understand their side-effects and pitfalls
precisely").

I agree with you on PROPAGATE case, but NO_ENABLE that, as pointed out
above,
should (IMHO and at least, in theory) only mean "keep the IRQ line disabled=
"
(and have nothing to do with .end-ing the IRQ line) would be better
supported.
But this is, again as was pointed out above, about some redesigning of the
current code =3D> some overhead that likely affects non-shared aware code t=
oo.


So on one hand,

I'm ready to re-work code with :

HANDLED and UNHANDLED (or NOINT)

+ 2 additional bits : NOENABLE and PROPAGATE.

and document it like you suggested "don't use NO_ENABLE or
PROPAGATE with shared interrupts
unless you understand their side-effects and pitfalls precisely";

on the other hand,

I'd say that I'm almost ready to vote against merging the irq sharing code
at all as it looks to be a rather partial solution.


--
Best regards,
Dmitry Adamushko

------=_Part_15956_28632741.1140540530511
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>
&gt; Good point, leaves us with 2 possible return values for shared handler=
s:<br>
&gt; <br>
&gt;&nbsp;&nbsp; HANDLED<br>
&gt;&nbsp;&nbsp; NOT_HANDLED<br>
&gt; <br>
&gt; i.e. shared handlers should never defer the end'ing of the interrupt (=
which<br>
&gt; makes sense, since this would affect the other [shared] handlers).<br>
<br>
HANDLED_NOEBNABLE could be supported too. There would be no need in reenven=
ting<br>
a wheel, just do it the way Linux does it.<br>
But it's about some additional re-designing of the current codebase<br>
(e.g. nested calling for irq_enable/disable())<br>
I'm not sure we do need it for something else rather than irq sharing code =
but it affects the rest of the code.<br>
<br>
And we have a kind of wrong concept :<br>
<br>
XN_ISR_ENABLE (or NOENABLE) corresponds to xnarch_end_irq().<br>
<br>
But the later one is not only about enabling the line, but<br>
on some archs - about .end-ing it too (sending EOI).<br>
<br>
And to support HANDLED_NOENABLE properly, those 2 have to be decoupled, i.e=
.<br>
EOI should always be sent from xnintr_shirq_handler().<br>
<br>
&gt; Yes, &quot;should&quot;. And this &quot;should&quot; is best be handle=
d by<br>
&gt; <br>
&gt; a) Documenting the potential conflict in the same place when describin=
g<br>
&gt; the return values<br>
&gt; <br>
&gt; b) Placing some debug warning in the nucleus' IRQ trampoline function =
to<br>
&gt; bail out (once per line) when running into such situation<br>
&gt; <br>
&gt; But I'm against any further runtime restrictions, especially as most<b=
r>
&gt; drivers will never return anything else than NOT_HANDLED or HANDLED.<b=
r>
&gt; Actually, this was the reason why I tried to separate the NO_ENABLE an=
d<br>
&gt; PROPAGATE features as *additional* bits from HANDLED and<br>
&gt; NOT_HANDLED/UNHANDLED/NOINT. But I acknowledge that having all valid b=
it<br>
&gt; combination present as constants can be more helpful for the user. We<=
br>
&gt; just have to draw some line between the standard values and the<br>
&gt; additional gurus return codes <br>
&gt;<br>
(documentation: &quot;don't use NO_ENABLE or<br>
&gt; PROPAGATE unless you understand their side-effects and pitfalls precis=
ely&quot;).<br>
<br>
I agree with you on PROPAGATE case, but NO_ENABLE that, as pointed out abov=
e,<br>
should (IMHO and at least, in theory) only mean &quot;keep the IRQ line dis=
abled&quot;<br>
(and have nothing to do with .end-ing the IRQ line) would be better support=
ed.<br>
But this is, again as was pointed out above, about some redesigning of the<=
br>
current code =3D&gt; some overhead that likely affects non-shared aware cod=
e too.<br>
<br>
<br>
So on one hand,<br>
<br>
I'm ready to re-work code with :<br>
<br>
HANDLED and UNHANDLED (or NOINT)<br>
<br>
+ 2 additional bits : NOENABLE and PROPAGATE.<br>
<br>
and document it like you suggested &quot;don't use NO_ENABLE or<br>
PROPAGATE with shared interrupts <br>
unless you understand their side-effects and pitfalls precisely&quot;;<br>
<br>
on the other hand,<br>
<br>
I'd say that I'm almost ready to vote against merging the irq sharing code =
at all as it looks to be a rather partial solution.<br>
<br clear=3D"all"><br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_15956_28632741.1140540530511--

