Date: Thu, 19 Jul 2007 08:33:08 +0000 (GMT)
From: Mathieu JOINIE-MAURIN <mjoiniem@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1265041004-1184833988=:95898"
Message-ID: <269393.95898.qm@domain.hid>
Subject: [Xenomai-help] Re : Problem with rt_pipe and user space
	communication
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

--0-1265041004-1184833988=:95898
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,=0A=0ASo i tried again this morning by sending an array of 3 doubles on =
my real time side (with rt_pipe_stream). On user space, I get as expected 2=
4 bytes which matches the size of 3 doubles. But I cannot get more datas an=
d I still do not understand why. My real time function runs periodically ev=
ery 1 ms and my userspace function runs in background or periodically (arou=
nd 500ms). What do I do wrong so that when I use the read(2) function it on=
ly reads datas by group (as if there was message boundary).=0A=0AThanks in =
advance,=0A=0AMathieu=0A=0A----- Message d'origine ----=0ADe : Philippe Ger=
um <rpm@xenomai.org>=0A=C0 : Mathieu JOINIE-MAURIN <mjoiniem@domain.hid>=0ACc=
 : xenomai@xenomai.org le : Mercredi, 18 Juillet 2007, 19h48mn =
37s=0AObjet : Re: [Xenomai-help] Problem with rt_pipe and user space commun=
ication=0A=0AOn Wed, 2007-07-18 at 14:43 +0000, Mathieu JOINIE-MAURIN wrote=
:=0A> Hi everybody,=0A> =0A> I try to learn Xenomai. I have a problem that =
I do not understand. I=0A> want that my real time task to communicate with =
my user space task=0A> through a pipe (FIFO) in order to save sample datas =
in a file. My=0A> problem is the following. I create a pipe with:=0A=0A<sni=
p>=0A> =0A> I get a value of 8 for nb_read which corresponds to sizeof(doub=
le).=0A> But i am expecting more. I do not know why the system function rea=
d(2)=0A> works like this.=0A> =0AThe user-space side seems to read double v=
alues as soon as they are=0Awritten to the pipe (i.e. try sending two doubl=
es in a row at each=0Akernel-side write op), so this behaviour would be the=
 expected one.=0A=0ASidenote: rt_pipe_stream will not keep message boundari=
es (e.g. writing=0A8 + 4 + 4 may cause the read side to get 12 + 4); rt_pip=
e_send/write=0Awill keep the boundaries intact.=0A=0A> Thank you in advance=
 for your help,=0A> =0A> Mathieu=0A> =0A> =0A> =0A> _______________________=
_______________________________________________=0A> Ne gardez plus qu'une s=
eule adresse mail ! Copiez vos mails vers=0A> Yahoo! Mail =0A> ____________=
___________________________________=0A> Xenomai-help mailing list=0A> Xenom=
ai-help@domain.hid> https://mail.gna.org/listinfo/xenomai-help=0A-- =0APhil=
ippe.=0A=0A=0A=0A=0A=0A=0A=0A=0A=0A      __________________________________=
___________________________________________ =0ANe gardez plus qu'une seule =
adresse mail ! Copiez vos mails vers Yahoo! Mail 
--0-1265041004-1184833988=:95898
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman,new york,times,serif;fon=
t-size:10pt"><div style=3D"font-family: times new roman,new york,times,seri=
f; font-size: 10pt;">Hi,<br><br>So i tried again this morning by sending an=
 array of 3 doubles on my real time side (with rt_pipe_stream). On user spa=
ce, I get as expected 24 bytes which matches the size of 3 doubles. But I c=
annot get more datas and I still do not understand why. My real time functi=
on runs periodically every 1 ms and my userspace function runs in backgroun=
d or periodically (around 500ms). What do I do wrong so that when I use the=
 read(2) function it only reads datas by group (as if there was message bou=
ndary).<br><br>Thanks in advance,<br><br>Mathieu<br><br><div style=3D"font-=
family: times new roman,new york,times,serif; font-size: 12pt;">----- Messa=
ge d'origine ----<br>De : Philippe Gerum &lt;rpm@xenomai.org&gt;<br>=C0 : M=
athieu JOINIE-MAURIN
 &lt;mjoiniem@domain.hid&gt;<br>Cc : xenomai@xenomai.org<br>Envoy=E9 le : Me=
rcredi, 18 Juillet 2007, 19h48mn 37s<br>Objet&nbsp;: Re: [Xenomai-help] Pro=
blem with rt_pipe and user space communication<br><br><div>On Wed, 2007-07-=
18 at 14:43 +0000, Mathieu JOINIE-MAURIN wrote:<br>&gt; Hi everybody,<br>&g=
t; <br>&gt; I try to learn Xenomai. I have a problem that I do not understa=
nd. I<br>&gt; want that my real time task to communicate with my user space=
 task<br>&gt; through a pipe (FIFO) in order to save sample datas in a file=
. My<br>&gt; problem is the following. I create a pipe with:<br><br>&lt;sni=
p&gt;<br>&gt; <br>&gt; I get a value of 8 for nb_read which corresponds to =
sizeof(double).<br>&gt; But i am expecting more. I do not know why the syst=
em function read(2)<br>&gt; works like this.<br>&gt; <br>The user-space sid=
e seems to read double values as soon as they are<br>written to the pipe (i=
.e. try sending two doubles in a row at each<br>kernel-side write op), so t=
his behaviour
 would be the expected one.<br><br>Sidenote: rt_pipe_stream will not keep m=
essage boundaries (e.g. writing<br>8 + 4 + 4 may cause the read side to get=
 12 + 4); rt_pipe_send/write<br>will keep the boundaries intact.<br><br>&gt=
; Thank you in advance for your help,<br>&gt; <br>&gt; Mathieu<br>&gt; <br>=
&gt; <br>&gt; <br>&gt; ____________________________________________________=
__________________<br>&gt; Ne gardez plus qu'une seule adresse mail ! Copie=
z vos mails vers<br>&gt; Yahoo! Mail <br>&gt; _____________________________=
__________________<br>&gt; Xenomai-help mailing list<br>&gt; Xenomai-help@domain.hid=
na.org<br>&gt; <a target=3D"_blank" href=3D"https://mail.gna.org/listinfo/x=
enomai-help">https://mail.gna.org/listinfo/xenomai-help</a><br>-- <br>Phili=
ppe.<br><br><br></div></div><br></div></div><br>=0A=0A=0A=0A      <hr size=
=3D"1"> =0ANe gardez plus qu'une seule adresse mail ! <a href=3D"http://www=
.trueswitch.com/yahoo-fr/">Copiez vos mails</a> vers Yahoo! Mail </body></h=
tml>
--0-1265041004-1184833988=:95898--

