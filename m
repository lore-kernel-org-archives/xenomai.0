MIME-Version: 1.0
In-Reply-To: <4AC346C7.4040600@domain.hid>
References: <1f3e02580909300343y3bf44fedh8dbc8d7e27fead4d@domain.hid>
	<4AC346C7.4040600@domain.hid>
Date: Fri, 2 Oct 2009 22:52:22 +0900
Message-ID: <1f3e02580910020652p7bc52284p7e26573669e1a05b@domain.hid>
From: Didenko Sergey <didenkos@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd14730c7390a0474f4123c
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

--000e0cd14730c7390a0474f4123c
Content-Type: text/plain; charset=UTF-8

>
> > For now on I have done with:
> >
> > - prepare kernel with adeos patch
> > - configure kernel with its original defconfig file (the original
> > configuration is verified and working fine on target board)
> > - building kernel (and here we are!)
> >
> > 2) I did add implementation for (even though the  I did not find any
> > link to it in HOWTO, so I referred to PXA's implementation):
> > __ipipe_check_tickdev (called from kernel\core.c)
> >
> > And for:
> > mv88f6290_osmr0_set_mode
> > mv88f6290_osmr0_set_next_event
> > ckevt_mv88f6290_osmr0
>
> > Even though all of them are required by __ipipe_mach_release_timer() I
> > did not find in HOWTO how these functions should be implemented for
> > MYCORE, so I referred to PXA's implementation again.
>

*Gilles:*
No, you should not add these functions. They already exist if your board
supports GENERIC_CLOCKEVENT and GENERIC_TIME.

*Sergey:*
Unfortunately no, there is no these functions for my board, there are only
for "arm\mach-pxa" and "arm\mach-sa1100".

*Q1: Does the fact that these options are enabled or disabled in kernel's
.config file effects on how kernel code has been patched?*
*
*
*Q2: Could anyone please explaine more exactly what do these options
(GENERIC_CLOCKEVENT
and GENERIC_TIME) mean? What are they doing and how? I realy want to
understand it, but can not find any information about it.*

--000e0cd14730c7390a0474f4123c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"borde=
r-left:1px solid rgb(204, 204, 204);margin:0pt 0pt 0pt 0.8ex;padding-left:1=
ex"><div><div>
&gt; For now on I have done with:<br>
&gt;<br>
&gt; - prepare kernel with adeos patch<br>
&gt; - configure kernel with its original defconfig file (the original<br>
&gt; configuration is verified and working fine on target board)<br>
&gt; - building kernel (and here we are!)<br>
&gt;<br>
&gt; 2) I did add implementation for (even though the =C2=A0I did not find =
any<br>
&gt; link to it in HOWTO, so I referred to PXA&#39;s implementation):<br>
&gt; __ipipe_check_tickdev (called from kernel\core.c)<br>
&gt;<br>
&gt; And for:<br>
&gt; mv88f6290_osmr0_set_mode<br>
&gt; mv88f6290_osmr0_set_next_event<br>
&gt; ckevt_mv88f6290_osmr0<br>
<br>
&gt; Even though all of them are required by __ipipe_mach_release_timer() I=
<br>
&gt; did not find in HOWTO how these functions should be implemented for<br=
>
&gt; MYCORE, so I referred to PXA&#39;s implementation again.</div></div></=
blockquote><div><br><b>Gilles:</b> <br>No, you should not add these functio=
ns. They already exist if your board<br>supports GENERIC_CLOCKEVENT and GEN=
ERIC_TIME.<br>

</div><div><br><b>Sergey:</b><br>Unfortunately no, there is no these functi=
ons for my board, there are only for &quot;arm\mach-pxa&quot; and &quot;arm=
\mach-sa1100&quot;.<br>

<br><b>Q1: Does the fact that these options are enabled or disabled in kern=
el&#39;s .config file effects on how kernel code has been patched?</b><br><=
b><br></b></div><div><b>Q2: Could anyone please explaine more exactly what =
do these options (<span class=3D"Apple-style-span" style=3D"font-weight: no=
rmal; "><b>GENERIC_CLOCKEVENT and GENERIC_TIME)</b><span class=3D"Apple-sty=
le-span" style=3D"font-weight: bold; "> mean? What are they doing and how? =
I realy want to understand it, but can not find any information about it.</=
span></span></b></div>
</div>

--000e0cd14730c7390a0474f4123c--

