Date: Sat, 15 Dec 2007 12:35:26 +0000 (GMT)
From: Michael Trimarchi <trimarchimichael@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1018812032-1197722126=:68019"
Message-ID: <136563.68019.qm@domain.hid>
Subject: Re: [Adeos-main] at91sam9260
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

--0-1018812032-1197722126=:68019
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,=0A>> =0A >> Hi,=0A >> =0A >> I think that the problem of the overruns a=
re related to the latency=0A introduced by adeos, and the=0A >> serial buff=
er of the at91sam9260 ( length =3D 1 ). =0A=0A>Wait a minute. You mean that=
 you want more than 5000 interrupts by=0A>second ? Are you sure you do not =
get overruns with plain, unpatched=0A>Linux, if you load it sufficiently ?=
=0A=0AThank's for you help. I'm new on ipipe & xenomai. Yesterday I find a =
problem related to my patch and the at91 clock initialization ( I forgot to=
 patch timex.h file ) and I will test serial line again as =0Asoon as possi=
ble. Now I try to integrate the leatest patch of ipipe from the git reposit=
ory.=0AI think that is not possible to have a "wired interrupt" for the roo=
t domain, or exclude ipipe =0Afor a series of interrupt (just to try). I tr=
y to use linux without ipipe patch and I don't have=0Aoverrun on serial lin=
e. It is possible to count unhandled interrupt? Maybe I have some problem=
=0Abut dosen't related to ipipe ( just visible with it ). are there test su=
ite for ipipe?=0A=0ARegards Michael=0A=0A=0ARegards Michael=0A=0A=0A=0A=0A=
=0A=0A=0A      ___________________________________ =0AL'email della prossim=
a generazione? Puoi averla con la nuova Yahoo! Mail: =0Ahttp://it.docs.yaho=
o.com/nowyoucan.html
--0-1018812032-1197722126=:68019
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:10pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 10pt;">Hi,<br><div style=3D"font-family: times new roman,n=
ew york,times,serif; font-size: 12pt;">&gt;&gt; <br> &gt;&gt; Hi,<br> &gt;&=
gt; <br> &gt;&gt; I think that the problem of the overruns are related to t=
he latency=0A introduced by adeos, and the<br> &gt;&gt; serial buffer of th=
e at91sam9260 ( length =3D 1 ). <br><br>&gt;Wait a minute. You mean that yo=
u want more than 5000 interrupts by<br>&gt;second ? Are you sure you do not=
 get overruns with plain, unpatched<br>&gt;Linux, if you load it sufficient=
ly ?<br><br>Thank's for you help. I'm new on ipipe &amp; xenomai. Yesterday=
 I find a problem related to my patch and the at91 clock initialization ( I=
 forgot to patch timex.h file ) and I will test serial line again as <br>so=
on as possible. Now I try to integrate the leatest patch of ipipe from the =
git repository.<br>I think that is not possible to have a "wired interrupt"=
 for the root domain, or exclude ipipe <br>for a series of interrupt (just =
to try). I try to use linux without ipipe patch and I don't have<br>overrun=
 on serial line. It is possible to count unhandled interrupt? Maybe I have =
some problem<br>but dosen't related to ipipe ( just visible with it ). are =
there
 test suite for ipipe?<br><br>Regards Michael<br><br><br>Regards Michael<br=
><br><br></div></div></div><br>=0A=0A=0A      <hr size=3D1><font face=3D"Ar=
ial" size=3D"2">L'email della prossima generazione? Puoi averla con la <a h=
ref=3D"http://us.rd.yahoo.com/mail/it/taglines/gmail/nowyoucan/nextgen/*htt=
p://it.docs.yahoo.com/nowyoucan.html">Nuova Yahoo! Mail</a></font></body></=
html>
--0-1018812032-1197722126=:68019--

