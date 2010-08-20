MIME-Version: 1.0
Date: Fri, 20 Aug 2010 17:43:07 -0300
Message-ID: <AANLkTikhNX=0q8M8j1TU1DpM6_EtghX8A0UQ37P6S6Vp@domain.hid>
From: Rodolfo Oliveira <rodolforomao@domain.hid>
Content-Type: multipart/alternative; boundary=00c09f986a129f09c1048e475838
Subject: [Xenomai-core] problem - eldk 4.2 - ppc
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

--00c09f986a129f09c1048e475838
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

--00c09f986a129f09c1048e475838
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><span id=3D"result_box" class=3D"long_text"><span style=3D"background-c=
olor: rgb(255, 255, 255);" title=3D"Boa tarde senhores," onmouseover=3D"thi=
s.style.backgroundColor=3D&#39;#ebeff9&#39;" onmouseout=3D"this.style.backg=
roundColor=3D&#39;#fff&#39;">Hi,<br>

<br></span><span style=3D"background-color: rgb(255, 255, 255);" title=3D"h=
oje uso a vers=E3o 3.0 neste no processador MPC5200B PPC, por=E9m quero atu=
alizar o kernel para a vers=E3o 2.6 e com o eldk 4.2 consigo fazer isto mai=
s facilmente." onmouseover=3D"this.style.backgroundColor=3D&#39;#ebeff9&#39=
;" onmouseout=3D"this.style.backgroundColor=3D&#39;#fff&#39;">Today
 use the eldk 3.0 version in this processor MPC5200B PPC, but I want to upg=
rade=20
the kernel to version 2.6 and eldk 4.2 with ELDK can do this more easily.
<br></span><span style=3D"background-color: rgb(255, 255, 255);" title=3D"O=
 problema acontece quando eu tento compilar executando as seguintes comando=
s:" onmouseover=3D"this.style.backgroundColor=3D&#39;#ebeff9&#39;" onmouseo=
ut=3D"this.style.backgroundColor=3D&#39;#fff&#39;">The problem happens when=
 I try to compile by running the following commands:
