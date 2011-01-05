Message-ID: <12d572a328f.gprizzi@domain.hid>
Date: Wed, 5 Jan 2011 18:12:19 +0100 (CET)
From: "gprizzi@domain.hid" <gprizzi@domain.hid>
Mime-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_190450_29804676.1294247539346"
Subject: [Xenomai-help] error in executing xenomai tests
Reply-To: "gprizzi@domain.hid" <gprizzi@domain.hid>
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

------=_Part_190450_29804676.1294247539346
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

 Dear sirs,

 I have a fresh install of xenomai 2.5.5.2.

I found the directory 

/usr/share/xenomai/testsuite/

in which there are subdirectory with different test.

I tried to execute them bat I got a lot of errors that you can see here below.

The most frequent error is the following:

FATAL: Module xeno_nucleus not found.

Have I made errors in xenomai installation process?

Have I a working xenomai system?

Moreover where can I found documentation that can help me to understand if the performances of the execute tests
are god?

During installation I used the following procedure that was explained on the page 
http://www.xenomai.org.php/Building_Debian_packages that now in no more available (why?)


INSTALLATION PROCEDURE

download of xenomai-2.5.2.2.tar.bz2 

extraction of files in 

Download/xenomai-2.5.2.2

apt-get install devscripts debhelper dh-kpatches findutils

DEBEMAIL="xxx@domain.hid" DEBFULLNAME="Your Name" debchange -v 2.5.5.2 Release 2.5.5.2

cd Download/xenomai-2.5.2.2 
debuild -uc -us
dpkg -i *.deb

dowload of linux kernel
wget http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.35.7.tar.bz2 &amp;&amp; tar -jxf linux-2.6.35.7.tar.bz2 &amp;&amp; cd linux-2.6.35.7

/usr/src/kernel-patches/i386/apply/xenomai

cp /boot/.config-2.6.35-22-generic .config
make oldconfig
make menuconfig 

to set the following options:

Processor type and features
  Processor Family 

Power management and ACPI options
  ACPI (Advanced Configuration and Power Interface support)
    Processor (disableb)

CPU Frequency scaling (disabled)

Processor type and features
  AMD IOMMU Support(disabled)

Bus Options (PCI etc.)
  Message Signaled Interrupts (MSI and MSI-X) (disabled)

kernel compilation

CONCURRENCY_LEVEL=2 CLEAN_SOURCE=no fakeroot make-kpkg --initrd --append-to-version -xenomai-2.5.5.2 --revision 1.0 kernel_image kernel_headers

dpkg -i linux-image*.deb
dpkg -i linux-header*.deb
update-initramfs -c -k 2.6.35.7-xenomai-2.5.5.2 &amp;&amp; update-grub



ERRORS IN TESTS

irqbench test

root@domain.hid# ./run
*
*
* Type ^C to stop this application.
*
*
FATAL: Module xeno_nucleus not found.
FATAL: Error running install command for xeno_nucleus
irqloop: failed to open benchmark device: No such file or directory
(modprobe xeno_irqbench?)
ERROR: Module xeno_rtdm does not exist in /proc/modules
ERROR: Module xeno_posix does not exist in /proc/modules
ERROR: Module xeno_nucleus does not exist in /proc/modules
root@domain.hid# ^C

klatency test

root@domain.hid# ./run
*
*
* Type ^C to stop this application.
*
*
FATAL: Module xeno_nucleus not found.
FATAL: Error running install command for xeno_nucleus
open(/proc/xenomai/registry/native/pipes/klat_pipe): No such file or directory
modprobe klat_mod or try the -P option?
ERROR: Module xeno_timerbench does not exist in /proc/modules
ERROR: Module xeno_rtdm does not exist in /proc/modules
ERROR: Module xeno_native does not exist in /proc/modules
ERROR: Module xeno_nucleus does not exist in /proc/modules

sigtest test

