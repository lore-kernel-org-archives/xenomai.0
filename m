From: steven.seeger flightsystems.net <steven.seeger@flightsystems.net>
Subject: Re: [PATCH 0/4] Drop PowerPC architecture
Date: Wed, 15 Dec 2021 19:25:38 +0000
Message-ID: <DM6PR05MB45062ED506E7DA3747B05977F7769@DM6PR05MB4506.namprd05.prod.outlook.com>
References: <cover.1639591464.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1639591464.git.jan.kiszka@siemens.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Really sad to see it go but my career hasn't allowed for me to continue sup=
port and I'm also now doing all arm and x86 like everyone else. Hopefully i=
 can contribute in these areas someday.

Steven
________________________________
From: Jan Kiszka <jan.kiszka@siemens.com>
Sent: Wednesday, December 15, 2021 1:04:21 PM
To: xenomai@xenomai.org <xenomai@xenomai.org>
Cc: steven.seeger flightsystems.net <steven.seeger@flightsystems.net>
Subject: [PATCH 0/4] Drop PowerPC architecture

Citing patch 1:

While this architecture served well in many use cases over a long time,
it's time is over, new chip chips are no longer being released.

As Xenomai is moving its core completely over Dovetail, there is no
support in Dovetail for PowerPC and that is not going to change, it's
time to drop this arch from the core in order to move forward.

Jan


CC: Steven Seeger <steven.seeger@flightsystems.net>

Jan Kiszka (4):
  Drop PowerPC architecture support
  drivers/net: Drop PowerPC-related drivers
  drivers/can: Drop MSCAN driver
  drivers/can/rtcan_flexcan: Drop PowerPC bits

 .gitlab-ci.yml                                |   27 +-
 configure.ac                                  |    9 -
 debian/control                                |    6 +-
 doc/asciidoc/README.INSTALL.adoc              |   50 +-
 doc/asciidoc/man1/xeno-config.adoc            |    2 +-
 kernel/cobalt/arch/powerpc/Kconfig            |    8 -
 .../powerpc/include/asm/xenomai/uapi/arith.h  |   34 -
 .../include/asm/xenomai/uapi/features.h       |   40 -
 .../powerpc/include/asm/xenomai/uapi/fptest.h |  127 -
 .../include/asm/xenomai/uapi/syscall.h        |   23 -
 kernel/cobalt/arch/powerpc/ipipe/Makefile     |    8 -
 kernel/cobalt/arch/powerpc/ipipe/README       |    3 -
 kernel/cobalt/arch/powerpc/ipipe/fpu.S        |   87 -
 .../ipipe/include/asm/xenomai/calibration.h   |  106 -
 .../ipipe/include/asm/xenomai/features.h      |   27 -
 .../ipipe/include/asm/xenomai/fptest.h        |   58 -
 .../ipipe/include/asm/xenomai/machine.h       |   39 -
 .../ipipe/include/asm/xenomai/syscall.h       |   83 -
 .../ipipe/include/asm/xenomai/syscall32.h     |   24 -
 .../ipipe/include/asm/xenomai/thread.h        |   92 -
 .../ipipe/include/asm/xenomai/wrappers.h      |   24 -
 kernel/cobalt/arch/powerpc/ipipe/machine.c    |   67 -
 kernel/cobalt/arch/powerpc/ipipe/thread.c     |  174 --
 kernel/drivers/can/Kconfig                    |    1 -
 kernel/drivers/can/Makefile                   |    2 +-
 kernel/drivers/can/mscan/Kconfig              |    8 -
 kernel/drivers/can/mscan/Makefile             |    6 -
 kernel/drivers/can/mscan/rtcan_mscan.c        |  798 ------
 kernel/drivers/can/mscan/rtcan_mscan.h        |   38 -
 .../drivers/can/mscan/rtcan_mscan_mpc5xxx.c   |  392 ---
 kernel/drivers/can/mscan/rtcan_mscan_proc.c   |  151 --
 kernel/drivers/can/mscan/rtcan_mscan_regs.h   |  226 --
 kernel/drivers/can/rtcan_flexcan.c            |  189 +-
 kernel/drivers/net/drivers/Kconfig            |   27 -
 kernel/drivers/net/drivers/Makefile           |   14 -
 .../drivers/net/drivers/mpc52xx_fec/Makefile  |    5 -
 kernel/drivers/net/drivers/mpc52xx_fec/README |   67 -
 .../mpc52xx_fec/linuxppc_2_4_devel-fec.patch  |   61 -
 .../net/drivers/mpc52xx_fec/mpc52xx_fec.c     | 1985 --------------
 .../net/drivers/mpc52xx_fec/rt_mpc52xx_fec.h  |  428 ---
 kernel/drivers/net/drivers/mpc8260_fcc_enet.c | 2235 ----------------
 kernel/drivers/net/drivers/mpc8xx_enet.c      | 1073 --------
 kernel/drivers/net/drivers/mpc8xx_fec.c       | 2341 -----------------
 lib/cobalt/arch/Makefile.am                   |    2 +-
 lib/cobalt/arch/powerpc/Makefile.am           |   13 -
 lib/cobalt/arch/powerpc/features.c            |   24 -
 lib/cobalt/arch/powerpc/include/Makefile.am   |    2 -
 .../arch/powerpc/include/asm/Makefile.am      |    2 -
 .../powerpc/include/asm/xenomai/Makefile.am   |    5 -
 .../powerpc/include/asm/xenomai/features.h    |   30 -
 .../powerpc/include/asm/xenomai/syscall.h     |   82 -
 .../arch/powerpc/include/asm/xenomai/time.h   |   16 -
 .../arch/powerpc/include/asm/xenomai/tsc.h    |   38 -
 scripts/prepare-kernel.sh                     |    3 -
 54 files changed, 100 insertions(+), 11282 deletions(-)
 delete mode 100644 kernel/cobalt/arch/powerpc/Kconfig
 delete mode 100644 kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/ari=
