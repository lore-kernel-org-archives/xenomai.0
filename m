MIME-Version: 1.0
In-Reply-To: <4C4D9171.5000202@domain.hid>
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
	<AANLkTim4ZHVhPbzwX5skDWujFcA2d8ceUgUoEvs_R5S1@domain.hid>
	<4C4D9171.5000202@domain.hid>
Date: Tue, 27 Jul 2010 14:20:41 +0100
Message-ID: <AANLkTi=NSEHpoxYHM0HmjtA-xW7Ec69eTgryOYzrvRhC@mail.gmail.com>
From: Stephen Bryant <sbxenomai@domain.hid>
Content-Type: multipart/alternative; boundary=001485f03f742d262c048c5e5eab
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

--001485f03f742d262c048c5e5eab
Content-Type: text/plain; charset=ISO-8859-1

On 26 July 2010 14:45, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Stephen Bryant wrote:
> > Do you mean enabling / disabling the individual options in the SMI
> > Workaround section of the kernel config file, or are you suggesting
> > something lower level / something else?
>
> The options in the SMI workaround section of the kernel config file
> actually disable some bits in some SMI registers, so they are already
> low level. Anyway, yes, it is what I ask you to do.
>
>
> --
>                                             Gilles.
>

I've been looking into this when I've had the time and the results so far
are that:
- Globally disabling SMI fails.
- Disabling all 8 'non-global' SMI options succeeds, but does not change my
latency results.

>From this I conclude that 'Globally disable SMI' really does try to disable
every SMI signal, which is different from just deselecting each of the 8
'Enable ... SMI' options presented, which I had not realised. Also, my
problem may still be SMI related, and I can only test this if I can convince
the BIOS to allow global SMI disabling.

So my next steps are to:
1 - Look for ways to change or circumvent the BIOS (if possible).
2 - Try a few other kernel settings (for examples the timers available) to
find out if my issue stems from something other than SMIs.
3 - Progressively change the Xenomai SMI disabling code to test SMIs not
covered by the 8 options presented.

I'll be checking the literature for help with these, but if anyone has any
pointers that would be much appreciated,

Steve

--001485f03f742d262c048c5e5eab
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On 26 July 2010 14:45, Gilles Chanteperdrix <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gille=
s.chanteperdrix@domain.hid</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt=
 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">Stephen Bryant wrote:<br>
&gt; Do you mean enabling / disabling the individual options in the SMI<br>
&gt; Workaround section of the kernel config file, or are you suggesting<br=
>
&gt; something lower level / something else?<br>
<br>
</div>The options in the SMI workaround section of the kernel config file<b=
r>
actually disable some bits in some SMI registers, so they are already<br>
low level. Anyway, yes, it is what I ask you to do.<br>
<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br>I&#39;ve been looking into this when I&#39;ve=
 had the time and the results so far are that:<br>- Globally disabling SMI =
fails.<br>- Disabling all 8 &#39;non-global&#39; SMI options succeeds, but =
does not change my latency results.<br>
<br>From this I conclude that &#39;Globally disable SMI&#39; really does tr=
y to disable every SMI signal, which is different from just deselecting eac=
h of the 8 &#39;Enable ... SMI&#39; options presented, which I had not real=
ised. Also, my problem may still be SMI related, and I can only test this i=
f I can convince the BIOS to allow global SMI disabling.<br>
<br>So my next steps are to:<br>1 - Look for ways to change or circumvent t=
he BIOS (if possible).<br>2 - Try a few other kernel settings (for examples=
 the timers available) to find out if my issue stems from something other t=
han SMIs.<br>
3 - Progressively change the Xenomai SMI disabling code to test SMIs not co=
vered by the 8 options presented.<br><br>I&#39;ll be checking the literatur=
e for help with these, but if anyone has any pointers that would be much ap=
preciated,<br>
<br>Steve<br>

--001485f03f742d262c048c5e5eab--

