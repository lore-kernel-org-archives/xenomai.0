References: <CA+K1mPGz2V-pWH=DLL15onqtL-CRFkezJjy2xrnRQP7rFX1W5Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <77f03786-e75e-cf4b-32b9-e6459fb9dcaa@siemens.com>
Date: Wed, 23 May 2018 11:18:04 +0200
MIME-Version: 1.0
In-Reply-To: <CA+K1mPGz2V-pWH=DLL15onqtL-CRFkezJjy2xrnRQP7rFX1W5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Only 2 serial ports at a time with xeno_16550A driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: C Smith <csmithquestions@gmail.com>, xenomai@xenomai.org

On 2018-05-23 07:25, C Smith wrote:
> I'm not familiar with the chaining of shared interrupts in the RTDM
> architecture. I think the EOI should somehow be done in the very last
> invocation of rt_16550_interrupt() by the last peripheral needing service.
> 

Just like under Linux, the driver does not have to worry about that
details. Xenomai will EOI the IRQ when needed. The driver handler just
need to tell if a particular invocation was (also) triggered by the
device it drives.

> 
> I read this from an old interrupt handler:
> (assuming IBM PC (Intel) architecture)
> An interrupt handler issues an EOI by writing the value 0x20 to the PIC at
> address 0x20. If the interrupt was number 8-15, do the same thing again,
> write 0x20 to address 0x20.
> 
> So perhaps something like this at the end of rt_16550_interrupt() ?
> 
> if (ctx->irq_handle.irq <= 7)        /* non-specific EOI to 8259 */
>   rt_16550_reg_out(mode, 0, 0x20, 0x20);
> if (ctx->irq_handle.irq <= 15)          /* extra EOI for upper ISA IRQs */
>   rt_16550_reg_out(mode, 0, 0x20, 0x20);
> 
> But again I don't know if that will work with shared interrupts. Surely
> RTDM implements some "master" handler which is already doing an EOI?
> Remember lower interrupts like IRQ 5 work fine with the xeno_16550A driver

As noted in the other thread, IRQ 5 is most probably wrong. Check what
Linux uses when you attach the device to a normal Linux driver.

Jan

> unless another port is sharing the same IRQ.
> 
> -C Smith
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

