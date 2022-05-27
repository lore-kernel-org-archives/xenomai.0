MIME-Version: 1.0
References: <CA+K1mPGZhf9Rg+ywyoffiy+jn0BuM_n7D4C7exyS5MKQK+UW6Q@mail.gmail.com>
 <CAFLxGvzpxq=5GTWsXJbCyYVDTDnP6ab8KKTcNVMAn7kGiX-RPQ@mail.gmail.com>
 <CA+K1mPGfRDQsW_d=Rq+O50sHzJtSEsRLvimLqfCzcBawgiQnAg@mail.gmail.com>
 <CAFLxGvw7RQFx8ESxxiJ51wpykfcbp6q85wer3sH6Rx9FBfvAWw@mail.gmail.com>
 <CA+K1mPGprv51onDpDEv1Vo5nEwTbv99J-hZPP+6gtUgBCdx3Zw@mail.gmail.com>
 <1268724685.102689.1653640441692.JavaMail.zimbra@nod.at>
In-Reply-To: <1268724685.102689.1653640441692.JavaMail.zimbra@nod.at>
From: C Smith <csmithquestions@gmail.com>
Date: Fri, 27 May 2022 15:02:26 -0700
Message-ID: <CA+K1mPGsBcdLe+-0-dc1DUtN-KO9jQERo4enXzR+6sVWGP8uaQ@mail.gmail.com>
Subject: Re: 16550A IRQ not enabled
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard@nod.at>
Cc: xenomai <xenomai@xenomai.org>

On Fri, May 27, 2022 at 1:34 AM Richard Weinberger <richard@nod.at> wrote:
> ----- Urspr=C3=BCngliche Mail -----
> > An update:
> > If the 16550A driver is modprobed with no arguments, it apparently
> > probes the PCI subsystem, gets the irq, and interrupts are enabled OK.
> > The serial port can send/receive data.
> > But, if a port=3D or irq=3D argument is passed into the 16550A driver,
> > then the driver seems to skip probing the PCI syubsystem, and the
> > driver fails to enable the irq. No data can transmitted or received by
> > the port, even though the driver has done an  rtdm_irq_request() of
> > the correct irq level.
> >
> > This is a problem for my application because I have 6 serial ports and
> > some must have different baud_base args, which is now impossible with
> > this inconsistent driver behavior.
>
> And just passing baud_base=3DX,Y,..,Z does not work?
> Sure this is still hacky since it depends on the PCI probe order...
>
> We could make baud_base configurable via ioctl, the driver supports alrea=
dy
> plenty of them.
> Or exposing this and other properties as sysfs attributes.
>
> Further I suggest splitting the driver in at at least two kernel modules.
> One for PCI and another one for legacy PIO/PNP.
> The current probe interface is IMHO confusing and error prone.
>
> Thanks,
> //richard

After a 16550A_pci.h driver modification, I got this all to work
finally, with interrupts enabled for all of my 6 serial ports. This is
the modprobe command line:
modprobe xeno_16550A io=3D0x3f8,0x2f8 irq=3D4,3
baud_base=3D115200,115200,460800,460800,460800,460800
Note that those first two ports above are are legacy (ISA) addresses,
not PCI cards. The last four baud_base args above are for the four
ports on the Moxa PCI card. By not specifying an io=3D,irq=3D for the PCI
ports we let the driver do a pci_resource_start() and the interrupts
are automagically enabled.

Here is the code I had to hack to get this to work.
static int rt_16550_pci_probe()
...
    for (i =3D 0; i < MAX_DEVICES; i++) {
        ...
            baud_base[i] =3D board->baud_base;

That last line was clobbering baud_base[] with defaults, even if I put
a new baud_base on the modprobe command line. With that last line
commented out the modprobe baud_base arguments succeed.

But per Richard W's other comments, this all only works if the PCI
probe gets things in the same order, but it seems to be consistent on
my system.

-C Smith

