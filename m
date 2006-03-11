Message-ID: <b647ffbd0603110246t43f89035y@domain.hid>
Date: Sat, 11 Mar 2006 12:46:06 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [RFC, Experimental Patch] nested irq disable calls
In-Reply-To: <44101F89.7080109@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1885_4525401.1142073966328"
References: <b647ffbd0603030252h5f54c436l@domain.hid>
	<440C1C41.5090304@domain.hid>
	<b647ffbd0603070648g6a09b3c5s@domain.hid>
	<44101F89.7080109@domain.hid>
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

------=_Part_1885_4525401.1142073966328
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<snip>

> > I would see the following scenario - an ISR wants to
> > _temporary_ defer an IRQ line enabling
> > until some later stage (e.g. rt_task which is a bottom half).
> > This is the only reason why xnarch_end_irq() or some later step in it
> > (in this case ->end() ) must be aware
> > of IPIPE_DISABLED_FLAG.
> >
> > Why the currently used approach is not that good for it (NOENABLE) ?
> >
> > 1)   it actually defers (for some PICs) not only "enabling" but sending
> > an EOI too;
> >     As a consequence :
> >
>
> This is no more the case for ppc over which Adeos had this bug Anders
reported and
> fixed.

I thought that the actual reason of that problem was the use of
rthal_enable_irq() in xnintr_irq_handler()
to play the IRQ .ending phase, not taking into account that .ending is not
always =3D=3D .enabling.
As a consequence, it didn't work for some ppc/PICs where the EOI is sent by
.end and not .ack and
that's why rthal_end_irq() has been recently introduced.

> For each arch/pic pairs, ->ack() should now send eoi and likely mask the
> outstanding IRQ, whilst ->end() should only unmask it as needed.
> AFAICT after a brief inspection, x86, ppc, ia64, and blackfin ports look
ok regarding this. (I
> did not check neither the ARM nor ppc64 ports yet, though).
> But in any case, this is the way Adeos is expected to behave, and it
should be fixed iff it doesn't.

This actually makes the implemention of nested irq disable calls simpler.

But is such a rework of the PIC logic always possible and correct, hw-wise?

let's consider 2 cases :

1)
.ack =3D NULL (do nothing)
.end =3D send EOI

2)
.ack =3D { mask and send EOI }
.end =3D unmask

I guess, both 1) and 2) keep the line "disabled" until .end takes place.
But 2) requires 2 more opertions (mask and unmask) and, hence, it gives hig=
h
overhead, esp. on some sluggish archs with not memory-mapped i/o ports.

Are those variants always safely exchangable?

> <snip>
> To sum up, I agree with you that addressing #2 directly through a disable
nesting
> count would solve those issues quite more elegantly.

Good.

> > Actually, why is ipipe_irq_unlock(irq) necessary in
> > __ipipe_override_irq_end()? ipipe_irq_lock() is not
> > called in __ipipe_ack_irq(). Is it locked somewhere else? At least, I
> > haven't found explicit ipipe_irq_lock()
> > or __ipipe_lock_irq() calls anywhere else.
>
> Basically because as documented in __do_IRQ, the ->end() handler has to
deal with
> interrupts which got disabled while the handler was running. If for some
reason,
> some IRQ handler decides to disable its own IRQ line, then the lock bit
would be
> raised in the pipeline for this IRQ too as a result of calling
disable_irq().
> Therefore, ->end() must unlock the IRQ at pipeline level whenever it
eventually
> decides to unmask.

So roughly, __ipipe_irq_lock() is coupled with ->disable() while
__ipipe_irq_unlock() -
with ->enable().
Actually, I was confused by the fact that .ack normally does the same thing
as ->disable(), i.e. masking, but there is no corresponding
__ipipe_irq_lock() call there.
IOW, a number of __ipipe_irq_lock() calls doesn't correlate to a number of
__ipipe_irq_unlock()
calls as 1:1.

And actually this saves us from a possible problem, I guess.
.ack and .end may be issued from different domains and that, in turn, leads
to calling
__ipipe_irq_lock() and __ipipe_irq_unlock() from different domains too. As =
a
result, a given
IRQ line is enabled (at the hw layer) but remains to be "LOCKED" in the
domain where .ack
took place.

The same may happen if a rt ISR calls ->enable() and then asks nucleus to
propagate an interrupt
down to the Linux domain where .end takes place.


> --
>
>Philippe.
>

--
Best regards,
Dmitry Adamushko

------=_Part_1885_4525401.1142073966328
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

