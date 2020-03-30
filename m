MIME-Version: 1.0
References: <mailman.77.1585580886.1004.xenomai@xenomai.org>
In-Reply-To: <mailman.77.1585580886.1004.xenomai@xenomai.org>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 30 Mar 2020 11:14:05 -0400
Message-ID: <CALLqZ8QaqLjRkgg1kC7BmsnQBzqe1Kabj7HHJKe3bHa-F_O+aA@mail.gmail.com>
Subject: Re: Serial driver 16550a on Beaglebone Black
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

On Mon, Mar 30, 2020 at 11:08 AM Micha=C5=82 Hanusek via Xenomai
<xenomai@xenomai.org> wrote:
>
>
> Hello.
> How to enable a driver 16550a (xeno_16550A) and configure the serial port=
?
>
> I loaded the driver to the kernel (for the /dev/ttyS4 port) but the devic=
e in the /dev/rtdm/rtser... location did not appear.

Do you have the vanilla kernel driver loaded as well?  You need to
unbind the serial port you want the 16550A to work with.
I don't think this has been tested on beaglebone black but I could be wrong=
.
>
> Please help.
>
> Linux kernel 4.9.88 + Xenomai patch
>
I would use a newer kernel and ipipe patch, 4.9 is currently no
supported.  I don't think it get the gpio fixes either.

> root@beaglebone:/home/debian# lsmod
> Module                  Size  Used by
> xeno_16550A            17350  0
>
> root@beaglebone:/home/debian# modprobe xeno_16550A io=3D0x481A8000 irq=3D=
159 baud_base=3D115200 start_index=3D0
>
> root@beaglebone:/home/debian# cat /proc/tty/driver/serial
> serinfo:1.0 driver revision:
> 0: uart:8250 mmio:0x44E09000 irq:158 tx:11568 rx:98 brk:63 RTS|CTS|DTR|DS=
R
> 1: uart:unknown port:00000000 irq:0
> 2: uart:unknown port:00000000 irq:0
> 3: uart:unknown port:00000000 irq:0
> 4: uart:8250 mmio:0x481A8000 irq:159 tx:2 rx:1 brk:1 CTS|DSR
> 5: uart:unknown port:00000000 irq:0
>
> root@beaglebone:/home/debian# setserial /dev/ttyS4
> /dev/ttyO4, UART: 8250, Port: 0x0000, IRQ: 159
>
> root@beaglebone:/home/debian# ls /dev/rtdm/
> autotune        memdev-private  memdev-shared   memdev-sys      switchtes=
t      timerbench
> Szanujemy Twoj=C4=85 prywatno=C5=9B=C4=87, dbamy o bezpiecze=C5=84stwo Tw=
oich danych osobowych,  Sprawd=C5=BA szczeg=C3=B3=C5=82y !

-Greg
>

