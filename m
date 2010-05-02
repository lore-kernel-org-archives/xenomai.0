MIME-Version: 1.0
Date: Sun, 2 May 2010 11:14:11 +0200
Message-ID: <z2t634720cc1005020214n3ce3543dhf272c998fb9ed48d@domain.hid>
From: Gildas Bayard <gildas.bayard@domain.hid>
Content-Type: multipart/alternative; boundary=00151747847044c363048598e606
Subject: [Xenomai-help] User space build problems with Xeno 2.5.2 and ARM
	integrator
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

--00151747847044c363048598e606
Content-Type: text/plain; charset=ISO-8859-1

Hello,

For training purpose I'm setting up embedded and real time linux on a qemu
emulated arm integrator board. I understand I can't demonstrate latency
performance on an emulator, yet I can teach my students about all the tools
and steps involved to build a running embedded linux system.

I'm using buildroot-2010.02 (stable) to get a cross compilation tool chain
and an arm file system. After tweaking the kernel I can get the kernel and
file system to work fine (qemu-system-arm -M integratorcp -kernel zImage
-initrd rootfs.arm.ext2 -append 'console=tty1 root=/dev/ram0')

Then I'm trying to get xenomai working.
I did not encounter any pb as far as the kernel side is concerned but I run
into several pbs on the user side.
* configure
To configure I use:
./configure --host=arm-linux --enable-arm-mach=integrator
--enable-arm-arch=5

This first failed with
configure: error: C compiler cannot create executables
The pb comes from the fact that some object necessary for the compile
process (crt1.o) is not found. So I set CFLAGS and LDFLAGS to
--sysroot=/path/to/arm-linux-binaries and ran configure again.

Then it failed with
checking for ARM architecture version... configure: error: Invalid
architecture choose, only 4, 5, xscale3, 6 and 7 are supported
It seems like a bug to me since the arch I specify is not taken into
account. So I changed line 11767 of configure from "case "$arch" in" to
"case "$enable_arm_arch" in" and configure runs smoothly

