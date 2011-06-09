Message-ID: <67271.69338.qm@domain.hid>
Date: Thu, 9 Jun 2011 00:33:04 -0700 (PDT)
From: nabanjan das <nabanjan@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-710170628-1307604784=:69338"
Subject: [Xenomai-help] Version mismatched during xenomai installation
Reply-To: nabanjan das <nabanjan@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

--0-710170628-1307604784=:69338
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,=0A=0AI have this issue of version mismatch during xenomai installation =
in debian linux.=A0=0A=0AI followed the steps in:=0A=0Ahttp://www.xenomai.o=
rg/index.php/Building_Debian_packages=0A=0A=0AInfo of my server is:=0A=0Apr=
ototype:~/merchant/linux-2.6.35.9# uname -a=0ALinux prototype 2.6.26-2-xen-=
686 #1 SMP Thu Jan 27 05:44:37 UTC 2011 i686 GNU/Linux=0A=0A=0AThe error me=
ssage in a step at end for which I want a solution:=0A=0Aprototype:~/mercha=
nt/linux-2.6.35.9# CONCURRENCY_LEVEL=3D2 CLEAN_SOURCE=3Dno fakeroot make-kp=
kg --initrd --append-to-version -xenomai-2.5.6 --revision 1.0 kernel_image =
kernel_headers=0Aexec debian/rules =A0DEBIAN_REVISION=3D1.0 =A0APPEND_TO_VE=
RSION=3D-xenomai-2.5.6 =A0INITRD=3DYES =A0kernel_image kernel_headers=A0=0A=
/usr/bin/make -f ./debian/rules =A0 =A0 =A0 =A0 debian/stamp/binary/pre-lin=
ux-image-2.6.35.9-xenomai-2.5.6=0Amake[1]: Entering directory `/root/mercha=
nt/linux-2.6.35.9'=0A=3D=3D=3D=3D=3D=3D making target debian/stamp/install/=
linux-image-2.6.35.9-xenomai-2.5.6 [new prereqs: ]=3D=3D=3D=3D=3D=3D=0AThis=
 is kernel package version 11.015.=0Aecho "The UTS Release version in inclu=
de/linux/version.h"; echo " =A0 =A0 =A0 =A0 =A0\"\" "; echo "does not match=
 current version:"; echo " =A0 =A0 =A0 =A0 =A0\"2.6.35.9-xenomai-2.5.6\" ";=
 echo "Please correct this."; exit 2=0AThe UTS Release version in include/l=
inux/version.h=0A=A0 =A0 =A0 =A0 =A0 =A0""=A0=0Adoes not match current vers=
ion:=0A=A0 =A0 =A0 =A0 =A0 =A0"2.6.35.9-xenomai-2.5.6"=A0=0APlease correct =
this.=0Amake[1]: *** [debian/stamp/install/linux-image-2.6.35.9-xenomai-2.5=
.6] Error 2=0Amake[1]: Leaving directory `/root/merchant/linux-2.6.35.9'=0A=
make: *** [kernel_image] Error 2=0A
--0-710170628-1307604784=:69338
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:12pt"><div style=3D"font-fa=
mily: 'times new roman', 'new york', times, serif; font-size: 12pt; ">Hi,</=
div><div style=3D"font-family: 'times new roman', 'new york', times, serif;=
 font-size: 12pt; "><br></div><div style=3D"font-family: 'times new roman',=
 'new york', times, serif; font-size: 12pt; ">I have this issue of version =
mismatch during xenomai installation in debian linux.&nbsp;</div><div style=
=3D"font-family: 'times new roman', 'new york', times, serif; font-size: 12=
pt; "><br></div><div style=3D"font-family: 'times new roman', 'new york', t=
imes, serif; font-size: 12pt; ">I followed the steps in:</div><div style=3D=
"font-family: 'times new roman', 'new york', times, serif; font-size: 12pt;=
 "><br></div><div><font class=3D"Apple-style-span" face=3D"'times new roman=
', 'new york', times,
 serif">http://www.xenomai.org/index.php/Building_Debian_packages</font><br=
