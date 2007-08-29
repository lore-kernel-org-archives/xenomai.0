Date: Wed, 29 Aug 2007 09:02:24 +0000 (GMT)
From: Mathieu JOINIE-MAURIN <mjoiniem@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-690243831-1188378144=:33097"
Message-ID: <904710.33097.qm@domain.hid>
Subject: [Xenomai-help] Re :  sqrt() function in xenomai kernel module
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

--0-690243831-1188378144=:33097
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

The application I used is a small controller for robot developped by people=
 in the lab. Before it used to be in RTAI. But now they are trying to use X=
enomai. The application is splitted in two parts:=0Athe user side which sav=
es data, manages interfaces and the kernel module which realise all the rea=
l time tisk (sampling, writing to electronic card, controler).=0AThe commun=
ications between the two is made by 5 pipes (command, parameters, acknowled=
gment, save, status).=0A=0AThis is why i need to make my sqrt() function (o=
f double variables)  into my kernel modul part.=0A=0AMathieu=0A=0A----- Mes=
sage d'origine ----=0ADe : Jan Kiszka <jan.kiszka@domain.hid>=0A=C0 : Mathieu J=
OINIE-MAURIN <mjoiniem@domain.hid>=0ACc : xenomai@xenomai.org le =
: Mercredi, 29 Ao=FBt 2007, 10h43mn 16s=0AObjet : Re: [Xenomai-help] sqrt()=
 function in xenomai kernel module=0A=0AMathieu JOINIE-MAURIN wrote:=0A> Hi=
,=0A> =0A> I need to use a sqrt() function in a kernel module code. I am a =
beginner with Xenomai. Is there any math_module which already exists ?=0A=
=0ACounter question: Why do you need to use math in kernel code? It is=0Age=
nerally a sign something is not well split-up between kernel-based=0Adriver=
 code and user-space RT applications.=0A=0ATo answer your question: No, Xen=
omai does not come with a kernel math=0Alib because there is not much use f=
or it - generally. Porting the app to=0Auser-space is recommended.=0A=0AJan=
=0A=0A=0A=0A=0A=0A=0A=0A=0A      __________________________________________=
___________________________________ =0ANe gardez plus qu'une seule adresse =
mail ! Copiez vos mails vers Yahoo! Mail 
--0-690243831-1188378144=:33097
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman,new york,times,serif;fon=
t-size:10pt"><div style=3D"font-family: times new roman,new york,times,seri=
f; font-size: 10pt;">The application I used is a small controller for robot=
 developped by people in the lab. Before it used to be in RTAI. But now the=
y are trying to use Xenomai. The application is splitted in two parts:<br>t=
he user side which saves data, manages interfaces and the kernel module whi=
ch realise all the real time tisk (sampling, writing to electronic card, co=
ntroler).<br>The communications between the two is made by 5 pipes (command=
, parameters, acknowledgment, save, status).<br><br>This is why i need to m=
ake my sqrt() function (of double variables)&nbsp; into my kernel modul par=
t.<br><br>Mathieu<br><br><div style=3D"font-family: times new roman,new yor=
k,times,serif; font-size: 12pt;">----- Message d'origine ----<br>De : Jan
 Kiszka &lt;jan.kiszka@domain.hid&gt;<br>=C0 : Mathieu JOINIE-MAURIN &lt;mjoini=
em@domain.hid&gt;<br>Cc : xenomai@xenomai.org<br>Envoy=E9 le : Mercredi, 29 =
Ao=FBt 2007, 10h43mn 16s<br>Objet&nbsp;: Re: [Xenomai-help] sqrt() function=
 in xenomai kernel module<br><br><div>Mathieu JOINIE-MAURIN wrote:<br>&gt; =
Hi,<br>&gt; <br>&gt; I need to use a sqrt() function in a kernel module cod=
e. I am a beginner with Xenomai. Is there any math_module which already exi=
sts ?<br><br>Counter question: Why do you need to use math in kernel code? =
It is<br>generally a sign something is not well split-up between kernel-bas=
ed<br>driver code and user-space RT applications.<br><br>To answer your que=
stion: No, Xenomai does not come with a kernel math<br>lib because there is=
 not much use for it - generally. Porting the app to<br>user-space is recom=
mended.<br><br>Jan<br><br></div></div><br></div></div><br>=0A=0A=0A=0A     =
 <hr size=3D"1"> =0ANe gardez plus qu'une seule adresse mail ! <a href=3D"h=
ttp://www.trueswitch.com/yahoo-fr/">Copiez vos mails</a> vers Yahoo! Mail <=
/body></html>
--0-690243831-1188378144=:33097--

