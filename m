References: <1E8207DAE59C6647B85953FE838AE65C06089573@MBX13.d.ethz.ch>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <9d6f4b46-41ca-e3e0-eef9-5365288b5ed0@xenomai.org>
Date: Fri, 30 Jun 2017 21:38:46 +0200
MIME-Version: 1.0
In-Reply-To: <1E8207DAE59C6647B85953FE838AE65C06089573@MBX13.d.ethz.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Serial Communication
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Satapathy Asutosh <sasutosh@ethz.ch>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 06/30/2017 07:36 PM, Satapathy  Asutosh wrote:
> Hello everyone,
> 
> I am using xenomai 2.6.4 and trying to establish real-time serial communication with a Roboteq Motor Controller(HDC2450). The required configuration for serial communication is : 115200, 8-bit, no parity, 1 stop bit, no flow control

Any reason not to use a current version? 2.6.4 is almost three years
old. You will most likely hit bugs that have been solved since then.
Also, people's incentive to answer questions about an obsolete release
is very low, because time is a scarce resource for everyone.

> 
> I have included the user account in the dialout group and set the port(/dev/ttyS0) permissions to 777. I then unload the uart driver and modprobe the xeno driver as follows:
> sudo setserial /dev/ttyS0 uart none
> sudo modprobe xeno_16550A io=0x3f8 irq=4 baud_base=115200 # I have also tried with irq=0
> 
> The code looks something like as follows:
> 
> int handle = rt_dev_open(port.c_str(), O_RDWR); // port is rtser0. rt_dev_open returns 0
> ...
> config.config_mask       = 0xFFFF;
> config.baud_rate         = 115200;
> config.parity            = RTSER_NO_PARITY;
> config.data_bits         = RTSER_8_BITS;
> config.stop_bits         = RTSER_DEF_STOPB;
> config.handshake         = RTSER_DEF_HAND;
> config.fifo_depth        = RTSER_DEF_FIFO_DEPTH;
> config.rx_timeout        = RTSER_DEF_TIMEOUT;
> config.tx_timeout        = RTSER_DEF_TIMEOUT; 
> config.event_timeout     = RTSER_DEF_TIMEOUT;
> config.timestamp_history = RTSER_RX_TIMESTAMP_HISTORY;
> config.event_mask        = RTSER_EVENT_RXPEND;
> 
> ser_err = rt_dev_ioctl(handle, RTSER_RTIOC_SET_CONFIG, &config); // returns 0
> ...
> ssize_t countSent = rt_dev_write(handle, str.c_str(), str.length()); // returns -1. Operation not permitted
> 
> The rt_dev_write returns -1 which is "Operation not permitted". 
> 

May be a call from an invalid context. Make sure to enable
CONFIG_XENO_OPT_DEBUG_RTDM and CONFIG_XENO_OPT_DEBUG_NUCLEUS in your
kernel configuration, and inspect the kernel log for any message when
your code runs.

-- 
Philippe.

