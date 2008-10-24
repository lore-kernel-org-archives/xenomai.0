Date: Fri, 24 Oct 2008 19:17:21 +0000 (GMT)
From: Gabriele Moabiti <gabmoa@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-889301253-1224875841=:68232"
Message-ID: <66014.68232.qm@domain.hid>
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Xenomai help <xenomai@xenomai.org>

--0-889301253-1224875841=:68232
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=0AGilles Chanteperdrix wrote:=0A> Gabriele Moabiti wrote:=0A>> (...)=0A>> =
I consider now ManageCustomExceptions a function that do nothing.=0A>> (...=
)=0A>> INT 0 (divide error) or 16 (fpu exception)=0A>> The system hangs.=0A=
> =0A> It will not work. It is because you have to handle the exception.=0A=
> Otherwise, when returning to user-space, your programs tries the faulty=
=0A> exception again, triggers the handler, which does nothing, and loops=
=0A> indefinitely...=0A> =0A=0Aso the int 1 and 3 are instead signed as tra=
ps with the old CS:EIP points past instruction causing exception...=0A=0ASo=
rry for the question (I have always done it directly in asm reprogramming c=
ustomizing the IDT), do I have to change the eip of the pt_regs structure p=
assed to the function?=0A=0AThank you,=0A    Gabriele=0A=0A=0A=0A      Scop=
ri il blog di Yahoo! Mail:=0ATrucchi, novit=C3=A0 e scrivi la tua opinione.=
=0Ahttp://www.ymailblogit.com/blog
--0-889301253-1224875841=:68232
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:arial,helvetica,sans-serif;font-size:10p=
t"><div style=3D"font-family: arial,helvetica,sans-serif; font-size: 10pt;"=
><div style=3D"font-family: arial,helvetica,sans-serif; font-size: 10pt;"><=
br>Gilles Chanteperdrix wrote:<br>&gt; Gabriele Moabiti wrote:<br>&gt;&gt; =
(...)<br>&gt;&gt; I consider now ManageCustomExceptions a function that do =
nothing.<br>&gt;&gt; (...)<br>&gt;&gt; INT 0 (divide error) or 16 (fpu exce=
ption)<br>&gt;&gt; The system hangs.<br>&gt; <br>&gt; It will not work. It =
is because you have to handle the exception.<br>&gt; Otherwise, when return=
ing to user-space, your programs tries the faulty<br>&gt; exception again, =
triggers the handler, which does nothing, and loops<br>&gt; indefinitely...=
<br>&gt; <br><br>so the int 1 and 3 are instead signed as traps with the ol=
d CS:EIP points past instruction causing exception...<br><br>Sorry for the
 question (I have always done it directly in asm reprogramming customizing =
the IDT), do I have to change the eip of the pt_regs structure passed to th=
e function?<br><br>Thank you,<br>&nbsp;&nbsp;&nbsp; Gabriele<br></div></div=
></div><br>=0A=0A=0A=0A      <hr size=3D1><font face=3D"Arial" size=3D"2">S=
copri il <a href=3D"http://us.rd.yahoo.com/mail/it/taglines/yahoo/ymail/SIG=
=3D11djrg460/**http%3A%2F%2Fwww.ymailblogit.com%2Fblog%2F"> Blog di Yahoo! =
Mail</a>: trucchi, novit=C3=A0, consigli... e scrivi la tua opinione!</font=
></body></html>
--0-889301253-1224875841=:68232--

