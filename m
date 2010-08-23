MIME-Version: 1.0
In-Reply-To: <AANLkTikhNX=0q8M8j1TU1DpM6_EtghX8A0UQ37P6S6Vp@domain.hid>
References: <AANLkTikhNX=0q8M8j1TU1DpM6_EtghX8A0UQ37P6S6Vp@domain.hid>
Date: Mon, 23 Aug 2010 07:38:40 -0300
Message-ID: <AANLkTikCehBXnp6cwks1QQmRwhxe5Hd=McupyEz+wKPC@mail.gmail.com>
From: Rodolfo Oliveira <rodolforomao@domain.hid>
Content-Type: multipart/alternative; boundary=0015175cb83874b2fa048e7b40ba
Subject: [Xenomai-core] problem - eldk 4.2 - ppc
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--0015175cb83874b2fa048e7b40ba
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Today use the eldk 3.0 version in this processor MPC5200B PPC, but I want t=
o
upgrade the kernel to version 2.6 and eldk 4.2 with ELDK can do this more
easily.
The problem happens when I try to compile by running the following commands=
:

make distclean
make clean
make menuconfig
make

many minutes after the following error appears:
  LD drivers / net / bonding / built-in.o
  CC [M] drivers / net / bonding / bond_main.o
  CC [M] drivers/net/bonding/bond_3ad.o
  CC [M] drivers / net / bonding / bond_alb.o
  CC [M] drivers / net / bonding / bond_sysfs.o
  LD [M] drivers / net / bonding / bonding.o
  LD drivers / net / can / built-in.o
  CC [M] drivers / net / can / vcan.o
drivers / net / can / vcan.c: In function 'vcan_setup':
drivers / net / can / vcan.c: 207: error: implicit declaration of function
'SET_MODULE_OWNER'
make [3]: ** [drivers / net / can / vcan.o] Error 1
make [2]: ** [drivers / net / can] Error 2
make [1]: ** [drivers / net] Error 2
make: ** [drivers] Error 2
rodolfo @ df2684: / $ ls opt/eldk/ppc_82xx/usr/src/linux-2.6.24

can anyone help me?

Thanks

--=20

[]=B4s



=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Rodolfo R. de O. Neto, Eng. , MBA
Engenheiro de computa=E7=E3o
MBA - Governan=E7a em TI
E-mail: rodolforomao@domain.hid
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--0015175cb83874b2fa048e7b40ba
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><br><span><span style=3D"background-color: rgb(2=
55, 255, 255);" title=3D"Boa tarde senhores,">Hi,<br>

<br></span><span style=3D"background-color: rgb(255, 255, 255);" title=3D"h=
oje uso a vers=E3o 3.0 neste no processador MPC5200B PPC, por=E9m quero atu=
alizar o kernel para a vers=E3o 2.6 e com o eldk 4.2 consigo fazer isto mai=
s facilmente.">Today
 use the eldk 3.0 version in this processor MPC5200B PPC, but I want to upg=
rade=20
the kernel to version 2.6 and eldk 4.2 with ELDK can do this more easily.
<br></span><span style=3D"background-color: rgb(255, 255, 255);" title=3D"O=
 problema acontece quando eu tento compilar executando as seguintes comando=
s:">The problem happens when I try to compile by running the following comm=
ands:
<br></span><span title=3D"make distclean">make distclean
<br></span><span title=3D"make clean">make clean
<br></span><span title=3D"make menuconfig">make menuconfig
<br></span><span title=3D"make">make
<br>
<br></span><span style=3D"background-color: rgb(255, 255, 255);" title=3D"m=
uitos minutos depois aparece o seguinte erro:">many minutes after the follo=
wing error appears:
<br>=A0=A0</span><span style=3D"background-color: rgb(255, 255, 255);" titl=
e=3D"LD drivers/net/bonding/built-in.o">LD drivers / net / bonding / built-=
in.o
<br>=A0=A0</span><span style=3D"background-color: rgb(255, 255, 255);" titl=
e=3D"CC [M] drivers/net/bonding/bond_main.o">CC [M] drivers / net / bonding=
 / bond_main.o
