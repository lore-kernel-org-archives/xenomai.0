Message-ID: <511B885E.8030300@siemens.com>
Date: Wed, 13 Feb 2013 13:34:38 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <FA4CEC4EBE2FA145A7663764A1CCB31E5C4C87A6@VOITV-EXCH-BE01.transas.com>
	<FA4CEC4EBE2FA145A7663764A1CCB31E5C4C8FEA@VOITV-EXCH-BE01.transas.com>,
	<511A408C.7070501@siemens.com>
	<FA4CEC4EBE2FA145A7663764A1CCB31E5C4C90E2@VOITV-EXCH-BE01.transas.com>
In-Reply-To: <FA4CEC4EBE2FA145A7663764A1CCB31E5C4C90E2@VOITV-EXCH-BE01.transas.com>
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

On 2013-02-13 13:22, Zemskov, Evgeny wrote:
>> Is there a packet frequency that is still fine? Are you sure your reader
>> task is able to keep up with the data stream? What is your RX FIFO
>> depth? Your hardware is 16550A compatible?
> 
>> Check the rate of RX interrupts and what status reported on each
>> (rt_16550_rx_interrupt). Do they complete successfully at all, only fail
>> after a while? Do they come regularly? Maybe something (SMI?) is
>> blocking interrupts for a longer period, causing the FIFO overflow.
> 
> At the moment we're testing with low frequencies, the same problem 
> occurs even at 1..2 second intervals between packets.
> The reader is definitely quick enough (essentially, it only executes an rt_printf 
> with read notification), and it handles in time packets with at least 50msec intervals.
> 
> Interesting thing is that problem occurs _only_ if packets are received by UART 
> during the startup or shutdown of the reader application.
> In latter case, rt_dev_read fails on first packet received after startup (probably, when
>  next RX interrupt is triggered).
> No problem occurs is data is received by UART when application is not running.
> 
> All RX interrupts are triggered and executed in xeno_16550A driver correctly 
> (I've added printk's in rt_16550_rx_interrupt), even after rt_dev_read has failed 
> (but the application is still running and keeps driver initialized)/

Sorry, I still don't fully get the error: rt_dev_read suddenly returns
-EIO and, after that, never works again until you do the hardware
re-init via the Linux driver?

After the first EIO, what does the interrupt handler read from the LSR
register from that on? Always RTSER_LSR_OVERRUN_ERR?

> 
> Hardware is a serial port built into ASUS P4 motherboard with i865 chipset. 
> Couldn't find which UART are they using, but it works fine with everything.
> I believe that its Rx FIFO depth is standard 16 bytes (at least Rx trigger 
> level can be set to standard 1-4-8-14 bytes)

And you leave the trigger depth at "1", right?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

