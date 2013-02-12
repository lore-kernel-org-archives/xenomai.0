Message-ID: <511A408C.7070501@siemens.com>
Date: Tue, 12 Feb 2013 14:15:56 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <FA4CEC4EBE2FA145A7663764A1CCB31E5C4C87A6@VOITV-EXCH-BE01.transas.com>
	<FA4CEC4EBE2FA145A7663764A1CCB31E5C4C8FEA@VOITV-EXCH-BE01.transas.com>
In-Reply-To: <FA4CEC4EBE2FA145A7663764A1CCB31E5C4C8FEA@VOITV-EXCH-BE01.transas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xeno_16550A : "unrecoverable" receive buffer overflow
	on read
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Zemskov, Evgeny" <Evgeny.Zemskov@transas.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2013-02-12 13:33, Zemskov, Evgeny wrote:
> Greetings !
> 
> I'm trying to use xeno_16550A driver to read a stream of high-frequency data
> (~50 byte packet each 20 msec at 57600 baud) with low latencies.

The driver was once developed to handle high-rate data streams at 1
Mbps, so it should generally work.


> After successful installation of xeno_16550A.ko driver module and 
> initialization of rtser0 device, an attempt to read from the device fails :
> rt_dev_read returns -5 (Input/output error),
> and subsequent ioctl RTSER_RTIOC_GET_STATUS shows the value of 
> LSR=0x62 and MSR=0x5.

rt_16550_context::status is reset after each error reported by
rt_dev_read, rt_16550_context::saved_status is reset after
RTSER_RTIOC_GET_STATUS. So, unless the problem re-arises continuously,
you should be able to recover the port. without that steps below.

Is there a packet frequency that is still fine? Are you sure your reader
task is able to keep up with the data stream? What is your RX FIFO
depth? Your hardware is 16550A compatible?

> 
> The data from rtser0 device can be read successfully after following sequence :
>  - rmmod xeno_16550A
>  - init /dev/ttyS0 to use standard Linux 8250 driver with setserial
>  - start and stop reading from /dev/ttyS0
>  - insmod xeno_16550A with valid parameters
> 
> Naturally, /dev/ttyS0 and rtser0 point to the same built-in serial port 
> at 0x3F8.
> 
> The problem doesn't appear when I send to the port ocassional bursts of data
> (sized around 20-30 bytes), i.e. rtser0 can be read from consistently after 
> each restart of the utility (i use modified cross-link with truncated write 
> functionality).
> 
> It seems like that xeno_16550A is unable to handle overflow of UART Rx buffer,
> which is flushed on initialization by 8250 driver.
> 
> Could anybody suggest where in sources (of both 16550A and 8250) to look for 
> the solution ?

Check the rate of RX interrupts and what status reported on each
(rt_16550_rx_interrupt). Do they complete successfully at all, only fail
after a while? Do they come regularly? Maybe something (SMI?) is
blocking interrupts for a longer period, causing the FIFO overflow.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

