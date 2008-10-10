Date: Fri, 10 Oct 2008 17:57:49 +0000 (GMT)
From: Gabriele Moabiti <gabmoa@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-396205436-1223661469=:45338"
Message-ID: <563079.45338.qm@domain.hid>
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

--0-396205436-1223661469=:45338
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=0A> =0A> my_rt_task_func()=0A> {=0A>     int 3 // This is trapped by the c=
ustom exception routine (forwarded to xenomai handler). The terminal write=
=0A>             // trace/breakpoint trap=0A> }=0A=0A> This does not tell m=
e how the thread running "my_rt_task_func" is created.=0A=0AIn user space w=
ith the standard=0A=0A        rt_task_create(&task_desc, "MyTaskName", TASK=
_STKSZ, TASK_PRIO, TASK_MODE);=0A        rt_task_start(&task_desc, &my_rt_t=
ask_func, NULL);=0A=0A    Gabriele=0A=0A=0A=0A      Scopri il blog di Yahoo=
! Mail:=0ATrucchi, novit=C3=A0 e scrivi la tua opinione.=0Ahttp://www.ymail=
blogit.com/blog
--0-396205436-1223661469=:45338
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:arial,helvetica,sans-serif;font-size:10p=
t"><div style=3D"font-family: arial,helvetica,sans-serif; font-size: 10pt;"=
><div style=3D"font-family: arial,helvetica,sans-serif; font-size: 10pt;"><=
br>&gt; <br>&gt; my_rt_task_func()<br>&gt; {<br>&gt;&nbsp; &nbsp;  int 3 //=
 This is trapped by the custom exception routine (forwarded to xenomai hand=
ler). The terminal write<br>&gt;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  =
// trace/breakpoint trap<br>&gt; }<br><br>&gt; This does not tell me how th=
e thread running "my_rt_task_func" is created.<br><br>In user space with th=
e standard<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; rt_task_create(&amp=
;task_desc, "MyTaskName", TASK_STKSZ, TASK_PRIO, TASK_MODE);<br>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_start(&amp;task_desc, &amp;my_rt_ta=
sk_func, NULL);<br><br>&nbsp;&nbsp;&nbsp; Gabriele<br></div></div></div><br=
>=0A=0A=0A=0A      <hr size=3D1><font face=3D"Arial" size=3D"2">Scopri il <=
a href=3D"http://us.rd.yahoo.com/mail/it/taglines/yahoo/ymail/SIG=3D11djrg4=
60/**http%3A%2F%2Fwww.ymailblogit.com%2Fblog%2F"> Blog di Yahoo! Mail</a>: =
trucchi, novit=C3=A0, consigli... e scrivi la tua opinione!</font></body></=
html>
--0-396205436-1223661469=:45338--

