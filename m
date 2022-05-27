Date: Fri, 27 May 2022 10:34:01 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1268724685.102689.1653640441692.JavaMail.zimbra@nod.at>
In-Reply-To: <CA+K1mPGprv51onDpDEv1Vo5nEwTbv99J-hZPP+6gtUgBCdx3Zw@mail.gmail.com>
References: <CA+K1mPGZhf9Rg+ywyoffiy+jn0BuM_n7D4C7exyS5MKQK+UW6Q@mail.gmail.com>
 <CAFLxGvzpxq=5GTWsXJbCyYVDTDnP6ab8KKTcNVMAn7kGiX-RPQ@mail.gmail.com>
 <CA+K1mPGfRDQsW_d=Rq+O50sHzJtSEsRLvimLqfCzcBawgiQnAg@mail.gmail.com>
 <CAFLxGvw7RQFx8ESxxiJ51wpykfcbp6q85wer3sH6Rx9FBfvAWw@mail.gmail.com>
 <CA+K1mPGprv51onDpDEv1Vo5nEwTbv99J-hZPP+6gtUgBCdx3Zw@mail.gmail.com>
Subject: Re: 16550A IRQ not enabled
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: C Smith <csmithquestions@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

----- Urspr=C3=BCngliche Mail -----
> An update:
> If the 16550A driver is modprobed with no arguments, it apparently
> probes the PCI subsystem, gets the irq, and interrupts are enabled OK.
> The serial port can send/receive data.
> But, if a port=3D or irq=3D argument is passed into the 16550A driver,
> then the driver seems to skip probing the PCI syubsystem, and the
> driver fails to enable the irq. No data can transmitted or received by
> the port, even though the driver has done an  rtdm_irq_request() of
> the correct irq level.
>=20
> This is a problem for my application because I have 6 serial ports and
> some must have different baud_base args, which is now impossible with
> this inconsistent driver behavior.

And just passing baud_base=3DX,Y,..,Z does not work?
Sure this is still hacky since it depends on the PCI probe order...

We could make baud_base configurable via ioctl, the driver supports already
plenty of them.
Or exposing this and other properties as sysfs attributes.

Further I suggest splitting the driver in at at least two kernel modules.
One for PCI and another one for legacy PIO/PNP.
The current probe interface is IMHO confusing and error prone.

Thanks,
//richard

