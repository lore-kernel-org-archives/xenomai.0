Message-Id: <8sm023$gq1qra@domain.hid>
From: "Gao" <gwysu@domain.hid>
Date: Wed, 1 Sep 2010 15:47:13 +0800
MIME-Version: 1.0
Content-Type: multipart/related;
	boundary="----=_NextPart_000_0008_01CB49EC.F35C19C0"
In-Reply-To: 
Subject: Re: [Xenomai-help] Powerpc kernel cannot boot with xenomai
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

This is a multi-part message in MIME format.

------=_NextPart_000_0008_01CB49EC.F35C19C0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0009_01CB49EC.F35E63B0"


------=_NextPart_001_0009_01CB49EC.F35E63B0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi All,
 
I patched the kernel with xenomai, but the kernel "cuImage" cannot boot up,
below is the console output:
     
U-Boot 2009.06.00-svn21572 (Aug 24 2010 - 11:20:12)
 
CPU:   MPC885ZPnn at 100 MHz: 8 kB I-Cache 8 kB D-Cache FEC present
Board: RXT-2000
I2C:   ready
DRAM:  32 MB
1 gd->ram_size = (2000000) CONFIG_SYS_MEM_TOP_HIDE (0)
2 gd->ram_size = (2000000) CONFIG_SYS_MEM_TOP_HIDE (0)
IRIS: bd->bi_memsize (2000000) gd(ff002ec0)->gd->ram_size(2000000)
IRIS: bd->bi_memsize (2000000)
Now running in RAM - U-Boot at: 01f89000
FLASH: 16 MB
In:    serial
Out:   serial
Err:   serial
Net:   FEC ETHERNET
IRIS: IDE testing
IRIS: CONFIG_CMD_IDE
PCMCIA:IRIS: NO CONFIG_START_IDE
SanDisk SDP 5/3 0.6
            Fixed Disk Card
            IDE interface
            [silicon] [unique] [single] [sleep] [standby] [idle] [low power]
Bus 0: OK
  Device 0: Model: SanDisk SDCFH-002G Firm: HDX 5.04 Ser#: AOZ043010001455
            Type: Removable Hard Disk
            Capacity: 1918.0 MB = 1.8 GB (3928176 x 512)
Hit any key to stop autoboot:  0
## Booting kernel from Legacy Image at 00100000 ...
   Image Name:   Linux-2.6.33.4
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1873951 Bytes =  1.8 MB
   Load Address: 00400000
   Entry Point:  00400558
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory <- <0x0 0x0> (0MB)
ENET0: local-mac-address <- 00:00:00:00:00:00
CPU clock-frequency <- 0x0 (0MHz)
CPU timebase-frequency <- 0x0 (0MHz)
 
zImage starting: loaded at 0x00400000 (sp: 0x01b88990)
Allocating 0x3d6de0 bytes for kernel ...
gunzipping (0x00000000 <- 0x0040c000:0x007fd97c)...done 0x3adf34 bytes
 
Linux/PowerPC load:
Finalizing device tree... flat tree at 0x80a300

 
 
Before I patched xenomai, the kernel can boot up with below console output:
 
 
CPU:   MPC885ZPnn at 100 MHz: 8 kB I-Cache 8 kB D-Cache FEC present
Board: RXT-2000
I2C:   ready
DRAM:  32 MB
1 gd->ram_size = (2000000) CONFIG_SYS_MEM_TOP_HIDE (0)
2 gd->ram_size = (2000000) CONFIG_SYS_MEM_TOP_HIDE (0)
IRIS: bd->bi_memsize (2000000) gd(ff002ec0)->gd->ram_size(2000000)
IRIS: bd->bi_memsize (2000000)
Now running in RAM - U-Boot at: 01f89000
FLASH: 16 MB
In:    serial
Out:   serial
Err:   serial
Net:   FEC ETHERNET
IRIS: IDE testing
IRIS: CONFIG_CMD_IDE
PCMCIA:IRIS: NO CONFIG_START_IDE
SanDisk SDP 5/3 0.6
            Fixed Disk Card
            IDE interface
            [silicon] [unique] [single] [sleep] [standby] [idle] [low power]
