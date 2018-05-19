MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Fri, 18 May 2018 22:30:28 -0700
Message-ID: <CA+K1mPGOFaKzQO2nys2XcbZ7vLaDvfpivOzyMXDgK89Z59sLGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Only 2 serial ports at a time with xeno_16550A driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

The xeno_16550A driver works on my system but I can't get it to use more
than two ports at a time.

'dmesg' after the kernel boots shows this:
[    0.538264] 00:05: ttyS1 at I/O 0x2f8 (irq = 5, base_baud = 115200) is a
16550A
[    0.559280] 00:06: ttyS3 at I/O 0x2e8 (irq = 5, base_baud = 115200) is a
16550A
[    0.580306] 00:0a: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a
16550A
[    0.601275] 0000:00:16.3: ttyS2 at I/O 0xf0a0 (irq = 19, base_baud =
115200) is a 16550A

If I load xeno_16550A in either of these two ways below my code can use
both serial ports listed, so we know that all three ports work OK:
[root@neon ~]# modprobe xeno_16550A io=0x3f8,0x02f8 irq=4,5
[root@neon ~]# modprobe xeno_16550A io=0x3f8,0x02e8 irq=4,5

But this always fails to allow 3 ports to work:
modprobe xeno_16550A io=0x3f8,0x02f8,0x02e8  irq=4,5,5
Only the first two ports can be initialized, the third gets a "device or
resource busy", rt_dev_open() returns -16.

My code snippet is:

struct rtser_config serial_config = {
        .config_mask       = 0xFFFF,
        .baud_rate         = 115200,
        .parity            = RTSER_NO_PARITY,
        .data_bits         = RTSER_8_BITS,
        .stop_bits         = RTSER_1_STOPB,
        .handshake         = RTSER_NO_HAND,
        .fifo_depth        = RTSER_DEF_FIFO_DEPTH, //RTSER_FIFO_DEPTH_8,
    // I'd rather not initialize this, but compiler error if not
    .reserved          = 0,
        .rx_timeout        = 500000, /* 500 us */
        .tx_timeout        = RTSER_DEF_TIMEOUT,
        .event_timeout     = 5000000, /* 5 ms */
        .timestamp_history = RTSER_RX_TIMESTAMP_HISTORY,
        .event_mask        = RTSER_EVENT_RXPEND,
};

static int fd_tty[MAX_NUM_SERIAL_PORT];   /* file descriptors for serial
ports */

/* a for() loop on port_num is here. ports are not initialized in order,
BTW. */
fd_tty[port_num] = rt_dev_open(tmpstr, O_RDWR | O_NONBLOCK);
if (fd_tty[port_num] < 0)
{
   printf("Problem setting up serial port %d on %s, got: %d\n", port_num,
tmpstr, fd_tty[port_num]);
}
else
{
   int ser_return;
   ser_return = rt_dev_ioctl(fd_tty[port_num], RTSER_RTIOC_SET_CONFIG,
&serial_config);
   if (ser_return < 0)
   {
      printf("serial device %s initialization failed with: (%d)\n",tmpstr,
ser_return);
   }
   else if (ser_return >= 0)
   {
      printf("successfully initialized serial device rtser%d
(fd=%d)\n",port_num,fd_tty[port_num]);
   }
}

This is the output as ports get initialized:
successfully initialized serial device rtser1 (fd=12)
successfully initialized serial device rtser0 (fd=13)
Problem setting up serial port 2 on rtser2, got: -16

I tried this with serial compiled into the kernel and I took the ports away
from the kernel with 'setserial /dev/ttyS_ uart none', and also I tried
with serial as kernel modules and I removed the modules - so there was no
possibility of the kernel using the serial ports.

Is there somehow a limit of 2 ports compiled into the xeno_16550A driver ?
Or is the driver having trouble with the shared interrupt 5?

I am using Xenomai 2.6.5 on kernel 3.18.20
