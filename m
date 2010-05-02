Message-ID: <4BDD4796.209@domain.hid>
Date: Sun, 02 May 2010 11:36:22 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <z2t634720cc1005020214n3ce3543dhf272c998fb9ed48d@domain.hid>
In-Reply-To: <z2t634720cc1005020214n3ce3543dhf272c998fb9ed48d@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] User space build problems with Xeno 2.5.2 and
 ARM	integrator
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gildas Bayard <gildas.bayard@domain.hid>
Cc: xenomai@xenomai.org

Gildas Bayard wrote:
> Hello,
> 
> For training purpose I'm setting up embedded and real time linux on a
> qemu emulated arm integrator board. I understand I can't demonstrate
> latency performance on an emulator, yet I can teach my students about
> all the tools and steps involved to build a running embedded linux system.
> 
> I'm using buildroot-2010.02 (stable) to get a cross compilation tool
> chain and an arm file system. After tweaking the kernel I can get the
> kernel and file system to work fine (qemu-system-arm -M integratorcp
> -kernel zImage -initrd rootfs.arm.ext2 -append 'console=tty1
> root=/dev/ram0')
> 
> Then I'm trying to get xenomai working.
> I did not encounter any pb as far as the kernel side is concerned but I
> run into several pbs on the user side.
> * configure
> To configure I use:
> ./configure --host=arm-linux --enable-arm-mach=integrator
> --enable-arm-arch=5
> 
> This first failed with
> configure: error: C compiler cannot create executables
> The pb comes from the fact that some object necessary for the compile
> process (crt1.o) is not found. So I set CFLAGS and LDFLAGS to
> --sysroot=/path/to/arm-linux-binaries and ran configure again.

You probably want to pass CC="arm-linux-gcc --sysroot=whatever" on
configure command line instead (and not as an environment variable). Like:

/path/xenomai/sources/configure \
	--host=arm-linux \
	--enable-arm-mach=integrator \
	--enable-arm-arch=5 \
	CC="arm-lnux-gcc --sysroot=whatever"

Note that the necessity to pass the --sysroot arguments shows that your
toolchain is not properly installed.
If you used an off-the-shelf toolchain, such as one obtained with
crosstool-ng, the codesourcery toolchain, or one of the Denx ELDK
toolchains, you would not have this issue.

Also note that buildroot 2010.02 is able to work with external
toolchains (actually, from the three solutions mentioned above, only a
toolchain made with crosstool-ng will work as an external toolchain for
buildroot 2010.02, as far as I remember, support for the crosstool
toolchain was going to be added, I was told).

> 
> Then it failed with
> checking for ARM architecture version... configure: error: Invalid
> architecture choose, only 4, 5, xscale3, 6 and 7 are supported
> It seems like a bug to me since the arch I specify is not taken into
> account. So I changed line 11767 of configure from "case "$arch" in" to
> "case "$enable_arm_arch" in" and configure runs smoothly

Right, it should be case "$CONFIG_XENO_ARM_ARCH" in fact. Will fix.

> 
> * make
> Then I type make and compilation starts. .c files are compiled smootly
> into .o files but it fails on first shared object creation with
> /bin/bash ../../libtool --tag=CC   --mode=link arm-linux-gcc 
> --sysroot=/home/gbayard/MI03_2010/TP/buildroot-2010.02/output/staging
> -version-info 0:0:0 -lpthread -lrt
> --sysroot=/home/gbayard/MI03_2010/TP/buildroot-2010.02/output/staging -o
> librtdk.la <http://librtdk.la> -rpath /usr/xenomai/lib
> librtdk_la-init.lo librtdk_la-rt_print.lo librtdk_la-assert_context.lo
> librtdk_la-wrappers.lo 
> libtool: link: arm-linux-gcc -shared  .libs/librtdk_la-init.o
> .libs/librtdk_la-rt_print.o .libs/librtdk_la-assert_context.o
> .libs/librtdk_la-wrappers.o   -lpthread -lrt    -Wl,-soname
> -Wl,librtdk.so.0 -o .libs/librtdk.so.0.0.0
> /home/gbayard/MI03_2010/TP/buildroot-2010.02/output/staging/usr/bin/../lib/gcc/arm-linux-uclibcgnueabi/4.3.4/../../../../arm-linux-uclibcgnueabi/bin/ld:
> crti.o: No such file: No such file or directory
> libtool is given the --sysroot parameter but decides to ignore it... If
> I manually add it to the arm-linux-gcc command it works well. This seems
> to me like a libtool problem.
> To go around this problem I looked into libtool file and changed line
> 260 from "CC="arm-linux-gcc"" to "CC="arm-linux-gcc
> --sysroot=/home/gbayard/MI03_2010/TP/buildroot-2010.02/output/staging
> "". As ugly as it is it worked (but I've got a lot of "sem_heap.c:1:
> warning: target CPU does not support interworking")

If you had passed CC on configure command line, you would have avoided this.

>  
> Compilation goes on but fails to compile every testsuite binaries
> (except latency) with
> ../../skins/posix/.libs/libpthread_rt.so: undefined reference to `mmap64'
> ../../skins/posix/.libs/libpthread_rt.so: undefined reference to
> `ftruncate64'
> There might be a problem with my PC system which runs x86_64 linux.

No. Normally, configure performs a test to know whether these functions
are available from your libc. Either we have (yet another) issue with
uclibc, or an issue because configure was not run properly. Could you
try re-running configure passing the sysroot argument through the CC,
then show me configure output and send me the config.log file, or paste
it to a pastebin?

-- 
					    Gilles.