&lt;snip&gt;<br>
<br>
&gt; &gt; I would see the following scenario - an ISR wants to<br>
&gt; &gt; _temporary_ defer an IRQ line enabling<br>
&gt; &gt; until some later stage (e.g. rt_task which is a bottom half).<br>
&gt; &gt; This is the only reason why xnarch_end_irq() or some later step i=
n it<br>
&gt; &gt; (in this case -&gt;end() ) must be aware<br>
&gt; &gt; of IPIPE_DISABLED_FLAG.<br>
&gt; &gt;<br>
&gt; &gt; Why the currently used approach is not that good for it (NOENABLE=
) ?<br>
&gt; &gt;<br>
&gt; &gt; 1)&nbsp;&nbsp; it actually defers (for some PICs) not only &quot;=
enabling&quot; but sending<br>
&gt; &gt; an EOI too;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; As a consequence :<br>
&gt; &gt;<br>
&gt; <br>
&gt; This is no more the case for ppc over which Adeos had this bug Anders =
reported and<br>
&gt; fixed.<br>
<br>
I thought that the actual reason of that problem was the use of rthal_enabl=
e_irq() in xnintr_irq_handler()<br>
to play the IRQ .ending phase, not taking into account that .ending is not =
always =3D=3D .enabling.<br>
As a consequence, it didn't work for some ppc/PICs where the EOI is sent by=
 .end and not .ack and<br>
that's why rthal_end_irq() has been recently introduced.<br>
<br>
&gt; For each arch/pic pairs, -&gt;ack() should now send eoi and likely mas=
k the<br>
&gt; outstanding IRQ, whilst -&gt;end() should only unmask it as needed.<br=
>
&gt; AFAICT after a brief inspection, x86, ppc, ia64, and blackfin ports lo=
ok ok regarding this. (I<br>
&gt; did not check neither the ARM nor ppc64 ports yet, though). <br>
&gt; But in any case, this is the way Adeos is expected to behave, and it s=
hould be fixed iff it doesn't.<br>
<br>
This actually makes the implemention of nested irq disable calls simpler.<b=
r>
<br>
But is such a rework of the PIC logic always possible and correct, hw-wise?=
<br>
<br>
let's consider 2 cases :<br>
<br>
1)<br>
.ack =3D NULL (do nothing)<br>
.end =3D send EOI<br>
<br>
2)<br>
.ack =3D { mask and send EOI }<br>
.end =3D unmask<br>
<br>
I guess, both 1) and 2) keep the line &quot;disabled&quot; until .end takes=
 place.<br>
But 2) requires 2 more opertions (mask and unmask) and, hence, it gives hig=
h<br>
overhead, esp. on some sluggish archs with not memory-mapped i/o ports.<br>
<br>
Are those variants always safely exchangable?<br>
<br>
&gt; &lt;snip&gt;<br>
&gt; To sum up, I agree with you that addressing #2 directly through a disa=
ble nesting<br>
&gt; count would solve those issues quite more elegantly.<br>
<br>
Good.<br>
<br>
&gt; &gt; Actually, why is ipipe_irq_unlock(irq) necessary in<br>
&gt; &gt; __ipipe_override_irq_end()? ipipe_irq_lock() is not<br>
&gt; &gt; called in __ipipe_ack_irq(). Is it locked somewhere else? At leas=
t, I<br>
&gt; &gt; haven't found explicit ipipe_irq_lock()<br>
&gt; &gt; or __ipipe_lock_irq() calls anywhere else.<br>
&gt; <br>
&gt; Basically because as documented in __do_IRQ, the -&gt;end() handler ha=
s to deal with<br>
&gt; interrupts which got disabled while the handler was running. If for so=
me reason,<br>
&gt; some IRQ handler decides to disable its own IRQ line, then the lock bi=
t would be<br>
&gt; raised in the pipeline for this IRQ too as a result of calling disable=
_irq().<br>
&gt; Therefore, -&gt;end() must unlock the IRQ at pipeline level whenever i=
t eventually<br>
&gt; decides to unmask.<br>
<br>
So roughly, __ipipe_irq_lock() is coupled with -&gt;disable() while __ipipe=
_irq_unlock() -<br>
with -&gt;enable().<br>
Actually, I was confused by the fact that .ack normally does the same thing=
<br>
as -&gt;disable(), i.e. masking, but there is no corresponding __ipipe_irq_=
lock() call there.<br>
IOW, a number of __ipipe_irq_lock() calls doesn't correlate to a number of =
__ipipe_irq_unlock()<br>
calls as 1:1.<br>
<br>
And actually this saves us from a possible problem, I guess.<br>
.ack and .end may be issued from different domains and that, in turn, leads=
 to calling<br>
__ipipe_irq_lock() and __ipipe_irq_unlock() from different domains too. As =
a result, a given<br>
IRQ line is enabled (at the hw layer) but remains to be &quot;LOCKED&quot; =
in the domain where .ack<br>
took place.<br>
<br>
The same may happen if a rt ISR calls -&gt;enable() and then asks nucleus t=
o propagate an interrupt<br>
down to the Linux domain where .end takes place.<br>
<br>
<br>
&gt; --<br>
&gt;<br>
&gt;Philippe.<br>
&gt;<br>
<br>
-- <br>Best regards,<br>Dmitry Adamushko<br>
<br>


------=_Part_1885_4525401.1142073966328--

