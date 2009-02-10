References: <729916.37479.qm@domain.hid>
	<49915E95.7010101@domain.hid>
Date: Tue, 10 Feb 2009 11:08:43 +0000 (GMT)
From: Mathieu JOINIE-MAURIN <mjoiniem@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-250392756-1234264123=:86092"
Message-ID: <951569.86092.qm@domain.hid>
Subject: [Xenomai-help] Re : Problem with Xeno-test: "Something died a XXX
	or"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--0-250392756-1234264123=:86092
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The thing is that as I had to compile many times my kernel in order to try =
many .config, I had time to try to run ./latency when compilation is made. =
And there is no problem with latencies for example.=0A=0AWhat does make exa=
ctly the load generator ? How can I try to debug it ? =0A=0AMathieu=0A=0A=
=0A=0A=0A=0A________________________________=0ADe : Gilles Chanteperdrix <g=
illes.chanteperdrix@domain.hid>=0A=C3=80 : Mathieu JOINIE-MAURIN <mjoiniem=
@yahoo.fr>=0ACc : xenomai@xenomai.org le : Mardi, 10 F=C3=A9=
vrier 2009, 12h01mn 41s=0AObjet : Re: [Xenomai-help] Problem with Xeno-test=
: "Something died a XXX or"=0A=0AMathieu JOINIE-MAURIN wrote:=0A> Hello,=0A=
> =0A> I try to install Xenomai on Ubunut Hardy 8.04. Versions used are: -=
=0A> xenomai-2.4.6.1 - linux-kernel 2-6.24.6 - adeos patch:=0A> adeos-ipipe=
-2.6.24-x86-2.0-07.patch=0A> =0A> I tried many .config files but it is alwa=
ys the same problem with=0A> Xeno-test. It seems that there is a problem wi=
th the "generate load"=0A> part of the script. Attached, are two files. One=
 is xeno-test without=0A> modifying it. The other is xeno-test results but =
with the "generate=0A> load'" part removed.=0A> =0A> Latency (in user space=
 and kernel) seem to be great. Around 7 us in=0A> user-space and 4 us in ke=
rnel for worst case.=0A=0AUnfortunately, latencies obtained without loading=
 the system are=0Ameaningless. So, generating a load is mandatory. I am afr=
aid you will=0Ahave to debug why the load generator does not work for you.=
=0A=0A-- =0A                                                 Gilles.=0A=0A=
=0A=0A      _______________________________________________________________=
___________________________________=0ANe pleurez pas si votre Webmail ferme=
 ! R=C3=A9cup=C3=A9rez votre historique sur Yahoo! Mail ! http://fr.docs.ya=
hoo.com/mail/transfert_mails.html
--0-250392756-1234264123=:86092
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman,new york,times,serif;fon=
t-size:10pt"><div>The thing is that as I had to compile many times my kerne=
l in order to try many .config, I had time to try to run ./latency when com=
pilation is made. And there is no problem with latencies for example.<br><b=
r>What does make exactly the load generator ? How can I try to debug it ? <=
br><br>Mathieu<br><br></div><div style=3D"font-family: times new roman,new =
york,times,serif; font-size: 10pt;"><br><div style=3D"font-family: arial,he=
lvetica,sans-serif; font-size: 13px;"><font face=3D"Tahoma" size=3D"2"><hr =
size=3D"1"><b><span style=3D"font-weight: bold;">De :</span></b> Gilles Cha=
nteperdrix &lt;gilles.chanteperdrix@xenomai.org&gt;<br><b><span style=3D"fo=
nt-weight: bold;">=C3=80 :</span></b> Mathieu JOINIE-MAURIN &lt;mjoiniem@domain.hid=
hoo.fr&gt;<br><b><span style=3D"font-weight: bold;">Cc :</span></b>
 xenomai@xenomai.org<br><b><span style=3D"font-weight: bold;">Envoy=C3=A9 =
le :</span></b> Mardi, 10 F=C3=A9vrier 2009, 12h01mn 41s<br><b><span style=
=3D"font-weight: bold;">Objet&nbsp;:</span></b> Re: [Xenomai-help] Problem =
with Xeno-test: "Something died a XXX or"<br></font><br>Mathieu JOINIE-MAUR=
IN wrote:<br>&gt; Hello,<br>&gt; <br>&gt; I try to install Xenomai on Ubunu=
t Hardy 8.04. Versions used are: -<br>&gt; xenomai-2.4.6.1 - linux-kernel 2=
-6.24.6 - adeos patch:<br>&gt; adeos-ipipe-2.6.24-x86-2.0-07.patch<br>&gt; =
<br>&gt; I tried many .config files but it is always the same problem with<=
br>&gt; Xeno-test. It seems that there is a problem with the "generate load=
"<br>&gt; part of the script. Attached, are two files. One is xeno-test wit=
hout<br>&gt; modifying it. The other is xeno-test results but with the "gen=
erate<br>&gt; load'" part removed.<br>&gt; <br>&gt; Latency (in user space =
and kernel) seem to be great. Around 7 us in<br>&gt; user-space and 4 us in
 kernel for worst case.<br><br>Unfortunately, latencies obtained without lo=
ading the system are<br>meaningless. So, generating a load is mandatory. I =
am afraid you will<br>have to debug why the load generator does not work fo=
r you.<br><br>-- <br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  Gilles.<br></div></div></div><br>=
=0A=0A=0A=0A      <hr size=3D"1"> =0ANe pleurez pas si votre Webmail ferme.=
 <a href=3D"http://fr.rd.yahoo.com/mail_fr/taglines/caramail/*http://fr.doc=
s.yahoo.com/mail/transfert_mails.html">R=C3=A9cup=C3=A9rez votre historique=
 sur Yahoo! Mail</a></body></html>
--0-250392756-1234264123=:86092--


