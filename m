Message-ID: <b647ffbd0602210254p19086a0au@domain.hid>
Date: Tue, 21 Feb 2006 12:54:24 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] Re: [PATCH] Shared interrupts (ready to merge)
In-Reply-To: <43FAD322.4060001@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_12485_13732239.1140519264889"
References: <b647ffbd0602150939g59256b2bx@domain.hid>
	<b647ffbd0602160558i4112313an@domain.hid>
	<43F48832.7060804@domain.hid>
	<b647ffbd0602161128t70d1f08ax@domain.hid>
	<43F4E2D3.4010705@domain.hid>
	<b647ffbd0602181204u518296fev@domain.hid>
	<43F793AF.4080805@domain.hid> <43F9C9C1.60101@domain.hid>
	<b647ffbd0602200840v5f066d0bv@domain.hid>
	<43FAD322.4060001@domain.hid>
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
Cc: xenomai@xenomai.org

------=_Part_12485_13732239.1140519264889
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 21/02/06, Anders Blomdell <anders.blomdell@domain.hid> wrote:
>
> Dmitry Adamushko wrote:
> >
> > N.B. Amongst other things, some thoughts about CHAINED with shared
> > interrupts.
> >
> >
> > On 20/02/06, *Anders Blomdell* <anders.blomdell@domain.hid
> > <mailto:anders.blomdell@domain.hid>> wrote:
> >
> >
> >
> >     A number of questions arise:
> >
> >     1. What happens if one of the shared handlers leaves the interrupt
> >     asserted,
> >     returns NOENABLE|HANDLED and another return only HANDLED?
> >
> >     2. What happens if one returns PROPAGATE and another returns
> HANDLED?
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
> Which is the worst way possible of prioritizing them, if a Linux interrup=
t
> is
> active when we get there with ENABLE|CHAINED, interrupts will be enabled
> with
> the Linux interrupt still asserted -> the IRQ-handlers will be called onc=
e
> more,
> probably returning ENABLE|CHAINED again -> infinite loop...
>
> >
> > the current code in the CVS doen not contain "else" in (*), so that
> > ENABLE | CHAINED is possible, though it's a wrong combination.
> >
> > This said, we suppose that one knows what he is doing.
> >
> > In the case of a single ISR per line, it's not that difficult to
> > achieve. But if there are a few ISRs, then one should analize and take
> > into account all possible return values of all the ISRs, as each of the=
m
> > may affect others (e.g. if one returns CHAINED when another - HANDLED |
> > ENABLE).
> Which is somewhat contrary to the concept of shared interrupts, if we hav=
e
> to
> take care of the global picture, why make them shared in the first place?
> (I like the concept of shared interrupts, but it is important that the
> framework
> gives a separation of concerns)


Unfortunately, it looks to me that the current picture (even with your
scalar values) requires from the user who develops a given IRQ to take into
account the possible return values of other ISRs.

As I pointed out, the situation when 2 ISRs return HANDLED_NOENABLE may lea=
d
to problems on some archs.

---
> ...

I'll take a look at the rest of the message a bit later.


--
Best regards,
Dmitry Adamushko

------=_Part_12485_13732239.1140519264889
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><div><span class=3D"gmail_quote">On 21/02/06, <b class=3D"gmail_sendern=
ame">Anders Blomdell</b> &lt;<a href=3D"mailto:anders.blomdell@domain.hid.=
se">anders.blomdell@domain.hid</a>&gt; wrote:</span><blockquote class=
=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin=
: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Dmitry Adamushko wrote:<br>&gt;<br>&gt; N.B. Amongst other things, some tho=
ughts about CHAINED with shared<br>&gt; interrupts.<br>&gt;<br>&gt;<br>&gt;=
 On 20/02/06, *Anders Blomdell* &lt;<a href=3D"mailto:anders.blomdell@domain.hid=
ol.lth.se">
anders.blomdell@domain.hid</a><br>&gt; &lt;mailto:<a href=3D"mailto:and=
ers.blomdell@domain.hid">anders.blomdell@domain.hid</a>&gt;&gt; wro=
te:<br>&gt;<br>&gt;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; A number of que=
stions arise:<br>&gt;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; 1. What happens if one of the shared handl=
ers leaves the interrupt<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; asserted,<br>&gt;&=
nbsp;&nbsp;&nbsp;&nbsp; returns NOENABLE|HANDLED and another return only HA=
NDLED?<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; 2. What happens if one retur=
ns PROPAGATE and another returns HANDLED?
<br>&gt;<br>&gt;<br>&gt; Yep, each ISR may return a different value and all=
 of them are<br>&gt; accumulated in the &quot;s&quot; variable ( s |=3D int=
r-&gt;isr(intr); ).<br>&gt;<br>&gt; So the loop may end up with &quot;s&quo=
t; which contains all of the possible bits:
<br>&gt;<br>&gt; (e.g.<br>&gt;<br>&gt; isr1 - HANDLED | ENABLE<br>&gt; isr2=
 - HANDLED (don't want the irq to be enabled)<br>&gt; isr3 - CHAINED<br>&gt=
;<br>&gt; )<br>&gt;<br>&gt; s =3D HANDLED | ENABLE | CHAINED;<br>&gt;<br>
&gt; Then CHAINED will be ignored because of the following code :<br>&gt;<b=
r>&gt; +&nbsp;&nbsp;&nbsp;&nbsp;if (s &amp; XN_ISR_ENABLE)<br>&gt; +&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnarch_end_irq(irq);<br>&gt; +&nbsp;&nbsp;&nb=
sp;&nbsp;else if (s &amp; XN_ISR_CHAINED)&nbsp;&nbsp;&nbsp;&nbsp;(*)<br>&gt=
; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xnarch_chain_irq(irq);
<br>Which is the worst way possible of prioritizing them, if a Linux interr=
upt is<br>active when we get there with ENABLE|CHAINED, interrupts will be =
enabled with<br>the Linux interrupt still asserted -&gt; the IRQ-handlers w=
ill be called once more,
<br>probably returning ENABLE|CHAINED again -&gt; infinite loop...<br><br>&=
gt;<br>&gt; the current code in the CVS doen not contain &quot;else&quot; i=
n (*), so that<br>&gt; ENABLE | CHAINED is possible, though it's a wrong co=
mbination.
<br>&gt;<br>&gt; This said, we suppose that one knows what he is doing.<br>=
&gt;<br>&gt; In the case of a single ISR per line, it's not that difficult =
to<br>&gt; achieve. But if there are a few ISRs, then one should analize an=
d take
<br>&gt; into account all possible return values of all the ISRs, as each o=
f them<br>&gt; may affect others (e.g. if one returns CHAINED when another =
- HANDLED |<br>&gt; ENABLE).<br>Which is somewhat contrary to the concept o=
f shared interrupts, if we have to
<br>take care of the global picture, why make them shared in the first plac=
e?<br>(I like the concept of shared interrupts, but it is important that th=
e framework<br>gives a separation of concerns)</blockquote><div><br>
Unfortunately, it looks to me that the current picture (even with your
scalar values) requires from the user who develops a given IRQ to take
into account the possible return values of other ISRs.<br>
<br>
As I pointed out, the situation when 2 ISRs return HANDLED_NOENABLE may lea=
d to problems on some archs.<br>
<br>
---<br>
&gt; ...<br>
<br>
I'll take a look at the rest of the message a bit later.<br>
&nbsp;<br>
</div></div><br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_12485_13732239.1140519264889--