></div><div><font class=3D"Apple-style-span" face=3D"'times new roman', 'ne=
w york', times, serif"><br></font></div><div><font class=3D"Apple-style-spa=
n" face=3D"'times new roman', 'new york', times, serif">Info of my server i=
s:</font></div><div><font class=3D"Apple-style-span" face=3D"'times new rom=
an', 'new york', times, serif"><br></font></div><div><font class=3D"Apple-s=
tyle-span" face=3D"'times new roman', 'new york', times, serif"><div>protot=
ype:~/merchant/linux-2.6.35.9# uname -a</div><div>Linux prototype 2.6.26-2-=
xen-686 #1 SMP Thu Jan 27 05:44:37 UTC 2011 i686 GNU/Linux</div><div><br></=
div></font></div><div style=3D"font-family: 'times new roman', 'new york', =
times, serif; font-size: 12pt; "><br></div><div style=3D"font-family: 'time=
s new roman', 'new york', times, serif; font-size: 12pt; ">The error messag=
e in a step at end for which I want a solution:</div><div style=3D"font-fam=
ily: 'times new
 roman', 'new york', times, serif; font-size: 12pt; "><br></div><div><div><=
font class=3D"Apple-style-span" face=3D"'times new roman', 'new york', time=
s, serif">prototype:~/merchant/linux-2.6.35.9# CONCURRENCY_LEVEL=3D2 CLEAN_=
SOURCE=3Dno fakeroot make-kpkg --initrd --append-to-version -xenomai-2.5.6 =
--revision 1.0 kernel_image kernel_headers</font></div><div><font class=3D"=
Apple-style-span" face=3D"'times new roman', 'new york', times, serif">exec=
 debian/rules &nbsp;DEBIAN_REVISION=3D1.0 &nbsp;APPEND_TO_VERSION=3D-xenoma=
i-2.5.6 &nbsp;INITRD=3DYES &nbsp;kernel_image kernel_headers&nbsp;</font></=
div><div><font class=3D"Apple-style-span" face=3D"'times new roman', 'new y=
ork', times, serif">/usr/bin/make -f ./debian/rules &nbsp; &nbsp; &nbsp; &n=
bsp; debian/stamp/binary/pre-linux-image-2.6.35.9-xenomai-2.5.6</font></div=
><div><font class=3D"Apple-style-span" face=3D"'times new roman', 'new york=
', times, serif">make[1]: Entering directory
 `/root/merchant/linux-2.6.35.9'</font></div><div><font class=3D"Apple-styl=
e-span" face=3D"'times new roman', 'new york', times, serif">=3D=3D=3D=3D=
=3D=3D making target debian/stamp/install/linux-image-2.6.35.9-xenomai-2.5.=
6 [new prereqs: ]=3D=3D=3D=3D=3D=3D</font></div><div><font class=3D"Apple-s=
tyle-span" face=3D"'times new roman', 'new york', times, serif">This is ker=
nel package version 11.015.</font></div><div><font class=3D"Apple-style-spa=
n" face=3D"'times new roman', 'new york', times, serif">echo "The UTS Relea=
se version in include/linux/version.h"; echo " &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;\"\" "; echo "does not match current version:"; echo " &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp;\"2.6.35.9-xenomai-2.5.6\" "; echo "Please correct this=
."; exit 2</font></div><div><font class=3D"Apple-style-span" face=3D"'times=
 new roman', 'new york', times, serif">The UTS Release version in include/l=
inux/version.h</font></div><div><font class=3D"Apple-style-span" face=3D"'t=
imes new roman', 'new york', times,
 serif">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;""&nbsp;</font></div><div>=
<font class=3D"Apple-style-span" face=3D"'times new roman', 'new york', tim=
es, serif">does not match current version:</font></div><div><font class=3D"=
Apple-style-span" face=3D"'times new roman', 'new york', times, serif">&nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"2.6.35.9-xenomai-2.5.6"&nbsp;</font><=
/div><div><font class=3D"Apple-style-span" face=3D"'times new roman', 'new =
york', times, serif">Please correct this.</font></div><div><font class=3D"A=
pple-style-span" face=3D"'times new roman', 'new york', times, serif">make[=
1]: *** [debian/stamp/install/linux-image-2.6.35.9-xenomai-2.5.6] Error 2</=
font></div><div><font class=3D"Apple-style-span" face=3D"'times new roman',=
 'new york', times, serif">make[1]: Leaving directory `/root/merchant/linux=
-2.6.35.9'</font></div><div><font class=3D"Apple-style-span" face=3D"'times=
 new roman', 'new york', times, serif">make: *** [kernel_image] Error 2</fo=
nt></div><div
 style=3D"font-family: 'times new roman', 'new york', times, serif; font-si=
ze: 12pt; "><br></div></div></div></body></html>
--0-710170628-1307604784=:69338--

