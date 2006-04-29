From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sat, 29 Apr 2006 18:50:35 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200604291850.36231.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Problems compiling arch/ppc/xmon/xmon.o
	(CONFIG_XMON=y)
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi

After a clean checkout of xenomai (r1016) and with a config
which defines CONFIG_XMON I get the following errors:
  CC      arch/ppc/xmon/xmon.o
In file included=20
from /mnt/data.ng/hcu/kernel/ppc/linux-2.6.14/arch/ppc/xmon/xmon.c:23:
/mnt/data.ng/hcu/kernel/ppc/linux-2.6.14/arch/ppc/xmon/privinst.h:26: error=
:=20
conflicting types for =E2=80=98get_rtcu=E2=80=99
include2/asm/time.h:102: error: previous definition of =E2=80=98get_rtcu=E2=
=80=99 was here
/mnt/data.ng/hcu/kernel/ppc/linux-2.6.14/arch/ppc/xmon/privinst.h:27: error=
:=20
conflicting types for =E2=80=98get_rtcl=E2=80=99
include2/asm/time.h:95: error: previous definition of =E2=80=98get_rtcl=E2=
=80=99 was here
/mnt/data.ng/hcu/kernel/ppc/linux-2.6.14/arch/ppc/xmon/privinst.h:32: error=
:=20
conflicting types for =E2=80=98get_dec=E2=80=99
include2/asm/time.h:39: error: previous definition of =E2=80=98get_dec=E2=
=80=99 was here
/mnt/data.ng/hcu/kernel/ppc/linux-2.6.14/arch/ppc/xmon/privinst.h:32: error=
:=20
conflicting types for =E2=80=98set_dec=E2=80=99
include2/asm/time.h:48: error: previous definition of =E2=80=98set_dec=E2=
=80=99 was here
make[2]: *** [arch/ppc/xmon/xmon.o] Fehler 1
make[1]: *** [arch/ppc/xmon] Fehler 2

Best regards
=2D-=20
Niklaus Giger

