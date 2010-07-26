MIME-Version: 1.0
In-Reply-To: <4C4D7B8E.4000309@domain.hid>
References: <AANLkTilWSsSuCKRxQg0NIkeeR28eqpdJfaVm_CiemnqF@mail.gmail.com>
	<4C46D49F.6030102@domain.hid>
	<AANLkTikJgzkkxQyM8DQqVz17ovJmPiIkdZMIFJImExIE@mail.gmail.com>
	<4C46F0D9.4030906@domain.hid>
	<AANLkTilP98GMfCx1rcgWto9eBmnDwtuavBteD8inFM6V@mail.gmail.com>
	<4C47F932.3060400@domain.hid>
	<AANLkTilP1f217jN3krm_Cdqu4LaYwpUMu6mMnLiUJq2f@domain.hid>
	<4C4823DC.4050500@domain.hid>
	<AANLkTi=GuZADaU-CedYiqBU1Bj_Li+EAQ_7ZJKXA_qRR@mail.gmail.com>
	<4C4D7B8E.4000309@domain.hid>
Date: Mon, 26 Jul 2010 13:31:28 +0100
Message-ID: <AANLkTim4ZHVhPbzwX5skDWujFcA2d8ceUgUoEvs_R5S1@domain.hid>
From: Stephen Bryant <sbxenomai@domain.hid>
Content-Type: multipart/alternative; boundary=0016364267ab5219d6048c4990cc
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

--0016364267ab5219d6048c4990cc
Content-Type: text/plain; charset=ISO-8859-1

On 26 July 2010 13:11, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> >>>>>
> >>>>>     Stephen Bryant wrote:
> >>>>>     > I've had a look at dmesg, but cannot find any references to SMI
> -
> >>>> what
> >>>>>     > should I be looking for?
> >>>>>
> >>>>>     What is described in the TROUBLESHOOTING file.
> >>>>>
> >>>>>
> >>>>> I have tried disabling the SMI workaround, ensuring that SMI
> detection
> >>>>> is not disabled, and logging the kernel output (setting the kernel
> log
> >>>>> level to 8 in grub and sending the output to the serial port to be
> >>>>> picked up by another machine). The troubleshooting file states that I
> >>>>> should see "Xenomai: Intel chipset found and SMI workaround not
> >>>>> enabled, you may encounter high interrupt latencies." in this output,
> >>>>> however this does not occur - I am using an Intel Core 2 Duo but with
> >>>>> SMP disabled, if this has any relevance.
> >>>> The SMI detection/workaround is based on the chipset you have. If your
> >>>> chipset is an ICH10, Stefan posted a patch a few days ago. If it is
> >>>> another one, then please send us the result of lspci -vv on your
> target.
> >>>>
> >>> It seems to be ICH8, so the result is attached,
> >> Please try with the following patch:
> >>
> >>
> >> --
> >>                                             Gilles.
> >>
> >
> > With the patch applied and SMI Workaround not used I get the kernel
> message
> > as expected: "...SMI workaround not enabled...".
> >
> > However, with the SMI Workaround enabled and Globally disabling SMI I get
> > the messages:
> > "Xenomai: SMI-enabled chipset found
> > Xenomai: SMI workaround failed!"
>
> It probably means that your board manufacturer has decided, at BIOS
> level, to prevent you from disabling the SMIs. You may want to try
> disabling the SMI bits one by one.
>
> --
>                                             Gilles.
>

Do you mean enabling / disabling the individual options in the SMI
Workaround section of the kernel config file, or are you suggesting
something lower level / something else?

Steve

--0016364267ab5219d6048c4990cc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On 26 July 2010 13:11, Gilles Chanteperd=
rix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
g">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); mar=
gin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class=3D"h5">
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; =A0 =A0 Stephen Bryant wrote:<br>
&gt;&gt;&gt;&gt;&gt; =A0 =A0 &gt; I&#39;ve had a look at dmesg, but cannot =
find any references to SMI -<br>
&gt;&gt;&gt;&gt; what<br>
&gt;&gt;&gt;&gt;&gt; =A0 =A0 &gt; should I be looking for?<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; =A0 =A0 What is described in the TROUBLESHOOTING file.=
<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; I have tried disabling the SMI workaround, ensuring th=
at SMI detection<br>
&gt;&gt;&gt;&gt;&gt; is not disabled, and logging the kernel output (settin=
g the kernel log<br>
&gt;&gt;&gt;&gt;&gt; level to 8 in grub and sending the output to the seria=
l port to be<br>
&gt;&gt;&gt;&gt;&gt; picked up by another machine). The troubleshooting fil=
e states that I<br>
&gt;&gt;&gt;&gt;&gt; should see &quot;Xenomai: Intel chipset found and SMI =
workaround not<br>
&gt;&gt;&gt;&gt;&gt; enabled, you may encounter high interrupt latencies.&q=
uot; in this output,<br>
&gt;&gt;&gt;&gt;&gt; however this does not occur - I am using an Intel Core=
 2 Duo but with<br>
&gt;&gt;&gt;&gt;&gt; SMP disabled, if this has any relevance.<br>
&gt;&gt;&gt;&gt; The SMI detection/workaround is based on the chipset you h=
ave. If your<br>
&gt;&gt;&gt;&gt; chipset is an ICH10, Stefan posted a patch a few days ago.=
 If it is<br>
&gt;&gt;&gt;&gt; another one, then please send us the result of lspci -vv o=
n your target.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; It seems to be ICH8, so the result is attached,<br>
&gt;&gt; Please try with the following patch:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 Gilles.<br>
&gt;&gt;<br>
&gt;<br>
&gt; With the patch applied and SMI Workaround not used I get the kernel me=
ssage<br>
&gt; as expected: &quot;...SMI workaround not enabled...&quot;.<br>
&gt;<br>
&gt; However, with the SMI Workaround enabled and Globally disabling SMI I =
get<br>
&gt; the messages:<br>
&gt; &quot;Xenomai: SMI-enabled chipset found<br>
&gt; Xenomai: SMI workaround failed!&quot;<br>
<br>
</div></div>It probably means that your board manufacturer has decided, at =
BIOS<br>
level, to prevent you from disabling the SMIs. You may want to try<br>
disabling the SMI bits one by one.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br>Do you mean enabling / disabling the individu=
al options in the SMI
Workaround section of the kernel config file, or are you suggesting
something lower level / something else?<br><br>Steve<br>

--0016364267ab5219d6048c4990cc--

