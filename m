Subject: Serial driver 16550a on Beaglebone Black
From: "=?ISO-8859-2?Q?Micha=B3_Hanusek?=" <mhanusek@energotest.com.pl>
Date: Mon, 30 Mar 2020 17:08:01 +0200
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <mailman.77.1585580886.1004.xenomai@xenomai.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


Hello.
How to enable a driver 16550a (xeno=5F16550A) and configure the serial port?

I loaded the driver to the kernel (for the /dev/ttyS4 port) but the device =
in the /dev/rtdm/rtser... location did not appear.

Please help.

Linux kernel 4.9.88 + Xenomai patch

root@beaglebone:/home/debian# lsmod
Module                  Size  Used by
xeno=5F16550A            17350  0

root@beaglebone:/home/debian# modprobe xeno=5F16550A io=3D0x481A8000 irq=3D=
159 baud=5Fbase=3D115200 start=5Findex=3D0

root@beaglebone:/home/debian# cat /proc/tty/driver/serial
serinfo:1.0 driver revision:
0: uart:8250 mmio:0x44E09000 irq:158 tx:11568 rx:98 brk:63 RTS|CTS|DTR|DSR
1: uart:unknown port:00000000 irq:0
2: uart:unknown port:00000000 irq:0
3: uart:unknown port:00000000 irq:0
4: uart:8250 mmio:0x481A8000 irq:159 tx:2 rx:1 brk:1 CTS|DSR
5: uart:unknown port:00000000 irq:0

root@beaglebone:/home/debian# setserial /dev/ttyS4=20
/dev/ttyO4, UART: 8250, Port: 0x0000, IRQ: 159

root@beaglebone:/home/debian# ls /dev/rtdm/
autotune        memdev-private  memdev-shared   memdev-sys      switchtest =
     timerbench=20
Szanujemy Twoj=C4=85 prywatno=C5=9B=C4=87, dbamy o bezpiecze=C5=84stwo Twoi=
ch danych osobowych,  Sprawd=C5=BA szczeg=C3=B3=C5=82y ! =
=


