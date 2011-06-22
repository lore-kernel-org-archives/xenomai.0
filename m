MIME-Version: 1.0
Date: Wed, 22 Jun 2011 12:11:31 +0200
Message-ID: <BANLkTik5jJ826WBUao92ktP8SccKhfoTfA@mail.gmail.com>
From: suresh reddy <sureshreddy.balijepalli@domain.hid>
Content-Type: multipart/alternative; boundary=20cf3079ba8247238504a64a319d
Subject: [Xenomai-help] reg arm.s
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

--20cf3079ba8247238504a64a319d
Content-Type: text/plain; charset=ISO-8859-1

Dear Giles,

If i use the omap2plus-defconfig and remove that smp option then my building
uimage worked as follows.

 SYSMAP  System.map
  SYSMAP  .tmp_System.map
  OBJCOPY arch/arm/boot/Image
  Kernel: arch/arm/boot/Image is ready
  AS      arch/arm/boot/compressed/head.o
  GZIP    arch/arm/boot/compressed/piggy.gzip
  AS      arch/arm/boot/compressed/piggy.gzip.o
  CC      arch/arm/boot/compressed/decompress.o
  SHIPPED arch/arm/boot/compressed/lib1funcs.S
  AS      arch/arm/boot/compressed/lib1funcs.o
  LD      arch/arm/boot/compressed/vmlinux
  OBJCOPY arch/arm/boot/zImage
  Kernel: arch/arm/boot/zImage is ready
  UIMAGE  arch/arm/boot/uImage
Image Name:   Linux-2.6.37.6-ipipe
Created:      Wed Jun 22 11:03:03 2011
Image Type:   ARM Linux Kernel Image (uncompressed)
Data Size:    2856292 Bytes = 2789.35 kB = 2.72 MB
Load Address: 0x80008000
Entry Point:  0x80008000
  Image arch/arm/boot/uImage is ready
test06:/home/balijepalli/omap4/ipipe-gch#


Now iam using the config file pointed by your previous mail  and I got as
below

Using /home/balijepalli/omap4/ipipe-gch as source for kernel
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
make[2]: `include/generated/mach-types.h' is up to date.
  CALL    /home/balijepalli/omap4/ipipe-gch/scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  Kernel: arch/arm/boot/Image is ready
  LZO     arch/arm/boot/compressed/piggy.lzo
  AS      arch/arm/boot/compressed/piggy.lzo.o
  CC      arch/arm/boot/compressed/misc.o
  CC      arch/arm/boot/compressed/decompress.o
  SHIPPED arch/arm/boot/compressed/lib1funcs.S
  AS      arch/arm/boot/compressed/lib1funcs.o
  LD      arch/arm/boot/compressed/vmlinux
  OBJCOPY arch/arm/boot/zImage
  Kernel: arch/arm/boot/zImage is ready
  UIMAGE  arch/arm/boot/uImage
Image Name:   Linux-2.6.37.6
Created:      Wed Jun 22 11:23:06 2011
Image Type:   ARM Linux Kernel Image (uncompressed)
Data Size:    2609200 Bytes = 2548.05 kB = 2.49 MB
Load Address: 0x80008000
Entry Point:  0x80008000
  Image arch/arm/boot/uImage is ready
Building modules, stage 2.
  MODPOST 3 modules



and  i have a question regarding modules. there are 3 modules in my build
directory (not in lib )

modules.symvers , modules.builtin , modules.order

these are the 3 modules that i have place in my rootfs of sd card (including
usr and dev directories) and Iam using the mlo and uboot.bin files that were
already on sd card ,Iam just replacing uImage.



Thanks

Suresh balijepalli
Rosenehim,Baveria.

--20cf3079ba8247238504a64a319d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Dear Giles,</div><div><br></div><div>If i use the oma=
p2plus-defconfig and remove that smp option then my building uimage worked =
as follows.</div><div><br></div><div>=A0SYSMAP =A0System.map</div><div>=A0=
=A0SYSMAP =A0.tmp_System.map</div>


<div>=A0=A0OBJCOPY arch/arm/boot/Image</div><div>=A0=A0Kernel: arch/arm/boo=
t/Image is ready</div><div>=A0=A0AS =A0 =A0 =A0arch/arm/boot/compressed/hea=
d.o</div><div>=A0=A0GZIP =A0 =A0arch/arm/boot/compressed/piggy.gzip</div><d=
iv>=A0=A0AS =A0 =A0 =A0arch/arm/boot/compressed/piggy.gzip.o</div>


<div>=A0=A0CC =A0 =A0 =A0arch/arm/boot/compressed/decompress.o</div><div>=
=A0=A0SHIPPED arch/arm/boot/compressed/lib1funcs.S</div><div>=A0=A0AS =A0 =
=A0 =A0arch/arm/boot/compressed/lib1funcs.o</div><div>=A0=A0LD =A0 =A0 =A0a=
rch/arm/boot/compressed/vmlinux</div>


<div>=A0=A0OBJCOPY arch/arm/boot/zImage</div><div>=A0=A0Kernel: arch/arm/bo=
ot/zImage is ready</div><div>=A0=A0UIMAGE =A0arch/arm/boot/uImage</div><div=
>Image Name: =A0 Linux-2.6.37.6-ipipe</div><div>Created: =A0 =A0 =A0Wed Jun=
 22 11:03:03 2011</div>


<div>Image Type: =A0 ARM Linux Kernel Image (uncompressed)</div><div>Data S=
ize: =A0 =A02856292 Bytes =3D 2789.35 kB =3D 2.72 MB</div><div>Load Address=
: 0x80008000</div><div>Entry Point: =A00x80008000</div><div>=A0=A0Image arc=
h/arm/boot/uImage is ready</div>


<div>test06:/home/balijepalli/omap4/ipipe-gch#</div><div><br></div><div><br=
></div><div><font color=3D"#FF0000">Now iam using the config file pointed b=
y your previous mail =A0and I got as below</font></div>
<div><br></div><div><div>Using /home/balijepalli/omap4/ipipe-gch as source =
for kernel</div><div>=A0=A0CHK =A0 =A0 include/linux/version.h</div><div>=
=A0=A0CHK =A0 =A0 include/generated/utsrelease.h</div><div>make[2]: `includ=
e/generated/mach-types.h&#39; is up to date.</div>