<br>=A0=A0</span><span style=3D"background-color: rgb(255, 255, 255);" titl=
e=3D"CC [M] drivers/net/bonding/bond_3ad.o">CC [M] drivers/net/bonding/bond=
_3ad.o
<br>=A0=A0</span><span style=3D"background-color: rgb(255, 255, 255);" titl=
e=3D"CC [M] drivers/net/bonding/bond_alb.o">CC [M] drivers / net / bonding =
/ bond_alb.o
<br>=A0=A0</span><span style=3D"background-color: rgb(255, 255, 255);" titl=
e=3D"CC [M] drivers/net/bonding/bond_sysfs.o">CC [M] drivers / net / bondin=
g / bond_sysfs.o
<br>=A0=A0</span><span title=3D"LD [M] drivers/net/bonding/bonding.o">LD [M=
] drivers / net / bonding / bonding.o
<br>=A0=A0</span><span title=3D"LD drivers/net/can/built-in.o">LD drivers /=
 net / can / built-in.o
<br>=A0=A0</span><span title=3D"CC [M] drivers/net/can/vcan.o">CC [M] drive=
rs / net / can / vcan.o
<br></span><span style=3D"background-color: rgb(255, 255, 255);" title=3D"d=
rivers/net/can/vcan.c: In function &#39;vcan_setup&#39;:">drivers / net / c=
an / vcan.c: In function &#39;vcan_setup&#39;:
<br></span><span title=3D"drivers/net/can/vcan.c:207: error: implicit decla=
ration of function &#39;SET_MODULE_OWNER&#39;">drivers / net / can / vcan.c=
: 207: error: implicit declaration of function &#39;SET_MODULE_OWNER&#39;
<br></span><span title=3D"make[3]: ** [drivers/net/can/vcan.o] Erro 1">make=
 [3]: ** [drivers / net / can / vcan.o] Error 1
<br></span><span title=3D"make[2]: ** [drivers/net/can] Erro 2">make [2]: *=
* [drivers / net / can] Error 2
<br></span><span title=3D"make[1]: ** [drivers/net] Erro 2">make [1]: ** [d=
rivers / net] Error 2
<br></span><span style=3D"background-color: rgb(255, 255, 255);" title=3D"m=
ake: ** [drivers] Erro 2">make: ** [drivers] Error 2
<br></span><span style=3D"background-color: rgb(255, 255, 255);" title=3D"r=
odolfo@domain.hid$ ls">rodolfo @ df2684=
: / $ ls opt/eldk/ppc_82xx/usr/src/linux-2.6.24
<br>
<br></span><span title=3D"algu=E9m pode me ajudar?">can anyone help me?
<br>
<br></span><span title=3D"Obrigado">Thanks
</span></span><br clear=3D"all"><br>-- <br><p><span style=3D"font-size: 11p=
t; color: rgb(31, 73, 125);">[]=B4s</span></p>

<p><span style=3D"font-size: 11pt; color: rgb(31, 73, 125);"></span></p>

<p><span style=3D"font-size: 11pt; color: rgb(31, 73, 125);">=A0</span></p>

<p><span style=3D"font-size: 10pt; color: rgb(31, 73, 125);">=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>Rodolfo R. de O. Neto, Eng. , MBA<br>
Engenheiro de computa=E7=E3o<br>MBA - Governan=E7a em TI<br></span><span st=
yle=3D"font-size: 10pt; color: rgb(31, 73, 125);">E-mail: <a href=3D"mailto=
:rodolforomao@domain.hid" target=3D"_blank">rodolforomao@domain.hid</a></span=
><br><span style=3D"font-size: 10pt; color: rgb(31, 73, 125);">
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0=A0 </span></p>
</div>

--0015175cb83874b2fa048e7b40ba--

