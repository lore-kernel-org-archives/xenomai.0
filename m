Message-ID: <b647ffbd0603070648g6a09b3c5s@domain.hid>
Date: Tue, 7 Mar 2006 16:48:39 +0200
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-core] [RFC, Experimental Patch] nested irq disable calls
In-Reply-To: <440C1C41.5090304@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_5974_8196229.1141742919252"
References: <b647ffbd0603030252h5f54c436l@domain.hid>
	<440C1C41.5090304@domain.hid>
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

------=_Part_5974_8196229.1141742919252
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> >
> >     BEFORE
> >
> >     static void openpic_end_irq(unsigned int irq_nr)
> >     {
> >     if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS))
> >         && irq_desc[irq_nr].action)
> >         openpic_enable_irq(irq_nr);
> >     }
> >
> >
> >     AFTER
> >
> >     static void openpic_end_irq(unsigned int irq_nr)
> >     {
> >     if (!ipipe_root_domain_p()
> >         &&
> >
!test_bit(IPIPE_DISABLED_FLAG,&ipipe_current_domain->irqs[irq_nr].control))
> >         return;
> >
>
> -
!test_bit(IPIPE_DISABLED_FLAG,&ipipe_current_domain->irqs[irq_nr].control))
> +
test_bit(IPIPE_DISABLED_FLAG,&ipipe_current_domain->irqs[irq_nr].control))
>
> ?

Yep.


> Additionally, there is another issue we discussed once with Anders, which
is
> related to not sending EOI twice after the shared IRQ already ended by a
RT domain
> has been fully propagated down the pipeline to Linux;
> some kind of test_and_clear_temporary_disable flag, would do, I guess. Th=
e
other way would be
> to test_and_set some "ended" flag for the outstanding IRQ when the ->end(=
)
routine
> is entered, clearing this flag before pipelining the IRQ in
__ipipe_walk_pipeline().
>
> Actually, I'm now starting to wonder why we would want to permanently
disable an
> IRQ line from a RT domain, which is known to be used by Linux.
> Is this what IPIPE_DISABLED_FLAG is expected to be used for, or is it onl=
y
there to handle the
> transient disabled state discussed above?

Why "permanently"? I would see the following scenario - an ISR wants to
_temporary_ defer an IRQ line enabling
until some later stage (e.g. rt_task which is a bottom half).
This is the only reason why xnarch_end_irq() or some later step in it (in
this case ->end() ) must be aware
of IPIPE_DISABLED_FLAG.

Why the currently used approach is not that good for it (NOENABLE) ?

1)   it actually defers (for some PICs) not only "enabling" but sending an
EOI too;
    As a consequence :

2)   rthal_end_irq() (on PPC and not just xnintr_enable() or
rthal_enable_irq()) must be called in bottom half
    to re-endable the IRQ line;

3)   does not co-exist well with the shared interrupts support (I don't mea=
n
sharing between RT and not-RT doamins here).
    Although it's not a common case if a few ISRs on the same shared line
want to defer enabling, esp. for
    real-time domain;

4)   it's a bit and if we would like to use only scalar values one day then
something
    like HANDLED, HANDLED_NOENABLE would be needed;

The support for nested irq enable/disable calls would resolve all the
"restrictions" above but the question is
whether we really need to resolve them.

In the same vein, I'd like to know you vision of the "nested irq
enable/disable calls support". Any use cases?

>
> >
> >     if (!ipipe_root_domain_p() || !(irq_desc[irq_nr].status &
> > (IRQ_DISABLED|IRQ_INPROGRESS))
> >         && irq_desc[irq_nr].action)
> >         openpic_enable_irq(irq_nr);
> >     }
> >
>
> There is another way for most archs, which is to add such code to the
->end()
> routine override in ipipe-root.c; this would be simpler and safer than
fixing such
> routine for each and every kind of interrupt controller. x86 directly
pokes into
> the PIC code and does not overrides IRQ control routines, though.

I didn't know about them as I mostly looked at the x86 implementation.

This gives as control over per-domain irq locking/unlocking
(ipipe_irq_lock/unlock()),
__ipipe_std_irq_dtype[irq].end() is always called unconditionally (as a
result, .enable() for some PICs).
That said, the IRQ line is actually on, the interrupts are just not handled
but accumulated in the pipe-log.

Actually, why is ipipe_irq_unlock(irq) necessary in
__ipipe_override_irq_end()? ipipe_irq_lock() is not
called in __ipipe_ack_irq(). Is it locked somewhere else? At least, I
haven't found explicit ipipe_irq_lock()
or __ipipe_lock_irq() calls anywhere else.


> [skip-skip-skip]
>
> >
> >  >From another point of view, this new feature seems not to be too
> > intrusive and not something really affecting the "fast path" so it coul=
d
> > be used by default, I guess. Or maybe we don't need it at all?
> >
>
> The disable nesting count at Xenomai level is needed to let ISRs act
independently
> from each others wrt interrupt masking - or at the very least, to let the=
m
think
> they do. This is strictly a Xenomai issue, not an Adeos one. If we keep i=
t
at this
> level, then using the xnintr struct to store the nesting counter becomes
an
> option, I guess.

Let's start from defining possible use cases with nested irq enable/disable
calls then.
Maybe we just don't need them at all (at least the same way Linux deals wit=
h
them)?

>
> --
>
> Philippe.


--
Best regards,
Dmitry Adamushko

------=_Part_5974_8196229.1141742919252
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; BEFORE<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; static void openpic_end_irq(unsigned int =
irq_nr)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; if (!(irq_desc[irq_nr].status &amp; (IRQ_=
DISABLED|IRQ_INPROGRESS))<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;&amp; irq_de=
sc[irq_nr].action)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; openpic_enable_ir=
q(irq_nr);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; AFTER<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; static void openpic_end_irq(unsigned int =
irq_nr)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; if (!ipipe_root_domain_p()<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;&amp;<br>
&gt; &gt; !test_bit(IPIPE_DISABLED_FLAG,&amp;ipipe_current_domain-&gt;irqs[=
irq_nr].control))<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &gt;<br>
&gt; <br>
&gt; - !test_bit(IPIPE_DISABLED_FLAG,&amp;ipipe_current_domain-&gt;irqs[irq=
_nr].control))<br>
&gt; + test_bit(IPIPE_DISABLED_FLAG,&amp;ipipe_current_domain-&gt;irqs[irq_=
nr].control))<br>
&gt; <br>
&gt; ?<br>
<br>
Yep.<br>
<br>
<br>
&gt; Additionally, there is another issue we discussed once with Anders, wh=
ich is<br>
&gt; related to not sending EOI twice after the shared IRQ already ended by=
 a RT domain<br>
&gt; has been fully propagated down the pipeline to Linux;<br>
&gt; some kind of test_and_clear_temporary_disable flag, would do, I guess.=
 The other way would be<br>
&gt; to test_and_set some &quot;ended&quot; flag for the outstanding IRQ wh=
en the -&gt;end() routine<br>
&gt; is entered, clearing this flag before pipelining the IRQ in __ipipe_wa=
lk_pipeline().<br>
&gt; <br>
&gt; Actually, I'm now starting to wonder why we would want to permanently =
disable an<br>
&gt; IRQ line from a RT domain, which is known to be used by Linux.<br>
&gt; Is this what IPIPE_DISABLED_FLAG is expected to be used for, or is it =
only there to handle the<br>
&gt; transient disabled state discussed above?<br>
<br>
Why &quot;permanently&quot;? I would see the following scenario - an ISR wa=
nts to _temporary_ defer an IRQ line enabling<br>
until some later stage (e.g. rt_task which is a bottom half).<br>
This is the only reason why xnarch_end_irq() or some later step in it (in t=
his case -&gt;end() ) must be aware<br>
of IPIPE_DISABLED_FLAG.<br>
<br>
Why the currently used approach is not that good for it (NOENABLE) ?<br>
<br>
1)&nbsp;&nbsp; it actually defers (for some PICs) not only &quot;enabling&q=
uot; but sending an EOI too;<br>
&nbsp;&nbsp;&nbsp; As a consequence :<br>
<br>
2)&nbsp;&nbsp; rthal_end_irq() (on PPC and not just xnintr_enable() or rtha=
l_enable_irq()) must be called in bottom half<br>
&nbsp;&nbsp;&nbsp; to re-endable the IRQ line;<br>
<br>
3)&nbsp;&nbsp; does not co-exist well with the shared interrupts
support (I don't mean sharing between RT and not-RT doamins here).<br>
&nbsp;&nbsp;&nbsp; Although it's not a common case if a few ISRs on the sam=
e shared line want to defer enabling, esp. for<br>
&nbsp;&nbsp;&nbsp; real-time domain;<br>
<br>
4)&nbsp;&nbsp; it's a bit and if we would like to use only scalar values on=
e day then something<br>
&nbsp;&nbsp;&nbsp; like HANDLED, HANDLED_NOENABLE would be needed;<br>
<br>
The support for nested irq enable/disable calls would resolve all the &quot=
;restrictions&quot; above but the question is<br>
whether we really need to resolve them.<br>
<br>
In the same vein, I'd like to know you vision of the &quot;nested irq enabl=
e/disable calls support&quot;. Any use cases?<br>
<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; if (!ipipe_root_domain_p() || !(irq_desc[=
irq_nr].status &amp;<br>
&gt; &gt; (IRQ_DISABLED|IRQ_INPROGRESS))<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;&amp; irq_de=
sc[irq_nr].action)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; openpic_enable_ir=
q(irq_nr);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; <br>
&gt; There is another way for most archs, which is to add such code to the =
-&gt;end()<br>
&gt; routine override in ipipe-root.c; this would be simpler and safer than=
 fixing such<br>
&gt; routine for each and every kind of interrupt controller. x86 directly =
pokes into<br>
&gt; the PIC code and does not overrides IRQ control routines, though.<br>
<br>
I didn't know about them as I mostly looked at the x86 implementation.<br>
<br>
This gives as control over per-domain irq locking/unlocking (ipipe_irq_lock=
/unlock()),<br>
__ipipe_std_irq_dtype[irq].end() is always called unconditionally (as a res=
ult, .enable() for some PICs).<br>
That said, the IRQ line is actually on, the interrupts are just not handled=
 but accumulated in the pipe-log.<br>
<br>
Actually, why is ipipe_irq_unlock(irq) necessary in __ipipe_override_irq_en=
d()? ipipe_irq_lock() is not<br>
called in __ipipe_ack_irq(). Is it locked somewhere else? At least, I haven=
't found explicit ipipe_irq_lock()<br>
or __ipipe_lock_irq() calls anywhere else.<br>
&nbsp;<br>
<br>
&gt; [skip-skip-skip]<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt;&nbsp; &gt;From another point of view, this new feature seems not =
to be too<br>
&gt; &gt; intrusive and not something really affecting the &quot;fast path&=
quot; so it could<br>
&gt; &gt; be used by default, I guess. Or maybe we don't need it at all?<br=
>
&gt; &gt;<br>
&gt; <br>
&gt; The disable nesting count at Xenomai level is needed to let ISRs act i=
ndependently<br>
&gt; from each others wrt interrupt masking - or at the very least, to let =
them think<br>
&gt; they do. This is strictly a Xenomai issue, not an Adeos one. If we kee=
p it at this<br>
&gt; level, then using the xnintr struct to store the nesting counter becom=
es an<br>
&gt; option, I guess.<br>
<br>
Let's start from defining possible use cases with nested irq enable/disable=
 calls then.<br>
Maybe we just don't need them at all (at least the same way Linux deals wit=
h them)?<br>
<br>
&gt; <br>
&gt; --<br>
&gt; <br>
&gt; Philippe.<br>
<br>
<br clear=3D"all">
-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_5974_8196229.1141742919252--

