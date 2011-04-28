MIME-Version: 1.0
In-Reply-To: <4DB9B978.2010200@domain.hid>
References: <4DB8149A.7080600@domain.hid> <4DB83CBE.5040007@domain.hid>
	<4DB94BA0.1020503@domain.hid> <4DB94C9C.7080904@domain.hid>
	<4DB991E6.90403@domain.hid> <4DB99E47.7000904@domain.hid>
	<BANLkTik_MeMvpq2x7N0WmML97uW5=HxsLw@domain.hid>
	<4DB9B978.2010200@domain.hid>
Date: Fri, 29 Apr 2011 01:28:30 +0600
Message-ID: <BANLkTinSWAT+33YFAD-z0kz6pesSQBe7qw@domain.hid>
From: Alexey Galakhov <agalakhov@domain.hid>
Content-Type: multipart/alternative; boundary=90e6ba5bc9c9f0527904a1ff8f80
Subject: Re: [Adeos-main] Ipipe hangs on ARM MINI2440 after switching
	clocksource
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

--90e6ba5bc9c9f0527904a1ff8f80
Content-Type: text/plain; charset=ISO-8859-1

2011/4/29 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

>
>
> So, have you tried reverting the timer3 patch?
>
>
Yes. After reverting, EVERYTHING stops working correctly (even with ipipe
off). It is really necessary.

Now I'm trying to understand the MMC code. Looks like that timers do their
job correctly, and MMC/SD driver seems to be the source of irq flood. If so,
it depends on kernel version, not on ipipe version. That is, ipipe seems
just to trigger a bug in already buggy kernel. Trying to examine it more
closely. Not sure.

--
Alex

--90e6ba5bc9c9f0527904a1ff8f80
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2011/4/29 Gilles Chanteperdrix <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.cha=
nteperdrix@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" =
style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 20=
4); padding-left: 1ex;">
<div><div class=3D"h5"><br>
<br>
</div></div>So, have you tried reverting the timer3 patch?<br>
<br></blockquote></div><br>Yes. After reverting, EVERYTHING stops working c=
orrectly (even with ipipe off). It is really necessary.<br><br>Now I&#39;m =
trying to understand the MMC code. Looks like that timers do their job corr=
ectly, and MMC/SD driver seems to be the source of irq flood. If so, it dep=
ends on kernel version, not on ipipe version. That is, ipipe seems just to =
trigger a bug in already buggy kernel. Trying to examine it more closely. N=
ot sure.<br>
<br>--<br>Alex<br>

--90e6ba5bc9c9f0527904a1ff8f80--

