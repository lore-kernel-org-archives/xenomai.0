MIME-Version: 1.0
Date: Mon, 20 Jun 2011 11:52:17 +0200
Message-ID: <BANLkTi=DsC9d_LVt3deiBCUAQq2-UubTuA@mail.gmail.com>
From: suresh reddy <sureshreddy.balijepalli@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec5015fb9d81b3204a621b066
Subject: [Xenomai-help] regarding freezing at booting
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

--bcaec5015fb9d81b3204a621b066
Content-Type: text/plain; charset=ISO-8859-1

Dear xenomai,

I compiled the the kernel and builded the uImage . I transfered the uImage
to FAT partion of SD Card  and the directories DEV and usr (That generated
due to make DESTDIR) to root filesystem of the sd card.

i started booting from sd card . It giving me the below result and freezing.
Iam seeing nothing on terminal after this .

Texas Instruments X-Loader 1.41 (Oct  6 2010 - 17:27:48)

mmc read: Invalid size

Starting OS Bootloader from MMC/SD1 ...



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
mmc1 is available
reading boot.scr

279 bytes read
Running bootscript from mmc1 ...
## Executing script at 82000000
reading uImage

3460944 bytes read
reading uInitrd

5977795 bytes read
## Booting kernel from Legacy Image at 80000000 ...
   Image Name:   Linux-2.6.37.6
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3460880 Bytes = 3.3 MiB
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



And i thought whether my uImage that i created was crashed , so thought of
building it again .
when i run the make uImage , it giving me error No rule to make target
uImage . stop

make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi-
O=/home/balijepalli/pandaboard/build uImage
make: *** No rule to make target `uImage'.  Stop.

then i ran
test06:/home/balijepalli/pandaboard/ipipe-gch# make ARCH=arm
CROSS_COMPILE=arm-none-linux-gnueabi- O=/home/balijepalli/pandaboard/build
omap4_panda_defconfig
make: *** No rule to make target `omap4_panda_defconfig'.  Stop.

so i went to to 1st step to check scripts/prepare. kernel.sh as below
 test06:/home/balijepalli/pandaboard/xenomai-2.5.6#
scripts/prepare-kernel.sh --linux=/home/balijepalli/pandaboard/ipipe-gch
--arch=arm
scripts/prepare-kernel.sh: line 350: linux_: command not found


 i checked this scripts/prepare.kernel.sh by downloading the xenomai again
but i got the same error.




Thanks for the help
Suresh balijepalli
Rosenehim,Baveria.

--bcaec5015fb9d81b3204a621b066
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear xenomai,<div><br></div><div>I compiled the the kernel=
 and builded the uImage . I transfered the uImage to FAT partion of SD Card=
 =A0and the directories DEV and usr (That generated due to make DESTDIR) to=
 root filesystem of the sd card.</div>
<div><br></div><div>i started booting from sd card . It giving me the below=
 result and freezing. Iam seeing nothing on terminal after this .</div><div=
><br></div><div><div>Texas Instruments X-Loader 1.41 (Oct =A06 2010 - 17:27=
:48) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0</div>
<div>mmc read: Invalid size =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0</di=
v><div>Starting OS Bootloader from MMC/SD1 ... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0</div><div>=A0=A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
</div>
<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0</div><div>U-Boot 2010.09-rc1 (Sep 23 2010 - 11:24:55)</div><di=
v>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0</div><div>CPU =A0: OMAP4430 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0=A0</div><div>Board: OMAP4 Panda =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0</div>
<div>I2C: =A0 ready =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
</div><div>DRAM: =A0512 MiB =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0</div><div>Using default environment =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0</di=
v><div><br></div><div>In: =A0 =A0serial</div><div>Out: =A0 serial</div><div=
>
Err: =A0 serial</div><div>Hit any key to stop autoboot: =A00</div><div>mmc1=
 is available</div><div>reading boot.scr</div><div><br></div><div>279 bytes=
 read</div><div>Running bootscript from mmc1 ...</div><div>## Executing scr=
ipt at 82000000</div>
<div>reading uImage</div><div><br></div><div>3460944 bytes read</div><div>r=
eading uInitrd</div><div><br></div><div>5977795 bytes read</div><div>## Boo=
ting kernel from Legacy Image at 80000000 ...</div><div>=A0=A0 Image Name: =
=A0 Linux-2.6.37.6</div>
<div>=A0=A0 Image Type: =A0 ARM Linux Kernel Image (uncompressed)</div><div=
>=A0=A0 Data Size: =A0 =A03460880 Bytes =3D 3.3 MiB</div><div>=A0=A0 Load A=
ddress: 80008000</div><div>=A0=A0 Entry Point: =A080008000</div><div>=A0=A0=
 Verifying Checksum ... OK</div>
<div>## Loading init Ramdisk from Legacy Image at 81600000 ...</div><div>=
=A0=A0 Image Name: =A0 Ubuntu Initrd</div><div>=A0=A0 Image Type: =A0 ARM L=
inux RAMDisk Image (gzip compressed)</div><div>=A0=A0 Data Size: =A0 =A0597=
7731 Bytes =3D 5.7 MiB</div>
<div>=A0=A0 Load Address: 00000000</div><div>=A0=A0 Entry Point: =A00000000=
0</div><div>=A0=A0 Verifying Checksum ... OK</div><div>=A0=A0 Loading Kerne=
l Image ... OK</div><div>OK</div><div><br></div><div>Starting kernel ...</d=
iv><div><br></div>
<div><font class=3D"Apple-style-span" color=3D"#FF0000">Uncompressing Linux=
... done, booting the kernel.</font></div></div><div><br></div><div><br></d=
iv><div><br></div><div>And i thought whether my uImage that i created was c=
rashed , so thought of building it again .</div>
<div>when i run the make uImage , it giving me error No rule to make target=
 uImage . stop</div><div><br></div><div><div>make ARCH=3Darm CROSS_COMPILE=
=3Darm-none-linux-gnueabi- O=3D/home/balijepalli/pandaboard/build uImage</d=
iv>
<div><font class=3D"Apple-style-span" color=3D"#FF0000">make: *** No rule t=
o make target `uImage&#39;. =A0Stop.</font></div></div><div><br></div><div>=
then i ran=A0</div><div><div>test06:/home/balijepalli/pandaboard/ipipe-gch#=
 make ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi- O=3D/home/balijepa=
lli/pandaboard/build omap4_panda_defconfig</div>
<div><font class=3D"Apple-style-span" color=3D"#FF0000">make: *** No rule t=
o make target `omap4_panda_defconfig&#39;. =A0Stop.</font></div></div><div>=
<br></div><div>so i went to to 1st step to check scripts/prepare. kernel.sh=
 as below</div>
<div>=A0test06:/home/balijepalli/pandaboard/xenomai-2.5.6# scripts/prepare-=
kernel.sh --linux=3D/home/balijepalli/pandaboard/ipipe-gch --arch=3Darm</di=
v><div>s<font class=3D"Apple-style-span" color=3D"#FF0000">cripts/prepare-k=
ernel.sh: line 350: linux_: command not found</font></div>
<div><br></div><div>=A0</div><div>=A0i checked this scripts/<a href=3D"http=
://prepare.kernel.sh">prepare.kernel.sh</a> by downloading the xenomai agai=
n but i got the same error.=A0</div><div><br></div><div><br></div><div><br =
clear=3D"all">
<br>Thanks for the help<br>Suresh balijepalli<br>Rosenehim,Baveria.<br>
</div></div>

--bcaec5015fb9d81b3204a621b066--

