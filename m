Message-ID: <4F96F53C.2070204@domain.hid>
Date: Tue, 24 Apr 2012 14:47:24 -0400
From: Andrew Tannenbaum <trb@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] rtcan I/O hang bug with /proc/rtcan/rtcan0/registers
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

I'm running

	Linux 2.6.38.8
	Xenomai 2.6.0
	Atom N270 CPU

I'm talking to CAN with a PEAK PCI SJA1000 CAN adapter.

I have a control loop running at 200 Hz, and I use it to drive a motor
and read an encoder using rtcan.  My code is based on the
rtcansend/rtcanrecv examples.

I found a bug where my control loop was hanging, and I've isolated the
problem so that it may be reproduced with Xenomai supplied tools,
without using my own code.

The problem is:

When I have a loop that is sending CAN packets, if I read
/proc/rtcan/rtcan0/registers at the same time, it causes the loop to
hang.  The hang is in rt_dev_sendto.

To reproduce:

Configure the CAN controller

	$ rtcanconfig rtcan0 --baudrate=1000000 start

Send packets, in this case, SYNC messages at 1000 Hz
with tty output 1 Hz.

	$ rtcansend rtcan0 -i 0x80 -p 1000 -l 1000000

It will print CAN SYNC (0x80) messages:

	<0x080> [0]
	<0x080> [0]
	...

In another window, read rtcan0/registers in a loop (10 Hz):

	$ while :; do cat /proc/rtcan/rtcan0/registers; sleep .1; done

After a few seconds or a minute, the rtcansend window will stop printing
SYNC messages, because it is hung.

gdb stack trace from hung rtcansend:

	(gdb) bt
	#0  0xb7862813 in rt_dev_sendmsg (fd=0, msg=0xbfe4d3ec, flags=0) at
core.c:84
	#1  0x08048b9b in rt_dev_sendto () at ../../../include/rtdm/rtdm.h:359
	#2  rt_task () at rtcansend.c:89
	#3  0x080492d3 in main (argc=8, argv=0xbfe4d654) at rtcansend.c:301

This example uses a (default) 1000 Hz rtcansend loop and a 10 Hz cat
from /proc, but in my code I found it with a 200 Hz rtcan I/O loop and a
/usr/bin/watch script that was running at .5 Hz (but it took longer to
reproduce the bug).

I think I see that the rtcan0/registers are read in:

	ksrc/drivers/can/sja1000/rtcan_sja1000_proc.c:rtcan_sja_proc_regs()

but I don't understand the details enough to debug further.

For debugging convenience, I found that if I ^C out of the rtcansend and
try to rerun it, the rtcan0 I/O will still be hung, but if I rerun the
rtcanconfig command above, that will unhang the I/O.  Of course, that's
not a workable fix.

I found this problem by running my CAN I/O app while running a "canstat"
shell script from a "watch" command.  The canstat script looks like this:

	#! /bin/bash

	pcat() {
		for i in $*
		do
			echo "###" $i
			cat $i
			echo
		done
	}
	cd /proc/rtcan
	pcat version devices sockets rtcan0/filters rtcan0/registers

	echo "### rtps"
	rtps

This script cats a bunch of data from /proc/rtcan/ but I believe the
rtcan0/registers data is the only part that causes the rt_dev_sendto to
hang.

-Andy

