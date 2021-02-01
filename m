Subject: Re: Using serial port with module xeno_16550A
References: <AS8PR08MB6485476EF27D66304C35723F9AB69@AS8PR08MB6485.eurprd08.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1df23930-c896-51dd-2de4-21ff89c11b41@siemens.com>
Date: Mon, 1 Feb 2021 20:26:18 +0100
MIME-Version: 1.0
In-Reply-To: <AS8PR08MB6485476EF27D66304C35723F9AB69@AS8PR08MB6485.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Zhao, Lixiang" <Lixiang.Zhao@leoni.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01.02.21 19:02, Zhao, Lixiang via Xenomai wrote:
> Hello,
> 
> I'm currently porting xenomai on my project on a raspberry pi 4B and I would like some advice, I'm using xenomai 3.0.9 with a ipipe patch that I found on the web, I managed to set the module xeno_16550A and I was able to replace the default module that load ttyAMA0 of the pi to /dev/rtdm/rtser0. Beside this, I was able to adapt the code to the real time task with the Xenomai API, and the performance I get with each cyclic is really good.
> 

ttyAMA0 should refer to the pl011 UART, while the auxiliary one is a
8250, thus the fit for the exist rtserial driver.

> I would like to use this file descriptor to perform some exchange, the simple test is to connect a Null cable on the RX/TX UART in order to form a loop. I did import the rtdm/serial.h, and explicitely call the __RT() functions on the open, write, read and ioctl on the low level functions. I am able to open the file, configure it with ioctl and the rtser_config struct, and writing on it. What I am struggling with is the read function, I am not able to retrieve the correct return value of the read, it always return -1, I'm not sure if my configuration is correct or not.
> 
> The rtser_config is the following :
>     struct rtser_config my_config;
> 
>     my_config.config_mask       = 0xFFFF; // RTSER_SET_BAUD | RTSER_SET_TIMESTAMP_HISTORY; // //
>     my_config.baud_rate         = 115200;
>     my_config.parity            = RTSER_NO_PARITY;
>     my_config.data_bits         = RTSER_8_BITS;
>     my_config.stop_bits         = RTSER_2_STOPB;
>     my_config.handshake         = RTSER_RTSCTS_HAND;
>     my_config.fifo_depth        = RTSER_DEF_FIFO_DEPTH;
>     my_config.rx_timeout        = RTDM_TIMEOUT_INFINITE;
>     my_config.tx_timeout        = RTDM_TIMEOUT_INFINITE;
>     my_config.event_timeout     = 1000000000; /* 1 s */
>     my_config.timestamp_history = RTSER_RX_TIMESTAMP_HISTORY;
>     my_config.event_mask        = RTSER_EVENT_RXPEND;
>     my_config.rs485             = RTSER_RS485_DISABLE;
> 
> Could you help me on this issue ?
> 

Did you study demo/alchemy/cobalt/cross-link.c already? It's using the
alchemy skin rather than posix, but that you could translate once you
have a working pattern.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

