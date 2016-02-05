From: Elmar Grom <elmar@grom.net>
Message-ID: <56B4228F.7040704@grom.net>
Date: Thu, 4 Feb 2016 20:18:23 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] Raspberry Pi 2 - again
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

Gilles,

thanks again for pointing out my tyo screwup. I fixed that and tried 
again, but
still no luck. Below is what happens now. This does not look like an actual
error, just some not so clean coding, hiding a potential error. I also saw a
questionable type cast warning zip by at some point.

For the time being it might be just a matter of treating this as a 
warning, not
as an error. Since I have absolutely no insight into the make 
infrastructure of
this project and what compiler switches are on or off at any given 
point, can
you suggest a course of action?

The updated script is below again for reference.

Elmar

...
   LD      drivers/clk/built-in.o
   CC      drivers/clocksource/clksrc-of.o
   CC      drivers/clocksource/arm_arch_timer.o
../drivers/clocksource/arm_arch_timer.c: In function ‘timer_handler’:
../drivers/clocksource/arm_arch_timer.c:190:3: error: implicit 
declaration of
function ‘__ipipe_tsc_update’ [-Werror=implicit-function-declaration]
    __ipipe_tsc_update();
    ^
../drivers/clocksource/arm_arch_timer.c: In function 
‘arch_counter_register’:
../drivers/clocksource/arm_arch_timer.c:538:2: error: implicit 
declaration of
function ‘__ipipe_tsc_register’ [-Werror=implicit-function-declaration]
   __ipipe_tsc_register(&tsc_info);
   ^
cc1: some warnings being treated as errors
make[3]: *** [drivers/clocksource/arm_arch_timer.o] Error 1
make[2]: *** [drivers/clocksource] Error 2
make[1]: *** [drivers] Error 2
make[1]: Leaving directory `~/raspi/linux/build'
make: *** [sub-make] Error 2
failed to compile


--- script ---

#!/bin/bash

# builds the Xenomai kernel

# create the build directory
echo
echo making build directory...
mkdir -p ~/raspi/linux/build/linux
if test $? -gt 0
then
	echo failed making build directory
	exit
fi

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
	echo failed to bootstrap the Xenomai tree
	exit
fi

# running the prepare script
echo
echo preparing...
~/raspi/xenomai-3/scripts/prepare-kernel.sh --arch=arm 
--linux=~/raspi/linux \
--ipipe=~/raspi/xenomai-3/kernel/cobalt/arch/arm/patches/ipipe-core-3.18.20 
\
-arm-6.patch
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

# run the kernel configuration
echo
echo configuring...
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=~/raspi/linux/build 
bcm2709_defconfig
if test $? -gt 0
then
	echo failed configuration
	exit
fi

# finally compile
echo
echo building...
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- O=~/raspi/linux/build \
bzImage modules
if test $? -gt 0
then
	echo failed to compile
	exit
fi