Bus 0: OK
  Device 0: Model: SanDisk SDCFH-002G Firm: HDX 5.04 Ser#: AOZ043010001455
            Type: Removable Hard Disk
            Capacity: 1918.0 MB = 1.8 GB (3928176 x 512)
Hit any key to stop autoboot:  0
## Booting kernel from Legacy Image at 00100000 ...
   Image Name:   Linux-2.6.33.4
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1697346 Bytes =  1.6 MB
   Load Address: 00400000
   Entry Point:  00400558
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory <- <0x0 0x2000000> (32MB)
ENET0: local-mac-address <- 00:d0:dd:ff:20:00
CPU clock-frequency <- 0x5f5e100 (100MHz)
CPU timebase-frequency <- 0x2faf08 (3MHz)
CPU bus-frequency <- 0x2faf080 (50MHz)
 
zImage starting: loaded at 0x00400000 (sp: 0x01b88990)
Allocating 0x35e3f0 bytes for kernel ...
gunzipping (0x00000000 <- 0x0040c000:0x00799450)...done 0x349f2c bytes
 
Linux/PowerPC load: root=/dev/sda1 rw rootfstype=ext3
ip=169.254.0.2::169.254.0.1:255.255.0.0 console=ttyCPM0,38400
Finalizing device tree... flat tree at 0x7a6300
Using RxT-Carrier machine description
...................

 
It seems the boot loader doesn't pass the boot parameters to the kernel that
cannot boot up. Any one can help me? Thanks in advance.
 
 
 
 
Best regards,
Wenyi Gao

 


------=_NextPart_001_0009_01CB49EC.F35E63B0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE id=3DridTitle>Blank</TITLE>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<STYLE><!-- body  { font-family: Arial, Helvetica; font-size: 10pt; =
color: #000000; margin-top: 25px; margin-left: 25px; } P.msoNormal, =
LI.msoNormal  { font-family: Helvetica, "Times New Roman"; font-size: =
10pt; margin-top: 0px; margin-left: 0px; color: "#ffffcc"; } --></STYLE>

<META content=3D"MSHTML 6.00.2900.3698" name=3DGENERATOR></HEAD>
<BODY id=3DridBody background=3Dcid:372474607@domain.hid>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D486354802-05122007><FONT =
size=3D3>Hi<SPAN=20
class=3D192242407-01092010> All,</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D192242407-01092010></SPAN></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D192242407-01092010>I patched the&nbsp;kernel with xenomai, =
but&nbsp;the=20
kernel "cuImage" cannot boot up,&nbsp;below is the console=20
output:</SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D192242407-01092010></SPAN>&nbsp;&nbsp;&nbsp;&nbsp; =
</FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>U-Boot =
2009.06.00-svn21572 (Aug=20
24 2010 - 11:20:12)</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>CPU:&nbsp;&nbsp; =
MPC885ZPnn at=20
100 MHz: 8 kB I-Cache 8 kB D-Cache FEC present<BR>Board:=20
RXT-2000<BR>I2C:&nbsp;&nbsp; ready<BR>DRAM:&nbsp; 32 MB<BR>1 =
gd-&gt;ram_size =3D=20
(2000000) CONFIG_SYS_MEM_TOP_HIDE (0)<BR>2 gd-&gt;ram_size =3D (2000000) =

CONFIG_SYS_MEM_TOP_HIDE (0)<BR>IRIS: bd-&gt;bi_memsize (2000000)=20
gd(ff002ec0)-&gt;gd-&gt;ram_size(2000000)<BR>IRIS: bd-&gt;bi_memsize=20
(2000000)<BR>Now running in RAM - U-Boot at: 01f89000<BR>FLASH: 16=20
MB<BR>In:&nbsp;&nbsp;&nbsp; serial<BR>Out:&nbsp;&nbsp;=20
serial<BR>Err:&nbsp;&nbsp; serial<BR>Net:&nbsp;&nbsp; FEC =
ETHERNET<BR>IRIS: IDE=20
testing<BR>IRIS: CONFIG_CMD_IDE<BR>PCMCIA:IRIS: NO =
CONFIG_START_IDE<BR>SanDisk=20
SDP 5/3=20
0.6<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 Fixed=20
Disk =
Card<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;=20
IDE=20
interface<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
[silicon] [unique] [single] [sleep] [standby] [idle] [low power]<BR>Bus =
0:=20
OK<BR>&nbsp; Device 0: Model: SanDisk SDCFH-002G Firm: HDX 5.04 Ser#:=20
AOZ043010001455<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;=20
Type: Removable Hard=20
Disk<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;=20
Capacity: 1918.0 MB =3D 1.8 GB (3928176 x 512)<BR>Hit any key to stop=20
autoboot:&nbsp; 0<BR>## Booting kernel from Legacy Image at 00100000=20
...<BR>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; =
Linux-2.6.33.4<BR>&nbsp;&nbsp; Image=20
Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip =
compressed)<BR>&nbsp;&nbsp;=20
Data Size:&nbsp;&nbsp;&nbsp; 1873951 Bytes =3D&nbsp; 1.8 =
MB<BR>&nbsp;&nbsp; Load=20
Address: 00400000<BR>&nbsp;&nbsp; Entry Point:&nbsp; =
00400558<BR>&nbsp;&nbsp;=20
Verifying Checksum ... OK<BR>&nbsp;&nbsp; Uncompressing Kernel Image ... =