th.h
 delete mode 100644 kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/fea=
tures.h
 delete mode 100644 kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/fpt=
est.h
 delete mode 100644 kernel/cobalt/arch/powerpc/include/asm/xenomai/uapi/sys=
call.h
 delete mode 100644 kernel/cobalt/arch/powerpc/ipipe/Makefile
 delete mode 100644 kernel/cobalt/arch/powerpc/ipipe/README
 delete mode 100644 kernel/cobalt/arch/powerpc/ipipe/fpu.S
 delete mode 100644 kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/ca=
libration.h
 delete mode 100644 kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/fe=
atures.h
 delete mode 100644 kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/fp=
test.h
 delete mode 100644 kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/ma=
chine.h
 delete mode 100644 kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/sy=
scall.h
 delete mode 100644 kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/sy=
scall32.h
 delete mode 100644 kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/th=
read.h
 delete mode 100644 kernel/cobalt/arch/powerpc/ipipe/include/asm/xenomai/wr=
appers.h
 delete mode 100644 kernel/cobalt/arch/powerpc/ipipe/machine.c
 delete mode 100644 kernel/cobalt/arch/powerpc/ipipe/thread.c
 delete mode 100644 kernel/drivers/can/mscan/Kconfig
 delete mode 100644 kernel/drivers/can/mscan/Makefile
 delete mode 100644 kernel/drivers/can/mscan/rtcan_mscan.c
 delete mode 100644 kernel/drivers/can/mscan/rtcan_mscan.h
 delete mode 100644 kernel/drivers/can/mscan/rtcan_mscan_mpc5xxx.c
 delete mode 100644 kernel/drivers/can/mscan/rtcan_mscan_proc.c
 delete mode 100644 kernel/drivers/can/mscan/rtcan_mscan_regs.h
 delete mode 100644 kernel/drivers/net/drivers/mpc52xx_fec/Makefile
 delete mode 100644 kernel/drivers/net/drivers/mpc52xx_fec/README
 delete mode 100644 kernel/drivers/net/drivers/mpc52xx_fec/linuxppc_2_4_dev=
el-fec.patch
 delete mode 100644 kernel/drivers/net/drivers/mpc52xx_fec/mpc52xx_fec.c
 delete mode 100644 kernel/drivers/net/drivers/mpc52xx_fec/rt_mpc52xx_fec.h
 delete mode 100644 kernel/drivers/net/drivers/mpc8260_fcc_enet.c
 delete mode 100644 kernel/drivers/net/drivers/mpc8xx_enet.c
 delete mode 100644 kernel/drivers/net/drivers/mpc8xx_fec.c
 delete mode 100644 lib/cobalt/arch/powerpc/Makefile.am
 delete mode 100644 lib/cobalt/arch/powerpc/features.c
 delete mode 100644 lib/cobalt/arch/powerpc/include/Makefile.am
 delete mode 100644 lib/cobalt/arch/powerpc/include/asm/Makefile.am
 delete mode 100644 lib/cobalt/arch/powerpc/include/asm/xenomai/Makefile.am
 delete mode 100644 lib/cobalt/arch/powerpc/include/asm/xenomai/features.h
 delete mode 100644 lib/cobalt/arch/powerpc/include/asm/xenomai/syscall.h
 delete mode 100644 lib/cobalt/arch/powerpc/include/asm/xenomai/time.h
 delete mode 100644 lib/cobalt/arch/powerpc/include/asm/xenomai/tsc.h

--
2.31.1

