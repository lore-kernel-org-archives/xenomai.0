From: "Zhao, Lixiang" <Lixiang.Zhao@leoni.com>
Subject: Using serial port with module xeno_16550A
Date: Mon, 1 Feb 2021 18:02:48 +0000
Message-ID: <AS8PR08MB6485476EF27D66304C35723F9AB69@AS8PR08MB6485.eurprd08.prod.outlook.com>
Content-Language: fr-FR
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

I'm currently porting xenomai on my project on a raspberry pi 4B and I woul=
d like some advice, I'm using xenomai 3.0.9 with a ipipe patch that I found=
 on the web, I managed to set the module xeno_16550A and I was able to repl=
ace the default module that load ttyAMA0 of the pi to /dev/rtdm/rtser0. Bes=
ide this, I was able to adapt the code to the real time task with the Xenom=
ai API, and the performance I get with each cyclic is really good.

I would like to use this file descriptor to perform some exchange, the simp=
le test is to connect a Null cable on the RX/TX UART in order to form a loo=
p. I did import the rtdm/serial.h, and explicitely call the __RT() function=
s on the open, write, read and ioctl on the low level functions. I am able =
to open the file, configure it with ioctl and the rtser_config struct, and =
writing on it. What I am struggling with is the read function, I am not abl=
e to retrieve the correct return value of the read, it always return -1, I'=
m not sure if my configuration is correct or not.

The rtser_config is the following :
    struct rtser_config my_config;

    my_config.config_mask       =3D 0xFFFF; // RTSER_SET_BAUD | RTSER_SET_T=
IMESTAMP_HISTORY; // //
    my_config.baud_rate         =3D 115200;
    my_config.parity            =3D RTSER_NO_PARITY;
    my_config.data_bits         =3D RTSER_8_BITS;
    my_config.stop_bits         =3D RTSER_2_STOPB;
    my_config.handshake         =3D RTSER_RTSCTS_HAND;
    my_config.fifo_depth        =3D RTSER_DEF_FIFO_DEPTH;
    my_config.rx_timeout        =3D RTDM_TIMEOUT_INFINITE;
    my_config.tx_timeout        =3D RTDM_TIMEOUT_INFINITE;
    my_config.event_timeout     =3D 1000000000; /* 1 s */
    my_config.timestamp_history =3D RTSER_RX_TIMESTAMP_HISTORY;
    my_config.event_mask        =3D RTSER_EVENT_RXPEND;
    my_config.rs485             =3D RTSER_RS485_DISABLE;

Could you help me on this issue ?

Best regards,
Li Xiang.

