Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C94BF0.0709D8AA"
Date: Fri, 21 Nov 2008 16:44:23 +0100
Message-ID: <A820268933E41D449CC13B5E097C1E2F0363CE11@domain.hid>
From: "Rubio, Martial" <Martial.Rubio@domain.hid>
Subject: [Xenomai-help] External PCIe device: MSI interrupt install hangs up
	the CPU
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
Cc: jeanfrancois.gilot@domain.hid, "Dupeyrou,
	Gilles" <Gilles.Dupeyrou@domain.hid>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C94BF0.0709D8AA
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello everybody
=20
I'm working with following config :=20
=20
CPU (0=3D>3) AMD Dual Core AMD Opteron=20
Linux version 2.6.25-pae
Xenomai : hal / i386
Xenomai : real time nucleus v2.4.5
=20
Here's below the state of /proc/interrupts :
=20
in red fonts the range of PCIe(xpress)-MSI vectors :
=20
hurle-bise [anaisvs](34):more /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  0:        146          0          0          0    XT-PIC-XT
timer
  1:       1039          0          0          0    XT-PIC-XT
i8042
  2:          0          0          0          0    XT-PIC-XT
cascade
  4:          5          0          0          0    XT-PIC-XT
  5:          2          0          0          0    XT-PIC-XT
ehci_hcd:usb2
  6:          5          0          0          0    XT-PIC-XT
floppy
  7:      16300          0          0          0    XT-PIC-XT
ohci_hcd:usb1
 10:     155104          0          0          0    XT-PIC-XT
ioc0, sata_nv, sata_nv, ohci1394
 11:      47305          0          0          0    XT-PIC-XT
sata_nv, HDA Intel
 14:          0          0          0          0    XT-PIC-XT
pata_amd
 15:          0          0          0          0    XT-PIC-XT
pata_amd
212:          0          9        487    1942504   PCI-MSI-edge
eth0
213:          0          0          0          0   PCI-MSI-edge
shpchp
NMI:          0          0          0          0   Non-maskable
interrupts
LOC:    3722798    3722767    3722730    3722768   Local timer
interrupts
RES:      39386      37672      23570      25780   Rescheduling
interrupts
CAL:       1112       1273       1280        250   function call
interrupts
TLB:       6144       8510       6271       9025   TLB shootdowns
TRM:          0          0          0          0   Thermal event
interrupts
SPU:          0          0          0          0   Spurious interrupts
ERR:          1
MIS:          0
=20
I try to install a new MSI interrupt via rtdm package (rtdm_irq_request)
with
a vector number (211) given by the call to pci_msi_enable for the new
PCIe device.
=20
The system hangs up immediatly (sometimes I can catch the stack trace
with dmesg
the last reference seems to be in rt_hal package)
=20
If I replace (for debug only!!!) this vector number by an unused
"classical" vector number (for instance
14 or 15) ... no problem.
=20
Have you allready test this kind of configuration ... if so a little
help from your part would be
greatly appreciated!
=20
Kind regards
=20
Martial Rubio   =20

Eurocopter France - ETZSR

Technical software manager

=20

* : <mailto:martial.rubio@domain.hid
<mailto:martial.rubio@domain.hid> >

