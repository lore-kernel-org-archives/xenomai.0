Date: Fri, 13 Aug 2010 15:17:37 +0100 (BST)
From: edward.robbins@domain.hid
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_20100813151737000000_56891"
Message-ID: <1281709057.650414331@domain.hid>
Subject: [Xenomai-help] Very high latencies under stress testing
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

------=_20100813151737000000_56891
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello all,=0A=0AI have just set up my first xenomai system, and though I be=
lieve I have followed most of the guidelines, if I run latency it sits at a=
round 8uS max, until I run something to stress the system (e.g. startx, or =
killing the x server) when it jumps to 700-800uS.=0A=0AI wonder if this is =
to do with graphics? I have set "NoAccel" in the driver section of Xorg.con=
f (I am using fbdev). I also notice that latencies go massive (e.g. 4200uS)=
 the first time I run glxgears. "glxinfo" reports "Direct rendering: no".=
=0A=0AThis is a core 2 duo system (MEN F19P cPCI) with ICH9M-SFF chipset. I=
 am running debian (lenny) and have followed the guide in the wiki (here: h=
ttp://www.xenomai.org/index.php/Building_Debian_packages) to install kernel=
 2.6.32.15 and xenomai 2.5.4. I have made the following selections for kern=
el configuration in order to try and prevent latency issues:=0A=0AProcessor=
 type and features:=0A         Enable interrupt pipeline=0A         Enable =
high resolution timer support=0A         Disable dell laptop support=0A    =
     Processor family --> Core 2/Newer Xeon=0A         Preemption model -->=
 Preemptible kernel (low latency desktop)=0A=0ABus options (PCI etc):=0A   =
      Disable PCI express hotplug driver=0A         Disable message signall=
ed interrupts (MSI and MSI-X)=0A         Disable PCCard (PCMCIA/Cardbus sup=
port)=0A         Disable support for PCI hotplug=0A=0ADevice drivers:=0A   =
      Disable Memory Technology Device (MTD) support=0A         Disable Fus=
ion MPT device support=0A         Disable I20 device support=0A         Dis=
able ISDN support=0A=0APower management options (ACPUI, APM):=0A         Di=
sable ACPI (Advanced Configuration and Power Interface) Support --> Process=
or=0A         Disable CPU Frequency Scaling=0A         Disable CPU idle PM =
support=0A         Disable Power Managment Support=0A=0AReal-time sub-syste=
m:=0A         Enable Machine--> SMI workaround =0A         Enable Machine--=
> globally disable SMI=0A=0AI have read through this: http://svn.gna.org/sv=
n/xenomai/trunk/TROUBLESHOOTING and tried to find anything relevant. I am b=
ooting from an on board compact flash via USB. I wondered if this could be =
the problem. Output of hdparm:=0A=0Ahdparm -v /dev/sda=0A=0Areadonly =3D 0 =
(off)=0Areadahead =3D 256 (on)=0Ageometry =3D 1024/255/63, sectors =3D 3122=
7840, start =3D 0=0A=0Ahdparm -acdgkmur /dev/sda=0A=0AHDIO_GET_MULTICOUNT f=
ailed: Invalid argument=0AHDIO_GET_32BIT failed: Invalid argument=0AHDIO_GE=
T_UNMASKINTR failed: Invalid argument=0AHDIO_GET_DMA failed: Invaid argumen=
t=0AHDIO_GET_KEEPSETTINGS failed: Invalid argument=0A(reast of output same =
as hdparm -v)=0A=0Ahdparm -t /dev/sda=0A=0A/dev/sda:=0ATiming buffered disk=
 reads: 100MB in 3.01 seconds =3D 33.24 MB/sec=0A=0Ahdparm -T /dev/sda=0A=
=0A/dev/sda:=0ATiming cached reads: 11006 MB in 2.00 seconds =3D 5503.00 MB=
/sec=0A=0AThen I did cat /proc/scsi/scsi:=0AHost: scsi4 Channel: 00 Id: 00 =
Lun: 00=0A  Vendor: Generic  Model: Flash HS-CF        Rev: 1.68=0A  Type: =
    Direct-Access                              ANSI   SCSI revision: 00=0A=
=0AAlso, this embedded system has a lot of configuration options in the BIO=
S (more than I have seen on any other system). Some seem like they could be=
 very useful but are currently unusable (e.g. if I set "SMI handler" to off=
, the system will no longer boot from compact flash). There are also other =
options that might be relevant. I have tried playing with them, but am not =
even sure what some are and the manual is quite cryptic:=0A=0AIDE Controlle=
r settings=0A         "HDC configure as" Options: "IDE", "RAID", "AHCI"=0A=
=0AUSB Configuration=0A         "USB Legacy" Enable/Disable=0A         "EHC=
I1" Enable/Disable=0A         "EHCI2"            "=0A         "UHCI1"      =
      "=0A         "UHCI2"=0A         ...=0A         "UHCI5"=0A         "Pe=
r-Port Control2" Enable/Disable=0A         "USB Pre-fetch Feature" Enable/D=
isable=0A         "USB Pre-fetch Time" 2ms/4ms=0A         "USB HC Alignment=
" Enable/Disable=0A=0AChipset Configuration=0A         "CRID/SRID" Enable/D=
isable=0A         "Port 80h Cycles" LPC bus/PCI bus=0A         "DMI Link AS=
PM Control" Enable/Disable=0A         "Automatic ASMO" Auto/Manual=0A      =
   "ASPM L0s Support" Enable/Disable=0A         "ASPM L0sL1 Support" Enable=
/Disable=0A         "VT-d" Enable/Disable=0A=0AACPI Table/Feature Control=
=0A         "FACP - C2 Latency Value" Enable/Disable=0A         "FACP - C3 =
Latency Value" Enable/Disable=0A         "FACP - RTC S4 Wakeup" Enable/Disa=
ble=0A         "APIC - IO APIC Mode" Enable/Disable=0A         "HPET - HPET=
 Support" Enable/Disable=0A         =0APCI Express Root Port 1/2/3/4/5/6 Se=
ttings=0A         "ASPM" Enable/Disable=0A         "Automatic ASPM" Auto/Ma=
nual=0A         "ASPM L0s" Root&Endpoint Ports/ Disabled/ Root Port Only/ E=
ndpoint port Only=0A         "ASPM L1" Enable/Disable=0A         "URR" Enab=
le/Disable=0A         "FER" Enable/Disable=0A         "NFER" Enable/Disable=
=0A         "CER" Enable/Disable=0A         "CTO" Enable/Disable=0A        =
 "SEFE" Enable/Disable=0A         "SENFE" Enable/Disable=0A         "SECE" =
Enable/Disable=0A         "PME Interrupt" Enable/Disable=0A         "PME SC=
I" Enable/Disable=0A         "Hot Plug SCI" Enable/Disable=0A=0AAdvanced CP=
U Control=0A         "P-States" Enable/Disable=0A         "CMP Support" Ena=
ble/Disable=0A         "Vanderpool Technology" Enable/Disable=0A         "S=
MRR Support" Auto/Disable=0A         "C-States" Enable/Disable=0A         "=
Enhanced C-States" Enable/Disable=0A         "C-State Pop Up Mode" Enable/D=
isable=0A         "C-State Pop Down Mode" Enable/Disable=0A         "C4 Exi=
t Timing Mode" Fast/Slow/Default/Force Slow=0A         "DeepC4" Enable/Disa=
ble=0A         "Hard C4E" Enable/Disable=0A         "Enable C6" Enable/Disa=
ble=0A         "EMTTM" Enable/Disable=0A         "Bi-directional PROCHOT#" =
Enable/Disable=0A         "ACPI 3.0 T-States" Enable/Disable=0A         "DT=
S" Enable/Disable"=0A         ... (lots more options that I am not sure wha=
t they really are for!)=0A=0APlatfoirm Power Management=0A         "Storage=
 Break Event" Enable/Disable=0A         "PCIE Break Event" Enable/Disable=
=0A         "PCI Break Event" Enable/Disable=0A         "EHCI Break Event" =
Enable/Disable=0A         "UHCI Break Event" Enable/Disable=0A         "HDA=
 Break Event" Enable/Disable=0A         "ACPI S3" Enable/Disable=0A=0ASo, c=
ould anyone suggest what I might try to improve the system? Sorry for the t=
orrent of information... I thought it better to give as much info as I coul=
d think of than to not provide enough to make a diagnosis!=0A=0AThanks,=0A=
=0AEdward Robbins=0A=0AControl Systems Engineer=0AOxford Technologies Ltd=
=0AUKAEA Culham=0AJoint European Torus, Remote Handling Division=0A
------=_20100813151737000000_56891
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<font face=3D"arial" size=3D"2">Hello all,<br><br>I have just set up my fir=
st xenomai system, and though I believe I have followed most of the guideli=
nes, if I run latency it sits at around 8uS max, until I run something to s=
tress the system (e.g. startx, or killing the x server) when it jumps to 70=
0-800uS.<br><br>I wonder if this is to do with graphics? I have set "NoAcce=
l" in the driver section of Xorg.conf (I am using fbdev). I also notice tha=
t latencies go massive (e.g. 4200uS) the first time I run glxgears. "glxinf=
o" reports "Direct rendering: no".<br><br>This is a core 2 duo system (MEN =
F19P cPCI) with ICH9M-SFF chipset. I am running debian (lenny) and have fol=
lowed the guide in the wiki (here: http://www.xenomai.org/index.php/Buildin=
g_Debian_packages) to install kernel 2.6.32.15 and xenomai 2.5.4. I have ma=
de the following selections for kernel configuration in order to try and pr=
event latency issues:<br><br>Processor type and features:<br>&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Enable interrupt pipeline<br>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Enable high resolution timer support<=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Disable dell laptop sup=
port<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Processor family -=
-&gt; Core 2/Newer Xeon<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 Preemption model --&gt; Preemptible kernel (low latency desktop)<br><br>Bu=
s options (PCI etc):<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Di=
sable PCI express hotplug driver<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; Disable message signalled interrupts (MSI and MSI-X)<br>&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Disable PCCard (PCMCIA/Cardbus supp=
ort)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Disable support fo=
r PCI hotplug<br><br>Device drivers:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; Disable Memory Technology Device (MTD) support<br>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Disable Fusion MPT device support<br>=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Disable I20 device support=
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Disable ISDN support<b=
r><br>Power management options (ACPUI, APM):<br>&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; Disable ACPI (Advanced Configuration and Power Interf=
ace) Support --&gt; Processor<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; Disable CPU Frequency Scaling<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; Disable CPU idle PM support<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; Disable Power Managment Support<br><br>Real-time sub-sys=
tem:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Enable Machine--&g=
t; SMI workaround <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Enab=
le Machine--&gt; globally disable SMI<br><br>I have read through this: http=
://svn.gna.org/svn/xenomai/trunk/TROUBLESHOOTING and tried to find anything=
 relevant. I am booting from an on board compact flash via USB. I wondered =
