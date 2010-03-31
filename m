From: Robert Berger <gmane@domain.hid>
Date: Wed, 31 Mar 2010 23:30:50 +0300
Message-ID: <hp0bdv$mp4$1@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] cyclictest -tn where n!=1 causes segfault with
	Kilauea
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

Hi,

I'm using a Kilauea board:

cat /proc/cpuinfo
processor       : 0
cpu             : 405EX
clock           : 533.333333MHz
revision        : 20.119 (pvr 1291 1477)
bogomips        : 1066.66
timebase        : 533333333
platform        : PowerPC 40x Platform
model           : amcc,kilauea
Memory          : 256 MB


The kernel is:

git clone git://git.denx.de/linux-2.6-denx.git
git checkout v2.6.33 -b v2.6.33_local

The adeos patch is:

wget
http://download.gna.org/adeos/patches/v2.6/powerpc/adeos-ipipe-2.6.33-powerpc-2.9-00.patch

xenomai is the latest and greatest:

git clone git://xenomai.org/xenomai-head

in the kernel dir:

make ARCH=powerpc CROSS_COMPILE=ppc_4xx- mrproper
make ARCH=powerpc CROSS_COMPILE=ppc_4xx- 40x/kilauea_defconfig

I'm patching the kernel:

export ADEOS_PATCH=adeos-ipipe-2.6.33-powerpc-2.9-00.patch

cd xenomai-head

./scripts/prepare-kernel.sh
--linux=$ELDK_PREFIX/eldk-4.2-ppc_4xx/usr/src/$KERNEL_DIR/ --arch=powe
rpc --adeos=../$ADEOS_PATCH

in the kernel dir:

make ARCH=powerpc CROSS_COMPILE=ppc_4xx- menuconfig

make ARCH=powerpc CROSS_COMPILE=ppc_4xx- uImage
EXTRAVERSION=$EXTRA_VERSION_INFO

make ARCH=powerpc CROSS_COMPILE=ppc_4xx- modules
EXTRAVERSION=$EXTRA_VERSION_INFO

make ARCH=powerpc CROSS_COMPILE=ppc_4xx-
INSTALL_MOD_PATH=$ELDK_PREFIX/eldk-4.2-ppc_4xx/ppc_4xx mo
dules_install

Build xenomai user-space support:

cd $ELDK_PREFIX/eldk-4.2-ppc_4xx/usr/src/xenomai-head

source $ELDK_PREFIX/eldk-4.2-ppc_4xx/eldk_init ppc_4xx

./configure --host=powerpc-linux --prefix=/usr/local/xenomai-head

make ARCH=powerpc CROSS_COMPILE=ppc_4xx-

make DESTDIR=$ELDK_PREFIX/eldk-4.2-ppc_4xx/ppc_4xx install

on the target:

cd /usr/local/xenomai-head/bin

./cyclictest -t2
Segmentation fault

./cyclictest -t3
Segmentation fault

./cyclictest -t4
Segmentation fault

only

./cyclictest -t1 does not give Segmentation fault

Please advise.

Regards,

Robert

-- 
Robert Berger
Embedded Software Specialist

Reliable Embedded Systems
Consulting Training Engineering
Tel.: (+30) 697 593 3428
Fax.:(+30) 210 684 7881
email: robert.berger@domain.hid
URL: http://www.reliableembeddedsystems.com


