MIME-Version: 1.0
In-Reply-To: <49DC9E5D.90404@domain.hid>
References: <37f89760904080541u4cdff5b2weec809904146cea3@domain.hid>
	<49DC9E5D.90404@domain.hid>
Date: Wed, 8 Apr 2009 15:07:10 +0200
Message-ID: <37f89760904080607r6ca05fc6ufb8dd3459e2cdfeb@domain.hid>
From: Marcel Soulot <msoulot@domain.hid>
Content-Type: multipart/alternative; boundary=0016364d20152ee5d104670acfff
Subject: Re: [Xenomai-help] IRQ issue :xnintr_irq_handler
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--0016364d20152ee5d104670acfff
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

But why does it work for my uart driver and not for my gpio driver ?
They works in the same way about irq management, spoke to the same chip?

Thanks,
Marcel .


2009/4/8 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Marcel Soulot wrote:
> > Hi,
> >
> > I wrote a driver to manage GPIO on a PCI card. This PCI card offer UART
> and
> > GPIO.
> > So when I use my GPIO driver with the IRQ10 (automatic assignment), I get
> > this error message : Xenomai: xnintr_irq_handler: IRQ10 not handled.
> > Disabling IRQ line.
> > I program IOCTL command which wait an event. This event is released when
> a
> > interrupt is notified on a change state from the input.
> > I get my error message when I change the state of my input and want to
> > provocate a interrupt.
> >
> > I've made a another test; still with the same PCI card (same IRQ 10) but
> > this time I load the 16550A driver and use the uart with www.captain.attest
> > on writing and reading on the same uart. Everything works fine.
> >
> > Can someone can explain me why I get my error ?
>
> You get this error because no registered real-time IRQ handler is able
> to handle the IRQ, very likely because you try to share an IRQ between
> real-time drivers and non real-time drivers without modifying the non
> real-time drivers as explained in the FAQ.
>
> --
>                                                  Gilles.
>

--0016364d20152ee5d104670acfff
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

But why does it work for my uart driver and not for my gpio driver ?<br>The=
y works in the same way about irq management, spoke to the same chip?<br><b=
r>Thanks,<br>Marcel .<br><br><br><div class=3D"gmail_quote">2009/4/8 Gilles=
 Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix=
@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><=
div class=3D"h5">Marcel Soulot wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I wrote a driver to manage GPIO on a PCI card. This PCI card offer UAR=
T and<br>
&gt; GPIO.<br>
&gt; So when I use my GPIO driver with the IRQ10 (automatic assignment), I =
get<br>
&gt; this error message : Xenomai: xnintr_irq_handler: IRQ10 not handled.<b=
r>
&gt; Disabling IRQ line.<br>
&gt; I program IOCTL command which wait an event. This event is released wh=
en a<br>
&gt; interrupt is notified on a change state from the input.<br>
&gt; I get my error message when I change the state of my input and want to=
<br>
&gt; provocate a interrupt.<br>
&gt;<br>
&gt; I&#39;ve made a another test; still with the same PCI card (same IRQ 1=
0) but<br>
&gt; this time I load the 16550A driver and use the uart with <a href=3D"ht=
tp://www.captain.at" target=3D"_blank">www.captain.at</a> test<br>
&gt; on writing and reading on the same uart. Everything works fine.<br>
&gt;<br>
&gt; Can someone can explain me why I get my error ?<br>
<br>
</div></div>You get this error because no registered real-time IRQ handler =
is able<br>
to handle the IRQ, very likely because you try to share an IRQ between<br>
real-time drivers and non real-time drivers without modifying the non<br>
real-time drivers as explained in the FAQ.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Gilles.<br>
</font></blockquote></div><br>

--0016364d20152ee5d104670acfff--

