MIME-Version: 1.0
In-Reply-To: <4F06C291.6020402@domain.hid>
References: <CAP1XtZx2JdZAs3SvbWGC8vkuwo+V5v8d69EBvBGzKmKLGi0iPQ@mail.gmail.com>
	<4F06C291.6020402@domain.hid>
Date: Mon, 9 Jan 2012 16:22:41 +0100
Message-ID: <CAP1XtZxO5_wF02Dt2m_4CF+EQ34zQ68Hany+QRonY1Zxpv7Obg@domain.hid>
From: Santiago Focke <focke.85@domain.hid>
Content-Type: multipart/alternative; boundary=f46d0447850b3d1a1404b619f874
Subject: Re: [Xenomai-help] Problems with installation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--f46d0447850b3d1a1404b619f874
Content-Type: text/plain; charset=ISO-8859-1

Thanks for your reply.

As I told you, I am really new with linux. I've been trying to find the
kernel source tree and not just the headers, but I haven't been able to do
it. I read that it is normally located in /usr/src/, but there I just have
the headers. How can I search the right path of the kernel source tree to
prepare the kernel?

Regards,

2012/1/6 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 01/05/2012 08:16 PM, Santiago Focke wrote:
> > Hi all
> >
> > I'm quite new with Linux and Xenomai. I'm using Ubunto kernel
> > 2.6.32-24-generic. I tied to install Xenomai-2.6 following the
> > README.INSTALL document. First of all I cloned the GIT repository in
> >
> > /usr/src/xenomai-2.6
> >
> > After that, I tried to run the prepare-kernel.sh script as follows:
> >
> > /usr/src/xenomai-2.6/scripts/prepare-kernel.sh
> > --linux=/usr/src/linux-headers-2.6.32-24-generic/
>
> That is not going to work. Xenomai patches the kernel sources, and ask
> you to rebuild a kernel, just supplying the headers will not work.
>
>
> --
>                                            Gilles.
>



-- 
Ing. Santiago Focke

--f46d0447850b3d1a1404b619f874
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks for your reply.<div><br></div><div>As I told you, I am really new wi=
th linux. I&#39;ve been trying to find the kernel source tree and not just =
the headers, but I haven&#39;t been able to do it. I read that it is normal=
ly located in /usr/src/, but there I just have the headers. How can I searc=
h the right path of the=A0kernel source tree=A0to prepare the kernel?</div>
<div><br></div><div>Regards,<br><br><div class=3D"gmail_quote">2012/1/6 Gil=
les Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperd=
rix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;</span><br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">
<div class=3D"im">On 01/05/2012 08:16 PM, Santiago Focke wrote:<br>
&gt; Hi all<br>
&gt;<br>
&gt; I&#39;m quite new with Linux and Xenomai. I&#39;m using Ubunto kernel<=
br>
&gt; 2.6.32-24-generic. I tied to install Xenomai-2.6 following the<br>
&gt; README.INSTALL document. First of all I cloned the GIT repository in<b=
r>
&gt;<br>
&gt; /usr/src/xenomai-2.6<br>
&gt;<br>
&gt; After that, I tried to run the prepare-kernel.sh script as follows:<br=
>
&gt;<br>
&gt; /usr/src/xenomai-2.6/scripts/prepare-kernel.sh<br>
&gt; --linux=3D/usr/src/linux-headers-2.6.32-24-generic/<br>
<br>
</div>That is not going to work. Xenomai patches the kernel sources, and as=
k<br>
you to rebuild a kernel, just supplying the headers will not work.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r>Ing. Santiago Focke<br>
</div>

--f46d0447850b3d1a1404b619f874--

