MIME-Version: 1.0
Date: Mon, 10 May 2010 11:03:33 +0200
Message-ID: <AANLkTimWzc7PUZP2g7hxT-upoxCcBj777L9c7d7rTRQe@domain.hid>
From: Divi Oillo <divi.oillo@domain.hid>
Content-Type: multipart/alternative; boundary=0015174c3c34f47619048639ae2b
Subject: [Xenomai-help] Problem with a serial test sofware
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

--0015174c3c34f47619048639ae2b
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I have a kernel 2.6.32.12 with Xenomai 2.5.3
I'm using a serial port with a PCMCIA card receiving a message each second
(9600 8N1) and I'm having some trouble with this software:
http://www.captain.at/xenomai-serial-port-example.php

$ dmesg | grep ttyS0
[   10.550153] 0.0: ttyS0 at I/O 0x5100 (irq = 10) is a 16550A
$ sudo setserial /dev/ttyS0
/dev/ttyS0, UART: 16550A, Port: 0x5100, IRQ: 10
$ sudo setserial /dev/ttyS0 uart none
$ sudo modprobe xeno_16550A io=0x5100 irq=10
$ sudo ./rt_serial_uprog
START RT_SERIAL
rt_serial_uprog: PRESS CTRL-C to EXIT
rt_serial_uprog: rtser_file opened
rt_serial_uprog: serial-port-config written
rt_serial_uprog: read-task created
rt_serial_uprog: starting read-task
read_task : error while RTSER_RTIOC_WAIT_EVENT, code -110
rt_serial_uprog: rtser0 (rtser) -> closed
read_task : exit

I don't receive any message...

$ lsmod
xeno_16550A            10568  0
serial_cs              20295  1
pcmcia                 34113  1 serial_cs
pcmcia_core            36724  4 serial_cs,pcmcia,yenta_socket,rsrc_nonstatic

Regards.

--0015174c3c34f47619048639ae2b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br>
<br>
I have a kernel 2.6.32.12 with Xenomai 2.5.3<br>
I&#39;m using a serial port with a PCMCIA card receiving a message each
second (9600 8N1) and I&#39;m having some trouble with this software:<br>
<a href=3D"http://www.captain.at/xenomai-serial-port-example.php" target=3D=
"_blank">http://www.captain.at/xenomai-serial-port-example.php</a><br>
<br>
$ dmesg | grep ttyS0<br>
[=A0 =A010.550153] 0.0: ttyS0 at I/O 0x5100 (irq =3D 10) is a 16550A<br>
$ sudo setserial /dev/ttyS0<br>
/dev/ttyS0, UART: 16550A, Port: 0x5100, IRQ: 10<br>
$ sudo setserial /dev/ttyS0 uart none<br>
$ sudo modprobe xeno_16550A io=3D0x5100 irq=3D10<br>
$ sudo ./rt_serial_uprog<br>
START RT_SERIAL<br>
rt_serial_uprog: PRESS CTRL-C to EXIT<br>
rt_serial_uprog: rtser_file opened<br>
rt_serial_uprog: serial-port-config written<br>
rt_serial_uprog: read-task created<br>
rt_serial_uprog: starting read-task<br>
read_task : error while RTSER_RTIOC_WAIT_EVENT, code -110<br>
rt_serial_uprog: rtser0 (rtser) -&gt; closed<br>
read_task : exit<br>
<br>
I don&#39;t receive any message...<br>
<br>
$ lsmod<br>
xeno_16550A=A0 =A0 =A0 =A0 =A0 =A0 10568=A0 0<br>
serial_cs=A0 =A0 =A0 =A0 =A0 =A0 =A0 20295=A0 1<br>
pcmcia=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A034113=A0 1 serial_cs<br>
pcmcia_core=A0 =A0 =A0 =A0 =A0 =A0 36724=A0 4 serial_cs,pcmcia,yenta_socket=
,rsrc_nonstatic<br>
<br>
Regards.

--0015174c3c34f47619048639ae2b--

