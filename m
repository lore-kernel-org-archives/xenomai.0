MIME-Version: 1.0
In-Reply-To: <ca10bce1-a06d-6c3d-41ad-af0c3012a999@siemens.com>
References: <CA+K1mPHAYw41SVh9M1zUwcZUB5g8ygjSbM7Pn0J61gRMzTkKcA@mail.gmail.com>
 <ca10bce1-a06d-6c3d-41ad-af0c3012a999@siemens.com>
From: C Smith <csmithquestions@gmail.com>
Date: Wed, 30 May 2018 10:39:48 -0700
Message-ID: <CA+K1mPFny03WB-b6WiqdYQycML3g87sMvzmarcJdOnKBq0JqgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Only 2 serial ports at a time with xeno_16550A driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

I configured BIOS so two ports shared IRQ5, and gave Linux kernel thoase
two ports with setserial:
/dev/ttyS0, UART: unknown, Port: 0x02e0, IRQ: 10
/dev/ttyS1, UART: 16550A, Port: 0x02f8, IRQ: 5
/dev/ttyS2, UART: unknown, Port: 0x03f8, IRQ: 4
/dev/ttyS3, UART: 16550A, Port: 0x02e8, IRQ: 5

Using Minicom to send some bytes (sucessfully) out of port 0x02f8, IRQ5
/proc/interrupts shows one more interrupt every time I send a byte out the
port:
           CPU0       CPU1       CPU2       CPU3
  5:         26         13          1          0   IO-APIC-edge      serial

But if I subsequently take those ports away from kernel with setserial
(with no changes to BIOS) and load xeno_16550A like this:
modprobe xeno_16550A io=0x02e0,0x02f8,0x03f8,0x02e8 irq=10,5,4,5
baud_base=115200,115200,115200,115200

I get file descriptors when the ports are initialized:
successfully initialized serial device rtser1 (fd=12)   [OK]
successfully initialized serial device rtser0 (fd=13)   [OK]
successfully initialized serial device rtser2 (fd=14)   [OK]
successfully initialized serial device rtser3 (fd=15)   [OK]

But the ports which share IRQ5 can't communicate.
While the port on 0x03f8 IRQ4 can communicate successfully.

So sharing IRQ5 is not working, and there is no way in the BIOS for these
ports to share another interrupt.

-C Smith
PS: Sorry Gmail was hiding your messages so I couldn't Reply to them.
<Trying a Reply here...>


On Mon, May 28, 2018 at 11:39 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 2018-05-28 19:21, C Smith wrote:
> > Jan wrote:
> >> Platform UART IRQs are assumed to be edge-triggered (see irqtype
> >> variable) - maybe your special board is different in this regard as
> >> well. Try removing RTDM_IRQTYPE_EDGE.
> >
> > I couldn't find a kernel option called RTDM_IRQTYPE_EDGE, either with
> 'make
> > menuconfig' or by grepping the Xenomai sources.
> >
> > So I assumed you meant do do this in include/rtdm_driver.h ?
> > /* #define RTDM_IRQTYPE_EDGE        XN_ISR_EDGE */   // just a test
> > #define RTDM_IRQTYPE_EDGE 0
> >
> > I  recompiled the xeno_16550A driver this way and it behaved no better. I
> > still can't get an interrupt if two serial ports share an IRQ.
> >
>
> How does /proc/interrupts look like when you have Linux driving all UARTs?
>
> Jan
>
> PS: You mail program is constantly breaking the topic threading - or you
> are not replying to the previous answers but writing new emails.
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
>
