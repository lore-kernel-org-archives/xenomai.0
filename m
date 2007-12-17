Date: Mon, 17 Dec 2007 14:51:43 +0000 (GMT)
From: Michael Trimarchi <trimarchimichael@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2063534368-1197903103=:6456"
Message-ID: <662766.6456.qm@domain.hid>
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

--0-2063534368-1197903103=:6456
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=0AHi,=0A>Ok. Could you try something ? It will work with I-pipe only but w=
ill=0A>break Xenomai, so do not try to run Xenomai over this modification.=
=0A=0A>In include/asm-arm/system.h in the definition of the switch_to macro=
=0A>try removing the calls to local_irq_disable_hw_cond and=0A>local_irq_en=
able_hw_cond, and tell us if you still get the serial=0A>driver overruns.=
=0AOk,=0Anow I can't because I have a flight in the afternoon. Maybe this n=
ight =0Aor tomorrow :)=0A=0A>This means that there is a fault in xnpod_sche=
dule, that causes a=0A>Linux function to be called over Xenomai domain. But=
 the problem is=0A>the fault in the first place. To debug this, we need a d=
isassembly of=0A>xnpod_schedule. This will be best discussed on Xenomai mai=
ling list.=0A>You probably have a problem in your port of the I-pipe patch,=
 since=0A>Xenomai is reported to works on other AT91s.=0AOk=0A=0ARegards MI=
chael=0A=0A=0A=0A=0A=0A=0A      ___________________________________ =0AL'em=
ail della prossima generazione? Puoi averla con la nuova Yahoo! Mail: =0Aht=
tp://it.docs.yahoo.com/nowyoucan.html
--0-2063534368-1197903103=:6456
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:10pt"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 10pt;"><br><div style=3D"font-family: times new roman,new =
york,times,serif; font-size: 12pt;">Hi,<br>&gt;Ok. Could you try something =
? It will work with I-pipe only but will<br>&gt;break Xenomai, so do not tr=
y to run Xenomai over this modification.<br><br>&gt;In include/asm-arm/syst=
em.h in the definition of the switch_to macro<br>&gt;try removing the calls=
 to local_irq_disable_hw_cond and<br>&gt;local_irq_enable_hw_cond, and tell=
 us if you still get the serial<br>&gt;driver overruns.<br>Ok,<br>now I can=
't because I have a flight in the afternoon. Maybe this night <br>or tomorr=
ow :)<br><br>&gt;This means that there is a fault in xnpod_schedule, that c=
auses a<br>&gt;Linux function to be called over Xenomai domain. But the
 problem is<br>&gt;the fault in the first place. To debug this, we need a d=
isassembly of<br>&gt;xnpod_schedule. This will be best discussed on Xenomai=
 mailing list.<br>&gt;You probably have a problem in your port of the I-pip=
e patch, since<br>&gt;Xenomai is reported to works on other AT91s.<br>Ok<br=
><br>Regards MIchael<br><br></div></div></div><br>=0A=0A=0A      <hr size=
=3D1><font face=3D"Arial" size=3D"2">L'email della prossima generazione? Pu=
oi averla con la <a href=3D"http://us.rd.yahoo.com/mail/it/taglines/gmail/n=
owyoucan/nextgen/*http://it.docs.yahoo.com/nowyoucan.html">Nuova Yahoo! Mai=
l</a></font></body></html>
--0-2063534368-1197903103=:6456--

