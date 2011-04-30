MIME-Version: 1.0
In-Reply-To: <BANLkTikNqOVEwRPUhcd0YOHELqYU=3DfgQ@mail.gmail.com>
References: <4DB8149A.7080600@domain.hid> <4DB83CBE.5040007@domain.hid>
	<4DB94BA0.1020503@domain.hid> <4DB94C9C.7080904@domain.hid>
	<4DB991E6.90403@domain.hid> <4DB99E47.7000904@domain.hid>
	<BANLkTik_MeMvpq2x7N0WmML97uW5=HxsLw@domain.hid>
	<4DB9B978.2010200@domain.hid>
	<BANLkTinSWAT+33YFAD-z0kz6pesSQBe7qw@domain.hid>
	<4DB9C0D3.4030003@domain.hid> <4DBA9C26.2040903@domain.hid>
	<4DBAA1DE.4000108@domain.hid> <4DBBDCA9.1040609@domain.hid>
	<BANLkTintQjX=O0DBYbyW2=jhyNQuyeZ=pQ@mail.gmail.com>
	<BANLkTikNqOVEwRPUhcd0YOHELqYU=3DfgQ@mail.gmail.com>
Date: Sun, 1 May 2011 00:41:26 +0600
Message-ID: <BANLkTim1j9Fx4=P9a+c5jK5EoBEp-5MrdQ@mail.gmail.com>
From: Alexey Galakhov <agalakhov@domain.hid>
Content-Type: multipart/alternative; boundary=90e6ba5bc9c950af7304a227237e
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

--90e6ba5bc9c950af7304a227237e
Content-Type: text/plain; charset=ISO-8859-1

2011/4/30 Alexey Galakhov <agalakhov@domain.hid>

>
> Hmmmm... It seems to be unstable, it generally works but with random
> hangups. Trying to debug.
>

Looks like now it's not IRQ related. Seems to be kind of overflow in
logarithmic_accumulation (), probably due to changes in timer code.

--
Alex

--90e6ba5bc9c950af7304a227237e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2011/4/30 Alexey Galakhov <span dir=3D"l=
tr">&lt;<a href=3D"mailto:agalakhov@domain.hid">agalakhov@domain.hid</a>&gt;<=
/span><br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"im"><br></div>Hmmmm... It seems to be unstable, it generally =
works but with random hangups. Trying to debug.<br></blockquote><div><br>Lo=
oks like now it&#39;s not IRQ related. Seems to be kind of overflow in loga=
rithmic_accumulation (), probably due to changes in timer code.<br>
<br>--<br>Alex <br></div></div>

--90e6ba5bc9c950af7304a227237e--

