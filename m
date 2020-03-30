Subject: Re: Odp: Re: Serial driver 16550a on Beaglebone Black
References: <OFE47A3410.5F2DBC65-ONC125853B.0053B5B9@LocalDomain>
 <mailman.77.1585580886.1004.xenomai@xenomai.org>
 <mailman.78.1585585273.1004.xenomai@xenomai.org>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <9416bf6c-3b3a-32ad-a62f-86a885c9bb07@web.de>
Date: Mon, 30 Mar 2020 18:41:29 +0200
MIME-Version: 1.0
In-Reply-To: <mailman.78.1585585273.1004.xenomai@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?Micha=c5=82_Hanusek?= <mhanusek@energotest.com.pl>, greg@embeddedgreg.com
Cc: xenomai@xenomai.org

On 30.03.20 18:21, Micha=C5=82 Hanusek via Xenomai wrote:
>       On Mon, Mar 30, 2020 at 11:08 AM Micha=C5=82 Hanusek via Xenomai
>       <xenomai@xenomai.org> wrote:
>       >
>       >
>       > Hello.
>       > How to enable a driver 16550a (xeno_16550A) and configure the
>       serial port?
>       >
>       > I loaded the driver to the kernel (for the /dev/ttyS4 port) but
>       the device in the /dev/rtdm/rtser... location did not appear.
>       Do you have the vanilla kernel driver loaded as well?  You need to
>       unbind the serial port you want the 16550A to work with.
>       I don't think this has been tested on beaglebone black but I could
>       be wrong.
>
>       I'm use kernel
>       from [1]https://github.com/beagleboard/linux/tree/4.9-xenomai
>

Don't do this. This is a downstream integration of unknown quality. And
it is definitely outdated. We support the BBB with proper upstream
kernels + the I-pipe patch, and that is frequently tested.

That said, where does the 16550A-compatible uart come from on your BBB?
It has omap3 uarts in its SOC.

Jan

>       >
>       > Please help.
>       >
>       > Linux kernel 4.9.88 + Xenomai patch
>       >
>       I would use a newer kernel and ipipe patch, 4.9 is currently no
>       supported.  I don't think it get the gpio fixes either.
>       Newer kernel? The newest kernel for BBB (with xenomai) is:
>
>       [2]https://github.com/beagleboard/linux/tree/4.14-xenomai
>
>       > root@beaglebone:/home/debian# lsmod
>       > Module                  Size  Used by
>       > xeno_16550A            17350  0
>       >
>       > root@beaglebone:/home/debian# modprobe xeno_16550A io=3D0x481A80=
00
>       irq=3D159 baud_base=3D115200 start_index=3D0
>       >
>       > root@beaglebone:/home/debian# cat /proc/tty/driver/serial
>       > serinfo:1.0 driver revision:
>       > 0: uart:8250 mmio:0x44E09000 irq:158 tx:11568 rx:98 brk:63
>       RTS|CTS|DTR|DSR
>       > 1: uart:unknown port:00000000 irq:0
>       > 2: uart:unknown port:00000000 irq:0
>       > 3: uart:unknown port:00000000 irq:0
>       > 4: uart:8250 mmio:0x481A8000 irq:159 tx:2 rx:1 brk:1 CTS|DSR
>       > 5: uart:unknown port:00000000 irq:0
>       >
>       > root@beaglebone:/home/debian# setserial /dev/ttyS4
>       > /dev/ttyO4, UART: 8250, Port: 0x0000, IRQ: 159
>       >
>       > root@beaglebone:/home/debian# ls /dev/rtdm/
>       > autotune        memdev-private  memdev-shared   memdev-sys
>       switchtest      timerbench
>       > Szanujemy Twoj=C4=85 prywatno=C5=9B=C4=87, dbamy o bezpiecze=C5=
=84stwo Twoich danych
>       osobowych,  Sprawd=C5=BA szczeg=C3=B3=C5=82y !
>       -Greg
>       >
>
>     Szanujemy Twoj=C4=85 prywatno=C5=9B=C4=87, dbamy o bezpiecze=C5=84st=
wo Twoich danych
>     osobowych, [3]Sprawd=C5=BA szczeg=C3=B3=C5=82y!
>
> References
>
>     1. https://github.com/beagleboard/linux/tree/4.9-xenomai
>     2. https://github.com/beagleboard/linux/tree/4.14-xenomai
>     3. http://www.energotest.com.pl/o-firmie/polityka-prywatno=C5=9Bci.h=
tml
>


