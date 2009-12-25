Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <4B354A20.90806@domain.hid>
Date: Sat, 26 Dec 2009 00:26:24 +0100
From: Alexis Berlemont <berlemont.hauw@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PULL REQUEST] analogy: build fixes and many bug
	fixes.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

The following changes since commit e305035eb6adc4220fe179477f3e300ad944f85c:
   Alexis Berlemont (1):
         analogy: fix bad error handling path in test programs

are available in the git repository at:

   ssh+git://git.xenomai.org/xenomai-abe.git analogy

Alexis Berlemont (22):
       analogy: fix potentiel NULL instructions handlers executions
       analogy: fix the default writing subdevice.
       analogy: properly manage cancel operations on synchronous subdevices
       analogy: add a kernel error message when a driver rejects a command
       analogy: add missing channel and range descriptors in the loop driver
       analogy: in cmd_read, set a higher scan interval
       analogy: fix wrong names of conversion functions
       analogy: improve the test program insn_write
       analogy: fix a bug in the conversion routines
       analogy: minor change in the driver description
       analogy: add a simple helper function
       analogy: slight change in a kernel error message
       analogy: fix Doxygen documentation (a4l_sync_read, a4l_sync_write)
       analogy: fix a bug in the execution of a list of instructions
       analogy: review the conversion routines in the user library
       analogy: improve the test program cmd_read
       analogy: minor Doxygen change
       analogy: fix wrong use of the type unsigned long long in time 
retrieval
       analogy: fix a bug in the user/kernel copy of the instruction's data
       analogy: fix a first part of the compilation issues when mite is 
disabled
       analogy: fix the compilation issues when mite is disabled
       analogy: replace EXPORT_SYMBOL() by EXPORT_SYMBOL_GPL()

  include/analogy/analogy.h                          |   48 +-
  include/analogy/instruction.h                      |    8 +-
  include/analogy/os_facilities.h                    |    4 +-
  ksrc/drivers/analogy/command.c                     |    8 +-
  ksrc/drivers/analogy/driver_facilities.c           |   58 +-
  ksrc/drivers/analogy/instruction.c                 |   67 ++-
  ksrc/drivers/analogy/intel/8255.c                  |   28 +-
  ksrc/drivers/analogy/intel/parport.c               |   38 +-
  .../analogy/national_instruments/mio_common.c      |  579 
++++++++++++--------
  ksrc/drivers/analogy/national_instruments/mite.c   |   42 +-
  ksrc/drivers/analogy/national_instruments/ni_tio.h |   20 +-
  ksrc/drivers/analogy/national_instruments/pcimio.c |    2 +
  .../analogy/national_instruments/tio_common.c      |   92 ++--
  ksrc/drivers/analogy/os_facilities.c               |   10 +-
  ksrc/drivers/analogy/testing/fake.c                |   19 +-
  ksrc/drivers/analogy/testing/loop.c                |   20 +-
  ksrc/drivers/analogy/transfer.c                    |    3 +-
  src/drvlib/analogy/range.c                         |  369 ++++++++++++--
  src/drvlib/analogy/sync.c                          |    4 +-
  src/utils/analogy/cmd_read.c                       |  138 ++++-
  src/utils/analogy/cmd_write.c                      |    4 +-
  src/utils/analogy/insn_read.c                      |  180 +++++--
  src/utils/analogy/insn_write.c                     |   84 ++-
  23 files changed, 1272 insertions(+), 553 deletions(-)