root@domain.hid# ./run
*
*
* Type ^C to stop this application.
*
*
FATAL: Module xeno_nucleus not found.
FATAL: Error running install command for xeno_nucleus
Xenomai: SIGTEST skin or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_sigtest?)
ERROR: Module xeno_rtdm does not exist in /proc/modules
ERROR: Module xeno_posix does not exist in /proc/modules
ERROR: Module xeno_nucleus does not exist in /proc/modules
root@domain.hid# ^C
root@domain.hid# 


switchtest test

root@domain.hid# ./run
*
*
* Type ^C to stop this application.
*
*
FATAL: Module xeno_nucleus not found.
FATAL: Error running install command for xeno_nucleus
== Testing FPU check routines...
r0: 1 != 2
r1: 1 != 2
r2: 1 != 2
r3: 1 != 2
r4: 1 != 2
r5: 1 != 2
r6: 1 != 2
r7: 1 != 2
== FPU check routines: OK.
ioctl(RTTST_RTIOC_SWTEST_CREATE_KTASK): Cannot allocate memory
== Threads: sleeper_ufps0-0 rtk0-1 rtk0-2 rtk_fp0-3 rtk_fp0-4 rtk_fp_ufpp0-5 rtk_fp_ufpp0-6 rtup0-7 rtup0-8 rtup_ufpp0-9 rtup_ufpp0-10 rtus0-11 rtus0-12 rtus_ufps0-13 rtus_ufps0-14 rtuo0-15 rtuo0-16 rtuo_ufpp0-17 rtuo_ufpp0-18 rtuo_ufps0-19 rtuo_ufps0-20 rtuo_ufpp_ufps0-21 rtuo_ufpp_ufps0-22 sleeper_ufps1-0 rtk1-1 rtk1-2 rtk_fp1-3 rtk_fp1-4 rtk_fp_ufpp1-5 rtk_fp_ufpp1-6 rtup1-7 rtup1-8 rtup_ufpp1-9 rtup_ufpp1-10 rtus1-11 rtus1-12 rtus_ufps1-13 rtus_ufps1-14 rtuo1-15 rtuo1-16 rtuo_ufpp1-17 rtuo_ufpp1-18 rtuo_ufps1-19 rtuo_ufps1-20 rtuo_ufpp_ufps1-21 rtuo_ufpp_ufps1-22 sleeper_ufps2-0 rtk2-1 rtk2-2 rtk_fp2-3RTT|  359512:23:52
RTH|---------cpu|ctx switches|-------total
RTD|           0|           0|           0
RTD|           1|           0|           0
RTD|           2|           0|           0
ERROR: Module xeno_switchtest does not exist in /proc/modules
ERROR: Module xeno_rtdm does not exist in /proc/modules
ERROR: Module xeno_posix does not exist in /proc/modules
ERROR: Module xeno_nucleus does not exist in /proc/modules

unit test

*
*
* Type ^C to stop this application.
*
*
FATAL: Module xeno_nucleus not found.
FATAL: Error running install command for xeno_nucleus
mul: 0x79364d93, shft: 26
integ: 30, frac: 0x4d9364d9364d9364

signed positive operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 29.102 ns, rejected 0/10000
inlined llimd: 0x79364d9364d9362f: 54.872 ns, rejected 1/10000
inlined llmulshft: 0x79364d92ffffffe1: 1.246 ns, rejected 0/10000
inlined nodiv_llimd: 0x79364d9364d9362f: 4.570 ns, rejected 0/10000
out of line calibration: 0x0000000000000000: 30.351 ns, rejected 1/10000
out of line llimd: 0x79364d9364d9362f: 60.692 ns, rejected 1/10000
out of line llmulshft: 0x79364d92ffffffe1: 0.830 ns, rejected 1/10000
out of line nodiv_llimd: 0x79364d9364d9362f: 4.571 ns, rejected 1/10000

signed negative operation: 0xfc00000000000001 * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 31.635 ns, rejected 1/10000
inlined llimd: 0x86c9b26c9b26c9d1: 53.173 ns, rejected 1/10000
inlined llmulshft: 0x86c9b26d0000001e: 0.678 ns, rejected 0/10000
inlined nodiv_llimd: 0x86c9b26c9b26c9d1: 3.286 ns, rejected 1/10000
out of line calibration: 0x0000000000000000: 30.351 ns, rejected 0/10000
out of line llimd: 0x86c9b26c9b26c9d1: 64.434 ns, rejected 1/10000
out of line llmulshft: 0x86c9b26d0000001e: 4.569 ns, rejected 1/10000
out of line nodiv_llimd: 0x86c9b26c9b26c9d1: 5.819 ns, rejected 1/10000

