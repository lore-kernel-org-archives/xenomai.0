Message-ID: <4BE7D752.4060800@domain.hid>
Date: Mon, 10 May 2010 11:52:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTimWzc7PUZP2g7hxT-upoxCcBj777L9c7d7rTRQe@domain.hid>
In-Reply-To: <AANLkTimWzc7PUZP2g7hxT-upoxCcBj777L9c7d7rTRQe@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with a serial test sofware
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Divi Oillo <divi.oillo@domain.hid>
Cc: xenomai@xenomai.org

Divi Oillo wrote:
> Hi,
> 
> I have a kernel 2.6.32.12 with Xenomai 2.5.3
> I'm using a serial port with a PCMCIA card receiving a message each
> second (9600 8N1) and I'm having some trouble with this software:
> http://www.captain.at/xenomai-serial-port-example.php
> 
> $ dmesg | grep ttyS0
> [   10.550153] 0.0: ttyS0 at I/O 0x5100 (irq = 10) is a 16550A
> $ sudo setserial /dev/ttyS0
> /dev/ttyS0, UART: 16550A, Port: 0x5100, IRQ: 10
> $ sudo setserial /dev/ttyS0 uart none
> $ sudo modprobe xeno_16550A io=0x5100 irq=10
> $ sudo ./rt_serial_uprog
> START RT_SERIAL
> rt_serial_uprog: PRESS CTRL-C to EXIT
> rt_serial_uprog: rtser_file opened
> rt_serial_uprog: serial-port-config written
> rt_serial_uprog: read-task created
> rt_serial_uprog: starting read-task
> read_task : error while RTSER_RTIOC_WAIT_EVENT, code -110
> rt_serial_uprog: rtser0 (rtser) -> closed
> read_task : exit
> 
> I don't receive any message...

I do not know much about this test, so I will only have a stupid
question: is there anything sending messages to this machine through the
serial cable?


-- 
					    Gilles.

