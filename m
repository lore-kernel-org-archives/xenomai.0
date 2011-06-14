Message-ID: <4DF7781F.6060409@domain.hid>
Date: Tue, 14 Jun 2011 17:02:55 +0200
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Xenomai 2.5.6 and 2.6.38.8 kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

When trying to compile 2.5.6 with adeos-ipipe-2.6.38.8-x86-2.10-00.patch,=
 I get
the following error:

  CC      arch/x86/xenomai/hal_32.o
arch/x86/xenomai/hal_32.c: In function =91rthal_arch_init=92:
arch/x86/xenomai/hal_32.c:341:6: error: =91nmi_watchdog=92 undeclared (fi=
rst use in
this function)
arch/x86/xenomai/hal_32.c:341:6: note: each undeclared identifier is repo=
rted
only once for each function it appears in
arch/x86/xenomai/hal_32.c:341:22: error: =91NMI_IO_APIC=92 undeclared (fi=
rst use in
this function)

Somebody that has a patch to work around this problem?

Regards

Anders Blomdell

--=20
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden


