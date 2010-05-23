MIME-Version: 1.0
Date: Sun, 23 May 2010 11:48:13 +0800
Message-ID: <AANLkTimhw6cOHeDP3D4Om8nBiT-aURPWxbIrT23hNcNW@mail.gmail.com>
From: Everett Wang <everteq@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] problem with serial example
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

I am trying to make my serial work with xenomai. I have managed to
compile and almost run the cross-link example.
When I tried to run it, I got a shared library problem:

examples
./cross-link
./cross-link: error while loading shared libraries: libxenomai.so.0: cannot...

I then added this:

$LD_LIBRARY_PATH=/usr/xenomai/lib
$export LD_LIBRARY_PATH

Is this the right thing to do?

I tried it again. I got a little further:

root@domain.hid# ./cross-link
main : can't open rtser0 (write), No such device

I googled a little bit and still can't find a solution. Here is the system I am
using: Beagleboard C4, xenomai 2.5.3, linux 2.6.33.3, cross-compiler CSL
2010Q1. In my kernel configuration, I do have CONFIG_XENO_DRIVERS_16550A
enabled as a module.

In a 2007 post, I saw  Philippe Gerum suggested to  have "vanilla
serial support disabled".
which kernel config is that? CONFIG_SERIAL_CORE? or CONFIG_SERIAL_8250?
I looked at my /dev/ directory and not found rtser*. It does have
ttyS0, ttyS1 and ttyS3
for my normal serial ports. Nothing called rtser in /proc/xenomai/rtdm either
root@domain.hid# ls
fildes         open_fildes       rttest-switchtest0
named_devices  protocol_devices  rttest-timerbench0

Any suggestions?

Have a nice weekend,

Everett

