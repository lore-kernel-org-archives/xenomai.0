From: Peter Feuerer <peter.feuerer@domain.hid>
Content-Type: text/plain
Date: Tue, 22 May 2007 14:48:26 +0200
Message-Id: <1179838106.6050.46.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] ppc crosscompilation, missing headers
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

Hi all,

I'm trying to crosscompile xenomai 2.3.1 for the ppc-architecture. 
My commands are like this:  (using latest denx ELDK)

export ARCH=ppc
export CROSS_COMPILE=ppc_8xx-

scripts/prepare-kernel.sh --arch=ppc
--linux=/home/piie/toolchains/ppc-4.1/ppc_8xx/usr/src/linux/
--adeos=ksrc/arch/powerpc/patches/adeos-ipipe-2.6.18-ppc-1.5-01.patch

cd bla/usr/src/linux/
make TQM8260_defconfig
make menuconfig
make uImage

Everything is working so far and the kernel with built in xenomai boots
flawless. (dmesg reports xenomai is working)

When trying to crosscompile the xenomai libs and so on, the configure
step is working correctly.

./configure -host=ppc-linux

But the make fails because of missing headers:
[..]
 error: asm/errno.h: No such file or directory
[..]
 error: asm/param.h: No such file or directory
[..]

I took a look at the kernel/include/asm-ppc/ folder and actually these
headers are missing. But they do exist for the "powerpc" architecture.
So I just copied all missing headers from asm-powerpc/ to asm-ppc/ to
try if the xenomai userspace things can be compiled. It worked. But I
think that is not the way it has to be done.
Does anybody know why these headers are missing in asm-ppc? Do I have to
install some kind of BSP-kernel-patch for my specific board? Why are
these headers available for powerpc?

And btw, maybe someone of you knows, why are there 2 architectures for
the powerpc architecture in the kernel tree?

thanks for your help,
--peter


