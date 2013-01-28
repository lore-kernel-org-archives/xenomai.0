Message-ID: <5106D4E4.7080101@ebus.com>
Date: Mon, 28 Jan 2013 11:43:32 -0800
From: Doug Brunner <dbrunner@ebus.com>
MIME-Version: 1.0
References: <mailman.1.1359025201.4260.xenomai@xenomai.org>
In-Reply-To: <mailman.1.1359025201.4260.xenomai@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai Digest, Vol 9, Issue 57
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

> On 01/24/2013 10:21 AM, Wolfgang Grandegger wrote:
>> >On 01/24/2013 09:43 AM, Wolfgang Grandegger wrote:
>>> >>On 01/24/2013 04:31 AM, Doug Brunner wrote:
>>>> >>>I have a 16550A UART (actually 1/4 of a TI TL16C554) on the ISA bus on
>>>> >>>my WinSystems PPM-LX800-G SBC, and I'm finding that rt_dev_write returns
>>>> >>>control to the userspace process much earlier than I would expect, given
>>>> >>>how the kernel module is set up. (I'm using Xenomai 2.6.1 btw.)
>>>> >>>Fortunately it has a dedicated IRQ line, so I was able to put a logic
>>>> >>>analyzer on the IRQ, the TX line, and the RTS line (which my software
>>>> >>>manually controls to operate an RS485 transceiver).
>>> >>
>>> >>The 16550A driver does not support half duplex RS485 mode but I see
>>> >>below that you it it's handled in your application.
>>> >>
>>>> >>>I initially found that, with the TX FIFO size allowed to default to 16
>>>> >>>bytes, rt_dev_write with a block of size 13 returns immediately. (I
>>>> >>>could tell this because my userspace routine sets RTS just before
>>>> >>>calling rt_dev_write and clears RTS immediately after, so it was visible
>>>> >>>on the logic analyzer.) This makes sense, because I could see that the
>>>> >>>16C554 fires an IRQ immediately on the start of transmission (that
>>>> >>>violates the description of the TX IRQ in its datasheet, but that's a
>>>> >>>matter for TI). This would lead into rt_16550_interrupt, which would see
>>>> >>>that ctx->out_npend == 0 because the data was written to the FIFO in one
>>>> >>>go, and consequently fire out_event. The TX timeout was configured for
>>> >>
>>> >>rt_dev_write does store the data in a ring buffer and enable the TX
>>> >>interrupt. When it occurs, the data is written to the FIFO and a
>>> >>subsequent interrupt will signal completion when the FIFO is empty and
>>> >>no more data in the ring buffer.
>>> >>
>>>> >>>100 ms, so rt_16550_write would be waiting on out_event, and
>>>> >>>rt_dev_write would return at that time.
>>> >>
>>> >>Yes, if the TX has not complete at that time.
>>> >>
>>>> >>>However...I tried setting the TX FIFO to 1 byte via xeno_16550A module
>>>> >>>parameter, and found that rt_dev_write still returned almost
>>>> >>>immediately. This is what I don't understand, since I could see data
>>>> >>>being transmitted, and the IRQ line going high once for every byte. This
>>>> >>>means that rt_16550_interrupt MUST be getting called, and in turn
>>>> >>>calling rt_16550_tx_interrupt to move data out to the UART. For
>>>> >>>rt_16550_tx_interrupt to be doing so, out_npend must != 0, so out_event
>>>> >>>should not be getting fired until the very last character.
>>> >>
>>> >>What value does rt_dev_write return?
>>> >>
>>>> >>>I did notice something odd: at the beginning of rt_16550_write, we
>>>> >>>initialize timeout_seq with ctx->config.rx_timeout. Later that timeout
>>>> >>>sequence is reused while waiting on out_event, which is naturally
>>>> >>>subject to ctx->config.tx_timeout. This seems like a possible source of
>>>> >>>error if tx and rx timeout are not equal--I didn't study the internal
>>>> >>>implementation of the timeout sequence so I'm not sure. However, I tried
>>>> >>>changing the references from rx_timeout to tx_timeout and it produced no
>>>> >>>change in behavior.
>>> >>
>>> >>The ctx->config.rx_timeout is used to lock (via mutex) the TX handling
>>> >>against RX.
>>> >>
>>>> >>>Do you know why rt_dev_write would be returning prematurely? I've
>>>> >>>attached the relevant userspace code snippets for reference. Note that
>>>> >>>RawInterface is a subclass of Interface, and higher level code will call
>>>> >>>RawInterface::Write.
>>> >>
>>> >>Not yet. An iPipe trace would help to understand the problem.
>> >
>> >Ah, I remember. FIFO empty does not mean that the transfer has been
>> >complete (on the bus). But that's what you need for toggling RTS for RS485.
> IIRC, the 16550A is not be able to signal the RTSER_EVENT_TXEMPTY empty.
> Therefore you need to poll the "Tramsmitter Empty" bit in the line
> status register. Please check the datasheet of the TL16C554.
>
> Wolfgang.
You're right--my issue was resolved by waiting for the time I expect the 
transmission to take, then polling the LSR with
RTSER_RTIOC_GET_STATUS. Thanks.

     --Doug Brunner

