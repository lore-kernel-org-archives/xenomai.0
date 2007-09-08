Message-ID: <1ce16a2c0709081159y62fbb73bwb16d2cae7a931774@domain.hid>
Date: Sat, 8 Sep 2007 20:59:25 +0200
From: "Bachman Kharazmi" <bahkha@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] serial module problems
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

Hi
I'm a new xenomai user and would like to get the serial module working.

I've 'builtin' serial support in my kernel, and tried to add a new
modified kernel line according to the docs which looks like:

kernel          /boot/maikern2 8250.nr_uarts=0
xeno_16550A.ioaddr=0x03f8,0xbc00,0xbc08,0xb800 xeno_16550A.irq=4,3,3,3
xeno_16550A.baud_base=115200,115200,115200,115200 root=/dev/hda3 ro

But when I boot my dmesg sais:
Kernel command line: 8250.nr_uarts=0
xeno_16550A.ioaddr=0x03f8,0xbc00,0xbc08,0xb800 xeno_16550A.irq=4,3,3,3
xeno_16550A.baud_base=115200,115200,115200,115200 root=/dev/hda3 ro
Unknown boot option `xeno_16550A.ioaddr=0x03f8,0xbc00,0xbc08,0xb800': ignoring


the serial example gives:
sandbox:/usr/src/xenomai/examples/rtdm/profiles/serial# ./cross-link
main : can't open rtser0 (write), No such device


I've tried to build the Serial support as a module instead, but it ends up in:
ERROR: "per_cpu__ipipe_percpu_daddr"
[drivers/xenomai/serial/xeno_16550A.ko] undefined!
when doing make bzImage modules.

Any help is welcome
/Bachman