OK<BR>Memory &lt;- &lt;0x0 0x0&gt; (0MB)<BR>ENET0: local-mac-address =
&lt;-=20
00:00:00:00:00:00<BR>CPU clock-frequency &lt;- 0x0 (0MHz)<BR>CPU=20
timebase-frequency &lt;- 0x0 (0MHz)</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>zImage starting: =
loaded at=20
0x00400000 (sp: 0x01b88990)<BR>Allocating 0x3d6de0 bytes for kernel=20
...<BR>gunzipping (0x00000000 &lt;- 0x0040c000:0x007fd97c)...done =
0x3adf34=20
bytes</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>Linux/PowerPC=20
load:<BR>Finalizing device tree... flat tree at =
0x80a300<BR></FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT =
size=3D3></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007></SPAN><SPAN=20
class=3D486354802-05122007></SPAN><SPAN =
class=3D486354802-05122007></SPAN><SPAN=20
class=3D486354802-05122007><FONT size=3D3></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D192242407-01092010><FONT=20
size=3D3>Before I patched xenomai, the kernel can boot up with below =
console=20
output:</FONT></SPAN></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><SPAN =
class=3D192242407-01092010><FONT=20
size=3D3></FONT></SPAN></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT =
size=3D3></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>CPU:&nbsp;&nbsp; =
MPC885ZPnn at=20
100 MHz: 8 kB I-Cache 8 kB D-Cache FEC present<BR>Board:=20
RXT-2000<BR>I2C:&nbsp;&nbsp; ready<BR>DRAM:&nbsp; 32 MB<BR>1 =
gd-&gt;ram_size =3D=20
(2000000) CONFIG_SYS_MEM_TOP_HIDE (0)<BR>2 gd-&gt;ram_size =3D (2000000) =

