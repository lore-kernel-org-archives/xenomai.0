Message-ID: <592273.9623.qm@domain.hid>
Date: Thu, 17 Feb 2011 13:32:40 +0000 (GMT)
From: Franz Engel <franz_lambert_engel@domain.hid>
In-Reply-To: <4D5CF34B.3030905@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1174114072-1297949560=:9623"
Subject: Re: [Xenomai-help] valgrind and modprobe xeno_posix
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--0-1174114072-1297949560=:9623
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

>> Hi,
>>=20
>> I'm still doubtful if I installed Xenomai correctly. When I start my QT-=
Programm=20
>> it runs correctly and I can see a new process in /proc/xenomai/state wit=
h the=20
>> name of my program. I insert the following lines in my *.pro-File (the d=
raft for=20
>> my makefile):
>> LIBS +=3D -Wl,@usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib -lpthre=
ad_rt=20
>> -lxenomai -lpthread -lrt -Xlinker -rpath -Xlinker /usr/xenomai/lib
>> LIBS +=3D -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe =
-D__XENO__=20
>> -I/usr/xenomai/include/posix
>>=20
>> I'm absoult no makefile pro. The two lines are the only thing I changed =
in my=20
>> *.pro file. Do I have to make more changes?

>Wrong makefile, see:
>http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Com=
pilation_flags


>> Futhermore, when I run:
>> valgrind --leak-check=3Dyes ./demo
>>=20
>> I get the correct valgrind output, but also a line of xenomai:
>> Xenomai: POSIX skin or CONFIG_XENO_OPT_PERVASIVE disabled
>> (modprobe xeno_posix?)
>>=20
>> Do I use a bad makefile?

>Yes, you use a bad makefile, but this is not the reason why your
>application does not work with valgrind: Xenomai applications do not
>work with valgrind.

>Also note that the QT library is compiled to use Linux posix objects,
>not Xenomai posix objects, so depending on what you do, mixing some
>Xenomai code with QT code will not work. The real-time part of the
>application has to clearly been separated from the rest, and only this
>part needs to be linked with Xenomai flags, so, the simplest thing to do
>is to put the real-time part of the application in a dynamic library,
>link-edit this dynamic library with Xenomai posix skin flags, then link
>with this dynamic library the rest of the application, without Xenomai
>posix skin flags. And in the interface between the library and the
>applicaiton, do not put any inline functions calling Xenomai posix skin
>services, as this would ruin what you are trying to achieve.
>
>--=20
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Gill=
es.

O.k. This is a quite=A0helpfull information. I tried to make dynamic librar=
ys and glue them with QT to my whole project. But, how I say, I'm a newbie =
with makefiles. I tried to trim the satch-example. This is my makefile:
APPLICATION =3D demoLib
XENO?=3D/usr/xenomai
XENOCONFIG=3D$(shell PATH=3D$(XENO):$(XENO)/bin:$(PATH) which xeno-config 2=
>/dev/null)
CC=3D$(shell $(XENOCONFIG) --cc)
CFLAGS=3D$(shell $(XENOCONFIG) --posix-cflags) $(APP_CFLAGS)
LDFLAGS=3D$(shell $(XENOCONFIG) --posix-ldflags) $(APP_LDFLAGS)
LDFLAGS+=3DXlinker -rpath -Xlinker $(shell $(XENOCONFIG) --libdir)
=A0
all:: $(APPLICATIONS)
clean::
=A0=A0=A0 $(RM) $(APPLICATIONS) *.o
=A0
The demoLib works fine, but of course, it is no lib. What I have to change =
to make a lib? Did I understand it right that the xeno-config is a skript t=
hat gives support to get the *FLAGS easier? But where is the compiling coma=
nd?=0A=0A
--0-1174114072-1297949560=:9623
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;"><P dir=3Dltr style=3D"MARGIN-RIGHT: 0px"><B>&=
gt;&gt; Hi,<BR>&gt;&gt; <BR>&gt;&gt; I'm still doubtful if I installed Xeno=
mai correctly. When I start my QT-Programm <BR>&gt;&gt; it runs correctly a=
nd I can see a new process in /proc/xenomai/state with the <BR>&gt;&gt; nam=
e of my program. I insert the following lines in my *.pro-File (the draft f=
or <BR>&gt;&gt; my makefile):<BR>&gt;&gt; LIBS +=3D -Wl,@usr/xenomai/lib/po=
six.wrappers -L/usr/xenomai/lib -lpthread_rt <BR>&gt;&gt; -lxenomai -lpthre=
ad -lrt -Xlinker -rpath -Xlinker /usr/xenomai/lib<BR>&gt;&gt; LIBS +=3D -I/=
usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__ <BR>&=
gt;&gt; -I/usr/xenomai/include/posix<BR>&gt;&gt; <BR>&gt;&gt; I'm absoult n=
o makefile pro. The two lines are the only thing I changed in my <BR>&gt;&g=
t; *.pro file. Do I have to make more changes?<BR><BR>&gt;Wrong makefile,
 see:<BR>&gt;<A href=3D"http://www.xenomai.org/index.php/Porting_POSIX_appl=
