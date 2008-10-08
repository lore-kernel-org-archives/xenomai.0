Date: Wed, 8 Oct 2008 11:32:44 +0000 (GMT)
From: Gabriele Moabiti <gabmoa@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1559547962-1223465564=:10282"
Message-ID: <581220.10282.qm@domain.hid>
Subject: Re: [Xenomai-help] trap exceptions in user
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

--0-1559547962-1223465564=:10282
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>You say yes, then propose to do what I told you was a bad idea. So, I=0A>r=
epeat: this is a bad idea. =0A=0AOk, now it's clear. This a port of a real =
time application first developed in DOS=0Athen ported to Windows XP so dirt=
y hacking was the rule.=0ASorry for the misunderstanding.=0A=0A> I think it=
 is better not to touch the=0A>hardware vector and use the trap interceptio=
n mechanism proposed by=0A>Xenomai rthal. And split exception handling in a=
 kernel-space handler=0A>which signals a user-space server thread.=0A=0AI t=
hink I can do the exception handling in a kernel-space handler without pass=
 to an user space server thread=0Adue to the memory of the process where th=
e SIS live (both data and code) is kernel memory mapped in the user space a=
nd SIS.=0A=0AI had read Adeos is the low level of the real time part and Xe=
nomai is one of the possible=0Adomain. Do I Have to use the rthal_trap_catc=
h function to alter Xenomai? Is there some examples=0Ato better understand =
how to do? =0ANOTE: I have to used rtnet too. Can this customization altera=
te the behaviour of rtnet?=0A=0AThank you=0A=0A=0A      Scopri il blog di Y=
ahoo! Mail:=0ATrucchi, novit=C3=A0 e scrivi la tua opinione.=0Ahttp://www.y=
mailblogit.com/blog
--0-1559547962-1223465564=:10282
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:arial,helvetica,sans-serif;font-size:10p=
t"><div style=3D"font-family: arial,helvetica,sans-serif; font-size: 10pt;"=
><div style=3D"font-family: arial,helvetica,sans-serif; font-size: 10pt;">&=
gt;You say yes, then propose to do what I told you was a bad idea. So, I<br=
>&gt;repeat: this is a bad idea. <br><br>Ok, now it's clear. This a port of=
 a real time application first developed in DOS<br>then ported to Windows X=
P so dirty hacking was the rule.<br>Sorry for the misunderstanding.<br><br>=
&gt; I think it is better not to touch the<br>&gt;hardware vector and use t=
he trap interception mechanism proposed by<br>&gt;Xenomai rthal. And split =
exception handling in a kernel-space handler<br>&gt;which signals a user-sp=
ace server thread.<br><br>I think I can do the exception handling in a kern=
el-space handler without pass to an user space server thread<br>=0Adue to t=
he memory of the process where the SIS live (both data and code) is kernel =
memory mapped in the user space and SIS.<br>=0A<br>I had read Adeos is the =
low level of the real time part and Xenomai is one of the possible<br>domai=
n. Do I Have to use the rthal_trap_catch function to alter Xenomai? Is ther=
e some examples<br>to better understand how to do? <br>NOTE: I have to used=
 rtnet too. Can this customization alterate the behaviour of rtnet?<br><br>=
Thank you<br><br></div></div></div><br>=0A=0A=0A=0A      <hr size=3D1><font=
 face=3D"Arial" size=3D"2">Scopri il <a href=3D"http://us.rd.yahoo.com/mail=
/it/taglines/yahoo/ymail/SIG=3D11djrg460/**http%3A%2F%2Fwww.ymailblogit.com=
%2Fblog%2F"> Blog di Yahoo! Mail</a>: trucchi, novit=C3=A0, consigli... e s=
crivi la tua opinione!</font></body></html>
--0-1559547962-1223465564=:10282--

