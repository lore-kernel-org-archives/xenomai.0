MIME-Version: 1.0
Date: Mon, 18 May 2009 15:12:10 +0200
Message-ID: <37f89760905180612m6de18575w82d0f2f07d95c508@domain.hid>
From: Marcel Soulot <msoulot@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6d64515bf03b1046a2f8ab3
Subject: [Xenomai-help] timer_settime issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

--0016e6d64515bf03b1046a2f8ab3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I try to set a 10ms periodic timer but I stay stuck in the call of
timer_settime().
I don't understand why it doesn't leave this function ?

thanks for your help,
Marcel.

here is the source code of my function :

*{*
*    struct sigaction sa;
    struct itimerspec timer;
    int ret;
    struct sigevent timer_event;

    if (! mbTimerRunning)
    {
        mbTimerRunning = true;*
*  *
*        memset (&sa, 0, sizeof (sa));
        sa.sa_handler = &CTimerManagment::timer_handler;
        ret = sigaction (SIGALRM, &sa, NULL);
        if (ret < 0)
        {
            printf("Error sigaction code %d.\n", ret);
        }

        // Configure the timer to expire after 10 msec...
        timer.it_value.tv_sec = 0;
        timer.it_value.tv_nsec = 10000;*
**
*        // ... and every 10 msec after that.
        timer.it_interval.tv_sec = 0;
        timer.it_interval.tv_nsec = 10000;*
**
*        timer_event.sigev_notify = SIGEV_SIGNAL;
        timer_event.sigev_signo = SIGALRM;
        timer_event.sigev_value.sival_ptr = (void*)&mytimer;*
**
*        ret = timer_create(CLOCK_REALTIME, &timer_event, &mytimer);
        if (0 > ret)
        {
            printf("Error timer_create %d\n", ret);
        }
*
*        ret = timer_settime(mytimer, 0, &timer, NULL);
        if (0 > ret)
        {
            printf("Error timer_settime %d\n", ret);
        }
    }
}*
**
**

--0016e6d64515bf03b1046a2f8ab3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi, </div>
<div>=A0</div>
<div>I try to set=A0a 10ms periodic timer=A0but=A0I stay stuck in the call =
of timer_settime().</div>
<div>I don&#39;t understand=A0why=A0it doesn&#39;t leave this function ?</d=
iv>
<div>=A0</div>
<div>thanks for your help,</div>
<div>Marcel.</div>
<div>=A0</div>
<div>here is the source code of my function :</div>
<div>=A0</div>
<div><font color=3D"#000099"><strong>{</strong></font></div>
<div><font color=3D"#000099"><strong>=A0=A0=A0 struct sigaction sa;<br>=A0=
=A0=A0 struct itimerspec timer;<br>=A0=A0=A0 int ret;<br>=A0=A0=A0 struct s=
igevent timer_event;<br><br>=A0=A0=A0 if (! mbTimerRunning)<br>=A0=A0=A0 {<=
br>=A0=A0=A0=A0=A0=A0=A0 mbTimerRunning =3D true;</strong></font></div>

<div><font color=3D"#000099"><strong>=A0=A0</strong></font></div>
<div><font color=3D"#000099"><strong>=A0=A0=A0=A0=A0=A0=A0 memset (&amp;sa,=
 0, sizeof (sa));<br>=A0=A0=A0=A0=A0=A0=A0 sa.sa_handler =3D &amp;CTimerMan=
agment::timer_handler;<br>=A0=A0=A0=A0=A0=A0=A0 ret =3D sigaction (SIGALRM,=
 &amp;sa, NULL);<br>=A0=A0=A0=A0=A0=A0=A0 if (ret &lt; 0)<br>
=A0=A0=A0=A0=A0=A0=A0 {<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printf(&quot;E=
rror sigaction code %d.\n&quot;, ret);<br>=A0=A0=A0=A0=A0=A0=A0 }<br><br>=
=A0=A0=A0=A0=A0=A0=A0 // Configure the timer to expire after 10 msec...<br>=
=A0=A0=A0=A0=A0=A0=A0 timer.it_value.tv_sec =3D 0;<br>=A0=A0=A0=A0=A0=A0=A0=
 timer.it_value.tv_nsec =3D 10000;</strong></font></div>

<div><font color=3D"#000099"><strong></strong></font>=A0</div>
<div><font color=3D"#000099"><strong>=A0=A0=A0=A0=A0=A0=A0 // ... and every=
 10 msec after that.<br>=A0=A0=A0=A0=A0=A0=A0 timer.it_interval.tv_sec =3D =
0;<br>=A0=A0=A0=A0=A0=A0=A0 timer.it_interval.tv_nsec =3D 10000;</strong></=
font></div>
<div><font color=3D"#000099"><strong></strong></font>=A0</div>
<div><font color=3D"#000099"><strong>=A0=A0=A0=A0=A0=A0=A0 timer_event.sige=
v_notify =3D SIGEV_SIGNAL;<br>=A0=A0=A0=A0=A0=A0=A0 timer_event.sigev_signo=
 =3D SIGALRM;<br>=A0=A0=A0=A0=A0=A0=A0 timer_event.sigev_value.sival_ptr =
=3D (void*)&amp;mytimer;</strong></font></div>
<div><font color=3D"#000099"><strong></strong></font>=A0</div>
<div><font color=3D"#000099"><strong>=A0=A0=A0=A0=A0=A0=A0 ret =3D timer_cr=
eate(CLOCK_REALTIME, &amp;timer_event, &amp;mytimer);<br>=A0=A0=A0=A0=A0=A0=
=A0 if (0 &gt; ret)<br>=A0=A0=A0=A0=A0=A0=A0 {<br>=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 printf(&quot;Error timer_create %d\n&quot;, ret);<br>=A0=A0=A0=A0=
=A0=A0=A0 }<br>
</strong></font></div>
<div><font color=3D"#000099"><strong>=A0=A0=A0=A0=A0=A0=A0 ret =3D timer_se=
ttime(mytimer, 0, &amp;timer, NULL);<br>=A0=A0=A0=A0=A0=A0=A0 if (0 &gt; re=
t)<br>=A0=A0=A0=A0=A0=A0=A0 {<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printf(&=
quot;Error timer_settime %d\n&quot;, ret);<br>=A0=A0=A0=A0=A0=A0=A0 }<br>=
=A0=A0=A0 }<br>
}</strong></font></div>
<div><strong><font color=3D"#000099"></font></strong>=A0</div>
<div><strong><font color=3D"#000099"></font></strong>=A0</div>

--0016e6d64515bf03b1046a2f8ab3--

