Message-ID: <b647ffbd0602220445k749d630j@domain.hid>
Date: Wed, 22 Feb 2006 14:45:02 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] Re: [PATCH] Shared interrupts (ready to merge)
In-Reply-To: <43FB6102.1070004@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_9757_14768308.1140612302337"
References: <b647ffbd0602150939g59256b2bx@domain.hid>
	<b647ffbd0602200840v5f066d0bv@domain.hid>
	<43FAD322.4060001@domain.hid>
	<b647ffbd0602210254p19086a0au@domain.hid>
	<43FAF94C.4080709@domain.hid>
	<43FAFE58.5060201@domain.hid>
	<b647ffbd0602210848g321ffedei@domain.hid>
	<43FB480E.9020808@domain.hid> <43FB529B.3040207@domain.hid>
	<43FB6102.1070004@domain.hid>
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

------=_Part_9757_14768308.1140612302337
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> For RTDM I'm now almost determined to rework the API in way that only
> HANDLED/UNHANDLED (or what ever their names will be) get exported, any
> additional guru features will remain excluded as long as we have no
> clean usage policy for them.

Good. Then let's go for

HANDLED, UNHANDLED - we may consider them even as 2 scalar values

+

NOENABLE, CHAINED  - additional bits.

They are not encouraged to be used with shared interrupts
(explained in docs + debug messages when XENO_OPT_DEBUG is on).

Any ISR on the shared irq line should "understand" that it's
just one among the equals. That said, it should not do anything
that may affect other ISRs and not require any special treatment
(like CHAINED or NOENABLE).
If it wants it indeed, then don't declare itself as SHARED.

We may come back to the topic about possible return values of ISRs
a bit later maybe having got more feedback (hm.. hopefully)
on shared irq support.


>>>
>>> But the later one is not only about enabling the line, but
>>> on some archs - about .end-ing it too (sending EOI).
>>>
>>> And to support HANDLED_NOENABLE properly, those 2 have to be
>>> decoupled, i.e.
>>> EOI should always be sent from xnintr_shirq_handler().
>> But the one returning HANDLED_NOENABLE is likely to leave the interrupt
>> asserted, hence we can't EOI at this point (unless NO_ENABLE means
>> DISABLE).
>
>I guess this is what Dmitry meant: explicitly call disable() if one or
>more ISRs returned NOENABLE - at least on archs where end !=3D enable.
>Will this work? We could then keep on using the existing IRQ-enable API
>from bottom-half IRQ tasks.

Almost.

Let's consider the following only as anorther way of doing some things;
I don't propose to implement it, it's just to illustrate my thoughts.
So one may simply ski-skip-skip it :o)

Let's keep in mind that what is behind .end-ing the IRQ line depends on
archs.
Sometimes end =3D=3D enable (EOI was sent on .ack step), while in other cas=
es
end =3D=3D send_EOI [+ re-enabling].

But anyway, all ISRs are running with a given IRQ line disabled.

Supported values : HANDLED, UNHANDLED, PROPAGATE.

nucleus :: xnintr_irq_handler()
{
    ret =3D 0;

    ...

    for each isr in isr_list[ IRQ ]
    {
    temp =3D isr->handler();

    if (temp > ret)
        ret =3D temp;
    }

    if (ret =3D=3D PROPAGATE)
    {
    // quite dengerous with shared interrupts, be sure you understand
    // what you are doing!

    xnarch_chain_irq(irq); // will be .end-ed in Linux domain
    }
    else
    {
    // HANDLED or UNHANDLED

    xnarch_end_irq();
    }

    ...

}

ENABLE or NOENABLE is missing? Nop.

let's say we have 2 rt-ISRs :

isr1 : HANDLED
isr2 : HANDLED + WISH

WISH =3D=3D I want the IRQ line remain disabled until later
        (e.g. bottom half in rt_task will enable it)

How may isr2 express this WISH? Simply, xnarch_irq_disable/enable() should
support an internal counter that allows them to be called in a nested way.

So e.g. if there are 2 consecutive calls to disable_irq(), then
2 calls to enable_irq() are needed to really enable the IRQ line.

This way, the WISH is only about directly calling xnarch_irq_disable() in
isr2
and there is no need in ENABLE or NOENABLE flags.

This way, PROPAGATE really means NOEND - the IRQ will be .end-ed in Linux
domain;
while WISH=3D=3DNOENABLE - has nothing to do with sending EOI, but only wit=
h
enabling/disabling the given IRQ line.

Yes, if one isr (or a few) defers the IRQ line enabling until later, it wil=
l
affect
all others ISR =3D> all interrupts are temporary not accepted on this line.
This scenario is possible under Linux, but should be used with even more
care in real-time system. At least, this way HANDLED_NOENABLE case works
and doesn't lead to lost interrupts on some archs.

Moreover, it avoids the need for ENABLE flag even in non-shared interrupt
case.


--
Best regards,
Dmitry Adamushko

