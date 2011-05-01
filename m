MIME-Version: 1.0
In-Reply-To: <4DBC8EEF.40109@domain.hid>
References: <4DB8149A.7080600@domain.hid> <4DB83CBE.5040007@domain.hid>
	<4DB94BA0.1020503@domain.hid> <4DB94C9C.7080904@domain.hid>
	<4DB991E6.90403@domain.hid> <4DB99E47.7000904@domain.hid>
	<BANLkTik_MeMvpq2x7N0WmML97uW5=HxsLw@domain.hid>
	<4DB9B978.2010200@domain.hid>
	<BANLkTinSWAT+33YFAD-z0kz6pesSQBe7qw@domain.hid>
	<4DB9C0D3.4030003@domain.hid> <4DBA9C26.2040903@domain.hid>
	<4DBAA1DE.4000108@domain.hid> <4DBBDCA9.1040609@domain.hid>
	<BANLkTintQjX=O0DBYbyW2=jhyNQuyeZ=pQ@mail.gmail.com>
	<4DBC6D98.2070306@domain.hid>
	<BANLkTi=Q07ByVtHNobQBR1uNkHwRAsoo5g@domain.hid>
	<4DBC8EEF.40109@domain.hid>
Date: Sun, 1 May 2011 20:23:21 +0600
Message-ID: <BANLkTinQLa9HQniMFS6L7T8PWmYR7C+3LA@mail.gmail.com>
From: Alexey Galakhov <agalakhov@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd5304427013304a237a679
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

--000e0cd5304427013304a237a679
Content-Type: text/plain; charset=ISO-8859-1

2011/5/1 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

>
> There is a bug in ipipe_tsc_update for decrementers. The all-in-one patch I
> would like you to try is:
>
>
This hangs ("infinite IRQs 30,37" symptom). It works fine after re-applying
this:
- set_irq_handler(irqno, handle_edge_irq);
+ set_irq_handler(irqno, handle_level_irq);

Seems that handle_edge_irq is broken while handle_level_irq works just fine.

Now the board seems to work. At least, there are no obvious hangups. Thanks!

--
Alex

--000e0cd5304427013304a237a679
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">2011/5/1 Gilles Chanteperdrix <span dir=3D"ltr">=
&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdri=
x@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div><div class=3D"h5">
<br>
</div></div>There is a bug in ipipe_tsc_update for decrementers. The all-in=
-one patch I<br>
would like you to try is:<br>
<br></blockquote><div><br>This hangs (&quot;infinite IRQs 30,37&quot; sympt=
om). It works fine after re-applying this:<br>- set_irq_handler(irqno, hand=
le_edge_irq);<br>+ set_irq_handler(irqno, handle_level_irq);<br><br>Seems t=
hat handle_edge_irq is broken while handle_level_irq works just fine.<br>
<br>Now the board seems to work. At least, there are no obvious hangups. Th=
anks!<br><br>--<br>Alex<br></div></div>

--000e0cd5304427013304a237a679--

