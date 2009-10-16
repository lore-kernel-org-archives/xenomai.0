MIME-Version: 1.0
In-Reply-To: <4AD8241C.6090200@domain.hid>
References: <1f3e02580910132319v3ce08b2frb811d749def9f17@domain.hid>
	<4AD57CE3.4050206@domain.hid>
	<1f3e02580910152226h4fb94068kfce63fec4be38c3f@domain.hid>
	<4AD8241C.6090200@domain.hid>
Date: Fri, 16 Oct 2009 17:30:58 +0900
Message-ID: <1f3e02580910160130m69f35a2bl5ca2b40cabadbb56@domain.hid>
From: Didenko Sergey <didenkos@domain.hid>
Content-Type: multipart/alternative; boundary=00504502bfe91e31400476093769
Subject: Re: [Xenomai-help] Support for ARCH_MV88F6290
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
Cc: xenomai@xenomai.org, mohamad.sharifi@domain.hid

--00504502bfe91e31400476093769
Content-Type: text/plain; charset=UTF-8

Thank you very much Gilles, now I have this done with no Warnings...good.

Two things are remained:

1) warning message like "remember to run `libtool --finish
/usr/xenomai/lib'" which are printed out when I do command
make DESTDIR=/nfs/rootfs install

How should I run it for the board's rootfs (located on /nfs/rootfs) ?
Is this "libtool --finish /nfs/rootfs/usr/xenomai/lib" correct?
Should I add this path to my board's environment variable?

2) I really need your help how to compile and run test-suit on my board.

Sergey

2009/10/16 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Didenko Sergey wrote:
> > CROSS_COMPILE - arm-none-linux-gnueabi
>
> So, your compiler is named arm-none-linux-gnueabi-gcc
>
> > checking build system type... i686-pc-linux-gnu
> > checking host system type... arm-unknown-linux-gnu
> > checking for a BSD-compatible install... /usr/bin/install -c
> > checking for arm-linux-gcc... no
> > checking for gcc... gcc
> > configure: WARNING: using cross tools not prefixed with host triplet
>
> No need to go further. Here you know that something went wrong.
> configure tells you that it will use gcc (the x86 compiler) as compiler
> because it could not find a compiler named arm-linux-gcc. This will
> definitely not work.
>
> Your compiler is arm-none-linux-gnueabi-gcc, not arm-linux-gcc, so, you
> should either configure passing --host=arm-none-linux-gnueabi, or define
> the CC variable to be arm-none-linux-gnueabi-gcc.
>
> This is explained in README.INSTALL.
>
> --
>                                             Gilles.
>

--00504502bfe91e31400476093769
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thank you very much Gilles, now I have this done with no Warnings...good.<b=
r><br>Two things are remained:<br><br>1) warning message like &quot;remembe=
r to run `libtool --finish /usr/xenomai/lib&#39;&quot; which are printed ou=
t when I do command <br>
make DESTDIR=3D/nfs/rootfs install<br><br>How should I run it for the board=
&#39;s rootfs (located on /nfs/rootfs) ?<br>Is this &quot;libtool --finish =
/nfs/rootfs/usr/xenomai/lib&quot; correct?<br>Should I add this path to my =
board&#39;s environment variable?<br>
<br>2) I really need your help how to compile and run test-suit on my board=
.<br><br>Sergey<br><br><div class=3D"gmail_quote">2009/10/16 Gilles Chantep=
erdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im"=
>Didenko Sergey wrote:<br>
&gt; CROSS_COMPILE - arm-none-linux-gnueabi<br>
<br>
</div>So, your compiler is named arm-none-linux-gnueabi-gcc<br>
<div class=3D"im"><br>
&gt; checking build system type... i686-pc-linux-gnu<br>
&gt; checking host system type... arm-unknown-linux-gnu<br>
&gt; checking for a BSD-compatible install... /usr/bin/install -c<br>
&gt; checking for arm-linux-gcc... no<br>
&gt; checking for gcc... gcc<br>
&gt; configure: WARNING: using cross tools not prefixed with host triplet<b=
r>
<br>
</div>No need to go further. Here you know that something went wrong.<br>
configure tells you that it will use gcc (the x86 compiler) as compiler<br>
because it could not find a compiler named arm-linux-gcc. This will<br>
definitely not work.<br>
<br>
Your compiler is arm-none-linux-gnueabi-gcc, not arm-linux-gcc, so, you<br>
should either configure passing --host=3Darm-none-linux-gnueabi, or define<=
br>
the CC variable to be arm-none-linux-gnueabi-gcc.<br>
<br>
This is explained in README.INSTALL.<br>
<br>
--<br>
<font color=3D"#888888"> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Gilles.<br>
</font></blockquote></div><br>

--00504502bfe91e31400476093769--

