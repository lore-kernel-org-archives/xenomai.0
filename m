Message-ID: <4404AE22.3050600@domain.hid>
Date: Tue, 28 Feb 2006 13:10:10 -0700
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-core] 16550 compile err:
 =?windows-1252?q?=91RTDM=5FIRQ=5FENABLE=92_und?=
 =?windows-1252?q?eclared_=28first_use_in_this_function=29?=
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

  LD      drivers/xenomai/16550A/built-in.o
  CC [M]  drivers/xenomai/16550A/16550A.o
/mnt/dilbert/jimc/dilbert/lxbuild/linux-2.6.15.1-ipipe-121/drivers/xenomai/=
16550A/16550A.c:=20
In function =91rt_16550_interrupt=92:
/mnt/dilbert/jimc/dilbert/lxbuild/linux-2.6.15.1-ipipe-121/drivers/xenomai/=
16550A/16550A.c:269:=20
error: =91RTDM_IRQ_ENABLE=92 undeclared (first use in this function)
/mnt/dilbert/jimc/dilbert/lxbuild/linux-2.6.15.1-ipipe-121/drivers/xenomai/=
16550A/16550A.c:269:=20
error: (Each undeclared identifier is reported only once
/mnt/dilbert/jimc/dilbert/lxbuild/linux-2.6.15.1-ipipe-121/drivers/xenomai/=
16550A/16550A.c:269:=20
error: for each function it appears in.)
make[4]: *** [drivers/xenomai/16550A/16550A.o] Error 1
make[3]: *** [drivers/xenomai/16550A] Error 2
make[2]: *** [drivers/xenomai] Error 2
make[1]: *** [drivers] Error 2
make: *** [_all] Error 2


I de-configured 16550, it built fine, so I suspect some recent change=20
missed this item.

that said, I havent tried _NOENABLE, since im guessing blind.

