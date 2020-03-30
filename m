MIME-Version: 1.0
References: <mailman.77.1585580886.1004.xenomai@xenomai.org>
 <OFE47A3410.5F2DBC65-ONC125853B.0053B5B9@LocalDomain>
 <5e821c74.1c69fb81.fcf31.a485SMTPIN_ADDED_MISSING@mx.google.com>
In-Reply-To: <5e821c74.1c69fb81.fcf31.a485SMTPIN_ADDED_MISSING@mx.google.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 30 Mar 2020 12:34:56 -0400
Message-ID: <CALLqZ8TBcoKkCnNuhqNmavx1Rue3zZXe491YMsGszM2S5VDvng@mail.gmail.com>
Subject: Re: Re: Serial driver 16550a on Beaglebone Black
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
To: =?UTF-8?Q?Micha=C5=82_Hanusek?= <mhanusek@energotest.com.pl>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Mar 30, 2020 at 12:21 PM Micha=C5=82 Hanusek
<mhanusek@energotest.com.pl> wrote:
>
>
> On Mon, Mar 30, 2020 at 11:08 AM Micha=C5=82 Hanusek via Xenomai
> <xenomai@xenomai.org> wrote:
> >
> >
> > Hello.
> > How to enable a driver 16550a (xeno_16550A) and configure the serial po=
rt?
> >
> > I loaded the driver to the kernel (for the /dev/ttyS4 port) but the dev=
ice in the /dev/rtdm/rtser... location did not appear.
>
> Do you have the vanilla kernel driver loaded as well?  You need to
> unbind the serial port you want the 16550A to work with.
> I don't think this has been tested on beaglebone black but I could be wro=
ng.
>
> I'm use kernel from https://github.com/beagleboard/linux/tree/4.9-xenomai

Since the linux drivers bind to this hardware interface you'll need to
unbind and then load the RT driver.  This is older but it helps:
https://wiki.emacinc.com/wiki/Xenomai_RTSerial

I guess once this gets tested out we should add official docs at some point=
.

>
> >
> > Please help.
> >
> > Linux kernel 4.9.88 + Xenomai patch
> >
> I would use a newer kernel and ipipe patch, 4.9 is currently no
> supported.  I don't think it get the gpio fixes either.
>
> Newer kernel? The newest kernel for BBB (with xenomai) is:
>
> https://github.com/beagleboard/linux/tree/4.14-xenomai

The ipipe-arm kernel that is maintained by this community and is
tested with Xenomai is at 4.19 and supports the beaglebone black.
It's based off the CIP kernel or the stable tree depending on the
patch you pick.
The documentation on gitlab goes over using a mainline kernel.

>
>
>
> > root@beaglebone:/home/debian# lsmod
> > Module                  Size  Used by
> > xeno_16550A            17350  0
> >
> > root@beaglebone:/home/debian# modprobe xeno_16550A io=3D0x481A8000 irq=
=3D159 baud_base=3D115200 start_index=3D0
> >
> > root@beaglebone:/home/debian# cat /proc/tty/driver/serial
> > serinfo:1.0 driver revision:
> > 0: uart:8250 mmio:0x44E09000 irq:158 tx:11568 rx:98 brk:63 RTS|CTS|DTR|=
DSR
> > 1: uart:unknown port:00000000 irq:0
> > 2: uart:unknown port:00000000 irq:0
> > 3: uart:unknown port:00000000 irq:0
> > 4: uart:8250 mmio:0x481A8000 irq:159 tx:2 rx:1 brk:1 CTS|DSR
> > 5: uart:unknown port:00000000 irq:0
> >
> > root@beaglebone:/home/debian# setserial /dev/ttyS4
> > /dev/ttyO4, UART: 8250, Port: 0x0000, IRQ: 159
> >
> > root@beaglebone:/home/debian# ls /dev/rtdm/
> > autotune        memdev-private  memdev-shared   memdev-sys      switcht=
est      timerbench
> > Szanujemy Twoj=C4=85 prywatno=C5=9B=C4=87, dbamy o bezpiecze=C5=84stwo =
Twoich danych osobowych,  Sprawd=C5=BA szczeg=C3=B3=C5=82y !
>
> -Greg
> >
>
> Szanujemy Twoj=C4=85 prywatno=C5=9B=C4=87, dbamy o bezpiecze=C5=84stwo Tw=
oich danych osobowych, Sprawd=C5=BA szczeg=C3=B3=C5=82y!

Thanks

Greg