------=_Part_9757_14768308.1140612302337
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>
&gt; For RTDM I'm now almost determined to rework the API in way that only<=
br>
&gt; HANDLED/UNHANDLED (or what ever their names will be) get exported, any=
<br>
&gt; additional guru features will remain excluded as long as we have no<br=
>
&gt; clean usage policy for them.<br>
<br>
Good. Then let's go for <br>
<br>
HANDLED, UNHANDLED - we may consider them even as 2 scalar values<br>
<br>
+<br>
<br>
NOENABLE, CHAINED&nbsp; - additional bits.<br>
<br>
They are not encouraged to be used with shared interrupts<br>
(explained in docs + debug messages when XENO_OPT_DEBUG is on).<br>
<br>
Any ISR on the shared irq line should &quot;understand&quot; that it's<br>
just one among the equals. That said, it should not do anything<br>
that may affect other ISRs and not require any special treatment<br>
(like CHAINED or NOENABLE).<br>
If it wants it indeed, then don't declare itself as SHARED.<br>
<br>
We may come back to the topic about possible return values of ISRs<br>
a bit later maybe having got more feedback (hm.. hopefully)<br>
on shared irq support.<br>
<br>
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; But the later one is not only about enabling the line, but<br>
&gt;&gt;&gt; on some archs - about .end-ing it too (sending EOI).<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; And to support HANDLED_NOENABLE properly, those 2 have to be<b=
r>
&gt;&gt;&gt; decoupled, i.e.<br>
&gt;&gt;&gt; EOI should always be sent from xnintr_shirq_handler().<br>
&gt;&gt; But the one returning HANDLED_NOENABLE is likely to leave the inte=
rrupt<br>
&gt;&gt; asserted, hence we can't EOI at this point (unless NO_ENABLE means=
<br>
&gt;&gt; DISABLE).<br>
&gt;<br>
&gt;I guess this is what Dmitry meant: explicitly call disable() if one or<=
br>
&gt;more ISRs returned NOENABLE - at least on archs where end !=3D enable.<=
br>
&gt;Will this work? We could then keep on using the existing IRQ-enable API=
<br>
&gt;from bottom-half IRQ tasks.<br>
<br>
Almost.<br>
<br>
Let's consider the following only as anorther way of doing some things;<br>
I don't propose to implement it, it's just to illustrate my thoughts.<br>
So one may simply ski-skip-skip it :o)<br>
<br>
Let's keep in mind that what is behind .end-ing the IRQ line depends on arc=
hs.<br>
Sometimes end =3D=3D enable (EOI was sent on .ack step), while in other cas=
es<br>
end =3D=3D send_EOI [+ re-enabling].<br>
<br>
But anyway, all ISRs are running with a given IRQ line disabled.<br>
<br>
Supported values : HANDLED, UNHANDLED, PROPAGATE.<br>
<br>
nucleus :: xnintr_irq_handler()<br>
{<br>
&nbsp;&nbsp;&nbsp; ret =3D 0;<br>
<br>
&nbsp;&nbsp;&nbsp; ...<br>
<br>
&nbsp;&nbsp;&nbsp; for each isr in isr_list[ IRQ ]<br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; temp =3D isr-&gt;handler();<br>
<br>
&nbsp;&nbsp;&nbsp; if (temp &gt; ret)<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ret =3D temp;<br>
&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp; if (ret =3D=3D PROPAGATE)<br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; // quite dengerous with shared interrupts, be sure you u=
nderstand<br>
&nbsp;&nbsp;&nbsp; // what you are doing!<br>
<br>
&nbsp;&nbsp;&nbsp; xnarch_chain_irq(irq); // will be .end-ed in Linux domai=
n<br>
&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; // HANDLED or UNHANDLED<br>
<br>
&nbsp;&nbsp;&nbsp; xnarch_end_irq();<br>
&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp; ...<br>
<br>
}<br>
<br>
ENABLE or NOENABLE is missing? Nop.<br>
<br>
let's say we have 2 rt-ISRs :<br>
<br>
isr1 : HANDLED<br>
isr2 : HANDLED + WISH<br>
<br>
WISH =3D=3D I want the IRQ line remain disabled until later<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; (e.g. bottom half in rt_task will ena=
ble it)<br>
<br>
How may isr2 express this WISH? Simply, xnarch_irq_disable/enable() should<=
br>
support an internal counter that allows them to be called in a nested way.<=
br>
<br>
So e.g. if there are 2 consecutive calls to disable_irq(), then<br>
2 calls to enable_irq() are needed to really enable the IRQ line.<br>
<br>
This way, the WISH is only about directly calling xnarch_irq_disable() in i=
sr2<br>
and there is no need in ENABLE or NOENABLE flags.<br>
<br>
This way, PROPAGATE really means NOEND - the IRQ will be .end-ed in Linux d=
omain;<br>
while WISH=3D=3DNOENABLE - has nothing to do with sending EOI, but only wit=
h<br>
enabling/disabling the given IRQ line.<br>
<br>
Yes, if one isr (or a few) defers the IRQ line enabling until later, it wil=
l affect<br>
all others ISR =3D&gt; all interrupts are temporary not accepted on this li=
ne.<br>
This scenario is possible under Linux, but should be used with even more<br=
>
care in real-time system. At least, this way HANDLED_NOENABLE case works<br=
>
and doesn't lead to lost interrupts on some archs.<br>
<br>
Moreover, it avoids the need for ENABLE flag even in non-shared interrupt c=
ase.<br>
<br>
<br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_9757_14768308.1140612302337--

