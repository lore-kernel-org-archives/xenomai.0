MIME-Version: 1.0
Date: Wed, 5 May 2010 10:38:50 +0800
Message-ID: <n2k633455b31005041938k29ad6c0br4e8092c19232ed68@domain.hid>
From: Everett Wang <everteq@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] install xenomai for beagleboard
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

Hi All,

I am new to xenomai and trying to install xenomai for my beagleboard,
using a Ubuntu 10.04 laptop computer. I have
downloaded xenomai 2.5.2 and plain linux kernel 2.6.30.5 from
www.kernal.org, installed cross compiler
arm-2009q1-203-arm-none-linux-gnueabi. Following the instruction in
REAM.INSTALL, I linked my linux-2.6.30.5 to /usr/src/linux and
xenomai-2.5.2 to /usr/xenomai.

I managed to patch my linux kernel fine:
everett@domain.hid$ scripts/prepare-kernel.sh
--arch=arm --adeos=/usr/xenomai/ksrc/arch/arm/patches/adeos-ipipe-2.6.30-arm-*
--linux=/usr/src/linux

and configured my kernel
cd /rtos/linux-2.6.30.5
root@domain.hid#  make ARCH=arm
CROSS_COMPILE=arm-none-linux-gnueabi- O=$build_root
omap3_beagle_defconfig

then compile kernel and modules
root@domain.hid#  make ARCH=arm
CROSS_COMPILE=arm-none-linux-gnueabi- O=$build_root bzImage modules

It runs fine. But I have some random questions.

where is the bzImage it made and modules I just made? Should I use a
newer version of Code Sourcery's cross compiler? I am using
arm-2009q1-203-arm-none-linux-gnueabi and there is an
arm-2010q1-202-arm-none-linux-gnueabi. I have difficult to follow
in compiling xenomai. The instruction reads:

"cd $build_root
$ $xenomai_root/configure --build=i686-pc-linux-gnu --host=arm-linux
--enable-arm-mach=at91rm9200 --enable-arm-tsc"

I have not defined a $build_root directory and what is the right name
to replace at91rm9200 and tsc?


Thanks in advance,

Everett

