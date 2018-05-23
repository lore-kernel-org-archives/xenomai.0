MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Tue, 22 May 2018 22:25:27 -0700
Message-ID: <CA+K1mPGz2V-pWH=DLL15onqtL-CRFkezJjy2xrnRQP7rFX1W5Q@mail.gmail.com>
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

I'm not familiar with the chaining of shared interrupts in the RTDM
architecture. I think the EOI should somehow be done in the very last
invocation of rt_16550_interrupt() by the last peripheral needing service.


I read this from an old interrupt handler:
(assuming IBM PC (Intel) architecture)
An interrupt handler issues an EOI by writing the value 0x20 to the PIC at
address 0x20. If the interrupt was number 8-15, do the same thing again,
write 0x20 to address 0x20.

So perhaps something like this at the end of rt_16550_interrupt() ?

if (ctx->irq_handle.irq <= 7)        /* non-specific EOI to 8259 */
  rt_16550_reg_out(mode, 0, 0x20, 0x20);
if (ctx->irq_handle.irq <= 15)          /* extra EOI for upper ISA IRQs */
  rt_16550_reg_out(mode, 0, 0x20, 0x20);

But again I don't know if that will work with shared interrupts. Surely
RTDM implements some "master" handler which is already doing an EOI?
Remember lower interrupts like IRQ 5 work fine with the xeno_16550A driver
unless another port is sharing the same IRQ.

-C Smith
