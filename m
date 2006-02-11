Message-ID: <b647ffbd0602110335u58e2d4cek@domain.hid>
Date: Sat, 11 Feb 2006 13:35:26 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
In-Reply-To: <43EC9C5B.4030501@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_5362_1783646.1139657726107"
References: <b647ffbd0602070104s63275903q@domain.hid>
	<43E86F4D.4050400@domain.hid>
	<43E8DFC4.4010805@domain.hid> <43E9CE95.3070806@domain.hid>
	<43EAFD8B.7020400@domain.hid> <43EB1279.3040902@domain.hid>
	<43EB1741.9080809@domain.hid>
	<b647ffbd0602090311x56dbc765x@domain.hid>
	<43EB63D7.2080507@domain.hid> <43EC9C5B.4030501@domain.hid>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

------=_Part_5362_1783646.1139657726107
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> >
> >   irq K  | ----------- | ---o    |   // Linux only
> >   ...
> >   irq L  | ---o        |         |   // RT-only
> >   ...
> >   irq M  | ---o------- | ---o    |   // Shared between domains
> >   ...
> >   irq N  | ---o---o--- |         |   // Shared inside single domain
> >   ...
> >   irq O  | ---o---o--- | ---o    |   // Shared between and inside singl=
e
> > domain
> >
> > Xenomai currently handles the K & L cases, Dmitrys patch addresses the =
N
> > case, with edge triggered interrupts the M (and O after Dmitry's patch)
> > case(s) might be handled by returning RT_INTR_CHAINED | RT_INTR_ENABLE
> >
>
> As you pointed out recently, using this combo for M (and thus O) might
also be
> unsafe, e.g. causing some implementation to send eoi twice or more (and
the second
> time while hw IRQs are off and the second IRQ is still pending) if more
than a
> single domain ends the current interrupt. This said, I've never tried tha=
t
> actually, but this does seem a bit optimistic to always expect a proper
behaviour
> in this case (basically, it all depends on what "ending" the interrupt
means hw-wise).


Just to be sure I've got the things more or less clear. I feel there are
some holes in my understanding of the irq handling stuff, mainly hw-wise.

x86 + i8259A.

In this case, .end handler does nothing more than enabling the IRQ line.
The "eoi" is sent in .ack right after disabling the IRQ line.

Let's suppose we have the "M" case ("O" makes no difference here).

When the ISR handler in Linux domain gets control :

- the IRQ line is ON (it was already .end-ed in the primary domain in case
  of XN_ISR_ENABLE | XN_ISR_CHAINED ).

=3D=3D=3D
  Actually, it's possible to set IPIPE_PASS flag for
  the primary_domain.irqs[THIS_IRQ].control
  when THIS_IRQ is shared across domains. This way, there is no need
  to call propagate_irq() in xnintr_irq_handler(). Ok, it's not
  that important so far.
=3D=3D=3D

  This is not how it happens when the IRQ is only handled in the
  Linux domain. But the ISR is still serialized (need not to be
  reentrant) because do_IRQ() takes care of it (by means
  of RUNNING and PENDING flags).

So, I suppose, it's possible to use XN_ISR_ENABLE | XN_ISR_CHAINED in that
case?

In case of a pure Linux :

SMP : I/O APIC + local APICs. As I know, enabling/disabling
the IRQ line occurs (normally?) on per-local APIC basis. This said, when
the ISR is running on CPU_0 with the IRQ line disabled, nothing prevents
(probably, if the IRQ also was .ack-ed by that time?) the same IRQ from
being signaled on another CPU (even on a few).
In that case, it gets marked as PENDING and do_IRQ() on CPU_0 will run
handler_IRQ_events() - ISR handlers - once more.

Since PENDING is only a flag (not a counter), the fact that the IRQ was
signaled
is not lost but Linux can't know how much time it was signaled.
I guess, it's not true for devices that e.g. do not rise a new interrupt
until
the ISR handler does some special acknowledgement device-wise.

am I right?


--
Best regards,
Dmitry Adamushko

------=_Part_5362_1783646.1139657726107
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp; irq K&nbsp; | ----------- | ---o&nbsp;&nbsp;&nbsp; |&=
nbsp;&nbsp; // Linux only<br>
&gt; &gt;&nbsp;&nbsp; ...<br>
&gt; &gt;&nbsp;&nbsp; irq L&nbsp; |
---o&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; //
RT-only<br>
&gt; &gt;&nbsp;&nbsp; ...<br>
&gt; &gt;&nbsp;&nbsp; irq M&nbsp; | ---o------- | ---o&nbsp;&nbsp;&nbsp; |&=
nbsp;&nbsp; // Shared between domains<br>
&gt; &gt;&nbsp;&nbsp; ...<br>
&gt; &gt;&nbsp;&nbsp; irq N&nbsp; | ---o---o---
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; //
Shared inside single domain<br>
&gt; &gt;&nbsp;&nbsp; ...<br>
&gt; &gt;&nbsp;&nbsp; irq O&nbsp; | ---o---o--- | ---o&nbsp;&nbsp;&nbsp; |&=
nbsp;&nbsp; // Shared between and inside single<br>
&gt; &gt; domain<br>
&gt; &gt;<br>
&gt; &gt; Xenomai currently handles the K &amp; L cases, Dmitrys patch addr=
esses the N<br>
&gt; &gt; case, with edge triggered interrupts the M (and O after Dmitry's =
patch)<br>
&gt; &gt; case(s) might be handled by returning RT_INTR_CHAINED | RT_INTR_E=
NABLE<br>
&gt; &gt;<br>
&gt; <br>
&gt; As you pointed out recently, using this combo for M (and thus O) might=
 also be<br>
&gt; unsafe, e.g. causing some implementation to send eoi twice or more (an=
d the second<br>
&gt; time while hw IRQs are off and the second IRQ is still pending) if mor=
e than a<br>
&gt; single domain ends the current interrupt. This said, I've never tried =
that<br>
&gt; actually, but this does seem a bit optimistic to always expect a prope=
r behaviour<br>
&gt; in this case (basically, it all depends on what &quot;ending&quot; the=
 interrupt means hw-wise).<br>
<br>
<br>
Just to be sure I've got the things more or less clear. I feel there
are some holes in my understanding of the irq handling stuff, mainly
hw-wise.<br>
<br>
x86 + i8259A.<br>
<br>
In this case, .end handler does nothing more than enabling the IRQ line.<br=
>
The &quot;eoi&quot; is sent in .ack right after disabling the IRQ line.<br>
<br>
Let's suppose we have the &quot;M&quot; case (&quot;O&quot; makes no differ=
ence here).<br>
<br>
When the ISR handler in Linux domain gets control :<br>
<br>
- the IRQ line is ON (it was already .end-ed in the primary domain in case<=
br>
&nbsp; of XN_ISR_ENABLE | XN_ISR_CHAINED ).<br>
<br>
=3D=3D=3D<br>
&nbsp; Actually, it's possible to set IPIPE_PASS flag for <br>
&nbsp; the primary_domain.irqs[THIS_IRQ].control<br>
&nbsp; when THIS_IRQ is shared across domains. This way, there is no need<b=
r>
&nbsp; to call propagate_irq() in xnintr_irq_handler(). Ok, it's not<br>
&nbsp; that important so far.<br>
=3D=3D=3D<br>
<br>
&nbsp; This is not how it happens when the IRQ is only handled in the<br>
&nbsp; Linux domain. But the ISR is still serialized (need not to be<br>
&nbsp; reentrant) because do_IRQ() takes care of it (by means<br>
&nbsp; of RUNNING and PENDING flags).<br>
<br>
So, I suppose, it's possible to use XN_ISR_ENABLE | XN_ISR_CHAINED in that<=
br>
case?<br>
<br>
In case of a pure Linux :<br>
<br>
SMP : I/O APIC + local APICs. As I know, enabling/disabling<br>
the IRQ line occurs (normally?) on per-local APIC basis. This said, when<br=
>
the ISR is running on CPU_0 with the IRQ line disabled, nothing prevents<br=
>
(probably, if the IRQ also was .ack-ed by that time?) the same IRQ from<br>
being signaled on another CPU (even on a few).<br>
In that case, it gets marked as PENDING and do_IRQ() on CPU_0 will run<br>
handler_IRQ_events() - ISR handlers - once more.<br>
<br>
Since PENDING is only a flag (not a counter), the fact that the IRQ was sig=
naled<br>
is not lost but Linux can't know how much time it was signaled.<br>
I guess, it's not true for devices that e.g. do not rise a new interrupt un=
til<br>
the ISR handler does some special acknowledgement device-wise.<br>
<br>
am I right?<br>
<br clear=3D"all"><br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_5362_1783646.1139657726107--