<br></span><span title=3D"make distclean" onmouseover=3D"this.style.backgro=
undColor=3D&#39;#ebeff9&#39;" onmouseout=3D"this.style.backgroundColor=3D&#=
39;#fff&#39;">make distclean
<br></span><span title=3D"make clean" onmouseover=3D"this.style.backgroundC=
olor=3D&#39;#ebeff9&#39;" onmouseout=3D"this.style.backgroundColor=3D&#39;#=
fff&#39;">make clean
<br></span><span title=3D"make menuconfig" onmouseover=3D"this.style.backgr=
oundColor=3D&#39;#ebeff9&#39;" onmouseout=3D"this.style.backgroundColor=3D&=
#39;#fff&#39;">make menuconfig
<br></span><span title=3D"make" onmouseover=3D"this.style.backgroundColor=
=3D&#39;#ebeff9&#39;" onmouseout=3D"this.style.backgroundColor=3D&#39;#fff&=
#39;">make
<br>
<br></span><span style=3D"background-color: rgb(255, 255, 255);" title=3D"m=
uitos minutos depois aparece o seguinte erro:" onmouseover=3D"this.style.ba=
ckgroundColor=3D&#39;#ebeff9&#39;" onmouseout=3D"this.style.backgroundColor=
=3D&#39;#fff&#39;">many minutes after the following error appears:
<br>=A0=A0</span><span style=3D"background-color: rgb(255, 255, 255);" titl=
e=3D"LD drivers/net/bonding/built-in.o" onmouseover=3D"this.style.backgroun=
dColor=3D&#39;#ebeff9&#39;" onmouseout=3D"this.style.backgroundColor=3D&#39=
;#fff&#39;">LD drivers / net / bonding / built-in.o
<br>=A0=A0</span><span style=3D"background-color: rgb(255, 255, 255);" titl=
e=3D"CC [M] drivers/net/bonding/bond_main.o" onmouseover=3D"this.style.back=
groundColor=3D&#39;#ebeff9&#39;" onmouseout=3D"this.style.backgroundColor=
=3D&#39;#fff&#39;">CC [M] drivers / net / bonding / bond_main.o
<br>=A0=A0</span><span style=3D"background-color: rgb(255, 255, 255);" titl=
e=3D"CC [M] drivers/net/bonding/bond_3ad.o" onmouseover=3D"this.style.backg=
roundColor=3D&#39;#ebeff9&#39;" onmouseout=3D"this.style.backgroundColor=3D=
&#39;#fff&#39;">CC [M] drivers/net/bonding/bond_3ad.o
<br>=A0=A0</span><span style=3D"background-color: rgb(255, 255, 255);" titl=
e=3D"CC [M] drivers/net/bonding/bond_alb.o" onmouseover=3D"this.style.backg=
roundColor=3D&#39;#ebeff9&#39;" onmouseout=3D"this.style.backgroundColor=3D=
&#39;#fff&#39;">CC [M] drivers / net / bonding / bond_alb.o
<br>=A0=A0</span><span style=3D"background-color: rgb(255, 255, 255);" titl=
e=3D"CC [M] drivers/net/bonding/bond_sysfs.o" onmouseover=3D"this.style.bac=
kgroundColor=3D&#39;#ebeff9&#39;" onmouseout=3D"this.style.backgroundColor=
=3D&#39;#fff&#39;">CC [M] drivers / net / bonding / bond_sysfs.o
<br>=A0=A0</span><span title=3D"LD [M] drivers/net/bonding/bonding.o" onmou=
seover=3D"this.style.backgroundColor=3D&#39;#ebeff9&#39;" onmouseout=3D"thi=
s.style.backgroundColor=3D&#39;#fff&#39;">LD [M] drivers / net / bonding / =
bonding.o
<br>=A0=A0</span><span title=3D"LD drivers/net/can/built-in.o" onmouseover=
=3D"this.style.backgroundColor=3D&#39;#ebeff9&#39;" onmouseout=3D"this.styl=
e.backgroundColor=3D&#39;#fff&#39;">LD drivers / net / can / built-in.o
<br>=A0=A0</span><span title=3D"CC [M] drivers/net/can/vcan.o" onmouseover=
=3D"this.style.backgroundColor=3D&#39;#ebeff9&#39;" onmouseout=3D"this.styl=
e.backgroundColor=3D&#39;#fff&#39;">CC [M] drivers / net / can / vcan.o
<br></span><span style=3D"background-color: rgb(255, 255, 255);" title=3D"d=
rivers/net/can/vcan.c: In function &#39;vcan_setup&#39;:" onmouseover=3D"th=
is.style.backgroundColor=3D&#39;#ebeff9&#39;" onmouseout=3D"this.style.back=
groundColor=3D&#39;#fff&#39;">drivers / net / can / vcan.c: In function &#3=
9;vcan_setup&#39;:
<br></span><span title=3D"drivers/net/can/vcan.c:207: error: implicit decla=
ration of function &#39;SET_MODULE_OWNER&#39;" onmouseover=3D"this.style.ba=
ckgroundColor=3D&#39;#ebeff9&#39;" onmouseout=3D"this.style.backgroundColor=
=3D&#39;#fff&#39;">drivers / net / can / vcan.c: 207: error: implicit decla=
ration of function &#39;SET_MODULE_OWNER&#39;
<br></span><span title=3D"make[3]: ** [drivers/net/can/vcan.o] Erro 1" onmo=
useover=3D"this.style.backgroundColor=3D&#39;#ebeff9&#39;" onmouseout=3D"th=
is.style.backgroundColor=3D&#39;#fff&#39;">make [3]: ** [drivers / net / ca=
n / vcan.o] Error 1
<br></span><span title=3D"make[2]: ** [drivers/net/can] Erro 2" onmouseover=
=3D"this.style.backgroundColor=3D&#39;#ebeff9&#39;" onmouseout=3D"this.styl=
e.backgroundColor=3D&#39;#fff&#39;">make [2]: ** [drivers / net / can] Erro=
r 2
<br></span><span title=3D"make[1]: ** [drivers/net] Erro 2" onmouseover=3D"=
this.style.backgroundColor=3D&#39;#ebeff9&#39;" onmouseout=3D"this.style.ba=
ckgroundColor=3D&#39;#fff&#39;">make [1]: ** [drivers / net] Error 2
<br></span><span style=3D"background-color: rgb(255, 255, 255);" title=3D"m=
ake: ** [drivers] Erro 2" onmouseover=3D"this.style.backgroundColor=3D&#39;=
#ebeff9&#39;" onmouseout=3D"this.style.backgroundColor=3D&#39;#fff&#39;">ma=
ke: ** [drivers] Error 2
<br></span><span style=3D"background-color: rgb(255, 255, 255);" title=3D"r=
odolfo@domain.hid$ ls" onmouseover=3D"t=
his.style.backgroundColor=3D&#39;#ebeff9&#39;" onmouseout=3D"this.style.bac=
kgroundColor=3D&#39;#fff&#39;">rodolfo @ df2684: / $ ls opt/eldk/ppc_82xx/u=
sr/src/linux-2.6.24
<br>
<br></span><span title=3D"algu=E9m pode me ajudar?" onmouseover=3D"this.sty=
le.backgroundColor=3D&#39;#ebeff9&#39;" onmouseout=3D"this.style.background=
Color=3D&#39;#fff&#39;">can anyone help me?
<br>
<br></span><span title=3D"Obrigado" onmouseover=3D"this.style.backgroundCol=
or=3D&#39;#ebeff9&#39;" onmouseout=3D"this.style.backgroundColor=3D&#39;#ff=
f&#39;">Thanks
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
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=A0=A0 </span></p><br>

--00c09f986a129f09c1048e475838--

