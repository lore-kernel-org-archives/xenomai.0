References: <857546.30206.qm@domain.hid>
	<490B32EF.8050503@domain.hid>
Date: Fri, 31 Oct 2008 16:47:33 +0000 (GMT)
From: Gabriele Moabiti <gabmoa@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-952731863-1225471653=:30247"
Message-ID: <327543.30247.qm@domain.hid>
Subject: Re: [Xenomai-help] floating point (int 16) exception
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
Cc: xenomai@xenomai.org

--0-952731863-1225471653=:30247
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=0A=0A>No, simply doing an fnclex will not do the trick.=0A>=0A>If you do n=
ot know the details of Xenomai and Linux FPU handling on x86,=0A>I advise y=
ou to let xenomai handle the fault, it does it without=0A>switching to seco=
ndary mode, so, you can use it. I do not want to=0A>explain you how it work=
s because it is rather hairy, so, the only way to=0A>understand, if you rea=
lly want to, is to read the xenomai and linux=0A>relevant sources.=0A=0AI n=
eed to manage exceptions in a different way of the x86 default so I have to=
 unmask fpu exceptions. I have read and follow how it works but in xenomai =
fpu exceptions invoke a switch to linux... =0A=0Aint xnpod_trap_fault(xnarc=
h_fltinfo_t *fltinfo)=0A{=0A    ...=0A    if (xnpod_shadow_p()) {=0A       =
 ...=0A        xnshadow_relax(xnarch_fault_notify(fltinfo));=0A    }=0A    =
return 0;=0A}=0A=0Aso there is not in the source code an example on how to =
trap exception and remain into real time task...=0A=0A=0A      Unisciti all=
a community di Io fotografo e video, il nuovo corso di fotografia di Gazzet=
ta dello sport:=0Ahttp://www.flickr.com/groups/iofotografoevideo
--0-952731863-1225471653=:30247
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:arial,helvetica,sans-serif;font-size:10p=
t"><div><br></div><div style=3D"font-family: arial,helvetica,sans-serif; fo=
nt-size: 10pt;"><div style=3D"font-family: arial,helvetica,sans-serif; font=
-size: 10pt;">&gt;No, simply doing an fnclex will not do the trick.<br>&gt;=
<br>&gt;If you do not know the details of Xenomai and Linux FPU handling on=
 x86,<br>&gt;I advise you to let xenomai handle the fault, it does it witho=
ut<br>&gt;switching to secondary mode, so, you can use it. I do not want to=
<br>&gt;explain you how it works because it is rather hairy, so, the only w=
ay to<br>&gt;understand, if you really want to, is to read the xenomai and =
linux<br>&gt;relevant sources.<br><br>I need to manage exceptions in a diff=
erent way of the x86 default so I have to unmask fpu exceptions. I have rea=
d and follow how it works but in xenomai fpu exceptions invoke a switch to
 linux... <br><br>int xnpod_trap_fault(xnarch_fltinfo_t *fltinfo)<br>{<br>&=
nbsp;&nbsp;&nbsp; ...<br>&nbsp;&nbsp;&nbsp; if (xnpod_shadow_p()) {<br>&nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ...<br>&nbsp; &nbsp; &nbsp;&nbsp;&nbsp; x=
nshadow_relax(xnarch_fault_notify(fltinfo));<br>&nbsp;&nbsp;&nbsp; }<br>&nb=
sp;&nbsp;&nbsp; return 0;<br>}<br><br>so there is not in the source code an=
 example on how to trap exception and remain into real time task...<br><br>=
<br><br></div></div></div><br>=0A=0A=0A=0A      <hr size=3D1><font face=3D"=
Arial" size=3D"2">Scopri la community di Io fotografo e video<br>=0A<a href=
=3Dhttp://us.rd.yahoo.com/SIG=3D11ud6kror/**http%3A%2F%2Fwww.flickr.com%2Fg=
roups%2Fiofotografoevideo%2F>Il nuovo corso</a> di Gazzetta dello sport per=
 diventare veri fotografi!</font></body></html>
--0-952731863-1225471653=:30247--

