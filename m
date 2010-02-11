MIME-Version: 1.0
In-Reply-To: <4B745CAB.5000404@domain.hid>
References: <8b216e9e1002100327h3aa332ddl13ec590fcb81f0b7@domain.hid> 
	<8b216e9e1002100358u71d73d36xb851e59e23e069d1@domain.hid> 
	<4B72C18F.20903@domain.hid>
	<8b216e9e1002101128t1246a5deh28ca13229f1d688d@domain.hid> 
	<8b216e9e1002111005h6b432bcby17d4127d3b9d385a@domain.hid> 
	<4B7447AD.5050401@domain.hid>
	<8b216e9e1002111024h7c87d0c1n9f36a91602e52cd6@domain.hid> 
	<4B744ED4.2000200@domain.hid>
	<8b216e9e1002111053gf6b4b2mf605e8c3b9f1c235@domain.hid> 
	<4B745CAB.5000404@domain.hid>
From: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Date: Thu, 11 Feb 2010 18:15:18 -0200
Message-ID: <8b216e9e1002111215h1c1dac81w1a1ca1d19a37378c@domain.hid>
Content-Type: multipart/alternative; boundary=00504502b535778440047f58d0a8
Subject: Re: [Xenomai-help] Problems when cross-compiling Xenomai
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
Cc: Xenomai help <xenomai@xenomai.org>

--00504502b535778440047f58d0a8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2010/2/11 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Felipe Brand=E3o Cavalcanti wrote:
> > 2010/2/11 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org=
>
> >
> >> Felipe Brand=E3o Cavalcanti wrote:
> >>> Sending the boot log and the xeno-test output as attachments.
> >> [    0.000000] OMAP clockevent source: GPTIMER12 at 32768 Hz
> >>
> >> Definitely not OK. We do not want this unprecise clockevent source.
> >> Disable it in the kernel configuration (option CONFIG_OMAP_32K_TIMER).
> >>
> >>
> > This is very interesting - this option doesnt seem to be set in my
> current
> > kernel config. Ive attached my .config.
>
> Selecting GPTIMER 1 should work. But if you get lockups or thing like
> that, please try with a vanilla 2.6.30 to see if you get them.
>
>
Great - changing GPTIMER to 1 did the trick! Gilles, thank you very much!

Here are the results of the first latency test, under 100% load:

RTT|  00:08:46  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat
worst
RTD|     12.999|     13.769|     18.846|       0|     0|     12.538|
44.692
RTD|     13.076|     13.769|     20.692|       0|     0|     12.538|
44.692
RTD|     12.923|     13.769|     18.076|       0|     0|     12.538|
44.692
RTD|     12.846|     13.769|     20.153|       0|     0|     12.538|
44.692
RTD|     12.999|     13.769|     18.692|       0|     0|     12.538|
44.692
RTD|     12.999|     13.769|     19.230|       0|     0|     12.538|
44.692
RTD|     13.076|     13.769|     18.769|       0|     0|     12.538|
44.692
RTD|     13.076|     13.769|     19.153|       0|     0|     12.538|
44.692
RTD|     12.846|     13.769|     19.999|       0|     0|     12.538|
44.692

BTW, the system does seem a lot more stable now - no random errors. I will
run some more tests, and will send in the results later - I will document
the procedure and post it online once we get Xenomai running well in the
IGEPv2.


> --
> Gilles Chanteperdrix, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
>
>


--=20
      -Felipe Brand=E3o Cavalcanti
      LARA - Robotics and Automation Laboratory
      Department of Electrical Engineering
      UnB - University of Bras=EDlia, Brazil
      http://www.lara.unb.br/~fbcavalcanti/

