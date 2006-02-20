Message-ID: <b647ffbd0602200840v5f066d0bv@domain.hid>
Date: Mon, 20 Feb 2006 18:40:29 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] Re: [PATCH] Shared interrupts (ready to merge)
In-Reply-To: <43F9C9C1.60101@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_2813_19046561.1140453629802"
References: <b647ffbd0602150939g59256b2bx@domain.hid>
	<b647ffbd0602160220we254aacx@domain.hid> <43F47705.90309@domain.hid>
	<b647ffbd0602160558i4112313an@domain.hid>
	<43F48832.7060804@domain.hid>
	<b647ffbd0602161128t70d1f08ax@domain.hid>
	<43F4E2D3.4010705@domain.hid>
	<b647ffbd0602181204u518296fev@domain.hid>
	<43F793AF.4080805@domain.hid> <43F9C9C1.60101@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

------=_Part_2813_19046561.1140453629802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

N.B. Amongst other things, some thoughts about CHAINED with shared
interrupts.


On 20/02/06, Anders Blomdell <anders.blomdell@domain.hid> wrote:



> A number of questions arise:
>
> 1. What happens if one of the shared handlers leaves the interrupt
> asserted,
> returns NOENABLE|HANDLED and another return only HANDLED?
>
> 2. What happens if one returns PROPAGATE and another returns HANDLED?


Yep, each ISR may return a different value and all of them are
accumulated in the "s" variable ( s |=3D intr->isr(intr); ).

So the loop may end up with "s" which contains all of the possible bits:

(e.g.

isr1 - HANDLED | ENABLE
isr2 - HANDLED (don't want the irq to be enabled)
isr3 - CHAINED

)

s =3D HANDLED | ENABLE | CHAINED;

Then CHAINED will be ignored because of the following code :

+    if (s & XN_ISR_ENABLE)
+       xnarch_end_irq(irq);
+    else if (s & XN_ISR_CHAINED)    (*)
+       xnarch_chain_irq(irq);

the current code in the CVS doen not contain "else" in (*), so that ENABLE =
|
CHAINED is possible, though it's a wrong combination.

This said, we suppose that one knows what he is doing.

In the case of a single ISR per line, it's not that difficult to achieve.
But if there are a few ISRs, then one should analize and take into account
all possible return values of all the ISRs, as each of them may affect
others (e.g. if one returns CHAINED when another - HANDLED | ENABLE).

So my feeling is that CHAINED should not be used by drivers which registere=
d
their ISRs as SHARED.

Moreover, I actually see the only scenario of CHAINED (I provided it before=
)
:

all ISRs in the primary domain have reported UNHANDLED  =3D>  nucleus
propagates the interrupt down the pipeline with xnacrh_chain_irq().
This call actually returns 1 upon successful propagation (some domain down
the pipeline was interested in this irq) and 0 otherwise.

Upon 0, this is a spurious irq (none of domains was interested in its
handling).

ok, let's suppose now :

we have 2 ISRs on the same shared line :

isr1 : HANDLED (will be enabled by rt task. Note, rt task must call
xnarch_end_irq() and not just xnarch_enable_irq()! )

isr2 : CHAINED

So HANDLED | CHAINED is ok for the single ISR on the line, but it may lead
to HANDLED | CHAINED | ENABLE in a case of the shared line.

rt task that works jointly with isr1 just calls xnarch_end_irq() at some
moment of time and some ISR in the linux domain does the same later  =3D>  =
the
line is .end-ed 2 times.

ISR should never return CHAINED as to indicate _only_ that it is not
interested in this irq, but ~HANDLED or NOINT (if we'll support it) instead=
.

If the ISR nevertheless wants to propagate the IRQ to the Linux domain
_explicitly_, it _must not_ register itself as SHARED, i.e. it _must_ be th=
e
only ISR on this line, otherwise that may lead to the IRQ line being .end-e=
d
twice (lost interrupts in some cases).


#define UNHANDLED 0
> #define HANDLED_ENABLE 1
> #define HANDLED_NOENABLE 2
> #define PROPAGATE 3


Yep, I'd agree with you. Moreover, PROPAGATE should not be used for shared
interrupts.


--
Best regards,
Dmitry Adamushko

------=_Part_2813_19046561.1140453629802
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>
N.B. Amongst other things, some thoughts about CHAINED with shared interrup=
ts.<br>
<br>
<br><div><span class=3D"gmail_quote">On 20/02/06, <b class=3D"gmail_sendern=
ame">Anders Blomdell</b> &lt;<a href=3D"mailto:anders.blomdell@domain.hid.=
se">anders.blomdell@domain.hid</a>&gt; wrote:<br>
<br>
<br>
</span><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rg=
b(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>A numb=
er of questions arise:<br><br>1. What happens if one of the shared handlers=
 leaves the interrupt asserted,
<br>returns NOENABLE|HANDLED and another return only HANDLED?<br><br>2. Wha=
t happens if one returns PROPAGATE and another returns HANDLED?</blockquote=
><div><br>
Yep, each ISR may return a different value and all of them are<br>
accumulated in the &quot;s&quot; variable ( s |=3D intr-&gt;isr(intr); ).<b=
r>
<br>
So the loop may end up with &quot;s&quot; which contains all of the possibl=
e bits:<br>
<br>
(e.g.<br>
<br>
isr1 - HANDLED | ENABLE<br>
isr2 - HANDLED (don't want the irq to be enabled)<br>
isr3 - CHAINED<br>
<br>
)<br>
<br>
s =3D HANDLED | ENABLE | CHAINED;<br>
</div><div><br>
Then CHAINED will be ignored because of the following code :<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp; if (s &amp; XN_ISR_ENABLE)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnarch_end_irq(irq);<br>
+&nbsp;&nbsp;&nbsp; else if (s &amp; XN_ISR_CHAINED)&nbsp;&nbsp;&nbsp; (*)<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnarch_chain_irq(irq);<br>
<br>
the current code in the CVS doen not contain &quot;else&quot; in (*), so th=
at
ENABLE | CHAINED is possible, though it's a wrong combination.<br>
<br>
This said, we suppose that one knows what he is doing.<br>
<br>
In the case of a single ISR per line, it's not that difficult to
achieve. But if there are a few ISRs, then one should analize and take
into account all possible return values of all the ISRs, as each of
them may affect others (e.g. if one returns CHAINED when another -
HANDLED | ENABLE).<br>
</div><br>
So my feeling is that CHAINED should not be used by drivers which registere=
d their ISRs as SHARED.<br>
<br>
Moreover, I actually see the only scenario of CHAINED (I provided it before=
) :<br>
<br>
all ISRs in the primary domain have reported UNHANDLED&nbsp;
=3D&gt;&nbsp; nucleus propagates the interrupt down the pipeline with
xnacrh_chain_irq().<br>
This call actually returns 1 upon successful propagation (some domain
down the pipeline was interested in this irq) and 0 otherwise.<br>
<br>
Upon 0, this is a spurious irq (none of domains was interested in its handl=
ing).<br>
<br>
ok, let's suppose now :<br>
<br>
we have 2 ISRs on the same shared line :<br>
<br>
isr1 : HANDLED (will be enabled by rt task. Note, rt task must call xnarch_=
end_irq() and not just xnarch_enable_irq()! )<br>
<br>
isr2 : CHAINED <br>
<br>
So HANDLED | CHAINED is ok for the single ISR on the line, but it may
lead to HANDLED | CHAINED | ENABLE in a case of the shared line.<br>
<br>
rt task that works jointly with isr1 just calls xnarch_end_irq() at
some moment of time and some ISR in the linux domain does the same
later&nbsp; =3D&gt;&nbsp; the line is .end-ed 2 times.<br>
<br>
ISR should never return CHAINED as to indicate _only_ that it is not
interested in this irq, but ~HANDLED or NOINT (if we'll support it)
instead.<br>
<br>
If the ISR nevertheless wants to propagate the IRQ to the Linux domain
_explicitly_, it _must not_ register itself as SHARED, i.e. it _must_
be the only ISR on this line, otherwise that may lead to the IRQ line
being .end-ed twice (lost interrupts in some cases).<br>
<br>
<br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(2=
04, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">#define UNHAN=
DLED 0<br>#define HANDLED_ENABLE 1<br>#define HANDLED_NOENABLE 2<br>#define=
 PROPAGATE 3
</blockquote><div><br>
Yep, I'd agree with you. Moreover, PROPAGATE should not be used for shared =
interrupts.<br>
&nbsp;</div></div><br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_2813_19046561.1140453629802--

