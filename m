Message-ID: <b647ffbd0602130300y4114708fy@domain.hid>
Date: Mon, 13 Feb 2006 13:00:01 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
In-Reply-To: <43F03A1F.3040206@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_2305_14212477.1139828401009"
References: <b647ffbd0602070104s63275903q@domain.hid>
	<43E9CE95.3070806@domain.hid> <43EAFD8B.7020400@domain.hid>
	<43EB1279.3040902@domain.hid> <43EB1741.9080809@domain.hid>
	<b647ffbd0602090311x56dbc765x@domain.hid>
	<43EB63D7.2080507@domain.hid> <43EC9C5B.4030501@domain.hid>
	<b647ffbd0602110335u58e2d4cek@domain.hid>
	<43F03A1F.3040206@domain.hid>
Subject: [Xenomai-core] Re: More on Shared interrupts
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

------=_Part_2305_14212477.1139828401009
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 13/02/06, Anders Blomdell <anders.blomdell@domain.hid> wrote:
>
> Dmitry Adamushko wrote:
> >
> >  > >
> >  > >   irq K  | ----------- | ---o    |   // Linux only
> >  > >   ...
> >  > >   irq L  | ---o        |         |   // RT-only
> >  > >   ...
> >  > >   irq M  | ---o------- | ---o    |   // Shared between domains
> >  > >   ...
> >  > >   irq N  | ---o---o--- |         |   // Shared inside single domai=
n
> >  > >   ...
> >  > >   irq O  | ---o---o--- | ---o    |   // Shared between and inside
> > single
> >  > > domain
> >  > >
> >  > > Xenomai currently handles the K & L cases, Dmitrys patch addresses
> > the N
> >  > > case, with edge triggered interrupts the M (and O after Dmitry's
> patch)
> >  > > case(s) might be handled by returning RT_INTR_CHAINED |
> RT_INTR_ENABLE
> >  > >
> >  >
> >  > As you pointed out recently, using this combo for M (and thus O)
> > might also be
> >  > unsafe, e.g. causing some implementation to send eoi twice or more
> > (and the second
> >  > time while hw IRQs are off and the second IRQ is still pending) if
> > more than a
> >  > single domain ends the current interrupt. This said, I've never trie=
d
> > that
> >  > actually, but this does seem a bit optimistic to always expect a
> > proper behaviour
> >  > in this case (basically, it all depends on what "ending" the
> > interrupt means hw-wise).
> >
> >
> > Just to be sure I've got the things more or less clear. I feel there ar=
e
> > some holes in my understanding of the irq handling stuff, mainly
> hw-wise.
> >
> > x86 + i8259A.
> >
> > In this case, .end handler does nothing more than enabling the IRQ line=
.
> > The "eoi" is sent in .ack right after disabling the IRQ line.
> >
> > Let's suppose we have the "M" case ("O" makes no difference here).
> >
> > When the ISR handler in Linux domain gets control :
> >
> > - the IRQ line is ON (it was already .end-ed in the primary domain in
> case
> >   of XN_ISR_ENABLE | XN_ISR_CHAINED ).
> >
> > =3D=3D=3D
> >   Actually, it's possible to set IPIPE_PASS flag for
> >   the primary_domain.irqs[THIS_IRQ].control
> >   when THIS_IRQ is shared across domains. This way, there is no need
> >   to call propagate_irq() in xnintr_irq_handler(). Ok, it's not
> >   that important so far.
> > =3D=3D=3D
> >
> >   This is not how it happens when the IRQ is only handled in the
> >   Linux domain. But the ISR is still serialized (need not to be
> >   reentrant) because do_IRQ() takes care of it (by means
> >   of RUNNING and PENDING flags).
> >
> > So, I suppose, it's possible to use XN_ISR_ENABLE | XN_ISR_CHAINED in
> that
> > case?
> Yes, but only if you disable interrupts from the Linux device (i.e. via
> its
> control registers, not via the APIC), otherwise the RT-handler will spin
> since
> the interrupt will never get deasserted. Then you are faced with finding
> some
> place to reenble those interrupts right after the Linux interrupts-handle=
r
> has run.


Thanks. I'm just missing what really happens between PIC and hw devices at
the time of CPU <--> PIC communication. Now it becomes clearer, nevertheles=
s
I have to find some good hw-related overview (tried but failed so far).



--
> Best regards
>
> Anders Blomdell
>


--
Best regards,
Dmitry Adamushko

