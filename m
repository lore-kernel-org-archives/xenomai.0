MIME-Version: 1.0
From: =?UTF-8?B?5byg56uL6ZGr?= <intelligentcodemail@gmail.com>
Date: Thu, 23 Jul 2015 23:29:29 +0800
Message-ID: <CAGFtc0Yj6yztoEUOBcM7Do5h2erYeX_2-Fcmd=4XrFxzc7JYFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] xenomai use for Raspberry Pi (ARM7) has error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

https://github.com/raspberrypi/linux

git reset --hard 43f497a2035f3d4a2f766d20827c68e0437cdd58

use
https://github.com/raspberrypi/linux/blob/rpi-3.18.y/arch/arm/configs/bcm27=
09_defconfig

$ export
PATH=3D$PATH:~/raspberrypi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf=
-raspbian/bin
$ export CCPI=3Darm-linux-gnueabihf-
$ KERNEL=3Dkernel7
$ mkdir build
$ make mrproper
$ make ARCH=3Darm O=3Dbuild CROSS_COMPILE=3D$CCPI bcm2709_defconfig
$ make ARCH=3Darm O=3Dbuild CROSS_COMPILE=3D$CCPI menuconfig

enabled ipipe

make -j 5 ARCH=3Darm O=3Dbuild CROSS_COMPILE=3D$CCPI

get this error

CC      arch/arm/mm/iomap.o
../arch/arm/kernel/smp.c: In function =E2=80=98ipi_timer=E2=80=99:
../arch/arm/kernel/smp.c:545:2: error: implicit declaration of function
=E2=80=98__ipipe_mach_update_tsc=E2=80=99 [-Werror=3Dimplicit-function-decl=
aration]
  __ipipe_mach_update_tsc();
  ^
cc1: some warnings being treated as errors
../scripts/Makefile.build:257: recipe for target 'arch/arm/kernel/smp.o'
failed
make[2]: *** [arch/arm/kernel/smp.o] Error 1
