Date: Tue, 18 Aug 2015 16:26:52 +0000 (UTC)
From: Frederik Bayart <frederik_bayart@yahoo.co.uk>
Message-ID: <171658328.6961247.1439915212899.JavaMail.yahoo@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] xeno 3-rc7 : rtcanconfig fails to set baudrate
Reply-To: Frederik Bayart <frederik_bayart@yahoo.co.uk>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I have build xeno-3.0.rc7 with kernel 3.18.12.
I have a PEAK-PCIe CAN card in my system.
Drivers are loaded and rtcan0 en rtcan1 are created in /proc/rtcan.

However, I'm not able to set the baudrate when I'm execute 'rtcanconfig rtc=
an0 -v -b 1000000 start'

By adding debug statements in rtcanconfig, I found that ioctl(can_fd, SIOCS=
CANBAUDRATE, &u.ifr); fails,

errno gives : SIOCSCANBAUDRATE(errno=3D19): No such device

Below the output of rtcan0/info and xeno-config --info

Any suggestions ?

Frederik


$cat ./rtcan0/info=20
Device=C2=A0=C2=A0=C2=A0=C2=A0 rtcan0
Controller SJA1000
Board=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PEAK-PCI
Clock-Hz=C2=A0=C2=A0 8000000
Baudrate=C2=A0=C2=A0 undefined
Bit-time=C2=A0=C2=A0 brp=3D0 prop_seg=3D0 phase_seg1=3D0 phase_seg2=3D0 sjw=
=3D0 sam=3D0
Ctrl-Mode=C2=A0=20
State=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stopped
TX-Counter 0
RX-Counter 0
Errors=C2=A0=C2=A0=C2=A0=C2=A0 0
Refcount=C2=A0=C2=A0 0


$ xeno-config --info
Xenomai version: Xenomai/cobalt v3.0-rc7 --=20
Linux dev1 3.18.12-x86-64-xeno-3.0.rc7 #1 SMP PREEMPT Tue Aug 18 16:33:55 C=
EST 2015 x86_64 GNU/Linux
Kernel parameters: BOOT_IMAGE=3D/vmlinuz-3.18.12-x86-64-xeno-3.0.rc7 root=
=3DUUID=3D20f2dd2f-f02f-4b82-8538-8fe52e55a8ff ro quiet
I-pipe release #1 detected
Cobalt core 3.0-rc7 detected
Compiler: gcc version 4.9.2 (Debian 4.9.2-10)=20
Build args: --prefix=3D/usr --includedir=3D/usr/include/xenomai --mandir=3D=
/usr/share/man --with-testdir=3D/usr/lib/xenomai/testsuite --with-core=3Dco=
balt --enable-smp --enable-pshared --enable-registry --build x86_64-linux-g=
nu build_alias=3Dx86_64-linux-gnu

