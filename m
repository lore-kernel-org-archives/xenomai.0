Date: Wed, 15 Oct 2008 15:30:43 +0000 (GMT)
From: Gabriele Moabiti <gabmoa@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-128110599-1224084643=:66216"
Message-ID: <373456.66216.qm@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

--0-128110599-1224084643=:66216
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>rtdm_printk (read 'k' as 'kernel') is for driver development in kernel=0A>=
space only.=0A>=0A>What you are looking for is rt_printf from the rtdk lib.=
 See related=0A>example (examples/native/rtprint.c).=0A=0AAt kernel level I=
 usually write defines like this=0A=0A#define DBG_PRINTF(expr...) \=0A  if =
(rtdm_in_rt_context()) \=0A    rtdm_printk(expr); \=0A  else if (kdb_on) \=
=0A    printk(expr)=0A=0Ato manage xenomai and linux output for debugging.=
=0AIs there something like rtdm_in_rt_context for the user space?=0A=0A=0A =
     Scopri il blog di Yahoo! Mail:=0ATrucchi, novit=C3=A0 e scrivi la tua =
opinione.=0Ahttp://www.ymailblogit.com/blog
--0-128110599-1224084643=:66216
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:arial,helvetica,sans-serif;font-size:10p=
t"><div style=3D"font-family: arial,helvetica,sans-serif; font-size: 10pt;"=
><div style=3D"font-family: arial,helvetica,sans-serif; font-size: 10pt;">&=
gt;rtdm_printk (read 'k' as 'kernel') is for driver development in kernel<b=
r>&gt;space only.<br>&gt;<br>&gt;What you are looking for is rt_printf from=
 the rtdk lib. See related<br>&gt;example (examples/native/rtprint.c).<br><=
br>At kernel level I usually write defines like this<br><br>#define DBG_PRI=
NTF(expr...) \<br>&nbsp; if (rtdm_in_rt_context()) \<br>&nbsp;&nbsp;&nbsp; =
rtdm_printk(expr); \<br>&nbsp; else if (kdb_on) \<br>&nbsp;&nbsp;&nbsp; pri=
ntk(expr)<br><br>to manage xenomai and linux output for debugging.<br>Is th=
ere something like rtdm_in_rt_context for the user space?<br><br></div></di=
v></div><br>=0A=0A=0A=0A      <hr size=3D1><font face=3D"Arial" size=3D"2">=
Scopri il <a href=3D"http://us.rd.yahoo.com/mail/it/taglines/yahoo/ymail/SI=
G=3D11djrg460/**http%3A%2F%2Fwww.ymailblogit.com%2Fblog%2F"> Blog di Yahoo!=
 Mail</a>: trucchi, novit=C3=A0, consigli... e scrivi la tua opinione!</fon=
t></body></html>
--0-128110599-1224084643=:66216--

