Date: Thu, 13 Dec 2007 15:41:19 +0000 (GMT)
From: Michael Trimarchi <trimarchimichael@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2041198372-1197560479=:70825"
Message-ID: <685497.70825.qm@domain.hid>
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

--0-2041198372-1197560479=:70825
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=0AHi=0A>=0A>=0A> Hi,=0A>=0A> I think that the problem of the overruns are =
related to the latency=0A> introduced by adeos, and the=0A> serial buffer o=
f the at91sam9260 ( length =3D 1 ).=0A>=0A>=0A> >Do you get the same behavi=
our if you apply=0A> >adeos-ipipe-2.6.20-arm-1.8-02.patch on a linux 2.6.20=
 ?=0A> >                                              Gilles Chanteperdrix=
=0A>=0A> I'll send soon my xeno-test. It is possible to serve an interrupt=
=0A without=0A> pass=0A> throw the log system in the root domain?=0A=0A>If =
you do not want to test the I-pipe patch on the kernel for which it=0A>is m=
ade, then I am afraid we can not conclude anything from any result=0A>you o=
btain.=0A=0A>-- =0A>                                               Gilles C=
hanteperdrix=0AI will test it on my board. =0A=0ARegards Michael=0A=0A=0A=
=0A=0A=0A=0A      ___________________________________ =0AL'email della pros=
sima generazione? Puoi averla con la nuova Yahoo! Mail: =0Ahttp://it.docs.y=
ahoo.com/nowyoucan.html
--0-2041198372-1197560479=:70825
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:10pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 10pt;"><br><div style=3D"font-family: times new roman,new =
york,times,serif; font-size: 12pt;">Hi<br>&gt;<br>&gt;<br>&gt; Hi,<br>&gt;<=
br>&gt; I think that the problem of the overruns are related to the latency=
<br>&gt; introduced by adeos, and the<br>&gt; serial buffer of the at91sam9=
260 ( length =3D 1 ).<br>&gt;<br>&gt;<br>&gt; &gt;Do you get the same behav=
iour if you apply<br>&gt; &gt;adeos-ipipe-2.6.20-arm-1.8-02.patch on a linu=
x 2.6.20 ?<br>&gt; &gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Gilles Chanteperdrix<br>&gt;<br>&gt; I'll=
 send soon my xeno-test. It is possible to serve an interrupt=0A without<br=
>&gt; pass<br>&gt; throw the log system in the root domain?<br><br>&gt;If y=
ou do not want to test the I-pipe patch on the kernel for which it<br>&gt;i=
s made, then I am afraid we can not conclude anything from any result<br>&g=
t;you obtain.<br><br>&gt;-- <br>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  Gilles Chanteperdrix<br>I w=
ill test it on my board. <br><br>Regards Michael<br><br></div></div></div><=
br>=0A=0A=0A      <hr size=3D1><font face=3D"Arial" size=3D"2">L'email dell=
a prossima generazione? Puoi averla con la <a href=3D"http://us.rd.yahoo.co=
m/mail/it/taglines/gmail/nowyoucan/nextgen/*http://it.docs.yahoo.com/nowyou=
can.html">Nuova Yahoo! Mail</a></font></body></html>
--0-2041198372-1197560479=:70825--

