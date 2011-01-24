Message-ID: <4D3DAC8B.5000409@domain.hid>
Date: Mon, 24 Jan 2011 17:44:59 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <23405065.111295887148359.JavaMail.SYSTEM@PC-MRINALDI>
In-Reply-To: <23405065.111295887148359.JavaMail.SYSTEM@PC-MRINALDI>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Problems with rt_task_create and rt_task_join
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michel Rinaldi <automation.03@domain.hid>
Cc: xenomai@xenomai.org

Michel Rinaldi wrote:
> ----- Messaggio originale -----=20
> Da: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>=20
> A: "Michel Rinaldi" <automation.03@domain.hid>=20
> Cc: xenomai@xenomai.org
> Inviato: Luned=C3=AC, 24 gennaio 2011 15:27:51 GMT +01:00 Amsterdam/Ber=
lino/Berna/Roma/Stoccolma/Vienna=20
> Oggetto: Re: [Xenomai-help] Problems with rt_task_create and rt_task_jo=
in=20
>=20
> .....=20
>=20
>> You explanations are hard to follow and understand, and what is more, =

>> ambiguous. Send us a piece of code which allows us to reproduce this=20
>> issue. Trying to make it as simple as possible. For instance seeing if=
=20
>> registering the interrupt causes any difference (if it does not make a=
ny=20
>> difference, then remove it, you get the idea).=20
>=20
> My code is really big and complex to reduce, I'll try to simplify it in=
 next days.=20
>=20
>> As usual, we do not know what version of Xenomai, Adeos, Linux, etc...=
=20
>> you are using. See:=20
>> http://www.xenomai.org/index.php/Request_for_information=20
>=20
> I post them into firts mail of this thread, anyway they are:=20
> - Linux system with kernel 2.6.35.7=20
> - Xenomai 2.5.5.2=20
> - Adeos ipipe patch 2.7-04=20
> GCC is on version 4.4.3.=20
>=20
> .....=20
>=20
>> That is bad. One more question: what happens when you run the "latency=
"=20
>> test, do you get strange results? Also, I see that you have the SMI=20
>> workaround enabled, does it detect your chipset?=20
>=20
> Yes, as system log says, Xenomai detect SMI motherboard and disable the=
m.=20
> I run the latency test: without other loads onto system, I observe valu=
es like these:=20
>=20
> RTT| 00:00:01 (periodic user-mode task, 100 us period, priority 99)=20
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--l=
at worst=20
> RTD| 6.680| 7.157| 12.187| 0| 0| 6.680| 12.187=20
> RTD| 6.277| 6.980| 10.519| 0| 0| 6.277| 12.187=20
> RTD| 1.175| 7.122| 9.315| 0| 0| 1.175| 12.187=20
> RTD| 1.578| 7.112| 9.382| 0| 0| 1.175| 12.187=20
> RTD| 1.635| 7.133| 10.307| 0| 0| 1.175| 12.187=20
>=20
> also after long runnings.=20
>=20
> But if I launch application contained into attached main_app.c file (th=
at represents my simplified application)=20
> what I observe into latency test is:=20

What you observe when you launch your application is irrelevant. The
latency test only makes sense if the the latency test is the only one
running with high priority. So, what you should run is some non-realtime
load.

Also, your application creates a thread with priority 99 using all the
CPU. This is absolutely not what Xenomai is made for. No wonder the
system stops working correctly when you do that.

--=20
                                                                Gilles.