unsigned operation: 0x03ffffffffffffff * 1000000000 / 33000000
inline calibration: 0x0000000000000000: 31.531 ns, rejected 0/10000
inlined nodiv_ullimd: 0x79364d9364d9362f: 2.140 ns, rejected 0/10000
out of line calibration: 0x0000000000000000: 30.351 ns, rejected 0/10000
out of line nodiv_ullimd: 0x79364d9364d9362f: 4.571 ns, rejected 1/10000
ERROR: Module xeno_native does not exist in /proc/modules
ERROR: Module xeno_nucleus does not exist in /proc/modules
root@domain.hid# 

 
------=_Part_190450_29804676.1294247539346
Content-Type: text/html;charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

&nbsp;Dear sirs,<br><br>&nbsp;I have a fresh install of xenomai 2.5.5.2.<br=
><br>I found the directory <br><br>/usr/share/xenomai/testsuite/<br><br>in =
which there are subdirectory with different test.<br><br>I tried to execute=
 them bat I got a lot of errors that you can see here below.<br><br>The mos=
t frequent error is the following:<br><br>FATAL: Module xeno_nucleus not fo=
und.<br><br>Have I made errors in xenomai installation process?<br><br>Have=
 I a working xenomai system?<br><br>Moreover where can I found documentatio=
n that can help me to understand if the performances of the execute tests<b=
r>are god?<br><br>During installation I used the following procedure that w=
as explained on the page <br>http://www.xenomai.org.php/Building_Debian_pac=
kages that now in no more available (why?)<br><br><br>INSTALLATION PROCEDUR=
E<br><br>download of xenomai-2.5.2.2.tar.bz2 <br><br>extraction of files in=
 <br><br>Download/xenomai-2.5.2.2<br><br>apt-get install devscripts debhelp=
er dh-kpatches findutils<br><br>DEBEMAIL=3D"xxx@domain.hid" DEBFULLNAME=3D"Your =
Name" debchange -v 2.5.5.2 Release 2.5.5.2<br><br>cd Download/xenomai-2.5.2=
.2 <br>debuild -uc -us<br>dpkg -i *.deb<br><br>dowload of linux kernel<br>w=
get http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.35.7.tar.bz2 &amp=
;&amp; tar -jxf linux-2.6.35.7.tar.bz2 &amp;&amp; cd linux-2.6.35.7<br><br>=
/usr/src/kernel-patches/i386/apply/xenomai<br><br>cp /boot/.config-2.6.35-2=
2-generic .config<br>make oldconfig<br>make menuconfig <br><br>to set the f=
ollowing options:<br><br>Processor type and features<br>&nbsp; Processor Fa=
mily <br><br>Power management and ACPI options<br>&nbsp; ACPI (Advanced Con=
figuration and Power Interface support)<br>&nbsp;&nbsp;&nbsp; Processor (di=
sableb)<br><br>CPU Frequency scaling (disabled)<br><br>Processor type and f=
eatures<br>&nbsp; AMD IOMMU Support(disabled)<br><br>Bus Options (PCI etc.)=
<br>&nbsp; Message Signaled Interrupts (MSI and MSI-X) (disabled)<br><br>ke=
rnel compilation<br><br>CONCURRENCY_LEVEL=3D2 CLEAN_SOURCE=3Dno fakeroot ma=
ke-kpkg --initrd --append-to-version -xenomai-2.5.5.2 --revision 1.0 kernel=
_image kernel_headers<br><br>dpkg -i linux-image*.deb<br>dpkg -i linux-head=
er*.deb<br>update-initramfs -c -k 2.6.35.7-xenomai-2.5.5.2 &amp;&amp; updat=
e-grub<br><br><br><br>ERRORS IN TESTS<br><br>irqbench test<br><br>root@domain.hid=
xU1010:/usr/share/xenomai/testsuite/irqbench# ./run<br>*<br>*<br>* Type ^C =
to stop this application.<br>*<br>*<br>FATAL: Module xeno_nucleus not found=
.<br>FATAL: Error running install command for xeno_nucleus<br>irqloop: fail=
ed to open benchmark device: No such file or directory<br>(modprobe xeno_ir=
qbench?)<br>ERROR: Module xeno_rtdm does not exist in /proc/modules<br>ERRO=
R: Module xeno_posix does not exist in /proc/modules<br>ERROR: Module xeno_=
nucleus does not exist in /proc/modules<br>root@domain.hid=
ai/testsuite/irqbench# ^C<br><br>klatency test<br><br>root@domain.hid/=
share/xenomai/testsuite/klatency# ./run<br>*<br>*<br>* Type ^C to stop this=
 application.<br>*<br>*<br>FATAL: Module xeno_nucleus not found.<br>FATAL: =
