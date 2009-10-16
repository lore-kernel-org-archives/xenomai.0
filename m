MIME-Version: 1.0
In-Reply-To: <4AD832CB.20004@domain.hid>
References: <1f3e02580910132319v3ce08b2frb811d749def9f17@domain.hid>
	<4AD57CE3.4050206@domain.hid>
	<1f3e02580910152226h4fb94068kfce63fec4be38c3f@domain.hid>
	<4AD8241C.6090200@domain.hid>
	<1f3e02580910160130m69f35a2bl5ca2b40cabadbb56@domain.hid>
	<4AD832CB.20004@domain.hid>
Date: Fri, 16 Oct 2009 17:56:29 +0900
Message-ID: <1f3e02580910160156t4635216if9ac722304750d65@domain.hid>
From: Didenko Sergey <didenkos@domain.hid>
Content-Type: multipart/alternative; boundary=0016368e223a5d3c24047609928b
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

--0016368e223a5d3c24047609928b
Content-Type: text/plain; charset=UTF-8

Thank a lot Gilles, it is working!

2009/10/16 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Didenko Sergey wrote:
> > Thank you very much Gilles, now I have this done with no Warnings...good.
> >
> > Two things are remained:
> >
> > 1) warning message like "remember to run `libtool --finish
> > /usr/xenomai/lib'" which are printed out when I do command
> > make DESTDIR=/nfs/rootfs install
> >
> > How should I run it for the board's rootfs (located on /nfs/rootfs) ?
> > Is this "libtool --finish /nfs/rootfs/usr/xenomai/lib" correct?
> > Should I add this path to my board's environment variable?
>
> You can safely ignore these messages.
>
> >
> > 2) I really need your help how to compile and run test-suit on my board.
>
> If for instance you want to run latency on your board, then boot your
> board, log on your board, then type:
>
> cd /usr/xenomai/share/testsuite/latency
> ./run -- -p 1000
>
> --
>                                           Gilles
>
>

--0016368e223a5d3c24047609928b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thank a lot Gilles, it is working!<div><br><div><div><br><div class=3D"gmai=
l_quote">2009/10/16 Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a=
>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">Didenko Sergey wrote:<br>
&gt; Thank you very much Gilles, now I have this done with no Warnings...go=
od.<br>
&gt;<br>
&gt; Two things are remained:<br>
&gt;<br>
&gt; 1) warning message like &quot;remember to run `libtool --finish<br>
&gt; /usr/xenomai/lib&#39;&quot; which are printed out when I do command<br=
>
&gt; make DESTDIR=3D/nfs/rootfs install<br>
&gt;<br>
&gt; How should I run it for the board&#39;s rootfs (located on /nfs/rootfs=
) ?<br>
&gt; Is this &quot;libtool --finish /nfs/rootfs/usr/xenomai/lib&quot; corre=
ct?<br>
&gt; Should I add this path to my board&#39;s environment variable?<br>
<br>
</div>You can safely ignore these messages.<br>
<div class=3D"im"><br>
&gt;<br>
&gt; 2) I really need your help how to compile and run test-suit on my boar=
d.<br>
<br>
</div>If for instance you want to run latency on your board, then boot your=
<br>
board, log on your board, then type:<br>
<br>
cd /usr/xenomai/share/testsuite/latency<br>
./run -- -p 1000<br>
<br>
--<br>
<font color=3D"#888888"> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0Gilles<br>
<br>
</font></blockquote></div><br></div></div></div>

--0016368e223a5d3c24047609928b--

