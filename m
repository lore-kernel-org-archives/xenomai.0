MIME-Version: 1.0
In-Reply-To: <4BE7D752.4060800@domain.hid>
References: <AANLkTimWzc7PUZP2g7hxT-upoxCcBj777L9c7d7rTRQe@domain.hid>
	<4BE7D752.4060800@domain.hid>
Date: Mon, 10 May 2010 12:03:30 +0200
Message-ID: <AANLkTimlP4GISTmZ1nX125-Lh11Oac8o_gmCzfHF178E@mail.gmail.com>
From: Divi Oillo <divi.oillo@domain.hid>
Content-Type: multipart/alternative; boundary=00032555b95a63c57c04863a85da
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--00032555b95a63c57c04863a85da
Content-Type: text/plain; charset=ISO-8859-1

2010/5/10 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Divi Oillo wrote:
> > Hi,
> >
> > I have a kernel 2.6.32.12 with Xenomai 2.5.3
> > I'm using a serial port with a PCMCIA card receiving a message each
> > second (9600 8N1) and I'm having some trouble with this software:
> > http://www.captain.at/xenomai-serial-port-example.php
> >
> > $ dmesg | grep ttyS0
> > [   10.550153] 0.0: ttyS0 at I/O 0x5100 (irq = 10) is a 16550A
> > $ sudo setserial /dev/ttyS0
> > /dev/ttyS0, UART: 16550A, Port: 0x5100, IRQ: 10
> > $ sudo setserial /dev/ttyS0 uart none
> > $ sudo modprobe xeno_16550A io=0x5100 irq=10
> > $ sudo ./rt_serial_uprog
> > START RT_SERIAL
> > rt_serial_uprog: PRESS CTRL-C to EXIT
> > rt_serial_uprog: rtser_file opened
> > rt_serial_uprog: serial-port-config written
> > rt_serial_uprog: read-task created
> > rt_serial_uprog: starting read-task
> > read_task : error while RTSER_RTIOC_WAIT_EVENT, code -110
> > rt_serial_uprog: rtser0 (rtser) -> closed
> > read_task : exit
> >
> > I don't receive any message...
>
> I do not know much about this test, so I will only have a stupid
> question: is there anything sending messages to this machine through the
> serial cable?
>

Yes there is.

$ sudo minicom -s
Welcome to minicom 2.3

OPTIONS: I18n

Compiled on Sep 25 2009, 23:45:34.

Port /dev/ttyS0



               Press CTRL-A Z for help on special keys



$GPGLL,2146.590,N,02146.590,W,115718*5E

$GPRMC,115718,A,2146.590,N,02146.590,W,005.0,315.0,100510,000.0,W*7A

$GPVTG,315.0,T,315.0,M,005.0,N,009.3,K*41

$GPZDA,115718,10,05,2010,00*68

$GPGGA,115718,2146.590,N,02146.590,W,1,08,2.0,100.0,M,50.0,M,,*55

$GPGSA,A,3,01,02,03,,05,,07,,09,,11,12,2.0,2.0,2.0*38
$GPGLL,2146.591,N,02146.591,W,115719*5F
$GPRMC,115719,A,2146.591,N,02146.591,W,005.0,315.0,100510,000.0,W*7B
$GPVTG,315.0,T,315.0,M,005.0,N,009.3,K*41
$GPZDA,115719,10,05,2010,00*69
$GPGGA,115719,2146.591,N,02146.591,W,1,08,2.0,100.0,M,50.0,M,,*54
$GPGSA,A,3,01,02,03,,05,,07,,09,,11,12,2.0,2.0,2.0*38

$ sudo setserial /dev/ttyS0
/dev/ttyS0, UART: 16550A, Port: 0x5100, IRQ: 10
$ sudo setserial /dev/ttyS0 uart none
$ sudo setserial /dev/ttyS0
/dev/ttyS0, UART: unknown, Port: 0x5100, IRQ: 10
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
^C
rt_serial_uprog: exit

Divi

>
>

