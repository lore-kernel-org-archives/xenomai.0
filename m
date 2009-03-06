MIME-Version: 1.0
In-Reply-To: <49B0F2DD.5080507@domain.hid>
References: <76902d360903060146t677ab7a1y38a11273957b8c45@domain.hid>
	<49B0F2DD.5080507@domain.hid>
Date: Fri, 6 Mar 2009 12:41:46 +0100
Message-ID: <76902d360903060341y20a45b61y1a6e484767baca80@domain.hid>
From: =?ISO-8859-1?Q?Jens_K=F6hler?= <jenskxxx@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd150b604c2ac046471c56e
Subject: Re: [Xenomai-help] Xenomai and reading of linux files?
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

--000e0cd150b604c2ac046471c56e
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2009/3/6 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

>  Jens K=F6hler wrote:
> > Hello,
> >
> > I like to port a rtai application  to xenomai. The rtai application has=
 a
> > user space part and a kernel module. Both communication together by rta=
i
> > queues and a shared memory.
> > Do I need for xenomai still queues? Or is it f.i. possible to read or
> write
> > linux files from xenomai application without problems?
>
> reading and writing will work, but will cause the thread which does it
> to switch to secondary mode (if it is a real-time thread), so it may not
> be what you want.
>
> --
>                                                 Gilles.


Hi Gilles,

thank you for your fast answer. I need in periodic real time task data from
user space. Then I have to use a msg_queue!?
How can I check if my real time task/ thread runs accidentally in secondary
mode?

Thanks,
Jens

--000e0cd150b604c2ac046471c56e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br>
<div class=3D"gmail_quote">2009/3/6 Gilles Chanteperdrix <span dir=3D"ltr">=
&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdri=
x@domain.hid</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div></div>
<div class=3D"h5">Jens K=F6hler wrote:<br>&gt; Hello,<br>&gt;<br>&gt; I lik=
e to port a rtai application =A0to xenomai. The rtai application has a<br>&=
gt; user space part and a kernel module. Both communication together by rta=
i<br>
&gt; queues and a shared memory.<br>&gt; Do I need for xenomai still queues=
? Or is it f.i. possible to read or write<br>&gt; linux files from xenomai =
application without problems?<br><br></div></div>reading and writing will w=
ork, but will cause the thread which does it<br>
to switch to secondary mode (if it is a real-time thread), so it may not<br=
>be what you want.<br><br>--<br><font color=3D"#888888">=A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 Gilles.</font></blockquote>
<div>=A0</div>
<div>Hi Gilles,</div>
<div>=A0</div>
<div>thank you for your fast answer. I need in periodic real time task data=
 from user space. Then I have to use a msg_queue!?</div>
<div>How can I check if my real time task/ thread runs accidentally in seco=
ndary mode?</div>
<div>=A0</div>
<div>Thanks,</div>
<div>Jens</div>
<div>=A0</div></div><br>

--000e0cd150b604c2ac046471c56e--

