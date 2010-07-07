Date: Thu, 8 Jul 2010 01:13:29 +0200
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20100707231329.GA30477@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai-core] [PULL REQUEST] analogy bug fixes
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

The following changes since commit 653a38669af4427471ed8cdd129eb0bbb33ba178:

  nucleus: finalize heap mapping sanitization (2010-07-04 18:57:54 +0200)

are available in the git repository at:
  git://git.xenomai.org/xenomai-abe.git analogy ..BRANCH.NOT.VERIFIED..

Alexis Berlemont (48):
      analogy: change the context's role (broken)
      analogy: the buffer structure is now the central field of a4l_context (broken)
      analogy: the subdevice structure got a new status field (broken)
      analogy: the transfer structure is left with a minimal role (broken)
      analogy: first draft of buffer initialization functions (broken)
      analogy: adapt open, r/w, select and ioctl functions (broken)
      analogy: adapt a4l_set_dev() after a4l_context's overhaul (broken)
      analogy: update a4l_set_dev() declaration (broken)
      analogy: update comments on a4l_context (broken)
      analogy: changes related with subdevice's status field (broken)
      analogy: replace transfer setup functions with buffer setup ones (broken)
      analogy: update cancel functions (broken)
      analogy: rewrite the cancel ioctl handler (broken)
      analogy: fix bulk flag declaration in buffer.h (broken)
      analogy: update a4l_read and a4l_write (broken)
      analogy: update all a4l_buf_* functions (broken)
      analogy: last updates in the buffer part (broken)
      analogy: cosmetic changes (broken)
      analogy: declare the reserve / release functions at the subd level (broken)
      analogy: update a4l_get_minor function (broken)
      analogy: update a4l_set_dev and remove useless info traces (broken)
      analogy: use rtdm_context_to_private (broken)
      analogy: minor fix in the subdevice structure declaration
      analogy: add some helper macros to test the subdevice's characteristics
      analogy: remove useless functions in the subdevice part
      analogy: fix the buffer syscalls (ioctl + r/w) after buffer review (broken)
      analogy: fix the declaration of the structure a4l_context (broken)
      analogy: fix compilation issues and review the mmap ioctl handler (broken)
      analogy: cosmetic change (broken)
      analogy: fix buffer's compilation issues (broken)
      analogy: prettify some subdevice tests (broken)
      analogy: [pcimio] fix a huge hack in the mite initialization (broken)
      analogy: fix the last compilation problems
      analogy: fix a missing setting of the buf field in subdevice (broken)
      analogy: fix the subdevice status management
      analogy: fix buffer initialization/cleanup calls at open/close times
      analogy: [loop] add a debug trace when trigger is called
      analogy: fix test of subdevice status in a4l_write
      analogy: [fake - loop] remove volatile keywords
      analogy: add a detail in a4l_close doxygen doc
      analogy: add an arbitrary sleep in cmd_write before closing the device
      analogy: [ni_pcimio] really minor changes
      analogy: [ni_pcimio] add the missing allocation of the digital ring
      analogy: [ni_pcimio] fix timeout value in digital trigger
      analogy: remove a4l_subd_is_busy calls in analogy core
      analogy: remove calls of a4l_release/reserve_subd in the core
      analogy: remove some tests which become with the buffer overhaul
      analogy: fix a bug in a4l_fill_desc() when called on an idle device

 include/analogy/buffer.h                           |   72 ++-
 include/analogy/context.h                          |   37 +-
 include/analogy/device.h                           |    7 +-
 include/analogy/subdevice.h                        |   47 ++-
 include/analogy/transfer.h                         |   17 +-
 ksrc/drivers/analogy/buffer.c                      |  629 +++++++++++---------
 ksrc/drivers/analogy/command.c                     |   55 +-
 ksrc/drivers/analogy/device.c                      |   51 +--
 ksrc/drivers/analogy/driver_facilities.c           |    4 +-
 ksrc/drivers/analogy/instruction.c                 |   11 +-
 .../analogy/national_instruments/mio_common.c      |   39 +-
 ksrc/drivers/analogy/national_instruments/mite.c   |   10 +-
 ksrc/drivers/analogy/national_instruments/mite.h   |    2 +-
 ksrc/drivers/analogy/national_instruments/pcimio.c |    2 +
 ksrc/drivers/analogy/rtdm_interface.c              |  137 +++---
 ksrc/drivers/analogy/subdevice.c                   |   12 +-
 ksrc/drivers/analogy/testing/fake.c                |   12 +-
 ksrc/drivers/analogy/testing/loop.c                |   22 +-
 ksrc/drivers/analogy/transfer.c                    |  274 +--------
 src/drvlib/analogy/descriptor.c                    |   14 +
 src/utils/analogy/cmd_write.c                      |    3 +
 21 files changed, 655 insertions(+), 802 deletions(-)

-- 
Alexis.

