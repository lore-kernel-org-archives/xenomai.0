Message-Id: <53C1B9A4-9035-4E75-8553-553E8F31EFCC@gmail.com>
From: Andreas Glatz <andi.glatz@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v936)
Date: Wed, 16 Apr 2014 11:06:11 +0100
Subject: [Xenomai] Linux 3.14 with Xenomai 2.6.3 on a Pandaboard
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This is a short summary how I got things working (thanks to Gilles).  
Those are merely guidlines which can obviously change as the 3.14  
ipipe git tree evolves.

In generally, I followed the steps in [1] which explain how to setup a  
Debian system with boot and rootfs on a SD card,  and how to use  
RobertCNelsons's build system to generate kernel debian packages. Here  
are the additional steps for including Xenomai 2.6.3:

1) Setup and patch kernel
 > BASEDIR=`pwd`
 > git clone git://github.com/RobertCNelson/armv7-multiplatform.git
 > cd ${BASEDIR}/armv7-multiplatform/
 > git checkout origin/v3.14.x -b v3.14
 > ./build_deb.sh # checks out the 3.14 kernel source and adds some  
patches
 > exit from 'make menuconfig' and Ctrl-C

2) Add Ipipe & Xenomai
 > cd ${BASEDIR}/armv7-multiplatform/KERNEL
 > git remote add ipipe git://http://git.xenomai.org/ipipe.git
 > git pull ipipe raw raw/ipipe-3.14.0 # requires a commit to the  
local git tree
 > ${XENODIR}/scripts/prepare-kernel.sh --arch=arm --linux=${BASEDIR}/ 
armv7-multiplatform/KERNEL --verbose
 > cp arch/arm/configs/omap2plus_defconfig .config # skip if you like  
Robert's config
 > patch -p1< 'patch at the bottom of this e-mail'

3) Configure & build
 > cd ${BASEDIR}/armv7-multiplatform
 > edit build_deb.sh and build_kernel.sh to unset FULL_REBUILD # was  
FULL_REBUILD=1 before
 > ./build_deb.sh or ./build_kernel.sh # configure the kernel with  
make menuconfig & start the build

4) Install the kernel assuming u have a working debian system  
(otherwise use ./build_kernel.sh and follow [1]):
 > cd ${BASEDIR}/armv7-multiplatform
 > scp * root@arm: # replace last string with your specific address
 > ssh root@arm # same here
 > dpkg -i <the deb packages we copied, one by one>
 > mkdir /tmp/dtbs
 > tar xfz 3.14.1-ipipe-armv7-x3-[...]-dirty-dtbs.tar.gz -C /tmp/dtbs
 > mkdir -p /boot/uboot/dtbs
 > cp  /tmp/dtbs/* /boot/uboot/dtbs
 > Repeat last steps with the firmware, which is e.g. needed to get  
wifi working

5) I also had to create boot.scr for u-boot to get the kernel to boot  
(alternatively modify/replace u-boot sources):
 > vi /tmp/boot.txt
 > add the following:
if run loadzimage; then
	run loadfdt;
	run mmcboot;
fi;
 > mkimage -A arm -O linux -T script -C none -n "U-Boot commands" -d / 
tmp/boot.txt  /boot/uboot/boot.scr

6) Test the system with the 3.14 kernel as described in [2].

On my pandaboard I get:

RTD|      0.110|      3.273|      7.189|       0|     0|      
-0.270|     17.819
RTD|           1|         966|    39578329
RTD|           0|       15303|   601212021
Load script terminated, terminating checked scripts
---| 
-----------| 
-----------|-----------|--------|------|-------------------------
RTS|     -0.270|      3.110|     17.819|       0|     0|     
11:48:37/11:48:37
RTD|           0|         923|    39549375
RTD|           0|        7821|   601219842
RTD|           1|       13255|   622109047
RTD|           1|         541|    39578870
pipe_in: /tmp/xeno-test-in-3689
root@arm:~# cat /proc/xenomai/timer
status=on 
+ 
watchdog:setup 
=205:clock=19910081911722:timerdev=local_timer:clockdev=ipipe_tsc

Good luck!

A.


[1] http://eewiki.net/display/linuxonarm/PandaBoard
[2] http://www.xenomai.org/pipermail/xenomai/2014-January/029772.html

---
diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index f46e4dd..152d4d2 100644
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -155,11 +155,11 @@ if grep -q '^CONFIG_MODULES=y' $KCONFIG_CONFIG ;  
then
                         for module in $(find lib/modules/ -name  
*.ko); do
                                 mkdir -p $(dirname $dbg_dir/usr/lib/ 
debug/$module)
                                 # only keep debug symbols in the  
debug file
-                               objcopy --only-keep-debug $module  
$dbg_dir/usr/lib/
+                               $OBJCOPY --only-keep-debug $module  
$dbg_dir/usr/lib
                                 # strip original module from debug  
symbols
-                               objcopy --strip-debug $module
+                               $OBJCOPY --strip-debug $module
                                 # then add a link to those
-                               objcopy --add-gnu-debuglink=$dbg_dir/ 
usr/lib/debug/
+                               $OBJCOPY --add-gnu-debuglink=$dbg_dir/ 
usr/lib/debug
                         done
                 )
         fi


