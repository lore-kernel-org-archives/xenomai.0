MIME-Version: 1.0
In-Reply-To: <4B4742B7.5010306@domain.hid>
References: <725957.56219.qm@domain.hid>
	<4B426A3D.5020706@domain.hid> <1262775394.7828.9.camel@domain.hid>
	<4B446D99.708@domain.hid>
	<4303dd241001060338w7876debaxa9e290b89d79a143@domain.hid>
	<4B4497BE.7040605@domain.hid>
	<4303dd241001061116q40315012v3b0459c3b245efa@domain.hid>
	<4B44E349.1000305@domain.hid>
	<4303dd241001080611t6ab0dafch785bcf967572e69a@domain.hid>
	<4B4742B7.5010306@domain.hid>
Date: Fri, 8 Jan 2010 12:58:44 -0200
Message-ID: <4303dd241001080658q224a43feqafa77aedd694b41c@domain.hid>
From: Flavio de Castro Alves Filho <flavio.alves@domain.hid>
Content-Type: multipart/alternative; boundary=00151750d94695ee7e047ca86c53
Subject: Re: [Xenomai-help] Porting I-Pipe for new ARM board
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--00151750d94695ee7e047ca86c53
Content-Type: text/plain; charset=ISO-8859-1

In fact,

The problem is not really related to the other timer, I believe.

Before the timer with irq 22 is called, another irq is called by
__ipipe_grab_irq(): the irq number 12 (IRQ_DA8XX_CCERRINT).

Now I'm looking for the place there this irq number is passed.

And thank you for this important information about the timers.


Flavio de Castro Alves Filho
Phi Innovations - Embedded Software Services
www.phiinnovations.com
Phone: +55 11 84 94 56 76
Skype: flavio.de.castro.alves.filho


2010/1/8 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Flavio de Castro Alves Filho wrote:
> > Hello Gilles,
> >
> > Unfortunately the patch didn't help... :-(
> >
> > But ... adding more traces on the code, I can see the irq number when the
> > function __ipipe_grab_irq() is called.
> >
> > When everything works fine, the irq number is 21 (IRQ_DA8XX_TINT12_0).
> >
> > And, sometime, the irq number starts to be 22 (IRQ_DA8XX_TINT34_0). It is
> > the other timer present at the processor. I believe that, somehow, the
> > information about the timer (at least, the interrupt location) has been
> > changed by some code.
> >
> > I will investigate more, according to these observations. I accept
> > suggestions :-)
>
> Are you sure you recompiled the kernel ? This other timer's irq seems to
> be the one for which the handle_edge_irq handler is used, which could
> really cause a lockup.
>
> Anyway, the reason why this other timer is used is probably because
> clockevent decided it had a better score. But that should not cause a
> lockup, unless handle_edge_irq is used.
>
> So, you are probably better off using that timer for xenomai too. If you
> do not want that, you will have to give a higher score to the timer you
> want Linux to use.
>
> --
>                                             Gilles.
>

--00151750d94695ee7e047ca86c53
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

In fact,<br><br>The problem is not really related to the other timer, I bel=
ieve.<br><br>Before the timer with irq 22 is called, another irq is called =
by __ipipe_grab_irq(): the irq number 12 (IRQ_DA8XX_CCERRINT).<br><br>Now I=
&#39;m looking for the place there this irq number is passed.<br>
<br>And thank you for this important information about the timers.<br><br><=
br clear=3D"all">Flavio de Castro Alves Filho<br>Phi Innovations - Embedded=
 Software Services<br><a href=3D"http://www.phiinnovations.com">www.phiinno=
vations.com</a><br>
Phone: +55 11 84 94 56 76<br>Skype: flavio.de.castro.alves.filho<br>
<br><br><div class=3D"gmail_quote">2010/1/8 Gilles Chanteperdrix <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.cha=
nteperdrix@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" =
style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8=
ex; padding-left: 1ex;">
<div class=3D"im">Flavio de Castro Alves Filho wrote:<br>
</div><div class=3D"im">&gt; Hello Gilles,<br>
&gt;<br>
&gt; Unfortunately the patch didn&#39;t help... :-(<br>
&gt;<br>
&gt; But ... adding more traces on the code, I can see the irq number when =
the<br>
&gt; function __ipipe_grab_irq() is called.<br>
&gt;<br>
&gt; When everything works fine, the irq number is 21 (IRQ_DA8XX_TINT12_0).=
<br>
&gt;<br>
&gt; And, sometime, the irq number starts to be 22 (IRQ_DA8XX_TINT34_0). It=
 is<br>
&gt; the other timer present at the processor. I believe that, somehow, the=
<br>
&gt; information about the timer (at least, the interrupt location) has bee=
n<br>
&gt; changed by some code.<br>
&gt;<br>
&gt; I will investigate more, according to these observations. I accept<br>
&gt; suggestions :-)<br>
<br>
</div>Are you sure you recompiled the kernel ? This other timer&#39;s irq s=
eems to<br>
be the one for which the handle_edge_irq handler is used, which could<br>
really cause a lockup.<br>
<br>
Anyway, the reason why this other timer is used is probably because<br>
clockevent decided it had a better score. But that should not cause a<br>
lockup, unless handle_edge_irq is used.<br>
<br>
So, you are probably better off using that timer for xenomai too. If you<br=
>
do not want that, you will have to give a higher score to the timer you<br>
want Linux to use.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br>

--00151750d94695ee7e047ca86c53--

