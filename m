MIME-Version: 1.0
From: Nitin Kulkarni <nitin.kulkarni@mindmusiclabs.com>
Date: Wed, 14 Aug 2019 13:34:26 +0200
Message-ID: <CAPgPmP3hBAu-sghDSSf5wavnknnwkBZ7tz4XzoEF1arUrOPR=g@mail.gmail.com>
Subject: Spitest with xeno_spi rtdm driver locks up on raspberry PI 3
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I just want to know has anyone successfully used spi rtdm driver on a
raspberry pi 3 ?
Because I am trying to use the spi rtdm driver on bcm2837 soc (Raspbery pi
3 B+ model)
It seems like the spi rtdm locks up.

When the driver is loaded I see the device is setup correctly:
[  168.556792] spi-bcm2835 3f204000.spi: bcm2835_spi_probe: entered
Aug 14 13:03:06 raspberrypi kernel: [  168.592569] rtdm_spi_device spi0.0:
using GPIO8 for CS0

When I run the spitest standalone from the smokey test suite using the
below command
 spitest --run=0 device=/dev/rtdm/spi0/slave0.0 speed=10000
[  890.847619] spi0 slave0.0: mapping created
Aug 14 12:56:27 raspberrypi kernel: [  890.848112] configured mode 0, 8
bits/w, 10000 Hz max

The system locks up and after a while the watch dog kicks in to dump this:
[ 1084.021563] watchdog: BUG: soft lockup - CPU#1 stuck for 22s!
[migration/1:15]
[ 1084.021572] watchdog: BUG: soft lockup - CPU#2 stuck for 22s!
[migration/2:21]
[ 1084.021627] Modules linked in: xeno_spi_bcm2835 xeno_spi brcmfmac
brcmutil cfg80211 rfkill i2c_bcm2835 uio_pdrv_genirq fixed uio ip_tables
x_tables ipv6
...

I changed the rtdm interrupt handler in spi-bcm2835.c to a normal non
real-time linux interrupt and it seems to work fine !
I suspect the rtdm interrupt in the driver is not working.

It would be great if some one can verify or debunk my theory if they have
EVER successfully used this driver on a RPI 3 machine.

My machine specs:
RPI 3 B+
Kernel version: Linux raspberrypi 4.14.85-v7+ (Raspbian distro with I-pipe
patch)
Xenomai ver 3.0.8

Thank you
Nitin