Error running install command for xeno_nucleus<br>open(/proc/xenomai/regist=
ry/native/pipes/klat_pipe): No such file or directory<br>modprobe klat_mod =
or try the -P option?<br>ERROR: Module xeno_timerbench does not exist in /p=
roc/modules<br>ERROR: Module xeno_rtdm does not exist in /proc/modules<br>E=
RROR: Module xeno_native does not exist in /proc/modules<br>ERROR: Module x=
eno_nucleus does not exist in /proc/modules<br><br>sigtest test<br><br>root=
@LinuxU1010:/usr/share/xenomai/testsuite/sigtest# ./run<br>*<br>*<br>* Type=
 ^C to stop this application.<br>*<br>*<br>FATAL: Module xeno_nucleus not f=
ound.<br>FATAL: Error running install command for xeno_nucleus<br>Xenomai: =
SIGTEST skin or CONFIG_XENO_OPT_PERVASIVE disabled.<br>(modprobe xeno_sigte=
st?)<br>ERROR: Module xeno_rtdm does not exist in /proc/modules<br>ERROR: M=
odule xeno_posix does not exist in /proc/modules<br>ERROR: Module xeno_nucl=
eus does not exist in /proc/modules<br>root@domain.hid=
estsuite/sigtest# ^C<br>root@domain.hid=
t# <br><br><br>switchtest test<br><br>root@domain.hid=
stsuite/switchtest# ./run<br>*<br>*<br>* Type ^C to stop this application.<=
br>*<br>*<br>FATAL: Module xeno_nucleus not found.<br>FATAL: Error running =
install command for xeno_nucleus<br>=3D=3D Testing FPU check routines...<br=
>r0: 1 !=3D 2<br>r1: 1 !=3D 2<br>r2: 1 !=3D 2<br>r3: 1 !=3D 2<br>r4: 1 !=3D=
 2<br>r5: 1 !=3D 2<br>r6: 1 !=3D 2<br>r7: 1 !=3D 2<br>=3D=3D FPU check rout=
ines: OK.<br>ioctl(RTTST_RTIOC_SWTEST_CREATE_KTASK): Cannot allocate memory=
<br>=3D=3D Threads: sleeper_ufps0-0 rtk0-1 rtk0-2 rtk_fp0-3 rtk_fp0-4 rtk_f=
p_ufpp0-5 rtk_fp_ufpp0-6 rtup0-7 rtup0-8 rtup_ufpp0-9 rtup_ufpp0-10 rtus0-1=
1 rtus0-12 rtus_ufps0-13 rtus_ufps0-14 rtuo0-15 rtuo0-16 rtuo_ufpp0-17 rtuo=
_ufpp0-18 rtuo_ufps0-19 rtuo_ufps0-20 rtuo_ufpp_ufps0-21 rtuo_ufpp_ufps0-22=
 sleeper_ufps1-0 rtk1-1 rtk1-2 rtk_fp1-3 rtk_fp1-4 rtk_fp_ufpp1-5 rtk_fp_uf=
