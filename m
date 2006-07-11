Message-ID: <e325d110607111054t2cae64bbg559c07c96e28df81@domain.hid>
Date: Tue, 11 Jul 2006 18:54:20 +0100
From: "Kim Chuan Lim" <lim.kim.chuan@domain.hid>
In-Reply-To: <44b3e189.3ea62bfd.3c6b.0b92SMTPIN_ADDED@mx.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44b3e189.3ea62bfd.3c6b.0b92SMTPIN_ADDED@mx.gmail.com>
Subject: [Xenomai-help] Re: Xenomai-help Digest, Vol 10, Issue 16
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

> On 7/11, Jan Kiszka wrote:
>
>         Kim Chuan Lim wrote:
>                 I am interested with the hard real time serial port example from..
>                 http://www.captain.at/xenomai-serial-port-example.php
>
>                 The following is the error message i received when i try to run the
>                 program..
>                 ./rt_serial_uprog
>                 rt_serial_uprog: PRESS CTRL-C to EXIT
>                 rt_serial_uprog: timer started
>                 rt_serial_uprog: can't open rtser0
>                 rt_serial_uprog: stop timer
>
>                 May i know which device is "rtser0"?
>                 shall i just change it to /dev/ttyS0?
>
>         Check Hannes' doku: you have to load the xeno_16550A driver.
>
The documentation is available at
http://www.captain.at/xenomai-xeno_16550A.php
>
> I'm also a beginner on Xenomai and I have the same problem as Kim Chuan Lim.
>  I verified my configuration : RTDM skin and 16550A driver are both integrated
> in my 2.6.16 kernel, so these modules don't exist.
> Shall I create rtser0 node ?

some steps which might help...

use "locate xeno_16550A.ko"
to find where is the location of xeno_16550A.ko
in my case.. my xeno_16550A.ko is located at
/lib/modules/2.6.17-smp/kernel/drivers/xenomai/16550A/xeno_16550A.ko

to find out your ttyS0 or ttyS1 do
"dmesg | grep ttyS*"
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A

su to root and insert modules xeno_16550A.ko by
insmod /lib/modules/2.6.17-smp/kernel/drivers/xenomai/16550A/xeno_16550A.ko
ioaddr=0x3f8 irq=4 tx_fifo=10 start_index=0
(can someone please explain why tx_fifo is 10 and start_index=0?)
if u get this msg "insmod: error inserting
'/lib/modules/2.6.17-smp/kernel/drivers/xenomai/16550A/xeno_16550A.ko':
-1 Device or resource busy"

you need to disable the kernel serial port driver with

setserial /dev/ttyS0 uart none
-or-
setserial /dev/ttyS1 uart none

Hope this help.

Regards,
Kim Chuan.

