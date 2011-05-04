MIME-Version: 1.0
In-Reply-To: <4DC03D39.2040305@domain.hid>
References: <BANLkTikzGAMXZ--TaxmxXZDsoYJSesC26g@domain.hid>
	<4DC03D39.2040305@domain.hid>
Date: Wed, 4 May 2011 09:11:18 +0200
Message-ID: <BANLkTi=Pj2Rk0u_ih7zKx+pmyhSTGM3Y-Q@mail.gmail.com>
From: Aurele Traynard <aurele.traynard@domain.hid>
Content-Type: multipart/alternative; boundary=20cf307f34008b6d6804a26df6f0
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

--20cf307f34008b6d6804a26df6f0
Content-Type: text/plain; charset=ISO-8859-1

Ok I will explain more things :
My software makes the system freezing, when my interrupt handler is called
for the first time I think that he is called again and again and again and
this never stops. And so this freeze the system
but I am not totaly sure.
I'm sure that it is not Xenomai's fault it is just mine. I think I don't use
Xenomai correctly...
That's why I am asking if "ioremap" "readl/writel" is the best way to
read/write CPU registers and if there are other ways.

CPU (XScale) : PXA270 520MHz, 256Mo RAM (100MHz)
gcc : from CodeSourcery
$ arm-none-linux-gnueabi-gcc --version
$ arm-none-linux-gnueabi-gcc (Sourcery G++ Lite 2010q1-202) 4.4.1

linux : 2.6.33.2
Xenomai 2.5.6
patch : ksrc/arch/arm/patches/adeos-ipipe-2.6.33-arm-1.18-02.patch



2011/5/3 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 05/03/2011 02:07 PM, Aurele Traynard wrote:
> > hello,
> >
> > I am writing a little test. I put all my RT things in a module : one ISR
> and
> > one RT task.
> > in init_module I call :
> >
> > drv->data.regs = ioremap(0x04000000, 64*1024*1024);
> > drv->data.gpio = ioremap(0x40E00000, 64*1024*1024);
> > this is to acces registers
> >
> > rthal_irq_request(8, my_rt_isr, NULL, &(drv->data));
> > rthal_irq_enable(8);
> > for the ISR
> >
> > in my interrupt routine I use : writel(1, data->gpio + 0x48); for
> hardware
> > interrupt acknowledge
> >
> > but when my interrupt routine is called linux is freezing so i think that
> I
> > am never going out of the ISR (I am 99.9% sure).
> > I am not sure but I think that It is due to the hardware interrupt
> > aknoledge...
> >
> > my question is :
> > can I call "writel(1, data->gpio + 0x48);" in my ISR?
> > is it good or not?
> > is there an other way to access registers?
> >
> > thanks for your answers.
> >
> > PS firstly I was calling : "GEDR0 = 0x1;" but in RT task this macro
> doesn't
> > work
>
> Why is that? What are the symptoms?
>
> Other than that, have a look at:
> http://www.xenomai.org/index.php/Request_for_information
>
> --
>                                                                 Gilles.
>

--20cf307f34008b6d6804a26df6f0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Ok I will explain more things :<br>My software makes the system freezing, w=
hen my interrupt handler is called for the first time I think that he is ca=
lled again and again and again and this never stops. And so this freeze the=
 system<br>
but I am not totaly sure. <br>I&#39;m sure that it is not Xenomai&#39;s fau=
lt it is just mine. I think I don&#39;t use Xenomai correctly...<br>That&#3=
9;s why I am asking if &quot;ioremap&quot; &quot;readl/writel&quot; is the =
best way to read/write CPU registers and if there are other ways.<br>
<br>CPU (XScale) : PXA270 520MHz, 256Mo RAM (100MHz)<br>gcc : from CodeSour=
cery <br>$ arm-none-linux-gnueabi-gcc --version<br>$ arm-none-linux-gnueabi=
-gcc (Sourcery G++ Lite 2010q1-202) 4.4.1<br><br>linux : 2.6.33.2<br>Xenoma=
i 2.5.6<br>
patch : ksrc/arch/arm/patches/adeos-ipipe-2.6.33-arm-1.18-02.patch<br><br><=
br><br><div class=3D"gmail_quote">2011/5/3 Gilles Chanteperdrix <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.cha=
nteperdrix@domain.hid</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div><div></div><div class=3D"h5">On 05/03/=
2011 02:07 PM, Aurele Traynard wrote:<br>
&gt; hello,<br>
&gt;<br>
&gt; I am writing a little test. I put all my RT things in a module : one I=
SR and<br>
&gt; one RT task.<br>
&gt; in init_module I call :<br>
&gt;<br>
&gt; drv-&gt;data.regs =3D ioremap(0x04000000, 64*1024*1024);<br>
&gt; drv-&gt;data.gpio =3D ioremap(0x40E00000, 64*1024*1024);<br>
&gt; this is to acces registers<br>
&gt;<br>
&gt; rthal_irq_request(8, my_rt_isr, NULL, &amp;(drv-&gt;data));<br>
&gt; rthal_irq_enable(8);<br>
&gt; for the ISR<br>
&gt;<br>
&gt; in my interrupt routine I use : writel(1, data-&gt;gpio + 0x48); for h=
ardware<br>
&gt; interrupt acknowledge<br>
&gt;<br>
&gt; but when my interrupt routine is called linux is freezing so i think t=
hat I<br>
&gt; am never going out of the ISR (I am 99.9% sure).<br>
&gt; I am not sure but I think that It is due to the hardware interrupt<br>
&gt; aknoledge...<br>
&gt;<br>
&gt; my question is :<br>
&gt; can I call &quot;writel(1, data-&gt;gpio + 0x48);&quot; in my ISR?<br>
&gt; is it good or not?<br>
&gt; is there an other way to access registers?<br>
&gt;<br>
&gt; thanks for your answers.<br>
&gt;<br>
&gt; PS firstly I was calling : &quot;GEDR0 =3D 0x1;&quot; but in RT task t=
his macro doesn&#39;t<br>
&gt; work<br>
<br>
</div></div>Why is that? What are the symptoms?<br>
<br>
Other than that, have a look at:<br>
<a href=3D"http://www.xenomai.org/index.php/Request_for_information" target=
=3D"_blank">http://www.xenomai.org/index.php/Request_for_information</a><br=
>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0Gilles.<br>
</font></blockquote></div><br>

--20cf307f34008b6d6804a26df6f0--

