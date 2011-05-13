From: "Benner Bernd (MH/EES)" <B.Benner@domain.hid>
Date: Fri, 13 May 2011 11:55:46 +0200
Message-ID: <294B28951EBE8146839AF99A61CB5FCE6B3F1A7999@domain.hid>
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_294B28951EBE8146839AF99A61CB5FCE6B3F1A7999SIMBX17debosc_"
MIME-Version: 1.0
Subject: [Xenomai-help] Xenomai 2.5.X - 32 bit X86 is not running on newer
	Kernel Versions
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

--_000_294B28951EBE8146839AF99A61CB5FCE6B3F1A7999SIMBX17debosc_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

   we have a well running X86 Realtime system with Kernel 2.6.29 and xenoma=
i-2.4.10. The system is able to boot from a stick and runs on all our compu=
ters.
 To fix some X11- problems with newer graphic chipsets, we try to upgrade t=
o a newer Kernel version.

   We are starting with Kernel 2.6.34.5 and xenomai-2.5.5.2 using the lates=
t ADEOS-patches. This system works on some test machines, but on some Core =
2 Duo 3 GHz systems with Intel Desktop Chipset ( Lenovo and HP ) the system=
 freeze and/or produces strange console outputs ( only line feeds ) after a=
 start of latency or clocktest.
We are not able to get a kernel log from this systems.

  All permutations of Kernel 2.6.34.5, Kernel 2.6.35.13, xenomai-2.5.3, xen=
omai-2.5.5.2, xenomai-2.5.6 has the same problems on the Core 2 Duo 3 GHz m=
achines.
On other machines with slower Mobile Core 2 Duo or Pentiom M processors the=
 system runs or has sometimes the same problem.

  I have try some changes in the Kernel configuration, without any success.=
  I have also try a combination of Kernel 2.6.35.13. and xenomai-2.4.10 wit=
h some changes in the xenomai headers to run with newer Kernels. This versi=
on has the same problem on the Core 2 Duo 3 GHz systems.

  Is there any way to find the reason of this problems with Xenomai 2.5.X a=
nd newer Kernels 2.6.3X with 32 bit X86 or has anybody similar problems fix=
ed.

Thanks in advance

Mit freundlichen Gr=FC=DFen / Best Regards
Bernd Benner
MH/SGT3
moehwald
Bosch Group
Moehwald GmbH
Michelinstra=DFe 21
66424 Homburg
GERMANY
www.moehwald.de
b.benner@domain.hid<mailto:b.benner@domain.hid>
Moehwald GmbH, Sitz/Registered Office: Homburg/Saar, Zentrales Handelsregis=
ter/Registered Court: Saarbr=FCcken HRB 2812
Gesch=E4ftsf=FChrung/Managing Directors: Jens Last, Wolfgang Geenen





--_000_294B28951EBE8146839AF99A61CB5FCE6B3F1A7999SIMBX17debosc_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Arial, sans-serif" size=3D"2">
<div>Hi,</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp; we have a well running X86 Realtime system with Kernel 2.=
6.29 and xenomai-2.4.10. The system is able to boot from a stick and runs o=
n all our computers.</div>
<div> To fix some X11- problems with newer graphic chipsets, we try to upgr=
ade to a newer Kernel version. </div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp; We are starting with Kernel 2.6.34.5 and xenomai-2.5.5.2 =
using the latest ADEOS-patches. This system works on some test machines, bu=
t on some Core 2 Duo 3 GHz systems with Intel Desktop Chipset ( Lenovo and =
HP ) the system freeze and/or produces strange
console outputs ( only line feeds ) after a start of latency or clocktest. =
</div>
<div>We are not able to get a kernel log from this systems.</div>
<div>&nbsp;</div>
<div>&nbsp; All permutations of Kernel 2.6.34.5, Kernel 2.6.35.13, xenomai-=
2.5.3, xenomai-2.5.5.2, xenomai-2.5.6 has the same problems on the Core 2 D=
uo 3 GHz machines.</div>
<div>On other machines with slower Mobile Core 2 Duo or Pentiom M processor=
s the system runs or has sometimes the same problem.</div>
<div>&nbsp;</div>
<div>&nbsp; I have try some changes in the Kernel configuration, without an=
y success.&nbsp; I have also try a combination of Kernel 2.6.35.13. and xen=
omai-2.4.10 with some changes in the xenomai headers to run with newer Kern=
els. This version has the same problem on
the Core 2 Duo 3 GHz systems.</div>
<div>&nbsp;</div>
<div>&nbsp; Is there any way to find the reason of this problems with Xenom=
ai 2.5.X and newer Kernels 2.6.3X with 32 bit X86 or has anybody similar pr=
oblems fixed.</div>
<div>&nbsp;</div>
<div><font face=3D"Arial, sans-serif">Thanks in advance<font size=3D"3"> </=
font></font></div>
<div><font face=3D"Arial, sans-serif" size=3D"3">&nbsp;</font></div>
<div>Mit freundlichen Gr=FC=DFen / Best Regards<font face=3D"Times New Roma=
n, serif" size=3D"3"> </font></div>
<div>Bernd Benner</div>
<div>MH/SGT3</div>
<div><font face=3D"Times New Roman, serif" size=3D"5" color=3D"#000080"><b>=
moehwald</b><font size=3D"3" color=3D"#000000">
<br>

</font><font size=3D"2" color=3D"#808080"><b>Bosch Group</b></font><font si=
ze=3D"3" color=3D"#000000"> </font></font></div>
<div><font face=3D"Times New Roman, serif">Moehwald GmbH<font size=3D"3"> <=
br>

</font>Michelinstra=DFe 21<font size=3D"3"> <br>

</font>66424 Homburg<font size=3D"3"> <br>

</font>GERMANY<font size=3D"3"> <br>

</font><a href=3D"www.moehwald.de"><font face=3D"Arial, sans-serif" color=
=3D"#0000FF"><u>www.moehwald.de</u></font></a><font size=3D"3"> </font></fo=
nt></div>
<div><font face=3D"Times New Roman, serif" color=3D"#0000FF"><a href=3D"mai=
lto:b.benner@domain.hid"><u>b.benner@domain.hid</u></a></font></div>
<div><font face=3D"Times New Roman, serif" size=3D"2">Moehwald GmbH, Sitz/R=
egistered Office: Homburg/Saar, Zentrales Handelsregister/Registered Court:=
 Saarbr=FCcken HRB 2812<font size=3D"3">
<br>

</font>Gesch=E4ftsf=FChrung/Managing Directors: Jens Last, Wolfgang Geenen<=
font size=3D"3"> </font></font></div>
<div><font face=3D"Times New Roman, serif" size=3D"3">&nbsp;</font></div>
<div><font face=3D"Times New Roman, serif" size=3D"3">&nbsp;</font></div>
<div><font face=3D"Times New Roman, serif" size=3D"3">&nbsp;</font></div>
<div>&nbsp;</div>
</font>
</body>
</html>

--_000_294B28951EBE8146839AF99A61CB5FCE6B3F1A7999SIMBX17debosc_--

