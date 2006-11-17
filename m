Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 17 Nov 2006 15:35:12 +0100
From: karre@domain.hid
Message-ID: <20061117143512.191580@domain.hid>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] System freezes with Xenomai 2.2.5 and kernel 2.6.17
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I tried to install a real time system using Suse Linux 10.1 with a Vanilla-=
Kernel 2.6.17 and Xenomai 2.2.5.

There were no error messages except "Cannot determine dependencies of modul=
e reiserfs", though the system was bootable and actually had access to reis=
erfs-partitions.

Another suspicious fact was numberous "nothing to do"-messages during compi=
lation of Xenomai.

Now the system is bootable and Xenomai reported that hal&x86, real-time nuc=
leus, nataive API, POSIX and RDTM services had started. Unfortunately, the =
system freezes unrecoverably shortly after login.

Can this be cause of I couldn't include "Interrupt pipeline" into the kerne=
l? There was no way to elect it in menuconfig, there was --- instead of [ ]=
, [*] or [M] beneath this option.

Thank you in advance for any advice!

Richard

--=20
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!=20
Ideal f=FCr Modem und ISDN: http://www.gmx.net/de/go/smartsurfer