if this could be the problem. Output of hdparm:<br><br>hdparm -v /dev/sda<b=
r><br>readonly =3D 0 (off)<br>readahead =3D 256 (on)<br>geometry =3D 1024/2=
55/63, sectors =3D 31227840, start =3D 0<br><br>hdparm -acdgkmur /dev/sda<b=
r><br>HDIO_GET_MULTICOUNT failed: Invalid argument<br>HDIO_GET_32BIT failed=
: Invalid argument<br>HDIO_GET_UNMASKINTR failed: Invalid argument<br>HDIO_=
GET_DMA failed: Invaid argument<br>HDIO_GET_KEEPSETTINGS failed: Invalid ar=
gument<br>(reast of output same as hdparm -v)<br><br>hdparm -t /dev/sda<br>=
<br>/dev/sda:<br>Timing buffered disk reads: 100MB in 3.01 seconds =3D 33.2=
4 MB/sec<br><br>hdparm -T /dev/sda<br><br>/dev/sda:<br>Timing cached reads:=
 11006 MB in 2.00 seconds =3D 5503.00 MB/sec<br><br>Then I did cat /proc/sc=
si/scsi:<br>Host: scsi4 Channel: 00 Id: 00 Lun: 00<br>&nbsp; Vendor: Generi=
c&nbsp; Model: Flash HS-CF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Rev: 1=
.68<br>&nbsp; Type:&nbsp;&nbsp;&nbsp;&nbsp; Direct-Access&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; ANSI&nbsp;&nbsp; SCSI revision: 00<br><br>Also, this embedded system=
 has a lot of configuration options in the BIOS (more than I have seen on a=
ny other system). Some seem like they could be very useful but are currentl=
y unusable (e.g. if I set "SMI handler" to off, the system will no longer b=
oot from compact flash). There are also other options that might be relevan=
t. I have tried playing with them, but am not even sure what some are and t=
he manual is quite cryptic:<br><br>IDE Controller settings<br>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "HDC configure as" Options: "IDE", "RAI=
D", "AHCI"<br><br>USB Configuration<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; "USB Legacy" Enable/Disable<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; "EHCI1" Enable/Disable<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; "EHCI2"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; "<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "UHC=
I1"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "<br>=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "UHCI2"<br>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ...<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; "UHCI5"<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
"Per-Port Control2" Enable/Disable<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; "USB Pre-fetch Feature" Enable/Disable<br>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; "USB Pre-fetch Time" 2ms/4ms<br>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "USB HC Alignment" Enable/Disable<br><br>=
Chipset Configuration<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "=
CRID/SRID" Enable/Disable<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; "Port 80h Cycles" LPC bus/PCI bus<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; "DMI Link ASPM Control" Enable/Disable<br>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "Automatic ASMO" Auto/Manual<br>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "ASPM L0s Support" Enable/Disable<br>&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "ASPM L0sL1 Support" Enable/=
Disable<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "VT-d" Enable/D=
isable<br><br>ACPI Table/Feature Control<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; "FACP - C2 Latency Value" Enable/Disable<br>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "FACP - C3 Latency Value" Enable/Disabl=
e<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "FACP - RTC S4 Wakeup=
" Enable/Disable<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "APIC =
- IO APIC Mode" Enable/Disable<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; "HPET - HPET Support" Enable/Disable<br>&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; <br>PCI Express Root Port 1/2/3/4/5/6 Settings<br>&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "ASPM" Enable/Disable<br>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "Automatic ASPM" Auto/Manual<b=
r>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "ASPM L0s" Root&amp;Endp=
oint Ports/ Disabled/ Root Port Only/ Endpoint port Only<br>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "ASPM L1" Enable/Disable<br>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "URR" Enable/Disable<br>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "FER" Enable/Disable<br>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "NFER" Enable/Disable<br>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "CER" Enable/Disable<br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; "CTO" Enable/Disable<br>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; "SEFE" Enable/Disable<br>&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; "SENFE" Enable/Disable<br>&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; "SECE" Enable/Disable<br>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; "PME Interrupt" Enable/Disable<br>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "PME SCI" Enable/Disable<br>&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "Hot Plug SCI" Enable/Disable<br><br>Adv=
anced CPU Control<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "P-St=
ates" Enable/Disable<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "C=
MP Support" Enable/Disable<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; "Vanderpool Technology" Enable/Disable<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; "SMRR Support" Auto/Disable<br>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; "C-States" Enable/Disable<br>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; "Enhanced C-States" Enable/Disable<br>&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "C-State Pop Up Mode" Enable/Disabl=
e<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "C-State Pop Down Mod=
e" Enable/Disable<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "C4 E=
xit Timing Mode" Fast/Slow/Default/Force Slow<br>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; "DeepC4" Enable/Disable<br>&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; "Hard C4E" Enable/Disable<br>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; "Enable C6" Enable/Disable<br>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "EMTTM" Enable/Disable<br>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "Bi-directional PROCHOT#" Enable/Disable<br>=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "ACPI 3.0 T-States" Enable=
/Disable<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "DTS" Enable/D=
isable"<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ... (lots more =
options that I am not sure what they really are for!)<br><br>Platfoirm Powe=
r Management<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "Storage B=
reak Event" Enable/Disable<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; "PCIE Break Event" Enable/Disable<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; "PCI Break Event" Enable/Disable<br>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; "EHCI Break Event" Enable/Disable<br>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "UHCI Break Event" Enable/Disable<br>&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "HDA Break Event" Enable/Dis=
able<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "ACPI S3" Enable/D=
isable<br><br>So, could anyone suggest what I might try to improve the syst=
em? Sorry for the torrent of information... I thought it better to give as =
much info as I could think of than to not provide enough to make a diagnosi=
s!<br><br>Thanks,<br><br>Edward Robbins<br><br>Control Systems Engineer<br>=
Oxford Technologies Ltd<br>UKAEA Culham<br>Joint European Torus, Remote Han=
dling Division<br></font>
------=_20100813151737000000_56891--