ications_to_Xenomai#Compilation_flags" target=3D_blank>http://www.xenomai.o=
rg/index.php/Porting_POSIX_applications_to_Xenomai#Compilation_flags</A><BR=
><BR><BR>&gt;&gt; Futhermore, when I run:<BR>&gt;&gt; valgrind --leak-check=
=3Dyes ./demo<BR>&gt;&gt; <BR>&gt;&gt; I get the correct valgrind output, b=
ut also a line of xenomai:<BR>&gt;&gt; Xenomai: POSIX skin or CONFIG_XENO_O=
PT_PERVASIVE disabled<BR>&gt;&gt; (modprobe xeno_posix?)<BR>&gt;&gt; <BR>&g=
t;&gt; Do I use a bad makefile?<BR><BR>&gt;Yes, you use a bad makefile, but=
 this is not the reason why your<BR>&gt;application does not work with valg=
rind: Xenomai applications do not<BR>&gt;work with valgrind.<BR><BR>&gt;Als=
o note that the QT library is compiled to use Linux posix objects,<BR>&gt;n=
ot Xenomai posix objects, so depending on what you do, mixing some<BR>&gt;X=
enomai code with QT code will not work. The real-time part of
 the<BR>&gt;application has to clearly been separated from the rest, and on=
ly this<BR>&gt;part needs to be linked with Xenomai flags, so, the simplest=
 thing to do<BR>&gt;is to put the real-time part of the application in a dy=
namic library,<BR>&gt;link-edit this dynamic library with Xenomai posix ski=
n flags, then link<BR>&gt;with this dynamic library the rest of the applica=
tion, without Xenomai<BR>&gt;posix skin flags. And in the interface between=
 the library and the<BR>&gt;applicaiton, do not put any inline functions ca=
lling Xenomai posix skin<BR>&gt;services, as this would ruin what you are t=
rying to achieve.<BR>&gt;<BR>&gt;-- <BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gilles.<BR></B></DIV>
<P dir=3Dltr style=3D"MARGIN-RIGHT: 0px"><B>O.k. This is a quite&nbsp;helpf=
ull information. I tried to make dynamic librarys and glue them with QT to =
my whole project. But, how I say, I'm a newbie with makefiles. I tried to t=
rim the satch-example. This is my makefile:</B></DIV>
<P dir=3Dltr style=3D"MARGIN-RIGHT: 0px"><B>APPLICATION =3D demoLib</B></DI=
V>
<P dir=3Dltr style=3D"MARGIN-RIGHT: 0px"><B>XENO?=3D/usr/xenomai</B></DIV>
<P dir=3Dltr style=3D"MARGIN-RIGHT: 0px"><STRONG>XENOCONFIG=3D$(shell PATH=
=3D$(XENO):$(XENO)/bin:$(PATH) which xeno-config 2&gt;/dev/null)</STRONG></=
DIV>
<P dir=3Dltr style=3D"MARGIN-RIGHT: 0px"><STRONG>CC=3D$(shell $(XENOCONFIG)=
 --cc)</STRONG></DIV>
<P dir=3Dltr style=3D"MARGIN-RIGHT: 0px"><STRONG>CFLAGS=3D$(shell $(XENOCON=
FIG) --posix-cflags) $(APP_CFLAGS)</STRONG></DIV>
<P dir=3Dltr style=3D"MARGIN-RIGHT: 0px"><STRONG>LDFLAGS=3D$(shell $(XENOCO=
NFIG) --posix-ldflags) $(APP_LDFLAGS)</STRONG></DIV>
<P dir=3Dltr style=3D"MARGIN-RIGHT: 0px"><STRONG>LDFLAGS+=3DXlinker -rpath =
-Xlinker $(shell $(XENOCONFIG) --libdir)</STRONG></DIV>
<P dir=3Dltr style=3D"MARGIN-RIGHT: 0px"><B></B>&nbsp;</DIV>
<P dir=3Dltr style=3D"MARGIN-RIGHT: 0px"><B>all:: $(APPLICATIONS)</B></DIV>
<P dir=3Dltr style=3D"MARGIN-RIGHT: 0px"><B>clean::</B></DIV>
<P dir=3Dltr style=3D"MARGIN-RIGHT: 0px"><B>&nbsp;&nbsp;&nbsp; $(RM) $(APPL=
ICATIONS) *.o</B></DIV>
<P dir=3Dltr style=3D"MARGIN-RIGHT: 0px"><B></B>&nbsp;</DIV>
<P dir=3Dltr style=3D"MARGIN-RIGHT: 0px"><B>The demoLib works fine, but of =
course, it is no lib. What I have to change to make a lib? Did I understand=
 it right that the xeno-config is a skript that gives support to get the *F=
LAGS easier? But where is the compiling comand?</B><B></DIV></B></td></tr><=
/table><br>
--0-1174114072-1297949560=:9623--

