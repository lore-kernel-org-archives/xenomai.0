MIME-Version: 1.0
Date: Fri, 17 Apr 2009 16:49:13 +0200
Message-ID: <2b490f270904170749m3ec39cc8vddab1b5aa50f4b4c@domain.hid>
From: Dehann Fourie <dehann.fourie@domain.hid>
Content-Type: multipart/alternative; boundary=001636416899b569540467c14871
Subject: [Xenomai-help] RT Serial, rt_dev_read blocking problem
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

--001636416899b569540467c14871
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I am having trouble with reading data from the serial port. I initially
followed the RT Serial example from captain. I changed the read task to a
periodic 20ms task, from which I read from the serial port (rtser0). This is
all that the rt_task is doing. The serial port config is:

static const struct rtser_config
<http://www.xenomai.org/documentation/trunk/html/api/structrtser__config.html>
read_config = {
        .config_mask       = 0xFFFF,
        .baud_rate         = 57600,
        .parity            = RTSER_NO_PARITY,
        .data_bits         = RTSER_8_BITS,
        .stop_bits         = RTSER_1_STOPB,
        .handshake         = RTSER_NO_HAND,
        .fifo_depth        = RTSER_DEF_FIFO_DEPTH,
        .rx_timeout        = RTSER_DEF_TIMEOUT,
        .tx_timeout        = RTSER_DEF_TIMEOUT,
        .event_timeout     = RTSER_DEF_TIMEOUT,
        .timestamp_history = RTSER_RX_TIMESTAMP_HISTORY,
        .event_mask        = RTSER_EVENT_RXPEND,
};

I am reading data into a buffer, char buf[300]. I am able to read data but
the task is repeating at a rate of about 50ms. Execution also only returns
from the rt_dev_read() call when 300 chars have been read, but the external
hardware is only sending a couple of chars (+-35) at a rate of 171Hz. Is the
rt task maybe blocking? How can I get it to only read the available chars in
the serial buffer and then return to my program?

I am on a Geode 500MHz single board computer with kernel 2.6.23 and xeno
2.4.3.

Thanks in advance.

Kind regards,

-- 
Dehann Fourie

--001636416899b569540467c14871
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I am having trouble with reading data from the serial port. I in=
itially followed the RT Serial example from captain. I changed the read tas=
k to a periodic 20ms task, from which I read from the serial port (rtser0).=
 This is all that the rt_task is doing. The serial port config is:<br>
<br><pre class=3D"fragment"><span class=3D"keyword">static</span> <span cla=
ss=3D"keyword">const</span> <span class=3D"keyword">struct </span><a name=
=3D"_a0"></a><a class=3D"code" href=3D"http://www.xenomai.org/documentation=
/trunk/html/api/structrtser__config.html" title=3D"Serial device configurat=
ion.">rtser_config</a> read_config =3D {<br>
        .config_mask       =3D 0xFFFF,<br>        .baud_rate         =3D 57=
600,<br>        .parity            =3D RTSER_NO_PARITY,<br>        .data_bi=
ts         =3D RTSER_8_BITS,<br>        .stop_bits         =3D RTSER_1_STOP=
B,<br>
        .handshake         =3D RTSER_NO_HAND,<br>        .fifo_depth       =
 =3D RTSER_DEF_FIFO_DEPTH,<br>        .rx_timeout        =3D RTSER_DEF_TIME=
OUT,<br>        .tx_timeout        =3D RTSER_DEF_TIMEOUT,<br>        .event=
_timeout     =3D RTSER_DEF_TIMEOUT,<span class=3D"comment"></span><br>
        .timestamp_history =3D RTSER_RX_TIMESTAMP_HISTORY,<br>        .even=
t_mask        =3D RTSER_EVENT_RXPEND,<br>};<br><br></pre><div style=3D"text=
-align: left;">I am reading data into a buffer, char buf[300]. I am able to=
 read data but the task is repeating at a rate of about 50ms. Execution als=
o only returns from the rt_dev_read() call when 300 chars have been read, b=
ut the external hardware is only sending a couple of chars (+-35) at a rate=
 of 171Hz. Is the rt task maybe blocking? How can I get it to only read the=
 available chars in the serial buffer and then return to my program?<br>
<br>I am on a Geode 500MHz single board computer with kernel 2.6.23 and xen=
o 2.4.3.<br><br>Thanks in advance.<br><br>Kind regards,<br></div><pre class=
=3D"fragment"></pre>-- <br>Dehann Fourie<br>

--001636416899b569540467c14871--