--00032555b95a63c57c04863a85da
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">2010/5/10 Gilles Chanteperdrix <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdr=
ix@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D=
"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padd=
ing-left: 1ex;">
<div class=3D"im">Divi Oillo wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I have a kernel 2.6.32.12 with Xenomai 2.5.3<br>
&gt; I&#39;m using a serial port with a PCMCIA card receiving a message eac=
h<br>
&gt; second (9600 8N1) and I&#39;m having some trouble with this software:<=
br>
&gt; <a href=3D"http://www.captain.at/xenomai-serial-port-example.php" targ=
et=3D"_blank">http://www.captain.at/xenomai-serial-port-example.php</a><br>
&gt;<br>
&gt; $ dmesg | grep ttyS0<br>
&gt; [ =A0 10.550153] 0.0: ttyS0 at I/O 0x5100 (irq =3D 10) is a 16550A<br>
&gt; $ sudo setserial /dev/ttyS0<br>
&gt; /dev/ttyS0, UART: 16550A, Port: 0x5100, IRQ: 10<br>
&gt; $ sudo setserial /dev/ttyS0 uart none<br>
&gt; $ sudo modprobe xeno_16550A io=3D0x5100 irq=3D10<br>
&gt; $ sudo ./rt_serial_uprog<br>
&gt; START RT_SERIAL<br>
&gt; rt_serial_uprog: PRESS CTRL-C to EXIT<br>
&gt; rt_serial_uprog: rtser_file opened<br>
&gt; rt_serial_uprog: serial-port-config written<br>
&gt; rt_serial_uprog: read-task created<br>
&gt; rt_serial_uprog: starting read-task<br>
&gt; read_task : error while RTSER_RTIOC_WAIT_EVENT, code -110<br>
&gt; rt_serial_uprog: rtser0 (rtser) -&gt; closed<br>
&gt; read_task : exit<br>
&gt;<br>
&gt; I don&#39;t receive any message...<br>
<br>
</div>I do not know much about this test, so I will only have a stupid<br>
question: is there anything sending messages to this machine through the<br=
>
serial cable?<br></blockquote><div><br>Yes there is. <br></div><div><br>$ s=
udo minicom -s<br>
Welcome to minicom 2.3<br>
<br>
OPTIONS: I18n=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>
Compiled on Sep 25 2009, 23:45:34.=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 <br>
Port /dev/ttyS0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 <br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Press CTRL-A Z for help on speci=
al keys=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <=
br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 <br>
$GPGLL,2146.590,N,02146.590,W,115718*5E=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 <br>
$GPRMC,115718,A,2146.590,N,02146.590,W,005.0,315.0,100510,000.0,W*7A=A0=A0=
=A0=A0=A0=A0=A0=A0 <br>
$GPVTG,315.0,T,315.0,M,005.0,N,009.3,K*41=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <b=
r>
$GPZDA,115718,10,05,2010,00*68=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 <br>
$GPGGA,115718,2146.590,N,02146.590,W,1,08,2.0,100.0,M,50.0,M,,*55=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 <br>
$GPGSA,A,3,01,02,03,,05,,07,,09,,11,12,2.0,2.0,2.0*38=A0=A0=A0=A0=A0=A0 <br=
>
$GPGLL,2146.591,N,02146.591,W,115719*5F=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 <br>
$GPRMC,115719,A,2146.591,N,02146.591,W,005.0,315.0,100510,000.0,W*7B<br>
$GPVTG,315.0,T,315.0,M,005.0,N,009.3,K*41=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 <br>
$GPZDA,115719,10,05,2010,00*69=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>
$GPGGA,115719,2146.591,N,02146.591,W,1,08,2.0,100.0,M,50.0,M,,*54<br>
$GPGSA,A,3,01,02,03,,05,,07,,09,,11,12,2.0,2.0,2.0*38 <br><br>$ sudo setser=
ial /dev/ttyS0 <br>/dev/ttyS0, UART: 16550A, Port: 0x5100, IRQ: 10<br>$ sud=
o setserial /dev/ttyS0 uart none<br>$ sudo setserial /dev/ttyS0 <br>/dev/tt=
yS0, UART: unknown, Port: 0x5100, IRQ: 10<br>
$ sudo modprobe xeno_16550A io=3D0x5100 irq=3D10<br>$ sudo ./rt_serial_upro=
g<br>START RT_SERIAL<br>rt_serial_uprog: PRESS CTRL-C to EXIT<br>rt_serial_=
uprog: rtser_file opened<br>rt_serial_uprog: serial-port-config written<br>
rt_serial_uprog: read-task created<br>rt_serial_uprog: starting read-task<b=
r>read_task : error while RTSER_RTIOC_WAIT_EVENT, code -110<br>rt_serial_up=
rog: rtser0 (rtser) -&gt; closed<br>read_task : exit<br>^C<br>rt_serial_upr=
og: exit<br>
<br>Divi<br></div><blockquote class=3D"gmail_quote" style=3D"border-left: 1=
px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"=
>
<font color=3D"#888888"><br>
</font></blockquote></div><br>

--00032555b95a63c57c04863a85da--