pp1-6 rtup1-7 rtup1-8 rtup_ufpp1-9 rtup_ufpp1-10 rtus1-11 rtus1-12 rtus_ufp=
s1-13 rtus_ufps1-14 rtuo1-15 rtuo1-16 rtuo_ufpp1-17 rtuo_ufpp1-18 rtuo_ufps=
1-19 rtuo_ufps1-20 rtuo_ufpp_ufps1-21 rtuo_ufpp_ufps1-22 sleeper_ufps2-0 rt=
k2-1 rtk2-2 rtk_fp2-3RTT|&nbsp; 359512:23:52<br>RTH|---------cpu|ctx switch=
es|-------total<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>RTD|&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1|&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 2|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 0<br>ERROR: Module xeno_switchtest does not exist in /proc/modules<br>ERR=
OR: Module xeno_rtdm does not exist in /proc/modules<br>ERROR: Module xeno_=
posix does not exist in /proc/modules<br>ERROR: Module xeno_nucleus does no=
t exist in /proc/modules<br><br>unit test<br><br>*<br>*<br>* Type ^C to sto=
p this application.<br>*<br>*<br>FATAL: Module xeno_nucleus not found.<br>F=
ATAL: Error running install command for xeno_nucleus<br>mul: 0x79364d93, sh=
ft: 26<br>integ: 30, frac: 0x4d9364d9364d9364<br><br>signed positive operat=
ion: 0x03ffffffffffffff * 1000000000 / 33000000<br>inline calibration: 0x00=
00000000000000: 29.102 ns, rejected 0/10000<br>inlined llimd: 0x79364d9364d=
9362f: 54.872 ns, rejected 1/10000<br>inlined llmulshft: 0x79364d92ffffffe1=
: 1.246 ns, rejected 0/10000<br>inlined nodiv_llimd: 0x79364d9364d9362f: 4.=
570 ns, rejected 0/10000<br>out of line calibration: 0x0000000000000000: 30=
.351 ns, rejected 1/10000<br>out of line llimd: 0x79364d9364d9362f: 60.692 =
ns, rejected 1/10000<br>out of line llmulshft: 0x79364d92ffffffe1: 0.830 ns=
, rejected 1/10000<br>out of line nodiv_llimd: 0x79364d9364d9362f: 4.571 ns=
, rejected 1/10000<br><br>signed negative operation: 0xfc00000000000001 * 1=
000000000 / 33000000<br>inline calibration: 0x0000000000000000: 31.635 ns, =
rejected 1/10000<br>inlined llimd: 0x86c9b26c9b26c9d1: 53.173 ns, rejected =
1/10000<br>inlined llmulshft: 0x86c9b26d0000001e: 0.678 ns, rejected 0/1000=
0<br>inlined nodiv_llimd: 0x86c9b26c9b26c9d1: 3.286 ns, rejected 1/10000<br=
>out of line calibration: 0x0000000000000000: 30.351 ns, rejected 0/10000<b=
r>out of line llimd: 0x86c9b26c9b26c9d1: 64.434 ns, rejected 1/10000<br>out=
 of line llmulshft: 0x86c9b26d0000001e: 4.569 ns, rejected 1/10000<br>out o=
f line nodiv_llimd: 0x86c9b26c9b26c9d1: 5.819 ns, rejected 1/10000<br><br>u=
nsigned operation: 0x03ffffffffffffff * 1000000000 / 33000000<br>inline cal=
ibration: 0x0000000000000000: 31.531 ns, rejected 0/10000<br>inlined nodiv_=
ullimd: 0x79364d9364d9362f: 2.140 ns, rejected 0/10000<br>out of line calib=
ration: 0x0000000000000000: 30.351 ns, rejected 0/10000<br>out of line nodi=
v_ullimd: 0x79364d9364d9362f: 4.571 ns, rejected 1/10000<br>ERROR: Module x=
eno_native does not exist in /proc/modules<br>ERROR: Module xeno_nucleus do=
es not exist in /proc/modules<br>root@domain.hid=
te/unit# <br><br>
------=_Part_190450_29804676.1294247539346--