(  04 42 85 68 11=20

7      04 42 85 88 35


=20

------_=_NextPart_001_01C94BF0.0709D8AA
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.3790.3959" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D858511014-21112008>Hello=20
everybody</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D858511014-21112008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT size=3D2><FONT><SPAN =
class=3D858511014-21112008>I'm=20
working with following config :</SPAN></FONT>&nbsp;</FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D858511014-21112008>CPU (0=3D&gt;3)=20
AMD Dual Core AMD Opteron </SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D858511014-21112008>Linux version=20
2.6.25-pae</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D858511014-21112008>Xenomai : hal=20
/ i386</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D858511014-21112008>Xenomai : real=20
time nucleus v2.4.5</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D858511014-21112008></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D858511014-21112008>Here's below=20
the state of /proc/interrupts :</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D858511014-21112008></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D858511014-21112008>in red fonts=20
the range of PCIe(xpress)-MSI vectors :</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D858511014-21112008></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D858511014-21112008>hurle-bise=20
[anaisvs](34):more=20
/proc/interrupts<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=20
CPU0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
CPU1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
CPU2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU3<BR>&nbsp;=20
0:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
146&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;=20
XT-PIC-XT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timer<BR>&nbsp;=20
1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
1039&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;=20
XT-PIC-XT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i8042<BR>&nbsp;=20
2:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;=20
XT-PIC-XT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cascade<BR>&nbsp;=20
4:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;=20
XT-PIC-XT<BR>&nbsp; =
5:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;=20
XT-PIC-XT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ehci_hcd:usb2<BR>&nbsp;=20
6:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;=20
XT-PIC-XT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; floppy<BR>&nbsp;=20
7:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
16300&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;=20
XT-PIC-XT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
ohci_hcd:usb1<BR>&nbsp;10:&nbsp;&nbsp;&nbsp;&nbsp;=20
155104&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;=20
XT-PIC-XT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ioc0, sata_nv, =
sata_nv,=20
ohci1394<BR>&nbsp;11:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
47305&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;=20
XT-PIC-XT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sata_nv, HDA=20
Intel<BR>&nbsp;14:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =

0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;=20
XT-PIC-XT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
pata_amd<BR>&nbsp;15:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;=20
XT-PIC-XT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pata_amd<BR><FONT=20
color=3D#ff0000>212:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
9&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 487&nbsp;&nbsp;&nbsp;=20
1942504&nbsp;&nbsp; PCI-MSI-edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
eth0<BR>213:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;=20
PCI-MSI-edge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
shpchp</FONT><BR>NMI:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;=20
Non-maskable interrupts<BR>LOC:&nbsp;&nbsp;&nbsp; =
3722798&nbsp;&nbsp;&nbsp;=20
3722767&nbsp;&nbsp;&nbsp; 3722730&nbsp;&nbsp;&nbsp; 3722768&nbsp;&nbsp; =
Local=20
timer interrupts<BR>RES:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
39386&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 37672&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
23570&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 25780&nbsp;&nbsp; Rescheduling=20
interrupts<BR>CAL:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
1112&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
1273&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
1280&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 250&nbsp;&nbsp; function =
call=20
interrupts<BR>TLB:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
6144&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
8510&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
6271&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9025&nbsp;&nbsp; TLB=20
shootdowns<BR>TRM:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =

0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; =
Thermal=20
event =
interrupts<BR>SPU:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =

0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp; =
Spurious=20
interrupts<BR>ERR:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =

1<BR>MIS:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
0</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D858511014-21112008></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D858511014-21112008>I try to=20
install a new MSI interrupt via rtdm package (rtdm_irq_request)=20
with</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D858511014-21112008>a vector=20
number (211) given by&nbsp;the&nbsp;call to pci_msi_enable&nbsp;for the =
new PCIe=20
device.</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D858511014-21112008></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D858511014-21112008>The system=20
hangs up immediatly (sometimes I can catch the stack trace with=20
dmesg</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D858511014-21112008>the last=20
reference seems to be in rt_hal package)</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D858511014-21112008></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D858511014-21112008>If I replace=20
(for&nbsp;debug only!!!) this vector number by an unused "classical" =
vector=20
number (for instance</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D858511014-21112008>14 or 15) ...=20
no problem.</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D858511014-21112008></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D858511014-21112008>Have you=20
allready test this kind of configuration ... if so a little help from =
your part=20
would be</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D858511014-21112008>greatly=20
appreciated!</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D858511014-21112008></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D858511014-21112008>Kind=20
regards</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D858511014-21112008></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN class=3D858511014-21112008>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0in 0in 0pt 16.5pt; TEXT-INDENT: -16.5pt"><STRONG><SPAN =

style=3D"FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: 'Comic Sans =
MS'">Martial</SPAN></STRONG><B><SPAN=20
style=3D"FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: 'Comic Sans =
MS'">&nbsp;Rubio</SPAN></B><SPAN=20
style=3D"COLOR: navy"><FONT size=3D3><FONT face=3D"Times New =
Roman">&nbsp;&nbsp;&nbsp;=20
<?xml:namespace prefix =3D o ns =3D =
"urn:schemas-microsoft-com:office:office"=20
/><o:p></o:p></FONT></FONT></SPAN></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0in 0in 0pt 16.5pt; TEXT-INDENT: -16.5pt"><FONT=20
face=3D"Times New Roman"><SPAN style=3D"FONT-SIZE: 10pt; COLOR: =
blue">Eurocopter=20
France &#8211; ETZSR</SPAN><SPAN style=3D"COLOR: =
blue"><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0in 0in 0pt 16.5pt; TEXT-INDENT: -16.5pt"><FONT=20
face=3D"Times New Roman"><SPAN style=3D"FONT-SIZE: 10pt; COLOR: =
blue">Technical=20
software manager</SPAN><SPAN style=3D"COLOR: =
navy"><o:p></o:p></SPAN></FONT></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0in 0in 0pt 16.5pt; TEXT-INDENT: -16.5pt"><SPAN=20
style=3D"FONT-SIZE: 10pt; COLOR: blue"><o:p><FONT=20
face=3D"Times New Roman">&nbsp;</FONT></o:p></SPAN></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0in 0in 0pt 16.5pt; TEXT-INDENT: -16.5pt"><SPAN =
lang=3DFR=20
style=3D"FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: Wingdings; =
mso-ansi-language: FR">*</SPAN><FONT=20
face=3D"Times New Roman"><SPAN style=3D"FONT-SIZE: 10pt; COLOR: =
blue">&nbsp;:=20
</SPAN><FONT size=3D3><U><SPAN style=3D"COLOR: =
black">&lt;</SPAN></U><U><SPAN=20
lang=3DFR style=3D"COLOR: blue; mso-ansi-language: FR"><A=20
title=3D"mailto:martial.rubio@domain.hid&#10;mailto:jean-pierre.lebai=
lly@domain.hid
href=3D"mailto:martial.rubio@domain.hid"><SPAN lang=3DEN-US=20
style=3D"mso-ansi-language: =
EN-US">mailto:martial.rubio@domain.hid</SPAN></A></SPAN><SPAN=20
style=3D"COLOR: black">&gt;</SPAN></U><SPAN=20
style=3D"COLOR: navy"><o:p></o:p></SPAN></FONT></FONT></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0in 0in 0pt 16.5pt; TEXT-INDENT: -16.5pt"><SPAN =
lang=3DFR=20
style=3D"FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: Wingdings; =
mso-ansi-language: FR">(</SPAN><FONT=20
face=3D"Times New Roman"><SPAN lang=3DFR=20
style=3D"COLOR: navy; mso-ansi-language: FR"><FONT size=3D3>&nbsp;=20
</FONT></SPAN><SPAN lang=3DFR=20
style=3D"FONT-SIZE: 10pt; COLOR: navy; mso-ansi-language: FR">04 42=20
8<B>5&nbsp;</B></SPAN><B><SPAN lang=3DFR=20
style=3D"FONT-SIZE: 10pt; COLOR: black; mso-ansi-language: =
FR">68&nbsp;11</SPAN></B><B><SPAN=20
lang=3DFR=20
style=3D"FONT-SIZE: 10pt; COLOR: blue; mso-ansi-language: =
FR">&nbsp;</SPAN></B></FONT></P>
<P class=3DMsoNormal=20
style=3D"MARGIN: 0in 0in 0pt 16.5pt; TEXT-INDENT: -16.5pt"><FONT=20
face=3D"Times New Roman"><B><SPAN lang=3DFR=20
style=3D"FONT-SIZE: 10pt; COLOR: blue; mso-ansi-language: =
FR"></SPAN></B></FONT><SPAN=20
lang=3DFR=20
style=3D"FONT-SIZE: 10pt; COLOR: navy; FONT-FAMILY: 'Wingdings 2'; =
mso-fareast-font-family: 'Wingdings 2'; mso-ansi-language: FR; =
mso-bidi-font-family: 'Wingdings 2'; mso-bidi-font-weight: bold"><SPAN=20
style=3D"mso-list: Ignore">7<SPAN=20
style=3D"FONT: 7pt 'Times New Roman'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
</SPAN></SPAN></SPAN><SPAN lang=3DFR=20
style=3D"FONT-SIZE: 10pt; COLOR: navy; mso-ansi-language: FR"><FONT=20
face=3D"Times New Roman">04 42 8<B>5 88 =
35<o:p></o:p></B></FONT></SPAN></P></DIV>
<DIV><BR></DIV></SPAN></FONT></FONT>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D858511014-21112008></SPAN></FONT></FONT>&nbsp;</DIV></BODY></HTML=
>

------_=_NextPart_001_01C94BF0.0709D8AA--