--00504502b535778440047f58d0a8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2010/2/11 Gilles Chanteperdrix <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gil=
les.chanteperdrix@domain.hid</a>&gt;</span><br><blockquote class=3D=
"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0=
pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<div class=3D"im">Felipe Brand=E3o Cavalcanti wrote:<br>
&gt; 2010/2/11 Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.chanteperd=
rix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;<br>
&gt;<br>
&gt;&gt; Felipe Brand=E3o Cavalcanti wrote:<br>
&gt;&gt;&gt; Sending the boot log and the xeno-test output as attachments.<=
br>
&gt;&gt; [ =A0 =A00.000000] OMAP clockevent source: GPTIMER12 at 32768 Hz<b=
r>
&gt;&gt;<br>
&gt;&gt; Definitely not OK. We do not want this unprecise clockevent source=
.<br>
&gt;&gt; Disable it in the kernel configuration (option CONFIG_OMAP_32K_TIM=
ER).<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; This is very interesting - this option doesnt seem to be set in my cur=
rent<br>
&gt; kernel config. Ive attached my .config.<br>
<br>
</div>Selecting GPTIMER 1 should work. But if you get lockups or thing like=
<br>
that, please try with a vanilla 2.6.30 to see if you get them.<br>
<font color=3D"#888888"><br></font></blockquote><div><br>Great - changing G=
PTIMER to 1 did the trick! Gilles, thank you very much!<br><br>Here are the=
 results of the first latency test, under 100% load:<br><br>RTT|=A0 00:08:4=
6=A0 (periodic user-mode task, 1000 us period, priority 99)<br>

RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst<br>RTD|=A0=A0=A0=A0 12.999|=A0=A0=A0=A0 13.769|=A0=A0=A0=A0 18.846|=A0=
=A0=A0=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0 12.538|=A0=A0=A0=A0 44.692<br=
>RTD|=A0=A0=A0=A0 13.076|=A0=A0=A0=A0 13.769|=A0=A0=A0=A0 20.692|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0 12.538|=A0=A0=A0=A0 44.692<br>

RTD|=A0=A0=A0=A0 12.923|=A0=A0=A0=A0 13.769|=A0=A0=A0=A0 18.076|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0 12.538|=A0=A0=A0=A0 44.692<br>RTD|=
=A0=A0=A0=A0 12.846|=A0=A0=A0=A0 13.769|=A0=A0=A0=A0 20.153|=A0=A0=A0=A0=A0=
=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0 12.538|=A0=A0=A0=A0 44.692<br>RTD|=A0=A0=
=A0=A0 12.999|=A0=A0=A0=A0 13.769|=A0=A0=A0=A0 18.692|=A0=A0=A0=A0=A0=A0 0|=
=A0=A0=A0=A0 0|=A0=A0=A0=A0 12.538|=A0=A0=A0=A0 44.692<br>

RTD|=A0=A0=A0=A0 12.999|=A0=A0=A0=A0 13.769|=A0=A0=A0=A0 19.230|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0 12.538|=A0=A0=A0=A0 44.692<br>RTD|=
=A0=A0=A0=A0 13.076|=A0=A0=A0=A0 13.769|=A0=A0=A0=A0 18.769|=A0=A0=A0=A0=A0=
=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0 12.538|=A0=A0=A0=A0 44.692<br>RTD|=A0=A0=
=A0=A0 13.076|=A0=A0=A0=A0 13.769|=A0=A0=A0=A0 19.153|=A0=A0=A0=A0=A0=A0 0|=
=A0=A0=A0=A0 0|=A0=A0=A0=A0 12.538|=A0=A0=A0=A0 44.692<br>

RTD|=A0=A0=A0=A0 12.846|=A0=A0=A0=A0 13.769|=A0=A0=A0=A0 19.999|=A0=A0=A0=
=A0=A0=A0 0|=A0=A0=A0=A0 0|=A0=A0=A0=A0 12.538|=A0=A0=A0=A0 44.692<br><br>B=
TW, the system does seem a lot more stable now - no random errors. I will r=
un some more tests, and will send in the results later - I will document th=
e procedure and post it online once we get Xenomai running well in the IGEP=
v2.<br>

=A0</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><font co=
lor=3D"#888888">
--<br>
</font><div><div></div><div class=3D"h5">Gilles Chanteperdrix, Free Electro=
ns<br>
Kernel, drivers, real-time and embedded Linux<br>
development, consulting, training and support.<br>
<a href=3D"http://free-electrons.com" target=3D"_blank">http://free-electro=
ns.com</a><br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br> =A0 =A0 =
=A0 -Felipe Brand=E3o Cavalcanti<br> =A0 =A0 =A0 LARA - Robotics and Automa=
tion Laboratory<br> =A0 =A0 =A0 Department of Electrical Engineering<br> =
=A0 =A0 =A0 UnB - University of Bras=EDlia, Brazil<br>

 =A0 =A0 =A0 <a href=3D"http://www.lara.unb.br/~fbcavalcanti/">http://www.l=
ara.unb.br/~fbcavalcanti/</a><br>

--00504502b535778440047f58d0a8--

