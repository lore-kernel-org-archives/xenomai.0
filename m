Date: Mon, 13 Oct 2008 09:55:54 +0000 (GMT)
From: Gabriele Moabiti <gabmoa@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1962456848-1223891754=:58327"
Message-ID: <967654.58327.qm@domain.hid>
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

--0-1962456848-1223891754=:58327
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>> I did't specify I have passed mem=3Dxxx to kernel to take the upper 16MB=
=0A>> I think the RTDM mapping works.=0A>=0A>Yes, but I still think this is=
 useless. If your user-space code expects=0A>to be running from 1MB to 16MB=
, it expects this for virtual addresses,=0A>not for physical addresses. So,=
 I really think you should mmap the 1MB=0A>to 16MB region by passing the st=
art address to mmap with the MMAP_FIXED=0A>flag.=0A=0AI have tried fixed mm=
ap mode and I have no luck.=0AOutside the mmap mapped memory exceptions are=
 trapped with rthal_trap_catch.=0AInside the callback doesn't work... seems=
 to dislike mapped memory...=0A=0AAnother question:=0AIs it right I can set=
 rthal_trap_catch only in kernel rt/nrt task?=0A=0A    Gabriele=0A=0A=0A   =
   Scopri il blog di Yahoo! Mail:=0ATrucchi, novit=C3=A0 e scrivi la tua op=
inione.=0Ahttp://www.ymailblogit.com/blog
--0-1962456848-1223891754=:58327
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:arial,helvetica,sans-serif;font-size:10p=
t"><div style=3D"font-family: arial,helvetica,sans-serif; font-size: 10pt;"=
><div style=3D"font-family: arial,helvetica,sans-serif; font-size: 10pt;">&=
gt;&gt; I did't specify I have passed mem=3Dxxx to kernel to take the upper=
 16MB<br>&gt;&gt; I think the RTDM mapping works.<br>&gt;<br>&gt;Yes, but I=
 still think this is useless. If your user-space code expects<br>&gt;to be =
running from 1MB to 16MB, it expects this for virtual addresses,<br>&gt;not=
 for physical addresses. So, I really think you should mmap the 1MB<br>&gt;=
to 16MB region by passing the start address to mmap with the MMAP_FIXED<br>=
&gt;flag.<br><br>I have tried fixed mmap mode and I have no luck.<br>Outsid=
e the mmap mapped memory exceptions are trapped with rthal_trap_catch.<br>I=
nside the callback doesn't work... seems to dislike mapped
 memory...<br><br>Another question:<br>Is it right I can set rthal_trap_cat=
ch only in kernel rt/nrt task?<br><br>&nbsp;&nbsp;&nbsp; Gabriele<br><br></=
div></div></div><br>=0A=0A=0A=0A      <hr size=3D1><font face=3D"Arial" siz=
e=3D"2">Scopri il <a href=3D"http://us.rd.yahoo.com/mail/it/taglines/yahoo/=
ymail/SIG=3D11djrg460/**http%3A%2F%2Fwww.ymailblogit.com%2Fblog%2F"> Blog d=
i Yahoo! Mail</a>: trucchi, novit=C3=A0, consigli... e scrivi la tua opinio=
ne!</font></body></html>
--0-1962456848-1223891754=:58327--

