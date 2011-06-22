MIME-Version: 1.0
Date: Wed, 22 Jun 2011 14:33:53 +0200
Message-ID: <BANLkTimKq+oq5oG3d9H+TWs1S0HVCXaPLQ@mail.gmail.com>
From: suresh reddy <sureshreddy.balijepalli@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec501673f6a4d3e04a64c2e45
Subject: [Xenomai-help] booting on pandaboard
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

--bcaec501673f6a4d3e04a64c2e45
Content-Type: text/plain; charset=ISO-8859-1

Dear all,

i placed uImage and modules on to the sdcard and started booting  but the
board freezing as below

U-Boot 2010.09-rc1 (Sep 23 2010 - 11:24:55)

CPU  : OMAP4430
Board: OMAP4 Panda
I2C:   ready
DRAM:  512 MiB
Using default environment

In:    serial
Out:   serial
Err:   serial
Hit any key to stop autoboot:  0
Panda # printenv
bootcmd=if mmc init ${mmcdev}; then if run loadbootscript; then run
bootscript; else if run loaduimage; then run mmcboot; fi; fi; fi
bootdelay=3
baudrate=115200
loadaddr=0x82000000
console=ttyS2,115200n8
usbtty=cdc_acm
vram=16M
mmcdev=1
mmcroot=/dev/mmcblk0p2 rw
mmcrootfstype=ext3 rootwait
mmcargs=setenv bootargs console=${console} vram=${vram} root=${mmcroot}
rootfstype=${mmcrootfstype}
loadbootscript=fatload mmc ${mmcdev} ${loadaddr} boot.scr
bootscript=echo Running bootscript from mmc${mmcdev} ...; source ${loadaddr}
loaduimage=fatload mmc ${mmcdev} ${loadaddr} uImage
mmcboot=echo Booting from mmc${mmcdev} ...; run mmcargs; bootm ${loadaddr}

Environment size: 653/262140 bytes
Panda # setenv mmcargs setenv bootargs console=${console} vram=${vram}
root=${mmcroot} rootfstype=${mmcrootfstype}
Panda # setenv mmcargs setenv bootargs console=${console} vram=${vram}
root=${mmcroot} rootfstype=${mmcrootfstype} earlyprintk
Panda # boot
mmc1 is available
reading boot.scr

279 bytes read
Running bootscript from mmc1 ...
## Executing script at 82000000
reading uImage

2609264 bytes read
reading uInitrd

5977795 bytes read
## Booting kernel from Legacy Image at 80000000 ...
   Image Name:   Linux-2.6.37.6
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2609200 Bytes = 2.5 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
## Loading init Ramdisk from Legacy Image at 81600000 ...
   Image Name:   Ubuntu Initrd
   Image Type:   ARM Linux RAMDisk Image (gzip compressed)
   Data Size:    5977731 Bytes = 5.7 MiB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.


my configuration already enabled erly printk and as i mentioned above i
seted the earlyprintk at args .
but iam not seeing anything on my screen after Uncompressing Linux... done,
booting the kernel.




Thanks

Suresh balijepalli
Rosenehim,Baveria.

--bcaec501673f6a4d3e04a64c2e45
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br clear=3D"all">Dear all,<div><br></div><div>i placed uI=
mage and modules on to the sdcard and started booting =A0but the board free=
zing as below</div><div><br></div><div><div>U-Boot 2010.09-rc1 (Sep 23 2010=
 - 11:24:55)</div>
<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0</div><div>CPU =A0: OMAP4430 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0=A0</div><div>Board: OMAP4 Panda =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0</div><div>I2C: =A0 ready =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0</div><div>DRAM: =A0512 MiB =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0</div>
<div>Using default environment =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0</div><div><br=
></div><div>In: =A0 =A0serial</div><div>Out: =A0 serial</div><div>Err: =A0 =
serial</div><div>Hit any key to stop autoboot: =A00</div><div><font class=
=3D"Apple-style-span" color=3D"#FF0000">Panda # printenv</font></div>
<div><font class=3D"Apple-style-span" color=3D"#FF0000">bootcmd=3Dif mmc in=
it ${mmcdev}; then if run loadbootscript; then run bootscript; else if run =
loaduimage; then run mmcboot; fi; fi; fi</font></div><div><font class=3D"Ap=
ple-style-span" color=3D"#FF0000">bootdelay=3D3</font></div>
<div><font class=3D"Apple-style-span" color=3D"#FF0000">baudrate=3D115200</=
font></div><div><font class=3D"Apple-style-span" color=3D"#FF0000">loadaddr=
=3D0x82000000</font></div><div><font class=3D"Apple-style-span" color=3D"#F=
F0000">console=3DttyS2,115200n8</font></div>
<div><font class=3D"Apple-style-span" color=3D"#FF0000">usbtty=3Dcdc_acm</f=
ont></div><div><font class=3D"Apple-style-span" color=3D"#FF0000">vram=3D16=
M</font></div><div><font class=3D"Apple-style-span" color=3D"#FF0000">mmcde=
v=3D1</font></div>
<div><font class=3D"Apple-style-span" color=3D"#FF0000">mmcroot=3D/dev/mmcb=
lk0p2 rw</font></div><div><font class=3D"Apple-style-span" color=3D"#FF0000=
">mmcrootfstype=3Dext3 rootwait</font></div><div><font class=3D"Apple-style=
-span" color=3D"#FF0000">mmcargs=3Dsetenv bootargs console=3D${console} vra=
m=3D${vram} root=3D${mmcroot} rootfstype=3D${mmcrootfstype}</font></div>
<div><font class=3D"Apple-style-span" color=3D"#FF0000">loadbootscript=3Dfa=
tload mmc ${mmcdev} ${loadaddr} boot.scr</font></div><div><font class=3D"Ap=
ple-style-span" color=3D"#FF0000">bootscript=3Decho Running bootscript from=
 mmc${mmcdev} ...; source ${loadaddr}</font></div>
