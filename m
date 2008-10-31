References: <857546.30206.qm@domain.hid>
	<490B32EF.8050503@domain.hid>
	<327543.30247.qm@domain.hid>
	<490B37D6.8050809@domain.hid>
	<352894.28773.qm@domain.hid>
	<490B3E58.3010206@domain.hid>
Date: Fri, 31 Oct 2008 18:41:19 +0000 (GMT)
From: Gabriele Moabiti <gabmoa@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2118816037-1225478479=:91697"
Message-ID: <125728.91697.qm@domain.hid>
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

--0-2118816037-1225478479=:91697
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=0A>You mean you want to handle a division by zero without ending the=0A>pr=
ogram, and without even switching to secondary mode? Then in this=0A>case, =
I am afraid you are on your own.=0A=0Ammm... it's better if i explain the s=
cenario to make sense.=0A=0AI am developing a driver for a CNC using xenoma=
i.=0ANow this cnc run on dos/win (and linux) and the real-time is based on =
nmi (with=0Aa pci card generate the nmi @ 0.125 us - 2ms attached to the pe=
ripherals and servodrives).=0ANow we want to switch to linux only changing =
the pci cart with an eth card and rtnet to=0Acommunicate.=0A=0AI have alrea=
dy done the ring 0 driver on linux (on windows is very similar) in a the *o=
rrible* way (I know!), =0Areprogramming the IDT and using cli and sti and u=
sing using xenomai only for small task=0Abut we want to use rtnet so I have=
 to better integrate into the xenomai context and=0Athe only way to do it p=
roper is to shift cnc to user rt domain.=0A(NOTE: it's a long story but cnc=
, written in asm x86 (500k) need to take the first 16 MB and this=0Ais done=
 with dirty tricks on gdt on ring 0, absolutely incompatible with linux/xen=
omai but=0Ain ring 3 with some mapping this problems disappears of course)=
=0A=0AThe cnc need to take different decisions on fpu exceptions:=0A1) the =
intel defaults actions on masked fpu exceptions aren't right for cnc=0A2) a=
n exception sometimes can occur but this must not stop cnc!=0A    (the cnc =
register the problem continue if it can be resumed)=0ASo custom exceptions =
handling is *really* needed.=0A=0AHowever I think a robust hard real time a=
pplication may need to remain in rt even if an=0Afpu exception is raised an=
d a custom exception handling is not so strange.=0A=0A    Gabriele=0A=0A=0A=
      Unisciti alla community di Io fotografo e video, il nuovo corso di fo=
tografia di Gazzetta dello sport:=0Ahttp://www.flickr.com/groups/iofotograf=
oevideo
--0-2118816037-1225478479=:91697
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:arial,helvetica,sans-serif;font-size:10p=
t"><div style=3D"font-family: arial,helvetica,sans-serif; font-size: 10pt;"=
><div style=3D"font-family: arial,helvetica,sans-serif; font-size: 10pt;"><=
br>&gt;You mean you want to handle a division by zero without ending the<br=
>&gt;program, and without even switching to secondary mode? Then in this<br=
>&gt;case, I am afraid you are on your own.<br><br>mmm... it's better if i =
explain the scenario to make sense.<br><br>I am developing a driver for a C=
NC using xenomai.<br>Now this cnc run on dos/win (and linux) and the real-t=
ime is based on nmi (with<br>a pci card generate the nmi @ 0.125 us - 2ms a=
ttached to the peripherals and servodrives).<br>Now we want to switch to li=
nux only changing the pci cart with an eth card and rtnet to<br>communicate=
.<br><br>I have already done the ring 0 driver on linux (on windows is very
 similar) in a the *orrible* way (I know!), <br>reprogramming the IDT and u=
sing cli and sti and using using xenomai only for small task<br>but we want=
 to use rtnet so I have to better integrate into the xenomai context and<br=
>the only way to do it proper is to shift cnc to user rt domain.<br>(NOTE: =
it's a long story but cnc, written in asm x86 (500k) need to take the first=
 16 MB and this<br>is done with dirty tricks on gdt on ring 0, absolutely i=
ncompatible with linux/xenomai but<br>in ring 3 with some mapping this prob=
lems disappears of course)<br><br>The cnc need to take different decisions =
on fpu exceptions:<br>=0A1) the intel defaults actions on masked fpu except=
ions aren't right for cnc<br>=0A2) an exception sometimes can occur but thi=
s must not stop cnc!<br>=0A&nbsp;&nbsp;&nbsp; (the cnc register the problem=
 continue if it can be resumed)<br>=0ASo custom exceptions handling is *rea=
lly* needed.<br>=0A<br>However I think a robust hard real time application =
may need to remain in rt even if an<br>fpu exception is raised and a custom=
 exception handling is not so strange.<br><br>&nbsp;&nbsp;&nbsp; Gabriele<b=
r><br></div></div></div><br>=0A=0A=0A=0A      <hr size=3D1><font face=3D"Ar=
ial" size=3D"2">Scopri la community di Io fotografo e video<br>=0A<a href=
=3Dhttp://us.rd.yahoo.com/SIG=3D11ud6kror/**http%3A%2F%2Fwww.flickr.com%2Fg=
roups%2Fiofotografoevideo%2F>Il nuovo corso</a> di Gazzetta dello sport per=
 diventare veri fotografi!</font></body></html>
--0-2118816037-1225478479=:91697--

