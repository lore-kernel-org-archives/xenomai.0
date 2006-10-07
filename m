Message-ID: <4527B6C6.7000208@domain.hid>
Date: Sat, 07 Oct 2006 16:16:38 +0200
From: Pavel Pirkl <pavelpirkl@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] USB to serial converter using in Xenomai
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

Hello,
1.
I am using USB to serial convertes with FTDI chip. But I don=B4t know
which paramaters of irq and ioaddr I must to set for xeno_16550A.ko .
Can you help me where I found this parameters?

2.
Now I am using two serial link defined us
#!/bin/sh
setserial /dev/ttyS1 uart none        #COM2
setserial /dev/ttyS2 uart none        #COM3
insmod    ./xeno_nucleus.ko
insmod    ./xeno_native.ko
insmod    ./xeno_rtdm.ko
insmod    ./xeno_16550A.ko ioaddr=3D0x2f8,0x3e8 irq=3D3,5 tx_fifo=3D10,10=
=20
start_index=3D0    #COM2, COM3

This two serial link works very good.
But if I am set for example this
#!/bin/sh
setserial /dev/ttyS2 uart none        #COM3
setserial /dev/ttyS3 uart none        #COM4 - not function ??
insmod    ./xeno_nucleus.ko
insmod    ./xeno_native.ko
insmod    ./xeno_rtdm.ko
insmod    ./xeno_16550A.ko ioaddr=3D0x3e8,0x3f8 irq=3D5,10 tx_fifo=3D10,1=
0=20
start_index=3D0    #COM3, COM4

The COM3 works but COM4 doesn=B4t work. Where is problem?

Thank you very much for your answer.
Pavel Pirkl.










