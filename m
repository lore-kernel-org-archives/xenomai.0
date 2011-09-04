MIME-Version: 1.0
Date: Sun, 4 Sep 2011 23:43:59 +0200
Message-ID: <CAMesUR6RGrw21=qDen2NXVDZTpBPfccDRH13YGzyZ8KdUjsvbg@domain.hid>
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-core] PULL REQUEST: analogy
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

The following changes since commit fa167ed2f2d9ce569968d801796f7e760772e97b:

  doc: regenerate (2011-09-04 21:48:41 +0200)

are available in the git repository at:
  ssh+git://git.xenomai.org/xenomai-abe.git analogy

Alexis Berlemont (28):
      analogy: add first version of waveform generation
      analogy: rename waveform files
      analogy: minor changes
      analogy: add wf_generate tool
      analogy: add verbose output in wf_generate tool
      analogy: add a 1st version of wf_cmd_write
      analogy: 1st rework of fake driver
      analogy: [fake] minor fix in attach parameters handling
      analogy: [fake] validate the looping feature
      analogy: minor fix in wf_generate
      analogy: [fake] add instruction callbacks for the loop subdevices
      analogy: [loop] remove the driver
      analogy: [fake] correctly manage EOA events for loop subdevices
      analogy: minor change in cmd_read.c
      analogy: various basic bug fixes in wf_cmd_write
      analogy: minor cosmetic changes in wf_facilities.c
      analogy: [fake] fix synchronization bugs at cancel time
      analogy: minor change in the test program wf_cmd_write
      analogy: add signal injection in the cmd_write tool
      analogy: implement the configuration of a wake-up threshold
      analogy: update cmd_read and cmd_write with a wake-count option
      analogy: [ni_660x] replace spin_lock_* calls by al4_lock_* calls
      analogy: [pcimio] minor cosmetic change
      analogy: [ni_660x] review indentation
      analogy: [ni_660x] review coding style and traces
      analogy: [ni_670x] review coding style
      analogy: [ni_660x] remove useless headers
      analogy: [ni_670x] replace printk calls by a4l_[err,info] calls

Anders Blomdell (2):
      analogy: fix duplicate symbols
      analogy: [pcimio] fix wrong IRQ setup after reboot

Julien Delange (1):
      analogy: integrate the drivers ni_660x and ni_670x.

 include/analogy/analogy.h                          |   80 +-
 include/analogy/buffer.h                           |   23 +
 include/analogy/channel_range.h                    |   16 +-
 include/analogy/ioctl.h                            |    7 +-
 ksrc/drivers/analogy/buffer.c                      |   86 +-
 ksrc/drivers/analogy/driver_facilities.c           |   12 +-
 ksrc/drivers/analogy/intel/8255.c                  |   10 +-
 ksrc/drivers/analogy/intel/8255.h                  |    8 +-
 ksrc/drivers/analogy/national_instruments/Kconfig  |   18 +
 ksrc/drivers/analogy/national_instruments/Makefile |    6 +
 .../analogy/national_instruments/mio_common.c      |  152 +-
 ksrc/drivers/analogy/national_instruments/mite.c   |  164 ++-
 ksrc/drivers/analogy/national_instruments/mite.h   |   51 +-
 .../drivers/analogy/national_instruments/ni_660x.c | 1485 ++++++++++++++++++++
 .../drivers/analogy/national_instruments/ni_670x.c |  446 ++++++
 ksrc/drivers/analogy/national_instruments/ni_mio.h |   18 +-
 ksrc/drivers/analogy/national_instruments/ni_tio.h |   28 +-
 ksrc/drivers/analogy/national_instruments/pcimio.c |   70 +-
 .../analogy/national_instruments/tio_common.c      |   82 +-
 ksrc/drivers/analogy/rtdm_interface.c              |    8 +-
 ksrc/drivers/analogy/sensoray/s526.c               |    4 +-
 ksrc/drivers/analogy/subdevice.c                   |   14 +-
 ksrc/drivers/analogy/testing/Config.in             |    1 -
 ksrc/drivers/analogy/testing/Kconfig               |   11 +-
 ksrc/drivers/analogy/testing/Makefile              |   11 +-
 ksrc/drivers/analogy/testing/fake.c                |  427 +++++-
 ksrc/drivers/analogy/testing/loop.c                |  287 ----
 src/drvlib/analogy/async.c                         |   31 +
 src/utils/analogy/Makefile.am                      |   18 +-
 src/utils/analogy/cmd_read.c                       |   24 +-
 src/utils/analogy/cmd_write.c                      |  721 ++++++----
 src/utils/analogy/wf_facilities.c                  |  158 +++
 src/utils/analogy/wf_facilities.h                  |   36 +
 src/utils/analogy/wf_generate.c                    |  252 ++++
 34 files changed, 3719 insertions(+), 1046 deletions(-)
 create mode 100644 ksrc/drivers/analogy/national_instruments/ni_660x.c
 create mode 100644 ksrc/drivers/analogy/national_instruments/ni_670x.c
 delete mode 100644 ksrc/drivers/analogy/testing/loop.c
 create mode 100644 src/utils/analogy/wf_facilities.c
 create mode 100644 src/utils/analogy/wf_facilities.h

Alexis.

