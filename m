MIME-Version: 1.0
References: <CA+K1mPFgaiP3fGFnd169MXhdRWo+a1TGz5fnEoj7MOCr11UbLQ@mail.gmail.com>
 <c6a9ba79-c7c5-195d-be1e-030fb44f5abc@siemens.com>
In-Reply-To: <c6a9ba79-c7c5-195d-be1e-030fb44f5abc@siemens.com>
From: C Smith <csmithquestions@gmail.com>
Date: Wed, 17 Apr 2019 23:42:17 -0700
Message-ID: <CA+K1mPEvKLN+gyDPwLE0OovtSn-iQ_BBZ86zQf12Fv65Ht5KbQ@mail.gmail.com>
Subject: Re: rt_dev_send() stalls periodic task
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Sumitabh Ghosh via Xenomai <xenomai@xenomai.org>

On Tue, Apr 16, 2019 at 1:03 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> > The serial device is set up this way:
> > struct rtser_config serial_config = {
> >          .config_mask       = 0xFFFF,
> >          .baud_rate         = 115200,
> >          .parity            = RTSER_NO_PARITY,
> >          .data_bits         = RTSER_8_BITS,
> >          .stop_bits         = RTSER_1_STOPB,
> >          .handshake         = RTSER_NO_HAND,
> >          .fifo_depth        = RTSER_DEF_FIFO_DEPTH, //RTSER_FIFO_DEPTH_8,
> >      .reserved          = 0,
> >          .rx_timeout        = 500000,
> >          .tx_timeout        = RTSER_DEF_TIMEOUT,
> >          .event_timeout     = 5000000,
> >          .timestamp_history = RTSER_RX_TIMESTAMP_HISTORY,
> >          .event_mask        = RTSER_EVENT_RXPEND,
> > };
> > fd_tty[0] = rt_dev_open("rtser1", O_RDWR | O_NONBLOCK);
> > sret = rt_dev_ioctl(fd_tty[0], RTSER_RTIOC_SET_CONFIG, &serial_config);
> >
> > The application transmits a packet of about 75 bytes repeatedly from a
> > xenomai periodic task that wakes up at 125Hz repeatedly. Note that there
> is
> > also a small RX serial packet arriving so there is some full-duplex
> > overlap.  On rtser0 this works fine, on the other serial ports the stall
> > happens after a few hours and my periodic xenomai task stops. There is no
> > xenomai watchdog message in dmesg. The code is repeatedly checking the
> > serial port status ioctl and there are no errors like framing errors etc.
> >
> > The periodic task is just a typical xenomai while() loop:
> >    next += period_ns + adjust_ns;
> >      rt_task_sleep_until(next);
> >
> > When my periodic task stops the kernel says the stack trace is:
> > [root@oyx ~]# cd /proc/1066/task/1075/
> > [root@oyx 1075]# cat stack
> > [<c112d058>] xnpod_suspend_thread+0x3d8/0x650
> > [<c1132f09>] xnsynch_sleep_on+0x139/0x320
> > [<c11a7f14>] rtdm_event_timedwait+0x2e4/0x390
> > [<e858ed3b>] rt_16550_write+0x35b/0x540 [xeno_16550A]
>
> This means the driver is stuck while writing because there are no more
> free
> entries in the hardware TX FIFO. Do you have hardware flow control
> enabled? Are
> you sure the that the receiving side is playing nicely?
> Jan
>

Well I'm not trying to use hardware flow control. Is hardware flow control
the xeno_16550A driver default?
I am using a 3-wire serial cable, no RTS/CTS wires at all, they are
floating.

At present my app only ever calls the ioctl RTSER_RTIOC_SET_CONFIG as
detailed above.
Are you saying I need to do an ioctl RTSER_RTIOC_SET_CONTROL and clear
control bit  *RTSER_MCR_RTS*   ?

I have another Xenomai app which has been running fine as a 3-wire serial
connection for about 4 years,
and it does not do an ioctl RTSER_RTIOC_SET_CONFIG either. Doesn't that
mean setting flow control is unnecessary?

-C Smith