CONFIG_SYS_MEM_TOP_HIDE (0)<BR>IRIS: bd-&gt;bi_memsize (2000000)=20
gd(ff002ec0)-&gt;gd-&gt;ram_size(2000000)<BR>IRIS: bd-&gt;bi_memsize=20
(2000000)<BR>Now running in RAM - U-Boot at: 01f89000<BR>FLASH: 16=20
MB<BR>In:&nbsp;&nbsp;&nbsp; serial<BR>Out:&nbsp;&nbsp;=20
serial<BR>Err:&nbsp;&nbsp; serial<BR>Net:&nbsp;&nbsp; FEC =
ETHERNET<BR>IRIS: IDE=20
testing<BR>IRIS: CONFIG_CMD_IDE<BR>PCMCIA:IRIS: NO =
CONFIG_START_IDE<BR>SanDisk=20
SDP 5/3=20
0.6<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 Fixed=20
Disk =
Card<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;=20
IDE=20
interface<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
[silicon] [unique] [single] [sleep] [standby] [idle] [low power]<BR>Bus =
0:=20
OK<BR>&nbsp; Device 0: Model: SanDisk SDCFH-002G Firm: HDX 5.04 Ser#:=20
AOZ043010001455<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;=20
Type: Removable Hard=20
Disk<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;=20
Capacity: 1918.0 MB =3D 1.8 GB (3928176 x 512)<BR>Hit any key to stop=20
autoboot:&nbsp; 0<BR>## Booting kernel from Legacy Image at 00100000=20
...<BR>&nbsp;&nbsp; Image Name:&nbsp;&nbsp; =
Linux-2.6.33.4<BR>&nbsp;&nbsp; Image=20
Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip =
compressed)<BR>&nbsp;&nbsp;=20
Data Size:&nbsp;&nbsp;&nbsp; 1697346 Bytes =3D&nbsp; 1.6 =
MB<BR>&nbsp;&nbsp; Load=20
Address: 00400000<BR>&nbsp;&nbsp; Entry Point:&nbsp; =
00400558<BR>&nbsp;&nbsp;=20
Verifying Checksum ... OK<BR>&nbsp;&nbsp; Uncompressing Kernel Image ... =

OK<BR>Memory &lt;- &lt;0x0 0x2000000&gt; (32MB)<BR>ENET0: =
local-mac-address=20
&lt;- 00:d0:dd:ff:20:00<BR>CPU clock-frequency &lt;- 0x5f5e100 =
(100MHz)<BR>CPU=20
timebase-frequency &lt;- 0x2faf08 (3MHz)<BR>CPU bus-frequency &lt;- =
0x2faf080=20
(50MHz)</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>zImage starting: =
loaded at=20
0x00400000 (sp: 0x01b88990)<BR>Allocating 0x35e3f0 bytes for kernel=20
...<BR>gunzipping (0x00000000 &lt;- 0x0040c000:0x00799450)...done =
0x349f2c=20
bytes</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>Linux/PowerPC load: =

root=3D/dev/sda1 rw rootfstype=3Dext3 =
ip=3D169.254.0.2::169.254.0.1:255.255.0.0=20
console=3DttyCPM0,38400<BR>Finalizing device tree... flat tree at=20
0x7a6300<BR>Using RxT-Carrier machine=20
description<BR>...................<BR></FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT =
size=3D3></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D192242407-01092010><FONT size=3D4>It seems the boot loader =
doesn't pass the=20
boot parameters to the kernel that cannot boot up. Any one&nbsp;can help =

me?&nbsp;Thanks in advance.</FONT></SPAN></FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D192242407-01092010></SPAN></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D192242407-01092010></SPAN></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D192242407-01092010></SPAN></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3><SPAN=20
class=3D192242407-01092010></SPAN>&nbsp;</DIV></FONT></SPAN>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>Best=20
regards,</FONT></SPAN></DIV>
<DIV><SPAN class=3D486354802-05122007><FONT size=3D3>Wenyi=20
Gao</FONT></SPAN></DIV><IFRAME width=3D100 height=3D0></IFRAME>
<P><FONT size=3D4></FONT>&nbsp;</P></BODY></HTML>

------=_NextPart_001_0009_01CB49EC.F35E63B0--

------=_NextPart_000_0008_01CB49EC.F35C19C0
Content-Type: image/gif;
	name="Blank Bkgrd.gif"
Content-Transfer-Encoding: base64
Content-ID: <372474607@domain.hid>

R0lGODlhLQAtAID/AP////f39ywAAAAALQAtAEACcAxup8vtvxKQsFon6d02898pGkgiYoCm6sq2
7iqWcmzOsmeXeA7uPJd5CYdD2g9oPF58ygqz+XhCG9JpJGmlYrPXGlfr/Yo/VW45e7amp2tou/lW
xo/zX513z+Vt+1n/tiX2pxP4NUhy2FM4xtjIUQAAOw==

------=_NextPart_000_0008_01CB49EC.F35C19C0--


