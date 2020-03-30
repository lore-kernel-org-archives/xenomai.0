MIME-Version: 1.0
References: <OFE47A3410.5F2DBC65-ONC125853B.0053B5B9@LocalDomain>
 <mailman.77.1585580886.1004.xenomai@xenomai.org>
 <mailman.78.1585585273.1004.xenomai@xenomai.org>
 <OFE64A70E5.1C5DA65E-ONC125853B.005BB303@LocalDomain>
 <mailman.81.1585587423.1004.xenomai@xenomai.org>
In-Reply-To: <mailman.81.1585587423.1004.xenomai@xenomai.org>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 30 Mar 2020 13:20:51 -0400
Message-ID: <CALLqZ8SXWxW3d_6Vh+Wh=54KUMKHGRCJ9MzVdC3Y=xds5wqrbw@mail.gmail.com>
Subject: Re: Re: Odp: Re: Serial driver 16550a on Beaglebone Black
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
Cc: Jan Kiszka <jan.kiszka@web.de>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Mar 30, 2020 at 12:58 PM Micha=C5=82 Hanusek via Xenomai
<xenomai@xenomai.org> wrote:
>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  Do: Micha=C5=82 Hanusek <mhanusek@energotest.com.pl>, greg@embeddedgreg.=
com
>  Od: Jan Kiszka <jan.kiszka@web.de>
>  Data: 2020-03-30 06:41PM
>  DW: xenomai@xenomai.org
>  Temat: Re: Odp: Re: Serial driver 16550a on Beaglebone Black
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    On 30.03.20 18:21, Micha=C5=82 Hanusek via Xenomai wrote:
> >       On Mon, Mar 30, 2020 at 11:08 AM Micha=C5=82 Hanusek via Xenomai
> >       <xenomai@xenomai.org> wrote:
> >       >
> >       >
> >       > Hello.
> >       > How to enable a driver 16550a (xeno_16550A) and configure the
> >       serial port?
> >       >
> >       > I loaded the driver to the kernel (for the /dev/ttyS4 port) but
> >       the device in the /dev/rtdm/rtser... location did not appear.
> >       Do you have the vanilla kernel driver loaded as well?  You need t=
o
> >       unbind the serial port you want the 16550A to work with.
> >       I don't think this has been tested on beaglebone black but I coul=
d
> >       be wrong.
> >
> >       I'm use kernel
> >       from [1]https://github.com/beagleboard/linux/tree/4.9-xenomai
> >
>
> Don't do this. This is a downstream integration of unknown quality. And
> it is definitely outdated. We support the BBB with proper upstream
> kernels + the I-pipe patch, and that is frequently tested.
>
> That said, where does the 16550A-compatible uart come from on your BBB?
> It has omap3 uarts in its SOC.
>
> Jan
>
>
> Im completely newbie.
> My main goal is to run the Application using serial ports on BeagleBone B=
lack (Linux / Xenomai).
>
> What should I use?
> Linux kernel 5.6 + i-pipe?
> Which driver should I use?
> M.H
Here's a good start:

https://gitlab.denx.de/Xenomai/xenomai/-/wikis/Setting_Up

For kernel version, use the ipipe-arm kernel, you can clone it from
the git repot:
https://gitlab.denx.de/Xenomai/ipipe-arm

or you can use the patches that are created instead and located on gitlab.

To Jan's point if you don't know if you can use the 16550A driver with
your SOC you may want to confirm before going any further.  Currently
the SPI and gpio drivers are supported so if you are looking to get
familiar with Xenomai it may be easier to use a SPI device or create
some code that plays with GPIO hardware.  I'm not sure if that would
help.

You can also use Xenomai images to get up and running fairly quick
with BBB but I'm just getting to know that area now so I'll defer to
someone else to help with that.


>
> >       >
> >       > Please help.
> >       >
> >       > Linux kernel 4.9.88 + Xenomai patch
> >       >
> >       I would use a newer kernel and ipipe patch, 4.9 is currently no
> >       supported.  I don't think it get the gpio fixes either.
> >       Newer kernel? The newest kernel for BBB (with xenomai) is:
> >
> >       [2]https://github.com/beagleboard/linux/tree/4.14-xenomai
> >
> >       > root@beaglebone:/home/debian# lsmod
> >       > Module                  Size  Used by
> >       > xeno_16550A            17350  0
> >       >
> >       > root@beaglebone:/home/debian# modprobe xeno_16550A io=3D0x481A8=
000
> >       irq=3D159 baud_base=3D115200 start_index=3D0
> >       >
> >       > root@beaglebone:/home/debian# cat /proc/tty/driver/serial
> >       > serinfo:1.0 driver revision:
> >       > 0: uart:8250 mmio:0x44E09000 irq:158 tx:11568 rx:98 brk:63
> >       RTS|CTS|DTR|DSR
> >       > 1: uart:unknown port:00000000 irq:0
> >       > 2: uart:unknown port:00000000 irq:0
> >       > 3: uart:unknown port:00000000 irq:0
> >       > 4: uart:8250 mmio:0x481A8000 irq:159 tx:2 rx:1 brk:1 CTS|DSR
> >       > 5: uart:unknown port:00000000 irq:0
> >       >
> >       > root@beaglebone:/home/debian# setserial /dev/ttyS4
> >       > /dev/ttyO4, UART: 8250, Port: 0x0000, IRQ: 159
> >       >
> >       > root@beaglebone:/home/debian# ls /dev/rtdm/
> >       > autotune        memdev-private  memdev-shared   memdev-sys
> >       switchtest      timerbench
> >       > Szanujemy Twoj=C4=85 prywatno=C5=9B=C4=87, dbamy o bezpiecze=C5=
=84stwo Twoich danych
> >       osobowych,  Sprawd=C5=BA szczeg=C3=B3=C5=82y !
> >       -Greg
> >       >
> >
> >     Szanujemy Twoj=C4=85 prywatno=C5=9B=C4=87, dbamy o bezpiecze=C5=84s=
two Twoich danych
> >     osobowych, [3]Sprawd=C5=BA szczeg=C3=B3=C5=82y!
> >
> > References
> >
> >     1. https://github.com/beagleboard/linux/tree/4.9-xenomai
> >     2. https://github.com/beagleboard/linux/tree/4.14-xenomai
> >     3. http://www.energotest.com.pl/o-firmie/polityka-prywatno=C5=9Bci.=
html
> >
>
>     Szanujemy Twoj=C4=85 prywatno=C5=9B=C4=87, dbamy o bezpiecze=C5=84stw=
o Twoich danych osobowych,  Sprawd=C5=BA szczeg=C3=B3=C5=82y !
>

-Greg

