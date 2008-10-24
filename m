Date: Fri, 24 Oct 2008 15:30:22 +0000 (GMT)
From: Gabriele Moabiti <gabmoa@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-923364900-1224862222=:59776"
Message-ID: <36141.59776.qm@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

--0-923364900-1224862222=:59776
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=0A=0A>INT 0 (divide error) or 16 (fpu exception)=0A>The system hangs.=0A=
=0AMaybe it's not too clear: the system hangs if i return RTHAL_EVENT_STOP =
doing nothing.=0AThe next one is the default behaviour when xenomai manage =
itself the exception.=0A=0A>When I pass to xenomai It doesn't handle the ex=
ception and relax the thread an propagate=0A>to linux (I think as expected =
to do).=0A=0A=0A      Scopri il blog di Yahoo! Mail:=0ATrucchi, novit=C3=A0=
 e scrivi la tua opinione.=0Ahttp://www.ymailblogit.com/blog
--0-923364900-1224862222=:59776
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:arial,helvetica,sans-serif;font-size:10p=
t"><div><br></div><div style=3D"font-family: arial,helvetica,sans-serif; fo=
nt-size: 10pt;"><div style=3D"font-family: times new roman,new york,times,s=
erif; font-size: 12pt;"><div style=3D"font-family: arial,helvetica,sans-ser=
if; font-size: 10pt;">&gt;INT 0 (divide error) or 16 (fpu exception)<br>&gt=
;The system=0A hangs.<br><br>Maybe it's not too clear: the system hangs if =
i return RTHAL_EVENT_STOP doing nothing.<br>The next one is the default beh=
aviour when xenomai manage itself the exception.<br>=0A<br>&gt;When I pass =
to xenomai It doesn't handle the exception and relax the thread an propagat=
e<br>&gt;to linux (I think as expected to do).<br>=0A</div><font size=3D"2"=
 face=3D"Arial"><br></font></div></div></div><br>=0A=0A=0A=0A      <hr size=
=3D1><font face=3D"Arial" size=3D"2">Scopri il <a href=3D"http://us.rd.yaho=
o.com/mail/it/taglines/yahoo/ymail/SIG=3D11djrg460/**http%3A%2F%2Fwww.ymail=
blogit.com%2Fblog%2F"> Blog di Yahoo! Mail</a>: trucchi, novit=C3=A0, consi=
gli... e scrivi la tua opinione!</font></body></html>
--0-923364900-1224862222=:59776--

