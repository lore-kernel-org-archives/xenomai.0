Message-ID: <5100AB10.3030509@ebus.com>
Date: Wed, 23 Jan 2013 19:31:28 -0800
From: Doug Brunner <dbrunner@ebus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Subject: [Xenomai] rt_dev_write returns immediately on xeno_16550A
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I have a 16550A UART (actually 1/4 of a TI TL16C554) on the ISA bus on =

my WinSystems PPM-LX800-G SBC, and I'm finding that rt_dev_write returns =

control to the userspace process much earlier than I would expect, given =

how the kernel module is set up. (I'm using Xenomai 2.6.1 btw.) =

Fortunately it has a dedicated IRQ line, so I was able to put a logic =

analyzer on the IRQ, the TX line, and the RTS line (which my software =

manually controls to operate an RS485 transceiver).

I initially found that, with the TX FIFO size allowed to default to 16 =

bytes, rt_dev_write with a block of size 13 returns immediately. (I =

could tell this because my userspace routine sets RTS just before =

calling rt_dev_write and clears RTS immediately after, so it was visible =

on the logic analyzer.) This makes sense, because I could see that the =

16C554 fires an IRQ immediately on the start of transmission (that =

violates the description of the TX IRQ in its datasheet, but that's a =

matter for TI). This would lead into rt_16550_interrupt, which would see =

that ctx->out_npend =3D=3D 0 because the data was written to the FIFO in on=
e =

go, and consequently fire out_event. The TX timeout was configured for =

100 ms, so rt_16550_write would be waiting on out_event, and =

rt_dev_write would return at that time.

However...I tried setting the TX FIFO to 1 byte via xeno_16550A module =

parameter, and found that rt_dev_write still returned almost =

immediately. This is what I don't understand, since I could see data =

being transmitted, and the IRQ line going high once for every byte. This =

means that rt_16550_interrupt MUST be getting called, and in turn =

calling rt_16550_tx_interrupt to move data out to the UART. For =

rt_16550_tx_interrupt to be doing so, out_npend must !=3D 0, so out_event =

should not be getting fired until the very last character.

I did notice something odd: at the beginning of rt_16550_write, we =

initialize timeout_seq with ctx->config.rx_timeout. Later that timeout =

sequence is reused while waiting on out_event, which is naturally =

subject to ctx->config.tx_timeout. This seems like a possible source of =

error if tx and rx timeout are not equal--I didn't study the internal =

implementation of the timeout sequence so I'm not sure. However, I tried =

changing the references from rx_timeout to tx_timeout and it produced no =

change in behavior.

Do you know why rt_dev_write would be returning prematurely? I've =

attached the relevant userspace code snippets for reference. Note that =

RawInterface is a subclass of Interface, and higher level code will call =

RawInterface::Write.

-- =

     Doug Brunner

-------------- next part --------------
A non-text attachment was scrubbed...
Name: rt-16550a-snippet.cpp
Type: text/x-c++src
Size: 2784 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130123/d5da87e=
f/attachment.cpp>