<div>=A0=A0CALL =A0 =A0/home/balijepalli/omap4/ipipe-gch/scripts/checksysca=
lls.sh</div><div>=A0=A0CHK =A0 =A0 include/generated/compile.h</div><div>=
=A0=A0Kernel: arch/arm/boot/Image is ready</div><div>=A0=A0LZO =A0 =A0 arch=
/arm/boot/compressed/piggy.lzo</div>

<div>=A0=A0AS =A0 =A0 =A0arch/arm/boot/compressed/piggy.lzo.o</div><div>=A0=
=A0CC =A0 =A0 =A0arch/arm/boot/compressed/misc.o</div><div>=A0=A0CC =A0 =A0=
 =A0arch/arm/boot/compressed/decompress.o</div><div>=A0=A0SHIPPED arch/arm/=
boot/compressed/lib1funcs.S</div>

<div>=A0=A0AS =A0 =A0 =A0arch/arm/boot/compressed/lib1funcs.o</div><div>=A0=
=A0LD =A0 =A0 =A0arch/arm/boot/compressed/vmlinux</div><div>=A0=A0OBJCOPY a=
rch/arm/boot/zImage</div><div>=A0=A0Kernel: arch/arm/boot/zImage is ready</=
div><div>=A0=A0UIMAGE =A0arch/arm/boot/uImage</div>

<div>Image Name: =A0 Linux-2.6.37.6</div><div>Created: =A0 =A0 =A0Wed Jun 2=
2 11:23:06 2011</div><div>Image Type: =A0 ARM Linux Kernel Image (uncompres=
sed)</div><div>Data Size: =A0 =A02609200 Bytes =3D 2548.05 kB =3D 2.49 MB</=
div><div>Load Address: 0x80008000</div>

<div>Entry Point: =A00x80008000</div><div>=A0=A0Image arch/arm/boot/uImage =
is ready</div></div><div><div>Building modules, stage 2.</div><div>=A0=A0MO=
DPOST 3 modules</div></div><div><br></div><div><br></div><div><br></div><di=
v>and =A0i have a question regarding modules. there are 3 modules in my bui=
ld directory (not in lib )=A0</div>
<div><br></div><div>modules.symvers , modules.builtin , modules.order=A0</d=
iv><div><br></div><div>these are the 3 modules that i have place in my root=
fs of sd card (including usr and dev directories) and Iam using the mlo and=
 uboot.bin files that were already on sd card ,Iam just replacing uImage.</=
div>
<div><br></div><div><br></div><div><br></div><div>Thanks</div>
<br>Suresh balijepalli<br>Rosenehim,Baveria.<br>
</div>

--20cf3079ba8247238504a64a319d--