<div><font class=3D"Apple-style-span" color=3D"#FF0000">loaduimage=3Dfatloa=
d mmc ${mmcdev} ${loadaddr} uImage</font></div><div><font class=3D"Apple-st=
yle-span" color=3D"#FF0000">mmcboot=3Decho Booting from mmc${mmcdev} ...; r=
un mmcargs; bootm ${loadaddr}</font></div>
<div><font class=3D"Apple-style-span" color=3D"#FF0000"><br></font></div><d=
iv><font class=3D"Apple-style-span" color=3D"#FF0000">Environment size: 653=
/262140 bytes</font></div><div><font class=3D"Apple-style-span" color=3D"#F=
F0000">Panda # setenv mmcargs setenv bootargs console=3D${console} vram=3D$=
{vram} root=3D${mmcroot} rootfstype=3D${mmcrootfstype}</font></div>
<div><font class=3D"Apple-style-span" color=3D"#FF0000">Panda # setenv mmca=
rgs setenv bootargs console=3D${console} vram=3D${vram} root=3D${mmcroot} r=
ootfstype=3D${mmcrootfstype} earlyprintk</font></div><div><font class=3D"Ap=
ple-style-span" color=3D"#FF0000">Panda # boot</font></div>
<div><font class=3D"Apple-style-span" color=3D"#FF0000">mmc1 is available</=
font></div><div><font class=3D"Apple-style-span" color=3D"#FF0000">reading =
boot.scr</font></div><div><br></div><div>279 bytes read</div><div>Running b=
ootscript from mmc1 ...</div>
<div>## Executing script at 82000000</div><div>reading uImage</div><div><br=
></div><div>2609264 bytes read</div><div>reading uInitrd</div><div><br></di=
v><div>5977795 bytes read</div><div>## Booting kernel from Legacy Image at =
80000000 ...</div>
<div>=A0=A0 Image Name: =A0 Linux-2.6.37.6</div><div>=A0=A0 Image Type: =A0=
 ARM Linux Kernel Image (uncompressed)</div><div>=A0=A0 Data Size: =A0 =A02=
609200 Bytes =3D 2.5 MiB</div><div>=A0=A0 Load Address: 80008000</div><div>=
=A0=A0 Entry Point: =A080008000</div>
<div>=A0=A0 Verifying Checksum ... OK</div><div>## Loading init Ramdisk fro=
m Legacy Image at 81600000 ...</div><div>=A0=A0 Image Name: =A0 Ubuntu Init=
rd</div><div>=A0=A0 Image Type: =A0 ARM Linux RAMDisk Image (gzip compresse=
d)</div><div>
=A0=A0 Data Size: =A0 =A05977731 Bytes =3D 5.7 MiB</div><div>=A0=A0 Load Ad=
dress: 00000000</div><div>=A0=A0 Entry Point: =A000000000</div><div>=A0=A0 =
Verifying Checksum ... OK</div><div>=A0=A0 Loading Kernel Image ... OK</div=
><div>OK</div><div><br></div>
<div>Starting kernel ...</div><div><br></div><div>Uncompressing Linux... do=
ne, booting the kernel.</div><div><br></div><br></div><div>my configuration=
 already enabled erly printk and as i mentioned above i seted the earlyprin=
tk at args .</div>
<div>but iam not seeing anything on my screen after=A0Uncompressing Linux..=
. done, booting the kernel.</div><meta http-equiv=3D"content-type" content=
=3D"text/html; charset=3Dutf-8"><div><br></div><div><br></div><div><br></di=
v><div>
<br></div><div>Thanks=A0<br><br>Suresh balijepalli<br>Rosenehim,Baveria.<br=
>
</div></div>

--bcaec501673f6a4d3e04a64c2e45--

