Message-ID: <b647ffbd0602210245p4dcdd2f4q@domain.hid>
Date: Tue, 21 Feb 2006 12:45:24 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] Re: [PATCH] Shared interrupts (ready to merge)
In-Reply-To: <43FAD26C.2030904@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_12377_2146405.1140518724654"
References: <b647ffbd0602150939g59256b2bx@domain.hid>
	<b647ffbd0602160558i4112313an@domain.hid>
	<43F48832.7060804@domain.hid>
	<b647ffbd0602161128t70d1f08ax@domain.hid>
	<43F4E2D3.4010705@domain.hid>
	<b647ffbd0602181204u518296fev@domain.hid>
	<43F793AF.4080805@domain.hid> <43F9C9C1.60101@domain.hid>
	<b647ffbd0602200840v5f066d0bv@domain.hid>
	<43FAD26C.2030904@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_12377_2146405.1140518724654
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 21/02/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Dmitry Adamushko wrote:
> > N.B. Amongst other things, some thoughts about CHAINED with shared
> > interrupts.
> >
> >
> > On 20/02/06, Anders Blomdell <anders.blomdell@domain.hid> wrote:
> >
> >
> >
> >> A number of questions arise:
> >>
> >> 1. What happens if one of the shared handlers leaves the interrupt
> >> asserted,
> >> returns NOENABLE|HANDLED and another return only HANDLED?
> >>
> >> 2. What happens if one returns PROPAGATE and another returns HANDLED?
> >
> >
> > Yep, each ISR may return a different value and all of them are
> > accumulated in the "s" variable ( s |=3D intr->isr(intr); ).
> >
> > So the loop may end up with "s" which contains all of the possible bits=
:
> >
> > (e.g.
> >
> > isr1 - HANDLED | ENABLE
> > isr2 - HANDLED (don't want the irq to be enabled)
> > isr3 - CHAINED
> >
> > )
> >
> > s =3D HANDLED | ENABLE | CHAINED;
> >
> > Then CHAINED will be ignored because of the following code :
> >
> > +    if (s & XN_ISR_ENABLE)
> > +       xnarch_end_irq(irq);
> > +    else if (s & XN_ISR_CHAINED)    (*)
> > +       xnarch_chain_irq(irq);
>
> Which may actually be fatal: consider one ISR intentionally not handling
> an IRQ but propagating it while another ISR thinks it has to re-enable
> it - bang! Anders' as well as my original suggestion were to ignore the
> ENABLE in this case.
>
> >
> > the current code in the CVS doen not contain "else" in (*), so that
> ENABLE |
> > CHAINED is possible, though it's a wrong combination.
> >
> > This said, we suppose that one knows what he is doing.
> >
> > In the case of a single ISR per line, it's not that difficult to
> achieve.
> > But if there are a few ISRs, then one should analize and take into
> account
> > all possible return values of all the ISRs, as each of them may affect
> > others (e.g. if one returns CHAINED when another - HANDLED | ENABLE).
> >
> > So my feeling is that CHAINED should not be used by drivers which
> registered
> > their ISRs as SHARED.
>
> That's true for standard drivers, but we should not prevent special
> corner-case designs which can be tuned to make even shared RT-IRQs +
> propagation possible. Sharing does not necessarily mean that different
> RT drivers are involved...


Yep.  But in this case the designer of the system should _care_ about all
corners of the system, i.e. to make sure that all ISRs return values which
are not contradictory to each other.

e.g.

1)
isr1 : HANDLED (keep disabled)
isr2 : CHAINED

or

2)
isr1 : HANDLED | NOENABLE (will be enabled by rt_task1)
isr2 : HANDLED | NOENABLE (-//- by rt_task2)

1) and 2) are wrong! Both lead to the IRQ line being .end-ed
(xnarch_end_irq()) twice! And on some archs, as we have seen before, that
may lead to lost interrupts.

Of course, when designing the real-time system, one should take charge of
all corners of the system, so that analyzing the possible return values of
all other ISRs that may share the same IRQ line is not anything extravagant=
,
but a requirement.

