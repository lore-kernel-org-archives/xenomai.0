From: Brandt Erickson <berickso@domain.hid>
Content-Type: text/plain
Date: Tue, 08 May 2007 11:34:49 -0600
Message-Id: <1178645689.7883.9.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] rtser not showing up
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
I'm trying to get realtime communication over the serial port to work
using the example found here

	http://www.captain.at/xenomai-serial-port-example.php

I compiled a 2.6.20-6 kernel with xenomai-2.3.1 and configure the
realtime serial driver to be a loadable module.  I disabled the default
linux serial driver using 'setserial'.  However, when I run

	modprobe xeno_16550A ioaddr=0x3f8 irq=4
or
	insmod ./xeno16550A.ko ioaddr=0x3f8 irq=4

no rtser<N> nodes turn up in /dev.  No errors are generated when I
insert the module and an lsmod reveals it is in.  Have I missed
something?  Thanks.
-Brandt



