Message-ID: <435FE178.1040100@domain.hid>
Date: Wed, 26 Oct 2005 22:05:12 +0200
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM & serial port
References: <435EFAB8.2050501@domain.hid> <435F2DDA.1030702@domain.hid>
	<435FB6CB.9030307@domain.hid> <435FBDB1.2010109@domain.hid>
	<435FC965.8040400@domain.hid> <435FCAA7.8090003@domain.hid>
In-Reply-To: <435FCAA7.8090003@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hi Jan!

Jan Kiszka wrote:
[...]
> Almost: ioaddr=0x3f8

Yep, tried that too before, but disabling ttyS0 with setserial did the trick :-)

> Ok, we need some README about xeno_16550A somewhere. Where would you
> look for information first?

API-docs -> Modules -> Real-Time Driver Model -> Device Profiles -> Serial Devices ?

> "setserial /dev/ttyS0 uart none" releases the first port.
> 
> Also something for a README. :-/

I'd add that to the API-docs too.

Just one further thing:
I've modified rt_serial_uprog.c and I just open rtser0 for reading and writing.
That works, I can write to it and read data back from it, but:

In read_task_proc:
     ret = rt_dev_ioctl(my_fd, RTSER_RTIOC_WAIT_EVENT, &rx_event );
rt_dev_ioctl always returns -1 - it doesn't block.

rtser_config for rtser0:
static const struct rtser_config ser_config = {
     0xFFFF,                     /* config_mask */
     RTSER_9600_BAUD,          /* baud_rate */
     RTSER_ODD_PARITY ,           /* parity */
     RTSER_8_BITS ,             /* data_bits */
     RTSER_1_STOPB ,            /* stop_bits */
     RTSER_NO_HAND ,             /* handshake */
     RTSER_DEF_FIFO_DEPTH,       /* fifo_depth*/
     RTSER_DEF_TIMEOUT,          /* rx_timeout */
     RTSER_DEF_TIMEOUT,          /* tx_timeout */
     RTSER_DEF_TIMEOUT,          /* event_timeout */
     RTSER_RX_TIMESTAMP_HISTORY, /* timestamp_history */
     RTSER_EVENT_RXPEND          /* event mask */
};

How can I get rt_dev_ioctl to block ?

Thank you very much for your time Jan! :-)
Best regards,
Hannes.

