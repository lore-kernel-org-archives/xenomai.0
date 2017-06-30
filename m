From: "Satapathy  Asutosh" <sasutosh@ethz.ch>
Date: Fri, 30 Jun 2017 17:36:35 +0000
Message-ID: <1E8207DAE59C6647B85953FE838AE65C06089573@MBX13.d.ethz.ch>
Content-Language: en-GB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai]  Serial Communication
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Hello everyone,

I am using xenomai 2.6.4 and trying to establish real-time serial communica=
tion with a Roboteq Motor Controller(HDC2450). The required configuration f=
or serial communication is : 115200, 8-bit, no parity, 1 stop bit, no flow =
control

I have included the user account in the dialout group and set the port(/dev=
/ttyS0) permissions to 777. I then unload the uart driver and modprobe the =
xeno driver as follows:
sudo setserial /dev/ttyS0 uart none
sudo modprobe xeno_16550A io=3D0x3f8 irq=3D4 baud_base=3D115200 # I have al=
so tried with irq=3D0

The code looks something like as follows:

int handle =3D rt_dev_open(port.c_str(), O_RDWR); // port is rtser0. rt_dev=
_open returns 0
...
config.config_mask       =3D 0xFFFF;
config.baud_rate         =3D 115200;
config.parity            =3D RTSER_NO_PARITY;
config.data_bits         =3D RTSER_8_BITS;
config.stop_bits         =3D RTSER_DEF_STOPB;
config.handshake         =3D RTSER_DEF_HAND;
config.fifo_depth        =3D RTSER_DEF_FIFO_DEPTH;
config.rx_timeout        =3D RTSER_DEF_TIMEOUT;
config.tx_timeout        =3D RTSER_DEF_TIMEOUT;=20
config.event_timeout     =3D RTSER_DEF_TIMEOUT;
config.timestamp_history =3D RTSER_RX_TIMESTAMP_HISTORY;
config.event_mask        =3D RTSER_EVENT_RXPEND;

ser_err =3D rt_dev_ioctl(handle, RTSER_RTIOC_SET_CONFIG, &config); // retur=
ns 0
...
ssize_t countSent =3D rt_dev_write(handle, str.c_str(), str.length()); // r=
eturns -1. Operation not permitted

The rt_dev_write returns -1 which is "Operation not permitted".=20

What am I doing wrong here? Any advice on how to proceed and debug? Thanks =
a lot in advance.

Cheers
Asutosh=