This said, I see no reason then why we should prevent users
from some cases (like CHAINED | ENABLE) and let him do the ones like 2).
2) is much more common scenario for irq sharing and looks sane  from the
point of view of a separate ISR, when the global picture (and nucleus
innards) is not taken into account.

p.s.
my 2) is equal to 2 ISRs returning HANDLED_NOENABLE in terms of Anders. Thi=
s
case is one of the most common with shared interrupts which I would imagine=
.
And it nevertheless leads to problems when the whole picture is not taken
into account by the designer of a given ISR.


>
> Moreover, I actually see the only scenario of CHAINED (I provided it
before)
> :
>
> all ISRs in the primary domain have reported UNHANDLED  =3D>  nucleus
> propagates the interrupt down the pipeline with xnacrh_chain_irq().
> This call actually returns 1 upon successful propagation (some domain dow=
n
> the pipeline was interested in this irq) and 0 otherwise.

>But this only means that some handler is registered down there,
> it
>cannot predict if that handler will actually care about the event.

Linux (not only vanilla, but ipipe-aware too) always .end-s (calls
desc->handler->end(irq)) on return from __do_IRQ(), no matter this interrup=
t
was handled by some ISR or not. It also re-enables the IRQ line if it was
not disabled by some ISR explicitly.
We don't care about anything else.



> Jan
>
>
>

--
Best regards,
Dmitry Adamushko

------=_Part_12377_2146405.1140518724654
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>
<div><span class=3D"gmail_quote">On 21/02/06, <b class=3D"gmail_sendername"=
>Jan Kiszka</b> &lt;<a href=3D"mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid<=
/a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-left=
: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1e=
x;">
Dmitry Adamushko wrote:<br>&gt; N.B. Amongst other things, some thoughts ab=
out CHAINED with shared<br>&gt; interrupts.<br>&gt;<br>&gt;<br>&gt; On 20/0=
2/06, Anders Blomdell &lt;<a href=3D"mailto:anders.blomdell@domain.hid"=
>
anders.blomdell@domain.hid</a>&gt; wrote:<br>&gt;<br>&gt;<br>&gt;<br>&g=
t;&gt; A number of questions arise:<br>&gt;&gt;<br>&gt;&gt; 1. What happens=
 if one of the shared handlers leaves the interrupt<br>&gt;&gt; asserted,
<br>&gt;&gt; returns NOENABLE|HANDLED and another return only HANDLED?<br>&=
gt;&gt;<br>&gt;&gt; 2. What happens if one returns PROPAGATE and another re=
turns HANDLED?<br>&gt;<br>&gt;<br>&gt; Yep, each ISR may return a different=
 value and all of them are
