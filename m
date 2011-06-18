Message-ID: <744344.82258.qm@domain.hid>
References: <67271.69338.qm@domain.hid>
	<201106091022.30083.kisda@domain.hid>
Date: Sat, 18 Jun 2011 10:43:37 -0700 (PDT)
From: nabanjan das <nabanjan@domain.hid>
In-Reply-To: <201106091022.30083.kisda@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2017627443-1308419017=:82258"
Subject: Re: [Xenomai-help] Version mismatched during xenomai installation
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
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

--0-2017627443-1308419017=:82258
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi All,=0A=0AFirst of all thanks to Stefan,=0A=0ABut I had already fixed th=
is issue. I am faced with a different issue now during reboot and here is t=
he log ( I NEED HELP ):=0A=0ALoading, please wait...=0ABegin: Loading essen=
tial drivers ... done.=0ABegin: Running /scripts/init-premount ... FATAL: E=
rror inserting fan (/lib/modules/2.6.3=0A5.9-xenomai-2.5.6/kernel/drivers/a=
cpi/fan.ko): No such device=0AFATAL: Error inserting thermal (/lib/modules/=
2.6.35.9-xenomai-2.5.6/kernel/drivers/acpi/=0Athermal.ko): No such device=
=0Adone.=0ABegin: Mounting root file system ... Begin: Running /scripts/loc=
al-top ... done.=0ABegin: Waiting for root file system ... done.=0AGave up =
waiting for root device. =A0Common problems:=0A=A0- Boot args (cat /proc/cm=
dline)=0A=A0 =A0- Check rootdelay=3D (did the system wait long enough?)=0A=
=A0 =A0- Check root=3D (did the system wait for the right device?)=0A=A0- M=
issing modules (cat /proc/modules; ls /dev)=0AALERT! does not exist. Droppi=
ng to a shell!=0A=0A=0ABusyBox v1.10.2 (Debian 1:1.10.2-2) built-in shell (=
ash)=0AEnter 'help' for a list of built-in commands.=0A=0A/bin/sh: can't ac=
cess tty; job control turned off=0A(initramfs)=0A=0A=0A=0AThanks,=0ANabanja=
n=0A=0A=0A________________________________=0AFrom: Stefan Kisdaroczi <kisda=
@hispeed.ch>=0ATo: nabanjan das <nabanjan@domain.hid>=0ACc: xenomai@xenomai.org=
.org=0ASent: Thursday, June 9, 2011 1:22 AM=0ASubject: Re: [Xenomai-help] V=
ersion mismatched during xenomai installation=0A=0AAm Donnerstag 09 Juni 20=
11, 09.33:04 schrieb nabanjan das:=0A> Hi,=0A> =0A> [...]=0A> =0A> The erro=
r message in a step at end for which I want a solution:=0A> =0A> prototype:=
~/merchant/linux-2.6.35.9# CONCURRENCY_LEVEL=3D2 CLEAN_SOURCE=3Dno=0A> fake=
root make-kpkg --initrd --append-to-version -xenomai-2.5.6 --revision=0A> 1=
.0 kernel_image kernel_headers exec debian/rules=A0 DEBIAN_REVISION=3D1.0=
=0A>=A0 APPEND_TO_VERSION=3D-xenomai-2.5.6=A0 INITRD=3DYES=A0 kernel_image =
kernel_headers=0A> /usr/bin/make -f ./debian/rules=A0 =A0 =A0 =A0 =0A> debi=
an/stamp/binary/pre-linux-image-2.6.35.9-xenomai-2.5.6 make[1]:=0A> Enterin=
g directory `/root/merchant/linux-2.6.35.9'=0A> =3D=3D=3D=3D=3D=3D making t=
arget=0A> debian/stamp/install/linux-image-2.6.35.9-xenomai-2.5.6 [new prer=
eqs:=0A> ]=3D=3D=3D=3D=3D=3D This is kernel package version 11.015.=0A> ech=
o "The UTS Release version in include/linux/version.h"; echo "=A0 =A0 =A0 =
=A0 =0A>=A0 \"\" "; echo "does not match current version:"; echo "=A0 =A0 =
=A0 =A0 =0A>=A0 \"2.6.35.9-xenomai-2.5.6\" "; echo "Please correct this."; =
exit 2 The UTS=0A> Release version in include/linux/version.h=0A>=A0 =A0 =
=A0 =A0 =A0 =A0 "" =0A> does not match current version:=0A>=A0 =A0 =A0 =A0 =
=A0 =A0 "2.6.35.9-xenomai-2.5.6" =0A> Please correct this.=0A> make[1]: ***=
 [debian/stamp/install/linux-image-2.6.35.9-xenomai-2.5.6]=0A> Error 2 make=
[1]: Leaving directory `/root/merchant/linux-2.6.35.9'=0A> make: *** [kerne=
l_image] Error 2=0A=0APlease run "make-kpkg clean" and retry to build the k=
ernel after that.=0A=0AThis looks like debian 5.0 lenny (released February =
2009). The last time i =0Achecked with (old) lenny was in January 2011 with=
 kernel 2.6.32 and it worked. =0AMaybe there is a incompatibility between k=
