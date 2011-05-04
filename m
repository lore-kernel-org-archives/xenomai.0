MIME-Version: 1.0
In-Reply-To: <4DC0FEDD.8080304@domain.hid>
References: <BANLkTikzGAMXZ--TaxmxXZDsoYJSesC26g@domain.hid>
	<4DC03D39.2040305@domain.hid>
	<BANLkTi=Pj2Rk0u_ih7zKx+pmyhSTGM3Y-Q@mail.gmail.com>
	<4DC0FEDD.8080304@domain.hid>
Date: Wed, 4 May 2011 10:59:23 +0200
Message-ID: <BANLkTim7y3DAAFoiHU1rVp9VtzTn0V2gXg@domain.hid>
From: Aurele Traynard <aurele.traynard@domain.hid>
Content-Type: multipart/alternative; boundary=20cf307f340017c65a04a26f79b4
Subject: Re: [Xenomai-help] reading/writing registers
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

--20cf307f340017c65a04a26f79b4
Content-Type: text/plain; charset=ISO-8859-1

2011/5/4 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 05/04/2011 09:11 AM, Aurele Traynard wrote:
> > Ok I will explain more things :
> > My software makes the system freezing, when my interrupt handler is
> called
> > for the first time I think that he is called again and again and again
> and
> > this never stops. And so this freeze the system
> > but I am not totaly sure.
> > I'm sure that it is not Xenomai's fault it is just mine. I think I don't
> use
> > Xenomai correctly...
> > That's why I am asking if "ioremap" "readl/writel" is the best way to
> > read/write CPU registers and if there are other ways.
>
> Yes they are. But if your aim is to acknowledge/mask the interrupt line
> at the interrupt controller level, this should not be done in the
> interrupt handler, it is supposed to be done in the irqchip callbacks
> for the interrupt controller you use.
>
> --
>                                                                 Gilles.
>

Ok if i understood I should put acknowledge/mask in a callback, and this
callback should be the "rthal_irq_ackfn_t ackfn" argument (in
rthal_irq_request)?
But if I would like to read write any other register in my interrupt handler
how should I do?

--20cf307f340017c65a04a26f79b4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2011/5/4 Gilles Chanteperdrix <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.cha=
nteperdrix@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"im">On 05/04/2011 09:11 AM, Aurele Traynard wrote:<br>
&gt; Ok I will explain more things :<br>
&gt; My software makes the system freezing, when my interrupt handler is ca=
lled<br>
&gt; for the first time I think that he is called again and again and again=
 and<br>
&gt; this never stops. And so this freeze the system<br>
&gt; but I am not totaly sure.<br>
&gt; I&#39;m sure that it is not Xenomai&#39;s fault it is just mine. I thi=
nk I don&#39;t use<br>
&gt; Xenomai correctly...<br>
&gt; That&#39;s why I am asking if &quot;ioremap&quot; &quot;readl/writel&q=
uot; is the best way to<br>
&gt; read/write CPU registers and if there are other ways.<br>
<br>
</div>Yes they are. But if your aim is to acknowledge/mask the interrupt li=
ne<br>
at the interrupt controller level, this should not be done in the<br>
interrupt handler, it is supposed to be done in the irqchip callbacks<br>
for the interrupt controller you use.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0Gilles.<br>
</font></blockquote></div><br>Ok if i understood I should put acknowledge/m=
ask in a callback, and this
 callback should be the &quot;rthal_irq_ackfn_t ackfn&quot; argument (in=20
rthal_irq_request)?<br>But if I would like to read write any other register=
 in my interrupt handler how should I do?

--20cf307f340017c65a04a26f79b4--

