MIME-Version: 1.0
In-Reply-To: <4DB99E47.7000904@domain.hid>
References: <4DB8149A.7080600@domain.hid> <4DB83CBE.5040007@domain.hid>
	<4DB94BA0.1020503@domain.hid> <4DB94C9C.7080904@domain.hid>
	<4DB991E6.90403@domain.hid> <4DB99E47.7000904@domain.hid>
Date: Fri, 29 Apr 2011 00:43:53 +0600
Message-ID: <BANLkTik_MeMvpq2x7N0WmML97uW5=HxsLw@domain.hid>
From: Alexey Galakhov <agalakhov@domain.hid>
Content-Type: multipart/alternative; boundary=20cf300fad3b6549f604a1fef078
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

--20cf300fad3b6549f604a1fef078
Content-Type: text/plain; charset=ISO-8859-1

2011/4/28 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

>
> Well, is not that an effect of kgdb? The timer tick occurs 100 or 1000
> times per second, so, you can not keep up with gdb. The fact that a new
> interrupts may occur why handling another interrupt is normal with Adeos.
>
> It is not to say that there is no irq loop, but we can not conclude from
> the symptoms you are describing.
>
>
I understand this possibility. I did a simple test: just switched the
processor back and forth between "run" and "halt" many many times. I did it
on hardware (JTAG) level so I believe the CPU was running at full speed. And
it was catched in one of these interrupt handlers every time, I've never
seen it in any other function. Thus I believe it was doing nothing else. The
stack is suspicious as well: it has lots of IRQ stuff, nothing but IRQs,
even if I interrupt the CPU for the first time.



> Is there an earlier version of the I-pipe patch which was working?
>
>
Unfortunately I've not tested earlier versions. I'll try. They say it worked
with linux 2.6.29 (ipipe version not mentioned, but it was just before the
mini2440 timer3 patch was submitted to mainstream):
http://www.friendlyarm.net/forum/topic/598

Seems that these guys have the same problem:
http://www.friendlyarm.net/forum/topic/1108

--
Alex

--20cf300fad3b6549f604a1fef078
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2011/4/28 Gilles Chanteperdrix <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.cha=
nteperdrix@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" =
style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 20=
4); padding-left: 1ex;">
<div><div class=3D"h5"><br>
</div></div>Well, is not that an effect of kgdb? The timer tick occurs 100 =
or 1000<br>
times per second, so, you can not keep up with gdb. The fact that a new<br>
interrupts may occur why handling another interrupt is normal with Adeos.<b=
r>
<br>
It is not to say that there is no irq loop, but we can not conclude from<br=
>
the symptoms you are describing.<br>
<br></blockquote><div><br>I understand this possibility. I did a simple tes=
t: just switched the processor back and forth between &quot;run&quot; and &=
quot;halt&quot; many many times. I did it on hardware (JTAG) level so I bel=
ieve the CPU was running at full speed. And it was catched in one of these =
interrupt handlers every time, I&#39;ve never seen it in any other function=
. Thus I believe it was doing nothing else. The stack is suspicious as well=
: it has lots of IRQ stuff, nothing but IRQs, even if I interrupt the CPU f=
or the first time.<br>
<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt=
 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
Is there an earlier version of the I-pipe patch which was working?<br>
<br></blockquote><div><br>Unfortunately I&#39;ve not tested earlier version=
s. I&#39;ll try. They say it worked with linux 2.6.29 (ipipe version not me=
ntioned, but it was just before the mini2440 timer3 patch was submitted to =
mainstream): <a href=3D"http://www.friendlyarm.net/forum/topic/598">http://=
www.friendlyarm.net/forum/topic/598</a><br>
<br>Seems that these guys have the same problem: <a href=3D"http://www.frie=
ndlyarm.net/forum/topic/1108">http://www.friendlyarm.net/forum/topic/1108</=
a><br>=A0</div>--<br>Alex<br></div>

--20cf300fad3b6549f604a1fef078--