ernel-package 11.015 from lenny and =0Anewer kernels.=0A=0AIf "make-kpkg cl=
ean" doesnt help consider upgrading to debian 6.0 squeeze =0A(released Febr=
uary 2011).=0A=0ASidenote: don't build packages/kernels as root.=0A=0AStefa=
n
--0-2017627443-1308419017=:82258
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:12pt"><div style=3D"font-fa=
mily: 'times new roman', 'new york', times, serif; font-size: 12pt; "><span=
>Hi All,</span></div><div style=3D"font-family: 'times new roman', 'new yor=
k', times, serif; font-size: 12pt; "><span><br></span></div><div style=3D"f=
ont-family: 'times new roman', 'new york', times, serif; font-size: 12pt; "=
><span>First of all thanks to Stefan,</span></div><div style=3D"font-family=
: 'times new roman', 'new york', times, serif; font-size: 12pt; "><span><br=
></span></div><div style=3D"font-family: 'times new roman', 'new york', tim=
es, serif; font-size: 12pt; "><span>But I had already fixed this issue. I a=
m faced with a different issue now during reboot and here is the log ( I NE=
ED HELP ):</span></div><div style=3D"font-family: 'times new roman', 'new y=
ork', times, serif; font-size: 12pt;
 "><span><br></span></div><div><span><div>Loading, please wait...</div><div=
>Begin: Loading essential drivers ... done.</div><div>Begin: Running /scrip=
ts/init-premount ... FATAL: Error inserting fan (/lib/modules/2.6.3</div><d=
iv>5.9-xenomai-2.5.6/kernel/drivers/acpi/fan.ko): No such device</div><div>=
FATAL: Error inserting thermal (/lib/modules/2.6.35.9-xenomai-2.5.6/kernel/=
drivers/acpi/</div><div>thermal.ko): No such device</div><div>done.</div><d=
iv>Begin: Mounting root file system ... Begin: Running /scripts/local-top .=
.. done.</div><div>Begin: Waiting for root file system ... done.</div><div>=
Gave up waiting for root device. &nbsp;Common problems:</div><div>&nbsp;- B=
oot args (cat /proc/cmdline)</div><div>&nbsp; &nbsp;- Check rootdelay=3D (d=
id the system wait long enough?)</div><div>&nbsp; &nbsp;- Check root=3D (di=
d the system wait for the right device?)</div><div>&nbsp;- Missing modules =
(cat /proc/modules; ls /dev)</div><div>ALERT! does not exist. Dropping
 to a shell!</div><div><br></div><div><br></div><div>BusyBox v1.10.2 (Debia=
n 1:1.10.2-2) built-in shell (ash)</div><div>Enter 'help' for a list of bui=
lt-in commands.</div><div><br></div><div>/bin/sh: can't access tty; job con=
trol turned off</div><div>(initramfs)</div><div><br></div><div><br></div><d=
iv><br></div><div>Thanks,</div><div>Nabanjan</div></span></div><div style=
=3D"font-family: 'times new roman', 'new york', times, serif; font-size: 12=
pt; "><br></div><div style=3D"font-size: 12pt; font-family: 'times new roma=
n', 'new york', times, serif; "><div style=3D"font-size: 12pt; font-family:=
 'times new roman', 'new york', times, serif; "><font size=3D"2" face=3D"Ar=
