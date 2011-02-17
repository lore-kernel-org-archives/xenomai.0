Message-ID: <608520.76294.qm@domain.hid>
Date: Thu, 17 Feb 2011 09:45:43 +0000 (GMT)
From: Franz Engel <franz_lambert_engel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-33883117-1297935943=:76294"
Subject: [Xenomai-help] valgrind and modprobe xeno_posix
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--0-33883117-1297935943=:76294
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,=0A=0AI'm still doubtful if I installed Xenomai correctly. When I start =
my QT-Programm =0Ait runs correctly and I can see a new process in /proc/xe=
nomai/state with the =0Aname of my program. I insert the following lines in=
 my *.pro-File (the draft for =0Amy makefile):=0ALIBS +=3D -Wl,@usr/xenomai=
/lib/posix.wrappers -L/usr/xenomai/lib -lpthread_rt =0A-lxenomai -lpthread =
-lrt -Xlinker -rpath -Xlinker /usr/xenomai/lib=0ALIBS +=3D -I/usr/xenomai/i=
nclude -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__ =0A-I/usr/xenomai/=
include/posix=0A=0AI'm absoult no makefile pro. The two lines are the only =
thing I changed in my =0A*.pro file. Do I have to make more changes?=0A=0AF=
uthermore,=A0when I run:=0Avalgrind --leak-check=3Dyes ./demo=0A=0AI get th=
e correct valgrind output, but also a line of xenomai:=0AXenomai: POSIX ski=
n or CONFIG_XENO_OPT_PERVASIVE disabled=0A(modprobe xeno_posix?)=0A=0ADo I =
use a bad makefile?=0A=0AThanking you in anticipation,=0A=A0=A0=A0=A0 Franz=
=0A=0A=0A
--0-33883117-1297935943=:76294
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><DIV>Hi,</DIV>=0A<DIV>&nbsp;</DIV>=0A<DIV>I'm still doubtfu=
l if I installed Xenomai correctly. When I start my QT-Programm it runs cor=
rectly and I can see a new process in /proc/xenomai/state with the name of =
my program. I insert the following lines in my *.pro-File (the draft for my=
 makefile):</DIV>=0A<DIV>LIBS +=3D -Wl,@usr/xenomai/lib/posix.wrappers -L/u=
sr/xenomai/lib -lpthread_rt -lxenomai -lpthread -lrt -Xlinker -rpath -Xlink=
er /usr/xenomai/lib</DIV>=0A<DIV>LIBS +=3D -I/usr/xenomai/include -D_GNU_SO=
URCE -D_REENTRANT -Wall -pipe -D__XENO__ -I/usr/xenomai/include/posix</DIV>=
=0A<DIV>&nbsp;</DIV>=0A<DIV>I'm absoult no makefile pro. The two lines are =
the only thing I changed in my *.pro file. Do I have to make more changes?<=
/DIV>=0A<DIV>&nbsp;</DIV>=0A<DIV>Futhermore,&nbsp;when I run:</DIV>=0A<DIV>=
valgrind --leak-check=3Dyes ./demo</DIV>=0A<DIV>&nbsp;</DIV>=0A<DIV>I get t=
he correct valgrind output, but also a line of xenomai:</DIV>=0A<DIV>Xenoma=
i: POSIX skin or CONFIG_XENO_OPT_PERVASIVE disabled</DIV>=0A<DIV>(modprobe =
xeno_posix?)</DIV>=0A<DIV>&nbsp;</DIV>=0A<DIV>Do I use a bad makefile?</DIV=
>=0A<DIV>&nbsp;</DIV>=0A<DIV>Thanking you in anticipation,</DIV>=0A<DIV>&nb=
sp;&nbsp;&nbsp;&nbsp; Franz</DIV>=0A<DIV>&nbsp;</DIV></div><br></body></htm=
l>
--0-33883117-1297935943=:76294--

