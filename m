MIME-Version: 1.0
In-Reply-To: <4C4823DC.4050500@domain.hid>
References: <AANLkTilWSsSuCKRxQg0NIkeeR28eqpdJfaVm_CiemnqF@mail.gmail.com>
	<4C46D49F.6030102@domain.hid>
	<AANLkTikJgzkkxQyM8DQqVz17ovJmPiIkdZMIFJImExIE@mail.gmail.com>
	<4C46F0D9.4030906@domain.hid>
	<AANLkTilP98GMfCx1rcgWto9eBmnDwtuavBteD8inFM6V@mail.gmail.com>
	<4C47F932.3060400@domain.hid>
	<AANLkTilP1f217jN3krm_Cdqu4LaYwpUMu6mMnLiUJq2f@domain.hid>
	<4C4823DC.4050500@domain.hid>
Date: Mon, 26 Jul 2010 11:27:58 +0100
Message-ID: <AANLkTi=GuZADaU-CedYiqBU1Bj_Li+EAQ_7ZJKXA_qRR@mail.gmail.com>
From: Stephen Bryant <sbxenomai@domain.hid>
Content-Type: multipart/alternative; boundary=001636a7da92a640af048c47d6d5
Subject: Re: [Xenomai-help] Unexpected preemption of highest priority thread
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

--001636a7da92a640af048c47d6d5
Content-Type: text/plain; charset=ISO-8859-1

On 22 July 2010 11:56, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Stephen Bryant wrote:
> > On 22 July 2010 08:54, Gilles Chanteperdrix <
> > gilles.chanteperdrix@xenomai.org> wrote:
> >
> >> Stephen Bryant wrote:
> >>> On 21 July 2010 14:06, Gilles Chanteperdrix
> >>> <gilles.chanteperdrix@xenomai.org
> >>> <mailto:gilles.chanteperdrix@xenomai.org>> wrote:
> >>>
> >>>     Stephen Bryant wrote:
> >>>     > I've had a look at dmesg, but cannot find any references to SMI -
> >> what
> >>>     > should I be looking for?
> >>>
> >>>     What is described in the TROUBLESHOOTING file.
> >>>
> >>>
> >>> I have tried disabling the SMI workaround, ensuring that SMI detection
> >>> is not disabled, and logging the kernel output (setting the kernel log
> >>> level to 8 in grub and sending the output to the serial port to be
> >>> picked up by another machine). The troubleshooting file states that I
> >>> should see "Xenomai: Intel chipset found and SMI workaround not
> >>> enabled, you may encounter high interrupt latencies." in this output,
> >>> however this does not occur - I am using an Intel Core 2 Duo but with
> >>> SMP disabled, if this has any relevance.
> >> The SMI detection/workaround is based on the chipset you have. If your
> >> chipset is an ICH10, Stefan posted a patch a few days ago. If it is
> >> another one, then please send us the result of lspci -vv on your target.
> >>
> >
> > It seems to be ICH8, so the result is attached,
>
> Please try with the following patch:
>
>
> --
>                                             Gilles.
>

With the patch applied and SMI Workaround not used I get the kernel message
as expected: "...SMI workaround not enabled...".

However, with the SMI Workaround enabled and Globally disabling SMI I get
the messages:
"Xenomai: SMI-enabled chipset found
Xenomai: SMI workaround failed!"

Steve

--001636a7da92a640af048c47d6d5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On 22 July 2010 11:56, Gilles Chanteperdrix <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gille=
s.chanteperdrix@domain.hid</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt=
 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class=3D"h5">Stephen Bryant wrote:<br>
&gt; On 22 July 2010 08:54, Gilles Chanteperdrix &lt;<br>
&gt; <a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdr=
ix@domain.hid</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; Stephen Bryant wrote:<br>
&gt;&gt;&gt; On 21 July 2010 14:06, Gilles Chanteperdrix<br>
&gt;&gt;&gt; &lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles=
.chanteperdrix@domain.hid</a><br>
&gt;&gt;&gt; &lt;mailto:<a href=3D"mailto:gilles.chanteperdrix@xenomai.org"=
>gilles.chanteperdrix@xenomai.org</a>&gt;&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =A0 =A0 Stephen Bryant wrote:<br>
&gt;&gt;&gt; =A0 =A0 &gt; I&#39;ve had a look at dmesg, but cannot find any=
 references to SMI -<br>
&gt;&gt; what<br>
&gt;&gt;&gt; =A0 =A0 &gt; should I be looking for?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =A0 =A0 What is described in the TROUBLESHOOTING file.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I have tried disabling the SMI workaround, ensuring that SMI d=
etection<br>
&gt;&gt;&gt; is not disabled, and logging the kernel output (setting the ke=
rnel log<br>
&gt;&gt;&gt; level to 8 in grub and sending the output to the serial port t=
o be<br>
&gt;&gt;&gt; picked up by another machine). The troubleshooting file states=
 that I<br>
&gt;&gt;&gt; should see &quot;Xenomai: Intel chipset found and SMI workarou=
nd not<br>
&gt;&gt;&gt; enabled, you may encounter high interrupt latencies.&quot; in =
this output,<br>
&gt;&gt;&gt; however this does not occur - I am using an Intel Core 2 Duo b=
ut with<br>
&gt;&gt;&gt; SMP disabled, if this has any relevance.<br>
&gt;&gt; The SMI detection/workaround is based on the chipset you have. If =
your<br>
&gt;&gt; chipset is an ICH10, Stefan posted a patch a few days ago. If it i=
s<br>
&gt;&gt; another one, then please send us the result of lspci -vv on your t=
arget.<br>
&gt;&gt;<br>
&gt;<br>
&gt; It seems to be ICH8, so the result is attached,<br>
<br>
</div></div>Please try with the following patch:<br>
<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br>With the patch applied and SMI Workaround not=
 used I get the kernel message as expected: &quot;...SMI workaround not ena=
bled...&quot;.<br><br>However, with the SMI Workaround enabled and Globally=
 disabling SMI I get the messages:<br>
&quot;Xenomai: SMI-enabled chipset found<br>Xenomai: SMI workaround failed!=
&quot;<br><br>Steve<br>

--001636a7da92a640af048c47d6d5--

