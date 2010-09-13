MIME-Version: 1.0
In-Reply-To: <4C8DE9CE.9050900@domain.hid>
References: <AANLkTi=Wke_BOMmq4P-SSoaMnaDVfBV=2Hmn5TZF7QgQ@mail.gmail.com>
	<4C8DE9CE.9050900@domain.hid>
Date: Mon, 13 Sep 2010 12:59:05 +0200
Message-ID: <AANLkTik4rjQzwnU82OBudtkeS+kO+fbD1RjFXvXK7=qS@mail.gmail.com>
From: =?ISO-8859-1?Q?Jens_K=F6hler?= <jenskxxx@domain.hid>
Content-Type: multipart/alternative; boundary=e0cb4e7004cf21fd15049021fc9d
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

--e0cb4e7004cf21fd15049021fc9d
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

 Hello Gilles,

here is the code:

RT_QUEUE myqueue;
int retval;
retval =3D rt_queue_create(&myqueue, "myqueue", 255, 10, Q_FIFO);

char message[100] =3D "Message ";
retval =3D rt_queue_write(&myqueue,message,sizeof(message),Q_NORMAL);
//retval is 0

char msgBuf[255];
retval =3D rt_queue_read(&myqueue, msgBuf, sizeof(msgBuf), TM_NONBLOCK);
//retval is always -1, why?

regards,
Jens



2010/9/13 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

>  Jens K=F6hler wrote:
> > Hello
> >
> > I am try to use a RT_QUEUE. I am writing messages with rt_queue_write t=
o
> > the queue. But when function rt_queue_read is called result is always
>  "-1".
> >
> > "-1" means EPERM. What means exactly: "EEPERM is returned if this
> > service should block"? I don't understand why a function should block t=
o
> > get a message from a queue!?
>
> A piece of code is worth a thousand words. Please send us a piece of
> code showing the behaviour you find suspicious.
>
> --
>                                            Gilles.
>
>

--e0cb4e7004cf21fd15049021fc9d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<span lang=3D"DE">
<div>Hello Gilles,</div>
<div>=A0</div>
<div>here is the code:</div>
<div>=A0</div>
<div>RT_QUEUE myqueue;</div>
<div>int retval;</div>
<div>retval =3D rt_queue_create(&amp;myqueue, &quot;myqueue&quot;, 255, 10,=
 Q_FIFO);</div>
<div>=A0</div>
<div>char message[100] =3D &quot;Message &quot;;</div>
<div>retval =3D rt_queue_write(&amp;myqueue,message,sizeof(message),Q_NORMA=
L);</div>
<div>//retval is 0</div>
<div>=A0</div>
<div>char msgBuf[255];</div>
<div>retval =3D rt_queue_read(&amp;myqueue, msgBuf, sizeof(msgBuf), TM_NONB=
LOCK);</div>
<div>//retval is always -1, why?</div></span>
<div>=A0</div>
<div>regards,</div>
<div>Jens</div>
<p><br><br></p>
<div class=3D"gmail_quote">2010/9/13 Gilles Chanteperdrix <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdr=
ix@domain.hid</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div></div>
<div class=3D"h5">Jens K=F6hler wrote:<br>&gt; Hello<br>&gt;<br>&gt; I am t=
ry to use a RT_QUEUE. I am writing messages with rt_queue_write to<br>&gt; =
the queue. But when function rt_queue_read is called result is always =A0&q=
uot;-1&quot;.<br>
&gt;<br>&gt; &quot;-1&quot; means EPERM. What means exactly: &quot;EEPERM i=
s returned if this<br>&gt; service should block&quot;? I don&#39;t understa=
nd why a function should block to<br>&gt; get a message from a queue!?<br>
<br></div></div>A piece of code is worth a thousand words. Please send us a=
 piece of<br>code showing the behaviour you find suspicious.<br><br>--<br><=
font color=3D"#888888">=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
<br></font></blockquote></div><br>

--e0cb4e7004cf21fd15049021fc9d--

