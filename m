Message-ID: <5097F3BE.8070709@gmail.com>
Date: Mon, 05 Nov 2012 17:13:34 +0000
From: Stefan Videv <videvstefan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Cross-compiling RTDM driver errors
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I am trying to cross compile a driver that I wrote which is very similar 
to the one provided in the examples (tut02-skeleton-drv). I've basically 
changed the write function to do what I am interested in doing, 
everything else is the same (however I am not providing a read function).

During compilation I get the following error:

FATAL: modpost: GPL-incompatible module vlcTxDriver.ko uses GPL-only 
symbol 'rtdm_dev_unregister'

What's that supposed to mean, and how do you get around it?

I am using the Makefile provided with the examples and compiling like so:

make XENO=/media/rootfs/usr/xenomai/ ARCH=arm 
CROSS_COMPILE=arm-linux-gnueabi- KSRC=~/beagle/linux/ 
DESTDIR=/media/rootfs ADD_CFLAGS=-I/usr/arm-linux-gnueabi/include


Thanks!

-- Stefan

