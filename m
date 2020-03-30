In-Reply-To: <OFE47A3410.5F2DBC65-ONC125853B.0053B5B9@LocalDomain>
Subject: Odp: Re: Serial driver 16550a on Beaglebone Black
From: "=?ISO-8859-2?Q?Micha=B3_Hanusek?=" <mhanusek@energotest.com.pl>
Date: Mon, 30 Mar 2020 18:21:02 +0200
References: <OFE47A3410.5F2DBC65-ONC125853B.0053B5B9@LocalDomain>,
 <mailman.77.1585580886.1004.xenomai@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-ID: <mailman.78.1585585273.1004.xenomai@xenomai.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Content-Transfer-Encoding: 8bit
To: greg@embeddedgreg.com
Cc: xenomai@xenomai.org

     On Mon, Mar 30, 2020 at 11:08 AM Michał Hanusek via Xenomai
     <xenomai@xenomai.org> wrote:
     >
     >
     > Hello.
     > How to enable a driver 16550a (xeno_16550A) and configure the
     serial port?
     >
     > I loaded the driver to the kernel (for the /dev/ttyS4 port) but
     the device in the /dev/rtdm/rtser... location did not appear.
     Do you have the vanilla kernel driver loaded as well?  You need to
     unbind the serial port you want the 16550A to work with.
     I don't think this has been tested on beaglebone black but I could
     be wrong.

     I'm use kernel
     from [1]https://github.com/beagleboard/linux/tree/4.9-xenomai

     >
     > Please help.
     >
     > Linux kernel 4.9.88 + Xenomai patch
     >
     I would use a newer kernel and ipipe patch, 4.9 is currently no
     supported.  I don't think it get the gpio fixes either.
     Newer kernel? The newest kernel for BBB (with xenomai) is:

     [2]https://github.com/beagleboard/linux/tree/4.14-xenomai

     > root@beaglebone:/home/debian# lsmod
     > Module                  Size  Used by
     > xeno_16550A            17350  0
     >
     > root@beaglebone:/home/debian# modprobe xeno_16550A io=0x481A8000
     irq=159 baud_base=115200 start_index=0
     >
     > root@beaglebone:/home/debian# cat /proc/tty/driver/serial
     > serinfo:1.0 driver revision:
     > 0: uart:8250 mmio:0x44E09000 irq:158 tx:11568 rx:98 brk:63
     RTS|CTS|DTR|DSR
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
     > autotune        memdev-private  memdev-shared   memdev-sys
     switchtest      timerbench
     > Szanujemy Twoją prywatność, dbamy o bezpieczeństwo Twoich danych
     osobowych,  Sprawdź szczegóły !
     -Greg
     >

   Szanujemy Twoją prywatność, dbamy o bezpieczeństwo Twoich danych
   osobowych, [3]Sprawdź szczegóły!

References

   1. https://github.com/beagleboard/linux/tree/4.9-xenomai
   2. https://github.com/beagleboard/linux/tree/4.14-xenomai
   3. http://www.energotest.com.pl/o-firmie/polityka-prywatności.html
