From: =?iso-8859-1?Q?Terje_Fr=F8ysa?= <Terje.Froysa@sintef.no>
Date: Thu, 6 Nov 2014 16:00:46 +0000
Message-ID: <314E5ECDAA86314791309FA670550F89C6765D87@SINTEFEXMBX05.sintef.no>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Applying the xeno-16550A driver on Beaglebone Black
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Dear Forum,
I need a confirmation on my understanding of the xeno-16550A install.

I have been studying the following URL's:
http://xenomai.org/serial-16550a-driver/
https://www.marshut.net/ihwimw/fail-to-load-the-xeno-16550a-real-time-seria=
l-port-driver-on-beaglebone-black.html

I have already enabled the in-kernel compile of the xeno-16550A and both io=
-port and memory mapped access.
Thus, I guess the Xenomai " In-Kernel Driver Setup" will apply.

By reading Gilles advices of the second URL, I guess I have to


=B7         disable the  OMAP serial driver by turning off CONFIG_SERIAL_OM=
AP in kernel configuration and

=B7         turn on CONFIG_SERIAL_8250 and observe that the console will ch=
ange name from /dev/ttyO2 to /dev/ttyS2.

=B7         re-compile the kernel

Beside this I need to know where I should enter the xeno-16550 configuratio=
n statements:
xeno_16550A.mem=3D0x48xxxxxxx, etc...
Can enter the parameters such that I can specify all parameters:
xeno_16550A.mem=3D<addr>[,...] irq=3D<no>[,...] baud_base=3D<val>[,...] tx_=
fifo=3D<val>[,...] start_index=3D<val>[,...]

As the xeon_16550A is a RTDM driver, I guess the device files will appear a=
s "rtserX" under the /proc/xenomai/rtdm ?

Best regards
Terje Froysa

Smail: Terje Fr=F8ysa, SINTEF ICT (Information and Communication Technology=
), N-7465 Trondheim, Norway.
Email: terje.froysa@sintef.no<blocked::mailto:terje.froysa@sintef.no> <mail=
to:terje.froysa@sintef.no<blocked::mailto:terje.froysa@sintef.no>>
Phone: +47 930 03603
Company: Independent R&D, see <http://www.sintef.no/<blocked::http://www.si=
ntef.no/>

