Message-ID: <4B38C28D.5010205@domain.hid>
Date: Mon, 28 Dec 2009 15:37:01 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] pull request
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

The following changes since commit e1db93a63545cb99b8f615b69aff22920fa0ee39:
  Philippe Gerum (1):
        blackfin: export atomic set/clear mask fns

are available in the git repository at:

  git://git.xenomai.org/xenomai-gch.git for-head

Gilles Chanteperdrix (3):
      analogy: comment out the definition of range_ni_M_628x_ao, which was not used
      blackfin: avoid redefinition of CAN_ERR_MASK with Linux 2.6.30
      nucleus: rename vdso symbols

Wolfgang Mauerer (2):
      nucleus: Add support for sharing data between Xenomai kernel and userland
      nucleus: Testcase for the xnvdso mechanism

 include/asm-blackfin/wrappers.h                    |    4 +
 include/asm-generic/syscall.h                      |    1 +
 include/nucleus/Makefile.am                        |    3 +-
 include/nucleus/xnvdso.h                           |   61 ++++++++++++++++++++
 ksrc/drivers/analogy/national_instruments/pcimio.c |    2 +
 ksrc/nucleus/module.c                              |    7 ++
 ksrc/nucleus/shadow.c                              |   22 +++++++
 src/testsuite/unit/Makefile.am                     |   15 +++++-
 src/testsuite/unit/check-vdso.c                    |   52 +++++++++++++++++
 src/testsuite/unit/runinfo.in                      |    1 +
 10 files changed, 166 insertions(+), 2 deletions(-)
 create mode 100644 include/nucleus/xnvdso.h
 create mode 100644 src/testsuite/unit/check-vdso.c

-- 
					    Gilles.

