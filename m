Message-ID: <b647ffbd0602251214h36768b46o@domain.hid>
Date: Sat, 25 Feb 2006 22:14:15 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] Re: [PATCH] Shared interrupts (ready to merge)
In-Reply-To: <43FDA8E2.5010806@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1745_26832109.1140898455168"
References: <b647ffbd0602150939g59256b2bx@domain.hid>
	<b647ffbd0602210254p19086a0au@domain.hid>
	<43FAF94C.4080709@domain.hid>
	<43FAFE58.5060201@domain.hid>
	<b647ffbd0602210848g321ffedei@domain.hid>
	<43FB480E.9020808@domain.hid> <43FB529B.3040207@domain.hid>
	<43FB6102.1070004@domain.hid>
	<b647ffbd0602220445k749d630j@domain.hid>
	<43FDA8E2.5010806@domain.hid>
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

------=_Part_1745_26832109.1140898455168
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> Ok, general bottom line regarding IRQ support (and the rest):
>
> 1- we want the rules applicable to the common case to be simple,
well-defined and
> straightforward. This applies to the ISR return value as exposed.
> 2- some requirements might fall outside of the common case; to support
them, we
> need to refrain from imposing a strong policy, but only provide sound
mechanisms
> to implement that. Specifically, let's keep the basic ability to control
the Adeos
> pipelining from Xenomai intact.
> 3- however, let's be true to the good old UNIX way-of-life: there is no
point in
> penalizing 99% of the common user base to please only 1% of them who
happen to
> have very specific needs. E.g., don't slow down the fast path everyone
takes,
> don't impose hard rules most of the users won't benefit from.

Ack.

> [I'm not referring
> to the enable/disable nesting count here: this _is_ correct, and is
currently
> missing -- this should be done at Xeno's arch-level, not from the HAL
which should
> be kept the way it is to have a direct, unmoderated access to the PIC
handling].

Let's consider it a bit. The counter as well as XENO_IRQ_DISABLED bit (or
something similar)
should be kept somewhere. So it's either xnintr_t or irq description in
low-level
ipipe code; we just don't want to introduce new structures and probably
it's better to implement this feature on Xeno layer, rather than on ipipe
one.

Actually, xnintr_t is not visible from arch-level code.

In order to support nested calls of irq_enable/disable, we should take
additional control
in all places where irq_desc[irq]->handler->enable/disable() are used (ok,
hal interface
is out of the scope, but e.g. xnintr_enable() and xnintr_disable() must be
modified
appropriately not to use this hal interface).

Another thing is xnarch_irq_end() which re-enables the IRQ line upon
exitting from
interrupt handling code.

It must make check for DISABLED bit (ISR might have called xnintr_disable()
to defer
the IRQ line enabling).

For most part of the archs supported by Xeno, .ending (xnarch_irq_end()) is
only about
calling irq_desc[irq]->handler->enable()
(handler->end() is never used) so it's not a problem to make a small wrappe=
r
that re-enables the IRQ line only when XENO_IRQ_DISABLED bit is not set.

On ppc, irq_desc[irq]->handler->end() can be called indeed and we don't kno=
w
what's all about - at least, on the Xeno layer.

So either

handler->end() must check for XENO_IRQ_DISABLED - but this is an arch-level
code
in Linux (i.e. not the Xeno layer);

or Xeno/arch/ppc must represent an .end substitution for each sub-arch
supported.


> IOW, the patch, the way you discussed it recently, is ok for me too.

This said, I'm going to publish the shirq patch (after finalizing ISR retur=
n
bits,
where I still have some doubts) without enable/disable nesting support.
It can be supported at some point of time later, if it's really needed.


--
>
> Philippe.
>



--
Best regards,
Dmitry Adamushko

------=_Part_1745_26832109.1140898455168
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div><div><br>
&gt; Ok, general bottom line regarding IRQ support (and the rest):<br>
&gt; <br>
&gt; 1- we want the rules applicable to the common case to be simple, well-=
defined and<br>
&gt; straightforward. This applies to the ISR return value as exposed.<br>
&gt; 2- some requirements might fall outside of the common case; to support=
 them, we<br>
&gt; need to refrain from imposing a strong policy, but only provide sound =
mechanisms<br>
&gt; to implement that. Specifically, let's keep the basic ability to contr=
ol the Adeos<br>
&gt; pipelining from Xenomai intact.<br>
&gt; 3- however, let's be true to the good old UNIX way-of-life: there is n=
o point in<br>
&gt; penalizing 99% of the common user base to please only 1% of them who h=
appen to<br>
&gt; have very specific needs. E.g., don't slow down the fast path everyone=
 takes,<br>
&gt; don't impose hard rules most of the users won't benefit from.<br>
<br>
Ack.<br>
<br>
&gt; [I'm not referring<br>
&gt; to the enable/disable nesting count here: this _is_ correct, and is cu=
rrently<br>
&gt; missing -- this should be done at Xeno's arch-level, not from the HAL =
which should<br>
&gt; be kept the way it is to have a direct, unmoderated access to the PIC =
handling].<br>
<br>
Let's consider it a bit. The counter as well as XENO_IRQ_DISABLED bit (or s=
omething similar)<br>
should be kept somewhere. So it's either xnintr_t or irq description in low=
-level<br>
ipipe code; we just don't want to introduce new structures and probably<br>
it's better to implement this feature on Xeno layer, rather than on ipipe o=
ne.<br>
<br>
Actually, xnintr_t is not visible from arch-level code.<br>
<br>
In order to support nested calls of irq_enable/disable, we should take addi=
tional control<br>
in all places where irq_desc[irq]-&gt;handler-&gt;enable/disable() are used=
 (ok, hal interface<br>
is out of the scope, but e.g. xnintr_enable() and xnintr_disable() must be =
modified<br>
appropriately not to use this hal interface).<br>
<br>
Another thing is xnarch_irq_end() which re-enables the IRQ line upon exitti=
ng from<br>
interrupt handling code.<br>
<br>
It must make check for DISABLED bit (ISR might have called xnintr_disable()=
 to defer<br>
the IRQ line enabling).<br>
<br>
For most part of the archs supported by Xeno, .ending (xnarch_irq_end()) is=
 only about<br>
calling irq_desc[irq]-&gt;handler-&gt;enable()<br>
(handler-&gt;end() is never used) so it's not a problem to make a small wra=
pper<br>
that re-enables the IRQ line only when XENO_IRQ_DISABLED bit is not set.<br=
>
<br>
On ppc, irq_desc[irq]-&gt;handler-&gt;end() can be called indeed and we don=
't know<br>
what's all about - at least, on the Xeno layer.<br>
<br>
So either<br>
<br>
handler-&gt;end() must check for XENO_IRQ_DISABLED - but this is an arch-le=
vel code<br>
in Linux (i.e. not the Xeno layer);<br>
<br>
or Xeno/arch/ppc must represent an .end substitution for each sub-arch supp=
orted.<br>
<br>
&nbsp;<br>
&gt; IOW, the patch, the way you discussed it recently, is ok for me too.<b=
r>
<br>
This said, I'm going to publish the shirq patch (after finalizing ISR retur=
n bits,<br>
where I still have some doubts) without enable/disable nesting support.<br>
It can be supported at some point of time later, if it's really needed.<br>
&nbsp;</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px=
 solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">-=
-<br><br>Philippe.<br></blockquote></div><br><br clear=3D"all"><br>-- <br>B=
est regards,
<br>Dmitry Adamushko

------=_Part_1745_26832109.1140898455168--

