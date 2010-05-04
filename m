Date: Tue, 4 May 2010 23:51:06 +0200
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20100504215106.GA9298@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai-core] [PULL REQUEST] analogy bug fixes + rtdm_rt_capable
	related changes
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

The following changes since commit
e9b509c9021e0134117d0fe75d11e495f0e954b7:

  arm: add missing #include (2010-05-04 03:44:01 +0200)

are available in the git repository at:
  git://git.xenomai.org/xenomai-abe.git analogy

Alexis Berlemont (17):
      analogy: fix ring-buffer issues
      analogy: cosmetic fix
      analogy: fix buffer checkings so as to allow infinite acquisitions
      analogy: make cmd_read work with infinite acquisitions (-S 0)
      analogy: fix a misuse of channel descriptors in a4l_get_chan
      analogy: [pcimio] register the digital trigger routine
      analogy: minor change in the header command.h
      analogy: minor cosmetic fix
      analogy: add the test program cmd_bits (beta version)
      analogy: minor fix in insn_bits
      analogy: add triggering in cmd_bits
      analogy: in the core, call rtdm_in_rt_context() instead of a4l_test_rt()
      analogy: add calls to rtdm_rt_capable() in ioctl handlers
      analogy: remove useless device declarations in read / write syscalls handlers
      analogy: add rtdm_rt_capable() calls in read / write syscall handlers
      analogy: fix a stupid bug in the use of rtdm_rt_capable()
      analogy: make the command registering perform in NRT context

Daniele Nicolodi (2):
      analogy: make a4l_find_range return the index of the selected range
      analogy: minor change (white spaces removals)

 include/analogy/buffer.h                           |   37 ++--
 include/analogy/command.h                          |   15 +-
 ksrc/drivers/analogy/buffer.c                      |   57 +++--
 ksrc/drivers/analogy/command.c                     |    6 +
 ksrc/drivers/analogy/device.c                      |    2 +-
 ksrc/drivers/analogy/instruction.c                 |    6 +
 .../analogy/national_instruments/mio_common.c      |   18 +-
 ksrc/drivers/analogy/rtdm_interface.c              |   10 +-
 ksrc/drivers/analogy/subdevice.c                   |    6 +-
 ksrc/drivers/analogy/transfer.c                    |   10 +-
 src/drvlib/analogy/range.c                         |   64 +++--
 src/utils/analogy/Makefile.am                      |   10 +-
 src/utils/analogy/cmd_bits.c                       |  277 ++++++++++++++++++++
 src/utils/analogy/cmd_read.c                       |    6 +-
 src/utils/analogy/insn_bits.c                      |    2 +-
 15 files changed, 425 insertions(+), 101 deletions(-)
 create mode 100644 src/utils/analogy/cmd_bits.c

-- 
Alexis.

