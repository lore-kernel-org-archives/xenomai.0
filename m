MIME-Version: 1.0
Date: Tue, 21 Jun 2011 15:11:08 +0200
Message-ID: <BANLkTi=qe3CqD9U_T3nF6xBN+nZNbxF7Gg@domain.hid>
From: suresh reddy <sureshreddy.balijepalli@domain.hid>
Content-Type: multipart/alternative; boundary=20cf3079ba82cf078f04a63895fe
Subject: [Xenomai-help] regarding ARMv.s error
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

--20cf3079ba82cf078f04a63895fe
Content-Type: text/plain; charset=ISO-8859-1

Dear all,


i have downloaded ipipe patched kernel from xenomai git .and applied the
patches to the xenomai 2.5.6 sources as mentioned .

make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- O=../build
omap2plus_defconfig
make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- O=../build menuconfig

i just removed all the other boards from TI except Pandaboard. I did not
touched any other options.

then I run the command

make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi- O=../build uImage

then it giving me the error as below

test06:/home/balijepalli/omap4/ipipe-gch# make ARCH=arm
CROSS_COMPILE=arm-none-linux-gnueabi- O=/home/balijepalli/omap4/build uImage
  GEN     /home/balijepalli/omap4/build/Makefile
scripts/kconfig/conf --silentoldconfig Kconfig
  Using /home/balijepalli/omap4/ipipe-gch as source for kernel
  GEN     /home/balijepalli/omap4/build/Makefile
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
make[2]: `include/generated/mach-types.h' is up to date.
  CC      arch/arm/kernel/asm-offsets.s
  GEN     include/generated/asm-offsets.h
  CALL    /home/balijepalli/omap4/ipipe-gch/scripts/checksyscalls.sh
  CC      init/main.o
  CHK     include/generated/compile.h
  CC      init/version.o
  CC      init/do_mounts.o
  CC      init/do_mounts_rd.o
  CC      init/do_mounts_initrd.o
  LD      init/mounts.o
  CC      init/initramfs.o
  CC      init/calibrate.o
  LD      init/built-in.o
  CC      arch/arm/nwfpe/fpa11_cpdt.o
  CC      arch/arm/nwfpe/fpmodule.o
  AS      arch/arm/nwfpe/entry.o
  LD      arch/arm/nwfpe/nwfpe.o
  LD      arch/arm/nwfpe/built-in.o
  CC      arch/arm/vfp/vfpmodule.o
  AS      arch/arm/vfp/entry.o
  AS      arch/arm/vfp/vfphw.o
  CC      arch/arm/vfp/vfpsingle.o
  CC      arch/arm/vfp/vfpdouble.o
  LD      arch/arm/vfp/vfp.o
  LD      arch/arm/vfp/built-in.o
  CC      arch/arm/kernel/elf.o
  AS      arch/arm/kernel/entry-armv.o
/home/balijepalli/omap4/ipipe-gch/arch/arm/kernel/entry-armv.S: Assembler
messages:
/home/balijepalli/omap4/ipipe-gch/arch/arm/kernel/entry-armv.S:1407: Error:
undefined symbol `.L99973' in operation setting `up_b_offset'
/home/balijepalli/omap4/ipipe-gch/arch/arm/kernel/entry-armv.S:1407: Error:
undefined symbol `.L99973' in operation setting `up_b_offset'
/home/balijepalli/omap4/ipipe-gch/arch/arm/kernel/entry-armv.S:1407: Error:
local label `"9997" (instance number 3 of a fb label)' is not defined
make[2]: *** [arch/arm/kernel/entry-armv.o] Error 1
make[1]: *** [arch/arm/kernel] Error 2
make: *** [sub-make] Error 2



Suresh balijepalli
Rosenehim,Baveria.

--20cf3079ba82cf078f04a63895fe
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear all,<div><br></div><div><br></div><div>i have downloa=
ded ipipe patched kernel from xenomai git .and applied the patches to the x=
enomai 2.5.6 sources as mentioned .</div><div><br></div><div>make ARCH=3Dar=
m CROSS_COMPILE=3Darm-none-linux-gnueabi- O=3D../build omap2plus_defconfig<=
/div>

<div>make ARCH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi- O=3D../build m=
enuconfig</div><div><br></div><div>i just removed all the other boards from=
 TI except Pandaboard. I did not touched any other options.=A0</div>
<div><br></div><div>then I run the command</div><div><br></div><div>make AR=
CH=3Darm CROSS_COMPILE=3Darm-none-linux-gnueabi- O=3D../build uImage</div><=
div><br></div>
<div>then it giving me the error as below</div><div><br></div><div><div>tes=
t06:/home/balijepalli/omap4/ipipe-gch# make ARCH=3Darm CROSS_COMPILE=3Darm-=
none-linux-gnueabi- O=3D/home/balijepalli/omap4/build uImage</div>
<div>=A0=A0GEN =A0 =A0 /home/balijepalli/omap4/build/Makefile</div><div>scr=
ipts/kconfig/conf --silentoldconfig Kconfig</div><div>=A0=A0Using /home/bal=
ijepalli/omap4/ipipe-gch as source for kernel</div><div>=A0=A0GEN =A0 =A0 /=
home/balijepalli/omap4/build/Makefile</div>

<div>=A0=A0CHK =A0 =A0 include/linux/version.h</div><div>=A0=A0CHK =A0 =A0 =
include/generated/utsrelease.h</div><div>make[2]: `include/generated/mach-t=
ypes.h&#39; is up to date.</div><div>=A0=A0CC =A0 =A0 =A0arch/arm/kernel/as=
m-offsets.s</div><div>

