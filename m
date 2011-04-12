MIME-Version: 1.0
Sender: madjsw@domain.hid
In-Reply-To: <4DA463D2.9030502@domain.hid>
References: <BANLkTikTWM75UZknkYRt=MeOUDJVsNmLAA@mail.gmail.com>
	<4DA463D2.9030502@domain.hid>
Date: Tue, 12 Apr 2011 10:06:28 -0500
Message-ID: <BANLkTi=YMQzg9943duUB2kdvawpYs7Z8KQ@mail.gmail.com>
From: Jeff Weber <jwamsc@domain.hid>
Content-Type: multipart/alternative; boundary=00151773dd0c6acbe804a0ba0960
Subject: Re: [Xenomai-help] pthread exit and PTHREAD_WARNSW
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

--00151773dd0c6acbe804a0ba0960
Content-Type: text/plain; charset=ISO-8859-1

Gilles:

On Tue, Apr 12, 2011 at 9:38 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Jeff Weber wrote:
>
> Hi Jeff,
>
> any news about the hostrt patch I sent you for x86_32? Does it work?
>

Yes it works.  However my call to clock_gettime(CLOCK_HOST_REALTIME) takes
too long (110 nsec on my CPU) for my ISR, so I will read the TSC instead,
and convert the TSC to host time in another thread.  Thanks for your help
though.


>
> > From testing, I found that if I enable PTHREAD_WARNSW for a pthread, I
> must
> > explicitly disable this mode before the thread terminates, or the thread
> > draws a signal 24 SIGXCPU.
>
> Yes, the problem is that we can put such migration if the thread
> function returns, but it will not work in case pthread_exit is called.
>

I'm interested if there is a way to automatically disable PTHREAD_WARNSW as
threads terminate, using return from the entry function.  I was only using
pthread_exit() to leverage the thread cleanup stack capability, and queue a
call to pthread_set_mode_np(PTHREAD_WARNSW, 0) .

>
> >
> > I've tried to simplify my thread terminations by pushing a function which
> > calls pthread_set_mode_np(PTHREAD_WARNSW, 0) onto the thread cleanup
> stack,
> > and always terminating the thread via pthread_exit().  However, this
> method
> > still draws a signal 24 SIGXCPU.    Here's a sample backtrace:
>
> ... and pthread_exit is basically a Linux service, so, we can not
> guarantee that it does not make any syscall before executing the cleanup
> handlers.
>

Right, I saw there was no  __wrap_pthread_exit
in /usr/xenomai/lib/libpthread_rt.so

Jeff

>
> --
>                                             Gilles.
>

--00151773dd0c6acbe804a0ba0960
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles:<br><br><div class=3D"gmail_quote">On Tue, Apr 12, 2011 at 9:38 AM, =
Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chantep=
erdrix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<=
br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;">Jeff Weber wrote:<br>
<br>
Hi Jeff,<br>
<br>
any news about the hostrt patch I sent you for x86_32? Does it work?<br></b=
lockquote><div><br></div><div>Yes it works. =A0However my call to clock_get=
time(CLOCK_HOST_REALTIME) takes too long (110 nsec on my CPU) for my ISR, s=
o I will read the TSC instead, and convert the TSC to host time in another =
thread. =A0Thanks for your help though.</div>
<div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"im"><br>
&gt; From testing, I found that if I enable PTHREAD_WARNSW for a pthread, I=
 must<br>
&gt; explicitly disable this mode before the thread terminates, or the thre=
ad<br>
&gt; draws a signal 24 SIGXCPU.<br>
<br>
</div>Yes, the problem is that we can put such migration if the thread<br>
function returns, but it will not work in case pthread_exit is called.<br><=
/blockquote><div><br></div><div>I&#39;m interested if there is a way to aut=
omatically disable PTHREAD_WARNSW as threads terminate, using return from t=
he entry function. =A0I was only using pthread_exit() to leverage the=A0thr=
ead cleanup stack capability, and queue a call to=A0pthread_set_mode_np(PTH=
READ_WARNSW, 0) .</div>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;">
<div class=3D"im"><br>
&gt;<br>
&gt; I&#39;ve tried to simplify my thread terminations by pushing a functio=
n which<br>
&gt; calls pthread_set_mode_np(PTHREAD_WARNSW, 0) onto the thread cleanup s=
tack,<br>
&gt; and always terminating the thread via pthread_exit(). =A0However, this=
 method<br>
&gt; still draws a signal 24 SIGXCPU. =A0 =A0Here&#39;s a sample backtrace:=
<br>
<br>
</div>... and pthread_exit is basically a Linux service, so, we can not<br>
guarantee that it does not make any syscall before executing the cleanup<br=
>
handlers.<br></blockquote><div><br></div><div>Right, I saw there was no =A0=
__wrap_pthread_exit in=A0/usr/xenomai/lib/libpthread_rt.so=A0</div><div><br=
></div><div>Jeff</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">

<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br>

--00151773dd0c6acbe804a0ba0960--

