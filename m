MIME-Version: 1.0
In-Reply-To: <4DB9C0D3.4030003@domain.hid>
References: <4DB8149A.7080600@domain.hid> <4DB83CBE.5040007@domain.hid>
	<4DB94BA0.1020503@domain.hid> <4DB94C9C.7080904@domain.hid>
	<4DB991E6.90403@domain.hid> <4DB99E47.7000904@domain.hid>
	<BANLkTik_MeMvpq2x7N0WmML97uW5=HxsLw@domain.hid>
	<4DB9B978.2010200@domain.hid>
	<BANLkTinSWAT+33YFAD-z0kz6pesSQBe7qw@domain.hid>
	<4DB9C0D3.4030003@domain.hid>
Date: Fri, 29 Apr 2011 01:47:54 +0600
Message-ID: <BANLkTikpH78xQ9Qx4sn=Hyeicfu3v9SP9w@domain.hid>
From: Alexey Galakhov <agalakhov@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd4b34851157104a1ffd5ab
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

--000e0cd4b34851157104a1ffd5ab
Content-Type: text/plain; charset=ISO-8859-1

2011/4/29 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

>
> Maybe you can try booting with MMC disabled, to see if the I-pipe is
> working? Not permanently, just to confirm that you are not chasing the
> wrong bug.
>

Sure, that's exactly what I want to do. Unfortunately, I cannot boot to a
working system in that mode since I have root on SD card, but "Kernel panic
- unable to mount root fs" would indicate successful boot. I think also
about moving root somewhere else to be able to run tests ans examine /proc
and /sys under ipipe kernel.

--
Alex

--000e0cd4b34851157104a1ffd5ab
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2011/4/29 Gilles Chanteperdrix <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.cha=
nteperdrix@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" =
style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 20=
4); padding-left: 1ex;">
<div><div class=3D"h5">
<br>
</div></div>Maybe you can try booting with MMC disabled, to see if the I-pi=
pe is<br>
working? Not permanently, just to confirm that you are not chasing the<br>
wrong bug.<br></blockquote><div><br>Sure, that&#39;s exactly what I want to=
 do. Unfortunately, I cannot boot to a working system in that mode since I =
have root on SD card, but &quot;Kernel panic - unable to mount root fs&quot=
; would indicate successful boot. I think also about moving root somewhere =
else to be able to run tests ans examine /proc and /sys under ipipe kernel.=
<br>
<br>--<br>Alex <br></div></div>

--000e0cd4b34851157104a1ffd5ab--

