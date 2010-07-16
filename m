MIME-Version: 1.0
In-Reply-To: <4C40015E.3030805@domain.hid>
References: <AANLkTinwyQgI26INSzLlvgyP2hlAmuziK7V3iNCVa8Nd@domain.hid>
	<4C3EFB0B.7050801@domain.hid>
	<AANLkTinH0vj7gAxa8LscV_-Hvmggo9LigQkp30nIUcz6@domain.hid>
	<4C3F192A.8080203@domain.hid>
	<AANLkTinJaCoe5nfcUuC25_0eOLJid1hk582uFdzRZT1_@domain.hid>
	<4C3F471F.4030002@domain.hid> <4C40015E.3030805@domain.hid>
Date: Fri, 16 Jul 2010 11:51:53 +0200
Message-ID: <AANLkTikE1IUPWQRiGDbw1BH0GL4zQA-2GY3bhceOnlb2@domain.hid>
From: Cyril Wallois <walloiscyril@domain.hid>
Content-Type: multipart/alternative; boundary=0015174c1aa82a8956048b7e2b46
Subject: Re: [Xenomai-help] [RTnet-users] Alignment problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

--0015174c1aa82a8956048b7e2b46
Content-Type: text/plain; charset=ISO-8859-1

Thanks for all Gilles.

Cyril

2010/7/16 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Gilles Chanteperdrix wrote:
> > Cyril Wallois wrote:
> >> I try show_stack(NULL,NULL)  after the Xenomai error message, but I have
> >> a lock up (the Xenomai code is not printing).
> >
> > Ok. Try adding a call to xnarch_trace_panic_freeze() before the call to
> > show_stack.
>
> Sorry, I meant rthal_emergency_console()
>
> --
>                                             Gilles.
>

--0015174c1aa82a8956048b7e2b46
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks for all Gilles.<br><br>Cyril<br><br><div class=3D"gmail_quote">2010/=
7/16 Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.ch=
anteperdrix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;</span><br><bl=
ockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-l=
eft: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
Gilles Chanteperdrix wrote:<br>
<div class=3D"im">&gt; Cyril Wallois wrote:<br>
&gt;&gt; I try show_stack(NULL,NULL) =A0after the Xenomai error message, bu=
t I have<br>
&gt;&gt; a lock up (the Xenomai code is not printing).<br>
&gt;<br>
&gt; Ok. Try adding a call to xnarch_trace_panic_freeze() before the call t=
o<br>
&gt; show_stack.<br>
<br>
</div>Sorry, I meant rthal_emergency_console()<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br>

--0015174c1aa82a8956048b7e2b46--