ial"><hr size=3D"1"><b><span style=3D"font-weight:bold;">From:</span></b> S=
tefan Kisdaroczi &lt;kisda@domain.hid&gt;<br><b><span style=3D"font-weight:=
 bold;">To:</span></b> nabanjan das &lt;nabanjan@domain.hid&gt;<br><b><span =
style=3D"font-weight: bold;">Cc:</span></b> xenomai@xenomai.org<br><b><spa=
n
 style=3D"font-weight: bold;">Sent:</span></b> Thursday, June 9, 2011 1:22 =
AM<br><b><span style=3D"font-weight: bold;">Subject:</span></b> Re: [Xenoma=
i-help] Version mismatched during xenomai installation<br></font><br>=0AAm =
Donnerstag 09 Juni 2011, 09.33:04 schrieb nabanjan das:<br>&gt; Hi,<br>&gt;=
 <br>&gt; [...]<br>&gt; <br>&gt; The error message in a step at end for whi=
ch I want a solution:<br>&gt; <br>&gt; prototype:~/merchant/linux-2.6.35.9#=
 CONCURRENCY_LEVEL=3D2 CLEAN_SOURCE=3Dno<br>&gt; fakeroot make-kpkg --initr=
d --append-to-version -xenomai-2.5.6 --revision<br>&gt; 1.0 kernel_image ke=
rnel_headers exec debian/rules&nbsp; DEBIAN_REVISION=3D1.0<br>&gt;&nbsp; AP=
PEND_TO_VERSION=3D-xenomai-2.5.6&nbsp; INITRD=3DYES&nbsp; kernel_image kern=
el_headers<br>&gt; /usr/bin/make -f ./debian/rules&nbsp; &nbsp; &nbsp; &nbs=
p; <br>&gt; debian/stamp/binary/pre-linux-image-2.6.35.9-xenomai-2.5.6 make=
[1]:<br>&gt; Entering directory `/root/merchant/linux-2.6.35.9'<br>&gt; =3D=
=3D=3D=3D=3D=3D making target<br>&gt; debian/stamp/install/linux-image-2.6.=
35.9-xenomai-2.5.6 [new prereqs:<br>&gt; ]=3D=3D=3D=3D=3D=3D This is kernel=
 package version 11.015.<br>&gt; echo "The UTS Release version in include/l=
inux/version.h"; echo
 "&nbsp; &nbsp; &nbsp; &nbsp; <br>&gt;&nbsp; \"\" "; echo "does not match c=
urrent version:"; echo "&nbsp; &nbsp; &nbsp; &nbsp; <br>&gt;&nbsp; \"2.6.35=
.9-xenomai-2.5.6\" "; echo "Please correct this."; exit 2 The UTS<br>&gt; R=
elease version in include/linux/version.h<br>&gt;&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; "" <br>&gt; does not match current version:<br>&gt;&nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; "2.6.35.9-xenomai-2.5.6" <br>&gt; Please =
correct this.<br>&gt; make[1]: *** [debian/stamp/install/linux-image-2.6.35=
.9-xenomai-2.5.6]<br>&gt; Error 2 make[1]: Leaving directory `/root/merchan=
t/linux-2.6.35.9'<br>&gt; make: *** [kernel_image] Error 2<br><br>Please ru=
n "make-kpkg clean" and retry to build the kernel after that.<br><br>This l=
ooks like debian 5.0 lenny (released February 2009). The last time i <br>ch=
ecked with (old) lenny was in January 2011 with kernel 2.6.32 and it worked=
. <br>Maybe there is a incompatibility between kernel-package 11.015
 from lenny and <br>newer kernels.<br><br>If "make-kpkg clean" doesnt help =
consider upgrading to debian 6.0 squeeze <br>(released February 2011).<br><=
br>Sidenote: don't build packages/kernels as root.<br><br>Stefan<br><br><br=
></div></div></div></body></html>
--0-2017627443-1308419017=:82258--

