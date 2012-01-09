Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: multipart/alternative; boundary=Apple-Mail-1--71453244
From: Tadele Shiferaw <metitad@domain.hid>
In-Reply-To: <CAP1XtZxO5_wF02Dt2m_4CF+EQ34zQ68Hany+QRonY1Zxpv7Obg@domain.hid>
Date: Mon, 9 Jan 2012 17:54:57 +0100
Message-Id: <C3C5060F-9149-43FE-9A41-CA0AF296B2D2@domain.hid>
References: <CAP1XtZx2JdZAs3SvbWGC8vkuwo+V5v8d69EBvBGzKmKLGi0iPQ@mail.gmail.com>
	<4F06C291.6020402@domain.hid>
	<CAP1XtZxO5_wF02Dt2m_4CF+EQ34zQ68Hany+QRonY1Zxpv7Obg@domain.hid>
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
To: Santiago Focke <focke.85@domain.hid>
Cc: xenomai@xenomai.org


--Apple-Mail-1--71453244
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On Jan 9, 2012, at 4:22 PM, Santiago Focke wrote:

> Thanks for your reply.
>=20
> As I told you, I am really new with linux. I've been trying to find =
the kernel source tree and not just the headers, but I haven't been able =
to do it. I read that it is normally located in /usr/src/, but there I =
just have the headers. How can I search the right path of the kernel =
source tree to prepare the kernel?
>=20

Rather than using the kernel headers from ubuntu, clone a new kernel =
copy in /usr/src and try to patch that.=20

> Regards,

Tadele
>=20
> 2012/1/6 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
> > --linux=3D/usr/src/linux-headers-2.6.32-24-generic/
>=20
> That is not going to work. Xenomai patches the kernel sources, and ask
> you to rebuild a kernel, just supplying the headers will not work.
>=20
>=20
> --
>                                            Gilles.
>=20
>=20
>=20
> --=20
> Ing. Santiago Focke
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--Apple-Mail-1--71453244
Content-Transfer-Encoding: 7bit
Content-Type: text/html;
	charset=us-ascii

<html><head></head><body style="word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space; "><br><div><div>On Jan 9, 2012, at 4:22 PM, Santiago Focke wrote:</div><br class="Apple-interchange-newline"><blockquote type="cite">Thanks for your reply.<div><br></div><div>As I told you, I am really new with linux. I've been trying to find the kernel source tree and not just the headers, but I haven't been able to do it. I read that it is normally located in /usr/src/, but there I just have the headers. How can I search the right path of the&nbsp;kernel source tree&nbsp;to prepare the kernel?</div>
<div><br></div></blockquote><div><br></div>Rather than using the kernel headers from ubuntu, clone a new kernel copy in /usr/src and try to patch that.&nbsp;</div><div><br><blockquote type="cite"><div>Regards,<br></div></blockquote><br>Tadele<br><blockquote type="cite"><div><br><div class="gmail_quote">2012/1/6 Gilles Chanteperdrix <span dir="ltr">&lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span><br><blockquote class="gmail_quote" style="margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class="im">On 01/05/2012 08:16 PM, Santiago Focke wrote:<br>
&gt; Hi all<br>
&gt;<br>
&gt; I'm quite new with Linux and Xenomai. I'm using Ubunto kernel<br>
&gt; 2.6.32-24-generic. I tied to install Xenomai-2.6 following the<br>
&gt; README.INSTALL document. First of all I cloned the GIT repository in<br>
&gt;<br>
&gt; /usr/src/xenomai-2.6<br>
&gt;<br>
&gt; After that, I tried to run the prepare-kernel.sh script as follows:<br>
&gt;<br>
&gt; /usr/src/xenomai-2.6/scripts/prepare-kernel.sh<br>
&gt; --linux=/usr/src/linux-headers-2.6.32-24-generic/<br>
<br>
</div>That is not going to work. Xenomai patches the kernel sources, and ask<br>
you to rebuild a kernel, just supplying the headers will not work.<br>
<span class="HOEnZb"><font color="#888888"><br>
<br>
--<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Gilles.<br>
</font></span></blockquote></div><br><br clear="all"><div><br></div>-- <br>Ing. Santiago Focke<br>
</div>
_______________________________________________<br>Xenomai-help mailing list<br><a href="mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>https://mail.gna.org/listinfo/xenomai-help<br></blockquote></div><br></body></html>
--Apple-Mail-1--71453244--