* make
Then I type make and compilation starts. .c files are compiled smootly into
.o files but it fails on first shared object creation with
/bin/bash ../../libtool --tag=CC   --mode=link arm-linux-gcc
--sysroot=/home/gbayard/MI03_2010/TP/buildroot-2010.02/output/staging
-version-info 0:0:0 -lpthread -lrt
--sysroot=/home/gbayard/MI03_2010/TP/buildroot-2010.02/output/staging -o
librtdk.la -rpath /usr/xenomai/lib librtdk_la-init.lo librtdk_la-rt_print.lo
librtdk_la-assert_context.lo librtdk_la-wrappers.lo
libtool: link: arm-linux-gcc -shared  .libs/librtdk_la-init.o
.libs/librtdk_la-rt_print.o .libs/librtdk_la-assert_context.o
.libs/librtdk_la-wrappers.o   -lpthread -lrt    -Wl,-soname -Wl,librtdk.so.0
-o .libs/librtdk.so.0.0.0
/home/gbayard/MI03_2010/TP/buildroot-2010.02/output/staging/usr/bin/../lib/gcc/arm-linux-uclibcgnueabi/4.3.4/../../../../arm-linux-uclibcgnueabi/bin/ld:
crti.o: No such file: No such file or directory
libtool is given the --sysroot parameter but decides to ignore it... If I
manually add it to the arm-linux-gcc command it works well. This seems to me
like a libtool problem.
To go around this problem I looked into libtool file and changed line 260
from "CC="arm-linux-gcc"" to "CC="arm-linux-gcc
--sysroot=/home/gbayard/MI03_2010/TP/buildroot-2010.02/output/staging "". As
ugly as it is it worked (but I've got a lot of "sem_heap.c:1: warning:
target CPU does not support interworking")

Compilation goes on but fails to compile every testsuite binaries (except
latency) with
../../skins/posix/.libs/libpthread_rt.so: undefined reference to `mmap64'
../../skins/posix/.libs/libpthread_rt.so: undefined reference to
`ftruncate64'
There might be a problem with my PC system which runs x86_64 linux.

Here I am. Xenomai is sort of built but it's not clean so I probably did
mistakes on the way. Could you guys tell me what is wrong in my build steps?

Best regards,
Gildas

--00151747847044c363048598e606
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>For training purpose I&#39;m setting up embedded and real tim=
e linux on a qemu emulated arm integrator board. I understand I can&#39;t d=
emonstrate latency performance on an emulator, yet I can teach my students =
about all the tools and steps involved to build a running embedded linux sy=
stem.<br>
<br>I&#39;m using buildroot-2010.02 (stable) to get a cross compilation too=
l chain and an arm file system. After tweaking the kernel I can get the ker=
nel and file system to work fine (qemu-system-arm -M integratorcp -kernel z=
Image -initrd rootfs.arm.ext2 -append &#39;console=3Dtty1 root=3D/dev/ram0&=
#39;)<br>
<br>Then I&#39;m trying to get xenomai working.<br>I did not encounter any =
pb as far as the kernel side is concerned but I run into several pbs on the=
 user side.<br>* configure<br>To configure I use:<br>./configure --host=3Da=
rm-linux --enable-arm-mach=3Dintegrator --enable-arm-arch=3D5<br>
<br>This first failed with<br><div style=3D"margin-left: 40px;">configure: =
error: C compiler cannot create executables<br></div>The pb comes from the =
fact that some object necessary for the compile process (crt1.o) is not fou=
nd. So I set CFLAGS and LDFLAGS to --sysroot=3D/path/to/arm-linux-binaries =
and ran configure again.<br>
<br>Then it failed with <br><div style=3D"margin-left: 40px;">checking for =
ARM architecture version... configure: error: Invalid architecture choose, =
only 4, 5, xscale3, 6 and 7 are supported<br></div>It seems like a bug to m=
e since the arch I specify is not taken into account. So I changed line 117=
67 of configure from &quot;case &quot;$arch&quot; in&quot; to &quot;case &q=
uot;$enable_arm_arch&quot; in&quot; and configure runs smoothly<br>
<br>* make<br>Then I type make and compilation starts. .c files are compile=
d smootly into .o files but it fails on first shared object creation with<b=
r><div style=3D"margin-left: 40px;">/bin/bash ../../libtool --tag=3DCC=A0=
=A0 --mode=3Dlink arm-linux-gcc=A0 --sysroot=3D/home/gbayard/MI03_2010/TP/b=
uildroot-2010.02/output/staging -version-info 0:0:0 -lpthread -lrt --sysroo=
t=3D/home/gbayard/MI03_2010/TP/buildroot-2010.02/output/staging -o <a href=
=3D"http://librtdk.la">librtdk.la</a> -rpath /usr/xenomai/lib librtdk_la-in=
it.lo librtdk_la-rt_print.lo librtdk_la-assert_context.lo librtdk_la-wrappe=
rs.lo=A0 <br>
</div><div style=3D"margin-left: 40px;">libtool: link: arm-linux-gcc -share=
d=A0 .libs/librtdk_la-init.o .libs/librtdk_la-rt_print.o .libs/librtdk_la-a=
ssert_context.o .libs/librtdk_la-wrappers.o=A0=A0 -lpthread -lrt=A0=A0=A0 -=
Wl,-soname -Wl,librtdk.so.0 -o .libs/librtdk.so.0.0.0<br>
</div><div style=3D"margin-left: 40px;">/home/gbayard/MI03_2010/TP/buildroo=
t-2010.02/output/staging/usr/bin/../lib/gcc/arm-linux-uclibcgnueabi/4.3.4/.=
./../../../arm-linux-uclibcgnueabi/bin/ld: crti.o: No such file: No such fi=
le or directory<br>
</div>libtool is given the --sysroot parameter but decides to ignore it... =
If I manually add it to the arm-linux-gcc command it works well. This seems=
 to me like a libtool problem.<br>To go around this problem I looked into l=
ibtool file and changed line 260 from &quot;CC=3D&quot;arm-linux-gcc&quot;&=
quot; to &quot;CC=3D&quot;arm-linux-gcc --sysroot=3D/home/gbayard/MI03_2010=
/TP/buildroot-2010.02/output/staging &quot;&quot;. As ugly as it is it work=
ed (but I&#39;ve got a lot of &quot;sem_heap.c:1: warning: target CPU does =
not support interworking&quot;)<br>
=A0<br>Compilation goes on but fails to compile every testsuite binaries (e=
xcept latency) with<br><div style=3D"margin-left: 40px;">../../skins/posix/=
.libs/libpthread_rt.so: undefined reference to `mmap64&#39;<br>../../skins/=
posix/.libs/libpthread_rt.so: undefined reference to `ftruncate64&#39;<br>
</div>There might be a problem with my PC system which runs x86_64 linux.<b=
r><br>Here I am. Xenomai is sort of built but it&#39;s not clean so I proba=
bly did mistakes on the way. Could you guys tell me what is wrong in my bui=
ld steps?<br>
<br>Best regards,<br>Gildas<br>

--00151747847044c363048598e606--

