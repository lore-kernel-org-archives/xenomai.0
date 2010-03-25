Message-ID: <507168.65506.qm@domain.hid>
Date: Thu, 25 Mar 2010 20:24:15 +0000 (GMT)
From: Chtourou Sonda <chtourou_sonda@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1965044213-1269548655=:65506"
Subject: [Xenomai-help] Problem to cross-compile Xenomai user-space support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--0-1965044213-1269548655=:65506
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Dears, =0A=0A=0AI built the uClinux kernel for NIOS II and it run well on t=
he target board. I followed the typical actions available here : http://www=
.nioswiki.com/ =0A=0ANow, I want to add a co-scheduler xenomai to the kerne=
l (uclinux) to reduce its latency. I followed these steps: (http://www.xeno=
mai.org/documentation/xenomai-2.5/README.INSTALL)=0A$ $xenomai-2.5.1/script=
s/prepare-kernel.sh --arch=3Dnios2 --adeos=3D$xenomai-2.5.1/ksrc/arch/nios2=
/patches/adeos-ipipe-2.6.30-nios2-1.1-00.patch=0A=A0 --linux=3D$linux_tree=
=0A$ $xenomai-2.5.1/configure --host=3Dnios2-linux=0A$ make install DESTDIR=
=3D$uClinux-dist/romfs=0A=0ABut, in this step, I got this error:=0A=0Aeck_v=
dso-check-vdso.o ../../skins/native/libnative.la -lpthread -lm=0Alibtool: l=
ink: ../../../scripts/wrap-link.sh nios2-linux-gcc -Wl,-elf2flt -o check-vd=
so check_vdso-check-vdso.o=A0 ../../skins/native/.libs/libnative.a -lpthrea=
d -lm=0Acheck-vdso.elf2flt(.text+0x16c): In function `main':=0A: undefined =
reference to `xeno_sem_heap'=0Acheck-vdso.elf2flt(.text+0x170): In function=
 `main':=0A: undefined reference to `xeno_sem_heap'=0Acollect2: ld returned=
 1 exit status=0Amake[3]: *** [check-vdso] Erreur 1=0Amake[3]: quittant le =
r=E9pertoire =AB /home/sonda/Desktop/xenomai-2.5.1/src/testsuite/unit =BB=
=0Amake[2]: *** [all-recursive] Erreur 1=0Amake[2]: quittant le r=E9pertoir=
e =AB /home/sonda/Desktop/xenomai-2.5.1/src/testsuite =BB=0Amake[1]: *** [a=
ll-recursive] Erreur 1=0Amake[1]: quittant le r=E9pertoire =AB /home/sonda/=
Desktop/xenomai-2.5.1/src =BB=0Amake: *** [all-recursive] Erreur 1=0A=0Awha=
t can I do? Please help=0ARegards,=0A=0A=0A      
--0-1965044213-1269548655=:65506
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><DIV>=0A<P style=3D"MARGIN: 0cm 0cm 10pt" class=3DMsoNormal=
><SPAN style=3D"mso-ansi-language: EN-US" lang=3DEN-US><FONT face=3DCalibri=
>Dears, <BR style=3D"mso-special-character: line-break"><BR style=3D"mso-sp=
ecial-character: line-break"><?xml:namespace prefix =3D o ns =3D "urn:schem=
as-microsoft-com:office:office" /><o:p></o:p></FONT></SPAN></P>=0A<P style=
=3D"MARGIN: 0cm 0cm 10pt" class=3DMsoNormal><SPAN style=3D"mso-ansi-languag=
e: EN-US" lang=3DEN-US><FONT face=3DCalibri>I built the uClinux kernel for =
NIOS II and it run well on the target board. I followed the typical actions=
 available here : http://www.nioswiki.com/ <BR><BR>Now, I want to add a co-=
scheduler xenomai to the kernel (uclinux) to reduce its latency. I followed=
 these steps: (http://www.xenomai.org/documentation/xenomai-2.5/README.INST=
ALL)<BR>$ $xenomai-2.5.1/scripts/prepare-kernel.sh --arch=3Dnios2 --adeos=
=3D$xenomai-2.5.1/ksrc/arch/nios2/patches/adeos-ipipe-2.6.30-nios2-1.1-00.p=
atch<BR>&nbsp; --linux=3D$linux_tree<BR>$ $xenomai-2.5.1/configure --host=
=3Dnios2-linux<BR>$ make install DESTDIR=3D$uClinux-dist/romfs<BR><BR>But, =
in this step, I got this error:<BR><BR>eck_vdso-check-vdso.o ../../skins/na=
tive/libnative.la -lpthread -lm<BR>libtool: link: ../../../scripts/wrap-lin=
k.sh nios2-linux-gcc -Wl,-elf2flt -o check-vdso check_vdso-check-vdso.o&nbs=
p;
 ../../skins/native/.libs/libnative.a -lpthread -lm<BR>check-vdso.elf2flt(.=
text+0x16c): In function `main':<BR>: undefined reference to `xeno_sem_heap=
'<BR>check-vdso.elf2flt(.text+0x170): In function `main':<BR>: undefined re=
ference to `xeno_sem_heap'<BR>collect2: ld returned 1 exit status<BR>make[3=
]: *** [check-vdso] Erreur 1<BR>make[3]: quittant le r=E9pertoire =AB /home=
/sonda/Desktop/xenomai-2.5.1/src/testsuite/unit =BB<BR>make[2]: *** [all-re=
cursive] Erreur 1<BR>make[2]: quittant le r=E9pertoire =AB /home/sonda/Desk=
top/xenomai-2.5.1/src/testsuite =BB<BR>make[1]: *** [all-recursive] Erreur =
1<BR>make[1]: quittant le r=E9pertoire =AB /home/sonda/Desktop/xenomai-2.5.=
1/src =BB<BR>make: *** [all-recursive] Erreur 1<BR><BR>what can I do? Pleas=
e help</FONT></SPAN></P>=0A<P style=3D"MARGIN: 0cm 0cm 10pt" class=3DMsoNor=
mal><SPAN style=3D"mso-ansi-language: EN-US" lang=3DEN-US><FONT face=3DCali=
bri><o:p>Regards,</o:p></FONT></SPAN></P></DIV></div><br>=0A=0A=0A=0A=0A   =
   </body></html>
--0-1965044213-1269548655=:65506--

