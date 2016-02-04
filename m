From: Elmar Grom <elmar@grom.net>
Message-ID: <56B2D4A7.9080801@grom.net>
Date: Wed, 3 Feb 2016 20:33:43 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] Trouble cross compiling Xenomai for Raspberry Pi
Reply-To: elmar@grom.net
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I had a bit of a rough time trying to build Xenomai but managed to get all
issues worked out and put together a shell script going by Gilles 
suggestion.
This is based on Sources on the Xenomai website and should be correct, 
as far I
can make out. I am pasting the script below for reference of what I am 
doing.
The paths are based on my arrangement with the linux tree residing in
~/raspi/linux and the Xenomai tree residing in ~/raspi/xenomai-3. The script
itself is launched from ~/raspi though that shouldn't really be relevant.

I am cross compiling for a Raspberry Pi 2 on an Intel based Ubuntu 
machine. I
got the two sources in this way:

git clone -b 'rpi-3.18.y' http://github.com/raspberrypi/linux
git clone git://git.xenomai.org/xenomai-3.git

All steps in the script seem to work, except for the last one as it does 
not
manage to actually compile. Eventually the compile ends with a bunch of
messages about errors in command line arguments. Any ideas what I might be
doing wrong would be much appreciated.


Here is the end of the compile:

...
(cat /dev/null; ) > modules.order
mkdir -p kernel/
   gcc -Wp,-MD,kernel/.bounds.s.d  -nostdinc -isystem 
/usr/lib/gcc/x86_64-linux-gnu/4.8/include -I../arch/arm/include 
-Iarch/arm/include/generated  -I../include -Iinclude 
-I../arch/arm/include/uapi -Iarch/arm/include/generated/uapi 
-I../include/uapi -Iinclude/generated/uapi -include 
../include/linux/kconfig.h  -I../. -I. -D__KERNEL__ -mlittle-endian 
-I../../arch/arm/mach-bcm2709/include -I../arch/arm/mach-bcm2709/include 
-Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing 
-fno-common -Werror-implicit-function-declaration -Wno-format-security 
-std=gnu89 -fno-dwarf2-cfi-asm -fno-omit-frame-pointer -mapcs 
-mno-sched-prolog -mabi=aapcs-linux -mno-thumb-interwork -mfpu=vfp 
-funwind-tables -D__LINUX_ARM_ARCH__=7 -march=armv5t -Wa,-march=armv7-a 
-msoft-float -Uarm  -I../arch/arm/xenomai/include 
-Iarch/arm/xenomai/include  -I../include/xenomai -Iinclude/xenomai -O2 
-fno-omit-frame-pointer -fno-optimize-sibling-calls -pg 
-DCC_HAVE_ASM_GOTO    -D"KBUILD_STR(s)=#s" 
-D"KBUILD_BASENAME=KBUILD_STR(bounds)" 
-D"KBUILD_MODNAME=KBUILD_STR(bounds)"  -fverbose-asm -S -o 
kernel/bounds.s ../kernel/bounds.c
gcc: error: unrecognized argument in option ‘-mabi=aapcs-linux’
gcc: note: valid arguments to ‘-mabi=’ are: ms sysv
gcc: error: unrecognized command line option ‘-mlittle-endian’
gcc: error: unrecognized command line option ‘-mapcs’
gcc: error: unrecognized command line option ‘-mno-sched-prolog’
gcc: error: unrecognized command line option ‘-mno-thumb-interwork’
gcc: error: unrecognized command line option ‘-mfpu=vfp’
make[3]: *** [kernel/bounds.s] Error 1
make[2]: *** [prepare0] Error 2
make[1]: *** [sub-make] Error 2
make: *** [__sub-make] Error 2


Shell script:

#!/bin/bash

# builds the Xenomai kernel

# switch to the Xenomai tree
echo entering ~/raspi/xenomai-3
cd ~/raspi/xenomai-3
if test $? -gt 0
then
	echo failed switching to Xenomai tree
	exit
fi

# running the bootstrap script
echo
echo running bootstrap...
scripts/bootstrap
if test $? -gt 0
then
	echo >> failed to bootstrap the Xenomai tree
	exit
fi

# running the prepare script
echo
echo preparing...
scripts/prepare-kernel.sh --arch=arm --linux=~/raspi/linux \
--ipipe=~/raspi/xenomai-3/kernel/cobalt/arch/arm/patches/ipipe-core-3.18.20-\
arm-6.patch
if test $? -gt 0
then
	echo failed to prepare Xenomai kernel
	exit
fi

# configure Xenomai
echo
echo configuring...
./configure
if test $? -gt 0
then
	echo failed to configure Xenomai
	exit
fi

# switch to the linux tree
echo
echo entering ~/raspi/linux
cd ~/raspi/linux
if test $? -gt 0
then
	echo failed switching to linux tree
	exit
fi

echo
echo making build directory...
mkdir -p build
if test $? -gt 0
then
	echo failed making build directory
	exit
fi

# switch to the linux build tree
echo
echo entering ~/raspi/linux/build
cd ~/raspi/linux/build
if test $? -gt 0
then
	echo failed switching to build tree
	exit
fi

echo
echo configuring...
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=~/raspi/linux/build 
bcm2709_defconfig
if test $? -gt 0
then
	echo failed configuration
	exit
fi

echo
echo building...
make ARCH=arm ROSS_COMPILE=arm-linux-gnueabihf- O=build/linux bzImage 
modules
if test $? -gt 0
then
	echo failed to compile
	exit
fi





