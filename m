From: ken barnett <kbb@domain.hid>
Date: Thu, 16 Oct 2008 12:52:25 +0000 (UTC)
Message-ID: <loom.20081016T124807-588@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: news <news@domain.hid>
Subject: [Xenomai-help] Need some help getting past an
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

Hope you can help.

My configuration is as follows:
PXA25xx ADS card w/ NO PCI bridge
Linux-2.6.24.5 kernel
Xenomai 2.4.5 stable

The Xenomai port to the kernel is as follows:

./prepare-kernel.sh linux=../../linux-2.6.24.5
--adeos=adeos-ipipe-2.6.24-arm-1.9-00.patch
--adeos=adeos-ipipe-2.6.24-arm-1.9-01.patch --arch=arm

./xenomai-2.4.5/scripts/prepare-kernel.sh --linux=linux-2.6.24.5
--adeos=./xenomai-2.4.5/ksrc/arch/arm/patches/
adeos-ipipe-2.6.24-arm-1.9-01.patch

I used 2 patches  but have tried to use either/or with the 
same indications.

configure CC=arm-linux-gcc --enable-arm-eabi
--prefix=/home/dvdb-lite/rootfs/usr/xenomai --host=arm-linux 
--enable-arm-arch=pxa

See attached for the output log.

Step 1:
Looking at post from July 05, 2008 - 12:26: it states to turn on full debug to
get the best output so that output file is attached also as debug1.log

Step 2
Then it stated to turn off Xenomai all together:
The log looks the same but is also attached as debug2.log

Step 3
Turn off ipipe altogether
The kernel/card is back to working.

Hop you can help,
Thanks,
Ken