=A0=A0GEN =A0 =A0 include/generated/asm-offsets.h</div><div>=A0=A0CALL =A0 =
=A0/home/balijepalli/omap4/ipipe-gch/scripts/checksyscalls.sh</div><div>=A0=
=A0CC =A0 =A0 =A0init/main.o</div><div>=A0=A0CHK =A0 =A0 include/generated/=
compile.h</div><div>=A0=A0CC =A0 =A0 =A0init/version.o</div>

<div>=A0=A0CC =A0 =A0 =A0init/do_mounts.o</div><div>=A0=A0CC =A0 =A0 =A0ini=
t/do_mounts_rd.o</div><div>=A0=A0CC =A0 =A0 =A0init/do_mounts_initrd.o</div=
><div>=A0=A0LD =A0 =A0 =A0init/mounts.o</div><div>=A0=A0CC =A0 =A0 =A0init/=
initramfs.o</div><div>=A0=A0CC =A0 =A0 =A0init/calibrate.o</div>

<div>=A0=A0LD =A0 =A0 =A0init/built-in.o</div><div>=A0=A0CC =A0 =A0 =A0arch=
/arm/nwfpe/fpa11_cpdt.o</div><div>=A0=A0CC =A0 =A0 =A0arch/arm/nwfpe/fpmodu=
le.o</div><div>=A0=A0AS =A0 =A0 =A0arch/arm/nwfpe/entry.o</div><div>=A0=A0L=
D =A0 =A0 =A0arch/arm/nwfpe/nwfpe.o</div><div>

=A0=A0LD =A0 =A0 =A0arch/arm/nwfpe/built-in.o</div><div>=A0=A0CC =A0 =A0 =
=A0arch/arm/vfp/vfpmodule.o</div><div>=A0=A0AS =A0 =A0 =A0arch/arm/vfp/entr=
y.o</div><div>=A0=A0AS =A0 =A0 =A0arch/arm/vfp/vfphw.o</div><div>=A0=A0CC =
=A0 =A0 =A0arch/arm/vfp/vfpsingle.o</div><div>=A0=A0CC =A0 =A0 =A0arch/arm/=
vfp/vfpdouble.o</div>

<div>=A0=A0LD =A0 =A0 =A0arch/arm/vfp/vfp.o</div><div>=A0=A0LD =A0 =A0 =A0a=
rch/arm/vfp/built-in.o</div><div>=A0=A0CC =A0 =A0 =A0arch/arm/kernel/elf.o<=
/div><div>=A0=A0AS =A0 =A0 =A0arch/arm/kernel/entry-armv.o</div><div>/<font=
 color=3D"#FF0000">home/balijepalli/omap4/ipipe-gch/arch/arm/kernel/entry-a=
rmv.S: Assembler messages:</font></div>

<div><font color=3D"#FF0000">/home/balijepalli/omap4/ipipe-gch/arch/arm/ker=
nel/entry-armv.S:1407: Error: undefined symbol `.L99973&#39; in operation s=
etting `up_b_offset&#39;</font></div><div><font color=3D"#FF0000">/home/bal=
ijepalli/omap4/ipipe-gch/arch/arm/kernel/entry-armv.S:1407: Error: undefine=
d symbol `.L99973&#39; in operation setting `up_b_offset&#39;</font></div>

<div><font color=3D"#FF0000">/home/balijepalli/omap4/ipipe-gch/arch/arm/ker=
nel/entry-armv.S:1407: Error: local label `&quot;9997&quot; (instance numbe=
r 3 of a fb label)&#39; is not defined</font></div>
<div><font color=3D"#FF0000">make[2]: *** [arch/arm/kernel/entry-armv.o] Er=
ror 1</font></div><div><font color=3D"#FF0000">make[1]: *** [arch/arm/kerne=
l] Error 2</font></div><div>
<font color=3D"#FF0000">make: *** [sub-make] Error 2</font></div><div><br><=
/div><div><br></div><br>Suresh balijepalli<br>Rosenehim,Baveria.<br>
</div></div>

--20cf3079ba82cf078f04a63895fe--

