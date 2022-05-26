MIME-Version: 1.0
References: <CA+K1mPGZhf9Rg+ywyoffiy+jn0BuM_n7D4C7exyS5MKQK+UW6Q@mail.gmail.com>
 <CAFLxGvzpxq=5GTWsXJbCyYVDTDnP6ab8KKTcNVMAn7kGiX-RPQ@mail.gmail.com>
 <CA+K1mPGfRDQsW_d=Rq+O50sHzJtSEsRLvimLqfCzcBawgiQnAg@mail.gmail.com>
In-Reply-To: <CA+K1mPGfRDQsW_d=Rq+O50sHzJtSEsRLvimLqfCzcBawgiQnAg@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 26 May 2022 07:50:35 +0200
Message-ID: <CAFLxGvw7RQFx8ESxxiJ51wpykfcbp6q85wer3sH6Rx9FBfvAWw@mail.gmail.com>
Subject: Re: 16550A IRQ not enabled
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: C Smith <csmithquestions@gmail.com>
Cc: Xenomai List <xenomai@xenomai.org>

On Thu, May 26, 2022 at 2:08 AM C Smith <csmithquestions@gmail.com> wrote:
>
> On Wed, May 25, 2022 at 1:07 AM Richard Weinberger
> <richard.weinberger@gmail.com> wrote:
> >
> > On Wed, May 25, 2022 at 2:18 AM C Smith via Xenomai <xenomai@xenomai.org> wrote:
> > > We are using Xenomai 3.1.2 on kernel 4.19.229, X86 CPU
> > > We have a (Moxa CP-104ul) serial card on an isolated PCI bus interrupt 17.
> > > lspci -v confirms that the serial card is isolated and that no other
> > > peripheral uses this interrupt.
> > >
> > > We have the 16550A serial driver loaded, and an external serial device
> > > trying to initiate a serial connection, but no interrupts are being
> > > generated. The interrupt counter in /proc/xenomai/irq stay at 0.
> > >
> > > [user@device~]$ cat /proc/xenomai/irq
> > >   IRQ         CPU0        CPU1        CPU2        CPU3
> > >    17:           0           0           0           0         rtser2
> > > rtser3 rtser4 rtser5
> > >
> > > As an experiment: if we enable the Azalia sound chip in the BIOS, and
> > > load its Alsa sound driver, the Serial card will then share IRQ 17
> > > with that sound chip, and then the serial card works. The serial
> > > interrupt counter is incrementing in /proc/xenomai/irq and our serial
> > > peripheral can utilize the serial port OK.
> >
> > I think enabling it in the BIOS is the key. Can you try keeping the sound driver
> > disabled and only enable in the BIOS.
>
> We left the Azalia sound chip enabled in the BIOS, and disabled the
> sound driver.
> Interrupts in /proc/xenomai/irq are still not incrementing when serial
> packets come into the po
>
> > > We don't want the sound driver enabled, but this test indicates that
> > > 16550A somehow failed to enable its interrupt, whereas the sound
> > > driver succeeded in doing so.
> > >
> > > How can we check a PIC, etc. to verify that the serial interrupt is
> > > truly enabled when the 16550A driver is loaded alone?
> >
> > You can enable CONFIG_GENERIC_IRQ_DEBUGFS and then poke into
> > /sys/kernel/debug/irq/.
> >
> > --
> > Thanks,
> > //richard
>
> We rebuilt our kernel with CONFIG_GENERIC_IRQ_DEBUGFS enabled, booted
> with the sound driver disabled and loaded xeno_16550A:
>
> [root@device~]# cat /sys/kernel/debug/irq/irqs/17
> cat: /sys/kernel/debug/irq/irqs/17: No such file or directory.
>
> We noticed that /proc/xenomai/irq is not showing IRQ17 immediately
> after xeno_16550A is loaded.
> proc/xenomai/irq only shows IRQ17 after the serial device is opened
> for the first time.

The driver requests the IRQ only upon open. So that's okay.

> So /sys/kernel/debug/irq/irqs/17 doesn't become available until the
> sound driver is loaded.

...or until you use the xeno_16550A driver by opening the device handle?

> We also have a (Peak) CAN card installed in this system, and the
> corresponding IRQ shows up immediately in
> /sys/kernel/debug/irq/irqs/18
> after the xeno_can driver is loaded.
>
> Should we expect to see the IRQ show up in /proc/xenomai/irq
> immediately after loading the xeno_16550A driver?

No. It depends how the driver works. As I wrote, xeno_16550A does
rtdm_irq_request()
in the open, not the probe function.

> How can we debug this further, since /sys/kernel/debug/irq/irqs/17
> does not exist without that sound driver?

I don't really understand, didn't you write a few lines above that the
IRQ shows also up
when you open the device? Why do you need the IRQ earlier?

-- 
Thanks,
//richard