------=_Part_2305_14212477.1139828401009
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><div><span class=3D"gmail_quote">On 13/02/06, <b class=3D"gmail_sendern=
ame">Anders Blomdell</b> &lt;<a href=3D"mailto:anders.blomdell@domain.hid.=
se">anders.blomdell@domain.hid</a>&gt; wrote:</span><blockquote class=
=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin=
: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Dmitry Adamushko wrote:<br>&gt;<br>&gt;&nbsp;&nbsp;&gt; &gt;<br>&gt;&nbsp;&=
nbsp;&gt; &gt;&nbsp;&nbsp; irq K&nbsp;&nbsp;| ----------- | ---o&nbsp;&nbsp=
;&nbsp;&nbsp;|&nbsp;&nbsp; // Linux only<br>&gt;&nbsp;&nbsp;&gt; &gt;&nbsp;=
&nbsp; ...<br>&gt;&nbsp;&nbsp;&gt;
&gt;&nbsp;&nbsp; irq L&nbsp;&nbsp;|
---o&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;
|&nbsp;&nbsp; // RT-only<br>&gt;&nbsp;&nbsp;&gt; &gt;&nbsp;&nbsp; ...<br>&g=
t;&nbsp;&nbsp;&gt;
&gt;&nbsp;&nbsp; irq M&nbsp;&nbsp;| ---o------- |
---o&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp; // Shared between domains<br>&gt;=
&nbsp;&nbsp;&gt; &gt;&nbsp;&nbsp; ...<br>&gt;&nbsp;&nbsp;&gt;
&gt;&nbsp;&nbsp; irq N&nbsp;&nbsp;| ---o---o---
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; //
Shared inside single domain<br>&gt;&nbsp;&nbsp;&gt; &gt;&nbsp;&nbsp; ...<br=
>&gt;&nbsp;&nbsp;&gt;
&gt;&nbsp;&nbsp; irq O&nbsp;&nbsp;| ---o---o--- |
---o&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp; // Shared between and inside<br>&=
gt; single<br>&gt;&nbsp;&nbsp;&gt; &gt; domain<br>&gt;&nbsp;&nbsp;&gt; &gt;=
<br>&gt;&nbsp;&nbsp;&gt; &gt; Xenomai currently handles the K &amp; L cases=
, Dmitrys patch addresses<br>&gt; the N<br>&gt;&nbsp;&nbsp;&gt; &gt; case, =
with edge triggered interrupts the M (and O after Dmitry's patch)
<br>&gt;&nbsp;&nbsp;&gt; &gt; case(s) might be handled by returning RT_INTR=
_CHAINED | RT_INTR_ENABLE<br>&gt;&nbsp;&nbsp;&gt; &gt;<br>&gt;&nbsp;&nbsp;&=
gt;<br>&gt;&nbsp;&nbsp;&gt; As you pointed out recently, using this combo f=
or M (and thus O)<br>&gt; might also be
<br>&gt;&nbsp;&nbsp;&gt; unsafe, e.g. causing some implementation to send e=
oi twice or more<br>&gt; (and the second<br>&gt;&nbsp;&nbsp;&gt; time while=
 hw IRQs are off and the second IRQ is still pending) if<br>&gt; more than =
a<br>&gt;&nbsp;&nbsp;&gt; single domain ends the current interrupt. This sa=
id, I've never tried
<br>&gt; that<br>&gt;&nbsp;&nbsp;&gt; actually, but this does seem a bit op=
timistic to always expect a<br>&gt; proper behaviour<br>&gt;&nbsp;&nbsp;&gt=
; in this case (basically, it all depends on what &quot;ending&quot; the<br=
>&gt; interrupt means hw-wise).
<br>&gt;<br>&gt;<br>&gt; Just to be sure I've got the things more or less c=
lear. I feel there are<br>&gt; some holes in my understanding of the irq ha=
ndling stuff, mainly hw-wise.<br>&gt;<br>&gt; x86 + i8259A.<br>&gt;<br>
&gt; In this case, .end handler does nothing more than enabling the IRQ lin=
e.<br>&gt; The &quot;eoi&quot; is sent in .ack right after disabling the IR=
Q line.<br>&gt;<br>&gt; Let's suppose we have the &quot;M&quot; case (&quot=
;O&quot; makes no difference here).
<br>&gt;<br>&gt; When the ISR handler in Linux domain gets control :<br>&gt=
;<br>&gt; - the IRQ line is ON (it was already .end-ed in the primary domai=
n in case<br>&gt;&nbsp;&nbsp; of XN_ISR_ENABLE | XN_ISR_CHAINED ).<br>&gt;<=
br>&gt; =3D=3D=3D
<br>&gt;&nbsp;&nbsp; Actually, it's possible to set IPIPE_PASS flag for<br>=
&gt;&nbsp;&nbsp; the primary_domain.irqs[THIS_IRQ].control<br>&gt;&nbsp;&nb=
sp; when THIS_IRQ is shared across domains. This way, there is no need<br>&=
gt;&nbsp;&nbsp; to call propagate_irq() in xnintr_irq_handler(). Ok, it's n=
ot
<br>&gt;&nbsp;&nbsp; that important so far.<br>&gt; =3D=3D=3D<br>&gt;<br>&g=
t;&nbsp;&nbsp; This is not how it happens when the IRQ is only handled in t=
he<br>&gt;&nbsp;&nbsp; Linux domain. But the ISR is still serialized (need =
not to be<br>&gt;&nbsp;&nbsp; reentrant) because do_IRQ() takes care of it =
(by means
<br>&gt;&nbsp;&nbsp; of RUNNING and PENDING flags).<br>&gt;<br>&gt; So, I s=
uppose, it's possible to use XN_ISR_ENABLE | XN_ISR_CHAINED in that<br>&gt;=
 case?<br>Yes, but only if you disable interrupts from the Linux device (i.=
e. via its
<br>control registers, not via the APIC), otherwise the RT-handler will spi=
n since<br>the interrupt will never get deasserted. Then you are faced with=
 finding some<br>place to reenble those interrupts right after the Linux in=
terrupts-handler has run.
</blockquote><div><br>
Thanks. I'm just missing what really happens between PIC and hw devices
at the time of CPU &lt;--&gt; PIC communication. Now it becomes
clearer, nevertheless I have to find some good hw-related overview
(tried but failed so far).<br>
&nbsp;<br>
<br>
<br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">--<br>Best =
regards<br><br>Anders Blomdell<br></blockquote></div><br clear=3D"all"><br>=
--=20
<br>Best regards,<br>Dmitry Adamushko

------=_Part_2305_14212477.1139828401009--

