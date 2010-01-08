MIME-Version: 1.0
In-Reply-To: <4B44E349.1000305@domain.hid>
References: <725957.56219.qm@domain.hid>
	<4B3CC62D.6070709@domain.hid>
	<1262643246.20365.10.camel@domain.hid>
	<4B426A3D.5020706@domain.hid> <1262775394.7828.9.camel@domain.hid>
	<4B446D99.708@domain.hid>
	<4303dd241001060338w7876debaxa9e290b89d79a143@domain.hid>
	<4B4497BE.7040605@domain.hid>
	<4303dd241001061116q40315012v3b0459c3b245efa@domain.hid>
	<4B44E349.1000305@domain.hid>
Date: Fri, 8 Jan 2010 12:11:29 -0200
Message-ID: <4303dd241001080611t6ab0dafch785bcf967572e69a@domain.hid>
From: Flavio de Castro Alves Filho <flavio.alves@domain.hid>
Content-Type: multipart/alternative; boundary=00032555ac0295ba53047ca7c3b1
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

--00032555ac0295ba53047ca7c3b1
Content-Type: text/plain; charset=ISO-8859-1

Hello Gilles,

Unfortunately the patch didn't help... :-(

But ... adding more traces on the code, I can see the irq number when the
function __ipipe_grab_irq() is called.

When everything works fine, the irq number is 21 (IRQ_DA8XX_TINT12_0).

And, sometime, the irq number starts to be 22 (IRQ_DA8XX_TINT34_0). It is
the other timer present at the processor. I believe that, somehow, the
information about the timer (at least, the interrupt location) has been
changed by some code.

I will investigate more, according to these observations. I accept
suggestions :-)

Best regards,

Flavio

Flavio de Castro Alves Filho
Phi Innovations - Embedded Software Services
www.phiinnovations.com
Phone: +55 11 84 94 56 76
Skype: flavio.de.castro.alves.filho


2010/1/6 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Flavio de Castro Alves Filho wrote:
> > I believe there is a lockup during the irq handling process.
> >
> > I could not find where it is blocking.
> >
> > I performed the following tests:
> >
> > 1) add traces in every function related to interrupt ... and none was
> called
>
> Well, obviously, you missed some, because your boot logs indicate
> clearly that at least the timer interrupt is working.
>
> If you are interested in what happens at I-pipe level, the functions you
> are interested in are ipipe_grab_irq, ipipe_handle_irq,
> ipipe_mach_demux_irq, etc...
>
> >
> > 2) add traces in every function in time.c file. After the last message
> > ("ata1: SATA max UDMA/133 irq 67"), the following functions were called:
> > - read_cycles()
> > - timer32_read()
> >
> > Looking at these functions, they seam to be fine. I have no clue about
> where
> > to start debugging.
> >
> > Thank you for all your help.
>
> Try this:
>
> diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
> index 5a324c9..22ddbe2 100644
> --- a/arch/arm/mach-davinci/irq.c
> +++ b/arch/arm/mach-davinci/irq.c
> @@ -360,9 +360,11 @@ void __init davinci_irq_init(void)
>        for (i = 0; i < DAVINCI_N_AINTC_IRQ; i++) {
>                set_irq_chip(i, &davinci_irq_chip_0);
>                set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
> +#ifndef CONFIG_IPIPE
>                if (i != IRQ_TINT1_TINT34)
>                        set_irq_handler(i, handle_edge_irq);
>                else
> +#endif /* CONFIG_IPIPE */
>                        set_irq_handler(i, handle_level_irq);
>        }
>  }
>
> --
>                                             Gilles.
>

--00032555ac0295ba53047ca7c3b1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Gilles,<br><br>Unfortunately the patch didn&#39;t help... :-(<br><br>=
But ... adding more traces on the code, I can see the irq number when the f=
unction __ipipe_grab_irq() is called.<br><br>When everything works fine, th=
e irq number is 21 (IRQ_DA8XX_TINT12_0).<br>

<br>And, sometime, the irq number starts to be 22 (IRQ_DA8XX_TINT34_0).
It is the other timer present at the processor. I believe that,
somehow, the information about the timer (at least, the interrupt
location) has been changed by some code.<br>
<br>I will investigate more, according to these observations. I accept sugg=
estions :-)<br><br>Best regards,<br><br>Flavio<br><br clear=3D"all">Flavio =
de Castro Alves Filho<br>Phi Innovations - Embedded Software Services<br>
<a href=3D"http://www.phiinnovations.com">www.phiinnovations.com</a><br>Pho=
ne: +55 11 84 94 56 76<br>Skype: flavio.de.castro.alves.filho<br>
<br><br><div class=3D"gmail_quote">2010/1/6 Gilles Chanteperdrix <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.cha=
nteperdrix@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" =
style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8=
ex; padding-left: 1ex;">
<div class=3D"im">Flavio de Castro Alves Filho wrote:<br>
</div><div class=3D"im">&gt; I believe there is a lockup during the irq han=
dling process.<br>
&gt;<br>
&gt; I could not find where it is blocking.<br>
&gt;<br>
&gt; I performed the following tests:<br>
&gt;<br>
&gt; 1) add traces in every function related to interrupt ... and none was =
called<br>
<br>
</div>Well, obviously, you missed some, because your boot logs indicate<br>
clearly that at least the timer interrupt is working.<br>
<br>
If you are interested in what happens at I-pipe level, the functions you<br=
>
are interested in are ipipe_grab_irq, ipipe_handle_irq,<br>
ipipe_mach_demux_irq, etc...<br>
<div class=3D"im"><br>
&gt;<br>
&gt; 2) add traces in every function in time.c file. After the last message=
<br>
&gt; (&quot;ata1: SATA max UDMA/133 irq 67&quot;), the following functions =
were called:<br>
&gt; - read_cycles()<br>
&gt; - timer32_read()<br>
&gt;<br>
&gt; Looking at these functions, they seam to be fine. I have no clue about=
 where<br>
&gt; to start debugging.<br>
&gt;<br>
&gt; Thank you for all your help.<br>
<br>
</div>Try this:<br>
<br>
diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c<br>
index 5a324c9..22ddbe2 100644<br>
--- a/arch/arm/mach-davinci/irq.c<br>
+++ b/arch/arm/mach-davinci/irq.c<br>
@@ -360,9 +360,11 @@ void __init davinci_irq_init(void)<br>
 =A0 =A0 =A0 =A0for (i =3D 0; i &lt; DAVINCI_N_AINTC_IRQ; i++) {<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_irq_chip(i, &amp;davinci_irq_chip_0);<b=
r>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_irq_flags(i, IRQF_VALID | IRQF_PROBE);<=
br>
+#ifndef CONFIG_IPIPE<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (i !=3D IRQ_TINT1_TINT34)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_irq_handler(i, handle_e=
dge_irq);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else<br>
+#endif /* CONFIG_IPIPE */<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_irq_handler(i, handle_l=
evel_irq);<br>
 =A0 =A0 =A0 =A0}<br>
=A0}<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br>

--00032555ac0295ba53047ca7c3b1--