<br>&gt; accumulated in the &quot;s&quot; variable ( s |=3D intr-&gt;isr(in=
tr); ).<br>&gt;<br>&gt; So the loop may end up with &quot;s&quot; which con=
tains all of the possible bits:<br>&gt;<br>&gt; (e.g.<br>&gt;<br>&gt; isr1 =
- HANDLED | ENABLE
<br>&gt; isr2 - HANDLED (don't want the irq to be enabled)<br>&gt; isr3 - C=
HAINED<br>&gt;<br>&gt; )<br>&gt;<br>&gt; s =3D HANDLED | ENABLE | CHAINED;<=
br>&gt;<br>&gt; Then CHAINED will be ignored because of the following code =
:
<br>&gt;<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;if (s &amp; XN_ISR_ENABLE)<br>&gt=
; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnarch_end_irq(irq);<br>&gt; +&nbsp=
;&nbsp;&nbsp;&nbsp;else if (s &amp; XN_ISR_CHAINED)&nbsp;&nbsp;&nbsp;&nbsp;=
(*)<br>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnarch_chain_irq(irq);<br=
><br>Which may actually be fatal: consider one ISR intentionally not handli=
ng
<br>an IRQ but propagating it while another ISR thinks it has to re-enable<=
br>it - bang! Anders' as well as my original suggestion were to ignore the<=
br>ENABLE in this case.<br><br>&gt;<br>&gt; the current code in the CVS doe=
n not contain &quot;else&quot; in (*), so that ENABLE |
<br>&gt; CHAINED is possible, though it's a wrong combination.<br>&gt;<br>&=
gt; This said, we suppose that one knows what he is doing.<br>&gt;<br>&gt; =
In the case of a single ISR per line, it's not that difficult to achieve.
<br>&gt; But if there are a few ISRs, then one should analize and take into=
 account<br>&gt; all possible return values of all the ISRs, as each of the=
m may affect<br>&gt; others (e.g. if one returns CHAINED when another - HAN=
DLED | ENABLE).
<br>&gt;<br>&gt; So my feeling is that CHAINED should not be used by driver=
s which registered<br>&gt; their ISRs as SHARED.<br><br>That's true for sta=
ndard drivers, but we should not prevent special<br>corner-case designs whi=
ch can be tuned to make even shared RT-IRQs +
<br>propagation possible. Sharing does not necessarily mean that different<=
br>RT drivers are involved...</blockquote><div><br>
Yep.&nbsp; But in this case the designer of the system should _care_
about all corners of the system, i.e. to make sure that all ISRs return
values which are not contradictory to each other.<br>
<br>
e.g.<br>
<br>
1)<br>
isr1 : HANDLED (keep disabled)<br>
isr2 : CHAINED<br>
<br>
or<br>
<br>
2)<br>
isr1 : HANDLED | NOENABLE (will be enabled by rt_task1)<br>
isr2 : HANDLED | NOENABLE (-//- by rt_task2)<br>
<br>
1) and 2) are wrong! Both lead to the IRQ line being .end-ed
(xnarch_end_irq()) twice! And on some archs, as we have seen before,
that may lead to lost interrupts. <br>
<br>
Of course, when designing the real-time system, one should take charge
of all corners of the system, so that analyzing the possible return
values of all other ISRs that may share the same IRQ line is not
anything extravagant, but a requirement.<br>
<br>
This said, I see no reason then why we should prevent users <br>
from some cases (like CHAINED | ENABLE) and let him do the ones like 2).<br=
>
2) is much more common scenario for irq sharing and looks sane&nbsp;
from the point of view of a separate ISR, when the global picture (and
nucleus innards) is not taken into account.<br>
<br>
p.s.<br>
my 2) is equal to 2 ISRs returning HANDLED_NOENABLE in terms of Anders.
This case is one of the most common with shared interrupts which I
would imagine. And it nevertheless leads to problems when the whole
picture is not taken into account by the designer of a given ISR.<br>
<br>
<span class=3D"q"><br>
&gt;<br>&gt; Moreover, I actually see the only scenario of CHAINED (I provi=
ded it before)<br>&gt; :<br>&gt;<br>&gt; all ISRs in the primary domain hav=
e reported UNHANDLED &nbsp;=3D&gt; &nbsp;nucleus<br>&gt; propagates the int=
errupt down the pipeline with xnacrh_chain_irq().
<br>&gt; This call actually returns 1 upon successful propagation (some dom=
ain down<br>&gt; the pipeline was interested in this irq) and 0 otherwise.<=
br><br></span><span class=3D"q">&gt;</span>But this only means that some ha=
ndler is registered down there,
<span class=3D"q"><br>
&gt;</span> it<br>
<span class=3D"q">&gt;</span>cannot predict if that handler will actually c=
are about the event.<br>
<br>
Linux (not only vanilla, but ipipe-aware too) always .end-s (calls
desc-&gt;handler-&gt;end(irq)) on return from __do_IRQ(), no matter
this interrupt was handled by some ISR or not. It also re-enables the
IRQ line if it was not disabled by some ISR explicitly.<br>
We don't care about anything else.<br>
<br>
<br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>Jan<br>=
<br><br>
</blockquote></div><br clear=3D"all"><br>-- <br>Best regards,<br>Dmitry Ada=
mushko

------=_Part_12377_2146405.1140518724654--

