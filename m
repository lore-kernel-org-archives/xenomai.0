MIME-Version: 1.0
In-Reply-To: <4AC63536.2010802@domain.hid>
References: <1f3e02580909300343y3bf44fedh8dbc8d7e27fead4d@domain.hid>
	<4AC346C7.4040600@domain.hid>
	<1f3e02580910020652p7bc52284p7e26573669e1a05b@domain.hid>
	<4AC63536.2010802@domain.hid>
Date: Sat, 3 Oct 2009 10:55:11 +0900
Message-ID: <1f3e02580910021855i294d2677x8da7cb0539f90490@domain.hid>
From: Didenko Sergey <didenkos@domain.hid>
Content-Type: multipart/alternative; boundary=001636e9144bc4ea9a0474fe2b03
Subject: Re: [Xenomai-help] [Guide] To patch Linux Kernel with Xenomai for
	Unknown core
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

--001636e9144bc4ea9a0474fe2b03
Content-Type: text/plain; charset=UTF-8

>
> > *Gilles:*
> > No, you should not add these functions. They already exist if your board
> > supports GENERIC_CLOCKEVENT and GENERIC_TIME.
> >
> > *Sergey:*
> > Unfortunately no, there is no these functions for my board, there are
> only
> > for "arm\mach-pxa" and "arm\mach-sa1100".
>
> *Gilles:*

> Then your board does not support GENERIC_CLOCKEVENT and GENERIC_TIME,
> and you should skip the section about it in the howto.
>

*Q1: But, so far as these options are defined in kernel's .config file, does
it effect somehow on how the kernel's code has been patched when I made
Xenomai\prepare_kernel?*
*
*
Sergey

--001636e9144bc4ea9a0474fe2b03
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;"><div class=3D"im=
">&gt; *Gilles:*<br>
&gt; No, you should not add these functions. They already exist if your boa=
rd<br>
&gt; supports GENERIC_CLOCKEVENT and GENERIC_TIME.<br>
&gt;<br>
&gt; *Sergey:*<br>
&gt; Unfortunately no, there is no these functions for my board, there are =
only<br>
&gt; for &quot;arm\mach-pxa&quot; and &quot;arm\mach-sa1100&quot;.<br>
<br></div></blockquote><div>*Gilles:*=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex;"><div class=3D"im">
</div>Then your board does not support GENERIC_CLOCKEVENT and GENERIC_TIME,=
<br>
and you should skip the section about it in the howto.<br>
</blockquote><div>=C2=A0</div><div><b>Q1: But, so far as these options are =
defined in kernel&#39;s .config file, does it effect somehow on how the ker=
nel&#39;s code has been patched when I made Xenomai\prepare_kernel?</b></di=
v>
<div><b><br></b></div><div>Sergey</div></div>

--001636e9144bc4ea9a0474fe2b03--

