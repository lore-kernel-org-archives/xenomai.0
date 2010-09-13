MIME-Version: 1.0
In-Reply-To: <4C8E118F.7010404@domain.hid>
References: <AANLkTi=Wke_BOMmq4P-SSoaMnaDVfBV=2Hmn5TZF7QgQ@mail.gmail.com>
	<4C8DE9CE.9050900@domain.hid>
	<AANLkTik4rjQzwnU82OBudtkeS+kO+fbD1RjFXvXK7=qS@mail.gmail.com>
	<4C8E118F.7010404@domain.hid>
Date: Mon, 13 Sep 2010 15:52:07 +0200
Message-ID: <AANLkTi=zxAy4wVyf2T_0XcxpnCkXRtApWhimmJO5hSFr@domain.hid>
From: =?ISO-8859-1?Q?Jens_K=F6hler?= <jenskxxx@domain.hid>
Content-Type: multipart/alternative; boundary=0016e646a456fbabb30490246686
Subject: Re: [Xenomai-help] rt_queue_read and EPERM?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

--0016e646a456fbabb30490246686
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Yes this is true. It is not a Xenomai task.

Many thanks,
Jens

2010/9/13 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Jens K=F6hler wrote:
> > Hello Gilles,
> >
> > here is the code:
> >
> > RT_QUEUE myqueue;
> > int retval;
> > retval =3D rt_queue_create(&myqueue, "myqueue", 255, 10, Q_FIFO);
> >
> > char message[100] =3D "Message ";
> > retval =3D rt_queue_write(&myqueue,message,sizeof(message),Q_NORMAL);
> > //retval is 0
> >
> > char msgBuf[255];
> > retval =3D rt_queue_read(&myqueue, msgBuf, sizeof(msgBuf), TM_NONBLOCK)=
;
> > //retval is always -1, why?
>
> Probably because the callling thread is not a Xenomai thread, it is a
> simple Linux thread, and as such, is not allowed to switch to primary
> mode as is required by rt_queue_read.
>
> --
>                                            Gilles.
>
>

--0016e646a456fbabb30490246686
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Yes this is true. It is not a Xenomai task.</div>
<div>=A0</div>
<div>Many thanks,</div>
<div>Jens<br><br></div>
<div class=3D"gmail_quote">2010/9/13 Gilles Chanteperdrix <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdr=
ix@domain.hid</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class=3D"im">Jens K=F6hler wrote:<br>&gt; Hello Gilles,<br>&gt;<br>&gt=
; here is the code:<br>&gt;<br>&gt; RT_QUEUE myqueue;<br>&gt; int retval;<b=
r>&gt; retval =3D rt_queue_create(&amp;myqueue, &quot;myqueue&quot;, 255, 1=
0, Q_FIFO);<br>
&gt;<br>&gt; char message[100] =3D &quot;Message &quot;;<br>&gt; retval =3D=
 rt_queue_write(&amp;myqueue,message,sizeof(message),Q_NORMAL);<br>&gt; //r=
etval is 0<br>&gt;<br>&gt; char msgBuf[255];<br>&gt; retval =3D rt_queue_re=
ad(&amp;myqueue, msgBuf, sizeof(msgBuf), TM_NONBLOCK);<br>
&gt; //retval is always -1, why?<br><br></div>Probably because the callling=
 thread is not a Xenomai thread, it is a<br>simple Linux thread, and as suc=
h, is not allowed to switch to primary<br>mode as is required by rt_queue_r=
ead.<br>
<br>--<br><font color=3D"#888888">=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br><br></font></bloc=
kquote></div><br>

--0016e646a456fbabb30490246686--

