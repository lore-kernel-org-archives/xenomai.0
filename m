Message-ID: <4954.192.168.2.153.1162320609.squirrel@domain.hid>
Date: Tue, 31 Oct 2006 18:50:09 -0000 (WET)
From: mjcoelho@domain.hid
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Share interrupts between two subdevices
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

Hi!


I'm implementing a driver for a device that has two subdevices (basically=
,
a serial board with two ports). For this to work, i need to use the same
interrupt for both subdevices.

So the driver, ATM, initializes both subdevices and then only one request=
s
and enables the interrupt.

Does RTDM call the interrupt handler of the subdevice that didn't request
the irq? What capabilities does RTDM have in terms of interrupt sharing
between drivers in rt "environment"?


Thanks for your help!








