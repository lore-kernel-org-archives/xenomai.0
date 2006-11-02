Message-Id: <s54a0103.074@domain.hid>
Date: Thu, 02 Nov 2006 14:30:09 +0100
From: "Nicolas BLANCHARD" <n.blanchard@domain.hid>
Subject: =?ISO-8859-1?Q?R=E9p.=20:=20[Xenomai-help]=20Share=20interrupts?=
	=?ISO-8859-1?Q?=20between=20two=20subdevices?=
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
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



>>> <mjcoelho@domain.hid> 31.10 19:50 >>>
>Hi!
>
>
>I'm implementing a driver for a device that has two subdevices
(basically,
>a serial board with two ports). For this to work, i need to use the
same
>interrupt for both subdevices.
>
>So the driver, ATM, initializes both subdevices and then only one
requests
>and enables the interrupt.
>
>Does RTDM call the interrupt handler of the subdevice that didn't
request
>the irq? What capabilities does RTDM have in terms of interrupt
sharing
>between drivers in rt "environment"?
>
>
>Thanks for your help!



Hello,

You have a Xenomai shared interrupt option in kernel options,
for example you can see the 16550 xenomai drivers that could use
shared interrupts.



_______________________________________________
Xenomai-help mailing list
Xenomai-help@domain.hid 
https://mail.gna.org/listinfo/xenomai-help

